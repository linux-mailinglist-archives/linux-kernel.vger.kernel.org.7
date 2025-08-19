Return-Path: <linux-kernel+bounces-775817-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EE422B2C55E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 15:23:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04ACC244135
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 13:19:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB6493469F4;
	Tue, 19 Aug 2025 13:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="d46pVRlc"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F438341ADC
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 13:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755609444; cv=none; b=lTg+nOOj3Ay0nSUOXBknlXmyT6g+NXIOC8/j9hNNM39Ta0zF98jePlDRpIMwGhZ1afdvtWQkjWVyUi67qWgjMOdlcI9FWLCRlJCD7/T5F22HPjLhebisTXoYJH8zB4qep/5a4KUa/Z3GSk9VOIse214fRz9siqiz1eYhiBJg5gU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755609444; c=relaxed/simple;
	bh=cAElRoL2NWCvmuacyatuiiR1RMfdevKs/9j2Ed/NzVg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sUc/7szDP4XBfrhlLxV9v1QkCkNG8hwbasklzjTfdcTeuDEwUgQlGk1Y7Ccc9tg+QCfyhlqjXHwklzsK2yB0IljerEcPh7Q5YiY6oTAh2o9RXjwC7ZOcuJuijgze3HpcbOFKO78NKsUlwu+MtU1UU89LleDOB83hfAcjiXdc2K0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=d46pVRlc; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-6188b7895e9so758718a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 06:17:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755609442; x=1756214242; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=F/SWEsw9FA3/BNJIk6fInZnfujPr6po/3IYDw4Qd3Tw=;
        b=d46pVRlcvyQdsdPXaWZW6HaZkdmzYUK1XGcUsELM+dXpJ/P4bjP1rqgqMo5hpdip4Z
         1pokdrZAGab7R4Ty2e8gq0ftAV8VSRmUmDrZZNvhfI8l3cFAkTCRm0IACf1J8EY6e+U6
         fB6ypb2cT/PaLbirQMiAc8DbAgoXGMmyndPeDJ/dy3MGYlH153/pfUthhPZv15xjcebo
         k4Y5AvCqbA1biwG9kG+H2jDjZa6AKawvqV/MvWz4WK4CXVFDkR4hX3GUk8lE+Kx+Re9j
         4WQASxRf0fi/rGUuynD+wSD+KVI4tjKLUXoK9EhzJSWRbpEGsb6PvOR1lKmtMg1Fp3uS
         GYUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755609442; x=1756214242;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F/SWEsw9FA3/BNJIk6fInZnfujPr6po/3IYDw4Qd3Tw=;
        b=rLjaFD7qFLBwtmSE0BBuEys1k+Y3O+14lt3DT3y4A+j0EQF7KPlEwZ1Kjubl+lS+YW
         VBD5Veb7TuWBaNmGwnEDsXoeoTiNdpAYHR1NJpoBMeX5R2os7dpd6Z2NT3uZRT8Gr3CH
         YctUmpB1BVn59XfSW0xsh0/f9FgpoNaiArT1Se8r2p6lu4hNt1WDnE76oJkFJF5xSEzu
         1WOhgWCPUbhwJ2Zn2dGkkLT+hxYsALp13GxhqoCkNGoLuXZnTFY0f0KSDwQXHdri5I/Z
         BrBMvw5aCSUmVwKVqt5Kc+qdc5ZRIjzwEveqHImjrMwvNV/r/5IyQOy2tbjCbiC3Dft8
         1Nkw==
X-Forwarded-Encrypted: i=1; AJvYcCVS5B6PpGBFxPXcVllKEqlCAFf8eEL9f/5+aZJ3N4W0VYoqBLGOH1XuU2YF0bEIaQS4I52ztbiB9P96WDU=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywn2enjxUuLoUuBaeoxvA+0XrXXKRBhrWMxdsjQL42Wc6VQiIYk
	BHHwu0ulsbn0wXrQv3j2LfovzwV9vboOkaFJvKyP8smN0fNjpu02/dUEA4B3uxWo2sw=
X-Gm-Gg: ASbGncsfh45enME/x6Jrip4I8FGkk9hULWZk6iKVwmF4uqlZ+VM6rw7oIFADJUknURm
	B4CMFaAvASRviiCdJPXvem1zLkcIXmKccA34jtxBlgOxrw7L7K+sCDwLbQRhHY/jpqs8rhfgl6r
	FyBklCeEFYXFdWBSZit5nv2nrh/Q0nndDMJpiJz1toRJIOQejwg0hqRj84/8QbJfFmclYRuviQx
	3E95BUbY/PkM9wTYvnfEXzk4Lh7fwQIhtx4mFQpIA5iK2sVyO80UdaC7TgHiAkZK5h+5KOMYKuc
	agtcK9OAUZoScCUcbg0lys8R+A7RsJ/jXdx6RprCsP5eEmzPyBkgGaQ/0KdlzeyyhjUbdQFO88G
	uoPt46PrB548UD5EL1b+vMGbgp0sK7wHbrQ==
