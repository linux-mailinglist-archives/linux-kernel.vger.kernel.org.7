Return-Path: <linux-kernel+bounces-781514-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D8AA2B31363
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 11:38:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB1CF5C2496
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 09:33:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A73502F8BC4;
	Fri, 22 Aug 2025 09:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="r84JfSyT"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A55DF2EFD9C
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 09:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755854952; cv=none; b=hGgw1gmEsrues5McWOfhsSzZFb+zizG+eYtezWZ62b9FmQYMGq7V23Uk2olFyKPKZEpHipCs6o0leL8iUniDbUKI2eAUyeTAxdwAsg3KdmZfqTEWRTXVQaPzy/Dc91g4yZ0yOpmsn5dwsTQjqbxLGW1wC5szp6OT3tytm43htAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755854952; c=relaxed/simple;
	bh=OV9NBEGNmZ2rTXWu+yVDHywWCMLATKrBxMJPKNHdUCk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UnvyH01igvlBGAsGJQNmwQZ1yrbuGyOJkf18Mi2GL2pxNDCp2kvf+ZUkjdsI0rgV/VGm4GYPE0DKvwd40Z0D4WBuwc/AQ3sqOOLz5eY1W1lfW7VixC5fB9l/8xKY5kg5nsbiX+OjluYdQHFfDenC3MIgG4LVcO16G0pjTCXEPYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=r84JfSyT; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-45a1b066b5eso10026805e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 02:29:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755854949; x=1756459749; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9XDvtosqXE1z2B0OghG2EJFFbUf7Y1I7x1P5I2TiCM4=;
        b=r84JfSyTRiBJoBe4Q+d3trl10l49CRVVnmmnwU4WxGhiNdFoJactGuK5ERrfe1XoEh
         RDpf4GOkYQ9B2KT7pQR/JhV+cCDh1kems6z9EkNcjLlPDI4jg9vNPAOphBFdo6hhpCtu
         dlQWl8+LpG/fL8L29f/Vxb+GfooUvLlBmy4HQU6YepoX1ib3MToqNB+K5thdJNN06q0B
         OSIIcC9vGXO6mbfhQZ5lzYuhH3fdKHnk/co/ozT+yRyvygsCFrY7fAMgYZIVumvA0YeS
         31sG9w2uZVZFWbLZWiZwURU9fR6VqKVa4KbquIRQe/TEoKQP1MDIO175OPHmUBIXDcsl
         dpFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755854949; x=1756459749;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9XDvtosqXE1z2B0OghG2EJFFbUf7Y1I7x1P5I2TiCM4=;
        b=szBOwvqIKPpQ9y3YGZU+mUBeCFYWiRaPD5xBoGOhfz08c2T1KxriFTRNZxILVBkuWo
         lS9YZ9ei/Cz+MSw19bge58bAGENk0UbVOTwkv98bl4Fn4tnRc9Ddx7yb1yuavfnicVQW
         zdckmNGi3/HHK2UIVS1uGS8DQYASw9yhm5n0x5omFHB4hhT57GhgmeBJK6YkkdHY2l6T
         QTvj0grH3LWRf6Z1kpQFSy5j6sBFtLvc9rUlasfZjGqW6hlrYHFGQjIONV4yuS5VAdGD
         PJSHeGhLXSf461RRw8LSmR/q6SNVKYZFO33Nd/p7OuA1RxEXx3nyh1HoHh5/ct4RwjV2
         urtg==
X-Forwarded-Encrypted: i=1; AJvYcCWk2WW9nuM4NQVGFjTKnFLiypMCHjCc85rJOFqVWKhrrUQrD0bZb2BbWfWAPOQPcM8PjaxFcV81AxYHk4A=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywo56KAnQHq03K/xuYcxdnbbVaN1EVt9bNkKGX1ZclSdpFZIxiJ
	LutMsjsNrRYWridqJnZoVv/h/A13EeR9HvM/3tq4zD7QGIPvY6B7CifQoL/vgBPP0y4=
