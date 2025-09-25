Return-Path: <linux-kernel+bounces-831903-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 623DEB9DD88
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 09:25:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8CFB07AA785
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 07:24:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECE592E7194;
	Thu, 25 Sep 2025 07:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=monstr-eu.20230601.gappssmtp.com header.i=@monstr-eu.20230601.gappssmtp.com header.b="NOEABq5K"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29B502E7637
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 07:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758785150; cv=none; b=i+BcgVz2+SeW4dtLH/bx2MKgjQMhXZbTaMVFn/wrdhidMY0fbGGFXqSwuSae2MAtUxT2LdT37PhL5PIoCAJcgAOJnNm1oqARIf/YsWZaM0j6bFHD4ztdG1KLHOAaUH366YdKclyLEsGtzvrWkfJqaOXqV48ni89dftwIO4YhzVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758785150; c=relaxed/simple;
	bh=07WGMp2mmMJK/+BTDq5FW1e1LtZ0Q0TILWryupbf3vI=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=lNPBMxSAtpkqwH5ZHchj1UeKfKau1MErjRPtQPhUPO7/WkdWHDGpWzVowAvV/3MfYi+KGkv433WivnQHmYtYtuGOajIsnrViMFqCn89aKCBlrEO79rqWnWWU5CunC9XA7FQGMnQHmHiVx81r7ot+SsqaSThVWjmmypozFuJnyLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=monstr.eu; spf=none smtp.mailfrom=monstr.eu; dkim=pass (2048-bit key) header.d=monstr-eu.20230601.gappssmtp.com header.i=@monstr-eu.20230601.gappssmtp.com header.b=NOEABq5K; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=monstr.eu
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=monstr.eu
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b07883a5feeso140352366b.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 00:25:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20230601.gappssmtp.com; s=20230601; t=1758785144; x=1759389944; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YI0BCX0C0rZPNyomOSPrlAb0GCcS3xWD5wv1elxG+L4=;
        b=NOEABq5Kgq8zFaT2F/Ks3dk0xlNJQdOqkPewNxPL7lgFDSI6M+ebdLPxr5T37Wr1fE
         z/YGAKwNKXeInXVhwyVnLr+jB1mI0BM5lz0T1DA7TRgp1psG+8CaERzJ+8DFpOQTDjQx
         rvM8WTQydNouNjR0+Go5yZXA24rUmlE9SlyBQN1+FWzAkV6dSLlMpMn9cupx62H9a+EJ
         CDLA/ztZKD9ObxtW6c15JiaYb6iQgNFJWlnSlSz/zMgR3g7IlL3CK+/p++5vJumlje92
         RgtdLr/sRZTCP7cIOBU39X/jE1XsTz+Du+ZECl6jNuN4TSawj0jDa/dO5hG5m/hk1Suo
         8qHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758785144; x=1759389944;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=YI0BCX0C0rZPNyomOSPrlAb0GCcS3xWD5wv1elxG+L4=;
        b=CspI47XK46AdHnclZT6ypdt3V8i7J/e7vxvG2RC1mj7HZWzWTakVXDv3hiD/1Nogb1
         lHF/63RnQxILaYdvCLUI2GiVX0ORrf1fJEIBIomrreS5xM43MliT5AvOsqLNKMzFu6XY
         N21Jft+m+ITj9X2sOL6JfEElVFuW/sjJONd33VfPXHv5pjgsJDUsoQE6CXM0dm2XA8Xw
         U4pfk5b6RHG1NlreyQm/1k6HRzFDeYMxKDH5ff2vT4BtXNhXqN+Lg0od1yvQUVvEqB6m
         BBWmNgkPgzq6PXhosoRBYu61v1h70NIUC8pRX1ukulLodAP7ZfN5hXuRe4cXFOc3o+67
         T1sw==
X-Gm-Message-State: AOJu0YxPvDujUmpvthdolOuvgVpJons60/uZ2I8Xo36MEaLV7JCK5qGe
	bFPMNkcqDjsAIH2WoEBZWDFcG/5On5HsSO7gwM0VJIpdLUACK2tQnhJ+7gUrXAfn130/6RhKl3Y
	qB/vg3Vo9
