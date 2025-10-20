Return-Path: <linux-kernel+bounces-861368-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BAFABF28E9
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 18:55:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DFB3C427FC4
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 16:53:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60E1A33032E;
	Mon, 20 Oct 2025 16:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wBpO41ED"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BB1F32F76E
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 16:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760979153; cv=none; b=gy3nzWsKRrGY1Zdf2daEKL49WnD5riJg5SmoegIV9OmeCh4RX6+Z7OTVcWKdFCdRrisQhcXHEHqpDCtp39kvAdgHMe2/8rDlBVrgmiYXjmDB0a1kRX0jLR63BzXvgPMcT8cAZWBIrKEYopyaTnuaXWE+IcY6sX1ETZ3Ktcau7tM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760979153; c=relaxed/simple;
	bh=vZieQoaOZdOJrGclPot4iYrFQ6Avj0HaDeuJuEXuAPs=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=atm7UGiT0BNE0VdfMx/GICvOSGn23Gfo023gE03Bi8mPtmdcYb/16q7QEIpnfPn15d0pDzZW7zGmY78LOHFGkzD6i2dFzTCasH1T7uSP2YBk2IiZazw971owjfMkmGQTAG8SQjIR6hhOGbkr+XexA5pQ6NWxjGZyyIeDy5fb0z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wBpO41ED; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-47105eb92d8so7315315e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 09:52:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760979150; x=1761583950; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5KCYjApNddIGmUSFoVSxu6I7kzYfXwxdV5uFV5PNTps=;
        b=wBpO41EDRHAuN6UNUYM68oS7Betxv5nzZl2zoxFZf9o9JcYMvdzkdqCZn6scjhaYYm
         Me4ZD+z3Co5KDcOEOWp7KqqvRYrL9kOM0HB9C5LIZsI4d7DF07oJBLRaYrpp37sr3WgT
         Im3VHgC+JJUIdoB76aoYFppKIOVGvWKD+8NY6Cft5rBqg8nWgTnuHUH6+rbCSwnzCPpz
         gn1j5mqJDxJCUGQUe32GPGFNTMbrrK2IwTo8qQhnxJVVrrb2ZVhWROIxtj3NKm5S8/fK
         nuF/aXSz898u6gHy53nHePQ6Q8ICk5btLkFgf45jnzM5AfB3lBP7Ku5P5uy1SrEXQsTI
         OZlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760979150; x=1761583950;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5KCYjApNddIGmUSFoVSxu6I7kzYfXwxdV5uFV5PNTps=;
        b=GelzGAHTyxhz4TLmmAF/C2TS7m45cPyd+0DOTkY9zEIsUjaEPU9pjQpw9cL58OvDKj
         fLrpW4py4ukkx56iYK/3Fb/u5aZPKMogkXXnYbic1NoOiV3venF4EAXmhqJcPDvCVvS0
         vJcPvfVw+SYAWMzoNF2GXvjOtHoyScyOsRRHfsr7F+Jx+Fhp1fPEyztgNSTd2meoBwAN
         PgFDOcj13wZzjNdUc6cAGIEtKeQsesfgrt+LOystE1yXiwbMiJwmTUjO+2iknBl6lvZI
         2BSForI6wUApLBU0YuuVUjdKAYpc7cVToWJq+DwYjK1e6gpxds52mWiVAc8yMP/WFxN6
         XJiA==
X-Forwarded-Encrypted: i=1; AJvYcCX4CqHsNKAUUs/Nu5hoAjebncuG/AuQb7NY9Q/M7keRNrdLiANolfUmaxJpCPKk5pqts8VkI0mFd8LjjX0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrE+zAAT6LKIIGmF0cG+d+sxY4RO3FQJohpIOx4LnECO64B4Aw
	xDeHdrXifH5CN0vVuaMcD0LyYbifoEHvBXk8r/rwNLYmNANyPqsM6ccIx7zwMeFAQCk=
X-Gm-Gg: ASbGnct046fysSjsw273LM0DxWrrsWShQxJHeHelmBY82yRprX1umctuy6TA6+CT21+
	aTY9etXoA9V+FLDMjUiA+HUNluCn00NPdAPF6pv85GBeAIDCaEH5ShLg/+fOanVw6Su7OfJy+Cj
	xY+imgaxmNzGPyzeidjsBw+ckiMYMoVrudMS3HRM5Z6GCZkWsV9ZJm/4I+zo01suBrlVC+rmlhK
	d9N5B6RVtuVnkRvU+f1/+W1ZXqBK822P8R2hWSiG+QoYnJzPLvhSsknbOrLTzFPWGBt+FJUJTrd
	errw4L5C3bx0pr+PFD+LqB/Rj8M2ICwR8lKmrfvYHPaQS0XokVAxAMbgvDXMhaV4UMWAVK32TCq
	t6xF7SIalPdFzjI6gP7a2uSZH5ZaMw5hNh4zvucmI6mNpOoLyWmuhjPtz5FwwAdJuyLLEYXFCew
	bhUC2DC+gJi8dRQ0FX19K+RBgwe8Q=
