Return-Path: <linux-kernel+bounces-813745-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38CD0B54A39
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 12:48:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EAE76AC2319
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 10:47:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33AD22FDC52;
	Fri, 12 Sep 2025 10:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nNxzDfYo"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 123662FDC47
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 10:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757674059; cv=none; b=TR8ttFSBfH6EhXLgCzgeFLQwLI+DpREoKC6JNwSovkwDnRB0SfisMIGjlOlmPYbwLhf8tjb9f6BjfemyquDTRilKxtVdJtWCi4f0eDdF3X/hKDxdhRXNxd7b3TiT2zyi1nuIyGnBiKhNopsthaQ4dUYL8/LAHzRyg0eFuSrqBRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757674059; c=relaxed/simple;
	bh=9Mtl3DFWDH+wE6RcNo9SWO/Ky6IGgN5a8YqQgo8cwaw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q3T1EnCVZe/odBtSL69bsZqLsWaZcKNnwJv7B00Sf/Upifa4cMbJss0HF3/ndqime9EOU2RbmRw5f8x1fugDpogLhEIwODkexNDEn2ZLYWlxcKxWqLN+zAmzPpIAfhWsbIIxL1ELX6suv+HxofH+T09s+3dN3zq4/5XcVJDKJ5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nNxzDfYo; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-45deccb2c1eso13312735e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 03:47:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757674056; x=1758278856; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RQUxlfAyxKIcoNzjnIkl3LJHo+al+9/aWzc3N+BZ0r8=;
        b=nNxzDfYoC5xJSttRKYm36QmkcJOpkRruOxu8FiJmgKLuweP7T0ASpggEAW8fBVEJsV
         qO3eORQvZr+k04trwLK696xc6b45pKDBmxzVDkemPSPiIBfydGFj+Y84GJueE7VgudeB
         HY3OqL/oEzJ6DYgwOWsAqs3sX4vkkWrScwGDt38WZeqezAC31ZjrHiQ4/p7g7nhV6KcW
         2av5nOmyZrZFgKDXuypHFHbtemm3aqSn3zTFUWuwO+ImdqwFoUqAwzv4hAD45fJg/Lx/
         9X9qXzLiZ1CEchCGMDc+67e2/hr+AWthHterxRQMv2HE4A7Evf1UCCtnkGcwNEovKxcx
         /EJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757674056; x=1758278856;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RQUxlfAyxKIcoNzjnIkl3LJHo+al+9/aWzc3N+BZ0r8=;
        b=owNL2yU5czmPRZvyqa89LJ+vLLMZaAkFXgeGEsBZZW3LON0ZL5FhRADs9eBRQWNKhj
         N0rs0G+up3n1xph6UwQLpEcdoaHpNVNqOngogkUKVEjDN4qsYvF0Ukx3o877f6abc/5G
         +Pbc4bSqh4mtQaKf4su8aXrgwkeK71B6sYKchkJU880jt6BBaaFymawbHpDbTfC6qvHF
         +8Uuzo3VdWaSo5KZSNbHSuL5SUitVsOxBVn4yW9wlwKRszdHF061WXsymhHdhIaOq8kr
         aQmH4lBbVpWKKfma9H5vVywRtza3PLu4H3Wew0Gsuq9yWvlu/he/bzMIWcr615i4wxCo
         cdAg==
X-Forwarded-Encrypted: i=1; AJvYcCUC7YnRTGV3NR7pKKycoGJ3jQtc9/FSNxZRAcnIK/T0Ley3GTBmVM+DDhyQqS9AjgqT57DCmdX42RjxFPY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWMUbWTbUnHoohAbeC9Eu0aKZEQFSX0oZbjFTs0y5pVvSksaQ3
	YcRJJjt4630jCdDzQDPy7lP6neMNdkOWltVw1ElGEwTyWMTIODOnOkhZ
X-Gm-Gg: ASbGncsrFMaQSeXsUH3cAWnmVJcv/FVXpCSCaGlatLa1z1Q5KCLvzqYN16zOKxumzA4
	06LJa1DJ/g13YBAin2i2o1ho2mkRRqXBZTJ38XLDOTqUf+Rr2pyzpmMX4R4ZzFcmTEzSHyng+7+
	zMoQI8MLaUz41N5KAIiHpGzhGwnA8IS5DqbJrxJ5+dnPyLr4fraqciEa2hKzI/+0W5BVd7NITGD
	8XJa0LN7T2dEQdIwMyRyfvJPc8cxSXs5xc1fYBDbcKmk+4uJpChHq+q8RjdIf2WAwE9JG8NhwJ+
	KCab7xr9NgYjsqMX3eCWf0pRHEkyjg0/d68r0w0pc49pnkxTjAGRvsaGOLdO1S+nLlIA3YdhWV0
	nZH53CUWWGrpH2yHgA4tyEN42v50w7UNa+UeJ2qiE9Z+LXK7zbDN0dDKie+RTPfyz4jrY+7yjcN
	XtbY/6CfzvoxM7
X-Google-Smtp-Source: AGHT+IEYNoJ2MXACJDoPR63gdzq0LP7xuddB+Xs8lNKzKtp6XRQW/Q14Meypapw/0V0M2s8A5w2wEA==
X-Received: by 2002:a05:600c:8b85:b0:45c:b5bb:7b51 with SMTP id 5b1f17b1804b1-45f211ffd2emr25647125e9.30.1757674055821;
        Fri, 12 Sep 2025 03:47:35 -0700 (PDT)
Received: from biju.lan (host86-139-30-37.range86-139.btcentralplus.com. [86.139.30.37])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e7607cd329sm6197316f8f.31.2025.09.12.03.47.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 03:47:35 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	Philipp Zabel <p.zabel@pengutronix.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	linux-can@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Biju Das <biju.das.au@gmail.com>,
	Vincent Mailhol <mailhol@kernel.org>
Subject: [PATCH v2 1/7] can: rcar_canfd: Invert reset assert order
Date: Fri, 12 Sep 2025 11:47:19 +0100
Message-ID: <20250912104733.173281-2-biju.das.jz@bp.renesas.com>
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

The two resets are asserted during cleanup in the same order as they
were deasserted during probe.  Invert the order to restore symmetry.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Vincent Mailhol <mailhol@kernel.org>
Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v1->v2:
 * Collected tags.
---
 drivers/net/can/rcar/rcar_canfd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rcar_canfd.c
index 401505264676..cf70029968ad 100644
--- a/drivers/net/can/rcar/rcar_canfd.c
+++ b/drivers/net/can/rcar/rcar_canfd.c
@@ -2192,8 +2192,8 @@ static int rcar_canfd_probe(struct platform_device *pdev)
 fail_clk:
 	clk_disable_unprepare(gpriv->clkp);
 fail_reset:
-	reset_control_assert(gpriv->rstc1);
 	reset_control_assert(gpriv->rstc2);
+	reset_control_assert(gpriv->rstc1);
 fail_dev:
 	return err;
 }
@@ -2214,8 +2214,8 @@ static void rcar_canfd_remove(struct platform_device *pdev)
 	/* Enter global sleep mode */
 	rcar_canfd_set_bit(gpriv->base, RCANFD_GCTR, RCANFD_GCTR_GSLPR);
 	clk_disable_unprepare(gpriv->clkp);
-	reset_control_assert(gpriv->rstc1);
 	reset_control_assert(gpriv->rstc2);
+	reset_control_assert(gpriv->rstc1);
 }
 
 static int __maybe_unused rcar_canfd_suspend(struct device *dev)
-- 
2.43.0


