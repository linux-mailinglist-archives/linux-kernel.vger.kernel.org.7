Return-Path: <linux-kernel+bounces-768902-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F51FB267C7
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 15:43:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3BDF45E6F8D
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 13:33:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A52030101F;
	Thu, 14 Aug 2025 13:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jmjgw3q7"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07E353019DC
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 13:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755178245; cv=none; b=tDww2ZD7M26CvURQcSEINFk3svHCFndmETFVtBJFZ0YBAXdlNAZmf6zEIpknidMLZisxIatECPM/bJm99hTRvLDcunYsXEGXhMWBIfgTFhs+MCFfUMzTUwvcr8Rbi0EbNgYhaT7BM1Ix8ifi1b93hLj2W/Wuspi8f6rEaH4kJms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755178245; c=relaxed/simple;
	bh=hAR+vSBoqbUevtG2jIAWEfME4wANe06aDr98BAB5U7I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uXT4n13XmsPXSotp/2cELDvlhLX3CUrwOp/Ckq4Sr0IqfrnTGuo6L7fPnOA2qE8Bu+iq0ZJb++/P32wtDL1JH4bPc1OOYgSkdBobpBLOUUUq5uEhH9YNs/CCI4vOReHuoAcx1gXYbuUBvXZiTDwW8CqeMh3ufb9SXKTBzJo0gMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jmjgw3q7; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-45a15fd04d9so13712915e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 06:30:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755178242; x=1755783042; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sERMGMt7J6k6rVfJYMtXEplUCG34cmz1p7gmiNqxYd4=;
        b=jmjgw3q7kUbWXTMPnKlsxDhrQVCBDaRUwOYyFrCt0JBTci/k9fcKXfuV4Pyk6dJz+4
         zHaiOqjOr1yFk8kkA2reHviZ+eqIEIt3C1ETYFZ+Vb9H1ZrsLrpV+ZBl9LueFhSBZZxn
         qhJGrGBDs399bUmsAOUkHWK2B1jhPZPm1x6nWHSR5TNHzInU85nySzLIY2TIigiso0JF
         kysRMAOLKLKfa6qowQbXCxBO0rTQtGVg2RxixGSi7AsQbEit6Rb+kBg8c6oFnQpUbw/8
         NhmPTEixIeb/ihstSvYSCQzdmnmvBbrcRs2I9SffgECT/JafMorkJStO2ZdqIuRYfpz8
         yMOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755178242; x=1755783042;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sERMGMt7J6k6rVfJYMtXEplUCG34cmz1p7gmiNqxYd4=;
        b=m+06c+//PdhZvylhjmK9x1oWnuun9jKW5WLoTvcQqlhWxuyn0iwAGeW0b61eTLAyEy
         ZvisbszIhBFhkujOr6sNJTJudbHnJeazsBDJXWD2br4TKtkEATFpPZ6U/rLmyThsZOzl
         IM20FqYDX2OkGO8f/hK6CQpxbjpW0HRJI0xyq1EErtzltz8T/ybNYaOKlII6vT4dGz7Z
         LelEPs41P/CC1je9ya/mHKN39gVjZb7NBcNqliyLwYkbSmhaHOiNqdbxhyZHWwNJTcf+
         ElnWbCrlSTrzJHhj7HMb6DZVVckI4Kqc7IXeCoAeWnrZAqoXAV6uP84FWj4Mq4WOOxr9
         ReRw==
X-Forwarded-Encrypted: i=1; AJvYcCUo6JGthsZPj0pCPnRfaQYYB3V6uCXnXj/6Oxw+JJhhqB7drWkRF1ViW98QlAk+i10whu/5f1HBSWxn4Lo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAqMroRqZ/viaNtc4trOlAgIfRadEmjYPT6Fe8bAOlqs4YPsMp
	kVxlFaanoUPJqECoNRo5RJhi1TuuXQN6rXyWEG3KgFBdrh7QZ3RAjWSMieHx1dzzlXg=
