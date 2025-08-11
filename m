Return-Path: <linux-kernel+bounces-762732-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 276FDB20A45
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 15:34:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B6F91891309
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 13:34:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA7942DEA70;
	Mon, 11 Aug 2025 13:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="BUiG8ukl"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEE962DC33B
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 13:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754919234; cv=none; b=QFiARM+e8vDWgID4rdgH8WfzOCbCk4awY7rFd73YrGXY5A5ZsxtpQAUlLfKvwTZUa6jwfVWkYWhZbh/mHgGTISKo2pJa5dvcJGHfvKsSr29JIzXmIz1TONBvla+m8h4m9PpdO4uPBnIo4sEWKDQFMEiZse1p/uFOAA+OYh8WzhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754919234; c=relaxed/simple;
	bh=wHJt9KADeg3vlovyFmoply0rzf3HIHb2hJqagqqEV+w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pVn2CWC+My9LWIxcR34BwRtlNzRV5HvRj/yeG3ux1oTeaF0pkxfHz5Ufh7DniYj/uRJvZ846cJ2ImcMETQICoz+jYOq8If3FCYbDE2RzdgH0NFYURt5F6FyUNvOq/9p9rbJPRRwhjqqspDDXKKgOS9rKV1KXs/iXdWU81vl0QH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=BUiG8ukl; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3b792b0b829so4231622f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 06:33:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1754919230; x=1755524030; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=npbwFYYz8zd+MoHg005SoEvDbAHHK2F2wVdN9XZoFi0=;
        b=BUiG8ukl4bnqoa5GRpl60zIyjFHG4n2xINKzRTPXT5rToZvWyMM2hCcLVpkYXj+Ikh
         U9LvzGD6Q5uth/wuw0yPiJZnzCK0ZO57aNFzfilrliBYjSsdnOyk7VTSLMg01Zqe2lMw
         gX54BKZotvDqet4fv25qf+wnEs8xvS4cXL3oNUfrw8yrdstmi6jeJxitJdRKac7MDDNW
         P1dKOlDAESut5B/Jih5VGsWQ+TmaUgwQRn6yJ5Q4x6z+pjrKNoARQtfPUwf83XpfBuEQ
         nNHE2mLpqMzjuwTrMkc8eGUNALBpuwpNhlODXuRG+gJi4HmnJbUufMWO8vxixo+CA7+0
         lgBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754919230; x=1755524030;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=npbwFYYz8zd+MoHg005SoEvDbAHHK2F2wVdN9XZoFi0=;
        b=rYuyLvs3a8ihAetyiAQ5g0XzYp69zjzUus5FKWMQyKtDJ+1JZZCbnx2sUDKJuQutR8
         T9538tm+SNaTi8aL4Htw584Ce0aNyn80dwScdgaqcEGKwxKPwIW+ffG+S81X9T+0KP7l
         HJKd5isoYgNDbSLJtlYT+JED48QggsOcDwaDRKAPAHUWFOID+tA63a+p49fArjzuTM3d
         xjSIPeZ0BnUPIFQwTC7yNEbXjiqKLoWr/ygF8vVErXFp4/8V8cTp3O+adHwy2fmyx8xa
         NE8s/a9SwH+/D2BqcMelefq+fAS1nYS2mPOtxAKsAXyryqBEK6A7xZhGx71TDoAywOhW
         QHwQ==
X-Gm-Message-State: AOJu0YzvREV7y6KE1A6V8Uq/PWE1KtZWvGHG8Kz2iJrS6RsYYc/wB/9V
	Mut7fHrhBbmtmAnDoq7sSBIutpsUNHdCl1a4mQX67Ixayy3sdpETEwSPMJOF73nxLpk=
X-Gm-Gg: ASbGncuHWvRTP5Euv+FU3j9X4IW3CnnScqABA89i9fKMUE6ZZsv0A7hB1qr74y41T+F
	1BFJ1D9TgnHwhgL9b5IaR8yN87T2HRVxTcL7UkOwarM6DUd9+k3rDU3CDMhxDyf/4X7c+lMr8oE
	YHCjFySRX+L14Sn+RLTB0auvXKVpIRXwUVqXggr18asDTbxP2vx80Z3Hk11kNi6SooqkGLjJWS6
	DFZH1Pl80A0PADNSE06GE/LERuYY5JbPQPtxIxqLwIXyd0w53wxPDxXIfkYDjqslml8dg7pFQOz
	iq9U3qbhtnU6QCoY/6j3BxW3jpTZNu51jjq934FEqs19abjes6vISMnAm3jCCUezWfv/jpw+93Q
	fR9t8X4lRd+EVI46BQ3QjJzqYRL7ZmX+B33CQWpBvQeG9wg==
