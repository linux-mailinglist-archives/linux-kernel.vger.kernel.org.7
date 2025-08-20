Return-Path: <linux-kernel+bounces-777711-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47249B2DCFD
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 14:48:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F5066256E0
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 12:46:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F0A6311C3C;
	Wed, 20 Aug 2025 12:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="k0xhhcAL"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B96AF308F05
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 12:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755693956; cv=none; b=EzeaezKCujI6xN0mJpxPHZaVLXxBq6I3cRJ8N2ChqnLK73ty5gejm4Y/1OQ8Cwfd5V1McRxijMC1r3NwqmiMttm3cJjzH6u7UmB5WtpX3fFLKr/LhFY0P9JkNCRCc7/gUV527w3QMApSZ8sZvEqbyyPWpiyRv6B6hq+fvUjimoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755693956; c=relaxed/simple;
	bh=7AZ0eI9TlHe52bT1lMC6WLW7ZECYFMBF31lbfocuWEQ=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=sin4fD4bnnz1T6yRTP+8R+X9EDRD63ok9ril3/32kN0xOTae/7Ro4V+wAsNK0LMa8pKAzJU3T8708qiluO/W+gZ9IXC0hOdAujhWlei4ibYuG4PSlIzMVa/NeXiVSUWDkzefNyoit/Y26Nt8F+eXi8/fhktStUte9JU+ZW9vibA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--abarnas.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=k0xhhcAL; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--abarnas.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-45a1ac1bf0dso5591745e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 05:45:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755693952; x=1756298752; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=L5gozRnSQkDuhLJMwdLaWw1qElhIPtCo1zd2N9em84E=;
        b=k0xhhcALSzIxnzXDW6H2v68LeNjJM/wx81RAUBhhs1kCM6Jm5F7ZxN6yczEEf07v74
         qyf6oaLFvDdRKBja+mjWt2SUdDZeDSOz6fYdkky9n8Z5iEb/WPnhCsuiCKP7pfp/OXK2
         qFhud2VEr2ReYqVYA43BUHHGJ+iBBAmE3NSu59P9fjPmfhBeXThZUXuVFeF57CrTCl4f
         ngdXRD52FFX5AOebDmFWA+kOZ0Rc15xZozj1ZMZXQ+w8ji0ZsZBTuwNAx/j6+FmeTH6d
         8D05WKTzcL888+X8ttQ+gKSt44IF6yus6S6JE7+h3gqioCMpCckrxVVyla5GuIWr/dCG
         rAaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755693952; x=1756298752;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L5gozRnSQkDuhLJMwdLaWw1qElhIPtCo1zd2N9em84E=;
        b=gaPCnfr43yVycGu479v2d/S8XbrckaCoIxj9LMB3oT2vkz8RG0KpD6+r0bBKyeV/Px
         cDLI8v3j1Ei0osScA8iPbZtESHvKvzPEnjE1TQRrKU4LrWuVhyTUYL+Hwu+VrwOUDmHw
         87dioA8PK4qz7NNyCjp9+3elGCItDbloZzZhFmvO5U+qoTyQgLymkhXB8llhiBxVZI8h
         FOHZQ9dkgVHkqQx+5GKBb+tkcxp4KO1ikjjroOT1cXb1lnu5Ilai5lX3Y+9vkrPUeNlw
         j8DwynGiqo8AkRXiSGKhLFiE84Va9aihUsrxQ7dI8B1lcPdXCLarB3Hn27PD9DWDKryO
         +oIw==
X-Forwarded-Encrypted: i=1; AJvYcCVwdFOFvqx9qpzIWFU+dP013AY9spR+fxVu/rBU/3W53okOWw/MpRyxwyziwiHZNTYJMtNDUXHALEmVB9E=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZuLHFVxlVIoXqTLhqAB4F+0JCjPxrKzPNxCkkvJ71y3A0cTDn
	qPO5IO+RiMH6JBFJbytBiSwyOt5NNjaPScWblm5pu8/cRXdOZx4SLtEOZuq1kA4pbWvGALmEZwY
	Qr455sYv+fw==
