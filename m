Return-Path: <linux-kernel+bounces-812703-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41D67B53BA7
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 20:38:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E134F3A5D0D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 18:38:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 267B02DC776;
	Thu, 11 Sep 2025 18:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zE0atjZY"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD5E12DC769
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 18:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757615927; cv=none; b=luSvMMf6OxlHuOepnFV0UAZvAMuYYJ7gA5gKVlS5ydhm8UwUIWbV3L2oHRXK1rc7ed5jiUtcZ8fZmT1AFglcnuZJvbh72JFL3WlJA3bbVuRws3G5FJ6fe7OEtf1K0l6wtQEtgkijdp5zoqXGu+VTL/Or9ar0G9fUtVGqXA5axD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757615927; c=relaxed/simple;
	bh=cyIuzam7bLo5cww7G8I2d/pYlJRYJ9PIWcnedS7TTIQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=NULaVEj5zpjuXGam7hBa1zFxX/DaOTHGOv8R9RiDIQQdYtHcXkX6TTuNkPihvmqTQ7kifo8s31D72Vf/NCKbAaGQuIOzxrWQwrubTbvUJs/Onaj7iix7lciYq/cNdJR0i3wzU/EzYqEg2hft2QZNlmWEDsoUrkc2M1C4Of+BA2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zE0atjZY; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-afcb7ae31caso179384066b.3
        for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 11:38:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757615924; x=1758220724; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0CYEVlIhuAwsxdbPBZNCG41bzVEkVebpPHWLaYcA87E=;
        b=zE0atjZYipn90WxGbLefXt1sY3f137lxUdNoSXyZvR7PxxKVq1V1+dFkwTtjdkWI8n
         qXYaqVm9D4SrIodxMjUA+87exJqat0Vf912APScavIKFzfFxJRaVF+BcTtbAbGzoKFm0
         uUnKlcnqhB+aX9b/qaVlvTJotbwKl7aP+ha0rf3ycbWNusinDA52gfU01BdCj3US6d/3
         5qJ5qD9WRAPOC8D5TI91+Ri2AaBGjxe5suAtVu99mLvq6ZmGcCtH2UFjWQJrwf0yVQz+
         KBY7qV9ClHW1Ir5VNwKknCGPDd1AaJtV9xyt0BUKa0BWzI6bB2uDRiZr3sPl1Wt1Y9re
         akpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757615924; x=1758220724;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0CYEVlIhuAwsxdbPBZNCG41bzVEkVebpPHWLaYcA87E=;
        b=FsCGC52VPVynXCECqLwAd/r5krhQ6OlSdLN+m2X532Rg28OTS0QHPLHDcntah9Mth0
         YP0vuovilE5m4Fn8blrI34A3bap4W3e46SsNoOb+hskPKj/yQue9ht3KQ1tn8MTBGqif
         IJ/W8i8pOZLJrtxeGWD2zmx/T3VzElXQZOQRuTj0NK2rGnyr5/IJI8nFPQRaxVJMkGD7
         P68Y56IKf/DvT/Rn1oFczPliO/EfIwQWXngowu+QP83JMp3ggkJIxHHfnblT3dFcIOoF
         kzzgVhmBd+guH7lIs0fVOJxiNaVu4FKu/bhMqvN3hBD0EE1FhiaXQszI9iZBDscGm8P/
         bxkA==
X-Forwarded-Encrypted: i=1; AJvYcCXicNH0VDs7g+UZeqk91FVI2vMm0WuwWpgURR4vU3Yea2TMWleAwuPz4YheDkc+KVIA/c0E2RDaAuz0dlQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTJspm2ZKft+26uNRQUqR2BVCZfmGvISh6AJOZJ3xrW8E2IQ+c
	Jt9kQLcdckGAchc+IXd7Ki7h2UjTZzw2Q0bYz5ViiLjtSwziR+ZY1a3bgKyZjhnMNWg=
