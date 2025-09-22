Return-Path: <linux-kernel+bounces-827084-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A68C0B9040B
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 12:48:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F357B188BA07
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 10:46:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCE7F303CB7;
	Mon, 22 Sep 2025 10:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1/zJbftn";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CBfUPWPi"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 824F32D4803
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 10:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758537849; cv=none; b=HxLplYZJDqvcpMgXlBmg/DbmvqYXgiaFbyz226oBISH1mzB2qwsyfVoE8vGtuDoBdy64sPG7HHcen3hFDOliipsMQdnFFcOyRKBc9qt9LLhwigGai8Aa0tZMpGw6RoPt4ACQHx1yrDD2KCmkq+TezPQTEO3hh5F4JDWjbHy+j/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758537849; c=relaxed/simple;
	bh=AlI+YKP8Q8Qoq1o9l54rYqFn7v+S33Yx+Mfa6s0Be6U=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=AtenqlZZBOByLouIWf6a049qmsnGU/ziCix5ZKb+HJc/r3iSaZ6LHQ+4VHocqaBK7dspkGZw3wzTtGPZA54bgb74Yvbd9pUyOC75lTuS+QyGVW5Fs2j+VbmluLgEEzr18ThqaZkUmPpWwKm6jSzvwrs09mqTFjdB35exzmGpSoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1/zJbftn; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CBfUPWPi; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1758537845;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2crP/7XMTvATF7qwRd2Qrq5+AyOo/h10TvTDPHrTCHM=;
	b=1/zJbftnkJyG64lU2eFOFWq+l+mWseVycXC5BzrbM2gZj3rvwGposb4R4M68EvEuUQf5Aj
	S3kSMweBLe9LPb0hbYw4H+JJRgCC+EO23OPTUv8IamuPK0hPZSxwZbDE9gsh99SZVWDwEf
	v3euiyrLErqwwKOyCqGyTEjspFQDICj1PlcrvBt0lBgGKQ0qPjnISeI/GnzDQnKkLnojDf
	zoyBHifRAg3mk4fxEaGLKLkggppajItyoyAtVspTQNiUSyREfi2Kn+PssICJaHlY7N3GLN
	RgVTp4Sv3KnN/QYiyyUVI6giW20f5IOcJUNBOMDnkiKc1Hq3jOqW2evwdhho1A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1758537845;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2crP/7XMTvATF7qwRd2Qrq5+AyOo/h10TvTDPHrTCHM=;
	b=CBfUPWPihvc3BOfnH8LYNyZDjfQMAu5AfpBtdBcv3nNJCNFYWkxBbEazymKrSrUvD6eOxl
	XOo8iDLDirH9wkBw==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, Steven Rostedt
 <rostedt@goodmis.org>, Breno Leitao <leitao@debian.org>, Mike Galbraith
 <efault@gmx.de>, linux-kernel@vger.kernel.org, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>
Subject: Re: [PATCH printk v1 1/1] printk: nbcon: Allow unsafe
 write_atomic() for panic
In-Reply-To: <aMq80xcRtQbthDiT@pathway.suse.cz>
References: <20250912121852.2666874-1-john.ogness@linutronix.de>
 <20250912121852.2666874-2-john.ogness@linutronix.de>
 <aMl8xX9QCM9jslLH@pathway.suse.cz> <848qidw8ip.fsf@jogness.linutronix.de>
 <aMq80xcRtQbthDiT@pathway.suse.cz>
Date: Mon, 22 Sep 2025 12:50:04 +0206
Message-ID: <848qi6kbrf.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2025-09-17, Petr Mladek <pmladek@suse.com> wrote:
>> After weighing the pros/cons I think that a global variable makes the
>> most sense. It will simplify internal APIs and provide all
>> console_is_usable() users a correct value. And the end result is no
>> different than what we do now.
>> 
>> We could also keep its setting inside nbcon_atomic_flush_unsafe() so
>> that the variable remains a printk-internal variable.
>
> Sounds good to me.

Right now things are a bit of a mess with required changes sitting in
printk and mm trees. Since this won't be going in to the upcoming merge
window, I will wait with v2 until you (Petr) can officially rebase the
printk tree to include the recent panic_*cpu*() changes. That will also
make it easier to coordinate the upcoming console_is_usable() changes as
well.

The functionality for v2 is the same as the v1, so the network folks can
continue working on the nbcon netconsole implementation.

@Breno: Or were you planning on pushing the nbcon netconsole for the 6.18
merge window next week? (I would guess no.)

John

