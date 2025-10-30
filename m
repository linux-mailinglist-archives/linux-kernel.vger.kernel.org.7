Return-Path: <linux-kernel+bounces-877891-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 76B73C1F491
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 10:29:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8EB09188A813
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 09:27:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C122340A4C;
	Thu, 30 Oct 2025 09:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="0G+kAEZ2"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 848032F12A0
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 09:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761816426; cv=none; b=hZLQrtYsTA8fogAKM2UcF/vR5/q5Es0COaOnk7thtTRYXKWYi8b9G9Cc5FNl0PS1yBiAPUgz3awPkn3v2HEllLQ1jzPi3i1Iu1EKUE6sRWKScNF7+ODRH+iAIgqnDxB0CyOceWp2BlvdIIjOlwakBAYgfuqgOI48PcPfNrCpgkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761816426; c=relaxed/simple;
	bh=KhR7mlGuLILLgbABDE8JZr+5vkedHPIY9RgeGmUDVFM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RRKBs9EaQknhKO3WBqcEt1RLwIg9Xrp6SrsWHlddczRfbPdgwz5CqaqhxyYyevykjgzlvk+b5BdCqov9bIOtfUTwF0hltStqhIkWdrnXMYErimYWyCN0m3v7rAbHF3L+FRsBjPtxCPQDy2XGAyzgQKhpx97LTWwQzsBqHvcP8iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=0G+kAEZ2; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4710022571cso9418795e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 02:27:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1761816422; x=1762421222; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f2nbBjY1ngedAQK32AIlHILlTX4360hWS/5AwjBnjIw=;
        b=0G+kAEZ2oKx54BGoHAZcI6KA2tn96hxoIM/wZ+uq8Mvohxx9KM2icmhtPQCA1fOM57
         MLQDk3b/MSr6PByw7/MHO5bU1TSdN58jAz9pvnzSXRuVqcsyzA+L62Z131QAKnbmUvCZ
         W7PF1gEPP+OYmDJH3jFdjvgLFu4C2NS/DLE4C/GnMDvntD+A18Cnfoy21wn146JcgApU
         3MXM9qETVckhvj1GWdXdIg3p9za7qbfDYmgqS3knAJveTrlIC3hULkpjM41F4EjCwFPA
         M2U1oH8iTzaDW6NtBO3NE8xI/2E22gx+0LMVI8KMjB3J0ynnaideN1xqY/V2APYoXUX7
         ga3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761816422; x=1762421222;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f2nbBjY1ngedAQK32AIlHILlTX4360hWS/5AwjBnjIw=;
        b=KhFOs6zKtd3zMGne0ARipN2t9NsYFwt3BZQRtOd9Emt2SK9KweVVxc2GavQQn8eZAJ
         4yGBJ4jGX1DGuQFBnt1QybDzm/1AL3R3wrM+SFt2w9J+qHljka5OhjwrxN37Vx4xhsJF
         3aUh7elH/qzOZclkwIvbbMRYL1cpbiKLEsbfrw6GzI8dd14aKBCHnFlZKV1wv2UlSHW6
         NzHudbuoTKHNIijBhb3M2LaPsnYs/D9Viq7azdwSd969mB+21lCRN4JYb2XaoXLRDbvm
         El2A0JxaHx8PJuSGqt1axCpi6A6XOylfEzcF8wyPdT5TvTofqhNPcOEd8Mq7/B4cNfxg
         6UMA==
X-Forwarded-Encrypted: i=1; AJvYcCXZCTs2lWNNhEJ/9TDj6LwKIBrUNhc/gtFq50Awarz07KxKM5tDxOH0Vg6Or5hyZI1D2ECDuSKfZ1d7uZ4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1KDUFW3aAzA/ZSNi60qMTrDyzJBJGwnzxPyFk3Pl4IsHsxLFb
	PauZsEyISBLk5Yj4hhym99Z+PNP3M0TlR4z2ls/RBHMIwiIM8FivovHNGyTK7DrgoQs=
X-Gm-Gg: ASbGncs+8F36Cgjun1HbYP0hbFR9T9kefDuC7e4O4/FhzU2ux6bJ5mkGW7sEqyi6bqD
	wdZ3yyg3BJztEO8L7V2rUfyGaaOWYyoMEv+MbowM/lQ9VI87gycHvTJmXIZOSCDBcWxykXa5Y+D
	5PIYGS5XpkWWc/y/V0ucHwOkxJMkyq3408sEOq8vZgDinHksHDsoc0QYhWFS+rBiDVJ7XjEQ9LR
	clpbRha6X3PwwAjKf09hTLwmBcDvB6FAmPdJbIxCIslE4sx2Dru+/DlcWWXGnNSPtZknU9rbQYT
	rDwjflA7IbqcHN3+HgvRtihPn23ETX53y9jlVRX8kGXIKdyznuXYSpEuISELVMXgvszbLApnjf3
	aAt93LZ5sOmlxEPAta/tIH/DmK34bxZo/vnUPn/vOMw+d/pfNdYxzMCCgUUPXpnxJGdpJdcPLC/
	vdS0wcBu8Q