X-Gm-Gg: ASbGnctfqy+bN+egOIcugTpHA8Faq7OO+obbA1rKYhAOrHbShCMvMaG8uNSm8LYEYEk
	l1v2VMGnih/gINX+4G62g9h6OAJ85DwLk8Nfveli4bAA6fHD1rlk/kkIDR8D5mtjwFWyIhbHWBk
	MIWge+QRbaVNAD+udMzZGKi74az5WdbzCPrs5DwO5CBJRBNTcX9+yAaX8E5MpS/wlbXMoMjmbxE
	wFSXBEOwYVKhmH5kDkv/yd1xv7HTN7k/ZIQaz2naCrmE4/u49X3rErT2u8YCKAt8/zKVotb3hOp
	Q9MYrc9c81bEHzwA4mfXbpLhxAbhawYxoOcYbN26Q02AjuqwflRocGKDASvpDtLb1U3yekw+0Nc
	Px/c0HGP9m0Au4nBvPdD0sXU0R4Qhg3YnYatP
X-Google-Smtp-Source: AGHT+IHW00HyCrS01FWvwq7ztkHXBvyQSF5YDzaWirCjwrXHf753N5vWfcIrsup4+4mmpuqcsU/ZZA==
X-Received: by 2002:a05:600c:1c08:b0:456:1281:f8dd with SMTP id 5b1f17b1804b1-45a1d52d0fbmr17310825e9.12.1755178242208;
        Thu, 14 Aug 2025 06:30:42 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:2454:ff21:ef41:9c1:e029:fc81:a800])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45a1c6bc85csm21468385e9.5.2025.08.14.06.30.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 06:30:41 -0700 (PDT)
From: Stephan Gerhold <stephan.gerhold@linaro.org>
Date: Thu, 14 Aug 2025 15:30:29 +0200
Subject: [PATCH 2/9] arm64: dts: qcom: x1-crd: Add missing pinctrl for eDP
 HPD
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250814-x1e80100-add-edp-hpd-v1-2-a52804db53f6@linaro.org>
References: <20250814-x1e80100-add-edp-hpd-v1-0-a52804db53f6@linaro.org>
In-Reply-To: <20250814-x1e80100-add-edp-hpd-v1-0-a52804db53f6@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: Aleksandrs Vinarskis <alex.vinarskis@gmail.com>, 
 Abel Vesa <abel.vesa@linaro.org>, Xilin Wu <wuxilin123@gmail.com>, 
 Jens Glathe <jens.glathe@oldschoolsolutions.biz>, 
 Srinivas Kandagatla <srini@kernel.org>, 
 Sibi Sankar <quic_sibis@quicinc.com>, 
 Rajendra Nayak <quic_rjendra@quicinc.com>, linux-arm-msm@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Johan Hovold <johan@kernel.org>, 
 Christopher Obbard <christopher.obbard@linaro.org>
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
bias-disable according to the ACPI DSDT).

Fixes: d7e03cce0400 ("arm64: dts: qcom: x1e80100-crd: Enable more support")
Signed-off-by: Stephan Gerhold <stephan.gerhold@linaro.org>
---
 arch/arm64/boot/dts/qcom/x1-crd.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/x1-crd.dtsi b/arch/arm64/boot/dts/qcom/x1-crd.dtsi
index e3d2fc342bd184473b37882f3bc4f9c4d23135bd..26b7930070265ddad07cee08b63b21ab3ee9c0b7 100644
--- a/arch/arm64/boot/dts/qcom/x1-crd.dtsi
+++ b/arch/arm64/boot/dts/qcom/x1-crd.dtsi
@@ -1174,6 +1174,9 @@ &mdss_dp2_out {
 &mdss_dp3 {
 	/delete-property/ #sound-dai-cells;
 
+	pinctrl-0 = <&edp_hpd_default>;
+	pinctrl-names = "default";
+
 	status = "okay";
 
 	aux-bus {
@@ -1478,6 +1481,12 @@ &tlmm {
 			       <44 4>, /* SPI (TPM) */
 			       <238 1>; /* UFS Reset */
 
+	edp_hpd_default: edp-hpd-default-state {
+		pins = "gpio119";
+		function = "edp0_hot";
+		bias-disable;
+	};
+
 	edp_reg_en: edp-reg-en-state {
 		pins = "gpio70";
 		function = "gpio";

-- 
2.50.1


