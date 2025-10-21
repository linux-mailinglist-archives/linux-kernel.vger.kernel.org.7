Return-Path: <linux-kernel+bounces-863230-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B32CBBF74CB
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 17:24:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 39D104F5157
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 15:23:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F2493446B6;
	Tue, 21 Oct 2025 15:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZGInI9fJ"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C6A53431F5
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 15:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761060193; cv=none; b=n3Iq5+y5VkY+kDSCp1Jfh3QwZqlC3066CccHG/2pkU/o8MGz6MFNEZzP/X5rq65rihKFpB67asEVnOlB+TZtzdvPDUqObQdzGfa3fX5hcgECs1IN6Pcx+kSxsMdn2EDRgXSlbgJuQ3vSs2g2stCRq//Eqg/XjKrW3N1pRNiyE2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761060193; c=relaxed/simple;
	bh=B/V0PZcMSL4fr5BJFAi6FbrjWZ96Fh2mlodt6dce7JE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EzviOCJR8nrN5uIsYr3oP+4shnn3GW3JRJm+QUbO4Wc7RyghW1GqHI9S2gHJGTpOXcxagu5H41ZXlOUV0e21OMiNhFhFkQpuWuzsHx4IXu5W3fx8EQwa6m9dOniJBfUVrqDUKeaDlzwUA9XbEqtAORI5c/vu74QdCngcYZXdH4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZGInI9fJ; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b6d262c8528so132664566b.2
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 08:23:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761060189; x=1761664989; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pkVtrQQNx9JXmbmmhcqWd4PIxXamm4sTBDEU32vDCe4=;
        b=ZGInI9fJxpXB+swW978kTlEOBWKxp2NGh7OY1g0/w1boZv6/mfWtf4UalfMyCtNwBQ
         K9Tluhl1ifRdfy7ymYWqfCKRxG2IIXUNIBvIPOvwiPOEF4sBIXbJreGXMZ3iKRlM7Dbl
         02Vwy3g5txUBjxl5leOfmGw2IS0KHkvTadff1LcLoHBfM4488aULaRfQNy5NvwzKT9Cm
         NoZ5wlNgfM3Daws/sYUYflfD5g8CZa6ZWGsDdu+0+Q9iFRo2/vKmOS5lLMAIUAbCCRKe
         t9m+rUTUGWH+kDZwjFcECWxn7a/XyS6cvCpIJMC5FJ+ZcHVzFB6Xl2I/oQDtjRBH0q+l
         l4EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761060189; x=1761664989;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pkVtrQQNx9JXmbmmhcqWd4PIxXamm4sTBDEU32vDCe4=;
        b=pCDhc1/+eXVVekUrLrdfU6C0pEEOYq0Vvhrl3JKb8CjvcWR+JZ0NCd3qn+J9xG+PIa
         AjyJQ5piJYfDqkKEbBPd5nbU4tzjo/rWLkoJDT6kKPbk1IxYEdanJdF7zrwfaBOWoVRG
         Qxe+T23YOhHORH64Xj9sXZGsl0wawi7byA+8LQcDgqBogFjgZTT0h5DFf3vfeZ4/N0xF
         X87bW0wByPIN5m8HFtRTBKFEEjnNPTvcgH8thvbHocwj8OkUZY1z74gpotgQDno8jikX
         lUCQ1lxiEgk+UzZxoOy9vd7b8rQJfjrTw+CdApkyvKPDEgUQlKEXBx2YexJ1oroDSeOR
         zvdg==
X-Forwarded-Encrypted: i=1; AJvYcCVXyU9Uh9lipcahAZRCYj+P1O1HFALtsF4eErKzK58+e8xU8bfYFBIHTlrwhnhjlV78qW/KMzsF966FR1Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+fxos1Nz8NDTXwNxHqAqgPUqGH8UAj1xAMTNZynAshPtfYcjK
	b3VKMicbgmkmV9u0xCxOPXOz2wGgcIZyUe9q9iwq7/cOoh3Oj5Q/BSHG
