Return-Path: <linux-kernel+bounces-784541-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DF8C9B33D26
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 12:49:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 057F47AE9D2
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 10:47:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51F772D8795;
	Mon, 25 Aug 2025 10:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b="XZffYDqF"
Received: from pdx-out-015.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-015.esa.us-west-2.outbound.mail-perimeter.amazon.com [50.112.246.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6E5E28C035
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 10:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=50.112.246.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756118942; cv=none; b=ZnQ2NuP10ManxD8SFTVOu3uwGszKirFIDd/VfGDL3u6tBZX7Zq3Yde8EdoFtW3OhjR0t6Zv6SggNEmSaY7jt1KTJR1MO5NdwmbtuYqF1/Gbu0sEKEl+7onXJ+54YnQ7l8zk7WSZ29WWNe+JVdndckGpkrU2zKgvxeX/9gPmFJMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756118942; c=relaxed/simple;
	bh=WeW5HSSfHAdF9NF0VXfP5qQtx11Z+DmAozfk2DT7bN0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hMTcXSsF7xp6aaUFVu4BFUMnDzF2DgGuxU1U/GoF7fzc9vfGP/Jf7uG1LgLcknSkt7/6Jsc4al9vcIk5I5BHr+LnmJg8KCeIHx8sets5iLiSBTPprlnbDWWq77AbEk0T6a37ok+1Wmwb3eK7f9VIuczuWIhxbP1SZ2KwE3cgnss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.de; dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b=XZffYDqF; arc=none smtp.client-ip=50.112.246.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1756118940; x=1787654940;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=D4roSe/NK9tFYGpEA7rB0f695B7PIUgnywAv4R//8oI=;
  b=XZffYDqFSoCtD5LiCt+txgjbO+eJwN0hsfY2LT42cQEK5jEVOZa7NQ+A
   xhwvz1p2PwLq9JnPxr8xhvvzaTY3msxixMV7woGZs/nMOGw8EYj2+oFzW
   eaRe6iyyPtDoi88mezZ4vsyHqLy62SPMVSaBf/u2NxgIlaQPDbW1p5VkZ
   dL0DiT8mpwpA+oj82f4GDadcLu7CcMzrruFcyhC7rIVq+D6KuZHDV4KNH
   hh2Phf9eY6oeDsu8cklfL4VKb1RxiCMD+22PqoAf6ltCEyh7ql4t3R+gt
   jwyLQi3ckuCrknvM82bljVDNJzgTRFWISF9xDMHbcyyPkFDOD/M+IIkJU
   Q==;
X-CSE-ConnectionGUID: OnnqOa4+ToK2afgf2QDQRA==
X-CSE-MsgGUID: CePU6LTpTqSWcBGjeKgvlg==
X-IronPort-AV: E=Sophos;i="6.17,312,1747699200"; 
   d="scan'208";a="1616714"
Received: from ip-10-5-12-219.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.12.219])
  by internal-pdx-out-015.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2025 10:48:58 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.38.20:3577]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.29.152:2525] with esmtp (Farcaster)
 id 484d78d4-786c-451f-98ab-973734c58a95; Mon, 25 Aug 2025 10:48:58 +0000 (UTC)
X-Farcaster-Flow-ID: 484d78d4-786c-451f-98ab-973734c58a95
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.17;
 Mon, 25 Aug 2025 10:48:58 +0000
Received: from dev-dsk-simonlie-1b-d602a7e1.eu-west-1.amazon.com
 (10.13.232.104) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.17; Mon, 25 Aug 2025
 10:48:56 +0000
From: Simon Liebold <simonlie@amazon.de>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>
CC: <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Andrew Morton
	<akpm@linux-foundation.org>, Mark Brown <broonie@kernel.org>, Lorenzo Stoakes
	<lorenzo.stoakes@oracle.com>, Helge Deller <deller@gmx.de>, "Liam R. Howlett"
	<Liam.Howlett@Oracle.com>, Simon Liebold <lieboldsimonpaul@gmail.com>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH] x86/mm: lower MAP_32BIT begin to reduce heap collisions
