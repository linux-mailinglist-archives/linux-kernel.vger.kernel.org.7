Return-Path: <linux-kernel+bounces-753423-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 470E5B182C3
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 15:51:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 724E71892829
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 13:51:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EDA9261594;
	Fri,  1 Aug 2025 13:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="nKaSLAKa"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75DD63BB48
	for <linux-kernel@vger.kernel.org>; Fri,  1 Aug 2025 13:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754056280; cv=none; b=DRjqNYUuBDJjgjdonXJr9YlDsyb/+gyT1PAjPvldMAmkZEcQG1jhaUFBT2xkK7uih4FA7GQhKwzMusb+2OgYgSi1tx1l+nI4USUX7o0jHeviqv5uokVYjxWhw+WYzb5F4zy1+umtLNUGHlHqNqjCCOJss4aH0I9yaoxnM9KcXIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754056280; c=relaxed/simple;
	bh=JudYny6kBruCccLSRGWfz/S4vITgCZdf4XwkLcThTDg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=i+YxNB1MM57KHSQXhIGREKwNgL5PixINqL66XHd4uUPf39TuZAcjcAqRcU6MYQ9ocqQ6XrNSamAOxLlUbzH2Ysc0bXGcnj2sa3CnuF4ZwvKs6gyaxbhJIqJ7DtRO6WwqPTwzcwni/MbC9OeRKzYjUkLgO/9yRhG3BoHWLn/hmCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=nKaSLAKa; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-615460d9897so2076516a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Aug 2025 06:51:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1754056277; x=1754661077; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yRU4l4Sw6RdeJzWq0D61GWcuC/cS97qBUpLaGPLulU0=;
        b=nKaSLAKadUWP5t81RjH7ejebC94uAz771+t8t0DMbwxAVizfGFR6aTPbulOhDGh1O3
         AFSVSQQUjSwpuD+4XGR/hJ57Z/RIoDtoidD6aSdOfnDmC5TFYn47sbS0mkz7fs3gmzAQ
         e/n7HKJu1pxvdbeBDi8H4o7wo/wQK1HnrFV99r6ygSVZw3F5/gJf4DyEPbSn/GA4Osnc
         Gn8YlJ85FLSEWv0cXehYXDocz2S5kB9f2MnbmZpdJIsJA6NHmiKSBAosQNZSgX3UZM1G
         0VYbTly7Wsrla1xjEXgoKu2hW3VlUg1rv3xG44NGxXqpiJiGJKdg25lgx2sZVGniT+pp
         zmpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754056277; x=1754661077;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yRU4l4Sw6RdeJzWq0D61GWcuC/cS97qBUpLaGPLulU0=;
        b=Es9ip13qmAtr8EYEGivjBOLkZtYVhH1lVn1EtrlM1vNnnr49PcdG3IgcWbCS2PsCxf
         G8ALN1fovDQLMihEc10I39fxHg1U40I0rCmFzWqLLNi9lrWmsDoQSBa0xhsSz46WVYqM
         KZH7IXgeML1CyTWDqeOKOH6bP7t3rPBWJI76aT8r8UYPFPN4Rq4Hy+9TF6JPYboImy40
         ql0llrkzI5u5nxOovYew9udVHdJygqsgM967pu0Le9zoKMvfSWO59xEc/uhNZ8w40sPt
         VgWCifynoAHotlKmebBrK67FJ/UPOOdgFzlm9p9A2hTgTyXE/oUmofKYpNPHbAi8VydI
         QFaA==
X-Forwarded-Encrypted: i=1; AJvYcCUA5tpwR8zgT5WbozaNMiLYv6rx3z8lEYu5OyWjb4PE35b+V/PABlbCm5mhncWecmc/3DFG404TFgV7VSI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpYJgkIQiwPATWYXx8izwAqwh8k8OQDBSONNWKb7Bqnm+JuPG6
	r3/lDyiKAvV4qPeNbtimKj4LsFw+zVj0ZHclxwORK4hDoBi7vUUKqF1z6abqVnFsfUY=
