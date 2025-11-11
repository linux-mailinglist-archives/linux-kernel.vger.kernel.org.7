Return-Path: <linux-kernel+bounces-895514-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EBF01C4E234
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 14:36:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 73FF1349537
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 13:36:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF5DC33ADB0;
	Tue, 11 Nov 2025 13:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bVm0+nW6"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC8F331BC82
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 13:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762868183; cv=none; b=F0OANYKatjgxx77w8NgHBFO2dusxQwJi0q6nyFY8pZTPB4dTwM2KpinpIYTQ8/hscobERMZkRu1YGgwqw/nfhRSh3JldnJOgSaM3FKPtmguvVpDLvCkhbrhnG8tFfPdphAqB960IxDLSRIN0UKNX2+MpMOpipiesAox4yUIMIcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762868183; c=relaxed/simple;
	bh=tb/o45k6NTZzp5Nk7GT0C9oDC7orJsd/WdpvbNYlIMU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=NA/xDFZWnRjqKCA/8mMZTpQFuKX0xV3PscZnsCyh7wC8AQWTu2/lv6EWUT8WmTjPI+Fc5i4x6mkjO2ZiVcXJTrMlt3iD2X469B/LeFJeUS4MPl+gaTtV1LX9BeVhMvBceT9gWinpqD+qbX+TCWDgWtnCsVtBFPnsFwjR0JN4zk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bVm0+nW6; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-7ae4656d6e4so5140289b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 05:36:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762868181; x=1763472981; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JSjWYrocQfwFaqc/FEuBHYlJesYb/9NVMF9Hr5o9yD0=;
        b=bVm0+nW6FbW+buyPJeOGSP+EHHQk4Q9MXvabZHfYPXwOpZvVLHKFLBbMxHSzZ8aHMu
         rHKyn6XoqYv6+n03gqhCwmtsHNzcM7uDfVyTS//Il0u1EAuMYJi+K6QG5gUlt0ivlY2I
         ejiFjgvnuXcxmMQ5xuccVQJUC13oTRpLOIhZpq5pMAktUWzf7YmZ2UwCg3sYouG1Okgr
         BK7t9M5nnU6nu8L3w52V2Ep6yrP2cAmUaAFpApK08aO0XQrIUI9cLfPlLO1zdd75fkTP
         jmN7/RVPqfxv69rNMMGiS0UaGsa1XTenzsiK2CNNiEfmmV5UHlcwXttI2DJG4JeK7J2f
         MZ8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762868181; x=1763472981;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JSjWYrocQfwFaqc/FEuBHYlJesYb/9NVMF9Hr5o9yD0=;
        b=n5xclOmhTioIMIWATgWRAhJZiv9giuOzBRpMzOd7IOqks/vRQRy/ooba1ERnS0qT7m
         vUFA81XBwf9XSN/LHebclCR07Ocpt8szfDen7lJKA3DWBesO8Xj73NWKQ2m1L3CT6cV3
         a764/vOArOcfqFAyikI6K32gIChDYZlhzd3w6ezyTzLf9pCzM8KQBAKendkWxU6/lTfb
         c3f/nQeCzRvDQ7Q5MGMB6qif5dA9Qkgq+4p8tgR5/zyfmkpBpZvmgZPN23mmLK1h2zP9
         02us2WE8/TIKxhj29NEVe9XlddmyhhCR4/9tiQepwY7OnNMX/l0Xn8Z/2aWqS8u67zXi
         NbDw==
X-Forwarded-Encrypted: i=1; AJvYcCWgvxZYTjx7m80UwFRNYKV40EivOOMrrC83wcZDSXLmcs0t53Ve595nqUNjmP0aPE84hm1FQ/HGv3vt6CA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbUe12RJt/TuPVdKvYu/V9BfRG/nnaL7S+VGq6Kc+F7QT1hvay
	aGUx7iBQfclHlZQSd3w0rYt5WQ0aAPPxdMN3ZSG7byZyQx2Z/ggV4upg
X-Gm-Gg: ASbGncvEiEFZaM5+iG+iJTywI05HFjO1+OIvo1vfUED08gLLUjboruRjsooUrm/53eD
	dTC9vQHrgdyI2igQXyzpuNck2jIXmd9kL1J1xVE/Ip4wFILH5ZB1KtVswBTtgHut+xkbu+Cq6+v
	UT6PWSShdrYUkmyOg3bqIbxkwQQeNq4LuGxdSgFC7K+ttiKaO+yXY8D4s0QYcqREc8GvU4aqhDs
	AKhjCDHB3jmrE4wQiwY/xXRWH/0rkcVF3XcsJO4u09Uf5JpAgzkCZCUL5FCicETz2YVl/JEkQiK
	Nb4kJkC93jDHYICode5apo+9cI+TuIiafy9f+bAU9yAPnjUBAIJw175NWcoOzwKazgoEjqX8JH7
	j/0fRvLEYjek5rzn6rEZBK2N3M6zed6PQnktEXI0iwpYHX6pGo+GYC4SR47IwT0VkvX89YePPhN
	nP+alI/gOsRb5M5qAPBCbJuIjGTmBlQtl+Qjhhgw==
