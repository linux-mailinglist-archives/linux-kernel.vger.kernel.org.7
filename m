Return-Path: <linux-kernel+bounces-729048-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 32786B03109
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jul 2025 14:47:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4056C189E425
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jul 2025 12:47:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 146F5278E79;
	Sun, 13 Jul 2025 12:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="y44pprNR"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2CBE22FAFD
	for <linux-kernel@vger.kernel.org>; Sun, 13 Jul 2025 12:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752410812; cv=none; b=W5nvi9FP2BY4Y9H8khK3ToEcEFmHPx/5shPxF/1WWsjHe/qi6utnRBkeysvwetecijVw0DtTwsZWX0MxfGqkAgNsuKfT/ly4WbrPvLL47Y8tdEE6OO1pJLTmnou3vJlvUvv534XS/vBwP/Cmo8Mm47InBQPeHXZwBOX3Jc3/n7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752410812; c=relaxed/simple;
	bh=BlRvIRPzQQPUtCo+mAvAI8qOIImTdfvDN7bB+4kLIBU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hfl2wVQH3qtBORdgvVT9vkP4BqkwkIpgC21UsSEz4o1h8dOspsd/H1ztyIphi20HVSSzMesmExMwJww283YRcJzJJkhDNE/IgTQ7AXOE2WF0NjaHRxYxaFZV1hJe0Gx5bA5gG5+u8fzYAQbS1eozm6bpMT6mKT4aRJ7RhjZZBEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=y44pprNR; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3a524caf77eso406297f8f.3
        for <linux-kernel@vger.kernel.org>; Sun, 13 Jul 2025 05:46:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752410809; x=1753015609; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XoZqNCvU/s4oHuYCydia6erGgc5X35yK1qc86vp7sCA=;
        b=y44pprNRPmtCZ6UkBpPZgIISN6bXIXiG5GdDO4RDjHK4Mu55Tj38zHP9qQocdNLL9Y
         o0xB4shAZOh80VbzCO60y6nxWEFSjhgtdVf3Ui0MEq2aDvJVMB6nwfYGqNvMTEuGvALO
         fo35OHpQfZrmFIF0iF4OEpBB0Jh7clp63KqW4MaocWHExgUDBorX17FP5slA2SYG7itd
         wdU5AFJ6FZKGRDjV0PRfzm7k0bw7tofRghreCoOG1AEBNfwY/KF2LkwHaeIcABTTZPVs
         jTlVM7YCMeHMrT8boiXn7LkDijyQfb7zO0qLS3KA+pZN5tqkIyM+Rsn6MFZNuuT65kiy
         JOTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752410809; x=1753015609;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XoZqNCvU/s4oHuYCydia6erGgc5X35yK1qc86vp7sCA=;
        b=mMPXJXuN9usOamlZWcvYp/AtSeGuF8WxuKs9oFGwJ7nzusYhvH+c/ZBsKeEjb4np1M
         Q3BjY+2fGoyBaJgbgcXZphMa1aZ9jY/We6Aw5iKdizzkkCfr+duJIAaV/ZS/BKFSRZEX
         5USjGDlcUp4x9uENtmFKU0J3Rfb9pCPaI2vXn4Tr/qL6M5acnG/PeavwTwfw18A0A9L3
         Y7fYXQJ3nqYyyyElbGuGrgeExKxp8ZfZjSaEOpWzQ2fh2kWMJvk5TOQRl2eTIX40BtJd
         jiI7bMf3gVoiwv6IA+L3rLeWpRq2L14VkGeuN7LIJBFKRBpqCcyipGvy+J7mVC3Ni2+L
         ouXQ==
X-Forwarded-Encrypted: i=1; AJvYcCWsBBchz8SSn9scHOFIsGHINKf8jA/yuP8+VgDnGLfac9hGFnVkxe62n1qAq2xbvFcburTv/BkKnAloONo=@vger.kernel.org
X-Gm-Message-State: AOJu0YydzmoFR+fd7uVBoAQSqYc/43fmUmMcXBXuDL7pLclu7AOywphE
	/YIU+U7MEE88o475DSpUQ3T2AHoufPEyzzeE5o+moycCLe2svy13nAiIotsAOwACt/E=
X-Gm-Gg: ASbGncs+3sR9lL3zN1Se1ZpYrmL+kSnhfLSb0BjiyoB0sSE5+9hZGxK/Zs+Rmf1LTD9
	gxaHv6kp7LOJYWGus5qRcdMLWg8Os+0jmPWYHEsJXfsaAKYKmAoiFScmnTnKOKJBpY0bR+s2tns
	nFBbcyNqGuWKl2I5L5qK/nmDq/M8fuveuif+99Er2YG4JisJScO4SCern69ICm1rwENOPfFpDG7
	p6/1bEVBk9JfqZd5hpB8sYrWvoSOpsiyHWnasphphXOm+kecFXMC7A4DkOn/ONuC3G8aSB2HG63
	NdZNmqYRwsivk0aspePw/hFNBnhgfFtpR3sXwWjFdk4kTJKtZ8OVo2lhrq9nyA75r8B6q5niZcH
	mK7gHM5MyqYE6GZ8cZMnBcw0lGyoTrs/hQOuI
