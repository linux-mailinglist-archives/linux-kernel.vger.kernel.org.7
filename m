Return-Path: <linux-kernel+bounces-834466-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 632B8BA4C09
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 19:13:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B4DD81BC84E8
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 17:14:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0CB330BF7E;
	Fri, 26 Sep 2025 17:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GFjuszb+"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95E2E30C0E5
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 17:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758906817; cv=none; b=AX72Q9Hri1L5v2v8VyFT6Rhmzdaw5EO8YM0W3nALNrtJPxi3jv49pf6MAf8ykAxkSD6gPv9+H2NINR+Y4yiyMCyniX3R8/A4OI6P39Fi9UGMmMBr1YbU3a7CGWFBz6IsVWRv2zzAfEM7ZMHlhi94rH2P68c14ONYM0dvr/xAwyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758906817; c=relaxed/simple;
	bh=KXa+AFXDw/y6DHlre9QjMfUSHSGKMD/6rd68rkDHdP0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VDBEwmJ0syHIV29OfgaJk1p0tZCNs3XR1FD4fSy+dz4Qs8QYHqpWun9Hcx/PhGaCfrfXlfRL8LGgP1y2dNqpoRg+XAeBo8l1CcSjI5x+0GXR11i82X67+oj+E9UvphmhyeKUOCdOAfLtZ92JSCFyfmhSn6GVcKhgE0j3CD8+kJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GFjuszb+; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-634cef434beso31126a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 10:13:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758906814; x=1759511614; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8Jlwkvw2hHQ0c6jPA0PLEUgMv6NDdNMIusq982ZHDNM=;
        b=GFjuszb++tqJ1SOHM98IDgp+KRRAAqPVigYdnTcLraHnfv46LSk9Adl6ZtcfUokZpo
         FP3vrfHNQEmrwFt3LpL5zvMB7LsJEKBfAqrVOI6iE5zFY4IGwmJ1dfmbvmNiHl7oqxSM
         vBnsP5m9ag93CgLsVSclvygPWWj2hiT0Uznev4wX61GyM+ewxhPDDjkkKpk29Ne1OUji
         Yggc8TUWZqecN6GlRHE5sUJd+RbV6Fb1pZeO48GjiDPXTyDduM04H5WrZG24ajHao/SH
         jwreV3zBPkHNbRyYaRVYLjfS6l/Y6itl+HJVqSK3/d1EnekT3PDLLV1DTZnB2LIpBlDb
         ZsuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758906814; x=1759511614;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8Jlwkvw2hHQ0c6jPA0PLEUgMv6NDdNMIusq982ZHDNM=;
        b=f944f2gB222GvXBaWyfbFZstzbq3/+oWOtlCK8Opr9LyMawTSMmee60RHmV1/uho9z
         UvEKNb2Sov9WRSMb3OiwAAkf4OQYDfrKZ2shm1NikfZVsNdH/TPw/jrqcvW+pxvTF8rs
         bBzqGseZpzefwdFtE3ytGubXjZBEKVj+rs1HGvej4++rCqZOR7xNQkd3nAK4mtQMt5k8
         OQAxkuCV/Vx28Ml/7fCmpvwmNZRsAhmMvDLksp0Ag2czaDa9Ng5Mv4TVkB4rx/h5DJSv
         tv0EAQr+Pb+GiwXQV4tIMjV+vX3b2SudISxg0IF+ItUUj83kkITiK4cN9sGQut1Auws9
         pw/A==
X-Gm-Message-State: AOJu0Yzb53nHu25kqUp//oDmxGBoZNlSzKw+fTHxx3eCDxUWF6ShUT3j
	tOryYZNetAn6ZnxEevJWtKHM9lO2SMloljhEeBtj5AUNPdyL156YjykL
