Return-Path: <linux-kernel+bounces-800412-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F6F6B43754
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 11:39:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0FAC91646D4
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 09:39:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46B762F745B;
	Thu,  4 Sep 2025 09:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M2MSX7LD"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F20126B2CE
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 09:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756978746; cv=none; b=ACdBJAEcFpHzo/SGDrtnoPr2HbmAGTLpB18P2tk6MUu06qIUfcwD6QRgChzxKGHptGq3AXzOJBWwxu/17ErpiPbiHWFEZvM0kp7L/Uy7OPOWk79QkIiWi+s8KnUDQxxC96FszAttZSF/qDGTZfnTqw7np1CfO6A9jAvcK0ajRj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756978746; c=relaxed/simple;
	bh=NCAmyg/53fyR8a4tBf+9uX+iCJGLLHyL1WlDUUOyhSI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GimZQHBp6FlOzKXZ+KK68mDLCfeod/C0mSYTk+ZLu/VYMYv3Abj4FELvUWTWDYitigaKRt8TYE/lryFKteFZDW6Vauj/Eh4djRsuVLnjyQxhklOJPgbdXn9sNFLpWPguPgD80am7thv8uEwO7WH+Z/IajKsBNRSm9zG+fU/+DT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=M2MSX7LD; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756978743;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=bBcU+drWJ3hvUYUB+y/OOMDGeoQSncTsSGslGzeSXlM=;
	b=M2MSX7LD5EeKvpKH2CCbjCwiPaBOqgtf5Sl68PxKq/8q9zigjQA4tlEMXA3zcvXrDESNJy
	qly4wUad4mJGM32M5nTVPcNRR4zhOpBsKHvYLupp+6tJYzbV/NRewa9K6mFxpPYwzsQoEJ
	uwppGqOjOfdCm/lTB+JbKGmuFNv3+iI=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-335-Z5NGx0EcPwy4NKr2ewnn8w-1; Thu, 04 Sep 2025 05:39:02 -0400
X-MC-Unique: Z5NGx0EcPwy4NKr2ewnn8w-1
X-Mimecast-MFC-AGG-ID: Z5NGx0EcPwy4NKr2ewnn8w_1756978740
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-329e375d372so1038644a91.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 02:39:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756978740; x=1757583540;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bBcU+drWJ3hvUYUB+y/OOMDGeoQSncTsSGslGzeSXlM=;
        b=iE35mU4GJSCbM83CCvf3VJz9dYNWGx8+qsnp9ssB+dyzOwuEUrP6jN+PVtP3XQfmuj
         QuWYz/IsYz95rda88E/1ok8LAqHRmVyrCNAPCGuT5f+94BTElMlEZss8hYUXFLpUtUg7
         o5t8hHLJPlJkvK8sYqpDHU0pep4qOH75KgTsw8QZAb5TauIq/782hQwH70EAvbnDTPYu
         C5uH+NggPEn94QoRNMKTwB98jlSUguVz/ybsj3lMbW7GVe54F9MPEFZ2/E/XJM2V7VKX
         fJfT/yfmGg1w3Y1Dnx/NmiJ2J+omAZ78NTc9gm2w77WxrQbpT3yMJ/eOVkN0c9JxzxEv
         cK4g==
X-Forwarded-Encrypted: i=1; AJvYcCXVNQONOMMnfmMXGGDPTYYTiaEE8Tgl4YYe9sNRJOBJlEXZdIV6vkoCSfnVkPnFckfnFJMW364SSnm2ouM=@vger.kernel.org
X-Gm-Message-State: AOJu0YymQ/Bcc4tcNyO8KX4I5qaidkwnlFrU7pbGTuQ6/1b5svgj1OIQ
	iL1NAJM5M7y//PGM2pYtE8DTe1VvG/D3YlsFDgoHIozRDyMloND++DAHf0TRYIH/9vb75F2zIvR
	TikXxzSrgzBjwUz6IqyV0n+JrQ2TxkRRaNgxLJysa+FalUhfJhu6GNhbJewbFnHDtAIukmAivoI
	L/Oq0=
X-Gm-Gg: ASbGncv3bhWPBRaqyB9Bn4VSPzNMH4DHSvCjBth0y/Bw+B4ZDLCL8N6eFQdhu1o0q7y
	FW/TCsEqnkypct2sLuGoDqlh1/we50a/f51xOFxsHtj9fu+kK9+6wsH3kbC0evhgg1/FbujRkap
	CoLhOTea8RH+J7Z6omloJvVaJwadT3KoIbqVt6Bls2v4YqYFdoxgaXgxZ2hB754nUyKAN23NRtV
	11J4baZdU+zdb9AMCCaKKi4ZPIoqXF2PXqJ63zllen2n/ttQ24wpQ9PXZTgxRyrXoKgzAtuU8LA
	qVeMjawkP8A8tT65qi7b/qlU3NWxt04=
X-Received: by 2002:a17:90b:38c5:b0:327:c207:b3fb with SMTP id 98e67ed59e1d1-328156cc954mr21219704a91.25.1756978740036;
        Thu, 04 Sep 2025 02:39:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEmAXPmAL5N6uswnGBHysh3EB25MAwxpg6uYHvn+wpMjFnTWn4DyTfl7/V8xNgx5Kkp7ntNlA==
