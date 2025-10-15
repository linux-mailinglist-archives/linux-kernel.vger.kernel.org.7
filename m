Return-Path: <linux-kernel+bounces-853513-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 141E7BDBE0D
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 02:11:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA25B18904C5
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 00:11:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 254EBDDA9;
	Wed, 15 Oct 2025 00:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="B+5vnFa3"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63A6B1A0BD6
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 00:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760487048; cv=pass; b=QyZFnv3RJNf76HqhXboEeX0Mp8qXdQFEbgDtaA++bbEKIijtDrQNFopjmy9gToFzjFBu/L5dEQ2ApEbqf2DfQJ2SkfP+Y56o2pzwcvbFQ5SchPiDmMPh5Gpz8bCdMGUanNpNRQC5UqfjuyH4ZhS9b1EDdXdHl6kBGrt10dJImk4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760487048; c=relaxed/simple;
	bh=5IOB5JiNTlszlwy8/yDSir1ADlcvRJPeYJCvj3iHGSs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tAq9xZM0nZ62KR6Ts4W5wxmSb3UZ/sy3b3mPfRACtFS9fuE/3KxRdSBc71j9DJA4EldTQpuCPBsiT9qMxKodCcbH6Z3INLsgDuiuj/bIgNyByiYoYIEwhUqsBhQfyl30Ci4VsTBG2eqPPDUiZUM713SWgEgOXWgl0TZ5OvqYqME=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b=B+5vnFa3; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1760487029; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=AbIMEgzChvM3oeaJI9Bd8EODazdIp8H7BBEVDAJoLkajUpuM/LB/owZ48LafIfIz9vrDaslhGdT78Si9r/0INA/JTnS/iwTVknaDLBO5LHMYKhQ4sU7vWaLAR2R0BbfvtxorNpZxa/1mEHfWV/J0Xn0zACfvFdj2+XZK80mhZ/A=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1760487029; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=iYU8Y6fdfg6t9q0eb4oUSrrpbJyFoasUUDRYSuiHHv4=; 
	b=j2JDCCxSifFpCxlDx/pL+xJRPRKzLLD67ZG94IC3hZX9yk9ZxYvctrg8fQiNXqRNgGp+BY0ZrEun0vqc5AF7KDylRR4dD+jUEQROS4Y5uNRB4IZMRcbWwxMtx2DKfVJKwHPTIfAOpA/XjQeOuEjm26C4zQUmx2KKEP462bpvd4o=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
	dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1760487029;
	s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=iYU8Y6fdfg6t9q0eb4oUSrrpbJyFoasUUDRYSuiHHv4=;
	b=B+5vnFa3GxYM7iSjilhT7iNfQVLahRNbZjswycHLTtgVd9HESnXzsVFzAne+PnQq
	d+Vt6uP7B5HurNQVLV+C0gzXCLIGECZBXcERyygl1MNLSMpmO1K4n2SCKjcQ2DNTkHm
	tljQFv0sy7nvWsF6b042g5nU3R0C91JvhF2E8FQQ=
Received: by mx.zohomail.com with SMTPS id 1760487028919256.12883687539625;
	Tue, 14 Oct 2025 17:10:28 -0700 (PDT)
From: =?UTF-8?q?Adri=C3=A1n=20Larumbe?= <adrian.larumbe@collabora.com>
To: linux-kernel@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org,
	Steven Price <steven.price@arm.com>,
	Boris Brezillon <boris.brezillon@collabora.com>,
	kernel@collabora.com,
	=?UTF-8?q?Adri=C3=A1n=20Larumbe?= <adrian.larumbe@collabora.com>,
	Rob Herring <robh@kernel.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>
Subject: [PATCH v6 05/12] drm/panfrost: Check sgt to know whether pages are already mapped
Date: Wed, 15 Oct 2025 01:09:11 +0100
Message-ID: <20251015000930.356073-6-adrian.larumbe@collabora.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251015000930.356073-1-adrian.larumbe@collabora.com>
References: <20251015000930.356073-1-adrian.larumbe@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

In the MMU's page fault ISR for a heap object, determine whether the
faulting address belongs to a 2MiB block that was already mapped by
checking its corresponding sgt in the Panfrost BO.

This is done in preparation for a future commit in which the MMU mapping
helper might fail, but the page array is left populated, so this cannot
be used as a check for an early bail-out.

Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>
---
 drivers/gpu/drm/panfrost/panfrost_mmu.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/panfrost/panfrost_mmu.c b/drivers/gpu/drm/panfrost/panfrost_mmu.c
index cf272b167feb..ba32d99ed854 100644
--- a/drivers/gpu/drm/panfrost/panfrost_mmu.c
+++ b/drivers/gpu/drm/panfrost/panfrost_mmu.c
@@ -600,10 +600,12 @@ static int panfrost_mmu_map_fault_addr(struct panfrost_device *pfdev, int as,
 		refcount_set(&bo->base.pages_use_count, 1);
 	} else {
 		pages = bo->base.pages;
-		if (pages[page_offset]) {
-			/* Pages are already mapped, bail out. */
-			goto out;
-		}
+	}
+
+	sgt = &bo->sgts[page_offset / (SZ_2M / PAGE_SIZE)];
+	if (sgt->sgl) {
+		/* Pages are already mapped, bail out. */
+		goto out;
 	}
 
 	mapping = bo->base.base.filp->f_mapping;
@@ -625,7 +627,6 @@ static int panfrost_mmu_map_fault_addr(struct panfrost_device *pfdev, int as,
 		}
 	}
 
-	sgt = &bo->sgts[page_offset / (SZ_2M / PAGE_SIZE)];
 	ret = sg_alloc_table_from_pages(sgt, pages + page_offset,
 					NUM_FAULT_PAGES, 0, SZ_2M, GFP_KERNEL);
 	if (ret)
-- 
2.51.0


