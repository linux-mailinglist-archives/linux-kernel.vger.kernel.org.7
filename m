Return-Path: <linux-kernel+bounces-723491-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 366F1AFE790
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 13:23:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DAD265A3EFD
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 11:22:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37F8A2BE626;
	Wed,  9 Jul 2025 11:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="04dw6U7E"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 820E4291C2B
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 11:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752060161; cv=none; b=BGIbgAkrCVxnOiibnYzGH9G8GrbdQGwffJlIFDCzpi/+1wyUyqFH7Vz3I6Hsb/9HVgOSN0l01mcMjH/RAuvJPXGDTzx2hSj6qzHR8KP3zQrYr0Ul01AXnfKoyt6xrA/GaR7LzWdTsRQHuzT/LXqYHuXTUOmG4e229Fw/I9ukzS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752060161; c=relaxed/simple;
	bh=v8W3GINcz/JRFuzQFTXnjEqR4QhQwIRLE6x327OiNU4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XokcpilecHvI8Y5DX24KzSBnUCXeLagHDeBiW1NutK8DIdQtcelgMppBVpFylM2ytuQHI9o2+XkaqSQc+E9aB1LAF23Elgx1BFTLzrXyCQvqTGkC5uuNNnUpTdYv0jqMl05mIIupFLBeY2Wsq8En1sxMfPvi4YB3iTzNfN2/kP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=04dw6U7E; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-ae0de0c03e9so932815666b.2
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jul 2025 04:22:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1752060158; x=1752664958; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/4dOumLNf2zlAbgSAyMPBNKWH+vCfQ2X+/X62wCBIXk=;
        b=04dw6U7Ek5LafvOGTqY0m78dHoV9wA1VGICE/nKznHED4BeJFMVmQLtrFoWgCleQgf
         7/VWIGFQsDy6+fVmn4nxdXklMjHnon6xqNc1A5nah/broM73B957q0XCooLAmkQ6bE28
         2DzHmqba0pGXDRNFRhUotZ8SvB0EK8QUfHyMfEAqkyMevdr+FaJJUXzp1fEDKLrie0ch
         QxK4WJj+lBVpS1MAoWSIHF4mwX5MlgcZRKKCn9GDacyzHg4b8b9TvG17aNTSl5t7kngZ
         5O2xf9Em9fBDcHyNuhu/3bseXRrnvxlvSMSMpAKchsECGyi5LY0wIRgXvMz8Xmv2S5hg
         xcQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752060158; x=1752664958;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/4dOumLNf2zlAbgSAyMPBNKWH+vCfQ2X+/X62wCBIXk=;
        b=cEYh51vrR5WYFAVV6ikHuY6Pq/rTnAdcPywv5E5CrEHAz2OTlaWri01qstmaVn8IOd
         s0r0/34u1SSiRFVeFkO0u/wc/OmUFueFgDPY/16qtIvttD1i1M9Ibv4MqaCHRERo7OD4
         aG9Lcz2LWWiqZMKGdt6YmQ+kaRIkGDfzDur3hGkA45Yn66QiDpoXa+g6R0afS42XLiwY
         k6fcBrxkbo7KsjCMD1Y/2jQ1xK6wKPiVEptGsiqsUs3nhDBotyq1NLXiiroGzisAcLXo
         BZUJb6rRa2oOzKhitXXNi3/0H+3F2LjI41vA6Q9LKKynz17uBGt1Dx+QnXycfNLekGll
         WMgA==
X-Forwarded-Encrypted: i=1; AJvYcCWxtwY7H97oEDYfFJAAKZ2ovx+FqrMONHXMAib3xfI+IAzm+BGr61BtrUb2rBAkTTkM4uUzbkJoghNRESo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxY8BnKwIsPtQBvZVo/AQSfaXhc2XYzAinM9ug3I6O9wIuksfCt
	o7G+PHSJZzi+U14SUlionmPGXiw7aPy75w7KVSSxs9iatPLg7tYlwrvnMqjS7fjrPyM=
X-Gm-Gg: ASbGncv0281peukkN1zYMH5x2p+9uvd1+a5ioWpC/o+kyxpUomtgUdbwtoPdEHv1ucB
	RTZrPV4X51U7oYZcUjJfI/iy4EPAvEqrleO0eDA9vy+lyWUErj3eXeJHly6AizD29mdtSavkwD2
	0JvkOX+PxfZz0tWTx8vvvELpZIxy/4HqQGsyEEug54lb0xmIeEn56QLk06CJrqJY1ugFBmMJ3NL
	GysBiSkY5qm9CMiBkfLzKnEiEQW9GLeyPra+iQh6dXn2klAMEVaooEHjYV+T2G5i32PqPNpkR7K
	sYs0SNGHW599kiSycQim8kxiRxhE1G4x4dCeL9to+TN1tl8JzmjF1WTWb44SZeDL1tMnR7lQBr/
	IU97V15HX1TUb0R7TrMNvOqf/9IDFR4G9
X-Google-Smtp-Source: AGHT+IH9vnwKDQS5PWwwot23KnBBMguALefUJ1bpdte4R5ZQwSrr0oNdJ1eGm7MuBqcVRYX5nvBBlQ==
X-Received: by 2002:a17:907:7e89:b0:ae6:abe9:8cbc with SMTP id a640c23a62f3a-ae6cf58d2b7mr206062666b.12.1752060157745;
        Wed, 09 Jul 2025 04:22:37 -0700 (PDT)
Received: from otso.local (144-178-202-139.static.ef-service.nl. [144.178.202.139])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae3f66d93basm1079861066b.4.2025.07.09.04.22.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jul 2025 04:22:37 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Wed, 09 Jul 2025 13:22:26 +0200
Subject: [PATCH v2 1/4] dt-bindings: mfd: qcom,spmi-pmic: Document PMIV0104
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250709-sm7635-pmiv0104-v2-1-ebf18895edd6@fairphone.com>
References: <20250709-sm7635-pmiv0104-v2-0-ebf18895edd6@fairphone.com>
In-Reply-To: <20250709-sm7635-pmiv0104-v2-0-ebf18895edd6@fairphone.com>
To: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Stephen Boyd <sboyd@kernel.org>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Linus Walleij <linus.walleij@linaro.org>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, 
 Luca Weiss <luca.weiss@fairphone.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752060155; l=892;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=v8W3GINcz/JRFuzQFTXnjEqR4QhQwIRLE6x327OiNU4=;
 b=Otrw6GqfkCGtNrkH58EJ4GUrammLwH2oknPOBewjtua7t9KC5rGMlkhlpPhzPUwHFelgxeMT3
 +qMFSSdu4mSD2v5n3Q0vKlNgtFDFVb2k3tYJ5KIh+u+xDXf114lit1D
X-Developer-Key: i=luca.weiss@fairphone.com; a=ed25519;
 pk=O1aw+AAust5lEmgrNJ1Bs7PTY0fEsJm+mdkjExA69q8=

Add the PMIV0104 PMIC which is found on e.g. boards with Milos SoCs.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml b/Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml
index 078a6886f8b1e9ceb2187e988ce7c9514ff6dc2c..c416f25c90d6d9f8404947d1fadef91cf664e666 100644
--- a/Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml
+++ b/Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml
@@ -84,6 +84,7 @@ properties:
           - qcom,pmi8994
           - qcom,pmi8998
           - qcom,pmih0108
+          - qcom,pmiv0104
           - qcom,pmk8002
           - qcom,pmk8350
           - qcom,pmk8550

-- 
2.50.0


