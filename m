Return-Path: <linux-kernel+bounces-779309-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 47F89B2F279
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 10:40:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 05E711CE0765
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 08:34:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ABDF2EA75F;
	Thu, 21 Aug 2025 08:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="T0LEUdoB"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AA683594F
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 08:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755765119; cv=none; b=j9bek3dNrd9G7M2jduL/svX3OQZ8J956bsBkVpmK7P88bpa1B0KLmDc3BBgtH3G13TOTjdxc96hOomO8IrOV81zvG7vOHxIZnRAyKL0yZQSddXoKaLZcqyi9TDGHFMzEmtXONfAvZ52T7CLXUuFNmsw1FRc+KXxcsaMmO65TQCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755765119; c=relaxed/simple;
	bh=o6wtN3783MnhTkItU8+Bf3YpWdPfZYyFxZjqmDsrBMk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=l8671Ugys2aPpRv2Aqzube4WwQaoFtsoXUA1HyGdsghd64URGwk/8Tj49oHIVzXbV359na2wZLodjk7amZOHlq/4d+lchMf1pGGIsyftgO3brW0LWVHkLFjJiEAm34IFW5kZmk1IBDwHpmZgdtkxcGHFqi6/LNPXJgHF26TkgXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=T0LEUdoB; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-afcb78d5e13so7743566b.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 01:31:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755765116; x=1756369916; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=T72UFcH6AjzcUCkgHZUc2QAiLeOpR0se8y/86dUUmFw=;
        b=T0LEUdoB8oUwJPZdrqYsFkY8xFXEcApme8xAaC54nQwwUXD3A4jQTlkJfM+blEy3Yc
         bRb/S/Bs8RAiydA266peYeaO2bzIOOh+G3+5bKe3SmlsJsFJbm+Cs9/vOiOwjjuZ7RHT
         I+m0vgK7VcIJ87I4G2+RWZFGzJhlTBEkcZrvHdAKymQT1Itwx1TJ/FnbRR78D8hFCOau
         2wLn8Mv4XkQP1RTxMiI1qKsidKLlEAgJcBHSZ6VF/PZsCOOI84hPgRInGcI9SHPMarpw
         PyF0xYDExPtpfmsJrSt2D7a+oqrSFfwN1SBv8koGuP4AT5f4GkcFDcPHlbLL7DZf9AtK
         DJdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755765116; x=1756369916;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T72UFcH6AjzcUCkgHZUc2QAiLeOpR0se8y/86dUUmFw=;
        b=hlpnjo6t/m/MJM3zFsgMFhJAGz9rUtpnJvXB/hYwYxGo2h21D/OkKVxLcfzsBBdBYM
         SbkErLOCMsZGN5nXKIlRv8puVM4AvR69dS9ItrItSirGK2UIIrYyCKmG7yHsGDAdXhv+
         76ZIj1CbcsMym0VAv53vEg0CfdJf++rMcPkCbD8Lljvqije84UF/ua8jG5cqWgBjBLi9
         36ohcS3nbeBa1s/QSaabv+IR6aS+Nsv5JHFANv2kTvIKM7PJKM+5i657TEsMa9TLYGpn
         G/8SjSvI3fxRF0vWaHOLkElnvVfwRvm8hRMAjAWI35ghi9FJ90fDZh6sx/14OziU6F7R
         m3Kg==
X-Forwarded-Encrypted: i=1; AJvYcCVwrNuY+eZnG/cXmKlcwj70Uk8Iuozhh6epMC0GPxr8JCtWL2RBx26SB+sEKPiyIjfO0YWgj6Oa3ri+ZmM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhocFK/Dz47OEuTGOQqg+OB4GoUTV/mPVhFmCR9Bqz9/ZIBXXg
	PWz3QMraX+WG3yn3ZCloXbA9rL5OoKPZTQVCBF+epQFeioxCYk8nA4DH6Axj6ItDnrY=
