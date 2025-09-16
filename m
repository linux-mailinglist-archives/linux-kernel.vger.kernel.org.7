Return-Path: <linux-kernel+bounces-818243-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57895B58EBC
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 09:01:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F4B317D2CF
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 07:01:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3943E2C029B;
	Tue, 16 Sep 2025 07:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=1wt.eu header.i=@1wt.eu header.b="W9sYFUT2"
Received: from mta1.formilux.org (mta1.formilux.org [51.159.59.229])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADB26278170
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 07:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.159.59.229
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758006067; cv=none; b=EGrdm2q2sCVZU9mySxQN81mNFmk6pnDsy6QzGCDFN/VDhkK+aMBOgiNMZfdq1x6PZ81yggdqGY71nWL8C03ixO8auRoqwX2qgEpJoyi5ez410Bs4XY3LrmK2CTDNUqjA9R6M68SOMdYSBQvvyeqMnMxM6nRJMi2EaGhhoRhNfAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758006067; c=relaxed/simple;
	bh=SjDnvp62/lLxeQ44giml4jaGp8oWeHSnwNPwO+xxCic=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=twedcKTQHO+bebULtJ7J8n2M/bFqTMoe9TAlmg0xZA8iM23m5JFeESVH26VEysABrdgYVk0QHFKvY+TKYDnnIgoH0qx0jkv2KDJUDPzqfN/QJWZP07uHL7sL0dw9FcdY4TvcDmJ8vqXmFPA740h9OqeXR2Y46rG1Oe3HgwtGdYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=1wt.eu; spf=pass smtp.mailfrom=1wt.eu; dkim=pass (1024-bit key) header.d=1wt.eu header.i=@1wt.eu header.b=W9sYFUT2; arc=none smtp.client-ip=51.159.59.229
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=1wt.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1wt.eu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=1wt.eu; s=mail;
	t=1758006053; bh=SjDnvp62/lLxeQ44giml4jaGp8oWeHSnwNPwO+xxCic=;
	h=From:Message-ID:From;
	b=W9sYFUT27nEB79RqrVIoMNZvsyRMQAICF+oC9OxhXwgE50B1CKq12V5vRbXxNYPxK
	 J9qF+8/2k2a4QLupgJNeLJVCmu+MW19hcQIdAodpzu5Xwctfmjwc67/xzV9UK9s5fz
	 MniQertvdcMjkAOJJHd2v6z43FChMz0iJ9JaGfzE=
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
	by mta1.formilux.org (Postfix) with ESMTP id 26141C069F;
	Tue, 16 Sep 2025 09:00:53 +0200 (CEST)
Received: (from willy@localhost)
	by pcw.home.local (8.15.2/8.15.2/Submit) id 58G70qZ2003883;
	Tue, 16 Sep 2025 09:00:52 +0200
Date: Tue, 16 Sep 2025 09:00:52 +0200
From: Willy Tarreau <w@1wt.eu>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Ash Logan <ash@heyquark.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        officialTechflashYT@gmail.com, "A. Wilcox" <AWilcox@wilcox-tech.com>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: 32-bit HIGHMEM and game console downstreams
Message-ID: <20250916070052.GA3616@1wt.eu>
References: <3e8cb683-a084-4847-8f69-e1f4d9125c45@heyquark.com>
 <432e049f-886d-4734-ad59-52569a796046@app.fastmail.com>
 <11e667d6-2210-47f0-a9ec-a134a60e138c@heyquark.com>
 <39164c56-78f8-4bac-acd2-a996149c1c57@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <39164c56-78f8-4bac-acd2-a996149c1c57@app.fastmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Tue, Sep 16, 2025 at 08:20:35AM +0200, Arnd Bergmann wrote:
> > The maintainer of that downstream claims to be able to boot modern 
> > text-mode distros on the GameCube' 24MB, which I find really impressive!
> 
> 24MB is impressive indeed. In my latest tests I did not get below 32MB
> (+swap) on an ARMv7 kernel with Debian Bookworm, and major features
> turned off in both kernel and userland.
> 
> On a simpler musl+busybox userland and even more feature reduced
> kernel (no network, initramfs-only) I could get to ~10MB, but then it
> doesn't really do anything besides showing a shell.

When you build your systems from source and install only the necessary
*files* (not packages) you can get much lower. Here's my reverse-proxy
for example (aarch64):

  $ df /
  Filesystem     1K-blocks  Used Available Use% Mounted on
  /dev/ram0          11520 11520         0 100% /

and my firewall:

  $ df /
  Filesystem     1K-blocks  Used Available Use% Mounted on
  /dev/ram0          16640 16640         0 100% /

these are full-featured images with tcpdump, exim, haproxy, nftables,
pppd, ntpd, wireguard, openvpn, hostapd etc and even glibc. I've been
used to installing them on 25128 SPI NOR flashes (16 MB). But yeah
that requires gcc -Os, getting rid of NLS, deciding on a case by case
basis between shared or static linking, and installing the strict
minimum for each service. I even have an old boot loader recovery
image where kernel+initramfs fit into just 1 MB with a small recovery
shell, mke2fs, dropbear and tftp client (i386).

Cheers,
Willy