X-Gm-Gg: ASbGnctu8uaAZs3hfmn5VZOFQpCLt0AMSs/5ynseEGqUr9JTZw/PpKvbYQdjI548RJK
	B3W9A8p0Xv12EFU/m2IHGTvfE/I0Hw8j61KIV7eV326/v2YwaLt9KmNJkuAuOQ85STlPKsLN3dW
	VoL0dMMl/K/tDhs1rTfQgkeCiJ34AnOehoT3Dj7aYvi4W1c1jbd/n6kzsTDd2OT0OxCa8oNr2XJ
	Yo8VYDoOEQp2eaqisj0lxykvyNRJCxXM5QAC137DNrr7P6wJJMRhfWE2KOzFdUmIvn/TTeuncha
	7DBx6EDM9qw2GBJDqGI/ERwChxpvCyx5cH7uLtwPQPi3YGGlQF8K2KAfAgj9/3cs1AGn5xzrW86
	ipksxBChAmrKgjfZnRr6o
X-Google-Smtp-Source: AGHT+IH88cjzmhthBewiZkKuansPR2wNU1nh+zcpF18i/kOdi/b7YACgV0B0jeBwFeyomlAaJSzMEg==
X-Received: by 2002:a17:907:cc95:b0:b35:9192:c804 with SMTP id a640c23a62f3a-b359192cf09mr567013466b.14.1758906813569;
        Fri, 26 Sep 2025 10:13:33 -0700 (PDT)
Received: from [127.0.1.1] ([46.53.240.27])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-b353fa65be9sm397211166b.48.2025.09.26.10.13.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Sep 2025 10:13:33 -0700 (PDT)
From: Dzmitry Sankouski <dsankouski@gmail.com>
Date: Fri, 26 Sep 2025 20:13:26 +0300
Subject: [PATCH v5 1/3] arm64: dts: qcom: sdm845-starqltechn: remove
 (address|size)-cells
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250926-starqltechn-correct_max77705_nodes-v5-1-c6ab35165534@gmail.com>
References: <20250926-starqltechn-correct_max77705_nodes-v5-0-c6ab35165534@gmail.com>
In-Reply-To: <20250926-starqltechn-correct_max77705_nodes-v5-0-c6ab35165534@gmail.com>
To: Chanwoo Choi <cw00.choi@samsung.com>, 
 Krzysztof Kozlowski <krzk@kernel.org>, Lee Jones <lee@kernel.org>, 
 Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, 
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, 
 Dzmitry Sankouski <dsankouski@gmail.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758906810; l=1117;
 i=dsankouski@gmail.com; s=20240619; h=from:subject:message-id;
 bh=KXa+AFXDw/y6DHlre9QjMfUSHSGKMD/6rd68rkDHdP0=;
 b=SXOnelA7RdJU5BQMKjktoe3awmEUR+WqpuLfzcZabL3FWvSZV+Woj77+SVsNVzHfLJaAZRW6c
 eW455L40sc1BH6O5icWizcNkwBY8GSQT1IS5Aw+S1TjnuSXGYgHKuTE
X-Developer-Key: i=dsankouski@gmail.com; a=ed25519;
 pk=YJcXFcN1EWrzBYuiE2yi5Mn6WLn6L1H71J+f7X8fMag=

Drop the unused address/size-cells properties to silence the DT
checker warning:

pmic@66 (maxim,max77705): '#address-cells', '#size-cells' do not
match any of the regexes: '^pinctrl-[0-9]+$'

Fixes: 7a88a931d095 ("arm64: dts: qcom: sdm845-starqltechn: add max77705 PMIC")
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Dzmitry Sankouski <dsankouski@gmail.com>
---
Changes in v3:
- fix commit message to be more clear
---
 arch/arm64/boot/dts/qcom/sdm845-samsung-starqltechn.dts | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sdm845-samsung-starqltechn.dts b/arch/arm64/boot/dts/qcom/sdm845-samsung-starqltechn.dts
index 75a53f0bbebd..45c7aa0f602d 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-samsung-starqltechn.dts
+++ b/arch/arm64/boot/dts/qcom/sdm845-samsung-starqltechn.dts
@@ -606,8 +606,6 @@ pmic@66 {
 		interrupts = <11 IRQ_TYPE_LEVEL_LOW>;
 		pinctrl-0 = <&pmic_int_default>;
 		pinctrl-names = "default";
-		#address-cells = <1>;
-		#size-cells = <0>;
 
 		leds {
 			compatible = "maxim,max77705-rgb";

-- 
2.39.5