X-Google-Smtp-Source: AGHT+IHAdIehjkYMlljSMzvvs/ySAlhEufMHsbD8ELSnM58asHwMaFX0gPfWp0eh8n5jJOi4cfz2JQ==
X-Received: by 2002:a05:6000:24c6:b0:3a4:f744:e019 with SMTP id ffacd0b85a97d-3b5f19000a5mr2744926f8f.16.1752410808920;
        Sun, 13 Jul 2025 05:46:48 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.222.89])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8e14d07sm9828835f8f.66.2025.07.13.05.46.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Jul 2025 05:46:47 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Sun, 13 Jul 2025 14:46:37 +0200
Subject: [PATCH v2 2/4] docs: dt: writing-bindings: Document compatible and
 filename naming
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250713-dt-bindings-docs-v2-2-672c898054ae@linaro.org>
References: <20250713-dt-bindings-docs-v2-0-672c898054ae@linaro.org>
In-Reply-To: <20250713-dt-bindings-docs-v2-0-672c898054ae@linaro.org>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2195;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=BlRvIRPzQQPUtCo+mAvAI8qOIImTdfvDN7bB+4kLIBU=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBoc6qxdV1Jq3JU6x7/ASYUlf69jDirm6DevtMGD
 LzbGveV35WJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaHOqsQAKCRDBN2bmhouD
 1w9LEACZor9MqYK3td8tiLCfJTxAZB+9nEXg0jBC/cKOwIsjA1fwzePixOo+eRo80wZnl/aQNVR
 yo2wFYpRGXCBTqOCC/etQ4GEr4VFg7M1KP/llGv1t0SW02rX+gHfpZQwJ5zU+uHqVG6y0/HM6fE
 om49GcCgRIXNzkPFlAmpSjA4yM5i/RCe9tjyldiCd+0/h/gb42tPEYWKUVhm92Bd0a9VVeQd/Ys
 EY1rn8lereCB1IVT73FqCcygkM/ZoNg1vdBFyFflS3rZkCM5R05LOKxZ3N5EQ/aWJoGbF4kZap3
 JxiU8BJtyK8/QvxeC0CMHuSPn267r2sr1spsJO7EceoGpc2Df8x6SJFaEKAwNvvWunC+PXSqa4u
 zheDrc1ctKYp5WBUDKKJj0EYg+h0LDS/shhqojPihtRDkQB/PVoXCRNsupfRU4XvsyCjkr6xy18
 sIDNMINqZcUzIKr0rukacY6Yr8M8GheJacSxB9CXr3MJNQqVRyrM4iGA0sCWOHlVHSxPckc0AdH
 isGiFfIEJ9bL1lN82vPZLBVHwbWea0vbBF2uAN9PtzwtopTBAmLyE8aKd7TxE35H/U21jqga6yy
 b2QyReCgx8AdbF+/ozF4OC/oOUxotABaV2u2LaGq6AUgaa3buIHwgcJ6NU9dLMCQK5r3R5cfrkz
 NpSeJpm3rbqP4yA==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Document established Devicetree bindings maintainers review practices:

1. Compatibles should not use bus suffixes to encode the type of
   interface, because the parent bus node defines that interface, e.g.
   "vendor,device" instead of "vendor,device-i2c" + "vendor,device-spi".

2. If the compatible represents the device as a whole, it should not
   contain the type of device in the name.

3. Filenames should match compatible.  The best if match is 100%, but if
   binding has multiple compatibles, then one of the fallbacks should be
   used.  Alternatively a genericish name is allowed if it follows
   "vendor,device" style.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Changes in v2:
1. New patch
---
 Documentation/devicetree/bindings/writing-bindings.rst | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/writing-bindings.rst b/Documentation/devicetree/bindings/writing-bindings.rst
index a2d2afd099c0bd922cf12dcf49f5dffe6da748f1..e63de88385b5bc5859d8d9fca82bcf30380f3e73 100644
--- a/Documentation/devicetree/bindings/writing-bindings.rst
+++ b/Documentation/devicetree/bindings/writing-bindings.rst
@@ -52,6 +52,10 @@ Properties
      fallback if appropriate. SoC-specific compatibles are also preferred for
      the fallbacks.
 
+   - DON'T use bus suffixes to encode the type of interface device is using.
+     The parent bus node already implies that interface.  DON'T add the type of
+     device, if the device cannot be anything else.
+
 - DO use a vendor prefix on device-specific property names. Consider if
   properties could be common among devices of the same class. Check other
   existing bindings for similar devices.
@@ -101,6 +105,10 @@ Typical cases and caveats
 - "syscon" is not a generic property. Use vendor and type, e.g.
   "vendor,power-manager-syscon".
 
+- Bindings files should be named like compatible: vendor,device.yaml. In case
+  of multiple compatibles in the binding, use one of the fallbacks or a more
+  generic name, yet still matching compatible style.
+
 Board/SoC .dts Files
 ====================
 

-- 
2.43.0


