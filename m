Return-Path: <linux-kernel+bounces-827334-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDAC9B91770
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 15:43:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 738D62A4994
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 13:42:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 156E530E0D9;
	Mon, 22 Sep 2025 13:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LiXpVpDr"
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5744A30E0C6
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 13:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758548490; cv=none; b=cnPJEmO2/lx6BLoqCAjOoxWVz2AnVRPukOWJZBntjbmjv6ENGMLQq7h60vDRHYmSPnPxR6Q1FRCZicthPvZgtj4o9B8Dz4s8gSOt82sUNHDpClGAtuo2hXsUiL8/aVwZODADoCDPLLVROvZ574JSyBl49LkWDmN9mpGcrl12ukY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758548490; c=relaxed/simple;
	bh=jifIjrc0NT+6WHcZ2cgAMdCYJ1mvmCHMgyoOQY2VNiE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=myXBAt1prG6MrCBESywOZ+wSYpGTDPts24ji5he/3tsPl4h/wOaT9bRP/lDQZ0j4ZlyvjQXsGpzVVqyFnNWjStefk9IWWLNnjFPAuGQJEQQoMy8SgX11PA/pXX9aZc1gr623CaCBYrSizr4Vz8NSwX8iWaf+6yg/0cQi6aw6UqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LiXpVpDr; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-33255011eafso1082988a91.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 06:41:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758548484; x=1759153284; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=u2LBCcqhdmtbzIdtk44hj4Q+t8eOJI+/5p77iMvyPwo=;
        b=LiXpVpDrug8qFgK2w1fUDng1KSFTF411jDa7S+EjGzgpRiV8AOw0rTRWNlO6ArOETm
         upV6a+RADi9ivrwFX/L1c6VnbkhpXMNATkWNZaX9YO71ZUszMI6ukK1EOVRGsABMoE7x
         aGwQeYykS6wT3pySjqtncBWg3TTlBVFu1H36u0/LdAVEsk/IEpSj+STdpCXOCVZ6gjE8
         AzX2whW8hzGO1zxs1bbW9BJmO/vfR6dT+UnXggFKqdR3atV9LxieFl1lZr4cJnGmmLM7
         U7Q/sbkEp/YpijuJNgpmPuTII42mkne8QmwGKy0ni/ovQn5sp5uKELr0CJdPt/rseGWd
         bp2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758548484; x=1759153284;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u2LBCcqhdmtbzIdtk44hj4Q+t8eOJI+/5p77iMvyPwo=;
        b=VAHPN2Vpi+RaN0yuhmR44zIJiYun7u1DgXYKiH0ubT9yxTl9KfDGjUl2OgOIyP/9uH
         NgQ2r0Vi51kOhimLZtho+SVeaqAXgNvL3YOTO7daH9kQ2Hzyh6Yh40xbgpZvkDYaOOnm
         MHSTih8fuK0PRGdH24+6XmET1MRC9mOcb9ZcjrC2hThcsTZzWjH3HtSAwALMui1i8ECZ
         USXtLWfi5nBruLd4fPCpShynwlBNsk6ws/VOBz+eoxTNqv2vz3Vau/7/QydM43ehbDwh
         kNL1CN2ymqdXca8H4zCw1g8WCFjWeYqb0cJDeapliN5o5lPmr94yGse4r2TZPYC+0zbu
         X7xA==
X-Gm-Message-State: AOJu0Yzlt//Cp/LWFzyyLejDRv9jTYNZYiOZ1s+5nBWcKDoVXDk1c/aO
	v29X2UYZi63uIm/dZAY3yiG4/7PaQw8YxiDpNNlJTg90oQMDJvtSkqquaXEd1dbymxVJJHO+ceT
	kmlzTzY2AehmBsorbfPWgWtA0N1k17CHNyQ==
X-Gm-Gg: ASbGncsqCS/YdsAuvKpd3NR+sX/IO6VMfEZ+THGSaqncbd6RJtHdokRhnN06OcTkT94
	6nPmllsXGTiVGqx9h+zIKYsWb+qnfko7Ip4OdBUncsysaGaUar7+SzU9wQ+TQMqYCB/f2mFDM/j
	xbOoJ0hcOYbf8KMoZzJYhYuFps2+28tbaXQoFoqiL5kqDce1SKrrRrt7aoBhCKxyt3wk8ovV1IG
	JJK2g==
X-Google-Smtp-Source: AGHT+IH5rDOTzXp5/mgKEqBzPrZKZKEZQvOYrh73IlUEM1ZGJ391X3IuTytA4WIu9lkIMnHUbQ1KGbiRz5b3+5TCxHM=
X-Received: by 2002:a17:90b:3c4b:b0:32e:37af:b012 with SMTP id
 98e67ed59e1d1-33097c26154mr15862252a91.0.1758548482514; Mon, 22 Sep 2025
 06:41:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHaCkmcZm43Di=AUx0_UTUjqNKjhDZsCMehW+HWRuy2wzoHzkg@mail.gmail.com>
In-Reply-To: <CAHaCkmcZm43Di=AUx0_UTUjqNKjhDZsCMehW+HWRuy2wzoHzkg@mail.gmail.com>
From: Jesper Juhl <jesperjuhl76@gmail.com>
Date: Mon, 22 Sep 2025 15:40:46 +0200
X-Gm-Features: AS18NWDPnrf7wUQa6eAZIN5I9WHe2X6PKk9iBRQV2XLLnytN5iqjeFOU9ZyVoe8
Message-ID: <CAHaCkmeEVg8ViXo849g5cP6Z+M+PdE0UPSN9+EPu1RGdJ72RoQ@mail.gmail.com>
Subject: Re: amdgpu ERROR flip_done timed out
To: linux-kernel@vger.kernel.org
Cc: Mario Limonciello <mario.limonciello@amd.com>, Felix Kuehling <Felix.Kuehling@amd.com>, 
	Alex Deucher <alexander.deucher@amd.com>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Antheas Kapenekakis <lkml@antheas.dev>
Content-Type: text/plain; charset="UTF-8"

Hi,

It just happened again. This time with a 6.16.8 kernel.
"uname -a" : " Linux smurf 6.16.8-arch1-1 #1 SMP PREEMPT_DYNAMIC Fri,
19 Sep 2025 15:58:36 +0000 x86_64 GNU/Linux".

"dmesg" output :
"
[    0.000000] Linux version 6.16.8-arch1-1 (linux@archlinux) (gcc
(GCC) 15.2.1 20250813, GNU ld (GNU Binutils) 2.45.0) #1 SMP
PREEMPT_DYNAMIC Fri, 19 Sep 2025 15:58:36 +0000
[    0.000000] Command line: BOOT_IMAGE=/vmlinuz-linux
root=UUID=a1c25360-9835-4c00-a3b9-fd93e2577a57 rw loglevel=3 quiet
[    0.000000] BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009ffff] usable
[    0.000000] BIOS-e820: [mem 0x00000000000a0000-0x00000000000fffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x0000000009afefff] usable
[    0.000000] BIOS-e820: [mem 0x0000000009aff000-0x0000000009ffffff] reserved
[    0.000000] BIOS-e820: [mem 0x000000000a000000-0x000000000a1fffff] usable
[    0.000000] BIOS-e820: [mem 0x000000000a200000-0x000000000a20ffff] ACPI NVS
[    0.000000] BIOS-e820: [mem 0x000000000a210000-0x000000000affffff] usable
[    0.000000] BIOS-e820: [mem 0x000000000b000000-0x000000000b020fff] reserved
[    0.000000] BIOS-e820: [mem 0x000000000b021000-0x000000006ad3cfff] usable
[    0.000000] BIOS-e820: [mem 0x000000006ad3d000-0x000000007157ffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000071580000-0x0000000071797fff] ACPI data
[    0.000000] BIOS-e820: [mem 0x0000000071798000-0x0000000073797fff] ACPI NVS
[    0.000000] BIOS-e820: [mem 0x0000000073798000-0x00000000783fefff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000783ff000-0x0000000079ff8fff] usable
[    0.000000] BIOS-e820: [mem 0x0000000079ff9000-0x0000000079ffbfff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000079ffc000-0x0000000079ffffff] usable
[    0.000000] BIOS-e820: [mem 0x000000007a000000-0x000000007bffffff] reserved
[    0.000000] BIOS-e820: [mem 0x000000007d7f3000-0x000000007fffffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000e0000000-0x00000000efffffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000f7000000-0x00000000ffffffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000100000000-0x000000105de7ffff] usable
[    0.000000] BIOS-e820: [mem 0x000000105eec0000-0x00000010a01fffff] reserved
[    0.000000] BIOS-e820: [mem 0x000000fd00000000-0x000000ffffffffff] reserved
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] APIC: Static calls initialized
[    0.000000] efi: EFI v2.9 by American Megatrends
[    0.000000] efi: ACPI=0x71797000 ACPI 2.0=0x71797014
SMBIOS=0x77887000 SMBIOS 3.0=0x77886000 MEMATTR=0x6561d018
ESRT=0x67998f18 INITRD=0x5aee8e18 RNG=0x7177c018
[    0.000000] random: crng init done
[    0.000000] efi: Remove mem60: MMIO range=[0xe0000000-0xefffffff]
(256MB) from e820 map
[    0.000000] e820: remove [mem 0xe0000000-0xefffffff] reserved
[    0.000000] efi: Remove mem61: MMIO range=[0xf7000000-0xfedfffff]
(126MB) from e820 map
[    0.000000] e820: remove [mem 0xf7000000-0xfedfffff] reserved
[    0.000000] efi: Not removing mem62: MMIO
range=[0xfee00000-0xfee00fff] (4KB) from e820 map
[    0.000000] efi: Remove mem63: MMIO range=[0xfee01000-0xffffffff]
(17MB) from e820 map
[    0.000000] e820: remove [mem 0xfee01000-0xffffffff] reserved
[    0.000000] efi: Remove mem65: MMIO
range=[0x1080000000-0x10a01fffff] (514MB) from e820 map
[    0.000000] e820: remove [mem 0x1080000000-0x10a01fffff] reserved
[    0.000000] SMBIOS 3.6.0 present.
[    0.000000] DMI: ASUS System Product Name/ROG STRIX X670E-E GAMING
WIFI, BIOS 3205 07/15/2025
[    0.000000] DMI: Memory slots populated: 2/4
[    0.000000] tsc: Fast TSC calibration using PIT
[    0.000000] tsc: Detected 4500.140 MHz processor
[    0.000110] e820: update [mem 0x00000000-0x00000fff] usable ==> reserved
[    0.000111] e820: remove [mem 0x000a0000-0x000fffff] usable
[    0.000114] last_pfn = 0x105de80 max_arch_pfn = 0x400000000
[    0.000119] MTRR map: 5 entries (3 fixed + 2 variable; max 20),
built from 9 variable MTRRs
[    0.000120] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC- WT
[    0.000242] e820: update [mem 0x80000000-0xffffffff] usable ==> reserved
[    0.000247] last_pfn = 0x7a000 max_arch_pfn = 0x400000000
[    0.002476] esrt: Reserving ESRT space from 0x0000000067998f18 to
0x0000000067998f50.
[    0.002480] e820: update [mem 0x67998000-0x67998fff] usable ==> reserved
[    0.002487] Using GB pages for direct mapping
[    0.002642] Secure boot disabled
[    0.002642] RAMDISK: [mem 0x52887000-0x55042fff]
[    0.002737] ACPI: Early table checksum verification disabled
[    0.002739] ACPI: RSDP 0x0000000071797014 000024 (v02 ALASKA)
[    0.002741] ACPI: XSDT 0x0000000071796728 0000F4 (v01 ALASKA A M I
  01072009 AMI  01000013)
[    0.002744] ACPI: FACP 0x000000007178B000 000114 (v06 ALASKA A M I
  01072009 AMI  00010013)
[    0.002747] ACPI: DSDT 0x0000000071763000 014E5E (v86 ALASKA A M I
  01072009 INTL 20230331)
[    0.002749] ACPI: FACS 0x000000007377E000 000040
[    0.002750] ACPI: SSDT 0x000000007178D000 00816C (v02 AMD
Splinter 00000002 MSFT 05000000)
[    0.002751] ACPI: SSDT 0x000000007178C000 0003F1 (v02 ALASKA
CPUSSDT  01072009 AMI  01072009)
[    0.002752] ACPI: FIDT 0x000000007177D000 00009C (v01 ALASKA A M I
  01072009 AMI  00010013)
[    0.002753] ACPI: MCFG 0x000000007177B000 00003C (v01 ALASKA A M I
  01072009 MSFT 00010013)
[    0.002754] ACPI: HPET 0x000000007177A000 000038 (v01 ALASKA A M I
  01072009 AMI  00000005)
[    0.002755] ACPI: WDRT 0x0000000071779000 000047 (v01 ALASKA A M I
  01072009 AMI  00000005)
[    0.002755] ACPI: FPDT 0x0000000071778000 000044 (v01 ALASKA A M I
  01072009 AMI  01000013)
[    0.002756] ACPI: VFCT 0x0000000071749000 0190A0 (v01 ALASKA A M I
  00000001 AMD  31504F47)
[    0.002757] ACPI: BGRT 0x000000007178A000 000038 (v01 ALASKA A M I
  01072009 AMI  00010013)
[    0.002758] ACPI: WPBT 0x0000000071788000 000040 (v01 ALASKA A M I
  00000001 ASUS 00000001)
[    0.002759] ACPI: SSDT 0x000000007177E000 009BAE (v02 AMD    AMD
CPU  00000001 AMD  00000001)
[    0.002760] ACPI: SSDT 0x0000000071607000 000041 (v01 AMD
AppCompD 00000001 INTL 20230331)
[    0.002761] ACPI: SSDT 0x0000000071605000 00169E (v02 AMD
CPMDFIG2 00000001 INTL 20230331)
[    0.002762] ACPI: SSDT 0x0000000071602000 002AA6 (v02 AMD
CDFAAIG2 00000001 INTL 20230331)
[    0.002763] ACPI: SSDT 0x0000000071601000 0008BA (v02 AMD
CPMDFDG2 00000001 INTL 20230331)
[    0.002764] ACPI: SSDT 0x00000000715F6000 00A665 (v02 AMD    CPMCMN
  00000001 INTL 20230331)
[    0.002765] ACPI: SSDT 0x00000000715F3000 0027FE (v02 AMD    AOD
  00000001 INTL 20230331)
[    0.002766] ACPI: WSMT 0x00000000715F2000 000028 (v01 ALASKA A M I
  01072009 AMI  00010013)
[    0.002767] ACPI: APIC 0x00000000715F1000 00015E (v06 ALASKA A M I
  01072009 AMI  00010013)
[    0.002768] ACPI: IVRS 0x00000000715F0000 0000C8 (v02 AMD
AmdTable 00000001 AMD  00000001)
[    0.002769] ACPI: SSDT 0x00000000715EF000 000500 (v02 AMD
MEMTOOL0 00000002 INTL 20230331)
[    0.002770] ACPI: SSDT 0x00000000715EE000 0009E6 (v02 AMD
CPMMSOSC 00000001 INTL 20230331)
[    0.002771] ACPI: SSDT 0x00000000715ED000 00047C (v02 AMD    AMDWOV
  00000001 INTL 20230331)
