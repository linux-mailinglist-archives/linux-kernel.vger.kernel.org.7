Return-Path: <linux-kernel+bounces-792660-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 33E11B3C753
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 04:18:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D7B2E5877B9
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 02:18:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00F1C24677C;
	Sat, 30 Aug 2025 02:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FfJRqcb1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BBFE30CDA5
	for <linux-kernel@vger.kernel.org>; Sat, 30 Aug 2025 02:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756520286; cv=none; b=dY/wlDfh1kn/lJcBRFTgjy0dcczk8Dpc7a726G4vlGKRsgAQwkRaxRJ5SWHeIFYuPaGi9mUxePGnQUFI97hgr2aLtPITHhk6PCFrWit9UN6xRRSwKv7UIwwT5+E091ySfNFyU6BKCBE0hWEK1bbQ+mDSufOs1dXjwTEtjm6QXTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756520286; c=relaxed/simple;
	bh=bUBluuTylB9s+IacH8z7i+pHhFqECBqPWsTD+uvyOGE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rZ61Enj76Towr67pqtHY9veyKU7GMTqK9fYxB6c50ArywZjK7o80VYSQqFfNziit+MV6eI8lqVb4sBTQczYSoAlmmdScMbAWNrDpPKhfr72yO7j+/4KYW+H5kADOt9aIM+tVCWKC8XsbMxQEYtLYwvngc1VA509NESW0bWsqwOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FfJRqcb1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4291DC4CEF0;
	Sat, 30 Aug 2025 02:18:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756520285;
	bh=bUBluuTylB9s+IacH8z7i+pHhFqECBqPWsTD+uvyOGE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FfJRqcb1+9wvALUWGm/eeBgZ0mFEkGsx5yXQ7f6ojj+lRUQJogtnNzMOaUWh2st8R
	 EyzDAm14tlgSohfASDXlxCBTZodmbOkTjSnJMRs/S6KbfwwS9meftAcIYtzMLM1UYE
	 e+UqQsPknUQN444LsRIfsjmCWG1CtSf/j4bvEKkqXm2E2xVjYhcQYuM24tRCzkgbM/
	 ENtp8ATWWkkje3Fh9o0Ie6VI7uQ7MoH8I/bjegVeRn4NLnTDfGn6/88ZIjTtYSaUyZ
	 LYFBLotVwA9ZcSEqGO0rAYKs3QbjipMrkrcbczid6ieFArLS5w1dDfqurG/FlD173i
	 ngX5TJacAgbYQ==
Date: Fri, 29 Aug 2025 19:18:02 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Tengda Wu <wutengda@huaweicloud.com>
Cc: x86@kernel.org, Andrey Ryabinin <ryabinin.a.a@gmail.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Alexander Potapenko <glider@google.com>, Andrey Konovalov <andreyknvl@gmail.com>, 
	Borislav Petkov <bp@alien8.de>, Dmitry Vyukov <dvyukov@google.com>, 
	Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next v2] x86: Prevent KASAN false positive warnings in
 __show_regs
Message-ID: <372iwvlxzynnnzn42wo2kur5enrlzzcqqnx5gx6o6bnfyqqlgx@p7drg4of3sdc>
References: <20250829094744.3133324-1-wutengda@huaweicloud.com>
 <xlaeuraw7mupek3fp62o7ahp5viusp6uo36jadtuidpwwkmy6a@5pzmlcxtb2ro>
 <ac1bb376-5b16-4d06-81a2-8d15315beba2@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ac1bb376-5b16-4d06-81a2-8d15315beba2@huaweicloud.com>

On Sat, Aug 30, 2025 at 09:34:59AM +0800, Tengda Wu wrote:
> 
> 
> On 2025/8/30 5:01, Josh Poimboeuf wrote:
> > On Fri, Aug 29, 2025 at 09:47:44AM +0000, Tengda Wu wrote:
> >>  static void show_regs_if_on_stack(struct stack_info *info, struct pt_regs *regs,
> >>  				  bool partial, const char *log_lvl)
> >>  {
> >> +	bool kasan_disabled = false;
> >> +
> >> +	/*
> >> +	 * When 'regs' resides in another task's stack space, KASAN should be
> >> +	 * disabled to prevent false positives during 'regs->' operation, as
> >> +	 * the 'regs' contents may change concurrently with task execution.
> >> +	 */
> >> +	if (!object_is_on_stack(regs)) {
> >> +		kasan_disable_current();
> >> +		kasan_disabled = true;
> >> +	}
> > 
> > I don't think this is right.  object_is_on_stack() only checks current's
> > *task* stack.  However the regs might be on a different stack used by
> > current (e.g., exception stack).  In which case there's no need to
> > disable KASAN.
> > 
> > What really determines the KASAN-safety is whether it's the current task
> > or not.
> > 
> 
> I see.
> 
> Since operations walking other tasks' regs-> only occur in show_regs_if_on_stack,
> to cover a more accurate range and targets, it seems we have no choice but to add
> a task parameter to show_regs_if_on_stack and then perform the check, right?

Reading another task's stack while it's running is problematic in
general -- not only for reading saved regs, but for reading any other
values on the stack.  So why not just do it in show_trace_log_lvl()?

-- 
Josh

