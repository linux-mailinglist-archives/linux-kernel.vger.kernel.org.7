Return-Path: <linux-kernel+bounces-835549-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 57E75BA76AE
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 21:09:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C6DBE18967D3
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 19:10:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BB702737F2;
	Sun, 28 Sep 2025 19:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dS12Kdhx"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7064B2701B6
	for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 19:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759086480; cv=none; b=d61tez+BshGEeiWQGyQW6DRmLitIDom6jNSapezoGTl8MQKpWXLbpdf8wWbPpESOCycH6wAl1FDsUjd9AYK7zDSz0oNQQ36f2XrBDPi5NWQ8EeOMAxbrFe4sW2us1kHU3dRn5cxx3vml2KjME7qdgCet79pFpLul0znWlqZC29M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759086480; c=relaxed/simple;
	bh=dUFxCLs7p9f1eI8l4b/ZFNt/1ECQtCPnVCtAG5CC0cA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ELnJMUS47mItWaiRZZCfRLiGYwxm95ed+gsibEPwKjioNX4SZ8g58tXRSy36304o6vs49sKmbQL3axH834Fw3TvmOlh1ADnj07UtEht8uZccNygQga68gRH9e1+gjSNuJ8Sxshu5UH90k+v7lfSWnsfgu9PkG67ePrSV9V00o/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dS12Kdhx; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-286a252bfbfso21150495ad.3
        for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 12:07:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759086478; x=1759691278; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=oIOurj+2nVVUDk10T5jpgRKE6q2CDkbGgR0n/0hZqjQ=;
        b=dS12KdhxGofTY5YH1pkQLUoDKjU2tbeb0Ogr0id4+GN1u9k7jMNCgvJz8UVXQ2OVY4
         fSQFY7jmeP1s8NH5CMQBKnLGlRdtRksefkeRrkkwqzVeiFuOVYRxOhmsaz0G4WlCjYFI
         xQsq6f9DrwzQ340PzbVu8GSIfUO3Xx9R8y+9u8Ze2Dd0h7z0XS6i6PQIejLsyQhTtV4F
         3pFBzG8oGMA3KRSRDMQjbxUUKjJjcsKpoSM6WYTtqf5yE3bNH5PSNJG+0Ij6EDpEMwKr
         UIWKxaU9phaxUHU+ERGZ7zpRW8mvSw2qJ/OaYOCxPpL/OnyW5MwyNS/0FaHQRePB6wpw
         dCqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759086478; x=1759691278;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oIOurj+2nVVUDk10T5jpgRKE6q2CDkbGgR0n/0hZqjQ=;
        b=Ot4d9Y1Ck1aeUKSL6zdple0KhuDgg9fu5vYbFLml7IY8kBMdUvnmJFD6c7ihLEngh5
         5yTyfI8GwFTpBPKn9zsacGcyAUdQyqiBDdTru5woX/bf6PsB1JnL+dLm0yIX3KDmCOUC
         jxhFt09dSmwTojwt9+WIdqGrWbIMPRm+C3CD9ph9lDguv59h/G7O3JaIPNbdlGkUBrAb
         Xoo31Krz4S41s6oh04kBZ1Pk4vac0yjWZrCdYG6mhyAXRKgKINtW8n+2aWmGFFz1DHBo
         Pmo7QQPxbVQSfUGrCKai6GxXvTwuPeoemEsIUfRI9LY7wEleE4iysL5lq3+f85HD+/G4
         scHw==
X-Forwarded-Encrypted: i=1; AJvYcCU6qea3AbOFaP7Vlc10qY62S/si2Uq8ZHaIGzDe0UAh2As1cLEQxqfTUEJmIuRvXazrisF3hYAONrdAnGQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxE/Nl7ZAgWWduyU4xjsHRSbiZ1scqIsjti25gNopcmsL12fXnU
	xmfaaphAVpyberoVm2AmTYd7920VoDeOyr2MJIUauulcFM6IyJ42rfMmPuvX+GTG8/RQbkamA+f
	MuW1mNAyPkRCNqA==
X-Google-Smtp-Source: AGHT+IElf39/DKJfyLea14v/9U1aXLe5jJdoyOqxRTz9WC5PCBwphXq5PQNOB03FmfvrzghM771xyTnwDScHMw==
X-Received: from pjbpg12.prod.google.com ([2002:a17:90b:1e0c:b0:32b:50cb:b92f])
 (user=skhawaja job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:27cc:b0:269:63ea:6d4e with SMTP id d9443c01a7336-27ed4a3de18mr105082665ad.37.1759086477777;
 Sun, 28 Sep 2025 12:07:57 -0700 (PDT)
Date: Sun, 28 Sep 2025 19:06:19 +0000
In-Reply-To: <20250928190624.3735830-1-skhawaja@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250928190624.3735830-1-skhawaja@google.com>
X-Mailer: git-send-email 2.51.0.536.g15c5d4f767-goog
Message-ID: <20250928190624.3735830-12-skhawaja@google.com>
Subject: [RFC PATCH 11/15] iommufd: Add basic skeleton based on liveupdate_file_handle
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

No functionality is implemented in this commit. Just registering and
unregistering of the struct liveupdate_file_handle for iommufd.

All operations are stubs returning either error or no-op.

Signed-off-by: YiFei Zhu <zhuyifei@google.com>
Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
---
 drivers/iommu/iommufd/Makefile          |  1 +
 drivers/iommu/iommufd/iommufd_private.h | 15 ++++++
 drivers/iommu/iommufd/liveupdate.c      | 68 +++++++++++++++++++++++++
 drivers/iommu/iommufd/main.c            | 14 ++++-
 4 files changed, 97 insertions(+), 1 deletion(-)
 create mode 100644 drivers/iommu/iommufd/liveupdate.c

diff --git a/drivers/iommu/iommufd/Makefile b/drivers/iommu/iommufd/Makefile
index 71d692c9a8f4..f37830ff7229 100644
--- a/drivers/iommu/iommufd/Makefile
+++ b/drivers/iommu/iommufd/Makefile
@@ -17,3 +17,4 @@ obj-$(CONFIG_IOMMUFD_DRIVER) += iova_bitmap.o
 
 iommufd_driver-y := driver.o
 obj-$(CONFIG_IOMMUFD_DRIVER_CORE) += iommufd_driver.o
+obj-$(CONFIG_LIVEUPDATE) += liveupdate.o
diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index 0da2a81eedfa..faf48ca9e555 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -702,6 +702,21 @@ iommufd_get_vdevice(struct iommufd_ctx *ictx, u32 id)
 			    struct iommufd_vdevice, obj);
 }
 
