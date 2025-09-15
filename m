Return-Path: <linux-kernel+bounces-816571-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 905C2B57591
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 12:07:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AAE351AA0814
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 10:07:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B6692FC02D;
	Mon, 15 Sep 2025 10:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vm76JxYn"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D80B2FB62A
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 10:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757930795; cv=none; b=H0kIAvDwAkjXfoHMTM6k6l5mtxCEQ1u7ccgQWdcXdfE7M4UhKQOUJAhmXf2QNqHXpG4Q+OcPWnQtSonx/I47wyC32jsl0cPusPNehx7OVHKZsAicUlkJv8Uxq1QPwbWJ4IbmBwNg+9SaDa9HpQGH6L983XGoepxsNXUM0QxDYmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757930795; c=relaxed/simple;
	bh=lPVsvFsNhFfkyen8EiuPo58L2CyLDTz7q3IsZ3ltpEo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cXPpWXAWSGCwsY0QgqX4MN2+Y0ZZJVsjfIwz6syz/5EN+ErFDFz7W8mCo5BQEJ3OoNC/rEcylIG+DdwXxVt110SEkWqm/PJoIVqepZsZSjOmHfC7h/xmCB+4XXPL6bcDCeNxlCDeR5IFqd0+evVmzzVAttEQKxUb+Rgcprfx0iY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vm76JxYn; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3e98c5adbbeso555175f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 03:06:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757930792; x=1758535592; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0P9I5GceZCsWfYioaUyTdRDDyk+XfjON/ECPS4nrgn0=;
        b=vm76JxYnxaZsGSldFk50TYjaHuqnLVr0e4G9ThCDq8LE8BjvXCRi/HxX/lXRd4s2CV
         lMMroxq0UmQWndz8vJFRqamPLgMh31BAp2y/poP31c5LFQasuYm7VIoTvk4P376VLvsb
         CAucuWVrtt0UUhsGWiPScWnuyQrQOxzn1nW+TDeekV4+NATyP1/+2rYUBW0n3DZ9XwxA
         8fdawHod8lG8l46d2hRH/EPzxpN8qmUYmkw1q4pVnL59y/sksZ1x4GAUE+VSC10SaOy2
         u28PEn4PU9gaTzxyQydQUrs2YGn01E0mr5XkXIj4PqjKInTX+A/BYezbJudwFt6hhO8S
         JAWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757930792; x=1758535592;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0P9I5GceZCsWfYioaUyTdRDDyk+XfjON/ECPS4nrgn0=;
        b=UQRQ2a6jjUsiF+ex4su+KAMs1663j9u59ReJz54uCb8OTxiTNvPj6NUSvfoMqGSiYN
         7Gmdexr5BzcI7ncBz6UkgeYWm8j1BJ6lUlrMhhfTzEfqXQ+Chiqo1aqAHqoNaS1nVymq
         kmEP9oD5es3wiFdcnzA91t7ltbwcJgrMsIBooFwn0JpAOKiR70Ktci0RoZbnVW8Ydkml
         +ufLLrQ1B1mJEflWftFSN/DPH+nN+zP/GNqERKqzz6PfIUtFeWqqwbP2WDxFHbuQpxWP
         0LC3kWGCz3daR+Uc/C7+Kx2iaSImqjZYeP1EpEYFkvFC9W7oDFKywLAyj6/qZJTx4vLl
         4hVg==
X-Forwarded-Encrypted: i=1; AJvYcCU9psYuxEh6W3nZw91DzP4xYwtCF31MkbjZA2IGkqrA+3mz/GxmPWssoCFdtzh20Hr0URx71CUVGmqee/w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6jnH33+F1uxg36wyKUirtpBeoZJYydwde8sv9Xwbajk3W6sM0
	Git96jEBdmXEK1G1giD8DAlB4YDOmid5laPuKqGTX/BuX5dM7wVRvaytxWBAZk94ZwU=
