Return-Path: <linux-kernel+bounces-888855-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 54657C3C140
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 16:34:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C2E41B20057
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 15:32:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC7392BCF5D;
	Thu,  6 Nov 2025 15:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arduino.cc header.i=@arduino.cc header.b="aVM6n5z1"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D8BA29B766
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 15:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762443088; cv=none; b=SeviYeMOqqPx8xCaGA2rZ9dssZ19eq7z1sU/B+4UDdQ266ipGAPxtGDPQwfUolzMsWQ8SMQLbhH+6aBs/i41slwIPhvuiDHpjPR90BiJ3OdLR3hUVIJUgA2JrBqpIomj7uzCWJfHATwgJSmWnrRC2wvbe+cbqtfhdkN16bcBNpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762443088; c=relaxed/simple;
	bh=zyGou655DgPVWbvzpRGsIISTwPvEcU+Qm+OetkBFuJE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cQjlRIvz9VyqDu8ceHclctuyOAo2y2/ZpZF+/sawy5xVHgpw7ZlzRgNsxuxnbCALpTzAy6S2IbEY8N7/vQcnZgbJOVplx+ADr4wX+EPzxhWYYof5QU7Jm4h/Ubp0HTtzz/W0Cny91fIGGmcycOFamYvwkTOWU2P9dF5SEQKCoTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=arduino.cc; spf=pass smtp.mailfrom=arduino.cc; dkim=pass (1024-bit key) header.d=arduino.cc header.i=@arduino.cc header.b=aVM6n5z1; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=arduino.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arduino.cc
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-429b7eecf7cso800236f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 07:31:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arduino.cc; s=google; t=1762443084; x=1763047884; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qdoIcRkh0qAEi2h/VedrLcowdMk122XxoHkRGxzNBLc=;
        b=aVM6n5z1uAFpFgePUg9wHhkpERhSDjziYWcayZ0caqNPSDpvnmjLvg7zjipKEKXReq
         39BbbStvCa8mrwXBgPFvuoi3VFiJN3tpoh5NZNIqJVS6X9IQ3tOZ32ukdawEVVW4QS6D
         oUU9cb9cnVLUkT9aoYrm733298++GTdXiO7+g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762443084; x=1763047884;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qdoIcRkh0qAEi2h/VedrLcowdMk122XxoHkRGxzNBLc=;
        b=pVnjd9SHDtHI0PgrFuAjY5NeAZ6+04u4NYvtTYsEbHgHiexCLtJgZlni7L9Q1zmybr
         +Z533wMjHlgqriJXyz9a9p5cD4uMoWWShhgTmlIURTziBzWFyIC2NwMqtDvjz68YEy1L
         tbysYt3OrzimSI3PXubcJL3Bo8pZuJpfxkQCGzTPw/w5f63ffqunaP44QZ7D2x3w4kvt
         OLTlERRkQ8aB/Y380lUeruZcvzq/QtPO+xvM2y36XlgsUTZeWeCBG3C+FDLGh81OocEP
         HWCN0tIn/OT00M9Zj0ReRqepjuJkeeF0JCiI4+7KaDWD9WJLfRiMgqofkB0giMzUZroa
         GlpA==
X-Forwarded-Encrypted: i=1; AJvYcCWmuquc3Xg7uictm+BZYjzz+akqmFsmOPpiJWf6Bea2FwU2k86W0k4XMPNjw0Eui4urjH8XnSNaq+mXKz0=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywvl4OgCYgw+xewzkv/B4t+J/ae3pFSAElC2PNHUVk3bnu6/IX4
	2e3GZHzRaWdVqsW9J37JTNkPmuP8IvSAUqLnmhsE1SwB5dGwKwtquSlPlZI7iv9Dtcs=
X-Gm-Gg: ASbGncuX0AHRWjSOxwUUXS+F4PJB9XuXoIunYWonh3Zjyect+V84TX78kKa+8U8yavm
	wOvdcUEoAFI/2LOgv0QqpRelglxzaerRaiihl1gDtBYw5YsWKIm93OYfyo/GEbXBDe6JbJSbjrW
	gFrA0zwNHbBCbzAAYFkud5p4pLYTNPy0Fr8N/Yq63tkgafgtS6bMyzS3BLAVC3OiWK1ze+jBNrs
	XRPj3Y4gPCujjjZjwCQDdhVjNPJjRAbkToU7GF+JjIR16yBhLmIU8Z8yfEFkFCMm3+d3usOpT4x
	FBu3zNA//IqZClx39XYTri4dfXFwtesP2w9cZRUg5P/I1blSlroNvt5zyoj5DOFhCbwhz0C5MJB
	bo7m6zHpjR5QN/dB1IGp2xagGh6rcn7AIMZjJ273U6R9kJBXVQKGfyIs/GOi9qAotqoSMC7xX4S
	QiTYR2E+dqc+Z7iI351dgrXiCZ
X-Google-Smtp-Source: AGHT+IE11tqb7MERlvkENeEoJrFa0Bnsi91DGqfmPPudaUG+82H0TbZwLnEcFpdLbyB2kEFZoFWXMw==
X-Received: by 2002:a05:6000:26cc:b0:425:82b4:a099 with SMTP id ffacd0b85a97d-429eb0d7665mr3707607f8f.0.1762443084189;
        Thu, 06 Nov 2025 07:31:24 -0800 (PST)
Received: from riccardo-work (public.toolboxoffice.it. [213.215.163.27])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429eb49a079sm5966719f8f.32.2025.11.06.07.31.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 07:31:23 -0800 (PST)
From: Riccardo Mereu <r.mereu.kernel@arduino.cc>
X-Google-Original-From: Riccardo Mereu <r.mereu@arduino.cc>
To: andersson@kernel.org,
	konradybcio@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	broonie@kernel.org
Cc: linux@roeck-us.net,
	Jonathan.Cameron@huawei.com,
	wenswang@yeah.net,
	naresh.solanki@9elements.com,
	michal.simek@amd.com,
	nuno.sa@analog.com,
	chou.cosmo@gmail.com,
	grantpeltier93@gmail.com,
	eajames@linux.ibm.com,
	farouk.bouabid@cherry.de,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-spi@vger.kernel.org,
	mm.facchin@arduino.cc,
	Riccardo Mereu <r.mereu@arduino.cc>
Subject: [PATCH 1/5] dt-binding: trivial-devices: add arduino spi mcu interface
Date: Thu,  6 Nov 2025 16:31:15 +0100
Message-ID: <20251106153119.266840-2-r.mereu@arduino.cc>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251106153119.266840-1-r.mereu@arduino.cc>
References: <20251106153119.266840-1-r.mereu@arduino.cc>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add spidev item in order to describe in Arduino boards one of the
interfaces between microprocessor and microcontroller.

Signed-off-by: Riccardo Mereu <r.mereu@arduino.cc>
---
 Documentation/devicetree/bindings/trivial-devices.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
index 2eff6f274302..c44fff4ce2e2 100644
--- a/Documentation/devicetree/bindings/trivial-devices.yaml
+++ b/Documentation/devicetree/bindings/trivial-devices.yaml
@@ -59,6 +59,8 @@ properties:
           - adi,lt7182s
             # AMS iAQ-Core VOC Sensor
           - ams,iaq-core
+            # Arduino microcontroller interface over SPI, e.g. on UnoQ board
+          - arduino,mcu
             # Temperature monitoring of Astera Labs PT5161L PCIe retimer
           - asteralabs,pt5161l
             # i2c h/w elliptic curve crypto module
-- 
2.51.2


