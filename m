Return-Path: <linux-kernel+bounces-878850-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C7A6CC219B7
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 18:59:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B898D1892BD6
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 17:58:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FE0F37DBCB;
	Thu, 30 Oct 2025 17:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VLeuDtXN"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F2E136CE0B
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 17:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761846939; cv=none; b=ZSDrerjsknPzRKiUY2fYsFTkD69Vww3Swz4hONj9K+IxCR0Rh5yHBM6XWZjyKRnsgJy7UHT7JmNLfJHz+Qt+y1GCdEpRiT4zwGTa1lSrilPz9KkDZjTnZTSxKJl0AgM5/FVUV7IQhBWMT8rGh/2OXOZpnNCHcMDFXUKHGnbSnDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761846939; c=relaxed/simple;
	bh=FUUpdN5VqPaa0AglNAM37NGlXaHlU8F1s0H5S0bhfxo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kX5AF79VJ0XGtjc2P+G5bfKsrSUAV0BWEo/kV4JoTFveMp7XPA0+AVsgZ2p9bIMPBjKGf78JV2HHIlbXrsmk06JWMHD7aHydzDnFaBjJ699C9Tf+TtscQApV54Ff/tu5Sh0d7W1K0f2MfWwAOVTa406Y3HCkXFbaSxvWTAkupzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VLeuDtXN; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3ee15b5435bso1069212f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 10:55:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761846934; x=1762451734; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qx09GhYIQEqgtyHYb9x3QHdYCDiDGK8KkivjnJ7GUsM=;
        b=VLeuDtXN2KJFSg2RW2rvkZQMu13Rlp4GFEPNaVhqFtPZJv5CFNG+OYknmQOhhFDKyz
         8mx0tYDWG2jdrt83B+JeRMCv+A8Q601logzyaGpMUfW/XFrrNm4TfZLLjjUQHoK2b1l4
         YA0IiQWL4DaS6SmOgDo/nwP8i/t+1bGNsacIkF8y3OF1ZzT83AysrcEHfn5vWvT6B4nX
         rlSBFyda8jBKk5bRqDJ/Cjzbq2rNK1/ruwr/T1GnRJAeTxX2KX8c5jG0Pg8GAaePiqm4
         UrZaCSFL53wYn06Z30kKFtWuI2iZTxv1saN8emR/hk9wsAoedb+gxm2chfbKgGsxX2jb
         lIIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761846934; x=1762451734;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qx09GhYIQEqgtyHYb9x3QHdYCDiDGK8KkivjnJ7GUsM=;
        b=k2KnkprG3p32zftDdFwpO1xE9/QdJce2p9rDWpWijbTHZKZMdoAGCrhAk0OUSnF+cb
         vnDCDsBBpDI2mVZw7lJUGJq0MbQv0AtFX7VAp0EtfsdL8weZrPt+AUsUsXQylPTnHSNH
         GrFSLAi2aemr5mC6U+sn0n/gTx+jVmGkVhAbw+8B9/wdCXbrADVEGnIwX0GzPuLTC6EC
         2vWO9DHnnA3AGXT1cSvN3APi+Z4uJmAxHDYyb+mCJcINrSWKG35QbIneSRpUhjz4isfT
         DybiIlHyBwex7Tso6qnNKaRAn5dGEjmsDiiY9OfOYJGKG3GTqfNUNALRBjZ1HmJBjQiY
         rnjA==
X-Forwarded-Encrypted: i=1; AJvYcCWxeqqiPBdHb9maLzgDchoFJdzl63KgPM5nUunXA9HOLYfpNDAymTRzcUh+2+kLKyKSosKWs9sNbJ1puyU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBAQh7Tv4KhoJsQFMLZr93cX7PRIu8ZU7w1tjiv4cXcfl6wzF1
	lv5KopJhqC3iBw9r+mPifpx2fvXTRbVLsyfumo6NgpAGgHnfe+guB+il
