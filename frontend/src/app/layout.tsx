import type { Metadata } from 'next'
import { Providers } from './providers'
import './globals.css'

export const metadata: Metadata = {
  title: 'HiddenStaking - Private Staking',
  description: 'Staking with encrypted amounts',
}

export default function RootLayout({
  children,
}: {
  children: React.ReactNode
}) {
  return (
    <html lang="en">
      <body><Providers>{children}</Providers></body>
    </html>
  )
}

