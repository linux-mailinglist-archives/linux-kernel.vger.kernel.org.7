Return-Path: <linux-kernel+bounces-816567-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15830B57587
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 12:07:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EFDF816D6F0
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 10:06:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87ED72FB629;
	Mon, 15 Sep 2025 10:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JQUFde59"
Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com [209.85.221.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A0DF2FA0F7
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 10:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757930792; cv=none; b=VQ/4kQd1f8tIJ7VGEud1x0PSApuSygxIka5oFH0a0MA9yVtdaA1nJaoOkxpoNXQ2oyHE1s4jPR8/3DfEIjRAyyQmGc6onuotDgWX1B2WrcvYeXT8dqrkNy9wXbGDm15VZc1RdCzi2HYrlpILvRyJ+AQp8na4UGbzTQUNzhs9cwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757930792; c=relaxed/simple;
	bh=JGji80klp66rQ1832BdwwUkhaAHryTM7+UK4ivqtNEo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Z/KP+UbUyionH/zDGZ1ZnuawgUukXcHPnPVPCMynX9oRiO3hH26UZyJUXS7vjbyRURKkfexoXtWCYw0xfUygiuSGmClCWFJFnUG6T7HM1FIEncpcdPvLdcysHS7ZQGahv4+6hRxlnb/lDRZ/jVXUJy99//mn97a0p4o+uYxP06w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JQUFde59; arc=none smtp.client-ip=209.85.221.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f65.google.com with SMTP id ffacd0b85a97d-3e9ca387425so963870f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 03:06:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757930788; x=1758535588; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n4Cu4jlvHGZG1vrYyhNaU7JIiE6KW6coiFWmDAcYM9U=;
        b=JQUFde59EFvsCQv44yM8jP7K/oIjndF9OWalr1ntEfx+Kb/L/u36AResdJSS8NQEYy
         9XQp8nm5RC0DZVMzSHzRQBZ0L7SAM1dlJxUntVAFbpSFqKVhMZN79m9QN8vraD9aGcFD
         IwGg1S6aCUgL/KRiJjZ+WjF4IoEv2Zgi4Bym4pN98NT2ae9EHG4ibAwfUxo8c4OgH2zX
         m8yedkQg+gKam5owHdJ+QejhcV+fe7VdP7ZpPjdPIZTt6OLMwLN02C2XeLVkDoTgYyjL
         n8GKkQEZuzyr0R0snpe5vYVraSsqv8FvBXloRFqyiYG7F8NFOVg0oR1jG0vPWmrIx3nn
         DUlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757930788; x=1758535588;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n4Cu4jlvHGZG1vrYyhNaU7JIiE6KW6coiFWmDAcYM9U=;
        b=fv9+tvKqmShMwgNLkJP1s5rpJOn7OXqWqD2GeqZLk36wC48nAWNv3WlXl7+I7D24ex
         UFIjO+GwE4+Ofb2tzIbp4lTHQxnuVNKbZ2rYsELR/8CJg1jWPO+8FKG36/c8KjP8v/TO
         GL+Uv6HzJfBzSqFMtqKzXD4NfpZobtxZ9zMAXZb1DK4taoHiuil1NsJeEQ/+0fpaZKic
         K0ZDesiWZcNG0XZ9Yu5+MogO/m6JZJqjvIFERa2hpHDSEst7p2jhvKTx4DTJVH/UaYZy
         ePeHSiOfmxql1mhDHDjz44TsrezcgxHfw7fJG5u4tEDgUdSK/rmLVmiZMhD/96az218K
         Tkkw==
X-Forwarded-Encrypted: i=1; AJvYcCV1HW8oIYeWxfgPBqqK/S/TNyp2AmzdKWEjZuE+BweJXWDBXSYUP189NMat3ojqNMQL/7bV+1j/n8Hm4cE=@vger.kernel.org
X-Gm-Message-State: AOJu0YybytrSRuRQd13G0VmN2aGedS39qB4ohcAPEz483FxcfyqRoyX/
	DndlnZ5HYtf88CjoZpt4MNkwUOPABtgFaJ0AQ78TBPfjmyTgoMUzxNAiultOJ4V/OA0=
X-Gm-Gg: ASbGncu6SdpERIJfP5MlqV3wa1HdDduUlaejAZKUXDfFbI++2Qf/4OPTcwbIAryLIXO
	60QZCKGhwhKWLuXamdWDSdeSmnHTdF+PdLignH5AqbSGb+0gThEIgq71ArE5Ty+qNNiEN5MVqh6
	2fhJrawJN0QCVfFLTLIb03CEQU7zQoL5U2S/iRKdxAdd5Nvw2AZ0McQEN9WMIrhz0+82GThbYGk
	iS53V7QkzohZNd3t0yW2j86fcXLuVOaE1klgO/Fm1a76VB+Jy5i/34vNgHTtthnhQw2DuX3OhJq
	Flb3WiHjBuQJLcVY2lf23C+MhnlkBXoWdLV2+OnRq0ssIPc6HgvDT7UamJ/TU/sO4EcnmbfIly9
	2F2sOFAfw3SU9GuWYTfcZJuE8lG3L2e2mzrk=
X-Google-Smtp-Source: AGHT+IFkAq8ub1X/dEEk4zZSV1ran2kYTxb2Dm/pCgwgP6bhwW+o2v6NIDlWFlb++BMsIuWvSvu+ug==
X-Received: by 2002:adf:a1ce:0:b0:3e9:4fe4:2632 with SMTP id ffacd0b85a97d-3e94fe45e49mr3763503f8f.46.1757930787745;
        Mon, 15 Sep 2025 03:06:27 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:2454:ff21:41:eee1:5042:e713:2e9a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e7607cd4cdsm17209127f8f.37.2025.09.15.03.06.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 03:06:27 -0700 (PDT)
From: Stephan Gerhold <stephan.gerhold@linaro.org>
Date: Mon, 15 Sep 2025 12:06:12 +0200
Subject: [PATCH v2 1/9] arm64: dts: qcom: sm8550/sm8650: Fix typo in IRIS
 comment
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250915-x1e-iris-dt-v2-1-1f928de08fd4@linaro.org>
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

It should be "enable on boards", not "enable in boards".

Reported-by: Alexey Klimov <alexey.klimov@linaro.org>
Closes: https://lore.kernel.org/r/DCQ8G73ISXHC.3V03MOGB6NDZE@linaro.org/
Signed-off-by: Stephan Gerhold <stephan.gerhold@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8550.dtsi | 2 +-
 arch/arm64/boot/dts/qcom/sm8650.dtsi | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8550.dtsi b/arch/arm64/boot/dts/qcom/sm8550.dtsi
index 2df6ba05e0cddaebf3d35a4b4b8e5cbb9048dfb1..ec67efd64b78673352c4c6e3a4e7e504d4525b46 100644
--- a/arch/arm64/boot/dts/qcom/sm8550.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8550.dtsi
@@ -3262,7 +3262,7 @@ &config_noc SLAVE_VENUS_CFG QCOM_ICC_TAG_ACTIVE_ONLY>,
 
 			/*
 			 * IRIS firmware is signed by vendors, only
-			 * enable in boards where the proper signed firmware
+			 * enable on boards where the proper signed firmware
 			 * is available.
 			 */
 			status = "disabled";
diff --git a/arch/arm64/boot/dts/qcom/sm8650.dtsi b/arch/arm64/boot/dts/qcom/sm8650.dtsi
index 367f448a743a306993b40f6c6b8a23a816744afb..e7582a19184b48de66d572d6e98fbf2f36a8c17f 100644
--- a/arch/arm64/boot/dts/qcom/sm8650.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8650.dtsi
@@ -5186,7 +5186,7 @@ &config_noc SLAVE_VENUS_CFG QCOM_ICC_TAG_ACTIVE_ONLY>,
 
 			/*
 			 * IRIS firmware is signed by vendors, only
-			 * enable in boards where the proper signed firmware
+			 * enable on boards where the proper signed firmware
 			 * is available.
 			 */
 			status = "disabled";

-- 
2.50.1


