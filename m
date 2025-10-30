Return-Path: <linux-kernel+bounces-878849-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 24497C219AE
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 18:59:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 71441188FC51
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 17:57:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EEED375751;
	Thu, 30 Oct 2025 17:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YjoMLTIx"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FB5436CDF7
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 17:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761846938; cv=none; b=gmsKUjGXNtRaDhbx6Sx0b7gAeVPXrrptFZtxkoEBrKO/Aoo+lDDmAcq7NkneiUMO29x02r2u5hjFT7eBA4kd0kBd+fRzKyGuyJl03SiPdpYw5icJeZrXjoFkOWypUFRlt162YJlS2HKSiqIX/NaNSDbYDkQlIbMz3YtcxjQNKwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761846938; c=relaxed/simple;
	bh=HUpnC1htM18fOjkA4XpHL5QRou+4yn4bYa0B4lXoOyg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S1ILu1TAl0dEVe+LPKAIVSzPNE4sBhL9zetuvvTZINYJIc0iCkJ9xWh/KiuoqXAjgJ5vlVi5zNCDIpoLIzSavElFmyN9w1PDSIoVqvP4xssZ/n2s1akpA069W5WH3CCbnxnRQ3uFSV4oO8Mzy13Cjdu7H75sEb4aP2+sNFu+xbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YjoMLTIx; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-429a0d1c31aso939278f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 10:55:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761846933; x=1762451733; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aEUFPuIhsavAXgb0AC7F4BVlpWod4yVZ6DEuITlOuu0=;
        b=YjoMLTIxKin+/GWOhbVfyK4bQIQ+l/X64jHnWln8KmJpjXDCtsz4i7rEMQN9xg+8yS
         knrX88QyPBfEoSuewqVkUUnXBHIOTeCUbE4Ysh7Fcm0wfEOCq0Tb311xPCsKoncOIaIR
         xKukIjZNbrqzV67CmJY3EDdf0oczljYrFSSnciPFL4GzuIYRKWaDLbvK7xvlAGCorbyz
         oUVcmnbb+HxdpS03aBz/wuBurylhXqskyR61bru6f7vp+I/VngyI4YXD/nhFTscrBIo9
         hZaZk2Mc4jb8iy413u6YClfBowwAu5DZ19duY82DYsyuO4nmhmQ2bnYCgtZxkZ4CPrlp
         XN0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761846933; x=1762451733;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aEUFPuIhsavAXgb0AC7F4BVlpWod4yVZ6DEuITlOuu0=;
        b=QEgpqNen2BqTAV2K+ecpD6iISaX9VFPIKK8RUHjL7TuRZKouc+rRDqicJcYHS0v+uW
         xKbx6yPww4wYB3KFeAKa5hos5hwYj3zP39OLjz3cd60waBFcepj+cirYtd30xiAIhKrs
         +cE0GkBWecg6qiA+/CPuXj+CprURkjfSR7sHbF6QJSGfT8BMEYOjyXI06b5PCentXG+4
         M0aP7y4ChmOOEnGN8up7i9nNOha4PsvoWTkdBE9aEyt0Ar4B6lVNVyy6kFrvGH4upui7
         z5n9lKohiUsWvGfH9KXKm4Cz3CQbwLZIbjZ3bs1Yd6b/VV3af8VzvQaTjro6+sVrsVmk
         214Q==
X-Forwarded-Encrypted: i=1; AJvYcCXjPLstcpLiN1qw+MG9Pm0UdCC0lvXIwGoTbgVkJZZNhgI4DRvUytDyRuhX6wBrKYbhZN5n7hU1yZ+4NZ0=@vger.kernel.org
X-Gm-Message-State: AOJu0YymMmleHb8mmbiyhs+XYbgpjQ6ncXtQ0sD9oG+q37oDmdEJMIf9
	nWn90SAW8lz/zcPcX7I/5i2v0WjPKYpXWZjIk88/bfo4X57VVW6afV0X
X-Gm-Gg: ASbGncvrfYAmP0Xa8xV+i/mcGYIeFEymd3/jcqavgQZ/IkfjQZFPALloodSAM4GQcBg
	dVjCxk7qZk2Zgd3eOu96eDx9tLHHp50X9Nhb5ywGD5ZPk4XBszYvL/SbhvA5kchMBHE0MF2BYOG
	Z/9MkYtD6W4vp57TMn2wpsn2yyjqJdnRc2v/vOzsvnHrh6eLckfhcNMIQfm0I0FxPI8mvm4sD6W
	n6ams8u8e+Um9MKhGLAZ/A6Z9xDj28WfAXGUo6tVKfq2bYb0gYjBU+lth9GTOa9pdvFIYBBVz7J
	e2612fYXRcaqc9OwR4h8VSkj1huwfuHdp/kJPwedyVbgj0DB5L957JgsBEVpLun75QSRON3ThDc
	uQjBJzzRaQ1/Xyp2ZTB2eowu0Ywsyy0EXh3VZ5gWIAe5Wm4mb3CjJPnHw3lsO1Afqhj3UGb6Zrm
	S4h/WPj0XcAz1dt5AHwprj3RrlIgC+XGv+mKtfx/82LAo81tPcRnWieMgiT+Ya