X-Google-Smtp-Source: AGHT+IGXRhetBmDY0UqanhzjhdwbjEaOqJ9qlQPU7v66jN4giQVF3G2msZickY+kz8JV5cPNKrQRJw==
X-Received: by 2002:a05:600c:3b85:b0:475:e007:bae0 with SMTP id 5b1f17b1804b1-47726736870mr19689495e9.16.1761816421828;
        Thu, 30 Oct 2025 02:27:01 -0700 (PDT)
Received: from localhost ([2001:4090:a245:8496:49da:2c07:5e9a:7fb9])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-429952cbb20sm30827543f8f.18.2025.10.30.02.27.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 02:27:01 -0700 (PDT)
From: "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
Date: Thu, 30 Oct 2025 10:26:08 +0100
Subject: [PATCH v9 1/3] firmware: ti_sci: Remove constant 0 function
 arguments
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251030-topic-am62-partialio-v6-12-b4-v9-1-074f55d9c16b@baylibre.com>
References: <20251030-topic-am62-partialio-v6-12-b4-v9-0-074f55d9c16b@baylibre.com>
In-Reply-To: <20251030-topic-am62-partialio-v6-12-b4-v9-0-074f55d9c16b@baylibre.com>
To: Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>, 
 Santosh Shilimkar <ssantosh@kernel.org>
Cc: Vishal Mahaveer <vishalm@ti.com>, Kevin Hilman <khilman@baylibre.com>, 
 Dhruva Gole <d-gole@ti.com>, Sebin Francis <sebin.francis@ti.com>, 
 Kendall Willis <k-willis@ti.com>, Akashdeep Kaur <a-kaur@ti.com>, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2209; i=msp@baylibre.com;
 h=from:subject:message-id; bh=KhR7mlGuLILLgbABDE8JZr+5vkedHPIY9RgeGmUDVFM=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhkxmfdtWEfXP9w89uvlp5cdTLK/Wv7ogG2Pgev4jq9/HL
 Reb/n3c01HKwiDGxSArpsjSmRia9l9+57HkRcs2w8xhZQIZwsDFKQATme3GyPCNQ1tN82iyZ73v
 jWNzbKccmanrVxogL9h9eLajouDzvL8M/wtdOpWEmQSvRqQF7PqkEZG3+rp3+Y2Q5d9SCl+Wzmd
 KYwQA
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41

ti_sci_cmd_prepare_sleep takes three arguments ctx_lo, ctx_hi and
debug_flags which are always 0 for the caller. Remove these arguments as
they are basically unused.

Signed-off-by: Markus Schneider-Pargmann (TI.com) <msp@baylibre.com>
---
 drivers/firmware/ti_sci.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/drivers/firmware/ti_sci.c b/drivers/firmware/ti_sci.c
index 49fd2ae01055d0f425062147422471f0fd49e4bd..24ab392b4a5d0460153de76fe382371e319d8f2e 100644
--- a/drivers/firmware/ti_sci.c
+++ b/drivers/firmware/ti_sci.c
@@ -1661,14 +1661,10 @@ static int ti_sci_cmd_clk_get_freq(const struct ti_sci_handle *handle,
  * ti_sci_cmd_prepare_sleep() - Prepare system for system suspend
  * @handle:		pointer to TI SCI handle
  * @mode:		Device identifier
- * @ctx_lo:		Low part of address for context save
- * @ctx_hi:		High part of address for context save
- * @debug_flags:	Debug flags to pass to firmware
  *
  * Return: 0 if all went well, else returns appropriate error value.
  */
-static int ti_sci_cmd_prepare_sleep(const struct ti_sci_handle *handle, u8 mode,
-				    u32 ctx_lo, u32 ctx_hi, u32 debug_flags)
+static int ti_sci_cmd_prepare_sleep(const struct ti_sci_handle *handle, u8 mode)
 {
 	struct ti_sci_info *info;
 	struct ti_sci_msg_req_prepare_sleep *req;
@@ -1696,9 +1692,9 @@ static int ti_sci_cmd_prepare_sleep(const struct ti_sci_handle *handle, u8 mode,
 
 	req = (struct ti_sci_msg_req_prepare_sleep *)xfer->xfer_buf;
 	req->mode = mode;
-	req->ctx_lo = ctx_lo;
-	req->ctx_hi = ctx_hi;
-	req->debug_flags = debug_flags;
+	req->ctx_lo = 0;
+	req->ctx_hi = 0;
+	req->debug_flags = 0;
 
 	ret = ti_sci_do_xfer(info, xfer);
 	if (ret) {
@@ -3689,8 +3685,7 @@ static int ti_sci_prepare_system_suspend(struct ti_sci_info *info)
 			 * internal use and can be 0
 			 */
 			return ti_sci_cmd_prepare_sleep(&info->handle,
-							TISCI_MSG_VALUE_SLEEP_MODE_DM_MANAGED,
-							0, 0, 0);
+							TISCI_MSG_VALUE_SLEEP_MODE_DM_MANAGED);
 		} else {
 			/* DM Managed is not supported by the firmware. */
 			dev_err(info->dev, "Suspend to memory is not supported by the firmware\n");

-- 
2.51.0


