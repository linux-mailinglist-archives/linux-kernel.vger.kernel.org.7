Return-Path: <linux-kernel+bounces-835542-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D6C86BA769C
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 21:08:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 509351896776
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 19:08:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39274264614;
	Sun, 28 Sep 2025 19:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mnFTZE0v"
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 310152609EE
	for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 19:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759086470; cv=none; b=XEInyw7oGQ7HkddBP5XyGt3oUXR2VkPIkuk9dZ6XT8/aDQVCaF/uFShP2WyBvfuvdoUZuapyvq9QnF6Li9wyIdzaVQ9Dq3HCWDF86GVTc/vm0Z1LWi8DQA6xmHZZkjVyHwpBWpj99NSVxAmW8ivcMJtzpo/sPM48nChw+cHH3To=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759086470; c=relaxed/simple;
	bh=zDH31s7rsPYxIzn24EVtvl9OZhYo2h1GDjEToyCXHhU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=FQi70l3TN1ePj/NbbsWjfhVhk34bGaUClLfXuXIvF2pCruZx3O4TdduIB0C06x8+kHkZeB3cmL4sqBAmQ2GpqJ7+3gXUMxKj1VyzKhBbjSorpNiFR5J0/Cgu2N4DWz0yHaK8ZB7oH22aLv2uFKZLsphxriPucRqTkXsZRfbs7po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mnFTZE0v; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-78117fbda6eso2468186b3a.3
        for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 12:07:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759086467; x=1759691267; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=XKD+6rR+ZCf718VijhXNO1kt7/wJrzJ8IPqx+tgskHE=;
        b=mnFTZE0vR2GT6QLf/UIMxM3z8PRaxZF4tJcVT/jnT5DWr3ZzQAANG4VPoLkhRceR+N
         cvfYHwD4bUnOhNvg0jk35wnhOn7BWragZaAJsFMypKxh0D7UXyzlHY5TtjVaaQ4Z0YXw
         ycuffM4v5ZShQ2oc5cR93xJaPrZJCQ5++bil+6Pij6T1km4QZZODtwipINNJlUfRQbn5
         a/MUHI0naypMsa930t4jVmpzZDf55ujfiH/58LukhamCEBTpu0J6vAIZpp+orJGNjgRH
         tA21RaagswYxDbFdezP33lqfU8ogm/4Y3D4C8DubSxDasj8R2c1u+sBAOfsF3Xt1l+6c
         Kscw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759086467; x=1759691267;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XKD+6rR+ZCf718VijhXNO1kt7/wJrzJ8IPqx+tgskHE=;
        b=mvft9Ud8h7P1fZxmK7e0ghsGgrHNju1oOYENP5pMr2+2+MvFPV++xpzpYGXqq2d0pa
         d2EkwONCQ5gOyOHtUk7M6ReCFPpLrudP8psKn1EPO3qr6g/vZLJ+ifDdmqmfZugfppPJ
         Z2SN+OLkSMF2HXQZ/W8Ka7lI1LTWOChm7Qzpg3Q1ydmPxjoHh+A9D7T5AKfQa4ClU2Ve
         hIiaTJox+zKGMzyAEiaYJ3Z9nJKq3Y/ztGzAtpC1ighyD20vKwfSPvt/Z7cLA0OWuLFp
         sq2/gxwFdVDkl1S8wGEEONlf4fQHmI3117SV5jCNHTuMfzOPTUhP4YACvinW80Q9wYaq
         1HVA==
X-Forwarded-Encrypted: i=1; AJvYcCUnV5Amu/Zi2cWXLEPAM6lkLOZUAQdRzwfmy/SRIt0dNKXrKYnlYeB9jCGV+72gkBnCN+pLiJ9zwnyAAec=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjTgCzD3Rr08+FZ2vjyuILI7FGYoujzyuM/ezkmOY/i5b+vy6G
	g2Eu4/lYZWe8GXkd+OyI2aAZbda10xqCVNXVPyueRGEtRblQwtxFEjKZJ1nL0UpBeG3Ig4q9qmU
	jYvDj0UGc9xyjpA==
X-Google-Smtp-Source: AGHT+IGttSbQUUKNc7Fj+s9+oJWDjLUfJmgHpOgznyqZWeNNRCg9RbZUUOUsFhC6DOgwPPznvL3k5goTDcPGbA==
X-Received: from pfbfp10.prod.google.com ([2002:a05:6a00:608a:b0:76b:651e:a69c])
 (user=skhawaja job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:3c8b:b0:781:2757:1b4f with SMTP id d2e1a72fcca58-78127571ef2mr4881787b3a.7.1759086467484;
 Sun, 28 Sep 2025 12:07:47 -0700 (PDT)
Date: Sun, 28 Sep 2025 19:06:12 +0000
In-Reply-To: <20250928190624.3735830-1-skhawaja@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250928190624.3735830-1-skhawaja@google.com>
X-Mailer: git-send-email 2.51.0.536.g15c5d4f767-goog
Message-ID: <20250928190624.3735830-5-skhawaja@google.com>
Subject: [RFC PATCH 04/15] iommu: Add preserve iommu_domain op
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

Add an optional preserve iommu_domain op that can be implemented by the
iommu drivers to preserve the iommu domain.

Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
---
 include/linux/iommu.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index d23d078f7c18..40801d8eac61 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -758,6 +758,8 @@ struct iommu_ops {
  *                           specific mechanisms.
  * @set_pgtable_quirks: Set io page table quirks (IO_PGTABLE_QUIRK_*)
  * @free: Release the domain after use.
+ * @preserve: Preserve the iommu domain for liveupdate.
+ *            Returns 0 on success, a negative errno on failure.
  */
 struct iommu_domain_ops {
 	int (*attach_dev)(struct iommu_domain *domain, struct device *dev);
@@ -787,6 +789,7 @@ struct iommu_domain_ops {
 				  unsigned long quirks);
 
 	void (*free)(struct iommu_domain *domain);
+	int (*preserve)(struct iommu_domain *domain);
 };
 
 /**
-- 
2.51.0.536.g15c5d4f767-goog


