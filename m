Return-Path: <linux-kernel+bounces-779308-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 96997B2F272
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 10:40:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25BBF6050CB
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 08:33:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDDAE2EB84E;
	Thu, 21 Aug 2025 08:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eNT/xUdj"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94BF22EB5A4
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 08:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755765079; cv=none; b=F9Hrlal+Bj5U8MSFCVZpsPWBSzy/QPZXU6Gx1c9D4T7h4Ucuhz1YiYo7NuoxGjbtAYKcOIgpfQnPnxaWFdWP0/68icUQ20Es5BM/ZoOkIbHtvPq+lwOgHM/t26M6n3B3TdPCoNxRi8fCdkmL3jFPcI9yOTKJrF5Tq/gPCUqR9ZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755765079; c=relaxed/simple;
	bh=DUl7jGgKxzyvQ+23Qw3Y1zXF0UNGWi5P39FS6KTVraQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CPRGmY8jGNaRnNikuST0vRB7i1TN57saOahLfqFWkomxVV2aEsqA0HDeWQxItr2V+6LdMEQaBEbI6E3gvlQPVQhhvmbIKPjf8U0NNKDjv24yxYnDVDet7J3rhXcYwToqPbEcdnCDcJeZexUoDQcHgm7EVc7pSSim2Glg6XpxkU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=eNT/xUdj; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-afcb731ca55so8502866b.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 01:31:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755765075; x=1756369875; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=72zWfvgWDgRSpp6oB3qhY57BxhHcK9M4jOdFz5rohrY=;
        b=eNT/xUdjyOfSumdgitPSUMzqHJPyXJBOEYNrYIRfckQhb6OrrGtHPuwlluOvPmeJoD
         OtjcUg5rkpZr6WXOsvrLCt5zcwGlBwVZtqPA9clMym4sQQwFXawSwe/7XpLIaKaw7EXi
         znEz7FqyWq9j2HovpSGjCP4vzNfqx3QW7De5ufT4bPz0z2cr+0vAqQ2xCi+A05MX7eB7
         Xkr7tHhdL/CbMvlvwgrDykwJBltHon7O8d+RsGAwqzCrh8VOUhiDOBtyENST4YKqHtKg
         Bpcs44HCa6KAO8NvhBsr5Pv1P9fBRfUeKpqXrrhaXrdxelzjplyhHZlCtJlrJctQiy1U
         hAHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755765075; x=1756369875;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=72zWfvgWDgRSpp6oB3qhY57BxhHcK9M4jOdFz5rohrY=;
        b=XYWNUoV36bc0zhzKDWvP7hhncrx4+NJiOIlAr789h3n6fchZmhyjCyPFJ8IhKyN6TY
         edPs+JquPc4K1wrlZxelenIGPD+f6NQJsexXcs7BXnO3DtZVRYnVzDiJ3s8flPCc576m
         hkYgFirEhmd5zBTe/fPf0h6HPszom9VS+GwcW+oOwJJmFCz4l0QiyAuvVkZ07pojOuyC
         WmAV9qU5uotAAFP6oja2zYBLvdIzUvz41dGXVkgF7yb4LZvwPsOUoSZW+WmLm2Eo1+B7
         df8uypadumisMXjwlsGwQBNa3WhKIyAM+O+lTVSIeUhlDTYAgdcnevMwGlvwaoP4uUaw
         osRQ==
X-Forwarded-Encrypted: i=1; AJvYcCWc6Nu7VKLuVtKv937skWaGheRmL0xoVn1WyxukimnZhLB+SXIL/SkoSUI+YYpZgRMFksjBaDOLR44G3eo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNOvpTiAo6q9JO4q8T1hARhtNZsa4nCb9C8lBGcjwqoZ9d0xnQ
	DVEiYQ01sLWUUgOAJiv/3BX5e5UB3hweddK9OHdGqfieR/4EBKv5WbU8zD/XmVuhmmzGdDtg9Mp
	/6DZl
X-Gm-Gg: ASbGncu5JSYFamS5qjy95hyBLEWEq1jqsZwH8NP0RrtNAmdCKZwh8vv1vD3CzZ/2Jji
	uKI+tFC1LQv5o9S3k+LIOKGdJv+L+gHaEDE4vBS1GEs+Gp1FwtNjw5Io2sCo/ML/4gXzo0Q8Y4X
	4EfWC7ccbNCzSVt8/Iy0zTZUjCgsxzCHuvH2+abQBzB8DXJGaBLZQ5R+cy6U3kffDxGS451BkTQ
	8oqpZSuKkL7aJcJVFb7JgiQsHhRuGGVH80VIOSSkMZ2QwVnf1p2yy2hMgYe7avTh1oVKIvNglac
	LM48zsENDqLlI7+K5DPMoffhZzBSNnrhfD9+qjYKNhONGFWxS+hx7D5WGgkwM4/XWRfm/75icUK
	JJit01/M40b72hDWgxXYupbenxAgTH19Jjg==
