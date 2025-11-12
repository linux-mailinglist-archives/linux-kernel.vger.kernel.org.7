Return-Path: <linux-kernel+bounces-896662-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DCEDC50EAB
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 08:24:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 842AB1897D96
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 07:25:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50F942C0293;
	Wed, 12 Nov 2025 07:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZVtZmY44"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCA4328B7DB
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 07:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762932274; cv=none; b=V2KQx4UpS/omoF0/iewqU7DAZm3DfU6N7NWVe9g8g7dktrWBpr/rAut9NMMs1y5WmIjIsWTluPK/YSBcpHk9tgfEXFMhSL/4/hNrVVsfCF+PnoYDA7USk3zOgF1PpRZTh0dk4gdGUCgysBhGoV48hvgUIlW5CaYKqP9xKixVFTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762932274; c=relaxed/simple;
	bh=wX/TVCUhFVt17oMlYXH/ecmu84amuQAfHBZJn8s7Qz8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KLNiDTDVmhu5r0m9oLKgzD9QK38dB6UwJogsjPRtRXm7eKBK3BPC8BVn9sn9wHFm4f93Dm8lLmtro26cTuNYoHN8ysQt5wG/inWZgrD3WZbgSswYfrUtj6PItnjPQBPBXNX9x2gQUQKdZ/EJB1ZaVrb3o9sgxKG50cj+ZiTU4L0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZVtZmY44; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-7a9fb6fccabso431369b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 23:24:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762932272; x=1763537072; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gHjs64x1sYM8PIf291RcKqDCzlklmWGwXUXJRSFHLCg=;
        b=ZVtZmY44KKYSL7mhRIQBF8o/60qxf9qyxjN1UDXsrG5RQ42P2aH6Km3RIbJ6xqleuz
         zTDrDpGXht8jW1OMv3QU1O4sR8XCAw+4EAxGRW+xIUoiAFdpNGQgfgnTH1QXINGcZ+7Y
         +LlBlMhcGqe961YdAs7giHF2C3lpS3QmRd9cbxb2rDWvQigXbOZszKhV54f8JyP8yXt1
         xU2e5JpWqqglTphfX7cXp5zDVSFOOzztkh7+/ldNR2a4Mqk6UgW9uGraW9tCswiIRfdj
         uqDl1sXG0gi/KIg2umUb+mOGcxY+E0NIMtOe+AAz97S8/cYHtaEk3/lUKN/b0QWyz1Ob
         uEeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762932272; x=1763537072;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gHjs64x1sYM8PIf291RcKqDCzlklmWGwXUXJRSFHLCg=;
        b=q8cOln8a59JgFl6Uvj2rQXLoRh9if70Gw/mcavI4e/w8dyksHgwIkfElhVCpk2hqBt
         AW+LTTo46iR36lIPfD2ggg55hrOE41BduNVnQSJkgU36f4YSoCdQt+OVlgeEH+j8FW/V
         HnhQFs7VznCWWla8nmRg5ng4xsLXj7lY2X21UKJz6SCuFddnvNI1cXaIXrDQe+lyho/z
         GdW2VZVoH4ldJ9CY0GQW69KC1kXW6Ft5WK/N+LKwZJ39oAvZSXv+oNKc4DjQjIkCxHaB
         8ujRuQSiihKgCM4crHOJbBaLiH0jaPghsfdZe6V0g1JnFkbYbJxz905rKdGCDqafc6Ka
         83GA==
X-Forwarded-Encrypted: i=1; AJvYcCUauI4B2nX7AZGoQpK8HexlZ/Ky5qWHEhL+W5p5HMQgUnbUuiydYG3j+KQm0KddqIL1jibWyLAgYKzArAE=@vger.kernel.org
X-Gm-Message-State: AOJu0YycUrF19p1Wo/Khmur+NF0zY9G8d7sBmxcDkS8OYfoGqlnvO8RL
	XD6a8t6MQx2CQhCL2XCYHhH4QtCBsdVIqZCWHNgcprohGIsBpkH8XLOpSuIRxePcLgKVyw==
X-Gm-Gg: ASbGnctuHXmRtfc0xIkFLL93A5W22dwN8nAOA79bzfoAaIsEf1ZVekKyZQ9BHNP6dt8
	IYTVbze8oiGXPsTEMiBV0VmEx7YzT0AF8DE7qgwIrY7QCw2Cpwo8PtwQBe9OMvEEXmzTbXkewtH
	zfaveKDi79CVMVT4ZzzCQJyQsOY6M/QFfmWzo9vYOeROVpIHPSgO8Hc1I5dxiINx4VEOiOyq/+1
	0PD4x7h2yzUKH2vVeD508UYQHe9xq6z9V7+AkbhfiNetflmVFi1MgBZ+LR+ijNDCpD9RBt8ae3f
	+IgoN2fbs/Z7ktiCR2byXVMfEjbpwfCvBpuyOoZN6Du//R5QlP8tT2o40dbE4s+WqjTBvGAmMPw
	oXFaJw18CBuDrbetIOjE/zyQ9QbD4RgOTpYlzfuNW6LW+RBzw8xUGUHlc/Jdes/fwussUjOG/3F
	5PAoJkXEqTvg==
X-Google-Smtp-Source: AGHT+IFUZAAP6TA8tNra5vdp5shDkkx1ePydRmct9+JBO8i8YD0QZYerdN9x2vPVqM44KgUCXLMhvQ==
X-Received: by 2002:a05:6a00:1397:b0:7aa:8397:7750 with SMTP id d2e1a72fcca58-7b7a2d8fb0bmr2111013b3a.12.1762932272063;
        Tue, 11 Nov 2025 23:24:32 -0800 (PST)
Received: from gmail.com ([117.147.73.250])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b811183c77sm903311b3a.20.2025.11.11.23.24.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 23:24:31 -0800 (PST)
From: peng8420.li@gmail.com
To: linux-mm@kvack.org,
	akpm@linux-foundation.org
Cc: david@redhat.com,
	osalvador@suse.de,
	jgg@ziepe.ca,
	jhubbard@nvidia.com,
	peterx@redhat.com,
	linux-kernel@vger.kernel.org,
	dan.j.williams@intel.com,
	"peng8420.li" <peng8420.li@gmail.com>
Subject: [PATCH] mm/gup: fix handling of zero page in follow_page_pte()
Date: Wed, 12 Nov 2025 15:24:24 +0800
Message-ID: <20251112072424.125514-1-peng8420.li@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "peng8420.li" <peng8420.li@gmail.com>

In some scenarios, `__vm_normal_page` might return NULL.
In this case, if `is_zero_pfn(pte_pfn(pte))` is true, simply return `page = pte_page(pte)`;
no further folio processing is needed.

Signed-off-by: peng8420.li <peng8420.li@gmail.com>
---
 mm/gup.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/gup.c b/mm/gup.c
index 95d948c8e86c..60ae5f0c20e0 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -838,6 +838,7 @@ static struct page *follow_page_pte(struct vm_area_struct *vma,
 
 		if (is_zero_pfn(pte_pfn(pte))) {
 			page = pte_page(pte);
+			goto out;
 		} else {
 			ret = follow_pfn_pte(vma, address, ptep, flags);
 			page = ERR_PTR(ret);
-- 
2.43.0


