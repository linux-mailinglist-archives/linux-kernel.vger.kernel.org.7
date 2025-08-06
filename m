Return-Path: <linux-kernel+bounces-757730-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 54B9CB1C60D
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 14:39:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B934317324A
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 12:39:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A21928C5BF;
	Wed,  6 Aug 2025 12:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MVZP7i65"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B2AD28C031
	for <linux-kernel@vger.kernel.org>; Wed,  6 Aug 2025 12:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754483930; cv=none; b=itcydCbUsXFDQtZpL7NHlGK3tqwOX0DQULEcd4IARwF+3WG69z7wxcGTlEHhZqbWOg3gEQ6huqaiy3vi1BvWFs1/oWFzJV462uEsoerFFpjbNXtEwbHvQPP4zij8BkYhbT+hIuRxSQwOL2sr5w0jz9+uENFu+EQFAh5caYYi0N4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754483930; c=relaxed/simple;
	bh=Eu8xqyxmJT4cy+IkwFfzScYWzL17LKhf3pxRBEd5zMc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=seC4JDEqQMc9fRC96Q5emY6nbXWPYDUqiLf5r1r2xm/yep+2u5s0kBimbjT7OSruFtaGYS1LP5qZwdSFIaEqB4VKzWD7NzBQnBykO30rJvKWjBsR2ZXcleY5cKa7F2XIWPo067pE8hfK3p8OMmHjZYI8YUKs+UQX/riNMWZm3wQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MVZP7i65; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-af940717331so104340566b.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Aug 2025 05:38:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1754483927; x=1755088727; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Iq1dXsHIjnJQgOoLlFKfB9bYrlfRitC3gfcfuZAFbrc=;
        b=MVZP7i65XSbQrAR7rXu3inuUW1Bddbs9ltTsF8SR2YF8vxH8idvJS9C98eHFQozYwA
         yQxU/yH9vpW2JvRKWgh7JBKLTIjyOlh5ZkExISQGhpYfM6Bu3QryCMNwwxafDKg1CmHm
         /P7gDrLyhTDi++EUiPmyMXpIUKjfshgf6ElvZhDLoRMlfE7ur8vhVXvTdlOGACrffXAk
         yC9MSOPCezohWNu33Z0V7xXmli3Vu0o7XKWVCZE3Frv3thqkfD2+NfASDPUqC5mH756x
         qKqZfsq9vxXTtJb42rFKzVobRml97/j6QOdoOsIkxRbCmXasyFXvXoh45CsteyiiTMkz
         ojYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754483927; x=1755088727;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Iq1dXsHIjnJQgOoLlFKfB9bYrlfRitC3gfcfuZAFbrc=;
        b=U0bqcwe/xn8vfQGrCMJyjkXupMLJwXJD3tWhDwM4RMVPExD1Ojzr1hTcnge3p4Mucj
         HtIe/6gKXCnV0cA/KWWef4Snn3O0x3KjHnS+cFZzAud2GclXfyQvvhZKaqeN5KBT/pRl
         yutygDuW2+12Kfeh/fDGOc9U3c8frBJlPWRc5RrZ5w0YTxyCFNspjcSLoGcUT7DvS+x0
         15vFQn10l/+SQFZu/sTt2Wql6L+19EGJ1BnAX+uu5Gj2mr78bUXq+EWB6EDuItUpSxl/
         NmUjvBLpap3ZjJS4R7FFNlHg4IrbzYnvh0Uk79NxB4a3yWGXyFKB6xhd72cOUCqf6HVl
         zETg==
X-Forwarded-Encrypted: i=1; AJvYcCVIrP2gK9PxKxmg7XHdyF87tYAi4bMIvxdUxau1QtSmXv7F5Fe64avku/I7A/aX4V7XUVrNJO5qDMTFMDc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy13Hto4Voduj6GW/xtzH7jCYJi5wzsQ5gTx6IoBsODRxGeTp1v
	V8epoblgtIak1MAnWFx9Xc6ym+81tdHfyDohJTdYRm06sC/PQdGq4cZmP813cfs4Qwo=
X-Gm-Gg: ASbGncvZ9NqUb71BKHTSe49zU6m2655XCn5tUnL8oh53RnJGlc9IwdhOhg+W+marB+l
	jGjjLavPzepQ8mXxNG7zwzhiSzAQrwIBjBmZMqDUlKl/9h+m+Cd+WbixNl1dai8cQHggFVhjpqf
	KGRxshEc0NBRxj8QtQpOQDoq96RJRyvjkgKSHTW7cf6rz3sGldMPfZbZ26f1lzB7i0dn9c7vrvf
	D6NvfNdSqbVoKpeP/IVgcHFJtbu1LVEXZ5yGPhTtLAxwUP7H6Ldkjq5NgjjEHCEm+PpxtC9w8XY
	qxsihyPe+1xD79GyB+1pUp0IH2Td9qe4oSFja62mOgE3hLyTR+DBOBvOTblKgH9yUxWobWs0XB1
	JkkFHLGLftKMRQHTMyp5kv4+Cdhjxk//UcajRJJ8=
