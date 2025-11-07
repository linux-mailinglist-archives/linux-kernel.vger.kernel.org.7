Return-Path: <linux-kernel+bounces-889957-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8070CC3EEB5
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 09:17:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 164B84EC58B
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 08:16:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FDDD3101B7;
	Fri,  7 Nov 2025 08:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wJoPvWAj"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67EB827F754
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 08:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762503386; cv=none; b=KFae7NtMmtfKMe1CkT0MhspTUcVMaX6UOtpCINVafOcioh/o25gmWjREHX7DYw2r64E0DJw/iQra37457rIGtufN4r+NoAnCbIEWv8JOMyHggjPp01YtK0MewmTGn3dPwCry6Re+2+2+kxBIHJlSIq27DMDSrpK9DgWDRFmt55E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762503386; c=relaxed/simple;
	bh=KzWXn+yRUUjpBHJaXgRwSAXb1HJyVmNmYBGEb7asavE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NXoUkC1ynTRUQ6I7LhmG+7VQQOhDq2lo65WxKaxcBz3pVD58fS8bb7xt5H5/E59NHl/OIUdqxOGN2ZWAA9idAWHX03Wxoor8cZOy85WR66UPuuXXROAnp0kBw8X+5PhxX3nSxPaQa0HLMqzPSxk0OMEAczfR5/uHF3xteyMBTNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wJoPvWAj; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-429cbab5d36so64693f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 00:16:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762503383; x=1763108183; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iCvxgq9zYPyMV5RPPEtwvCqno8HSagbXhXnbN1FGzJY=;
        b=wJoPvWAjDNsQo75o9F1XihcBniaON/4swlNWgWa+5PVPviJ6CMpzqbN5WMkRgK+BmE
         J81GVex6q8gXnVo6r9V6CJiZi6ij6vsKCFXeFyF6vWpopqkx0fIceO+HcHAcNN7yr6vg
         EsJaK60hkablPQ1INA8MS/LBtUbQcEuWcqsLTmABEOtSLIFGzm31cgyiCSpEGEXdT3Kk
         +DPyBCVn+Pxb73Tl51Kx5qvxL7rU5oT672uAE5aPho9UyqZjDse/DLjHqWJeT4ulEDYi
         j6Wel21fZ4fxWxsZ1xV+FHWfI/E2Kwy3tIa2Tkz1TRajblUS9LmkasTMKNtuKNp9BXQS
         2z8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762503383; x=1763108183;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=iCvxgq9zYPyMV5RPPEtwvCqno8HSagbXhXnbN1FGzJY=;
        b=vmN5C0ohga8oYzEgJK5vDMTBQ/EfeVuZsdicSHwLbYYFg1ZKPBAkZeCSbs/Q/g03ht
         LuHeIAHHczYi1uLYlOpKGVzL1LHq00q4qvQEgvZGnfWD1FXEVCkRcQxraEqBspRiBw1r
         NG4Q5RDV7o56l42GgJUnuRbIOp+sLBu3jObB52RhNieTWSxjzhKZA6h3//+pw0LYdj0Q
         87XgdtGMgZ5nxGThQx+ai+UPuboRWQNzxsDmo+SXG/SiOlGO68pKIvnBhwLFuTHtu8LO
         htZ5A+bqFNGXEmWaPQsAg1uLFN5RaGGpIDvLb9UR0h5tuKsgQGt0vcFWhBUJYStox4+8
         rwmA==
X-Forwarded-Encrypted: i=1; AJvYcCVbHwmauQ8zdBnwMIo9gwhG/jAmRpobnt/REWbIakbNgyB0dl/oTNHIJX+F5+B5qMzpmy8ofSvbn8fVVWY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTVHPwlW9K23K99CkCaw7AF2LBY5y9Wmk4Jh77mKmLpou74Um4
	2fCqbyoPYMxSyWhNLua3Ryr6Ab4XeN6hPnisbxe2NmIOtAb3cvh+wwjbNXL3Es9yHM8=
X-Gm-Gg: ASbGncssQXJh3yO+pjhDUhQLsE8hIclKWSL6WglHl8ePIc/TXhupaGrEJZq//fjHEGP
	S2K75MXmlO1mRCVuu4PktOKHToUPaqkOdWdlpt94MPOsJ9v6TsGDWzUMolODlFe2fDu83CokDLb
	WPYE8CP/R90J38OwDlAU9W1ThIvPn9jYnt9FC+p26OGSmr/x7aVxXH1bm/LdSBjihFTOYUhgWnP
	LuSlAUImUKARtdQRKWx5BJGZQLbkE8Geh2COJEVd5s8HAU1etOHwlC1Zk/olb7qXt4BkyTsVytx
	KAxIZjnY5yd/Tup2n/0RIr0P5PUwp5wRa961Nkc7keYLJ1kVp9KTPGVDZH8dZFta7LQR6cXSRGC
	ievcODqxqQS2Rpg9JJ/EA7/gwCc5wqaZpQnFpNh9BpxpD/qtcVM06vx/ABEX2KEIGeRRzOEi7V1
	AQSXv+xZ3WHv2Kncl7+KYct6o0+1o=
