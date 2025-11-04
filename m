Return-Path: <linux-kernel+bounces-884629-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 66B9EC309CB
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 11:55:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD39518838B0
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 10:55:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A1E22D7DDC;
	Tue,  4 Nov 2025 10:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="KgD/oN9w"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6CD319F40A
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 10:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762253701; cv=none; b=GUbGT4TBrXRCXDukMBdtQjhY/3G5815b+PUoXE2I8oVz9ox184QGNkwPjqoF5n/AV8phavF1Z29KVl69w7jCKow5r+4OazUqT5joAG2zpividOtgj7JsFH6c8YtUVC4nj+35btXULeLQFDpxhCHT+DyqS7u0MsIu7RROwgKDJWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762253701; c=relaxed/simple;
	bh=R1jeV3wiv8DXKujJVS3YRokbucemxRcp2L9aU/+ZO2A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uTN6kukXe+xzt7r4NFdAed/A4wnjMlbWpBqers1DgVFm/jUgr3FXeXH5u06tZSXu3duMu7bZfw6nQY6bYEzvpkl5bvEmEhvpY58gbCO91h4rUCsWLa0gtoFkISLNnALCRTU3ldIEhx5NfB7Wb7t9e2s5Q+8RI4NAoKDKZO/XM5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=KgD/oN9w; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b3b27b50090so832062566b.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 02:54:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762253698; x=1762858498; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=h68+BzrgDoWnKcF5o/ojKkTPKX3UizaTNvfX1EgB8Ec=;
        b=KgD/oN9wnLB688glrZk0raXjwK+UyQBMBVNFeNjb1sg2zB7iVlEe5UafQ5Gbi0lNCk
         OE+Bxfa2l9XjZ2ayQBe3LZZFrOggrMJ4pSVGB3OeyYlWEd8fmIeAS5Drup+YLWB22T53
         GQbA5E09/Emi8980QyyeGv8ahduJwEykJxYEUAQX14FzH0x5le5JfOkqreE/QOLGu0r3
         kgMJyOK2iGdmcw/MQsOfR/99OXElPDDUlNt3kpGg1iEiwiReG+uj17aDGywz6ooh8sJy
         UNUcr3ihLg0jrX80lhDt1Lahkc/+w6nigZi0fTCZ84NoxqqcXLVqGYD+pvXTtE+sldwx
         Bu1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762253698; x=1762858498;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h68+BzrgDoWnKcF5o/ojKkTPKX3UizaTNvfX1EgB8Ec=;
        b=HRsZzo6AD4mdxVtVS46iD2uC5rKwXZPgfEVq4FVmNxIg3wyNl0cFT3VkNvQm3lKQOL
         sm1ew5JGGExP9HHAgs3rkPfLCpMsYHWT8E7FGm4lvK6Cnqzwb/q8RTVS7544mzIIBW0E
         fqKjshesKAKImZaZT2a5q2vz2WmbSHZLsB6mLbr8r5IWxEo9Ska32/LX9h2Iawz88Bts
         Ku0B5LH7cmkud5y2k73DFMr2PD5CxLAHBPmCN3RCBgfbAVrij5POggyCJuEiqtrFW2ze
         REieuH3y25ietxpQYxWj5dkNQ0a/30X6KtV/bE0iY0gT6sELGXTk+UWLIRD6cz1vY9o/
         vdvw==
X-Gm-Message-State: AOJu0Yxvi+hOa++H3udgXdE+2ixTTFoz/ixjKhiorvZGk/abpPXyDNLc
	BTjbnUZxIYfGToMR4tqOPeFbbXBTtty0ArXT0JaLrq5AO+HeK9X7U5fzzocsJ73wkwcVtYrMKmc
	nTN0e
X-Gm-Gg: ASbGncvA/XCDtliETfzEt/OgQTNbVRXWXK87pmrHtb53vZtgL/Q8xDKMjeOatsnZ/nB
	PmIHTmWptgVdo2qPLzsWZko8mZ3R5tQHz4Z4MF5sBcKiwS9is2yzHSIEQPwpMiC24+2i8jpdeYU
	jFexXMu4cUKEjR6Sr/zQX2DziUsGsUbNt//Q77L4WM5+OBnkY1cXwv8wEVYbiG846qauRF6wd79
	l1hXdKnC4eQ5ronYVM1ccfND0Gpmj4mSaiEC0BqCn+UlHE1XdTJ77ggAhXIGrax24vO2ZieJFu1
	2xAdJGHMfQhVE3JEDTa23PabrAis3OT6zfKFvDUTV8dCh3BljRuyAHO1UNnaGnmDptILyHFcBcU
	kwYTfNfsYwTPiWr8uEhpkFHPiVZ2/zvMOTL6vh00SD1MizPRjbTDQJv712HRllu7Dw1mo9sUdEC
	5uvxU30Zy1rGtLGA==
