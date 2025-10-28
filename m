Return-Path: <linux-kernel+bounces-873403-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFCA6C13DB8
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 10:38:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B99F842519D
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 09:34:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FD7129ACD1;
	Tue, 28 Oct 2025 09:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ky9zI9Rf"
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A1A627056B
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 09:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761644031; cv=none; b=mwEIlJ0ISDi/D4C2FWkLinJBGWsm+x8xFBwjU0CCtGcMZZpyBwdHbrpSf9ipMBK7aAiXL72pQGvxPSoT2298edzZx92EeO+Q22X1lvHHqkmtTIC32VfXkVSI/KxQRB4nVb8aphWgInM8vC43tyyYTDwBlUhpJ7Ln61/cUKuUIT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761644031; c=relaxed/simple;
	bh=1tBI1fKtiAUVvLhBl+QlinXByKOL31usMx/Gb+Ms4ZA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=saAffoWIPUUDwvv+TXsEX9xHpT8G1uRYMppSnAENGjbZlOV3NyB2TVHNACuTi6GpjUhcy1NudfD7q1cUx+SsiyeFi92zOnCcd9NJdGiBILRV3j/kI3XhhIC2Gtq782clVESBYI8Tjh5E1+44nM+9jiFzpVU/HFojtnybOlMPFqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ky9zI9Rf; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-b6ce806af3eso5263529a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 02:33:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761644030; x=1762248830; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0XbbD0XUPOCx5w6Va6PKcmpMHJKzovEwVaWUKYe40hU=;
        b=Ky9zI9RfQmP4NMnYPnvFtloEQ/nlVl3jFxFIBahG8iBYOJrkJA5loiRr9MhrmfO73E
         D+IsFJKOqk08mb20DgytzosXwNDIkxEHfvFTj6J2O7mi3Z0NpG1rcAbD+/FrxAEcB6Qm
         YEtsnweVd1oU8fHY736O0llKM7mr4VXPPh+36rE9W2igfpRVPMpie0YpM9qWu69DC6wA
         ZoN/AoXg3qb67IuN+guSCO98cJXpUfa6rLuNPPzE56avxdl8ukEYuXW+yrH6yqoVuTnj
         U2VFu6Vvn41H/x4uu7iDNQbGu8MLx6yFzWiAGhvMx2azNPN+o1roca4LiFTNaVrNyvxG
         ubSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761644030; x=1762248830;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0XbbD0XUPOCx5w6Va6PKcmpMHJKzovEwVaWUKYe40hU=;
        b=GoRy6+So1Aj43aC0uF1t3Pv8JIKD5AOCq2mlPtmPb9sM78ItfN3EcKF0BZc4KmCSlw
         SVeuP/NaKMVtCiX8ygVJ7quJOMjiV46OMkaIE+MpvW5I7Y4VMkFwBWm1lyiDDgLFdIHb
         8kdbvslNoaFNN4fsC+b16le/RRsKDqdlLp0/L14atBi+DRiONPjavrgts6w3/PEzfIc1
         6WwCIfQRwjj5ZoHweB9mQ9V01vhHvWeyWzlEoGCSk5MlfFeAn6Qs4zzC/O0nkqKTix5g
         ufRCVCUApNRbzEFjEJ+Y4+o9+VG1/VSoT1fPpqWfAekscUf3je7VhrbHNGlMKkTwzc6i
         Usqg==
X-Forwarded-Encrypted: i=1; AJvYcCWa1VrIdTXCuQ9VskNPxfmXTeSYdMHsIyVb2eQB9xuUGU4pQ7SIptEwRDoNIB0Uv0mYscOAmKev6DyDnlY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6l5Cm3sO439Es1J0B6zf7kBOei+eNPQLsneSoVWAcDH/KcQN+
	2TGlkeIfF5qWh64rd8t1R1mvSBZR8KMBIgZ+DWn7INfgbVGvYDhhuAwz
