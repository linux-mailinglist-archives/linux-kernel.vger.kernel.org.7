Return-Path: <linux-kernel+bounces-833103-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A955BA13A3
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 21:39:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 048ED3BCFE7
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 19:39:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39EC431D727;
	Thu, 25 Sep 2025 19:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MtTqC3ZG"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDD5A31D389
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 19:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758829127; cv=none; b=pJVYppDa4bJ1qb/4us9URECINdDEM6jnhdIhx970JkrMfMhnoM/c9ivTx+iV1YO6ZMdfiVGojPUUK9r+CScroDdSGoIqhA9qzjTRIPnd9qfB53l9K6Fq+U2iF0+Nsn/iZdWC1dceOh5GaXPEfcUrMyG5b68436JcxZQXrQ4VYjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758829127; c=relaxed/simple;
	bh=KXa+AFXDw/y6DHlre9QjMfUSHSGKMD/6rd68rkDHdP0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=A/gFCobgO4ez0rwF2+4VnZ4XIP1bzDMCjn0BrO5ZenRPBXhd5SHSdvmhQrC/YHUScv8S3QM6xD3C0yy5wEsUBYF0w4/78I4jRumTkQB7sbbRCJWY3p+L+kam4IGGwwhiCLdvD6AMIgo7P/gnRBZ/5dk7kxuwUhQuH1buujs2j+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MtTqC3ZG; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-634a3327ff7so2352226a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 12:38:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758829124; x=1759433924; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8Jlwkvw2hHQ0c6jPA0PLEUgMv6NDdNMIusq982ZHDNM=;
        b=MtTqC3ZGe47h+ES8f4kxv9pkHZbvCYmqrNUyyUc6ahThPv0/Fth9xmBQkTx1DmcmyH
         QaDJZe3EkJa/n6SHyQF/zACgaJsJHA0+XDbHIwNhn70p1ksYLIvyouWOuH0iap/cLJwI
         UrIT9yTs3qpgi5lNrcDZmMebUwXZLElrpqR0dz7sdTKOxG41HobCsToiehMTkvsBPCb5
         4k6ncL9QRl59fukBGLvvLGvV7wziM5E13jdhRCxKJyDPVGQ9P1odIbBJtb/v/zHyJmv6
         mO9szkdVbx5uXgwpF+kYqh6/O+4NPiyaG2+3bAwoHHO/m1m0ULFFyPoSxCe6NpzoOLwj
         MA/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758829124; x=1759433924;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8Jlwkvw2hHQ0c6jPA0PLEUgMv6NDdNMIusq982ZHDNM=;
        b=jp+Xpe6p9Q3yJSTNusIh2xBEUpEeDzvZgA3VoJsvbftGXXtSAPIDXEmoGil9J4mi9p
         KFqm0fnXiazVXXxjb3mndd8pb3EyP4TpRVZGGP1XtFFozmEnEZ/RRWR/RQG5IwjU2UaS
         AW2lVg73rgx5WAsMJreVzKdx86EKK+rxurgXYl3e5g2YkHmk5uZeb2UEnX66+ftQtUJK
         nBzoGKX8Nv+5bxOA+VwvkDmzGGfRLIuEKEdlSwTVqYyeMwi905838AZKibTMzHn1+vxE
         DUtR3Jzc9r8ObDDx3Dtq+HADtmM1XoCTEQl1m2fY2pQmW2lxJ5xSQyU9rDVnpVkpM3lo
         k0Sg==
X-Gm-Message-State: AOJu0YyqSZN7FkjNO6oyFNDpv19MtrVH0Y+0W6/qWlu3DvlpRX3WQIGx
	vX1dXwd/pftB/+Xy9RsXdPoWo/aK637yqf0To3DqYUet2hVJZBMYg3mn
X-Gm-Gg: ASbGncugfZmMDkflFu0jdSTlnkJRSCh2dRtDY3b9pHBAS7zEpk0hqhyM7DLu07YVv2H
	7YjBbHk5NTDnrWGkAGu28eQDTcSz1oxHz47fhCtAlncK8WEsEuuhnJDj3YJHCLRdvEKYxpghauP
	OBrhOLhAWSnK2Nix9n3tE9ukfL82vaQtLAqgyBmWhgq1939ONBP/N4yDx4XJ5/awlxCcbWN43tY
	rTm3zlpZFgfrz/5rqX7ptK8RU0Auy/GpbcE+/J9t0jN1GiSYX0aG0jH3mJwstvqaePJzg1jqes6
	DEgzxYAoFc2ZpkVSQmBPRFg4q95i5kG1asWx/S2b6lp5jt0fDjorb7nBK3Ve20SqwbgywId+Gx0
	ACkcfNIS1SNIh5U/l1KKL
X-Google-Smtp-Source: AGHT+IE/AaRt1vZleBpFFE3medxviv+3SYFioXoNmY8V7mFPoWlo3WX6Ptu1q7ZNQcHZ67UMce6drA==
X-Received: by 2002:a17:907:3fa0:b0:b04:9ad9:5b29 with SMTP id a640c23a62f3a-b34bbbda59cmr574770666b.54.1758829123783;
        Thu, 25 Sep 2025 12:38:43 -0700 (PDT)
Received: from [127.0.1.1] ([46.53.240.27])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-b353efa4c35sm222820766b.26.2025.09.25.12.38.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 12:38:43 -0700 (PDT)
From: Dzmitry Sankouski <dsankouski@gmail.com>
Date: Thu, 25 Sep 2025 22:38:37 +0300
Subject: [PATCH v4 1/3] arm64: dts: qcom: sdm845-starqltechn: remove
 (address|size)-cells
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250925-starqltechn-correct_max77705_nodes-v4-1-93b706bdda58@gmail.com>
References: <20250925-starqltechn-correct_max77705_nodes-v4-0-93b706bdda58@gmail.com>
In-Reply-To: <20250925-starqltechn-correct_max77705_nodes-v4-0-93b706bdda58@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758829121; l=1117;
 i=dsankouski@gmail.com; s=20240619; h=from:subject:message-id;
 bh=KXa+AFXDw/y6DHlre9QjMfUSHSGKMD/6rd68rkDHdP0=;
 b=bpUKBonuQTiw6W5tHeMIp7Q+/7Horigpbdl0sRLCD9vNiky4QvgMaUU/9bvUwsjju3IVXsSPH
 GWtwRWc27zADRDje7xMZ2G+JM0MGt2fQZVXXr0ujoEA/CYhEJCDA/Vz
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


