Return-Path: <linux-kernel+bounces-879758-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id DE6C5C23F2E
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 09:56:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3F1E04E7695
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 08:56:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5CDF31A056;
	Fri, 31 Oct 2025 08:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KA6vJYco";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="x5I+KeLO"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 039F33176EF
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 08:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761900977; cv=none; b=X/S3OU9fCauFwMKEqw1Y+2gh8GqRoAF2D9agPw/3Co00tKaORZdjbGx9p6bgIybXhUSDfVWL12Fn+1tyhZouUNv/6BofYVfWZE2J/uEEH3urHFAGjDppeIZzCsNe5LG0LLSyGRgdNQ5JCqRxezzSjCo1XwzT2AJbmgRBex0Lp8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761900977; c=relaxed/simple;
	bh=iuDFykkDdPkE0VLPWpV6tBuaOMpsVLCTxOa1JGKjOeo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HnLqSMIbi/8TWTjVUw8koTHJX8ZaxOGmsbSEEBLxCKTsM4KJzcVga5NIvYT5ENKjW6g+C3PNp9NsyQ5Z3MXXtqsQAXwO9zQla5dbinH+B9V5DQBXCVqmmQZNb+QVdluRjfuuWPiUROH23c5M0Ujay0zyT6g2DzpjFEIFkkYblkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KA6vJYco; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=x5I+KeLO; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761900966;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iuDFykkDdPkE0VLPWpV6tBuaOMpsVLCTxOa1JGKjOeo=;
	b=KA6vJYcozWv7Wz4iz0T/ClS+OCtxkJCHrL2AR2BXm7akb7chCmvbalCsS+50AVwLe8brNH
	IxrOGDC3/cEq723yyG9EvtXl4N58kLCLalPoUahkYxkwbFOAFGus0exkdw5ArFBLt7jhnd
	2UL18o5hT/xoJfE6B1Q5qFOSkLqp+awxx92T4HgE2x+Mw4rOIy9p/1SMFViqoM/uNGinOA
	qw2NSWgi007iZ67XNIFnAbQ6ph/Ifhl7+NG4RuZUczo+Qfm2fmRunAQ7lZNiUCgreMx4rM
	JSleMtPiKP9w9Mw49FauxDn7VmCYmgQUic6M/h9cm0pbx+h0Z8sWsHOWn9Un7Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761900966;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iuDFykkDdPkE0VLPWpV6tBuaOMpsVLCTxOa1JGKjOeo=;
	b=x5I+KeLOOc/IpsHq4bfdJTnpTqKdM7wEkbj+5XAZXLFsn55Ahvfzm5HwwA4cgb9hF4i9EN
	b8mZ1sI5shFI1/AQ==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, Steven Rostedt
 <rostedt@goodmis.org>, Breno Leitao <leitao@debian.org>, Mike Galbraith
 <efault@gmx.de>, linux-kernel@vger.kernel.org, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>
Subject: Re: [PATCH printk v2 1/1] printk: nbcon: Allow unsafe
 write_atomic() for panic
In-Reply-To: <aQN-NeWzlxtWDLXF@pathway.suse.cz>
References: <20251027161212.334219-1-john.ogness@linutronix.de>
 <20251027161212.334219-2-john.ogness@linutronix.de>
 <aQN-NeWzlxtWDLXF@pathway.suse.cz>
Date: Fri, 31 Oct 2025 10:02:06 +0106
Message-ID: <87346z5u1l.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2025-10-30, Petr Mladek <pmladek@suse.com> wrote:
> The patch looks good to me:
>
> Reviewed-by: Petr Mladek <pmladek@suse.com>

Thanks.

> That said, it needs one more hunk to fix build with the patchset
> adding support for nbcon into kdb which is
> in https://git.kernel.org/pub/scm/linux/kernel/git/printk/linux.git/

[...]

> Also there is one trivial conflict with the new branch which is
> preventing hardlockups in atomic flush which is
> https://git.kernel.org/pub/scm/linux/kernel/git/printk/linux.git/log/?h=rework/atomic-flush-hardlockup
>
> Namely, it is the last patch which moves nbcon_context_try_acquire()
> into to while cycle, see
> https://git.kernel.org/pub/scm/linux/kernel/git/printk/linux.git/commit/?h=rework/atomic-flush-hardlockup&id=d5d399efff65773ed82ddaf6c11a0fcfdb5eb029

I can send a new patch that takes all these underlying series into
account... assuming it is going through the printk tree.

> I am not sure how to move forward. IMHO, the original plan was to push
> this patch together with the other netconsole-related changes. In this
> case, the conflicts will need to be solved when merging pull requests
> from netconsole and printk trees. Well, the conflicts are trivial.
>
> Or I could push this patch via the printk tree and queue it for 6.19.
> But this might be too late for netconsole.

@Breno: This new feature only exists for netconsole at the moment, so I
am fine with it going through the netconsole tree. But we need to decide
this soon because there are a lot of printk-changes queued for 6.19 that
conflict with this patch and we should get those sorted out sooner
rather than later. (Note that the patch in its current form will also
conflict with the netconsole tree, so regardless of our decision I need
to submit a new version.)

John

