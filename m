Return-Path: <linux-kernel+bounces-896083-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 46D6CC4F9A1
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 20:27:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD60F1887DD2
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 19:27:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F9A7325709;
	Tue, 11 Nov 2025 19:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="czTSgGHG"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69BF5326D6D
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 19:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762889204; cv=none; b=HGk9DCCgMlpamLC13tKR43OQle/hKv+wBqTZWQNtIKNUoq/RdSX1hNU+JSJyKm4+xDXawlEk41t3FUabTEMVaJbgWB4vdjLn3UAbeJ9sFji7CyktgfGVTb22uG9hwjxeK4Hux4fTGxCADKd0se/h4cfE8VkWdNFQkhprOn5mWpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762889204; c=relaxed/simple;
	bh=PuM1AACg2d+I1zG41cyM/NLvQTJ2/H6JFpNiUOMJQO8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Tu9IXk+uszdgE8Zrt4FpnCi3YKp1g3cQIufDMAoOcMdhu2wgxrMI2tIHWOHbGdmoD7l5KhmkfHd3bR3/iT8EJ1WNwsitE7hKm6Oly094mWcRJxfQ3USA99m0z6EFvOmoIoLVo4ElvMkffjm5c/EGN/1aX0KUrAYcl0Mr48YNz+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=czTSgGHG; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2957850c63bso17375ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 11:26:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1762889203; x=1763494003; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BdNxsDJ9m7UGbRcYc8TABHid3VHQHv2h0LQ2tYeasVo=;
        b=czTSgGHGABHc27+UBO36i8NZqqDMtOKmZJeshxFQSzE7w8yHWNBVghJ1OKn+sh/OTr
         pO7ohLbAh3htpT5Tab1CnPR28QtdkyFyl1OX0XN2t7g8oGbTYQI7SVLTchelDU8JgIxB
         AvhMjwViVRw3M+mr9FgRdEyIebm2BDdUMFLy8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762889203; x=1763494003;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BdNxsDJ9m7UGbRcYc8TABHid3VHQHv2h0LQ2tYeasVo=;
        b=YqnaV78K04LoXwfiVsBMTqbvBnQeQG/OTsOxLI4NWw564NNL8GIl0jvjCQC8vBdG0M
         tZ1XYmq7SM5CQTmVEsaANHxoL7309O0HnrTDWpQNMTlUZukEh7QpuIVj3kSKaJLW4+oQ
         +Hz4rKPH0YM4YZM0W9cK0uTRdSQ5NOveQ5vHLgN++fjFM7YSq0yj6G6AZ1g1aRRf4xAl
         0Mvlm1iXnNg7P+wl3r6VcCqFhE5bEzh0gdwvKiCN3ROZeA2LDIvDwZyJLPFKfGTvxkxF
         4dXHaiaAsTtKxlnUvNa1sbKSvOzPUw5P6Oy6pyqBgHJRtZul2XZu5HDxvXqJsXwJ2cs5
         z4EQ==
X-Forwarded-Encrypted: i=1; AJvYcCUKUG+lZbDgWCaPTZ2I4rBNdXMMua/DVFzB9dqvZ6lfnLSxcsavdRVVLUh5Obp8XvSdbIbx8rAMCz/qYiQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgxlHlXcXEMIDYyl3F/BkEg+h63RYfJ6oLHGvN0zu9K4HYmCRF
	099J2if0na6xN/pjilVntssAyFie/Ax2AB6rnj96zbghpoEPuQEvSZTVao+4SylP0g==
X-Gm-Gg: ASbGncsuQs9QkQwXuFQ0+ePhm2QrKU3Mn8YalAdIgxH5SnOea7nBgTybkw2xUjlKqgh
	H2cRsZC6vDyVypIAZdLtSicrNVG/8EztDvCEAkMkqhLTliZG9+46pT3oIp5vpc0KvfNLwr+yqk/
	OqKNaIEPt47JbWhtRjDTyZEwZsr/2NGrGinurISgGIYBTSqnyche3US41prJtcqemUKWR03BxDc
	/F00deuqSuyB7JZlTOw+fNHmqEMdTXIgd+GmNaYbAjS1MilsDXM92AHA4wMkg8ZA2hUMLf+rAHt
	eN+/ySoSY652RJReDeJrZmcWIxxbfPrWix4fWc70lXTJmFzSbNPuVrRj8wzSJnj4prEHBbuY8ty
	LnKjfTXMoGLEIbXNfBHr+P/6pGShH5WF2qQt5JIa0RjNVye4jKnVK4QTl9MHrhDVUicnpa1DEMC
	yT5BfSIRW9mMzEJK9ymt+AbGVyYpYDGBX57z9lEacbbdRGrbX7Cp3GQEGCbSBDzSeF4OJ/Jg==
X-Google-Smtp-Source: AGHT+IFUhgG9WpQVUBXncCvJtpv/AdoMd+/rut91fwnGCd4l3imDRqM9pTW1tm/5jIJ9RftY3SLcaw==
X-Received: by 2002:a17:903:944:b0:295:28a4:f0c6 with SMTP id d9443c01a7336-2984ec88253mr6581805ad.0.1762889202759;
        Tue, 11 Nov 2025 11:26:42 -0800 (PST)
Received: from dianders.sjc.corp.google.com ([2a00:79e0:2e7c:8:ba9f:d4c6:9323:4864])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2984dcd0974sm4861075ad.90.2025.11.11.11.26.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 11:26:41 -0800 (PST)
From: Douglas Anderson <dianders@chromium.org>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Peter Griffin <peter.griffin@linaro.org>,
	=?UTF-8?q?Andr=C3=A9=20Draszik?= <andre.draszik@linaro.org>,
	Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: linux-samsung-soc@vger.kernel.org,
	Roy Luo <royluo@google.com>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Chen-Yu Tsai <wenst@chromium.org>,
	Julius Werner <jwerner@chromium.org>,
	William McVicker <willmcvicker@google.com>,
	Douglas Anderson <dianders@chromium.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: [PATCH 2/4] dt-bindings: serial: snps-dw-apb-uart: Add "google,lga-uart"
Date: Tue, 11 Nov 2025 11:22:05 -0800
Message-ID: <20251111112158.2.I040412d80bc262f213444aa6f6ec4f0334315a67@changeid>
X-Mailer: git-send-email 2.51.2.1041.gc1ab5b90ca-goog
In-Reply-To: <20251111192422.4180216-1-dianders@chromium.org>
References: <20251111192422.4180216-1-dianders@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Google Tensor G5 SoC (known as "laguna" and canonically written in
code as "lga") has a UART based on Designware IP. The UART appears to
work reasonably well, at least for serial console, with the existing
driver in Linux. Add a compatible for this UART based on the canonical
"lga" name for this SoC with a fallback to the existing
"snps,dw-apb-uart".

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml b/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml
index cb9da6c97afc..df6a7558a9f2 100644
--- a/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml
+++ b/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml
@@ -53,6 +53,7 @@ properties:
           - enum:
               - brcm,bcm11351-dw-apb-uart
               - brcm,bcm21664-dw-apb-uart
+              - google,lga-uart
               - rockchip,px30-uart
               - rockchip,rk1808-uart
               - rockchip,rk3036-uart
-- 
2.51.2.1041.gc1ab5b90ca-goog