[    0.002772] ACPI: SSDT 0x00000000715EC000 00044E (v02 AMD
AmdTable 00000001 INTL 20230331)
[    0.002773] ACPI: SSDT 0x00000000715EB000 000771 (v02 AMD
AmdTable 00000001 INTL 20230331)
[    0.002773] ACPI: Reserving FACP table memory at [mem 0x7178b000-0x7178b113]
[    0.002774] ACPI: Reserving DSDT table memory at [mem 0x71763000-0x71777e5d]
[    0.002774] ACPI: Reserving FACS table memory at [mem 0x7377e000-0x7377e03f]
[    0.002774] ACPI: Reserving SSDT table memory at [mem 0x7178d000-0x7179516b]
[    0.002775] ACPI: Reserving SSDT table memory at [mem 0x7178c000-0x7178c3f0]
[    0.002775] ACPI: Reserving FIDT table memory at [mem 0x7177d000-0x7177d09b]
[    0.002775] ACPI: Reserving MCFG table memory at [mem 0x7177b000-0x7177b03b]
[    0.002775] ACPI: Reserving HPET table memory at [mem 0x7177a000-0x7177a037]
[    0.002776] ACPI: Reserving WDRT table memory at [mem 0x71779000-0x71779046]
[    0.002776] ACPI: Reserving FPDT table memory at [mem 0x71778000-0x71778043]
[    0.002776] ACPI: Reserving VFCT table memory at [mem 0x71749000-0x7176209f]
[    0.002776] ACPI: Reserving BGRT table memory at [mem 0x7178a000-0x7178a037]
[    0.002777] ACPI: Reserving WPBT table memory at [mem 0x71788000-0x7178803f]
[    0.002777] ACPI: Reserving SSDT table memory at [mem 0x7177e000-0x71787bad]
[    0.002777] ACPI: Reserving SSDT table memory at [mem 0x71607000-0x71607040]
[    0.002777] ACPI: Reserving SSDT table memory at [mem 0x71605000-0x7160669d]
[    0.002778] ACPI: Reserving SSDT table memory at [mem 0x71602000-0x71604aa5]
[    0.002778] ACPI: Reserving SSDT table memory at [mem 0x71601000-0x716018b9]
[    0.002778] ACPI: Reserving SSDT table memory at [mem 0x715f6000-0x71600664]
[    0.002778] ACPI: Reserving SSDT table memory at [mem 0x715f3000-0x715f57fd]
[    0.002779] ACPI: Reserving WSMT table memory at [mem 0x715f2000-0x715f2027]
[    0.002779] ACPI: Reserving APIC table memory at [mem 0x715f1000-0x715f115d]
[    0.002779] ACPI: Reserving IVRS table memory at [mem 0x715f0000-0x715f00c7]
[    0.002779] ACPI: Reserving SSDT table memory at [mem 0x715ef000-0x715ef4ff]
[    0.002780] ACPI: Reserving SSDT table memory at [mem 0x715ee000-0x715ee9e5]
[    0.002780] ACPI: Reserving SSDT table memory at [mem 0x715ed000-0x715ed47b]
[    0.002780] ACPI: Reserving SSDT table memory at [mem 0x715ec000-0x715ec44d]
[    0.002780] ACPI: Reserving SSDT table memory at [mem 0x715eb000-0x715eb770]
[    0.002820] No NUMA configuration found
[    0.002821] Faking a node at [mem 0x0000000000000000-0x000000105de7ffff]
[    0.002824] NODE_DATA(0) allocated [mem 0x105de55280-0x105de7ffff]
[    0.002946] Zone ranges:
[    0.002947]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
[    0.002947]   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
[    0.002948]   Normal   [mem 0x0000000100000000-0x000000105de7ffff]
[    0.002948]   Device   empty
[    0.002949] Movable zone start for each node
[    0.002949] Early memory node ranges
[    0.002950]   node   0: [mem 0x0000000000001000-0x000000000009ffff]
[    0.002950]   node   0: [mem 0x0000000000100000-0x0000000009afefff]
[    0.002951]   node   0: [mem 0x000000000a000000-0x000000000a1fffff]
[    0.002951]   node   0: [mem 0x000000000a210000-0x000000000affffff]
[    0.002951]   node   0: [mem 0x000000000b021000-0x000000006ad3cfff]
[    0.002951]   node   0: [mem 0x00000000783ff000-0x0000000079ff8fff]
[    0.002952]   node   0: [mem 0x0000000079ffc000-0x0000000079ffffff]
[    0.002952]   node   0: [mem 0x0000000100000000-0x000000105de7ffff]
[    0.002955] Initmem setup node 0 [mem 0x0000000000001000-0x000000105de7ffff]
[    0.002958] On node 0, zone DMA: 1 pages in unavailable ranges
[    0.002966] On node 0, zone DMA: 96 pages in unavailable ranges
[    0.003023] On node 0, zone DMA32: 1281 pages in unavailable ranges
[    0.003030] On node 0, zone DMA32: 16 pages in unavailable ranges
[    0.003641] On node 0, zone DMA32: 33 pages in unavailable ranges
[    0.003687] On node 0, zone DMA32: 22210 pages in unavailable ranges
[    0.003688] On node 0, zone DMA32: 3 pages in unavailable ranges
[    0.040510] On node 0, zone Normal: 24576 pages in unavailable ranges
[    0.040531] On node 0, zone Normal: 8576 pages in unavailable ranges
[    0.041666] ACPI: PM-Timer IO Port: 0x808
[    0.041673] ACPI: LAPIC_NMI (acpi_id[0xff] high edge lint[0x1])
[    0.041682] IOAPIC[0]: apic_id 32, version 33, address 0xfec00000, GSI 0-23
[    0.041685] IOAPIC[1]: apic_id 33, version 33, address 0xfec01000, GSI 24-55
[    0.041686] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.041687] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 low level)
[    0.041689] ACPI: Using ACPI (MADT) for SMP configuration information
[    0.041690] ACPI: HPET id: 0x10228201 base: 0xfed00000
[    0.041696] e820: update [mem 0x649ac000-0x64d78fff] usable ==> reserved
[    0.041704] CPU topo: Max. logical packages:   1
[    0.041705] CPU topo: Max. logical dies:       2
[    0.041705] CPU topo: Max. dies per package:   2
[    0.041707] CPU topo: Max. threads per core:   2
[    0.041708] CPU topo: Num. cores per package:    16
[    0.041708] CPU topo: Num. threads per package:  32
[    0.041708] CPU topo: Allowing 32 present CPUs plus 0 hotplug CPUs
[    0.041719] PM: hibernation: Registered nosave memory: [mem
0x00000000-0x00000fff]
[    0.041720] PM: hibernation: Registered nosave memory: [mem
0x000a0000-0x000fffff]
[    0.041720] PM: hibernation: Registered nosave memory: [mem
0x09aff000-0x09ffffff]
[    0.041721] PM: hibernation: Registered nosave memory: [mem
0x0a200000-0x0a20ffff]
[    0.041721] PM: hibernation: Registered nosave memory: [mem
0x0b000000-0x0b020fff]
[    0.041722] PM: hibernation: Registered nosave memory: [mem
0x649ac000-0x64d78fff]
[    0.041723] PM: hibernation: Registered nosave memory: [mem
0x67998000-0x67998fff]
[    0.041723] PM: hibernation: Registered nosave memory: [mem
0x6ad3d000-0x783fefff]
[    0.041724] PM: hibernation: Registered nosave memory: [mem
0x79ff9000-0x79ffbfff]
[    0.041724] PM: hibernation: Registered nosave memory: [mem
0x7a000000-0xffffffff]
[    0.041725] [mem 0x80000000-0xfedfffff] available for PCI devices
[    0.041726] Booting paravirtualized kernel on bare hardware
[    0.041727] clocksource: refined-jiffies: mask: 0xffffffff
max_cycles: 0xffffffff, max_idle_ns: 1910969940391419 ns
[    0.044658] setup_percpu: NR_CPUS:8192 nr_cpumask_bits:32
nr_cpu_ids:32 nr_node_ids:1
[    0.045086] percpu: Embedded 62 pages/cpu s217088 r8192 d28672 u262144
[    0.045089] pcpu-alloc: s217088 r8192 d28672 u262144 alloc=1*2097152
[    0.045090] pcpu-alloc: [0] 00 01 02 03 04 05 06 07 [0] 08 09 10 11
12 13 14 15
[    0.045093] pcpu-alloc: [0] 16 17 18 19 20 21 22 23 [0] 24 25 26 27
28 29 30 31
[    0.045103] Kernel command line: BOOT_IMAGE=/vmlinuz-linux
root=UUID=a1c25360-9835-4c00-a3b9-fd93e2577a57 rw loglevel=3 quiet
[    0.045133] Unknown kernel command line parameters
"BOOT_IMAGE=/vmlinuz-linux", will be passed to user space.
[    0.045321] printk: log_buf_len individual max cpu contribution: 4096 bytes
[    0.045321] printk: log_buf_len total cpu_extra contributions: 126976 bytes
[    0.045321] printk: log_buf_len min size: 131072 bytes
[    0.045378] printk: log buffer data + meta data: 262144 + 917504 =
1179648 bytes
[    0.045379] printk: early log buf free: 117720(89%)
[    0.047519] Dentry cache hash table entries: 8388608 (order: 14,
67108864 bytes, linear)
[    0.048566] Inode-cache hash table entries: 4194304 (order: 13,
33554432 bytes, linear)
[    0.048711] software IO TLB: area num 32.
[    0.052964] Fallback order for Node 0: 0
[    0.052969] Built 1 zonelists, mobility grouping on.  Total pages: 16556584
[    0.052970] Policy zone: Normal
[    0.053051] mem auto-init: stack:all(zero), heap alloc:on, heap free:off
[    0.105068] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=32, Nodes=1
[    0.111647] ftrace: allocating 56047 entries in 220 pages
[    0.111648] ftrace: allocated 220 pages with 5 groups
[    0.111700] Dynamic Preempt: full
[    0.111752] rcu: Preemptible hierarchical RCU implementation.
[    0.111752] rcu:     RCU restricting CPUs from NR_CPUS=8192 to nr_cpu_ids=32.
[    0.111753] rcu:     RCU priority boosting: priority 1 delay 500 ms.
[    0.111753]  Trampoline variant of Tasks RCU enabled.
[    0.111754]  Rude variant of Tasks RCU enabled.
[    0.111754]  Tracing variant of Tasks RCU enabled.
[    0.111754] rcu: RCU calculated value of scheduler-enlistment delay
is 100 jiffies.
[    0.111755] rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=32
[    0.111763] RCU Tasks: Setting shift to 5 and lim to 1
rcu_task_cb_adjust=1 rcu_task_cpu_ids=32.
[    0.111764] RCU Tasks Rude: Setting shift to 5 and lim to 1
rcu_task_cb_adjust=1 rcu_task_cpu_ids=32.
[    0.111765] RCU Tasks Trace: Setting shift to 5 and lim to 1
rcu_task_cb_adjust=1 rcu_task_cpu_ids=32.
[    0.114054] NR_IRQS: 524544, nr_irqs: 1224, preallocated irqs: 16
[    0.114224] rcu: srcu_init: Setting srcu_struct sizes based on contention.
[    0.114362] kfence: initialized - using 2097152 bytes for 255
objects at 0x(____ptrval____)-0x(____ptrval____)
[    0.114389] Console: colour dummy device 80x25
[    0.114390] printk: legacy console [tty0] enabled
[    0.114415] ACPI: Core revision 20250404
[    0.114535] clocksource: hpet: mask: 0xffffffff max_cycles:
0xffffffff, max_idle_ns: 133484873504 ns
[    0.114545] APIC: Switch to symmetric I/O mode setup
[    0.114778] AMD-Vi: Using global IVHD EFR:0x246577efa2254afa, EFR2:0x0
[    0.115545] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
[    0.120550] clocksource: tsc-early: mask: 0xffffffffffffffff
max_cycles: 0x40dded453bd, max_idle_ns: 440795427129 ns
[    0.120552] Calibrating delay loop (skipped), value calculated
using timer frequency.. 9000.28 BogoMIPS (lpj=4500140)
[    0.120563] x86/cpu: User Mode Instruction Prevention (UMIP) activated
[    0.120601] LVT offset 1 assigned for vector 0xf9
[    0.120721] LVT offset 2 assigned for vector 0xf4
[    0.120756] Last level iTLB entries: 4KB 512, 2MB 512, 4MB 256
[    0.120756] Last level dTLB entries: 4KB 3072, 2MB 3072, 4MB 1536, 1GB 0
[    0.120758] process: using mwait in idle threads
[    0.120760] Speculative Store Bypass: Mitigation: Speculative Store
Bypass disabled via prctl
[    0.120761] Transient Scheduler Attacks: Mitigation: Clear CPU buffers
[    0.120761] Spectre V2 : Mitigation: Enhanced / Automatic IBRS
[    0.120762] Spectre V2 : User space: Mitigation: STIBP always-on protection
[    0.120762] Speculative Return Stack Overflow: Mitigation: Safe RET
[    0.120763] VMSCAPE: Mitigation: IBPB before exit to userspace
[    0.120763] Spectre V1 : Mitigation: usercopy/swapgs barriers and
__user pointer sanitization
[    0.120764] Spectre V2 : mitigation: Enabling conditional Indirect
Branch Prediction Barrier
[    0.120765] active return thunk: srso_alias_return_thunk
[    0.120770] x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating
point registers'
[    0.120771] x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers'
[    0.120771] x86/fpu: Supporting XSAVE feature 0x004: 'AVX registers'
[    0.120771] x86/fpu: Supporting XSAVE feature 0x020: 'AVX-512 opmask'
[    0.120772] x86/fpu: Supporting XSAVE feature 0x040: 'AVX-512 Hi256'
[    0.120772] x86/fpu: Supporting XSAVE feature 0x080: 'AVX-512 ZMM_Hi256'
[    0.120772] x86/fpu: Supporting XSAVE feature 0x200: 'Protection
Keys User registers'
[    0.120773] x86/fpu: Supporting XSAVE feature 0x800: 'Control-flow
User registers'
[    0.120774] x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  256
[    0.120774] x86/fpu: xstate_offset[5]:  832, xstate_sizes[5]:   64
[    0.120775] x86/fpu: xstate_offset[6]:  896, xstate_sizes[6]:  512
[    0.120775] x86/fpu: xstate_offset[7]: 1408, xstate_sizes[7]: 1024
[    0.120776] x86/fpu: xstate_offset[9]: 2432, xstate_sizes[9]:    8
[    0.120776] x86/fpu: xstate_offset[11]: 2440, xstate_sizes[11]:   16
[    0.120777] x86/fpu: Enabled xstate features 0xae7, context size is
2456 bytes, using 'compacted' format.
[    0.140402] Freeing SMP alternatives memory: 56K
[    0.140404] pid_max: default: 32768 minimum: 301
[    0.141573] LSM: initializing lsm=capability,landlock,lockdown,yama,bpf
[    0.141630] landlock: Up and running.
[    0.141632] Yama: becoming mindful.
[    0.141785] LSM support for eBPF active
[    0.141835] Mount-cache hash table entries: 131072 (order: 8,
1048576 bytes, linear)
[    0.141874] Mountpoint-cache hash table entries: 131072 (order: 8,
1048576 bytes, linear)
[    0.245555] smpboot: CPU0: AMD Ryzen 9 7950X 16-Core Processor
(family: 0x19, model: 0x61, stepping: 0x2)
[    0.245685] Performance Events: Fam17h+ 16-deep LBR, core perfctr,
AMD PMU driver.
[    0.245708] ... version:                2
[    0.245708] ... bit width:              48
[    0.245709] ... generic registers:      6
[    0.245710] ... value mask:             0000ffffffffffff
[    0.245711] ... max period:             00007fffffffffff
[    0.245711] ... fixed-purpose events:   0
[    0.245712] ... event mask:             000000000000003f
[    0.245796] signal: max sigframe size: 3376
[    0.245827] rcu: Hierarchical SRCU implementation.
[    0.245828] rcu:     Max phase no-delay instances is 400.
[    0.245871] Timer migration: 2 hierarchy levels; 8 children per
group; 2 crossnode level
[    0.248869] MCE: In-kernel MCE decoding enabled.
[    0.248892] NMI watchdog: Enabled. Permanently consumes one hw-PMU counter.
[    0.249023] smp: Bringing up secondary CPUs ...
[    0.249085] smpboot: x86: Booting SMP configuration:
[    0.249086] .... node  #0, CPUs:        #1  #2  #3  #4  #5  #6  #7
#8  #9 #10 #11 #12 #13 #14 #15 #16 #17 #18 #19 #20 #21 #22 #23 #24 #25
#26 #27 #28 #29 #30 #31
[    0.269661] Spectre V2 : Update user space SMT mitigation: STIBP always-on
[    0.286592] smp: Brought up 1 node, 32 CPUs
[    0.286592] smpboot: Total of 32 processors activated (288008.96 BogoMIPS)
[    0.288612] Memory: 64869668K/66226336K available (19868K kernel
code, 2942K rwdata, 16676K rodata, 4664K init, 4948K bss, 1317704K
reserved, 0K cma-reserved)
[    0.289101] devtmpfs: initialized
[    0.289101] x86/mm: Memory block size: 2048MB
[    0.290280] ACPI: PM: Registering ACPI NVS region [mem
0x0a200000-0x0a20ffff] (65536 bytes)
[    0.290280] ACPI: PM: Registering ACPI NVS region [mem
0x71798000-0x73797fff] (33554432 bytes)
[    0.290582] clocksource: jiffies: mask: 0xffffffff max_cycles:
0xffffffff, max_idle_ns: 1911260446275000 ns
[    0.290582] posixtimers hash table entries: 16384 (order: 6, 262144
bytes, linear)
[    0.290585] futex hash table entries: 8192 (524288 bytes on 1 NUMA
nodes, total 512 KiB, linear).
[    0.290648] pinctrl core: initialized pinctrl subsystem
[    0.290727] PM: RTC time: 06:53:55, date: 2025-09-22
[    0.290986] NET: Registered PF_NETLINK/PF_ROUTE protocol family
[    0.291174] DMA: preallocated 4096 KiB GFP_KERNEL pool for atomic allocations
[    0.291261] DMA: preallocated 4096 KiB GFP_KERNEL|GFP_DMA pool for
atomic allocations
[    0.291347] DMA: preallocated 4096 KiB GFP_KERNEL|GFP_DMA32 pool
for atomic allocations
[    0.291352] audit: initializing netlink subsys (disabled)
[    0.291357] audit: type=2000 audit(1758524035.000:1):
state=initialized audit_enabled=0 res=1
[    0.291357] thermal_sys: Registered thermal governor 'fair_share'
[    0.291357] thermal_sys: Registered thermal governor 'bang_bang'
[    0.291357] thermal_sys: Registered thermal governor 'step_wise'
[    0.291357] thermal_sys: Registered thermal governor 'user_space'
[    0.291357] thermal_sys: Registered thermal governor 'power_allocator'
[    0.291357] cpuidle: using governor ladder
[    0.291357] cpuidle: using governor menu
[    0.291613] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
[    0.291665] PCI: ECAM [mem 0xe0000000-0xefffffff] (base 0xe0000000)
for domain 0000 [bus 00-ff]
[    0.291676] PCI: Using configuration type 1 for base access
[    0.291768] kprobes: kprobe jump-optimization is enabled. All
kprobes are optimized if possible.
[    0.291774] HugeTLB: allocation took 0ms with hugepage_allocation_threads=8
[    0.291774] HugeTLB: registered 1.00 GiB page size, pre-allocated 0 pages
[    0.291774] HugeTLB: 16380 KiB vmemmap can be freed for a 1.00 GiB page
[    0.291774] HugeTLB: registered 2.00 MiB page size, pre-allocated 0 pages
[    0.291774] HugeTLB: 28 KiB vmemmap can be freed for a 2.00 MiB page
[    0.291774] raid6: skipped pq benchmark and selected avx512x4
[    0.291774] raid6: using avx512x2 recovery algorithm
[    0.292863] ACPI: Added _OSI(Module Device)
[    0.292865] ACPI: Added _OSI(Processor Device)
[    0.292866] ACPI: Added _OSI(Processor Aggregator Device)
[    0.315131] ACPI: 15 ACPI AML tables successfully acquired and loaded
[    0.321307] ACPI: EC: EC started
[    0.321309] ACPI: EC: interrupt blocked
[    0.321874] ACPI: EC: EC_CMD/EC_SC=0x66, EC_DATA=0x62
[    0.321875] ACPI: \_SB_.PCI0.SBRG.EC0_: Boot DSDT EC used to handle
transactions
[    0.321876] ACPI: Interpreter enabled
[    0.321888] ACPI: PM: (supports S0 S3 S4 S5)
[    0.321889] ACPI: Using IOAPIC for interrupt routing
[    0.323478] PCI: Using host bridge windows from ACPI; if necessary,
use "pci=nocrs" and report a bug
[    0.323479] PCI: Ignoring E820 reservations for host bridge windows
[    0.323939] ACPI: Enabled 6 GPEs in block 00 to 1F
[    0.328026] ACPI: \_SB_.PCI0.GPP0.M237: New power resource
[    0.328079] ACPI: \_SB_.PCI0.GPP0.SWUS.M237: New power resource
[    0.328141] ACPI: \_SB_.PCI0.GPP0.SWUS.SWDS.M237: New power resource
[    0.339965] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
[    0.339969] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM
ClockPM Segments MSI EDR HPX-Type3]
[    0.340128] acpi PNP0A08:00: _OSC: OS now controls [PCIeHotplug
SHPCHotplug PME AER PCIeCapability LTR DPC]
[    0.340632] PCI host bridge to bus 0000:00
[    0.340635] pci_bus 0000:00: root bus resource [io  0x0000-0x03af window]
[    0.340637] pci_bus 0000:00: root bus resource [io  0x03e0-0x0cf7 window]
[    0.340638] pci_bus 0000:00: root bus resource [io  0x03b0-0x03df window]
[    0.340639] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
[    0.340641] pci_bus 0000:00: root bus resource [mem
0x000a0000-0x000dffff window]
[    0.340642] pci_bus 0000:00: root bus resource [mem
0x80000000-0xf6ffffff window]
[    0.340643] pci_bus 0000:00: root bus resource [mem
0x1080000000-0xffffffffff window]
[    0.340644] pci_bus 0000:00: root bus resource [bus 00-ff]
[    0.340656] pci 0000:00:00.0: [1022:14d8] type 00 class 0x060000
conventional PCI endpoint
[    0.340739] pci 0000:00:00.2: [1022:14d9] type 00 class 0x080600
conventional PCI endpoint
[    0.340816] pci 0000:00:01.0: [1022:14da] type 00 class 0x060000
conventional PCI endpoint
[    0.340885] pci 0000:00:01.1: [1022:14db] type 01 class 0x060400
PCIe Root Port
[    0.340899] pci 0000:00:01.1: PCI bridge to [bus 01-03]
[    0.340903] pci 0000:00:01.1:   bridge window [io  0xf000-0xffff]
[    0.340905] pci 0000:00:01.1:   bridge window [mem 0xf6b00000-0xf6dfffff]
[    0.340911] pci 0000:00:01.1:   bridge window [mem
0xf000000000-0xf80fffffff 64bit pref]
[    0.340970] pci 0000:00:01.1: PME# supported from D0 D3hot D3cold
[    0.341100] pci 0000:00:01.2: [1022:14db] type 01 class 0x060400
PCIe Root Port
[    0.341120] pci 0000:00:01.2: PCI bridge to [bus 04]
[    0.341127] pci 0000:00:01.2:   bridge window [mem 0xf6f00000-0xf6ffffff]
[    0.341218] pci 0000:00:01.2: PME# supported from D0 D3hot D3cold
[    0.341365] pci 0000:00:02.0: [1022:14da] type 00 class 0x060000
conventional PCI endpoint
[    0.341437] pci 0000:00:02.1: [1022:14db] type 01 class 0x060400
PCIe Root Port
[    0.341457] pci 0000:00:02.1: PCI bridge to [bus 05-13]
[    0.341464] pci 0000:00:02.1:   bridge window [mem 0xf6000000-0xf66fffff]
[    0.341481] pci 0000:00:02.1: enabling Extended Tags
[    0.341565] pci 0000:00:02.1: PME# supported from D0 D3hot D3cold
[    0.341786] pci 0000:00:03.0: [1022:14da] type 00 class 0x060000
conventional PCI endpoint
[    0.341857] pci 0000:00:04.0: [1022:14da] type 00 class 0x060000
conventional PCI endpoint
[    0.341929] pci 0000:00:08.0: [1022:14da] type 00 class 0x060000
conventional PCI endpoint
[    0.341997] pci 0000:00:08.1: [1022:14dd] type 01 class 0x060400
PCIe Root Port
[    0.342006] pci 0000:00:08.1: PCI bridge to [bus 14]
[    0.342009] pci 0000:00:08.1:   bridge window [io  0xe000-0xefff]
[    0.342011] pci 0000:00:08.1:   bridge window [mem 0xf6700000-0xf6afffff]
[    0.342015] pci 0000:00:08.1:   bridge window [mem
0xf820000000-0xf8301fffff 64bit pref]
[    0.342019] pci 0000:00:08.1: enabling Extended Tags
[    0.342044] pci 0000:00:08.1: PME# supported from D0 D3hot D3cold
[    0.342140] pci 0000:00:08.3: [1022:14dd] type 01 class 0x060400
PCIe Root Port
[    0.342150] pci 0000:00:08.3: PCI bridge to [bus 15]
[    0.342153] pci 0000:00:08.3:   bridge window [mem 0xf6e00000-0xf6efffff]
[    0.342160] pci 0000:00:08.3: enabling Extended Tags
[    0.342185] pci 0000:00:08.3: PME# supported from D0 D3hot D3cold
[    0.342276] pci 0000:00:14.0: [1022:790b] type 00 class 0x0c0500
conventional PCI endpoint
[    0.342367] pci 0000:00:14.3: [1022:790e] type 00 class 0x060100
conventional PCI endpoint
[    0.342470] pci 0000:00:18.0: [1022:14e0] type 00 class 0x060000
conventional PCI endpoint
[    0.342502] pci 0000:00:18.1: [1022:14e1] type 00 class 0x060000
conventional PCI endpoint
[    0.342532] pci 0000:00:18.2: [1022:14e2] type 00 class 0x060000
conventional PCI endpoint
[    0.342570] pci 0000:00:18.3: [1022:14e3] type 00 class 0x060000
conventional PCI endpoint
[    0.342601] pci 0000:00:18.4: [1022:14e4] type 00 class 0x060000
conventional PCI endpoint
[    0.342633] pci 0000:00:18.5: [1022:14e5] type 00 class 0x060000
conventional PCI endpoint
[    0.342664] pci 0000:00:18.6: [1022:14e6] type 00 class 0x060000
conventional PCI endpoint
[    0.342695] pci 0000:00:18.7: [1022:14e7] type 00 class 0x060000
conventional PCI endpoint
[    0.342798] pci 0000:01:00.0: [1002:1478] type 01 class 0x060400
PCIe Switch Upstream Port
[    0.342823] pci 0000:01:00.0: BAR 0 [mem 0xf6d00000-0xf6d03fff]
[    0.342828] pci 0000:01:00.0: PCI bridge to [bus 02-03]
[    0.342834] pci 0000:01:00.0:   bridge window [io  0xf000-0xffff]
[    0.342837] pci 0000:01:00.0:   bridge window [mem 0xf6b00000-0xf6cfffff]
[    0.342847] pci 0000:01:00.0:   bridge window [mem
0xf000000000-0xf80fffffff 64bit pref]
[    0.342946] pci 0000:01:00.0: PME# supported from D0 D3hot D3cold
[    0.343054] pci 0000:01:00.0: 32.000 Gb/s available PCIe bandwidth,
limited by 2.5 GT/s PCIe x16 link at 0000:00:01.1 (capable of 252.048
Gb/s with 16.0 GT/s PCIe x16 link)
[    0.343151] pci 0000:00:01.1: PCI bridge to [bus 01-03]
[    0.343221] pci 0000:02:00.0: [1002:1479] type 01 class 0x060400
PCIe Switch Downstream Port
[    0.343246] pci 0000:02:00.0: PCI bridge to [bus 03]
[    0.343252] pci 0000:02:00.0:   bridge window [io  0xf000-0xffff]
[    0.343255] pci 0000:02:00.0:   bridge window [mem 0xf6b00000-0xf6cfffff]
[    0.343265] pci 0000:02:00.0:   bridge window [mem
0xf000000000-0xf80fffffff 64bit pref]
[    0.343357] pci 0000:02:00.0: PME# supported from D0 D3hot D3cold
[    0.343929] pci 0000:01:00.0: PCI bridge to [bus 02-03]
[    0.344004] pci 0000:03:00.0: [1002:744c] type 00 class 0x030000
PCIe Legacy Endpoint
[    0.344043] pci 0000:03:00.0: BAR 0 [mem 0xf000000000-0xf7ffffffff
64bit pref]
[    0.344046] pci 0000:03:00.0: BAR 2 [mem 0xf800000000-0xf80fffffff
64bit pref]
[    0.344048] pci 0000:03:00.0: BAR 4 [io  0xf000-0xf0ff]
[    0.344050] pci 0000:03:00.0: BAR 5 [mem 0xf6b00000-0xf6bfffff]
[    0.344052] pci 0000:03:00.0: ROM [mem 0xf6c00000-0xf6c1ffff pref]
[    0.344154] pci 0000:03:00.0: PME# supported from D1 D2 D3hot D3cold
[    0.344260] pci 0000:03:00.0: 32.000 Gb/s available PCIe bandwidth,
limited by 2.5 GT/s PCIe x16 link at 0000:00:01.1 (capable of 252.048
Gb/s with 16.0 GT/s PCIe x16 link)
[    0.344365] pci 0000:03:00.1: [1002:ab30] type 00 class 0x040300
PCIe Legacy Endpoint
[    0.344401] pci 0000:03:00.1: BAR 0 [mem 0xf6c20000-0xf6c23fff]
[    0.344475] pci 0000:03:00.1: PME# supported from D1 D2 D3hot D3cold
[    0.344625] pci 0000:02:00.0: PCI bridge to [bus 03]
[    0.344922] pci 0000:04:00.0: [144d:a80a] type 00 class 0x010802
PCIe Endpoint
[    0.344949] pci 0000:04:00.0: BAR 0 [mem 0xf6f00000-0xf6f03fff 64bit]
[    0.345392] pci 0000:00:01.2: PCI bridge to [bus 04]
[    0.345571] pci 0000:05:00.0: [1022:43f4] type 01 class 0x060400
PCIe Switch Upstream Port
[    0.345588] pci 0000:05:00.0: PCI bridge to [bus 06-13]
[    0.345593] pci 0000:05:00.0:   bridge window [mem 0xf6000000-0xf66fffff]
[    0.345607] pci 0000:05:00.0: enabling Extended Tags
[    0.345652] pci 0000:05:00.0: PME# supported from D0 D3hot D3cold
[    0.346110] pci 0000:00:02.1: PCI bridge to [bus 05-13]
[    0.346940] pci 0000:06:00.0: [1022:43f5] type 01 class 0x060400
PCIe Switch Downstream Port
[    0.346956] pci 0000:06:00.0: PCI bridge to [bus 07]
[    0.346976] pci 0000:06:00.0: enabling Extended Tags
[    0.347024] pci 0000:06:00.0: PME# supported from D0 D3hot D3cold
[    0.347415] pci 0000:06:08.0: [1022:43f5] type 01 class 0x060400
PCIe Switch Downstream Port
[    0.347432] pci 0000:06:08.0: PCI bridge to [bus 08-11]
[    0.347437] pci 0000:06:08.0:   bridge window [mem 0xf6000000-0xf64fffff]
[    0.347451] pci 0000:06:08.0: enabling Extended Tags
[    0.347498] pci 0000:06:08.0: PME# supported from D0 D3hot D3cold
[    0.348249] pci 0000:06:0c.0: [1022:43f5] type 01 class 0x060400
PCIe Switch Downstream Port
[    0.348265] pci 0000:06:0c.0: PCI bridge to [bus 12]
[    0.348269] pci 0000:06:0c.0:   bridge window [mem 0xf6600000-0xf66fffff]
[    0.348283] pci 0000:06:0c.0: enabling Extended Tags
[    0.348316] pci 0000:06:0c.0: PME# supported from D0 D3hot D3cold
[    0.348565] pci 0000:06:0d.0: [1022:43f5] type 01 class 0x060400
PCIe Switch Downstream Port
[    0.348582] pci 0000:06:0d.0: PCI bridge to [bus 13]
[    0.348586] pci 0000:06:0d.0:   bridge window [mem 0xf6500000-0xf65fffff]
[    0.348600] pci 0000:06:0d.0: enabling Extended Tags
[    0.348633] pci 0000:06:0d.0: PME# supported from D0 D3hot D3cold
[    0.348999] pci 0000:05:00.0: PCI bridge to [bus 06-13]
[    0.349333] pci 0000:06:00.0: PCI bridge to [bus 07]
[    0.349573] pci 0000:08:00.0: [1022:43f4] type 01 class 0x060400
PCIe Switch Upstream Port
[    0.349599] pci 0000:08:00.0: PCI bridge to [bus 09-11]
[    0.349607] pci 0000:08:00.0:   bridge window [mem 0xf6000000-0xf64fffff]
[    0.349629] pci 0000:08:00.0: enabling Extended Tags
[    0.349702] pci 0000:08:00.0: PME# supported from D0 D3hot D3cold
[    0.349923] pci 0000:06:08.0: PCI bridge to [bus 08-11]
[    0.350064] pci 0000:09:00.0: [1022:43f5] type 01 class 0x060400
PCIe Switch Downstream Port
[    0.350090] pci 0000:09:00.0: PCI bridge to [bus 0a]
[    0.350120] pci 0000:09:00.0: enabling Extended Tags
[    0.350198] pci 0000:09:00.0: PME# supported from D0 D3hot D3cold
[    0.350624] pci 0000:09:04.0: [1022:43f5] type 01 class 0x060400
PCIe Switch Downstream Port
[    0.350650] pci 0000:09:04.0: PCI bridge to [bus 0b]
[    0.350658] pci 0000:09:04.0:   bridge window [mem 0xf6400000-0xf64fffff]
[    0.350681] pci 0000:09:04.0: enabling Extended Tags
[    0.350755] pci 0000:09:04.0: PME# supported from D0 D3hot D3cold
[    0.350930] pci 0000:09:05.0: [1022:43f5] type 01 class 0x060400
PCIe Switch Downstream Port
[    0.350956] pci 0000:09:05.0: PCI bridge to [bus 0c]
[    0.350964] pci 0000:09:05.0:   bridge window [mem 0xf6000000-0xf61fffff]
[    0.350987] pci 0000:09:05.0: enabling Extended Tags
[    0.351062] pci 0000:09:05.0: PME# supported from D0 D3hot D3cold
[    0.351236] pci 0000:09:06.0: [1022:43f5] type 01 class 0x060400
PCIe Switch Downstream Port
[    0.351262] pci 0000:09:06.0: PCI bridge to [bus 0d]
[    0.351292] pci 0000:09:06.0: enabling Extended Tags
[    0.351370] pci 0000:09:06.0: PME# supported from D0 D3hot D3cold
[    0.351544] pci 0000:09:07.0: [1022:43f5] type 01 class 0x060400
PCIe Switch Downstream Port
[    0.351570] pci 0000:09:07.0: PCI bridge to [bus 0e]
[    0.351600] pci 0000:09:07.0: enabling Extended Tags
[    0.351678] pci 0000:09:07.0: PME# supported from D0 D3hot D3cold
[    0.351853] pci 0000:09:08.0: [1022:43f5] type 01 class 0x060400
PCIe Switch Downstream Port
[    0.351879] pci 0000:09:08.0: PCI bridge to [bus 0f]
[    0.351909] pci 0000:09:08.0: enabling Extended Tags
[    0.351987] pci 0000:09:08.0: PME# supported from D0 D3hot D3cold
[    0.352167] pci 0000:09:0c.0: [1022:43f5] type 01 class 0x060400
PCIe Switch Downstream Port
[    0.352193] pci 0000:09:0c.0: PCI bridge to [bus 10]
[    0.352199] pci 0000:09:0c.0:   bridge window [mem 0xf6300000-0xf63fffff]
[    0.352221] pci 0000:09:0c.0: enabling Extended Tags
[    0.352272] pci 0000:09:0c.0: PME# supported from D0 D3hot D3cold
[    0.352414] pci 0000:09:0d.0: [1022:43f5] type 01 class 0x060400
PCIe Switch Downstream Port
[    0.352440] pci 0000:09:0d.0: PCI bridge to [bus 11]
[    0.352446] pci 0000:09:0d.0:   bridge window [mem 0xf6200000-0xf62fffff]
[    0.352468] pci 0000:09:0d.0: enabling Extended Tags
[    0.352520] pci 0000:09:0d.0: PME# supported from D0 D3hot D3cold
[    0.352653] pci 0000:08:00.0: PCI bridge to [bus 09-11]
[    0.352711] pci 0000:09:00.0: PCI bridge to [bus 0a]
[    0.352838] pci 0000:0b:00.0: [8086:2725] type 00 class 0x028000
PCIe Endpoint
[    0.352909] pci 0000:0b:00.0: BAR 0 [mem 0xf6400000-0xf6403fff 64bit]
[    0.353036] pci 0000:0b:00.0: PME# supported from D0 D3hot D3cold
[    0.353266] pci 0000:09:04.0: PCI bridge to [bus 0b]
[    0.353382] pci 0000:0c:00.0: [8086:15f3] type 00 class 0x020000
PCIe Endpoint
[    0.353447] pci 0000:0c:00.0: BAR 0 [mem 0xf6000000-0xf60fffff]
[    0.353453] pci 0000:0c:00.0: BAR 3 [mem 0xf6100000-0xf6103fff]
[    0.353581] pci 0000:0c:00.0: PME# supported from D0 D3hot D3cold
[    0.353821] pci 0000:09:05.0: PCI bridge to [bus 0c]
[    0.353878] pci 0000:09:06.0: PCI bridge to [bus 0d]
[    0.353934] pci 0000:09:07.0: PCI bridge to [bus 0e]
[    0.353990] pci 0000:09:08.0: PCI bridge to [bus 0f]
[    0.354062] pci 0000:10:00.0: [1022:43f7] type 00 class 0x0c0330
PCIe Legacy Endpoint
[    0.354102] pci 0000:10:00.0: BAR 0 [mem 0xf6300000-0xf6307fff 64bit]
[    0.354114] pci 0000:10:00.0: enabling Extended Tags
[    0.354171] pci 0000:10:00.0: PME# supported from D0 D3hot D3cold
[    0.354346] pci 0000:09:0c.0: PCI bridge to [bus 10]
[    0.354440] pci 0000:11:00.0: [1022:43f6] type 00 class 0x010601
PCIe Legacy Endpoint
[    0.354482] pci 0000:11:00.0: BAR 5 [mem 0xf6280000-0xf62803ff]
[    0.354484] pci 0000:11:00.0: ROM [mem 0xf6200000-0xf627ffff pref]
[    0.354492] pci 0000:11:00.0: enabling Extended Tags
[    0.354538] pci 0000:11:00.0: PME# supported from D0 D3hot D3cold
[    0.354660] pci 0000:09:0d.0: PCI bridge to [bus 11]
[    0.354763] pci 0000:12:00.0: [1022:43f7] type 00 class 0x0c0330
PCIe Legacy Endpoint
[    0.354788] pci 0000:12:00.0: BAR 0 [mem 0xf6600000-0xf6607fff 64bit]
[    0.354797] pci 0000:12:00.0: enabling Extended Tags
[    0.354832] pci 0000:12:00.0: PME# supported from D0 D3hot D3cold
[    0.354949] pci 0000:06:0c.0: PCI bridge to [bus 12]
[    0.355000] pci 0000:13:00.0: [1022:43f6] type 00 class 0x010601
PCIe Legacy Endpoint
[    0.355026] pci 0000:13:00.0: BAR 5 [mem 0xf6580000-0xf65803ff]
[    0.355028] pci 0000:13:00.0: ROM [mem 0xf6500000-0xf657ffff pref]
[    0.355033] pci 0000:13:00.0: enabling Extended Tags
[    0.355062] pci 0000:13:00.0: PME# supported from D0 D3hot D3cold
[    0.355156] pci 0000:06:0d.0: PCI bridge to [bus 13]
[    0.355251] pci 0000:14:00.0: [1002:164e] type 00 class 0x030000
PCIe Legacy Endpoint
[    0.355267] pci 0000:14:00.0: BAR 0 [mem 0xf820000000-0xf82fffffff
64bit pref]
[    0.355269] pci 0000:14:00.0: BAR 2 [mem 0xf830000000-0xf8301fffff
64bit pref]
[    0.355271] pci 0000:14:00.0: BAR 4 [io  0xe000-0xe0ff]
[    0.355272] pci 0000:14:00.0: BAR 5 [mem 0xf6a00000-0xf6a7ffff]
[    0.355276] pci 0000:14:00.0: enabling Extended Tags
[    0.355310] pci 0000:14:00.0: PME# supported from D1 D2 D3hot D3cold
[    0.355399] pci 0000:14:00.1: [1002:1640] type 00 class 0x040300
PCIe Legacy Endpoint
[    0.355414] pci 0000:14:00.1: BAR 0 [mem 0xf6a80000-0xf6a83fff]
[    0.355420] pci 0000:14:00.1: enabling Extended Tags
[    0.355441] pci 0000:14:00.1: PME# supported from D1 D2 D3hot D3cold
[    0.355510] pci 0000:14:00.2: [1022:1649] type 00 class 0x108000
PCIe Endpoint
[    0.355545] pci 0000:14:00.2: BAR 2 [mem 0xf6900000-0xf69fffff]
[    0.355547] pci 0000:14:00.2: BAR 5 [mem 0xf6a84000-0xf6a85fff]
[    0.355553] pci 0000:14:00.2: enabling Extended Tags
[    0.355641] pci 0000:14:00.3: [1022:15b6] type 00 class 0x0c0330
PCIe Endpoint
[    0.355657] pci 0000:14:00.3: BAR 0 [mem 0xf6800000-0xf68fffff 64bit]
[    0.355662] pci 0000:14:00.3: enabling Extended Tags
[    0.355685] pci 0000:14:00.3: PME# supported from D0 D3hot D3cold
[    0.355757] pci 0000:14:00.4: [1022:15b7] type 00 class 0x0c0330
PCIe Endpoint
[    0.355773] pci 0000:14:00.4: BAR 0 [mem 0xf6700000-0xf67fffff 64bit]
[    0.355778] pci 0000:14:00.4: enabling Extended Tags
[    0.355801] pci 0000:14:00.4: PME# supported from D0 D3hot D3cold
[    0.355883] pci 0000:00:08.1: PCI bridge to [bus 14]
[    0.355921] pci 0000:15:00.0: [1022:15b8] type 00 class 0x0c0330
PCIe Endpoint
[    0.355941] pci 0000:15:00.0: BAR 0 [mem 0xf6e00000-0xf6efffff 64bit]
[    0.355946] pci 0000:15:00.0: enabling Extended Tags
[    0.355974] pci 0000:15:00.0: PME# supported from D0 D3hot D3cold
[    0.356055] pci 0000:00:08.3: PCI bridge to [bus 15]
[    0.356930] ACPI: PCI: Interrupt link LNKA configured for IRQ 0
[    0.356979] ACPI: PCI: Interrupt link LNKB configured for IRQ 0
[    0.357022] ACPI: PCI: Interrupt link LNKC configured for IRQ 0
[    0.357073] ACPI: PCI: Interrupt link LNKD configured for IRQ 0
[    0.357120] ACPI: PCI: Interrupt link LNKE configured for IRQ 0
[    0.357159] ACPI: PCI: Interrupt link LNKF configured for IRQ 0
[    0.357199] ACPI: PCI: Interrupt link LNKG configured for IRQ 0
[    0.357238] ACPI: PCI: Interrupt link LNKH configured for IRQ 0
[    0.358505] ACPI: EC: interrupt unblocked
[    0.358507] ACPI: EC: event unblocked
[    0.358511] ACPI: EC: EC_CMD/EC_SC=0x66, EC_DATA=0x62
[    0.358512] ACPI: EC: GPE=0x4
[    0.358513] ACPI: \_SB_.PCI0.SBRG.EC0_: Boot DSDT EC initialization complete
[    0.358514] ACPI: \_SB_.PCI0.SBRG.EC0_: EC: Used to handle
transactions and events
[    0.358582] iommu: Default domain type: Translated
[    0.358582] iommu: DMA domain TLB invalidation policy: lazy mode
[    0.358649] SCSI subsystem initialized
[    0.358655] libata version 3.00 loaded.
[    0.358655] ACPI: bus type USB registered
[    0.358655] usbcore: registered new interface driver usbfs
[    0.358655] usbcore: registered new interface driver hub
[    0.358655] usbcore: registered new device driver usb
[    0.361617] EDAC MC: Ver: 3.0.0
[    0.361958] efivars: Registered efivars operations
[    0.361958] NetLabel: Initializing
[    0.361958] NetLabel:  domain hash size = 128
[    0.361958] NetLabel:  protocols = UNLABELED CIPSOv4 CALIPSO
[    0.361958] NetLabel:  unlabeled traffic allowed by default
[    0.361958] mctp: management component transport protocol core
[    0.361958] NET: Registered PF_MCTP protocol family
[    0.361958] PCI: Using ACPI for IRQ routing
[    0.367926] PCI: pci_cache_line_size set to 64 bytes
[    0.367929] pci 0000:00:02.1: bridge window [mem
0xf6000000-0xf66fffff]: can't claim; address conflict with AMDIF031:00
[mem 0xf6200000-0xf6200fff]
[    0.367931] pci 0000:05:00.0: bridge window [mem
0xf6000000-0xf66fffff]: can't claim; no compatible bridge window
[    0.367932] pci 0000:06:08.0: bridge window [mem
0xf6000000-0xf64fffff]: can't claim; no compatible bridge window
[    0.367933] pci 0000:08:00.0: bridge window [mem
0xf6000000-0xf64fffff]: can't claim; no compatible bridge window
[    0.367935] pci 0000:09:04.0: bridge window [mem
0xf6400000-0xf64fffff]: can't claim; no compatible bridge window
[    0.367936] pci 0000:09:05.0: bridge window [mem
0xf6000000-0xf61fffff]: can't claim; no compatible bridge window
[    0.367937] pci 0000:09:0c.0: bridge window [mem
0xf6300000-0xf63fffff]: can't claim; no compatible bridge window
[    0.367938] pci 0000:09:0d.0: bridge window [mem
0xf6200000-0xf62fffff]: can't claim; no compatible bridge window
[    0.367939] pci 0000:06:0c.0: bridge window [mem
0xf6600000-0xf66fffff]: can't claim; no compatible bridge window
[    0.367940] pci 0000:06:0d.0: bridge window [mem
0xf6500000-0xf65fffff]: can't claim; no compatible bridge window
[    0.368183] pci 0000:0c:00.0: BAR 0 [mem 0xf6000000-0xf60fffff]:
can't claim; no compatible bridge window
[    0.368185] pci 0000:0c:00.0: BAR 3 [mem 0xf6100000-0xf6103fff]:
can't claim; no compatible bridge window
[    0.368191] pci 0000:10:00.0: BAR 0 [mem 0xf6300000-0xf6307fff
64bit]: can't claim; no compatible bridge window
[    0.368195] pci 0000:12:00.0: BAR 0 [mem 0xf6600000-0xf6607fff
64bit]: can't claim; no compatible bridge window
[    0.368389] pci 0000:0b:00.0: BAR 0 [mem 0xf6400000-0xf6403fff
64bit]: can't claim; no compatible bridge window
[    0.368401] pci 0000:11:00.0: BAR 5 [mem 0xf6280000-0xf62803ff]:
can't claim; no compatible bridge window
[    0.368404] pci 0000:13:00.0: BAR 5 [mem 0xf6580000-0xf65803ff]:
can't claim; no compatible bridge window
[    0.368414] e820: reserve RAM buffer [mem 0x09aff000-0x0bffffff]
[    0.368415] e820: reserve RAM buffer [mem 0x0a200000-0x0bffffff]
[    0.368416] e820: reserve RAM buffer [mem 0x0b000000-0x0bffffff]
[    0.368417] e820: reserve RAM buffer [mem 0x649ac000-0x67ffffff]
[    0.368417] e820: reserve RAM buffer [mem 0x67998000-0x67ffffff]
[    0.368418] e820: reserve RAM buffer [mem 0x6ad3d000-0x6bffffff]
[    0.368419] e820: reserve RAM buffer [mem 0x79ff9000-0x7bffffff]
[    0.368420] e820: reserve RAM buffer [mem 0x7a000000-0x7bffffff]
[    0.368421] e820: reserve RAM buffer [mem 0x105de80000-0x105fffffff]
[    0.368455] pci 0000:03:00.0: vgaarb: setting as boot VGA device
[    0.368455] pci 0000:03:00.0: vgaarb: bridge control possible
[    0.368455] pci 0000:03:00.0: vgaarb: VGA device added:
decodes=io+mem,owns=none,locks=none
[    0.368455] pci 0000:14:00.0: vgaarb: bridge control possible
[    0.368455] pci 0000:14:00.0: vgaarb: VGA device added:
decodes=io+mem,owns=none,locks=none
[    0.368455] vgaarb: loaded
[    0.368552] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0
[    0.368556] hpet0: 3 comparators, 32-bit 14.318180 MHz counter
[    0.370613] clocksource: Switched to clocksource tsc-early
[    0.370739] VFS: Disk quotas dquot_6.6.0
[    0.370746] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[    0.370759] pnp: PnP ACPI init
[    0.370841] system 00:00: [mem 0xe0000000-0xefffffff] has been reserved
[    0.370912] system 00:01: [mem 0x1060000000-0x107fffffff window]
has been reserved
[    0.371144] system 00:03: [io  0x0290-0x029f] has been reserved
[    0.371146] system 00:03: [io  0x0200-0x023f] has been reserved
[    0.371407] system 00:04: [io  0x04d0-0x04d1] has been reserved
[    0.371409] system 00:04: [io  0x040b] has been reserved
[    0.371411] system 00:04: [io  0x04d6] has been reserved
[    0.371413] system 00:04: [io  0x0c00-0x0c01] has been reserved
[    0.371414] system 00:04: [io  0x0c14] has been reserved
[    0.371416] system 00:04: [io  0x0c50-0x0c51] has been reserved
[    0.371417] system 00:04: [io  0x0c52] has been reserved
[    0.371419] system 00:04: [io  0x0c6c] has been reserved
[    0.371421] system 00:04: [io  0x0c6f] has been reserved
[    0.371422] system 00:04: [io  0x0cd8-0x0cdf] has been reserved
[    0.371424] system 00:04: [io  0x0800-0x089f] has been reserved
[    0.371425] system 00:04: [io  0x0b00-0x0b0f] has been reserved
[    0.371427] system 00:04: [io  0x0b20-0x0b3f] has been reserved
[    0.371428] system 00:04: [io  0x0900-0x090f] has been reserved
[    0.371430] system 00:04: [io  0x0910-0x091f] has been reserved
[    0.371433] system 00:04: [mem 0xfedc0000-0xfedc0fff] has been reserved
[    0.371435] system 00:04: [mem 0xfee00000-0xfee00fff] has been reserved
[    0.371437] system 00:04: [mem 0xfec10000-0xfec10fff] has been reserved
[    0.371439] system 00:04: [mem 0xfeb00000-0xfeb00fff] has been reserved
[    0.371441] system 00:04: [mem 0xff000000-0xffffffff] has been reserved
[    0.372298] pnp: PnP ACPI: found 5 devices
[    0.378037] clocksource: acpi_pm: mask: 0xffffff max_cycles:
0xffffff, max_idle_ns: 2085701024 ns
[    0.378074] NET: Registered PF_INET protocol family
[    0.378146] IP idents hash table entries: 262144 (order: 9, 2097152
bytes, linear)
[    0.387122] tcp_listen_portaddr_hash hash table entries: 32768
(order: 7, 524288 bytes, linear)
[    0.387147] Table-perturb hash table entries: 65536 (order: 6,
262144 bytes, linear)
[    0.387271] TCP established hash table entries: 524288 (order: 10,
4194304 bytes, linear)
[    0.387537] TCP bind hash table entries: 65536 (order: 9, 2097152
bytes, linear)
[    0.387587] TCP: Hash tables configured (established 524288 bind 65536)
[    0.387740] MPTCP token hash table entries: 65536 (order: 8,
1572864 bytes, linear)
[    0.387839] UDP hash table entries: 32768 (order: 9, 2097152 bytes, linear)
[    0.387959] UDP-Lite hash table entries: 32768 (order: 9, 2097152
bytes, linear)
[    0.388059] NET: Registered PF_UNIX/PF_LOCAL protocol family
[    0.388063] NET: Registered PF_XDP protocol family
[    0.388067] pci 0000:11:00.0: ROM [mem 0xf6200000-0xf627ffff pref]:
can't claim; no compatible bridge window
[    0.388069] pci 0000:13:00.0: ROM [mem 0xf6500000-0xf657ffff pref]:
can't claim; no compatible bridge window
[    0.388082] pci 0000:00:02.1: bridge window [mem
0x80000000-0x806fffff]: assigned
[    0.388084] pci 0000:02:00.0: PCI bridge to [bus 03]
[    0.388091] pci 0000:02:00.0:   bridge window [io  0xf000-0xffff]
[    0.388095] pci 0000:02:00.0:   bridge window [mem 0xf6b00000-0xf6cfffff]
[    0.388098] pci 0000:02:00.0:   bridge window [mem
0xf000000000-0xf80fffffff 64bit pref]
[    0.388103] pci 0000:01:00.0: PCI bridge to [bus 02-03]
[    0.388105] pci 0000:01:00.0:   bridge window [io  0xf000-0xffff]
[    0.388110] pci 0000:01:00.0:   bridge window [mem 0xf6b00000-0xf6cfffff]
[    0.388113] pci 0000:01:00.0:   bridge window [mem
0xf000000000-0xf80fffffff 64bit pref]
[    0.388118] pci 0000:00:01.1: PCI bridge to [bus 01-03]
[    0.388119] pci 0000:00:01.1:   bridge window [io  0xf000-0xffff]
[    0.388122] pci 0000:00:01.1:   bridge window [mem 0xf6b00000-0xf6dfffff]
[    0.388124] pci 0000:00:01.1:   bridge window [mem
0xf000000000-0xf80fffffff 64bit pref]
[    0.388134] pci 0000:00:01.2: PCI bridge to [bus 04]
[    0.388137] pci 0000:00:01.2:   bridge window [mem 0xf6f00000-0xf6ffffff]
[    0.388147] pci 0000:05:00.0: bridge window [mem
0x80000000-0x806fffff]: assigned
[    0.388149] pci 0000:06:08.0: bridge window [mem
0x80000000-0x804fffff]: assigned
[    0.388151] pci 0000:06:0c.0: bridge window [mem
0x80500000-0x805fffff]: assigned
[    0.388152] pci 0000:06:0d.0: bridge window [mem
0x80600000-0x806fffff]: assigned
[    0.388153] pci 0000:06:00.0: PCI bridge to [bus 07]
[    0.388165] pci 0000:08:00.0: bridge window [mem
0x80000000-0x804fffff]: assigned
[    0.388167] pci 0000:09:04.0: bridge window [mem
0x80000000-0x800fffff]: assigned
[    0.388168] pci 0000:09:05.0: bridge window [mem
0x80100000-0x802fffff]: assigned
[    0.388169] pci 0000:09:0c.0: bridge window [mem
0x80300000-0x803fffff]: assigned
[    0.388171] pci 0000:09:0d.0: bridge window [mem
0x80400000-0x804fffff]: assigned
[    0.388172] pci 0000:09:00.0: PCI bridge to [bus 0a]
[    0.388182] pci 0000:0b:00.0: BAR 0 [mem 0x80000000-0x80003fff
64bit]: assigned
[    0.388224] pci 0000:09:04.0: PCI bridge to [bus 0b]
[    0.388228] pci 0000:09:04.0:   bridge window [mem 0x80000000-0x800fffff]
[    0.388235] pci 0000:0c:00.0: BAR 0 [mem 0x80100000-0x801fffff]: assigned
[    0.388263] pci 0000:0c:00.0: BAR 3 [mem 0x80200000-0x80203fff]: assigned
[    0.388267] pci 0000:09:05.0: PCI bridge to [bus 0c]
[    0.388271] pci 0000:09:05.0:   bridge window [mem 0x80100000-0x802fffff]
[    0.388278] pci 0000:09:06.0: PCI bridge to [bus 0d]
[    0.388288] pci 0000:09:07.0: PCI bridge to [bus 0e]
[    0.388298] pci 0000:09:08.0: PCI bridge to [bus 0f]
[    0.388308] pci 0000:10:00.0: BAR 0 [mem 0x80300000-0x80307fff
64bit]: assigned
[    0.388316] pci 0000:09:0c.0: PCI bridge to [bus 10]
[    0.388320] pci 0000:09:0c.0:   bridge window [mem 0x80300000-0x803fffff]
[    0.388328] pci 0000:11:00.0: ROM [mem 0x80400000-0x8047ffff pref]: assigned
[    0.388329] pci 0000:11:00.0: BAR 5 [mem 0x80480000-0x804803ff]: assigned
[    0.388332] pci 0000:09:0d.0: PCI bridge to [bus 11]
[    0.388336] pci 0000:09:0d.0:   bridge window [mem 0x80400000-0x804fffff]
[    0.388343] pci 0000:08:00.0: PCI bridge to [bus 09-11]
[    0.388347] pci 0000:08:00.0:   bridge window [mem 0x80000000-0x804fffff]
[    0.388354] pci 0000:06:08.0: PCI bridge to [bus 08-11]
[    0.388357] pci 0000:06:08.0:   bridge window [mem 0x80000000-0x804fffff]
[    0.388362] pci 0000:12:00.0: BAR 0 [mem 0x80500000-0x80507fff
64bit]: assigned
[    0.388367] pci 0000:06:0c.0: PCI bridge to [bus 12]
[    0.388370] pci 0000:06:0c.0:   bridge window [mem 0x80500000-0x805fffff]
[    0.388375] pci 0000:13:00.0: ROM [mem 0x80600000-0x8067ffff pref]: assigned
[    0.388377] pci 0000:13:00.0: BAR 5 [mem 0x80680000-0x806803ff]: assigned
[    0.388379] pci 0000:06:0d.0: PCI bridge to [bus 13]
[    0.388382] pci 0000:06:0d.0:   bridge window [mem 0x80600000-0x806fffff]
[    0.388386] pci 0000:05:00.0: PCI bridge to [bus 06-13]
[    0.388389] pci 0000:05:00.0:   bridge window [mem 0x80000000-0x806fffff]
[    0.388394] pci 0000:00:02.1: PCI bridge to [bus 05-13]
[    0.388396] pci 0000:00:02.1:   bridge window [mem 0x80000000-0x806fffff]
[    0.388408] pci 0000:00:08.1: PCI bridge to [bus 14]
[    0.388413] pci 0000:00:08.1:   bridge window [io  0xe000-0xefff]
[    0.388415] pci 0000:00:08.1:   bridge window [mem 0xf6700000-0xf6afffff]
[    0.388417] pci 0000:00:08.1:   bridge window [mem
0xf820000000-0xf8301fffff 64bit pref]
[    0.388420] pci 0000:00:08.3: PCI bridge to [bus 15]
[    0.388422] pci 0000:00:08.3:   bridge window [mem 0xf6e00000-0xf6efffff]
[    0.388425] pci_bus 0000:00: resource 4 [io  0x0000-0x03af window]
[    0.388426] pci_bus 0000:00: resource 5 [io  0x03e0-0x0cf7 window]
[    0.388428] pci_bus 0000:00: resource 6 [io  0x03b0-0x03df window]
[    0.388429] pci_bus 0000:00: resource 7 [io  0x0d00-0xffff window]
[    0.388430] pci_bus 0000:00: resource 8 [mem 0x000a0000-0x000dffff window]
[    0.388431] pci_bus 0000:00: resource 9 [mem 0x80000000-0xf6ffffff window]
[    0.388432] pci_bus 0000:00: resource 10 [mem
0x1080000000-0xffffffffff window]
[    0.388433] pci_bus 0000:01: resource 0 [io  0xf000-0xffff]
[    0.388434] pci_bus 0000:01: resource 1 [mem 0xf6b00000-0xf6dfffff]
[    0.388435] pci_bus 0000:01: resource 2 [mem
0xf000000000-0xf80fffffff 64bit pref]
[    0.388436] pci_bus 0000:02: resource 0 [io  0xf000-0xffff]
[    0.388437] pci_bus 0000:02: resource 1 [mem 0xf6b00000-0xf6cfffff]
[    0.388439] pci_bus 0000:02: resource 2 [mem
0xf000000000-0xf80fffffff 64bit pref]
[    0.388440] pci_bus 0000:03: resource 0 [io  0xf000-0xffff]
[    0.388441] pci_bus 0000:03: resource 1 [mem 0xf6b00000-0xf6cfffff]
[    0.388442] pci_bus 0000:03: resource 2 [mem
0xf000000000-0xf80fffffff 64bit pref]
[    0.388443] pci_bus 0000:04: resource 1 [mem 0xf6f00000-0xf6ffffff]
[    0.388444] pci_bus 0000:05: resource 1 [mem 0x80000000-0x806fffff]
[    0.388445] pci_bus 0000:06: resource 1 [mem 0x80000000-0x806fffff]
[    0.388446] pci_bus 0000:08: resource 1 [mem 0x80000000-0x804fffff]
[    0.388447] pci_bus 0000:09: resource 1 [mem 0x80000000-0x804fffff]
[    0.388449] pci_bus 0000:0b: resource 1 [mem 0x80000000-0x800fffff]
[    0.388450] pci_bus 0000:0c: resource 1 [mem 0x80100000-0x802fffff]
[    0.388451] pci_bus 0000:10: resource 1 [mem 0x80300000-0x803fffff]
[    0.388452] pci_bus 0000:11: resource 1 [mem 0x80400000-0x804fffff]
[    0.388453] pci_bus 0000:12: resource 1 [mem 0x80500000-0x805fffff]
[    0.388454] pci_bus 0000:13: resource 1 [mem 0x80600000-0x806fffff]
[    0.388455] pci_bus 0000:14: resource 0 [io  0xe000-0xefff]
[    0.388456] pci_bus 0000:14: resource 1 [mem 0xf6700000-0xf6afffff]
[    0.388458] pci_bus 0000:14: resource 2 [mem
0xf820000000-0xf8301fffff 64bit pref]
[    0.388459] pci_bus 0000:15: resource 1 [mem 0xf6e00000-0xf6efffff]
[    0.388594] pci 0000:03:00.1: D0 power state depends on 0000:03:00.0
[    0.389118] pci 0000:14:00.1: D0 power state depends on 0000:14:00.0
[    0.389337] PCI: CLS 64 bytes, default 64
[    0.389354] pci 0000:00:00.2: AMD-Vi: IOMMU performance counters supported
[    0.389382] Trying to unpack rootfs image as initramfs...
[    0.389411] pci 0000:00:00.0: Adding to iommu group 0
[    0.389435] pci 0000:00:01.0: Adding to iommu group 1
[    0.389449] pci 0000:00:01.1: Adding to iommu group 2
[    0.389464] pci 0000:00:01.2: Adding to iommu group 3
[    0.389494] pci 0000:00:02.0: Adding to iommu group 4
[    0.389508] pci 0000:00:02.1: Adding to iommu group 5
[    0.389530] pci 0000:00:03.0: Adding to iommu group 6
[    0.389552] pci 0000:00:04.0: Adding to iommu group 7
[    0.389579] pci 0000:00:08.0: Adding to iommu group 8
[    0.389594] pci 0000:00:08.1: Adding to iommu group 9
[    0.389608] pci 0000:00:08.3: Adding to iommu group 10
[    0.389637] pci 0000:00:14.0: Adding to iommu group 11
[    0.389650] pci 0000:00:14.3: Adding to iommu group 11
[    0.389722] pci 0000:00:18.0: Adding to iommu group 12
[    0.389737] pci 0000:00:18.1: Adding to iommu group 12
[    0.389751] pci 0000:00:18.2: Adding to iommu group 12
[    0.389765] pci 0000:00:18.3: Adding to iommu group 12
[    0.389780] pci 0000:00:18.4: Adding to iommu group 12
[    0.389795] pci 0000:00:18.5: Adding to iommu group 12
[    0.389810] pci 0000:00:18.6: Adding to iommu group 12
[    0.389824] pci 0000:00:18.7: Adding to iommu group 12
[    0.389840] pci 0000:01:00.0: Adding to iommu group 13
[    0.389856] pci 0000:02:00.0: Adding to iommu group 14
[    0.389883] pci 0000:03:00.0: Adding to iommu group 15
[    0.389901] pci 0000:03:00.1: Adding to iommu group 16
[    0.389916] pci 0000:04:00.0: Adding to iommu group 17
[    0.389933] pci 0000:05:00.0: Adding to iommu group 18
[    0.389950] pci 0000:06:00.0: Adding to iommu group 19
[    0.389965] pci 0000:06:08.0: Adding to iommu group 20
[    0.389980] pci 0000:06:0c.0: Adding to iommu group 21
[    0.389995] pci 0000:06:0d.0: Adding to iommu group 22
[    0.390001] pci 0000:08:00.0: Adding to iommu group 20
[    0.390007] pci 0000:09:00.0: Adding to iommu group 20
[    0.390011] pci 0000:09:04.0: Adding to iommu group 20
[    0.390017] pci 0000:09:05.0: Adding to iommu group 20
[    0.390022] pci 0000:09:06.0: Adding to iommu group 20
[    0.390027] pci 0000:09:07.0: Adding to iommu group 20
[    0.390033] pci 0000:09:08.0: Adding to iommu group 20
[    0.390039] pci 0000:09:0c.0: Adding to iommu group 20
[    0.390044] pci 0000:09:0d.0: Adding to iommu group 20
[    0.390049] pci 0000:0b:00.0: Adding to iommu group 20
[    0.390054] pci 0000:0c:00.0: Adding to iommu group 20
[    0.390059] pci 0000:10:00.0: Adding to iommu group 20
[    0.390064] pci 0000:11:00.0: Adding to iommu group 20
[    0.390070] pci 0000:12:00.0: Adding to iommu group 21
[    0.390075] pci 0000:13:00.0: Adding to iommu group 22
[    0.390105] pci 0000:14:00.0: Adding to iommu group 23
[    0.390121] pci 0000:14:00.1: Adding to iommu group 24
[    0.390136] pci 0000:14:00.2: Adding to iommu group 25
[    0.390153] pci 0000:14:00.3: Adding to iommu group 26
[    0.390169] pci 0000:14:00.4: Adding to iommu group 27
[    0.390184] pci 0000:15:00.0: Adding to iommu group 28
[    0.393067] AMD-Vi: Extended features (0x246577efa2254afa, 0x0):
PPR NX GT [5] IA GA PC GA_vAPIC
[    0.393078] AMD-Vi: Interrupt remapping enabled
[    0.417510] AMD-Vi: Virtual APIC enabled
[    0.417525] PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
[    0.417526] software IO TLB: mapped [mem
0x00000000606e3000-0x00000000646e3000] (64MB)
[    0.417570] LVT offset 0 assigned for vector 0x400
[    0.419345] perf: AMD IBS detected (0x00000bff)
[    0.419351] perf/amd_iommu: Detected AMD IOMMU #0 (2 banks, 4 counters/bank).
[    0.424705] Freeing initrd memory: 40688K
[    0.434652] Initialise system trusted keyrings
[    0.434659] Key type blacklist registered
[    0.434691] workingset: timestamp_bits=36 max_order=24 bucket_order=0
[    0.434869] fuse: init (API version 7.44)
[    0.434930] integrity: Platform Keyring initialized
[    0.434931] integrity: Machine keyring initialized
[    0.441363] xor: automatically using best checksumming function   avx
[    0.441365] Key type asymmetric registered
[    0.441366] Asymmetric key parser 'x509' registered
[    0.441377] Block layer SCSI generic (bsg) driver version 0.4
loaded (major 246)
[    0.441414] io scheduler mq-deadline registered
[    0.441415] io scheduler kyber registered
[    0.441423] io scheduler bfq registered
[    0.442552] ledtrig-cpu: registered to indicate activity on CPUs
[    0.442659] pcieport 0000:00:01.1: PME: Signaling with IRQ 27
[    0.442787] pcieport 0000:00:01.2: PME: Signaling with IRQ 28
[    0.442896] pcieport 0000:00:02.1: PME: Signaling with IRQ 29
[    0.443001] pcieport 0000:00:08.1: PME: Signaling with IRQ 30
[    0.443098] pcieport 0000:00:08.3: PME: Signaling with IRQ 31
[    0.445125] input: Power Button as
/devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0C:00/input/input0
[    0.445143] ACPI: button: Power Button [PWRB]
[    0.445170] input: Power Button as
/devices/LNXSYSTM:00/LNXPWRBN:00/input/input1
[    0.445944] ACPI: button: Power Button [PWRF]
[    0.446450] Monitor-Mwait will be used to enter C-1 state
[    0.449106] Estimated ratio of average max frequency by base
frequency (times 1024): 1181
[    0.449297] Serial: 8250/16550 driver, 32 ports, IRQ sharing enabled
[    0.449592] serial8250: ttyS0 at I/O 0x3f8 (irq = 4, base_baud =
115200) is a 16550A
[    0.450983] Non-volatile memory driver v1.3
[    0.450984] Linux agpgart interface v0.103
[    0.451034] ACPI: bus type drm_connector registered
[    0.452425] ahci 0000:11:00.0: enabling device (0000 -> 0002)
[    0.452511] ahci 0000:11:00.0: SSS flag set, parallel bus scan disabled
[    0.452548] ahci 0000:11:00.0: AHCI vers 0001.0301, 32 command
slots, 6 Gbps, SATA mode
[    0.452550] ahci 0000:11:00.0: 4/6 ports implemented (port mask 0xf)
[    0.452551] ahci 0000:11:00.0: flags: 64bit ncq sntf stag pm led
clo only pmp pio slum part sxs deso sadm sds apst
[    0.452880] scsi host0: ahci
[    0.452963] scsi host1: ahci
[    0.453031] scsi host2: ahci
[    0.453101] scsi host3: ahci
[    0.453169] scsi host4: ahci
[    0.453235] scsi host5: ahci
[    0.453266] ata1: SATA max UDMA/133 abar m1024@0x80480000 port
0x80480100 irq 45 lpm-pol 3
[    0.453269] ata2: SATA max UDMA/133 abar m1024@0x80480000 port
0x80480180 irq 45 lpm-pol 3
[    0.453271] ata3: SATA max UDMA/133 abar m1024@0x80480000 port
0x80480200 irq 45 lpm-pol 3
[    0.453273] ata4: SATA max UDMA/133 abar m1024@0x80480000 port
0x80480280 irq 45 lpm-pol 3
[    0.453273] ata5: DUMMY
[    0.453274] ata6: DUMMY
[    0.453287] ahci 0000:13:00.0: enabling device (0000 -> 0002)
[    0.453357] ahci 0000:13:00.0: SSS flag set, parallel bus scan disabled
[    0.453381] ahci 0000:13:00.0: AHCI vers 0001.0301, 32 command
slots, 6 Gbps, SATA mode
[    0.453382] ahci 0000:13:00.0: 4/6 ports implemented (port mask 0xf)
[    0.453383] ahci 0000:13:00.0: flags: 64bit ncq sntf stag pm led
clo only pmp pio slum part sxs deso sadm sds apst
[    0.453693] scsi host6: ahci
[    0.453762] scsi host7: ahci
[    0.453831] scsi host8: ahci
[    0.453898] scsi host9: ahci
[    0.453968] scsi host10: ahci
[    0.454036] scsi host11: ahci
[    0.454065] ata7: SATA max UDMA/133 abar m1024@0x80680000 port
0x80680100 irq 46 lpm-pol 3
[    0.454066] ata8: SATA max UDMA/133 abar m1024@0x80680000 port
0x80680180 irq 46 lpm-pol 3
[    0.454068] ata9: SATA max UDMA/133 abar m1024@0x80680000 port
0x80680200 irq 46 lpm-pol 3
[    0.454069] ata10: SATA max UDMA/133 abar m1024@0x80680000 port
0x80680280 irq 46 lpm-pol 3
[    0.454070] ata11: DUMMY
[    0.454071] ata12: DUMMY
[    0.454181] xhci_hcd 0000:10:00.0: xHCI Host Controller
[    0.454185] xhci_hcd 0000:10:00.0: new USB bus registered, assigned
bus number 1
[    0.510180] xhci_hcd 0000:10:00.0: hcc params 0x0200ef81 hci
version 0x110 quirks 0x0000000200000010
[    0.510467] xhci_hcd 0000:10:00.0: xHCI Host Controller
[    0.510469] xhci_hcd 0000:10:00.0: new USB bus registered, assigned
bus number 2
[    0.510472] xhci_hcd 0000:10:00.0: Host supports USB 3.2 Enhanced SuperSpeed
[    0.511136] usb usb1: New USB device found, idVendor=1d6b,
idProduct=0002, bcdDevice= 6.16
[    0.511138] usb usb1: New USB device strings: Mfr=3, Product=2,
SerialNumber=1
[    0.511139] usb usb1: Product: xHCI Host Controller
[    0.511140] usb usb1: Manufacturer: Linux 6.16.8-arch1-1 xhci-hcd
[    0.511141] usb usb1: SerialNumber: 0000:10:00.0
[    0.511230] hub 1-0:1.0: USB hub found
[    0.511250] hub 1-0:1.0: 12 ports detected
[    0.513872] usb usb2: We don't know the algorithms for LPM for this
host, disabling LPM.
[    0.513887] usb usb2: New USB device found, idVendor=1d6b,
idProduct=0003, bcdDevice= 6.16
[    0.513888] usb usb2: New USB device strings: Mfr=3, Product=2,
SerialNumber=1
[    0.513889] usb usb2: Product: xHCI Host Controller
[    0.513890] usb usb2: Manufacturer: Linux 6.16.8-arch1-1 xhci-hcd
[    0.513891] usb usb2: SerialNumber: 0000:10:00.0
[    0.513948] hub 2-0:1.0: USB hub found
[    0.513960] hub 2-0:1.0: 5 ports detected
[    0.515155] xhci_hcd 0000:12:00.0: xHCI Host Controller
[    0.515158] xhci_hcd 0000:12:00.0: new USB bus registered, assigned
bus number 3
[    0.571124] xhci_hcd 0000:12:00.0: hcc params 0x0200ef81 hci
version 0x110 quirks 0x0000000200000010
[    0.571370] xhci_hcd 0000:12:00.0: xHCI Host Controller
[    0.571372] xhci_hcd 0000:12:00.0: new USB bus registered, assigned
bus number 4
[    0.571374] xhci_hcd 0000:12:00.0: Host supports USB 3.2 Enhanced SuperSpeed
[    0.572099] usb usb3: New USB device found, idVendor=1d6b,
idProduct=0002, bcdDevice= 6.16
[    0.572101] usb usb3: New USB device strings: Mfr=3, Product=2,
SerialNumber=1
[    0.572102] usb usb3: Product: xHCI Host Controller
[    0.572103] usb usb3: Manufacturer: Linux 6.16.8-arch1-1 xhci-hcd
[    0.572104] usb usb3: SerialNumber: 0000:12:00.0
[    0.572187] hub 3-0:1.0: USB hub found
[    0.572203] hub 3-0:1.0: 12 ports detected
[    0.574968] usb usb4: We don't know the algorithms for LPM for this
host, disabling LPM.
[    0.574982] usb usb4: New USB device found, idVendor=1d6b,
idProduct=0003, bcdDevice= 6.16
[    0.574984] usb usb4: New USB device strings: Mfr=3, Product=2,
SerialNumber=1
[    0.574985] usb usb4: Product: xHCI Host Controller
[    0.574986] usb usb4: Manufacturer: Linux 6.16.8-arch1-1 xhci-hcd
[    0.574987] usb usb4: SerialNumber: 0000:12:00.0
[    0.575041] hub 4-0:1.0: USB hub found
[    0.575047] hub 4-0:1.0: 5 ports detected
[    0.576263] xhci_hcd 0000:14:00.3: xHCI Host Controller
[    0.576267] xhci_hcd 0000:14:00.3: new USB bus registered, assigned
bus number 5
[    0.576597] xhci_hcd 0000:14:00.3: hcc params 0x0120ffc5 hci
version 0x120 quirks 0x0000000200000010
[    0.576812] xhci_hcd 0000:14:00.3: xHCI Host Controller
[    0.576814] xhci_hcd 0000:14:00.3: new USB bus registered, assigned
bus number 6
[    0.576815] xhci_hcd 0000:14:00.3: Host supports USB 3.1 Enhanced SuperSpeed
[    0.576837] usb usb5: New USB device found, idVendor=1d6b,
idProduct=0002, bcdDevice= 6.16
[    0.576838] usb usb5: New USB device strings: Mfr=3, Product=2,
SerialNumber=1
[    0.576839] usb usb5: Product: xHCI Host Controller
[    0.576840] usb usb5: Manufacturer: Linux 6.16.8-arch1-1 xhci-hcd
[    0.576841] usb usb5: SerialNumber: 0000:14:00.3
[    0.576902] hub 5-0:1.0: USB hub found
[    0.576907] hub 5-0:1.0: 2 ports detected
[    0.577470] usb usb6: We don't know the algorithms for LPM for this
host, disabling LPM.
[    0.577484] usb usb6: New USB device found, idVendor=1d6b,
idProduct=0003, bcdDevice= 6.16
[    0.577485] usb usb6: New USB device strings: Mfr=3, Product=2,
SerialNumber=1
[    0.577486] usb usb6: Product: xHCI Host Controller
[    0.577488] usb usb6: Manufacturer: Linux 6.16.8-arch1-1 xhci-hcd
[    0.577489] usb usb6: SerialNumber: 0000:14:00.3
[    0.577545] hub 6-0:1.0: USB hub found
[    0.577549] hub 6-0:1.0: 2 ports detected
[    0.578139] xhci_hcd 0000:14:00.4: xHCI Host Controller
[    0.578142] xhci_hcd 0000:14:00.4: new USB bus registered, assigned
bus number 7
[    0.578501] xhci_hcd 0000:14:00.4: hcc params 0x0120ffc5 hci
version 0x120 quirks 0x0000000200000010
[    0.578699] xhci_hcd 0000:14:00.4: xHCI Host Controller
[    0.578701] xhci_hcd 0000:14:00.4: new USB bus registered, assigned
bus number 8
[    0.578703] xhci_hcd 0000:14:00.4: Host supports USB 3.1 Enhanced SuperSpeed
[    0.578724] usb usb7: New USB device found, idVendor=1d6b,
idProduct=0002, bcdDevice= 6.16
[    0.578725] usb usb7: New USB device strings: Mfr=3, Product=2,
SerialNumber=1
[    0.578726] usb usb7: Product: xHCI Host Controller
[    0.578727] usb usb7: Manufacturer: Linux 6.16.8-arch1-1 xhci-hcd
[    0.578728] usb usb7: SerialNumber: 0000:14:00.4
[    0.578786] hub 7-0:1.0: USB hub found
[    0.578790] hub 7-0:1.0: 2 ports detected
[    0.579305] usb usb8: We don't know the algorithms for LPM for this
host, disabling LPM.
[    0.579319] usb usb8: New USB device found, idVendor=1d6b,
idProduct=0003, bcdDevice= 6.16
[    0.579320] usb usb8: New USB device strings: Mfr=3, Product=2,
SerialNumber=1
[    0.579321] usb usb8: Product: xHCI Host Controller
[    0.579322] usb usb8: Manufacturer: Linux 6.16.8-arch1-1 xhci-hcd
[    0.579323] usb usb8: SerialNumber: 0000:14:00.4
[    0.579391] hub 8-0:1.0: USB hub found
[    0.579399] hub 8-0:1.0: 2 ports detected
[    0.579936] xhci_hcd 0000:15:00.0: xHCI Host Controller
[    0.579939] xhci_hcd 0000:15:00.0: new USB bus registered, assigned
bus number 9
[    0.581198] xhci_hcd 0000:15:00.0: USB3 root hub has no ports
[    0.581212] xhci_hcd 0000:15:00.0: hcc params 0x0110ffc5 hci
version 0x120 quirks 0x0000000200000010
[    0.581440] xhci_hcd 0000:15:00.0: xHCI Host Controller
[    0.581441] xhci_hcd 0000:15:00.0: new USB bus registered, assigned
bus number 10
[    0.581443] xhci_hcd 0000:15:00.0: Host supports USB 3.0 SuperSpeed
[    0.581471] usb usb9: New USB device found, idVendor=1d6b,
idProduct=0002, bcdDevice= 6.16
[    0.581472] usb usb9: New USB device strings: Mfr=3, Product=2,
SerialNumber=1
[    0.581473] usb usb9: Product: xHCI Host Controller
[    0.581474] usb usb9: Manufacturer: Linux 6.16.8-arch1-1 xhci-hcd
[    0.581475] usb usb9: SerialNumber: 0000:15:00.0
[    0.581536] hub 9-0:1.0: USB hub found
[    0.581540] hub 9-0:1.0: 1 port detected
[    0.581778] usb usb10: We don't know the algorithms for LPM for
this host, disabling LPM.
[    0.581792] usb usb10: New USB device found, idVendor=1d6b,
idProduct=0003, bcdDevice= 6.16
[    0.581793] usb usb10: New USB device strings: Mfr=3, Product=2,
SerialNumber=1
[    0.581794] usb usb10: Product: xHCI Host Controller
[    0.581795] usb usb10: Manufacturer: Linux 6.16.8-arch1-1 xhci-hcd
[    0.581796] usb usb10: SerialNumber: 0000:15:00.0
[    0.581854] hub 10-0:1.0: USB hub found
[    0.581857] hub 10-0:1.0: config failed, hub doesn't have any
ports! (err -19)
[    0.581897] usbcore: registered new interface driver usbserial_generic
[    0.581901] usbserial: USB Serial support registered for generic
[    0.581922] i8042: PNP: No PS/2 controller found.
[    0.581981] rtc_cmos 00:02: RTC can wake from S4
[    0.582142] rtc_cmos 00:02: registered as rtc0
[    0.582166] rtc_cmos 00:02: setting system clock to
2025-09-22T06:53:55 UTC (1758524035)
[    0.582184] rtc_cmos 00:02: alarms up to one month, y3k, 114 bytes nvram
[    0.583903] simple-framebuffer simple-framebuffer.0: [drm]
Registered 1 planes with drm panic
[    0.583905] [drm] Initialized simpledrm 1.0.0 for
simple-framebuffer.0 on minor 0
[    0.588657] fbcon: Deferring console take-over
[    0.588658] simple-framebuffer simple-framebuffer.0: [drm] fb0:
simpledrmdrmfb frame buffer device
[    0.588690] hid: raw HID events driver (C) Jiri Kosina
[    0.588708] usbcore: registered new interface driver usbhid
[    0.588709] usbhid: USB HID core driver
[    0.588761] drop_monitor: Initializing network drop monitor service
[    0.588829] NET: Registered PF_INET6 protocol family
[    0.592254] Segment Routing with IPv6
[    0.592255] RPL Segment Routing with IPv6
[    0.592260] In-situ OAM (IOAM) with IPv6
[    0.592273] NET: Registered PF_PACKET protocol family
[    0.593765] x86/amd: Previous system reset reason [0x00200800]:
ACPI power state transition occurred
[    0.593769] microcode: Current revision: 0x0a60120c
[    0.594171] resctrl: L3 allocation detected
[    0.594172] resctrl: MB allocation detected
[    0.594173] resctrl: SMBA allocation detected
[    0.594174] resctrl: L3 monitoring detected
[    0.594197] IPI shorthand broadcast: enabled
[    0.596108] sched_clock: Marking stable (594766005,
1307714)->(652184140, -56110421)
[    0.596246] registered taskstats version 1
[    0.596821] Loading compiled-in X.509 certificates
[    0.600097] Loaded X.509 cert 'Build time autogenerated kernel key:
7a4ab88bc73f4690a20fdd72926430918eba5009'
[    0.602371] zswap: loaded using pool zstd/zsmalloc
[    0.602416] Demotion targets for Node 0: null
[    0.602549] Key type .fscrypt registered
[    0.602550] Key type fscrypt-provisioning registered
[    0.602916] Btrfs loaded, zoned=yes, fsverity=yes
[    0.602938] Key type big_key registered
[    0.602993] integrity: Loading X.509 certificate: UEFI:db
[    0.604850] integrity: Loaded X.509 cert 'ASUSTeK MotherBoard SW
Key Certificate: da83b990422ebc8c441f8d8b039a65a2'
[    0.604851] integrity: Loading X.509 certificate: UEFI:db
[    0.604924] integrity: Loaded X.509 cert 'ASUSTeK Notebook SW Key
Certificate: b8e581e4df77a5bb4282d5ccfc00c071'
[    0.604925] integrity: Loading X.509 certificate: UEFI:db
[    0.604932] integrity: Loaded X.509 cert 'Microsoft Corporation
UEFI CA 2011: 13adbf4309bd82709c8cd54f316ed522988a1bd4'
[    0.604933] integrity: Loading X.509 certificate: UEFI:db
[    0.604942] integrity: Loaded X.509 cert 'Microsoft Windows
Production PCA 2011: a92902398e16c49778cd90f99e4f9ae17c55af53'
[    0.604943] integrity: Loading X.509 certificate: UEFI:db
[    0.605015] integrity: Loaded X.509 cert 'Canonical Ltd. Master
Certificate Authority: ad91990bc22ab1f517048c23b6655a268e345a63'
[    0.605016] integrity: Loading X.509 certificate: UEFI:db
[    0.605022] integrity: Loaded X.509 cert 'Microsoft UEFI CA 2023:
81aa6b3244c935bce0d6628af39827421e32497d'
[    0.605022] integrity: Loading X.509 certificate: UEFI:db
[    0.605029] integrity: Loaded X.509 cert 'Microsoft Option ROM UEFI
CA 2023: 514fbf937fa46fb57bf07af8bed84b3b864b1711'
[    0.605968] PM:   Magic number: 9:645:873
[    0.606580] RAS: Correctable Errors collector initialized.
[    0.609167] clk: Disabling unused clocks
[    0.609169] PM: genpd: Disabling unused power domains
[    0.761583] ata7: SATA link down (SStatus 0 SControl 300)
[    0.762146] ata1: SATA link down (SStatus 0 SControl 300)
[    0.809218] usb 1-2: new low-speed USB device number 2 using xhci_hcd
[    0.873053] usb 3-3: new full-speed USB device number 2 using xhci_hcd
[    1.074228] ata2: SATA link down (SStatus 0 SControl 300)
[    1.104803] usb 1-2: New USB device found, idVendor=18f8,
idProduct=0f99, bcdDevice= 1.00
[    1.104807] usb 1-2: New USB device strings: Mfr=0, Product=1, SerialNumber=0
[    1.104809] usb 1-2: Product: USB OPTICAL MOUSE
[    1.128669] input: USB OPTICAL MOUSE  as
/devices/pci0000:00/0000:00:02.1/0000:05:00.0/0000:06:08.0/0000:08:00.0/0000:09:0c.0/0000:10:00.0/usb1/1-2/1-2:1.0/0003:18F8:0F99.0001/input/input2
[    1.128708] hid-generic 0003:18F8:0F99.0001: input,hidraw0: USB HID
v1.10 Mouse [USB OPTICAL MOUSE ] on usb-0000:10:00.0-2/input0
[    1.147802] input: USB OPTICAL MOUSE  Keyboard as
/devices/pci0000:00/0000:00:02.1/0000:05:00.0/0000:06:08.0/0000:08:00.0/0000:09:0c.0/0000:10:00.0/usb1/1-2/1-2:1.1/0003:18F8:0F99.0002/input/input3
[    1.193579] usb 2-1: new SuperSpeed USB device number 2 using xhci_hcd
[    1.198541] hid-generic 0003:18F8:0F99.0002:
input,hiddev96,hidraw1: USB HID v1.10 Keyboard [USB OPTICAL MOUSE ] on
usb-0000:10:00.0-2/input1
[    1.208207] usb 2-1: New USB device found, idVendor=0bda,
idProduct=8153, bcdDevice=31.00
[    1.208209] usb 2-1: New USB device strings: Mfr=1, Product=2, SerialNumber=6
[    1.208211] usb 2-1: Product: USB 10/100/1000 LAN
[    1.208212] usb 2-1: Manufacturer: Realtek
[    1.208213] usb 2-1: SerialNumber: 001000001
[    1.248637] usb 3-3: New USB device found, idVendor=1532,
idProduct=0533, bcdDevice= 0.04
[    1.248642] usb 3-3: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[    1.248644] usb 3-3: Product: Razer Kraken V3 HyperSense
[    1.248646] usb 3-3: Manufacturer: Razer
[    1.248648] usb 3-3: SerialNumber: 000000000001
[    1.258076] usb 4-5: new SuperSpeed Plus Gen 2x1 USB device number
2 using xhci_hcd
[    1.270732] input: Razer Razer Kraken V3 HyperSense Consumer
Control as /devices/pci0000:00/0000:00:02.1/0000:05:00.0/0000:06:0c.0/0000:12:00.0/usb3/3-3/3-3:1.3/0003:1532:0533.0003/input/input5
[    1.272594] usb 4-5: New USB device found, idVendor=05e3,
idProduct=0625, bcdDevice=70.31
[    1.272597] usb 4-5: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[    1.272599] usb 4-5: Product: USB3.2 Hub
[    1.272600] usb 4-5: Manufacturer: GenesysLogic
[    1.279054] hub 4-5:1.0: USB hub found
[    1.279333] hub 4-5:1.0: 4 ports detected
[    1.321524] hid-generic 0003:1532:0533.0003:
input,hiddev97,hidraw2: USB HID v1.11 Device [Razer Razer Kraken V3
HyperSense] on usb-0000:12:00.0-3/input3
[    1.379356] usb 1-4: new full-speed USB device number 3 using xhci_hcd
[    1.388451] ata3: SATA link down (SStatus 0 SControl 300)
[    1.427355] tsc: Refined TSC clocksource calibration: 4499.982 MHz
[    1.427366] clocksource: tsc: mask: 0xffffffffffffffff max_cycles:
0x40dd574b308, max_idle_ns: 440795285901 ns
[    1.427420] clocksource: Switched to clocksource tsc
[    1.494710] usb 3-5: new high-speed USB device number 3 using xhci_hcd
[    1.701184] ata4: SATA link down (SStatus 0 SControl 300)
[    1.715881] usb 3-5: New USB device found, idVendor=05e3,
idProduct=0610, bcdDevice=70.31
[    1.715887] usb 3-5: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[    1.715890] usb 3-5: Product: USB2.1 Hub
[    1.715892] usb 3-5: Manufacturer: GenesysLogic
[    1.726303] hub 3-5:1.0: USB hub found
[    1.729871] hub 3-5:1.0: 4 ports detected
[    1.744733] usb 1-4: New USB device found, idVendor=1038,
idProduct=1607, bcdDevice= 0.12
[    1.744739] usb 1-4: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[    1.744741] usb 1-4: Product: SteelSeries Apex M500 Gaming Keyboard
[    1.744743] usb 1-4: Manufacturer: SteelSeries
[    1.772763] input: SteelSeries SteelSeries Apex M500 Gaming
Keyboard as /devices/pci0000:00/0000:00:02.1/0000:05:00.0/0000:06:08.0/0000:08:00.0/0000:09:0c.0/0000:10:00.0/usb1/1-4/1-4:1.0/0003:1038:1607.0004/input/input6
[    1.823620] hid-generic 0003:1038:1607.0004: input,hidraw3: USB HID
v1.11 Keyboard [SteelSeries SteelSeries Apex M500 Gaming Keyboard] on
usb-0000:10:00.0-4/input0
[    1.827733] hid-generic 0003:1038:1607.0005: hiddev98,hidraw4: USB
HID v1.11 Device [SteelSeries SteelSeries Apex M500 Gaming Keyboard]
on usb-0000:10:00.0-4/input1
[    1.832816] input: SteelSeries SteelSeries Apex M500 Gaming
Keyboard as /devices/pci0000:00/0000:00:02.1/0000:05:00.0/0000:06:08.0/0000:08:00.0/0000:09:0c.0/0000:10:00.0/usb1/1-4/1-4:1.2/0003:1038:1607.0006/input/input7
[    1.883855] hid-generic 0003:1038:1607.0006: input,hidraw5: USB HID
v1.11 Device [SteelSeries SteelSeries Apex M500 Gaming Keyboard] on
usb-0000:10:00.0-4/input2
[    1.887709] input: SteelSeries SteelSeries Apex M500 Gaming
Keyboard as /devices/pci0000:00/0000:00:02.1/0000:05:00.0/0000:06:08.0/0000:08:00.0/0000:09:0c.0/0000:10:00.0/usb1/1-4/1-4:1.3/0003:1038:1607.0007/input/input8
[    1.934716] usb 3-6: new high-speed USB device number 4 using xhci_hcd
[    1.938993] hid-generic 0003:1038:1607.0007: input,hidraw6: USB HID
v1.11 Keyboard [SteelSeries SteelSeries Apex M500 Gaming Keyboard] on
usb-0000:10:00.0-4/input3
[    2.012519] ata8: SATA link down (SStatus 0 SControl 300)
[    2.111733] usb 1-9: new full-speed USB device number 4 using xhci_hcd
[    2.320885] ata9: SATA link down (SStatus 0 SControl 300)
[    2.486780] usb 1-9: New USB device found, idVendor=8087,
idProduct=0032, bcdDevice= 0.00
[    2.486786] usb 1-9: New USB device strings: Mfr=0, Product=0, SerialNumber=0
[    2.624769] ata10: SATA link down (SStatus 0 SControl 300)
[    2.625738] Freeing unused decrypted memory: 2028K
[    2.626106] Freeing unused kernel image (initmem) memory: 4664K
[    2.626114] Write protecting the kernel read-only data: 38912k
[    2.626353] Freeing unused kernel image (text/rodata gap) memory: 608K
[    2.626542] Freeing unused kernel image (rodata/data gap) memory: 1756K
[    2.659563] x86/mm: Checked W+X mappings: passed, no W+X pages found.
[    2.659567] rodata_test: all tests were successful
[    2.659571] Run /init as init process
[    2.659572]   with arguments:
[    2.659573]     /init
[    2.659574]   with environment:
[    2.659575]     HOME=/
[    2.659575]     TERM=linux
[    2.659576]     BOOT_IMAGE=/vmlinuz-linux
[    2.917049] Key type psk registered
[    2.924337] ACPI: video: Video Device [VGA] (multi-head: yes  rom:
no  post: no)
[    2.924636] input: Video Bus as
/devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/device:20/LNXVIDEO:00/input/input9
[    2.929144] nvme nvme0: pci function 0000:04:00.0
[    2.941750] nvme nvme0: D3 entry latency set to 10 seconds
[    2.948528] nvme nvme0: 32/0/0 default/read/poll queues
[    2.951783]  nvme0n1: p1 p2 p3
[    4.109079] [drm] amdgpu kernel modesetting enabled.
[    4.109098] amdgpu: vga_switcheroo: detected switching method
\_SB_.PCI0.GP17.VGA_.ATPX handle
[    4.109239] amdgpu: ATPX version 1, functions 0x00000000
[    4.117527] amdgpu: Virtual CRAT table created for CPU
[    4.117537] amdgpu: Topology: Add CPU node
[    4.117603] amdgpu 0000:03:00.0: enabling device (0006 -> 0007)
[    4.117636] [drm] initializing kernel modesetting (IP DISCOVERY
0x1002:0x744C 0x1849:0x5302 0xC8).
[    4.117644] [drm] register mmio base: 0xF6B00000
[    4.117645] [drm] register mmio size: 1048576
[    4.122708] amdgpu 0000:03:00.0: amdgpu: detected ip block number 0
<soc21_common>
[    4.122709] amdgpu 0000:03:00.0: amdgpu: detected ip block number 1
<gmc_v11_0>
[    4.122710] amdgpu 0000:03:00.0: amdgpu: detected ip block number 2 <ih_v6_0>
[    4.122712] amdgpu 0000:03:00.0: amdgpu: detected ip block number 3 <psp>
[    4.122713] amdgpu 0000:03:00.0: amdgpu: detected ip block number 4 <smu>
[    4.122714] amdgpu 0000:03:00.0: amdgpu: detected ip block number 5 <dm>
[    4.122715] amdgpu 0000:03:00.0: amdgpu: detected ip block number 6
<gfx_v11_0>
[    4.122716] amdgpu 0000:03:00.0: amdgpu: detected ip block number 7
<sdma_v6_0>
[    4.122718] amdgpu 0000:03:00.0: amdgpu: detected ip block number 8
<vcn_v4_0>
[    4.122719] amdgpu 0000:03:00.0: amdgpu: detected ip block number 9
<jpeg_v4_0>
[    4.122720] amdgpu 0000:03:00.0: amdgpu: detected ip block number
10 <mes_v11_0>
[    4.122732] amdgpu 0000:03:00.0: amdgpu: Fetched VBIOS from VFCT
[    4.122734] amdgpu: ATOM BIOS: 113-D70201-810008
[    4.124424] amdgpu 0000:03:00.0: amdgpu: CP RS64 enable
[    4.162136] amdgpu 0000:03:00.0: vgaarb: deactivate vga console
[    4.162139] amdgpu 0000:03:00.0: amdgpu: Trusted Memory Zone (TMZ)
feature not supported
[    4.162164] amdgpu 0000:03:00.0: amdgpu: MEM ECC is not presented.
[    4.162165] amdgpu 0000:03:00.0: amdgpu: SRAM ECC is not presented.
[    4.162214] [drm] vm size is 262144 GB, 4 levels, block size is
9-bit, fragment size is 9-bit
[    4.162219] amdgpu 0000:03:00.0: amdgpu: VRAM: 24560M
0x0000008000000000 - 0x00000085FEFFFFFF (24560M used)
[    4.162221] amdgpu 0000:03:00.0: amdgpu: GART: 512M
0x00007FFF00000000 - 0x00007FFF1FFFFFFF
[    4.162228] [drm] Detected VRAM RAM=24560M, BAR=32768M
[    4.162228] [drm] RAM width 384bits GDDR6
[    4.162342] [drm] amdgpu: 24560M of VRAM memory ready
[    4.162344] [drm] amdgpu: 31717M of GTT memory ready.
[    4.162355] [drm] GART: num cpu pages 131072, num gpu pages 131072
[    4.162442] [drm] PCIE GART of 512M enabled (table at 0x00000085FEB00000).
[    4.162873] amdgpu 0000:03:00.0: amdgpu: [drm] Loading DMUB
firmware via PSP: version=0x07002F00
[    4.163056] amdgpu 0000:03:00.0: amdgpu: Found VCN firmware Version
ENC: 1.24 DEC: 9 VEP: 0 Revision: 22
[    4.163303] amdgpu 0000:03:00.0: amdgpu: Found VCN firmware Version
ENC: 1.24 DEC: 9 VEP: 0 Revision: 22
[    4.234340] amdgpu 0000:03:00.0: amdgpu: reserve 0x1300000 from
0x85fc000000 for PSP TMR
[    4.295780] usb 3-6: New USB device found, idVendor=0b05,
idProduct=1a52, bcdDevice= 0.03
[    4.295785] usb 3-6: New USB device strings: Mfr=3, Product=1, SerialNumber=0
[    4.295787] usb 3-6: Product: USB Audio
[    4.295789] usb 3-6: Manufacturer: Generic
[    4.362945] hid-generic 0003:0B05:1A52.0008: hiddev99,hidraw7: USB
HID v1.11 Device [Generic USB Audio] on usb-0000:12:00.0-6/input7
[    4.383752] amdgpu 0000:03:00.0: amdgpu: RAP: optional rap ta ucode
is not available
[    4.383754] amdgpu 0000:03:00.0: amdgpu: SECUREDISPLAY: optional
securedisplay ta ucode is not available
[    4.383827] amdgpu 0000:03:00.0: amdgpu: smu driver if version =
0x0000003d, smu fw if version = 0x00000040, smu fw program = 0, smu fw
version = 0x004e8200 (78.130.0)
[    4.383828] amdgpu 0000:03:00.0: amdgpu: SMU driver if version not matched
[    4.535313] usb 3-7: new full-speed USB device number 5 using xhci_hcd
[    4.711962] amdgpu 0000:03:00.0: amdgpu: SMU is initialized successfully!
[    4.712271] amdgpu 0000:03:00.0: amdgpu: [drm] Display Core
v3.2.334 initialized on DCN 3.2
[    4.712273] amdgpu 0000:03:00.0: amdgpu: [drm] DP-HDMI FRL PCON supported
[    4.714188] amdgpu 0000:03:00.0: amdgpu: [drm] DMUB hardware
initialized: version=0x07002F00
[    4.784990] amdgpu 0000:03:00.0: amdgpu: [drm] PSR support 0, DC
PSR ver -1, sink PSR ver 0 DPCD caps 0x0 su_y_granularity 0
[    4.785192] amdgpu 0000:03:00.0: amdgpu: [drm] PSR support 0, DC
PSR ver -1, sink PSR ver 0 DPCD caps 0x0 su_y_granularity 0
[    4.917559] usb 3-7: config 1 has an invalid interface number: 2 but max is 1
[    4.917564] usb 3-7: config 1 has no interface number 1
[    4.929549] usb 3-7: New USB device found, idVendor=0b05,
idProduct=19af, bcdDevice= 1.00
[    4.929553] usb 3-7: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[    4.929555] usb 3-7: Product: AURA LED Controller
[    4.929556] usb 3-7: Manufacturer: AsusTek Computer Inc.
[    4.929557] usb 3-7: SerialNumber: 9876543210
[    4.946568] hid-generic 0003:0B05:19AF.0009: hiddev100,hidraw8: USB
HID v1.11 Device [AsusTek Computer Inc. AURA LED Controller] on
usb-0000:12:00.0-7/input2
[    4.998648] amdgpu 0000:03:00.0: amdgpu: [drm] PSR support 0, DC
PSR ver -1, sink PSR ver 0 DPCD caps 0x0 su_y_granularity 0
[    4.998724] amdgpu 0000:03:00.0: amdgpu: [drm] PSR support 0, DC
PSR ver -1, sink PSR ver 0 DPCD caps 0x0 su_y_granularity 0
[    5.069494] amdgpu: HMM registered 24560MB device memory
[    5.071027] kfd kfd: amdgpu: Allocated 3969056 bytes on gart
[    5.071037] kfd kfd: amdgpu: Total number of KFD nodes to be created: 1
[    5.071071] amdgpu: Virtual CRAT table created for GPU
[    5.071299] amdgpu: Topology: Add dGPU node [0x744c:0x1002]
[    5.071301] kfd kfd: amdgpu: added device 1002:744c
[    5.071319] amdgpu 0000:03:00.0: amdgpu: SE 6, SH per SE 2, CU per
SH 8, active_cu_number 96
[    5.071323] amdgpu 0000:03:00.0: amdgpu: ring gfx_0.0.0 uses VM inv
eng 0 on hub 0
[    5.071324] amdgpu 0000:03:00.0: amdgpu: ring comp_1.0.0 uses VM
inv eng 1 on hub 0
[    5.071326] amdgpu 0000:03:00.0: amdgpu: ring comp_1.1.0 uses VM
inv eng 4 on hub 0
[    5.071327] amdgpu 0000:03:00.0: amdgpu: ring comp_1.2.0 uses VM
inv eng 6 on hub 0
[    5.071328] amdgpu 0000:03:00.0: amdgpu: ring comp_1.3.0 uses VM
inv eng 7 on hub 0
[    5.071329] amdgpu 0000:03:00.0: amdgpu: ring comp_1.0.1 uses VM
inv eng 8 on hub 0
[    5.071330] amdgpu 0000:03:00.0: amdgpu: ring comp_1.1.1 uses VM
inv eng 9 on hub 0
[    5.071331] amdgpu 0000:03:00.0: amdgpu: ring comp_1.2.1 uses VM
inv eng 10 on hub 0
[    5.071332] amdgpu 0000:03:00.0: amdgpu: ring comp_1.3.1 uses VM
inv eng 11 on hub 0
[    5.071333] amdgpu 0000:03:00.0: amdgpu: ring sdma0 uses VM inv eng
12 on hub 0
[    5.071334] amdgpu 0000:03:00.0: amdgpu: ring sdma1 uses VM inv eng
13 on hub 0
[    5.071335] amdgpu 0000:03:00.0: amdgpu: ring vcn_unified_0 uses VM
inv eng 0 on hub 8
[    5.071336] amdgpu 0000:03:00.0: amdgpu: ring vcn_unified_1 uses VM
inv eng 1 on hub 8
[    5.071338] amdgpu 0000:03:00.0: amdgpu: ring jpeg_dec uses VM inv
eng 4 on hub 8
[    5.071339] amdgpu 0000:03:00.0: amdgpu: ring mes_kiq_3.1.0 uses VM
inv eng 14 on hub 0
[    5.073023] amdgpu 0000:03:00.0: amdgpu: Using BACO for runtime pm
[    5.073356] amdgpu 0000:03:00.0: [drm] Registered 4 planes with drm panic
[    5.073357] [drm] Initialized amdgpu 3.64.0 for 0000:03:00.0 on minor 1
[    5.079112] fbcon: amdgpudrmfb (fb0) is primary device
[    5.079114] fbcon: Deferring console take-over
[    5.079115] amdgpu 0000:03:00.0: [drm] fb0: amdgpudrmfb frame buffer device
[    5.097841] amdgpu 0000:14:00.0: enabling device (0006 -> 0007)
[    5.097896] [drm] initializing kernel modesetting (IP DISCOVERY
0x1002:0x164E 0x1043:0x8877 0xC1).
[    5.097910] [drm] register mmio base: 0xF6A00000
[    5.097911] [drm] register mmio size: 524288
[    5.099751] amdgpu 0000:14:00.0: amdgpu: detected ip block number 0
<nv_common>
[    5.099753] amdgpu 0000:14:00.0: amdgpu: detected ip block number 1
<gmc_v10_0>
[    5.099754] amdgpu 0000:14:00.0: amdgpu: detected ip block number 2
<navi10_ih>
[    5.099755] amdgpu 0000:14:00.0: amdgpu: detected ip block number 3 <psp>
[    5.099756] amdgpu 0000:14:00.0: amdgpu: detected ip block number 4 <smu>
[    5.099757] amdgpu 0000:14:00.0: amdgpu: detected ip block number 5 <dm>
[    5.099758] amdgpu 0000:14:00.0: amdgpu: detected ip block number 6
<gfx_v10_0>
[    5.099760] amdgpu 0000:14:00.0: amdgpu: detected ip block number 7
<sdma_v5_2>
[    5.099761] amdgpu 0000:14:00.0: amdgpu: detected ip block number 8
<vcn_v3_0>
[    5.099762] amdgpu 0000:14:00.0: amdgpu: detected ip block number 9
<jpeg_v3_0>
[    5.099778] amdgpu 0000:14:00.0: amdgpu: Fetched VBIOS from VFCT
[    5.099780] amdgpu: ATOM BIOS: 102-RAPHAEL-008
[    5.102724] amdgpu 0000:14:00.0: amdgpu: Trusted Memory Zone (TMZ)
feature disabled as experimental (default)
[    5.102753] [drm] vm size is 262144 GB, 4 levels, block size is
9-bit, fragment size is 9-bit
[    5.102758] amdgpu 0000:14:00.0: amdgpu: VRAM: 512M
0x000000F400000000 - 0x000000F41FFFFFFF (512M used)
[    5.102760] amdgpu 0000:14:00.0: amdgpu: GART: 1024M
0x0000000000000000 - 0x000000003FFFFFFF
[    5.102767] [drm] Detected VRAM RAM=512M, BAR=512M
[    5.102768] [drm] RAM width 128bits DDR5
[    5.102923] [drm] amdgpu: 512M of VRAM memory ready
[    5.102924] [drm] amdgpu: 31717M of GTT memory ready.
[    5.102934] [drm] GART: num cpu pages 262144, num gpu pages 262144
[    5.103022] [drm] PCIE GART of 1024M enabled (table at 0x000000F41FC00000).
[    5.103315] amdgpu 0000:14:00.0: amdgpu: [drm] Loading DMUB
firmware via PSP: version=0x05002A00
[    5.103648] [drm] use_doorbell being set to: [true]
[    5.103661] amdgpu 0000:14:00.0: amdgpu: Found VCN firmware Version
ENC: 1.33 DEC: 4 VEP: 0 Revision: 13
[    5.119320] usb 3-12: new full-speed USB device number 6 using xhci_hcd
[    5.125724] amdgpu 0000:14:00.0: amdgpu: reserve 0xa00000 from
0xf41e000000 for PSP TMR
[    5.186824] amdgpu 0000:14:00.0: amdgpu: RAS: optional ras ta ucode
is not available
[    5.192517] amdgpu 0000:14:00.0: amdgpu: RAP: optional rap ta ucode
is not available
[    5.192519] amdgpu 0000:14:00.0: amdgpu: SECUREDISPLAY: optional
securedisplay ta ucode is not available
[    5.193958] amdgpu 0000:14:00.0: amdgpu: SMU is initialized successfully!
[    5.194278] amdgpu 0000:14:00.0: amdgpu: [drm] Display Core
v3.2.334 initialized on DCN 3.1.5
[    5.194280] amdgpu 0000:14:00.0: amdgpu: [drm] DP-HDMI FRL PCON supported
[    5.195041] amdgpu 0000:14:00.0: amdgpu: [drm] DMUB hardware
initialized: version=0x05002A00
[    5.196231] amdgpu 0000:14:00.0: amdgpu: [drm] PSR support 0, DC
PSR ver -1, sink PSR ver 0 DPCD caps 0x0 su_y_granularity 0
[    5.196257] amdgpu 0000:14:00.0: amdgpu: [drm] PSR support 0, DC
PSR ver -1, sink PSR ver 0 DPCD caps 0x0 su_y_granularity 0
[    5.196607] [drm] kiq ring mec 2 pipe 1 q 0
[    5.199725] kfd kfd: amdgpu: Allocated 3969056 bytes on gart
[    5.199731] kfd kfd: amdgpu: Total number of KFD nodes to be created: 1
[    5.199998] amdgpu: Virtual CRAT table created for GPU
[    5.200849] amdgpu: Topology: Add dGPU node [0x164e:0x1002]
[    5.200850] kfd kfd: amdgpu: added device 1002:164e
[    5.200857] amdgpu 0000:14:00.0: amdgpu: SE 1, SH per SE 1, CU per
SH 2, active_cu_number 2
[    5.200860] amdgpu 0000:14:00.0: amdgpu: ring gfx_0.0.0 uses VM inv
eng 0 on hub 0
[    5.200861] amdgpu 0000:14:00.0: amdgpu: ring gfx_0.1.0 uses VM inv
eng 1 on hub 0
[    5.200862] amdgpu 0000:14:00.0: amdgpu: ring comp_1.0.0 uses VM
inv eng 4 on hub 0
[    5.200863] amdgpu 0000:14:00.0: amdgpu: ring comp_1.1.0 uses VM
inv eng 5 on hub 0
[    5.200864] amdgpu 0000:14:00.0: amdgpu: ring comp_1.2.0 uses VM
inv eng 6 on hub 0
[    5.200865] amdgpu 0000:14:00.0: amdgpu: ring comp_1.3.0 uses VM
inv eng 7 on hub 0
[    5.200866] amdgpu 0000:14:00.0: amdgpu: ring comp_1.0.1 uses VM
inv eng 8 on hub 0
[    5.200867] amdgpu 0000:14:00.0: amdgpu: ring comp_1.1.1 uses VM
inv eng 9 on hub 0
[    5.200868] amdgpu 0000:14:00.0: amdgpu: ring comp_1.2.1 uses VM
inv eng 10 on hub 0
[    5.200869] amdgpu 0000:14:00.0: amdgpu: ring comp_1.3.1 uses VM
inv eng 11 on hub 0
[    5.200870] amdgpu 0000:14:00.0: amdgpu: ring kiq_0.2.1.0 uses VM
inv eng 12 on hub 0
[    5.200871] amdgpu 0000:14:00.0: amdgpu: ring sdma0 uses VM inv eng
13 on hub 0
[    5.200872] amdgpu 0000:14:00.0: amdgpu: ring vcn_dec_0 uses VM inv
eng 0 on hub 8
[    5.200873] amdgpu 0000:14:00.0: amdgpu: ring vcn_enc_0.0 uses VM
inv eng 1 on hub 8
[    5.200874] amdgpu 0000:14:00.0: amdgpu: ring vcn_enc_0.1 uses VM
inv eng 4 on hub 8
[    5.200875] amdgpu 0000:14:00.0: amdgpu: ring jpeg_dec uses VM inv
eng 5 on hub 8
[    5.201101] amdgpu 0000:14:00.0: amdgpu: Runtime PM not available
[    5.201279] amdgpu 0000:14:00.0: [drm] Registered 4 planes with drm panic
[    5.201280] [drm] Initialized amdgpu 3.64.0 for 0000:14:00.0 on minor 0
[    5.203550] amdgpu 0000:14:00.0: [drm] Cannot find any crtc or sizes
[    5.203559] [drm] pre_validate_dsc:1628 MST_DSC dsc precompute is not needed
[    5.489558] usb 3-12: New USB device found, idVendor=0b05,
idProduct=1a51, bcdDevice= 2.00
[    5.489565] usb 3-12: New USB device strings: Mfr=1, Product=2,
SerialNumber=3
[    5.489567] usb 3-12: Product: ROG RYUO III
[    5.489569] usb 3-12: Manufacturer: AsusTek Computer Inc.
[    5.489570] usb 3-12: SerialNumber: 208D39504D48
[    5.530864] hid-generic 0003:0B05:1A51.000A: hiddev101,hidraw9: USB
HID v1.11 Device [AsusTek Computer Inc. ROG RYUO III] on
usb-0000:12:00.0-12/input1
[    5.566579] fbcon: Taking over console
[    5.596943] EXT4-fs (nvme0n1p3): mounted filesystem
a1c25360-9835-4c00-a3b9-fd93e2577a57 r/w with ordered data mode. Quota
mode: none.
[    5.703185] Console: switching to colour frame buffer device 240x67
[    5.751588] systemd[1]: systemd 258-2-arch running in system mode
(+PAM +AUDIT -SELINUX +APPARMOR -IMA +IPE +SMACK +SECCOMP +GCRYPT
+GNUTLS +OPENSSL +ACL +BLKID +CURL +ELFUTILS +FIDO2 +IDN2 -IDN +IPTC
+KMOD +LIBCRYPTSETUP +LIBCRYPTSETUP_PLUGINS +LIBFDISK +PCRE2
+PWQUALITY +P11KIT +QRE
NCODE +TPM2 +BZIP2 +LZ4 +XZ +ZLIB +ZSTD +BPF_FRAMEWORK +BTF +XKBCOMMON
+UTMP -SYSVINIT +LIBARCHIVE)
[    5.751593] systemd[1]: Detected architecture x86-64.
[    5.752601] systemd[1]: Hostname set to <smurf>.
[    5.846359] systemd[1]: bpf-restrict-fs: LSM BPF program attached
[    5.972459] systemd[1]: Queued start job for default target
Graphical Interface.
[    5.997203] systemd[1]: Created slice Slice /system/dirmngr.
[    5.997457] systemd[1]: Created slice Slice /system/getty.
[    5.997669] systemd[1]: Created slice Slice /system/gpg-agent.
[    5.997885] systemd[1]: Created slice Slice /system/gpg-agent-browser.
[    5.998092] systemd[1]: Created slice Slice /system/gpg-agent-extra.
[    5.998306] systemd[1]: Created slice Slice /system/gpg-agent-ssh.
[    5.998521] systemd[1]: Created slice Slice /system/keyboxd.
[    5.998737] systemd[1]: Created slice Slice /system/modprobe.
[    5.998946] systemd[1]: Created slice Slice /system/systemd-fsck.
[    5.999106] systemd[1]: Created slice User and Session Slice.
[    5.999140] systemd[1]: Started Dispatch Password Requests to
Console Directory Watch.
[    5.999166] systemd[1]: Started Forward Password Requests to Wall
Directory Watch.
[    5.999283] systemd[1]: Set up automount Arbitrary Executable File
Formats File System Automount Point.
[    5.999293] systemd[1]: Expecting device /dev/nvme0n1p1...
[    5.999297] systemd[1]: Expecting device /dev/nvme0n1p2...
[    5.999302] systemd[1]: Reached target Local Encrypted Volumes.
[    5.999337] systemd[1]: Reached target Login Prompts.
[    5.999346] systemd[1]: Reached target Image Downloads.
[    5.999354] systemd[1]: Reached target Local Integrity Protected Volumes.
[    5.999365] systemd[1]: Reached target Path Units.
[    5.999371] systemd[1]: Reached target Remote File Systems.
[    5.999376] systemd[1]: Reached target Slice Units.
[    5.999390] systemd[1]: Reached target Local Verity Protected Volumes.
[    5.999435] systemd[1]: Listening on Device-mapper event daemon FIFOs.
[    5.999479] systemd[1]: Listening on LVM2 poll daemon socket.
[    5.999962] systemd[1]: Listening on Query the User Interactively
for a Password.
[    6.001696] systemd[1]: Listening on Process Core Dump Socket.
[    6.002067] systemd[1]: Listening on Credential Encryption/Decryption.
[    6.002541] systemd[1]: Listening on Factory Reset Management.
[    6.002593] systemd[1]: Listening on Journal Socket (/dev/log).
[    6.002639] systemd[1]: Listening on Journal Sockets.
[    6.002664] systemd[1]: TPM PCR Measurements was skipped because of
an unmet condition check (ConditionSecurity=measured-uki).
[    6.002671] systemd[1]: Make TPM PCR Policy was skipped because of
an unmet condition check (ConditionSecurity=measured-uki).
[    6.002704] systemd[1]: Listening on udev Control Socket.
[    6.002727] systemd[1]: Listening on udev Kernel Socket.
[    6.002757] systemd[1]: Listening on udev Varlink Socket.
[    6.003365] systemd[1]: Mounting Huge Pages File System...
[    6.003804] systemd[1]: Mounting POSIX Message Queue File System...
[    6.004234] systemd[1]: Mounting Kernel Debug File System...
[    6.004656] systemd[1]: Mounting Kernel Trace File System...
[    6.005165] systemd[1]: Starting Create List of Static Device Nodes...
[    6.005605] systemd[1]: Starting Monitoring of LVM2 mirrors,
snapshots etc. using dmeventd or progress polling...
[    6.005620] systemd[1]: Load Kernel Module configfs was skipped
because of an unmet condition check
(ConditionKernelModuleLoaded=!configfs).
[    6.006091] systemd[1]: Mounting Kernel Configuration File System...
[    6.006890] systemd[1]: Starting Load Kernel Module dm_mod...
[    6.006908] systemd[1]: Load Kernel Module drm was skipped because
of an unmet condition check (ConditionKernelModuleLoaded=!drm).
[    6.006928] systemd[1]: Load Kernel Module fuse was skipped because
of an unmet condition check (ConditionKernelModuleLoaded=!fuse).
[    6.007403] systemd[1]: Mounting FUSE Control File System...
[    6.008063] systemd[1]: Starting Load Kernel Module loop...
[    6.008091] systemd[1]: File System Check on Root Device was
skipped because of an unmet condition check
(ConditionPathIsReadWrite=!/).
[    6.008111] systemd[1]: Clear Stale Hibernate Storage Info was
skipped because of an unmet condition check
(ConditionPathExists=/sys/firmware/efi/efivars/HibernateLocation-8cf2644b-4b0b-428f-9387-6d876050dc67).
[    6.009134] systemd[1]: Starting Journal Service...
[    6.010233] systemd[1]: Starting Load Kernel Modules...
[    6.010245] systemd[1]: TPM PCR Machine ID Measurement was skipped
because of an unmet condition check (ConditionSecurity=measured-uki).
[    6.011323] systemd[1]: Starting Remount Root and Kernel File Systems...
[    6.011353] systemd[1]: Early TPM SRK Setup was skipped because of
an unmet condition check (ConditionSecurity=measured-uki).
[    6.011838] systemd[1]: Starting Load udev Rules from Credentials...
[    6.012608] systemd[1]: Starting Coldplug All udev Devices...
[    6.014068] systemd[1]: Mounted Huge Pages File System.
[    6.014147] systemd[1]: Mounted POSIX Message Queue File System.
[    6.014216] systemd[1]: Mounted Kernel Debug File System.
[    6.014275] systemd[1]: Mounted Kernel Trace File System.
[    6.014318] loop: module loaded
[    6.014447] systemd[1]: Finished Create List of Static Device Nodes.
[    6.014817] systemd[1]: Mounted Kernel Configuration File System.
[    6.014879] systemd[1]: Mounted FUSE Control File System.
[    6.015003] systemd[1]: modprobe@loop.service: Deactivated successfully.
[    6.015123] systemd[1]: Finished Load Kernel Module loop.
[    6.015751] systemd[1]: Starting Create Static Device Nodes in /dev
gracefully...
[    6.017258] device-mapper: uevent: version 1.0.3
[    6.017310] device-mapper: ioctl: 4.50.0-ioctl (2025-04-28)
initialised: dm-devel@lists.linux.dev
[    6.017778] systemd[1]: modprobe@dm_mod.service: Deactivated successfully.
[    6.017917] systemd[1]: Finished Load Kernel Module dm_mod.
[    6.018032] systemd[1]: Repartition Root Disk was skipped because
no trigger condition checks were met.
[    6.018472] systemd[1]: Finished Load udev Rules from Credentials.
[    6.020080] i2c_dev: i2c /dev entries driver
[    6.020402] systemd-journald[648]: Collecting audit messages is disabled.
[    6.021055] systemd[1]: Finished Load Kernel Modules.
[    6.021620] systemd[1]: Starting Apply Kernel Variables...
[    6.027832] systemd[1]: Finished Apply Kernel Variables.
[    6.037651] EXT4-fs (nvme0n1p3): re-mounted
a1c25360-9835-4c00-a3b9-fd93e2577a57.
[    6.037906] systemd[1]: Finished Create Static Device Nodes in /dev
gracefully.
[    6.038121] systemd[1]: Finished Remount Root and Kernel File Systems.
[    6.038407] systemd[1]: Rebuild Hardware Database was skipped
because no trigger condition checks were met.
[    6.038861] systemd[1]: Starting Load/Save OS Random Seed...
[    6.039290] systemd[1]: Starting Create System Users...
[    6.039300] systemd[1]: TPM SRK Setup was skipped because of an
unmet condition check (ConditionSecurity=measured-uki).
[    6.053086] systemd[1]: Finished Monitoring of LVM2 mirrors,
snapshots etc. using dmeventd or progress polling.
[    6.073716] systemd[1]: Finished Load/Save OS Random Seed.
[    6.085848] systemd[1]: Finished Create System Users.
[    6.086644] systemd[1]: Starting Network Time Synchronization...
[    6.087103] systemd[1]: Starting Create Static Device Nodes in /dev...
[    6.115903] systemd[1]: Finished Create Static Device Nodes in /dev.
[    6.115954] systemd[1]: Reached target Preparation for Local File Systems.
[    6.116489] systemd[1]: Starting Rule-based Manager for Device
Events and Files...
[    6.122631] systemd[1]: Started Journal Service.
[    6.127582] systemd-journald[648]: Received client request to flush
runtime journal.
[    6.321832] pps_core: LinuxPPS API ver. 1 registered
[    6.321835] pps_core: Software ver. 5.3.6 - Copyright 2005-2007
Rodolfo Giometti <giometti@linux.it>
[    6.322784] piix4_smbus 0000:00:14.0: SMBus Host Controller at
0xb00, revision 0
[    6.322789] piix4_smbus 0000:00:14.0: Using register 0x02 for SMBus
port selection
[    6.330109] i2c i2c-14: Successfully instantiated SPD at 0x51
[    6.331572] PTP clock support registered
[    6.331671] ccp 0000:14:00.2: enabling device (0000 -> 0002)
[    6.332496] i2c i2c-14: Successfully instantiated SPD at 0x53
[    6.334207] piix4_smbus 0000:00:14.0: Auxiliary SMBus Host
Controller at 0xb20
[    6.336319] ccp 0000:14:00.2: tee enabled
[    6.337407] ccp 0000:14:00.2: psp enabled
[    6.365965] input: PC Speaker as /devices/platform/pcspkr/input/input10
[    6.366167] sp5100_tco: SP5100/SB800 TCO WatchDog Timer Driver
[    6.366301] RAPL PMU: API unit is 2^-32 Joules, 2 fixed counters,
163840 ms ovfl timer
[    6.366303] RAPL PMU: hw unit of domain package 2^-16 Joules
[    6.366305] RAPL PMU: hw unit of domain core 2^-16 Joules
[    6.366443] sp5100-tco sp5100-tco: Using 0xfeb00000 for watchdog MMIO address
[    6.366447] Intel(R) 2.5G Ethernet Linux Driver
[    6.366449] Copyright(c) 2018 Intel Corporation.
[    6.366596] igc 0000:0c:00.0: PCIe PTM not supported by PCIe bus/controller
[    6.366626] sp5100-tco sp5100-tco: initialized. heartbeat=60 sec (nowayout=0)
[    6.366992] cfg80211: Loading compiled-in X.509 certificates for
regulatory database
[    6.367109] Loaded X.509 cert 'sforshee: 00b28ddf47aef9cea7'
[    6.367183] Loaded X.509 cert 'wens:
61c038651aabdcf94bd0ac7ff06c7248db18c600'
[    6.367817] platform regulatory.0: Direct firmware load for
regulatory.db failed with error -2
[    6.367820] cfg80211: failed to load regulatory.db
[    6.371763] asus_wmi: ASUS WMI generic driver loaded
[    6.374029] asus_wmi: failed to register LPS0 sleep handler in asus-wmi
[    6.374102] asus_wmi: SFUN value: 0x1
[    6.374104] eeepc-wmi eeepc-wmi: Detected ATK, not ASUSWMI, use DSTS
[    6.375399] input: Eee PC WMI hotkeys as
/devices/platform/eeepc-wmi/input/input11
[    6.380065] spd5118 14-0051: DDR5 temperature sensor: vendor
0x00:0xb3 revision 2.2
[    6.380819] Intel(R) Wireless WiFi driver for Linux
[    6.380890] iwlwifi 0000:0b:00.0: enabling device (0000 -> 0002)
[    6.382325] iwlwifi 0000:0b:00.0: Detected crf-id 0x400410, cnv-id
0x400410 wfpm id 0x80000000
[    6.382333] iwlwifi 0000:0b:00.0: PCI dev 2725/0024, rev=0x420, rfid=0x10d000
[    6.382334] iwlwifi 0000:0b:00.0: Detected Intel(R) Wi-Fi 6E AX210 160MHz
[    6.385909] spd5118 14-0053: DDR5 temperature sensor: vendor
0x00:0xb3 revision 2.2
[    6.386470] Adding 69206012k swap on /dev/nvme0n1p2.  Priority:-2
extents:1 across:69206012k SS
[    6.386623] iwlwifi 0000:0b:00.0: TLV_FW_FSEQ_VERSION: FSEQ Version: 0.0.2.42
[    6.386880] iwlwifi 0000:0b:00.0: loaded firmware version
89.2e78fa67.0 ty-a0-gf-a0-89.ucode op_mode iwlmvm
[    6.389274] snd_hda_intel 0000:03:00.1: enabling device (0000 -> 0002)
[    6.390388] snd_hda_intel 0000:03:00.1: Handle vga_switcheroo audio client
[    6.390391] snd_hda_intel 0000:03:00.1: Force to non-snoop mode
[    6.391526] snd_hda_intel 0000:14:00.1: enabling device (0000 -> 0002)
[    6.391576] snd_hda_intel 0000:14:00.1: Handle vga_switcheroo audio client
[    6.416694] igc 0000:0c:00.0 (unnamed net_device) (uninitialized): PHC added
[    6.418053] snd_hda_intel 0000:14:00.1: bound 0000:14:00.0 (ops
amdgpu_dm_audio_component_bind_ops [amdgpu])
[    6.418647] input: HD-Audio Generic HDMI/DP,pcm=3 as
/devices/pci0000:00/0000:00:08.1/0000:14:00.1/sound/card1/input12
[    6.418708] input: HD-Audio Generic HDMI/DP,pcm=7 as
/devices/pci0000:00/0000:00:08.1/0000:14:00.1/sound/card1/input13
[    6.419213] snd_hda_intel 0000:03:00.1: bound 0000:03:00.0 (ops
amdgpu_dm_audio_component_bind_ops [amdgpu])
[    6.419984] input: HDA ATI HDMI HDMI/DP,pcm=3 as
/devices/pci0000:00/0000:00:01.1/0000:01:00.0/0000:02:00.0/0000:03:00.1/sound/card0/input14
[    6.420033] input: HDA ATI HDMI HDMI/DP,pcm=7 as
/devices/pci0000:00/0000:00:01.1/0000:01:00.0/0000:02:00.0/0000:03:00.1/sound/card0/input15
[    6.420076] input: HDA ATI HDMI HDMI/DP,pcm=8 as
/devices/pci0000:00/0000:00:01.1/0000:01:00.0/0000:02:00.0/0000:03:00.1/sound/card0/input16
[    6.420139] input: HDA ATI HDMI HDMI/DP,pcm=9 as
/devices/pci0000:00/0000:00:01.1/0000:01:00.0/0000:02:00.0/0000:03:00.1/sound/card0/input17
[    6.443583] igc 0000:0c:00.0: 4.000 Gb/s available PCIe bandwidth
(5.0 GT/s PCIe x1 link)
[    6.443586] igc 0000:0c:00.0 eth0: MAC: a0:36:bc:ac:b3:b6
[    6.457589] igc 0000:0c:00.0 eno1: renamed from eth0
[    6.525006] kvm_amd: TSC scaling supported
[    6.525008] kvm_amd: Nested Virtualization enabled
[    6.525009] kvm_amd: Nested Paging enabled
[    6.525010] kvm_amd: LBR virtualization supported
[    6.525016] kvm_amd: Virtual GIF supported
[    6.525017] kvm_amd: Virtual NMI enabled
[    6.578963] intel_rapl_common: Found RAPL domain package
[    6.578966] intel_rapl_common: Found RAPL domain core
[    6.579401] amd_atl: AMD Address Translation Library initialized
[    6.695481] iwlwifi 0000:0b:00.0: WFPM_UMAC_PD_NOTIFICATION: 0x20
[    6.695501] iwlwifi 0000:0b:00.0: WFPM_LMAC2_PD_NOTIFICATION: 0x1f
[    6.695516] iwlwifi 0000:0b:00.0: WFPM_AUTH_KEY_0: 0x90
[    6.695529] iwlwifi 0000:0b:00.0: CNVI_SCU_SEQ_DATA_DW9: 0x0
[    6.695591] iwlwifi 0000:0b:00.0: Detected RF GF, rfid=0x10d000
[    6.696880] iwlwifi 0000:0b:00.0: loaded PNVM version 4f8f0b9a
[    6.783039] iwlwifi 0000:0b:00.0: base HW address: bc:09:1b:0f:5c:12
[    6.811347] iwlwifi 0000:0b:00.0 wlp11s0: renamed from wlan0
[    7.379740] mc: Linux media interface: v0.10
[    7.382384] mousedev: PS/2 mouse device common for all mice
[    7.395419] Bluetooth: Core ver 2.22
[    7.395431] NET: Registered PF_BLUETOOTH protocol family
[    7.395433] Bluetooth: HCI device and connection manager initialized
[    7.395436] Bluetooth: HCI socket layer initialized
[    7.395438] Bluetooth: L2CAP socket layer initialized
[    7.395441] Bluetooth: SCO socket layer initialized
[    7.400911] usbcore: registered new device driver r8152-cfgselector
[    7.477180] usb 3-3: Warning! Unlikely big volume range (=16384),
cval->res is probably wrong.
[    7.477183] usb 3-3: [2] FU [PCM Playback Volume] ch = 2, val = -16384/0/1
[    7.507944] usbcore: registered new interface driver btusb
[    7.508180] usb 3-3: Warning! Unlikely big volume range (=7680),
cval->res is probably wrong.
[    7.508182] usb 3-3: [6] FU [Mic Capture Volume] ch = 2, val = -7680/0/1
[    7.513515] Bluetooth: hci0: Firmware timestamp 2025.20 buildtype 1
build 82053
[    7.513518] Bluetooth: hci0: Firmware SHA1: 0x937bca4a
[    7.513521] Bluetooth: hci0: No support for _PRR ACPI method
[    7.519313] Bluetooth: hci0: Found device firmware: intel/ibt-0041-0041.sfi
[    7.519322] Bluetooth: hci0: Boot Address: 0x100800
[    7.519323] Bluetooth: hci0: Firmware Version: 133-20.25
[    7.519324] Bluetooth: hci0: Firmware already loaded
[    7.534367] Bluetooth: hci0: Fseq status: Success (0x00)
[    7.534368] Bluetooth: hci0: Fseq executed: 00.00.02.42
[    7.534370] Bluetooth: hci0: Fseq BT Top: 00.00.02.41
[    7.606711] amdgpu 0000:03:00.0: vgaarb: VGA decodes changed:
olddecodes=io+mem,decodes=none:owns=none
[    7.606757] amdgpu 0000:14:00.0: vgaarb: VGA decodes changed:
olddecodes=io+mem,decodes=none:owns=none
[    7.620012] r8152-cfgselector 2-1: reset SuperSpeed USB device
number 2 using xhci_hcd
[    7.679663] r8152 2-1:1.0 eth0: v1.12.13
[    7.679681] usbcore: registered new interface driver r8152
[    7.684885] usbcore: registered new interface driver cdc_ether
[    7.686941] usbcore: registered new interface driver r8153_ecm
[    7.721391] r8152 2-1:1.0 enp16s0u1: renamed from eth0
[   10.320829] r8152 2-1:1.0 enp16s0u1: carrier on
[   10.356855] r8152 2-1:1.0 enp16s0u1: carrier off
[   13.602722] usbcore: registered new interface driver snd-usb-audio
[   13.680893] r8152 2-1:1.0 enp16s0u1: carrier on
[   13.906848] nvme nvme0: using unchecked data buffer
[   15.717045] warning: `kdeconnectd' uses wireless extensions which
will stop working for Wi-Fi 7 hardware; use nl80211
[ 3900.983969] amdgpu 0000:03:00.0: [drm] *ERROR* [CRTC:80:crtc-0]
flip_done timed out
[ 3907.639967] amdgpu 0000:03:00.0: amdgpu: [drm] *ERROR*
[CRTC:80:crtc-0] hw_done or flip_done timed out
[ 3917.880052] amdgpu 0000:03:00.0: [drm] *ERROR* flip_done timed out
[ 3917.880056] amdgpu 0000:03:00.0: [drm] *ERROR* [CRTC:80:crtc-0]
commit wait timed out
[ 3928.119607] amdgpu 0000:03:00.0: [drm] *ERROR* flip_done timed out
[ 3928.119611] amdgpu 0000:03:00.0: [drm] *ERROR* [PLANE:77:plane-6]
commit wait timed out
[ 3928.342935] ------------[ cut here ]------------
[ 3928.342937] WARNING: CPU: 18 PID: 1346 at
drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:8915
amdgpu_dm_atomic_commit_tail+0x37d8/0x3840 [amdgpu]
[ 3928.343115] Modules linked in: r8153_ecm cdc_ether usbnet btusb
btrtl snd_usb_audio btintel r8152 snd_usbmidi_lib btbcm btmtk snd_ump
mii snd_rawmidi libphy snd_seq_device mousedev joydev bluetooth
mdio_bus mc vfat fat amd_atl intel_rapl_msr intel_rapl_common iwlmvm
kvm_amd kvm mac802
11 snd_hda_codec_hdmi libarc4 snd_hda_intel irqbypass snd_intel_dspcfg
snd_intel_sdw_acpi polyval_clmulni ghash_clmulni_intel snd_hda_codec
sha512_ssse3 spd5118 iwlwifi eeepc_wmi snd_hda_core sha1_ssse3
asus_wmi aesni_intel snd_hwdep platform_profile rapl sparse_keymap
wmi_bmof snd_pcm s
p5100_tco pcspkr igc snd_timer cfg80211 snd ptp ccp soundcore
i2c_piix4 k10temp pps_core rfkill i2c_smbus gpio_amdpt gpio_generic
mac_hid i2c_dev crypto_user dm_mod loop nfnetlink ip_tables x_tables
amdgpu amdxcp i2c_algo_bit drm_ttm_helper ttm drm_exec gpu_sched
drm_suballoc_helper nvme
drm_panel_backlight_quirks drm_buddy video nvme_core
drm_display_helper nvme_keyring cec nvme_auth wmi
[ 3928.343153] CPU: 18 UID: 0 PID: 1346 Comm: systemd-logind Not
tainted 6.16.8-arch1-1 #1 PREEMPT(full)
d690182ccc8b3c99d062070f13840552d7036612
[ 3928.343155] Hardware name: ASUS System Product Name/ROG STRIX
X670E-E GAMING WIFI, BIOS 3205 07/15/2025
[ 3928.343156] RIP: 0010:amdgpu_dm_atomic_commit_tail+0x37d8/0x3840 [amdgpu]
[ 3928.343291] Code: 0b e9 f6 f8 ff ff 0f 0b 49 8d 84 24 a8 4f 04 00
c6 85 28 fe ff ff 00 48 89 85 30 fe ff ff e9 83 ce ff ff 0f 0b e9 ce
ce ff ff <0f> 0b e9 ea f8 ff ff 48 c7 85 20 fe ff ff 00 00 00 00 48 c7
85 f8
[ 3928.343292] RSP: 0018:ffffcef780f3f3b0 EFLAGS: 00010082
[ 3928.343293] RAX: 0000000000000001 RBX: 0000000000000286 RCX: ffff8ad941179118
[ 3928.343294] RDX: 0000000000000001 RSI: 0000000000000286 RDI: ffff8ad959380180
[ 3928.343294] RBP: ffffcef780f3f608 R08: ffffcef780f3f2a4 R09: 0000000000000000
[ 3928.343295] R10: 0000000000000000 R11: ffffcef780f3f314 R12: ffff8ad941179118
[ 3928.343295] R13: ffff8ad959380010 R14: ffff8ad941179000 R15: ffff8ad9e4115e00
[ 3928.343296] FS:  00007fd32fa5f900(0000) GS:ffff8ae8ca59a000(0000)
knlGS:0000000000000000
[ 3928.343297] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 3928.343298] CR2: 00007fb5a75dbe90 CR3: 000000010d675000 CR4: 0000000000f50ef0
[ 3928.343299] PKRU: 55555554
[ 3928.343299] Call Trace:
[ 3928.343301]  <TASK>
[ 3928.343311]  commit_tail+0x9e/0x130
[ 3928.343315]  drm_atomic_helper_commit+0x13c/0x180
[ 3928.343317]  drm_atomic_commit+0xae/0xe0
[ 3928.343319]  ? __pfx___drm_printfn_info+0x10/0x10
[ 3928.343322]  drm_client_modeset_commit_atomic+0x1ec/0x230
[ 3928.343327]  drm_client_modeset_commit_locked+0x58/0x160
[ 3928.343329]  __drm_fb_helper_restore_fbdev_mode_unlocked+0x55/0xd0
[ 3928.343332]  drm_fb_helper_set_par+0x2d/0x40
[ 3928.343333]  fb_set_var+0x239/0x430
[ 3928.343337]  ? srso_alias_return_thunk+0x5/0xfbef5
[ 3928.343339]  ? update_load_avg+0x7c/0x740
[ 3928.343341]  ? srso_alias_return_thunk+0x5/0xfbef5
[ 3928.343342]  ? psi_group_change+0x10c/0x2c0
[ 3928.343347]  fbcon_blank+0x272/0x330
[ 3928.343351]  do_unblank_screen+0xc5/0x1b0
[ 3928.343354]  complete_change_console+0x54/0x120
[ 3928.343357]  vt_ioctl+0xd34/0x1450
[ 3928.343360]  tty_ioctl+0xe1/0x980
[ 3928.343362]  ? __seccomp_filter+0x41/0x4e0
[ 3928.343366]  __x64_sys_ioctl+0x94/0xe0
[ 3928.343369]  ? srso_alias_return_thunk+0x5/0xfbef5
[ 3928.343370]  do_syscall_64+0x81/0x970
[ 3928.343376]  ? srso_alias_return_thunk+0x5/0xfbef5
[ 3928.343377]  ? srso_alias_return_thunk+0x5/0xfbef5
[ 3928.343378]  ? __sys_sendmsg+0x8a/0xf0
[ 3928.343382]  ? srso_alias_return_thunk+0x5/0xfbef5
[ 3928.343383]  ? do_syscall_64+0x81/0x970
[ 3928.343385]  ? srso_alias_return_thunk+0x5/0xfbef5
[ 3928.343386]  ? do_syscall_64+0x81/0x970
[ 3928.343389]  ? srso_alias_return_thunk+0x5/0xfbef5
[ 3928.343390]  ? do_syscall_64+0x81/0x970
[ 3928.343391]  ? srso_alias_return_thunk+0x5/0xfbef5
[ 3928.343392]  ? do_syscall_64+0x81/0x970
[ 3928.343394]  ? srso_alias_return_thunk+0x5/0xfbef5
[ 3928.343395]  ? do_syscall_64+0x229/0x970
[ 3928.343396]  ? srso_alias_return_thunk+0x5/0xfbef5
[ 3928.343397]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[ 3928.343399] RIP: 0033:0x7fd32f91674d
[ 3928.343413] Code: 04 25 28 00 00 00 48 89 45 c8 31 c0 48 8d 45 10
c7 45 b0 10 00 00 00 48 89 45 b8 48 8d 45 d0 48 89 45 c0 b8 10 00 00
00 0f 05 <89> c2 3d 00 f0 ff ff 77 1a 48 8b 45 c8 64 48 2b 04 25 28 00
00 00
[ 3928.343413] RSP: 002b:00007ffc7edcd490 EFLAGS: 00000246 ORIG_RAX:
0000000000000010
[ 3928.343415] RAX: ffffffffffffffda RBX: 000000000000001c RCX: 00007fd32f91674d
[ 3928.343415] RDX: 0000000000000001 RSI: 0000000000005605 RDI: 000000000000001c
[ 3928.343416] RBP: 00007ffc7edcd4e0 R08: 00000000ffffffff R09: 00007ffc7edcd4c0
[ 3928.343416] R10: 00000000ffffffff R11: 0000000000000246 R12: 00005586d5dc4e80
[ 3928.343417] R13: 00005586d5dc4e80 R14: 0000000000000000 R15: 00005586d5dc6110
[ 3928.343419]  </TASK>
[ 3928.343420] ---[ end trace 0000000000000000 ]---

"

On Sun, 14 Sept 2025 at 19:28, Jesper Juhl <jesperjuhl76@gmail.com> wrote:
>
> Hi guys
>
> I'm writing in the hope that I can provide some helpful information in
> order to get this issue resolved.
>
> This has plagued me personally for the past year and a half, but I can
> see online when searching for "flip_done timed out" that this has been
> an issue for many more people for much longer (both when using distro
> kernels and kernel.org kernels).
>
> I experience this issue sometimes months apart and sometimes hours
> apart and I really don't know how to trigger it. Sometimes it happens
> while I'm watching a youtube video, sometimes while I'm playing a
> steam/proton game and sometimes I'm just editing a file in LibreOffice
> or my computer is just idle at the KDE desktop.
>
> In every case the kernel `dmesg` report looks the same - here's the
> latest one I've captured:
>
> ...
> [   10.142827] r8152 2-1:1.0 enp16s0u1: carrier on
> [   10.178864] r8152 2-1:1.0 enp16s0u1: carrier off
> [   13.056370] nvme nvme0: using unchecked data buffer
> [   13.373622] usbcore: registered new interface driver snd-usb-audio
> [   13.406920] r8152 2-1:1.0 enp16s0u1: carrier on
> [   14.402737] r8152 2-1:1.0 enp16s0u1: carrier off
> [   15.223671] warning: `kdeconnectd' uses wireless extensions which
> will stop working for Wi-Fi 7 hardware; use nl80211
> [   16.910901] r8152 2-1:1.0 enp16s0u1: carrier on
> [19381.259879] usb 3-2: new high-speed USB device number 7 using xhci_hcd
> [19381.483014] usb 3-2: New USB device found, idVendor=18d1,
> idProduct=4ee1, bcdDevice= 6.01
> [19381.483017] usb 3-2: New USB device strings: Mfr=1, Product=2, SerialNumber=3
> [19381.483018] usb 3-2: Product: Pixel 9a
> [19381.483020] usb 3-2: Manufacturer: Google
> [19381.483021] usb 3-2: SerialNumber: 4A101JEBF08492
> [19741.639725] usb 3-2: USB disconnect, device number 7
> [20238.021390] amdgpu 0000:03:00.0: [drm] *ERROR* [CRTC:80:crtc-0]
> flip_done timed out
> [20251.333468] amdgpu 0000:03:00.0: [drm] *ERROR* flip_done timed out
> [20251.333473] amdgpu 0000:03:00.0: [drm] *ERROR* [CRTC:80:crtc-0]
> commit wait timed out
> [20261.572992] amdgpu 0000:03:00.0: [drm] *ERROR* flip_done timed out
> [20261.572995] amdgpu 0000:03:00.0: [drm] *ERROR* [PLANE:77:plane-6]
> commit wait timed out
> [20261.798769] ------------[ cut here ]------------
> [20261.798771] WARNING: CPU: 18 PID: 1326 at
> drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:8905
> amdgpu_dm_atomic_commit_tail+0x37d8/0x3840 [amdgpu]
> [20261.798947] Modules linked in: r8153_ecm cdc_ether usbnet btusb
> snd_usb_audio btrtl btintel snd_usbmidi_lib snd_ump btbcm r8152
> snd_rawmidi btmtk mii snd_seq_device libphy mc bluetooth mdio_bus
> mousedev joydev vfat fat amd_atl intel_rapl_msr intel_rapl_common
> iwlmvm kvm_amd snd_hda_c
> odec_hdmi mac80211 kvm snd_hda_intel snd_intel_dspcfg
> snd_intel_sdw_acpi libarc4 irqbypass snd_hda_codec spd5118
> polyval_clmulni asus_nb_wmi ghash_clmulni_intel iwlwifi sp5100_tco
> snd_hda_core sha512_ssse3 asus_wmi snd_hwdep sha1_ssse3
> platform_profile aesni_intel snd_pcm igc i2c_piix4
> wmi_bmof sparse_keymap rapl cfg80211 ptp snd_timer pcspkr ccp k10temp
> i2c_smbus pps_core snd rfkill soundcore gpio_amdpt gpio_generic
> mac_hid i2c_dev crypto_user loop dm_mod nfnetlink ip_tables x_tables
> amdgpu amdxcp i2c_algo_bit drm_ttm_helper ttm drm_exec gpu_sched
> drm_suballoc_helper
> drm_panel_backlight_quirks nvme drm_buddy nvme_core drm_display_helper
> nvme_keyring cec video nvme_auth wmi
> [20261.798985] CPU: 18 UID: 0 PID: 1326 Comm: systemd-logind Not
> tainted 6.16.7-arch1-1 #1 PREEMPT(full)
> ca97e8d991f25900a7e86eaefaa601b827fdc90b
> [20261.798987] Hardware name: ASUS System Product Name/ROG STRIX
> X670E-E GAMING WIFI, BIOS 3205 07/15/2025
> [20261.798988] RIP: 0010:amdgpu_dm_atomic_commit_tail+0x37d8/0x3840 [amdgpu]
> [20261.799120] Code: 0b e9 f6 f8 ff ff 0f 0b 49 8d 84 24 a8 4f 04 00
> c6 85 28 fe ff ff 00 48 89 85 30 fe ff ff e9 83 ce ff ff 0f 0b e9 ce
> ce ff ff <0f> 0b e9 ea f8 ff ff 48 c7 85 20 fe ff ff 00 00 00 00 48 c7
> 85 f8
> [20261.799121] RSP: 0018:ffffd43ac5b7f630 EFLAGS: 00010086
> [20261.799122] RAX: 0000000000000001 RBX: 0000000000000282 RCX: ffff8ec601e6a118
> [20261.799123] RDX: 0000000000000001 RSI: 0000000000000286 RDI: ffff8ec616700180
> [20261.799123] RBP: ffffd43ac5b7f888 R08: ffffd43ac5b7f524 R09: 0000000000000000
> [20261.799124] R10: 0000000000000000 R11: ffffd43ac5b7f594 R12: ffff8ec601e6a118
> [20261.799124] R13: ffff8ec616700010 R14: ffff8ec601e6a000 R15: ffff8ec764044000
> [20261.799125] FS:  00007f0c45a3d900(0000) GS:ffff8ed59859b000(0000)
> knlGS:0000000000000000
> [20261.799126] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [20261.799127] CR2: 00007f0171413be0 CR3: 000000014332d000 CR4: 0000000000f50ef0
> [20261.799128] PKRU: 55555554
> [20261.799128] Call Trace:
> [20261.799130]  <TASK>
> [20261.799139]  commit_tail+0x9e/0x130
> [20261.799143]  drm_atomic_helper_commit+0x13c/0x180
> [20261.799144]  drm_atomic_commit+0xae/0xe0
> [20261.799147]  ? __pfx___drm_printfn_info+0x10/0x10
> [20261.799151]  drm_client_modeset_commit_atomic+0x1ec/0x230
> [20261.799154]  drm_client_modeset_commit_locked+0x58/0x160
> [20261.799156]  __drm_fb_helper_restore_fbdev_mode_unlocked+0x55/0xd0
> [20261.799159]  drm_fb_helper_set_par+0x2d/0x40
> [20261.799160]  fb_set_var+0x239/0x430
> [20261.799164]  ? srso_alias_return_thunk+0x5/0xfbef5
> [20261.799166]  ? update_load_avg+0x7c/0x740
> [20261.799168]  ? srso_alias_return_thunk+0x5/0xfbef5
> [20261.799169]  ? psi_group_change+0x10c/0x2c0
> [20261.799174]  fbcon_blank+0x272/0x330
> [20261.799178]  do_unblank_screen+0xc5/0x1b0
> [20261.799181]  complete_change_console+0x54/0x120
> [20261.799183]  vt_ioctl+0xd34/0x1450
> [20261.799185]  ? srso_alias_return_thunk+0x5/0xfbef5
> [20261.799186]  ? tty_ioctl+0x156/0x980
> [20261.799188]  ? __seccomp_filter+0x41/0x4e0
> [20261.799191]  tty_ioctl+0xe1/0x980
> [20261.799192]  ? __seccomp_filter+0x41/0x4e0
> [20261.799195]  __x64_sys_ioctl+0x94/0xe0
> [20261.799197]  ? srso_alias_return_thunk+0x5/0xfbef5
> [20261.799199]  do_syscall_64+0x81/0x970
> [20261.799202]  ? srso_alias_return_thunk+0x5/0xfbef5
> [20261.799203]  ? do_syscall_64+0x81/0x970
> [20261.799204]  ? srso_alias_return_thunk+0x5/0xfbef5
> [20261.799205]  ? do_syscall_64+0x81/0x970
> [20261.799206]  ? srso_alias_return_thunk+0x5/0xfbef5
> [20261.799208]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> [20261.799209] RIP: 0033:0x7f0c4591674d
> [20261.799221] Code: 04 25 28 00 00 00 48 89 45 c8 31 c0 48 8d 45 10
> c7 45 b0 10 00 00 00 48 89 45 b8 48 8d 45 d0 48 89 45 c0 b8 10 00 00
> 00 0f 05 <89> c2 3d 00 f0 ff ff 77 1a 48 8b 45 c8 64 48 2b 04 25 28 00
> 00 00
> [20261.799222] RSP: 002b:00007ffe1bb81820 EFLAGS: 00000246 ORIG_RAX:
> 0000000000000010
> [20261.799223] RAX: ffffffffffffffda RBX: 000000000000001a RCX: 00007f0c4591674d
> [20261.799224] RDX: 0000000000000001 RSI: 0000000000005605 RDI: 000000000000001a
> [20261.799224] RBP: 00007ffe1bb81870 R08: 00000000ffffffff R09: 00007ffe1bb81850
> [20261.799225] R10: 00000000ffffffff R11: 0000000000000246 R12: 0000558921a1ef60
> [20261.799225] R13: 0000558921a1ef60 R14: 0000000000000000 R15: 0000558921a200b0
> [20261.799228]  </TASK>
> [20261.799229] ---[ end trace 0000000000000000 ]---
>
> I have many similar traces from older kernel versions (this one is "
> Linux smurf 6.16.7-arch1-1 #1 SMP PREEMPT_DYNAMIC Thu, 11 Sep 2025
> 17:42:36 +0000 x86_64 GNU/Linux").
>
> As for my hardware, I'm using a ASUS motherboard " ROG STRIX X670E-E
> GAMING WIFI (BIOS version 3205"). The CPU is a AMD 7950X and there are
> 64GB of memory installed. The GPU is a AsRock 7900XTX Tichi OC - "
> 03:00.0 VGA compatible controller: Advanced Micro Devices, Inc.
> [AMD/ATI] Navi 31 [Radeon RX 7900 XT/7900 XTX/7900 GRE/7900M] (rev c8)
> (prog-if 00 [VGA controller])".
>
> I can provide more hardware details if needed.
>
> The fact is that this bites regularly and has for ages. It has also
> bitten my wife who uses a 7800XT in her machine. It's a pain and it
> has been happening for ages with a ton of different hardware. Please
> tell me what I can try/test/do to help resolve this.
>
> PPS. My linux firmware version at the time of writing this is 20250808-1
>
> Please let me know how I can help resolve this - it's really annoying
> and obviously impacting a *lot* of people.
>
> --
> Kind regards,
>  Jesper Juhl