X-Google-Smtp-Source: AGHT+IHfPN6V1Gb0/vnW2BNSqlXyl8GiEmiehj7J7xXiDDPdmxVdlwQ2TmXH/z4ECTJFaHlBm/ipbw==
X-Received: by 2002:a17:907:7256:b0:b72:5983:db20 with SMTP id a640c23a62f3a-b725983dfdamr87995466b.32.1762253698012;
        Tue, 04 Nov 2025 02:54:58 -0800 (PST)
Received: from linux ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b723d3a3d4asm180927566b.2.2025.11.04.02.54.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 02:54:57 -0800 (PST)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Subject: [PATCH] tty: replace use of system_unbound_wq with system_dfl_wq
Date: Tue,  4 Nov 2025 11:54:46 +0100
Message-ID: <20251104105446.110884-1-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently if a user enqueue a work item using schedule_delayed_work() the
used wq is "system_wq" (per-cpu wq) while queue_delayed_work() use
WORK_CPU_UNBOUND (used when a cpu is not specified). The same applies to
schedule_work() that is using system_wq and queue_work(), that makes use
again of WORK_CPU_UNBOUND.

This lack of consistentcy cannot be addressed without refactoring the API.

This patch continues the effort to refactor worqueue APIs, which has begun
with the change introducing new workqueues and a new alloc_workqueue flag:

commit 128ea9f6ccfb ("workqueue: Add system_percpu_wq and system_dfl_wq")
commit 930c2ea566af ("workqueue: Add new WQ_PERCPU flag")

system_dfl_wq should be the default workqueue so as not to enforce
locality constraints for random work whenever it's not required.

The old system_unbound_wq will be kept for a few release cycles.

Suggested-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
---
 drivers/tty/serial/8250/8250_dw.c | 4 ++--
 drivers/tty/tty_buffer.c          | 8 ++++----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
index 710ae4d40aec..27af83f0ff46 100644
--- a/drivers/tty/serial/8250/8250_dw.c
+++ b/drivers/tty/serial/8250/8250_dw.c
@@ -361,7 +361,7 @@ static int dw8250_clk_notifier_cb(struct notifier_block *nb,
 	 * deferred event handling complication.
 	 */
 	if (event == POST_RATE_CHANGE) {
-		queue_work(system_unbound_wq, &d->clk_work);
+		queue_work(system_dfl_wq, &d->clk_work);
 		return NOTIFY_OK;
 	}
 
@@ -680,7 +680,7 @@ static int dw8250_probe(struct platform_device *pdev)
 		err = clk_notifier_register(data->clk, &data->clk_notifier);
 		if (err)
 			return dev_err_probe(dev, err, "Failed to set the clock notifier\n");
-		queue_work(system_unbound_wq, &data->clk_work);
+		queue_work(system_dfl_wq, &data->clk_work);
 	}
 
 	platform_set_drvdata(pdev, data);
diff --git a/drivers/tty/tty_buffer.c b/drivers/tty/tty_buffer.c
index 67271fc0b223..1a5673acd9b1 100644
--- a/drivers/tty/tty_buffer.c
+++ b/drivers/tty/tty_buffer.c
@@ -76,7 +76,7 @@ void tty_buffer_unlock_exclusive(struct tty_port *port)
 	mutex_unlock(&buf->lock);
 
 	if (restart)
-		queue_work(system_unbound_wq, &buf->work);
+		queue_work(system_dfl_wq, &buf->work);
 }
 EXPORT_SYMBOL_GPL(tty_buffer_unlock_exclusive);
 
@@ -530,7 +530,7 @@ void tty_flip_buffer_push(struct tty_port *port)
 	struct tty_bufhead *buf = &port->buf;
 
 	tty_flip_buffer_commit(buf->tail);
-	queue_work(system_unbound_wq, &buf->work);
+	queue_work(system_dfl_wq, &buf->work);
 }
 EXPORT_SYMBOL(tty_flip_buffer_push);
 
@@ -560,7 +560,7 @@ int tty_insert_flip_string_and_push_buffer(struct tty_port *port,
 		tty_flip_buffer_commit(buf->tail);
 	spin_unlock_irqrestore(&port->lock, flags);
 
-	queue_work(system_unbound_wq, &buf->work);
+	queue_work(system_dfl_wq, &buf->work);
 
 	return size;
 }
@@ -613,7 +613,7 @@ void tty_buffer_set_lock_subclass(struct tty_port *port)
 
 bool tty_buffer_restart_work(struct tty_port *port)
 {
-	return queue_work(system_unbound_wq, &port->buf.work);
+	return queue_work(system_dfl_wq, &port->buf.work);
 }
 
 bool tty_buffer_cancel_work(struct tty_port *port)
-- 
2.51.1


