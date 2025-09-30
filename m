Return-Path: <linux-kernel+bounces-837756-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ECD60BAD1E3
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 15:57:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D9DA1927516
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 13:58:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 292C7305040;
	Tue, 30 Sep 2025 13:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="KO4st/kh"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86C18239E67
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 13:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759240641; cv=none; b=FZAStV21ht3z0L0wt0x8TpVdqj3qNFaS2Qr0RFmom8ggAIZt5oUG8dZid8I6HUpKS+SSXGdLvKVxiurcGjxXLIkOWLrJSfoOrnglz0e7bprK6H/x44Wc2Gk/z34Ypmh4lb7raK312XFBQxmfe0vHGAy1JS3SWrO5/Na9jfrFfnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759240641; c=relaxed/simple;
	bh=1x84MG3B6+rIyLmlzbvcHx7tOGONlCSyAvhMbbN0B1w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ARODxj1Xj1N6oX+ap8HvXRQa8IYjdV6lhtH6cu519SaAckbNBbMrvvy9E+jUGSP+VQ6sOQfalyKJTrdJ6IglsKyd+0ldRuL8P0jtL8eHrCvsLt7B2GWZBrr8bdoSwYEGBpOzFOOaL+QM/w8ulE9FYtjLZ1A1FFahZl9pTwaah3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=KO4st/kh; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-636255b92c9so5797643a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 06:57:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1759240638; x=1759845438; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2xA4DauDgUbKo1WZQ953ToPUo77YTzWkhKxmPQMFvMQ=;
        b=KO4st/khWCNGzcSTDyQTFXvDYGQqP4S9fy7EoRTzrbUFs2wX1rxRGMDN2bTGQoXokW
         IKYZlYT78q9zUnteoMyk02boAonbSZoXhTo8b3zjBxH4AoBZBHkediqvV03X0a4G+jT9
         VA2cPqxy/ENKm4E1pygY88hqQ1JkG+p0MoYrMYjUFR3okQluhDXY3XCtSFzGPeEv1p/t
         WpH3K9ISTfK6ACJQrKcF/tPkJLCH2//W57MauxlaGW3+cHbYDLb3k/JieoCrRwiaUraP
         /6THhp4rsj9S/Jfof5GSIouL495OO9zYQMAZYFWZgO7VxOJ+CHCLpWa7HMEXPUcML/xt
         egaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759240638; x=1759845438;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2xA4DauDgUbKo1WZQ953ToPUo77YTzWkhKxmPQMFvMQ=;
        b=OeVClNkRgsq+Ajs2J6I1cAFwdPh1TTJ7+fGJrdCsjvorUU0fisoj15UKOg66PQjCeQ
         Tla5J67IF/vgjFNWYgmWM1qjUOL/JuhGWEtS8lKcNVGYVwvirYxTC8F3T9yN4x1atxS5
         5UJxahNniYI9s1/8ZXslg3zyIcjGtk86X8hTvzHOcW5T7e8sPIWE9oRx4dtj1+GP6Qjv
         S3wR7U5mZday6CYdrGG/tB0nz9BrzPyPyXYk+yl9l3shWJ8SWinDl9yz6jphx12Nj/Jy
         kRg/qanL28Z0IFAT1GmpbPuemEeNL/1aIzCaGgOUg412gnSuzkCgk5dlpUrnSJeZ8Lh7
         P4wA==
X-Forwarded-Encrypted: i=1; AJvYcCWCQAm1T87n1Wy4LFSdHedphXXgDxlYUZqzCBOM/jDN+Fio6QF5oyvI06/pYsqGhtyTsZcLRLRpTAAP13Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkiV5fI6ptzQeAjrfcQPJVZzLQKUZEPKfqHJTi1oD+MdnnR3RY
	xCGobwdDcyB8Fg95FAl+yLfMWc4JjVlPkKOsuXwjcLtBEzgGTQlJ/tg2GBF0xBvlfcw=
