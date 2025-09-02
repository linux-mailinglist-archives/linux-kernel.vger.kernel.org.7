Return-Path: <linux-kernel+bounces-797197-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 49F54B40D3C
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 20:35:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C737563367
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 18:35:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5945C34DCC9;
	Tue,  2 Sep 2025 18:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="fYEzzByO"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85AAC350857
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 18:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756838065; cv=none; b=iWubGCBhKZe3UFyppi2NGLKAVtOkRryFZOLHHP+heoywMob+eNa1bUKoJnZvYgEWBykrOEVLmE6ZFetkzeiLVW1pvYcunov94XHKkG/Jm6gXJRbQu9/QQCxilG1FbEhAJO0WLKUnAU6GRdCMUDNTF6iX85jYvG09a30GYrEMzN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756838065; c=relaxed/simple;
	bh=+UwyHLjdFrZY6eKJLE4ZxlJyjFoWSa4EScBE6ysnaVI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rxnmekfgPGPzfNKP3t3q7crekLspxHBeojzyJE5sIUoX8a2fMcRQkFM14URKRW0I5oUNORovhzd6anLv80QOMgl8bgehw3vfVomuZU41qw7vmKURq2AIEDEkpXGyynNe0ikW2ftjA/9rV5WqqZ/gQFC5VYNTDVnnMf3PzBIjXC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=fYEzzByO; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-45b79ec2fbeso38846965e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 11:34:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1756838061; x=1757442861; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Xcq4igIAw5t5SC0KyrVI7uzqX4joQRvngrbWP1St/kY=;
        b=fYEzzByO4ryzG6guf31cGmYrw/yOkfuksZ+9pwAIsKl9syvI9HW+KzVaxCCWZNR0qO
         zFjV/rtfsK6VAaG3WjRz8BRG8vgEbjJt6q6eToscIO6TKbGj7dBnc9el3oreq7vPQ0YH
         fctnBda4B0AouyrGt01oXLJQSyfOy/vr7k2amRhfmWmpJnUarOsBSGLf147Aq+fljbel
         NKJ+elTezGzRqoPiJ/9VzgJ6IJU0wrjNp9zWSgAPXU6a2zxH7al8K+mXxpJ4sBT6bKyD
         lH5h54QbVNLGb+QdWiRBwBbtiR6sv62Xmu00cIUV3luc4NBKMx3G98sT+TzSWENlF3eA
         CR6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756838061; x=1757442861;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xcq4igIAw5t5SC0KyrVI7uzqX4joQRvngrbWP1St/kY=;
        b=qlcwn9+B8VvUna4z3mTD78NsQkGnuMuyA0SkxeGlQmuIFoN54FMzGHF+ugCDHnEOTL
         QyconXSXWh2fe6JHDZVEbf4zl9m9/Cv2wEF7U6FdhlO4tPcVOc4DHo8QsUi4fz2O2DUp
         zxPzpspy46gkc3xU1SgkJocTA0SUhguoKpMm9rxFG6NC3qYH8DhGPOpwChs0oxx8oqOI
         7ilcieMx8C+znvEcWcnf1ikhdu/UmSw4JirfwFSjF66NAlqAuVRoKSAxSdY0R8AN0jkl
         MHM4UMTDKt63i96IDHCSQOxj0WivMiFJXUf2LzTIHq7DKHTfAq5Lpa801+ShWv3kIsRn
         i2gg==
X-Gm-Message-State: AOJu0YzKhcXT/s5q+F8SuxqmhaP73aJZ3WmsB2jS31FWHLzuc/5twk3Y
	RYuOfwZfM8gaDvOuFyIXdGfKmDqHh1cvY5DecgzNCvAlcGbaQammBByKlX9rOdmd1c0=
