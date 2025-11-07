Return-Path: <linux-kernel+bounces-891148-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ABC3C41F80
	for <lists+linux-kernel@lfdr.de>; Sat, 08 Nov 2025 00:34:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 882A24E8C3A
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 23:34:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 798A4314B6B;
	Fri,  7 Nov 2025 23:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EqT93UYM"
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 787902F7AAA
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 23:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762558437; cv=none; b=Bc1BOXPpefgIavsoRS5zBnyBF/x2WZFHs6t79NXM7H2WQ93mwmho8edM2tjweM+/4+T29faDDl1gthx/fWA73H8aUgspYdZXYMTZnd3kvP6Dp1EHqC+ALDkThfLujXP8+p5coFBghwqlWMoehyIwsF5vEY/gfcLO5PGcPKAN4OY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762558437; c=relaxed/simple;
	bh=n1bFuKtdlnt7XRi46FUhRQ6Bn0uY8ezS7neJaezJxOU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jN5GiPGQexIwMfBANtrqmz6jjAftSt3lIyTAlWaSFnen+iiwj2gXp9s7QQ2ewybcF9ePZAXjp60AMGjesXxbeWHLUbpiH3TmRdywim9bjo0HBbf0JrN+F+PjViubqeEJcQ0hETepLcteGh68el+QEgj0XL1dhhjlS7KL6IEMPhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EqT93UYM; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-b55517e74e3so1125698a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 15:33:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762558436; x=1763163236; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XGlJAgjZPtag5TirGXaS2/5ONA2zXm/4q2zVDYxz4+M=;
        b=EqT93UYMQNvaD4JtaMvuuOH+Wjk4L5Vng4wb/ttD5s1VcMqHrAye4HJZOYLrcB2f/Q
         bphU3P1e9bEHwclHA8XgLOI+JRWEfTiwue7w5qpEdP6jJ9zS4MDZrPnzu78HWbBvwbgD
         GoxZ0cqKq310LAlUdxWtZc+rAqnX6XPdPC0ziHZ6jFD9lsjWocseP0KWzMAfIjbkM7z6
         mF8dC87Vvlz969xDrOBs3+KohbKiALuV56fdOvdhOx6lToCx+UI9vzvB+dsNxkic/2vI
         zH1j7ASsp8DyndLMAjjDShK3X/k1ibdTSdh2BDwMD3CY4w/fFUjOrkrsGjw/7h/zoYOZ
         Tlxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762558436; x=1763163236;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XGlJAgjZPtag5TirGXaS2/5ONA2zXm/4q2zVDYxz4+M=;
        b=ltvihjoSKlhgAYtvN7r8RnmxfUq9y4Nsm2iymVSn6rDwZgtUrbCNYPP/7z1lKrdL9d
         PbvpZ6CTxJ3ghKRNtSl0Ubj8nSd5Yu6zkB1c4tYmLSmMIXlxAjtzZUBVMWAshaCI6xtv
         KR0FOZkzobIPyUNCO1okP5QDwFamFVUzEt0/kELmx9nFq7BjvgLaNzSHvVae3Chbaegl
         qYhtiE4kjXnAb9blPdfC16ioCcxewTSh3bNrcAiRFElNUDeProtNYKMuOXcUdxTI0B/k
         NVbfHVc4DJF1zuOguSTQeykBGgBA3OYhOCDx3nZhchW8RJka0+58T8YskZ35lpHvY8Fz
         G9rA==
X-Gm-Message-State: AOJu0YyWmd7z7Q97S4pEeDEcPR34Zh1CCDbQsM3BYgvJvy/K7YphDKP2
	s2tfBd6E2DLiOwIBG4ev2j44jKecoYYZiC9ossyduQd1Hw1WYT61LSTN
