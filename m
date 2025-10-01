Return-Path: <linux-kernel+bounces-839069-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C6C6BB0C02
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 16:39:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 895144A1A4A
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 14:38:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31CD625BEE7;
	Wed,  1 Oct 2025 14:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="l9jgz+gW"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A1581B21BF
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 14:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759329496; cv=none; b=i34/KK8eEMRND7rHGPKj9VHMNP7ZRb/OGerzeFE71/edcWQ2dEoqtjJj0B8/JLZReIXvF5PiwO/1S7YqVkehTjj8Um5FeLKJFhXxMlXKsEj+5tcdbogEnLREqXRz4XVRd+rQ0ub34sHsMZH6bkASpIGYE+hETI7BV8oGtV7k6e8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759329496; c=relaxed/simple;
	bh=KhR7mlGuLILLgbABDE8JZr+5vkedHPIY9RgeGmUDVFM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GvmJKnx/omZikAho6ttueUZWFwl1iSKtxL3XAKw4V+IKnOVyebgZPBzt7mvaR2Ez3nxm0CgfZR8fZ3XFGvc4os1tNWsQ8F4olm2yD17ThKWpOEYWTVvNZxzZZgEpnpGj9bbQnVRg+3RBCAUU6sYoMp4BC7TWlrcAkYg/8yzAzho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=l9jgz+gW; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-afcb78ead12so1312310266b.1
        for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 07:38:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1759329493; x=1759934293; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f2nbBjY1ngedAQK32AIlHILlTX4360hWS/5AwjBnjIw=;
        b=l9jgz+gWWoBE6z62mweflt/vSTKrVhFnsDHsrZ4n78XlE52xt0ejLV2m1u/qsaAAUK
         8chL5WSoFn23VHfX6FBDvMZqmfhwRsWdPs2fzW8VdzRxn6zMa86XBlVN2xmMWkQux0op
         ttgBIYVZnrrrKpxJXvcIlqFU2bFMCXbYWfT/3tD9g0QO0ivuMB3I53u4zS/4kxSOQtGP
         0c8dGoGSVu6YPtaO2zVyDdrpLmCleJfn8T9++xs7O2PR6d+IasHReQtOEch8hfS8nhxi
         2nJr4bipjScb88UW+VZDs1enlAwMbmoDX/ReemBPYKRg2nPlZChgPyot13eUk7WP6lKX
         40lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759329493; x=1759934293;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f2nbBjY1ngedAQK32AIlHILlTX4360hWS/5AwjBnjIw=;
        b=pVU6MRQW13qXZ9HZAp+6nVt25J3WzC6bZsKlFH7xsLe3+ZQdUP12gMcRCaV1nDqaqZ
         5BROpSyZQ+v/rAK6qeY08kO2rcncLWNLhWxGWwOmQFwL6uSFQdHkF5A84yKAHu0EpMbk
         8TWImlM93z14cRMhRNru7mtotL8mx7Yx4SOZNZ+kj8OPQgHUPN5CJGdF22vwP2DQhxNQ
         RPwyte3GgK49l+mVp4GVkV1DM0DJ67ju1EP2a1YgsuBa3WfS45PIagiTSeb2ryqAaEVq
         h56bnLY1El6fDaEZdxNfAmlXLdDyn99U7zHLz+rGJJKKcClnM0DFvcC4fa2/3YKTTMQt
         zLoA==
X-Forwarded-Encrypted: i=1; AJvYcCWt9Hoksk0fSOTvPzuFgrGREkCYmg200yecwy3t2SVGMfbKh9QZM3X63aPF+OeQAtseVX6XEmJh4uGNXUE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkQFEA5s7JkO/r5EfdpmA9cIMDvT/dVt8X9d1oUYLc4gh3K5Nr
	+qG6IQqT66MJtGQOZp6+iuacjJQ1mEfeJYuxsUw6Ztx9x41CkXhWi/ZQlE7jfIDNJws=
X-Gm-Gg: ASbGnctlOGxDx+mSScM6oQdG2x+ZX5Rn+/DXMu1X+NJw9vHjoYTUYq+X55o3MX1sCkV
	UOdOfPLreQNm7ZpZLSjd2JSXVVJjG9h833PJudgLA/Bebd9gPug4eQQ0WrYQ2My9OSLNhRJ0K8B
	hkCE7RwJnBhW91s+icUigYzvB5CMEkMeyvrwxmYcO1ZDRJ8GB1YzysksA8f7G9mmqU1Ve7fNzGa
	1+4ho0tzy0/cPMYwXCOE26STztuXK47cO9p488GQ0ezh+5Yn7EWnKHkk3jJnPY19Q+XY60FDX4o
	SjZEVCPRcIsUIbDCTW6fMgl2GCzLt+AzOZ7GExucFANjeKk+5mt1ntv0uofqFMr5G3MhiaIWtVU
	ohTWb5Jemsvn8J1N4dsWehrboFISOz5g3OVdhtHRIyMOU
X-Google-Smtp-Source: AGHT+IFq8ZndNY94ug4Vncfn6GMH3AJectm8OrQgKj3dtrGm9CswRsXpRhsooX03/jVdbWn1ILmXPQ==
X-Received: by 2002:a17:907:9487:b0:b3f:ccac:af47 with SMTP id a640c23a62f3a-b46e8894979mr402428366b.31.1759329492716;
        Wed, 01 Oct 2025 07:38:12 -0700 (PDT)
Received: from localhost ([2001:4090:a245:8496:49da:2c07:5e9a:7fb9])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-b3f57c9c2e2sm629872966b.68.2025.10.01.07.38.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Oct 2025 07:38:12 -0700 (PDT)
From: "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
Date: Wed, 01 Oct 2025 16:37:38 +0200
Subject: [PATCH v8 1/3] firmware: ti_sci: Remove constant 0 function
 arguments
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251001-topic-am62-partialio-v6-12-b4-v8-1-76a742605110@baylibre.com>
References: <20251001-topic-am62-partialio-v6-12-b4-v8-0-76a742605110@baylibre.com>
In-Reply-To: <20251001-topic-am62-partialio-v6-12-b4-v8-0-76a742605110@baylibre.com>
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
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhoy7NvuKNpSGHnlyR/7Vs+1t0ywXXX4aJS6VUflv4RERQ
 ROHn2uWdpSyMIhxMciKKbJ0Joam/ZffeSx50bLNMHNYmUCGMHBxCsBEVj1jZFhanJD0/IWUTKWO
 9Yx6JSUli88rX6ndKk74cPhXq0O00VuG/0GXvZN+bzy6Vee2gZ2VFNtaNtbd8y/s9mF0s/MN52k
 UYAAA
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