X-Gm-Gg: ASbGncsEq7x4hVfOlOmDIjSIjjBgGMTeM9sHF81K9fAXgAeBiouXcPgqwyYN1ymaP9N
	iJv35R9+T/HIx0BjcEOYIetOtsoxwgG9n3cewoBcJ0+SjR8Vd6ctqro2jdkJoyhDzkhvqUgyR6Z
	DliglhLnYr5mdcYVKA0J/kRTwII5q/z/TIxZujgmfpsOeU3RlgltUf8BxKF13LtuWXumLoNxy+k
	2iqRINi5OeHPM4x2z6tf68Ymz9BgMz2R+79Pg3WfT6oVxD8bAJj0yRPT8NuzWrfjoL4aJ4anOmu
	MupKtI9qEA5TL5ApfnA3qkE+Qvd1iaNkDUJ+je+pCbm0BWnv0KG0HkM0EplyJwKJ5VlXciuP7gm
	v+gKBJ/AObVqXxP7Abaxdk7YCxe8xs6U0acnj6+hzxtyPpZJ0KDHXOrai
X-Google-Smtp-Source: AGHT+IENWQx+UcTcrrly0QwCzyfPQCRYOIixkTX1wJC/Ai5bWPg14xN9tzDlmLGksLlVWk3hcK94eA==
X-Received: by 2002:a05:6000:144a:b0:3ea:a496:9b8c with SMTP id ffacd0b85a97d-3eaa4969f1fmr3260601f8f.45.1757930791820;
        Mon, 15 Sep 2025 03:06:31 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:2454:ff21:41:eee1:5042:e713:2e9a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e7607cd4cdsm17209127f8f.37.2025.09.15.03.06.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 03:06:31 -0700 (PDT)
From: Stephan Gerhold <stephan.gerhold@linaro.org>
Date: Mon, 15 Sep 2025 12:06:16 +0200
Subject: [PATCH v2 5/9] arm64: dts: qcom: x1e78100-lenovo-thinkpad-t14s:
 Enable IRIS
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250915-x1e-iris-dt-v2-5-1f928de08fd4@linaro.org>
References: <20250915-x1e-iris-dt-v2-0-1f928de08fd4@linaro.org>
In-Reply-To: <20250915-x1e-iris-dt-v2-0-1f928de08fd4@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>, 
 Vikash Garodia <vikash.garodia@oss.qualcomm.com>, 
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Alexey Klimov <alexey.klimov@linaro.org>, 
 Anthony Ruhier <aruhier@mailbox.org>, 
 Stefan Schmidt <stefan.schmidt@linaro.org>
X-Mailer: b4 0.14.2

IRIS firmware for the Lenovo ThinkPad T14s is already upstream in
linux-firmware at qcom/x1e80100/LENOVO/21N1/qcvss8380.mbn, so enable IRIS
for the T14s with the corresponding firmware-name property.

Tested-by: Neil Armstrong <neil.armstrong@linaro.org> # on Thinkpad T14S OLED
Signed-off-by: Stephan Gerhold <stephan.gerhold@linaro.org>
---
 arch/arm64/boot/dts/qcom/x1e78100-lenovo-thinkpad-t14s.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/x1e78100-lenovo-thinkpad-t14s.dtsi b/arch/arm64/boot/dts/qcom/x1e78100-lenovo-thinkpad-t14s.dtsi
index 23213b0d9582822e9503e4acf18c62d5c8c7867d..0a989e9d3d23146cb9689b68ba6c5779283b3c98 100644
--- a/arch/arm64/boot/dts/qcom/x1e78100-lenovo-thinkpad-t14s.dtsi
+++ b/arch/arm64/boot/dts/qcom/x1e78100-lenovo-thinkpad-t14s.dtsi
@@ -967,6 +967,11 @@ touchscreen@10 {
 	/* TODO: second-sourced touchscreen @ 0x41 */
 };
 
+&iris {
+	firmware-name = "qcom/x1e80100/LENOVO/21N1/qcvss8380.mbn";
+	status = "okay";
+};
+
 &lpass_tlmm {
 	spkr_01_sd_n_active: spkr-01-sd-n-active-state {
 		pins = "gpio12";

-- 
2.50.1


