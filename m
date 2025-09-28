Return-Path: <linux-kernel+bounces-835543-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98B18BA76A2
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 21:08:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 091007ACA96
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 19:06:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 935CF25D1E9;
	Sun, 28 Sep 2025 19:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DbY5qTnW"
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72202261573
	for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 19:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759086470; cv=none; b=Mly2GemyqFmHeLD1/Y0/J1iCNw2ngAH4LpFV9VochtdgU3PjGV8d6x0ejHdZ1jyI7Tb84bQ89mYMXxJYIo2RORL8s2BlIBlefZyeFWSBg/7PkwKujEHlTuTB0Eilz+bHp3Lzr7njDUV1ZM5wBGU/6+SRXe6ddXgfgaHceG86rj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759086470; c=relaxed/simple;
	bh=MuX3jZ3sSbwfMCn0UPvl+BEUskcLBHNXaIPs4MYUTto=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=UvJGUDcsmvlplLHul08lJ2rc+U5eREwABGAT6OdIsWlveMpa4gLiCgNFB4h0mpVb75Lihtim64imbNdvKne30S1B1oeG5M6k7lWHQ4Vs05FUEE1+7UrcaL27JUOc8+zsNt9Gy2O0gzYl2LRgxk0Mh/2y3wpqepY1HgGgyKcbzPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DbY5qTnW; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-7847cc45409so317516b3a.3
        for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 12:07:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759086469; x=1759691269; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=rdi2PyKiCCjIQ8wy03XR3Gwap8/Sh7/Zx1Xvfs/uPkQ=;
        b=DbY5qTnWSS+/nluO92jyrGiov/dbTYh9OkTEX0TykWM9igSFQMvHxSlTsGV/ukO9Kz
         ikdzO4Qvlns4qzi2QYSKCKtoRoGHQx2suMKFYx2HwB3NVKYtDNrtWiyYNBHIvTHcmGpN
         EQKKW/h8LoM1W91Rbbmxm72wAJx9sRORIWDhF5VnzePvn4EzyHqXBn3OSMzz5lQpEo1G
         a19TGWHRjEifQjbt+D72jnklKyzr0xrT9vkg1LW/31ROSkeEn77z51TD+MztwUJb9KE2
         i/xBicRUkh4mvvITSQdwVJOMrJ3JZ+6UPb306lOCs/wHxyZTjmVGLJr6tTqJpvdChH3j
         AhqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759086469; x=1759691269;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rdi2PyKiCCjIQ8wy03XR3Gwap8/Sh7/Zx1Xvfs/uPkQ=;
        b=p47y+BFIEKJw3+UCTz1ICw3j4w4lnL7IT4CsVBPwvvQsTgNT03bVC7NMviPFMyovXT
         cNZ3tHo1q/odUtIJN0hhxCBhGg1QEiMTI9FjZHjlxHDb39tDSZVaVfM0jzNnfZKzDAhJ
         mNpxEd4DhOozfqb9DDv4MEKyMlj23KKs5+lDdKR+CFn/87xSh/UU1Xa8ejxHAATcQaek
         LhonmgZnZTNWdt5YgG5RxcREL26ICRKlQs+2wP6XLhDxz+WxriW96wVZ/IYQAf8wjHoE
         quko6As/J89ZfeEN1rMIdY0lqNQslw9Deod8AlSsMqi55ono1fGX+8bK2YCxn2/e7noY
         4Zig==
X-Forwarded-Encrypted: i=1; AJvYcCU5qRFShzOx4tt1z+7EukN+m3hxy5Hytyc7JV+T7bwIbvhfAWwMOYYy1hZYJZo0++Gz3GbCbP9xzN75snI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyt+PWc8YkdUP9wgxi289fgB402MxgXA9VIRbvB5gJP4HDGV1yZ
	UEoi8BLA1HWpdlG8A70PsyBqTbkjLQoRr0bRgq5DbiFPJ2pZ9bxx18M2Bi58G71I+SwqEJimb30
	rsWnuJlLToDkSSQ==
