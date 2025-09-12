Return-Path: <linux-kernel+bounces-813747-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96CFBB54A3E
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 12:48:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2C324872CE
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 10:48:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78D192FF140;
	Fri, 12 Sep 2025 10:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NWmFk/hT"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82E682FE04F
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 10:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757674061; cv=none; b=lSWZsN0yFTJOjmWuOMozABOyVrSVBorhdYi2T6+sH9Ku6CKCVlAXvKgnpPTkcWo8qjJjjDFjp8so1fzzH0jdUC/NL6w7cq4/YUYDKhYUQmE3yopQ5PLCWBIoL/XyDAZyoO1b51M0RWOPSj5RD9egv6ikIMsZj8d88Bcz0tjtXDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757674061; c=relaxed/simple;
	bh=jEe+LssdJuX0Sol/ICpsmWzbrOJwv26l/qHv6esdx/k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hM0tjQvxz0VmeM/xeMZpi7Du98sdG0V9jjQo3fDL6EvfaaYNeJpq+GvlHgzOdmtazk8x2zQUu0NFY3KLiunsr5CJ4///2cMJV6fQqV7Zik0ZRdV5DehAYvg1uUZTAFY7YNXNo2v8TGIhW6fZMPsLk1PiPmCa0/yElfHkxtjyWX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NWmFk/hT; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-45dec1ae562so16760675e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 03:47:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757674057; x=1758278857; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1S7AuUlSi67Znb0Wq+XUSupvk0GbKEmlDvc8tRj0Jnw=;
        b=NWmFk/hTtB4O9nB5UxL237V6ljbhej4rW+y9tBWLMRssjN77rUPuqY1RauCmtper8z
         w9YoEbOJqnr0l9QCm4v+S4wo375Ey7PGWtEA+Djt72YMhb/dGB/uH5xAdtzMn9k4eA/o
         G7NwHn2HFGGIfktOE0JQLjklzQrv6FyN2v6gA0sDxP452u9uGT9rGz3Ken6SqfEOFI6z
         MCsKv2aN1I4pXrHa63B1/rOHksF81RXzGLamOYrtbZfb72jgI6KJQW93vt9Ifm2ns9+L
         PwVzG+bsb5pqZbQqXUBWDxqniV944gzgVDJMRpPLCt+EOV6Q9NCysjvGdFNtf55QnFwX
         djXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757674057; x=1758278857;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1S7AuUlSi67Znb0Wq+XUSupvk0GbKEmlDvc8tRj0Jnw=;
        b=ALgHY704+sAv/TH/GThcR2TUDQtnXJZFg8LXCjiB5A7IJug0cCAXHb8ujljV8OXLdH
         C+scarz2zkR2WrF8Z5aboIi+8iqC5EeDPyBDopoTF6wSF54F95ICUg6AylANyZ1kn/a6
         CvQ2FLtE2aAA0Pr4QeKFb6m3ywPIIRPwnRey6w8bHPDBDn8n80Gcf2HZKa1yc/TSJDLV
         rdcCBsvQXKGzGSfZt+oSL+cSePpZxMyjVlCLr/Kv5sXKkcqms2YVj1Tds+4Vq7fXxUbE
         N9qkZV0XGLW/AwGFTWcSn0aRKbKnsjeoQamjQrcteQ0WWWg/BKypy7ElUc+cL0NCVJ8m
         P2oA==
X-Forwarded-Encrypted: i=1; AJvYcCWvyZZ1b4Xtk+UFT9wxp90bo+5to/vzZAkdLJpujC5H1q4upjpEazzVG+84ymF3bBeB/bQ5uwzKkxCrwGU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8LUhuohes8kqck5ItcKSQDEzD1gy0e9AR6o4LDRNkEsv7VAup
	UkYcGtTHqX5vIHg9LyozywJwKHLS6PbJ8se+Wh7WyE27jcGQue0DwchY
X-Gm-Gg: ASbGncseqOjLZhpL0NjzZYphkfs5GI+rnaXW7fv2Acp/5gl9Zm/4BQDgffWDRKWQvWd
	2ffmRh2qVsHoz5gshN1zpr6Pa1NiJ4VXDGLRoAjvisEJTW+tHWYM6cV/y7GlXqb9WVXXww+AVyh
	feW1i14bgM+0i/4RGH4mqdouauLUq5vxqoS/bc+/L7/R/vk3aDYVUTHQXVpZXmSl9yBLsglzP7A
	3oa1pLACFcRz35rAO55PCZaL1kN3ETYRHzEGse90dy1mJ/sxdBhxWxmurS6NpYVtr5xU8xKgKI4
	MZfk1xXO126Pxa9sBNQbi5GXJHimg/04558SgeyvOCPlTfhl4FaMYNHjy7RAgK22oIHr1LgxBtj
	3z1/nbew+l7kF47QdpHzr/TXm7fyMYOChfv5TTDOLrJ6NF3FMg4rW676jz9+fz8k9PC4ZFHyy6J
	lw3Q==
X-Google-Smtp-Source: AGHT+IGGQn4z6FJczqoIOf8FijkX45T6VbvuIudJ+ZXc3G02iFJUUELPhSpYW2NzZxdr0hLI4woaSg==
X-Received: by 2002:a7b:cc91:0:b0:45b:8039:6196 with SMTP id 5b1f17b1804b1-45f211cce4fmr18730275e9.4.1757674056487;
        Fri, 12 Sep 2025 03:47:36 -0700 (PDT)
Received: from biju.lan (host86-139-30-37.range86-139.btcentralplus.com. [86.139.30.37])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e7607cd329sm6197316f8f.31.2025.09.12.03.47.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 03:47:36 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	linux-can@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Biju Das <biju.das.au@gmail.com>,
	Vincent Mailhol <mailhol@kernel.org>
Subject: [PATCH v2 2/7] can: rcar_canfd: Invert global vs. channel teardown
Date: Fri, 12 Sep 2025 11:47:20 +0100
Message-ID: <20250912104733.173281-3-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250912104733.173281-1-biju.das.jz@bp.renesas.com>
References: <20250912104733.173281-1-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geert Uytterhoeven <geert+renesas@glider.be>

Global state is initialized and torn down before per-channel state.
Invert the order to restore symmetry.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Vincent Mailhol <mailhol@kernel.org>
Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v1->v2:
 * Collected tags.
---
 drivers/net/can/rcar/rcar_canfd.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rcar_canfd.c
index cf70029968ad..460bb62bbd08 100644
--- a/drivers/net/can/rcar/rcar_canfd.c
+++ b/drivers/net/can/rcar/rcar_canfd.c
@@ -2203,14 +2203,14 @@ static void rcar_canfd_remove(struct platform_device *pdev)
 	struct rcar_canfd_global *gpriv = platform_get_drvdata(pdev);
 	u32 ch;
 
-	rcar_canfd_reset_controller(gpriv);
-	rcar_canfd_disable_global_interrupts(gpriv);
-
 	for_each_set_bit(ch, &gpriv->channels_mask, gpriv->info->max_channels) {
 		rcar_canfd_disable_channel_interrupts(gpriv->ch[ch]);
 		rcar_canfd_channel_remove(gpriv, ch);
 	}
 
+	rcar_canfd_disable_global_interrupts(gpriv);
+	rcar_canfd_reset_controller(gpriv);
+
 	/* Enter global sleep mode */
 	rcar_canfd_set_bit(gpriv->base, RCANFD_GCTR, RCANFD_GCTR_GSLPR);
 	clk_disable_unprepare(gpriv->clkp);
-- 
2.43.0


