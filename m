Return-Path: <linux-kernel+bounces-837755-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 33DADBAD1D7
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 15:57:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E420C1C7662
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 13:57:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74E493043B8;
	Tue, 30 Sep 2025 13:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="Ii58swwd"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9606D21D590
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 13:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759240640; cv=none; b=STU7TEJrQRhZS/jyqca2j6g5xLRgCHuyg6ViXzZHYL4PAbYnbcU9dZY+rCRWgR3E//sS5De0NFcjFUqLA+RQ3mhYBmGrB5PD96dhTgMGOIZoZPC0Gr+1v/zkfr6J4t5N+6ESdaYhlxR4O+YuR6QrNu0tjyx9ms3GjehmduWNrKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759240640; c=relaxed/simple;
	bh=tzYiBi1inoE6AQKDp3BZER5u/OgLXaF5Dw3TSJH/dpk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BNT1mic3RhfOCLXRzikAyGMF4BJHFbExwZgm35q2h0Wvtl6jk6qyfMrpR0t8GLm4YXr3YDEiY3wPXhMZU0yFbEr7m9Pox/bvolqfT9+0sPpKszDlfb590Q5rsg9nlz+rScMdipEi3ACZJrvZg0eSwO+jlf4EatTk+Ccq7jciPis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=Ii58swwd; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b3e234fcd4bso409690866b.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 06:57:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1759240637; x=1759845437; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lVfHh0PGJNCeCUt53q0MGqTcrE5zWwJY78oS+k48p74=;
        b=Ii58swwdeXSxfwH8WC/n4oK0hwSUPc+khTuCyt3sHvSpgxgDK6AHjmPa4x+JUa5bfq
         d0zHSFSPDbTTc3OGGYmUB4VSINSRLuYcirQj3yuatR5y8OfIseqqflOqc2zFJcac7GNR
         W09Ou7Lri4x80uwK6d+OfTR9/VU/h43Qsbj6het5Ron1cCQTnEzMF86OsxmnPFwb7hZt
         ko5Zb25w01zd74XgcfpPS3EXmgUz851QEvwO01e+537Xe4ygWIggQHUsfc9ANYcP8XaE
         7mnk36AwdM1BGFHqBgHi5WbvJaIYqVka3sL4vcp17JPJ95w8ZdNtbdgwVz3OI19nd0mr
         nowQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759240637; x=1759845437;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lVfHh0PGJNCeCUt53q0MGqTcrE5zWwJY78oS+k48p74=;
        b=ZgvX8H0WWoFUV0pLviKsrtvL/BdTKDXDqlNspKxkppWaTR3pkLvZqwgewLXHxOTTjU
         m5DmKndBolceTbyVK09Owbw1/ERpmqr1Cfbks2lCErcmFzCSQaLy9NvLGNOORJhu+yDB
         mTP7AtQRCxNs4IBpdQYHZUk0S7iMarC8tvHvBBh6NaJJ32tbjW7aRC+pQ8LJe96uUS9p
         dnJRupIQckEJUBp6bI8nwjYInYJh3oyZHFzZltiIFXM1wld3XqYUWb5ubo2ZcnV+MwjO
         yqXk/RT7/zU0s7Dhxr2y0W9N7IGCQ7gZgcMCGmnIRST9RWteG51dg9pKdm+/Jf5l1NrR
         J/PA==
X-Forwarded-Encrypted: i=1; AJvYcCXzC+lrCrJfca5MOPN8f04KLUFDCKRWyTEDeZHlo9uB/d9tvj7QAh9jd/QqFdvZbKWMeW6RsKfzZueYF3c=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHi6gpuUVeRspszzerZ72Gg+fpXjGaNB+YK4cxjE1cGexOFzp7
	+CT80AbiiIEN/ToelOUGsAE6J4+syzvopgxiGI+v9bmmFO0fjM7uMNbPFGh6Uj9C2X8=
