Return-Path: <linux-kernel+bounces-838686-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B0917BAFEE7
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 11:53:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C33B3AFE07
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 09:53:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9442728D8FD;
	Wed,  1 Oct 2025 09:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="EPR1DRCi";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GUgTuCKS"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB6D326461F
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 09:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759312397; cv=none; b=JglFFzHDbkBJcPmccp8W1RFr/Nv2TgaWcjLGGPKl1LVL2Xeg/qngGkZNviOgk1Bd7SE/JNo++J16gVUx4WI3J+yk6iNDU7bZM9CSVjmyk9JLM97HwQ96jmJCdYKDRzbpBBB4zGRJJMcdBjCa48BkqlEZgYX2yMT146qLNZIpIgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759312397; c=relaxed/simple;
	bh=TwWbXTtT8Jpkg4B1RDSQTmGxjVJ3owiNAOOqyjACHps=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HmyCjS58gyJL7z/m0zTGuRKTko+eK4LdddMmnA3zLY9zfsd65uerqqzE3xJssflfKln/A12M63NM0WddFv3gTzzPvLwDIfjPwgQSo8UVBxqRIV+nleXkxAhUGa1TUOdm1J1fZAQnGXqJTX0HshAuYINLBDkXsdfnlQBlwrfXDJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=EPR1DRCi; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GUgTuCKS; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1759312390;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vC3OdWWeJh+PxyArQwklWEXKC6IsarjbY4j/qJQw9X8=;
	b=EPR1DRCirxmpEQD82QiIob5iu3hiJ56mO7g8NgNIsj5BIC7/IHWFQwfHnpxDeEI0xyEFVG
	07QHFuz2HyqbqftKUOyAZw2n2BWEGe7ECiJkyGmHG1nq56fMwjWusz2jrsE7qopeFos8p5
	o5nfzCXsdF4QG7pwkDYHRcy+duxKtyHPVjeGVhP7GoBqDe10IaW43/GMcSA5WFhF+bjYT3
	3Zzzj2hvVz0V71vg7CNEHA/nqYDd3ue0KHaotGdxtkhqf2dfIfmfPU4LJxBz2b9prRdAfS
	WTr+Za9T9WreICzcVdTb5hKJ2vrT1AVscAJyoeBxJICasVTv9xU2KqRAgS+mvg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1759312390;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vC3OdWWeJh+PxyArQwklWEXKC6IsarjbY4j/qJQw9X8=;
	b=GUgTuCKS9J3TLo5ShX5zK7vo4RrlV4qdl+jspATQWR1tBU3sxw8XWAPR263UX4/vLu9UV7
	n2JmfqL13y+ApsCg==
To: Andrew Murray <amurray@thegoodpenguin.co.uk>
Cc: Petr Mladek <pmladek@suse.com>, Steven Rostedt <rostedt@goodmis.org>,
 Sergey Senozhatsky <senozhatsky@chromium.org>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] printk: console_flush_one_record() code cleanup
In-Reply-To: <CALqELGwd1CiRAYNBVWsrgb5T3eJ9ugP+0wG2WKZGvSfowqgaaQ@mail.gmail.com>
References: <20250927-printk_legacy_thread_console_lock-v2-0-cff9f063071a@thegoodpenguin.co.uk>
 <20250927-printk_legacy_thread_console_lock-v2-2-cff9f063071a@thegoodpenguin.co.uk>
 <84o6qsjduw.fsf@jogness.linutronix.de>
 <CALqELGwd1CiRAYNBVWsrgb5T3eJ9ugP+0wG2WKZGvSfowqgaaQ@mail.gmail.com>
Date: Wed, 01 Oct 2025 11:59:10 +0206
Message-ID: <84seg3gd89.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2025-09-30, Andrew Murray <amurray@thegoodpenguin.co.uk> wrote:
>> On 2025-09-27, Andrew Murray <amurray@thegoodpenguin.co.uk> wrote:
>> > diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
>> > index 060d4919de320fe21fd7aca73ba497e27c4ff334..e2c1cacdb4164489c60fe38f1e2837eb838107d6 100644
>> > --- a/kernel/printk/printk.c
>> > +++ b/kernel/printk/printk.c
>> > @@ -3193,6 +3194,7 @@ static bool console_flush_one_record(bool do_cond_resched, u64 *next_seq, bool *
>> >       bool any_progress;
>> >       int cookie;
>> >
>> > +     *any_usable = false;
>>
>> Since it is expected that @next_seq and @handover are initialized by
>> their callers (if their callers are interested in the values), then I
>> would expect @any_usable to be initialized by the
>> caller. console_flush_one_record() never reads this variable.
>
> Yes, that's correct. Perhaps the comments for the parameters should
> indicate otherwise?

They should clarify. For example, @next_seq is "valid only when this
function returns true" but @handover validitiy is not specified and is
also not related to the return value.

I would like to see the helper function provide clear usage. If the
caller is expected to initialize the parameters (which IMHO it should be
the case for all of the pointer parameters), then that should be
specified.

>> > @@ -3280,21 +3284,16 @@ static bool console_flush_one_record(bool do_cond_resched, u64 *next_seq, bool *
>> >   */
>> >  static bool console_flush_all(bool do_cond_resched, u64 *next_seq, bool *handover)
>> >  {
>> > -     bool any_usable = false;
>> > +     bool any_usable;
>>
>> Since console_flush_all() does read @any_usable, I would expect it to
>> initialize @any_usable. So I would not remove this definition initialization.
>
> Prior to this series, console_flush_all would set any_usable to false.
> It would be set to true if at any point a usable console is found,
> that value would be returned, or otherwise false if handover or panic.
> When the first patch split out this function, any_usable was kept as
> it was, leading to any_usable being true, even if a handover or panic
> had happened (hence additional checks needed, which are removed in
> this patch).
>
> By setting any_usable at the start of flush_one_record, it allows for
> any_usable to revert back to false, in the case where a once usable
> console is no longer usable. Thus representing the situation for the
> last record printed. It also makes console_flush_one_record easier to
> understand, as the any_usable flag will always be set, rather than
> only changing from false to true.

OK. But then just have console_flush_all() set @any_usable in the loop:

static bool console_flush_all(bool do_cond_resched, u64 *next_seq, bool *handover)
{
	bool any_progress;
	bool any_usable;

	*next_seq = 0;
	*handover = false;

	do {
		any_usable = false;
		any_progress = console_flush_one_record(do_cond_resched, next_seq,
							handover, &any_usable);
	} while (any_progress);

	return any_usable;
}

> Alternatively, it may be possible for console_flush_one_record to
> return any_usable, thus dropping it as an argument and removing the
> return of any_progress. Instead the caller could keep calling
> console_flush_one_record until it returns false or until next_seq
> stops increasing? Thus semantically, the return value of
> console_flush_one_record tells you that nothing bad happened and you
> can call it again, and the benefit of calling it again depends on if
> progress is being made (as determined by the caller through the
> existing seq argument).

Sorry, I could not follow how this would work. It sounds like a
simplification. If you can make it work, go for it.

John

