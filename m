Return-Path: <linux-kernel+bounces-845870-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B38E8BC6607
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 20:57:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F7CD3BD3FB
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 18:57:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F5AD2C15A9;
	Wed,  8 Oct 2025 18:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UyG4K0GJ"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE66C2BF007
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 18:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759949819; cv=none; b=oNzrrHH7F7HpEeZm8Q9cgCWHTjq2RK9Ag0mAsVyWg/ukqs55mKJbjq1kMl89MAWD+ue5f6vAQtb6ULCqirBA6+nXaiXHsooFC2JlApG/hyA2LSX65BiQ8Kn9Zw6sd6v1gbPo2wi4E3OMwIwI6kgM1BRuzXdnQjWtPv+LLaJfESY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759949819; c=relaxed/simple;
	bh=f+9F2VgDwpt+eIZsiqDos0F36iTHtkLjFiXyBcqS6uM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GmxVDDeuWyV9iWJL0TMIhHTKY+H5ZE5oofxkC6wqM/tNev5l1r5ib+8IHpcQeARIXmch3qc5oHtORm8UnrlfoPGX0jYcpH4iOTL9ufmSw5BCE54y9WDZiDpQMWPQ0YeEh7qP7HSbnOLgHCJRrdjUlJgWiqrVQ669+OpSQpwRDyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UyG4K0GJ; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3ee12807d97so281298f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 11:56:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1759949816; x=1760554616; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RP5ag3QpkMJrEI5cmmcvESLNbS46ev4g4xZc39EVqhA=;
        b=UyG4K0GJCmgWVLlEE3HkE7t7g0GDNfpshKXAL3Y9ok0wVrSxo4KXu0Kq3K//C4CfE0
         +KPWqg8qIsKfHHzC2R8RxWhT5NYG78yx+0TyycfYMGvP876VzYKC2CQ3w6clZhondeiM
         gTa4XscBhHyDWySuFzlDVaaGkqPteclMZPFeccOVKhvh4Nkg6/xCPAIUgxMTIzOTxnms
         vdCPffaA7XB23cBLMw32RHL2K8WELs+48wZyKG29j5dN63Oin/eXlTky3ja+kC9Nmn9A
         jJzy798Ook1rFkNgdXHtAoubo0kOZztTJvc62qEgu68+l2kjcHzAh8A+xoGmfnYyvrQs
         Um+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759949816; x=1760554616;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RP5ag3QpkMJrEI5cmmcvESLNbS46ev4g4xZc39EVqhA=;
        b=vXsmvHRMJ9SYwfKp+0FZC9xpzFtNwx98DG8LL+eE8NciiK71NUdA5ya3jApjzgiKrU
         VI/bKrPw7m/8/LLkvDrbvS8LbWF3MBVuS5CDHEwCDUOWd6r6/tjpT/2ykTVBSbNZSbef
         yWDg6DbtszDyuaWpsDAshpxYxnvq/UII/JgxE+jhU2AI83ox/6aJActPD2Acd/9Y/ywV
         sN+R97PaFzaLMWukzqe8PaNTguLEYzWLKiHGWmgY+hKefolWhN59qAXXq2IF5EXqhvTp
         zdUvoDbofEfjFLnOcLNADcAtd8IwPS3UTtQKAwhl8veQyIi1gtwQc3/d4qDC9+MepTiJ
         AklA==
X-Forwarded-Encrypted: i=1; AJvYcCUn3sxAb4AQUnO3Bclw5S5/FwwVNL0Fbnum22qQPVHBOy1j7eG3NK3NrseRqtV879RNWFQtdNfBvqlHANA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMUqe8kH4OZOeG4ANAzIz62nQLLkaJA4MfoRFCH375b/DW8yoo
	qiPBJRmpwpEo34dPQENKa1b1dwDKAI1Mu5hN56E+KnaOdu31FEQUWWdHgDXClanNeHw=
X-Gm-Gg: ASbGncsj7M0wuVCKf9WlukKIO3aG25HHen1GXdONxshqnYGCn43kV2DbPqHh0q4n6LZ
	0EVAHGab9bgVNNewAjm9Ot/RRwzoO3jFr02gi5NT+I2bQmsWa3qAE+w6M+/TPqI3sSBXHqAXhEw
	K1uia5M36MF+BakRrURGkh+ohz0PzcDKVS1pt9GcnA8CPRUHclZfGLjm3zDyo+xXyzTLqhspTph
	vRzKd1D0hNc1Q3hArTCk1+w2sQziRwW4LXbhM6y/Ii4zTGI/uS938UjmAJ5ou5BJe0NA5ays/hp
	C5TGEJB5YraX4F0SVLpCUp2hVgRHJzOyB3Iq1mo/ofeHm1eceE0folRvE5eWkXHqyGHLxmUSiq+
	QSgi85t0xtgM4ET8nzME7+j6J8RMat91hH9wk966qMqv0Gtb2/fpqEDFle4eR8obIA973e19ORs
	O/Qt4Wcw==