+#ifdef CONFIG_LIVEUPDATE
+int iommufd_liveupdate_register_lufs(void);
+int iommufd_liveupdate_unregister_lufs(void);
+#else
+static inline int iommufd_liveupdate_register_lufs(void)
+{
+	return 0;
+}
+
+static inline int iommufd_liveupdate_unregister_lufs(void)
+{
+	return 0;
+}
+#endif
+
 #ifdef CONFIG_IOMMUFD_TEST
 int iommufd_test(struct iommufd_ucmd *ucmd);
 void iommufd_selftest_destroy(struct iommufd_object *obj);
diff --git a/drivers/iommu/iommufd/liveupdate.c b/drivers/iommu/iommufd/liveupdate.c
new file mode 100644
index 000000000000..6d2a64966335
--- /dev/null
+++ b/drivers/iommu/iommufd/liveupdate.c
@@ -0,0 +1,68 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#define pr_fmt(fmt) "iommufd: " fmt
+
+#include <linux/file.h>
+#include <linux/iommufd.h>
+#include <linux/liveupdate.h>
+
+#include "iommufd_private.h"
+
+static int iommufd_liveupdate_prepare(struct liveupdate_file_handler *handler,
+				      struct file *file, u64 *data)
+{
+	return -EOPNOTSUPP;
+}
+
+static int iommufd_liveupdate_freeze(struct liveupdate_file_handler *handler,
+				     struct file *file, u64 *data)
+{
+	/* No-Op; everything should be made read-only */
+	return 0;
+}
+
+static void iommufd_liveupdate_cancel(struct liveupdate_file_handler *handler,
+				      struct file *file, u64 data)
+{
+}
+
+static void iommufd_liveupdate_finish(struct liveupdate_file_handler *handler,
+				      struct file *file, u64 data, bool reclaimed)
+{
+}
+
+static int iommufd_liveupdate_retrieve(struct liveupdate_file_handler *handler,
+				       u64 data, struct file **file_p)
+{
+	return -EOPNOTSUPP;
+}
+
+static bool iommufd_liveupdate_can_preserve(struct liveupdate_file_handler *handler,
+					    struct file *file)
+{
+	return false;
+}
+
+static struct liveupdate_file_ops iommufd_lu_file_ops = {
+	.prepare = iommufd_liveupdate_prepare,
+	.freeze = iommufd_liveupdate_freeze,
+	.cancel = iommufd_liveupdate_cancel,
+	.finish = iommufd_liveupdate_finish,
+	.retrieve = iommufd_liveupdate_retrieve,
+	.can_preserve = iommufd_liveupdate_can_preserve,
+};
+
+static struct liveupdate_file_handler iommufd_lu_handler = {
+	.compatible = "iommufd-v1",
+	.ops = &iommufd_lu_file_ops,
+};
+
+int iommufd_liveupdate_register_lufs(void)
+{
+	return liveupdate_register_file_handler(&iommufd_lu_handler);
+}
+
+int iommufd_liveupdate_unregister_lufs(void)
+{
+	return liveupdate_unregister_file_handler(&iommufd_lu_handler);
+}
diff --git a/drivers/iommu/iommufd/main.c b/drivers/iommu/iommufd/main.c
index 15af7ced0501..b3bf65bc8da4 100644
--- a/drivers/iommu/iommufd/main.c
+++ b/drivers/iommu/iommufd/main.c
@@ -723,11 +723,21 @@ static int __init iommufd_init(void)
 		if (ret)
 			goto err_misc;
 	}
+
+	if (IS_ENABLED(CONFIG_LIVEUPDATE)) {
+		ret = iommufd_liveupdate_register_lufs();
+		if (ret)
+			goto err_vfio_misc;
+	}
+
 	ret = iommufd_test_init();
 	if (ret)
-		goto err_vfio_misc;
+		goto err_lufs;
 	return 0;
 
+err_lufs:
+	if (IS_ENABLED(CONFIG_LIVEUPDATE))
+		iommufd_liveupdate_unregister_lufs();
 err_vfio_misc:
 	if (IS_ENABLED(CONFIG_IOMMUFD_VFIO_CONTAINER))
 		misc_deregister(&vfio_misc_dev);
@@ -739,6 +749,8 @@ static int __init iommufd_init(void)
 static void __exit iommufd_exit(void)
 {
 	iommufd_test_exit();
+	if (IS_ENABLED(CONFIG_LIVEUPDATE))
+		iommufd_liveupdate_unregister_lufs();
 	if (IS_ENABLED(CONFIG_IOMMUFD_VFIO_CONTAINER))
 		misc_deregister(&vfio_misc_dev);
 	misc_deregister(&iommu_misc_dev);
-- 
2.51.0.536.g15c5d4f767-goog


