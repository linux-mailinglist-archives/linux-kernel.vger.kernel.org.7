Return-Path: <linux-kernel+bounces-867001-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D7CCC014FD
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 15:17:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2801D35A83F
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 13:17:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24C5D3019DA;
	Thu, 23 Oct 2025 13:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="uuDUdsMd";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="uMNG8LmK"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1901F28E00
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 13:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761225438; cv=none; b=s0AzEiIRVYGo7eNPyWlLjOuSZ6tPw7lQhYBJu5n0YU58CXXahnwTVGnieimqfMy3T5xlfvGUcqcSLjhdWQ7ly6jtoMhT7cvimT2bKei55YxNg649HYIme5iLmIgHLJp17l8S/ZPSS+x9YKdfkyeLnwUMEG4Hv/kTgANrOYAMh+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761225438; c=relaxed/simple;
	bh=jhWRGl8zuZQkBeFFZQuq/ayCm7CfpSMhiyrB1d/XAyU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=A7rNYQlgCswvWDaNlelcjbzyq2PqXV1LKCTQU5UhcO+d5eFuK0a31gfml3rc4kDqD8zrZ8tGggF0z9itmT2O07aFZg4L7PXKZ/isMDFuft+mccgjiJ75+4Zq5RbF+JHVBprjRO4mf4R3SwfcvItqPaAiUeGxOqkTxTEXxXeiPtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=uuDUdsMd; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=uMNG8LmK; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761225434;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jhWRGl8zuZQkBeFFZQuq/ayCm7CfpSMhiyrB1d/XAyU=;
	b=uuDUdsMdCQnJBFmTrlWk/MJkImvYmNYwCHRkzOH5Xs0hwvv14MtfO0QeUZthH7ZyUT4gq6
	dLa+V/0Cq6Ideb8rRsCJgBfCyWnJZpTmjUU/cWI6WgSsJOl4Wd9niM4wwGIPYh81dsb52i
	MwKBNy5rOIcEdHoJ3WORBlZRQUqSQOc518EIqnHQrxes8KDQrKrUwcu6xrxEbCyxMz9uXq
	9FqggSX3qZj86+HzcPZSgpuKIC89GLgviM+ZMzig0H866VlG1L+nuqeIIccQqBsOYY9bhH
	sPax7MHPwZBl9s4fEAefUCcYk8PSno78I5Yi7MEMNKDzcYkNQTHmbAVzw2pYew==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761225434;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jhWRGl8zuZQkBeFFZQuq/ayCm7CfpSMhiyrB1d/XAyU=;
	b=uMNG8LmKwq/unH46wThHgDe1yjdCeJX0QpueHJovZaEH5qm/2BnoiIu3GC9geXWdj3WnV/
	93+lGo+n81TLtRCQ==
To: Andrew Murray <amurray@thegoodpenguin.co.uk>, Petr Mladek
 <pmladek@suse.com>, Steven Rostedt <rostedt@goodmis.org>, Sergey
 Senozhatsky <senozhatsky@chromium.org>
Cc: linux-kernel@vger.kernel.org, Andrew Murray <amurray@thegoodpenguin.co.uk>
Subject: Re: [PATCH v3 1/3] printk: Introduce console_flush_one_record
In-Reply-To: <20251020-printk_legacy_thread_console_lock-v3-1-00f1f0ac055a@thegoodpenguin.co.uk>
References: <20251020-printk_legacy_thread_console_lock-v3-0-00f1f0ac055a@thegoodpenguin.co.uk>
 <20251020-printk_legacy_thread_console_lock-v3-1-00f1f0ac055a@thegoodpenguin.co.uk>
Date: Thu, 23 Oct 2025 15:23:14 +0206
Message-ID: <875xc5dag5.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2025-10-20, Andrew Murray <amurray@thegoodpenguin.co.uk> wrote:
> console_flush_all prints all remaining records to all usable consoles
> whilst its caller holds console_lock. This can result in large waiting
> times for those waiting for console_lock especially where there is a
> large volume of records or where the console is slow (e.g. serial).
>
> Let's extract the parts of this function which print a single record
> into a new function named console_flush_one_record. This can later
> be used for functions that will release and reacquire console_lock
> between records.
>
> This commit should not change existing functionality.
>
> Reviewed-by: Petr Mladek <pmladek@suse.com>
> Signed-off-by: Andrew Murray <amurray@thegoodpenguin.co.uk>

Reviewed-by: John Ogness <john.ogness@linutronix.de>

