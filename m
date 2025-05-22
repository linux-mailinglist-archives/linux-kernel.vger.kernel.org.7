Return-Path: <linux-kernel+bounces-659210-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B57EAC0CD2
	for <lists+linux-kernel@lfdr.de>; Thu, 22 May 2025 15:30:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4BA9189E385
	for <lists+linux-kernel@lfdr.de>; Thu, 22 May 2025 13:30:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A1D928C850;
	Thu, 22 May 2025 13:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="gRgmfTrI"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ACAB28C5B7
	for <linux-kernel@vger.kernel.org>; Thu, 22 May 2025 13:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747920606; cv=none; b=rRNY7d5yL7Qhj1iYvptkk5issyIQzT1mrETDpJ9Sz5ysIyNuzUgxEMoG07pHmbablAqc94owy0ekRXLwc+I+wr2AkNXXgPQJsFmzp9PkKQxx5KWVPinTNjCee8TSJE3xekBPf63TXJubJibfPIZ9tqU2AlD7xJ3pH8cR6hKDhMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747920606; c=relaxed/simple;
	bh=NtotUFQE861trIH/6KVUMJlh1RHFkSekY2PpGsDNTzs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=adjC+hOPorFujNwk6iWMTzYDDLsqyd4rIjt/x05eqFAF/s8jrXS35dvMnUwbuERzTFyhPbdgvtWdIafNQYOUTv0lh0EGtPrW/VSnKyQkBIW+bzNd0ipBVINnsOfiH/vrHyye3iNfUFRzQYqxmXrvZw4xqQuJ/CQh8hcBK08jLgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=gRgmfTrI; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-442f4a3a4d6so52367365e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 22 May 2025 06:30:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1747920603; x=1748525403; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SSPYC82OHD2BI/YU/tjmuoLa3AQcRKZBypSGl/10x2A=;
        b=gRgmfTrIuGwPrK7Fs/pGDE+VezigRH6CBrZSbLo4N2e7GyFseQOz+sjcIF0KJBB8S/
         SlMTodoaiB/MsXpFC1tjZgHKEPFxnGXtdwPdc9kM3C3M+6TqRG5wQHmdnJEjWJahw6RU
         Nil5eEzR72+3vDVgQ9+7jplZRacDBpjbufeXFVHTpb9Mt1vCVROa9M0NyCfzswRqOL9X
         iDNVHG61woAiRH1jxQPo2BL1sk24HrUmn4ntnaeNZNC7Ww9hcVGdqWwQBUKbpOKxMEKa
         nhh/Ii4FRdKrjcn+uhTpd212rDpUI6Meyemm1w0q/pgFmWk7McXNqRlny8UHHHjZgpyk
         YU1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747920603; x=1748525403;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SSPYC82OHD2BI/YU/tjmuoLa3AQcRKZBypSGl/10x2A=;
        b=l+yjy3juEwSo9nigkYEuWd/RNo3Dnzbb40TYudCuSrcHt3RZD8bPrPlOg/vv8wgb3T
         UHOmkthINuXXCmjBkTfzliZH9N6BYpBeFvz3/b5K2fJR7DqOosZ/8AAt8qqjN7YYyWJU
         J6CK7Ba7a6hU03/qtot18Md0boxqHxrb9P9WTDculE5FOo7W/u2ez404F75fbAbkhVF+
         nBPFYrxSxQmEMOzoaNKvQFAMasoiu7bj1gFI1FPYG4Ve0tQYul3P4RvWzvyxCgGXn4fM
         6DLZtMpEp1d1ig1Ff/jP8haBe6ouDQteFWMkOp5qXbUFfBbNgkoLzwS+3DjATuse9Ly6
         YIfw==
X-Forwarded-Encrypted: i=1; AJvYcCUDeWgrOj6V1TxjotyjetJVJGZH4PgHuDP1uoVOeHwPsNfghudBxREp/9LpVR/NiuVqPOivrDwa0bdCOvQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfUeLw77vrpQ0dlE2CzeaF6b1JLLkOuxKl0n01ci5xyUQEDJJ7
	gcPsyiUeoDRfh2B7YiXaPQOgRcJgGYaqZnzIQkWakAkHk3+RYVSdYAa9J6bPhuPI7mw=
