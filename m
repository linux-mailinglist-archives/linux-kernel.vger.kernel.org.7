Return-Path: <linux-kernel+bounces-850580-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D1E64BD3354
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 15:30:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 558E33C6BC6
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 13:28:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1D853064A1;
	Mon, 13 Oct 2025 13:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J44iDNpz"
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C58B61FDA
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 13:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760362124; cv=none; b=ninny7ibeoQq8vd71rxQX7eB48P4LZ72Th9N07Ea3QZ7BAGQgNBFlDkU94sifYbnrxu3aw7msjCcX4ElCfxjWHGGSdep5SLyymoOscTFSaMnygD6gnl7X5GFq6KQvy5N8xPTvn95HV0K6RaUPLZ+s9WD4Jt1IgFgstE4tS5MXwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760362124; c=relaxed/simple;
	bh=hyIt+iHMpoQi13DyesQ6EL1Sxder5nAc0pRzujq/6Do=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=scZ90xOnLzOy4PRQn1YQTWSoqPVkYrPu8QY4TQnihdXJR2ErfYrjGVPwOVXxXiORPTs8xtySU3gBp98figvDY45nIjPSFs9pMfpf/A0D3dmMzDdCCWNOWxxLzdblLygfgFdoySR4rXfL03cyZnDDjhaOuOHiTWqyRIlx6sDbdnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J44iDNpz; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-3369dcfef12so4887640a91.2
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 06:28:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760362122; x=1760966922; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KB8cW4O6YyTsn6w5tpu0l/sw/Fa0/TCK5XPWajFzOx4=;
        b=J44iDNpzZsBtANKYMpmk8B8JRCJiq0HRkFFqz+1GZUMdl0L1lHXAScwuybuLkaf/J6
         DLTZWlZ62IqIT1fJip4prgt9gsiY2v4XikR1b5GFKSJR61QI0rBpa0iatYhfEjN/UhUX
         V5ObM+DwvfgBjDc4a64back54fg6Qz3WKjrZ4ISHbnIzOXfToVDEIrks+oEcowvs5Ede
         ntww1GWvnvFSyMmXp6YvVg23+BE2RDdYixDY3oMji+om0GiA/nAHCOVJSZEOXfJXU0Ta
         X9f2Y30RKGZ3MBULLVWS8ooAvnXLKQOwr4qYhJDEHKOc+a2RVPhh8Cf63afbFRqai8S0
         4Yrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760362122; x=1760966922;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KB8cW4O6YyTsn6w5tpu0l/sw/Fa0/TCK5XPWajFzOx4=;
        b=luMrKBhVNJ+t75fUgLDc9N7D1dkqIr84H49sxh8duecUkvDv6TBGNkWvYUqBBCZY1K
         L/MJtP9tKUYa+Yeac0nIb/qESFeydpoipmrcsvLNAxgiKHgs152vNqkwXs7d/dUJRrzR
         h+rzGdctEiB6ZleXTozQsj2vHF6wNZqrvrYACsrbbBULbiMgja3YCZx9rfYNTWJnBPxS
         uRNp1qfdrFFngS8npk9qg7qtZZrgd8QyfHA2Xa96vxQX5Dakxv61lwiEczLPvWATxMbN
         c9wfRPFT4PMtxv3D44r/3/X+7K6b2SdZqab5iwZWUTywbAifkfUu1KwraGzaMwfZurWu
         HVOw==
X-Gm-Message-State: AOJu0YxJOIy7wWW4NWWpHQLVfQuQNFKs1EiTGmLJXoeKdorLLewaUfm2
	r2c+0AzSll8LeYimpyDopujCxWcQYSPhRfrqREd2YWUi8M4x4urUGJjt
X-Gm-Gg: ASbGncuu9vjelheBPgMItDiP2crOhOX1mqFh8WBo6Evl4nFCqUAiXg/2MKPe8yLkLO/
	uBMOangBv1Np5pxAw4JJ+9Gv9v2wasnK8Peh5j9uA59CcNRzK6ABHRDJK2OpXsQ28+2DaV8yEVX
	ADYiWLdegjOGDJHacs4EzlulDcg+X9Rawi6+oUVBDHVLX6t1mJVB9eTjtUt8lBQL/fo2avPptfG
	rF3yS2DmWLkccip7BPJd6W8gVwUsxJYKUrI/z23hYS3/7ZAO4gFR9NOaTn3DERQbWccpLLbdvoK
	LG1JrV/1XjnPdjL4kWsa0iCa9CXd/xRQsZ696LVrbaTN7k7OE757r/0X72goZg7nsbuKf7wZxQ3
	qHwYGe1pepibtpq1QqlEjCQETc54Kx31o2Oi4geI5C+q8D2FJm0U7FQ==
X-Google-Smtp-Source: AGHT+IEcalrsF6aHpKTvaMZvKrHtvwAvRJZAVd8Hu2hbifRs4/HbAGNuW7JxXyjLu4HGeFRF9Y8sGQ==
X-Received: by 2002:a17:90b:1b41:b0:330:82b1:ef76 with SMTP id 98e67ed59e1d1-33b513d08e3mr26416903a91.28.1760362122025;
        Mon, 13 Oct 2025 06:28:42 -0700 (PDT)
Received: from archlinux ([36.255.84.63])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33b626e8bf5sm12037656a91.23.2025.10.13.06.28.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Oct 2025 06:28:41 -0700 (PDT)
From: Madhur Kumar <madhurkumar004@gmail.com>
To: arnd@arndb.de,
	gregkh@linuxfoundation.org,
	mirq-linux@rere.qmqm.pl
Cc: linux-kernel@vger.kernel.org,
	Madhur Kumar <madhurkumar004@gmail.com>
Subject: [PATCH v2] misc: cb710: Replace deprecated PCI functions
Date: Mon, 13 Oct 2025 18:58:33 +0530
Message-ID: <20251013132833.1783880-1-madhurkumar004@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250919083214.1052842-1-madhurkumar004@gmail.com>
References: <20250919083214.1052842-1-madhurkumar004@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pcim_iomap_table() and pcim_iomap_regions() have been deprecated.
Replace them with pcim_iomap_region().

Signed-off-by: Madhur Kumar <madhurkumar004@gmail.com>
---
v2: fix checkpatch warning for missing space after 'if' in core.c

 drivers/misc/cb710/core.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/misc/cb710/core.c b/drivers/misc/cb710/core.c
index 55b7ee0e8f93..a1e6ba62c298 100644
--- a/drivers/misc/cb710/core.c
+++ b/drivers/misc/cb710/core.c
@@ -223,13 +223,11 @@ static int cb710_probe(struct pci_dev *pdev,
 	if (err)
 		return err;
 
-	err = pcim_iomap_regions(pdev, 0x0001, KBUILD_MODNAME);
-	if (err)
-		return err;
-
 	spin_lock_init(&chip->irq_lock);
 	chip->pdev = pdev;
-	chip->iobase = pcim_iomap_table(pdev)[0];
+	chip->iobase = pcim_iomap_region(pdev, 0, KBUILD_MODNAME);
+	if (!chip->iobase)
+		return -ENOMEM;
 
 	pci_set_drvdata(pdev, chip);
 
-- 
2.51.0