X-Received: by 2002:a17:90b:38c5:b0:327:c207:b3fb with SMTP id 98e67ed59e1d1-328156cc954mr21219683a91.25.1756978739508;
        Thu, 04 Sep 2025 02:38:59 -0700 (PDT)
Received: from localhost ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-772396d2b97sm16676762b3a.67.2025.09.04.02.38.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Sep 2025 02:38:59 -0700 (PDT)
From: Coiby Xu <coxu@redhat.com>
To: kexec@lists.infradead.org
Cc: fuqiang wang <fuqiang.wang@easystack.cn>,
	x86@kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <bhe@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	linux-kernel@vger.kernel.org (open list:X86 ARCHITECTURE (32-BIT AND 64-BIT))
Subject: [PATCH v6 1/2] x86/kexec: fix potential cmem->ranges out of memory
Date: Thu,  4 Sep 2025 17:38:52 +0800
Message-ID: <20250904093855.1180154-1-coxu@redhat.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: fuqiang wang <fuqiang.wang@easystack.cn>

In memmap_exclude_ranges(), elfheader will be excluded from crashk_res.
In the current x86 architecture code, the elfheader is always allocated
at crashk_res.start. It seems that there won't be a new split range.
But it depends on the allocation position of elfheader in crashk_res. To
avoid potential out of memory in future, add a extra slot. Otherwise
loading the kdump kernel will fail because crash_exclude_mem_range will
return -ENOMEM. random kexec_buf for passing dm crypt keys may cause a
range split too,
add another extra slot here.

The similar issue also exists in fill_up_crash_elf_data(). The range to
be excluded is [0, 1M], start (0) is special and will not appear in the
middle of existing cmem->ranges[]. But in cast the low 1M could be
changed in the future, add a extra slot too.

Previously discussed link:
[1] https://lore.kernel.org/kexec/ZXk2oBf%2FT1Ul6o0c@MiWiFi-R3L-srv/
[2] https://lore.kernel.org/kexec/273284e8-7680-4f5f-8065-c5d780987e59@easystack.cn/
[3] https://lore.kernel.org/kexec/ZYQ6O%2F57sHAPxTHm@MiWiFi-R3L-srv/

Signed-off-by: fuqiang wang <fuqiang.wang@easystack.cn>
Signed-off-by: Baoquan He <bhe@redhat.com>
Signed-off-by: Coiby Xu <coxu@redhat.com>
---
v5->v6:
- rebase onto v6.17-rc4

v4->v5 (Baoquan):
- This is on top of Coiby's LUKS patchset in branch mm-nonmm-unstable of
  akpm/mm.git. I did some adaption based on Coiby's patches.
- [PATCH v9 0/8] Support kdump with LUKS encryption by reusing LUKS volume keys

 arch/x86/kernel/crash.c | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
index c6b12bed173d..5efdcd95a283 100644
--- a/arch/x86/kernel/crash.c
+++ b/arch/x86/kernel/crash.c
@@ -165,8 +165,18 @@ static struct crash_mem *fill_up_crash_elf_data(void)
 	/*
 	 * Exclusion of crash region, crashk_low_res and/or crashk_cma_ranges
 	 * may cause range splits. So add extra slots here.
+	 *
+	 * Exclusion of low 1M may not cause another range split, because the
+	 * range of exclude is [0, 1M] and the condition for splitting a new
+	 * region is that the start, end parameters are both in a certain
+	 * existing region in cmem and cannot be equal to existing region's
+	 * start or end. Obviously, the start of [0, 1M] cannot meet this
+	 * condition.
+	 *
+	 * But in order to lest the low 1M could be changed in the future,
+	 * (e.g. [start, 1M]), add a extra slot.
 	 */
-	nr_ranges += 2 + crashk_cma_cnt;
+	nr_ranges += 3 + crashk_cma_cnt;
 	cmem = vzalloc(struct_size(cmem, ranges, nr_ranges));
 	if (!cmem)
 		return NULL;
@@ -323,10 +333,15 @@ int crash_setup_memmap_entries(struct kimage *image, struct boot_params *params)
 	struct crash_mem *cmem;
 
 	/*
-	 * Using random kexec_buf for passing dm crypt keys may cause a range
-	 * split. So use two slots here.
+	 * In the current x86 architecture code, the elfheader is always
+	 * allocated at crashk_res.start. But it depends on the allocation
+	 * position of elfheader in crashk_res. To avoid potential out of
+	 * bounds in future, add an extra slot.
+	 *
+	 * And using random kexec_buf for passing dm crypt keys may cause a
+	 * range split too, add another extra slot here.
 	 */
-	nr_ranges = 2;
+	nr_ranges = 3;
 	cmem = vzalloc(struct_size(cmem, ranges, nr_ranges));
 	if (!cmem)
 		return -ENOMEM;

base-commit: b320789d6883cc00ac78ce83bccbfe7ed58afcf0
-- 
2.51.0


