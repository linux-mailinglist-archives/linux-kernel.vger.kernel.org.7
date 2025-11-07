Return-Path: <linux-kernel+bounces-890338-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D01DC3FD4F
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 13:01:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id ADE0834C059
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 12:01:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A34C326D6F;
	Fri,  7 Nov 2025 12:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CKyg/UHr"
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BF5823E34C
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 12:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762516869; cv=none; b=LGR2oRx/dAMQFZPOY7fJVirLyq/5FvOw9grwKXOHppC6mvuV6sN3/j+C0v7KKo46P+tma35X3YxWHXJCTjhOa9r54sJhvPkFqRQk9sjH/ibWFCV5vswF3UcDdmYsJB7fUETBU0igvNFD4MFv+ZYZCQtgWfglcd3eWr29snYGUc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762516869; c=relaxed/simple;
	bh=WrQbYnERfuilsYa/L8pS83dChTm6g4pxcqy1IHgxWE0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oJZt07yi/M1K7mLvNV1x28faKzZoADhFsksTpD3j1wdb1D7vdu0uWsXSRxVRJwGF03h6bVTBXCakFVtrN9UzwVOb2TaLGGsNdurj70IKCIOLAcywpexZg6nGBk2oWb87/PTHJSvQA39rO/gp/1r6+B0gdDQZcONAwR9++teKwLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CKyg/UHr; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-340c1c05feeso605937a91.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 04:01:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762516864; x=1763121664; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+CceWq1gwdCMIj9EhxpAQS0ZIz7AyEWHXDa3+02Ng1A=;
        b=CKyg/UHrLGdAUTqXimfYc032qpNMkQ14nNIwTsEoGZun5sgVZ831cwrVCIs08kkgM6
         oikvGYdQ3vxkPxCHchkW3rZsJXroHlYoGZoIthkFFmECD7gJKt2WJqG0cfKaHHzv+Ihf
         kSAwUFlx/WNK5eI69hmtHiNV2WDO1HGY4UMfGe1/8S0q16I5TyZv9ZCqeOu/uCHvQSuq
         tnSylO21kvtr+Fl7KghRzTMXtcWzpady0fCnEY4knk920l4c7486WE2kxz5/GumTYn5h
         lAZuEA3mROb4enkXu5oKgjgkNMKhPvSOJYkDXG759ZnLWG9cfkeNaFEAS6+SDIqlpLrV
         dDOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762516864; x=1763121664;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+CceWq1gwdCMIj9EhxpAQS0ZIz7AyEWHXDa3+02Ng1A=;
        b=rlf9zPCSqNVD6uG6NBqt/JmhkWL9QRtkeoesakhRPu4GW1qz0yd+jMyQwEbedohdqx
         BlAQkop4JobjIRA6TC1yxPKVhcoRT0JFrNOavoiABeH6p1xDCDB0o2QX6QbVrfqJ3QAk
         O/VXbMfYsahwOTV0Ij3YQGrNO+hJk9NpXrz8+A12Vkc4guBhZzOTSuKstJr4rPni2LX6
         Sff/kzerWpuvQZp1ag+RVeSNoxaIgageVP/z327AGCeUmJ8Z6fhK9Mb6d1UNI7rDPEc2
         4zhMVT3Rwv5TEv4f7DgbA29KJPmziyjP/dpMybEG0PwVoXAP058Z3+nBEE1oXhPSalb4
         TQWQ==
X-Forwarded-Encrypted: i=1; AJvYcCWNV7/dr/PaUaiIN9PGW3UV1x6KdaKoutUTctUEPLdifzyOBRF7XhtMnUrxdpWJ+VkJcsTKQ+VMTdrJLeQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxeHPy+u/jqqwWjVqkFkKpDNXxiUgI/JztKArniEckqNe7IpaK
	m/c5hyswjy/3a+b5AZYRadRHDhK6/IZafRR3k3m1Fk5Hqmjf0JwQZZQjw4ywHrMYzno=
