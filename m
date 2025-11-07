Return-Path: <linux-kernel+bounces-890130-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E8C9CC3F497
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 11:00:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6C78B34D1EC
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 10:00:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FBC31FF1B4;
	Fri,  7 Nov 2025 10:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b="UlUdj4FH"
Received: from pdx-out-014.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-014.esa.us-west-2.outbound.mail-perimeter.amazon.com [35.83.148.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 174FF747F
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 10:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.83.148.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762509631; cv=none; b=qUV7jM4xzpoddJrvz/bJSUkOrIx4RrY4P7BD1tVBkz0nno0hFTd3yGsgWD+wosYyjwZ8aeNyuHvpMRf8HtUA8MN0kRuDB+jp2nZRxlyWZ7efTaDL5To3uvbVUSbr86BvRe65LBGVBDS5gKROCrbXkvzfc0jTQaXQaVNeaBEHPD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762509631; c=relaxed/simple;
	bh=m/8zPMzO3sPR9cj9Hm3+C+88lHXxhZaRiogKHxQ1V3s=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=b+7zRYXj6vi0kxHZwAFwg58fcMFfUIkeWsgZij4QI/c3g90UI1E2T4Iuwuw8gNRwnUorE7X/HdFdWbxKhVJplKO0cTKqfxQBp35H5rCt2bjvpI36aGvScHbAUBBuyZuqCliMPzmXkY0v7I7BNfb+6IP3J48VgKKe+K9gTnj0qHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.de; dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b=UlUdj4FH; arc=none smtp.client-ip=35.83.148.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1762509630; x=1794045630;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=gaK6pACLGs/VVG2+bcRoCnqyEjxUer7HCt5ZvlpCNPw=;
  b=UlUdj4FHC1/qRLV3rVGjdcWIVmEnmhCNQphThtGQ5DUR1pj9wwIxg27q
   Th+3rr7yJpw+UZhvSzYzL4DMJObyUXPbodDniKUIcNm2rbDgtwkys9kXp
   ZGt+CugRQKy9hHJP/QWh/+iQW3ZDjXYk4k22Jh7eJzj1E+HcyKwn2Hd/L
   Ktc2/7lNRL86umiZqU4JphO8TKL2UcBIwSn3BxYXFyyhMkO+DibCG6haF
   WxF42tAAHnLUoq9t9+JKVkxIJ7dzAa3UdzA+m1ckbaDXQzchF1kO/R2FU
   rfZnhecXgLdc/3DlKB39aGOPhqslQOPZITK68RkALrch2c7qYp7SlXKOA
   Q==;
X-CSE-ConnectionGUID: OVlOEeg8RvG25Gv2lNLChA==
X-CSE-MsgGUID: qkPF/1d8QmqgeYjOBuW/GA==
X-IronPort-AV: E=Sophos;i="6.19,286,1754956800"; 
   d="scan'208";a="6408377"
Received: from ip-10-5-9-48.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.9.48])
  by internal-pdx-out-014.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2025 10:00:27 +0000
Received: from EX19MTAUWA002.ant.amazon.com [205.251.233.234:19663]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.51.49:2525] with esmtp (Farcaster)
 id 45571d5a-eff0-4b9f-8095-e0e4bc963290; Fri, 7 Nov 2025 10:00:27 +0000 (UTC)
X-Farcaster-Flow-ID: 45571d5a-eff0-4b9f-8095-e0e4bc963290
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.29;
 Fri, 7 Nov 2025 10:00:27 +0000
Received: from dev-dsk-simonlie-1b-d602a7e1.eu-west-1.amazon.com
 (10.13.232.104) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.29; Fri, 7 Nov 2025
 10:00:25 +0000
From: Simon Liebold <simonlie@amazon.de>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>, Simon Liebold
	<lieboldsimonpaul@gmail.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH RESEND] x86/mm: lower MAP_32BIT begin to reduce heap collisions
Date: Fri, 7 Nov 2025 10:00:04 +0000
Message-ID: <20251107100004.66240-1-simonlie@amazon.de>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ClientProxiedBy: EX19D037UWC004.ant.amazon.com (10.13.139.254) To
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
    Re-sending after rebasing and re-testing on v6.18-rc4
    
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
    
    This is an excerpt from the output of one of the failure cases on real
    workloads:
    
        00400000-00566000 r-xp 00000000 103:01 4476567               [...]/bin/httpd.orig
        00765000-0076b000 r--p 00165000 103:01 4476567               [...]/bin/httpd.orig
        0076b000-00772000 rw-p 0016b000 103:01 4476567               [...]/bin/httpd.orig
        00772000-00778000 rw-p 00000000 00:00 0
        34a21000-35021000 rw-p 00000000 00:00 0                      [heap]
        35021000-82ea7000 rw-p 00000000 00:00 0                      [heap]
        7fee7c0ba000-7fee7c11f000 r-xp 00000000 103:01 3836609       [...]/lib/libluajit-5.1.so
        7fee7c11f000-7fee7c31f000 ---p 00065000 103:01 3836609       [...]/lib/libluajit-5.1.so
        7fee7c31f000-7fee7c321000 r--p 00065000 103:01 3836609       [...]/lib/libluajit-5.1.so
        7fee7c321000-7fee7c322000 rw-p 00067000 103:01 3836609       [...]/lib/libluajit-5.1.so
        [Other maps at high addresses...]

 arch/x86/kernel/sys_x86_64.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/sys_x86_64.c b/arch/x86/kernel/sys_x86_64.c
index 776ae6fa7f2d6..29c6277aa31e6 100644
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

base-commit: 4a0c9b3391999818e2c5b93719699b255be1f682
-- 
2.47.3




Amazon Web Services Development Center Germany GmbH
Tamara-Danz-Str. 13
10243 Berlin
Geschaeftsfuehrung: Christian Schlaeger, Christof Hellmis
Eingetragen am Amtsgericht Charlottenburg unter HRB 257764 B
Sitz: Berlin
Ust-ID: DE 365 538 597


