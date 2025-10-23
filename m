Return-Path: <linux-kernel+bounces-866833-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F175EC00C7B
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 13:36:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43C073AFA0C
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 11:32:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2B6C30AAC7;
	Thu, 23 Oct 2025 11:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="k7h6MOsa"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 163082FB99A
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 11:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761219160; cv=none; b=Bp5kDX/Qz+x8iH1BaP1OIEyUqMrbO4Nqc2hQVUCgGKFyflPjheaMM/cnVc+Q3+Omj32QTlIbRpFR3t6K5dQRMC/cvn9p0T140cJhRkuXatzYmRXOlWPnc62XUY4aILNzsHuLve91oUbkhtg5dOSoyi6Bae1/wD7gfGBSiH+DNns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761219160; c=relaxed/simple;
	bh=g+3CeFyje36vUYiPPwLlKha+0xvRznsvxy3KI+MrI2Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WJwHzD6cBzvE7wGZ6+xCVkrK3q4lkMpCLaj937i9/VfiVLnKrlklvXrz7T7qQSMI5wE3jZtlsgirHmY4fsTW61ojwO5wepl1jBaMx+0tp4fNZn+IJu7uIRwmmg4WgStbRixzG57x2FIcUE82uqJvFbA13rsndUdFKW1JP8CGTIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=k7h6MOsa; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b50206773adso51860366b.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 04:32:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1761219155; x=1761823955; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WDmWPTg7/WzUkcF+6ZlKfYsF25od0Ln4c+tVV2LpT0A=;
        b=k7h6MOsaOMD202hiBcaDQ0SqMtcXCNh/RCsUmN6q486K68eJwO7MJYW2g3+kBVktMj
         +mntqtWE8o7/tdXODOJW/OT317Z8ZJer1lqkZ74ke3FOWEmGUaGFo3403vFQDccmplCK
         /ZF2Z0z+LoJkFD9HxtVenwX37MShXoqH0UvxsAktcoejIkmQqsOyBNHsLgHWX2DWEiZz
         OFl3ogWByE1XBjVFtdzDU/XzoYCiXCGCS+RBKG7nYrK+TaqxdEEyEFGPHyUlnTMbam+i
         bgqk+DWQol8yjcTor+JQ16wUQnKH4lahhg/w4uT6aHNZoAecipohogGMKW7uu4r7UPOX
         nAvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761219155; x=1761823955;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WDmWPTg7/WzUkcF+6ZlKfYsF25od0Ln4c+tVV2LpT0A=;
        b=TW9JbBCUM5F3GMCPDtzjZekwyntqn5jW4AbiDrvzp7Od5kuBjTqOVBXJwJ9Itf3LUx
         rRoH/UXARFPwzSNIta1O522+NDxBZnHQLyIPEg/5GkNmKmmn+IxchKRkh/W69GWeatQe
         Uj6z3L3hVGLy0w5pDUK8AbrDAyZJeRWoU19n4h17RwKptkhp1biVpwNojVIT5lQMQe+9
         lDyWfGXMvUhtBrJcd6ASsNhuC/d4BuNjNP72aHwSx1KcfYWYyOAd/++es/ucVb8dgEt5
         sSv0YXsJT2v7Oaj6bV3A0YYIMjhRMFH4DG2AXQWE9q5n0rUVPMmnbfo0H9U2OOo1RTDw
         dU0Q==
X-Forwarded-Encrypted: i=1; AJvYcCXhNT7JN1tMp+te3C4cKVzP+BMWZQA8Rluav61DKF9cok2wSibDSKa+EI8UB6CvL3dnibPYffTMy5GOQy8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzN5Q+ukD1PX2T5MFhno69RP3P43330YSLr26rZf3P4FiukeniG
	C7OKa3IVzRgJor9k6WWKcuTmO3/8sc3sPKrpXFPNsXlT5+b8FL7CZK1EIOdIuSlrbUE=
