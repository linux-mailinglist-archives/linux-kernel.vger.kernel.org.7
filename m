Return-Path: <linux-kernel+bounces-767079-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 82ACBB24F0B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 18:11:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A423B1B62461
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 16:05:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B69CD29ACF1;
	Wed, 13 Aug 2025 15:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XBbYBjtd"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79BB0291C1E
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 15:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755100791; cv=none; b=YyZkgdVkt2d2X7MPy4POj+YYHClJNXgqBl3aIQd9fwknKOEhQqlDUdn/CXktugqmPs9I7ghRyi7glsXNBfJW/aJDF6jE39wy0b3Ku2qVdDKq7o75VicDAgTlJ9Ie4PwCnaAX5KjR+9+udPdTz8T+BjBDzdkM/iwcxN27uNmYlUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755100791; c=relaxed/simple;
	bh=l3L2yfE27yLL68tGI1MKqrfaMy8Xr8dhr6oWtd8kSXE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Cr/Xk4GJMutd1jzdvkWiKUA4FcKxIPHgzbQcuoEbTOwEaO39qG/l/i8edZ2ycQR0+4YZEr9ETo/CZyWsY3sHafFGm/kvAZNcIebvU1Sh50HwYQr+6t2FZv9pe72ZC6njsp3xyNsSiG8uOZE7RyQtdvQYGuraRW9KnSvSpNR2O3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XBbYBjtd; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-459e3926cbbso29311985e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 08:59:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755100788; x=1755705588; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ilAhY86W6D/mCFE0ccFmIl6uGsK2qfdLyAFl6RSiZEQ=;
        b=XBbYBjtdjsANy9idyCL/VhHEcd6n1szyPg16yexdPfOEm8WLdYGG37DTS9gvXFBDGS
         phps6ZyzxabjuoPiDgYMBLBro+y5s8n5bi+qBr2VILI/13ZV1Z8J56H0rkU+GxPgFg0V
         acIgXC2HKl6z/xEMKMoCAYpp8DGklHYlxwE8mYLMau2lqxPt39ugrjPQ9h3Qig9hq04o
         9VrXXQVUG4duq9CxYO+Ru8Emhwlu0V5KJveeW/i4B06FsRQKbID7rV8B1sTdjK/i3zWS
         po5hRY1T88NIighVeZwk59hPeEe675+dPpGg2ykreSIVjR7BhD3NuWv0rW3l8Mk13Bbm
         ZcsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755100788; x=1755705588;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ilAhY86W6D/mCFE0ccFmIl6uGsK2qfdLyAFl6RSiZEQ=;
        b=recoss03u8v6FqqYECKCjgnqers/XBCJavuXMumnX/1lIsK/G73RW+ZFX66GH/xsg2
         ZFjVIG4sZWcD6FWkHAwCcJmVPfBHa0YPcuEMl8kqnPu5OQXmN/8H1hR5RKiaaZmhLdco
         SxFD0mXeh56hjGJg0oJynf/VxSKJ31EoE5kZZ0Sbpdyhu7eXz+zEV6lKSajIfILODJ5l
         4lMPlrZXupzIKFvHNtGU58jTOBgBIAp9MyuPO3RbGbk+ZGvWvNU9JoIUN+Z6SHh1nxAH
         pD9hanDS7zccHenIu18hAptEbsOHzDTYs39zEW3BMPf6LhuXY5lV+7qjU7EkYvtT7ggo
         gvTA==
X-Forwarded-Encrypted: i=1; AJvYcCWlX/oZy6iG3RiNy2b2da502qN2NFt8GZ2qVirMJDubPDIR2BHgDCorwjCK2R5BSqIx80M5EoEautmi6GU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyj8Zi4xvvs+kLPMxxi6gN+A4BGEd1EKL/z7NUvC9XFmiCLhFS8
	X94g+qziCSOpnrGYhJ2RZuJpT0ubSFvHyBJhOA/kvxGm4Ky9/6wEnTPMmcbjEmrbMZo=