X-Gm-Gg: ASbGnctdS7aEtDipb91lsbeWyMUb9tLMM9Gyx3JRvtQSbGQ/fK7RmHsB7YmQwrQ7f+h
	jHMC4XaeDW5MOtZRisV54Lf93vSZsmZOSf7DlBsdj5vwwy37YvoZOed53k+vbmGKIA7pnhBdTcN
	Raxjt85Bzb/kMNrxGM4upJgkxMM9+SAhL7+7K6ml8DBx9JEhyR4eO97v3hc9rXw1g6BWWTplcIH
	NWN2u3tN8cfVwrIR5iOEvpPxE4HsbciM5eK3a0d8ctDxp1nW4VDWV1n6WDYybN33GIPHrfG+ATJ
	7T37tPg9jtXDAQCXlVR1g94Tn+IiuDYvq8Ia48kAYIYppUaQ6kzJtrv3PLEgDd/OLJzdYj337Jq
	loouquBUTZ+lgLUHm4lAwndk20ml7phqdJNQ/MaSHhYkNhMAC+qcshoN7K3cRneHJ8c6YNfhPRo
	PLbrDsrWg7Pb6vxqTnBQ==
X-Google-Smtp-Source: AGHT+IGYpOyuHrV3NMYdDmii+YAGqD9Cnpv6UIS+kz/yGdm4TlrhmHWe/hPo+Kke8kFGDiqYhnt+MA==
X-Received: by 2002:a17:906:dc95:b0:b40:33ec:51ea with SMTP id a640c23a62f3a-b4033ec5d68mr618735366b.6.1759240636824;
        Tue, 30 Sep 2025 06:57:16 -0700 (PDT)
Received: from otso.local (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b3fb818fb90sm370234866b.63.2025.09.30.06.57.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Sep 2025 06:57:16 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Tue, 30 Sep 2025 15:57:01 +0200
Subject: [PATCH 1/5] arm64: dts: qcom: qcm6490-fairphone-fp5: Add supplies
 to simple-fb node
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250930-sc7280-dts-misc-v1-1-5a45923ef705@fairphone.com>
References: <20250930-sc7280-dts-misc-v1-0-5a45923ef705@fairphone.com>
In-Reply-To: <20250930-sc7280-dts-misc-v1-0-5a45923ef705@fairphone.com>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Marijn Suijten <marijn.suijten@somainline.org>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, 
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Luca Weiss <luca.weiss@fairphone.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1759240635; l=966;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=tzYiBi1inoE6AQKDp3BZER5u/OgLXaF5Dw3TSJH/dpk=;
 b=yTOVqbRldO1E+tGjFjGAFseABV4r1qByu1pbbAcH2yqG34o3vjM4uLWD1TvE2y8YIsU+8DoO2
 G4hPBGFUKpRDRrmcoYfv2t1HJ3SL30mFEMGZegh79iZKLBCX4mG/+85
X-Developer-Key: i=luca.weiss@fairphone.com; a=ed25519;
 pk=O1aw+AAust5lEmgrNJ1Bs7PTY0fEsJm+mdkjExA69q8=

Add the OLED power supplies to the simple-framebuffer node, so that
the regulators don't get turned off while the simple-fb is being used.

Fixes: c365a026155c ("arm64: dts: qcom: qcm6490-fairphone-fp5: Enable display")
Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts b/arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts
index 519e458e1a890814e5135450c60e5c71c1b75a81..36d5750584831d66b4c2faf6042e4cbb3274eca7 100644
--- a/arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts
+++ b/arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts
@@ -47,6 +47,8 @@ framebuffer0: framebuffer@a000000 {
 			stride = <(1224 * 4)>;
 			format = "a8r8g8b8";
 			clocks = <&gcc GCC_DISP_HF_AXI_CLK>;
+			vci-supply = <&vreg_oled_vci>;
+			dvdd-supply = <&vreg_oled_dvdd>;
 		};
 	};
 

-- 
2.51.0


