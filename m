Return-Path: <linux-kernel+bounces-844344-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E9C6FBC1A2F
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 16:06:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 27BEF4F69DD
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 14:05:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F9D42E284A;
	Tue,  7 Oct 2025 14:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="NuoqihyM"
Received: from mail-yx1-f97.google.com (mail-yx1-f97.google.com [74.125.224.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B9252E1C7B
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 14:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759845900; cv=none; b=tNDL0D6DPGulr4tDNCfBj+9q9aIOcsLZB6cjRZpDgs6X/wnskjwq9wP64+VuChfITfDIdpLOCu8zV6RP84JIW86bVseg2djhweRdggjWuHxMv5hUJ8FJeUwH6f+dY/jgXivZKB/NcebJDZfzecgsULv8rAZWKjvKyhidFavl4wQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759845900; c=relaxed/simple;
	bh=vUUmEvlmkeV1irok1/nIhqLFK/Atv2L+zIdkEFj6r50=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kk+vYE2dsSkuKoVyx8u/hpRlqKndd8QpH00mL17cnSAnZoshteGG9tlpxXwnTrmZP7Gz7l7+vi2Yw1CqL9pvEIGbQRQSt3aT8O8GgQrsiNeYvrIuVG6VdSj2T8vbJFTSeVv4C3WQFweLUQIqp/IlHimivpAEMZ0jm4pwficIDYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=NuoqihyM; arc=none smtp.client-ip=74.125.224.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-yx1-f97.google.com with SMTP id 956f58d0204a3-63bcdf5f241so4790208d50.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 07:04:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759845898; x=1760450698;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SzHMYfimzskmCvhQZFOQq3Y8wAS1gFZFKB5XWvB1gEs=;
        b=pI2BN5m71RULZ8bT4AtOUr6+WsK0PXGrZRc6a7TYCDQ/0ohuUuLdWIwda0WpbWfqw+
         KRZZWpDQbA0rvY86QjH+Jv+XrSCP1ipNfTjuJaHHy0iLzuovTWWvylDEMlvjUobwret3
         u43FTedRVi+yvZv150nsHya2Xj+550wu9SfWZ2aC+27cCnDCSgJ4HKW33idmbQT5nKcA
         foihKVTTmFHv0uZTW0z5uPD+iMJeHRL+NjSNZW5uhucrY3eJT/BlGZSUTtRIaj89jUYh
         N75GNJ06RSv5WOinHYiBdVgPt6Zam3vINbdQn0sua8Fg0oXSl9Cc388YBjrZJXLqAuCR
         RIfg==
X-Forwarded-Encrypted: i=1; AJvYcCW81z8G1HIn+zRHG7IPNwDYDHN8KjaUKkdpaZli996sHCahfI0JXiLksQmHtyBInCrWgPjYjd0KN1J1WFM=@vger.kernel.org
X-Gm-Message-State: AOJu0YypMiafSAgLF9GsWjE3cFxkdose1+NnLUdFg9qk5FyKEIad8Dwo
	nsb9LX9OlaTPREdDFpNhGFWOUCri7AByVfHX0JA0RpAHsLPpaiZsrK62yv0LOtrspO904tSes3Y
	qGcHoYVjoNMIN0Lleg7ox5tW/O7viyKevqM7ekH73iYf4KRxWjahvrh+1c4AoDxafOecg3NM3b5
	+G1mDHvx5NBR/sTIlapw6czeZhqFMHoFtquE0GJsPSa32iAQG1/WG1HAesP3+ZXGtBOji5vwpbh
	5opYfiU/MpdQJaZ
X-Gm-Gg: ASbGncsicsVdgLP+jITif4ECoS/OA4qq1/J1uTUm5MawluM0+18HGSW2msv41sJ/a3W
	HP+j49lBz5NbWw9Bm/6CifAn5LEZmOv/MvS/21diPHmcppeDiCMlhc18cBONIKyogZej6uQs+Br
	fBzjCo55pA6o9KllNB9pF/ltOHtwUIhd6DlLjEb8ZD8mWZ5liKxKqk/bxEvguebnwVZuzdEi5Ea
	ZTa/JN72yDnyruvXIvZSYSUa6ffXHiown4/VZ8JIi80Ms0RJzzDGizvoAZk3RJWuD8N3WDgmLAt
	tw3LIGM16xhzABkIUL9AdiJNCC+w44uhmWwGyyYzg5giF6Jyg/Oy7FY/nVTqSz2imN2+qk3j3dT
	m6Z+60Nitp+y0+LVIst+ch6gnTGTZ+zClbR0stepC7IXbmp23+AGWW91bshqkbyi50YeRy42dfj
	W/KTEs
X-Google-Smtp-Source: AGHT+IEk52MJRiKrgXLhdgDjJfb4X1mQwpb9umLnbPvpKmgAVPR4ndWlrP1zBg2fo5bU+ehTTYesxFeq4R17
X-Received: by 2002:a53:dd03:0:b0:63b:822c:449a with SMTP id 956f58d0204a3-63cbe0d3a50mr2963475d50.16.1759845897713;
        Tue, 07 Oct 2025 07:04:57 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-126.dlp.protect.broadcom.com. [144.49.247.126])
        by smtp-relay.gmail.com with ESMTPS id 956f58d0204a3-63b84686bf1sm919212d50.14.2025.10.07.07.04.57
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 Oct 2025 07:04:57 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-86b8db0e70dso153814426d6.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 07:04:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1759845897; x=1760450697; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SzHMYfimzskmCvhQZFOQq3Y8wAS1gFZFKB5XWvB1gEs=;
        b=NuoqihyMDCEC+Ho30inYY3l85IznEQa1+z6KWRQ6EmB82zoWOjzqjwqzDZK0Q6mrQp
         gZYnoYrVHBZo4+DyTSIBCGp3+m0bu1NzFVUa3DdefRmpEbb+R12IJYq+Y5lTOBVROEBD
         U/+YXdIa6Q+LhUIAdZTdSElVIg4OdEbUah/pc=
X-Forwarded-Encrypted: i=1; AJvYcCUfbB92399M6Asds18GYhJircOeZ4hM3ZR3tWXn9ICo5eh3NWj7vkg9BNKrKxgB6LPVdO2QVWJia4+FbtU=@vger.kernel.org
X-Received: by 2002:ad4:5ca9:0:b0:78c:f62c:8eb1 with SMTP id 6a1803df08f44-87a052a7fc2mr39707506d6.26.1759845896920;
        Tue, 07 Oct 2025 07:04:56 -0700 (PDT)
X-Received: by 2002:ad4:5ca9:0:b0:78c:f62c:8eb1 with SMTP id 6a1803df08f44-87a052a7fc2mr39706726d6.26.1759845895821;
        Tue, 07 Oct 2025 07:04:55 -0700 (PDT)
Received: from mail.broadcom.net ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-878bae60b67sm142718956d6.9.2025.10.07.07.04.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 07:04:55 -0700 (PDT)
From: Kamal Dasu <kamal.dasu@broadcom.com>
To: andersson@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	florian.fainelli@broadcom.com,
	ulf.hansson@linaro.org,
	adrian.hunter@intel.com
Cc: bcm-kernel-feedback-list@broadcom.com,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mmc@vger.kernel.org,
	Kamal Dasu <kamal.dasu@broadcom.com>
Subject: [PATCH v2 2/5] mmc: sdhci-brcmstb: move SDIO_CFG_CQ_CAPABILITY define
Date: Tue,  7 Oct 2025 10:04:30 -0400
Message-Id: <20251007140434.606051-3-kamal.dasu@broadcom.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251007140434.606051-1-kamal.dasu@broadcom.com>
References: <20251007140434.606051-1-kamal.dasu@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

Moving SDIO_CFG_CQ_CAPABILITY register defines to be in sorted order for
better readability.

Signed-off-by: Kamal Dasu <kamal.dasu@broadcom.com>
---
 drivers/mmc/host/sdhci-brcmstb.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/sdhci-brcmstb.c b/drivers/mmc/host/sdhci-brcmstb.c
index efc2f3bdc631..f81cc1889ac9 100644
--- a/drivers/mmc/host/sdhci-brcmstb.c
+++ b/drivers/mmc/host/sdhci-brcmstb.c
@@ -31,13 +31,11 @@
 
 #define SDHCI_ARASAN_CQE_BASE_ADDR		0x200
 
-#define SDIO_CFG_CQ_CAPABILITY			0x4c
-#define SDIO_CFG_CQ_CAPABILITY_FMUL		GENMASK(13, 12)
-
 #define SDIO_CFG_CTRL				0x0
 #define SDIO_CFG_CTRL_SDCD_N_TEST_EN		BIT(31)
 #define SDIO_CFG_CTRL_SDCD_N_TEST_LEV		BIT(30)
-
+#define SDIO_CFG_CQ_CAPABILITY			0x4c
+#define SDIO_CFG_CQ_CAPABILITY_FMUL		GENMASK(13, 12)
 #define SDIO_CFG_MAX_50MHZ_MODE			0x1ac
 #define SDIO_CFG_MAX_50MHZ_MODE_STRAP_OVERRIDE	BIT(31)
 #define SDIO_CFG_MAX_50MHZ_MODE_ENABLE		BIT(0)
-- 
2.34.1


