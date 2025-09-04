Return-Path: <linux-kernel+bounces-801005-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B5567B43EB0
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 16:26:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C6A11C87B7F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 14:26:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 583543074AB;
	Thu,  4 Sep 2025 14:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="z4GiKnMZ"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DCC630CD88
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 14:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756995848; cv=none; b=RQjR1z/JQVMEleAKbA0ExlqOx2qICsJCoYHW/uKkQRopNnpXnk7tpuvHRe6NU/bdiuspPdEXRnAmlI7wIkqOI4Qi+ovRKC/2lnb/aOlzCeC2EEbey+i3IB8S7xJ7XdcwkNxI50ASBMW8rTNiIm9bKn5e54HzTRzx6aeGMIMjBME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756995848; c=relaxed/simple;
	bh=rJbB3QOAsoTaxqo4Kd4lB6HXlcCx0S/pVRiVTjcef5E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bvnCLy29G6VoNIgbaW1pR1y5Rbz15mENKwCbcotUakKuPAG1dLUBkun+O+LNWQfOnaWWNr84hXXTcFyPzfejKYZFIR/1WThnz1rsJctX2gkHFAoXpqb7ZQm/6ruyseq/qwIYOZOp4ED/LzicTY1ZGPRAVanR3W54ktoe2hfbNQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=z4GiKnMZ; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b046d1cd1fdso17845566b.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 07:24:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756995845; x=1757600645; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nNrC/NOuBDqAGWreYEfGfKmUPRa1ls8wWMOF4jMHuN4=;
        b=z4GiKnMZMMu1zzObHvLfmCx1l4/xxGUcIAzJhBdFSaSGzQYmNIDGc0iNy6u/bORsCN
         /PrJ4tZ5Xbf5PVZVLfE/1O+SYXU1xSzxvGf3Jtd7p7BqYZAPCO8v0ELDwqE/fkFqWypY
         VjKnlbAqeY8+c1c19hno1YV1U65o/cLtcU0pCabl6WwgDXDbU7U8FFMzOkq8d7vaFQyG
         Cx80Y3ciY23YVlilYElxrjG8nOHnjhw2K5u6Cf8C8jvvFwPXbHakFpQxxu4AUMBE46lb
         9dXW/LgUYKWCTgl78bcql8C+nWdsUIT2Wq55pvFj2Fg9E6onDrngxKzT+KTSNU8N2QXo
         1MkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756995845; x=1757600645;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nNrC/NOuBDqAGWreYEfGfKmUPRa1ls8wWMOF4jMHuN4=;
        b=LrR3VGyY8WbJ2BDoWBug4wHAKSdAJiBgbzNL8M4jV8KZmUf3aqTbBdHazlA0vXurce
         w9Etnr4YYswuSGZiqVxhiZzmALSa6694FWxhGpXbmVPlrn8sbZP939rBWeSx2c3ns0DQ
         BhPgjWZESjYAjcCRU1gk4sxXB2Mnv/nMGM0rwyLtbaDVZMbOrUaLr4kh86+DruRiBm5d
         J630CchumvQUXUBb6Qc83Vbf8biS6Bd5tLcrIcmn535izI1EDBfBaReJm+0oLSyu4D0U
         QCMKwIBkGHoz0XIdeFbpfG4N06veZafShUGRC6NaTxieANdEXPAtlKF+9CxW/EFXcj6T
         XRdQ==
X-Forwarded-Encrypted: i=1; AJvYcCXYKkHztIwGDGwkXoDgujVS+Cz8reK/U6Dg3k+wwUNV8fdYwFL9JereFJKWY8Z/s7GmPdFT576+UqC8tjI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpGSBAKxD8xc+oFt6MVoSj9Ro5ceO7VUdUYGCC4K0un5dv3Glk
	dQxwDuJGHiy8WqEE8EEFQLqzPIpT2J2fxztKFroJXY+jkC3OKeQ9wffuEtWotBiRLcI=
X-Gm-Gg: ASbGncuWUY34Nq6+PMEvcnJkU1xR/ciOyh+vkGMGNFEpqte57pJqIOPp11aMm13VZ3L
	YGfn4obTNVafQILfGZvRVL+plznXLSuFItvbrnrdICzDksuZCBuGXBhvSOqIS4jzXiZOibUcNKU
	txreeDsnHXAPVUZyt+1tXsIGOGZBIs+P0f/IwlfMSxLV0DGdFLwcJ1U8a8J9VT+EfHA0RzbdJnX
	VMCWYlvd6VkazdZ+L2OZC26LWwRooRAG6ysoJu+sABhq8+TgwvY23XB0t73f8jzwdjCd4uujagQ
	qpOg2GD+X8YVmQQAu6dclBNzcXO0LDD/QHRVeJPtJVY9+1kZ+4mIiyxHm7j8ZYJGpWVcolLt8B2
	pQOBmPVw6RTXPXXtUBejF1f5k7Xjh3pZliQ==
