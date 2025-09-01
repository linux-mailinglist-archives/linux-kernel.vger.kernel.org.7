Return-Path: <linux-kernel+bounces-794526-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6320CB3E2E3
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 14:30:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5A7484E1D09
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 12:30:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A65B3277BF;
	Mon,  1 Sep 2025 12:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Q5Qk+127";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2JD+Pp+e"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A2B230F81F
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 12:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756729624; cv=none; b=urj+AkijzZzI4wyGd5k5KoUfg3AJKnTaf5W3TVgbCDp5IjGG6wGBR678T6QvqqyHIDYqpvmZQmyliCmkLUd8c0r34G9YRZs5mIKKzuRSHTrVsRo+KbfKIu9tBN7qrpHitf0hmyrD9/xpOHD6y2F7Cl7eopc6chtSD9j4mLAJQtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756729624; c=relaxed/simple;
	bh=9wiDbBI9M5vxzXr9ac0bcV09NfOny2XpjgsYzok5KH0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lWTbE92+OkR2eD/zyyBhXMLeXoBgvrsxlQzz08o/b3Lkzhq+uTtsA0/yqFnTaJjgrc1xUEyGF3S/E5DWsK8DX76uw03nALDYz5Au7YHz9CnModBEzrYLtXypo23v/ZWzjheS/EGc7vxL9+W9qLtypTubiVhPmZSmQL9YKKZ/m04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Q5Qk+127; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2JD+Pp+e; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1756729621;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RV3gTTTp4ssTmWwaO0d/6rvk9d+lygaUTsck7J1Xt4c=;
	b=Q5Qk+127/4/N+Y7srzk9VoqJOkeBM+ICdjafJ6yX+6X+LcTaCCpJPL1AhDodutRb/81uOd
	IwDqa3m5OP3VRVpSP+cWD53EYf0JQY7nOU1EH2dUJDFVHU+5HXauucUxPiIQsd+xQDOlkm
	x79G5FYVVroDLFtts/xSFTLV1hLqDt+h6a09yezKTGaN6Xj9RcAX5cstPUjL+K1w9gRzSZ
	zaFQQWxQQt5IWteDro4vCAFb44zx9YYs8rhwekH8YqSbHFhdOXwjin9/+sV/B0bNSGXzVd
	ev6Nh8/cgHEfTxlyMSW3V8sOMW5kOBaMzQ076iCDyBWG5bXFKhqbCettqrf14Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1756729621;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RV3gTTTp4ssTmWwaO0d/6rvk9d+lygaUTsck7J1Xt4c=;
	b=2JD+Pp+eMZJFj3djv9Mo7vCURdR9J567BCk343FXBvSX/O27k0Ctukf38/AeJwi6gEt+oZ
	a9Oeusmt9Xm3IcDQ==
To: Petr Mladek <pmladek@suse.com>
Cc: Marcos Paulo de Souza <mpdesouza@suse.com>, Daniel Thompson
 <daniel@riscstar.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Steven Rostedt <rostedt@goodmis.org>, Sergey Senozhatsky
 <senozhatsky@chromium.org>, Jason Wessel <jason.wessel@windriver.com>,
 Daniel Thompson <danielt@kernel.org>, Douglas Anderson
 <dianders@chromium.org>, linux-kernel@vger.kernel.org,
 kgdb-bugreport@lists.sourceforge.net
Subject: Re: [PATCH v2 3/3] kdb: Adapt kdb_msg_write to work with NBCON
 consoles
In-Reply-To: <aLWHmY9_I4rbV0wG@pathway.suse.cz>
References: <20250811-nbcon-kgdboc-v2-0-c7c72bcdeaf6@suse.com>
 <20250811-nbcon-kgdboc-v2-3-c7c72bcdeaf6@suse.com>
 <aJoAYD_r7ygH9AdS@aspen.lan>
 <6035c35f72eb1ac8817396ca08aae71d097ca42c.camel@suse.com>
 <84h5xukti3.fsf@jogness.linutronix.de> <aLGoBDapczoLH9-Y@pathway.suse.cz>
 <84v7m6gqsz.fsf@jogness.linutronix.de> <aLWHmY9_I4rbV0wG@pathway.suse.cz>
Date: Mon, 01 Sep 2025 14:33:00 +0206
Message-ID: <84plca5pez.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2025-09-01, Petr Mladek <pmladek@suse.com> wrote:
> What about the following race?
>
> kdb_printf_cpu = -1  (0xffffffff)
>
> CPU 0xff				CPU 0x1
>
> 					panic()
>
> printk()
>   nbcon_atomic_flush_pending()
>      nbcon_context_try_acquire_direct()
> 	# load low byte of kdb_printf_cpu
> 	val = 0xff
>
> 					vkdb_printf()
> 					  cmpxchg(&kdb_printf_cpu, ...)
> 					  kdb_printf_cpu == 0x1
>
> 	# load higher byte of kdb_printf_cpu
> 	val = 0xff
>
> Result: CPU 0xff would be allowed to acquire the nbcon context
> 	because it thinks that vkdb_printf() got locked on this CPU.
>
> 	It is not fully artificial, see
> 	https://lwn.net/Articles/793253/#Load%20Tearing
>
> The above race is not critical. CPU 0x1 still could wait for CPU 0xff
> and acquire the nbcon context later.
>
> But it is something unexpected. I would feel more comfortable if
> we used the READ_ONCE() and be on the safe side.

Agreed.

John