X-Gm-Gg: ASbGnctxxg/Er7NUQ+NHhStUQkb5LCaROjud8HW2NPl1KrNdqs5JDbKKUvK7Cs/yJzW
	YMpktEsndzZylROhD2gBzZkIrulAqYxqiL0tBTQxbs1Xdwf+OaKY1PU2Y/Qo2jSyV90YpKI4ApW
	yeuRse9AeSk24puEDvCy/Xoj8pWM+OD2+ll2ZQuvsavG0iPyMu2zYBOT6b6g8gR3Mh9Me8C15EE
	t7Z0waxOpgdYlWnOiODKxPk2J3RkJWRAv0al2SxwYWfoXKreL9tao1scevSdk8NdUOWI/oJ2AzW
	xz13rL4VzB5XxRdXxSjfnEB2+I6UWKySHncxa2CckxPk3WUBZS9d8J30Klnc69EhtaBjv98mmRs
	fh3fTrJYDpDbJYOtatGAvuOQX7Xzd3DIbfx+zKz8gtwExrN8cNuaZ73tUFsOCsIdQz4Dd
X-Google-Smtp-Source: AGHT+IHsNin0LaTapE/cQ8nw7WgEaAB2R5RTFTn3HmuVmcLJmorV7ASz1XrMUgnFIN8XyzvCDFy+VQ==
X-Received: by 2002:a17:907:3e90:b0:ae3:64e8:8c5c with SMTP id a640c23a62f3a-af93178b217mr318476666b.14.1754056276770;
        Fri, 01 Aug 2025 06:51:16 -0700 (PDT)
Received: from otso.local (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af92a2ec9cbsm180542266b.79.2025.08.01.06.51.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Aug 2025 06:51:16 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Fri, 01 Aug 2025 15:51:05 +0200
Subject: [PATCH 1/2] arm64: dts: qcom: sc7280: Add q6usbdai node
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250801-fp5-usb-audio-offload-v1-1-240fc213d3d3@fairphone.com>
References: <20250801-fp5-usb-audio-offload-v1-0-240fc213d3d3@fairphone.com>
In-Reply-To: <20250801-fp5-usb-audio-offload-v1-0-240fc213d3d3@fairphone.com>
To: cros-qcom-dts-watchers@chromium.org, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Wesley Cheng <quic_wcheng@quicinc.com>, 
 Stephan Gerhold <stephan.gerhold@linaro.org>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Luca Weiss <luca.weiss@fairphone.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1754056275; l=1417;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=JudYny6kBruCccLSRGWfz/S4vITgCZdf4XwkLcThTDg=;
 b=EPg4WORZqO1tKwYbyn0LirBb/S4J+sjSIlWlU+3BTiOKGNu2bZokPrA/phAA3z8K45iDFZZ1M
 Mi13ywosVR2Bg21Meg86lEwlgG+4kq6jO7mH1bvBMmJwNZv+lumwQai
X-Developer-Key: i=luca.weiss@fairphone.com; a=ed25519;
 pk=O1aw+AAust5lEmgrNJ1Bs7PTY0fEsJm+mdkjExA69q8=

Add a node for q6usb which handles USB audio offloading, allowing to
play audio via a USB-C headset with lower power consumption and enabling
some other features.

We also need to set num-hc-interrupters for the dwc3 for the q6usb to be
able to use its sideband interrupter.

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 arch/arm64/boot/dts/qcom/sc7280.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
index 64a2abd3010018e94eb50c534a509d6b4cf2473b..c019f58d2f438f23b4be2e879ecd78850e3df1ef 100644
--- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
@@ -3862,6 +3862,13 @@ q6afecc: clock-controller {
 							compatible = "qcom,q6afe-clocks";
 							#clock-cells = <2>;
 						};
+
+						q6usbdai: usbd {
+							compatible = "qcom,q6usb";
+							iommus = <&apps_smmu 0x180f 0x0>;
+							#sound-dai-cells = <1>;
+							qcom,usb-audio-intr-idx = /bits/ 16 <2>;
+						};
 					};
 
 					q6asm: service@7 {
@@ -4303,6 +4310,7 @@ usb_1_dwc3: usb@a600000 {
 				reg = <0 0x0a600000 0 0xe000>;
 				interrupts = <GIC_SPI 133 IRQ_TYPE_LEVEL_HIGH>;
 				iommus = <&apps_smmu 0xe0 0x0>;
+				num-hc-interrupters = /bits/ 16 <3>;
 				snps,dis_u2_susphy_quirk;
 				snps,dis_enblslpm_quirk;
 				snps,parkmode-disable-ss-quirk;

-- 
2.50.1


