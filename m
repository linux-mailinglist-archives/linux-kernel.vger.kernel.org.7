Return-Path: <linux-kernel+bounces-815999-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E485DB56E09
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 03:53:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2712B7A0476
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 01:52:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0CDC2248A5;
	Mon, 15 Sep 2025 01:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F/H1NmGL"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A65F021B192
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 01:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757901183; cv=none; b=e0l8zMiodm/T1gCFwtpBUipszD8cDvdMZ1AFNW25pdV2Eoe/8O+I4+alee4qN22zz2+U4zG0yb6kZdXGRi/mev6XkUGNN93xtYKocO+A+vlUOnuX7GA5R65X9WlNbU7e6WPEetuNdLDJE+gCOIt6X3DxRzRywBSAd8NGuETDGhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757901183; c=relaxed/simple;
	bh=JIsMKYVvFErbnKFHO1CrIUXDSj+IhP03g/zRcyQzRCQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FpSexFLlLYSRfGtc7tgKwOswveyv4/FjxcAk8KS1sMLq4Pf6gWUG2XapR5r099hf+7QnkCUo/bOVugkwb7ZZOPO08sHeRtiuAf9kD7k6MUPlMnQk5F6aOeygUjS9yIlsfy+WeMI8Gur2BTPg91m0oqOBfeWLb01A8tjXxq+x4vM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F/H1NmGL; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-7762021c574so1449768b3a.0
        for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 18:53:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757901181; x=1758505981; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2A139N7u8LP+PVMXYdMyToSHsPMkupLAjBa9WZQYT4o=;
        b=F/H1NmGLEn6vSw6V3PRv5lngqObF6ZrEvTpuqIAWlHMcgfjCfptxUDl70LSkCT7rMH
         /m4hSg0XVFh6POrsw4zV+bNrUDDTPmLIwH3X5ne62RvcPejIYe8f4VtlI84aA6h7vjyD
         8uouGy8KcZZOautOSkft3/B+uu9FiJMZz9JvTp93ifch2txrPk0z7hNKxFY1Yn1erXzN
         9tj2aUi39Z6M41ms2XwnmIOgFbJEdCfAaNLK0lfbKPhpBpn/3y4b8MeFckZAlvJV9uF7
         T6vYD/MhsSNp+kVjNG2N/ogQTdnuKP+rMbFMAN2CIfa5ykq3+Mw76E4aDfUMm/OmYhR7
         GhGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757901181; x=1758505981;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2A139N7u8LP+PVMXYdMyToSHsPMkupLAjBa9WZQYT4o=;
        b=A2opSgrv2bfVpqWSB+Zul5oZj89e8dWHs4yw886HUEalVxFvkm6a8Qv/Vj49YYHQ0K
         TfI55tF5JjuivpqrX3JugVwxLLgg+V5NjcjUREgfNY+LG/0wKAZgod0FEtGrpt2f6eMz
         ykjsl+eDuFahJfOIXN8+FRFF5vi8I1ygSRrNHZ52lNvzrzKf3VIgUva505cOZq/vJ2nA
         bxrfJC2R0SqIf7nvLajj7vFi+TjG3REHUbSacMaav5b5TExzKHHmsYXVISd12m7kpZPz
         1OkLpiwZ4xMcSoaLyb9TW9jgeZgcEn6+QE5YLovivMESCBGRhnxFbPr3hdZzdH96nyjP
         2H7A==
X-Forwarded-Encrypted: i=1; AJvYcCVHra4F5siJrbi/thx4++DPExdOLKAd2sE41+Q/fTWz5lDVSYWyvkcLfLMCIUiaWA2IWT4pAPgEkR/y8/Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxn6a2R1+ej5SDX7a7e3WjiuLXBjUuit28OgNle9seEupFQUf1w
	nrDZVp6H+yQMecDwLeQ21QcBFULa3XFNzjDMUnBSCpg6jjFU/H40DbcR
X-Gm-Gg: ASbGnctTqeG1q89tn7y642As5+OTzbtrI1+V1OGJsOvsXuTzR9WGFWe3Sxy7p+VNwZJ
	OClo9qh08+lAZhMNXPHd0v+yO1+oI9QI+CVhCuahhTYD0dtnS3pSdmcH0WLwF+wNEVpr6SmbJVI
	0HKG+kv4MgIaGNxlYc6ZKqeGgT+it5LWiFittBTtpCs1ebM8Hv2IOVcv4WGgJ6uAi0qzYy9fyQz
	hGeUh5KV9VcpLxL1ZnDES0//wY/KYIb/Yt2gKSYsIkCEq5th9fx9uStZkv4UIVGnM46BDzCuRwN
	7LEwLHpmjyfPRDCURy8gXVu3N4a949gToQf+V/Xidvy6bMZfoMgTjK/XSkSROPYIzYBKi1G4kpD
	sepna1kyIOZQWzFKvtXfh7TZg
