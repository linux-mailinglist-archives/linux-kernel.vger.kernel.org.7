Return-Path: <linux-kernel+bounces-767082-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 644F9B24F1F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 18:13:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9AD2580001
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 16:05:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7F222BD003;
	Wed, 13 Aug 2025 15:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IXlw7xUA"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDBCF299A87
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 15:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755100794; cv=none; b=l9hYE8pXnd+BLmXwUaOypKKvKQXloyLCzZhcwr2IdfU+uPzIIhR40NCLU6tmRqtPlPfCkfhXukaJvBos3wYtQ4xr6RCJ6YJH8868MitgujZf5ghO0kFPN3FnSNp6kWebeoMZOP+hG5/yRuJ6+WJRZG8K0xDxTLCAuJJm15Npb70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755100794; c=relaxed/simple;
	bh=BJacCqalYuhTrgJ6z+lyprAGp2ZxuB+c08EcKO9oezw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cQpf0+55e3mDc5ISrJbtW02uOmQxh9L+jt0Y2M6sddFR2t5ebLPEzlUTLnxEwccG9/DHDOfpy7VSogwO2oYaLOWRXRV4KIkfXSkoqKXXGq97ZjYcx2ywlP2QA5NwFma5ho0+kckM9FmltfnekH32/fd8oQu8IP2nr2Z5m4zFS+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IXlw7xUA; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4563cfac2d2so58908505e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 08:59:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755100790; x=1755705590; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hflNaXmnDmYKGXSSuXmMvcjUzpmt1x6X6QV1FeYHqQc=;
        b=IXlw7xUA2Q9iHS/OLdpohKsscOduB7bIYYDciRBHIMli0wu5LhxNr5sckMojQPyd4G
         JxR9tYkQ+14SaHBUIq836RU8R2ZVPECGwvqVNY71a9ezP7Gy0XgRppkPUqZICCiaNjOG
         PBCtlAI8wrjfCtsPhaEVIdhERpPYw8tNNZzcWfGOqNOlclaQC98weDGNu6xAHHxOhU1l
         fgUwxWDMBC2e7jQPacCJzN657o+2okrvols94IOmdqPwARR0vLMaXnWr2fThUJBxOed/
         yXonYw4eYxgbA0Kf/HBEXPFkp8DxVYRuzKDQRUCifiKEMKIBkSQTLoJd9aQRDu8jG2J2
         o8Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755100790; x=1755705590;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hflNaXmnDmYKGXSSuXmMvcjUzpmt1x6X6QV1FeYHqQc=;
        b=KRhWAuIPcWgmS70vDd7p2bIn5oV8JvRjFnicfuvOq1lXAmqpKjeXuJgtidpBt2iM0l
         yqJINMgO8fuw5jkaBdUMU+dPeL+14cdWykktLCNodcBG1qpSFdyFqKWtuQGINi3lNGaE
         iENeFD1UQYaqG9U318Y9f0qhA2QbhN5AoPvZ23SLaywvKnLaoPq7JZWNt2bjA7eQf9UU
         XhcguhsTvdMQP7ZGCm0b3FrjvY8g2szcZ2I8z+utUNzlwIiLzBgMAdXnoFRBtVkRwaL2
         rlCpAH8Bk/5w1c/0dumYRIwOjGZwBa4RfFt9UbOJpdULM8HWeRipdxxP9nbszZwE6vmI
         vXJA==
X-Forwarded-Encrypted: i=1; AJvYcCUFdmZjZadonYH5bqytWmtbuq2AUdsuCRP5XQuNVTgz+2KCaBaybzKnrF+C3jpZWYGW6/HgDY4A9f/m8cA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJYGtyJZqUoJN5VdzbzXOwZx2YWVQjBd4EBrzdb5Dgp8Mbf91o
	WeKXRKh1hg1EX/iErky5d5smDGhwJw3VicADVcPH3qIu1QeynxObMWtHIUC3FLPgiUA=
X-Gm-Gg: ASbGncvAB/5ebitnFMg73wDx5NqIzDT7su/7cIG/CnBH0Gyb0/xXUk1dTHhBceczFto
	hpvaLWftMMLZsYMUQJdmf56TZZhMZnXv4DQquP+NYMgMd2lB2/E9yXIuZ8VgG//qdygFlEdhFtY
	XU4aO/ep9jyoCYEmfVXOT8G7WMb4g6yNwrqAdLWiFGFv6z9/qygnsc78TLuzowT44+7RPf9jo0J
	bxuVUZ3IhbVp97Jb0MYePiYo6WbRlERs56Fm1q+C8XelisTHLk0kVfnfYABtFUyx7HSK71SYRcp
	vyM0Hgd/1Jp3D4hrB6ZKEOs0eht5TLKG/PGAD0RAcwP/bRSgIvVPgYjNhG+a5yz/Te14wleysyY
	9aUpuNSY6J1ERubgcH18UNKgDcjZ/I2mpbYrDDQ==
X-Google-Smtp-Source: AGHT+IHxYDkUcEsCLbIRyFMqaOkoGUJMUYCdTh55vftfsZFEQiSSGKWq1Gxa6ZrB4wY4xUh/ZJMJeQ==
X-Received: by 2002:a05:600c:1553:b0:459:df25:b839 with SMTP id 5b1f17b1804b1-45a165f7ea6mr27766545e9.33.1755100789993;
        Wed, 13 Aug 2025 08:59:49 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:2454:ff21:ef41:4537:5d58:c08d:204b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45a1a517c26sm7087755e9.7.2025.08.13.08.59.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 08:59:49 -0700 (PDT)
From: Stephan Gerhold <stephan.gerhold@linaro.org>
Date: Wed, 13 Aug 2025 17:59:00 +0200
Subject: [PATCH 3/9] arm64: dts: qcom: x1e001de-devkit: Explicitly enable
 used audio codecs
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250813-x1e80100-disable-audio-codecs-v1-3-af82d9576f80@linaro.org>
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
 arch/arm64/boot/dts/qcom/x1e001de-devkit.dts | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/x1e001de-devkit.dts b/arch/arm64/boot/dts/qcom/x1e001de-devkit.dts
index 2d9627e6c7983daedba87619ba01074ee22b43c9..636264e130b7d4c82cfe7d8a24508cec20ff997d 100644
--- a/arch/arm64/boot/dts/qcom/x1e001de-devkit.dts
+++ b/arch/arm64/boot/dts/qcom/x1e001de-devkit.dts
@@ -974,6 +974,19 @@ retimer_ss1_con_sbu_out: endpoint {
 	};
 };
 
+&lpass_rxmacro {
+	status = "okay";
+};
+
+&lpass_txmacro {
+	status = "okay";
+};
+
+&lpass_vamacro {
+	/* Not directly used yet, but needed for fsgen by all other macros */
+	status = "okay";
+};
+
 &mdss {
 	status = "okay";
 };

-- 
2.50.1