X-Gm-Gg: ASbGncu2u4u2O/Dh6huA+RwOVi7kVFyGuXhKuSrH9lPw3fK+TE2zri4oGN9U5AAFnUj
	k7pA9elapfZCU9N5uc307rOsJeohdOjoYEkzkXXWI/Yk2zxWCr5C5K7suRyB7W/QkoD8eMcRmHa
	lslgDNGqGtpaw1Junts8gHk9XkMPZ5wotZeXymfWlJOoO5KcZ6ulKXxO+kg9kOtFCWuVoRF4O1h
	ahtGB1KZFenQ26+qTwhBh8m74LLLXcs86XLr9w8p6wdOvrpJXZArUq+5vh8CEIgefCLVzKmOaqE
	A4WFYCSyRaVDZsdU63Lv/w8N3LEbU+udV1f+vCbTsukbwUsc53VdypxAtXS2MqtnxW4JlELdcc6
	RqyqcHfcqegBDjoXrNryjef9OTDWrHYiLK/pUcL09/Mq0ESnNMFk+Uytx3w+OKPovdoEqrQHLNf
	yQYpBlTDJBtl5+INBKbA==
X-Google-Smtp-Source: AGHT+IERKslKjdq0BrQ1VOkSh4EKFusUKWtXRtHjmXAW75SqlWpqvYfjUSZtYoVl8r+DZg4tRIiZLQ==
X-Received: by 2002:a17:906:391:b0:b3e:151b:849e with SMTP id a640c23a62f3a-b3e151b86d4mr767458966b.10.1759240637785;
        Tue, 30 Sep 2025 06:57:17 -0700 (PDT)
Received: from otso.local (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b3fb818fb90sm370234866b.63.2025.09.30.06.57.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Sep 2025 06:57:17 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Tue, 30 Sep 2025 15:57:02 +0200
Subject: [PATCH 2/5] arm64: dts: qcom: qcm6490-fairphone-fp5: Add
 VTOF_LDO_2P8 regulator
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250930-sc7280-dts-misc-v1-2-5a45923ef705@fairphone.com>
References: <20250930-sc7280-dts-misc-v1-0-5a45923ef705@fairphone.com>
In-Reply-To: <20250930-sc7280-dts-misc-v1-0-5a45923ef705@fairphone.com>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Marijn Suijten <marijn.suijten@somainline.org>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, 
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Luca Weiss <luca.weiss@fairphone.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1759240635; l=1168;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=1x84MG3B6+rIyLmlzbvcHx7tOGONlCSyAvhMbbN0B1w=;
 b=lREdBSoS00W8KHeYcIcLaMeAqfjHbVEtn2/Jd1CozYTiGlPwi9VXXkojQmraOODDAdyTDjxU8
 vLr9Etgr9MyCANvti2k7FWCn7e+pmM83++TnTyiW7tbMIOqoktosrWv
X-Developer-Key: i=luca.weiss@fairphone.com; a=ed25519;
 pk=O1aw+AAust5lEmgrNJ1Bs7PTY0fEsJm+mdkjExA69q8=

Describe yet another regulator-fixed on this board, powering the ToF
sensor.

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts b/arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts
index 36d5750584831d66b4c2faf6042e4cbb3274eca7..0a64e5721e092d1f3e4bb7329335704eee567761 100644
--- a/arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts
+++ b/arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts
@@ -195,6 +195,19 @@ vreg_usb_redrive_1v8: regulator-usb-redrive-1v8 {
 		pinctrl-names = "default";
 	};
 
+	vreg_vtof_ldo_2p8: regulator-vtof-ldo-2p8 {
+		compatible = "regulator-fixed";
+		regulator-name = "VTOF_LDO_2P8";
+		regulator-min-microvolt = <2800000>;
+		regulator-max-microvolt = <2800000>;
+		regulator-enable-ramp-delay = <233>;
+
+		gpio = <&tlmm 141 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+
+		vin-supply = <&vreg_bob>;
+	};
+
 	reserved-memory {
 		cont_splash_mem: cont-splash@e1000000 {
 			reg = <0x0 0xe1000000 0x0 0x2300000>;

-- 
2.51.0


