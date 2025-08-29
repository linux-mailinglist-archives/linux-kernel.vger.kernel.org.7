Return-Path: <linux-kernel+bounces-791397-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 07A49B3B660
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 10:51:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B02B61CC0177
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 08:51:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CDE42D0C68;
	Fri, 29 Aug 2025 08:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YkQilyrR"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 092EB2D0606;
	Fri, 29 Aug 2025 08:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756457311; cv=none; b=X6wjr+j1aHB4YWCG8AN9u74gDgnZWDdreeh3y5BlOCwCrGlFZoA+HKO5vBJRIHL4S5LdngKRLJOq0gjRMK+hMQLsI5xrfi3IHn8YKygWlRunZFFNgxJP4gUiTC8GPdrW/6zgZQzKt4nZg5Y158e1JMdFva0jxuVVcqIF0m63iYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756457311; c=relaxed/simple;
	bh=WTcRU3ek4vi18/6+bn2AZBisc3HsqCJ8Oa5khMxDoNs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=P38uVVE/2mzm5efNn3EyoJYbCpjG6GB5Vx9EiX3jHgiRHCEd7L8LyCkd4soK1PWuT1E2HLyU3LElhC8LOqvn9h6TbsW5igT667PzovKeheI5aa11Rgshn1H/YdbWOfvfLB5lQhyMnlwM9362Pm2Jily1jKA6zN5b36ZIHS5N1HU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YkQilyrR; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2490369145fso5915115ad.2;
        Fri, 29 Aug 2025 01:48:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756457309; x=1757062109; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J3Np6RSUufpFZ+G05WkQGnHAm+bGRWCensQMqZVsmAo=;
        b=YkQilyrRa3D+YhhGVmIJKHQ7CrS0AtxRRcUul39LxB+Tp65BVlooPhWfOZW1m0ubqd
         8eL6bcMFBy9ShADor5kSHpoKpOm8Y0GenT5nMA3H4B0VbVjwtTpmT+zU8O9F07Qn1e8H
         cKcZmt9HzlluHeqQ7SOStn2hKucrhmdryLgN0a375HFIbq6aKOXlo9eu/dPCm/JeXk0i
         AyLQI+gxMSJ8jwFSKhUh86IH/oSoF5Ub4ED2cZ5qDql7lfNoJlgr8Fh0l6DfLC+vcFjv
         H9+awO5RXejKwDXj4HrZ/0Tk4vv9/x0dMJ+Ld7s54tMyCi0BXZmrzGBrIYApYy9cgjjI
         UjFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756457309; x=1757062109;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J3Np6RSUufpFZ+G05WkQGnHAm+bGRWCensQMqZVsmAo=;
        b=CMXC1tWdth5Xci/qRdc8LuKE1+avOcYoLdj7X7K0Xfcf5Afgr58EYeqrwoQtbQPUcl
         HiojENwUKgXevjdCr7JsgBzV49IAupoGwA3N3/casZRBnxD5DOgG7IglpECKHON7+VtV
         U8E1HUZxWOqfeyZeePsMOUhV8zm5tM9yQ122vbHgXoP3akvQ2mEbveanq5vcG0o/Ar8D
         s7DC35Rzl1T0flRkY/CgGGiRggfP9lTVn4qcBO9HAUjDACWxa+POhyz8JCkrVYHIpiDJ
         JQJN5rRbsqGNrtwm+u0ALq7qlWvVxd7RLcvuBRSmdtgqOEzHFmIEhtzsRcgcs8hJNJW+
         1uOQ==
X-Forwarded-Encrypted: i=1; AJvYcCVouf5qRrjQg59TxE0e1H5FmQM7XQvBeeSBIzuTwtU78Fn4lBqwKmP7dg9yRLc4gwc8pvp/lpEMp9kym1kn@vger.kernel.org, AJvYcCWo5kCeBmV0qKjwoYJQJ+A8+exc2HmiPIgbATYBsVdH81w2vtDU40hQp/BZcKyHwgGq8HmJLMWyxBPi@vger.kernel.org
X-Gm-Message-State: AOJu0YyTVsqFQ2cKq9OQTgBj7/wrC8SY7854g8Vu4iiU9p/7HIT705K4
	RAn/LQRSMHgMNHhIYUSnbBGv9cderaVMz3hRzNAl0q6+R+O9+OU+f09RG0fD5vxJoyI=
X-Gm-Gg: ASbGnctmJy5sYabml/5l9/1WVK4ZzJRh541IO/6B+cfjf4ztZXFkZKc7aUxG+RgbPGJ
	uy0SQAXkrlMQPbUzGFf5VMvx+rTTigmotf2N/6iAB8v1hQpWQn+lG870oEMxFxA/l8fYLmzxdpI
	RWLH47yef0RrZ3h0NUV7skeg5KZm0+HY8KakUosrcVfWdqd+oQk98LkTJVh4S/xVU7hmZAWS8qL
	xVXB0K4C7ymGM9tSxxX+2qmLaawHyY/4LwjXT2WeqyDCtSRzlV2JQ8mFIuTY2PtQ2SdO1j43ZRa
	riBEEqOBsyH7gB3qmqsDvDo9VqsXaDfyVJ0eKs4M6AlBZ13q+XybD3i8RFOJlnmViVST6EsTeic
	vpdk6jNNG317+RJ1leM72MpiDQCwuW8/HhigxENNFQPNOOJ5M
