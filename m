Return-Path: <linux-kernel+bounces-856377-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F1C8BE400E
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 16:50:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 88357358D67
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 14:50:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BD4534DCCC;
	Thu, 16 Oct 2025 14:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="G1FVdEjE"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B799534BA4E
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 14:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760626112; cv=none; b=OfCFplgutomL6vbSX3tVTsIKe8+XN70jD5Mt1LrKRl790p3KqwJpuULQeiYpfg96y9W/84Jo6nwoqEINuyNrz7+zFt5de0HoSlsxk851RwpH4yWmd3Qbfr7ew/VNlL/N6zfRvCORO2MFbs3cczPYcyp74XxVm8RQ+Tc/nBQq+P4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760626112; c=relaxed/simple;
	bh=Z9P5xcvbpTnJxeGz7KZPPikGSxpPD+xoc+k6to82yJA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eWO1F7otmdZYs1IdDKNCscf6pMZ6xI0gvcK+WHXR5/fDX0NRQ19G5jV5XYQ1pjlHBALgYSE8eceXZc12HDBnOY1D8UW+yDlMi27vUZA/j2RIcTB2Amn3TRqwjqZK6EvbqzTP3dt79AEN6vBppSrseTmhAwask5bOSTBuKvnApsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=G1FVdEjE; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-421851bcb25so485249f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 07:48:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1760626104; x=1761230904; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I0sO08yiEnLurERgKve9iMIdfZXEHm1ICclZZWjRlKY=;
        b=G1FVdEjEkDhixX2aMbwxR+YvoYYJZqanzS8Z6RQBzO+tNoKo5RUdR+sg0FINXe2AuS
         Y9llKXE9Vfz+MXVRxIM5rNkGHNyZ7/anS4t7VUMkh00+YAsaio9+qf+5lz79lf7FV1m6
         D37aCJU+YAnXFLnZV39COrtHvP6K6hXZMWevxurwo8041lyzsvQ71LU35Y3imGvDuyOK
         bvB8UbVfJx7vqqotphqfhZ3wVxgi1T+ygyDjdO6mQXLI1nnXiMI4LUaRP/XF+iOj2UrO
         p3lll3cl3vzwQ0qtSh0Vd7XyIZusO60qQBV4buDpaXWHP/BzW7R5HlkSNVTWkYDrwhrA
         yESg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760626104; x=1761230904;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I0sO08yiEnLurERgKve9iMIdfZXEHm1ICclZZWjRlKY=;
        b=TWYjoxEGeW+LJy9oam0PSZnAtJZ6Ca87nhhRqgcHJdXCWoGE/zVX2iaMklfBCAKkgO
         ABbq6DXa0f1T8KnI6PZ9e6+imRJim/1qE0Zc8ZS2r6H4Qn0HPw8squDVITRpntz9QD4v
         0xU5us/+L98f1v8pepRhXANWRyUcaGna8+TY3VJqmRw7OuUbT1FPM2jtIGbpTUGK8EF3
         Wr99AT+l5nh6RBN2pc9UG8AJcFfByWnFqtVQnhgGrJF78qN2NqHBo2rBtEDd1boj6Ncc
         qxWbmnVEU4q46IM1D0oSyoZrHlquVQUtGE/Gz5sowRwCAmD/Nd1e7szAMskku2oJoS8H
         mAVA==
X-Gm-Message-State: AOJu0Yx784tVpWGImAUA4PFLDFsrB2AQVp213De3lgYAPkIc2DmSG9mw
	sYUk7xvJFPxUbFermf4QY6scD+GUMdgrWg6jZaODH0KNDmS5Xlr8EEHfR3hw7ZM7Q1w=
X-Gm-Gg: ASbGncugMRYwDrvtKSFlBMjNvAJGTa9bAp0sJXMRveXeNxZNk/5Oa4xzhyXFZjoIeWK
	7yFBeAWd4CjmrlRGxss4VgHa6hte9rh14mwLLwIq4CShOcXHDvhLKdUhJT0ywprAtsdVo+RR8jo
	sa9ZLSanV8UKh3axm1gxn7f7xKDxqFl7upwl4PJ+t/Rzunu7iHOP/lFNlASI6MQ/wfccDIzQztX
	OvLubJ/eEHT9FuUHYR6XrAUQAdd1BwUjt7HU2rmiNAHejjxldadPldXfahLvAl2HiJ9RHSkghZl
	UmCdzBz9DsYjpi2wegcfmiZIdyppEg1LtEksP3U5I/yABLeA8UuyBNERlwCilKGu5wls6cn1oRT
	zxO6cs2tlouyqQ/xvKIAkh+QOKthI3pLF3paWxNnVhbFVX0kW+1+BpMMMoPMrhIQ+c0FN3H0C
X-Google-Smtp-Source: AGHT+IHnk9pbg0pNj+5jfkNWDhm3iigyZ6RX54/ZD/vVzsGzmPA9YsRX1KZ8+fyQCNEFMvNTW6Es3A==
X-Received: by 2002:a05:6000:2512:b0:426:d589:2633 with SMTP id ffacd0b85a97d-42704d993d3mr355598f8f.44.1760626104177;
        Thu, 16 Oct 2025 07:48:24 -0700 (PDT)
