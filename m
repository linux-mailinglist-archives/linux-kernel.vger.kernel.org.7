Return-Path: <linux-kernel+bounces-878845-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B1A5AC2197E
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 18:57:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8C73B4EC84B
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 17:56:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40EA736CA7D;
	Thu, 30 Oct 2025 17:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J82MttpW"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8797E36CA98
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 17:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761846936; cv=none; b=Hn1YrSu/MOZ5NGv3HEv7LokhYcRBG6GYxgSUxxlDdopik1B6OWpkyV0RJaAmsw2eGKRaaVv8GQQQ9Q4OFACAl/awnWH/S8KA4v62G1yDCoj+QDVn5eGTlz5rb27mJ28f7IBRhAfzdyO/h5ktm3zMz4fxGJYRGUuZw2zq7jcqdBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761846936; c=relaxed/simple;
	bh=9jcJ345rfMMIxdlmZfAg0y+exXpCpE0R+jvegxv2zm4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ewOt+NYKnNjIqILYfTSuOtX4LLzgn0tv0i7OQRDlEWuPMo8hic2RvDe44fuWW+h5m312owluQo3Ei94TKHQnIyiYngRcv/2PSPUjp5u5g2fraKu3NBMiuACq4j32xrSHA7IYR/o9dAbvPhKK74dfdnfHXCEK4q7LCBCdLsiJ70o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J82MttpW; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3ee64bc6b85so1298436f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 10:55:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761846931; x=1762451731; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GbIsB+JA33Gj1io+1AAFvPQwYHrrul7tUKhFdp8JQ+s=;
        b=J82MttpWIRLzbNEEfH+3Ncrsg/jYUIIN1lQ9nT3qpprSyfwFZTx+k292qSqPOp0GRc
         BNmSaBB/F5m3Cb4K83iM2sAVIfjfN5+ofA+IPFv2CuSQlTzy2IV7sLV4W2Zm9Hwsai0x
         XmHQhD4zkjKv7FLeStCGweTQp4ynd6ZJvJHVJTIqRrC5jN5YOiQTWHJmakoBFJX9iQyG
         5b8GCp1sm4Wz5+A31X5yZqFW4v9nJvILLctnkZBTeR1ibpFO4DCiLnNB0nmTA+3Qbs74
         llsdnhZoFd0CYI30Wi08BmbQL7bzSPJxAeBTSmJCmM3kcMNkV4vKwxU/9Sj0n+4wiYpY
         qQ2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761846931; x=1762451731;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GbIsB+JA33Gj1io+1AAFvPQwYHrrul7tUKhFdp8JQ+s=;
        b=r9Bf+DPVfuxVVmZD5p2vXWgFVXznL+xL6yh2dlr7+wDYX82G3tWckiUfusDuSgAlWS
         y7yye/2zj71v2TWyzMNLCihCnJBxwBDj6HlRHs9msLEqk+xH+frQEU3SC4AvNSCfazLb
         xpu2ZCzzJ2tkyPwzX81kT2smVX99xtOhNhhtNi38uOCCySnaWRYbl7hBjmCt9AnsXqJf
         V6LcIWdQagNsbZm85WD+Zwn5cJTuS10U1KSKOQIOE/ryvzuNujIiUkXhJXvVa5aHbRjj
         opGDQ2CbaN94M+CpSM5f3MioJYF4hkeF4APEDMobIlcqLadACWJlXFHfbKRxfZaEBfFt
         s3Zw==
X-Forwarded-Encrypted: i=1; AJvYcCW/gya1dNvyacbi/a+IjOdile4iL4f276kT4sZ9qhnQL7Voz03mmqqah+YEN1hV3bhIxpapMo9J6uzCf70=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkAQ0MJJLrunpJL7HgScHRPq+piXKWS/PKggNZMecNQe4r3S5c
	n37zYVs7x4EsLq1chGiDezJMpGZS4gNYql6CO8nF9sxytIkI/wjGLGLk
X-Gm-Gg: ASbGncvOQfjj8O0Zdk/7KzmltB8WjJglts4EHejVtDWoMK6ImyGNYT55+w+wMbSpnxG
	CDIHceEV6j/ZwdeBDkA0ZgclHJ8kVCJBr9tmOX9HD9TskFUhkbKzIp72K1WWfuWDaBOcjpMEywX
	eEyNfo+fgNAJjzl1VNUecUuH9ft4vpp3IBJgbvK74K9f2B7tLRIs13UfmPCUTzcjRFgO/nHW0eE
	4WL9P6Pik3MZkumx/DoPByTwszwzxm6ltB94jDEYNhemVkIaAdrxexFL/PbNY12EUyoL4s/GzQI
	2fVODEZ8uSoUSDI1vqVQuqRe8oFm9BP1K1FW3XPo9DKZwlU+BaMEFw02577z3MZ40CTubi6j4hO
	LCchS4FZtKyn5gpm3laarygNLqFiLw2yqlOJDUDLgeOgaLIt2tEvxgrnME4afAMJIWz6r7pEuom
	/QKMDdJZkHiieqjxpiikf3Ldd4HuWLUeR1ktFlXpaAWRFFR8uTZ9s1Gd4j7K/I8iauuRxuEr4=
X-Google-Smtp-Source: AGHT+IEF2L0p91EN9iLwnGMihS3zlarLJMg1F5IRe+iNrL7LAp7ExKgFdBKaDNHl4ZjJyQD8OKHXaQ==
X-Received: by 2002:a05:6000:25c2:b0:429:b718:167c with SMTP id ffacd0b85a97d-429bd68847fmr429373f8f.28.1761846931270;
        Thu, 30 Oct 2025 10:55:31 -0700 (PDT)
Received: from biju.lan (host86-162-200-138.range86-162.btcentralplus.com. [86.162.200.138])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429952de5f9sm33384041f8f.38.2025.10.30.10.55.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 10:55:31 -0700 (PDT)
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
Subject: [PATCH v2 05/13] serial: rsci: Drop unused TDR register
Date: Thu, 30 Oct 2025 17:55:09 +0000
Message-ID: <20251030175526.607006-6-biju.das.jz@bp.renesas.com>
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

Drop the unused TDR register-related macros.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v1->v2:
 * No change.
---
 drivers/tty/serial/rsci.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/tty/serial/rsci.c b/drivers/tty/serial/rsci.c
index 470b5701cd67..ade5ee479e99 100644
--- a/drivers/tty/serial/rsci.c
+++ b/drivers/tty/serial/rsci.c
@@ -35,12 +35,6 @@ MODULE_IMPORT_NS("SH_SCI");
 #define RDR_FPER		BIT(11) /* FIFO Parity Error */
 #define RDR_RDAT_MSK		GENMASK(8, 0)
 
-/* TDR (Transmit Data Register) */
-#define TDR_MPBT		BIT(9)	/* Multiprocessor Transfer */
-#define TDR_TDAT_9BIT_LSHIFT	0
-#define TDR_TDAT_9BIT_VAL	0x1FF
-#define TDR_TDAT_9BIT_MSK	(TDR_TDAT_9BIT_VAL << TDR_TDAT_9BIT_LSHIFT)
-
 /* CCR0 (Common Control Register 0) */
 #define CCR0_SSE		BIT(24)	/* SSn# Pin Function Enable */
 #define CCR0_TEIE		BIT(21)	/* Transmit End Interrupt Enable */
-- 
2.43.0