X-Google-Smtp-Source: AGHT+IG1WfPwzcneuCdATSCE09C1Y773iKrUOLTnPDkh/cXKuCKQ3K5m15q+fwccDXPfnzCmzpQ3Jw==
X-Received: by 2002:a05:600c:a06:b0:471:ab1:18f5 with SMTP id 5b1f17b1804b1-4776bcc5334mr10868915e9.7.1762503382674;
        Fri, 07 Nov 2025 00:16:22 -0800 (PST)
Received: from [127.0.1.1] ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42ac679d544sm4058381f8f.46.2025.11.07.00.16.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 00:16:22 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Fri, 07 Nov 2025 09:15:49 +0100
Subject: [PATCH v2 2/6] hwrng: bcm2835 - Simplify with
 of_device_get_match_data()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251107-crypto-of-match-v2-2-a0ea93e24d2a@linaro.org>
References: <20251107-crypto-of-match-v2-0-a0ea93e24d2a@linaro.org>
In-Reply-To: <20251107-crypto-of-match-v2-0-a0ea93e24d2a@linaro.org>
To: Olivia Mackall <olivia@selenic.com>, 
 Herbert Xu <herbert@gondor.apana.org.au>, 
 Florian Fainelli <florian.fainelli@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, 
 Jesper Nilsson <jesper.nilsson@axis.com>, 
 Lars Persson <lars.persson@axis.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 Tom Lendacky <thomas.lendacky@amd.com>, John Allen <john.allen@amd.com>, 
 Srujana Challa <schalla@marvell.com>, 
 Bharat Bhushan <bbhushan2@marvell.com>
Cc: linux-crypto@vger.kernel.org, linux-rpi-kernel@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@axis.com, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1474;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=KzWXn+yRUUjpBHJaXgRwSAXb1HJyVmNmYBGEb7asavE=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBpDarNNAJtIDGyF0BhraA4Wnr5mnztF9FLWAyE4
 QqQdRi0AUaJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaQ2qzQAKCRDBN2bmhouD
 15E5D/9wMVJ2fBEQHcIitgPv5MZFIyz/UJUAVG5KpW34AGSs13BNXX9GX9JhxLopOlp4kbCw7LD
 LM83IxKwW3aPefI/ObmGin+Z8QuT7c4+iBH3BF8oZLMY816wuEvhUUOBK25+MN92Et1e2GK2x47
 D+7l2c/Ckz5y/KZKuUaQVx4yqIVYHsDgQMmpYdQo4jAHOZ+vZ4UE5NPul6Di0O4xtNSHbdN9ppU
 ojKI++kkK2+aHUG5bbdZzh0HlXyYzYnZL2Mwd6d8eH77j5+rcOlmM25j3q2Rm3GHHyQlX72/WqI
 XyHZLur3iHCfwdLU5i+TnSydF02ZTC2RgmlW8g7JsRaIxaDnv8pG5c9Lv62kuI4uFyc7wpRN1eg
 D7FH7I5nO86WJUf9XsgTqqyBZ3xHsr372Xlmmcwql4bGQ0W/mtk9x6oINveXqB07jplrUK6jgaT
 ica/DQIrHkSwtGAYP1d3klEQJl9elCyP2rbqbMAcwCK4ugqTH9sKrItpB7nolG/fooCvwZhscaI
 tCvarQKE/ugM1/VKq2is7VECZJX9RdjtbVR3JDUqqt32PkTM5xPeCBbusX4Ze9O+FNPhtc9OqYa
 tJI8rzapmJEkLvPLX93C4eW27wIra8myCvPx1F5zyQh3z8LFN2cgajSoT+1h4eCE9kN+S/Y5yX3
 ED+hsjI9pJQgvqw==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Driver's probe function matches against driver's of_device_id table,
where each entry has non-NULL match data, so of_match_node() can be
simplified with of_device_get_match_data().

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/char/hw_random/bcm2835-rng.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/char/hw_random/bcm2835-rng.c b/drivers/char/hw_random/bcm2835-rng.c
index 0b67cfd15b11..6d6ac409efcf 100644
--- a/drivers/char/hw_random/bcm2835-rng.c
+++ b/drivers/char/hw_random/bcm2835-rng.c
@@ -142,9 +142,7 @@ MODULE_DEVICE_TABLE(of, bcm2835_rng_of_match);
 
 static int bcm2835_rng_probe(struct platform_device *pdev)
 {
-	const struct bcm2835_rng_of_data *of_data;
 	struct device *dev = &pdev->dev;
-	const struct of_device_id *rng_id;
 	struct bcm2835_rng_priv *priv;
 	int err;
 
@@ -172,12 +170,10 @@ static int bcm2835_rng_probe(struct platform_device *pdev)
 	priv->rng.cleanup = bcm2835_rng_cleanup;
 
 	if (dev_of_node(dev)) {
-		rng_id = of_match_node(bcm2835_rng_of_match, dev->of_node);
-		if (!rng_id)
-			return -EINVAL;
+		const struct bcm2835_rng_of_data *of_data;
 
 		/* Check for rng init function, execute it */
-		of_data = rng_id->data;
+		of_data = of_device_get_match_data(dev);
 		if (of_data)
 			priv->mask_interrupts = of_data->mask_interrupts;
 	}

-- 
2.48.1