X-Google-Smtp-Source: AGHT+IH1MCcEAYbFWkRzhmxuZA3++Z7ES4Zu+n2T5+SGS8RGQVPQvJUlm5h2QcPvISw4DO4/Z8tu2w==
X-Received: by 2002:a17:907:7e89:b0:ae3:63fd:c3b4 with SMTP id a640c23a62f3a-af99031ce8fmr121559966b.5.1754483927349;
        Wed, 06 Aug 2025 05:38:47 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.218.223])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a21c081sm1083866766b.97.2025.08.06.05.38.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Aug 2025 05:38:46 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Wed, 06 Aug 2025 14:38:32 +0200
Subject: [PATCH DO NOT MERGE RFC v2 3/3] arm64: dts: qcom: sm8750-qrd:
 Enable Iris codec
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250806-b4-sm8750-iris-dts-v2-3-2ce197525eed@linaro.org>
References: <20250806-b4-sm8750-iris-dts-v2-0-2ce197525eed@linaro.org>
In-Reply-To: <20250806-b4-sm8750-iris-dts-v2-0-2ce197525eed@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1068;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=Eu8xqyxmJT4cy+IkwFfzScYWzL17LKhf3pxRBEd5zMc=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBok0zQvyzCAYOL7BMZJSO9B6MNXCHo9gjkmhG0e
 Ry42X5ZExaJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaJNM0AAKCRDBN2bmhouD
 1649D/43FW6NDwKmazwEJrMxnzlc3KeXTnZnUw07I4ESJBiy0o44hxwfLy+qUz638ISoPl6cUbb
 Pu0OMk+SYBLhRjOcMZl/TboRkcdmncXsH15/zZveNm7wO5Cx1fM+odrferMgRhMMF7JRP9N9qqw
 okPLTpatYigUIGGk/ArTpmGKdeA6RV+FnKDA43qENTcuXCz+ZFuvQwRvIF2wQ+5pQ0b2bNG86tB
 Y6z4G8cbcbD8hVL0OkF4KyWB2tg4Gm2bB0Nuz5MiFvf6lUWdcFRsxNjnL7PWqkPZogSQepR0qeU
 +IFCSPSZccr7Kdlyix6DwuMwBHSrYT10W5Bh2nEKJc0o66yunch/eIYDQTBxpyMCVJyYVVbIaff
 vZeyMn09U5g1qSoEJHuZgeLMeyPnr/PGNaFE2nvO1Du1+a9Kz0MyR8qJ2M8CEBCqAOcj/OYaBW5
 6wWxzOJ/C9DiRM3S78OExQp0vf/i44RgQOBWhf+PQi+QnWLjB4IpiDtSfVxcIdmA0tq36FRLB37
 pkHtn4vb4AYYMW14pDYBrjm+R6DRZzQAh2UMjMxUINibUYwYMbtyXVhAXigEu632g8NprkX448r
 10fTazC18qOPvUHaPWk+OhlU2WCEYwEV9gxIbwXcwXRFM5Ui72UgnPv11zqy3YeVQ1LQ+/R4e6G
 aNXF2QZvNbkM0TA==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Enable on SM8750 QRD the Iris video codec for accelerated video
encoding/decoding.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Do not merge because firmware (hard-coded in the driver) is not released.

For Rob's bot reports:

qcom,sm8750-videocc bindings and clock headers dependency (will fail
build):
https://lore.kernel.org/all/20241206-sm8750_videocc-v1-0-5da6e7eea2bd@quicinc.com/

qcom,sm8750-iris bindings:
https://lore.kernel.org/r/20250804-sm8750-iris-v2-0-6d78407f8078@linaro.org
---
 arch/arm64/boot/dts/qcom/sm8750-qrd.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8750-qrd.dts b/arch/arm64/boot/dts/qcom/sm8750-qrd.dts
index 13c7b9664c89cffb68a1f941c16b30074816af8b..369623f8e4c921e99532d5e22fe9f0049746ebaf 100644
--- a/arch/arm64/boot/dts/qcom/sm8750-qrd.dts
+++ b/arch/arm64/boot/dts/qcom/sm8750-qrd.dts
@@ -813,6 +813,10 @@ vreg_l7n_3p3: ldo7 {
 	};
 };
 
+&iris {
+	status = "okay";
+};
+
 &pm8550_flash {
 	status = "okay";
 

-- 
2.48.1


