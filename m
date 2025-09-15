Return-Path: <linux-kernel+bounces-816575-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD6ADB5759C
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 12:08:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 76D7617F5CC
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 10:08:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D3F32FD7A4;
	Mon, 15 Sep 2025 10:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mwVaMN+O"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1D0A2FC876
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 10:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757930799; cv=none; b=D/8SNzpjncqR4IWP9Ez48Tjml72q2Gi0bnC83mieA2ecTbUfQUMq5dJBmfsuDJoNYQPHS3zrnxKYYNOq9BSFQZPtex1y5xSKvTYni1VibJuA8Yo/5og42CNLemlqWvBcoDMSh394pCPlRnxWaRH6vgsZZwFlsFO5FF2X+U8lVpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757930799; c=relaxed/simple;
	bh=8Enp+Mkl2UxqpACVzNToxnoA6OxpULssI+bvEQ0Nf4U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Tdk36EW9Uo41U2JS+pn7MDeUvGQKINk9cfVPEpZEiDDQSbsZB/QYqzR8XarROEZDcQ2dAgSgILyR7g3oRTzGc11N3yQmP8gX5hBoY6dCW9wSR9pRvA6QPYCRgvdv6eMtlfXn1L++PaGGUk6Zi1Fw3bL1+KPYFTd67tHoV978Xno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mwVaMN+O; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3e4b5aee522so2394676f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 03:06:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757930796; x=1758535596; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aMJ/RBwT6mg+UjxGTL74eJG4QUt2rz+S26/sAVei4C0=;
        b=mwVaMN+O7JQojI5YqTtmPbLUEgRTHwx7+kjEd4Hk26ECRuVMtOrUAwNtl23nqe7RZU
         1hJ108f9SK0/8xqBaMN7vnA03bygmzYGVkOZl+dEgIZPgp1CpJjw9gR60pHJruSVjUkJ
         6AnAUkcJcmKDMqh1/OAsNdsXDmxIM21IVgACFPzkU6aNcGokJO3PeHwjGmmUGSMbL0qa
         +Y98Lf3dUAAcQZHPPq+bhvpmMKmqO5XLzeJ+ULPAmkxtdNUe1CmsSE1YVUY6E+FqBml+
         +4H0TCRgnq3gaqNfLEJ4HX8BRRhL//svw3QCw3WFB6E8C0KlHAv7dgpHU8GOUGD1Zosy
         V1+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757930796; x=1758535596;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aMJ/RBwT6mg+UjxGTL74eJG4QUt2rz+S26/sAVei4C0=;
        b=CiJwwhOsT2km468NxK2AYIbT+oNQVfkETodgActQG1yX9X0j7Sy4W1q7s2SY8K7a28
         VEsK6WY6KaqyTCfERTjlME/EKI8vv+DbYQfG3ursq8Q1jLXlnPBtvT0r05iRYQWVGPGm
         U1AiAhJCf5gXG1+vKkB+Q9t2eOKg62RlE+y53FK/3sY8a/2BsWG46oNKDzSsBs3r3J9O
         +m5Cx1kMRSz6y8K58vtlV+gU2qTyHhlcByb/M8NOKWiNAtQzDW+KfDSKLHdLuh1R5ooU
         0z1gjsStvTjWYsjJ+svVPcBWqDT+zOTkKCjf++R/mM4VYK+4/r4VlaUN519ul++fgIdN
         6rCw==
X-Forwarded-Encrypted: i=1; AJvYcCUELx1aXMRhV/f3hxhOF1jkotcuCUnWzrgOizlxJq/6sjJd7fRZ8f6uSV2K2x6vw0q4g6PCWCdlXGuKubw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzScsbA7dL1qzwJ6ur07k9zbXZbwrmZPRZNb67JhdqGmJTUFDO3
	tZRzIXPB/NfaH2e3SMuJEBD97w6ngnP1z9EPJqzq3YlDlN24zBe6K/Hxv/sm9pPw6jE=
X-Gm-Gg: ASbGncvUA/C4c4IitX5ZCW1YxatYpKotBx7TEczLCactlnfU1I+d8ZlRDlnwTs6MeDq
	famVkeCPg5/YGF+qWmdy7r4IkEFdgS0GNGccFEZojXV2Knvij87j5DZjLnzNY0IE+O4n+KIPvCK
	nXOoS9cxzXJGTJKu0LoGjeqO6UpW/DYbiF35pmA3RagmUV10ro/dGLNXsl/fP9ggvF7TDN+rhUQ
	e1dJlzhcxmUrT+B8D2+kADv0JhZMQ5SF8N3HZvZl7h0GgZy6wN0RMrucOOP5w4tn60Vfr2GjaoH
	hrFhhGXBCt0+hrx2Q5nn2mG/Z1rYS/ibD9vPKahI1fnjcMHt2qonmqU8sjZlXrbiU7hq3bdBad3
	bEmuKIBN6HA6Z9Jv3ma92U4Jd+p89sWAWdXvLcUZMr8uJOA==
X-Google-Smtp-Source: AGHT+IGAYfNbairUcoKCWSDsEU5WSecLpPfBO1ydBVHA7jvKLsoeowirgMHHx11PlHl8N8clREqLbQ==
X-Received: by 2002:a05:6000:2509:b0:3e2:fd26:10f0 with SMTP id ffacd0b85a97d-3e765594128mr11920512f8f.11.1757930795969;
        Mon, 15 Sep 2025 03:06:35 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:2454:ff21:41:eee1:5042:e713:2e9a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e7607cd4cdsm17209127f8f.37.2025.09.15.03.06.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 03:06:35 -0700 (PDT)
From: Stephan Gerhold <stephan.gerhold@linaro.org>
Date: Mon, 15 Sep 2025 12:06:20 +0200
Subject: [PATCH v2 9/9] arm64: dts: qcom: x1e80100-dell-xps13-9345: Enable
 IRIS
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250915-x1e-iris-dt-v2-9-1f928de08fd4@linaro.org>
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

Enable IRIS to allow using the hardware-accelerated video codecs. The
firmware is not upstream in linux-firmware yet, so users need to copy it
from Windows to qcom/x1e80100/dell/xps13-9345/qcvss8380.mbn (just like
GPU/ADSP/CDSP firmware).

Signed-off-by: Stephan Gerhold <stephan.gerhold@linaro.org>
---
 arch/arm64/boot/dts/qcom/x1e80100-dell-xps13-9345.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/x1e80100-dell-xps13-9345.dts b/arch/arm64/boot/dts/qcom/x1e80100-dell-xps13-9345.dts
index 19a2604038a88f37e6ab87129a6318db78345339..58f8caaa7258077d2c267048ca048279109ddb71 100644
--- a/arch/arm64/boot/dts/qcom/x1e80100-dell-xps13-9345.dts
+++ b/arch/arm64/boot/dts/qcom/x1e80100-dell-xps13-9345.dts
@@ -875,6 +875,11 @@ touchpad@2c {
 	};
 };
 
+&iris {
+	firmware-name = "qcom/x1e80100/dell/xps13-9345/qcvss8380.mbn";
+	status = "okay";
+};
+
 &mdss {
 	status = "okay";
 };

-- 
2.50.1


