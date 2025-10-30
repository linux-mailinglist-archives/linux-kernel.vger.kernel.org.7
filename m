Return-Path: <linux-kernel+bounces-878851-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A1DF1C219A8
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 18:59:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 083BE4EF3DA
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 17:57:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CF0037DBCA;
	Thu, 30 Oct 2025 17:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Swqnbqey"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A54936CA99
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 17:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761846940; cv=none; b=gGVj7azeANziyzMIJHnkWMWrrouGJJJq2VSLJmPEfTfYtr2yXkQ/U1TMDxkoho7+ksuu/3ARKQa1E1of3KX23ymtPwotvkHd42nBmNKmns9zRy1CU+ZmMdgperdlNsyp8jzrg7Lvor71zcXz8nTyEBIqNWU7KLdk0dTJtbpRypk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761846940; c=relaxed/simple;
	bh=ZVr695PrkjlsTLaO5UZFDg6DGUr1VgaEBsWlk7XU+bM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uPtjgjwRcvigL6fpN5lUE3UB8bgnISKGSUnc2uRhj/qIcqlRjHWXB7Bi35YC8aq6lyy5dxsVi98/3XVno+jy9I6+fnFRJvNu7gOxjD7ZaunXfMipNdk/G6HCnizdCYnHG2c0MtDs55FH+fBKNCARpfPGGGmOZy+BopWnTn3pynQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Swqnbqey; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-421851bca51so1210680f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 10:55:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761846934; x=1762451734; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MfbjD1RYHWgoO0jG0DLqriHMmFx1f2scKAXhmIYvONA=;
        b=Swqnbqey01kzoa1XCsgBJ96Ik0fRiuVDcnRfuMz8alz7WDm54NY3dzBwjkElt0srJI
         /HLCcmFPd3QN5j4M/BLm1ABFjPqtpAQcMW0LweGKjOTbsQXHgGbxEkcVmJIRN8CEp+LH
         QELc3ux58kIV0x//taAH9Ycmll+cuMKGkuFQXaIg+QLzIvaj8JRaWF/8yIl8Ez1GWEV3
         wO5i566uyZMpYYh4JcYUtxZ/CK8Z5G2tIyBbyaTcV/OV7JsrojxWrsFTngbgtjVspjWZ
         1ErfRY/pSOvrcVVPbKlLIhoKK12Apf4ENW9VhxguusPVyrZxfj3+3upqYVY2hxh4rHqM
         G4eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761846934; x=1762451734;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MfbjD1RYHWgoO0jG0DLqriHMmFx1f2scKAXhmIYvONA=;
        b=qQGtNFrfSxgxg8Nso6ALyZ7knHfdQcBniVGjyhWFnB5x9zlfJDbkDvLE45VUbVRPjv
         G9O8O5Gog7FE2ewyQXxuddyS4NJuCojRiNj+GqSD8gUWkPjqrs53B3SLY3D2N6hU1el1
         i2Lu7Sv5oWCCedZJcNphkXDkoYbDFlp/mB1vszDbHsj7O0LghP5jWL2GOhsqXNSfyqHn
         BqZ9avPPrpkaBKWGCxlfdLZswsMJ7xhpyfZh4oFjA+XpwRuu4Vhhh5Ve27tlhLNAJZgz
         i47sYdI1YYdyK2AJ2Yccq3bqoVt7Yed22jn+gS0pGeBPMJql78/w6UvBn0zoCvLB0Pwn
         P/Fw==
X-Forwarded-Encrypted: i=1; AJvYcCWkNnT5ssNYJmuPdeOEj2eeKjZmm/okjPk59bU1flysbX4OmRDLeD2tG7BoWgXTV7387No32iLko61Q4tw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbVbDF6WzLIb6EdpoELKAQjoXTuHEodweeoc8YbpBtPJPJ1sXw
	og0BC62DVZN/wF4+yViDl/0x2nQV59S3+B3HZorA+Qj2U+YGf4MO1JKL
X-Gm-Gg: ASbGncvcyMe8tRE1H1z1XzvSYoyeUwjs6ug7ZnBnLWXv1qvP9+85TTfYG85I3q13xeF
	luKJeNmbJcSOnlRrzq+2ZPJ8wYKQOV8X8ZGa6QdguYBrTcI6SuygndaCNZTsxybZx3pmP3mRwu/
	isa/APtScoErlSBbuZENlCwGNqP6pNae0pbZVsty/0lxgFohsdh9GfiODqkX4rPweVjYildldQy
	wTe2MAyxGgBoZksALmV++O+Rn8ERR6kIc7nPi8Unhwd/czpqlchaw92VXi8xCw6yTTtAe8y0OS/
	fpnx+dwt0lijMCD3GmkGnc6/UhXmEm6w4M21TBfq4SV65OK9KbrGdTFHof7zvpilYeGAQ37wZ6a
	DZkwaFHmhcjnmTu5j429oUDlv6SXTcE+PBwl2Rvs7D8QJV74YTKZxHlSMJnxMqBhNyfx+xrkFbJ
	EU63/Mg1fd1BcNgFkVhV2FSTSB3JxEmPzJdG9sJSgoPyBt50s8okLV6AR+Cci3eTkcSS7ohGsZw
	JoMC+nARQ==
X-Google-Smtp-Source: AGHT+IE3z5lAmhGoh5d4Yy4K8o1VX+Hl6Sh/SAktovTtRK5y2To4h3DqtSkPbGR9LE39NISIviPJxA==
X-Received: by 2002:a05:6000:2207:b0:429:7693:884f with SMTP id ffacd0b85a97d-429bd6725bbmr488929f8f.5.1761846934316;
        Thu, 30 Oct 2025 10:55:34 -0700 (PDT)
Received: from biju.lan (host86-162-200-138.range86-162.btcentralplus.com. [86.162.200.138])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429952de5f9sm33384041f8f.38.2025.10.30.10.55.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 10:55:34 -0700 (PDT)
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
Date: Thu, 30 Oct 2025 17:55:15 +0000
Message-ID: <20251030175526.607006-12-biju.das.jz@bp.renesas.com>
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


