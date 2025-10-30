Return-Path: <linux-kernel+bounces-878867-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C59FC219EA
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 19:01:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id CEF50350476
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 18:01:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1337380863;
	Thu, 30 Oct 2025 17:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KHk3RpWK"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 363CC37DBC1
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 17:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761847103; cv=none; b=qRghcTJxZKywitNLrW59jnSqKVtGqQEr6n4YDzjOy8CAddEN9LjSYHtkss1DhjomxPY8EXjWDX9qPH8walh4wJ4sjYZ1lnefI6TiO7PziiQu022fDVrVzP8o72OY+TC2o1XmgyBhWBiz/xtr6H4GUA9Vq7AX2uenlRCWzI4F1A4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761847103; c=relaxed/simple;
	bh=FUUpdN5VqPaa0AglNAM37NGlXaHlU8F1s0H5S0bhfxo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RYspIev4BPZHOMbZ4mOwUkn2kp3761c+eHzQ+4fNWO8MgIZJF9PJDgIIawVkFVcpKr9O3mS6cddlEhc3ZuWPLTdZWii7CR0bPYz61BgFCerpvc5PKOLrznrBV9RHtj+JvpLUbydQ+g+mlVq9Wjv31rBJzCwyPZ5yEBqgw9fpbAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KHk3RpWK; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-471b80b994bso17423745e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 10:58:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761847099; x=1762451899; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qx09GhYIQEqgtyHYb9x3QHdYCDiDGK8KkivjnJ7GUsM=;
        b=KHk3RpWK07Tx5yE+KFd36Erln8/MJ5GLnQUmV/VepNXLQltC6ou5pNnkrpjSqeSg9l
         rFsNAhnluyEz9/5Mhzrs9tC5s2FvRvVjcB6litomKpG5Iiivebtq3al07fOri/hs2Vvq
         9CUPgEqk71JIw/mqABJ8Gp1qPKannJk3QgHh1Qn6UKB56I1dfVzA4c34RO62bjk5u3Hp
         xl17l6lq/bygbBGxYMeAjlRTRVJ9WZIlhPRxW5RdXmQQXBetmPHqJ5+QOzTDS6f9CEvi
         gXK6750S1CPJgy6JJD67zBUFTcuz4vhhuIzih9DaElLeww9TLWXyN7Zq8MHJnS9PDBtQ
         /L2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761847099; x=1762451899;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qx09GhYIQEqgtyHYb9x3QHdYCDiDGK8KkivjnJ7GUsM=;
        b=wvN4/lltoYVbbsOqV3sKAarjAwwhTPq8sxVyEJlsYJ6zmh7IrDyX8wNTjeLyKZpi0G
         TGbxknih2XNWJZDNeQnaNMZQ1PfT2lC6DcdBwxVQs9+LnlxwUE18gCjRqOE9jvPTnMRR
         yDw4+T07mgdB3GPdCXWopwNDDEmqVMD6bzKq2EBwEVvKUA9w339MfR6oWz0krz10/46X
         AcjWNo+KPQfVxeV79ubTzYyYNMuYctFjvEbyn55ZKnHunKTZHGlrwxh/L7VxbzUQtvfy
         1xR6fy8wqFZSg3e1bFq9/YrTlseb/B/KwhrVX774yzxcN3PhxpJHPMaM5JfsMat/HPK6
         m4JA==
X-Forwarded-Encrypted: i=1; AJvYcCXZJC+QAK06nJXNNnsXXZOCI17dgV9MBOSpOn3xyDjcapLb1q9kVcZScI1o1l3WKRGhxaDezV2C0zmrHRY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvnJNy4MhH9nlNSiXY2xE7C3v/Ib5cvgfo5NzLzh9wqaum15hL
	F0woIcUcbucmIHiyHwaw39HDesWQPSZIjEFLVqChKFIAoxWLku0CNvzh
X-Gm-Gg: ASbGncswtZF0SnF3UrgAhd7iGmnjA3BxgV8Qjvd/pXWaB0YKd21lHSCVRf6tg/cKgP5
	n44aX/7KlfZMT3JODGLVMjTP6axfBMQ0JMZJU1wkU0geyGfrXInhZzWvlK1fY9aZOYFd6SdUssx
	Qb2E0/yy4PGnTKhhGmmSibMzkF2TQ8z2ZgnRWFanQZpiFLPpKLXtFst8TiYeCDy2g1Dhb59RbaI
	dbcAPwDMvgz2/9TZJhbqYmy6Sf3yi0MdNoTIiadOJzC22yeh6og1jyYGr91mWPsYwy0+b3na9lA
	OydSMaQn8QXBh3SpeoHDtolZtOJV23otKuNbua8IgkI4pDRI4bBqEMopP8JDOkHpV2jriDPq0b+
	HCQNgKySPi8jrvBgtoo+1dd7YwSVDO4hcrpy/iXnYSL/eLJQMcUSDIWttFj8RNiussbUz1TuZ/c
	48vtvgsssp9yrxh3B/dAXVUvREmg3BnS0qwxT0oItQa3CN6fRZlTNd34LMMPye5ZeTVVu31TA=
X-Google-Smtp-Source: AGHT+IEM7c5w5v0aGKFjPUDUh4EvuTkOKmjFdioWbv9NSqY6m/OatijGxXMTlQm1Adm4IZf0xwqM/w==
X-Received: by 2002:a05:600c:1c93:b0:477:58:7cf4 with SMTP id 5b1f17b1804b1-47730794401mr6582545e9.4.1761847099337;
        Thu, 30 Oct 2025 10:58:19 -0700 (PDT)
Received: from biju.lan (host86-162-200-138.range86-162.btcentralplus.com. [86.162.200.138])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4772f53aad6sm15098055e9.13.2025.10.30.10.58.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 10:58:19 -0700 (PDT)
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
Date: Thu, 30 Oct 2025 17:57:58 +0000
Message-ID: <20251030175811.607137-11-biju.das.jz@bp.renesas.com>
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


