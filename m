Return-Path: <linux-kernel+bounces-792895-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2631AB3CA1A
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 12:20:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 68C38189D33F
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 10:20:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 530D927703C;
	Sat, 30 Aug 2025 10:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="i4bYN35Z"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B60E5275AF2
	for <linux-kernel@vger.kernel.org>; Sat, 30 Aug 2025 10:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756549153; cv=none; b=T9k4EWsvmBe3hV/Xmor4CWam5kG2nCQyqQ8WYx7LrP5+lmMukiG8hMKo/b5WFShUUhHYuYskTEI/AjziCwfDRStz3tvBVzCWC22BRCD/Vd8fAbOe7gIKf7OR2SdnwzUV+gGN42KPtBaCcpBnm9Jb1eUafx3IoEvnDZohnL6gayU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756549153; c=relaxed/simple;
	bh=NvFVk53JPURQUDV8Y4c/VLoYIsxRD0yXmhCyTafaDzY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Emb6pm63bgaXMeSRBkHV9lGFHQN2XXmd96JX69fCSdOaFeiLm54YtWTjI5Ho7CJzZW4UVpbeTrjL8F6koyFp6XfWIzjahoOegZvdgwJoDVbTKG0GYf5q9pNG+xmzvbwoOg4oTwfCQPFhyrWPv6NmkX7hZFhtUkzFhcr2BBybQcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=i4bYN35Z; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3d12c5224abso168847f8f.0
        for <linux-kernel@vger.kernel.org>; Sat, 30 Aug 2025 03:19:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756549150; x=1757153950; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RQkwG3esvRsRXcGjq0nlDl6dBfzj0vcyqIdzAb+t90U=;
        b=i4bYN35ZLZDD0Nzhk/bhLF4zakj4gmtbBh9AquJ7r16P1tCgrJRcBgSGaesVnKHdpo
         eqks+zDij/eehE1a7xhPhYfuGeONd1YzaRvpMqwtjkFsh8KGhwutB//r7UOqyFPckXws
         L3Vsck4BGlzwlLWGw3ku9Re7QN9Ai0ekYwe9cFvnV3iq2dtohoc43QOkePvmIGNbAB6z
         xkUsb0LQv9MMtHES9WYFVNspFJiz9haIQXECzw9ihQm5CxnKXou+sX3YAa8kFO9WYJYd
         dbOQ2hQkZiZC3Ro56XL0dv9JUJ33ZN51xqRbJzoIfwUO0d76YkPHIHN5JPLouH5nUMKx
         Rz1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756549150; x=1757153950;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RQkwG3esvRsRXcGjq0nlDl6dBfzj0vcyqIdzAb+t90U=;
        b=t985Ktu2QsusIJV+SJxslUAo/l7Em3W2Qxh5X7Kh5s7epg+LYjjXd0xLooQ6wzHHZH
         vwHdZV8HergB23a+v/QWqU3PjcSCh4a1o5pjUvOP3YaBH/9IsnpT37axXV9E9CcFppNp
         49pj7acu84+1QoHrCb4a3Nz5r/4B8q6Trb0atFBOb6lAdy44yvDYJdiBx1kffocEcmmj
         4WphsIoq2Nrnv3VSwfca4AFQIwfSYBgrExcSexYstVVplzcDAHh27vcSUuAL9wyfz/Ln
         Jj99wGd+ntsbRNRlsvDpyrKAABWBzDcKk9tnOcthVi52AAMhDk/wzt01Dfr1zNMURLio
         VLHw==
X-Forwarded-Encrypted: i=1; AJvYcCUElAV7j8CujGWTbZn7HBG53lxphFteXBH+aiWMoDFi+qP7QZDzbV6ffxPef/oHODSpgBHABlWb/phKUCg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVMSMNKoIKiylWQkgNaNXFYjf3AkoYC8rt8vH9P77lr2TSKyRN
	ICK8c4S44sqTeJshw2nl2Nio+ZreU21K1WA4QMF/fjDfVyK6JCb4EsMQP09gnTbpLa8=
X-Gm-Gg: ASbGncseow0MesB5ISZCAGKA977AhU4/WOBsAD4CygyxfyOyYJi2FU7IZ+XWDiy+blc
	B7V752XH5l0FzKwYhQ7BPmAtI9xRwPw2l57mM/pem/t3GiQ6QlIW14fLzN2CQ4Q7k3rCGwak08t
	11lccl+htn7aNoZ34qjF4uU/MYfkx49GBMLKHwlP/oZHXiAykBLZ9TuOfMtsWX000mBcuzx2tTL
	Wrs8PVItpSjXmj8BoxwNHR9dgmHBSfNY2QVKR6Y/iSAONKVcmFkOehA50Z3McUU+VXOWVGRln14
	WC2KcrvTbUYpx0L34tjmXbwd9aNoVPcih0fa2QEf+R6/gi5RovJzIAnM9s2OADoAlZyTrCBtO/g
	OLl8AHZ+ZCQQKehcSpvRkLYc1eztVM1a7vIiF91/l0L76ao7s7w==
