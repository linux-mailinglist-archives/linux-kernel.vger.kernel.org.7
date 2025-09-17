Return-Path: <linux-kernel+bounces-821044-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A4F7B8039B
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 16:47:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0EB231885985
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 14:45:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52EB83161A0;
	Wed, 17 Sep 2025 14:44:44 +0000 (UTC)
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 427CD236A73
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 14:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758120283; cv=none; b=UJLW1qxDpyt88BdSWK3g/qV2oPOyptBVzwwdJtbpBFKT4D2ftD1ntv8nfGDV+z787ugBpYMwoY4SS0JvzS5Rso14Bk/Ya3dCAgg+f9vMzIrNScNOcAqRXDqETz6uOcBA3mdqAXwND68kmkSinrA1DPXBSyKTvuabPld9RkRSmUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758120283; c=relaxed/simple;
	bh=3y/EjZj+vW3jizeSwu3mFSqiIIGd0FGP0aSpJ32i3eI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uhdog29pZy38imLcvXrPRts6KMwxfrOBdSJ0NV5qMvT4dyBGp9Pfzx3mIVmNkCTjN4RojkBv/Z2GQF3mtA28hcMEe6xIZqIhgIg7Fn5pH2rztouhND2GnYFl49r+BJIuqcmXrlqQS+kNC1coxvOn1je3PU5ynm6hToy23GH6VKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b07dac96d1eso156476966b.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 07:44:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758120278; x=1758725078;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=57MPflead0x+cCcaHt4qz6hGysW6yPqMKfSPRSI3nBw=;
        b=b91wZPNzJ1cyvmh9/arbZq2zoq/pLqrLxHDqNxfqMrJ0F1cVmK6rhS3bZs1XR3sl+A
         C4jV9DnSw+yhKBMcAOCmGgOjBPEcIdYDQXKGsMtriqqLfHA0njtTo3+6uooTqbjKouIy
         ANStzx2y57wwJn3hfIp7gfitSHzZgyXP5bb6uIMGxLzHsf06VcPJffgIR9Aq5xGxbjfM
         NTl4HXRl3kuobZrFM81di3QsfxpXgAb823JNo35GFyzSUxii0hRhKI3Y9iHAYeiNxTIv
         KVMWLZMTxUF6sK7aA9me1Afdd3egvmlvsGuDu6l2GuQheVF5KwCXctmIUPY6THfMaQzd
         xWAg==
X-Forwarded-Encrypted: i=1; AJvYcCX5+NpSBwwlXPfejNhOD2ls47ss0yIBM6qRz1SGb3OW0AJIZ2zGBywI35E7M+vm15m/XVZkNpazQf5dPV8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwU1lZ4QreTy0YNBrx4mNmLmIjHJklEGwanoequOa9l4VXRhv11
	YAZnAWeveyJ6XVHXvhN2jGZPvF9W69PeiexOTKDWwT5BkSeMH7is6zGL
X-Gm-Gg: ASbGncsr5JcfZ+Y+cRO0oyeVEDZOhT0Vm5WBMFyFAsSp8rnFgOcUVN2XT4ZXjPoPeLq
	cB1PgH7UelYR5DG3Zx9UOL8V89TJaAh3krpzbQnqJqZBcZf8J7PN148IIxgafw1PZco5r5g+kzr
	sKciZT5/7LZ/z6fCW50wfuyp08CzZ0ErvYQf1tp1GYx851/itCEH7Yh41jZ+yq7sTvz8tHcc6Ab
	HF1atD8opEizRHOVzqrlT9mPtUsqSxj4zP3c7T68wAs1f66LKlYekPqKWeqq/H66oqlRkny1jsh
	LYJCmA4XqBxttD8L/VQhz3bVRIZ3TdylDFpypkFFck0s52i+j/86fjrvB4xz2I+K4lErdPkm1lE
	8+Xzl3L0QHpkY
