Return-Path: <linux-kernel+bounces-835551-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 61B77BA76B7
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 21:10:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A845A188D712
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 19:10:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0C77273D6F;
	Sun, 28 Sep 2025 19:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UKX4EYyd"
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F6D92737F9
	for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 19:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759086482; cv=none; b=nduTLFwVTlFXukAtdgR0oOjFWUHvTwGxCmSmMabp1N4LyBZIN5GFXCkzPayOasodf+1QYTXd6bUfCmb/yupIbT6PtNhxTyaK0way4gHELyh6AxzMwJuxWxBwg19wuVNBwry6/7T7/Te3d9C/uFp5hxT3l7yBJ73gDkiIWLh5xXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759086482; c=relaxed/simple;
	bh=eE4YtWNaCXed6BZ7yxa8qvhRb0ZMJlu8yifPEfR7bgo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=nNAQPv+tNz8y9m+uG+PLANcGnRoIIOkAiPrg/IBvGG9Ki8JQV7y2q5fXw0ISyXVPCL59U2RiwTt/K/SzyJaqtrKvxuxIp6Zp6dUezkkWPCjqkct5fV05EzW5g5BeZVLzMKk3sQFlVgk4fWO3qi/tqymmgWg7xcFOvX5zvTmXNws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UKX4EYyd; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b5509ed1854so2521036a12.0
        for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 12:08:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759086480; x=1759691280; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Pi5xSv0ip63020Fps6lPWkegEnm0TGf/4Ss482K5u6o=;
        b=UKX4EYyd9VPPT9Kt8iDe2VvQFcLlWY8yHS9y2ZWX7mc9iFYikmS2XqXe+XxBAAcvjN
         z/nm8B+tau5vnJO2ccZ33+7O/JzFw8kiCORKfHJmVXMAQNeSHI8iaZE6yIZINhVTpJxS
         6wimAFRcBX4FHGH1Lf7GBBfyA9Q67CrUSVXUY/DaEYrPCFb9b+ympfzfuLnY/gaNkuY9
         Xx5/SyJvUj3HApMoNqn4rypZQ64akkBg+GkynMnPFrdkdPjgeQnG/U8L/pOlUH4uZwaH
         qTolVWRVaydrY8DSEE3PmY+ntOxptqhhrsUd0kUa3U6o53pINb+5SsVvsnu97Hw3q24r
         5alw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759086480; x=1759691280;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Pi5xSv0ip63020Fps6lPWkegEnm0TGf/4Ss482K5u6o=;
        b=OLBsZpsH1fvTNwDxTV4DWmTpXG7u3hIqW4TmoHX5lNeAtLQbNn+2VEa7NqchY2M1WC
         pfQKGYfe1+n4FDoWwxzoYPwNPrRHC2NZCaPhWzpJUgiDonkqRt3e/QMqf13SuAL0szN+
         6B5fF+GeEUQ+9Kiz1/JfOj/Jwyl9MST+/Z58a2WM5QSydj5rE24g9ZkeK7LmL6vjvK3K
         FVdB1sT2RFJ57yhmYPrkzBkfInVKJgct4HFcilfppPPK8/bLZ8uM/diCaX8owzU0EtTu
         NLPivg6wiRZSnJn2AP1JI2b5V0tuXrjYH7Vi9fP4E46JnuZuwspe13LVKxdSnN3sDAGe
         3wsg==
X-Forwarded-Encrypted: i=1; AJvYcCW2EAcpHkoQJ+4ioPcmsfN3SGHFM+5/gjEAXjTW0f8zZZe+KtHWM6BWEeSohr1CaKfBw/Q6N6rhEmexTho=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUBOypGhEi8F4XCSWx+Dl0WxgMK3L7N0BzvQFIghrBO9nWp7dZ
	UTYRJWSdYB4rt4Rcxx8i0YbakoeFdRi/j9DrysGgsE8pBzZGSd4jSRwiWtvHERm0Qk4B9OPNyYt
	4H+KdzoI+6xmvUQ==