X-Google-Smtp-Source: AGHT+IFlRpzCZJwVLyz4vd+bbM0VhDvQFIr7m66Xdde7XxC4dW/e2SY7oK12bgM2QVykMekDGxO43g==
X-Received: by 2002:a05:6000:2308:b0:401:c55d:2d20 with SMTP id ffacd0b85a97d-429b4c8b48fmr3544505f8f.26.1761846933193;
        Thu, 30 Oct 2025 10:55:33 -0700 (PDT)
Received: from biju.lan (host86-162-200-138.range86-162.btcentralplus.com. [86.162.200.138])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429952de5f9sm33384041f8f.38.2025.10.30.10.55.32
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
Subject: [PATCH v2 09/13] serial: sh-sci: Add support for RZ/G3E RSCI clks
Date: Thu, 30 Oct 2025 17:55:13 +0000
Message-ID: <20251030175526.607006-10-biju.das.jz@bp.renesas.com>
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

RZ/G3E RSCI has 6 clocks (5 module clocks + 1 external clock). Add
support for the module clocks.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v1->v2:
 * Updated commit description.
---
 drivers/tty/serial/sh-sci-common.h |  3 +++
 drivers/tty/serial/sh-sci.c        | 12 ++++++++++++
 2 files changed, 15 insertions(+)

diff --git a/drivers/tty/serial/sh-sci-common.h b/drivers/tty/serial/sh-sci-common.h
index ef1d94ae8b5c..f730ff9add60 100644
--- a/drivers/tty/serial/sh-sci-common.h
+++ b/drivers/tty/serial/sh-sci-common.h
@@ -17,6 +17,9 @@ enum SCI_CLKS {
 	SCI_SCK,		/* Optional External Clock */
 	SCI_BRG_INT,		/* Optional BRG Internal Clock Source */
 	SCI_SCIF_CLK,		/* Optional BRG External Clock Source */
+	SCI_FCK_DIV64,		/* Optional Functional Clock frequency-divided by 64 */
+	SCI_FCK_DIV16,		/* Optional Functional Clock frequency-divided by 16 */
+	SCI_FCK_DIV4,		/* Optional Functional Clock frequency-divided by 4 */
 	SCI_NUM_CLKS
 };
 
diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 7cc2b622e270..67eba7feea9f 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -2994,6 +2994,9 @@ static int sci_init_clocks(struct sci_port *sci_port, struct device *dev)
 		[SCI_SCK] = "sck",
 		[SCI_BRG_INT] = "brg_int",
 		[SCI_SCIF_CLK] = "scif_clk",
+		[SCI_FCK_DIV64] = "tclk_div64",
+		[SCI_FCK_DIV16] = "tclk_div16",
+		[SCI_FCK_DIV4] = "tclk_div4",
 	};
 	struct clk *clk;
 	unsigned int i;
@@ -3003,6 +3006,9 @@ static int sci_init_clocks(struct sci_port *sci_port, struct device *dev)
 	} else if (sci_port->type == SCI_PORT_RSCI) {
 		clk_names[SCI_FCK] = "operation";
 		clk_names[SCI_BRG_INT] = "bus";
+	} else if (sci_port->type == RSCI_PORT_SCI || sci_port->type == RSCI_PORT_SCIF) {
+		clk_names[SCI_FCK] = "tclk";
+		clk_names[SCI_BRG_INT] = "bus";
 	}
 
 	for (i = 0; i < SCI_NUM_CLKS; i++) {
@@ -3016,6 +3022,12 @@ static int sci_init_clocks(struct sci_port *sci_port, struct device *dev)
 		    (i == SCI_FCK || i == SCI_BRG_INT))
 			return dev_err_probe(dev, -ENODEV, "failed to get %s\n", name);
 
+		if (!clk && (sci_port->type == RSCI_PORT_SCI ||
+			     sci_port->type == RSCI_PORT_SCIF) &&
+		    (i == SCI_FCK || i == SCI_BRG_INT || i == SCI_FCK_DIV64 ||
+		     i == SCI_FCK_DIV16 || i == SCI_FCK_DIV4))
+			return dev_err_probe(dev, -ENODEV, "failed to get %s\n", name);
+
 		if (!clk && i == SCI_FCK) {
 			/*
 			 * Not all SH platforms declare a clock lookup entry
-- 
2.43.0


