Return-Path: <linux-kernel+bounces-816570-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3963DB57590
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 12:07:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 21CE3200CCE
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 10:07:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D68CA2FC006;
	Mon, 15 Sep 2025 10:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="E65XAi60"
Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com [209.85.221.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9124D2FB0BA
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 10:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757930794; cv=none; b=Gt62nHtB8aBE8UGErXH2VUP8KzXGV0zsBju6FbdfJd2lhD0sZCRZaJzdRsospF2yDjA/EgCGsntrQI3GNo8bpsR9M+zXRK+SglkLuVHbL4YF3emgLKvblxu20OXqcm9Bij6vrrP7cfnveAHJQu6S9vL/KTY87BMJ7SYGDUrYbtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757930794; c=relaxed/simple;
	bh=MDfCdJ5kvasHFOiBfeJtUTsAbDg5HADtacgIr04WlG0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uDTdCNXHmcLkeEZE8oran5T9sAIUUzxY2ec9spMkUAk5m79G85/MijmFBEyGhuLUSIc4mQ1XwzF7PStCAATiy/ycLHobH9QukM6TlLyAuuqEnTnSieeVd2oSZKmAI7Cj63dRXbCpODwpfmnzLpyc9gtNCtipk4OTb/Nue8+lGhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=E65XAi60; arc=none smtp.client-ip=209.85.221.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f67.google.com with SMTP id ffacd0b85a97d-3c46686d1e6so2798678f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 03:06:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757930790; x=1758535590; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D6bLhOy3aQ+nTIsBm75KhRBxHYpZEyRQkCJbrV2nDCs=;
        b=E65XAi60IZKN+J2NYeEbIoFYBoNf3nsKm4jCFH7T1qfsllCB31tNoQtd84rU7okpEJ
         /Ga7m70duJ7emkC2QcDGUFt4mjjWnMZiC12xEIR3qG7uuD9QdpYv959+ZY/jE5aSXa1g
         /jRTu8JTFYuA9HYtTbVg0PBswQ8BTgRsGSiJ8T5yJIjgtNM83TWJhzj6GdmSZ+sLofPP
         0CzcXkMMtx7b/OcjHfT1e1svGhO9yhTlQN0qju0bGtxZvdVht/VMpIWpzumZm5jCitru
         nKITEhANx+de56CMjRU2KbdrFqQnDpSyb3/gLw0eBE3H01QTA1u/HmIeJkfI9qrhDZyY
         P0gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757930790; x=1758535590;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D6bLhOy3aQ+nTIsBm75KhRBxHYpZEyRQkCJbrV2nDCs=;
        b=O+QPuobnIWJt/GzuGj+U72yqcoBMfDGR6+XTM0bOrt2nFG9lZftPgfTbwb6NeY8xOr
         mcT/jF51lTXmYX6Co6vg7cnL8ATOrgDtIpQlTRqJtny5LKj6kSy89XFMzqZjhCmi6r/5
         zq0awAKt8q66/quVUxg76ZJ6yKa5sYViYqkWe21RCPA2ySfItqqc9CJe4Mz4g2BgSi8Q
         kh8MpS+kjBBfNbzvHNO7jLfUunH36PbLZX+zkjD39GEQ40ZPRYRJdZyFC8IFHF0nUUk8
         flv4X5CKnV9IyN510A7gtw0Iz5O6Yhuqg4Av7QUORnUp7INSeCPZx7cgMPW2/gzgVol5
         CgZA==
X-Forwarded-Encrypted: i=1; AJvYcCVn+g06SobC37VRNQkN/d64wk3PNmlzwHr5z7LpZR8AAfDM0kmLChOKrrGef38Xf9VoUU6NsOoqqDJ/A4Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0jYjFK1np7c9Kk9hcVMzPFqX+7leTLT/Zsk2K+Cryq5V7EDGj
	sdXhfJ+oHnh22XV3OBdVfOXbG1/uaS3ock539QRPZ7Bw2kCv8PYxtMp+wjJ7qnpTzgo=
X-Gm-Gg: ASbGncty+oOqCTMIrKQpln/k1Rbq7jy4g0ddr/WBj+WQKJHDZkj5T148BqxouG+kJ8m
	4eNH5/d4FQTyAHEfhI4YQt6oSZf4IGNuaskLQ49SFH4HNdMzghLsSe7vkpm12z4rwUWG7GVkTzh
	EImV54ukHiV7AYHV6g3Mn0szYK/WFp4ce3xc8ih5os7Y+Sfd2M1XSr4d1mkk0LZKA69rGVXuuLB
	b1uiSAEnrsJzX+hbmYo1coMsxdL8Uz61haEU3leykjw6WwAZTZVXqVntQxRgLoHszODFupYwxcb
	s4yplppahK13xDCSspXrByHymmqg1/3ub7iGCyC6AgxWmrtqYEyLddBnc+l+aakxXqY0C2Oz56R
	08cEx6ls2y6zpWoBjGSv2zeAlQk8QYIKvrwX75rbG3hNpkQ==
X-Google-Smtp-Source: AGHT+IHuHMN20CvPkXUvYZTGmiFV3ve4adeDICiqiLAsONuOwCFEVWmW+hAAOekUIPtlXXHNkbcI3A==
X-Received: by 2002:a05:6000:2511:b0:3c9:b8b7:ea4e with SMTP id ffacd0b85a97d-3e7658bb0b9mr8253628f8f.19.1757930789807;
        Mon, 15 Sep 2025 03:06:29 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:2454:ff21:41:eee1:5042:e713:2e9a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e7607cd4cdsm17209127f8f.37.2025.09.15.03.06.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 03:06:29 -0700 (PDT)
From: Stephan Gerhold <stephan.gerhold@linaro.org>
Date: Mon, 15 Sep 2025 12:06:14 +0200
Subject: [PATCH v2 3/9] arm64: dts: qcom: x1-el2: Disable IRIS for now
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250915-x1e-iris-dt-v2-3-1f928de08fd4@linaro.org>
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

The reset and IOMMU management for remoteprocs like IRIS is implemented in
the hypervisor for older targets such as X1E [1]. When booting Linux/KVM
directly in EL2, this functionality is missing and the PAS interface
normally used by IRIS to boot the video firmware is not working.

The Venus driver supports starting the video firmware without using the PAS
interface. The same code also works for X1E when using KVM. However, for
the new IRIS dt-bindings it was decided to avoid using the dummy
"video-firmware" node in the device tree to describe the IOMMU [2].
Discussion is still ongoing how to describe this properly [3].

To avoid regressions when running using KVM, add a TODO in x1-el2.dtso for
now and disable IRIS even when it was enabled by the board.

[1]: https://resources.linaro.org/en/resource/sF8jXifdb9V1mUefdbfafa
[2]: https://lore.kernel.org/r/20250823155349.22344-2-krzysztof.kozlowski@linaro.org/
[3]: https://lore.kernel.org/r/20250819165447.4149674-12-mukesh.ojha@oss.qualcomm.com/

Signed-off-by: Stephan Gerhold <stephan.gerhold@linaro.org>
---
 arch/arm64/boot/dts/qcom/x1-el2.dtso | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/x1-el2.dtso b/arch/arm64/boot/dts/qcom/x1-el2.dtso
index 380441deca65d1b443962fbe6151f4aadd918383..2d1c9151cf1b4aca79f7ad67328ffc3c721b9dc3 100644
--- a/arch/arm64/boot/dts/qcom/x1-el2.dtso
+++ b/arch/arm64/boot/dts/qcom/x1-el2.dtso
@@ -12,6 +12,11 @@ &gpu_zap_shader {
 	status = "disabled";
 };
 
+&iris {
+	/* TODO: Add video-firmware iommus to start IRIS from EL2 */
+	status = "disabled";
+};
+
 /*
  * When running under Gunyah, this IOMMU is controlled by the firmware,
  * however when we take ownership of it in EL2, we need to configure

-- 
2.50.1


