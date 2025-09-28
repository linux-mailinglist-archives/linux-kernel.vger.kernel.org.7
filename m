Return-Path: <linux-kernel+bounces-835540-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 96B0FBA7696
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 21:08:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ACA85176E4F
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 19:08:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4035E23183F;
	Sun, 28 Sep 2025 19:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ac23Ridm"
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C05725C816
	for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 19:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759086466; cv=none; b=acyEj+lX4I09z6IQMv1u9UsX4VswlhdMZXR61uufeR1Iu9wXZ2jfHw64P87P5dNyQMDZQLFScyhWle3ugr+uh5Y/lhd8uSALyIpkXwmJ0kdoBbQDwOdeZ4R5d2ABDyKWmmVgUgrvBgKkvmxh+OVSsVyRmVwqtT+NZAmcsRxKwms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759086466; c=relaxed/simple;
	bh=TwkDwodBUCdAT08Dx1368hcmJsMEk9iOzMuO3YTeHgw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=pgFpJtv0kzmh7Xg5wgbgJCXYl5aLXY+/SJNCIYtcLyI1QuPNYwlIKAjWv3xH+kxPF1+UXKX+V6MbhPDR87t8gC8tFuE7wt5LoSHi11nPbuk3xU4LrJ5qWMWj1mfe58h1o1gSOpu+Xz3g6rCuHN+GqA4ODv1pzu0o1hpdJbdygwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ac23Ridm; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-78102ba5966so3465590b3a.2
        for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 12:07:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759086464; x=1759691264; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=IKcQOPAuV/AfXb11Bbc+ExvF6Mw54uI2kbWY/7dTIhc=;
        b=Ac23RidmF81xVkhnxmFW2pn+gdL+1B3q0PPRCI0CzCBnSiw3mJj1hvrmx2hIqHBvBO
         TeL9ApJj9ybfMEczgBrbkCO6iGbvlNjcYeMMaMA8sFRC081C+xETeOxaL2oLQHNXOn3L
         +XzyAobU0CPNO9tMmeRV4UqfrdNi5AouGwbheh12TK+wZekzBlGNLjVtb+1nuWmcHs2z
         5uXBjStQK1ohZpHlUkQlzu+jkl3ZqGYJYthE6PChQqaFX6ML2ARMetY4CkJeyH58tmHj
         3hsvvg+/1orvX1EkdwdMtih5fMQal8UYaNROwPpF9pShJQAx6lzFV6SbwLP2guILfdOv
         AjEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759086464; x=1759691264;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IKcQOPAuV/AfXb11Bbc+ExvF6Mw54uI2kbWY/7dTIhc=;
        b=b9Xsd4rVPZlB/miGG4svI+yWaJlv24smVszcsP/7enEV8/febf0isHHbUImGi0tQHk
         doJXsGB+GmVnb0wZFtVTpkhZml4c4tKyih9bJt53vmrFfNrSeFhjrKE28lBuifA08dAp
         MPo+XJlHtnulwaR2osgDLX9ezBALuRDPNXCzZHr6wpB2qyAAzKBwq3a3hZjx2noxfzaK
         90V0aaZAIMCQHGpdgZNarhXVdxclycskA3Iqda+oV9OsP9GiNrozWhra1wTQSFTwFRSN
         868U0qXJ9YwyDQg8gKvLTcmJDArLtSnJnMvu0Dr6YdYhhXxQauRjYhhhrDlFa0CEfDmk
         5uhw==
X-Forwarded-Encrypted: i=1; AJvYcCUZ86r+/CRnmrh073+dJLqG51ph1smxE5y3yBZLLzPMiSCU5abRS0dT/EE68w5lhNX5jEhpZ2AoRgLsrVI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+F6nxWbig5J4RITbeW31PNTRX819uAWCTEqjYEiw6zDEwIHME
	yMYH+B39gyg16LnE0syVqLY6zGLizRb+tSheiMegBANn49Yv75BY1uDR3FPX5KMpBtwPfzAaW1O
	AP2OCPA+w0FuSPw==
X-Google-Smtp-Source: AGHT+IHDYriJ2CM6vbXXafroWapgFfQBlAXQ04VVe+gXkI/tWSYoUN/rx+IsvTB3qwxKgNIrgENnlZqvrAEbqw==
X-Received: from pfwz13.prod.google.com ([2002:a05:6a00:1d8d:b0:781:2040:d72b])
 (user=skhawaja job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:8cb:b0:77f:efd:829b with SMTP id d2e1a72fcca58-780fceba2ffmr14102660b3a.22.1759086464308;
 Sun, 28 Sep 2025 12:07:44 -0700 (PDT)
Date: Sun, 28 Sep 2025 19:06:10 +0000
In-Reply-To: <20250928190624.3735830-1-skhawaja@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250928190624.3735830-1-skhawaja@google.com>
X-Mailer: git-send-email 2.51.0.536.g15c5d4f767-goog
Message-ID: <20250928190624.3735830-3-skhawaja@google.com>
Subject: [RFC PATCH 02/15] iommu: Add rw_semaphore to serialize live update state
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

Introduce a rw_semaphore to protect the IOMMU live update state.

When a live update operation (prepare, cancel, etc.) is in progress, the
underlying state of the IOMMU subsystem (e.g., the set of active
hardware units, the state of preserved domains) must not be changed by
concurrent events.

This semaphore acts as a subsystem-wide lock to serialize the LUO
callbacks against any other code path that might modify this state,
such as IOMMU hardware hotplug.

The LUO callbacks take a write lock, as they modify the live update
state. Other code paths should take a read lock to check if a live
update is in progress.

Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
---
 drivers/iommu/iommu.c | 4 ++++
 include/linux/iommu.h | 9 +++++++++
 2 files changed, 13 insertions(+)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 060ebe330ee1..bfa7c8653720 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -2052,6 +2052,10 @@ struct iommu_domain *iommu_paging_domain_alloc_flags(struct device *dev,
 }
 EXPORT_SYMBOL_GPL(iommu_paging_domain_alloc_flags);
 
+#ifdef CONFIG_LIVEUPDATE
+DECLARE_RWSEM(liveupdate_state_rwsem);
+#endif
+
 void iommu_domain_free(struct iommu_domain *domain)
 {
 	switch (domain->cookie_type) {
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index c30d12e16473..d23d078f7c18 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -598,6 +598,15 @@ __iommu_copy_struct_to_user(const struct iommu_user_data *dst_data,
 	__iommu_copy_struct_to_user(user_data, ksrc, data_type, sizeof(*ksrc), \
 				    offsetofend(typeof(*ksrc), min_last))
 
+#ifdef CONFIG_LIVEUPDATE
+extern struct rw_semaphore liveupdate_state_rwsem;
+#define guard_liveupdate_state_read() guard(rwsem_read)(&liveupdate_state_rwsem)
+#define guard_liveupdate_state_write() guard(rwsem_write)(&liveupdate_state_rwsem)
+#else
+#define guard_liveupdate_state_read()
+#define guard_liveupdate_state_write()
+#endif /* CONFIG_LIVEUPDATE */
+
 /**
  * struct iommu_ops - iommu ops and capabilities
  * @capable: check capability
-- 
2.51.0.536.g15c5d4f767-goog


