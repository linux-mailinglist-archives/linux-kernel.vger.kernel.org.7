Return-Path: <linux-kernel+bounces-891029-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CA1F0C41A40
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 21:53:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52027189B55A
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 20:54:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 766CA31BC84;
	Fri,  7 Nov 2025 20:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="s15Wom5E"
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6A6B30EF9F
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 20:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762548826; cv=none; b=KlXeH8Jg4Ib9Yx7oWiON/pAxVLQwH2Mtt7wkPJhF9OY/SPo3JZUvfX8M54St/G8USiZcR0kD7LQHEJxSzf2kcw8+TYlQcnFY/XOsHU7A6gZBhHsy0+vHUNzQUeJzWEwuGnEEZQVqJ6BYk5h3g6mxillKS47KPnW5ImD5En4rHlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762548826; c=relaxed/simple;
	bh=GzDNbyMI4KydFDgGfy/VeBjUSngx+JmJMBw+foU/HUU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=c7JisD52a0GQs/8mQdmwbt5nWAV3gD9VsPC5uHvG9YjyiW3i0Hvqi/cwIpDC9EbZ7vj+LGu39bV8Iv2rzjF+Csk4xtfMiiB0dh8hiQhzb0O8cGjF3wTl+o9HlqGwSoO1Wh5r79Odg+WaFYQbADWYhBOnBD2JkDyrsl0XIJUx3Og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=s15Wom5E; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-44f7be0adcfso593408b6e.2
        for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 12:53:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1762548824; x=1763153624; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Bw4pFNPg7WOI6b81QBAhCby/sZRUjd7BzHL1pO1Aj/k=;
        b=s15Wom5Ept/5mOhvrjk2e5yVNHW6l6OyjjxkPzgfUuv5UrG3VpUnsC3QmnNyJSH24T
         SWr03VLihNvPnQ7vCmV74yBzNzLgXhYGDUOwkfKIRAyRKrhnXoBz16kmkDKSHsnFiiXA
         +eOjOixb1LYMRbpjxZwRl1hXDOs1RzZhVH9niTAKOp0DbcyBmgjXTw1TF6rOFtxLqGvw
         spbbFe9ZtN4vsuZkzJddMijKQKuHTwT5UtkzN2p6Z3jhCECsNvb0GaaGpQ4vxtO2aWNs
         iRIEv0PfFrVRTwxrHDaSVbA7y48S7P61iAei8w+1LxroPAImRKoC8vI6qJR/sILgSnBL
         O5Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762548824; x=1763153624;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Bw4pFNPg7WOI6b81QBAhCby/sZRUjd7BzHL1pO1Aj/k=;
        b=XNxqeBi6q7kIwQbDErtB/Blg3tnFXQk0v4tHXG271T6McRFA/7PRIuMdA4ipN6N4nj
         3cT4LSwOL8+AWOQXUEbax/mxYDKUw5eU2gEspg1yxk57CMHgdb61Gzl8tKTcLOUOhpjY
         nBz6BNyM84KSB3tyuucIAfMk6L6WfihdzYtMmv6S7rcER2QEDGuElRcKhHVK44l+U8B8
         AtcRIbTgDfrnS8D0NXg6Oq42m47zIiQ1/hyJwdZ4JNKBiffIUm9fxeyL25fpjpmv2mmw
         Woq8DvgdiDfn5CdQstUpcM6yf+eJV3P5OKKW43z58XbtJMWzJTjAs5f5Jz95h6XQ7h2C
         +Mkw==
X-Forwarded-Encrypted: i=1; AJvYcCV27BSHOKNgL36EYR/VViZcO7EvKceC4bAxDY3LbULxHJJSd22fm982DV1FKtj0arOdpEkfUZRdU3yNkVw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz66rTDs0cU5aE/XkSNb5Q/U4MUpHZufm6UQ2+jrtepU7l84rPE
	AuB8ZXAyteC0todrVhrNG7sycUdRibCMF3XQrAW1oH1bytBSNk1Y6NoOBVoWAKqhpjI=
X-Gm-Gg: ASbGncttBbi0ToE9PRI0/jromKaX7TTfgSRQGbfo6UyMq5+a8I1gHcy1A479LFBPmjm
	NOaLZTmbhQnWWjDonug+9fDNabEwC1lstHPn4QgC5eSRq06mqvt3J62IHyJLmcTguaz+kfipTrT
	3H2M9cmy96AFQwe8DW5i4e3TusL3JBEOsAvvvcNzH9MijhzspKVwzn81p52ruQrL/Q42cGxjJ7S
	fLG2CDd20kDfXWwUhFSOsgzzmQUwGb0MRrItih8nXx/qrOwNvip+AMeuU6kPYcO8T0cq182p71M
	Ic7z2HKhEXtAEiG+TkM1BjnfXGFWWQPTHmRELKX3av4SWuJ4dL+6CCN1XpIfITbfPcqDp0mZk2+
	jlHaP/HFa2TmVPNxEkCHc20h8h9znozfoUhXzy6TVFLoHZTrSHMmH4rsGYpzpa3L22QKsXz0KIy
	kKC6xK