X-Gm-Gg: ASbGncspHql8Tq115Ts5RzHYlF1i3JqbRIC+KTSssP7fJAV/G5fRyWbRTEA4cbo4q2c
	gwc+PoSWTqmju4MQUuLKdQn1OIKA6F/LrzcdGVTx+eZUvFGWhEU7zbK02Jz78tzayfmJIXjM0HD
	6gkZHcGyEDzTU9M+Gcz2pW3CfFYVyHoqrkUIw/TIvVmx2vY7/sAF2fvv45lL1NCB0sStIDTN/WV
	avb9OwgO486kRYxDcehmvR6Hg+6yRUPFlcb5fduhQyINGwIJA2MPiPlctj/+eFSBwyEsf2KLJj3
	1Vhuw0urxEdNgoJpuE8CCEl/ke6SXqZJOJ/EMarO1Ew5JrJ30senrNNHBh9Tojgx97+CoPY+BjF
	e9QiQiOKW9vuIl68aZKFIP6Ct+aBvgwhhZk8AQg==
X-Google-Smtp-Source: AGHT+IFgRJXQP7h2ypmOmygvb//roZOZXvSuj5BEnjvYNBIjrGkAeA47av9q7BT/h/81tPwAMfHUNA==
X-Received: by 2002:a05:600c:1390:b0:458:bf0a:6049 with SMTP id 5b1f17b1804b1-45a165dc915mr30627565e9.20.1755100787752;
        Wed, 13 Aug 2025 08:59:47 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:2454:ff21:ef41:4537:5d58:c08d:204b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45a1a517c26sm7087755e9.7.2025.08.13.08.59.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 08:59:47 -0700 (PDT)
From: Stephan Gerhold <stephan.gerhold@linaro.org>
Date: Wed, 13 Aug 2025 17:58:58 +0200
Subject: [PATCH 1/9] arm64: dts: qcom: x1-asus-zenbook-a14: Explicitly
 enable used audio codecs
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250813-x1e80100-disable-audio-codecs-v1-1-af82d9576f80@linaro.org>
References: <20250813-x1e80100-disable-audio-codecs-v1-0-af82d9576f80@linaro.org>
In-Reply-To: <20250813-x1e80100-disable-audio-codecs-v1-0-af82d9576f80@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Abel Vesa <abel.vesa@linaro.org>, 
 Johan Hovold <johan@kernel.org>
X-Mailer: b4 0.14.2

Currently, the macro audio codecs are enabled by default in x1e80100.dtsi.
However, they do not probe without the ADSP remoteproc, which is disabled
by default. Also, not all boards make use of all the audio codecs, e.g.
there are several boards with just two speakers. In this case, the
&lpass_wsa2macro is not used.

In preparation of disabling the audio codecs by default in x1e80100.dtsi,
add the missing status lines to explicitly enable the used audio codecs.

Signed-off-by: Stephan Gerhold <stephan.gerhold@linaro.org>
---
 arch/arm64/boot/dts/qcom/x1-asus-zenbook-a14.dtsi | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/x1-asus-zenbook-a14.dtsi b/arch/arm64/boot/dts/qcom/x1-asus-zenbook-a14.dtsi
index 16d045cf64c08c02c420787e000f4f45cfc2c6ff..9e6dd0bb527a3b11f9e09d498f3ccc117d52fd0f 100644
--- a/arch/arm64/boot/dts/qcom/x1-asus-zenbook-a14.dtsi
+++ b/arch/arm64/boot/dts/qcom/x1-asus-zenbook-a14.dtsi
@@ -958,7 +958,13 @@ keyboard@15 {
 	};
 };
 
+&lpass_rxmacro {
+	status = "okay";
+};
+
 &lpass_tlmm {
+	status = "okay";
+
 	spkr_01_sd_n_active: spkr-01-sd-n-active-state {
 		pins = "gpio12";
 		function = "gpio";
@@ -968,12 +974,22 @@ spkr_01_sd_n_active: spkr-01-sd-n-active-state {
 	};
 };
 
+&lpass_txmacro {
+	status = "okay";
+};
+
 &lpass_vamacro {
 	pinctrl-0 = <&dmic01_default>;
 	pinctrl-names = "default";
 
 	vdd-micb-supply = <&vreg_l1b_1p8>;
 	qcom,dmic-sample-rate = <4800000>;
+
+	status = "okay";
+};
+
+&lpass_wsamacro {
+	status = "okay";
 };
 
 &mdss {

-- 
2.50.1


