Return-Path: <linux-kernel+bounces-840667-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B9FFBB4EDC
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 20:46:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0302332227A
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 18:46:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CED127EFFE;
	Thu,  2 Oct 2025 18:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e2PUofOZ"
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBD6012C544
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 18:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759430761; cv=none; b=J//OQPChKT7ZSmrCiDQPkjY15UhNBOAscRWCVYCAFoD5QHzq1zGekGgU0oRHvxXgOSGxH9XHSVsQ3UDg/28dXuNQJSc9CVOaMRYtSsoY52W/YPBl+YXs8q7KOOEck+TT62VoyFZwZHeNKR+r/q+xyFNi5Ilcf5/uqc+HDTmF26I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759430761; c=relaxed/simple;
	bh=Ascy4a+Xeii0NZTr/g7kAFe/Ox0HSoQnoFLYu2nFJE4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ObMPemQ0PhhXpB0ifl8FUv7nX5ufqTxvc9Y2OqumO6OkUkpCJt9dATtHu/f8Wa20iW3rB4KoKm7mJnZ5U0q8JvA3UVnjyEh+ZvD5WMzFV+jD9TuAQFtlSVlRvD50nEBWFyAPHmxxnx+WBrsWc+DeTr7wRzo5nRVDFiEdZVrac5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e2PUofOZ; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-330b0bb4507so1390020a91.3
        for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 11:45:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759430758; x=1760035558; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/gi5q0a0nZyS/dfJX3MGDVRu/hHYpidRpZ3Oro0wuwY=;
        b=e2PUofOZbWliyOxrhK/5zDwlNnhjjh2r/Qm/LFQjAbfjAOroVdm5n+hCsiHpxyrSFR
         o6sTEzVFOddbNqRSN1UiAW3BFgDMlKLg1f6+xRn/JUcgajp9R9LZAEfA3svvYkW09m0E
         +5UgKtEutBc74yHQi158b6jvQGL3aPjcsXXcKFcfxFEkwCi4+Li44Cn9VInAWTS7OLBX
         Yv4TGSqpTUkNKHelTr9CkTcpiJMPc4zaTMYFYA9Dle5crbO2QZTRtG8A/xHdWRdbRWYm
         lfQBbun2mPempeBm8TNUe9j3Zk2kWiNb97gVyceP4TfruPHzKulU8xGc5uvA4W/uwd+b
         Bhsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759430758; x=1760035558;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/gi5q0a0nZyS/dfJX3MGDVRu/hHYpidRpZ3Oro0wuwY=;
        b=RwpQAt9tO4jnq8K04n5Uy61N2gS0uhu2eW8EXYEy96L7emvk7uxbGZGJE/+nSkAXFZ
         EmA6UyJZ1v6aQs07j+KK+gSPBsjo2CCf0c79fWPkLZdK+4jyXeMtsrT6CralZ4VM+6Y0
         CgjsABWWocPi1ms7ZTAs3S6hwhfmlwL2HJuQi5umiVUb6IVpAImCnJv64SFWI4vnTCzN
         aFLgzI9VKOL/AojD8HwA3g83NVoSvHAx4vmGRrRgbSL0tj7MJNgjthngcyj6/i1vn7K+
         F7i9C2O+leAXOYiBIsXf77ZJ//9/wXXR3BsXJxdxJ6s0MegSpOYNUVzxlSq5YVqhNtk8
         ArlQ==
X-Forwarded-Encrypted: i=1; AJvYcCV7FjvW2oOTzo02LJ8IMhEHoV3v8v2Qes8Gg6gU3GhFW9hG7DX32GjyiHulhgeeHWKEs2l3ndirVAeyfBU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFYXKlxRJwwiGXE8W84/4DbJ3wwoQBjG4Q/zUu3k/Gts9MFS94
	UuE3Yg6TXacqFnXPG1J5NI+rQ+7z8CyGI1HMCQZaj2ZsgjRSPHZv9ML7
X-Gm-Gg: ASbGncsfEGtxK8kCv9Y9bo62r7xNY7e+YbVyFWBmOyw8W5X4EMf3A/2suwQic/284VN
	oy/mIO8ikEijx4VCxrjb96zG+WsIPDX4xQgVO5L+Jxv+IWMPpw0ubNmVDK0kRztPFz1/OuLV0cr
	qObh+eQywYRsk1BcvqCHoE9AYNtGfxjx1lab2LXRQPT6rEcmBK2ZKNuKJBdAx/2/aVRrosi903t
	gezz+gvxKFlGjwjQsyMjE4wQemEHVOWvN342rCajp1Oblg+oDIFfIf64fsoI8m5SWn+Mh52SEB/
	vM3zWRea/use80zoB6mZaSN4UgstQ1KiJ+Hq5p8mjB5v32MdtiIzsc3cfBkI+4Ae4nOpgCihFNd
	JHf2wmtGbss8UgvvlolcN2oY/Zkmc/8S5ZKKgHJb+B6EqaM0BVYXWHpzo
X-Google-Smtp-Source: AGHT+IFD/xR7zKZYq6ViRMZbh2WKNDPDZW4cTflRTL1qJCjXE32+dlrH1auWCgKPbeZC9OKbs2Dm1A==
X-Received: by 2002:a17:90b:17c5:b0:32e:528c:60ee with SMTP id 98e67ed59e1d1-339c27ba49bmr384189a91.24.1759430758146;
        Thu, 02 Oct 2025 11:45:58 -0700 (PDT)
Received: from archlinux ([179.110.144.170])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-339a701bf31sm5600336a91.19.2025.10.02.11.45.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Oct 2025 11:45:57 -0700 (PDT)
From: =?UTF-8?q?Eric=20Gon=C3=A7alves?= <ghatto404@gmail.com>
To: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Rob Herring <robh+dt@kernel.org>
Cc: devicetree@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4] arm64: dts: qcom: sm8250-samsung-common: correct reserved pins
Date: Thu,  2 Oct 2025 18:44:59 +0000
Message-ID: <20251002184459.15742-1-ghatto404@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The S20 series has additional reserved pins for the fingerprint sensor,
GPIO 20-23. Correct it by adding them into gpio-reserved-ranges.

Fixes: 6657fe9e9f23 ("arm64: dts: qcom: add initial support for Samsung Galaxy S20 FE")
Signed-off-by: Eric Gonçalves <ghatto404@gmail.com>
---
Changes in v4:
- Removed accidental , instead of ; in the last line

Changes in v3:
- Actually fixed <40 4> indentation
Sorry, I still had my editor on 4 spaces a tab

Changes in v2:
- "Fixed" the formatting of the <40 4> line
- Added Fixes tag
---
 arch/arm64/boot/dts/qcom/sm8250-samsung-common.dtsi | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8250-samsung-common.dtsi b/arch/arm64/boot/dts/qcom/sm8250-samsung-common.dtsi
index 96662bf9e527..7696b147e7da 100644
--- a/arch/arm64/boot/dts/qcom/sm8250-samsung-common.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8250-samsung-common.dtsi
@@ -159,7 +159,8 @@ &pon_resin {
 };
 
 &tlmm {
-	gpio-reserved-ranges = <40 4>; /* I2C (Unused) */
+	gpio-reserved-ranges = <20 4>, /* SPI (fingerprint scanner) */
+			       <40 4>; /* Unused */
 };
 
 &usb_1 {
-- 
2.51.0


