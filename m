Return-Path: <linux-kernel+bounces-728902-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DF23B02EA8
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jul 2025 07:09:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8284B4A1280
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jul 2025 05:09:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 023DE1A5BAE;
	Sun, 13 Jul 2025 05:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="NFxRV6s2"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44DC419C558
	for <linux-kernel@vger.kernel.org>; Sun, 13 Jul 2025 05:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752383375; cv=none; b=LwrsO3AX6ixAjguN/dlfke46217U3t/uHtHyIyR3U6vVdMVznXS3mEhEekpHvQ9vrUtLuU4bDP1IhlglzhTWx64wZt8wyErqHoKXsNWCcXFNbOGdOIClKw8AYFW+MoxYpt6CrGCdE373440zM1K/EjtlJ6caTzcqfZ4POhhXpas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752383375; c=relaxed/simple;
	bh=BhkQT2VjxlBBB44KZbEDSDCxnibcvsDE0D7c+VlqDfo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Vs0r9K1V98kMz5oxu1Xl0X7DnJOkl4bZLnxGzpEk2tpb56Qm2Ow7zCmSWzu19ALbIBuMTwDAyjxCILgpCL+CveQoZuzZgsSHTutjNpQsKpoYYyMzO+dMj3ewdqDq/VOzosUKYCSDJ2a2Q6LpIc3Pnlcn14Ij0ReoPvfctHAZtk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=NFxRV6s2; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3a6cd1a6fecso3261513f8f.3
        for <linux-kernel@vger.kernel.org>; Sat, 12 Jul 2025 22:09:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1752383371; x=1752988171; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rplS/4F9HQSrBRuj60001ScYo39oY8hZsZRvEzwk1RM=;
        b=NFxRV6s2Rz5wygWFwVWlXsakR454K3TwSgAHm/wSN+ZHdXz8MbwGZ99wY9H7+WY6Py
         DstI6H4dJZd2nA9Aeb+SWBSMgH51lyIAaXtLgC3klobhONLaeB/wPnw93Y2861FceQX6
         1DDDzhIztzFiLzEskdjh393aXqofv5z4vTDmb2gjmXLP8UaJzy51WBAge/b3aAsizf7Y
         QQTjtN5TqxUnCoJOQsZv4ccWN0NZMBblcmAN7gsIyPvz/493vgd/ROodfBMdv+sL4DTQ
         yFXr74m2Tu0/vCJlWB/0RfPW2g2UaLXN85u7kYiN08d7Z7iWdmQO2/zS7GYJvOG7NPve
         wTcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752383371; x=1752988171;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rplS/4F9HQSrBRuj60001ScYo39oY8hZsZRvEzwk1RM=;
        b=ACev6pnsZTzhRSnOkAgmgYycVjMC9zBFyAX7SKO3de+kmErEan6YpFg9Iffw9X3dzK
         24j6Wmr4prqrOEb8GRylhhZKgrsSAAAovDguogbggpC0Io0IFzkkdGwqsniRn1kP4Syn
         iYgD+0+wkrdvY2o1xZQ3TVo9Zx2rDhLlsR0EE7z+phUTo6GWSuuZGUwoCOHiPk/J4pOJ
         vzMweTrMeVPpKKZAdhJh8ZSpwWGlwI/l4Ol8Dh4CgYPne9mwQ9kOYGcGx8vJ9/hrJiq9
         cVZRDR+jnUT8OwW5K5SmPAFhW3mRq1bXWQloK+gcRvDS5kclfDxQLKJV5+iz5tacDMhP
         sbRw==
X-Gm-Message-State: AOJu0YwX5ZpZZXE/UpPDjQPce4LdHEggf7shy7iQXA9iMpq4gSJ3/89O
	pH70RJx4mFuipHQXD3ZYWYyBoWRJJ+nqm1mHHQaA5n2lPdM/Sdi16o3OiYsPL8ApKJw=
X-Gm-Gg: ASbGncs/t3USaZLuIoRALD8HP/JFLSM+9TShf2K4UcKZcde8JZMiizNoxKFg9fv8cCO
	EeMdJWmsFT58a1yj05kPzrvYngKGGA8vCAE2WQBV34V9m+Xeo2UOS6kldejRQjCOFlr8jq86pyN
	hzDVT3zAn/c2y/xGsREQB+gRowvxS9n9zvp9WHqQuZj8EkeZQKCMKEjHqrI3+iHeDVrQnVC0z8d
	Wzvp1aTTkRMsd3GTbfM9vNGPuTyREZuotVcSbXns62R/ocmQwfikYwKJhNrt1CVd3HevBTHXXbP
	53jsVXpUjSwu9ZRsZMAc1Fiv7VQgzIbhX4Hv8eV103JP2Bf4dPmRmwNOdr/9GuI0OyWgLK0BWMX
	zoiE9xDR6voFF6AVDdpE=
