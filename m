Return-Path: <linux-kernel+bounces-816573-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B21AB57599
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 12:08:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1035B3BF202
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 10:08:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 987882FD1B2;
	Mon, 15 Sep 2025 10:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hzF6fvmq"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6AC52FC032
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 10:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757930798; cv=none; b=UQ7YcMVn4yxuwQTAfOmwthEFW0ot7exzYiDZJXBGQ8Ki5rNgMZQxCemfZ9b94ttNmaQYN/EBJcz4/WE/2h5Rhmv0n/+gHzVq59nXls9M7rYH7+vnT8h1ENCfnx2w8k3uIRwN6IOzeQ3eowbLB+mnTbVE0aw/EkpnILs0jkwiewA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757930798; c=relaxed/simple;
	bh=hJIwkiz9sypHEiHD79ZpOaAj0rAaVF4u0ldF0tcXL3c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=S5WZQflZlUa0cfcwKjC6MAJ8L6TcGttkQAPkFQehSmEZWO8wEYVOLh2wpWm8zDiZAvUCHnevYxGhOsjcoyDw8CZM0avgPpHL579NMUx7h1f5zUKgCgoJuqQBJMO+3Xd7ySF4ivmPNGztNzOyYuAUXICe/MEufdv4ticHDmLLtm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hzF6fvmq; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3e92ce28278so1148358f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 03:06:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757930795; x=1758535595; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eGHFxRjJDleNewjPVp65zuO30fhwOTH80zSHnSHmwac=;
        b=hzF6fvmq27vDWGU1sWwnEn0bqwSoD/YumqTGOuCIbGO6ieR9iAe9mOITX16KuAdyZJ
         S0pVS6WVzDm2dDoUJcJYyiAo+KLBYsRN4JsSnWuqrwDlOrh4CJzTBxPhSDK8xdOs6TcA
         6Pr3aMQnzd9fBbTJJShAN7NIvbQIDn+inR5Pjg5Jotl2o/EFsSilnKrmfHyhX2vqoyPl
         Jtlz0H7tKuBF4RcQruhXT3R7DRyeO5JAdlmwfSwGxC2BKjvXRhwb+Q2a8shblJ1uvKjC
         hjgB76HRqnphp1NxtRUW5MLO03gMDDcq6CAEGNupPrK/NGuZukJdirfmrkHzJhd1upke
         Fl4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757930795; x=1758535595;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eGHFxRjJDleNewjPVp65zuO30fhwOTH80zSHnSHmwac=;
        b=Qa8AD5t9A4DqRowgUeXGdZ5MRTXRsW6CqLviJ/3Px0j+amJBikWU4glEn9iro6EvMN
         fKYPuU5cp9p/EMPHiNXrMPz95fwVUoDHJYKBJsTY12n3XegCfXCnCu/7UiaxKZ87AtsL
         d3At1/pKL2pusY0lRxrIxX6tdKzp9ZbGKSjKcByF6LhJxFESWUxP3AE4RxPpvLNq5s0m
         j2DwWLSORZgVCJrvvaJc/kDSsLZmOtGqFX53q/FrhipjJ04DONroJBRT97wBBr0fZqMG
         VAX1bLX0fYBErCKRS6YCsYxe3U7iTgsrGFuWlCEQaDltV2IQZwEr49FdKE9d3VX783Bs
         BnDA==
X-Forwarded-Encrypted: i=1; AJvYcCWIHjna9G3oMyZ3TR7oymTQQoAgalnIrWZ9NfN6AdYBqNqUgrSPhiQIpZ25mC070R1qAbfm8OnypshKCTo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKucf8hFtmObmAYz5AQJSNmU+C1weDy4enB6YqhW6u+hpxf8Si
	4fOYhyCYrEOR+QAoKmiZqFau2KarNZOCYoXSmAQNZ1mGR8eRVfbH7yv78GrJ0bnVRNY=
X-Gm-Gg: ASbGnctFF3j9AlfLM8P/vANGQh+Mv9YbiNtDhUXXGDJ044jrMU5DVNXmLJLCQufxBkK
	PdOr3VVKrquVKfkad/j1Qj+g+qDzv/9V6i24KlTYuxb081qCUjf10lTlEkEyGbucE4cBbh/FG26
	0+M2B1LuGX2/3vjbGTfvXqNSc8TNOGKywIyGSpO0mtZNlzw1yE6yhP4TZwoq3l/sq1ue3DPG1bk
	vbEb2hpsVEBhS1Qha8Qi/aDzJtQa5cD1VM5cNz2vurUvbJ/fDLNAvXpDbwwjaay4ZNGLpVft/gH
	YBJsjlw9e9yKF2yObHVl86AmDAMG4qT8gar5BouZMPcxsF4PW8QXlHoseH64SbVmKaE3yTDvMua
	4tTbcHt5cL+hxVo5xRgHRsf8b8AFnm8uElOs=
X-Google-Smtp-Source: AGHT+IElgrSVID5upnr61Jr9QDLifzP3jmV2135LUHdvrrOdgcUm13X1jm52Z1V6i5ZQyQaHDlAhTA==
X-Received: by 2002:a05:6000:1884:b0:3ea:9042:e69d with SMTP id ffacd0b85a97d-3ea9042ec43mr3268023f8f.17.1757930794918;
        Mon, 15 Sep 2025 03:06:34 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:2454:ff21:41:eee1:5042:e713:2e9a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e7607cd4cdsm17209127f8f.37.2025.09.15.03.06.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 03:06:34 -0700 (PDT)
From: Stephan Gerhold <stephan.gerhold@linaro.org>
Date: Mon, 15 Sep 2025 12:06:19 +0200
Subject: [PATCH v2 8/9] arm64: dts: qcom: x1e80100-dell-latitude-7455:
 Enable IRIS
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250915-x1e-iris-dt-v2-8-1f928de08fd4@linaro.org>
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
from Windows to qcom/x1e80100/dell/latitude-7455/qcvss8380.mbn (just like
GPU/ADSP/CDSP firmware).

Signed-off-by: Stephan Gerhold <stephan.gerhold@linaro.org>
---
 arch/arm64/boot/dts/qcom/x1e80100-dell-latitude-7455.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/x1e80100-dell-latitude-7455.dts b/arch/arm64/boot/dts/qcom/x1e80100-dell-latitude-7455.dts
index ace2a905e4430d6cd1db59e9a9fb7441f7fe0aa9..32ad9679550efce1fda1182bd874d6a3c53d8f03 100644
--- a/arch/arm64/boot/dts/qcom/x1e80100-dell-latitude-7455.dts
+++ b/arch/arm64/boot/dts/qcom/x1e80100-dell-latitude-7455.dts
@@ -38,6 +38,11 @@ touchscreen@9 {
 	};
 };
 
+&iris {
+	firmware-name = "qcom/x1e80100/dell/latitude-7455/qcvss8380.mbn";
+	status = "okay";
+};
+
 &remoteproc_adsp {
 	firmware-name = "qcom/x1e80100/dell/latitude-7455/qcadsp8380.mbn",
 			"qcom/x1e80100/dell/latitude-7455/adsp_dtbs.elf";

-- 
2.50.1


