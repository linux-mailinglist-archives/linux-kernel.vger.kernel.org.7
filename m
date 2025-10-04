Return-Path: <linux-kernel+bounces-841934-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3B54BB88F3
	for <lists+linux-kernel@lfdr.de>; Sat, 04 Oct 2025 05:30:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52B8F3A9267
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Oct 2025 03:30:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE85C1DE892;
	Sat,  4 Oct 2025 03:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ByOhD/Od"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3B2C4C6C
	for <linux-kernel@vger.kernel.org>; Sat,  4 Oct 2025 03:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759548643; cv=none; b=C2jQ3F7fP9AYZc0od21e3PkikMaxL3I4nvUvNaCMfv6rP6ZnnViBf81ZAoSPR1Do+9LHuvBHm2Umk6VS9JLtZb3tSURWfHFJid6AjW+4A/cawPM/yc+lBv18ZxsQykvw6vY/JTLOvOFTkXtRA2GU9Da3NxkpWeEGPYAgSq0pvks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759548643; c=relaxed/simple;
	bh=0c9z4SuRFiGBPFcUXAMN7ywy26aeUTsJfjovJPLNtJc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ti7HBKzqh+YbvrkrjqN8N+iIT3MZI7gqgyN/UBN6X4T9Rbtiy/ofLZmf0GyfPvnjrdMGT4MBMiQOkiu3ZwYDF0lbEK0ddD4gt+uzqt/nwC2QHV5nztkq/8/uwv9bWPLKllt5aiTs8bPbeeyZcJKEMsQmfXR8FGpYB4ZHMwVchaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ByOhD/Od; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-273a0aeed57so50701945ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 03 Oct 2025 20:30:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759548641; x=1760153441; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jiutd4RVK94JAmVmtepdZy4JLO6Phqgp3QTqvVC7OFc=;
        b=ByOhD/OdNvO2IDmOK2JM9ze3QAesDPDEsoNZDSJgXoF3N3fQPyigE/dEhgt0/vsg0h
         ze7SRirLDOXCglwi6ZvJGMttyCZrZNrNlmWr5/Y1tMfX8tZJQQCR6+MGOeRwuelmT+Bc
         tLiNKWU1O5Yey4inNC0HtBYZ1gcRhqdZD6JvfcATJMK4sAODyNY9Wyl+CPwRKMjDk1aT
         /uDVKdBl3oa5TwtyAHhLb/i0e63TEjEtVbfSDIkmiXsCJjrI4u08PjC777Y7VUooCwHO
         fZsdnA/bWqLcjQetJvdQpfVENaPCx8cMcvTmfNrYqTY5tEXD2GZ2YMCSFydtx9o4QfUr
         1IQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759548641; x=1760153441;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jiutd4RVK94JAmVmtepdZy4JLO6Phqgp3QTqvVC7OFc=;
        b=a7S5qoCr+ytaj/yYbq7OazYj+X7hk4lHx6VVoutegUB7l/PE0Udu7OHIO1BwnPUC5F
         xrFWoTViqwOk+TtF+sMv8KQpcFhUW6LZYUEOsxJe8vI/qlZDeelRMc+orwhbO2bU6ap5
         fdhhrRMslLpi3wwmkCoXzoqLoULySSwHUhzwsqvd0p30sMq0myp684DGp82rmO1FtWbc
         z7BAw8T2bzKmSo3AuFN/R4D4zmGX5E1UwrKiWpE70JJuyGrJIMkl6+iQ0Hs/q+/Zd7S6
         5VXEe6cC7wmcjUBMezWLUaWETgXHp2nFVt21RZYUrBTdU2gtbu8RzHnWxJxDGdcjHKJi
         hp5Q==
X-Forwarded-Encrypted: i=1; AJvYcCUaoU/EpJ/OqsgBdqhbNWEaSlGO5h9J3/CegUylqhViZ0FxGsxKLwB9ruYnIJZ5HjS3PN07w8dlPxuYv0s=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQw98QA2t5fGSGwdZTvUMWO1pHVdaA5qZdtyeTFBpTwGUrA5iD
	wv4z0i778UY3GCj8405nGqwzPP2mFg5eicHHuV9T3r1YlxFAngOULAWx
X-Gm-Gg: ASbGncsswi08riOdZp/bALidy+s3+yko2oWQ2yql+039ryW30ADNQ2KfL06d4kbHE71
	jf26SzW156Wr4ALkfXpvEuduxPuWZuSYVn1n9CoUW+4ua0Gh1NBaueEIs5w6YrNQwtoQlVDeV75
	fY0vFTZSCCN89AXVcLKpig1+G3LLLfVvOOGT3ESDV3hLjsikfJyqoC8ifvcPEkVK3n5+oUoa+9f
	mGk+DGS/toU8WHMNP4dWcXs9QoaavAD2GdozcPgkS6hKSN/lZEnKbTjJso9L46SZxOT4LQRqZjz
	bqNicHZhikDrZoJxe8SdKv0q7KgCyTAMRKF6yTOlhHGlvdV4IudYBHVcVWdjOUCT4CFdd6RRS1K
	oVtNpvorBfq9ASgjvwEvKjzfTyRps69Rgq1rtosxxxwDd0HZLy+t0l2hMsvrTGq4fKA5Otoil
X-Google-Smtp-Source: AGHT+IGnSnK3Jadih+8ztxMGZHFLoCmey9SXzZ5BNJm+bZsYDVSdTmF5KauP0zWMC8R6eaI84W4ugQ==
X-Received: by 2002:a17:903:1b25:b0:271:d1ab:17ce with SMTP id d9443c01a7336-28e8d0e8395mr100457975ad.26.1759548641069;
        Fri, 03 Oct 2025 20:30:41 -0700 (PDT)
Received: from ryzoh.. ([2804:14c:5fc8:8033:c5aa:36f3:14cd:8995])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-28e8d128041sm65070625ad.37.2025.10.03.20.30.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Oct 2025 20:30:40 -0700 (PDT)
From: Pedro Demarchi Gomes <pedrodemargomes@gmail.com>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>
Cc: Robin Murphy <robin.murphy@arm.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Pedro Demarchi Gomes <pedrodemargomes@gmail.com>
Subject: [PATCH] iommu/pages: use folio_nr_pages() instead of shift operation
Date: Sat,  4 Oct 2025 00:23:51 -0300
Message-Id: <20251004032351.51150-1-pedrodemargomes@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

folio_nr_pages() is a faster helper function to get the number of pages when
NR_PAGES_IN_LARGE_FOLIO is enabled.

Signed-off-by: Pedro Demarchi Gomes <pedrodemargomes@gmail.com>
---
 drivers/iommu/iommu-pages.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/iommu-pages.c b/drivers/iommu/iommu-pages.c
index 238c09e5166b..3cb8fcc39066 100644
--- a/drivers/iommu/iommu-pages.c
+++ b/drivers/iommu/iommu-pages.c
@@ -80,7 +80,7 @@ EXPORT_SYMBOL_GPL(iommu_alloc_pages_node_sz);
 static void __iommu_free_desc(struct ioptdesc *iopt)
 {
 	struct folio *folio = ioptdesc_folio(iopt);
-	const unsigned long pgcnt = 1UL << folio_order(folio);
+	const unsigned long pgcnt = folio_nr_pages(folio);
 
 	mod_node_page_state(folio_pgdat(folio), NR_IOMMU_PAGES, -pgcnt);
 	lruvec_stat_mod_folio(folio, NR_SECONDARY_PAGETABLE, -pgcnt);
-- 
2.39.5