X-Google-Smtp-Source: AGHT+IFxFD2OXnDy2a0RgFmC/y+CVZzaev2ere71b0IMZGKVsU0l/pbGXasgy8IKu9OXnU5Vt+tAHg==
X-Received: by 2002:a05:6000:178f:b0:3b7:8dd7:55ad with SMTP id ffacd0b85a97d-3b900b7aeafmr10984761f8f.39.1754919230049;
        Mon, 11 Aug 2025 06:33:50 -0700 (PDT)
Received: from [127.0.0.1] (71.36.160.45.gramnet.com.br. [45.160.36.71])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bccfd18c9sm26667449b3a.91.2025.08.11.06.33.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 06:33:49 -0700 (PDT)
From: Marcos Paulo de Souza <mpdesouza@suse.com>
Date: Mon, 11 Aug 2025 10:32:47 -0300
Subject: [PATCH v2 3/3] kdb: Adapt kdb_msg_write to work with NBCON
 consoles
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250811-nbcon-kgdboc-v2-3-c7c72bcdeaf6@suse.com>
References: <20250811-nbcon-kgdboc-v2-0-c7c72bcdeaf6@suse.com>
In-Reply-To: <20250811-nbcon-kgdboc-v2-0-c7c72bcdeaf6@suse.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1754919199; l=2309;
 i=mpdesouza@suse.com; s=20231031; h=from:subject:message-id;
 bh=wHJt9KADeg3vlovyFmoply0rzf3HIHb2hJqagqqEV+w=;
 b=a5sAiSr27faPRI3JEgJIJnvCPiyXuqBHilT/H7/wQTH7y8AvHd1onEGwUehVWIzpdBfmoTXj1
 4JZv+miDm9oDWSNn8rFpmilYyhCt/JzEP1cILI6+h9NUo74JB81TMTz
X-Developer-Key: i=mpdesouza@suse.com; a=ed25519;
 pk=/Ni/TsKkr69EOmdZXkp1Q/BlzDonbOBRsfPa18ySIwU=

Function kdb_msg_write was calling con->write for any found console,
but it won't work on NBCON ones. In this case we should acquire the
ownership of the console using NBCON_PRIO_EMERGENCY, since printing
kdb messages should only be interrupted by a panic. This is done by the
nbcon_kdb_{acquire,release} functions.

At this point, the console is required to use the atomic callback. The
console is skipped if the write_atomic callback is not set or if the
context could not be acquired. The validation of NBCON is done by the
console_is_usable helper. The context is released right after
write_atomic finishes.

Suggested-by: Petr Mladek <pmladek@suse.com>
Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
---
 kernel/debug/kdb/kdb_io.c | 26 ++++++++++++++++++++++----
 1 file changed, 22 insertions(+), 4 deletions(-)

diff --git a/kernel/debug/kdb/kdb_io.c b/kernel/debug/kdb/kdb_io.c
index 9b11b10b120cf07e451a7a4d92ce50f9a6c066b2..74f6d4316bdc9d3c4f6d4252bf425e33cce65a87 100644
--- a/kernel/debug/kdb/kdb_io.c
+++ b/kernel/debug/kdb/kdb_io.c
@@ -589,12 +589,23 @@ static void kdb_msg_write(const char *msg, int msg_len)
 	 */
 	cookie = console_srcu_read_lock();
 	for_each_console_srcu(c) {
-		if (!(console_srcu_read_flags(c) & CON_ENABLED))
+		struct nbcon_write_context wctxt = { };
+		short flags = console_srcu_read_flags(c);
+
+		if (!console_is_usable(c, flags, true))
 			continue;
 		if (c == dbg_io_ops->cons)
 			continue;
-		if (!c->write)
-			continue;
+
+		/*
+		 * Do not continue if the console is NBCON and the context
+		 * can't be acquired.
+		 */
+		if (flags & CON_NBCON) {
+			if (!nbcon_kdb_try_acquire(c, &wctxt))
+				continue;
+		}
+
 		/*
 		 * Set oops_in_progress to encourage the console drivers to
 		 * disregard their internal spin locks: in the current calling
@@ -605,7 +616,14 @@ static void kdb_msg_write(const char *msg, int msg_len)
 		 * for this calling context.
 		 */
 		++oops_in_progress;
-		c->write(c, msg, msg_len);
+		if (flags & CON_NBCON) {
+			wctxt.outbuf = (char *)msg;
+			wctxt.len = msg_len;
+			c->write_atomic(c, &wctxt);
+			nbcon_kdb_release(&wctxt);
+		} else {
+			c->write(c, msg, msg_len);
+		}
 		--oops_in_progress;
 		touch_nmi_watchdog();
 	}

-- 
2.50.0


