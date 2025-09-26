Return-Path: <linux-kernel+bounces-833709-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F172BA2CA9
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 09:32:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4FA55625D07
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 07:31:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D720428750A;
	Fri, 26 Sep 2025 07:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NsmADlEt"
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 655C1286426
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 07:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758871834; cv=none; b=p9A5rjhqfEl/g+T+Gnfp+QYA2MEO/zWcN+hsUWIon4GLA350dgEc2b2EjZYiagv/sdxYBx9YKH8L7epn+v6bvFIYI1/4iPLZdynA+0kXIVxjSBC9MYlZirLXRqd1LRfQMuw8CPIrK6XUahnLyVOUceTQKWy3Zoe70B0i3/9jfI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758871834; c=relaxed/simple;
	bh=6Lc+pIB1LdtktN7Z2Zgxt+CHB2qivEkBYFlDtKk9Bz8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FZMhxMsj50vAAl3oWp0eARoksJWGiFqY+fKzmRGyx+vSVFGPSE6ICzotrKuUX5auKxWdJUNAdI4to83xghPCWuKb6F3LZZEK5t9a/x9ksfUyQ7TxUVgTYyF6hP3ZgJvroWOP9iaHzfUMBsDwtuQnxUzrmTE84kR5ja850ti/Pk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NsmADlEt; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-b550a522a49so1669812a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 00:30:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758871832; x=1759476632; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aSEZq8w/PRxCnrID2Y5d0d0SEP9SLps2HU2L0+eGoGY=;
        b=NsmADlEtq+xQKbWYlrQlxwAdsYPUOBhPVz1WvpIMEOTqZ7D5pqfeVWOHCjyzD/0Ish
         MofTuwICp9QZvLjcZ+jXoqKtYDy81uRZTmtNsNXj3yi/b5T0cE8QlKLXa0Z3KeUqLOIF
         A8Al+q64R/JRzaKfSYIFHVoS1NaNqsBBBlt6YAkrSaYtoKNV6Qs/JeKinQn2XqR6OzQi
         d2YPme/Zzn7xg5Ev5BXivoyLUbd/e7j0KtmLwa8RPuuwxcDP6PDPYv5MmlgRugpMwz+9
         4z6NZPL/2JzD8EgZZiCM/MFuCtHOV1BVa0kVavLKNNAkJEByCwnzfddsAVBHs0DePFhm
         A8IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758871832; x=1759476632;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aSEZq8w/PRxCnrID2Y5d0d0SEP9SLps2HU2L0+eGoGY=;
        b=kU+tiGddHkEza5Azml3klo2/YPB3Ci6hlhe7DyBOtIoNIRqtAiFfzOy4FSrpEk+8m6
         KI1bSPpGtGuIDhOQSctgVujcrbiCEkzxtN9HPRuWdtFeyEWVn330OA2NnVgJzCCfw4Tp
         ql3VxcCWahDQeTniW5vtvJcFayMECqyopfLdUGwMrYCm8tpu5e2S/YBQ8nmjvbpOAL+P
         9sOJyvi8zMkvM/90nfb8DBRd1tGruu/UBTValwCQ9cbUrDeADTfRVvJrZmcxg2Mdfxtz
         5WFUpJVkAwGk+fFtp4XkdAzoFxtTAQVlOmAD5QcuobInC4BzPORLal1uJT7OdNtzbbTT
         3nNw==
X-Forwarded-Encrypted: i=1; AJvYcCVWMsn2WeIdBCLkZk2ePQEgRIN8v1hf6ZKV8xYVwxpY5dsy/Piw9MQLO5Udr66fUi4lyXJ2ipNoauLRL/0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzlY/tGGfHDtwhpVeL8rMkAUboQrsgNpsYm99u/KcX3oiS5IGp
	11rHupYa7m4V9o0rVax+IVcaDLMws1s+w/duyXo+Yi+EbBe6YtPSe1Az
X-Gm-Gg: ASbGncuFQ9EHvY/lJfLxl/Jnun/rHryEeHYc9PpOM2FNqklr2PIiAYxz/lSfkkD/qIP
	lxwz5Wo2s3oeWNtBQwPQKSWyRrSrK3s8GpyDeo4TDW5KIpa3tEVu8T8h4B+qnmL1DG1e9SCWHfC
	dPYfJ1wtvARJKDjKtqGhmOsaUmJ0Vc4hZkez1jUbL1GGgJV/CC1k8xcNd5Z+IvpUZ4nED9WJr5O
	oz3khpkpVPk0W0NV4ehW7JPvUl155RnCzn06SsW4qhlt+Fnp6KmEZcYsE7QoqZR0+nzd9yEgenI
	kDVL6XDOsmF28mG8MYSxKz0CkUOG0F5vJ6y/+0bV1pmqxEU6MCo/Yl+a1Xg8k43V/3qE2v5Zate
	DNoZb+zP/D0Q8fvmrJwXC
X-Google-Smtp-Source: AGHT+IG+8wcNbZ1mF4LIuGVqoV+lEiR0nH0teiABbbJAvSAPFBdcwV+sobdgY9ZY43R4oF0vAZAAdA==
X-Received: by 2002:a17:902:db04:b0:265:9878:4852 with SMTP id d9443c01a7336-27ed49ddab3mr78603555ad.15.1758871831650;
        Fri, 26 Sep 2025 00:30:31 -0700 (PDT)
Received: from rockpi-5b ([45.112.0.216])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed69a98b9sm44083065ad.111.2025.09.26.00.30.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Sep 2025 00:30:30 -0700 (PDT)
From: Anand Moon <linux.amoon@gmail.com>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	linux-pci@vger.kernel.org (open list:PCI NATIVE HOST BRIDGE AND ENDPOINT DRIVERS),
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-tegra@vger.kernel.org (open list:TEGRA ARCHITECTURE SUPPORT),
	linux-kernel@vger.kernel.org (open list)
Cc: Anand Moon <linux.amoon@gmail.com>
Subject: [PATCH v1 5/5] PCI: tegra: Document map_lock and mask_lock usage
Date: Fri, 26 Sep 2025 12:57:46 +0530
Message-ID: <20250926072905.126737-6-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250926072905.126737-1-linux.amoon@gmail.com>
References: <20250926072905.126737-1-linux.amoon@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add comments to clarify the purpose of map_lock and mask_lock in the
tegra_msi structure. This addresses checkpatch.pl warnings about missing
comments for struct mutex and spinlock_t definitions, improving code
readability without functional changes.

CHECK: struct mutex definition without comment
+       struct mutex map_lock;

CHECK: spinlock_t definition without comment
+       spinlock_t mask_lock;

Cc: Jon Hunter <jonathanh@nvidia.com>
Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
v1: new patch in this series.
---
 drivers/pci/controller/pci-tegra.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pci/controller/pci-tegra.c b/drivers/pci/controller/pci-tegra.c
index 02cee0763396..24b6ae0f0035 100644
--- a/drivers/pci/controller/pci-tegra.c
+++ b/drivers/pci/controller/pci-tegra.c
@@ -270,7 +270,9 @@
 struct tegra_msi {
 	DECLARE_BITMAP(used, INT_PCI_MSI_NR);
 	struct irq_domain *domain;
+	/* Protects mapping operations */
 	struct mutex map_lock;
+	/* Guards interrupt mask updates */
 	spinlock_t mask_lock;
 	void *virt;
 	dma_addr_t phys;
-- 
2.50.1