X-Google-Smtp-Source: AGHT+IE9CnlJcLdiotMu3CPWOFGa4Qbbs3VcUOyfssl5nXIo/nwxXTHS8424T9CoJW4l01vDjDvbImmW+vK32A==
X-Received: from pfbde1.prod.google.com ([2002:a05:6a00:4681:b0:77e:468d:c50d])
 (user=skhawaja job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:80ec:b0:77e:325b:f614 with SMTP id d2e1a72fcca58-780fce1fe2bmr12364767b3a.12.1759086468856;
 Sun, 28 Sep 2025 12:07:48 -0700 (PDT)
Date: Sun, 28 Sep 2025 19:06:13 +0000
In-Reply-To: <20250928190624.3735830-1-skhawaja@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250928190624.3735830-1-skhawaja@google.com>
X-Mailer: git-send-email 2.51.0.536.g15c5d4f767-goog
Message-ID: <20250928190624.3735830-6-skhawaja@google.com>
Subject: [RFC PATCH 05/15] iommu: Introduce API to preserve iommu domain
From: Samiullah Khawaja <skhawaja@google.com>
To: David Woodhouse <dwmw2@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>, 
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Jason Gunthorpe <jgg@ziepe.ca>, iommu@lists.linux.dev
Cc: Samiullah Khawaja <skhawaja@google.com>, Robin Murphy <robin.murphy@arm.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Kevin Tian <kevin.tian@intel.com>, linux-kernel@vger.kernel.org, 
	Saeed Mahameed <saeedm@nvidia.com>, Adithya Jayachandran <ajayachandra@nvidia.com>, 
	Parav Pandit <parav@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, William Tu <witu@nvidia.com>, 
	Vipin Sharma <vipinsh@google.com>, dmatlack@google.com, zhuyifei@google.com, 
	Chris Li <chrisl@kernel.org>, praan@google.com
Content-Type: text/plain; charset="UTF-8"

Add an API that can be called by the iommu users to preserve iommu
domain. Currently it only marks the iommu_domain as preserved.

Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
---
 drivers/iommu/iommu.c | 20 ++++++++++++++++++++
 include/linux/iommu.h | 10 ++++++++++
 2 files changed, 30 insertions(+)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index bfa7c8653720..2e6e9c3f26ec 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -2002,6 +2002,10 @@ static void iommu_domain_init(struct iommu_domain *domain, unsigned int type,
 	domain->owner = ops;
 	if (!domain->ops)
 		domain->ops = ops->default_domain_ops;
+
+#ifdef CONFIG_LIVEUPDATE
+	atomic_set(&domain->preserved, 0);
+#endif
 }
 
 static struct iommu_domain *
@@ -2054,6 +2058,22 @@ EXPORT_SYMBOL_GPL(iommu_paging_domain_alloc_flags);
 
 #ifdef CONFIG_LIVEUPDATE
 DECLARE_RWSEM(liveupdate_state_rwsem);
+
+int iommu_domain_preserve(struct iommu_domain *domain)
+{
+	int ret;
+
+	lockdep_assert_held(&liveupdate_state_rwsem);
+	if (!domain->ops->preserve)
+		return -EOPNOTSUPP;
+
+	ret = domain->ops->preserve(domain);
+	if (!ret)
+		atomic_set(&domain->preserved, 1);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(iommu_domain_preserve);
 #endif
 
 void iommu_domain_free(struct iommu_domain *domain)
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 40801d8eac61..aafd06134f5c 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -14,6 +14,7 @@
 #include <linux/err.h>
 #include <linux/of.h>
 #include <linux/iova_bitmap.h>
+#include <linux/atomic.h>
 #include <uapi/linux/iommufd.h>
 
 #define IOMMU_READ	(1 << 0)
@@ -248,6 +249,10 @@ struct iommu_domain {
 			struct list_head next;
 		};
 	};
+
+#ifdef CONFIG_LIVEUPDATE
+	atomic_t preserved;
+#endif
 };
 
 static inline bool iommu_is_dma_domain(struct iommu_domain *domain)
@@ -915,6 +920,11 @@ static inline struct iommu_domain *iommu_paging_domain_alloc(struct device *dev)
 {
 	return iommu_paging_domain_alloc_flags(dev, 0);
 }
+
+#ifdef CONFIG_LIVEUPDATE
+int iommu_domain_preserve(struct iommu_domain *domain);
+#endif
+
 extern void iommu_domain_free(struct iommu_domain *domain);
 extern int iommu_attach_device(struct iommu_domain *domain,
 			       struct device *dev);
-- 
2.51.0.536.g15c5d4f767-goog


