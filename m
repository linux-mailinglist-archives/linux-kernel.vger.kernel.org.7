Return-Path: <linux-kernel+bounces-781511-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DC46FB3135F
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 11:37:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4752D623E4F
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 09:33:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 480702F7464;
	Fri, 22 Aug 2025 09:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="l6auaDi5"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BDDB2F6165
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 09:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755854951; cv=none; b=mD4/DNTEoy8iy5AP00xB0oyFq+u43RsFmr0JTOOLRr5tudsvXHGx/NNreLQcHzGZeXnT88+YZ8NAeLBPw8kxDN30ne2rlEVwklnnhQUXPNgjGCR6ZDys5seV2g0bE0P3WbzbmnLmWauXNK0ilZF8wVmWyQVwi2Z3nXS5H+aykoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755854951; c=relaxed/simple;
	bh=KTn6vbVqVwIQjrGCMmz+yYtiW5sU/DuQSWNcqBhTWPE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=InamYCfl4DjlrrLcv61MfivWNiuc1Ph1Dzaneq87JOiMUpOmqG5NWTB/7KByEayXCIP/8AkFyXwCHKkkxoAxGWwPz+lGNwYXMiV/tpzktsYf+5JpoHtbE2yJaybTX90WFhjSjRT3cQxxssvKnzcpP0GmuDZYoCzQngRm3sLgVU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=l6auaDi5; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-45a1b00a65fso9400295e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 02:29:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755854946; x=1756459746; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aDaAQdKRC/QElueN4SD7JG4KlVvvsfus2+KgJMaOEsc=;
        b=l6auaDi5nddH2EuqyF82mmFIVySgpZe2UE5KlkPqyg7g5jvTmNgndA5/GwaO0SEj64
         Us1HGdohgB/lXqHZh7LWXmmnHHnwtx11rxW5FIbwf1IHwR7YScuVeU4HF9WRfPB1eujM
         khTmWxVGDWLXoKqdSrBNK8SaxflDtGyiHf/wognqH5v58e2hycPD8y/PiIWDMO+bXPxI
         7kewh8/zENf4ytekwWLdmLL7M111BnPVZyiI9vjhrS5mbvXx9W+NeIoIWWZszF2IKHIs
         1P8iF9qYrp+kk6jXXMFpn9/xUjvEZk210GB7amFib9JGUsvv1w4QJyICbNO8UflI2Yu0
         o0nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755854946; x=1756459746;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aDaAQdKRC/QElueN4SD7JG4KlVvvsfus2+KgJMaOEsc=;
        b=a/QRNySW6tf9f1bWh6wMHj0AUB578VwBxDjTgvgaL7kEa9undg20Ob3z99+efrIx3p
         i/jC5nK6K7g30YNxN3bgdl1Aknn5lQBzhK5duoUxrxT2httqm12p7rGPaevA8bCpb277
         6eUv1CLLQgsK8K5GbEZtIBKZ6IKZlFyVc/w0k+YVFHbkbOBilAM6vMzTAMoJfKONnK4L
         jnKQ0GOcYdXO3Eob4FBoFJ0l9wkssiQzNb/uby1i6NGN5NfBMVTlJRsFL7UFaMtIrHLc
         Kk4GdduzIKgxtDlfvrdrI57PuOfxpY7nVHoP5IkOhm4Feq4dTILF6j5PR0HxHjULJBkt
         W+VA==
X-Forwarded-Encrypted: i=1; AJvYcCWGDzWn1sFXXpIiqUUDEotwP65tvVn/H5cspi7soBoF9sUWoDTRaZWYFy5vJr5vM8DrCrUXJJdvH/CdGbI=@vger.kernel.org
X-Gm-Message-State: AOJu0YygJ7GBLrOwhlfK9tn6Sn9/p1xbHqrdZh+Q0KxOrIF5LnEs3v+h
	6cFn/8nUzQzdlr6/TibiW2J6FoHrb2qguDydxsyw4CTgm19qJye4MUPKp/a0jQdrdwg=
