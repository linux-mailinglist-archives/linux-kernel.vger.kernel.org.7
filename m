Return-Path: <linux-kernel+bounces-822885-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D4F79B84E52
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 15:44:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9BF0B1C83BAE
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 13:45:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6829530C0E8;
	Thu, 18 Sep 2025 13:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="U+DD5T6X"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31E002D3752
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 13:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758203074; cv=none; b=i0+I+62N9zoyAc7++jXM+njZDqfK/Zsnvejx+tZ3O79C+VBeXSwWguy5bfu7cYfK3glYJ1CbySG9GYTayz3xKAHtw6iOWjAg6x1CKgt0X8R2kB16JU+jb2g7/I6oYb7VA63fUGUgbZtj0NcFf08WfwiAq9Iq/IEBflhMzDZ9lk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758203074; c=relaxed/simple;
	bh=XuOF4oo2GinDw6nta1GzB5BT0iZEdEiCzVd7lTzDV3Y=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=qhM+GSzRR9JFr/bvr7P2i9z2b1KtymNpi6e+EQc6icDO8wZA/GEKRmv99T/h0OMJzbW1+YTZK/ApC8NsRpC82UFs+G/W+Uv2JK2igbKdUNOAuzS3mfRFVTEkACR2v27zuscXhwnQwSPj0YCg63s4xrkB3XxBVa4+TdzEWV+3ZpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--abarnas.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=U+DD5T6X; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--abarnas.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-45dd9a66c3fso3566295e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 06:44:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758203071; x=1758807871; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ui5tTWxJ24mYLV11DTjF2SiOWTz6D5IXHniLYM1RLCw=;
        b=U+DD5T6XA8hU+MDmTcKRZO3F+mZqEGMy9Eim7N79a1PpRPFCfe3dWMxbX+g47MHZq3
         qwVQv8WoiIS5nz10fpq4E0vsL/r/mSpvSiQL0qQJWTIB2a4be2Rmn+rerG567togsoBD
         MlLI9LEsht9K6P3cDPe8tggrL1CviABJYDvsjFRrWFrdQ5DjOf/ZFOHTdE/5MpwUvPy4
         v6AAeIILM/IZz/hsVNoaOtNtQEbJ5rtUPV2l0ba6ML14yUTURNl254in3bsemqhhINfH
         TKMOGUpEJrlfUoAae0D8dHeTzNdsYmRHxCL6KTf/E9TK6ioh3zs5gS84U87kUcxa1e7u
         VAHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758203071; x=1758807871;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ui5tTWxJ24mYLV11DTjF2SiOWTz6D5IXHniLYM1RLCw=;
        b=XhhPFywVe4THb+QetVBseLqf86pLe7l9YB22GNlPysamLEivAvf69EauruY+R+7Nc4
         MSzURnq52RyDlU7ta1eVZzrio4Gm6rntZmyhZRiDVj+bWlokKrqgMUKjFAgAYPhEuOkx
         pgGFCym3za16p853iLb7YWDRp4YNngbO4BNGtnY/tJrj+4p+kendqCAfsUjJrUkLXlwk
         9+6LaDryQL8R2eFu+utqsSpb2MAPabkgnloJDj4YjtzkIGkA0LCKUq3+KTlXoU2YlUdJ
         RHQA6npGESEUoIRjtCyrHq2+2TmBP8C+/lLpRgl3CUqEV0QzxIp77sq+y35U8npTl9aT
         invw==
X-Forwarded-Encrypted: i=1; AJvYcCXW/BoakSMkdUqY/I2/z8sdM/+diJGxrcDKwEXwlR19cRYHeMbC69vWBhEgfcJJ64NslN0Hmb360EpIRe0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxuPmsgZrveBjjcMrRxzexmvm8cXIVXyjnH2hwxLAW/tm5xIBN2
	MDnwygLfCSX4J78XGF8qU3+vneD6euPSx0nCZK4b3nnvoJbBCCbleIupYQxflWyjdJSuHThyrNo
	g5CNWVQDu9g==
X-Google-Smtp-Source: AGHT+IEkBbKrfoI0H8uPH3QdEl5PEuuy96uXEpRRSsfVmacTDuWG5tsTGBzmx1eB6WxtriqBAzOrNhmtQrjf
X-Received: from wmbeo3.prod.google.com ([2002:a05:600c:82c3:b0:45b:6337:ab6b])
 (user=abarnas job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:4511:b0:45d:e326:96fb
 with SMTP id 5b1f17b1804b1-462066563e4mr65848755e9.30.1758203071419; Thu, 18
 Sep 2025 06:44:31 -0700 (PDT)
Date: Thu, 18 Sep 2025 13:44:28 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.470.ga7dc726c21-goog
Message-ID: <20250918134429.270814-1-abarnas@google.com>
Subject: [PATCH] arm: make sa1111_bus_type const
From: "=?UTF-8?q?Adrian=20Barna=C5=9B?=" <abarnas@google.com>
To: Russell King <linux@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"=?UTF-8?q?Adrian=20Barna=C5=9B?=" <abarnas@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Because driver core can properly handle constant struct bus_type,
move the sa1111_bus_type to be a constant structure as well,
placing it into read-only memory which can not be modified at runtime.

Signed-off-by: Adrian Barna=C5=9B <abarnas@google.com>
---
 arch/arm/common/sa1111.c               | 2 +-
 arch/arm/include/asm/hardware/sa1111.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/common/sa1111.c b/arch/arm/common/sa1111.c
index 3389a70e4d49..04ff75dcc20e 100644
--- a/arch/arm/common/sa1111.c
+++ b/arch/arm/common/sa1111.c
@@ -1371,7 +1371,7 @@ static void sa1111_bus_remove(struct device *dev)
 		drv->remove(sadev);
 }
=20
-struct bus_type sa1111_bus_type =3D {
+const struct bus_type sa1111_bus_type =3D {
 	.name		=3D "sa1111-rab",
 	.match		=3D sa1111_match,
 	.probe		=3D sa1111_bus_probe,
diff --git a/arch/arm/include/asm/hardware/sa1111.h b/arch/arm/include/asm/=
hardware/sa1111.h
index a815f39b4243..90b6a832108d 100644
--- a/arch/arm/include/asm/hardware/sa1111.h
+++ b/arch/arm/include/asm/hardware/sa1111.h
@@ -368,7 +368,7 @@
=20
=20
=20
-extern struct bus_type sa1111_bus_type;
+extern const struct bus_type sa1111_bus_type;
=20
 #define SA1111_DEVID_SBI	(1 << 0)
 #define SA1111_DEVID_SK		(1 << 1)
--=20
2.51.0.470.ga7dc726c21-goog


