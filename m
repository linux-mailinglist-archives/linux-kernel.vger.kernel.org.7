Return-Path: <linux-kernel+bounces-641372-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 09202AB10B9
	for <lists+linux-kernel@lfdr.de>; Fri,  9 May 2025 12:30:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0CC2A01CA1
	for <lists+linux-kernel@lfdr.de>; Fri,  9 May 2025 10:29:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 721C028F536;
	Fri,  9 May 2025 10:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="RjQrZQ84"
Received: from smtp-bc0a.mail.infomaniak.ch (smtp-bc0a.mail.infomaniak.ch [45.157.188.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A761828ECF9
	for <linux-kernel@vger.kernel.org>; Fri,  9 May 2025 10:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746786411; cv=none; b=mDkg09EYJcY8dtLyuZuzx2swGn70UN3te1Hmpgkky98Hz7FuCF7z3yGXoayBUe+mMKDxyCUreRc0nzHhU0EfGqdgiF0LLWDtFq7nIhWXvczpygR04nJPq7V7vNVczRf6xe/wZHex2rk0jpc+pUOtM2bCYxQJy7sOfoQfpgYh8nI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746786411; c=relaxed/simple;
	bh=0hgLDBDBqIc+ajD8fKoIpxS6gijW76ZLX+VXrJUmh6E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cz705DpCqW6z3yXbW57bIsYUQCKTHNhOBFkMxn182K7p8HHFvqV3scW1ZwD8whhg8BIt7hZlGbH5hJ0pxds/l4aMXZQHvOyvtXhCBPBhocDJkas7pZdSA60Qy8zkpOj0w41esmX3zRSQjQ5pmzoDos7pG2eeg4UI/al/xoWSb94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=RjQrZQ84; arc=none smtp.client-ip=45.157.188.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-3-0001.mail.infomaniak.ch (smtp-3-0001.mail.infomaniak.ch [10.4.36.108])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4Zv4tH4x3gzTkQ;
	Fri,  9 May 2025 12:26:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1746786407;
	bh=pwp7aGGfuXhGuWiZq4lEqOzbbcbhUTvngL3tCWRDYJg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RjQrZQ84I4ZLCOPdNvJCURGqKw24PzdHcWdVgd05M27bNGowwta3gJdGFkot5l1MA
	 2/1CrApRjcGtx+lCql7qGkrv+sp/lr26107uqBz/grlyqssmi7mARV8PDTSkxu7J5h
	 un/axsBqZnfs98zrS9YGpjSwP6N483JDLSgFeRDc=
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4Zv4tH0ccfzFFD;
	Fri,  9 May 2025 12:26:47 +0200 (CEST)
Date: Fri, 9 May 2025 12:26:45 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: John Johansen <john.johansen@canonical.com>, 
	Paul Moore <paul@paul-moore.com>, Maxime =?utf-8?Q?B=C3=A9lair?= <maxime.belair@canonical.com>, 
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, linux-security-module@vger.kernel.org, jmorris@namei.org, 
	serge@hallyn.com, kees@kernel.org, stephen.smalley.work@gmail.com, 
	takedakn@nttdata.co.jp, linux-api@vger.kernel.org, apparmor@lists.ubuntu.com, 
	linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 2/3] lsm: introduce security_lsm_manage_policy hook
Message-ID: <20250509.Chuecae0phoo@digikod.net>
References: <20250506143254.718647-1-maxime.belair@canonical.com>
 <20250506143254.718647-3-maxime.belair@canonical.com>
 <9c68743f-5efa-4a77-a29b-d3e8f2b2a462@I-love.SAKURA.ne.jp>
 <CAHC9VhRKwB4quqBtYQyxRqCX2C6fCgTbyAP3Ov+NdQ06t1aFdA@mail.gmail.com>
 <120954c2-87b7-4bda-958b-2b4f0180a736@canonical.com>
 <efe5b15a-6141-424a-8391-9092e79e4acf@schaufler-ca.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <efe5b15a-6141-424a-8391-9092e79e4acf@schaufler-ca.com>
X-Infomaniak-Routing: alpha

On Thu, May 08, 2025 at 09:54:19AM -0700, Casey Schaufler wrote:
> On 5/8/2025 1:29 AM, John Johansen wrote:
> > On 5/7/25 13:25, Paul Moore wrote:
> >> On Wed, May 7, 2025 at 6:41 AM Tetsuo Handa
> >> <penguin-kernel@i-love.sakura.ne.jp> wrote:
> >>> On 2025/05/06 23:32, Maxime Bélair wrote:
> >>>> diff --git a/security/lsm_syscalls.c b/security/lsm_syscalls.c
> >>>> index dcaad8818679..b39e6635a7d5 100644
> >>>> --- a/security/lsm_syscalls.c
> >>>> +++ b/security/lsm_syscalls.c
> >>>> @@ -122,5 +122,10 @@ SYSCALL_DEFINE3(lsm_list_modules, u64 __user
> >>>> *, ids, u32 __user *, size,
> >>>>   SYSCALL_DEFINE5(lsm_manage_policy, u32, lsm_id, u32, op, void
> >>>> __user *, buf, u32
> >>>>                __user *, size, u32, flags)
> >>>>   {
> >>>> -     return 0;
> >>>> +     size_t usize;
> >>>> +
> >>>> +     if (get_user(usize, size))
> >>>> +             return -EFAULT;
> >>>> +
> >>>> +     return security_lsm_manage_policy(lsm_id, op, buf, usize,
> >>>> flags);
> >>>>   }
> >>>
> >>> syzbot will report user-controlled unbounded huge size memory
> >>> allocation attempt. ;-)
> >>>
> >>> This interface might be fine for AppArmor, but TOMOYO won't use this
> >>> interface because
> >>> TOMOYO's policy is line-oriented ASCII text data where the
> >>> destination is switched via
> >>> pseudo‑filesystem's filename ...
> >>
> >> While Tetsuo's comment is limited to TOMOYO, I believe the argument
> >> applies to a number of other LSMs as well.  The reality is that there
> >> is no one policy ideal shared across LSMs and that complicates things
> >> like the lsm_manage_policy() proposal.  I'm intentionally saying
> >> "complicates" and not "prevents" because I don't want to flat out
> >> reject something like this, but I think there needs to be a larger
> >> discussion among the different LSM groups about what such an API
> >> should look like.  We may not need to get every LSM to support this
> >> new API, but we need to get something that would work for a
> >> significant majority and would be general/extensible enough that we
> >> would expect it to work with the majority of future LSMs (as much as
> >> we can predict the future anyway).
> >>
> >
> > yep, I look at this is just a starting point for discussion. There
> > isn't going to be any discussion without some code, so here is a v1
> > that supports a single LSM let the bike shedding begin.
> 
> Aside from the issues with allocating a buffer for a big policy
> I don't see a problem with this proposal. The system call looks
> a lot like the other LSM interfaces, so any developer who likes
> those ought to like this one. The infrastructure can easily check
> the lsm_id and only call the appropriate LSM hook, so no one
> is going to be interfering with other modules.

We may not want to only be able to load buffers containing policies, but
also to leverage file descriptors like Landlock does.  Getting a
property from a kernel object or updating it is mainly about dealing
with a buffer.  And the current LSM syscalls do just that.  Other kind
of operations may require more than that though.

I don't like multiplexer syscalls because they don't expose a clear
semantic and can be complex to manage and filter.  This new syscall is
kind of a multiplexer that redirect commands to an arbitrary set of
kernel parts, which can then define their own semantic.  I'd like to see
a clear set of well-defined operations and their required permission.
Even better, one syscall per operation should simplify their interface.