X-Gm-Gg: ASbGncueOz+7Ksk7dnCwZwNgmWKuxlNB+sQpa+WUG9V3vqqSSsh3DYvyzIW2yThMSd0
	EIfDqcLqW8ZxmKrdjZJHuebMF6q1NctzUPxw76X68yQ0CwMIce/NzL3NR5fptSfpaWE2mgsiyEE
	0i25tcHxa+TYGHUW2sGvBcH8YtlBzVaJlKVGBCdTO06cIXgEg5bvPf3MKmXPCougeV+xn6Z7HoT
	2k8l+WpqyaFQJ4pub6TON2qAD9RAVn7GQ5P4dbTAHz/zA33uYkOlIRga9RBS/FXgG3K7IlS9+vw
	DKW0VAp/IbQoQModizB5ibDyKCsGuxiRxcJvNQGgtvcneKi2wWvCDAdRLpP9e1SYjMVj2asvcrE
	Ut971Kjwbq2NeAlOdcKWMfOmCKD8ns/abuoKpw3EMjrJorXfLVdQdWtBGJagEIyRo/a5vwSfM29
	b2sn4Z0A/l2wr0w/+U
X-Google-Smtp-Source: AGHT+IGNqDKOcuei+TEE14MiEdWZNPbqqDIwZ5o9/TpCj1YrL3udLywKrVrz2O94Cfm+4TL2T6UXig==
X-Received: by 2002:a17:902:e545:b0:290:b14c:4f37 with SMTP id d9443c01a7336-294cb524eafmr36342495ad.30.1761644029561;
        Tue, 28 Oct 2025 02:33:49 -0700 (PDT)
Received: from crl-3.node2.local ([125.63.65.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498e4349fsm109367625ad.107.2025.10.28.02.33.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Oct 2025 02:33:49 -0700 (PDT)
From: Kriish Sharma <kriish.sharma2006@gmail.com>
To: nuno.sa@analog.com,
	olivier.moysan@foss.st.com,
	jic23@kernel.org,
	dlechner@baylibre.com,
	andy@kernel.org
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kriish Sharma <kriish.sharma2006@gmail.com>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH v3] iio: backend: fix kernel-doc to avoid warnings and ensure consistency
Date: Tue, 28 Oct 2025 09:33:26 +0000
Message-Id: <20251028093326.1087660-1-kriish.sharma2006@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Fix multiple kernel-doc warnings and make the documentation style
consistent in drivers/iio/industrialio-backend.c.

Changes include:
 - Add missing @chan parameter description in
   iio_backend_oversampling_ratio_set().
 - Add missing RETURNS section in iio_backend_get_priv().
 - Replace Return: with “RETURNS:” across the file for consistency.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202506292344.HLJbrrgR-lkp@intel.com
Suggested-by: Andy Shevchenko <andy@kernel.org>
Suggested-by: David Lechner <dlechner@baylibre.com>
Signed-off-by: Kriish Sharma <kriish.sharma2006@gmail.com>
---
v3:
 - Changed Return: to RETURNS: for consistency across the file as
   suggested by David

v2: https://lore.kernel.org/all/20251027092159.918445-1-kriish.sharma2006@gmail.com

v1: https://lore.kernel.org/all/20251025102008.253566-1-kriish.sharma2006@gmail.com

 drivers/iio/industrialio-backend.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/industrialio-backend.c b/drivers/iio/industrialio-backend.c
index 23760652a046..447b694d6d5f 100644
--- a/drivers/iio/industrialio-backend.c
+++ b/drivers/iio/industrialio-backend.c
@@ -702,7 +702,7 @@ EXPORT_SYMBOL_NS_GPL(iio_backend_interface_type_get, "IIO_BACKEND");
  * interface/data bus. Hence, the backend device needs to be aware of it so
  * data can be correctly transferred.
  *
- * Return:
+ * RETURNS:
  * 0 on success, negative error number on failure.
  */
 int iio_backend_data_size_set(struct iio_backend *back, unsigned int size)
@@ -717,9 +717,10 @@ EXPORT_SYMBOL_NS_GPL(iio_backend_data_size_set, "IIO_BACKEND");
 /**
  * iio_backend_oversampling_ratio_set - set the oversampling ratio
  * @back: Backend device
+ * @chan: Channel number
  * @ratio: The oversampling ratio - value 1 corresponds to no oversampling.
  *
- * Return:
+ * RETURNS:
  * 0 on success, negative error number on failure.
  */
 int iio_backend_oversampling_ratio_set(struct iio_backend *back,
@@ -1064,6 +1065,9 @@ EXPORT_SYMBOL_NS_GPL(__devm_iio_backend_get_from_fwnode_lookup, "IIO_BACKEND");
 /**
  * iio_backend_get_priv - Get driver private data
  * @back: Backend device
+ *
+ * RETURNS:
+ * Pointer to the driver private data associated with the backend.
  */
 void *iio_backend_get_priv(const struct iio_backend *back)
 {
-- 
2.34.1


