Return-Path: <linux-kernel+bounces-878868-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 23FF6C21A98
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 19:06:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7176D4F4745
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 18:01:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2392380864;
	Thu, 30 Oct 2025 17:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="azfsx1pU"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECFF137DBCE
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 17:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761847104; cv=none; b=uYHQimv71KGP9tzKBv31Y4xIfErF9GXbfeKVqlCbuM163dwKt4tahy8LvGXHVJHVIDOQg8/AQLMJnuytUkx1VnkaJ4yUV58V7zMoxSfB+Rz8CzxwDru5h1XFk0gtzt9KMLTjVkfc2pcZKcBJcjh/RwTX+QBvPj7BtCrsHfIxixk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761847104; c=relaxed/simple;
	bh=ZVr695PrkjlsTLaO5UZFDg6DGUr1VgaEBsWlk7XU+bM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LYWXfYwVM5pYfc0ONXc+m8dFEg7V1Ug154OW2wD9pPiWZpn619dT0X8kDBBq8qA8S6Nk+sEYYJ2dDxehofkKKYeAiWM6uOpvzAafl/GEFFl51sm+/y3orh+eAsK6Uj1TGHyjRkI60M8dnaOOyf5rS8fDIl58Swn4mpsGaRMjbA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=azfsx1pU; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3ee64bc6b90so1123145f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 10:58:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761847100; x=1762451900; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MfbjD1RYHWgoO0jG0DLqriHMmFx1f2scKAXhmIYvONA=;
        b=azfsx1pUgFkTpN+3DH7falTpbwTn0N/KvJ6g8CC7E/3doS+qKR7yNqPpyogWr1QVE2
         iMsNPVBxARX1g3x63S0iX1GS2pusGQtkWWAQhcvjjkWjXM2i77OBe0wQqz9yHUYhzNkd
         Tc94/bq4+WT//uyIb1+tRf/r70lSOPWYnnmEJb1VSZA4DTbsdZBckHYAUTeeBpx5bV9U
         Y/7moIRtxksVby79yTngd8EHSQrMfGGBxVEwQoC3QveM4wpeP53UvEbQ+uKC4R0POPxj
         T7h3mF4LGFfH8Y4YduINwE4kDIuAC0bdqoCxSzDal+02OW0sE7OG+yMNZwEdFfXzu+8h
         VePg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761847100; x=1762451900;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MfbjD1RYHWgoO0jG0DLqriHMmFx1f2scKAXhmIYvONA=;
        b=Y7XDQm3rIAiuiialXJ/toDEUiqk1LNPzROBnsZTuk7Jcst3Ll+qudmfPoLNQX4ZnBW
         twkm2WoAP+9k6Shf5ffc9r2ozh4XC16MtbL1q6F0d3NEV+M9R7raHEaBjTowX++cBkYq
         a2DQ9z3vG/+IWzb2sZLgUAfwQLlySEj7DzcWNLvCxRdKwqmCyHyynWLgiuaesgi4cshj
         7EnUU2kwAAEI7Ik+qe4lxPHiQBB+8NHCvDt0ygTR6dOtl7MQh6mahre1mkunEyoadhx5
         FjoIL7OV2kh3t166a5hoEFoFHKNjHvV7oWnbbZPx80vj4IiPPCsu09Z2cHpLaFGaDqDr
         kTXQ==
X-Forwarded-Encrypted: i=1; AJvYcCWMQC0YFhN/vH7L5GPNJC4NPAD+cUguvcK+2yiEceQmvP/zcX+gaftKN3G2842b2Qp6AwQxTGWYV6U5xTY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRRlTRgYtsPsj3TbYq26upUn+S219NWShGRZogEgHEsqeEf9iv
	SJyugil3vH/85vX/FZ7voOJvzXek6efF7hDRubtzQG5abXRo92HScQfc
X-Gm-Gg: ASbGncu5Xrhy0MN1KWSxskWmNEUbONRy0ypLn5Ejdl/Ssz/L5lkxvuw60HPeZH+anDB
	ynHNjZvyRgfFNS7BoluWT7YI+3RieLWe4an1wPrTxaMC3WtP5v48x7W49F6YEIXil9RbOzi41vP
	Gfd2HBcVSl1oo6K+AUgQTbAXgsVfJXMVX+op+8GeqJHgwwu2a/0yWgz92W/F41UzVZwFEh22dbn
	ffXXzznUCYJ6pk/0KkiKW2wP9mPsiITEY9bnR1lLLMah5Zl5vvGbzblNBrpAeVZuOVKw5sWTB6E
	uIyH9fwhLA3VHnAzlVv0xOdDhee+KwCny4Q/vngAqSYA96MrCMbyFd1MKQfKN8Io+3/xUDf8idj
	SLh6RLn1dx1tltVR+NG4hS07gXnveiyrt//zMqCl4q70OOHMmwbsVTsCyGLpFV/esX1F0rLSNe4
	lKVo8XuvFtCzi9rIvkEzmmDAnzqWvhCbBlNS/ilJmSKf2RbTZwE5CuJH+Ksi1OlbqPf7gA77g=
X-Google-Smtp-Source: AGHT+IHuRhTGUiR2NIlai1bZW5SqOJBWIIwWKnWsf40J77cS2AzqDsRE/KFfqvOf5LEZ0cNzAruVbA==
X-Received: by 2002:a05:6000:1ac8:b0:3ea:bccc:2a2c with SMTP id ffacd0b85a97d-429bd6726a2mr523089f8f.11.1761847099845;
        Thu, 30 Oct 2025 10:58:19 -0700 (PDT)
Received: from biju.lan (host86-162-200-138.range86-162.btcentralplus.com. [86.162.200.138])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4772f53aad6sm15098055e9.13.2025.10.30.10.58.19
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
Subject: [PATCH v2 11/13] serial: sh-sci: Add finish_console_write() callback
Date: Thu, 30 Oct 2025 17:57:59 +0000
Message-ID: <20251030175811.607137-12-biju.das.jz@bp.renesas.com>
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

Add finish_console_write() callback as RZ/G3E RSCI IP needs special
handling compared to other SoCs.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v1->v2:
 * No change.
---
 drivers/tty/serial/sh-sci-common.h | 1 +
 drivers/tty/serial/sh-sci.c        | 5 ++++-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/sh-sci-common.h b/drivers/tty/serial/sh-sci-common.h
index a3f4a76cdecb..2e97aad390d9 100644
--- a/drivers/tty/serial/sh-sci-common.h
+++ b/drivers/tty/serial/sh-sci-common.h
@@ -95,6 +95,7 @@ struct sci_port_ops {
 	void (*shutdown_complete)(struct uart_port *port);
 
 	void (*prepare_console_write)(struct uart_port *port, u32 ctrl);
+	void (*finish_console_write)(struct uart_port *port, u32 ctrl);
 	void (*console_save)(struct uart_port *port);
 	void (*console_restore)(struct uart_port *port);
 	size_t (*suspend_regs_size)(void);
diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index ca4915c1e2e6..fac83dace27c 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -3259,7 +3259,10 @@ static void serial_console_write(struct console *co, const char *s,
 		cpu_relax();
 
 	/* restore the SCSCR */
-	sci_port->ops->write_reg(port, regs->control, ctrl);
+	if (sci_port->ops->finish_console_write)
+		sci_port->ops->finish_console_write(port, ctrl);
+	else
+		sci_port->ops->write_reg(port, regs->control, ctrl);
 
 	if (locked)
 		uart_port_unlock_irqrestore(port, flags);
-- 
2.43.0