X-Google-Smtp-Source: AGHT+IEfAAI91TDLBhG8dPwDnnbKSbycBahi+QUq+TvuHTeJX7hqwRnpkMsJHWwJfltLyQBbY3rpYQ==
X-Received: by 2002:a17:907:9450:b0:b04:2697:9f60 with SMTP id a640c23a62f3a-b1be5a56e0dmr350288066b.13.1758120277776;
        Wed, 17 Sep 2025 07:44:37 -0700 (PDT)
Received: from gmail.com ([2a03:2880:30ff:5::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b07b3333e81sm1392912166b.94.2025.09.17.07.44.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 07:44:37 -0700 (PDT)
Date: Wed, 17 Sep 2025 07:44:34 -0700
From: Breno Leitao <leitao@debian.org>
To: John Ogness <john.ogness@linutronix.de>
Cc: Petr Mladek <pmladek@suse.com>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Mike Galbraith <efault@gmx.de>, linux-kernel@vger.kernel.org, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH printk v1 0/1] Allow unsafe ->write_atomic() for panic
Message-ID: <5hgyof3yowdw3v76ygz2oxkzv7vpz5kp62nx36gynmr646yrjs@ag4mvynlin4k>
References: <20250912121852.2666874-1-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250912121852.2666874-1-john.ogness@linutronix.de>

On Fri, Sep 12, 2025 at 02:24:51PM +0206, John Ogness wrote:
> Hi,
> 
> An effort is underway to update netconsole to support nbcon [0].
> Currently it is not known exactly how a safe ->write_atomic()
> callback for netconsole could be implemented. However, without
> ->write_atomic() implemented, there is guaranteed to be _no_
> panic output.
> 
> We decided to allow unsafe ->write_atomic() implementations to
> be used only as a last resort at the end of panic. This should
> allow netconsole to be updated to support nbcon and still
> provide panic output in "typical panic" situations.
> 
> I considered extending the feature to also allow such consoles
> to print using their ->write_thread() callback whenever it is
> known to be a sleepable context. However, this started to get
> quite complex. We can revisit this extended feature if it is
> determined that it is necessary.

Thanks for this patch! I've successfully adapted my PoC netconsole
implementation to work with NBCON using your modifications, and the
initial results are encouraging. With your patch and a corresponding
->write_atomic callback, I'm receiving the complete set of messages that
were previously available through the regular console interface.

Upon further consideration, it's worth noting that not all network
drivers rely on irq-unsafe locks. In practice, only a subset of drivers
use them, while most network drivers I'm familiar with maintain IRQ-safe
TX paths.

If we could determine the IRQ safety characteristics (IRQ-safe vs
IRQ-unsafe TX) during netconsole registration, this would enable more
optimized behavior: netconsole could register as CON_NBCON_ATOMIC_UNSAFE
only when the underlying network adapter uses IRQ-unsafe locks. For
adapters with IRQ-safe implementations, netconsole could safely utilize
the ->write_atomic path without restrictions.

FWIW, I am attaching the patch I used to test netconsole on top of your
changes. Keep in mind this is is calling TX patch with IRQ disabled
given the list is depending on IRQ-safe lock.

This will be fixed once I do the following:

1) move target_list to use RCU
2) Untangling netconsole from netpoll [1]
3) They are depending on a conflicting netpoll fix [2]

Link: https://lore.kernel.org/all/willemdebruijn.kernel.a0f67bb6112a@gmail.com/ [1]
Link: https://lore.kernel.org/all/20250917-netconsole_torture-v4-1-0a5b3b8f81ce@debian.org/ [2]

