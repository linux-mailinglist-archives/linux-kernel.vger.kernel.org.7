Return-Path: <linux-kernel+bounces-751734-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C29BB16CDC
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 09:45:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D5A81AA5FC3
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 07:45:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9584529DB78;
	Thu, 31 Jul 2025 07:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fG6gk7d2";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XV4eKtA9"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96F5C29DB8B
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 07:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753947911; cv=none; b=YELmNubkD9asz4Kps2OaY0Qr1gCKw0oCVZ2OOuYkzSby7VAdj34tnPxkMDRlipceQCXLpWfCTdGev2WBGQ5muIKaIF1KsfoMtUsVrCHMTFupLv+1U34kF4k9eOilPVPIBlSFX0EprftEjEUfYhiHx/1m5qZVYt3WAzYbpmRfWWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753947911; c=relaxed/simple;
	bh=a6yR5tNct5qMW4Sdi02EPj9NR3vfn29qlGgB4gxe73c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=vEPiRAXHRL7OxAF5zHDQM29NUFkBXO2fjM8syXv66yCmPdldA3hVNj7QbciAY21PQXUuxU7R6CMuN5sNbAK7yCNtYJ5q2CHIsZfXgpYsRCMnjxrpMFgGXqzH9KnbG5R3ZzijljWFPKJm2GA34aaHYb3JgAoNGUh7uUYfxHJ+d5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fG6gk7d2; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XV4eKtA9; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1753947907;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eV2+A95kzNQDZx82boJU8ARGwT2estI0efyX7fFc+OI=;
	b=fG6gk7d2fesT3DaGS7cfQ1Zs1amiCadZ9Tgvftqlz7PDltpkCeRZ2sqY6ZSUZbOnDcbxYi
	LLacu1lo0JKwMOWZQf3iLXJf+TQyXifjNiTXGoVYc1M2SKMcxH9yZCwKYi5cc7aIonZBYI
	KnG2qa0Mg8cUciOmsRqEApl+DpjBCJgk7H4SGMj1EuaJmnSBbSUoOm2Q3H97rCKXFA8Ij8
	51fl76yV5NDhZWxKTqvUOUsqBZzQaugdkCjVPiHHJe+ItHFjcKSKG/s/UiAWgHVh4KCzK8
	49n7iW8ggdRH1jCs3p0r7VaHuVCwTq7sP75utAvOtFQFNwGl4x4Gwr/fEJsVng==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1753947907;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eV2+A95kzNQDZx82boJU8ARGwT2estI0efyX7fFc+OI=;
	b=XV4eKtA9wbylkCSUifqIwlk9dJRJG6dRCvxfEVoJ3XFhOj6yEap6OQx6mgCUDCpTqrkKwM
	bId/q+/IbyWWuNDg==
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, Andrew Morton
 <akpm@linux-foundation.org>, Petr Mladek <pmladek@suse.com>, Feng Tang
 <feng.tang@linux.alibaba.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] panic: remove redundant panic-cpu backtrace
In-Reply-To: <2kwymhiz4fcozfmbmj6ju2qatsbmnrtiidfa4nxrqutgwa6xfy@dbf3caohbbay>
References: <20250731030314.3818040-1-senozhatsky@chromium.org>
 <84seichm5t.fsf@jogness.linutronix.de>
 <2kwymhiz4fcozfmbmj6ju2qatsbmnrtiidfa4nxrqutgwa6xfy@dbf3caohbbay>
Date: Thu, 31 Jul 2025 09:51:07 +0206
Message-ID: <84pldghkho.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2025-07-31, Sergey Senozhatsky <senozhatsky@chromium.org> wrote:
> On (25/07/31 09:15), John Ogness wrote:
>> On 2025-07-31, Sergey Senozhatsky <senozhatsky@chromium.org> wrote:
>> > SYS_INFO_ALL_CPU_BT sends NMI backtrace request to
>> > all CPUs, which dumps an extra backtrace on panic CPU.
>> 
>> Isn't this only true if CONFIG_DEBUG_BUGVERBOSE=y?
>
> Are you referring to vpanic()->dump_stack()?

Yes.

> Another way to get backtrace on panic CPU is via BUG(), which routes
> through die()->__die_body(), which prints registers, stack trace,
> and so on, before it calls into panic().  This might be x86 specific,
> though.

So in that case you see 2 stack traces if CONFIG_DEBUG_BUGVERBOSE=y?

>> Also, the information is not the same. trigger_all_cpu_backtrace() will
>> also dump the registers. For CONFIG_DEBUG_BUGVERBOSE=y on the panic CPU,
>> only the stack is dumped.
>
> Hmm, it's getting complicated, probably isn't worth it then.

I think it is worth cleaning up, but it probably won't be such a simple
fix. All call paths of redundant stack trace printing should be
identified and then we can decide on a clean solution.

John