X-Gm-Gg: ASbGncss6DP3mVONqKJQkWPLusRl8z3PwRlNa/Hi263/W+EOwyBv3pVkd8RxRri9/Rk
	D4EHi0ZCuBuY7FH8wD2+3OVdAvn5truUFT7jMKEhHypP5/uPBjz9mBdbhCOBQvqq6XamWLyHDBJ
	r2mt25pDYoXGvA0u+3XWMJvcJb75RPQhKIHwrS/AsAl8BXUuPLGtLbhppQtUiDbRYpK183qKkyd
	LybfnCJGy5liDJbl5JLGo/rCPrD06IElYjdO4/JD02n0mE79Ldg0aR+ekYOnjbLsfZRcG35jpGD
	rqehCk2u2P7SiuMpQHjJf/DSYYa7ET8zISuGllpSh8A4Xq8VwcZHli5qg11fdioYyONuWVYNdSP
	lslLBNdI/OPOTGf0Vu/N1DBoakzq7rno=
X-Google-Smtp-Source: AGHT+IH9QGz0PDISBiKrFha2AAGWzCcQvew7kYeN4H3AJCARsk7unlU57nvYDBkppGj+7OkhB2hf6Q==
X-Received: by 2002:a05:600c:4506:b0:43d:fa5f:7d30 with SMTP id 5b1f17b1804b1-442fd9a2be1mr224033195e9.16.1747920602769;
        Thu, 22 May 2025 06:30:02 -0700 (PDT)
Received: from [192.168.0.2] (host-80-116-51-117.retail.telecomitalia.it. [80.116.51.117])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-447f1ef0b20sm109837585e9.14.2025.05.22.06.29.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 May 2025 06:30:02 -0700 (PDT)
From: Angelo Dureghello <adureghello@baylibre.com>
X-Google-Original-From: Angelo Dureghello <adureghello@baylibre.org>
Date: Thu, 22 May 2025 15:27:05 +0200
Subject: [PATCH v6 4/6] dt-bindings: iio: adc: adi,ad7606: add gain
 calibration support
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250522-wip-bl-ad7606-calibration-v6-4-487b90433da0@baylibre.com>
References: <20250522-wip-bl-ad7606-calibration-v6-0-487b90433da0@baylibre.com>
In-Reply-To: <20250522-wip-bl-ad7606-calibration-v6-0-487b90433da0@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Michael Hennerich <michael.hennerich@analog.com>, 
 devicetree@vger.kernel.org, Angelo Dureghello <adureghello@baylibre.com>, 
 Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2030;
 i=adureghello@baylibre.com; h=from:subject:message-id;
 bh=mK1GoQiX2hS20/yC/1czrPjfc5t1uAwSltJDkMx72Mc=;
 b=owGbwMvMwCXGf3bn1e/btlsznlZLYsjQV0uc4H8k57KT1P9PiW5Hz1v4cRXrzJY8Ity1+9Pi0
 My5chztHaUsDGJcDLJiiix1iREmobdDpZQXMM6GmcPKBDKEgYtTACZyq47hf5HbtLVnmRxPVr1j
 v79x5hZz+zvfLPiO7joasmpCd1pGiyEjw502u+Zy4TeuLZHpOXVNCz4ETlOrN5bb0GDFt75X1f4
 aCwA=
X-Developer-Key: i=adureghello@baylibre.com; a=openpgp;
 fpr=703CDFAD8B573EB00850E38366D1CB9419AF3953

From: Angelo Dureghello <adureghello@baylibre.com>

Add gain calibration support by a per-channel resistor value.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
---
 .../devicetree/bindings/iio/adc/adi,ad7606.yaml    | 29 ++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml
index 29f12d650442b8ff2eb455306ce59a0e87867ddd..6926f5f090ad6bbbe7bfd9327dc5ae17dafcd1fd 100644
--- a/Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml
@@ -204,6 +204,15 @@ patternProperties:
           considered a bipolar differential channel. Otherwise it is bipolar
           single-ended.
 
+      adi,rfilter-ohms:
+        description:
+          For ADCs that supports gain calibration, this property must be set to
+          the value of the external RFilter resistor. Proper gain error
+          correction is applied based on this value.
+        default: 0
+        minimum: 0
+        maximum: 64512
+
     required:
       - reg
       - bipolar
@@ -256,6 +265,25 @@ allOf:
       properties:
         adi,oversampling-ratio-gpios: false
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - adi,ad7605-4
+              - adi,ad7606-4
+              - adi,ad7606-6
+              - adi,ad7606-8
+              - adi,ad7607
+              - adi,ad7608
+              - adi,ad7609
+              - adi,ad7616
+    then:
+      patternProperties:
+        "^channel@[0-9a-f]+$":
+          properties:
+            adi,rfilter-ohms: false
+
   - if:
       properties:
         compatible:
@@ -398,6 +426,7 @@ examples:
                 reg = <8>;
                 diff-channels = <8 8>;
                 bipolar;
+                adi,rfilter-ohms = <2048>;
             };
 
         };

-- 
2.49.0


