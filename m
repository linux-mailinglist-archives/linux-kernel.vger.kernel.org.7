Return-Path: <linux-kernel+bounces-885027-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AF24CC31BA3
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 16:07:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7423A34AF10
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 15:07:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF010248F73;
	Tue,  4 Nov 2025 15:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bd4z93LI"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87A5B2472B5
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 15:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762268824; cv=none; b=USgtM0xyalEcnv01S4thkg0+QTSBwVCHq4KtF+bob7oFXb83Gs7o6R4OvvWRdUl1JWal9KrGd9lRQkETr54icgjSiNlhb1aNUGrJSOUcDQQ/dG3b6YxIttqcLjLAo4JAfrRJWa3Z75F7RnaYPLWIEEqyjwmwUyvdZ5B2DYVITRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762268824; c=relaxed/simple;
	bh=+xLPW149u0EPQxrFFbkLg6mu/X+Jh93ibtFPT6VV7Pc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=raQXoeHsMNbz9XbscdkK2YAbfoBHHTNB/Dd5fvUqrMV1mP0ruaP7uV6GuLZWjDNZ+tnnh4dK0oVXnzpX3GJ1o9CjNLFZoPpCv0ntz52r4v3AChjl2Z0DFBOBMoTvYbuhivHkN456fPwVTOFGzDcJ4+rYeYi+oATD4T0jmyesUjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bd4z93LI; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-640bd9039fbso3889945a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 07:07:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762268821; x=1762873621; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=knoBTxhys0G5L6IMAZNao0/3R6GsTIMb0vdRqZYYHho=;
        b=Bd4z93LIc7B5pXkWjUaOYg87Mr11wI4U/XBkYRAEshrQ+UiIgN9fYVYXp0hqGfwHxc
         qO+1+sQXTtMX6ebWWRcyIylXWRNFfjj0wXn5z5eM3veMfC5vFjYRMrm0x0BkfK0C+yvj
         aTXjkA3PgtRgdEITYvKRm44UT+PpzY65pEfoe6Z61fNn6HxxK33dv+uiGA85tlU2w6so
         cNfuv4URiaHiXD8Qg01iKmXB8gY6MdyBxWKPxfm8MPICeH+rhoYruHvss8jJnRaehZfo
         B74CZQb8yoOYBEgAPoxcGr31PiBnpWGwiywS0mQQXAkbu3GqWqpENetEnlSYCHUKlb17
         sugA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762268821; x=1762873621;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=knoBTxhys0G5L6IMAZNao0/3R6GsTIMb0vdRqZYYHho=;
        b=DDEt1iTOV5pZfAjRBdGH/DFB6XRRUUBDKHipYr0vBoaLSOGd8ohw1b+2CtzsMRd42E
         QbabcFBRdaLscK+Clg4mT7a+n060fSLKgXBaAtslvezv5KNNjbqNBCZcU4BSpr81a+f2
         1QUvQQDXArZdKdo2bPLsS6s9Inm1Ogd81+EdAeVq1FVNlv8nOiFDJ6MGsMt4byuBXFpn
         Ry7HH6RvBPpFpu0ZN8SSYqS6IQd8bClGci2o1KYE8E2hbR2CAFLJ/CPdgPl2RME+8Vsb
         m9RR7vMFsGPQC9OZGj4Dyjjai/UibFIuo/qQvtQiDdNJ/csTypNthna/ppPC41wwogsa
         xyeA==
X-Forwarded-Encrypted: i=1; AJvYcCWLlKc2k9VpOXlf6fOD4h2zuwFNJ/ByIXlKyiv9sKp92L4B0Lb08oV2K+YtEpCjN1Q9E9X1zxQHwLvVsu4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNE9BcrtFU1dkXVGLbYar/e4GdnNIlAPqKa8gxhDbzghQXGroI
	bl9dor/DGs3r947gHpZggf9Vi9GOU9vtS9X9PqXaya0aBc+BmO7BRnDP
X-Gm-Gg: ASbGncvogL4XLxZFojCLs4q+KP0YQfQ6CpK0sB4hB0sl8q78KkgyO+QDpIPtYrNHh/c
	xvbVzX5wmRM+VLYFFFplvjdiKxSUCZBJ84LDfpUXpx395Sc0XPpjstgAUoQTHPZaBylf9KqY+YW
	xvrjJ6yEygJRhP4fVLiZlGvHvtIHTRPOqQx2s10oirjppUrniAD4k+9gu9SrtAc/xcRn++e3dHz
	mOjtHCxrOXgiQsFcyb20pKWIkG/R/BmZfpr5pwnx8AHA4xbsj1oubMxivFAzVcGQJQi1Bqx4Sjy
	rudkkEYlzlyeEb0f6i6OKdFygZFoHapDObOdHi+0t2rFD2R3FN4DkJLZTaoG007x1wnt1NBzuMv
	/i3zo5Acq2CqTqNytqHGGBgWvwhUk26VtpQfmQNx5nOPcMnwfNsKSlex9UI8mK+4OfSL3yCJppl
	GteKuiB10N9GOA7CFFYl0wfU4h4Q==
X-Google-Smtp-Source: AGHT+IH3QQar3AAy6xFUftSUi+POCA8TYsQTXR01XqUsEDkX3Cp2Kija0BWAy5x9Z/zOTkdgKsJWSA==
X-Received: by 2002:a05:6402:350a:b0:640:976f:13b0 with SMTP id 4fb4d7f45d1cf-640976f1865mr10596262a12.12.1762268820845;
        Tue, 04 Nov 2025 07:07:00 -0800 (PST)
Received: from SMW024614.wbi.nxp.com ([128.77.115.157])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-640e6805da3sm2342014a12.15.2025.11.04.07.06.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 07:06:59 -0800 (PST)
From: Laurentiu Mihalcea <laurentiumihalcea111@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Daniel Baluta <daniel.baluta@nxp.com>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/3] arm64: defconfig: enable i.MX AIPSTZ driver
Date: Tue,  4 Nov 2025 07:06:10 -0800
Message-ID: <20251104150612.1874-2-laurentiumihalcea111@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251104150612.1874-1-laurentiumihalcea111@gmail.com>
References: <20251104150612.1874-1-laurentiumihalcea111@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>

Enable the i.MX AIPSTZ driver, which is used for i.MX8MP-based boards such
as NXP's IMX8MP-EVK.

Signed-off-by: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 03d89f29e7c1..ae5d32ea9fc3 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -271,6 +271,7 @@ CONFIG_GOOGLE_FIRMWARE=y
 CONFIG_GOOGLE_CBMEM=m
 CONFIG_GOOGLE_COREBOOT_TABLE=m
 CONFIG_EFI_CAPSULE_LOADER=y
+CONFIG_IMX_AIPSTZ=y
 CONFIG_IMX_SCU=y
 CONFIG_QCOM_TZMEM_MODE_SHMBRIDGE=y
 CONFIG_QCOM_QSEECOM=y
-- 
2.43.0


