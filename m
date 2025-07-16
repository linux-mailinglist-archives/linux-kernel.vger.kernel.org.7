Return-Path: <linux-kernel+bounces-733369-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FDD3B073B6
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 12:42:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A887583785
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 10:42:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE92D2F49E9;
	Wed, 16 Jul 2025 10:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="NZRwvBL7"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB8592F4337
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 10:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752662485; cv=none; b=PUk3obuJkgGr2Ir5wF9MsAGRQMzS7g1JefAoVAck0LFMQnj+HvCQGnWJBh3uDhX9sB1W31oduMsj6LrIsBy9qEhkIuQO7rhwzaMZnZ/gcThfq+6rmjJAP6blpCf9yOS7UqZEFjhXYBnn/ETuQGJCUlS+yM0jEJvXqMU8pd3KzbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752662485; c=relaxed/simple;
	bh=yeEgt3B7oP+kZLvu/rWotic5mkE4aCWzjFVNCBZaVhw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IgzeT0mSQ0KdYPII/8WP4w003nbikA3sB17eKc1OS6mPH9d9bvy7xSdEFv0UfmyzxhamgDWFfUYEmXZMzw8UNkTxTCqcbNdm4MYkqQeatOVlFq09BzsGdawN6pxciU/pOk/peJlVjAIT4nmuzqE+sdmcG7mhv2jwE0YiJuRnWy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=NZRwvBL7; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-748e81d37a7so3920351b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 03:41:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1752662482; x=1753267282; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YaG3DvsXq5/AKyC1GLSjgb34PJp+nqhxTUl2VKU3MC8=;
        b=NZRwvBL7TQCUevVXlVOVDtTEb4fXOJ0970bmPnHHjezYtwcOFyf23lbCu1M0BUwOjd
         c4KZvgeZtaYKGCIPa7SqZc4IoR0TNYVLA6hS/4Str8WlMLipmxs+Onzc8OYEImAivX16
         rlsPJAVHgkRo/A9dRoxO6PFVs/FrDIRYFRgMGw4uXseFg5dVpGlR3qJyRkaeACbw6HWC
         j+SthCv7wctN/ZzgYz9xhW9nrzO1aKvoa230paMOl62wr2YoS6v9y+qnkDAOYHHAAxAH
         8h+fp5h3g2/IuEuPlT0SSlc5hPBSm0oKy7NO1SgVHZhkjdBsoNWZ2W15H8vzXHzcBlfC
         Y0Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752662482; x=1753267282;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YaG3DvsXq5/AKyC1GLSjgb34PJp+nqhxTUl2VKU3MC8=;
        b=vJ05z/brJa2hA48XZuQKjvD8C6ddLox0hDvGW/P9mWfAJjDztDEc+dTUdEXe71PSyG
         65ZmU5yrm7nRVK85meKlwYQw0ayOGEbnHIIFzbueLVf5KrLMHKtJm/LfmztXc4nDiEs/
         yEmHAxVg9dF1ZUfQq8ZulO+mA9Pyw6m6Zq2vSF14dzek/nFOsSfURT4YE0B3vOCiDGFs
         aOPemoqYB53AtXHzhn+HhR6N7VUMqXo3Ggh+0hcCzZ2baAYglYSawkHlM2VB57SoqfEs
         u9w/gaAIF1e81oHEXxmL/pD4kDyt0vzxROTQDo2fj/9V5chv9kUuLl85jlOzq/fQYesX
         wpnQ==
X-Gm-Message-State: AOJu0YxM09beYGOxVShupl5IH+3xBPwdzb9ZoYsSKlFoqkaGDU7BWa9M
	VDRiTEdwGt39rZNypLsMojfLKTePOnw/T1b2ZfWVifptCyadDGWj1CIhasJ7ljuhvwFoADshhDa
	8z9GxZ3Q=
X-Gm-Gg: ASbGnctDhusYJRzb2U+58KM9/HNe3/NXKV8KZx4TvMloc1AJnvHRnBptesUy+PmNlUr
	LP9eWVUq4e6OdoWoiRoDTb53rG/JMlHPALu7oIfmhIAQFyPyEBCHZR9xH98gDaoEU1MB+ysNzFS
	2dXAlOyCWQk4OuEP0fXgQtTlClUN+2CL3QDauc4eGOwlRffnUxg9LbKMAmqYtXNQ0LWPVSotpDK
	LjxTHKFMIslswNC3Pi90UQ6FuvM5F9F+JGx8vtmvtE+Jz5qFdLpau06AgVeW1qNt5LF+8ldxhs4
	GMzfPkV8tlI5ZcH6P+Vncwu6LCGTQduMe/8UCtRXZx5ucK7IqxNDGA1TAIj3qxXcBnP4OG4qyIT
	kxkpPe08Itbe1ppfgrztkf85tPgmsRIpZ
X-Google-Smtp-Source: AGHT+IEC8Wh248xbvV7SVKKzD0alSVzVgeFsgJh9ogEs3+/ngP7xonwyOrkgTHqNNgbjcXTmqAIWTg==
X-Received: by 2002:a05:6a00:2387:b0:749:540:ca72 with SMTP id d2e1a72fcca58-756ea8b944bmr4580850b3a.24.1752662481956;
        Wed, 16 Jul 2025 03:41:21 -0700 (PDT)
Received: from sunil-pc.Dlink ([106.51.195.230])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74eb9f1af40sm13946709b3a.72.2025.07.16.03.41.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 03:41:21 -0700 (PDT)
From: Sunil V L <sunilvl@ventanamicro.com>
To: linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-acpi@vger.kernel.org,
	iommu@lists.linux.dev
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Alexandre Ghiti <alex@ghiti.fr>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Tomasz Jeznach <tjeznach@rivosinc.com>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Atish Kumar Patra <atishp@rivosinc.com>,
	Anup Patel <apatel@ventanamicro.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Sunil V L <sunilvl@ventanamicro.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH v5 2/3] ACPI: scan: Add support for RISC-V in acpi_iommu_configure_id()
Date: Wed, 16 Jul 2025 16:10:58 +0530
Message-ID: <20250716104059.3539482-3-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250716104059.3539482-1-sunilvl@ventanamicro.com>
References: <20250716104059.3539482-1-sunilvl@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

acpi_iommu_configure_id() currently supports only IORT (ARM) and VIOT.
Add support for RISC-V as well.

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/scan.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index fb1fe9f3b1a3..f022f32de8a4 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -11,6 +11,7 @@
 #include <linux/kernel.h>
 #include <linux/acpi.h>
 #include <linux/acpi_iort.h>
+#include <linux/acpi_rimt.h>
 #include <linux/acpi_viot.h>
 #include <linux/iommu.h>
 #include <linux/signal.h>
@@ -1628,8 +1629,11 @@ static int acpi_iommu_configure_id(struct device *dev, const u32 *id_in)
 	}
 
 	err = iort_iommu_configure_id(dev, id_in);
+	if (err && err != -EPROBE_DEFER)
+		err = rimt_iommu_configure_id(dev, id_in);
 	if (err && err != -EPROBE_DEFER)
 		err = viot_iommu_configure(dev);
+
 	mutex_unlock(&iommu_probe_device_lock);
 
 	return err;
-- 
2.43.0


