Return-Path: <linux-kernel+bounces-816757-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 461BEB577FA
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 13:22:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 370A73BFFD0
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 11:21:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D6E73002DE;
	Mon, 15 Sep 2025 11:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="LhDKdEG7"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C7242FE570
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 11:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757935260; cv=none; b=KpRZHZPzs6RhlBnujnu3cGOj/ZYXyNXPZH+v3UZgTaXpn+U5ZD9t4KdpR0Vu6ymyiYhbqwAU/a7kjw07c1SwO/yGi4ZmhD9mZVxMzpweeBacQA6/2DM4OrF/245GpQPMRUpMHtNaa/LMUHc5LMrIyIMzb9Ce5IJua2bOIVqnpPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757935260; c=relaxed/simple;
	bh=cU4lCiNjMiiGMfFUXRrB/KF33np8MWM4waFxZIq2SMc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=O+hyNl/dAwt+UgTi7jfARLLBtoc6lcRPJvkEWhaEcYUIGfHd+3y3C9EABjsMIJcXevuzk6TCsj5e5SCKyIUUzcUoRoz027ikAN3HZ+aoRpcuPhjOM5ExT8zQfoVeywzC9VocgKCIkvHlmWkRGgr+DPNR7US8PwXSRr6kEghPKK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=LhDKdEG7; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-45f2fbdacd2so2803335e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 04:20:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1757935257; x=1758540057; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yI3qfrLV7ruXbzRrQGdU3KTH5BlrLsrFDw7oSvmhleo=;
        b=LhDKdEG72yOIGdIG327Ck/Mg6XcTINpJacFm8oS7359+fhmjdZ5uJz5djb4C2iEwaq
         fWnrLztfmdriccCmCW3XaJmDqVWWZrhSB0C3sS51yhiUJped1QnghOYHP/SwCEhDYI85
         Cr/DqQ5D8LcircXnZgeh3P5lA2g71AsHzFon0smnhCPV/xRAh0GCrOH8vgLiseEhvacm
         iVJN1tX6GTfXu7QH4sZRqUJOeD1WpwSzVl3vbP0NurlkaSLkLnG7+FRbA92GYTgO8dbs
         r3UNMtGcA2d94ZNQD6xFdYbl33SqKdRWRexu7LY4pF26UlWOWF61fM9cUsa+HiPu7Nhz
         lweA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757935257; x=1758540057;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yI3qfrLV7ruXbzRrQGdU3KTH5BlrLsrFDw7oSvmhleo=;
        b=AcBtWtT50dI9e/bcBRdI/pLqZ8LgFqJwebi4laR/TFNTJnJlH9n0Sz8ouRtUV3daHP
         hB08lG70ySr4qtdW3hOsfnATkqcaXAoHDcNBEVtG8A/3LW7LbHm3VEZVubbWqsSh+vPN
         j1qmYjQV3bgMKzfAjE9eBY6i3WDbzgoROa0GiAMoBgHL/Hfp6NbiW6iXYV98vF2+Oas9
         vXKPGdiDanljqRWwhO4irOVlyivvH3v3GfVK1nM5Yb82aQwhftk9tVCoUGbJsVggYn4/
         tpWZSdG9jaeq3/OTqcTCUHWwMzTy6KB6HOiybRnBsRkinKqeuI8XspDAUU4JDDZDmGYE
         EDTA==
X-Gm-Message-State: AOJu0YwaPSApGVaFBvJnRN0fUwkNuuMETFXskMf7x6JMuZWAbE4H+DNo
	MmhsgECArC6itZ7KG/ClQZOeiwcMVsdw535F2KsJyoS4YlYFn8EpbXNW0Ym3zzsjNPk=
X-Gm-Gg: ASbGncuvSjnPDU4KlmzPeOFq1J3gLiOYLm6J6XFlpUKyr/HkrciCRm5t3UAqMBJ6Un5
	fgc/XcRsjN1X3X0cB6BOJ+S0xGdQIiMRPbL/bRJ0FihB17vBNNQ7+hMDjqviAj9UXCQondSFqXw
	SL/mGI/f2gllUBbt6Bl7cOnqMfSdQqysLj9wQkBdS1VPIbVAW5ftEq+UEDsrShQzvpz/wg3Q6fd
	F93lbX0BOgJBhvgscoqqC0dxg3awdoQKuwsqUXAZCVmNZLL3tCwCyHiymYUxQQqZQSsscYIbXfm
	9yds3Pmx1faFNBBgqS+TR19OgrEtfjkDmVnSYEp7/CBNCfEjoxWJe5ENwHdnV/IcS9Wf0tl2W7a
	SERo+WU0f+2uRdZ+KEH16L0sQU8wio9yRpax1X39VPPXIjiDsrw9KIelBg1M=
X-Google-Smtp-Source: AGHT+IHlepwn2YUclkQra47gSbaQH2Winx4dfN2i2Z3eBSGGpIvoXWKQb1B+Sku0IkdxX83AyB66GQ==
X-Received: by 2002:a7b:ca5a:0:b0:45d:e0cf:41c9 with SMTP id 5b1f17b1804b1-45f211f89d6mr77517385e9.22.1757935256907;
        Mon, 15 Sep 2025 04:20:56 -0700 (PDT)
Received: from [127.0.0.1] (210.37.160.45.gramnet.com.br. [45.160.37.210])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45e01519f67sm91903345e9.1.2025.09.15.04.20.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 04:20:56 -0700 (PDT)
From: Marcos Paulo de Souza <mpdesouza@suse.com>
Date: Mon, 15 Sep 2025 08:20:34 -0300
Subject: [PATCH v4 5/5] kdb: Adapt kdb_msg_write to work with NBCON
 consoles
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250915-nbcon-kgdboc-v4-5-e2b6753bb566@suse.com>
References: <20250915-nbcon-kgdboc-v4-0-e2b6753bb566@suse.com>
In-Reply-To: <20250915-nbcon-kgdboc-v4-0-e2b6753bb566@suse.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757935236; l=3116;
 i=mpdesouza@suse.com; s=20231031; h=from:subject:message-id;
 bh=cU4lCiNjMiiGMfFUXRrB/KF33np8MWM4waFxZIq2SMc=;
 b=Y6lbO/KCBWxTvMSGO2TK/tbcPJ/aQUu4DL2ZUtimx/DkNPqLGVp7o3w+v848Ecp7GpIfU+SdW
 ZDXDMvsJD+JDoakfaepCtR5in9rzdM7olYGxHid+YWm/6wImVedpqii
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
Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
---
 kernel/debug/kdb/kdb_io.c | 47 ++++++++++++++++++++++++++++++++---------------
 1 file changed, 32 insertions(+), 15 deletions(-)

diff --git a/kernel/debug/kdb/kdb_io.c b/kernel/debug/kdb/kdb_io.c
index 9b11b10b120cf07e451a7a4d92ce50f9a6c066b2..7f41ce5d1b4b2b9970f7c84d8df40d13c9e9a084 100644
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