X-Gm-Gg: ASbGnctykdmQeAzB09scsuK8gbV1chxtRekdneWk/ozbvcefvDbBDxtu0DPSNk7vqpn
	9zbYhmTb9S+RVF72cOWHxTqNT5ubbQ7iuRbpJhZQwgB9uKheuAGmRsHLay4bGzvQ1C7LXjrE7pD
	9AjC22nyqPYDWAUFw3+Ld2i5X4SeY5aIKBCw8s+y3Dd61gMpenkhMx3ODvlzSFSJ/K5xMljgqlf
	YJvl6evp6uP4In0Q6rODYaAoNjfTq756GzhHe1u3cL8n1RVoUBmYbrdsbIi132xeu7BvR3agSqn
	10Y4NMZdnUNj8R1XF3TMRIyQXC5CJaJFRTXG1kCr58ed0Vc6RSxsHGCYArOq4xM0+2bzcToyGWT
	doUt6yNYZ1YwI3Z7yYtqOB07cP7nClEPpidb3NnEq7kaspQR+2tyzyf3WvfG7rzv0Q9U6TuofkL
	pvfYzYk1IvmIYX5/OQ58HKfdprmRZnOvbs3/tyW9M3pJjxxmFbBHrdcdf2lKXH
X-Google-Smtp-Source: AGHT+IE2wGBv6w4TzgH/dIqRMjz4ljrVN4/hTLrQ5+0NZaeomnqoztVj/d+T+noqIPl5lxRmm33nkQ==
X-Received: by 2002:a5d:5f55:0:b0:429:bc31:5de6 with SMTP id ffacd0b85a97d-429bd671ed0mr446668f8f.12.1761846933645;
        Thu, 30 Oct 2025 10:55:33 -0700 (PDT)
Received: from biju.lan (host86-162-200-138.range86-162.btcentralplus.com. [86.162.200.138])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429952de5f9sm33384041f8f.38.2025.10.30.10.55.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 10:55:33 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	Biju Das <biju.das.au@gmail.com>,
	linux-renesas-soc@vger.kernel.org
Subject: [PATCH v2 10/13] serial: sh-sci: Make sci_scbrr_calc() public
Date: Thu, 30 Oct 2025 17:55:14 +0000
Message-ID: <20251030175526.607006-11-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251030175526.607006-1-biju.das.jz@bp.renesas.com>
References: <20251030175526.607006-1-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Biju Das <biju.das.jz@bp.renesas.com>

Make the function sci_scbrr_calc() public for code reuse to support RZ/G3E
RSCI IP.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v1->v2:
 * No change.
---
 drivers/tty/serial/sh-sci-common.h | 3 +++
 drivers/tty/serial/sh-sci.c        | 6 +++---
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/sh-sci-common.h b/drivers/tty/serial/sh-sci-common.h
index f730ff9add60..a3f4a76cdecb 100644
--- a/drivers/tty/serial/sh-sci-common.h
+++ b/drivers/tty/serial/sh-sci-common.h
@@ -171,6 +171,9 @@ void sci_port_enable(struct sci_port *sci_port);
 int sci_startup(struct uart_port *port);
 void sci_shutdown(struct uart_port *port);
 
+int sci_scbrr_calc(struct sci_port *s, unsigned int bps, unsigned int *brr,
+		   unsigned int *srr, unsigned int *cks);
+
 #define min_sr(_port)		ffs((_port)->sampling_rate_mask)
 #define max_sr(_port)		fls((_port)->sampling_rate_mask)
 
diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 67eba7feea9f..ca4915c1e2e6 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -2395,9 +2395,8 @@ static int sci_brg_calc(struct sci_port *s, unsigned int bps,
 }
 
 /* calculate sample rate, BRR, and clock select */
-static int sci_scbrr_calc(struct sci_port *s, unsigned int bps,
-		   unsigned int *brr, unsigned int *srr,
-		   unsigned int *cks)
+int sci_scbrr_calc(struct sci_port *s, unsigned int bps, unsigned int *brr,
+		   unsigned int *srr, unsigned int *cks)
 {
 	unsigned long freq = s->clk_rates[SCI_FCK];
 	unsigned int sr, br, prediv, scrate, c;
@@ -2461,6 +2460,7 @@ static int sci_scbrr_calc(struct sci_port *s, unsigned int bps,
 		min_err, *brr, *srr + 1, *cks);
 	return min_err;
 }
+EXPORT_SYMBOL_NS_GPL(sci_scbrr_calc, "SH_SCI");
 
 static void sci_reset(struct uart_port *port)
 {
-- 
2.43.0


