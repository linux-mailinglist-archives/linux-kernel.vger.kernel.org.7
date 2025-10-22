Return-Path: <linux-kernel+bounces-864202-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F156BFA293
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 08:07:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4174C189F9D1
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 06:07:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9436C2ED84A;
	Wed, 22 Oct 2025 06:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="D+PzS1mF"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 946C02D7DEF
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 06:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761113230; cv=none; b=qz/zPzvgKGw8yvn/gV6VQcwvBVWn2BG1d1F7hax6I6tn3PaKPx29vyWuiY7tZwND8zMJ7eFTbdwXho+osBwMMKpSgdvkbapm4F9XIOiv62UPd5sDh89nElC5CsdTN939Tht9Dh/mK/vpi7KeLJLq9HUBSXW02vrJcjbjKVPYeWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761113230; c=relaxed/simple;
	bh=S97oSVlZN3KadS5+RKsMHqWslriATuoFqnaos8OAnCg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WXZ3KbzIXurUTeDXcH8gP0tFugkrWBWjErVf3iZda5z+7vZemUd473L6PwHZMgdohvqGMq/3mXduawt2l+VlKwPtVAr14wCfj+E23IOoSXc2mSd/ttrp/mE4Xy9Xl1qj6j+6Nb41ZqNLQMs3aGDkGDUDrMZ3T++vx5nMcm8Vv9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=D+PzS1mF; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-47100eae3e5so19127315e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 23:07:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761113227; x=1761718027; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z2kywcqHndau+ZX1UJrHVrAlF87vou6twWGANcsSckg=;
        b=D+PzS1mF2m5XAgZxJv9W7JVRgqhuEJhiPu8xgtDSBxIUJFXsbT7wX2jyM+KhoLmo7M
         l0gZYApbleMj3lKhMcfbt2dCi4zRWUzNfEVXte4QQnxhCYupOQzuhcloStpalCPR5MWL
         Pb2UIie9zne49V2Ia8IcaiWLA1wU/RVhXDeuPZdx4dfk/FRMyYYfqAk9MU7N2spFr9cn
         RegpidKiA7UZ6KspbWBqjk5EvP8KxzTTqanE043aEg73NrY8RJZxTxj5cyPJxlZduRzU
         32aEyfI3NmIsY/QM17Bsv+rs0dSamTB5gMHJX55bCryuOzbjV/NPWbOlIbAkE0kYiaun
         T/RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761113227; x=1761718027;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z2kywcqHndau+ZX1UJrHVrAlF87vou6twWGANcsSckg=;
        b=PEVPlFNY/2OP6qp2Fj6bBh+B66fLSdeA1eEozXMg/tD5fcFYT7BGz81uiDWwLY0M4j
         9yYaD0VxjgDGqM3XP4lxvPTH2TYp/1m/jwKaDcIC6kFDzRefvDPkuwaq7Av44gXCRFXp
         wsiG20tbak6HFbC/UTyXb2tVcvD6CIMT6EAklD3OCoB/1gUk4wVON9izZzLrF0Z2cV+d
         9QtZLwlaUPeD18BgclDe08WTjY88MHbXwdmrMlfZ64kxTgRIeDadf8CoZdNiVpweVmYl
         tVTq+nL1NyJ18+7IYrxAIP4Hty7KXQDwdsQy5lmTWT6fNLE19heOcrCOfJYAZspSCPnQ
         aKOw==
X-Forwarded-Encrypted: i=1; AJvYcCWdJhgYaILSRTmkY8Sgxy/iwh+S7efF41Ll7cJc2JW+S05IlEdqhPbQFZDWOzg6L6BYFhp1DsylwWg6ZNA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkuyEJG1gbc5/dELMFUnbif/KfvpnQULMoMYeokk1JcFWxc2IL
	E4Pz1IeES81h7U3/hlPRgtXCvyhYq5NSelwhRX4Fjywnycq1Y+X2u0sBP2QI5RlTSg4=
X-Gm-Gg: ASbGncuIxq4CV64wwB+GHvIQAcUJSUBz6pm+VOLW17mIqjEFFsle4eDazTWCe/akxwQ
	fb3W4okwSFyoGdnt1T2ENYeBOKM1QUovzle4SpXW9Swyxiv/3bQZdKtFkBXMokx+PGLh/3OVywz
	7HIJ/37rClxA2RIUXecRNMovdceBkAiCRI5HjeLP2aqSrBQr/7nrYC/NzN3M7B/1w0qDdxNu6ld
	6vwy41iHiXMEeQyC3aVUd4xGJWa1FW4ypP5Z8MhsombYbJyMCoODJJZjruWASvTSwxe4XjYe1Jp
	f7lhFJnLuLdBd+HAJ5uDmp11Gv3lmER0x6bk2HfEREFbLyDcj/iw2Er+APpKg0Rsu8EcF7EKgKL
	wUJVGcu8SpuortIX1XYBURvGaL/qIMjKfhbUy3WfuM93OGGIEsOyzK3RGtBaPC2oO7HhR4YV6K9
	mdziCqEKxbrWOpzLAr
