Return-Path: <linux-kernel+bounces-861370-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 792F3BF28DA
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 18:54:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E8DDC4F936C
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 16:53:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AB293314C0;
	Mon, 20 Oct 2025 16:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZLmolHsW"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EDAE33033F
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 16:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760979156; cv=none; b=Qsx9eCa/TFqmckRxFd/VVxD00VP1TetlB+PHulnGS8C6i07IazoBevDMfuxeUYV+1dUloen14ABVuK7I1FYeMPA/Uk8LA3LgpDkjCJV4ZQAvvn6Imcjq0Q5Nd4NBpLTk4NJmO2hkTTfMSeJGxPW5DgSKnVbKTHScBxHhBneqPs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760979156; c=relaxed/simple;
	bh=htAlHwQVIYizuRXKdH6PchWyf3kZMookjeX2Sgrd4xk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KXpXCBSHyFehIaEmxVB5asTqlXEfpFlsIjRPmPrCM/ppIykhMQrUMHnohJ7Glfzv8juFJLrqDkvafhQI1DqksMf3+GYC/mCJD07w/o2orzrToMp05xlXDO45P4Do0KX93gqG0pbOH30d1EWRS8aGAsh6k4B1WseoI3LuB9squHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZLmolHsW; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-47105eb92d8so7315445e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 09:52:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760979153; x=1761583953; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9s2zBGFC8HC7HhNDa+xm1kX5bnSLiqdr+y/FIgBtsxQ=;
        b=ZLmolHsWXsLJwuH41+/+Zm+e2G5rKhJJgGMLKl3MmUanjPWgRnjRY/X3snakIWVXDo
         fcuSsw3Io+4G0ezUGBkZn3e1s9z+GaaEPuDeonxZ74oPMadiJa6xiG0Vf+JFhtHaLgab
         hX8+tKmUSNZs28yuTv6s9hCxEe7mmSn76QyD7YLKaQFO6Aco3Fu7fz5nMUCQ3FW7L79I
         QIm04ZPTwKZUvguRG/2VFdcjIcpDknMWfv0Og3WisdGhQXORGIY1483S/KcqHq8ZWWnU
         tU5RHIpJTfnxHB2Gw+3FB0R0HC+azjp2XRU/YvHDbheXTUfQvcViGKcFfP5YIlvnI4MK
         EYvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760979153; x=1761583953;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9s2zBGFC8HC7HhNDa+xm1kX5bnSLiqdr+y/FIgBtsxQ=;
        b=JjeBG9jsZVAcGnu8Leh/1ALPGL5qwq8xiuPa1jtqW3B0jXSt/ETrwLrofgeYqV0GeJ
         rD4Hk3JWfz7qPvLEiNxsUWWPxc5X0mkcy4PRPiQX037tJpxNlMuZQhr88U35KCpl09MO
         VVk/I2GtAe8Pgp3oyS6uA3qbd1ECw0d2q8r3ikSy74sB1zN/bggg29ghiVxuGiZMy7t7
         y5JqcdEx9XjhI9xIpOflWts422FPCLMKZjtcuYF9OtGqX9xJkWjK5T97N40U/mjuuNoc
         P2+iSpNQUI7zFJYHO9dNi/MxroYos43Cw+Xbt5Te96s/xct2B+WLSIjniYWYX5wYf6Xu
         Kbnw==
X-Forwarded-Encrypted: i=1; AJvYcCU59amJNHYxi1UzoDwVPg+AbBrsrd4eWyiJ7Mz+/hcQ65wIJu29pEE9vbuDyiizsPB1tZE8z5EftanoGCM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNyE4VbY9UAHxwd7ERizCzvqKeCLMlo1i8gIMAa4pML7Mk1DVv
	a6Z0YhxXSNUyiajehAib4G5NzLH4HNZvTExdLi1gfZXOnliDRb0FlhVrLp9wM95ImBM=
X-Gm-Gg: ASbGncsT3NyySanBFrPp9tOdWa3Y8Y5Ruw790ZhErsGOUxUskjEsyRevhrxVvpiAiO/
	GDsBNqKv/T30LyNGq6+0bYrccmusz0psdossYqtCRg109h0XP7cdycEaI12fI8Mb1FuMaJBm6s7
	mO/shJ7yg2hOnM7nYuXf8f7fjWz28lxlV93g+/gbUQrTzBdGYYdrNGOa9pm5qCBnPcz4O/sli6l
	3yxOI6Rpsj9KZxghptHOokTHUDLvP9Dzc4WccP0genkMf/DrzxFRvJGE90vtIOUUVPvMc9geTxT
	KaOlUhuCyrTeGsIUVjDICxlHFanOjIQUoMphg3TwPM+kllblohTzU1SGIAMYAJQA9/0Hdni6sfD
	KUhDqKz0f/5lbaC9utufYl6t+QW1RUDaR9TwolYQKA1ljTOzWwgc/wG5CUBqzvtjiCHOkN7aHxI
	V2Af/VY0DDt049YrrFv6DqReR3/eg=