X-Gm-Gg: ASbGncvLv0/06grRDARp6x1tTJ3bHX7and6f6dIx5hDMWeY/M/DX/QPCwf7QctC1PEA
	e+M0pMCVjtzmyJ3dTa0rY0Y9HBi0YSBJ3dRmfYFdDZD2TGsXCvYWQNV066juEmplOHW7Vxz9BCl
	PjhkAq8VsNijPzhcstA88CPbtwh8epfLc7AXv7IDayM9lJcDEaoYDwiaXKWFSH47qVLN7uIvjbO
	cMnlIEFC+sdsEbXd8VPhpFJSY2gybKyCrRK0MjijT5A7mPjaRrqlvabdnzr7dB9nzdQkCcGW6R6
	iiHSNDwDYZj93e6wwyN9pu0M1GUZolp0Rdlc9/xZD4EQSJr7sdSE8x7eN15kpKXvDfARxjkNLXv
	P+1CK/PZJhhlG4WitcTvyP8k1AEifad3yl8CS9ugmlW1k0hULOpVYjokf8llF4bEVcG7hY2HNcr
	3nDVvwUR6Baa4I02nb0hNhFdIWpfZSXibfz/Ln0MozbNY3zCPBl78e7fvvOPhTQvA=
X-Google-Smtp-Source: AGHT+IE2Jvir4YmFcnnOxNAW+erOoTmE+Om3BFAAMC9RL83vI2P1CfSiqnBRw4rpoPb7xePR5kkslg==
X-Received: by 2002:a17:90b:3843:b0:340:b908:9665 with SMTP id 98e67ed59e1d1-3434c584051mr3815197a91.37.1762516862908;
        Fri, 07 Nov 2025 04:01:02 -0800 (PST)
Received: from SIQOL-WIN-0002-DARSHAN.localdomain ([27.57.191.202])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b0c9c08ee9sm2833728b3a.21.2025.11.07.04.01.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 04:01:02 -0800 (PST)
From: Darshan Rathod <darshanrathod475@gmail.com>
To: airlied@redhat.com
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Darshan Rathod <darshanrathod475@gmail.com>
Subject: [PATCH] agp/nvidia: Fix coding style issues
Date: Fri,  7 Nov 2025 12:02:06 +0000
Message-ID: <20251107120206.923-1-darshanrathod475@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove assignment from inside if condition and adjust brace placement in
static initializers to comply with kernel coding style guidelines.

No functional changes.

Signed-off-by: Darshan Rathod <darshanrathod475@gmail.com>
---
 drivers/char/agp/nvidia-agp.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/char/agp/nvidia-agp.c b/drivers/char/agp/nvidia-agp.c
index 4787391bb6b4..aab33d1297d9 100644
--- a/drivers/char/agp/nvidia-agp.c
+++ b/drivers/char/agp/nvidia-agp.c
@@ -125,7 +125,8 @@ static int nvidia_configure(void)
 	pci_write_config_dword(nvidia_private.dev_2, NVIDIA_2_APLIMIT, aplimit);
 	pci_write_config_dword(nvidia_private.dev_3, NVIDIA_3_APBASE, apbase);
 	pci_write_config_dword(nvidia_private.dev_3, NVIDIA_3_APLIMIT, aplimit);
-	if (0 != (rc = nvidia_init_iorr(apbase, current_size->size * 1024 * 1024)))
+	rc = nvidia_init_iorr(apbase, current_size->size * 1024 * 1024);
+	if (rc)
 		return rc;
 
 	/* directory size is 64k */
@@ -291,8 +292,7 @@ static void nvidia_tlbflush(struct agp_memory *mem)
 }
 
 
-static const struct aper_size_info_8 nvidia_generic_sizes[5] =
-{
+static const struct aper_size_info_8 nvidia_generic_sizes[5] = {
 	{512, 131072, 7, 0},
 	{256, 65536, 6, 8},
 	{128, 32768, 5, 12},
@@ -302,8 +302,7 @@ static const struct aper_size_info_8 nvidia_generic_sizes[5] =
 };
 
 
-static const struct gatt_mask nvidia_generic_masks[] =
-{
+static const struct gatt_mask nvidia_generic_masks[] = {
 	{ .mask = 1, .type = 0}
 };
 
-- 
2.43.0