commit e9f4a292a49ae6d3da29f1dca39754180d2608d7
Author: Breno Leitao <leitao@debian.org>
Date:   Tue Aug 19 04:14:58 2025 -0700

    netconsole: Add support for nbcon
    
    Add support for running netconsole using the new non‑blocking console
    (nbcon) infrastructure.
    
    The nbcon framework improves console handling by avoiding the global
    console lock and enabling asynchronous, non‑blocking writes from
    multiple contexts.
    
    With this option enabled, netconsole can operate as a fully
    asynchronous, lockless nbcon backend, not depending on console lock
    anymore.
    
    This support is marked experimental for now until it receives wider
    testing.
    
    This depends on the CON_NBCON_ATOMIC_UNSAFE nbcon flag, and
    ->write_atomic is unsafe and only called with NBCON_PRIO_PANIC priority.
    
    Signed-off-by: Breno Leitao <leitao@debian.org>

diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
index b29628d46be9b..ec9a430aa160e 100644
--- a/drivers/net/Kconfig
+++ b/drivers/net/Kconfig
@@ -382,6 +382,16 @@ config NETCONSOLE_PREPEND_RELEASE
 	  message.  See <file:Documentation/networking/netconsole.rst> for
 	  details.
 
+config NETCONSOLE_NBCON
+	bool "Enable non blocking netconsole (EXPERIMENTAL)"
+	depends on NETCONSOLE
+	default n
+	help
+	  Move netconsole to use non-blocking console (nbcons).  Non-blocking
+	  console (nbcon) is a new console infrastructure introduced to improve
+	  console handling by avoiding the global console lock (Big Kernel
+	  Lock) and enabling non-blocking, asynchronous writes to the console.
+
 config NETPOLL
 	def_bool NETCONSOLE
 
diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index e3722de08ea9f..ac2f0ace45d6e 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -1692,6 +1692,97 @@ static void send_ext_msg_udp(struct netconsole_target *nt, const char *msg,
 				   extradata_len);
 }
 
