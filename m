Return-Path: <linux-kernel+bounces-783227-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 420CDB32ADE
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 18:33:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C4F2AA029D
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 16:33:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16D021BCA0E;
	Sat, 23 Aug 2025 16:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gTmAaLwk"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7114155C97
	for <linux-kernel@vger.kernel.org>; Sat, 23 Aug 2025 16:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755966786; cv=none; b=kH3qdGlkLDjlmrlkcdRGbAR32slZ7+bwlmOgnN/AgcLYGBWblSu20xIg4actMCGGioYAUi+up9hQIxwSghrDIsloWhy/dmxOD5+/Rtw6RpVSqlaEjYINFHp9N1lce+6Reku6o0Ey60JNfhUIn3hmgDgY/WP7+kD9OieT57iE2RI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755966786; c=relaxed/simple;
	bh=yxuy3oDJ08FCrS2YoJDAqGlTn0pBViRwW5im30kIBpM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TxmSYoP8QIakgCBtLJredy4SaumLe77v5Ualbwl6BgqFSOCv8CzPoqqgs4dXpDCHNsnZbmOuER4NEiOtu6SLi68tQTw6b1EmOje28//EAk9R4HF8dfeqxUdz3Tc38Z08sHJt0a9YoCpqlYSB42H6BVNKFbJgFN8aenqKo+AHX20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gTmAaLwk; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-61c20df01a9so191376a12.0
        for <linux-kernel@vger.kernel.org>; Sat, 23 Aug 2025 09:33:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755966783; x=1756571583; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=STNSS1T+h+xo04Oxr4E7Wd3mL52PcoQ8ncvgJmGARK0=;
        b=gTmAaLwkWChz+NX6/AOFlK0vuvp+a74V5sWhyHPqvM5tv4yH8tYvtG3mttcwjsu6s/
         NfI61cVvYu6XqF/2RqVPvG9H2cip78FS5PlZranI0sIsrgEkZb5wQI4bbjtg8hKPmmc1
         CwL4fPkmiVu5HQd0K66q7L+m91n04umS6SHHqm6Rag9I5izstfyYZrd2Hr+tJvwMoZBl
         sI58yG5Ri05ptDEiyFRblaQ37pRY9KBbN85r8Cm3L/dHoePYeHwO2l+eeE0CMa0DSR61
         aGBeh7MybHXgLd5pmaD0Df6Bxlj6NldvHLA9JpQuf0oMCwLJnL7knsr1ZYIKgXTBCWHN
         IbQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755966783; x=1756571583;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=STNSS1T+h+xo04Oxr4E7Wd3mL52PcoQ8ncvgJmGARK0=;
        b=huLIV5gpP1MPRszuSbemCZxYmYWms7lr64VdrAYLTZmFMX+ALW/5NDCbhX6Z6VteIn
         5G7hPLEsuBGNY7PYwZUM63XNIibDplEn7v+HkCi/IVDyQiMMZoatMF6xJEWZGJ3b/96t
         IsK7uPtEhrTwo9Sf/LzIScPz/mYhlZuKHnUgxMVLSYzTeTT0hQLXkU7dVK+pA+1LsiAN
         EWyve/ykt9yhzCkLp55HOkVU3SNuyXUWMISOXE0/ewWjfC4tl/qwbaUyTBh+um3gUidV
         mzrHV0fXHz99DgAzGYnPMKzs4HcgvuW+sx8LgIPtVB5kbeqjBfg3YVCxGc1KGElSQPMF
         Q1wA==
X-Forwarded-Encrypted: i=1; AJvYcCVPd4vBZ14OJRbgRoDKXc1N9cJBGxa5D2xBmb2pmrWtOtQVZiK2J4Ex8gtQkuG4R+6pkokHKkskZY7i/F0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHD/1adzOwUP7zie67DWiiS6+FmtrRljzIdqyD5ZvDtY6qOT7a
	RUXX5X0PiYH7elKJo+PopG0zC9nvBZR5q6Jpo3NdVadq2S7aJ99oDXwZlnbJNcakuQKlLuW7vgZ
	EME78
