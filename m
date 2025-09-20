Return-Path: <linux-kernel+bounces-825901-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 218B7B8D119
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 22:42:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB67E3A830E
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 20:42:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CB692E2DC1;
	Sat, 20 Sep 2025 20:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="oZExTUWr"
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEDDF2E22B5
	for <linux-kernel@vger.kernel.org>; Sat, 20 Sep 2025 20:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758400752; cv=none; b=sbRWiEgPH7V5+dTPvRGfETVuDW7PNjrgiM9kuS2j5pi6coNTqYzGBbj5HfNifbffrnSlr3w5wWks6MGMTLVxiihO2ClTUe9EsOaJ2y8zUBKOmuFgvjRl/pPxsZysZY7bnaGHf37YNWTybljLAN0/wHZL0Cv8IyQa7lCngiuJT6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758400752; c=relaxed/simple;
	bh=Hg34JU7YAR3ovVopvNeMy/UYrJOofzU+xpM0EejLzeI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QImxCT73ZVaqqPS6mKDknvPGEPxa57shrxwQVa7s19wa3tDxvYKYfx+Hv8hFy1Oe2kZEKYyVY3RgoH31a7CjyEqRS4Uyt2sYULwncOCMRf7biZBhb9sN7LzdtfnAoCJwSLoWzvEci5pcBG1UowLGhz4DFPbGoBvu9QXfFL0Bcds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=oZExTUWr; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-4256f0fac67so5297865ab.2
        for <linux-kernel@vger.kernel.org>; Sat, 20 Sep 2025 13:39:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1758400750; x=1759005550; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tiJg8ON0boDhCQorG+j+Xw5gw12MCBbaI74+jnmrMFk=;
        b=oZExTUWrER6X/OgXrV7rlHfqqm468bDvvF0DIk1x9k77GCBQdVwSxk7ox+TIBVHnwY
         Dx57sU1muoIj86ADKODQB29H8gYgqUgkKsb60coYVAnUKxhbUhP3h9JSbbblphlE5MXD
         JNvsRqAJWlhoT5vQnT4F1rdq9jgiwHI3xHGkfRVDl8oahLIUCM/T0TGrdrvUL+ViOykv
         t23gOLG/g8ZCP25/+j7WpUchyyIwf8bau8tpTxYgxIYNFbIkawCsP+aWP9Zqzy7hpej+
         ZxxOkInWm/0R0PAvfYgUByS1RJt5cJ9Fs181Qpq1Tbpif2o3+J3NCtXEo9q14/+pG6OL
         QXcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758400750; x=1759005550;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tiJg8ON0boDhCQorG+j+Xw5gw12MCBbaI74+jnmrMFk=;
        b=HdL4tffjoRq5/JaV1UtTWvGrBObjobFFUKPsAh8k/072XWxv+edDYxZRu6fYFxw/P7
         jnzg58Bh9i90r422Dfo8OLanWmx7IPjKcU0YPpum2PNcWRNHy69tEEjfwj5iOYB9kpy4
         Urv7cMwwohml28qlBpMbOQD0ddtM4/pW/pvIJy248Mh/x9OCid7cjzzDjiAsjx1YiPaI
         SlSo8RxfeAmOR6dkEHZRCtSD6xw+TsKQ2VFn5hJ815uyK9JSZzebHtInSJjtov5Iq/dN
         NKcF2FUgORABPF0UxW4k8z/Jqznhfc66RGLpISJ1dp/7O0R2Alt5hJ07URG1Axad/jQR
         b4OA==
X-Forwarded-Encrypted: i=1; AJvYcCW7trXC6SgND6alrPZJE7v/RipTRDCSLIiacULnVhgD0yku9DUh9vOfq9JbJrYbEouycHZBF9ebIwXVQ5U=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVcHD9Kzg1S6mz5OY9prPti9oPTgq1E5uPvz/Uys623qdOzlcJ
	SMFHAuTcsRSROf20WTv0fIU/3bB3T9WLjY6qbBX4Lzz12WDuDXNv4xzzHsUWHRw8Z9w=