X-Google-Smtp-Source: AGHT+IGvK4zWnlaCkD0f/IQFYVOmByD4kqH4uguG0N/BCo4r6RwhrUrDJK8xeOPyv5jvg1TSq2X0mQ==
X-Received: by 2002:a05:600c:444f:b0:459:d7c4:9e14 with SMTP id 5b1f17b1804b1-45b800cecd5mr22607935e9.0.1756549150034;
        Sat, 30 Aug 2025 03:19:10 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3cf276c8eccsm6547492f8f.20.2025.08.30.03.19.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Aug 2025 03:19:09 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Sat, 30 Aug 2025 12:18:59 +0200
Subject: [PATCH 3/4] dt-bindings: watchdog: samsung-wdt: Drop S3C2410
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250830-watchdog-s3c-cleanup-v1-3-837ae94a21b5@linaro.org>
References: <20250830-watchdog-s3c-cleanup-v1-0-837ae94a21b5@linaro.org>
In-Reply-To: <20250830-watchdog-s3c-cleanup-v1-0-837ae94a21b5@linaro.org>
To: Wim Van Sebroeck <wim@linux-watchdog.org>, 
 Guenter Roeck <linux@roeck-us.net>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, linux-watchdog@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1400;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=NvFVk53JPURQUDV8Y4c/VLoYIsxRD0yXmhCyTafaDzY=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBostAVi1bpYXyeIxAn9++1KZjZ2KpRpiB3xHjRF
 uAMEVQ8RMaJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaLLQFQAKCRDBN2bmhouD
 1xxQD/4ii3iTngoFf9A4Dgol3h6dIma/GS0zpvssmtqke8BXY3xVZWg+j4w7cvobY7VQckDxOMN
 ZFnQ9kmddkcXTuKB33VdUlZLd2qnZiGZohnl0EEdDzQRJj99lfwINF9GdMgxuX9urIcCV7bXLV2
 rNmOLdOfoyTOl7NJjQvBVGyN5dAk/dEPbzqcHkKSSVxuu13deyIZhOQwhagA1j3JKhIYZPUwf9b
 k4bPN0yBvoC8bz474FsU/awElM4pRLcqAObicKeyMhzLZ33U0C0+vQvfp30YF+GIP9HVw7OoufF
 WxE93XppZpgXfHnXgMoph9qXjMycTUkipcX9hpvs2Vt82bfBUlKaSxlz815RMpQ3VgluSoNNS7D
 q9SjLMj6Nnm5AdreDm2wQLpJQ1HM05jlEPU4wYgK/NBDUrF6UCmEeFjBbIJGnUNnHRO6r+xb4y+
 A2njgktciBlZ9ZbtyZ/GAvm5tcorVl5ztTRAkWGFgDaFV4HGhQfqDAaNklgkdwFwT79KwLNodLV
 YrPI48t4HlPiPNk7TbpUBJObPFc9qYgSQmWDB5sBVcZ5Q55sL1/T5VPPlFTG01BNDz3S4qF0tyy
 XinK4XV82zUsIa8JyFcfsqlGlf5VzO4bVfrZ0Knwr6CJ5ZgR/PZpKm3XBz7gISM2seUqrvy2pF2
 XbheD6X0aTBjwDA==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Samsung S3C2410 SoC was removed from Linux kernel in the
commit 61b7f8920b17 ("ARM: s3c: remove all s3c24xx support"), in January
2023.  There are no in-kernel users of samsung,s3c2410-wdt compatible
anymore and platform is so old, that there should be no out-of-tree
users.  If such existed, they would have enough of time to object
dropping Samsung S3C2410 SoC removal from the kernel (which did not
happen).

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/watchdog/samsung-wdt.yaml | 1 -
 1 file changed, 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/watchdog/samsung-wdt.yaml b/Documentation/devicetree/bindings/watchdog/samsung-wdt.yaml
index 445c5271879f002f2b05645a0e748dd9be5aaf72..51e597ba7db2615da41f5d3b6dc4e70f6bb72bb6 100644
--- a/Documentation/devicetree/bindings/watchdog/samsung-wdt.yaml
+++ b/Documentation/devicetree/bindings/watchdog/samsung-wdt.yaml
@@ -19,7 +19,6 @@ properties:
     oneOf:
       - enum:
           - google,gs101-wdt                      # for Google gs101
-          - samsung,s3c2410-wdt                   # for S3C2410
           - samsung,s3c6410-wdt                   # for S3C6410, S5PV210 and Exynos4
           - samsung,exynos5250-wdt                # for Exynos5250
           - samsung,exynos5420-wdt                # for Exynos5420

-- 
2.48.1