X-Google-Smtp-Source: AGHT+IFLw4OO7nSlgIF0qPS+YvoqDVvOPMHcN6Km34QLMfCyT+GzpmfJIFPnh8iJs+rvRWXDVTu29w==
X-Received: by 2002:a05:6402:13c7:b0:612:a505:34c3 with SMTP id 4fb4d7f45d1cf-61a7e765e61mr940286a12.4.1755609441644;
        Tue, 19 Aug 2025 06:17:21 -0700 (PDT)
Received: from kuoka.. ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-61a758b8efesm1694229a12.50.2025.08.19.06.17.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 06:17:21 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Kees Cook <kees@kernel.org>,
	Tony Luck <tony.luck@intel.com>,
	"Guilherme G. Piccoli" <gpiccoli@igalia.com>,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 1/2] ARM: dts: qcom: apq8064-mako: Minor whitespace cleanup
Date: Tue, 19 Aug 2025 15:17:18 +0200
Message-ID: <20250819131717.86713-3-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1173; i=krzysztof.kozlowski@linaro.org;
 h=from:subject; bh=cAElRoL2NWCvmuacyatuiiR1RMfdevKs/9j2Ed/NzVg=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBopHldNt7hGa21JU8Gz1KGlMh3GILNacKyzCCeP
 voiRS8LlwqJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaKR5XQAKCRDBN2bmhouD
 1+NOD/9CfUYtVivxuyZU4eEgjmt4Q0N4PsKnUbRscq6f8ZkQVHxQxkPrbyNeHSziNjMIyKZNowe
 G8bMZNapagriutogSZxWpukuiwLe8iaAyyicBDNxgh9PN4ECtgXpeLqpYrMPvADUbJ/0B4Yefwg
 4UtDTNtuTMXlEkE9tA3simAWtomIN/6AKa2qUidyK2luD0+UZFMtfr2Ddr7ICYlRpQMqAKawkjp
 gOs9W+/iSrHmaBSYd9tSInwsHsMl7mwyMxI5zbQkFI3FXf/o7qnqrAKhIWmlrWNEDGMLYmaC3kZ
 f8eGUArolxbe8iKTpVaiv0R5sW6z9tsRniwlKMC0j2UIcUNvT2PYnpombnnloMKxDwV447UqXA9
 Ys2nlJzeYKtzJUW+NyHkOjmjz4O7BiY/f6V5Ba2e0lYai9EFFE2vVc8pnjoHQJfCY6CfDHsMDVz
 3RUa+wzxIFA3UO+tcKXfjinbH+fs60L/zT2lHUU291yDsExinQpVb8kFd2CnBSyIYqwBdGCGSnq
 d15akv264DZcQj9aJxWAEu3gp6IGF6aFWB4ba2/OYqYwEUOThD8O9UcDEOPRXeljPxDpq1wennk
 9JqZluZAizzLPi/dHHAVb3nOnQXht5aL4PLsPxEdE0mAxIpGQHTlEQO9c8JF9V6JqL+6S/L/yyU dhLb5c0Tkwtn+YA==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp; fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
Content-Transfer-Encoding: 8bit

The DTS code coding style expects exactly one space around '=' or '{'
characters.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm/boot/dts/qcom/qcom-apq8064-lg-nexus4-mako.dts | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/qcom/qcom-apq8064-lg-nexus4-mako.dts b/arch/arm/boot/dts/qcom/qcom-apq8064-lg-nexus4-mako.dts
index c187c6875bc6..fdbbc1389297 100644
--- a/arch/arm/boot/dts/qcom/qcom-apq8064-lg-nexus4-mako.dts
+++ b/arch/arm/boot/dts/qcom/qcom-apq8064-lg-nexus4-mako.dts
@@ -34,7 +34,7 @@ reserved-memory {
 		#size-cells = <1>;
 		ranges;
 
-		ramoops@88d00000{
+		ramoops@88d00000 {
 			compatible = "ramoops";
 			reg = <0x88d00000 0x100000>;
 			record-size = <0x20000>;
@@ -326,8 +326,8 @@ pm8921_s3: s3 {
 		 */
 		pm8921_s4: s4 {
 			regulator-always-on;
-			regulator-min-microvolt	= <1800000>;
-			regulator-max-microvolt	= <1800000>;
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
 			qcom,switch-mode-frequency = <1600000>;
 			bias-pull-down;
 			qcom,force-mode = <QCOM_RPM_FORCE_MODE_AUTO>;
-- 
2.48.1