X-Gm-Gg: ASbGncubC93GeqqgMKACqlIvQ/hvY3HHJ3vp2OM99+zQMZ0JHBUAVbwj0LwV9HZ9Z+/
	1i9PBQm41YcxbHhqWV+MENxHj4ptlsQAFORdqs6puWf/k1UfqoyUpWPhATGFhb5SimmvZzZTCFp
	eEynfnuK0CkT9otrrzUOJDerrxde5GRb6IbMXgQHb/F8ArBSMC6MuEAKB9Pee1tUI1SmcFb71uT
	imNlmw/u2rZSgYfBATLYWbd3HPhFJ2wAffgVIFCtZDCrGFnHSdamK1k4M37sjybJgTNTWSqv3xm
	bmF7b9OoGiIju8ALhGOhxDN9yHu/DwDUFO4zML1U4cHlR96kwFIj4M/Zsjc2qG5hClAOPxpYn5n
	uYod/Od2FstSjXF3/5WpB5m31B6pwJMGpF88ojA==
X-Google-Smtp-Source: AGHT+IE98olllF50n/P1P+GEkLwCm1VNHU4/tQIHf/qa8FuDV/x8gbbK0X0a5GOq+jeMBdChlo6QLg==
X-Received: by 2002:a05:600c:3f18:b0:456:161c:3d77 with SMTP id 5b1f17b1804b1-45b54c306c8mr13475315e9.16.1755854945709;
        Fri, 22 Aug 2025 02:29:05 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:2454:ff21:ef41:c671:531c:f2ff:2a7a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b4e269d20sm33831805e9.2.2025.08.22.02.29.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Aug 2025 02:29:05 -0700 (PDT)
From: Stephan Gerhold <stephan.gerhold@linaro.org>
Date: Fri, 22 Aug 2025 11:28:53 +0200
Subject: [PATCH v2 02/10] arm64: dts: qcom: x1-asus-zenbook-a14: Add
 missing pinctrl for eDP HPD
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250822-x1e80100-add-edp-hpd-v2-2-6310176239a6@linaro.org>
References: <20250822-x1e80100-add-edp-hpd-v2-0-6310176239a6@linaro.org>
In-Reply-To: <20250822-x1e80100-add-edp-hpd-v2-0-6310176239a6@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Aleksandrs Vinarskis <alex.vinarskis@gmail.com>, 
 Abel Vesa <abel.vesa@linaro.org>, Xilin Wu <wuxilin123@gmail.com>, 
 Jens Glathe <jens.glathe@oldschoolsolutions.biz>, 
 Srinivas Kandagatla <srini@kernel.org>, 
 Sibi Sankar <quic_sibis@quicinc.com>, 
 Rajendra Nayak <quic_rjendra@quicinc.com>, linux-arm-msm@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Johan Hovold <johan@kernel.org>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
X-Mailer: b4 0.14.2

At the moment, we indirectly rely on the boot firmware to set up the
pinctrl for the eDP HPD line coming from the internal display. If the boot
firmware does not configure the display (e.g. because a different display
is selected for output in the UEFI settings), then the display fails to
come up and there are several errors in the kernel log:

 [drm:dpu_encoder_phys_vid_wait_for_commit_done:544] [dpu error]vblank timeout: 80020041
 [drm:dpu_kms_wait_for_commit_done:524] [dpu error]wait for commit done returned -110
 [drm:dpu_encoder_frame_done_timeout:2715] [dpu error]enc40 frame done timeout
 ...

Fix this by adding the missing pinctrl for gpio119 (func1/edp0_hot and
bias-disable according to the ACPI DSDT), which is defined as
&edp0_hpd_default template in x1e80100.dtsi.

Fixes: 6516961352a1 ("arm64: dts: qcom: Add support for X1-based Asus Zenbook A14")
Tested-by: Aleksandrs Vinarskis <alex.vinarskis@gmail.com>    # FHD OLED
Reviewed-by: Aleksandrs Vinarskis <alex.vinarskis@gmail.com>
Signed-off-by: Stephan Gerhold <stephan.gerhold@linaro.org>
---
 arch/arm64/boot/dts/qcom/x1-asus-zenbook-a14.dtsi | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/x1-asus-zenbook-a14.dtsi b/arch/arm64/boot/dts/qcom/x1-asus-zenbook-a14.dtsi
index 16d045cf64c08c02c420787e000f4f45cfc2c6ff..76948160634fe8b3cd20aa02d6edd53b37be0689 100644
--- a/arch/arm64/boot/dts/qcom/x1-asus-zenbook-a14.dtsi
+++ b/arch/arm64/boot/dts/qcom/x1-asus-zenbook-a14.dtsi
@@ -1001,6 +1001,9 @@ &mdss_dp1_out {
 &mdss_dp3 {
 	/delete-property/ #sound-dai-cells;
 
+	pinctrl-0 = <&edp0_hpd_default>;
+	pinctrl-names = "default";
+
 	status = "okay";
 
 	aux-bus {

-- 
2.50.1


