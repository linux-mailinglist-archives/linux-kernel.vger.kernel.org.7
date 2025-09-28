Return-Path: <linux-kernel+bounces-835206-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B48C9BA67FF
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 06:52:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A0353B5D3F
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 04:52:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51C4F2222BA;
	Sun, 28 Sep 2025 04:52:20 +0000 (UTC)
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E50D1DE3B7
	for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 04:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759035139; cv=none; b=pr/5EhpbyuP4lJjjRxdQHv0UKFdeN3EzpsiqCMmRoKJvaoMpOMIlIPaSF+C7ZPy1QJmnKyCxRnLKfcK+j4GMjat83Jmv1tWnlEPJxJqJ+EspFyvT7Oid9G3Xts1r9bveRJLL1TwZG8bn56j4/0p0ObD/M2mcH0tt7e8V7wYeyo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759035139; c=relaxed/simple;
	bh=V579NiAWyFA7M0hzU3TLmxji9AamGpMvr2IJYgPsK28=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=O4Ssvzien6g7ZEASkuGR4uVWqVSTFIdQbxewa5BRpJzXV83lnNIkzboiuRMYTrlz1UFS+osNDhJBKWzZKW2MEslxyD43Nr0d/gg88b12BSIz/dZRIIO5WORt9hrZ8n4hV/rrD6NYBFWMmlzzDi3Bm62kUnkpGYrkKBQ/rC1vsMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3ee13baf2e1so2669231f8f.3
        for <linux-kernel@vger.kernel.org>; Sat, 27 Sep 2025 21:52:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759035135; x=1759639935;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MDeTOOsx+C00FUGoSTYTsfkYGe7/IDMgbdTfsuLqCIw=;
        b=uN8W6HVU3EDqZ1/aF3C6kT36jBluCtZqPX0Cv8EDjZyR5u1Mm9VOARKf5e5J2PzUZG
         9gSszvZsaknFOq6trx/wVF59KYDS9nAi/ximuLpf/fHrHL7cseESlsDsjhI3GWGmz3dN
         5hVlsLJvcFCF775N1jXhrEOEYhfC3dU4qlRdUuzTIKF6OLv2J4WGUA7ny6PvPY1K4tdq
         ae1iRSBzE7SyOY/Alz66WTs7I28T7L4XH08nnSd7qVAGAN+iYROUoBZQtaI7bNKHXisM
         co0+SKiKaBO/Ysi0Je5G7wBd546eagrNiKw4+a0bkdnz1kFeO7j76MRO76SmuIFVqqWu
         Gg9g==
X-Forwarded-Encrypted: i=1; AJvYcCV+vACmUrlTSlEi8uCveG3zHezEt8so5lHdy8og0ZIs1PMx8LfELEHwP1d5BtYWTz+yqVQEmdSjNZVz8so=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJ7COaT5mVxUwpAgEqXdxrzX4HccIJZE7EGNrBEpdosjgba/KE
	8X9+YkJljFKV2Pa5j5fw7iiovILWDnqb1HJevrpMl0TbTWel7IQynVH5
X-Gm-Gg: ASbGncsXBBn+Oa+VDOqVHSPKApUm0ffLiDRP9eqjSgJEQFJLvjSCHT6k7dSij/nsZTB
	aYGE8V0o/ZDPI/xgxFF9T6AkN9raSmengTLj2CSG/YD1+nLxE4ez8fQ2UrjxL6xbW1SIjOZW9LM
	xqzNgc8tpryYMK/+1QzstEs0FJTszwgbkB46pfQ8E35g0YTAPGUpin0fqFkie4ssIZfkHsTh5oX
	e9cSVRytmNNpfmcKERetGXhaYVLcdDnNnE6aPmUnFZ3wmf9syp2HViVwfSl5mWj2WlosraJQI7l
	5HlRXJ0dekupVDzuPCeA3kXqHL7H1RfG8IYZvCTh+4gWkM9aXxheP8aMZRG2KXlpRKZemMvez3b
	HvAwaPbfHppbz
X-Google-Smtp-Source: AGHT+IHVzH6CutqdZ2xPOWXvoxdwHZpW8hcV6MdTmJ329VCEuu3lj8BtnISnCCqCDPg2So93Cnj9wg==
X-Received: by 2002:a05:6000:22c2:b0:3ea:3b7b:80bb with SMTP id ffacd0b85a97d-40e4ce4c5f2mr10247690f8f.58.1759035135383;
        Sat, 27 Sep 2025 21:52:15 -0700 (PDT)
Received: from EBJ9932692.tcent.cn ([2a09:0:1:2::302c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-40fc5602efdsm13539465f8f.34.2025.09.27.21.52.12
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 27 Sep 2025 21:52:15 -0700 (PDT)
From: Lance Yang <lance.yang@linux.dev>
To: akpm@linux-foundation.org,
	david@redhat.com
Cc: xu.xin16@zte.com.cn,
	chengming.zhou@linux.dev,
	ran.xiaokai@zte.com.cn,
	yang.yang29@zte.com.cn,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	ioworker0@gmail.com,
	Lance Yang <lance.yang@linux.dev>
Subject: [PATCH 1/1] mm/ksm: fix spurious soft-dirty bit on zero-filled page merging
Date: Sun, 28 Sep 2025 12:52:07 +0800
Message-ID: <20250928045207.78546-1-lance.yang@linux.dev>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lance Yang <lance.yang@linux.dev>

When KSM merges a zero-filled page with the shared zeropage, it uses
pte_mkdirty() to mark the new PTE for internal accounting. However,
pte_mkdirty() unconditionally sets both the hardware dirty bit and the
soft-dirty bit.

This behavior causes false positives in userspace tools like CRIU that
rely on the soft-dirty mechanism for tracking memory changes.

So, preserve the correct state by reading the old PTE under the page
table lock and explicitly clearing the soft-dirty bit from the new PTE
if the original was not soft-dirty.

Fixes: 79271476b336 ("ksm: support unsharing KSM-placed zero pages")
Signed-off-by: Lance Yang <lance.yang@linux.dev>
---
 mm/ksm.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/mm/ksm.c b/mm/ksm.c
index 04019a15b25d..e34516b8fbe4 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -1403,6 +1403,9 @@ static int replace_page(struct vm_area_struct *vma, struct page *page,
 		 * the dirty bit in zero page's PTE is set.
 		 */
 		newpte = pte_mkdirty(pte_mkspecial(pfn_pte(page_to_pfn(kpage), vma->vm_page_prot)));
+		if (!pte_soft_dirty(ptep_get(ptep)))
+			newpte = pte_clear_soft_dirty(newpte);
+
 		ksm_map_zero_page(mm);
 		/*
 		 * We're replacing an anonymous page with a zero page, which is
-- 
2.49.0


