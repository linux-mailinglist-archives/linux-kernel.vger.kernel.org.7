Return-Path: <linux-kernel+bounces-878866-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C811CC21A6E
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 19:04:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B710C4ED84D
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 18:00:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0836337FC4A;
	Thu, 30 Oct 2025 17:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YXPMvkaw"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CD2A37573C
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 17:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761847103; cv=none; b=ZzZrUc4TAwhA4nL1tQqqDpNaDexAg6dK0Of83f0Opf6FpRUW0xhkgKp5is39KR2/XM4x7QE4Fy+h0/uRFzzz9scG2/3z3gxPUlI2xWdX3UmV3hqeZy25CdnQLxsGKut+WyltAXKp6WRCOPCbUoCf3nAYJ7KoOqxQ9kSsyCY2cxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761847103; c=relaxed/simple;
	bh=hRGcrf757tBUlPVJghD36FxXRGKWF+Ddzd5vihoN5uc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bjxOpjFlCK1NMinQOwDgswHP5Y2OH8XxuQZQBIicYGGWwUzPCzhR6xmw/s3u7RaB5+OXwF0cXyh4XAiVtaboAMwo440iJuB5dvW9VgZflwW80pFP5Wyltuz07sRNBxEkKGg9aoVl28+CP15C10qLXpnCDu5Rw3UaYTUl4JtXEcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YXPMvkaw; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-47728f914a4so6467655e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 10:58:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761847098; x=1762451898; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7uqGmMoi1PPAQaFicRlny+AD/MJGroEdg5O4X9kuPbw=;
        b=YXPMvkawHvTCa7O2TOGqIkRSO1AsAnYS4wF4Dua4XUXv2vIpXzO6uc8jbEa5gb9bry
         KhOjFGa4yRfI4Pw/V50I0GAObednKhdFwdvbqHIlHE0I0qvWfyovVf2P7wBQowI08Wd+
         dZpL2msLWPRY3bGpM+U2DuONWxQbLjw/ucVzbQn7b4gUBggJ+oTe1rcYk898qTQHU5vB
         yY5eXqw5B6ZbgckwVn21oR6mk4y5ZtHxrqNPO1+KzTfMxATL2yVqO2sI45Xa4B5tycyS
         bFknHEf1kI6vu8pKzr1zsxf7tcnzmwXlu1OaUvyq2PYCzc8Oa0k/GRCjZ3II9pHihdl7
         rYJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761847098; x=1762451898;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7uqGmMoi1PPAQaFicRlny+AD/MJGroEdg5O4X9kuPbw=;
        b=jKV61olYNki66cbfJOK4t1Bfg+/9N1WR8kDzOzsWYqHuaWJi/sg8fhKSLMDwLgrhyc
         Vh07OLHpoN76ud2uc6OlckP2vuY/lVsoXfiDn7bREAGNDpYFbfFvDNv3rhkzZF7912yj
         X89lidr443awFS1Fi29zOKf2sl3Pe5/3hiuz2XKCAQ3739n0VUYuam2MTw5T0+1MzLlT
         F24I90Y/fbZ1uFoJecSO4yNUbyzjA2jncLSrt5t0S9zpOfPXuQaROPsDkRsFs5wCV5Br
         5ykuj6AmOsioKHyIdWKAbWmto9UCP3EYbOQN5BeBlqkkz7PdhmYCa0SwxUsnvQnvtrIq
         UzNA==
X-Forwarded-Encrypted: i=1; AJvYcCWnaNC05RDsJFF1beR114/h8rWJ0sby3a6LbeZr+4epT0ra49QwRHBDXKrfzuBl2XPy7xh2aQk5sd/v2mY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWNBigiuiQK4pcLPJCYnqyGZ/9wP7dz0Hp4/yyq82VGNClY6FP
	MouWoWPRodxpUlvP4NaBsWljKvBEFnOOxqQozg35LqPg/FfAEMqqpqV2