X-Gm-Gg: ASbGncvWtjhQlAblqQcA1NRbkxwkoVbhKMxPEXxi6ko2JHGtVyl9tZ2e6g6Sue3bshy
	hxgUHrzcYpPvbg+BofwVwcWF3qBqbflJY/NvQK0BYJBl0zqd/ekFxMGJr9LxFpyMBAas5659e3j
	L9YxFYUrBesFyezSREgh2p1qSN1c/8HO75xQOGZoSkxbKD5wD2dAdC7QXhl96jHb4aHmJWk0fHC
	dnxaA7i2LCzrBUPFJKKLMlkzCtx0csK876AZ2UGtNvFUenGbXESE0P3SGOMPENpMjEQvctF606S
	kG1soePH/sbHigIISSrQCyobUFGNi/0kiFeHw9oTll7tDY0EpT/hgoO3vg/W1jLQpoZp2cI5QIx
	eBcZXIcc3TqlUvp2J/IdXhO0IzZGciBhh4nNViIljNRlup8cvzqveAzYkCjMnYCqYfs0Slk/y4d
	18CZKK+SlecdLDU9CcYtY6UTZc/GzXH8DKv6gCZxJrEVI9ZQ4p5dE3EjvF
X-Google-Smtp-Source: AGHT+IGyvy+vosOGhAVyW26FRy5VuLmJAby6oQyCi95CiOh6ji/6s6+Drjmz7GBaGHKaPJ1tX6zb6A==
X-Received: by 2002:a17:906:fe09:b0:b46:57fd:8443 with SMTP id a640c23a62f3a-b6d2c780045mr842584766b.24.1761219155404;
        Thu, 23 Oct 2025 04:32:35 -0700 (PDT)
Received: from [192.168.178.36] (046124199085.public.t-mobile.at. [46.124.199.85])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b6d51471ef6sm183087866b.72.2025.10.23.04.32.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 04:32:34 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Thu, 23 Oct 2025 13:32:25 +0200
Subject: [PATCH v3 1/3] dt-bindings: leds: qcom,spmi-flash-led: Add PM7550
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251023-sm7635-pmxr2230-v3-1-f70466c030fe@fairphone.com>
References: <20251023-sm7635-pmxr2230-v3-0-f70466c030fe@fairphone.com>
In-Reply-To: <20251023-sm7635-pmxr2230-v3-0-f70466c030fe@fairphone.com>
To: Lee Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Fenglin Wu <quic_fenglinw@quicinc.com>, 
 Stephen Boyd <sboyd@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, 
 Linus Walleij <linus.walleij@linaro.org>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, linux-leds@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-gpio@vger.kernel.org, Luca Weiss <luca.weiss@fairphone.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761219151; l=888;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=g+3CeFyje36vUYiPPwLlKha+0xvRznsvxy3KI+MrI2Y=;
 b=j89EwbY2JAhGXJpHxxGsH6u2oxbgZtWs6paN5vbiIuiZHuJEhqK/8I5HYQqEYX6szI52SCm3Y
 Da0QHu8QSSpD5Ppa/++qNNAHGINmzpw9AJwY/tzlF50tZIr7ncN9jqB
X-Developer-Key: i=luca.weiss@fairphone.com; a=ed25519;
 pk=O1aw+AAust5lEmgrNJ1Bs7PTY0fEsJm+mdkjExA69q8=

Document compatible for PM7550 Torch and Flash LED controller.

Acked-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 Documentation/devicetree/bindings/leds/qcom,spmi-flash-led.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/leds/qcom,spmi-flash-led.yaml b/Documentation/devicetree/bindings/leds/qcom,spmi-flash-led.yaml
index bcf0ad4ea57e..05250aefd385 100644
--- a/Documentation/devicetree/bindings/leds/qcom,spmi-flash-led.yaml
+++ b/Documentation/devicetree/bindings/leds/qcom,spmi-flash-led.yaml
@@ -24,6 +24,7 @@ properties:
       - enum:
           - qcom,pm6150l-flash-led
           - qcom,pm660l-flash-led
+          - qcom,pm7550-flash-led
           - qcom,pm8150c-flash-led
           - qcom,pm8150l-flash-led
           - qcom,pm8350c-flash-led

-- 
2.51.1