X-Gm-Gg: ASbGnctoddCN2A6gPhRhVleB3RLaO2Tj1ZOy6x59lYJFRJmIIGiLILwV0NZ/hnJJuDa
	Klwykk/QeUUwTLoGDH6zHsHDiB0sHgRibvWwGfoIAcjDqhqkEA/cFV/G5TrYd1cUWMsv4CwKJr7
	XvEPbQLeTsHmtveFK9MAgupxIN2DLbeQHPzRYb6EeTumM/N1K2zKXq2qiGlSg+0vb5jEEh8ywSs
	knyYR34BinHRPUEoO9te9IQk9X3R3lM97GA8H24ebm3jVOLifpCBr7uOV7s/QwgBzSo/1u/Brsh
	L/CF9dl5mC0gP9K4aGAu0PpAie+A6DJqG42LMzNVZkykARaNmJeBnN86rAaNTO4KSziws33kKw7
	Lny909v3FolHp2wwgd6xmYjtZ
X-Google-Smtp-Source: AGHT+IFsmriwC7sM1H4SekuoxTk4S0bUk4TUqEUdLP6mEpfm4K0KojSVb0TkIY/Q7lu1c7nixhkmrw==
X-Received: by 2002:a92:c24c:0:b0:40c:410d:dc35 with SMTP id e9e14a558f8ab-424819709a7mr96072735ab.21.1758400749673;
        Sat, 20 Sep 2025 13:39:09 -0700 (PDT)
Received: from localhost ([140.82.166.162])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-4248a975078sm17095365ab.17.2025.09.20.13.39.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Sep 2025 13:39:09 -0700 (PDT)
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
Subject: [RFC PATCH v2 13/18] iommu/riscv: report iommu capabilities
Date: Sat, 20 Sep 2025 15:39:03 -0500
Message-ID: <20250920203851.2205115-33-ajones@ventanamicro.com>
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

From: Tomasz Jeznach <tjeznach@rivosinc.com>

Report RISC-V IOMMU capability required by the VFIO subsystem
to enable PCIe device assignment.

Signed-off-by: Tomasz Jeznach <tjeznach@rivosinc.com>
Signed-off-by: Andrew Jones <ajones@ventanamicro.com>
---
 drivers/iommu/riscv/iommu.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/iommu/riscv/iommu.c b/drivers/iommu/riscv/iommu.c
index 02f38aa0b231..5a0dd99f07d0 100644
--- a/drivers/iommu/riscv/iommu.c
+++ b/drivers/iommu/riscv/iommu.c
@@ -1452,6 +1452,17 @@ static struct iommu_group *riscv_iommu_device_group(struct device *dev)
 	return generic_device_group(dev);
 }
 
+static bool riscv_iommu_capable(struct device *dev, enum iommu_cap cap)
+{
+	switch (cap) {
+	case IOMMU_CAP_CACHE_COHERENCY:
+		/* The RISC-V IOMMU is always DMA cache coherent. */
+		return true;
+	default:
+		return false;
+	}
+}
+
 static int riscv_iommu_of_xlate(struct device *dev, const struct of_phandle_args *args)
 {
 	return iommu_fwspec_add_ids(dev, args->args, 1);
@@ -1531,6 +1542,7 @@ static void riscv_iommu_release_device(struct device *dev)
 
 static const struct iommu_ops riscv_iommu_ops = {
 	.of_xlate = riscv_iommu_of_xlate,
+	.capable = riscv_iommu_capable,
 	.identity_domain = &riscv_iommu_identity_domain,
 	.blocked_domain = &riscv_iommu_blocking_domain,
 	.release_domain = &riscv_iommu_blocking_domain,
-- 
2.49.0