X-Google-Smtp-Source: AGHT+IGb8HlE8JWSJkJpS1zcZZEBczySzg7b334mkzaQboKOCpDTMasE41mUoiJGlPM7Flg7CXU+DQ==
X-Received: by 2002:a05:6a20:7fa9:b0:351:118a:62a5 with SMTP id adf61e73a8af0-353a1ae304dmr16647492637.30.1762868180916;
        Tue, 11 Nov 2025 05:36:20 -0800 (PST)
Received: from [127.0.0.1] ([101.32.222.185])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b0c9ff74bfsm15512914b3a.27.2025.11.11.05.36.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 05:36:20 -0800 (PST)
From: Kairui Song <ryncsn@gmail.com>
Date: Tue, 11 Nov 2025 21:36:08 +0800
Subject: [PATCH] mm, swap: fix potential UAF issue for VMA readahead
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251111-swap-fix-vma-uaf-v1-1-41c660e58562@tencent.com>
X-B4-Tracking: v=1; b=H4sIAMc7E2kC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1NDINAtLk8s0E3LrNAty03ULU1M001KTTY3sDSzNDI1SFMCaisoSgVKg42
 Mjq2tBQBHfgxpYgAAAA==
X-Change-ID: 20251111-swap-fix-vma-uaf-bec70969250f
To: linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>, Chris Li <chrisl@kernel.org>, 
 Kemeng Shi <shikemeng@huaweicloud.com>, Nhat Pham <nphamcs@gmail.com>, 
 Baoquan He <bhe@redhat.com>, Barry Song <baohua@kernel.org>, 
 Huang Ying <ying.huang@linux.alibaba.com>, linux-kernel@vger.kernel.org, 
 Kairui Song <kasong@tencent.com>, stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762868177; l=2673;
 i=kasong@tencent.com; s=kasong-sign-tencent; h=from:subject:message-id;
 bh=HeLp2ZoEZDX3vftvgCEWtbgmeYKyB9IS5uu4bOi2WgY=;
 b=NP1wXB3s9uZ5LCa0q45CMtK5u/dbQ6VfiNSojUKk74bIoCx+/UuzY877LLypbYFnbaQsE5yWu
 5+x4bAONzQKCDhqfC//W4zhw1Ds+YK0ipI/5kAQRfxPapBT1qcI5Tpr
X-Developer-Key: i=kasong@tencent.com; a=ed25519;
 pk=kCdoBuwrYph+KrkJnrr7Sm1pwwhGDdZKcKrqiK8Y1mI=

From: Kairui Song <kasong@tencent.com>

Since commit 78524b05f1a3 ("mm, swap: avoid redundant swap device
pinning"), the common helper for allocating and preparing a folio in the
swap cache layer no longer tries to get a swap device reference
internally, because all callers of __read_swap_cache_async are already
holding a swap entry reference. The repeated swap device pinning isn't
needed on the same swap device.

Caller of VMA readahead is also holding a reference to the target
entry's swap device, but VMA readahead walks the page table, so it might
encounter swap entries from other devices, and call
__read_swap_cache_async on another device without holding a reference to
it.

So it is possible to cause a UAF when swapoff of device A raced with
swapin on device B, and VMA readahead tries to read swap entries from
device A. It's not easy to trigger, but in theory, it could cause real
issues.

Make VMA readahead try to get the device reference first if the swap
device is a different one from the target entry.

Cc: stable@vger.kernel.org
Fixes: 78524b05f1a3 ("mm, swap: avoid redundant swap device pinning")
Suggested-by: Huang Ying <ying.huang@linux.alibaba.com>
Signed-off-by: Kairui Song <kasong@tencent.com>
---
Sending as a new patch instead of V2 because the approach is very
different.

Previous patch:
https://lore.kernel.org/linux-mm/20251110-revert-78524b05f1a3-v1-1-88313f2b9b20@tencent.com/
---
 mm/swap_state.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/mm/swap_state.c b/mm/swap_state.c
index 0cf9853a9232..da0481e163a4 100644
--- a/mm/swap_state.c
+++ b/mm/swap_state.c
@@ -745,6 +745,7 @@ static struct folio *swap_vma_readahead(swp_entry_t targ_entry, gfp_t gfp_mask,
 
 	blk_start_plug(&plug);
 	for (addr = start; addr < end; ilx++, addr += PAGE_SIZE) {
+		struct swap_info_struct *si = NULL;
 		softleaf_t entry;
 
 		if (!pte++) {
@@ -759,8 +760,19 @@ static struct folio *swap_vma_readahead(swp_entry_t targ_entry, gfp_t gfp_mask,
 			continue;
 		pte_unmap(pte);
 		pte = NULL;
+		/*
+		 * Readahead entry may come from a device that we are not
+		 * holding a reference to, try to grab a reference, or skip.
+		 */
+		if (swp_type(entry) != swp_type(targ_entry)) {
+			si = get_swap_device(entry);
+			if (!si)
+				continue;
+		}
 		folio = __read_swap_cache_async(entry, gfp_mask, mpol, ilx,
 						&page_allocated, false);
+		if (si)
+			put_swap_device(si);
 		if (!folio)
 			continue;
 		if (page_allocated) {

---
base-commit: 565d240810a6c9689817a9f3d08f80adf488ca59
change-id: 20251111-swap-fix-vma-uaf-bec70969250f

Best regards,
-- 
Kairui Song <kasong@tencent.com>


