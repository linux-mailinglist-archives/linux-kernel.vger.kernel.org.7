Return-Path: <linux-kernel+bounces-762977-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CADAB20D19
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 17:09:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8ADD16133F
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 15:07:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8AF42E03E6;
	Mon, 11 Aug 2025 15:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="hnfqNvzK"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DB832DFA25
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 15:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754924823; cv=none; b=ccjvIzsnaowKpV9lpVU7Qp+NFWeHJNvEeS3NB6KP49hpqeYcFjSHfzgVPrVPaFeRxATvaCEoyYaK8hktgDd+ck/mAHUD5WmTHqWoKk7E3x67XFBmjSeYCjW0sNj18wdVSz9ej+VR2TjtIVJVD+86NyvG4zx/mkwHULkEUvgrLj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754924823; c=relaxed/simple;
	bh=3p5hcBViOeL2xgiNJ699bYMhAUyttuVRwHkczSRJSbc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cFBFoMJGq8/gYd90sOkmVeIZhocQMmpMt7QqcqPZyPMu98c8juj0Mk+i3wP3XBgr8wy7t/zw7H/bIQis78Lleh66pLu2mYqEOKRcsvJ1LVw1FSPB2UZPCr1/xh+Od0RZBBcdXXCB/a0xLUrGwdPiKKfLV9OjEtoPbUN9pEl84kE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=hnfqNvzK; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-459e39ee7ccso44458455e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 08:07:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1754924819; x=1755529619; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y0Oy8wSgLdlcIY+gXHw1NOZYFR+FdOb96GdIigh4L3Y=;
        b=hnfqNvzKKCHGEvUgt/EJkxQ3DAYw87KZzMiP5f6IqyMNjANoSMuMPJLBDk7vY23KSz
         79VqxNOKZnHOCMUVz503+xCqdhVfo6tQ/I9ON7K3PcyDw1Wi+HKjKEknyzenaTxzvkBB
         IhdQwkNEc4+hOYE2ob0AcuOtpbzNoV5ueuH8FdvxyvcxDzUGWUN4lgr13MNx8W+u3bw+
         EAMchlajIipl0DB58RNnr+rrNEFGVWsXNKcxBqGgjiQku6TsPWY7KUvDL6yNFFQMtzxY
         vsF6WYqFJaPSpY6YKAIcppLEUEJ/oKTG4sityCMNhXH6uaMge1PWekSNmqEbmXDMjfvU
         6LYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754924819; x=1755529619;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y0Oy8wSgLdlcIY+gXHw1NOZYFR+FdOb96GdIigh4L3Y=;
        b=IKCmtt+IpFPMAMwd11K75mmvWJ1tNusnwFCEBApGIegEyGnb28LrWhS8zmprH3fS7e
         k4qZUcJdmSH4ZDUle99LwO7yBMGVT+kRiCPKR+FPE+T6sTQqploOe92Or7bg2wU0N5kb
         ZsTcgklF9iiOQ544Xw5rmTj1AumckWiq3PgMsdxNcApSrhYQqUQM+L2TAUOl3VyprBJU
         /nVWDfJtvPhVI3QeeuUGy9XDGAvtuthWIrAfRK2jAUVWu26STkPLERUFS3d116+ncvCR
         9V/wVK2vieX3nnLCXW3T7R8rtPwBOQrfuDPx00Mb+6Jr+m7R1jPpSn1JoucvOPjXZZ8c
         C/qw==
X-Forwarded-Encrypted: i=1; AJvYcCWhcWqQQ6eSEeg6WjzTLRz5A0TGCHLweu7Tn7FigdULEIz6vkzPWrr0g7v+EZOPTDkje9CYXFb+ddfsQbo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJDoGbwnwyO1DZfR7dZtQy61keXV0wTOY7TbJbu/CftmnMLL34
	jxwJlJaogaNKAwQevmJ8VdrCSatc7/dsMm++tJNgctl/qUdalHR+/ncq4kcTi0FnwJA=
X-Gm-Gg: ASbGncs6aegrpT113vcCElZlakwzv1kFt6KvLyvFRvUNZELby9uEmLjucf52kLXWScp
	Q+FKRZQSVqkMIfUle14k2Gekw5pVX6OZbn5eKTrPdzALG9b6Osm0b1RHbRAiu6u1A74NCuuO3ZZ
	pkvU/gpmJnghZynmloCSX1OyQTTXLevLcmhj1+1sEJ8sLDyT7Gh58pNh2iTi09o/8AaIeouOcFJ
	B8sjpj5JWTtMQQpmbIG1Xh/3J86HF67kB8RvnMiFM2K9zf+Pn5j4rRFB623VonQxAskvePL8wLs
	tkQVx3D1Lb6gYCVRVBfFNmPz0ToBQOAsve1ovP0PZMLHV5DLRXEZIxJfVn4r0JDfgDYw5PQb4uf
	F5aMe9fYIX2Mz4Bz2Hw==