X-Google-Smtp-Source: AGHT+IHVetR1KhaNo7u3MMikYnmy6Ccr19qtqBiiIGbBQ8eluV+r4wxJSlvm1cyFFrRG2yeAI2VhAGBN2H78
X-Received: from wmbds11.prod.google.com ([2002:a05:600c:628b:b0:458:bfa7:dd5b])
 (user=abarnas job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:4a9d:b0:45a:2686:dda2
 with SMTP id 5b1f17b1804b1-45b43e6e738mr35344485e9.5.1755693952214; Wed, 20
 Aug 2025 05:45:52 -0700 (PDT)
Date: Wed, 20 Aug 2025 12:45:19 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.rc1.167.g924127e9c0-goog
Message-ID: <20250820124519.2287171-1-abarnas@google.com>
Subject: [PATCH] staging: media: atomisp: Whitespaces style cleanup in gdc.c
From: "=?UTF-8?q?Adrian=20Barna=C5=9B?=" <abarnas@google.com>
To: Hans de Goede <hansg@kernel.org>, Mauro Carvalho Chehab <mchehab@kernel.org>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, Andy Shevchenko <andy@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-media@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Cc: "=?UTF-8?q?Adrian=20Barna=C5=9B?=" <abarnas@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

NFC: This patch cleans up coding style whitespace issues
in drivers/staging/media/atomisp/pci/hive_isp_css_common/host/gdc.c

Fixes include:
 - removal of unnecessary line breaks
 - correcting spacing around operators
 - correcting spaces between types and names

Signed-off-by: Adrian Barna=C5=9B <abarnas@google.com>
---
 .../pci/hive_isp_css_common/host/gdc.c        | 33 +++++++------------
 1 file changed, 12 insertions(+), 21 deletions(-)

diff --git a/drivers/staging/media/atomisp/pci/hive_isp_css_common/host/gdc=
.c b/drivers/staging/media/atomisp/pci/hive_isp_css_common/host/gdc.c
index 8bb78b4d7c677..69d709888c05a 100644
--- a/drivers/staging/media/atomisp/pci/hive_isp_css_common/host/gdc.c
+++ b/drivers/staging/media/atomisp/pci/hive_isp_css_common/host/gdc.c
@@ -14,10 +14,8 @@
 /*
  * Local function declarations
  */
-static inline void gdc_reg_store(
-    const gdc_ID_t		ID,
-    const unsigned int	reg,
-    const hrt_data		value);
+static inline void gdc_reg_store(const gdc_ID_t ID, const unsigned int reg=
,
+				 const hrt_data value);
=20
 #ifndef __INLINE_GDC__
 #include "gdc_private.h"
@@ -26,9 +24,7 @@ static inline void gdc_reg_store(
 /*
  * Exported function implementations
  */
-void gdc_lut_store(
-    const gdc_ID_t		ID,
-    const int			data[4][HRT_GDC_N])
+void gdc_lut_store(const gdc_ID_t ID, const int data[4][HRT_GDC_N])
 {
 	unsigned int i, lut_offset =3D HRT_GDC_LUT_IDX;
=20
@@ -36,15 +32,13 @@ void gdc_lut_store(
 	assert(HRT_GDC_LUT_COEFF_OFFSET <=3D (4 * sizeof(hrt_data)));
=20
 	for (i =3D 0; i < HRT_GDC_N; i++) {
-		hrt_data	entry_0 =3D data[0][i] & HRT_GDC_BCI_COEF_MASK;
-		hrt_data	entry_1 =3D data[1][i] & HRT_GDC_BCI_COEF_MASK;
-		hrt_data	entry_2 =3D data[2][i] & HRT_GDC_BCI_COEF_MASK;
-		hrt_data	entry_3 =3D data[3][i] & HRT_GDC_BCI_COEF_MASK;
+		hrt_data entry_0 =3D data[0][i] & HRT_GDC_BCI_COEF_MASK;
+		hrt_data entry_1 =3D data[1][i] & HRT_GDC_BCI_COEF_MASK;
+		hrt_data entry_2 =3D data[2][i] & HRT_GDC_BCI_COEF_MASK;
+		hrt_data entry_3 =3D data[3][i] & HRT_GDC_BCI_COEF_MASK;
=20
-		hrt_data	word_0 =3D entry_0 |
-				     (entry_1 << HRT_GDC_LUT_COEFF_OFFSET);
-		hrt_data	word_1 =3D entry_2 |
-				     (entry_3 << HRT_GDC_LUT_COEFF_OFFSET);
+		hrt_data word_0 =3D entry_0 | (entry_1 << HRT_GDC_LUT_COEFF_OFFSET);
+		hrt_data word_1 =3D entry_2 | (entry_3 << HRT_GDC_LUT_COEFF_OFFSET);
=20
 		gdc_reg_store(ID, lut_offset++, word_0);
 		gdc_reg_store(ID, lut_offset++, word_1);
@@ -85,8 +79,7 @@ void gdc_lut_convert_to_isp_format(const int in_lut[4][HR=
T_GDC_N],
 	}
 }
=20
-int gdc_get_unity(
-    const gdc_ID_t		ID)
+int gdc_get_unity(const gdc_ID_t ID)
 {
 	assert(ID < N_GDC_ID);
 	(void)ID;
@@ -96,10 +89,8 @@ int gdc_get_unity(
 /*
  * Local function implementations
  */
-static inline void gdc_reg_store(
-    const gdc_ID_t		ID,
-    const unsigned int	reg,
-    const hrt_data		value)
+static inline void gdc_reg_store(const gdc_ID_t ID, const unsigned int	reg=
,
+				 const hrt_data value)
 {
 	ia_css_device_store_uint32(GDC_BASE[ID] + reg * sizeof(hrt_data), value);
 	return;
--=20
2.51.0.rc1.167.g924127e9c0-goog