Received: from [127.0.0.1] ([2804:5078:81f:9200:58f2:fc97:371f:2])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29099afe03bsm32947795ad.107.2025.10.16.07.48.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 07:48:23 -0700 (PDT)
From: Marcos Paulo de Souza <mpdesouza@suse.com>
Date: Thu, 16 Oct 2025 11:47:58 -0300
Subject: [PATCH v6 5/5] kdb: Adapt kdb_msg_write to work with NBCON
 consoles
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251016-nbcon-kgdboc-v6-5-866aac60a80e@suse.com>
References: <20251016-nbcon-kgdboc-v6-0-866aac60a80e@suse.com>
In-Reply-To: <20251016-nbcon-kgdboc-v6-0-866aac60a80e@suse.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Petr Mladek <pmladek@suse.com>, Steven Rostedt <rostedt@goodmis.org>, 
 John Ogness <john.ogness@linutronix.de>, 
 Sergey Senozhatsky <senozhatsky@chromium.org>, 
 Jason Wessel <jason.wessel@windriver.com>, 
 Daniel Thompson <danielt@kernel.org>, 
 Douglas Anderson <dianders@chromium.org>
Cc: linux-kernel@vger.kernel.org, kgdb-bugreport@lists.sourceforge.net, 
 Marcos Paulo de Souza <mpdesouza@suse.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760626083; l=3159;
 i=mpdesouza@suse.com; s=20231031; h=from:subject:message-id;
 bh=Z9P5xcvbpTnJxeGz7KZPPikGSxpPD+xoc+k6to82yJA=;
 b=G+geV9gPFaBstxo8zAKrM3CPumHZxftSTfFf6nrMv2jIIVrkq40CdwCb7XDVxLyZBZjxpWsBA
 /p1tBh8FTePD0M0mbDBQxhq72eVE+C0Bcx9Hxc8Zt14Vluzjzwnss0K
X-Developer-Key: i=mpdesouza@suse.com; a=ed25519;
 pk=/Ni/TsKkr69EOmdZXkp1Q/BlzDonbOBRsfPa18ySIwU=

Function kdb_msg_write was calling con->write for any found console,
but it won't work on NBCON consoles. In this case we should acquire the
ownership of the console using NBCON_PRIO_EMERGENCY, since printing
kdb messages should only be interrupted by a panic.

At this point, the console is required to use the atomic callback. The
console is skipped if the write_atomic callback is not set or if the
context could not be acquired. The validation of NBCON is done by the
console_is_usable helper. The context is released right after
write_atomic finishes.

The oops_in_progress handling is only needed in the legacy consoles,
so it was moved around the con->write callback.

Suggested-by: Petr Mladek <pmladek@suse.com>
Reviewed-by: Petr Mladek <pmladek@suse.com>
Reviewed-by: John Ogness <john.ogness@linutronix.de>
Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
---
 kernel/debug/kdb/kdb_io.c | 47 ++++++++++++++++++++++++++++++++---------------
 1 file changed, 32 insertions(+), 15 deletions(-)

diff --git a/kernel/debug/kdb/kdb_io.c b/kernel/debug/kdb/kdb_io.c
index b12b9db75c1d..61c1690058ed 100644
--- a/kernel/debug/kdb/kdb_io.c
+++ b/kernel/debug/kdb/kdb_io.c
@@ -589,24 +589,41 @@ static void kdb_msg_write(const char *msg, int msg_len)
 	 */
 	cookie = console_srcu_read_lock();
 	for_each_console_srcu(c) {
-		if (!(console_srcu_read_flags(c) & CON_ENABLED))
+		short flags = console_srcu_read_flags(c);
+
+		if (!console_is_usable(c, flags, true))
 			continue;
 		if (c == dbg_io_ops->cons)
 			continue;
-		if (!c->write)
-			continue;
-		/*
-		 * Set oops_in_progress to encourage the console drivers to
-		 * disregard their internal spin locks: in the current calling
-		 * context the risk of deadlock is a bigger problem than risks
-		 * due to re-entering the console driver. We operate directly on
-		 * oops_in_progress rather than using bust_spinlocks() because
-		 * the calls bust_spinlocks() makes on exit are not appropriate
-		 * for this calling context.
-		 */
-		++oops_in_progress;
-		c->write(c, msg, msg_len);
-		--oops_in_progress;
+
+		if (flags & CON_NBCON) {
+			struct nbcon_write_context wctxt = { };
+
+			/*
+			 * Do not continue if the console is NBCON and the context
+			 * can't be acquired.
+			 */
+			if (!nbcon_kdb_try_acquire(c, &wctxt))
+				continue;
+
+			nbcon_write_context_set_buf(&wctxt, (char *)msg, msg_len);
+
+			c->write_atomic(c, &wctxt);
+			nbcon_kdb_release(&wctxt);
+		} else {
+			/*
+			 * Set oops_in_progress to encourage the console drivers to
+			 * disregard their internal spin locks: in the current calling
+			 * context the risk of deadlock is a bigger problem than risks
+			 * due to re-entering the console driver. We operate directly on
+			 * oops_in_progress rather than using bust_spinlocks() because
+			 * the calls bust_spinlocks() makes on exit are not appropriate
+			 * for this calling context.
+			 */
+			++oops_in_progress;
+			c->write(c, msg, msg_len);
+			--oops_in_progress;
+		}
 		touch_nmi_watchdog();
 	}
 	console_srcu_read_unlock(cookie);

-- 
2.51.0


