Return-Path: <linux-kernel+bounces-731368-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 65406B0533E
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 09:32:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 60C64189A416
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 07:32:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB42F2777F3;
	Tue, 15 Jul 2025 07:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="BGYnPXzJ"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C03D7274B29
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 07:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752564593; cv=none; b=Lb2cAPk342zuZcrISojRN0IX/nmaa1fTW58tFsJP31RqEPms2wFyrbsW9NwQWZEetKr/zVr6aBg8ryumRyGHxfMeiv4BKk4HtRM04mfn/MpSiQQZ6/rtP0kIDeeMQa3hZ24icEUGutQEon0naMuZTakGvMgH9Y97t0Rm+2qR5ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752564593; c=relaxed/simple;
	bh=sF0BBqSfmmjGnkvMWcmZuM22C376Bznvzv1cD7u8WVI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ezHh1JOMwWqK47MaXtTzpH/7/z07DryTc3TcUNTM9TKxOqhPr1Zl4NaTGx5Zb/xwsfN/K5EmQPKLSQaqJm4mNVQCD7gEtxuzszag3yVCaHlTnXM7XyGSbOKEzu2oVfG0RRWene0VkHUuuW0Q/BCfDu3GOtbR0DcAezA2N+vqv3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=BGYnPXzJ; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3a6cd1a6fecso4913088f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 00:29:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1752564589; x=1753169389; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gMdbbj4BEowCYzs/Z3M6B78NShV/42oHTUmjX6X1bd0=;
        b=BGYnPXzJqVh5O2j8Zp2czkrFZebhECxO+QZiatbUk+MX57bX1qXDVHy8/WVgiuxWyv
         qCyT8pT1M/SjIT9gZNXhwuhM9P2pctwTphybsKo2HXlWs56iwAyDUcHKR3PWNLokktzg
         IB/um+6zfynUQ7GTywEaCXDCyOcHCOp8VZhJy3V+b3qqAn755s93eOtrbc01ZvMMTrle
         kVjU3IXQeJrgKbb8HPWPDUilk3n4FL1as2/xnmYAuBzIWoyWv7ITERARInI2SMBTBQgs
         Z/6QqjkclDGxrFWMQhrb05Op8HRRBBUIPaEY1VDZF9A6I3u7TSEjcy5pYQAtNLkTLb8Y
         S45A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752564589; x=1753169389;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gMdbbj4BEowCYzs/Z3M6B78NShV/42oHTUmjX6X1bd0=;
        b=FilaVEjfgsZwAmnOFr1YCynZPwzdL0Gbmo1mG62FwqN/NVcQOe723mWSE3A5OOCiX5
         5u1P87v9peChe6KDXj009ksgQqUwtbM1GYA/COAdbXML8s64Zh4/99PApD5ppVFKrvmm
         p9aA1SzYduC+8Hj07aWCOlf32rccXM2lHKcxcS0jx2rXNyf39233xXHElDJxPS8I3eIX
         oV0H3rcIUs7veA0e1mj2fghiZrU1c3seZDWoZ6+Eeh9p9MiyB4DfP3Qml4ltWoCMioME
         zPMCCt1dNWWa5N5imp/P/5XU48IIyFIFHC7fDMdpXdGR2XsN1Y5xdiFA/SbOiuELIClb
         VvVA==
X-Forwarded-Encrypted: i=1; AJvYcCUllgaPMotCFVprDWGK78fgk6k8mwll+jwuawqOFizKWkQUZd2AwGBc82YtpN3I9vvTmwMMkpqNEEGcDnA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2GsP6LeiNvRdFRNpS+srGVtusY9CgGC04krpeqiqy24lgnIf0
	DBTEsMsGhWsGF74RfA3hP3K0jELXWWnGqK2zMjTCSwTFGOHgZfTHVI0gw8N/wKS8nOM=
