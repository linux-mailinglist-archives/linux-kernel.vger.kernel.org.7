Return-Path: <linux-kernel+bounces-878863-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 45D7DC21A56
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 19:03:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AE59D4ED651
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 18:00:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D23EA37DBED;
	Thu, 30 Oct 2025 17:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JNewtzJo"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64266374AD2
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 17:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761847100; cv=none; b=q5DaW+tIcBxQ89Z5aO8HabqzSV357SDepBgUrP8WVr1YifGC3gtJ7ZZxs4V0eBgG7Xh7cjOtltDjR0/Rylg+gmef7kT4Q+zpKPyMFbgt5PPODEUtTjYQbeb5vnPf18b9lL1gdXb3TAHqWekmzTbNpMAsXAu6EnW6nhSUPtndEQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761847100; c=relaxed/simple;
	bh=KXgzGd6gNo09gi0VZSrUZARuDuGxlTCFI7gHi/TqNjw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IO3KuQfftyE+0apUk1wjrOs9FNhw+tF3wB+Wf+5beOftOEHMvqaAGxKPziGfvIz1bg13KBC1VEjP5T89GoYtS2CJfvZngea/6jWNU6Q25cx9GXX5Ie2PScNSNnlQNmVQssRDo9TKKYFvpUuyxUXOfbsZu9KMjtUS3VoQdQ4rHRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JNewtzJo; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-475dc0ed8aeso9496635e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 10:58:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761847096; x=1762451896; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NV2npGkfv500PmnI9y9LBiyb4UX94aZHfGA0F6aPZeM=;
        b=JNewtzJotfw5LiLe2JGXAzYyGpsH7UwUG91pj2aKigmiysVtMavQWQpawJwo3XGX0L
         tMnLVe0GSNO0WDB+RqVpPANzTp1xQbYk5B+Prr3SqU9hhZ5GyV+jczXyeO7NF8sA7Tj1
         tAk30mJMsnUxaIy/m7EsDHiWP7feEjCBUCooJ8VjPrZnrAJ0xapsuqHEL4L8RPP2OLGW
         hpKVnUPIk1VuGAuOD1b4Lei/4PqbD4ZP7kp+qdLymtXmnlz4Ox4gzExymDJkAqk0xrXe
         /l1kG2Mq+5OBQJkG3CKBzQgsZA9eN0unEO20Lc6P2q2cB4cf41RMxEJo9zPYgR69mnct
         J0Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761847096; x=1762451896;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NV2npGkfv500PmnI9y9LBiyb4UX94aZHfGA0F6aPZeM=;
        b=MyrzN9c2AYtMwnNNzJT99rUXWTyhG7ClxcxXew/SQVaerKnHpkF/M+YO76E1OwWGOr
         ZpD8KCjOI83Td/LZhBfMki7tTUWfasuSm5vlP6bz8CPJ/tdXrKdTdhOX7dtkRPOmTR6b
         zULvdryTekYpwkTAsBP+v+0YM3slYlCVQvjQ0z+HjMZnbz/dvxYzqBNHXO8+unN78NzJ
         x3axGKpC5iqvBe53PPGEkP3jSvQThA+B0mOu58Yzy8THSP4PGOFCISMpQ2zLl6FlekFE
         iB9Hz48hlLNwHuK4VrQ7HzpCR/sC0S42kNXOu428OTA7zpqgYBOGKBc5SnJntb+HaQBb
         7XcQ==
X-Forwarded-Encrypted: i=1; AJvYcCVlEN2Mr+3bHnhoVDaBNEf5YfK46K8qn7VmRRb6SgPJw6Uz6IsyFMev0xPIMdT8mueGsxQG1+OKGE3TM2A=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXlaJ7SUdW8DFhPfZxcvFLDuTiROnoLWvtdLrg5s67t8kzWqts
	C2lDPnx43CJ6omUmNKG8T+A2n3YT/JCLhXYU5Y37XojGQR4u192Vct1J
X-Gm-Gg: ASbGncsaPpwxl0IlMG4Px+/14tMPd2e5LvanIdAKpF7FrjlBo3WYCu9TpiVY0EWCCWJ
	5NxvrHRY2nOaqZAdsV/7/hoklfWcq1gErvTYuoWXyrZPjEFC+xaU2V3226uQawvRouz3Pbqjy0S
	UjFEnSCrzOPwth3by36TU1velBfKCQMbWhl5k0tHd1atO3/ZhV+3rXzIBhd7eQUe8BzLfPBzMsK
	ECuOkH1Gysa6leKajY+QO/XTEb41UdSZp2CkGUj+pBNw44v1gHx2BjxCBPrtnSNReoFiUIEmTq2
	XnVpFX1S8iIlzkonNGhJRO+BvXiUd31tUirOt3HXGT57J1/MO2RpGOd5JZdsvHB8Mt4asJKSPYd
	pojzcO+mCuBiipIFJkzTyODMg1x/kSdBn74/3mY1CInM8fBPw3ofIATl417rnGgq1QW/A7WhxSO
	OX8s9f9numBdqdechFxrAw9N87F39R6Yc7xbMIImY0kLAxPS3SbJc7iv2uvacjG3pdWDGxddY=
X-Google-Smtp-Source: AGHT+IEauFP+H4BtsTHNnwX2RMa6g7oaZopNNZdiBz+4pgcKwzPpZyX4Q4A5C/MiMwcUg284xoHAQA==
X-Received: by 2002:a05:600c:468e:b0:475:dd59:d8d8 with SMTP id 5b1f17b1804b1-47730793c2amr7516675e9.8.1761847096132;
        Thu, 30 Oct 2025 10:58:16 -0700 (PDT)
Received: from biju.lan (host86-162-200-138.range86-162.btcentralplus.com. [86.162.200.138])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4772f53aad6sm15098055e9.13.2025.10.30.10.58.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 10:58:15 -0700 (PDT)
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
Subject: [PATCH v2 04/13] serial: rsci: Drop unused macro DCR
Date: Thu, 30 Oct 2025 17:57:52 +0000
Message-ID: <20251030175811.607137-5-biju.das.jz@bp.renesas.com>
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

Drop unused macro DCR and its bit definition.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v1->v2:
 * No change.
---
 drivers/tty/serial/rsci.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/tty/serial/rsci.c b/drivers/tty/serial/rsci.c
index 504361ed5ecc..470b5701cd67 100644
--- a/drivers/tty/serial/rsci.c
+++ b/drivers/tty/serial/rsci.c
@@ -24,7 +24,6 @@ MODULE_IMPORT_NS("SH_SCI");
 #define CCR3	0x14
 #define CCR4	0x18
 #define FCR	0x24
-#define DCR	0x30
 #define CSR	0x48
 #define FRSR	0x50
 #define FTSR	0x54
@@ -119,8 +118,6 @@ MODULE_IMPORT_NS("SH_SCI");
 /* FFCLR (FIFO Flag CLear Register) */
 #define FFCLR_DRC		BIT(0)	/* DR Clear */
 
-#define DCR_DEPOL		BIT(0)
-
 static u32 rsci_serial_in(struct uart_port *p, int offset)
 {
 	return readl(p->membase + offset);
-- 
2.43.0


