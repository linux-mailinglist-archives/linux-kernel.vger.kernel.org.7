Return-Path: <linux-kernel+bounces-882065-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D86E9C2988F
	for <lists+linux-kernel@lfdr.de>; Sun, 02 Nov 2025 23:35:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57CD53AEA10
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Nov 2025 22:35:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C62C319F12D;
	Sun,  2 Nov 2025 22:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N141O+gD"
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D028B12B93
	for <linux-kernel@vger.kernel.org>; Sun,  2 Nov 2025 22:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762122948; cv=none; b=maXqGJmlP1B9YqYYspKdL9iIVC7XJFtzDQfxN24ot+mD+n0Hfz5C3cJhWBsHm4ziQvewBCuBfLwwMTvxCcScAvcBi3/VZ0vW/3wtKWVPCDs6/8L7WaByZm4upBJSL/R2KYEQW59Lg3okQGMyzAqG3MxeMyAwehp9V9vv1uHroj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762122948; c=relaxed/simple;
	bh=zHLJyI1B0tQ7hDcTDpYEVBdJEhuTUsIfsTItFBBZTB8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mfru2QIdsNEiQpTXUHq97cicwNEClecGjSGtP8QMJTJUomr2flFGnD5HUz2DDZwcdT8W/fbMioMn0ZbS0U822Px0Uu3VupkBdIWspMVXiWhNaneThYQYko068bh7MZQt1u1AxtvTNypqNo3pHnHXRMFr3rfYzJZWCDXzo69by4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N141O+gD; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-b67684e2904so2629556a12.2
        for <linux-kernel@vger.kernel.org>; Sun, 02 Nov 2025 14:35:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762122946; x=1762727746; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=P9Pa3OHQ3FbNoagKUAESzu74YyfMwxV8hg5SUVSdQaE=;
        b=N141O+gDz/iJfKnhN2O09iCUFKJ9m68PRn/QfssDLWs5UqBV9rPqpFPKNRd6nQsK9B
         0z+ib3z365iSS5ROXY8le/bAb6npWnMKE0wV+3c/VlnByLMh4ZC3VKBORt8Pd1hlgAME
         RZRk6yVO8/qFIuIHFjRcIn8FuCd1/wOI0SZLzAqQt6cdLvIPSHgigAYWCiIMZO4pTUYK
         lGjajOA2QkxWop3kwQbTbiDuo7522RVJj1UItjrS1oyxhePtKuQWzZGOpHXdnSLHb40c
         xPKH14lpNw6S+auzV4g8vbc5qc6KcArbIOwxmjfgNeqs+USTXBtJBUG0F0wSGu59NJBO
         8QLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762122946; x=1762727746;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P9Pa3OHQ3FbNoagKUAESzu74YyfMwxV8hg5SUVSdQaE=;
        b=OJKteezf0yBsFhgqh/qPDfPODCdi5CuoKUxA/EsxQ0PXkHRduV7zPPcx9wWkJpbSCa
         AGEDar2xoukU9lvXMWMLnI/gdzQVGQvKRtyAOkigPG7VZbXj6Yj8bO2OzYMUWC2iDYKm
         D1Rs6e5E20eTZlIcZ2xketdIjw4n0MMF9RSZOFeRj1Eswt2cvASrUEUT0LwErgozpPut
         Pn++eh57O1dLDZeMu4rKeNb4yR41klVUwlv5Lp2xgPaJp8ekdl3Hk2hZsUaM2q4INDGk
         S1TU2wcdqeUyFAUgRsTtZy6oYeN8gpYwNpXtW5sxDx1MTpLXeJYBXjvGmgaM1Pn2suIE
         EuzA==
X-Forwarded-Encrypted: i=1; AJvYcCWk2viheybqKCRAeHNmPKOP9HowEWwI2npt2wY74nvqUW7U60SwSMDaP+nOpAeDjn9c6lCSz5S0NuzDPz8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx58XtShsFLDszgibN1AGrnQ8DzQGqBdklLqz+OMCUAh//xnmIQ
	jNefy2M2PF49H4MsoxGv7TjouDQOV0OwSL03dLBgKyVA/bEN9XehwhJW
