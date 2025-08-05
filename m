Return-Path: <linux-kernel+bounces-756111-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8151CB1B01F
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 10:19:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3CCCA3B2148
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 08:19:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC34D1A5B8C;
	Tue,  5 Aug 2025 08:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="a5RBPVSp";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HRtLr/dP"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0DC41F30AD
	for <linux-kernel@vger.kernel.org>; Tue,  5 Aug 2025 08:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754381976; cv=none; b=PTqSAZTMswEb95E2v9ImYx9Gl8CFbd6gPgg3H+B2TTWzuELur1DgxBOaOFJsWhfP/CoqFafzSWlrovBXK6mvWf62n9MgrEdJ/C9nIY0/9imKrKPUv2wq+Rw/sbfvy4A6pj8KC3P1OcePHIf5dVoe6IvC2XyUi+0wiSqQKCbCIkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754381976; c=relaxed/simple;
	bh=Os9JiwIeGtnfmNy4C+UTY5wklB1lOf1J6DAA6X/9jus=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=InjuWfhymjnsbngGZTmOFbEKwryeu93SeUmQnWdAdcmvpaipMcw4JdE729OG8yc4LEp+//GkOj0aKzD+ArRbkOQhv2X5+CTaDRND+6xm3pVLyecTb611YsStVbmlhDDhkM7DK0jFzTuUeVDjDmz9h7p5euhDhY7kBQ4qHYh2TMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=a5RBPVSp; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=HRtLr/dP; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1754381972;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7eXqZukBJsjBSdz9QJmzEvxSldHJHVRIiX8d3xX8bzQ=;
	b=a5RBPVSprZDV3Htcc3FsH6T6QM+N57wqK4qHzFp3A/CvpB5c/Yn7V13nYF66si8A9leMd0
	bAH5i8vLnBWq7ulNuz6/AVFMBqt7wMTa70hx1ZBvjZgg2k2r4il9xT8NmbxiPgUH/yfqWQ
	b8oE6UqH8nSAGfEWQWGKPh2mB0hO5QnDPL/qNI+BAUsaQsr+syh3IYeDHdSk5K1Hg0jIEc
	Iot22oHSS8qVFwsZjMaTTnYIRmkB7MDcYicv6Kn4YGzmWIEstznZIYDFPEx7DwOLIo3Tas
	Amk1mcoaGnohXTfssSInU83CppUUm/0XrRI0H7yNwJDPfLwksYuIm2xwcUKydQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1754381972;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7eXqZukBJsjBSdz9QJmzEvxSldHJHVRIiX8d3xX8bzQ=;
	b=HRtLr/dPowXxJ7nvW9ff1UkZso7WUufswXqUPE5bt0MF8s5Qzdd0kt/P+Pl5S1dfH7/+2M
	uE0L1ONaW0/O4eCg==
To: Pranav Tyagi <pranav.tyagi03@gmail.com>, mingo@redhat.com,
 peterz@infradead.org, dvhart@infradead.org, dave@stgolabs.net,
 andrealmeid@igalia.com, linux-kernel@vger.kernel.org
Cc: jann@thejh.net, keescook@chromium.org, skhan@linuxfoundation.org,
 linux-kernel-mentees@lists.linux.dev, Pranav Tyagi
 <pranav.tyagi03@gmail.com>
Subject: Re: [PATCH v2] futex: don't leak robust_list pointer on exec race
In-Reply-To: <20250804115533.14186-1-pranav.tyagi03@gmail.com>
References: <20250804115533.14186-1-pranav.tyagi03@gmail.com>
Date: Tue, 05 Aug 2025 10:19:31 +0200
Message-ID: <871ppqgoz0.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Aug 04 2025 at 17:25, Pranav Tyagi wrote:
> Take a read lock on signal->exec_update_lock prior to invoking
> ptrace_may_access() and accessing the robust_list/compat_robust_list.
> This ensures that the target task's exec state remains stable during the
> check, allowing for consistent and synchronized validation of
> credentials.
>
> changed in v2:
> - improved changelog
> - helper function for common part of the compat and native syscalls

Please put version log below the --- line. That's not part of the change log.

> Signed-off-by: Pranav Tyagi <pranav.tyagi03@gmail.com>
> Suggested-by: Jann Horn <jann@thejh.net>
> Link: https://lore.kernel.org/linux-fsdevel/1477863998-3298-5-git-send-email-jann@thejh.net/
> Link: https://github.com/KSPP/linux/issues/119
> ---
>  kernel/futex/syscalls.c | 110 ++++++++++++++++++++++------------------
>  1 file changed, 62 insertions(+), 48 deletions(-)
>
> diff --git a/kernel/futex/syscalls.c b/kernel/futex/syscalls.c
> index 4b6da9116aa6..3278d91d95ce 100644
> --- a/kernel/futex/syscalls.c
> +++ b/kernel/futex/syscalls.c
> @@ -39,46 +39,81 @@ SYSCALL_DEFINE2(set_robust_list, struct robust_list_head __user *, head,
>  	return 0;
>  }
>  
> -/**
> - * sys_get_robust_list() - Get the robust-futex list head of a task
> - * @pid:	pid of the process [zero for current task]
> - * @head_ptr:	pointer to a list-head pointer, the kernel fills it in
> - * @len_ptr:	pointer to a length field, the kernel fills in the header size
> - */
> -SYSCALL_DEFINE3(get_robust_list, int, pid,
> -		struct robust_list_head __user * __user *, head_ptr,
> -		size_t __user *, len_ptr)
> +static void __user *get_robust_list_common(int pid,
> +		bool compat)

