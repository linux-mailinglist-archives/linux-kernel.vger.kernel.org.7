Return-Path: <linux-kernel+bounces-830795-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13698B9A8BB
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 17:15:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CC35B7A65AE
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 15:13:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86CF430C62A;
	Wed, 24 Sep 2025 15:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lmQ1Uc64"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D2CE30C622
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 15:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758726923; cv=none; b=ntkxYTwaubCHvjdPA896ifYUkxA48sCy89NvoBbuy2WRJp4A8DipPxauNed0e6hp7kNbhT7NepBA9YYif99CZu0dBPU5EaCnG6Ne9K1fpJZoVRCfewLNN8h0LCPVRL6g5aj77VKTanZw/d/MMiEQG2r6NcvsUPvH2uYUFYPKWoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758726923; c=relaxed/simple;
	bh=JmsEgZMHNR2hZ1IS9otwlJdT37DqVFuKcq466eHfWkM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Y25eHd5oE08nuE39Xg2F2YM6W9Wk5qhgCHjHsDHIi9ZcBjsttERQUl/pc06Ya5RjckBHZWmd0Dq8HJ2Qf6hyKAr1WRUJnO/KCkbd4bnypIlHvHJZHX6TwKR1j13tRRNichRbzBidQH+KRqpciYH9OH4SBwdcdydb0p7sNDMGVuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lmQ1Uc64; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3b9edf4cf6cso6342384f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 08:15:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1758726920; x=1759331720; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KVqkCRaMXNKzpuB5REQUDEUQfJMrsFYNkn+7shJjr5E=;
        b=lmQ1Uc64I3aFUIDIvp9cshnu6kgh4ATw2zJd8HRIfhOuk4x6dqWzudEs9LtORPARzU
         DMf2CakYIv/dzFSgUga59O4O5PY9zGlMHr8hEAmG1B3pIU/B4YAjzxq9+MQQ3r/ufmqO
         YKjtH3gslGfzrsRdABEPH7ylPBrugxDSHMOOA+94SQCaLUsCzkCuELRczSXZzc7/GrxR
         XqKNK89eVhnGHWTMbOvoVE227r5YQdnzUdeDuggWJqoM8gyfB2KjB4rybnCvml9GPVlY
         6gfkJiY4tt9huHOwuVttFLME6HgRqTly7aQxXmp0jz2etBswUGEouYfAIHzU53D07clf
         rQIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758726920; x=1759331720;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KVqkCRaMXNKzpuB5REQUDEUQfJMrsFYNkn+7shJjr5E=;
        b=i59bC/VuEzZ8reiPaeMNWjeiX4KRAjzBX11Ha7alD6QDXhCHRP0it7C9Ac9W+TuL+0
         7LYBrObE70r9a/UJrFaWnWLRXtBl+3ZbUEk3au0/2Fy3YuqQZlzLeSBWsMih24TW/OMD
         Kk39RF6nqf/W4nX3QjSkxdyDpcudr58Az8gZ+TnoxdhNY3aVm8Q+hdgiU1kRBnzr38ve
         xWkY+SxS/JzDespXgQa4J2IYagHA6w041n8cNTnrysC1uT3l/cqyW4kvzCX0ocz+qiHW
         z/vH0dcjABNCZ32jhdjWCi8wg7P220VAWjf+8SlxxeHhL+VCXLE5PmuAror63X+iKnln
         QLnw==
X-Forwarded-Encrypted: i=1; AJvYcCVTmlsMmAf2A8ZFBdYeEztq82zPlEeQmVqmiAan1s171ehbsiWyJpGQG3rPJSO5sIEvt66D2N9qaaRzdTg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6Yoa+3vqNI5ImEG980m/WKVMByXLrCcDyr7OqxqzmcbbimtT+
	ti3JJzk9ANlcM+3EYD6ky7cp2n1j6zETXu0Ka3yQZVcst7Jttxi84rTL22s3VaHE8Ms=
