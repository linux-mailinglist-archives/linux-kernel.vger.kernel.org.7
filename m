Return-Path: <linux-kernel+bounces-781485-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58CEFB31315
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 11:30:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B9605C2F0E
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 09:27:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBD1D2EE5FC;
	Fri, 22 Aug 2025 09:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YTLr5k6W"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 042EF2185A6
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 09:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755854804; cv=none; b=jMCP5Z8WmmvtrYlxuOsXknIpjq7CIjTTiv5sGbjRo42oyCOlH4sswTp8PAS7VAa2kQkAuvSLR7702UpsB3AaTH/CdfMihg0Des/7fVk/fyiKvqT5goZHjBfHBZtxV1EZGZS2MDknHL5OlwhTXezth+gkD8Q+bwh+q/gSg3TQPoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755854804; c=relaxed/simple;
	bh=odok1NB/os6Op96Tw20uQsfm8O8IHcGhS2hw5yQh51U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=i0Xq2LhZTt0A1vI/XYDklp1uoJsM4DU+SHfpxAU856ME1Im2iko4+FGI/AuNNs410UKXAWoU+WPCQzxCChjSvIOKIJUwBicpnl7NlkBckvOm/XMXSHbkgqeg09o9BWknr5JvrzYPw8p9AUpRRUPB97O0dlxlW7nF1vv959QzID8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YTLr5k6W; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3c68ac7e1c4so70141f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 02:26:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755854801; x=1756459601; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qqy2gm0eQAUZyJWlOlSTZmK8sdI8rKYK24OGN8Pqm2g=;
        b=YTLr5k6WNVbvjOz7+hBYJ8jSi29b5I4q6zEbwbuwJZUz/y+18BEs5Me+/TYu6KsREL
         w+EyFDemejc9PgG+n8/mhrEiyNftfjMlMTs+/+4IpCt0ZgWivyDyOHF3u8By3Dq1770f
         ByPfE6/NUZ7xOObtQ2hNuMkdaHpyI9FC2U5xOK9OcV+da9vR/AZELOQMI9AHNpSOs4I/
         JMjO4nWXhwgeRj2EVdU40qMdoIue3w0gi5a3WTLgbW4DQ5Y9JQPr8eWS6CjDP81F47r5
         MZwGPqP/ejtqfkY1MvPf+KEFPILQ+K4QwvvbBMvFQnBwVMrUX9mXHX+MlIPdKtQkwTUo
         QeXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755854801; x=1756459601;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qqy2gm0eQAUZyJWlOlSTZmK8sdI8rKYK24OGN8Pqm2g=;
        b=uiz1UhRXWQNzMtWb1hlj9/i3WqBd248zo+K2NnkfLozS8aqX08vaIjmnInfPXarTWM
         K+82h528gxossqTbPB5dX+pe4d1EQLUxjzxEhOyMA1O69F3d2FR8VUSCKTGJEkOT3A8M
         ayS0iDJ9Hb7S2/CG8zVH/8hMIEG+p0SIwd+Csvf2+yy3V+gBJZP8Sxwy15HkjZ19Uq4Z
         v8ObTUCU1BSzq0jNb28+niB8925J+bHTEA4WGAX8wFa/w0CIt4yAGJ3phdGEW2Xy9KeQ
         wEgwuegf8qRwpex1P8FFI1t3pQ9ASb76ASbbfH8/8ADphqJ6AdpsVmouDqQmSjFb8IlK
         wjpw==
X-Forwarded-Encrypted: i=1; AJvYcCVVDv1pc/TXXERfCobVn2aIUx/cgFirEqRrSERBI1XmaAxwQjLWBNOvxUco7fG9+F+isHxIuwsMsEgBIQo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkusvlSJHpar1lMbdKxuv/QBhjG+KppI1H93i79DW+5NwZVqAs
	Khg5co1fY5tRDcd5L1oTVntr7UvO/R9J8WKyyWaB9q5JuLjsSlcEtl02hG1c5nVYuwo=
X-Gm-Gg: ASbGncusSClEz/AA4BeAWiLzX/aTysD3i71KzeF3kArQVyAN9u33/IYXkRNhmKatMFd
	Lbzw+NaJxhG3RhNvqb6wIb/4N7ADc2Z5QlODz2ZusaUd/BMLJEwdmmXwCyasGsupO0MJmuxeX1P
	NGhY+IK63eOVa0g1MO20W1WUZ889PrT7bNRXL7HvfX76eUX8HdenMAzqAOfpubTB773wjWdSrng
	PEaWCGFWVuB62tAj6IWnEYHhdelXZs3GNRc9J/Mmev8opq8yNWbm8F94ZL8jkk77c9nWQz/ILY5
	qwTp+F0JWVk3jeOiDKyZsp/o/P+ky5RrifJaJLF9iwbCMlAEfBFUFfXUerAm4Q1S78cPD3Y4pbW
	luwzqB/BmBOu+FHX1upWxqAw6metOauf8AvkdzZPjghIK+BZdthK1dw==
