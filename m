Return-Path: <linux-kernel+bounces-837977-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FDD7BAE299
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 19:22:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 714F04A3E4F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 17:22:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DA322FBE16;
	Tue, 30 Sep 2025 17:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Zvd+J7jT"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FCA330C600
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 17:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759252931; cv=none; b=kECLqFpVOPkqYNK0EA2nHFrIqfEL3BsxpUMHoCj1woBXNnmLG0/sETKtJJwa/gMb+ZTw1RgLJr4PuybOUGaoFLmP8vBxvbDcnzalBpSUIeXJhaNynmyhMELRt95Xr0HAvQmOOWHBmTHKSoUFbpkviINdNs3EoBmShgKjmmWb8o4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759252931; c=relaxed/simple;
	bh=ygwUX/1tQYNO8Z3SG4OQhTz6XDitcn9QQTD2XNDaWnM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Cf8BVKZO841ObgSRJJJdVR5qAVDxe1uF/jXCLQjVWvMIiKwomZSXLg9S+dRhyzNVRjGNQWyB5GIyOd7Jj0YjZ294KE68JW6ltm7fzWpjNg4UM4hj7r32z4MBn9iH1pfgqJfeyS0nopRJZxWcKFwElysjUN5S/raH2TVvcPWqOUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Zvd+J7jT; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-46e414f90ceso11384525e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 10:22:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1759252925; x=1759857725; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aLcpX2pmqFVTyeyKqISxLvLObbz2xb7M6zZbF5c/M0w=;
        b=Zvd+J7jTQxIXBbFVBAYjBLCFyOuawf/75RRdvoywV6FFxNOpTq70QLkFn2KEevWFPg
         C7jK+MWyFwJSERSHEUNF/XUZMyMKk4hTRZIVUX92+BQ2BPsbY1mqQx3FPlVXyN7/YbCT
         soB7nDCACTI4Y8wI/A3vGcm7WLzMPm7SFltIqPipk2UPYu75d3CWB6Xt3kw7ekyejRKM
         W6pfT00VqT+Rrz+SFzwz1BGaYo15x1Sg5xqyQ3kx87oib2kJhb7EHwhPITgrnZm+8IWn
         xn8tIfBfjG6iJbkj/GkKcvygBB7YFoY0HzeHSMCtJ/Ybr1xvMrurnoFM/WYi14MW1bLL
         5kwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759252925; x=1759857725;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aLcpX2pmqFVTyeyKqISxLvLObbz2xb7M6zZbF5c/M0w=;
        b=H2PNKoHPy784XHrj/4nGj9XT3GBrIkaH9iKBPfyDiLgxr52H33lLGDo7tl+MdZKDZa
         4ut99Ncc1pR8/pPVHmgOI2u/Gy0grIfe3QwVsYAMzezyX7eO6PKo1tMmV9EBPhspO4wo
         Y7hU8U9s8yDfl3kbf4daRFQ9WKYhd0hFIjygclIAesUeC4LhT8unavK9Lev48dkcOSYw
         /CfRYmJ8VCSQn7RwePTknEAc4rvzSVU5TtylUGnoV1uzblcopuir/LGXuwZRI6kE+Jq9
         R7aleDwTZTudiIzNwx9PtiUSRv+tEzJXN/lu8Rv3DDldgxqXAQOx5CC9JM0xBOvPlPzG
         D/hg==
X-Gm-Message-State: AOJu0YzeWqQJCwzgT2eThljCwieKdahSdH3s4FFX5zRNeNMFqYC14KeZ
	ZRgUaKnNsfTH2mE1dwiIH6PH0GiqqoKXlsc0p3eBQ93/rY2htM9TnxnExOsZOO6K5Ys=
X-Gm-Gg: ASbGnctnWqJppgNuF/qB3jcTUrGEszRiXiCiTYn74tlmjVswb1Qm/jrIT123ZApu6bt
	4y0q/9GQB8VgiPVt6M8SEwrw296CG3qTmVkZNJDm4vMPl7pryogtraJtyb5v8yy+VMtCfWEBX6T
	Fh9JzfJZR6pTCsLuHeglCKztvuttgxEKG0pwQsUr62x4U7DPeRBStpIFYxEYflOTBGAs2p2t9qx
	2IO/RADhzb4H2WWGVjOm2HlZVszi/UqoQgxrpwzYwJNLvIjuMrA7B8TvpLAiUTVsBRSuJUL0Zq/
	RBEwnGqGAx5YwGZ3n75Yjr3vKmUYr2D6v0UCq3Gmaz22C2/W10nqueV221YEhKVwp6E5102rzVf
	TErCMcySVt2FYTqeuGYwMs0xrHO2fFkcRH9dITV9dG1oGOQ2d9d76gOITxfNmMUGn2f4tJA==
X-Google-Smtp-Source: AGHT+IE6+GIKVcLHfdesBGw0a0n3RqOmAcVF/EI842DFmf+4JhKX+V5imSFpFavv7JiYyYzgPEqBMg==
X-Received: by 2002:a05:600c:4e52:b0:45b:7b00:c129 with SMTP id 5b1f17b1804b1-46e612e6f9fmr4823605e9.35.1759252925439;
        Tue, 30 Sep 2025 10:22:05 -0700 (PDT)
Received: from [127.0.0.1] (88.36.160.45.gramnet.com.br. [45.160.36.88])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e61a17a0dsm2459465e9.17.2025.09.30.10.22.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Sep 2025 10:22:05 -0700 (PDT)
From: Marcos Paulo de Souza <mpdesouza@suse.com>
Date: Tue, 30 Sep 2025 14:21:11 -0300
Subject: [PATCH v5 5/5] kdb: Adapt kdb_msg_write to work with NBCON
 consoles
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250930-nbcon-kgdboc-v5-5-8125893cfb4f@suse.com>
References: <20250930-nbcon-kgdboc-v5-0-8125893cfb4f@suse.com>
In-Reply-To: <20250930-nbcon-kgdboc-v5-0-8125893cfb4f@suse.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1759252905; l=3161;
 i=mpdesouza@suse.com; s=20231031; h=from:subject:message-id;
 bh=ygwUX/1tQYNO8Z3SG4OQhTz6XDitcn9QQTD2XNDaWnM=;
 b=X3rMY7ZtKq4g6XYCM3D20/MmRpjrwKyQV7cX9mB1G+W2N1cnhvHvBaIRhWKRsckS7OO9hEphp
 b+DwAK11c96A2o+6UZA3SRCfN/cC4qpjDrRxOliSssscTx5Yl/AMnX2
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


