Return-Path: <linux-kernel+bounces-866653-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8409FC005B0
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 11:55:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4E71D4E869C
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 09:55:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67EBE30AACB;
	Thu, 23 Oct 2025 09:55:05 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8582D3002C3
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 09:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761213305; cv=none; b=GHFXdRYBSeugP+J7mzVJ95oyE6jGgmohPLlHVrY6/7T0HzEDydw/z3/LzNCvJhFoU9oQqHf3kkRE3ib5LCpeMo9DN1mkCqJV3IbU8lZgIbddoF/R92mczOUVSDqIVXRhdtxKk7D/04fSIVqiPJ1X0ZOlWFE1pUxaeRkEWuAYSis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761213305; c=relaxed/simple;
	bh=J/AAH2bwLlYJYpjLXSLPZrsFBGMEuqYSMJbiyGGRhnU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=eTh2cTveQzKOBzFm/+7jubwIa5hBADxA72MjZo1TuvnIh+Ih/3k7oyGpzDZBiLtZ5ffdUfNGhl+VhOI6qjviqb2W3YwMilbhWsRh9LVzQRDPTvtFMe3nyejdMpPMDORjCUq+wSsuBtWzaSq/JDiSvknhZBj8dVZiIk8ea8u3ZSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-431d84fdb91so20331255ab.3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 02:55:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761213302; x=1761818102;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3n236XZgAer2W5YqKCRhpb085gY3qepXWFjtDuUaDgg=;
        b=g7q6MFlgo11GSco2F8taIDBeGS1doIRgLjjdmHYsNhxO54Rwh6Tf+efwEAplAY/GEW
         +JXpy+flQT4ZPMl/c1yHJOe0vQRYDIOLVD/aoZZ07UOsgA+9Aq4SsLh0f5laLdSlHuJ2
         MredKrmEbEWfuATvMc0G/yDZW+jhrFfrQzAC44TqX6uIfKRsyciLP8O1YptxIMpP2026
         pDUf6mW4iuio6W73i18S2jzLL9OgLRogRxsDSzmPOm+Afr+QUx91faVdCUtw0sAJJcBZ
         1DMnnaM7xWQobb9BQ4BQn35bQfgWTJ4LS60NVx8eVKDut9Gc4avLzFeXU5RaKk/5qIYb
         CTLA==
X-Forwarded-Encrypted: i=1; AJvYcCUYQk7ApiCofPl+quHfMK01LLIMQVGOzyC3bRq31h3cCOYyGL0K05ae/Os8FNvKnz47nAUUIVsHmSgka7o=@vger.kernel.org
X-Gm-Message-State: AOJu0YxiR87yWSfyACWiqtK0NWJwEHUJqw7/EZcnYL1W56JByOaqLv5b
	sAjm4lTVW6z2AIuE3Nv0po7jJlBT/yF9gap0d9CeVsJn3NqmMAGSFjjwecq8ibYjirvOHbeOev6
	EIv/9OH04J62yJK4tWrX4/pxJYYDg6dDTkSOS13lQFSJZ7R8cjtire8IuLdE=
X-Google-Smtp-Source: AGHT+IEUyenbb5PSdPDjxWuPfEfNtM/iof8YBs8n5bDfq2cIKuKtdeEJqkbYqiNb3N5D+6HceOUWnXsV7rKQfQgh2ZkQeOeBOosW
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1605:b0:42f:9187:f6e0 with SMTP id
 e9e14a558f8ab-431dc16a124mr24644865ab.13.1761213302724; Thu, 23 Oct 2025
 02:55:02 -0700 (PDT)
Date: Thu, 23 Oct 2025 02:55:02 -0700
In-Reply-To: <CAPqLRf0D2bzcZ-c4RAmhX2vB9ZDxA3e5M1TVXBnMjokXSQm2Xw@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68f9fb76.050a0220.346f24.0075.GAE@google.com>
Subject: Re: [syzbot] [mm] KMSAN: uninit-value in sw842_compress
From: syzbot <syzbot+17cae3c0a5b0acdc327d@syzkaller.appspotmail.com>
To: kubik.bartlomiej@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
KMSAN: uninit-value in sw842_decompress

=====================================================
BUG: KMSAN: uninit-value in crc32_be_base lib/crc/crc32-main.c:46 [inline]
BUG: KMSAN: uninit-value in crc32_be+0x215/0x270 lib/crc/crc32-main.c:80
 crc32_be_base lib/crc/crc32-main.c:46 [inline]
 crc32_be+0x215/0x270 lib/crc/crc32-main.c:80
 sw842_decompress+0x2223/0x23e0 lib/842/842_decompress.c:385
 crypto842_sdecompress+0x46/0x60 crypto/842.c:53
 scomp_acomp_comp_decomp+0xa49/0x1120 include/crypto/internal/scompress.h:-1
 scomp_acomp_decompress+0x30/0x40 crypto/scompress.c:287
 crypto_acomp_decompress+0x5b4/0xe80 crypto/acompress.c:303
 zswap_decompress+0x684/0xf40 mm/zswap.c:968
 zswap_load+0x262/0x570 mm/zswap.c:1628
 swap_read_folio+0x662/0x3050 mm/page_io.c:637
 swap_cluster_readahead+0xa8c/0xb20 mm/swap_state.c:672
 swapin_readahead+0x1d9/0x15b0 mm/swap_state.c:813
 do_swap_page+0xce9/0x9c40 mm/memory.c:4713
 handle_pte_fault mm/memory.c:6180 [inline]
 __handle_mm_fault mm/memory.c:6318 [inline]
 handle_mm_fault+0x4100/0xded0 mm/memory.c:6487
 do_user_addr_fault+0x1777/0x2550 arch/x86/mm/fault.c:1336
 handle_page_fault arch/x86/mm/fault.c:1476 [inline]
 exc_page_fault+0x74/0xc0 arch/x86/mm/fault.c:1532
 asm_exc_page_fault+0x2b/0x30 arch/x86/include/asm/idtentry.h:618

Uninit was created at:
 __alloc_frozen_pages_noprof+0x689/0xf00 mm/page_alloc.c:5206
 alloc_pages_mpol+0x328/0x860 mm/mempolicy.c:2416
 folio_alloc_mpol_noprof+0x56/0x1d0 mm/mempolicy.c:2435
 __read_swap_cache_async+0x1f9/0x770 mm/swap_state.c:440
 swap_cluster_readahead+0xa0d/0xb20 mm/swap_state.c:669
 swapin_readahead+0x1d9/0x15b0 mm/swap_state.c:813
 do_swap_page+0xce9/0x9c40 mm/memory.c:4713
 handle_pte_fault mm/memory.c:6180 [inline]
 __handle_mm_fault mm/memory.c:6318 [inline]
 handle_mm_fault+0x4100/0xded0 mm/memory.c:6487
 do_user_addr_fault+0x1777/0x2550 arch/x86/mm/fault.c:1336
 handle_page_fault arch/x86/mm/fault.c:1476 [inline]
 exc_page_fault+0x74/0xc0 arch/x86/mm/fault.c:1532
 asm_exc_page_fault+0x2b/0x30 arch/x86/include/asm/idtentry.h:618

CPU: 1 UID: 0 PID: 4809 Comm: dhcpcd Not tainted syzkaller #0 PREEMPT(none) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/02/2025
=====================================================


Tested on:

commit:         43e9ad0c Merge tag 'scsi-fixes' of git://git.kernel.or..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=172213e2580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=42e68cb86cfb456e
dashboard link: https://syzkaller.appspot.com/bug?extid=17cae3c0a5b0acdc327d
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=13b8b734580000