X-Gm-Gg: ASbGncvlgInElReS5RaWM+DdLgA9fuozs1CsMKQaURoLDHf3+Kk5+0wtGC1UbDG6hxS
	yQhCbKSdw+O/Z1fObxFA3dVAfX3vK1ryh2R8nXi0VApcFcL2fHpTwliV49s8Mom1q5c8K0WR/ln
	7StRb5715jc2rm/Lh0Xz4PyL0kzN6wGcTRIK4CRlJEpMo00XyV2mDAc+sO4MJyHc7tXcqe84Z/4
	fsZmxoP2N5DKJ+aNrgjmXQBOMvQcRKbKofHpRgT8V2d8tcetSgSPY0v/WRTkQPy/5vM2gzPznti
	NRiml231mQWdTKaIv0aa0XSh53XXcsgwXrk7E57OT3lhlkW+lWCMB0AtQQrRplw8NFjX23CtAKM
	X5LJZhBrYaJ6CItWDOJAVezdByAHM4kG2vSxtDfXxM8Ru+nnpAijI/UnC2pmlG08F7zQyfKA0pc
	ID
X-Google-Smtp-Source: AGHT+IGJ+B/hqDtgl62JslOGOydMbTfxT1KUV6B60Z5pW1xtuDgezBwdauev+XWwxPmxcZIKm/8EGw==
X-Received: by 2002:a17:902:e847:b0:295:7f1d:b02d with SMTP id d9443c01a7336-297e56476f0mr9802925ad.22.1762558435589;
        Fri, 07 Nov 2025 15:33:55 -0800 (PST)
Received: from archie.me ([210.87.74.117])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29650c5c6b3sm70025515ad.24.2025.11.07.15.33.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 15:33:55 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
	id 5BA90423BF1E; Sat, 08 Nov 2025 06:33:51 +0700 (WIB)
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux IOMMU <iommu@lists.linux.dev>
Cc: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] iommupt: Actually correct pt_test_sw_bit_{acquire_release}() parameter description
Date: Sat,  8 Nov 2025 06:33:17 +0700
Message-ID: <20251107233316.7256-2-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.51.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1748; i=bagasdotme@gmail.com; h=from:subject; bh=n1bFuKtdlnt7XRi46FUhRQ6Bn0uY8ezS7neJaezJxOU=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDJl8jQEq11fXT/DUSg7faHZA8dkB3sUfjduPrWp/aqW/3 shgNadyRykLgxgXg6yYIsukRL6m07uMRC60r3WEmcPKBDKEgYtTACaidYeRodGo9tSeKccCBFnm mQmukpCf/+D0qehNPcXezEY5uluMzRgZHjj+bHsivy/R58lze+9wyc0tEdd+P47i+bnrXNeRSL5 wLgA=
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit

In review comment for v1 of genpt documentation fixes [1], Randy
suggested that pt_test_sw_bit_acquire() parameters description
should be written using "to read". Commit e4dfaf25df1210 ("iommupt:
Describe @bitnr parameter"), however, misunderstood the review by
instead using "to read" on @bitnr parameter on both
pt_test_sw_bit_acquire() and pt_test_sw_bit_release().

Actually correct the description.

[1]: https://lore.kernel.org/linux-doc/9dba0eb7-6f32-41b7-b70b-12379364585f@infradead.org/

Fixes: e4dfaf25df1210 ("iommupt: Describe @bitnr parameter")
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 drivers/iommu/generic_pt/pt_common.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/generic_pt/pt_common.h b/drivers/iommu/generic_pt/pt_common.h
index 3b4e371089140a..e1123d35c90765 100644
--- a/drivers/iommu/generic_pt/pt_common.h
+++ b/drivers/iommu/generic_pt/pt_common.h
@@ -353,7 +353,7 @@ static inline unsigned int pt_max_sw_bit(struct pt_common *common);
 
 /**
  * pt_test_sw_bit_acquire() - Read a software bit in an item
- * @pts: Entry to set
+ * @pts: Entry to read
  * @bitnr: Bit to read
  *
  * Software bits are ignored by HW and can be used for any purpose by the
@@ -365,7 +365,7 @@ static inline bool pt_test_sw_bit_acquire(struct pt_state *pts,
 /**
  * pt_set_sw_bit_release() - Set a software bit in an item
  * @pts: Entry to set
- * @bitnr: Bit to read
+ * @bitnr: Bit to set
  *
  * Software bits are ignored by HW and can be used for any purpose by the
  * software. This does a set bit and release operation.

base-commit: 91920a9d87f5192c56ba5bf3e133aeb3576b705d
-- 
An old man doll... just what I always wanted! - Clara