X-Google-Smtp-Source: AGHT+IGH6IgoeqeXukrgS3hPdlTrL8/hFM2akIjvjNIrVv2Rl95G6ZAYGTxaQu9g+oIYMhO7raaS2w==
X-Received: by 2002:a05:600c:4e89:b0:459:dfa8:b881 with SMTP id 5b1f17b1804b1-45a10b95532mr658835e9.7.1754924819497;
        Mon, 11 Aug 2025 08:06:59 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:6841:8926:4410:c880])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c3abf0csm40107411f8f.14.2025.08.11.08.06.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 08:06:57 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 11 Aug 2025 17:06:48 +0200
Subject: [PATCH RESEND 1/3] arm64: dts: qcom: qrb2210-rb1: fix GPIO lookup
 flags for i2c SDA and SCL
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250811-qcom-gpio-lookup-open-drain-v1-1-b5496f80e047@linaro.org>
References: <20250811-qcom-gpio-lookup-open-drain-v1-0-b5496f80e047@linaro.org>
In-Reply-To: <20250811-qcom-gpio-lookup-open-drain-v1-0-b5496f80e047@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, 
 Alexey Klimov <alexey.klimov@linaro.org>, 
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1371;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=TMD6A256PGlZL2cGXyLS2Wh/cdu83URj71C5IQiDtPI=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBomgcO4YgjPDJ47wzCZZhdZl4XEBlevsW4myYIS
 TusbY6YNfeJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCaJoHDgAKCRARpy6gFHHX
 csujEADNmkYAfUEumm4DG2TePnFbmkN8bmN1HgR9q0FqnY1yvsRKmMZEksOB3t+RMBd9kCWGl4V
 7oYhFEryrw0TkrR+Eqlfe5qCvJZd15tJFeaCYYAvolFiJxt1hiKJ8GWk+uCXMVqTQYlB/wZHwB1
 eDrPMtM6hFpJ4lvovw7ile6eUFL3uv3umj4uqEFx0afFj9QhrO0/cyZuXjnodWMhwdElpE441Sq
 gp9fkkr4faC6tDGOTLDpIbkWRKkq1+ON4IdyXP+Cqp0kLaEe26m6sHnZTstqI1NZfps8sepy7Lr
 hn/AiDjoZm0YSNfYm02fKRhfrXmHcdkcwx651SXD0FAHL7y0VZ4r29IygWVaAMvORpwjX0OHOwH
 AQnpUpASc1kG7muzoNaAW54PpwQn5r87ruoyAZM5QONnIqnUWAi/QxPmfn5YgRSWfjWcVL6jqq2
 iFLcc20XUjOy39It/SzICoTrUyvzowwDPYNI7JvnbVFqyQbxHXNW17lu2xLHJ0maQyQ67kS3ox+
 bcLzHAaQZFw0weae4U9jKoL6iWUkykrDW9dJChHuy0nZ9m9X7tBGDw/5o8lqiS1qXwsSrx1E67f
 WZfdrGODYGe5E0dp/L/u1IG15P/8Gl23bnmv8oQz1hCQ3NCN4UMS7JJUwuFnFXBbfF6y3dexp2N
 Y3PlaSwZwi1NQWQ==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

The I2C GPIO bus driver enforces the SDA and SCL pins as open-drain
outputs but the lookup flags in the DTS don't reflect that triggering
warnings from GPIO core. Add the appropriate flags.

Tested-by: Alexey Klimov <alexey.klimov@linaro.org>
Reported-by: Alexey Klimov <alexey.klimov@linaro.org>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 arch/arm64/boot/dts/qcom/qrb2210-rb1.dts | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/qrb2210-rb1.dts b/arch/arm64/boot/dts/qcom/qrb2210-rb1.dts
index b2e0fc5501c1eefc7e037b2efd939126b483b226..277b33100ac07cb1e8477e9e51331f974b65092b 100644
--- a/arch/arm64/boot/dts/qcom/qrb2210-rb1.dts
+++ b/arch/arm64/boot/dts/qcom/qrb2210-rb1.dts
@@ -5,6 +5,7 @@
 
 /dts-v1/;
 
+#include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/leds/common.h>
 #include "qcm2290.dtsi"
 #include "pm4125.dtsi"
@@ -63,8 +64,8 @@ hdmi_con: endpoint {
 	i2c2_gpio: i2c {
 		compatible = "i2c-gpio";
 
-		sda-gpios = <&tlmm 6 GPIO_ACTIVE_HIGH>;
-		scl-gpios = <&tlmm 7 GPIO_ACTIVE_HIGH>;
+		sda-gpios = <&tlmm 6 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+		scl-gpios = <&tlmm 7 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
 		#address-cells = <1>;
 		#size-cells = <0>;
 

-- 
2.48.1