X-Gm-Gg: ASbGncv8doFghvM0xJ1DeIUeL/Adv8iOXpmEq64oY4ySvV7/k+UGqNZRPRCi6MSnljh
	nrDAKlAm0cCF5h0oY/ub8nef8e1/u2oaaeUJvE39ENcEueLytrxM79oVcaEAnHVqiNBcFA6Urof
	CdaoOfpRQN/WNb91KmmC4dVkNpJo3YPUUZO8P2z9gjnVCEPaebN/5+XTgp1udxZPwfPpEEDSgqk
	Atg4PNColOeLUkudhDRKl/kAdvXUF9RJLlJbqiw2T7MVy0snaus6u93o7pWByoj22fn5YaGdPm4
	eKvopKL6ePjFcOOz/kSYqcR7I4kNv43JN37gAI1gaEI5abyvKieN6Z5rXsIqs0533A9WmZadHZt
	4tme04trdIjt4eVLbdg0spw27KlUecJ6MOE44avXHOCzH
X-Google-Smtp-Source: AGHT+IErPaYZ/R95hNRLUPhZsS2vquoXzXo7P0FirUWFb/QPx3CCkmkS9LQTJIIb4KUb+7m1ka+ieg==
X-Received: by 2002:a17:906:c116:b0:af9:6580:c34f with SMTP id a640c23a62f3a-afe2943e3a9mr312096366b.9.1755966782918;
        Sat, 23 Aug 2025 09:33:02 -0700 (PDT)
Received: from kuoka.. ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afe492d8713sm197936366b.67.2025.08.23.09.33.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Aug 2025 09:33:02 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Thomas Gleixner <tglx@linutronix.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] dt-bindings: interrupt-controller: marvell,cp110-icu: Document address-cells
Date: Sat, 23 Aug 2025 18:32:59 +0200
Message-ID: <20250823163258.49648-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1096; i=krzysztof.kozlowski@linaro.org;
 h=from:subject; bh=yxuy3oDJ08FCrS2YoJDAqGlTn0pBViRwW5im30kIBpM=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBoqe06CKqz7vUiMX/kbfeMtXcTP08L2/emP36Fu
 j85/zUeakuJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaKntOgAKCRDBN2bmhouD
 14R+D/4pm/ejDJYyjI2JDvZXREerlPNO9m1qSmi0mMowWiIXkWWOWxKHtQDHCRn8bpYMQqvedoY
 5qT3c2EIqLROQg/54kSFJDSGDgy5gEDK08FL2uF27HXMD1PyMWaDEmyhpC5daRfjpf6H0dN0pMR
 abKotXNpGXBr8Xvvh2NPOoxRK0dp9e3Fzo971IhRUREJo7YDI1XiUpn7oqnMe6VAXePKsGF1Igi
 vMOP9Q+DZamATcJ3DyWEy+QeLHjXkSXisKlnTzdRssoHl4JoKTwPbEGwHFMYOWp2YlID7Of1mIP
 EP5EGdY/kwIms4ZzZcMN0lv4p/FrOMAS/rjvG7cqb7i+rd/IjlzscYYK6wkVb2hVoPSC+vuCl9L
 /QWz1TDq/Wd6nbkjd8QujodZRZVEMGTr5AypicnOVAfAg5Sc6z90vzaZDvs3ZrVJ49XgK8tnG+d
 eW3XRb1mMLfFg7xV1LR1tUF5ez2aqaHkj0DX1y9bbj0oZVsB3QIKWJ8Z7OU/ImL4eHFjDJhubuU
 jSgaH2lJFT2wfE+mNxa3BXQbm2TLjGTctZuyv2Z32MQZzbLt56IvWTofi263L05psauT4lOyawV
 HF/b1MGUXfYwKi8195yFpTQKxyx+v6vTdN/fMIggDQg5wkjgwCcfLEJlqweIZ9VW8+OpY5Su8q2 f91fdG/0GpnTbeQ==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp; fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
Content-Transfer-Encoding: 8bit

The CP110 ICU children are interrupt controllers and can be referenced
in interrupt-map properties (e.g. in
arch/arm64/boot/dts/marvell/armada-cp11x.dtsi), thus the nodes should
have address-cells property.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

See
https://lore.kernel.org/linux-devicetree/175589786306.518460.17450425303264875357.robh@kernel.org/
for reference.
---
 .../bindings/interrupt-controller/marvell,cp110-icu.yaml       | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/marvell,cp110-icu.yaml b/Documentation/devicetree/bindings/interrupt-controller/marvell,cp110-icu.yaml
index 9d4f06f45372..ddfce217e119 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/marvell,cp110-icu.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/marvell,cp110-icu.yaml
@@ -49,6 +49,9 @@ patternProperties:
       reg:
         maxItems: 1
 
+      '#address-cells':
+        const: 0
+
       '#interrupt-cells':
         const: 2
 
-- 
2.48.1