X-Gm-Gg: ASbGncs21Mj3RRclzUU9ydiLY5JwP6cs1m7mGN5eYFmaZ4jUS4Ps7qLZqZr3pYWBK5j
	AGxt/uhTi4G1Tt0jeZqxuKQdu0k/CgjZwIjVA5AL+j4DftT47d3vb9YgVGcSFTCqsT3cdM+ynwH
	HGJ4Gc9vKwwKHt7M4wRkVaIReM1fGj/7eoYFTQJR49jvtHae5mR9gHK1F7Qx5Z+KYJKb+gll56p
	eTFB0655YxGYmsJVv9J+RNU3FtWDGexXFglZWQG2KL+o9tKRUXD0KsWaUUYAJawWq6C26ah5JwQ
	jr0XaUhsfaG+98mx8ZMrrJ9VM/oTwo0dhvGewDK0HhdVKwag8iq5NE/l9K9uZcfPxj+IBBDCns3
	MhWHH/HdeROA0bkkZcaJxmLvrz93Klg==
X-Google-Smtp-Source: AGHT+IHWvfa1MfnXxCv92+LKAfoxq9DlDGk2apmD5Gzp1xX7ZsE3yezBngl0biLHukmFmhP6HVgmWA==
X-Received: by 2002:a05:6000:1888:b0:3ce:a06e:f24e with SMTP id ffacd0b85a97d-3d1e05b6b69mr7933860f8f.52.1756838060800;
        Tue, 02 Sep 2025 11:34:20 -0700 (PDT)
Received: from [127.0.0.1] ([2804:5078:9a0:f000:58f2:fc97:371f:2])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7722a4e1d4fsm14028477b3a.73.2025.09.02.11.34.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 11:34:20 -0700 (PDT)
From: Marcos Paulo de Souza <mpdesouza@suse.com>
Date: Tue, 02 Sep 2025 15:33:55 -0300
Subject: [PATCH v3 4/4] kdb: Adapt kdb_msg_write to work with NBCON
 consoles
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250902-nbcon-kgdboc-v3-4-cd30a8106f1c@suse.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756838042; l=3211;
 i=mpdesouza@suse.com; s=20231031; h=from:subject:message-id;
 bh=+UwyHLjdFrZY6eKJLE4ZxlJyjFoWSa4EScBE6ysnaVI=;
 b=lzYUMPYu2PLlg3gPvl+ogk+PEjpIYL3DTt0nd9nwcAKyg8F5UiKDXV5FZhydCLA1LLurdiii+
 qJiBTPCmsZICSMPLq2lXvZ6UqfFRvqPjmtLz9muRoX0jMUIqyOGY28T
X-Developer-Key: i=mpdesouza@suse.com; a=ed25519;
 pk=/Ni/TsKkr69EOmdZXkp1Q/BlzDonbOBRsfPa18ySIwU=

Function kdb_msg_write was calling con->write for any found console,
but it won't work on NBCON ones. In this case we should acquire the
ownership of the console using NBCON_PRIO_EMERGENCY, since printing
kdb messages should only be interrupted by a panic in the case it was
triggered by sysrq debug option. This is done by the
nbcon_kdb_{acquire,release} functions.

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
 kernel/debug/kdb/kdb_io.c | 46 +++++++++++++++++++++++++++++++---------------
 1 file changed, 31 insertions(+), 15 deletions(-)

diff --git a/kernel/debug/kdb/kdb_io.c b/kernel/debug/kdb/kdb_io.c
index 9b11b10b120cf07e451a7a4d92ce50f9a6c066b2..47bc31cc71bc84750db5d9304ed75a113cd382bf 100644
--- a/kernel/debug/kdb/kdb_io.c
+++ b/kernel/debug/kdb/kdb_io.c
@@ -589,24 +589,40 @@ static void kdb_msg_write(const char *msg, int msg_len)
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
+			/*
+			 * Do not continue if the console is NBCON and the context
+			 * can't be acquired.
+			 */
+			if (!nbcon_kdb_try_acquire(c, &wctxt))
+				continue;
+
+			wctxt.outbuf = (char *)msg;
+			wctxt.len = msg_len;
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
2.50.0


