Return-Path: <linux-kernel+bounces-881577-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E59AC287C5
	for <lists+linux-kernel@lfdr.de>; Sat, 01 Nov 2025 21:29:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 02B394E2707
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Nov 2025 20:29:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05BED2FB09E;
	Sat,  1 Nov 2025 20:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HzGnnPd7"
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD2B225EFBE
	for <linux-kernel@vger.kernel.org>; Sat,  1 Nov 2025 20:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762028962; cv=none; b=EtVFIid+4/cKTmD/447os1aA8cIsS4SF/SA8mqsQkX+MIQ+/M3mq7fH0IIBwmgdKjjSifDtgAcerX5zYkjYhcPqWQ0kQxj9xmuLf407ZDrDSYbMs43SWrwHWJzKRFOpmU3tUmnd4HCxDtPS3QE2xxwePass6QFl9JhmL65U8YBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762028962; c=relaxed/simple;
	bh=f4ly8cg8WNIJApwHlFk7r+UQI1Q1uI2E782wrY3RmGE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=bntdZdcDG/Zv0Y4h7+CuHtdMWaFJwsOJecrXGPLKlYn93ISLURt8oO4K2vs6GEGlGiV0DFSgs8HD3+GtwH0PLO5BdeRLau3YkaRWQRCU4e8xRHOtNMMMkJEcSwQdV5EzCgf1Sk6cwh8dgqqgFDuTVNETHASd9kaVimPWAKPEnoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HzGnnPd7; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-89ed2ee35bbso496949585a.3
        for <linux-kernel@vger.kernel.org>; Sat, 01 Nov 2025 13:29:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762028958; x=1762633758; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uXG3lN4x/ShRe5qXk1rZTrbqpeJ5XP/xqHhXD9nerjs=;
        b=HzGnnPd7t8X5Z1pGFFEyfC++nX3+2mxCITVfcbB9wY9kHiyN2GWve/KfQ6/aNL7hCW
         65u5VvWFt/EZ76u+c6qauGvayjJtvztHIGycFHY/vMYM5rmbUlUPeWTyWlKd5wGJxqhr
         5AYNeZj1i7bStRq3a8C9Yc4OhOQ+ehixAwujmgw5/31VGRmRBY0UEghFK69G2mDQImG7
         IWIPbEcEAeIXdCEICJeFY70uUkNFaaEPA0lp3GN3VbNdnYGLLQPaY6RlZPm+zvo+sWr9
         NlTVBtanYaWMYogPQtUx6ak7bH0tR9qLV0e2CSFVTEbKyCzKBKNqK9IbpX8vtVa/dTXu
         Vkzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762028958; x=1762633758;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uXG3lN4x/ShRe5qXk1rZTrbqpeJ5XP/xqHhXD9nerjs=;
        b=uBxQz3MKoI+ytnq/DXAN54HUd8t1FXTstvN7/buLIf6z8Ic4upvQsyqrLHKlIo1oy1
         5ztg3ln3xyvamN4iWpjfpPFCuzCf1wFMWe16TJOGEfmKAyna1P95MpuA0GC3OX9T3+JB
         zLSAEzTRg1pwDkOppB6Ddg8Tc8DeeCajq1Hw7SzPwtodswOdPJ13MGxzs++2VurerDZ7
         4ZKdIrvHHtjZXWT5MHy4MXt4Yo0H717Kng0G7f4AdMBY9wxWxAkxqEWBtjLShXCrxxHC
         /IR5vtY9o6oDhvL69/9M4KXN99zzn53+Lo/noPYjiwMnqBPdxSyJcau8c1YKIO1pCT/I
         d+jA==
X-Forwarded-Encrypted: i=1; AJvYcCUL8BwioEzvV/OVOKc69NJeDtcsDFdIbPFZG2HlSln4VOWDZz282Pz8EwrxZjWlZXEwGUF5RLZvSCJUK+E=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBmRw9JssMCY3XlonG6siXKvpwp0JCdzdJpYdYsEZqDoFsBHoW
	uhNxyK1m7Q+3OzKrXipVsoxmK4vTzbgJOBb7DVcVsXdchnZ3gKaAa49J
X-Gm-Gg: ASbGncsUIO5WDLW4SIfGhz7nSaVK1zRJfjCuTpZc+zbiSrpkPbWK7VHG/HGx8pD567b
	Jjf/eBVWX+RBRznwRhSSisRzblmVnPxcBMt8EZBbo6/OhP9AizZCt+GL6XVyAtXrAdfX1XJfGDf
	ss/1V2j7DnguLQg9ob12MabRuaYVh2WiQ9AH1hx17Rp8/oPMewCEXMnXkZkqhyEzb9zLL8VI+/+
	Uub1OjI9IgY+utWPc/H4B0tcHZBWTmcOQrJCs19gxVCBan0C9J3QOiWTGqrFe6KNeSPv5SrY88M
	3xg1bcQgRgKEbHtxm1WY/KtkkoHQvKPEhkqVAdHAfyEySNKRD8u3Dh9ytf5RWS+FhvunjHprpBK
	PG+PZQHOjrh5j0ECyE2ub02mKbR+y94s9J2rkFXVN0aUehpZVH4jhvyZHS25rI0Fb8Us1usraYJ
	fL4M8bZFg0Gmv7kS7v