X-Google-Smtp-Source: AGHT+IGfK4c9b4dcviAlGkTvokFM18b/RZpHMLFU9OtYfQL7gB4N46H+oF0gdluiqTzWFb9WGu4bYw==
X-Received: by 2002:a05:6808:bcc:b0:44d:aa6b:a578 with SMTP id 5614622812f47-4502a40c801mr380282b6e.66.1762548823806;
        Fri, 07 Nov 2025 12:53:43 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:7bb8:950b:327d:4ba4])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-656c57eae5esm2915601eaf.16.2025.11.07.12.53.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 12:53:43 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Fri, 07 Nov 2025 14:52:47 -0600
Subject: [PATCH v2 1/6] spi: dt-bindings: Add spi-data-buses property
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251107-spi-add-multi-bus-support-v2-1-8a92693314d9@baylibre.com>
References: <20251107-spi-add-multi-bus-support-v2-0-8a92693314d9@baylibre.com>
In-Reply-To: <20251107-spi-add-multi-bus-support-v2-0-8a92693314d9@baylibre.com>
To: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Marcelo Schmitt <marcelo.schmitt@analog.com>, 
 Michael Hennerich <michael.hennerich@analog.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, Andy Shevchenko <andy@kernel.org>
Cc: Sean Anderson <sean.anderson@linux.dev>, linux-spi@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-iio@vger.kernel.org, David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2076; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=GzDNbyMI4KydFDgGfy/VeBjUSngx+JmJMBw+foU/HUU=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBpDlwtAwtlV0VQGNVIxEBaAxjKPBXvLbMxZAb/W
 qByJpooBjKJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaQ5cLQAKCRDCzCAB/wGP
 wJTrB/9LuHD+FF8YuGEQ8ift3smVYnehTtkxIxJlPmGPlglTjsW/tP2kiiJ0j6dET2OY+l9YVMg
 xtWPfOKrH6DXK72pckNTdt7YIp5y/+1UuiTrZ5yiPeyC4jkov6+jzNeZToP8AevMq5pnxLEid6U
 7juw0TfIaw3Htg4FSkal4pt8/DhjkbLSJv4dPxyBFLym1R5Tjoki6xPx/oiFbWEgThNhlTUIOHK
 cPBHEFumqpqrHrnz7H7gjaT3tVc/YYOVfH6CaKXgIFYUH/cLnvt7f/J6ngV+tGl8myJhEeb4mUV
 AkpNNAqavMCLXweLYq+dGaXsyTPFXR6jmPK8BKYurywRRS6/
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Add a spi-data-buses property to the spi-peripheral-props binding to
allow specifying the SPI data bus or buses that a peripheral is
connected to in cases where the SPI controller has more than one
physical SPI data bus.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---

v2 changes:
* Renamed property from spi-buses to spi-data-buses to make it clear
  that we are only talking about the SDI/SDO lines and not the entire
  SPI bus (SCK, CS, etc).
* Fixed prefix order in subject.

This patch has been seen before in a different series from Sean [1].

[1]: https://lore.kernel.org/linux-spi/20250616220054.3968946-2-sean.anderson@linux.dev/

Changes:
* Added maxItems. (8 is the most I've seen so far on an ADC)
* Tweaked the description a bit.
---
 .../devicetree/bindings/spi/spi-peripheral-props.yaml        | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml b/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
index 8b6e8fc009dbdc80978f3afef84ddc688ade4348..6fe739eaf09876b9c5d8902f792ca02181d7266f 100644
--- a/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
+++ b/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
@@ -89,6 +89,18 @@ properties:
     description:
       Delay, in microseconds, after a write transfer.
 
+  spi-data-buses:
+    description:
+      Array of data bus numbers that describes which SPI data buses of the
+      controller are connected to the peripheral. This only applies to
+      peripherals connected to specialized SPI controllers that have multiple
+      SPI data buses (a set of independent SDI/SDO lines each with its own
+      serializer) on a single controller.
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    minItems: 1
+    maxItems: 8
+    default: [0]
+
   stacked-memories:
     description: Several SPI memories can be wired in stacked mode.
       This basically means that either a device features several chip

-- 
2.43.0