X-Gm-Gg: ASbGncuv7FNgzy5fH3rUHuhOhbZMvonn7dH2YV+yVhEgZ5NSXxwJ3+AXK9KmsrmBJTo
	h1nsbVXwC5iQ4t0EG6QHwB9YWAp4E3dbXZjFp9vuPGstysUKJIGkSarUVs4Gt9t8w0udwNzQcNz
	920bC3k2bA2UVrR/Mfuf4Q46QHYR1Rn/DN9YUkwt5N9dw6SMQhDPnPpjQs/gOp4Dzc96lxQ/ZSE
	ng8E4Toj+Sj4MKqnypxfgNZ1NmdA5F/cUJCvpZC4qjviSfjTKb1mb0/sWDnBu11kTVxDYKwYEyW
	1vlBsMtYxdufAnQq71DtvQarGws9u9y9/Fc1iCykp2XtMVYBKTdlAbpJPAq9eiswQZ54zviqrkj
	p0NO/OhBYr5ba2GilJypT/IT7lsKWaXvnnf+2qeO4SXjvay1PkeSHWqpYO354Bm9Zzl9GXNDgHV
	A=
X-Google-Smtp-Source: AGHT+IFUBokS/crC/e1tyzLRdorHGylPcO9/aHYJEu0osDuR4f/t84N4YYsDuJGzyT1nQBhllDuZwQ==
X-Received: by 2002:a05:6000:4202:b0:3ec:ce37:3a6d with SMTP id ffacd0b85a97d-40e4cb6e228mr379725f8f.47.1758726920506;
        Wed, 24 Sep 2025 08:15:20 -0700 (PDT)
Received: from ta2.c.googlers.com (213.53.77.34.bc.googleusercontent.com. [34.77.53.213])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e2a996bf1sm36541855e9.1.2025.09.24.08.15.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 08:15:19 -0700 (PDT)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
Date: Wed, 24 Sep 2025 15:14:41 +0000
Subject: [PATCH v4 1/3] arm64: dts: exynos: gs101: add #clock-cells to the
 ACPM protocol node
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250924-acpm-dvfs-dt-v4-1-3106d49e03f5@linaro.org>
References: <20250924-acpm-dvfs-dt-v4-0-3106d49e03f5@linaro.org>
In-Reply-To: <20250924-acpm-dvfs-dt-v4-0-3106d49e03f5@linaro.org>
To: Peter Griffin <peter.griffin@linaro.org>, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 willmcvicker@google.com, kernel-team@android.com, 
 Tudor Ambarus <tudor.ambarus@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758726918; l=984;
 i=tudor.ambarus@linaro.org; s=20241212; h=from:subject:message-id;
 bh=JmsEgZMHNR2hZ1IS9otwlJdT37DqVFuKcq466eHfWkM=;
 b=In9O47CfMkMqpQRFT0EdPf6ZFFTRjGsFERp5FOQXNztXjs5m7eOB+4DwpP5+7wmzH4t124xRS
 d0YD7QdbCAJAnxjbbNk8gD0ezAWG0lxXstJGjc/g0YGXRMyewTbLF9z
X-Developer-Key: i=tudor.ambarus@linaro.org; a=ed25519;
 pk=uQzE0NXo3dIjeowMTOPCpIiPHEz12IA/MbyzrZVh9WI=

Make the ACPM node a clock provider by adding the mandatory
"#clock-cells" property, which allows devices to reference
its clock outputs.

Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
Reviewed-by: Peter Griffin <peter.griffin@linaro.org>
Tested-by: Peter Griffin <peter.griffin@linaro.org> # on gs101-oriole
---
 arch/arm64/boot/dts/exynos/google/gs101.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/exynos/google/gs101.dtsi b/arch/arm64/boot/dts/exynos/google/gs101.dtsi
index 31c99526470d0bb946d498f7546e70c84ed4845b..f88d45a368af7ef88e8cdc84b3a81a63a753832c 100644
--- a/arch/arm64/boot/dts/exynos/google/gs101.dtsi
+++ b/arch/arm64/boot/dts/exynos/google/gs101.dtsi
@@ -202,6 +202,7 @@ ext_200m: clock-2 {
 	firmware {
 		acpm_ipc: power-management {
 			compatible = "google,gs101-acpm-ipc";
+			#clock-cells = <1>;
 			mboxes = <&ap2apm_mailbox>;
 			shmem = <&apm_sram>;
 		};

-- 
2.51.0.536.g15c5d4f767-goog


