Return-Path: <linux-kernel+bounces-755371-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B9E2B1A591
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 17:12:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02C7A17ED93
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 15:12:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FA18218AAF;
	Mon,  4 Aug 2025 15:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j4h9FXN9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 840F31EA7E9;
	Mon,  4 Aug 2025 15:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754320352; cv=none; b=q3v/+JEeUT5TRRD53k5yaHaJ8+b23fnRJCQgeOnBn0CPQuRUoo+ciplvm68ByPKAsac1Y6VYL5OYfHtkSJ6TB9RP+5a7hB0FRuxGuqy5jc1n6Nyx17hLsD8+GVSNTgbTmkdPTSjK6zWC6cs/Mujz9KpHFj8xsupcLPVfX/LPD5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754320352; c=relaxed/simple;
	bh=s8Hl5yqqBlXVSgd7w3HW62AgLG1twY0pWWHfz3al/M0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p23Z/FL0bNvcmYg04uIk3+eZsS91pInxAMsuoCQtglYWQNXNUTY3amM/lZceY4B52ZogxnxXLC5PQL1vsUaBuRVYhLLEwg2SmRA/J9aZW456xJuU2E3jnFRX3NZemPKw0OxjZVDOCsZ5kTHzAHEGOyJk0Cgb3y/czyW6VE7K3iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j4h9FXN9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BFCAC4CEE7;
	Mon,  4 Aug 2025 15:12:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754320352;
	bh=s8Hl5yqqBlXVSgd7w3HW62AgLG1twY0pWWHfz3al/M0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=j4h9FXN9MrTeETabRPKqGw0DlBEgTHhW01QwghvFgToGaA02bi9JnLLl4rQih1Fnc
	 EKmLNxqOeoyea0cVkOHhdEmcvslersOvoLitcaIYZoPpcBLg1yElS3KNww6eIFQtF8
	 TcFRE3zpR+JELLo6XLEE1TppL98Td8gaPZhDuNsy3tElr3MsLNyKMhZuLXbh88sJ6R
	 +4qPXpmPCuBvRG7lnyvQRjHKnACtYf9xAuEL/q/B9BXWW4AjbVKafF/1cajrXxuV4n
	 krQkqnxtL/mN91OKgvXY4hAVXD6NfSrFFA9jsZMNfgMBc+/U5R4A+JYCANhFZwjsI/
	 1lEs8006JfP0Q==
Date: Mon, 4 Aug 2025 08:12:31 -0700
From: Kees Cook <kees@kernel.org>
To: Pranav Tyagi <pranav.tyagi03@gmail.com>
Cc: tglx@linutronix.de, mingo@redhat.com, peterz@infradead.org,
	dvhart@infradead.org, dave@stgolabs.net, andrealmeid@igalia.com,
	linux-kernel@vger.kernel.org, jann@thejh.net,
	skhan@linuxfoundation.org, linux-kernel-mentees@lists.linux.dev
Subject: Re: [PATCH v2] futex: don't leak robust_list pointer on exec race
Message-ID: <202508040811.3DB8AA242@keescook>
References: <20250804115533.14186-1-pranav.tyagi03@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250804115533.14186-1-pranav.tyagi03@gmail.com>

On Mon, Aug 04, 2025 at 05:25:33PM +0530, Pranav Tyagi wrote:
> sys_get_robust_list() and compat_get_robust_list() use
> ptrace_may_access() to check if the calling task is allowed to access
> another task's robust_list pointer. This check is racy against a
> concurrent exec() in the target process.
> 
> During exec(), a task may transition from a non-privileged binary to a
> privileged one (e.g., setuid binary) and its credentials/memory mappings
> may change. If get_robust_list() performs ptrace_may_access() before
> this transition, it may erroneously allow access to sensitive information
> after the target becomes privileged.
> 
> A racy access allows an attacker to exploit a window
> during which ptrace_may_access() passes before a target process
> transitions to a privileged state via exec().
> 
> For example, consider a non-privileged task T that is about to execute a
> setuid-root binary. An attacker task A calls get_robust_list(T) while T
> is still unprivileged. Since ptrace_may_access() checks permissions
> based on current credentials, it succeeds. However, if T begins exec
> immediately afterwards, it becomes privileged and may change its memory
> mappings. Because get_robust_list() proceeds to access T->robust_list
> without synchronizing with exec() it may read user-space pointers from a
> now-privileged process.
> 
> This violates the intended post-exec access restrictions and could
> expose sensitive memory addresses or be used as a primitive in a larger
> exploit chain. Consequently, the race can lead to unauthorized
> disclosure of information across privilege boundaries and poses a
> potential security risk.
> 
> Take a read lock on signal->exec_update_lock prior to invoking
> ptrace_may_access() and accessing the robust_list/compat_robust_list.
> This ensures that the target task's exec state remains stable during the
> check, allowing for consistent and synchronized validation of
> credentials.

Thanks for this commit log; I think it captures the concern very well.

> 
> changed in v2:
> - improved changelog
> - helper function for common part of the compat and native syscalls
> 
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
>  {
> -	struct robust_list_head __user *head;
> +	void __user *head;
>  	unsigned long ret;
> -	struct task_struct *p;
>  
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
>  	}
>  
> +	/*
> +	 * Hold exec_update_lock to serialize with concurrent exec()
> +	 * so ptrace_may_access() is checked against stable credentials
> +	 */
> +
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
>  
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
> +
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
>  
> -	rcu_read_lock();
> -
> -	ret = -ESRCH;
> -	if (!pid)
> -		p = current;
> -	else {
> -		p = find_task_by_vpid(pid);
> -		if (!p)
> -			goto err_unlock;
> -	}
> -
> -	ret = -EPERM;
> -	if (!ptrace_may_access(p, PTRACE_MODE_READ_REALCREDS))
> -		goto err_unlock;
> -
> -	head = p->compat_robust_list;
> -	rcu_read_unlock();
> +	if (IS_ERR(head))
> +		return PTR_ERR(head);
>  
>  	if (put_user(sizeof(*head), len_ptr))
>  		return -EFAULT;
>  	return put_user(ptr_to_compat(head), head_ptr);
> -
> -err_unlock:
> -	rcu_read_unlock();
> -
> -	return ret;
>  }
>  #endif /* CONFIG_COMPAT */
>  
> -- 
> 2.49.0
> 

This looks good to me; it needs to use a void * for the common helper,
but it's nice to have it all in one place.

Reviewed-by: Kees Cook <kees@kernel.org>

-Kees

-- 
Kees Cook