X-Google-Smtp-Source: AGHT+IGbDE4Lbd1UX80jxSMFpqE9JxKaQx6eti4GBEaGPewm18SC2YL90lrx67QMMt85CnHr/UlVog==
X-Received: by 2002:a05:6000:2f86:b0:3a4:eda1:6c39 with SMTP id ffacd0b85a97d-3c5da931b49mr1552694f8f.13.1755854801333;
        Fri, 22 Aug 2025 02:26:41 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:3d9:2080:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3c5826751d5sm3297007f8f.14.2025.08.22.02.26.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Aug 2025 02:26:40 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Fri, 22 Aug 2025 11:26:34 +0200
Subject: [PATCH v2 2/6] arm64: dts: qcom: sm8550: Additionally manage MXC
 power domain in videocc
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250822-topic-sm8x50-upstream-pll-multi-pd-voting-dt-v2-2-28f35728a146@linaro.org>
References: <20250822-topic-sm8x50-upstream-pll-multi-pd-voting-dt-v2-0-28f35728a146@linaro.org>
In-Reply-To: <20250822-topic-sm8x50-upstream-pll-multi-pd-voting-dt-v2-0-28f35728a146@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Jagadeesh Kona <quic_jkona@quicinc.com>, 
 Dmitry Baryshkov <lumag@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Neil Armstrong <neil.armstrong@linaro.org>, 
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>, 
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, 
 Dmitry Baryshkov <lumag@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1337;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=EsER8r1zfXvJMrf+Uq1BesZ7c/Gb0QgKo2HXPPO6s9I=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBoqDfMqjSIJ7bP/doPod2Mj3wwzh3Qf3osoWLsCS1d
 ixrH29aJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCaKg3zAAKCRB33NvayMhJ0alBEA
 C2NTr0NtKNc7KILPIi8JaSFgL5XqjIIFxdqNt2XXo0FHI8d8iUtbRxIQHbgaPsNpOOf6FEFkNZRUbX
 CYctfu33qeZMlp9Kn+7veVvUBU5NX9kHmMoqa1ccVsFESnKpuJDONCov7OV+5i5mmefUr0EdHsg6aJ
 Kc2VpQAE2FwkxDqminFUfXafC2V+21F3ILyYjLsDy9/t2c6l6WelR9YQIk+qVJXrHjJPpOev5/ZnDY
 33fvvXbuqArxf1xKUC0BaM2fqHHeeUMSdV5jwFcRMGVNlSK/LCNJINlOm5LYNIDdM8yt1dSJTwQw0S
 ZaXvvuerytwubDoirsGw75qIQeH8R0kZpJ4Vy0JMAegB0K+BfveBXJgR+vgwerfUbNoz/L7zijFpvj
 k5NZe2Z9Vd608HnNqX/fWq5H70zboi68C+vDzur+yL0pHf4MuARlIsX/z2mMccwI3KovMaMbl2p4wZ
 Rm1xt8w8hsK0p9eG+YfgoyD+B9mqp2AwDrCUitkwdNV7qzgmi1t9jenWMi5tk9mwAYb8oVqSPQHYfQ
 C1MmRgoid6CvCMqDbAn4Pw6ALAT1PnNM7ZmRVYo2cHNt9SXS1NAyslhMoZ9JezYKAwFQ75sMa2OjVm
 GpnzLUBnUR9wNqCMVpIhkfMtKqOwh57Bq0mO3r7zqsWBLD/BA9uqUgdGsvRA==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

From: Jagadeesh Kona <quic_jkona@quicinc.com>

Videocc requires both MMCX and MXC rails to be powered ON to configure
the video PLLs on SM8550 platform. Hence add MXC power domain to videocc
node on SM8550.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Jagadeesh Kona <quic_jkona@quicinc.com>
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8550.dtsi | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8550.dtsi b/arch/arm64/boot/dts/qcom/sm8550.dtsi
index 38d139d1dd4a994287c03d064ca01d59a11ac771..d4bffcc244c98e87464cb2a4075c21f3cd368482 100644
--- a/arch/arm64/boot/dts/qcom/sm8550.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8550.dtsi
@@ -3307,8 +3307,10 @@ videocc: clock-controller@aaf0000 {
 			reg = <0 0x0aaf0000 0 0x10000>;
 			clocks = <&bi_tcxo_div2>,
 				 <&gcc GCC_VIDEO_AHB_CLK>;
-			power-domains = <&rpmhpd RPMHPD_MMCX>;
-			required-opps = <&rpmhpd_opp_low_svs>;
+			power-domains = <&rpmhpd RPMHPD_MMCX>,
+					<&rpmhpd RPMHPD_MXC>;
+			required-opps = <&rpmhpd_opp_low_svs>,
+					<&rpmhpd_opp_low_svs>;
 			#clock-cells = <1>;
 			#reset-cells = <1>;
 			#power-domain-cells = <1>;

-- 
2.34.1