What is this random line break for?

>  {
> -	struct robust_list_head __user *head;
> +	void __user *head;
>  	unsigned long ret;
> -	struct task_struct *p;
>  

Stray new line and please use reverse fir tree ordering of variables:

https://www.kernel.org/doc/html/latest/process/maintainer-tip.html#variable-declarations

> -	rcu_read_lock();
> +	struct task_struct *p;
>  
> -	ret = -ESRCH;
> -	if (!pid)
> +	if (!pid) {
>  		p = current;
> -	else {
> +		get_task_struct(p);
> +	} else {
> +		rcu_read_lock();
>  		p = find_task_by_vpid(pid);
> +		/*
> +		 * pin the task to permit dropping the RCU read lock before
> +		 * acquiring the semaphore
> +		 */
> +		if (p)
> +			get_task_struct(p);
> +		rcu_read_unlock();
>  		if (!p)
> -			goto err_unlock;
> +			return ERR_PTR(-ESRCH);

                scoped_guard(rcu) {
                     p = find_task_by_vpid(pid);
                     if (!p)
			return (void __user *)ERR_PTR(-ESRCH);
                     get_task_struct(p);
                }

No need for a comment about pinning the task. This is obvious and a
common pattern all over the place. And note the type case on the error
return.

But you can simplify this whole thing even further:

	struct task_struct *p = current;

	scoped_guard(rcu) {
        	if (pid) {
                     p = find_task_by_vpid(pid);
                     if (!p)
			return (void __user *)ERR_PTR(-ESRCH);
		}
        	get_task_struct(p);
        }

Yes, RCU is not required for the !pid case, but this is not a hot path.

>  
> +	/*
> +	 * Hold exec_update_lock to serialize with concurrent exec()
> +	 * so ptrace_may_access() is checked against stable credentials
> +	 */
> +

Stray newline.

> +	ret = down_read_killable(&p->signal->exec_update_lock);
> +	if (ret)
> +		goto err_put;
> +
>  	ret = -EPERM;
>  	if (!ptrace_may_access(p, PTRACE_MODE_READ_REALCREDS))
>  		goto err_unlock;
>  
> -	head = p->robust_list;
> -	rcu_read_unlock();
> +	if (compat)
> +		head = p->compat_robust_list;
> +	else
> +		head = p->robust_list;

Brain compiler complains about a build fail with CONFIG_COMPAT=n

static inline void __user *task_robust_list(struct task_struct *p, bool compat)
{
#ifdef COMPAT
	if (compat)
		return p->compat_robust_list;
#endif
	return p->robust_list;
}

So you don't have the #ifdef ugly in this function..

> -	if (put_user(sizeof(*head), len_ptr))
> -		return -EFAULT;
> -	return put_user(head, head_ptr);
> +	up_read(&p->signal->exec_update_lock);
> +	put_task_struct(p);
> +
> +	return head;
>  
>  err_unlock:
> -	rcu_read_unlock();
> +	up_read(&p->signal->exec_update_lock);
> +err_put:
> +	put_task_struct(p);
> +	return ERR_PTR(ret);
> +}
>  
> -	return ret;
> +
> +/**
> + * sys_get_robust_list() - Get the robust-futex list head of a task
> + * @pid:	pid of the process [zero for current task]
> + * @head_ptr:	pointer to a list-head pointer, the kernel fills it in
> + * @len_ptr:	pointer to a length field, the kernel fills in the header size
> + */
> +SYSCALL_DEFINE3(get_robust_list, int, pid,
> +		struct robust_list_head __user * __user *, head_ptr,
> +		size_t __user *, len_ptr)
> +{
> +	struct robust_list_head __user *head =
> +		get_robust_list_common(pid, false);

No line break required.

> +	if (IS_ERR(head))
> +		return PTR_ERR(head);
> +
> +	if (put_user(sizeof(*head), len_ptr))
> +		return -EFAULT;
> +	return put_user(head, head_ptr);
>  }
>  
>  long do_futex(u32 __user *uaddr, int op, u32 val, ktime_t *timeout,
> @@ -455,36 +490,15 @@ COMPAT_SYSCALL_DEFINE3(get_robust_list, int, pid,
>  			compat_uptr_t __user *, head_ptr,
>  			compat_size_t __user *, len_ptr)
>  {
> -	struct compat_robust_list_head __user *head;
> -	unsigned long ret;
> -	struct task_struct *p;
> +	struct compat_robust_list_head __user *head =
> +		get_robust_list_common(pid, true);

Ditto

Thanks,

        tglx