X-Google-Smtp-Source: AGHT+IH/lG0/wtwwi45kibg7irhMga7P+QoBrHuyvg1RpJroQXZkYkGelqR1QnmMJ8MsjRb/KbFTZQ==
X-Received: by 2002:adf:b60b:0:b0:3a8:6260:ea91 with SMTP id ffacd0b85a97d-3b5f1895c8cmr7180948f8f.40.1752383371510;
        Sat, 12 Jul 2025 22:09:31 -0700 (PDT)
Received: from [127.0.0.1] ([2804:5078:828:f400:58f2:fc97:371f:2])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74eb9f210f1sm8125879b3a.88.2025.07.12.22.09.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Jul 2025 22:09:31 -0700 (PDT)
From: Marcos Paulo de Souza <mpdesouza@suse.com>
Date: Sun, 13 Jul 2025 02:09:19 -0300
Subject: [PATCH 2/2] kdb: Adapt kdb_msg_write to work with NBCON consoles
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250713-nbcon-kgdboc-v1-2-51eccd9247a8@suse.com>
References: <20250713-nbcon-kgdboc-v1-0-51eccd9247a8@suse.com>
In-Reply-To: <20250713-nbcon-kgdboc-v1-0-51eccd9247a8@suse.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752383361; l=2988;
 i=mpdesouza@suse.com; s=20231031; h=from:subject:message-id;
 bh=BhkQT2VjxlBBB44KZbEDSDCxnibcvsDE0D7c+VlqDfo=;
 b=mD048M7lF++L74S6TaHtkYIT8KOYYfLt+kZ+fMDfjPU1S7ibbneYLVe0x3wybOOfDdr0n/f3E
 5V1w79YtGJDAAIJtOsboa8A8L6LsStIOs9wdNyuj1QFRndJ4GBHdZdB
X-Developer-Key: i=mpdesouza@suse.com; a=ed25519;
 pk=/Ni/TsKkr69EOmdZXkp1Q/BlzDonbOBRsfPa18ySIwU=

Function kdb_msg_write was calling con->write for the any found console,
but it won't work on NBCON ones. In this case we should acquire the
ownership of the console using NBCON_PRIO_EMERGENCY, since printing
kdb messages should only be interrupted by a panic.

At this point, the console is required to use the atomic callback. The
console is skipped if the write_atomic callback is not set or if the
context could not be acquired. The validation of NBCON is done by the
console_is_usable helper. The context is released right after
write_atomic finishes.

Suggested-by: Petr Mladek <pmladek@suse.com>
Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
---
 kernel/debug/kdb/kdb_io.c | 46 ++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 42 insertions(+), 4 deletions(-)

diff --git a/kernel/debug/kdb/kdb_io.c b/kernel/debug/kdb/kdb_io.c
index 9b11b10b120cf07e451a7a4d92ce50f9a6c066b2..3b7365c11d06b01d487767fd89f1081da10dd2ed 100644
--- a/kernel/debug/kdb/kdb_io.c
+++ b/kernel/debug/kdb/kdb_io.c
@@ -558,6 +558,25 @@ static int kdb_search_string(char *searched, char *searchfor)
 	return 0;
 }
 
+static struct nbcon_context *nbcon_acquire_ctxt(struct console *con,
+					struct nbcon_write_context *wctxt,
+					char *msg, int msg_len)
+{
+	struct nbcon_context *ctxt = &ACCESS_PRIVATE(wctxt, ctxt);
+
+	ctxt->console		    = con;
+	ctxt->spinwait_max_us	    = 0;
+	ctxt->prio		    = NBCON_PRIO_EMERGENCY;
+	ctxt->allow_unsafe_takeover = false;
+	wctxt->outbuf		    = msg;
+	wctxt->len		    = msg_len;
+
+	if (!nbcon_context_try_acquire(ctxt))
+		return NULL;
+
+	return ctxt;
+}
+
 static void kdb_msg_write(const char *msg, int msg_len)
 {
 	struct console *c;
@@ -589,12 +608,26 @@ static void kdb_msg_write(const char *msg, int msg_len)
 	 */
 	cookie = console_srcu_read_lock();
 	for_each_console_srcu(c) {
-		if (!(console_srcu_read_flags(c) & CON_ENABLED))
+		struct nbcon_write_context wctxt = { };
+		struct nbcon_context *ctxt;
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
+			ctxt = nbcon_acquire_ctxt(c, &wctxt, (char *)msg,
+						  msg_len);
+			if (!ctxt)
+				continue;
+		}
+
 		/*
 		 * Set oops_in_progress to encourage the console drivers to
 		 * disregard their internal spin locks: in the current calling
@@ -605,7 +638,12 @@ static void kdb_msg_write(const char *msg, int msg_len)
 		 * for this calling context.
 		 */
 		++oops_in_progress;
-		c->write(c, msg, msg_len);
+		if (flags & CON_NBCON) {
+			c->write_atomic(c, &wctxt);
+			nbcon_context_release(ctxt);
+		} else {
+			c->write(c, msg, msg_len);
+		}
 		--oops_in_progress;
 		touch_nmi_watchdog();
 	}

-- 
2.50.0