X-Gm-Gg: ASbGnct6FHMkLHWUt1r8loPj6J+9FoNL9kQLA1A27KFKyI9OpSvgBccXe9FaMSkSitw
	teIaax6Qqh9Gwlgp5gxIYCtsWAt6VeIYhX5if2CoWVQ7pvrr8yf2QLXwzbVVEPzXalUWaJ/5wLQ
	ysBlPkd+LVwU2zhtHwfGFhlkXMgRpk8/fVVdZU45v2RrSH4l9hyw4RcqS9OmN4qjaH5sUGHUrf1
	PO51Bs5O3/rYI9LeeE/rhXJhd/AanzYIFxRo2pVyxZMlVRKPgBZD62aeW9nBI+0AwofqCfHP537
	7GSVgNziShFFy+9O/y5VsiwG2NS9MK1LCCxKBJL4lMTyQYXM6ps8ghjHmfNDKY8NIkOJCpfWJ/U
	OzsclJyceSJOvZoVAzfbMfqAPX3qYZsqXNr2yjW0sSfvQF+T4FgP8vbAH
X-Google-Smtp-Source: AGHT+IH7xZihVzIA5RnWD6NyU0bUqw560Kv27vVv2rhTAzSisPpc8YG7ahtot4M4YwZjZtNx8Gr9kQ==
X-Received: by 2002:a05:6000:985:b0:3a5:2949:6c38 with SMTP id ffacd0b85a97d-3b60a1bad1emr1118577f8f.52.1752564588929;
        Tue, 15 Jul 2025 00:29:48 -0700 (PDT)
Received: from otso.local (212095005088.public.telering.at. [212.95.5.88])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-455f8fc5a01sm106703395e9.32.2025.07.15.00.29.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jul 2025 00:29:48 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Tue, 15 Jul 2025 09:29:34 +0200
Subject: [PATCH v3 1/4] dt-bindings: usb: qcom,snps-dwc3: Add Milos
 compatible
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250715-sm7635-eusb-phy-v3-1-6c3224085eb6@fairphone.com>
References: <20250715-sm7635-eusb-phy-v3-0-6c3224085eb6@fairphone.com>
In-Reply-To: <20250715-sm7635-eusb-phy-v3-0-6c3224085eb6@fairphone.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Wesley Cheng <quic_wcheng@quicinc.com>, 
 Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>, 
 Abel Vesa <abel.vesa@linaro.org>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-phy@lists.infradead.org, Luca Weiss <luca.weiss@fairphone.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752564584; l=1322;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=sF0BBqSfmmjGnkvMWcmZuM22C376Bznvzv1cD7u8WVI=;
 b=kWHGuSS6cgAT+8EY14LUc3Wr8wswBjOovjk3j3OcaOlQzDYtixwgSAbOWluwm+7/DADGH77OD
 /ATYlXH1wgcD7S06O+brsLKzuyArP0bc9RfmMxcb0S24PBta83t8Lqx
X-Developer-Key: i=luca.weiss@fairphone.com; a=ed25519;
 pk=O1aw+AAust5lEmgrNJ1Bs7PTY0fEsJm+mdkjExA69q8=

Document the Milos dwc3 compatible.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 Documentation/devicetree/bindings/usb/qcom,snps-dwc3.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/usb/qcom,snps-dwc3.yaml b/Documentation/devicetree/bindings/usb/qcom,snps-dwc3.yaml
index 8dac5eba61b45bc2ea78b23ff38678f909e21317..dfd084ed90242f0e77cb2cde16023c3421c5dfab 100644
--- a/Documentation/devicetree/bindings/usb/qcom,snps-dwc3.yaml
+++ b/Documentation/devicetree/bindings/usb/qcom,snps-dwc3.yaml
@@ -32,6 +32,7 @@ properties:
           - qcom,ipq8064-dwc3
           - qcom,ipq8074-dwc3
           - qcom,ipq9574-dwc3
+          - qcom,milos-dwc3
           - qcom,msm8953-dwc3
           - qcom,msm8994-dwc3
           - qcom,msm8996-dwc3
@@ -338,6 +339,7 @@ allOf:
         compatible:
           contains:
             enum:
+              - qcom,milos-dwc3
               - qcom,qcm2290-dwc3
               - qcom,qcs615-dwc3
               - qcom,sar2130p-dwc3
@@ -453,6 +455,7 @@ allOf:
         compatible:
           contains:
             enum:
+              - qcom,milos-dwc3
               - qcom,x1e80100-dwc3
     then:
       properties:

-- 
2.50.1


