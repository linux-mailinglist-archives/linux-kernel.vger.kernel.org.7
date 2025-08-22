Return-Path: <linux-kernel+bounces-781517-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E03FBB3135B
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 11:37:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE0DE1D00A33
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 09:34:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF3BD2FAC18;
	Fri, 22 Aug 2025 09:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="to1fAIot"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8D812F8BCD
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 09:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755854955; cv=none; b=dOIt2ugM3RFVP7rO9tG2RtJOXhm060D+cwPlpRx6hhfYQWLFive/oXdQ7r/z5iimxTLIIp+2q0WHayEAotgxy40ehCBqoZWIM8GykVggty0kP5Aa3R+NQWk3Gyg69z8N4LS5xblOxv0Ap/QioAHWpxaVAxTdgdOxR7Y2rxmVA5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755854955; c=relaxed/simple;
	bh=VeUCv5OypXPXd/iOoNA4jj+z2SlWhHr+JXevb9g+W/0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rmlSl+BC5ATLsl6VUpLJNcBWJxNsFrClne71ZtiJERFVHOZbTog0wyLF5UIiyCbl67meiePhUGK0WX05EKQxCRwYnIQEuX6H+xB1IQwSkn+d6iGsZ5DDIJYGJinw9HtD40lc+Vt3elbHjtxfD46L7/3lOPCtKTuKY4Jf6SvbhEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=to1fAIot; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-45b55ed86b9so730725e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 02:29:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755854952; x=1756459752; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N0a/roQjAOMowibb0xrTwJSZ3ukysCGuBQ+y5KVoQ+k=;
        b=to1fAIotJwaLvSXTBZx5YPC/I9I7HXp9FhYsNnvphb2REsU8/oxjM5SwVsQvoycnxY
         KHl1jrgE5cLCGF+jmorCnoI2NgyNUMkIjn1hIuxQVaxMrrX6qx1psKtg9TmjCaLtjqRZ
         jVn6VOU31L9knJihJSTjb+Wruuhk85le2m0lTcqb3aChFlvm6xQ3HXHXvFxYkhHVSKtg
         2DrT1gtg4haDqLv9hl6OZH2CXLGk3gUAgNJI1y55IECPtZvlRAQYHhC/63uFt0ckFZr3
         2WmwpDXOlTW/SKt/uTLtoC/g2gNNxFqtsk/ZU5gTUxRYUv01S3pLsLSU7mWUThDwTkMS
         r5NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755854952; x=1756459752;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N0a/roQjAOMowibb0xrTwJSZ3ukysCGuBQ+y5KVoQ+k=;
        b=Uj07zq/t0aRLasHZelT9QGdvc9CsTmA2nZLN5LeP7iRa7TgYbxVdV7ya2xAqPXREeC
         IeHTFfJqFMQU5LlUyobEK/o2biRnw4vySNIihl+jcu9Te7r2OmENvpc07f58baYvDNuk
         GhiXL2ih7216OYhYbM5BYj4faSWqYVhLI5Jtqe+VDKZtyAx1eqfUrEe1o85koJAi/wHn
         PbnKNg0NUZBLO6zlIhYobUlpXmYjLipY0LpACC5ngKiPFBIm7Ihw/kQDjPKW20rXnPk5
         XqA3gDZwUuGPwEntlYyqt3asoBCEfc2Fc6Re5L8K+oLfuqV6P+XwM25ple4dX0oj9i2v
         uHYQ==
X-Forwarded-Encrypted: i=1; AJvYcCXJtsdqizUp4VXyOr1Qat7SOtO1jwCLDpF8VZXXBjDbv06tI0xg0KR69MXccyPHkG2OnbGT/On5W3zBpFM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyiJPy7sD1OhGOi385ZvENJtdQqTKtdlyzfml5ohCDWif835NkB
	Jl1BD3vKICsKlfO+WfdKYautP+DyUYOr1gG+yaoY5NvMMnySZ4VB6koxkE0hMjHGmfc=
X-Gm-Gg: ASbGncufoCAH28Zk7rnDEvLDXN5eSeb/6aLPkYN/LKVR4Qz3fIlZwiAuqI7igTr6cU3
	N9I+iXJk745ENhaubvKqUbagyxV7XdaqfFsZhpKfxv5u+Zb6MCqV/VYxZPpw/5SXKkym9sFdm4B
	bXEdeTsdDZxSj1Vpdk9d8ijuR52m8G690jyu5lfUKFbGUoeIk/tvpdOSVJHeoc/fAkn3amvBKF4
	1cpLji94SOVZZ9uoCZAS9G5QVDUvk4OT2nvzzVIjVJ4VafP4iYm6IfIggk+Vm5slp1L5n3I4lsU
	OULPnN4Dbf96q3NlJvpqnwnRh9PwoGh1twgFnrAP1XzUK390CPd9pjFWzuZoSn79cOXE+BL5Fj9
	Qqy+fc5cl73y+IgdwmAecUkiBCnRKwQqJLgk8GQ==
X-Google-Smtp-Source: AGHT+IGBLtFrfsIlGo4/670EQdWfkmVjySe29U9Is+Rdyd/oKJzHmoQgOsX99oIOfPJdrAo/Q54wxg==
X-Received: by 2002:a05:600c:1c28:b0:456:2698:d4d9 with SMTP id 5b1f17b1804b1-45b5179ccb8mr17335915e9.3.1755854952165;
        Fri, 22 Aug 2025 02:29:12 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:2454:ff21:ef41:c671:531c:f2ff:2a7a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b4e269d20sm33831805e9.2.2025.08.22.02.29.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Aug 2025 02:29:11 -0700 (PDT)
From: Stephan Gerhold <stephan.gerhold@linaro.org>
Date: Fri, 22 Aug 2025 11:28:59 +0200
Subject: [PATCH v2 08/10] arm64: dts: qcom: x1e80100-lenovo-yoga-slim7x:
 Add missing pinctrl for eDP HPD
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250822-x1e80100-add-edp-hpd-v2-8-6310176239a6@linaro.org>
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

Fixes: 45247fe17db2 ("arm64: dts: qcom: x1e80100: add Lenovo Thinkpad Yoga slim 7x devicetree")
Signed-off-by: Stephan Gerhold <stephan.gerhold@linaro.org>
---
 arch/arm64/boot/dts/qcom/x1e80100-lenovo-yoga-slim7x.dts | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/x1e80100-lenovo-yoga-slim7x.dts b/arch/arm64/boot/dts/qcom/x1e80100-lenovo-yoga-slim7x.dts
index 71becfc5e6f649299b05b0b93cf74b81dea9fa57..dadbcd66584d7c90a01bfb339e586e4675bf32f5 100644
--- a/arch/arm64/boot/dts/qcom/x1e80100-lenovo-yoga-slim7x.dts
+++ b/arch/arm64/boot/dts/qcom/x1e80100-lenovo-yoga-slim7x.dts
@@ -1086,6 +1086,9 @@ &mdss_dp2_out {
 &mdss_dp3 {
 	/delete-property/ #sound-dai-cells;
 
+	pinctrl-0 = <&edp0_hpd_default>;
+	pinctrl-names = "default";
+
 	status = "okay";
 
 	aux-bus {

-- 
2.50.1


