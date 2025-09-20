Return-Path: <linux-kernel+bounces-825890-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 65B3DB8D0DD
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 22:39:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 237D71B25B10
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 20:40:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28BAC2D948E;
	Sat, 20 Sep 2025 20:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="X3sFkbIT"
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A18AD1AF0AF
	for <linux-kernel@vger.kernel.org>; Sat, 20 Sep 2025 20:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758400738; cv=none; b=SZh0KK6UxRQX45GvSlVCyZYzYDsfBD7IS2ccDFjhWi/tGv2hgH53UD7HEGgJ6xaLWGeoVL9H7ZNT4RnqTlwvfWVoqfxfk01n3oVkp2kyTaqH6v813ZCRq64dDn0VSq/JW1GeVyifZLG2TWyxZY+G/2Rg+NqLgrlTuNn24BBDYSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758400738; c=relaxed/simple;
	bh=OuRQ1dQeehiLZyRtEdjZyrjgSkJSYGgZCnUoVwKEy5g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aPDCPbRwS0yrBwcvEzPXoFpoi3ax1NSYqU9lSCQr9QCN8YmhktRsASeSgwCwasFJ72Wdviw8unVqQ5wMtzty5LP+pLiz5p6z9hrhYo+SWRAiUEn0uEjEyDxq1/jM2HrYM4uJhmYYgWdJaiHey7KQHO64dnBLzqur7N7GMuVQ2Ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=X3sFkbIT; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-892db7eb552so417436539f.1
        for <linux-kernel@vger.kernel.org>; Sat, 20 Sep 2025 13:38:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1758400736; x=1759005536; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P6NLd7h8COmFlKXea5yNf3+i/groQ/UZ03coZlB4lvw=;
        b=X3sFkbIT/pZqsNf5Zqele5tOMfdgRbs9S4KywLJTeXqMk43alpAVWx6lB4Ka/IE71v
         ZU8L2ZbwBK0o4CKiSj6bQEwdTGUOE+ljTP4dq/b0u1iSxha1EG60rdGW/x/c/E4AKrex
         gBRAjVQ1ceehxlLuxQzc88mXJd9X62fiRr8uKA0BxiAmhuVrBS87volUPLHUNcmValfi
         M7VX+w3yDC5yX541TUQFPJ7HEJCUiwIRyUnCcu1+6h/Ihqss7S9G7pwIN3x9d9GOqsPm
         kvNSeIFpfhhitQfbs0aB/R2oPHT5Cnnf4M+sjOGb8aV9asMcdycdXcg0PjEsg0qzcsUW
         F/JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758400736; x=1759005536;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P6NLd7h8COmFlKXea5yNf3+i/groQ/UZ03coZlB4lvw=;
        b=M1omlOU1fI53CrTCV5phXOv3ahsCBxocgE+so5S6oNQobOeX+gTzXX1qcyAlhZzCGG
         jPf8o1xuUQQRxXyefKphNxF6ME6C1HGYeG8RGpNnuHW03/eAF8WlDh3Yt3H6doC0ZOHb
         hcZ6DRrKpe9eNzLeMX/O/h9dEf/Woi6KmYLGPOnkiRzgBQNTCeMxPzQME+muzso0uUdV
         GX2UJFM+W1RbhRpEBzr/QnVOpgu8Fu/OlFL7/3dOdmx6bvFrAnJ8zeNF7WcXm8etPbeH
         CLR1xph/bIWqlC4lFV/9hKHS1KV2O6y6nDEtJXy7nK3sxFyoQWFeyU3Qid7IehS5PfVV
         34bQ==
X-Forwarded-Encrypted: i=1; AJvYcCUPQpt//ZdsMyuu+Y1P/RqFPOIGjfoXKZgUigSnNX0IuWVIt3LbXHe1eP1MxLcr4iDxGnjKQlNdcGp5044=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywx0Cfoxph98RRkgFuqCBrbB0Q+1RRCWkA+RqNO3nV8MbDFyd69
	+A+zJd4Yzp8US+M2cHl90rrHDnkFCmvdR5uspeiOzMoPcmg0yeEKaFGAEoJznN/WYY4=
X-Gm-Gg: ASbGncuE1i7Tr/yB3bFLjp5RekzsghBgmSsB7T80ElgfWxou9q2mBGyKQDfo0Ve5eDS
	phg+OlQPUbeT2ZbESaFssskaDuXTnXWkvSo6WIxzTPs2VhOEkDwKXjuASaSVcrc4wir1huNLdox
	iWKdSxMInnefULtcsgzhpY5+IdXNnXgioEaYpNllSjp+9ERnPVVvaLA451e0BI5Ubf0dplGHgjR
	NmkYFD6wbACfsUHvwRCmafFEX7XAN9OsKH2Y+A6pAtSjJfjG64qo1OXGMGOWGG8RhdOTQWFL7Vm
	MfvQH9Lq0L4m9hMFj6+vZWGO+1Zwo3TK+ZTL9s7MxpAjNc/l/ec1cqS4n/J+aoxtrkgVlQHAlGA
	uI1qd9V18mau2NtMCbJySSLFI
