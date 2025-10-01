Return-Path: <linux-kernel+bounces-839181-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C1D86BB0FD3
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 17:12:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 55CB619C3021
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 15:09:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BCD21EB5C2;
	Wed,  1 Oct 2025 15:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mPczA7C5";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="I4KgKjhe"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72A3C46BF
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 15:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759331342; cv=none; b=CHcRz7IBKl9dSkH1zbOhhZuxongSYjHumlLc04ijfAgqFLeq4aSzLyVbwubhaWpKQDGQOwhmiAK6MYSM7TxcjfSp07GGzKg83mLV5zJ2tfVHTehba7xLtedgVV4leEldWXgWHw6JHx5h3lTIjzvWckHS/jxMi1aZ07QSrjbOBB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759331342; c=relaxed/simple;
	bh=96VGdzIdn163X2/8v2Z0GnkMDfBtTd/Ib9HyGZZOKYc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kxCKYg3MnY4BFfis3Fo4gFo/826h+FzMQqxuRgqZ1uLdWk+/UORZnceKFBzxRwzNLY9JLVPnb3zCi4k7DHqTd9XS7/Cbiqp2NL660etACe3xvAYAaSg5pA/qPpLDzhbWBiuAoGSp6CPfQlr8SZVy+5nfJdlKZ3FBwflTOn3P98o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mPczA7C5; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=I4KgKjhe; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1759331337;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fguV5cbsHKuUFApAwnvZw5d5Ai6OoR9oWuiwl4vfpSM=;
	b=mPczA7C5nO//5gBKxPj1IEDbHuF7u0K6htFM12e0aCufPawyBemSSoaY5U5nJYODzMf5ri
	3pebGEM8NyK1AAeQIZ3djORNgGcsMrNih7FJetrPt+NQ8RIDZEPS95TPS8laUeoRq9rv8R
	ncBxU6ku90iLFOop2LnFGP22NZKSqXEqBza0NAXcwskpVEVKWZsYc8L31Xjn9RuGOIq6/D
	vvj13BlecZ4/cyN8o0NgvTkTPStUImNt7E0XUNVXOwQtaIjRcVH21rgw8l11o0SX8FBD+0
	9DvOvgQTiZApi/UiaVMWhSO0gk0lJZOHazzO66HYcmHb22Wj9YZPjlTfdGhxWw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1759331337;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fguV5cbsHKuUFApAwnvZw5d5Ai6OoR9oWuiwl4vfpSM=;
	b=I4KgKjhehQ1b3il3f4YFTcfw3/+mUM9oRJLE8/F71S55E9uzBqoRu6kuli6Qlx6i3E3isx
	JhW1F5lAJGdQlICg==
To: Marcos Paulo de Souza <mpdesouza@suse.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Petr Mladek <pmladek@suse.com>, Steven
 Rostedt <rostedt@goodmis.org>, Sergey Senozhatsky
 <senozhatsky@chromium.org>, Jason Wessel <jason.wessel@windriver.com>,
 Daniel Thompson <danielt@kernel.org>, Douglas Anderson
 <dianders@chromium.org>
Cc: linux-kernel@vger.kernel.org, kgdb-bugreport@lists.sourceforge.net,
 Marcos Paulo de Souza <mpdesouza@suse.com>
Subject: Re: [PATCH v5 4/5] printk: nbcon: Export nbcon_write_context_set_buf
In-Reply-To: <20250930-nbcon-kgdboc-v5-4-8125893cfb4f@suse.com>
References: <20250930-nbcon-kgdboc-v5-0-8125893cfb4f@suse.com>
 <20250930-nbcon-kgdboc-v5-4-8125893cfb4f@suse.com>
Date: Wed, 01 Oct 2025 17:14:56 +0206
Message-ID: <84bjmqhd6f.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2025-09-30, Marcos Paulo de Souza <mpdesouza@suse.com> wrote:
> diff --git a/kernel/printk/nbcon.c b/kernel/printk/nbcon.c
> index 6e4641350fe8985438f53bcd32f3adf72d9d6835..2492b14bd272562378c4cdb465eea2269638e127 100644
> --- a/kernel/printk/nbcon.c
> +++ b/kernel/printk/nbcon.c
> @@ -854,7 +854,7 @@ static bool __nbcon_context_update_unsafe(struct nbcon_context *ctxt, bool unsaf
>  	return nbcon_context_can_proceed(ctxt, &cur);
>  }
>  
> -static void nbcon_write_context_set_buf(struct nbcon_write_context *wctxt,
> +void nbcon_write_context_set_buf(struct nbcon_write_context *wctxt,
>  					char *buf, unsigned int len)

Could we also update the whitespace on the 2nd line? And it would all
fit on one line if you want.

John