X-Google-Smtp-Source: AGHT+IGS1r7c4z7Oj/JUMu3dGW4i1hneTD9SnjBJwWU0SVodFJd+one9+/U91e8Rz9GkkwYravVyAg==
X-Received: by 2002:a05:6402:2355:b0:615:c741:ec18 with SMTP id 4fb4d7f45d1cf-61bf86da6cbmr798735a12.2.1755765074962;
        Thu, 21 Aug 2025 01:31:14 -0700 (PDT)
Received: from kuoka.. ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-61a75777beesm4778255a12.26.2025.08.21.01.31.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 01:31:14 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Frank Li <Frank.Li@nxp.com>,
	linux-pwm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] dt-bindings: pwm: nxp,lpc1850-sct-pwm: Minor whitespace cleanup in example
Date: Thu, 21 Aug 2025 10:31:11 +0200
Message-ID: <20250821083110.46420-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=890; i=krzysztof.kozlowski@linaro.org;
 h=from:subject; bh=DUl7jGgKxzyvQ+23Qw3Y1zXF0UNGWi5P39FS6KTVraQ=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBoptlOFryJKNO+2kvcAg4ltdJEZLjHc8UC79sco
 55uOB1vkFiJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaKbZTgAKCRDBN2bmhouD
 15mTD/9lQW9AoV5VPmQuFpjbAjj1ZNaOh9StbPoiFY0W3YmrjRfc1z4yKCrJHkCXdheHXccDb4h
 V2vPOw5A0T608t7cZVLTmcaiz/w5xvAAAONUQ1Qjr9rkDtw0stO+F/wv81FoHvNRhChfJ0Ovz8G
 JWa24jjZgMlYiBaI7vVwpz4dAmvdV6W+c2y3fA38n0YK5IdbVOU6j7swjZqZsceQU2taXlQzwqP
 JTBOR16hRDUMM3eocd3ARiuP/Zjbst6E3uDvK9XqeEWmjIIYTR6hYKgCerwMz7jlA/YHogrY6hk
 g1whpoBALsZ0mZH5cAGL0It2GWTUldaVwNiEySivHdyDl+6FdoRya8WtJepcngsOmcy6uJe3ZCr
 LzOTubAeR5E547f/e50+Ohko26+/c321Nwjiv93oYfbld/HLu+oDidwaNH76Ly/ClOcLb/SfGXK
 AXJ4z9HVkNQuPQwuZR+TKME11yODWzlUqkf8wVpgsxIHc7/5CmL5vHj592GLwJPqu/vUkj5YkkP
 T1+dD2FKREeYPSvIbV74JstG+soEt9SrCp2xsflYbyNgD9Cz/ISPZ24OZB0+CnwGncw+DCP56tj
 qNrn3XDrBUW/40we5HG/lXHlLIP3fbtt/kNRdnPpG2ioRuonhsYw8x7R8aje7OOcw6i2BGNdifz UI6prLSZLBxnbQw==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp; fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
Content-Transfer-Encoding: 8bit

The DTS code coding style expects exactly one space around '='
character.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/pwm/nxp,lpc1850-sct-pwm.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pwm/nxp,lpc1850-sct-pwm.yaml b/Documentation/devicetree/bindings/pwm/nxp,lpc1850-sct-pwm.yaml
index ffda0123878e..920e0413d431 100644
--- a/Documentation/devicetree/bindings/pwm/nxp,lpc1850-sct-pwm.yaml
+++ b/Documentation/devicetree/bindings/pwm/nxp,lpc1850-sct-pwm.yaml
@@ -48,7 +48,7 @@ examples:
     pwm@40000000 {
         compatible = "nxp,lpc1850-sct-pwm";
         reg = <0x40000000 0x1000>;
-        clocks =<&ccu1 CLK_CPU_SCT>;
+        clocks = <&ccu1 CLK_CPU_SCT>;
         clock-names = "pwm";
         #pwm-cells = <3>;
     };
-- 
2.48.1


