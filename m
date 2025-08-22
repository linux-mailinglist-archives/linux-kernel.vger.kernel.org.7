Return-Path: <linux-kernel+bounces-781519-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F611B3136E
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 11:38:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE59C1CC190D
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 09:35:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 806F92FC001;
	Fri, 22 Aug 2025 09:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SBx4KPp7"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13FDE2FABF0
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 09:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755854957; cv=none; b=axFLoXdgYh4w2qrWGvK331ftuHC6QmkutO51jIMmV/eem3h/nvFOtY5iivNnYlx6DFR3fILtILB+/uiKrmoLW1R2F93nO0EoMI9uv/AHTwNrKxAaSyuEPvyCO13kh+oM/3j9oYYTgA2F0RsFwl6MpkxJPFb+x6f2l44DfkPPH6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755854957; c=relaxed/simple;
	bh=QUt0+UycE3l2L7m5spe6S0KqFj7nRto3yM8Pu7JHGtQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QsPRLM+KbOkFRWwRXllKE8Q6coywYyyRoajiXrpH3BulLhsmB8HF5+5sHloEFicXUo2FQEuAAxXYdBJUh1UyZcFw8SlNEvxVzRPU2zMe8ktMILZEdMtU8BaKCqZ9Y1cE7XnkkspZwVaHYhvTNZHeltgdxhq+6+zB6yhtygfXNig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SBx4KPp7; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-45a1b066b5eso10027305e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 02:29:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755854954; x=1756459754; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=482U6L1exn0T0v/WP+eBHc4UYIMx1Rf/qRIRSNFyPxM=;
        b=SBx4KPp7ybUy5U/MY0d/Ug7czgPB5ZwifJ2LugC2hdVvvsulzZENrNYy58wFID/sXa
         sLWuqLPL9f/d48rtqIGuBPaKrWEQ7dYn2sddbv1BwKXRQQlVEXxN0/11QpioAKqxZ3Ch
         CYJPo6ECNLeU0lXPuHvRZk9UCR2/PMsxnUO0Bl1F4ZzYk65UL9r4cQn3MnxVoviVzkId
         o5gCWDBCx0pvAB9wbdwzR2WJcq/wEQZHJZgRVehTxNpwZkSC8PyfT0zaONs8xRrWZFV6
         bHl2KJR2+xZ1NO4ljMUcGYtgILXnmBgycr91oqurmhz1jdZl9jfD/zSyX6rWumrQJDDC
         x7Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755854954; x=1756459754;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=482U6L1exn0T0v/WP+eBHc4UYIMx1Rf/qRIRSNFyPxM=;
        b=Lao0zsY8lMfJO6C3zQ8aseapTylhWeiemQeUrUx28x7Y77bpkGc4JMdEkBTFuXElcB
         bruGFVHCdUKPN7coLDA4CX5Niz3SzdMKxyh06MlDEI4I1UyJtK2yH9wijf+K9OkZP0mj
         pZcjWFfDQOtnZ38bgpXQ97AL+oVrXJsy0MfPb8htLgUjUxddLqwcSgnM/LVAivrZDLRA
         b75SCR0Llmp6xddWqtOF+/XMgLfLnIbO3aWU0ZMhZ8ZHhYcKkzBgQGxRZacSopeD4DuE
         RyUC6GKfq19C81d4Evz9WgEYMbk19s6LbbV7GCFOhfEhXMf1Nb1mP2jqZDsaY0G6VmRW
         QQXw==
X-Forwarded-Encrypted: i=1; AJvYcCV8ZgfRMuF7P56kTIyy9PbojHgAOHnM5T6Wlm/xWEbXcWFisdRrf9aH+kiP6Ek8fh8WJKE3pF2g2FL8PPY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzH6ZXulDjvhcxKgMunIp3ditWwqAb9LyIe3tsv3pbxuMkw8iZ+
	egLrsaq1JytJP5aKKnBcjeUVtCQZNC4u+y5vFlWSwT0lrqa8DnysJAW0bL4VlPLdGso=
X-Gm-Gg: ASbGnctQ83lpybPprdg6EVKmyeEsVBj2euKR/6qXNk5GeceSshsbNKnCoMC0ZUhNd9y
	uviTT0+AoKatlV1M3yoRKvzCCY/AMICZw5emAWGZlOS8R6jmJA5gc89t6nh4NJhe2cm2WDqsQZj
	yYMwsUtQY/AL84fSKZMMdv4rXXof/AIY/8nyUV0QH42zbQPy/j1PUAejjbZHskkVcGfoPpC7uOi
	jtXiaj8mg2o/OzbYQrNnssjmMTeLIVqJFObVOhu27KohBawNrMCLsh0h6G0rYgxNKK9rxPY8zeM
	Z5p5UTmx0dwJUNpu4II6qnmo8GCGHhNhUKdQ9LZtluPvaF3HlGP0EcKtwCpAB3qgQEEN72oflyt
	BVOxOYl8TTQXkZLlwSoE1SH2K4x1rpbM3JuWnznaBsKMfLhXp
X-Google-Smtp-Source: AGHT+IF8rG+HAdadk8FJZFHlMphapIz/vjkTDpBbGV2hMvAIFg2h5HlIyowXYUWst12d1VIrhFQpvg==
X-Received: by 2002:a05:6000:2313:b0:3c3:c280:d42e with SMTP id ffacd0b85a97d-3c5da83be09mr1291521f8f.1.1755854954298;
        Fri, 22 Aug 2025 02:29:14 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:2454:ff21:ef41:c671:531c:f2ff:2a7a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b4e269d20sm33831805e9.2.2025.08.22.02.29.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Aug 2025 02:29:13 -0700 (PDT)
From: Stephan Gerhold <stephan.gerhold@linaro.org>
Date: Fri, 22 Aug 2025 11:29:01 +0200
Subject: [PATCH v2 10/10] arm64: dts: qcom: x1e80100-qcp: Add missing
 pinctrl for eDP HPD
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250822-x1e80100-add-edp-hpd-v2-10-6310176239a6@linaro.org>
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
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
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

Fixes: f9a9c11471da ("arm64: dts: qcom: x1e80100-qcp: Enable more support")
Signed-off-by: Stephan Gerhold <stephan.gerhold@linaro.org>
---
 arch/arm64/boot/dts/qcom/x1e80100-qcp.dts | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/x1e80100-qcp.dts b/arch/arm64/boot/dts/qcom/x1e80100-qcp.dts
index 9369b76c668b5c008fefd85d5ca18e87ab9ce93f..ef9bb7dac9193a44e3086ca370350b816744f41a 100644
--- a/arch/arm64/boot/dts/qcom/x1e80100-qcp.dts
+++ b/arch/arm64/boot/dts/qcom/x1e80100-qcp.dts
@@ -915,6 +915,9 @@ &mdss_dp2_out {
 &mdss_dp3 {
 	/delete-property/ #sound-dai-cells;
 
+	pinctrl-0 = <&edp0_hpd_default>;
+	pinctrl-names = "default";
+
 	status = "okay";
 
 	aux-bus {

-- 
2.50.1