X-Google-Smtp-Source: AGHT+IGIbFfwxftIcSQPMj+XA/sS67b8NDWPfF8Kb4beEyqUHTpSix4Gfe2Z2Mgh1GHHIM3iPiAGoA==
X-Received: by 2002:a05:620a:4016:b0:85b:8a42:eff9 with SMTP id af79cd13be357-8ab9acee01bmr979641085a.53.1762028958452;
        Sat, 01 Nov 2025 13:29:18 -0700 (PDT)
Received: from [10.73.222.215] ([142.182.130.176])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4ed352deaf3sm30290891cf.29.2025.11.01.13.29.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Nov 2025 13:29:17 -0700 (PDT)
From: Samuel Kayode <samkay014@gmail.com>
Date: Sat, 01 Nov 2025 16:28:47 -0400
Subject: [PATCH v2] MAINTAINERS: update PF1550 driver email address
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251101-update-email-v2-1-175d221ec40f@gmail.com>
X-B4-Tracking: v=1; b=H4sIAH5tBmkC/3XOQQ7CIBAF0Ks0rMXAUBBdeQ/TxRQGJbFWgTaap
 ncXde3y/8l/mYVlSpEyOzQLSzTHHMdbDbBpmLvg7Uw8+poZCNBSwJ5Pd4+FOA0YrzxY7FvwEjX
 tWZ3cE4X4/HKnruZLzGVMr68+y0/7B5ollzwoG1qN6IDs8fzpt24cWLf+5ESPqf5XfjzrMROv9
 yGWQ4M7b0BrFH1QApwAi85YoU1rlEJTTR2MlL5i6xvNc3la9AAAAA==
X-Change-ID: 20251029-update-email-f8ab42d1a5e9
To: Lee Jones <lee@kernel.org>
Cc: Lukas Bulwahn <lbulwahn@redhat.com>, 
 Jerome Oufella <jerome.oufella@savoirfairelinux.com>, 
 Samuel Kayode <samkay014@gmail.com>, Frank Li <Frank.Li@nxp.com>, 
 Sean Nyekjaer <sean@geanix.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, imx@lists.linux.dev, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762028956; l=1134;
 i=samkay014@gmail.com; s=20251028; h=from:subject:message-id;
 bh=f4ly8cg8WNIJApwHlFk7r+UQI1Q1uI2E782wrY3RmGE=;
 b=Q6W8p83xhBLpUQv/Kus5iJ+jaQweIa1jJo11C9T/BzNslQMtocpefTW+kzY7l7u6foGia4ybA
 7QiGFn5K8YlDSdV4wiFd3OMp45/q6fFwtcSIcyyU1S8H60rDS8ZL6HV
X-Developer-Key: i=samkay014@gmail.com; a=ed25519;
 pk=favoK08ilD1j62PrGf+RHihBzbqJGWMC6f2nszR5UIc=

Update Sam's email address for the PF1550 PMIC driver.

Signed-off-by: Samuel Kayode <samkay014@gmail.com>
---
Changes in v2:
- rebase on ib-mfd-input-power-regulator-v6.19
- Link to v1: https://lore.kernel.org/r/20251029-update-email-v1-1-f38f45aac2e8@gmail.com
---
I left Savoir-faire Linux but I do intend to continue maintaining this
driver.
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 2a9330f05e2fca6b8661bb698dea17dcfd7fc254..c44d2cf7e7b85104a6eb09142da8ef3d9fa7e55d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18608,7 +18608,7 @@ F:	Documentation/devicetree/bindings/regulator/nxp,pf5300.yaml
 F:	drivers/regulator/pf530x-regulator.c
 
 NXP PF1550 PMIC MFD DRIVER
-M:	Samuel Kayode <samuel.kayode@savoirfairelinux.com>
+M:	Samuel Kayode <samkay014@gmail.com>
 L:	imx@lists.linux.dev
 S:	Maintained
 F:	Documentation/devicetree/bindings/mfd/nxp,pf1550.yaml

---
base-commit: a7d6255a0bf302c028ac680564633a6aac5f611d
change-id: 20251029-update-email-f8ab42d1a5e9

Best regards,
-- 
Samuel Kayode <samkay014@gmail.com>