X-Google-Smtp-Source: AGHT+IHvY8MI9FmdOJKvxqkZENHKXLT9a+Nnec2BglSSWqYh5CgLTYL8rIj1yUpyF0vSSs/N2lIokg==
X-Received: by 2002:a05:600c:871a:b0:46f:b43a:aeef with SMTP id 5b1f17b1804b1-4711791d923mr117704085e9.38.1761113226858;
        Tue, 21 Oct 2025 23:07:06 -0700 (PDT)
Received: from orion.home ([2a02:c7c:7259:a00:11f4:2b3f:7c5a:5c10])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-427f009a75bsm23794067f8f.23.2025.10.21.23.07.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 23:07:06 -0700 (PDT)
From: Alexey Klimov <alexey.klimov@linaro.org>
Date: Wed, 22 Oct 2025 07:06:42 +0100
Subject: [PATCH v3 2/3] arm64: dts: qcom: qcm2290: add LPASS LPI pin
 controller
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251022-rb1_hdmi_audio-v3-2-0d38f777a547@linaro.org>
References: <20251022-rb1_hdmi_audio-v3-0-0d38f777a547@linaro.org>
In-Reply-To: <20251022-rb1_hdmi_audio-v3-0-0d38f777a547@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
 Srinivas Kandagatla <srini@kernel.org>
Cc: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-sound@vger.kernel.org, 
 Alexey Klimov <alexey.klimov@linaro.org>
X-Mailer: b4 0.14.2

Add the Low Power Audio SubSystem Low Power Island (LPASS LPI) pin
controller device node required for audio subsystem on Qualcomm
QRB2210 RB1. QRB2210 is based on qcm2290 which is based on sm6115.

While at this, also add description of lpi_i2s2 pins (active state)
required for audio playback via HDMI/I2S.

Cc: Srinivas Kandagatla <srini@kernel.org>
Signed-off-by: Alexey Klimov <alexey.klimov@linaro.org>
---
 arch/arm64/boot/dts/qcom/qcm2290.dtsi | 38 +++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/qcm2290.dtsi b/arch/arm64/boot/dts/qcom/qcm2290.dtsi
index 7303aff33814f256a2ea09a71a640db466370eff..a378bd01099633db49051a87d0b0f06e07c3ed2c 100644
--- a/arch/arm64/boot/dts/qcom/qcm2290.dtsi
+++ b/arch/arm64/boot/dts/qcom/qcm2290.dtsi
@@ -19,6 +19,7 @@
 #include <dt-bindings/power/qcom-rpmpd.h>
 #include <dt-bindings/soc/qcom,apr.h>
 #include <dt-bindings/sound/qcom,q6asm.h>
+#include <dt-bindings/sound/qcom,q6dsp-lpass-ports.h>
 
 / {
 	interrupt-parent = <&intc>;
@@ -673,6 +674,43 @@ data-pins {
 			};
 		};
 
+		lpass_tlmm: pinctrl@a7c0000 {
+			compatible = "qcom,qcm2290-lpass-lpi-pinctrl",
+				     "qcom,sm6115-lpass-lpi-pinctrl";
+			reg = <0x0 0x0a7c0000 0x0 0x20000>,
+			      <0x0 0x0a950000 0x0 0x10000>;
+
+			clocks = <&q6afecc LPASS_HW_DCODEC_VOTE LPASS_CLK_ATTRIBUTE_COUPLE_NO>;
+			clock-names = "audio";
+
+			gpio-controller;
+			#gpio-cells = <2>;
+			gpio-ranges = <&lpass_tlmm 0 0 19>;
+
+			lpi_i2s2_active: lpi-i2s2-active-state {
+				sck-pins {
+					pins = "gpio10";
+					function = "i2s2_clk";
+					bias-disable;
+					drive-strength = <8>;
+				};
+
+				ws-pins {
+					pins = "gpio11";
+					function = "i2s2_ws";
+					bias-disable;
+					drive-strength = <8>;
+				};
+
+				data-pins {
+					pins = "gpio12";
+					function = "i2s2_data";
+					bias-disable;
+					drive-strength = <8>;
+				};
+			};
+		};
+
 		gcc: clock-controller@1400000 {
 			compatible = "qcom,gcc-qcm2290";
 			reg = <0x0 0x01400000 0x0 0x1f0000>;

-- 
2.47.3


