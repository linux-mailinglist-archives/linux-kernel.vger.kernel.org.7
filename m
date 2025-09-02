Return-Path: <linux-kernel+bounces-797196-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CA17B40D3B
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 20:34:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 190705E2BEE
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 18:34:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0D6D34DCEF;
	Tue,  2 Sep 2025 18:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="gcNLQJU7"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05CC6350823
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 18:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756838061; cv=none; b=T6HaQYP1ZtT7Yu+CE19Q7IhcCB9mHys+1bky1wdu/g/OvI81jM6vy+vOHLp8mNtpdG/M2ChONvlaw28oHYgStLfRyLVECfo45UOPyvBW7U64nyCZfXhri21P9BkDEt0ht9ka+msBB7dJPh4nAnd3Re4iFjQHWZ36iThHeQ81Y8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756838061; c=relaxed/simple;
	bh=r5/WzNLFvBizJNQfa0Ilg++26fG8AY3qSmOM5PSpOPE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cDeEvg7Lp0kXf2q+0BY55Am0wSWfl91ZF5FNZlr1kLTtkjdG2KZQ9yk8TXp+loyiTLknawMbizsHzXC4PHyDE8Q6ZIMo31nljfgLPfakfde/ri6uwCGYjtjBrBWsFqf+xp41WV6v6HBamhv2j7XMCKUAQ6zfHeVGb2Ag/cKkW/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=gcNLQJU7; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3d17f24d42fso2464280f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 11:34:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1756838057; x=1757442857; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WnHal8GQDAKujAP+BdXrilvKsGown9cJN4bGYLKXHLw=;
        b=gcNLQJU7p3P1/fyT8VDWAkCfqJgC31c+pgJqVjTrgnFIrWMrV8+O0C/BH62NptKKwo
         2cne7ndHuJ2JkFtTUHBe771WobZ2doHifgdMpVttSTxz4PA95DRUiEHN64Xbvnm/OwHb
         yxfHyIIJ5XIXNodWXCJ9cb7ERm8mIKMh8t1fNjpfppEa+AuX1BWgOxBT2bSygUbE/GKz
         598eJY7WHNPk9FExhdiCQQpH6EJpk0IBuUnq9OiLq3jGSBr8rOKgXtiHUfmA2wg4Guke
         z3nGxnlBHY7GPNBni4Z45CTZP7yeiwaVm9QxFWUW+D6HnMmwSIKTwxB5Zt7iKZZjfUiO
         FgMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756838057; x=1757442857;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WnHal8GQDAKujAP+BdXrilvKsGown9cJN4bGYLKXHLw=;
        b=dVKD3AYoOY+IWyvoGnxCCpYv+oko1k2Ml5zmLtwe1stXuOyLYnf4U020r8snMvtinv
         vhM4FnonmzcXfsT2A7HqPUaLiLdMVTNg6tUcasgj0E3FNYPso75FDJ5cOb/ja0R8ljVF
         cexvwVhZ5ktZEA36jVvRBOWw9Y+n0H1vuTZ4Hov6tM8r7DcVccc76Yu+zegh9xLHQrhV
         +lXHMWFQTirNCbwrIqv1OB8Knf0GTJYPPyHc4iYbRtMzpJhJi+gPiN8CmMCefpAoeeZD
         BtzxA5Ie+LZVNTC/J2AuAp2Ec8kHCZp3YBj2z6WnVwQ7LsRNCPbTjPTBGKCSg+xMIvwK
         qmHw==
X-Gm-Message-State: AOJu0Yz+oxxOff1+RBwm96h+0jeVWNghS8dzUF8541XqvLl9kNq42yBb
	/cSjT9qB2Otc7qpahHG7MINTWPbsqi0TxUujSIH7iveGQWF5mg/69wJYaYJYPKYPjYPpe0n4szT
	HgU/A11I=
X-Gm-Gg: ASbGncubU3G8XbUNVGFUWSVWhv8Q8W8J2zs+C9Q2UcHhKhn7QWhQBDTLIjc+XoXGXGX
	m/H2aG+8A7RUt28jZ4YLThZ1yiP42sr6eOCD83bT7i1tcrAab4VWU2Fv+BIrdmI2noTJJmKUk0P
	QwqQehG4n9F6uYJN+EY1GlfwlN5d0ZeIeNsRvQjMXBaI5rGq88c+qKuL2xK6u6OPYPJmGFJyK5c
	avOpOqTjJWT4dYYHtOmLzYOeQltzAj+voMIAr3C16f1DnvqriqQdovllY3tx8sISgl7EYk5l4En
	4GPgS3mvtZAY6VDam1D7dy6PyjpIjy51gzad1CQ8v1EALG39fuhMj3fU4K6M3C/izl9Pe0XcYEZ
	yD6AOOLT8qaLhbKWKX6E=
