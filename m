Return-Path: <linux-kernel+bounces-815153-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8D20B56056
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 12:53:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 707447B79FD
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 10:51:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 059002EC0B5;
	Sat, 13 Sep 2025 10:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=heyquark.com header.i=@heyquark.com header.b="ZPwflY85"
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87DD12EC0AC
	for <linux-kernel@vger.kernel.org>; Sat, 13 Sep 2025 10:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757760803; cv=none; b=CWQDUl6er4L9I6CF1Rrk4ffvFKrDXwZWRCa37hLmV8nitR2Z5IF8ycVdhLZhlZYJSBW9nH4TmiXIcjRm4+FMJfzvASDx4zDlmHfoGnA2K+yX459Kj+fUK0TCxcoWhDn9Yk3QQ9qLNHhcaq7ZgtZ8Psw1N6ktHFLmz9vH8mf8c9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757760803; c=relaxed/simple;
	bh=qXx1wONTbcgawN/zX0ziVSkmOFKWffOPfCIo4Thq7VI=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=Lr6ls5qxZTJKnGMY3iV6hv9tQXApIUMZYtspC4pFBR9gUDale9UprZn8fC2dL9FSIxrYWWbj+sIuG7F2VZBKXWxF4Gw/lSjMHA2abbygqwR0P4cszvgD/Mt7Fpol6r14PU1XrzsnRlyecBoHaY0KNrZQr99w0Wxs/SSwGQJ5NHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=heyquark.com; spf=pass smtp.mailfrom=heyquark.com; dkim=pass (2048-bit key) header.d=heyquark.com header.i=@heyquark.com header.b=ZPwflY85; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=heyquark.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=heyquark.com
Message-ID: <3e8cb683-a084-4847-8f69-e1f4d9125c45@heyquark.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=heyquark.com;
	s=key1; t=1757760798;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=1iZiELOPGgRZDBi2au223SZgjALhV2isPuOLR/SKVds=;
	b=ZPwflY854lfR6+0k+h4yDgxJWLkTlhGcfYHnB/PhTWkU+vIwyWhZXL2UE3uTJ/Xix0zK+U
	66IwEf6xsXakDFWxyhzg5a83nJTtKwd9NJnINz/rCmXaV9Cc68bKyH7w0BLmHPvxDQnBrH
	/+l9KErxJkMkbsE2KDFnkgWqLYMw5nWZqZS9Px0jM1D+spx4jdK6KajIco0RNkdxxcHtaV
	3Eoi6Mp6KFCk2A78L+jA21XKKsmGZPFZGrvggAWwSeXCADlOjNHhaRyrU4FTMwimAHNr1o
	t7axN5rc/TW5uDrrhmLVPsGCp+EF2UhBiCCo9Je2k3qGp0KZ+JF6VdQTsEaskQ==
Date: Sat, 13 Sep 2025 20:53:08 +1000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ash Logan <ash@heyquark.com>
Subject: 32-bit HIGHMEM and game console downstreams
Content-Language: en-US
To: arnd@arndb.de, christophe.leroy@csgroup.eu
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 officialTechflashYT@gmail.com, AWilcox@Wilcox-Tech.com,
 Michael Ellerman <mpe@ellerman.id.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Hello!

LWN recently did a piece on 32-bit support in the kernel, and thought as 
a user of 32-bit I would share my 2c. [1]

I maintain a downstream fork of 6.6 to support the Nintendo Wii U 
hardware [2]. I'm also in regular contact with another doing the same 
for the older Wii [3]. Linux on this era of game consoles is doing 
pretty well :)

The Wii and Wii U are both 32-bit PowerPC machines with holes in their 
memory map, which I think makes them interesting for this discussion. 
Let me summarize the hardware and kernels involved:

Wii (2006)
- 1x PowerPC 750CL "Broadway" @ 729MHz
- 24MB "MEM1" + 64MB "MEM2" (non-contiguous - MEM2 starts 256MiB in)
- Kernel 4.19 (+ CIP patchset), dev has been working on forward-porting 
all the drivers one major version at a time (he's currently up to 5.15 
last I checked) + limited upstream support (hardware bringup, UART, not 
many peripherals)

Wii U (2012)
- 3x PowerPC 750CL "Espresso" @ 1.2GHz
- 32MB "MEM1" + 2GB "MEM2" (also starts 256MiB in) + various small SRAMs
- Kernel 6.6 (+ LTS patchset), I also had a run at upstreaming some of 
it in 2022 [4] and would eventually like to go again

Special mention to the GameCube, basically a slower Wii with only 24MB 
direct RAM and 16MB of non-mapped "ARAM". Wii Linux has experimental 
support for this where they use the ARAM as swap.

All of these are flatmem devices, as that's all the 32-bit PowerPC arch 
supports, with the Wii U additionally enabling highmem for its 2GB of 
RAM. Both devices have a small memory area (MEM1) with the "bulk" of RAM 
starting at 256MiB. The Wii U in particular sounds like a candidate 
system for densemem - I would like to read up more about this if I can, 
I was only able to find seemingly unrelated information about CXL when 
searching online.

There is a somewhat active userbase for both devices. I only have stats 
for the Wii U side, but some rough nginx grepping for the last few days 
- Sep 7th-Sep 12th - shows 39 downloads of distribution tarballs and 
bootloader binaries in that period, not including torrents. In the past 
2 weeks - Aug 29th-Sep 12th - 9 people joined the community Discord, 442 
total. Anecdotally, the Wii Linux userbase appears at least twice as big 
(based on their Discord activity).

Distribution-wise, we're supported by ArchPOWER [5], Adélie Linux [6], 
and other distros. The Wii U's Espresso has CPU errata requiring a 
patched compiler, and both distributions ship separate package repos for 
this CPU. ArchPOWER requested I rebase onto 6.6 so they could have 
firmware compression - previously the Wii U was on 4.19 - so there is 
some demand for newer kernel features as well.

I know I'm talking about hobbyist use - and mostly downstream use at 
that - and I do suspect that in the event of a wider 32-bit deprecation 
we'd be fine on the final LTS, whatever that ends up being. Still, I 
think the Wii and Wii U represent a decent number of 32-bit users, so I 
wanted to add to the conversation here.

Thanks,
Ash

[1] https://lwn.net/Articles/1035727/
[2] https://linux-wiiu.org/
[3] https://wii-linux.org/
[4] https://lore.kernel.org/lkml/20221119113041.284419-1-ash@heyquark.com/
[5] https://archlinuxpower.org/
[6] https://www.adelielinux.org/

