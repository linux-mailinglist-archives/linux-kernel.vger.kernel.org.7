Return-Path: <linux-kernel+bounces-883573-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id CFE51C2DC97
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 20:03:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 23B3C4F25FC
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 19:02:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E8562CCC5;
	Mon,  3 Nov 2025 19:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IBTPfkvx"
Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com [209.85.217.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27A6822333D
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 19:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762196536; cv=none; b=YVWlL0b5dRcLKjGqYaJuhj0UF6GYZtSxL3R6S9Ayv/hhGmhdJeHDBgq7BhuOrCj28OIdtdubMdUQxor5kvw8yhdxSbs7OT2exidi9l5JRYRg0o4wt1fyZMiXILpk7ldFWPy2kssbRhqibLVbs8WzrbgNpQgSbym4A5jKVSbF6LE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762196536; c=relaxed/simple;
	bh=hvfee8sXKcTq7gEJakAvwck8wU8l+Scz9c49QRFo9dw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XQG33GFKXsxSL2ei+1oCO+Oe1v7T2DCBCiNF6Pxy7nU4bc6fd8Bm4WgnajjUq747jdfRuHOMLHWEABh5bRpoyv7YrHwMH5koTxFoYf/BYJEW9a1kaNSzu+sBul9W6d1Rqcrox8WSJ3t5Tyiv/4oq9bAh61v7AMpuB2X6Qm5Pbkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IBTPfkvx; arc=none smtp.client-ip=209.85.217.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f51.google.com with SMTP id ada2fe7eead31-5d980e08e06so2978070137.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 11:02:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762196534; x=1762801334; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9r2ANkDfOB5YfNM8kC4pPiqKBxC9W1qN8SMBk8lGv4Y=;
        b=IBTPfkvx6Wu89e0bm0eH6XbPtsvf8vkPgs0b9apwurQFG24CrX+eSXxx9wfnPpwIWA
         xw3yOk14Ot5xkMdyX/lvypu3X+n/2D4AAJo5cYBnxlhMvboJto+aY+P8cy9/PLsUsWB1
         Wk7ScvPQCvJI3DyoVF0Nm+SQ9NRx98cqKK/COYZXUL6meZx6RwN8GmSU6EdJztu/A4Qv
         xhU7ikEn0hGdq9+QgKYPsZsXa4zEtDk48R6/9qoQ1tOsqiDL6TE/MSzMF126lN97mF2w
         xCJPb2Mc4IMCIJ+rBX599ZRvhQxGU+FyA7NQrM+1qW7gLIxBUChxkqwgSyoGzkqFx+y/
         ZCkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762196534; x=1762801334;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9r2ANkDfOB5YfNM8kC4pPiqKBxC9W1qN8SMBk8lGv4Y=;
        b=ogCJUmYJFK5bIR2vfYEwDAyEZ0Z7JAWnVe7jO/uRiIDGnoExS8fEWoXGRKB2QI3v9E
         9YjdFvDc69esK8VWioWmcx7+JmEvVdcsdTFdv5O7kGOWltAaonK1fn+q76LvC8dRc8WF
         rXz5w59QTBthcZG3t2Rd6+iEOUd1O/y/q7a0MQ8mxSzyPv1yn3wnYZ1jme/YjvWXwJQ/
         +sWG8XD654mJkX8r5N88SoOrkaK4Tnc+1+A+mN/AKTQcgk1/4wLhLCrGbVN5Xb+VEmhd
         sjcW0uZrwoJw+ko21hZjlWwYeJZ0NQX+TrWh2K8WPOfKAwmx7LqMDy7I1JxKnUXNLQBt
         uqdA==
X-Forwarded-Encrypted: i=1; AJvYcCUrdfVWMiyZ4OoKSAJYsg//EQTfS3YjSwsXhT21BcCEfHGvWEyZk7SPO7VoYXTLMjo3XLMynZ7aAucwHLQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGCq0qCz648sE17GJZUj0he/OnZYVYABy/2ihMDAKB6Nok3Psf
	ywWWnchudduUMKvLDlccOGIOv+EkZeE4bklVISPaCOud96jr/h0Q5/dYHRrAdA==
X-Gm-Gg: ASbGncuU8W7iGiJ6S+720I5vwaLx4vS3tJYJE3cNuEvHaqg88rcZbEaO8M4VO+aPouY
	ru69KuLBMxcHD6M2BdJjEV6TTeKr7ljYi0j9ZTQe0eaCSVDVCwhoaJSB/3lB3aFuvNI4rCOJPhU
	HqnFsF3Ss52X7QPgeEZafgIqFhDEMyjWDYfI9spiFM83NjZgrOr5peVD+Dq1GDk2C0bjuWKKhAE
	g5XlCUihfDJ8O680LbqBMWYXlau5yg0/gMDfRhZduVGAb07lXoLbw7S5T5veGsrSnmOr3MwvviQ
	6ijkFKmUiqv2YYlpeBm43o9fk1V9N66WpdZxhIMHFmPVoDMB3YHGh7iFCc0aq5IG7pcKehlb2Pt
	hDwW3gUcI1uqVJx/6GLnA/MXP0yOk09yaOFT2iyx03ihECCl6AuChS1p50WBS5drtUTP6UnWQUy
	80CoHe3IAgjaUo
X-Google-Smtp-Source: AGHT+IHAvEL5uV6W5jmM4MLDCbHgG/IiWv4lbBhQ9ARySZHyuHwi5rGV6GQRfyyi1F8kgt5bof8sBA==
X-Received: by 2002:a05:6122:551:b0:559:61bb:18f1 with SMTP id 71dfb90a1353d-559769b87e8mr327879e0c.7.1762196524587;
        Mon, 03 Nov 2025 11:02:04 -0800 (PST)
Received: from [192.168.100.70] ([2800:bf0:82:3d2:875c:6c76:e06b:3095])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-55973c834e3sm358469e0c.11.2025.11.03.11.02.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 11:02:04 -0800 (PST)
From: Kurt Borja <kuurtb@gmail.com>
Date: Mon, 03 Nov 2025 14:01:44 -0500
Subject: [PATCH 1/5] platform/x86: alienware-wmi-wmax: Fix "Alienware m16
 R1 AMD" quirk order
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251103-family-supp-v1-1-a241075d1787@gmail.com>
References: <20251103-family-supp-v1-0-a241075d1787@gmail.com>
In-Reply-To: <20251103-family-supp-v1-0-a241075d1787@gmail.com>
To: Hans de Goede <hansg@kernel.org>, 
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 Armin Wolf <W_Armin@gmx.de>
Cc: platform-driver-x86@vger.kernel.org, Dell.Client.Kernel@dell.com, 
 linux-kernel@vger.kernel.org, Kurt Borja <kuurtb@gmail.com>, 
 Cihan Ozakca <cozakca@outlook.com>, stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1551; i=kuurtb@gmail.com;
 h=from:subject:message-id; bh=hvfee8sXKcTq7gEJakAvwck8wU8l+Scz9c49QRFo9dw=;
 b=owGbwMvMwCUmluBs8WX+lTTG02pJDJkcf5S28Il3hv/TP5TadvN5SPeVn877Np2Za/zzem5R2
 12fFImwjlIWBjEuBlkxRZb2hEXfHkXlvfU7EHofZg4rE8gQBi5OAZjIvmcMf4Ufu3fP1WvxPRA8
 QTu7e/5XHtU7ef9jC5ulhRdIPxP6/JLhn3pQnfI77szojls/WjY+/8Dk8ehcYYru1Z4Tupae/5Z
 UMwAA
X-Developer-Key: i=kuurtb@gmail.com; a=openpgp;
 fpr=54D3BE170AEF777983C3C63B57E3B6585920A69A

Quirks are matched using dmi_first_match(), therefore move the
"Alienware m16 R1 AMD" entry above other m16 entries.

Reported-by: Cihan Ozakca <cozakca@outlook.com>
Fixes: e2468dc70074 ("Revert "platform/x86: alienware-wmi-wmax: Add G-Mode support to Alienware m16 R1"")
Cc: stable@vger.kernel.org
Signed-off-by: Kurt Borja <kuurtb@gmail.com>
---
 drivers/platform/x86/dell/alienware-wmi-wmax.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/platform/x86/dell/alienware-wmi-wmax.c b/drivers/platform/x86/dell/alienware-wmi-wmax.c
index f417dcc9af35..53f476604269 100644
--- a/drivers/platform/x86/dell/alienware-wmi-wmax.c
+++ b/drivers/platform/x86/dell/alienware-wmi-wmax.c
@@ -121,14 +121,6 @@ static const struct dmi_system_id awcc_dmi_table[] __initconst = {
 		},
 		.driver_data = &generic_quirks,
 	},
-	{
-		.ident = "Alienware m16 R1",
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "Alienware"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "Alienware m16 R1"),
-		},
-		.driver_data = &g_series_quirks,
-	},
 	{
 		.ident = "Alienware m16 R1 AMD",
 		.matches = {
@@ -137,6 +129,14 @@ static const struct dmi_system_id awcc_dmi_table[] __initconst = {
 		},
 		.driver_data = &generic_quirks,
 	},
+	{
+		.ident = "Alienware m16 R1",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Alienware"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Alienware m16 R1"),
+		},
+		.driver_data = &g_series_quirks,
+	},
 	{
 		.ident = "Alienware m16 R2",
 		.matches = {

-- 
2.51.2