X-Google-Smtp-Source: AGHT+IGr6dfrRRQuVok1ow5zCKd2/gxu4vBTmvpxzkkEulS7SF4Yl3RRi4c9dTaQzlJzsA5mQVlzxQ==
X-Received: by 2002:a17:903:1207:b0:240:5549:708e with SMTP id d9443c01a7336-2462ef942bdmr327011365ad.46.1756457309160;
        Fri, 29 Aug 2025 01:48:29 -0700 (PDT)
Received: from [127.0.1.1] ([59.188.211.98])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-249066e042asm18162565ad.146.2025.08.29.01.48.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Aug 2025 01:48:28 -0700 (PDT)
From: Nick Chan <towinchenmi@gmail.com>
Date: Fri, 29 Aug 2025 16:47:00 +0800
Subject: [PATCH v3 1/3] dt-bindings: spmi: Add Apple A11 and T2 compatible
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250829-t8015-spmi-v3-1-58b15ee2c825@gmail.com>
References: <20250829-t8015-spmi-v3-0-58b15ee2c825@gmail.com>
In-Reply-To: <20250829-t8015-spmi-v3-0-58b15ee2c825@gmail.com>
To: Janne Grunau <j@jannau.net>, Alyssa Rosenzweig <alyssa@rosenzweig.io>, 
 Neal Gompa <neal@gompa.dev>, Stephen Boyd <sboyd@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Sasha Finkelstein <fnkl.kernel@gmail.com>, Sven Peter <sven@kernel.org>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 Nick Chan <towinchenmi@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1240; i=towinchenmi@gmail.com;
 h=from:subject:message-id; bh=WTcRU3ek4vi18/6+bn2AZBisc3HsqCJ8Oa5khMxDoNs=;
 b=owEBbQKS/ZANAwAKAQHKCLemxQgkAcsmYgBosWlU+ZIQ+k3EFIaELJ3w1MmrvGHBvq3g2+23D
 s6WkgTaLJeJAjMEAAEKAB0WIQRLUnh4XJes95w8aIMBygi3psUIJAUCaLFpVAAKCRABygi3psUI
 JDEDD/4xS06N6hYF6BFqyUS932VY299g48zcagOnmAqRFAmzva9MtJ5fPzMXgIPXeGGDOV9GYWC
 vkXl3U2H+2crxZanliHx+XuTGcYuDU8Rocz9wwIByWWEQym+PiiZk9umQyzjwfs77oM/5xkqARC
 RTMxzhcB7m9xyRxXhGIgavgPVdBsX2lkL8uJwk1smD494nva3kpNj73zoirxlmAc/0qIS+KDhmn
 z11D2eokz1GHghS5I3o0x2nC4PrTEWsH92uFlWYLC6Dk4RHENjA1f0b1W37Qt4S9x6c/UYv5hCH
 GZRLSpaHsUzdy588M3wDxqIIP3fHqPiAsbtH+UfxGez9tc00zDpKB4EBZspKdPmYTunH8D2RKIm
 poBnhwm7OV0zI8HIMe0+u8MH4RsUUp5j20qG0X4lFnsda9Y4gRNtO2DrYjtZjW1+SaMGpp4BFfZ
 6ZbqPhKzPaAxk0BBNpECAuJglxSJRcEV9Ryv684at4ES0ZDxuRCa182UIknUXoRnYF68AslwSKT
 JnALU17lOi94vDHewcKwOgTd0LNw4dNE2biEZVbopcUrvh2v9mmRXkCd7De1tlE0IHmacgUDTux
 ARQtdTq8bS89FK/MkUsuH4dvt5tLS3DvYqJIQT2l9tEDu70wZUFZSMwdz//TTbI8XHq7Vs0/zID
 a0eTKWm/hVZsgYw==
X-Developer-Key: i=towinchenmi@gmail.com; a=openpgp;
 fpr=4B5278785C97ACF79C3C688301CA08B7A6C50824

The SPMI bus found on Apple A11 and T2 SoCs are compatible with the
existing driver for t8103's spmi so add their compatibles.

Acked-by: Rob Herring (Arm) <robh@kernel.org>
Reviewed-by: Sven Peter <sven@kernel.org>
Signed-off-by: Nick Chan <towinchenmi@gmail.com>
---
 Documentation/devicetree/bindings/spmi/apple,spmi.yaml | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/spmi/apple,spmi.yaml b/Documentation/devicetree/bindings/spmi/apple,spmi.yaml
index dbf09ad0ecdecab82074344aa6a840a820bc448a..ba0ec92a55d4fe14671ea71b5c6d530d1ac0b11a 100644
--- a/Documentation/devicetree/bindings/spmi/apple,spmi.yaml
+++ b/Documentation/devicetree/bindings/spmi/apple,spmi.yaml
@@ -18,7 +18,10 @@ properties:
   compatible:
     oneOf:
       - items:
-          - const: apple,t6020-spmi
+          - enum:
+              - apple,t6020-spmi
+              - apple,t8012-spmi
+              - apple,t8015-spmi
           - const: apple,t8103-spmi
       - items:
           - enum:
@@ -27,7 +30,6 @@ properties:
               - apple,t6000-spmi
               - apple,t8112-spmi
           - const: apple,spmi
-
   reg:
     maxItems: 1
 

-- 
2.51.0