X-Gm-Gg: ASbGncs8VUPl7uIJeiAVPVXzMLggJF3XwYnjDwhB8PfRjumsFBO8+kbD/dMIcyERAIA
	Zi8FL20aS9B6UUKBmcmHmrMnvh22TGJV0eJxaEg3tWC9xtoAZ0dCxAYNqP670k7t8mwj0r9amyE
	jbBxo8x7fIj4nEz/JARdh9oywO9l6FlhFstjy0DmOrgAjmlueBdNMOrVY9EgUDbjFZHmwAOOGIB
	Fg6l/mW36bkb78qzhbaEP8VGFJ4TGL4VVAmK3LtqEJBRmH/VLMQO6FNhDlaGQc9fDcDXslLgwgA
	T3wA1VosOvktqN77afTymYk65a22FLecflyWBYZ8cusN5Of+xjoNVjrVdM6KL6F9ckdcwSRqJgc
	coHzNDMWU4yPhWNv90FizKAptZuPTkpIJ0Tw1fm3vjGMRMh6AfOTFv74jMrhJCK8Okvm/MYd5so
	eMNz7vDUFmcYkE/6sNBIpMyh8RqUG43o/N6cblxw==
X-Google-Smtp-Source: AGHT+IFBawaPITrNdYmiay8yNLixvU/sNG7B1UP8/hHhq3TLFQvwCAZYt06AP2bMcG0Yh7bzOTP88g==
X-Received: by 2002:a17:906:ee89:b0:b47:de64:df26 with SMTP id a640c23a62f3a-b6474b371a3mr1920210966b.35.1761060188643;
        Tue, 21 Oct 2025 08:23:08 -0700 (PDT)
Received: from tearch (pc142.ds2-s.us.edu.pl. [155.158.56.142])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b65e8581780sm1082737866b.31.2025.10.21.08.23.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 08:23:07 -0700 (PDT)
From: muhammed.efecetin.67@gmail.com
X-Google-Original-From: muhammed.efecetin67@gmail.com
To: linux-rockchip@lists.infradead.org
Cc: devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	heiko@sntech.de,
	neil.armstrong@linaro.org,
	lee@kernel.org,
	rafael@kernel.org,
	efectn@protonmail.com,
	daniel.lezcano@linaro.org
Subject: [PATCH v3 2/5] mfd: khadas-mcu: drop unused nvmem code
Date: Tue, 21 Oct 2025 17:22:42 +0200
Message-ID: <78fab8c8b621c0ec1d7c702c028840d7f431e429.1761059314.git.efectn@protonmail.com>
X-Mailer: git-send-email 2.51.1.dirty
In-Reply-To: <cover.1761059314.git.efectn@protonmail.com>
References: <cover.1761059314.git.efectn@protonmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Muhammed Efe Cetin <efectn@protonmail.com>

Drop "khadas-mcu-user-mem" code since it is not used anywhere.

Signed-off-by: Muhammed Efe Cetin <efectn@protonmail.com>
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/mfd/khadas-mcu.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/drivers/mfd/khadas-mcu.c b/drivers/mfd/khadas-mcu.c
index ba981a7886921..ca4bd6cf56994 100644
--- a/drivers/mfd/khadas-mcu.c
+++ b/drivers/mfd/khadas-mcu.c
@@ -80,10 +80,6 @@ static struct mfd_cell khadas_mcu_fan_cells[] = {
 	{ .name = "khadas-mcu-fan-ctrl", },
 };
 
-static struct mfd_cell khadas_mcu_cells[] = {
-	{ .name = "khadas-mcu-user-mem", },
-};
-
 static int khadas_mcu_probe(struct i2c_client *client)
 {
 	struct device *dev = &client->dev;
@@ -105,13 +101,6 @@ static int khadas_mcu_probe(struct i2c_client *client)
 		return ret;
 	}
 
-	ret = devm_mfd_add_devices(dev, PLATFORM_DEVID_NONE,
-				   khadas_mcu_cells,
-				   ARRAY_SIZE(khadas_mcu_cells),
-				   NULL, 0, NULL);
-	if (ret)
-		return ret;
-
 	if (of_property_present(dev->of_node, "#cooling-cells"))
 		return devm_mfd_add_devices(dev, PLATFORM_DEVID_NONE,
 					    khadas_mcu_fan_cells,
-- 
2.51.1.dirty