X-Gm-Gg: ASbGncsYiUezYusUCotxcLDekYCwxU9L1WbuGtOhqD+XSXI64XBt/d+NpCLBYg3/hMW
	NWR6ROYUs/R5JKO8ZLQ+S3PrwQAK1BibNUy+I0dSrFPMZJXjPw2CSZJbZyKLxPvPrByhTuDZwNO
	Fw9SXPGdCi9GawVz9G85x42XcpFaDAeY9ftn/iIEoCV3Z9CXN1g2mOW4bchE3tf5W2JWl5sj4G7
	q9O4F/BaNXsC3/FpT/hC359WirXtV3u8rV8e7AnzCETZ/uXUjnnP0pDuZ54Zl0Nvfpnb/1nqdMv
	UErFNAe6NTkyi8VyKR+xp11wKjBhQ1cYKxbPLCKsndLk8QCjQBvMH3WWwbiFTVB1GLDgCsdHnY6
	mb3B7aSV+2Q0C4YuTDqJEf+sC328/MiToNw==
X-Google-Smtp-Source: AGHT+IEmYCB7RoXV5cO6L40St+lRMNzSQSwZc09J9Wq+5CcfC6nThev98ei1pp0ECHLQKecQGw45HQ==
X-Received: by 2002:a17:907:2d9f:b0:af8:fb0a:45d4 with SMTP id a640c23a62f3a-afe07a20215mr76866066b.5.1755765114658;
        Thu, 21 Aug 2025 01:31:54 -0700 (PDT)
Received: from kuoka.. ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afded35547esm341911366b.50.2025.08.21.01.31.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 01:31:54 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Michael Hennerich <michael.hennerich@analog.com>,
	Kim Seer Paller <kimseer.paller@analog.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] dt-bindings: iio: adi,ltc2664: Minor whitespace cleanup in example
Date: Thu, 21 Aug 2025 10:31:51 +0200
Message-ID: <20250821083150.46554-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=831; i=krzysztof.kozlowski@linaro.org;
 h=from:subject; bh=o6wtN3783MnhTkItU8+Bf3YpWdPfZYyFxZjqmDsrBMk=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBoptl2dxU42hCXeG4lO8ny/fQClzik9KbgZZ8H9
 s00I/xTaxeJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaKbZdgAKCRDBN2bmhouD
 17AQD/9+lWAFaa/J1oRYmRcHyrNtykXAnAF63nJwJijngp+Hh+IlrctA0x26TBH7oWarxZFvN9E
 El2wORkEIhLkESFL+VoEVRRiHMjNehb2mjsbNUzs/wTGHd6iaY06OSSGjWOkByG0R4VmxVDngG1
 kcbxhjjcCtcyFmcxtopvwAKKYi6uXPLjspAFcKdOwtV7UJn2q8u3tr+LMrsoQlkL6DGdvMyGK2d
 c8AYYH2fDGDaPySi3GDkX1hwEfBaPXGzjrPKGnqmuzaH/8W7dlLw+kJ5j8ZKiMa+87cRFG/oFPU
 srzBjpMNVMFmYxeYqmGIkcwlLcMobAYRA3jAXEYCBICCmBQ7WS15yr+sLXoB7aTljGOl52aq97l
 o315K5aww3EufdswS7ppqpFCQjqpbT+uWo+XhBBsRRyy9aY2HiHb1/cY3t+tNWutUxDAfhTsCqd
 /nlgtBaP55lRokisyLf3D6GLR+KvugC4knuMh+ZPFlexxDwxzqEEOwmq+yYCWiUKOBXk6T1Up3k
 DbXRiONLDHtgS/WRzW/GAvtN6i0QPB9qPZj/AOQ3beKRmwK2MdYNpX9Mlyr0yvw/vcGfP82jSpx
 p3IWuIm31c2XGI6RIiIVE3CLvvy9qE4ZWb76sRg/HraVWtS3JN/oeGmtaOLMM3ej2VbuOqpd++X fM/oa2Jdefzs+3w==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp; fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
Content-Transfer-Encoding: 8bit

The DTS code coding style expects exactly one space around '='
character.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/iio/dac/adi,ltc2664.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/iio/dac/adi,ltc2664.yaml b/Documentation/devicetree/bindings/iio/dac/adi,ltc2664.yaml
index 1aece3392b77..4688eccfeb89 100644
--- a/Documentation/devicetree/bindings/iio/dac/adi,ltc2664.yaml
+++ b/Documentation/devicetree/bindings/iio/dac/adi,ltc2664.yaml
@@ -174,7 +174,7 @@ examples:
 
             channel@1 {
                 reg = <1>;
-                output-range-microvolt= <0 10000000>;
+                output-range-microvolt = <0 10000000>;
             };
         };
     };
-- 
2.48.1