X-Google-Smtp-Source: AGHT+IEiIX4HMezHoTHcpOx6Y7u2rWpvSIWej8foIoPdV55AIR8hCDNmJ2lq50k/5jhrKKdyqbQP7g==
X-Received: by 2002:a17:903:3c4b:b0:25b:c709:568c with SMTP id d9443c01a7336-25d24cac4f9mr113648065ad.25.1757901180910;
        Sun, 14 Sep 2025 18:53:00 -0700 (PDT)
Received: from [127.0.1.1] ([59.188.211.98])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-262df893ec5sm41565255ad.46.2025.09.14.18.52.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Sep 2025 18:53:00 -0700 (PDT)
From: Nick Chan <towinchenmi@gmail.com>
Date: Mon, 15 Sep 2025 09:52:26 +0800
Subject: [PATCH v4 3/3] arm64: dts: apple: t8015: Add SPMI node
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250915-t8015-spmi-v4-3-758620b5f2ae@gmail.com>
References: <20250915-t8015-spmi-v4-0-758620b5f2ae@gmail.com>
In-Reply-To: <20250915-t8015-spmi-v4-0-758620b5f2ae@gmail.com>
To: Janne Grunau <j@jannau.net>, Neal Gompa <neal@gompa.dev>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Sasha Finkelstein <fnkl.kernel@gmail.com>, Sven Peter <sven@kernel.org>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 Nick Chan <towinchenmi@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1146; i=towinchenmi@gmail.com;
 h=from:subject:message-id; bh=JIsMKYVvFErbnKFHO1CrIUXDSj+IhP03g/zRcyQzRCQ=;
 b=owEBbQKS/ZANAwAKAQHKCLemxQgkAcsmYgBox3FxPxpSPr9TPi3OX9425fiwK0FE73rPO/i5/
 DOT1UnRyX6JAjMEAAEKAB0WIQRLUnh4XJes95w8aIMBygi3psUIJAUCaMdxcQAKCRABygi3psUI
 JLb9D/9ZAEHklb2IiKDO8EAKTpsHj6N3G9FkJ943XH+Xa5OlnHu82KUqRtL05LGK2mPmJkSmpzY
 4TOTy++CXi6R2VL2nhM+XNPf0Cr4seFYc1JupRSW0jrVOKZH2QIJKgZ1jQuUh3E427XtRSrP+kA
 m8nwdmr6foVBiO3VYAScQxk4aHvaBHPLN4enotjeAIp0NrxBbCneARqAcQmahYopaQUSRgjKkjS
 0E+GbN416T6sw/DNFiwhUBix92nuUeXdz75Mb4xjN7TcuKo/U44oe1dbWJzC+MADrZOGNKvZ1nH
 F/KCHi8eka794nMEIdJiNdR1bJ8CYgL4KIF6Gyut47kUHhHcVBD7cIeWeHOfMa8lAbQ1YW38I/n
 I2Elwxit5ziXKe4N9OraDKFwX2yzAsVb5Hj58DEubfnu1gZgfFsyAECECZIEnuDQhWsACgbQlLR
 ORSsE4Rmq7sH4Cfu1twXJrQzqZbdv2RbCP8/hii7vbC5rH2sYGfaTS78chFENQw9E0go1gsjFfp
 4q2BPEw1oCW6XkUe3ea3BRrOGZC1zMJg3kniWPuN8QkcoZ62TfXj5Bi1KA8xvk6KWA76MIM/x+t
 csl7DCjPToSCDMPgRkWQPN9ZU9Pc+gTfV+Q2LD+DtgApqhkrHHTRVNId9gyeMBZovag9sW5X2q/
 J1LiTXb5RxjI0Pg==
X-Developer-Key: i=towinchenmi@gmail.com; a=openpgp;
 fpr=4B5278785C97ACF79C3C688301CA08B7A6C50824

Add SPMI node for Apple A11 SoC.

Signed-off-by: Nick Chan <towinchenmi@gmail.com>
---
 arch/arm64/boot/dts/apple/t8015.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/apple/t8015.dtsi b/arch/arm64/boot/dts/apple/t8015.dtsi
index 12acf8fc8bc6bcde6b11773cadd97e9ee115f510..4266667b23c1c851540a4a68411c50234f228071 100644
--- a/arch/arm64/boot/dts/apple/t8015.dtsi
+++ b/arch/arm64/boot/dts/apple/t8015.dtsi
@@ -11,6 +11,7 @@
 #include <dt-bindings/interrupt-controller/apple-aic.h>
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/pinctrl/apple.h>
+#include <dt-bindings/spmi/spmi.h>
 
 / {
 	interrupt-parent = <&aic>;
@@ -344,6 +345,13 @@ pinctrl_aop: pinctrl@2340f0000 {
 				     <AIC_IRQ 141 IRQ_TYPE_LEVEL_HIGH>;
 		};
 
+		spmi: spmi@235180700 {
+			compatible = "apple,t8015-spmi", "apple,t8103-spmi";
+			reg = <0x2 0x35180700 0x0 0x100>;
+			#address-cells = <2>;
+			#size-cells = <0>;
+		};
+
 		pinctrl_nub: pinctrl@2351f0000 {
 			compatible = "apple,t8015-pinctrl", "apple,pinctrl";
 			reg = <0x2 0x351f0000 0x0 0x4000>;

-- 
2.51.0