X-Google-Smtp-Source: AGHT+IFBPkGpH7OCUHfHFF8d+acmdhzJ29lI4BjvBzLTfWRbfPTbQPxmr3Hnz/k/wLvWCf/I5Td6iQ==
X-Received: by 2002:a05:6000:2893:b0:3d3:8711:d951 with SMTP id ffacd0b85a97d-3d38711dd3emr9891835f8f.45.1756838057231;
        Tue, 02 Sep 2025 11:34:17 -0700 (PDT)
Received: from [127.0.0.1] ([2804:5078:9a0:f000:58f2:fc97:371f:2])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7722a4e1d4fsm14028477b3a.73.2025.09.02.11.34.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 11:34:16 -0700 (PDT)
From: Marcos Paulo de Souza <mpdesouza@suse.com>
Date: Tue, 02 Sep 2025 15:33:54 -0300
Subject: [PATCH v3 3/4] printk: nbcon: Allow KDB to acquire the NBCON
 context
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250902-nbcon-kgdboc-v3-3-cd30a8106f1c@suse.com>
References: <20250902-nbcon-kgdboc-v3-0-cd30a8106f1c@suse.com>
In-Reply-To: <20250902-nbcon-kgdboc-v3-0-cd30a8106f1c@suse.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Petr Mladek <pmladek@suse.com>, Steven Rostedt <rostedt@goodmis.org>, 
 John Ogness <john.ogness@linutronix.de>, 
 Sergey Senozhatsky <senozhatsky@chromium.org>, 
 Jason Wessel <jason.wessel@windriver.com>, 
 Daniel Thompson <danielt@kernel.org>, 
 Douglas Anderson <dianders@chromium.org>
Cc: linux-kernel@vger.kernel.org, kgdb-bugreport@lists.sourceforge.net, 
 Marcos Paulo de Souza <mpdesouza@suse.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756838042; l=1914;
 i=mpdesouza@suse.com; s=20231031; h=from:subject:message-id;
 bh=r5/WzNLFvBizJNQfa0Ilg++26fG8AY3qSmOM5PSpOPE=;
 b=W+qjsg4lnlTEWWbLzvCQWRhvM5FtpC60RWrOTzt57hm8vTwi/RkTlKIRi1iUPtvsE27C2RkYu
 r8Lc+i/hR5WC9g+1cDvixfxUaqC8+aWCE/HBdWdc/k+JE3Xklx1gUQz
X-Developer-Key: i=mpdesouza@suse.com; a=ed25519;
 pk=/Ni/TsKkr69EOmdZXkp1Q/BlzDonbOBRsfPa18ySIwU=

KDB can interrupt any console to execute the "mirrored printing" at any
time, so add an exception to nbcon_context_try_acquire_direct to allow
to get the context if the current CPU is the same as kdb_printf_cpu.

This change will be necessary for the next patch, which fixes
kdb_msg_write to work with NBCON consoles by calling ->write_atomic on
such consoles. But to print it first needs to acquire the ownership of
the console, so nbcon_context_try_acquire_direct is fixed here.

Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
---
 kernel/printk/nbcon.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/printk/nbcon.c b/kernel/printk/nbcon.c
index ff218e95a505fd10521c2c4dfb00ad5ec5773953..352235a0eb4a484caccf86d3a57d1a149218ecec 100644
--- a/kernel/printk/nbcon.c
+++ b/kernel/printk/nbcon.c
@@ -10,6 +10,7 @@
 #include <linux/export.h>
 #include <linux/init.h>
 #include <linux/irqflags.h>
+#include <linux/kdb.h>
 #include <linux/kthread.h>
 #include <linux/minmax.h>
 #include <linux/percpu.h>
@@ -247,6 +248,8 @@ static int nbcon_context_try_acquire_direct(struct nbcon_context *ctxt,
 		 * Panic does not imply that the console is owned. However,
 		 * since all non-panic CPUs are stopped during panic(), it
 		 * is safer to have them avoid gaining console ownership.
+		 * The only exception is if kdb is active, which may print
+		 * from multiple CPUs during a panic.
 		 *
 		 * If this acquire is a reacquire (and an unsafe takeover
 		 * has not previously occurred) then it is allowed to attempt
@@ -255,6 +258,7 @@ static int nbcon_context_try_acquire_direct(struct nbcon_context *ctxt,
 		 * interrupted by the panic CPU while printing.
 		 */
 		if (other_cpu_in_panic() &&
+		    READ_ONCE(kdb_printf_cpu) != raw_smp_processor_id() &&
 		    (!is_reacquire || cur->unsafe_takeover)) {
 			return -EPERM;
 		}

-- 
2.50.0


