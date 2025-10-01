Return-Path: <linux-kernel+bounces-839179-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 92FDDBB0FC4
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 17:12:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA79418836EA
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 15:09:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E6C725CC42;
	Wed,  1 Oct 2025 15:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0ul3tkBk";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZDknhNYA"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 594951D5CC6
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 15:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759331121; cv=none; b=S4rduHOyywPAEFFvoSZbfZe+yFzxrRYy3CqfAIGV2+0TrpBscsZkvq4uBMBmZ8NoavJFSdiEpfeEeNLCysfGoj0NKVXnyMz7CGp9zVjfoiTcZGtGaxMo+livoRElMV8zeKV5SWXmzgfrn01XiUDdIIJAG37y8KCYUS1Ad87Vt6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759331121; c=relaxed/simple;
	bh=y7WlVOUvyteV26l8RUbjwsQsfVeujp8NN4q+CXKabq8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KywW5WEAQSpA8NdLUZpCjWyM98oEeeegNPJW6yl5kDj+q9RfKKEoIY6zjLKge7VSU/dChhqdiz9+mOxnRl9Ihire+SGvRbiaF5nK7AHZ4cEtDQKEVlE3HIka4NXtGuoeIBg1Pszr+JZPk+EIgTSu54Qb0lEvYvwXnWJLK5Vvd/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0ul3tkBk; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZDknhNYA; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1759331118;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LYgUmX9oFXqBlVnDhkhcIzkt3iPl24PQrTnT2nPcvZ8=;
	b=0ul3tkBkJ34uPGNuGvXkMe0pYMzlNfnO4qXuISckCo/iXfuBbTGt28u3fST3LIewDyDqDP
	YY9/4tRkqhRiokwGoPT/4Z75em5t0FhR9oweHXrrItVc+bO280FYT85f6UrXqo9wXYehU3
	Mk5RXZWzGvhkmxZzrbjHdok+lFUoO9JIBRgDR8YnyaIeBbWed1n/po6q0YAM+DleA3bLJ6
	X8tqvuieP5kZsYPhJlFeEl29PRtKcjstjzRbEgswZnMJsVlvY8YEoTr33JE3/Hegx3t4gA
	Ffdc16DZlfjFH/3ZF9LPNkKiJGzrZ5+SHbs7sfhbFFZZb3MbSlzMZeCPZ6HQaQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1759331118;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LYgUmX9oFXqBlVnDhkhcIzkt3iPl24PQrTnT2nPcvZ8=;
	b=ZDknhNYA3vw3mn9F98cbAYhxhsVpYfkPxsq/XfouNS9zDokzkHiCisCpCQ9MjkyMLon1EW
	5ZVWRJHUu4kAV4Cg==
To: Marcos Paulo de Souza <mpdesouza@suse.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Petr Mladek <pmladek@suse.com>, Steven
 Rostedt <rostedt@goodmis.org>, Sergey Senozhatsky
 <senozhatsky@chromium.org>, Jason Wessel <jason.wessel@windriver.com>,
 Daniel Thompson <danielt@kernel.org>, Douglas Anderson
 <dianders@chromium.org>
Cc: linux-kernel@vger.kernel.org, kgdb-bugreport@lists.sourceforge.net,
 Marcos Paulo de Souza <mpdesouza@suse.com>
Subject: Re: [PATCH v5 3/5] printk: nbcon: Allow KDB to acquire the NBCON
 context
In-Reply-To: <20250930-nbcon-kgdboc-v5-3-8125893cfb4f@suse.com>
References: <20250930-nbcon-kgdboc-v5-0-8125893cfb4f@suse.com>
 <20250930-nbcon-kgdboc-v5-3-8125893cfb4f@suse.com>
Date: Wed, 01 Oct 2025 17:11:17 +0206
Message-ID: <84ecrmhdci.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2025-09-30, Marcos Paulo de Souza <mpdesouza@suse.com> wrote:
> diff --git a/include/linux/kdb.h b/include/linux/kdb.h
> index ecbf819deeca118f27e98bf71bb37dd27a257ebb..36b46c85733fe1df28cde7760e5c26e96de40c05 100644
> --- a/include/linux/kdb.h
> +++ b/include/linux/kdb.h
> @@ -207,11 +207,26 @@ static inline const char *kdb_walk_kallsyms(loff_t *pos)
>  /* Dynamic kdb shell command registration */
>  extern int kdb_register(kdbtab_t *cmd);
>  extern void kdb_unregister(kdbtab_t *cmd);
> +
> +/* Return true when KDB as locked for printing a message on this CPU. */
> +static inline
> +bool kdb_printf_on_this_cpu(void)
> +{
> +	/*
> +	 * We can use raw_smp_processor_id() here because the task could
> +	 * not get migrated when KDB has locked for printing on this CPU.
> +	 */
> +	return unlikely(READ_ONCE(kdb_printf_cpu) == raw_smp_processor_id());
> +}
> +
>  #else /* ! CONFIG_KGDB_KDB */
>  static inline __printf(1, 2) int kdb_printf(const char *fmt, ...) { return 0; }
>  static inline void kdb_init(int level) {}
>  static inline int kdb_register(kdbtab_t *cmd) { return 0; }
>  static inline void kdb_unregister(kdbtab_t *cmd) {}
> +
> +static inline bool kdb_printf_on_this_cpu(void) { return false };
> +
>  #endif	/* CONFIG_KGDB_KDB */
>  enum {
>  	KDB_NOT_INITIALIZED,

The include for raw_smp_processor_id() is also needed:

diff --git a/include/linux/kdb.h b/include/linux/kdb.h
index 36b46c85733fe..db9d73b12a1af 100644
--- a/include/linux/kdb.h
+++ b/include/linux/kdb.h
@@ -14,6 +14,7 @@
  */
 
 #include <linux/list.h>
+#include <linux/smp.h>
 
 /* Shifted versions of the command enable bits are be used if the command
  * has no arguments (see kdb_check_flags). This allows commands, such as

