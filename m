Return-Path: <linux-kernel+bounces-740459-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 73FB0B0D464
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 10:22:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 666D47A85E0
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 08:20:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54BC62D9EF2;
	Tue, 22 Jul 2025 08:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QkFjxDID"
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48B192D97A2
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 08:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753172511; cv=none; b=EkkC73CUEjoYFma5HFA+ZXMXB8lJjEW5cu0FLSffKUmvETyF6p8Ai7ak14LUkbH+PvZZ8hvHqVz7IbZ9oGUE6lAXtJGAotNgtbJpomPEx1N/F7DDh0QnLFEAvQvpXcNXvacwEL+hrPUzwRotYdkVhLHtAJv2h+3lGiiTdD0ips0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753172511; c=relaxed/simple;
	bh=EkjBKYNUb0p/xaXKO8e3OpXfbQY4O4HZvcyVlt/rpUE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JYU39YU5V1tSyLhxJzGdJMuiDPsiQAZwU4t9G/2ilGHW2n2b3uqjXFeVQsgK/aJBUaAS1iyQ3bi/RiI1vxD8f0tlc0QYKowA9X6JqnW2VDEBEzroAjYZRzBwGOcMkRLPSmLC3ylPs15yDgCJxvCS6uuuKwl7WVv1FR4m1H0h/f8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QkFjxDID; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-3137c20213cso4829662a91.3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 01:21:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753172509; x=1753777309; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Mvsu2vjVRIsk6oZmKXVbnoH+nR7s7OCeL0T9nIIghGo=;
        b=QkFjxDIDePa+sg9l57MrgbnBOzUwVS7uDdDkDK8NZzcz71FMJsx3Zdc3etrM3xcF1l
         7l8kfxGME6j+19yJvdp/co3OLLOeeSJ+gkDUPp2kOEAK1sRphSSlrGpvkrkVNIY/csZP
         AqjrKTFnpufl9PEnJQoiJzVTE61hyx5LH5syzGFHju36jjZ7El/8Z7xO/Q6KwU+F0fVf
         T+c50c0MfTc7FkdYDBtzxB+LFW8QZi9QFXuX+MtBaGIhYFZRHA9QlEbEZ9/sm7ywJM1c
         fWBAYdS79CjLNiAIGhHlsQQEAhfjf39VGvTV80npbUA/i8cEgfKGf+YJArofxwjikvRw
         MASw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753172509; x=1753777309;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Mvsu2vjVRIsk6oZmKXVbnoH+nR7s7OCeL0T9nIIghGo=;
        b=RNQ+LwUdQdxtaQ3VK1K/ueTOqEYG/lX5d0f3zb8EhUx1lwdg47RVAZ1k+HXWyoLu7b
         58nRaUacnFrBQwcCmapExlV2ieQdg2G/yWvVEso2H8BbTOoKNPC+R5kTTjI9k6mlLUgH
         +pTVvSyPIHAOUGzvN7ba6MbYLURKAIeElAknWkE9PakzjGiPArqwUGxseVUXw3nGQBg0
         f0lP1xhU3TxKwwgxoPqghsJQl9iqBhItAmdNa1773VZQ3L3otHzo3WL3PeUUrwHoD6MA
         2eyeN+nfrzVIBPFABytb1fQWIIiwQ+uiVHVdygJizPJQ8Ods1imKbW+ysSQJ31FNq81z
         UjmA==
X-Forwarded-Encrypted: i=1; AJvYcCUrzHaMuNcvUVNzriuhjOOFMM1UhYpUhVvDx8O5WhDTej4/6GV9tWygLi1e9qgg1vUsrYMGCjLT9gGU+eE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbgdQLBuKXYFruYtLGXyjdTxvCXEdKHnZ9kkw0SYHUcMhChc2Q
	ZHbK4tVLwYo/JJGe80X9Ad+8WERAyr1jhaKfoNWbXsWyLGV3KNDNuE4M