Date: Mon, 25 Aug 2025 10:48:44 +0000
Message-ID: <20250825104847.36669-1-simonlie@amazon.de>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ClientProxiedBy: EX19D040UWB004.ant.amazon.com (10.13.138.91) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Commit 03475167fda5 ("x86: Increase brk randomness entropy for 64-bit
systems") increased the brk randomness from 32 MiB to 1 GiB. MAP_32BIT
looks between 1 GiB and 2 GiB for an unmapped area. Depending on the
randomization, a heap starting high enough and being big enough can use
up all the area that MAP_32BIT looks at, leading to allocation failures.

For example, if the heap starts at 800 MiB and is 1.2 GiB large,
allocations with MAP_32BIT will always fail despite unused addresses
below 800 MiB.

Lower the begin of the address space which is available to MAP32_BIT
from 0x40000000 to 0x10000000 to give mmap more room if the randomly
allocated brk address turns out to be unfavourable high. This allows
mmap to allocate up to 75% more space.

Signed-off-by: Simon Liebold <simonlie@amazon.de>
---

Notes:
    Background: LuaJIT v2.0 uses MAP32_BIT for allocating memory. Because of
    the restriction of MAP32_BIT to limit all allocation of mmap to the
    address space from 1 GiB to 2 GiB, LuaJIT v2.0 can fail to work,
    depending on the random location of brk.
    
    I tested this change using the following reproducer:
    
    int main() {
        uintptr_t mmap_end = 0x80000000;
        uintptr_t heap_start = (uintptr_t)sbrk(0);
        printf("heap start: %p\n", heap_start);
        uintptr_t alloc_size = mmap_end - heap_start;
        uintptr_t heap_end = (uintptr_t)sbrk(alloc_size);
        printf("heap allocated until: %p\n", heap_end);
        void* addr = mmap(NULL,
            8,
            PROT_READ | PROT_WRITE,
            MAP_PRIVATE | MAP_ANONYMOUS | MAP_32BIT,
            -1,
            0);
    
        if(addr == MAP_FAILED)
            printf("mmap allocation failed\n");
        else
            printf("mmap allocation at %p\n", addr);
    
        return 0;
    }
    
    Before the change, the allocation failed:
        [root@localhost ~]# ./repro
        heap start: 0x24bce000
        heap allocated until: 0x24bef000
        mmap allocation failed
    
    After the change, it succeeded:
        [root@localhost ~]# ./repro
        heap start: 0x38f24000
        heap allocated until: 0x38f45000
        mmap allocation at 0x11962000
    
    Note that this does not guarantee to succeed. If the randomized heap
    start is below 0x10000000, it still fails.

 arch/x86/kernel/sys_x86_64.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/sys_x86_64.c b/arch/x86/kernel/sys_x86_64.c
index 776ae6fa7f2d..29c6277aa31e 100644
--- a/arch/x86/kernel/sys_x86_64.c
+++ b/arch/x86/kernel/sys_x86_64.c
@@ -100,7 +100,7 @@ static void find_start_end(unsigned long addr, unsigned long flags,
 		   conflicts with the heap, but we assume that glibc
 		   malloc knows how to fall back to mmap. Give it 1GB
 		   of playground for now. -AK */
-		*begin = 0x40000000;
+		*begin = 0x10000000;
 		*end = 0x80000000;
 		if (current->flags & PF_RANDOMIZE) {
 			*begin = randomize_page(*begin, 0x02000000);

base-commit: 260f6f4fda93c8485c8037865c941b42b9cba5d2
-- 
2.47.3




Amazon Web Services Development Center Germany GmbH
Tamara-Danz-Str. 13
10243 Berlin
Geschaeftsfuehrung: Christian Schlaeger, Jonathan Weiss
Eingetragen am Amtsgericht Charlottenburg unter HRB 257764 B
Sitz: Berlin
Ust-ID: DE 365 538 597


