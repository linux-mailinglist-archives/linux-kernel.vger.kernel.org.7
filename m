Return-Path: <linux-kernel+bounces-878862-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 619B8C219CF
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 19:00:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C5704228B2
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 18:00:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0EDE37DBEC;
	Thu, 30 Oct 2025 17:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g2/7CgLG"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FA0D374AB3
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 17:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761847100; cv=none; b=c75oU749ET9n/nXtsm+CLss1j206O0946UB6hruIQwdbT4fby/DUu+Nb1DBh2sExCwyLiomo2QCoBnkkQFmgg/5Tw3srzX9hMiyktjMWI9G2WJXxQN/HnJbDUONnFIrbgXCPiLlE+le9zj9h1Y2UB0xOLf6OEiWNKnbMjFa5c2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761847100; c=relaxed/simple;
	bh=9jcJ345rfMMIxdlmZfAg0y+exXpCpE0R+jvegxv2zm4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sdt8k1sJjDla9+51yn/JhHaYhaP7znt4pze6f5g0cwecADRzA+kz/gwi56ckFmpJZ4F2+li1Lp95arW/qh1Gn/Dcu0T3Znbf0mdL5Y3EcV7f/gMWMjynwgJnzVRv+6LqTc+96rw2KX0TMboLH8eXylWw+iQKLyMB7H9EWTx8Hn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g2/7CgLG; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-47721293fd3so8610495e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 10:58:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761847097; x=1762451897; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GbIsB+JA33Gj1io+1AAFvPQwYHrrul7tUKhFdp8JQ+s=;
        b=g2/7CgLGNM06zuV3it5VB7AXNnSh/EFwuTl55MbCt9TwFejVsFq0yfSD0jmSKpi9pe
         cm2JLb+QJtOCRR5M18Bva9NoODFirJbmNYh8tMNP3WnQzAq8NlnBWM5FaRqObSiuBq4y
         VyBoUir3jd5pGWYhmGSso1bWxq7m4yhFF8RJeY/1yfcLIIh8a/UHOMiL8JKUExb2Z3h3
         JFfz28PD0MH3XYs6RI4fJ2aCZU/gSM3Xf7p6kkYfLxXTwgcAgVVU2RZ5agdCR4wQn/Gd
         qui/5F0a5Qpq77OMC0Hs7K2RN75atwWzfLJrLYWt1inZ9zWvw3xNpGK6yyLZfDPeejDp
         cWrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761847097; x=1762451897;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GbIsB+JA33Gj1io+1AAFvPQwYHrrul7tUKhFdp8JQ+s=;
        b=pXUfLlAjBycwOr5oze9BdlpoNj7+6ONsFxO6wWxLhIwH09TSbDvZfA/X9F/UhpS9cq
         4a4VfnYoWLVVtXvsl7ekX3AmiNrDTBP76OlmqeFeBlKp3tSep9ClqEd+4Ea65tz2/+Xj
         e9KE1+89XgCfj4b9ZFcBxL72mLRRmHsIbcwdatlVioNYA5Qeg9mhfKyjoSaKZpfiEUjA
         SjqNLZqbWJjs0goANj1Fz9oPxLu9YdPJ2Oo72F1mve/qv0b3yECMo2BfNYg8Od3RBk17
         02NnNx1+ZY+AggDaTECGEGvB02S2XqdTCbxlYfpWN6SjXXMeIedHFn5ByOJyRj9ZXLD0
         whXw==
X-Forwarded-Encrypted: i=1; AJvYcCWpBQdQzU06stUXDsasOGKnwDWPbmzFr6BhIKH6jWbmSSOHS8GHj0U5oMvjCg+I5pIWb0aN06iyZB/TQPY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyiYoFFjQWOA7LbEK0yT4XFFfaAB3R+BZJi6vKFRtbiDTAuz9vK
	aG2LV+Ca4HW+Vb5s+3eJAr+YsN5diaBZRSThrXN3zurn8ZRb6JIXUBeS
X-Gm-Gg: ASbGnctIfkyBhGs7msSTBfT1X3qz0z+uuUUm8KuRDAbNNT0GdMMSIe2JLzx+t1kjI+b
	w9223l5VTuchU8ehePYlYyGtNiUHU+MTh+zXuLN6ChIo9z4qcR3S6J8tqSoXfd97eU7CMRYjrar
	m8GDFtJpkqBKeoZ/rMyiOpdwFWkNarlQ27WEq3MtdN0pkIg06N0dTkm8HfBiMfkhsWd9uC1aipO
	QSR7asqn7a4PvppHI69doPD6QkhaxQBXHVTeaPigq3mhZ3rXM24bBV8v4YXZmblRAhFrXgC8JdX
	kCmuQDczwxKqK2hup9tnwGh/GGDl6LZU2f/TSmOc+GITQua8bECxtWLGERYQ946KcZ5CA8p1jDj
	nrGnW7MYXUwZLrQq8u5CknUo3oHA0S3ACoi/aRcDkPVvfJSEq9vCriEj+CE4BK2QVKBbt0KI8ee
	jXWNTTaUV8JaRADSaVNtZSQEZPBwDCLeacwWId7S8SFMjp2O1GPFXEwTqzFu/E2U+17oy6cQw=
X-Google-Smtp-Source: AGHT+IHaW/aKuio2uca4DVlK5hpIYnror7GRbjbf3WKhe549DWwP6AesragGrVL8J6g2M1dW2nuRjA==
X-Received: by 2002:a7b:ce96:0:b0:471:611:c1e2 with SMTP id 5b1f17b1804b1-4772622261fmr32312035e9.3.1761847096589;
        Thu, 30 Oct 2025 10:58:16 -0700 (PDT)
Received: from biju.lan (host86-162-200-138.range86-162.btcentralplus.com. [86.162.200.138])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4772f53aad6sm15098055e9.13.2025.10.30.10.58.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 10:58:16 -0700 (PDT)
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
Date: Thu, 30 Oct 2025 17:57:53 +0000
Message-ID: <20251030175811.607137-6-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251030175811.607137-1-biju.das.jz@bp.renesas.com>
References: <20251030175811.607137-1-biju.das.jz@bp.renesas.com>
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