X-Gm-Gg: ASbGncv8u7CCVIqgli4fXndm5c7cxpeZN1LYMmC0m3XXcQUr5G2m5qRmGt59As3YpvT
	P2gM0KFXLh5r/WLugAFEo6ptdojQSvCUh6hGjyxctZhEHelcFwhSG09g0w9qxvKG645ZxTsSQEh
	Mc1p3/utwmyZFZ3/sNCN4CHGOIWuQQIP8Cv9gzlkkWiIG1TcHBI9ISK8KEaFo8bwRWWbIHAskcw
	RT82HvSQ6aX183v0+845WjMNoqBFvbh/tv8yvrE42ilT6VVs9xWW1BdyaXmmG4ZSJkW5K/2Q5a0
	7m/Z4OS4KCj3sksEmKzCXNoTZbqI+fj/y3zrsuqkp++2zvGLlQFB6S5ZUP8ZEyIxP6/iZSRbZsB
	BieWSCxeI1P7s9VjdyRZdYR6Q0zBGol+bz788tx1GFcSSLA==
X-Google-Smtp-Source: AGHT+IEjJOxKFCMA/W05J86dcoXFeTq9z2VaU8ffTPvx80au0umrXWr+q+XebdIcsaID7+0UviaoUw==
X-Received: by 2002:a17:90b:5485:b0:311:b0ec:135b with SMTP id 98e67ed59e1d1-31c9f47c799mr33546230a91.24.1753172509476;
        Tue, 22 Jul 2025 01:21:49 -0700 (PDT)
Received: from localhost.localdomain ([36.110.106.149])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23e3c3a5d15sm70337265ad.62.2025.07.22.01.21.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jul 2025 01:21:49 -0700 (PDT)
From: Weikang Guo <guoweikang.kernel@gmail.com>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Marc Zyngier <maz@kernel.org>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Weikang Guo <guoweikang.kernel@gmail.com>,
	Ard Biesheuvel <ardb@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: mm: Ensure phys_to_ttbr on pgdir for idmap_cpu_replace_ttbr1
Date: Tue, 22 Jul 2025 16:21:13 +0800
Message-Id: <20250722082117.1777570-1-guoweikang.kernel@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 5ffdfaedfa0a ("arm64: mm: Support Common Not Private translations")
changed the contract of idmap_cpu_replace_ttbr1, requiring that the TTBR
argument passed in should already be processed by phys_to_ttbr (i.e., in
TTBR format, not just a raw physical address).

However, the current map_kernel implementation does not always convert the
pgdir/ttbr argument via phys_to_ttbr before calling
idmap_cpu_replace_ttbr1. This can lead to issues on systems with
CONFIG_ARM64_PA_BITS_52 enabled, as the TTBR would not be properly folded
per the ARMv8.2+ requirements.

Signed-off-by: Weikang Guo <guoweikang.kernel@gmail.com>

---
Note: I do not currently have access to ARM64 hardware or an emulation
environment that supports 52-bit physical address (PA52). I would
greatly appreciate if anyone with such a platform could help test
this patch. Thank you!
---
 arch/arm64/kernel/pi/map_kernel.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/kernel/pi/map_kernel.c b/arch/arm64/kernel/pi/map_kernel.c
index 0f4bd7771859..05a04eb91e81 100644
--- a/arch/arm64/kernel/pi/map_kernel.c
+++ b/arch/arm64/kernel/pi/map_kernel.c
@@ -18,7 +18,7 @@
 
 extern const u8 __eh_frame_start[], __eh_frame_end[];
 
-extern void idmap_cpu_replace_ttbr1(void *pgdir);
+extern void idmap_cpu_replace_ttbr1(phys_addr_t);
 
 static void __init map_segment(pgd_t *pg_dir, u64 *pgd, u64 va_offset,
 			       void *start, void *end, pgprot_t prot,
@@ -90,7 +90,7 @@ static void __init map_kernel(u64 kaslr_offset, u64 va_offset, int root_level)
 		    true, root_level);
 	dsb(ishst);
 
-	idmap_cpu_replace_ttbr1(init_pg_dir);
+	idmap_cpu_replace_ttbr1(phys_to_ttbr((u64)init_pg_dir));
 
 	if (twopass) {
 		if (IS_ENABLED(CONFIG_RELOCATABLE))
@@ -129,7 +129,7 @@ static void __init map_kernel(u64 kaslr_offset, u64 va_offset, int root_level)
 	/* Copy the root page table to its final location */
 	memcpy((void *)swapper_pg_dir + va_offset, init_pg_dir, PAGE_SIZE);
 	dsb(ishst);
-	idmap_cpu_replace_ttbr1(swapper_pg_dir);
+	idmap_cpu_replace_ttbr1(phys_to_ttbr((u64)swapper_pg_dir));
 }
 
 static void noinline __section(".idmap.text") set_ttbr0_for_lpa2(u64 ttbr)
-- 
2.25.1