X-Google-Smtp-Source: AGHT+IHbDh/psntZAQrwhmgYfdd6+QUgFKcczM818cmbTUp9YMR8lJJAeTz4CAy+PPiDGOALUnKI9w==
X-Received: by 2002:a05:6e02:2305:b0:41f:5e50:23f1 with SMTP id e9e14a558f8ab-424819af385mr128428775ab.25.1758400735680;
        Sat, 20 Sep 2025 13:38:55 -0700 (PDT)
Received: from localhost ([140.82.166.162])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-53d50aa5f44sm3758324173.49.2025.09.20.13.38.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Sep 2025 13:38:55 -0700 (PDT)
From: Andrew Jones <ajones@ventanamicro.com>
To: iommu@lists.linux.dev,
	kvm-riscv@lists.infradead.org,
	kvm@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: jgg@nvidia.com,
	zong.li@sifive.com,
	tjeznach@rivosinc.com,
	joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com,
	anup@brainfault.org,
	atish.patra@linux.dev,
	tglx@linutronix.de,
	alex.williamson@redhat.com,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	alex@ghiti.fr
Subject: [RFC PATCH v2 02/18] iommu/riscv: Move struct riscv_iommu_domain and info to iommu.h
Date: Sat, 20 Sep 2025 15:38:52 -0500
Message-ID: <20250920203851.2205115-22-ajones@ventanamicro.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250920203851.2205115-20-ajones@ventanamicro.com>
References: <20250920203851.2205115-20-ajones@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In order to add the interrupt remapping support in a separate file,
share struct riscv_iommu_domain and struct riscv_iommu_info through
the header.

Signed-off-by: Andrew Jones <ajones@ventanamicro.com>
---
 drivers/iommu/riscv/iommu.c | 20 --------------------
 drivers/iommu/riscv/iommu.h | 20 ++++++++++++++++++++
 2 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/drivers/iommu/riscv/iommu.c b/drivers/iommu/riscv/iommu.c
index 0eae2f4bdc5e..901d02529a26 100644
--- a/drivers/iommu/riscv/iommu.c
+++ b/drivers/iommu/riscv/iommu.c
@@ -38,9 +38,6 @@
 #define phys_to_ppn(pa)  (((pa) >> 2) & (((1ULL << 44) - 1) << 10))
 #define ppn_to_phys(pn)	 (((pn) << 2) & (((1ULL << 44) - 1) << 12))
 
-#define dev_to_iommu(dev) \
-	iommu_get_iommu_dev(dev, struct riscv_iommu_device, iommu)
-
 /* IOMMU PSCID allocation namespace. */
 static DEFINE_IDA(riscv_iommu_pscids);
 #define RISCV_IOMMU_MAX_PSCID		(BIT(20) - 1)
@@ -802,26 +799,9 @@ static int riscv_iommu_iodir_set_mode(struct riscv_iommu_device *iommu,
 	return 0;
 }
 
-/* This struct contains protection domain specific IOMMU driver data. */
-struct riscv_iommu_domain {
-	struct iommu_domain domain;
-	struct list_head bonds;
-	spinlock_t lock;		/* protect bonds list updates. */
-	int pscid;
-	bool amo_enabled;
-	int numa_node;
-	unsigned int pgd_mode;
-	unsigned long *pgd_root;
-};
-
 #define iommu_domain_to_riscv(iommu_domain) \
 	container_of(iommu_domain, struct riscv_iommu_domain, domain)
 
-/* Private IOMMU data for managed devices, dev_iommu_priv_* */
-struct riscv_iommu_info {
-	struct riscv_iommu_domain *domain;
-};
-
 /*
  * Linkage between an iommu_domain and attached devices.
  *
diff --git a/drivers/iommu/riscv/iommu.h b/drivers/iommu/riscv/iommu.h
index 46df79dd5495..1d163cbd9e4d 100644
--- a/drivers/iommu/riscv/iommu.h
+++ b/drivers/iommu/riscv/iommu.h
@@ -17,8 +17,28 @@
 
 #include "iommu-bits.h"
 
+/* This struct contains protection domain specific IOMMU driver data. */
+struct riscv_iommu_domain {
+	struct iommu_domain domain;
+	struct list_head bonds;
+	spinlock_t lock;			/* protect bonds list updates. */
+	int pscid;
+	int amo_enabled;
+	int numa_node;
+	unsigned int pgd_mode;
+	unsigned long *pgd_root;
+};
+
+/* Private IOMMU data for managed devices, dev_iommu_priv_* */
+struct riscv_iommu_info {
+	struct riscv_iommu_domain *domain;
+};
+
 struct riscv_iommu_device;
 
+#define dev_to_iommu(dev) \
+	iommu_get_iommu_dev(dev, struct riscv_iommu_device, iommu)
+
 struct riscv_iommu_queue {
 	atomic_t prod;				/* unbounded producer allocation index */
 	atomic_t head;				/* unbounded shadow ring buffer consumer index */
-- 
2.49.0