X-Google-Smtp-Source: AGHT+IHWb96t9jX27gWJcDQD4MNIhLEngNzoE/msC+TkOtH0mdcANE6Zxrpt9MlR78ciVFNKsFAmYg==
X-Received: by 2002:a05:6000:40df:b0:425:6865:43fe with SMTP id ffacd0b85a97d-4266e7cdc9amr2754132f8f.2.1759949815845;
        Wed, 08 Oct 2025 11:56:55 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:3d9:2080:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4255d8e96e0sm31029735f8f.33.2025.10.08.11.56.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Oct 2025 11:56:55 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Wed, 08 Oct 2025 20:56:49 +0200
Subject: [PATCH RFC v2 2/6] ASoC: dt-bindings: qcom,sm8250: Add clocks
 properties for I2S
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251008-topic-sm8x50-next-hdk-i2s-v2-2-6b7d38d4ad5e@linaro.org>
References: <20251008-topic-sm8x50-next-hdk-i2s-v2-0-6b7d38d4ad5e@linaro.org>
In-Reply-To: <20251008-topic-sm8x50-next-hdk-i2s-v2-0-6b7d38d4ad5e@linaro.org>
To: Srinivas Kandagatla <srini@kernel.org>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-sound@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1574;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=f+9F2VgDwpt+eIZsiqDos0F36iTHtkLjFiXyBcqS6uM=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBo5rPz4GLKtV0DtesmpGxsXgECs16ymYSjumw4wgsc
 vfThG5eJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCaOaz8wAKCRB33NvayMhJ0ZLzD/
 0bRSvXEyLLXfAwLKWsNpmQsAaFhX8F8NRrnjNaxk8622UJm71//YRKdU0Es1FP09I/0kVPcR6jTv81
 nl8BMIcekWeK5SZAWy0AiANgSiYD0qTpW2C7DEx3wG3Fy1g/eTxwF6a1WRcLRl5rU6jhU90tO3+Ubq
 7LHfVwhwjxLYE/H6RsWk3ugmnUOFpnJl4gQ4qalESXD6uinXy3N52kz5afoJ3XN2sl6eKLWcns9w8w
 ny/8L5QssVB49i4asPTZryswNe2d3brx3tl8gIdEk3TYvwz95sjPBPVBktwYqsRRHj4DF6qS9cgd/w
 76j1lgdHXesQvgAu/4N62Al/n5DyxAcYNZmmBmr/aG7/3XZG1tZDIXMTJKO/QEUYZs6nuorSjZ7SHE
 POdS2lKxmK/MdoK6ki8libopFPRB/Inbp7KxeZZfwrem9edlCEi32Ql5AXivRvcWscTVPRj3oYVvhg
 qVJrgsB0nRAmM/xTGlgwr6jD/DayS6KKHiHIrryxcKp799jcKnjuY/ZuwWrqLOXAhAY1TS1uevrp3M
 W+nLyKasqR5+NflkS06dMGpf7ewhKdKIGO0eQJPM/qZrLOGt5Fd5w+3WIpxpu8Qzaf0+6Fngj1ZKg6
 xyMGgQg8MyMwWSyo0hQB+GW/Ux0hLX5/V4bWJEFo8bBfNzL0q3P5lckgXslQ==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

In order to describe the block and master clock of each I2S bus, add
the first 5 I2S busses clock entries.

The names (primary, secondary, tertiarty, quaternary, quinary, senary)
uses the LPASS clock naming which were used for a long time on Qualcomm
LPASS firmware interfaces.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 .../devicetree/bindings/sound/qcom,sm8250.yaml      | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/qcom,sm8250.yaml b/Documentation/devicetree/bindings/sound/qcom,sm8250.yaml
index 8ac91625dce5ccba5c5f31748c36296b12fac1a6..d1420d138b7ed8152aa53769c4d495e1674275e6 100644
--- a/Documentation/devicetree/bindings/sound/qcom,sm8250.yaml
+++ b/Documentation/devicetree/bindings/sound/qcom,sm8250.yaml
@@ -64,6 +64,27 @@ properties:
     $ref: /schemas/types.yaml#/definitions/string
     description: User visible long sound card name
 
+  clocks:
+    minItems: 2
+    maxItems: 12
+
+  clock-names:
+    minItems: 2
+    items:
+      # mclk is the I2S Master Clock, mi2s the I2S Bit Clock
+      - const: primary-mi2s
+      - const: primary-mclk
+      - const: secondary-mi2s
+      - const: secondary-mclk
+      - const: tertiary-mi2s
+      - const: tertiary-mclk
+      - const: quaternary-mi2s
+      - const: quaternary-mclk
+      - const: quinary-mi2s
+      - const: quinary-mclk
+      - const: senary-mi2s
+      - const: senary-mclk
+
 patternProperties:
   ".*-dai-link$":
     description:

-- 
2.34.1