+static void do_write_msg(struct netconsole_target *nt, const char *msg,
+			 unsigned int len)
+{
+	const char *tmp;
+	int frag, left;
+
+	/*
+	 * We nest this inside the for-each-target loop above
+	 * so that we're able to get as much logging out to
+	 * at least one target if we die inside here, instead
+	 * of unnecessarily keeping all targets in lock-step.
+	 */
+	tmp = msg;
+	for (left = len; left;) {
+		frag = min(left, MAX_PRINT_CHUNK);
+		send_udp(nt, tmp, frag);
+		tmp += frag;
+		left -= frag;
+	}
+}
+
+#ifdef CONFIG_NETCONSOLE_NBCON
+static void netcon_write_ext_atomic(struct console *con,
+				    struct nbcon_write_context *wctxt)
+{
+	struct netconsole_target *nt;
+
+	list_for_each_entry(nt, &target_list, list)
+		if (nt->extended && nt->enabled && netif_running(nt->np.dev)) {
+			if (!nbcon_enter_unsafe(wctxt))
+				continue;
+			send_ext_msg_udp(nt, wctxt->outbuf, wctxt->len);
+			nbcon_exit_unsafe(wctxt);
+		}
+}
+
+static void netcon_write_ext_thread(struct console *con,
+				    struct nbcon_write_context *wctxt)
+{
+	struct netconsole_target *nt;
+
+	list_for_each_entry(nt, &target_list, list)
+		if (nt->extended && nt->enabled && netif_running(nt->np.dev)) {
+			if (!nbcon_enter_unsafe(wctxt))
+				continue;
+			send_ext_msg_udp(nt, wctxt->outbuf, wctxt->len);
+			nbcon_exit_unsafe(wctxt);
+		}
+}
+
+/* regular write call backs */
+static void netcon_write_thread(struct console *con,
+				struct nbcon_write_context *wctxt)
+{
+	struct netconsole_target *nt;
+
+	list_for_each_entry(nt, &target_list, list)
+		if (!nt->extended && nt->enabled && netif_running(nt->np.dev)) {
+			if (!nbcon_enter_unsafe(wctxt))
+				continue;
+			do_write_msg(nt, wctxt->outbuf, wctxt->len);
+			nbcon_exit_unsafe(wctxt);
+		}
+}
+
+static void netcon_write_atomic(struct console *con,
+				struct nbcon_write_context *wctxt)
+{
+	struct netconsole_target *nt;
+
+	list_for_each_entry(nt, &target_list, list)
+		if (!nt->extended && nt->enabled && netif_running(nt->np.dev)) {
+			if (!nbcon_enter_unsafe(wctxt))
+				continue;
+			do_write_msg(nt, wctxt->outbuf, wctxt->len);
+			nbcon_exit_unsafe(wctxt);
+		}
+}
+
+/* locks call backs */
+static void netconsole_device_lock(struct console *con, unsigned long *flags)
+{
+	/* protects all the targets at the same time */
+	spin_lock_irqsave(&target_list_lock, *flags);
+}
+
+static void netconsole_device_unlock(struct console *con, unsigned long flags)
+{
+	spin_unlock_irqrestore(&target_list_lock, flags);
+}
+#else
 static void write_ext_msg(struct console *con, const char *msg,
 			  unsigned int len)
 {
@@ -1710,10 +1801,8 @@ static void write_ext_msg(struct console *con, const char *msg,
 
 static void write_msg(struct console *con, const char *msg, unsigned int len)
 {
-	int frag, left;
 	unsigned long flags;
 	struct netconsole_target *nt;
-	const char *tmp;
 
 	if (oops_only && !oops_in_progress)
 		return;
@@ -1723,24 +1812,13 @@ static void write_msg(struct console *con, const char *msg, unsigned int len)
 
 	spin_lock_irqsave(&target_list_lock, flags);
 	list_for_each_entry(nt, &target_list, list) {
-		if (!nt->extended && nt->enabled && netif_running(nt->np.dev)) {
-			/*
-			 * We nest this inside the for-each-target loop above
-			 * so that we're able to get as much logging out to
-			 * at least one target if we die inside here, instead
-			 * of unnecessarily keeping all targets in lock-step.
-			 */
-			tmp = msg;
-			for (left = len; left;) {
-				frag = min(left, MAX_PRINT_CHUNK);
-				send_udp(nt, tmp, frag);
-				tmp += frag;
-				left -= frag;
-			}
-		}
+		if (!nt->extended && nt->enabled && netif_running(nt->np.dev))
+			do_write_msg(nt, msg, len);
 	}
 	spin_unlock_irqrestore(&target_list_lock, flags);
 }
+#endif
+
 
 static int netpoll_parse_ip_addr(const char *str, union inet_addr *addr)
 {
@@ -1919,14 +1997,30 @@ static void free_param_target(struct netconsole_target *nt)
 
 static struct console netconsole_ext = {
 	.name	= "netcon_ext",
+#ifdef CONFIG_NETCONSOLE_NBCON
+	.flags	= CON_ENABLED | CON_EXTENDED | CON_NBCON | CON_NBCON_ATOMIC_UNSAFE,
+	.write_thread = netcon_write_ext_thread,
+	.write_atomic = netcon_write_ext_atomic,
+	.device_lock = netconsole_device_lock,
+	.device_unlock = netconsole_device_unlock,
+#else
 	.flags	= CON_ENABLED | CON_EXTENDED,
 	.write	= write_ext_msg,
+#endif
 };
 
 static struct console netconsole = {
 	.name	= "netcon",
+#ifdef CONFIG_NETCONSOLE_NBCON
+	.flags	= CON_ENABLED | CON_NBCON | CON_NBCON_ATOMIC_UNSAFE,
+	.write_thread = netcon_write_thread,
+	.write_atomic = netcon_write_atomic,
+	.device_lock = netconsole_device_lock,
+	.device_unlock = netconsole_device_unlock,
+#else
 	.flags	= CON_ENABLED,
 	.write	= write_msg,
+#endif
 };
 
 static int __init init_netconsole(void)