X-Gm-Gg: ASbGncuhdza+Wv9HAeAwDrKo0MLceNbmWFXTDwuKBJAO71pAQLB4VjbZ6k+tvzrkWSB
	TOgKaRX3cckJNWTbruveGD+P1B7kq/YneaI6CPjGBCWnFKog4PfzWZczLM5kRwhFMASlLUTnack
	YzVKPzVZdjMMsX574JuGVtN4XUBJE9lYEY/NA+2qMWuzNWqreSv/MwTc7kbKBz4uPt3SvVycnBk
	ZvnBm6SOpjp5ePy+q04PFRYvEsSUPMTNdIK8q2sHU3WbAugPSn5H+ah3cJlL3VpSNY9puNNTSCd
	8MbePjRz1Rklfu3f8B4jJiSI1HFb3j71MnE+V2+EQhPvWeNcnQtykwQeIj1S0T3i5s4Ia0cDMFC
	9ko38iI4g9JlaHV4qCp8TRFuAUpX1/n8xfM8XnFdt5VJOaucF
X-Google-Smtp-Source: AGHT+IHExVmgqlSBDTxp3UBEsiithGY1ASjzeGyFWNQHJP3V6k3TURzkBS3Q8Xdh3G4H3SMgsocWjQ==
X-Received: by 2002:a05:600c:4692:b0:456:1514:5b04 with SMTP id 5b1f17b1804b1-45b517b9636mr17657205e9.21.1755854948985;
        Fri, 22 Aug 2025 02:29:08 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:2454:ff21:ef41:c671:531c:f2ff:2a7a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b4e269d20sm33831805e9.2.2025.08.22.02.29.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Aug 2025 02:29:08 -0700 (PDT)
From: Stephan Gerhold <stephan.gerhold@linaro.org>
Date: Fri, 22 Aug 2025 11:28:56 +0200
Subject: [PATCH v2 05/10] arm64: dts: qcom: x1e80100-asus-vivobook-s15: Add
 missing pinctrl for eDP HPD
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250822-x1e80100-add-edp-hpd-v2-5-6310176239a6@linaro.org>
References: <20250822-x1e80100-add-edp-hpd-v2-0-6310176239a6@linaro.org>
In-Reply-To: <20250822-x1e80100-add-edp-hpd-v2-0-6310176239a6@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Aleksandrs Vinarskis <alex.vinarskis@gmail.com>, 
 Abel Vesa <abel.vesa@linaro.org>, Xilin Wu <wuxilin123@gmail.com>, 
 Jens Glathe <jens.glathe@oldschoolsolutions.biz>, 
 Srinivas Kandagatla <srini@kernel.org>, 
 Sibi Sankar <quic_sibis@quicinc.com>, 
 Rajendra Nayak <quic_rjendra@quicinc.com>, linux-arm-msm@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Johan Hovold <johan@kernel.org>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
 Maud Spierings <maud_spierings@hotmail.com>
X-Mailer: b4 0.14.2

At the moment, we indirectly rely on the boot firmware to set up the
pinctrl for the eDP HPD line coming from the internal display. If the boot
firmware does not configure the display (e.g. because a different display
is selected for output in the UEFI settings), then the display fails to
come up and there are several errors in the kernel log:

 [drm:dpu_encoder_phys_vid_wait_for_commit_done:544] [dpu error]vblank timeout: 80020041
 [drm:dpu_kms_wait_for_commit_done:524] [dpu error]wait for commit done returned -110
 [drm:dpu_encoder_frame_done_timeout:2715] [dpu error]enc40 frame done timeout
 ...

Fix this by adding the missing pinctrl for gpio119 (func1/edp0_hot and
bias-disable according to the ACPI DSDT), which is defined as
&edp0_hpd_default template in x1e80100.dtsi.

Fixes: d0e2f8f62dff ("arm64: dts: qcom: Add device tree for ASUS Vivobook S 15")
Tested-by: Maud Spierings <maud_spierings@hotmail.com>
Signed-off-by: Stephan Gerhold <stephan.gerhold@linaro.org>
---
 arch/arm64/boot/dts/qcom/x1e80100-asus-vivobook-s15.dts | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/x1e80100-asus-vivobook-s15.dts b/arch/arm64/boot/dts/qcom/x1e80100-asus-vivobook-s15.dts
index 62eba17cdc87c088ca471b4cbf5b44af06400fe4..7de191d2aa5ee8d32b20e3617f1ec7cb938bdbde 100644
--- a/arch/arm64/boot/dts/qcom/x1e80100-asus-vivobook-s15.dts
+++ b/arch/arm64/boot/dts/qcom/x1e80100-asus-vivobook-s15.dts
@@ -593,6 +593,9 @@ &mdss {
 &mdss_dp3 {
 	/delete-property/ #sound-dai-cells;
 
+	pinctrl-0 = <&edp0_hpd_default>;
+	pinctrl-names = "default";
+
 	status = "okay";
 
 	aux-bus {

-- 
2.50.1