X-Google-Smtp-Source: AGHT+IGNV50jro7uMtgoJhjjvwjyznKhwM82NWrwa4sUItnPrV/V66x4nrLpTFqOJQAebi57nfUbBQ==
X-Received: by 2002:a17:907:2d8c:b0:b04:83f1:afaa with SMTP id a640c23a62f3a-b0483f1c682mr121328466b.6.1756995844599;
        Thu, 04 Sep 2025 07:24:04 -0700 (PDT)
Received: from kuoka.. ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b046f888b95sm347059866b.34.2025.09.04.07.24.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Sep 2025 07:24:03 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] docs: dt: writing-schema: Describe defining properties in top-level
Date: Thu,  4 Sep 2025 16:24:01 +0200
Message-ID: <20250904142400.179955-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1506; i=krzysztof.kozlowski@linaro.org;
 h=from:subject; bh=rJbB3QOAsoTaxqo4Kd4lB6HXlcCx0S/pVRiVTjcef5E=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBouaEArq2qphlBSq9K0XZCXbcEVoS1cOy3asNZC
 zTHFKmK/CGJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaLmhAAAKCRDBN2bmhouD
 10EpEACA1X1JRpjg8VvtinjyTBdJez0NF64yxJwGekQgBE+wmrFBua4jQ83FWULPiQOOEZzAnyZ
 UnLA/RJC0jdL8OcfA2NtSAs9BzK6zS+y5bav820hZ/YWyDSZDhOgbaTOeTTD3m3Yqk3f89JY+WC
 MCNU/AN9Bq5oNys7xnX6EHCWDhairD1ALUQj9/i1Xg0CCdwCB6KwNEWSK0oP26tEBkqme9FkYrh
 KSy9nPhS9xF1OPc+D+YZSl1eVqaal8CttoxTr9RXb2Wh5jcWySC3sSYo6SOnv+2mfI+JxGszJWq
 Zwj77axeHWrOfEaeXZOQvxDIy1G0Nz+HyM40G7YeYYZh1KMDUZaj03uEiPgqTJ9WLCZsrDKvtCQ
 oQerSB6s0AJIc9LC97kqx3xUv85UGIcYm/BiB29utXUXiwq2Z68TOfv1fX4edcbatCf+BQBeOJb
 Ciqz3frq5zTxiF5kyY/RNapbkUAK1IjkTrR1kYVRCCpnilByXYn6LbIZeLfvO+wOwIJhAGgQeQY
 lqR+EC9o9TyO/QPeYd/FjSlA/U6BylXkCBA793Xft/rff/pNckD3g3u8Vd2TlNC/TL3eqDTrRpF
 VtK2Kc8+sjnN1Wb6z1FZz1LPMeOWA7Xw6K8cWCmYM8l3EC6GGrzteTxi3LtzeePvg5G/LNCS+Bf zR3t9h5T6Sgnf/Q==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp; fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
Content-Transfer-Encoding: 8bit

Document established Devicetree bindings maintainers review practice:
Properties having differences per each device in the binding, e.g.
different constraints for lists or different allowed values, should
still be defined in top-level 'properties' section and only customized
in 'if:then:'.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/writing-schema.rst | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/writing-schema.rst b/Documentation/devicetree/bindings/writing-schema.rst
index 470d1521fa17..e0859094575d 100644
--- a/Documentation/devicetree/bindings/writing-schema.rst
+++ b/Documentation/devicetree/bindings/writing-schema.rst
@@ -165,6 +165,14 @@ The YAML Devicetree format also makes all string values an array and scalar
 values a matrix (in order to define groupings) even when only a single value
 is present. Single entries in schemas are fixed up to match this encoding.
 
+When bindings cover multiple similar devices that differ in some properties,
+those properties should be constrained for each device. This usually means:
+
+ * In top level 'properties' define the property with the broadest constraints.
+ * In 'if:then:' blocks, further narrow the constraints for those properties.
+ * Do not define the properties within an 'if:then:' block (note that
+   'additionalItems' also won't allow that).
+
 Coding style
 ------------
 
-- 
2.48.1