X-Gm-Gg: ASbGncvgXTzgrfaZerPpgcR21OOc4HwBFc5mRGm5AOl08C7W/bh56NDD1U0s/bwSk2X
	fwBDkreTkcg8rCG9DW5+K8uVEUNi6SbskxpIh+VaiLfJo3YhM4QQG2BKt26xaDjsVOvB7A1zjy4
	HRKegyjfR9cIh1DiHWwjLL4QpcwrWYlQVQxL/kcefRL1UaKLnH1jB9rUaSpljm02ha5jV6fIoWn
	h8n0mSQ6jpaOZ2t0wBJgCnlX8/yvHzQmLgmeVlBQ04mDLOsQNwUUcuvYev+ynjG1QX9OvXaPxJJ
	CHAdIVhS6S03IB0LgSxTGJQzsJTU63yI+G11pEWwzienWgjWqqTDz+jCp2SSelA6YmdsIQn/hDp
	w3bA3S6D2woRBJ3jVctqIBor3SBnR3a1w2Ksy/aQtpQhSRf9/4oSEvOxBEx61tmR3ocUP8M1wVn
	Mvbcerv2D9b2RyldHV5tVG84tQupabIWEUxA==
X-Google-Smtp-Source: AGHT+IFslqE5PZW8WOH32oKkpjAT+nE3kdUaE93ZVDSdYVX9RgOGkUJh9awov+E/yE9W4J1l4QVD3A==
X-Received: by 2002:a17:902:db0b:b0:295:59ef:809e with SMTP id d9443c01a7336-29559ef820emr63430415ad.24.1762122946016;
        Sun, 02 Nov 2025 14:35:46 -0800 (PST)
Received: from localhost.localdomain ([2804:14d:4c64:860f:2214:33ff:7c70:4d9b])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-295cd210613sm2460885ad.107.2025.11.02.14.35.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Nov 2025 14:35:45 -0800 (PST)
From: Rodrigo Gobbi <rodrigo.gobbi.7@gmail.com>
To: lanzano.alex@gmail.com,
	jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org
Cc: ~lkcamp/patches@lists.sr.ht,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] iio: imu: bmi270: fix dev_err_probe error msg
Date: Sun,  2 Nov 2025 19:30:18 -0300
Message-ID: <20251102223539.11837-1-rodrigo.gobbi.7@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The bmi270 can be connected to I2C or a SPI interface. If it is a SPI,
during probe, if devm_regmap_init() fails, it should print the "spi"
term rather "i2c".

Fixes: 92cc50a00574 ("iio: imu: bmi270: Add spi driver for bmi270 imu")
Signed-off-by: Rodrigo Gobbi <rodrigo.gobbi.7@gmail.com>
---
Changelog:
v2: add trailing and fixes tag
v1: https://lore.kernel.org/all/20251010191055.28708-1-rodrigo.gobbi.7@gmail.com/
---
 drivers/iio/imu/bmi270/bmi270_spi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/imu/bmi270/bmi270_spi.c b/drivers/iio/imu/bmi270/bmi270_spi.c
index 19dd7734f9d0..80c9fa1d685a 100644
--- a/drivers/iio/imu/bmi270/bmi270_spi.c
+++ b/drivers/iio/imu/bmi270/bmi270_spi.c
@@ -60,7 +60,7 @@ static int bmi270_spi_probe(struct spi_device *spi)
 				  &bmi270_spi_regmap_config);
 	if (IS_ERR(regmap))
 		return dev_err_probe(dev, PTR_ERR(regmap),
-				     "Failed to init i2c regmap");
+				     "Failed to init spi regmap\n");
 
 	return bmi270_core_probe(dev, regmap, chip_info);
 }
-- 
2.48.1