X-Google-Smtp-Source: AGHT+IHG9a3/3M25m7Es4vnxCmLCJx69A8ax6XoFZlXJBUz+MkJq5yGxtpLLdLEf4IZ4Zi6XBHqZFQ==
X-Received: by 2002:a05:600c:3b04:b0:471:12be:744 with SMTP id 5b1f17b1804b1-47117932dd5mr55329145e9.8.1760979152937;
        Mon, 20 Oct 2025 09:52:32 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-471144c82c9sm238324695e9.14.2025.10.20.09.52.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 09:52:32 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Mon, 20 Oct 2025 18:52:21 +0200
Subject: [PATCH 2/3] dt-bindings: watchdog: Allow node names named 'pmic'
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251020-dt-bindings-watchdog-timeout-v1-2-d0f3235eb327@linaro.org>
References: <20251020-dt-bindings-watchdog-timeout-v1-0-d0f3235eb327@linaro.org>
In-Reply-To: <20251020-dt-bindings-watchdog-timeout-v1-0-d0f3235eb327@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=975;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=htAlHwQVIYizuRXKdH6PchWyf3kZMookjeX2Sgrd4xk=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBo9mjKWkCODiSTKVC6hNwgzQPe7coHBherhOW57
 0KJ/VKGemeJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaPZoygAKCRDBN2bmhouD
 16bBD/9e7PiFf8JEVvATyMQtFP3rL6Z8LpZpTQS2yu7d+wi9snlR/LzTCz8tGPMCbPNZZQKYGUc
 upB0lCvkB7lK6YXiJkTuHC6c0lZIWi3cNlG1EEkLUTBMHLJzfPlu7W7dxfLbV+cd0Yxh3jQrDMl
 unTPMzc+P7h4GBmqh3tLjg6n/qwmKE4poh0kAGqfDpmNpR3nrlWJsjwC4kRUbJ6droZ9/HJudN1
 OR3UQtcIU9EsKmYQVD+YpuRX+g9+obMRXL616UcNow0C0bFi79TUVaRJRFFD+m83odDthX1lRo8
 CL+4V1K+B1qtDcvQBmAWfPMiHprjXcpU74OHhwzNflVBh2IW38dA9MLzioVVIlmE6EMBKlBiUEW
 KeGZIkwHkByhcfzYaG48TyasyqxaQvUEfCHRDiLxtHgdxbegno9Ci7G66pY9/P1d/rIPH/z0qvI
 A92Yov3qavMU9kcAPKBWAxObC2S1AHSRHylnDr9FK0QHaAxrljD612UGZ/yLxYlseMzU7QCH5Pi
 7tJLFeEUUZEL8L3VHfhzzJmohvTjFZTOXbZFHlvO3i+AjXF2WWIyb0tcQi0aVZzKd+/5W13yK/a
 66Hu87O0Q1X5E0K5dxze7VBshMQmeqjE2MGssHMb4wfOAuUGnjAdB4Ype+1t/f7lbRxmAylWDao
 GAU7cUOKliGSZWA==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Watchdog is often part of more complex devices like Power Management ICs
(PMIC), e.g. on rohm,bd96801, and the schema can be referenced by a
binding describing parent (main) node.  Allow another typical name for
such PMIC devices: pmic.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/watchdog/watchdog.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/watchdog/watchdog.yaml b/Documentation/devicetree/bindings/watchdog/watchdog.yaml
index be0327f587eb..77ac23516d6d 100644
--- a/Documentation/devicetree/bindings/watchdog/watchdog.yaml
+++ b/Documentation/devicetree/bindings/watchdog/watchdog.yaml
@@ -21,7 +21,7 @@ select:
 
 properties:
   $nodename:
-    pattern: "^(timer|watchdog)(@.*|-([0-9]|[1-9][0-9]+))?$"
+    pattern: "^(pmic|timer|watchdog)(@.*|-([0-9]|[1-9][0-9]+))?$"
 
   timeout-sec:
     maxItems: 1

-- 
2.48.1


