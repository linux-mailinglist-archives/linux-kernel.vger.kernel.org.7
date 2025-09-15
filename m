Return-Path: <linux-kernel+bounces-817052-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 203AAB57D1E
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 15:30:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1443F3A1355
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 13:29:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C39A33191C0;
	Mon, 15 Sep 2025 13:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nrgbE7Xv"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37B7D31329A
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 13:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757942937; cv=none; b=hEzzUBuAAlEbx0XOPohXNV3TB5SKj6ZXQu2KnGh38rV1sh2OP1gfnlLUwu0u6XrSkhu9YwffQFs1zQZ2vZxn7L8uhHBpzpWCQPD4tNVWxrsI30hUre3GQea91/Mul9QqiR6w9VswUYrdAFsE/F5V6RjEVFyvzEzoMHe7J4rignY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757942937; c=relaxed/simple;
	bh=xEgvgp1w1rmeywAOVMjlCu8mw7ilAI0jVsgUn340nr4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=qoH689tUJa1ZhSL79AaJw22xtwguOQLaMFcDcR6SxqF2UeX0BiVFNgATn61XnHjYdpdtpAzhzCBO7SqiL/WhLlw12T44zKj0gWXUXy/UItND8WxPUqIOmXzgL6/ZNQmvN9pjMgavB6FSb5R9sJcurgL0HXL38Y4bDK9OGkKn454=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nrgbE7Xv; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-45f2fbdacd2so3785845e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 06:28:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757942932; x=1758547732; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=E64EnDDoUOocvbh8uugNWKeoaww3AkFSaRKoHulwLmQ=;
        b=nrgbE7XvEID0Yju47ylFelyaSgKwRjFDNdtTH9r5ZEFtndr0BODbIooSPcabYXplaE
         E/DQDT+OnDxOxMHUnPk3gWKAQAp4p6Q3Nu2Mm6x99ZgjvMNAjYRXD7M1JM/sB94JjUKH
         elR6lnOPdOuW6h2/t8pv88Sv6HoeKoXk3Gc7ExIbNkWsz2yOA1R8S0nhPOvx9t3J9pP0
         ASD73GG3og6N/lHB6IJBMTszg/T/Bbci4ZKT/2pn7phJ/AzKmHPDwXKBaNG1UtAMteSV
         MApAgRtCb+vZH9rkzD/Cs/ekKEl+mISkBK5+J6VrIh3FHIz/4KRKpYr7gaO+Hezg/N3b
         C6/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757942932; x=1758547732;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E64EnDDoUOocvbh8uugNWKeoaww3AkFSaRKoHulwLmQ=;
        b=VHBKiu+ROQDpeXscXZ+q68jUcAFBxGesVj82GpUj2OtdtOTJBP9koe1qf779WgWel7
         gbh004cAHPrBzr7WmQeNEpFj3gYumjs0Wm56e2TkJOeFt/6hg/iwrX4m/Da55y32kRQG
         3ol/DVXqoUSQVKl6qNlAssDWtDr7+JsvSoVI46ZvN6ZEfZt3mybU4gKGeLRlCZIqiUwk
         OFYD9QgCluKv9d3CCQnP30eZS1cE+IOnzMW31LVm/LWwx8x1eRAU4cTBc+8oqCTQrgML
         muow6qvbulVEH2GwhMgyuwqaRKkYLYz6+6Qs28MOQiWZorxusVuEMRQGt2hROb0R3BNT
         9Bbw==
X-Forwarded-Encrypted: i=1; AJvYcCXoqYRo5huwzlzXkVJAXWzcITIj7sPMwznFkf13x+V20DtCRYVpd4qBue3aZPrszXjo8FCbAYVVytkeJRg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrOb9f3T1WywBIZtIVVbAWrUoWvDUxdagdFr+CsNzogR9aXxzg
	wp9xU+Ubj6/oMAga3Vbu3brkzcrsPjMlYKeKA3gV8HkhMIu0p4m0bKraKXD4DF5kipLhNiqs4TK
	aW0dUxQg=
X-Gm-Gg: ASbGncs7cL+eQh/uLu+qzlu+FLkMiFNIXpmNJjpopT8+kJtl/kpia9iwvYaK9BjDmBt
	7dp2iK6gT0X62tfdza8245bNQtyHdQjX4IvlZ8wBO0otiikW95TL5m2fb/FVond+OHz/e7vh7Y+
	PS2xxUiGndxhar2UaWy8de20zH2c9tlo0Di9kXZ0He6uP/t3acCcy1Eej8k32dD2gVKxqF06tdZ
	wXTSDmdNb5zEH7RTLnzA7F3SGiUWqDJGoMK1AIaYaloj9X8mqeIOlxTWaclrg9GF0L54dFLVhrT
	fhxWNBzEmppDciOxnDOnuUKU+T/LuPH47r0mX+7pUfXcJYz2wFZDqJg7rTczY9mUKlTxh/rygUa
	6ubgaat0iom2M9dv8ZZflw/3Ffxxy2BMKP2OD5Fhe0/q3ww==
X-Google-Smtp-Source: AGHT+IGMJiALjnpkCZFxZk9BbN00L9xwO5fbJ1orbywijGyhwDs/6vzS8QZBYd1u/SfOaaq9fQHVyQ==
X-Received: by 2002:a05:600c:6c94:b0:45b:9afe:ad48 with SMTP id 5b1f17b1804b1-45f211d57e3mr101731705e9.16.1757942932310;
        Mon, 15 Sep 2025 06:28:52 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:2454:ff21:41:eee1:5042:e713:2e9a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e9fd89af70sm5978874f8f.43.2025.09.15.06.28.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 06:28:51 -0700 (PDT)
From: Stephan Gerhold <stephan.gerhold@linaro.org>
Subject: [PATCH 0/3] arm64: dts: qcom: msm8916/39: Add missing MDSS/SDCC
 resets
Date: Mon, 15 Sep 2025 15:28:29 +0200
Message-Id: <20250915-msm8916-resets-v1-0-a5c705df0c45@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAH0UyGgC/x3MPQqAMAxA4atIZgNtoGq9ijj4EzWDVRoRQXp3i
 +M3vPeCchRWaIsXIt+icoQMWxYwbUNYGWXOBjLkjLcOd90bbyuMrHwpOlqIHVWGxhpydEZe5Pm
 HXZ/SB1cE2jRgAAAA
X-Change-ID: 20250915-msm8916-resets-52f2e52602b7
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: Vincent Knecht <vincent.knecht@mailoo.org>, 
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2

Add the missing resets for MDSS and SDCC on MSM8916 and MSM8939 to ensure
that we don't run into issues with the hardware configured by the
bootloader. On v6.17, the MDSS reset is necessary to have working display
when the bootloader has already initialized it for the boot splash screen.
MSM8939 has the SDCC resets specified already, so that commit is omitted.

Signed-off-by: Stephan Gerhold <stephan.gerhold@linaro.org>
---
Stephan Gerhold (3):
      arm64: dts: qcom: msm8916: Add missing MDSS reset
      arm64: dts: qcom: msm8939: Add missing MDSS reset
      arm64: dts: qcom: msm8916: Add SDCC resets

 arch/arm64/boot/dts/qcom/msm8916.dtsi | 4 ++++
 arch/arm64/boot/dts/qcom/msm8939.dtsi | 2 ++
 2 files changed, 6 insertions(+)
---
base-commit: 62a9be0b3388d1026117de536f6c81e09ba219fe
change-id: 20250915-msm8916-resets-52f2e52602b7

Best regards,
-- 
Stephan Gerhold <stephan.gerhold@linaro.org>