X-Google-Smtp-Source: AGHT+IG0pDvpM9G54/3TjfbvcFpmO/TqiGthSy0imZbx93Glz7wAQ23TYddREy6lbjR0p5lw+B7srvLFeianPg==
X-Received: from pjjk3.prod.google.com ([2002:a17:90a:6583:b0:32d:a0b1:2b14])
 (user=skhawaja job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:4d10:b0:330:6d5e:f178 with SMTP id 98e67ed59e1d1-3342a30c47amr3373951a91.26.1759086480539;
 Sun, 28 Sep 2025 12:08:00 -0700 (PDT)
Date: Sun, 28 Sep 2025 19:06:21 +0000
In-Reply-To: <20250928190624.3735830-1-skhawaja@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250928190624.3735830-1-skhawaja@google.com>
X-Mailer: git-send-email 2.51.0.536.g15c5d4f767-goog
Message-ID: <20250928190624.3735830-14-skhawaja@google.com>
Subject: [RFC PATCH 13/15] iommufd: Persist iommu domains for live update
From: Samiullah Khawaja <skhawaja@google.com>
To: David Woodhouse <dwmw2@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>, 
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Jason Gunthorpe <jgg@ziepe.ca>, iommu@lists.linux.dev
Cc: YiFei Zhu <zhuyifei@google.com>, Samiullah Khawaja <skhawaja@google.com>, 
	Robin Murphy <robin.murphy@arm.com>, Pratyush Yadav <pratyush@kernel.org>, 
	Kevin Tian <kevin.tian@intel.com>, linux-kernel@vger.kernel.org, 
	Saeed Mahameed <saeedm@nvidia.com>, Adithya Jayachandran <ajayachandra@nvidia.com>, 
	Parav Pandit <parav@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, William Tu <witu@nvidia.com>, 
	Vipin Sharma <vipinsh@google.com>, dmatlack@google.com, Chris Li <chrisl@kernel.org>, 
	praan@google.com
Content-Type: text/plain; charset="UTF-8"

From: YiFei Zhu <zhuyifei@google.com>

Iterate through all the IOAS objects and the underlying hwpt_paging
objects. Persist each iommu domain using API iommu_domain_preserve.

This is temporary as only the domains attached to the persisted devices
need to preserved.

Signed-off-by: YiFei Zhu <zhuyifei@google.com>
Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
---
 drivers/iommu/iommufd/liveupdate.c | 47 ++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/drivers/iommu/iommufd/liveupdate.c b/drivers/iommu/iommufd/liveupdate.c
index 1bdd5a82af90..0af0c6fadff1 100644
--- a/drivers/iommu/iommufd/liveupdate.c
+++ b/drivers/iommu/iommufd/liveupdate.c
@@ -8,9 +8,52 @@
 #include <linux/kexec_handover.h>
 #include <linux/liveupdate.h>
 #include <linux/mm.h>
+#include <linux/pci.h>
 
 #include "iommufd_private.h"
 
+static int iommufd_save_ioas(struct iommufd_ctx *ictx,
+			     struct iommufd_lu *iommufd_lu)
+{
+	struct iommufd_hwpt_paging *hwpt_paging;
+	struct iommufd_ioas *ioas = NULL;
+	struct iommufd_object *obj;
+	unsigned long index;
+	int rc;
+
+	/* Iterate each ioas. */
+	xa_for_each(&ictx->objects, index, obj) {
+		if (obj->type != IOMMUFD_OBJ_IOAS)
+			continue;
+
+		ioas = (struct iommufd_ioas *)obj;
+		mutex_lock(&ioas->mutex);
+
+		/*
+		 * TODO: Iterate over each device of this iommufd and only save
+		 * hwpt/domain if the device is persisted.
+		 */
+		list_for_each_entry(hwpt_paging, &ioas->hwpt_list, hwpt_item) {
+			if (!hwpt_paging->common.domain)
+				continue;
+
+			rc = iommu_domain_preserve(hwpt_paging->common.domain);
+			if (rc)
+				goto err;
+		}
+
+		mutex_unlock(&ioas->mutex);
+		ioas = NULL;
+	}
+
+	return 0;
+
+err:
+	if (ioas)
+		mutex_unlock(&ioas->mutex);
+	return rc;
+}
+
 static int iommufd_liveupdate_prepare(struct liveupdate_file_handler *handler,
 				      struct file *file, u64 *data)
 {
@@ -33,6 +76,10 @@ static int iommufd_liveupdate_prepare(struct liveupdate_file_handler *handler,
 
 	iommufd_lu = folio_address(folio_lu);
 
+	rc = iommufd_save_ioas(ictx, iommufd_lu);
+	if (rc)
+		goto err_folio_put;
+
 	rc = kho_preserve_folio(folio_lu);
 	if (rc)
 		goto err_folio_put;
-- 
2.51.0.536.g15c5d4f767-goog