X-Google-Smtp-Source: AGHT+IFq6eiUybBCcgPn78eYQEMq8UP3MM0hOecYMP9MLQwhWe/dX5I4wohsL36fCYcUPbfIoa28uw==
X-Received: by 2002:a05:600c:1994:b0:45f:2c33:2731 with SMTP id 5b1f17b1804b1-47117874694mr57176425e9.2.1760979149761;
        Mon, 20 Oct 2025 09:52:29 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-471144c82c9sm238324695e9.14.2025.10.20.09.52.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 09:52:28 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 0/3] mfd/watchdog: dt-bindings: Reference watchdog schema
 in rohm,bd96801-pmic
Date: Mon, 20 Oct 2025 18:52:19 +0200
Message-Id: <20251020-dt-bindings-watchdog-timeout-v1-0-d0f3235eb327@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMNo9mgC/x3MSwqAIBAA0KvErBswM6iuEi0sJ5tFGmofiO6et
 Hyb90CkwBShLx4IdHJk7zKqsoB51c4SsskGKWRTCSnQJJzYGXY24qXTvBpvMfFG/khYt0o3Sqp
 OdC3kYg+08P33w/i+H4t+CO9uAAAA
X-Change-ID: 20251020-dt-bindings-watchdog-timeout-384a54249098
To: Wim Van Sebroeck <wim@linux-watchdog.org>, 
 Guenter Roeck <linux@roeck-us.net>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>, 
 Matti Vaittinen <mazziesaccount@gmail.com>
Cc: linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Timothy Pearson <tpearson@raptorengineering.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=863;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=vZieQoaOZdOJrGclPot4iYrFQ6Avj0HaDeuJuEXuAPs=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBo9mjFDlEe6IncaZP9cdnACEoL4jyItNFxIAgtp
 vLqQXKp6cuJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaPZoxQAKCRDBN2bmhouD
 11j/D/0eiV/jMoQ+pi8sTgHdLuyjB5B/Vz75qXlTFc92kE9d14RZtuSenpe2kjPoeB2HEYy1giF
 gCTSI6jWHM/LPj1uo1h2wMq0CAFst5N1F4v0ayycNsvmS7W+QzhxeMyLjari7ichpajDEL8d/Fv
 14QnToHKyEyiLgjwVmyWyJgvvUf4U0d9zJOQVWgiib2DkyYwUauAFFFGA/gMRN/2MPPwPltl3Pk
 CX+q1axt5729Ict0OPzkUDIFumxbRY0CVSzpuSlUEqxzmfw/AXgZUIlYMaBDKEWI8e98J6Mzwj1
 8eHLhFeRMSMQF+GqHefEK7R1IpPhjTLFmK84zHnQ4Gb3Dlyzw3moviQy224zs3r4aMbJffLqatA
 bYo/lP1nyXaZYjBSc5nHox+g3PR58Dp2pg4BO91z1nwQULv8QHQJzpK9uaK9nlH85/L9l+rEvXQ
 4huh2f1KySxWU6HmvdTygAE3+JQFXCeoFrSUSsGOda48w/5nXboFV+8uLGGQB/R5pCdBtOba9qd
 Cz0Fa0Nhn+cJN0XwFWQKgg/5/kzSaWMdpc36mm2YH7bjh/4JHUuvKDKoni1OOTX77ILa5UXAHqI
 Wl/X8DCdkctHdO2BnlnLI6ymgQwVgmxYR+6vB/PnsFITF7DDmZ7tlsmLBPAkc9GJx9aCTD9SJEX
 PjNvAIztOfkAPTA==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Dependency
==========
The last MFD patch depends on the previous watchdog.

rohm,bd96801-pmic.yaml binding should reference watchdog.yaml which
leads to few more patches.

Best regards,
Krzysztof

---
Krzysztof Kozlowski (3):
      dt-bindings: watchdog: Restrict timeout-sec to one number
      dt-bindings: watchdog: Allow node names named 'pmic'
      dt-bindings: mfd: rohm,bd96801-pmic: Correct timeout-sec length and reference watchdog schema

 Documentation/devicetree/bindings/mfd/rohm,bd96801-pmic.yaml | 8 +++++---
 Documentation/devicetree/bindings/watchdog/watchdog.yaml     | 3 ++-
 2 files changed, 7 insertions(+), 4 deletions(-)
---
base-commit: 52ba76324a9d7c39830c850999210a36ef023cde
change-id: 20251020-dt-bindings-watchdog-timeout-384a54249098

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