X-Gm-Gg: ASbGnctqv7BpPo258yk1VILkU2r1mOIiCkVLyyeGxkQ6YHSXdFueQe3n/EYR1q/88O7
	lpC3T9NVCld6nQ9GhjDgBikb2A8fnXkMMO7n9sq7QUs6xmk43O1OO2s5NYZY6cBn4zXPJeGF+z6
	5DcKfY+qGlXIeOVrB8ZfOuPlbSY/R218hsd9beBFRXmhTzMgdyF8a/oAanG5my+JZ6h86nnPFjm
	Pxt/4NeldZUvwqutL2gRc0/VP58vfmDbn/58CtL/87xFWy7nSru7P0l/NVJV37D0V1rp6MBFUEG
	H9meKgKdCyaxAgj/7950bQXBFBn8WJhTY65WW19xhZ8zMwI8vuY3i7VG4eXASesOF0orM4A/t+X
	iv0XYUR74hQytyFhCRGwbD5YC0RZxCgpCaf8Txzg/E28PNhOPFkrZC9O5/bRqWMWHKMQEswSeF0
	DSku39lFNie1tMbSvJ7CHzGciJ9XqOM0y8+r/SD29Fefttjte5I68A2V99t2oYFnEw/MtJIKk=
X-Google-Smtp-Source: AGHT+IFxF/iIFAzHknsywdTtIa6UpsxTE/jVAyMQAFSxtFD6VyWI1a9ctJ+afJ70siiRJJLy10m6Fg==
X-Received: by 2002:a05:600c:5295:b0:46d:3a07:73cd with SMTP id 5b1f17b1804b1-4773087258fmr5929595e9.23.1761847097921;
        Thu, 30 Oct 2025 10:58:17 -0700 (PDT)
Received: from biju.lan (host86-162-200-138.range86-162.btcentralplus.com. [86.162.200.138])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4772f53aad6sm15098055e9.13.2025.10.30.10.58.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 10:58:17 -0700 (PDT)
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
Subject: [PATCH v2 07/13] serial: sh-sci: Add RSCI_PORT_{SCI,SCIF} port IDs
Date: Thu, 30 Oct 2025 17:57:55 +0000
Message-ID: <20251030175811.607137-8-biju.das.jz@bp.renesas.com>
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

RZ/G3E RSCI tx/rx supports both FIFO and non-FIFO mode. It has 32-stage
FIFO. Add RSCI_PORT_SCI port ID for non-FIFO mode and RSCI_PORT_SCIF port
ID for FIFO mode. Update the rx_trigger for both these modes.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v1->v2:
 * No change.
---
 drivers/tty/serial/sh-sci-common.h | 2 ++
 drivers/tty/serial/sh-sci.c        | 3 +++
 2 files changed, 5 insertions(+)

diff --git a/drivers/tty/serial/sh-sci-common.h b/drivers/tty/serial/sh-sci-common.h
index bcdb41ddc15d..ef1d94ae8b5c 100644
--- a/drivers/tty/serial/sh-sci-common.h
+++ b/drivers/tty/serial/sh-sci-common.h
@@ -8,6 +8,8 @@
 /* Private port IDs */
 enum SCI_PORT_TYPE {
 	SCI_PORT_RSCI = BIT(7) | 0,
+	RSCI_PORT_SCI = BIT(7) | 1,
+	RSCI_PORT_SCIF = BIT(7) | 2,
 };
 
 enum SCI_CLKS {
diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index d07424caeeab..6f396e1151d8 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -3149,6 +3149,9 @@ static int sci_init_single(struct platform_device *dev,
 	case SCI_PORT_RSCI:
 		sci_port->rx_trigger = 15;
 		break;
+	case RSCI_PORT_SCIF:
+		sci_port->rx_trigger = 32;
+		break;
 	default:
 		sci_port->rx_trigger = 1;
 		break;
-- 
2.43.0