X-Gm-Gg: ASbGncvYZu3urjKMI1olhS00NZcnAsd4+iFmCDC4a/uPG21QSRzprXquio/xJKuCA3o
	ITq0T/B6A1HMVc4WHZIBx0kp3z0k2elkEtNPBrgJFneY4dlvSHVc3XuhrlihLvmogUDsK2MY+T/
	glm/ALBvUwT8ZFHTr8Gf4cpoqizGckRZiKbEtCSI61ZAqdvm5PTqYuq4icGN5NqIkLUpF9It34C
	N/sAK8GdbGqDpcpQb3cdJx2cIc1aYHkvRzDCfdMjiClPBb1cchAMrY4Ahp3+jtcK2hG0qSIvHnd
	KZN6kmov8ahXlLvUL0NzloMuAoxu7vPNx/mzJWRCuEJhPVgAY6qehTu2C/aUhHMeaS03KpVyXi0
	Q/Zvu0COKo5gyATqOrlm4tiZf7bqKVSZ26A==
X-Google-Smtp-Source: AGHT+IHuyID7DG1/KskiWhcy6TIsIYPl8tY5FAE3l8iO5JPheONXetmpMP+YXEkW+CxLttaXcg5qKA==
X-Received: by 2002:a17:907:da4:b0:b04:2cc2:e49c with SMTP id a640c23a62f3a-b07c35bbcbbmr17109266b.19.1757615924030;
        Thu, 11 Sep 2025 11:38:44 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:2454:ff21:41:725:1e09:bed1:27ea])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b07b31715fdsm183999166b.49.2025.09.11.11.38.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Sep 2025 11:38:43 -0700 (PDT)
From: Stephan Gerhold <stephan.gerhold@linaro.org>
Subject: [PATCH 0/4] arm64: dts: qcom: x1e80100: Add IRIS video codec
Date: Thu, 11 Sep 2025 20:38:23 +0200
Message-Id: <20250911-x1e-iris-dt-v1-0-63caf0fd202c@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACAXw2gC/x2MQQqAIBAAvyJ7TljNDvaV6GC61V4sNEIQ/550n
 IGZCpkSU4ZZVEj0cuYrdlCDAH+6eJDk0Bk06gktWllUV4mzDI+kDY01To3oHfTiTrRz+W/L2to
 HgGADEl0AAAA=
X-Change-ID: 20250909-x1e-iris-dt-eb0494a130ca
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>, 
 Vikash Garodia <vikash.garodia@oss.qualcomm.com>, 
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.2

Add the necessary definitions to enable the IRIS video codec for
accelerated video decoding on the X1E CRD and Lenovo ThinkPad T14s. The
additions are largely copied as-is from sm8550.dtsi with some minor changes
necessary for X1E.

The PAS interface used to boot the IRIS firmware is not functional in EL2.
The code to start it without using PAS exists already in the Venus driver,
but was not ported over to IRIS yet. Discussions how to model the
video-firmware IOMMU are still ongoing, so disable IRIS in x1-el2.dtso for
now to avoid regressions when running in EL2.

Signed-off-by: Stephan Gerhold <stephan.gerhold@linaro.org>
---
Stephan Gerhold (4):
      arm64: dts: qcom: x1e80100: Add IRIS video codec
      arm64: dts: qcom: x1-el2: Disable IRIS for now
      arm64: dts: qcom: x1e80100-crd: Enable IRIS video codec
      arm64: dts: qcom: x1e78100-lenovo-thinkpad-t14s: Enable IRIS

 arch/arm64/boot/dts/qcom/x1-el2.dtso               |  5 ++
 .../dts/qcom/x1e78100-lenovo-thinkpad-t14s.dtsi    |  5 ++
 arch/arm64/boot/dts/qcom/x1e80100-crd.dts          |  4 +
 arch/arm64/boot/dts/qcom/x1e80100.dtsi             | 87 ++++++++++++++++++++++
 4 files changed, 101 insertions(+)
---
base-commit: 8f21d9da46702c4d6951ba60ca8a05f42870fe8f
change-id: 20250909-x1e-iris-dt-eb0494a130ca

Best regards,
-- 
Stephan Gerhold <stephan.gerhold@linaro.org>


