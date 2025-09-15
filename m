Return-Path: <linux-kernel+bounces-816566-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ACF8DB57581
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 12:06:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B9ADD1AA0804
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 10:07:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25C7C2FB08B;
	Mon, 15 Sep 2025 10:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qB6QehD1"
Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com [209.85.221.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D08C2FABE9
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 10:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757930790; cv=none; b=J8kwthK84tIdqzskSYXqltdFcu9wEUgrN+K4CFcqTZI6Nz1xv1Pm8voGybgnRBYZ1zccLWvG2uwcSZRCM4oCLl1/D4mQHzcW/0a3cAur0jAQYz6EcThqdFiy/MbWK2XYfrQ+wTqSHFqqWU/M8BHorJ/yK7rGJHXofxHC3l7/kcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757930790; c=relaxed/simple;
	bh=Lflukm9inkFHDen/xv9DPoJ94WLjeXwlcVLPUTjmVXI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=KEO86Xf57PkuX3ka3vvWqjkxbHXHuPUqJtMfR52QRiuskTsRedQxJQ+WbE/yUQzdaX6tQdQb+NcZ+VcBgVMF5yDxG1RTXfgJJ0LhCOM7V2urJQUkwd1WEAC2xOpXIS2HPoV7GBAxPvV6Qfici6HtmU7A5sgZ5qHNC0ssgzd3Qk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qB6QehD1; arc=none smtp.client-ip=209.85.221.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f68.google.com with SMTP id ffacd0b85a97d-3ebe8dc13a3so60283f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 03:06:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757930787; x=1758535587; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=n7wfHA9fiq8GV6iKYUSldM7skudAMrfG9DouOO2pRFQ=;
        b=qB6QehD1Hqf3YXkQKfYncc8ODDLc6mTSi7UTvDw/KJAZoX56rm3Iyh1+gtIWyyIcAy
         ZP5nz2vtnT7BIjPymn4NOgtBWiZ9qNsWqBAfLVEEtmxCD8FcHeMdGO8q7atkiOdx0GLG
         BBot1s8yktq9E2U7ONVhB7s7hxcsUdLouGg75XjLSz62uqwxj45eVgqa9HWZb2JpwLJV
         2bCBOwmf3DJ6FXR1tZhSsKtAcSRw9FvO66eamxNUYIt85jiGYOkmkXMqd0OrcICXoT3W
         rxTGWqqX9bJl9Z7Fk8cHsX/XcdKUCsA823yUxxNe9u7HfFyPwd6XljNIYezj33qon/RW
         VCBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757930787; x=1758535587;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n7wfHA9fiq8GV6iKYUSldM7skudAMrfG9DouOO2pRFQ=;
        b=jIlvcgFqBO+7u1zMH408phGlpSHxp6Qrg4mK3tGpI8JolzcIal6G4gbZCkljTf6lAT
         2F9HjMm07Yx3zrBjH00bPyWpBaC1ZO6x/76sAAtpkVt9+MWrAioVqGN8zdhDiquVm/vT
         20THhKRcvgL+5PLQOsVzNu2VM5OVxJoVWyNvrLClSWlW73SEcUeiwdt+kTzqkayLtdtY
         ixnFYw5jhYLHBcEUKDv4zx9R7BPPOoGsp+dbVYrbF/iMJpAiub7JFHhJKHGXHS4/L+ng
         wKVi80RPI9B5/LHiHi++w5fKl8NwSdIKshEWaP5HuJld8GT7lJ1eDXc3aducPPOjK+VO
         pQtA==
X-Forwarded-Encrypted: i=1; AJvYcCVvRYljK0pmwmwl2dJr99sk9G7hGipW2KmXJ+tT5TcgD4osdBvA60XaZJsi5eYxkYeNl/w7BUZGx1Y9J5c=@vger.kernel.org
X-Gm-Message-State: AOJu0YyV0eqQu6KbsqiJEpfdskE3XbgnXIIPTOW+8B6BZ/tJNbhBgOwL
	rQznNYaBO/+WnIP26vZZ8A2Ng+5JI0of86VEMUY7eQAVJGvZ+SFTzX1v/vIvRDvDgRQ=
X-Gm-Gg: ASbGncsUCVJiEbEKDAtJACNVpnOMhmYgIw5DEqKU4fpmLmfjmMOqHKwr2rO6U4OZdkp
	/2xp822A5dMfT3ANUQejw2aV3ht1fBjtlvzh+EVRidUB1oARyM2nTmxaGRCghjqFwNIURVPRta/
	LTShG0W0gRtvXhRpOcEgu2UIVz6Sx+IDgPbYKSgAPazUKdBiAK4UcoI8BqGi0nPm9JY6PMPDaD/
	vfzY90R9phFmPmAgGFagRwoQUfTi5VPBlaOcUP1XL2/lObnX/bhEZTz4qK6DZoRIvaHjcAforQ0
	LwbLb6b9gnXgY6y1ECyUPbEu+ceEs3lDYcMJNxILCL0HYWqPhZhlHb65tt2Me/isp5U+UZ8SKrM
	TjmdMsT+65Tjbn0pdTBwpYPSc4QaDt3a1dz8HqPmGmfvqerI/jO6tanoZ
X-Google-Smtp-Source: AGHT+IEWX6WiB96O6KkfXRMglqxuS6BwP39e3jC9S9DmPdpANKfiG7fuuUfc7A6J+a1uJC5XnIE97g==
X-Received: by 2002:a05:6000:2012:b0:3e4:3e20:dafe with SMTP id ffacd0b85a97d-3e7659e835dmr11274354f8f.33.1757930786677;
        Mon, 15 Sep 2025 03:06:26 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:2454:ff21:41:eee1:5042:e713:2e9a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e7607cd4cdsm17209127f8f.37.2025.09.15.03.06.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 03:06:26 -0700 (PDT)
From: Stephan Gerhold <stephan.gerhold@linaro.org>
Subject: [PATCH v2 0/9] arm64: dts: qcom: x1e80100: Add IRIS video codec
Date: Mon, 15 Sep 2025 12:06:11 +0200
Message-Id: <20250915-x1e-iris-dt-v2-0-1f928de08fd4@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABPlx2gC/1WMywrCMBBFf6XM2sgkrUJc+R+li5hHOyCJTEqol
 Py7sbhxeQ73nh2yZ/IZbt0O7AtlSrGBOnVgFxNnL8g1BoXqghq12GRTTFm4VfgHDnowskdroD1
 e7ANtR22cGi+U18TvI17k1/46Uv51ihQorr01AYNrC3t/UjSczolnmGqtHzqz/lanAAAA
X-Change-ID: 20250909-x1e-iris-dt-eb0494a130ca
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

Add the necessary definitions to enable the IRIS video codec for
accelerated video decoding on the X1E CRD, Lenovo ThinkPad T14s, Lenovo
Yoga Slim 7x, Dell Inspiron 14 Plus 7441, Dell Latitude 7455 and Dell XPS
13 9345. The additions are largely copied as-is from sm8550.dtsi with some
minor changes necessary for X1E.

The PAS interface used to boot the IRIS firmware works only when running
the usual setup with the Gunyah hypervisor in EL2 and Linux in EL1. It does
not work when booting Linux/KVM in EL2. The code to start it without using
PAS exists already in the Venus driver, but was not ported over to IRIS
yet. Discussions how to model the video-firmware IOMMU are still ongoing,
so disable IRIS in x1-el2.dtso for now to avoid regressions when running
with KVM.

Signed-off-by: Stephan Gerhold <stephan.gerhold@linaro.org>
---
Changes in v2:
- Reword EL2<=>KVM<=>Gunyah slightly to avoid confusion (Trilok)
- Fix typo in comment copied from sm8550.dtsi (Alexey)
- Enable IRIS on Dell Thena variants (Bryan)
- Enable IRIS on Lenovo Slim 7x (Anthony)
- Enable IRIS on Dell XPS (Stefan Schmidt tested it before,
  see Tested-by in initial IRIS driver commits)
- Link to v1: https://lore.kernel.org/r/20250911-x1e-iris-dt-v1-0-63caf0fd202c@linaro.org

---
Stephan Gerhold (9):
      arm64: dts: qcom: sm8550/sm8650: Fix typo in IRIS comment
      arm64: dts: qcom: x1e80100: Add IRIS video codec
      arm64: dts: qcom: x1-el2: Disable IRIS for now
      arm64: dts: qcom: x1e80100-crd: Enable IRIS video codec
      arm64: dts: qcom: x1e78100-lenovo-thinkpad-t14s: Enable IRIS
      arm64: dts: qcom: x1e80100-lenovo-yoga-slim7x: Enable IRIS
      arm64: dts: qcom: x1e80100-dell-inspiron-14-plus-7441: Enable IRIS
      arm64: dts: qcom: x1e80100-dell-latitude-7455: Enable IRIS
      arm64: dts: qcom: x1e80100-dell-xps13-9345: Enable IRIS

 arch/arm64/boot/dts/qcom/sm8550.dtsi               |  2 +-
 arch/arm64/boot/dts/qcom/sm8650.dtsi               |  2 +-
 arch/arm64/boot/dts/qcom/x1-el2.dtso               |  5 ++
 .../dts/qcom/x1e78100-lenovo-thinkpad-t14s.dtsi    |  5 ++
 arch/arm64/boot/dts/qcom/x1e80100-crd.dts          |  4 +
 .../qcom/x1e80100-dell-inspiron-14-plus-7441.dts   |  5 ++
 .../boot/dts/qcom/x1e80100-dell-latitude-7455.dts  |  5 ++
 .../boot/dts/qcom/x1e80100-dell-xps13-9345.dts     |  5 ++
 .../boot/dts/qcom/x1e80100-lenovo-yoga-slim7x.dts  |  5 ++
 arch/arm64/boot/dts/qcom/x1e80100.dtsi             | 87 ++++++++++++++++++++++
 10 files changed, 123 insertions(+), 2 deletions(-)
---
base-commit: 590b221ed4256fd6c34d3dea77aa5bd6e741bbc1
change-id: 20250909-x1e-iris-dt-eb0494a130ca

Best regards,
-- 
Stephan Gerhold <stephan.gerhold@linaro.org>