X-Gm-Gg: ASbGncvaysi64x0WrKzvxa5GUTMdTUc/xDbRRGZR4VjgeTXtzObV0n6rDHutpfT9HLp
	HIDT4IVSSIQbLkdf17jM0vuIMY5zwjVpjW+4CAVvfjwhDq07/LHMsSsZFvdmLBa/6ftIJrcmbOF
	pJq0pErk85y5a6IczbNnvqE3eBbthQupGeNwoZPSpeOZ6qiJQkps7Vk/m0HmPqGc9EEN1w3yeFE
	NzUScO2s9CylP0VJLO/o4mGk+kZK3J9XcnanFQxGRk979FJ8PCa7zgIrhS3LWsJn2qxf23nB0VQ
	2likdEUOCZhC5We9xl/3F0BE5ZwUIimv8UHR8owi6e1mRObUtdWdJxj+r8xqmzl6LtMGeax0b50
	TtGrEJLP0t1y5qMEkVsUcRYjNSXDyPAHWuuHC8iOm
X-Google-Smtp-Source: AGHT+IFFt/xljWDkVOP+9K0VaRh6potm13QS0ERaASG/Cra7EUf5bE1boPlNkfZt+pVdYTchJxu2kg==
X-Received: by 2002:a17:907:94c7:b0:b2d:804c:f5c with SMTP id a640c23a62f3a-b34b684a76bmr306211066b.4.1758785144022;
        Thu, 25 Sep 2025 00:25:44 -0700 (PDT)
Received: from [192.168.0.105] (nat-108f.starnet.cz. [109.164.53.108])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b353efa4685sm107232466b.28.2025.09.25.00.25.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Sep 2025 00:25:43 -0700 (PDT)
Message-ID: <ef737658-d423-4fb0-9564-484907972e41@monstr.eu>
Date: Thu, 25 Sep 2025 09:25:42 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
From: Michal Simek <monstr@monstr.eu>
Subject: [GIT PULL] arch/microblaze patches for 6.18-rc1
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Linus,

please pull these three simple patches to your tree.

Thanks,
Michal

The following changes since commit 8f5ae30d69d7543eee0d70083daf4de8fe15d585:

   Linux 6.17-rc1 (2025-08-10 19:41:16 +0300)

are available in the Git repository at:

   git://git.monstr.eu/linux-2.6-microblaze.git tags/microblaze-v6.18

for you to fetch changes up to 438f7cd41765dbe8830009a37f90145b7f05ed39:

   microblaze: Replace __ASSEMBLY__ with __ASSEMBLER__ in non-uapi headers 
(2025-09-12 13:12:42 +0200)

----------------------------------------------------------------
Microblaze patches for 6.18-rc1

- Fix typos in Kconfig
- s/__ASSEMBLY__/__ASSEMBLER__/g

----------------------------------------------------------------
Ahelenia Ziemiańska (1):
       microblaze: fix typos in Kconfig

Thomas Huth (2):
       microblaze: Replace __ASSEMBLY__ with __ASSEMBLER__ in uapi headers
       microblaze: Replace __ASSEMBLY__ with __ASSEMBLER__ in non-uapi headers

  arch/microblaze/Kconfig.platform                | 10 +++++-----
  arch/microblaze/include/asm/asm-compat.h        |  2 +-
  arch/microblaze/include/asm/current.h           |  4 ++--
  arch/microblaze/include/asm/entry.h             |  4 ++--
  arch/microblaze/include/asm/exceptions.h        |  4 ++--
  arch/microblaze/include/asm/fixmap.h            |  4 ++--
  arch/microblaze/include/asm/ftrace.h            |  2 +-
  arch/microblaze/include/asm/kgdb.h              |  4 ++--
  arch/microblaze/include/asm/mmu.h               |  4 ++--
  arch/microblaze/include/asm/page.h              |  8 ++++----
  arch/microblaze/include/asm/pgtable.h           | 18 +++++++++---------
  arch/microblaze/include/asm/processor.h         |  8 ++++----
  arch/microblaze/include/asm/ptrace.h            |  4 ++--
  arch/microblaze/include/asm/sections.h          |  4 ++--
  arch/microblaze/include/asm/setup.h             |  4 ++--
  arch/microblaze/include/asm/thread_info.h       |  4 ++--
  arch/microblaze/include/asm/unistd.h            |  4 ++--
  arch/microblaze/include/asm/xilinx_mb_manager.h |  4 ++--
  arch/microblaze/include/uapi/asm/ptrace.h       |  4 ++--
  19 files changed, 50 insertions(+), 50 deletions(-)

-- 
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP/Versal ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP/Versal/Versal NET SoCs
TF-A maintainer - Xilinx ZynqMP/Versal/Versal NET SoCs


