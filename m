Return-Path: <linux-kernel+bounces-801566-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AC7D2B446BF
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 21:52:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6836DA40353
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 19:52:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A41C277038;
	Thu,  4 Sep 2025 19:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="bjhmky/C"
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A36E272E71;
	Thu,  4 Sep 2025 19:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757015561; cv=none; b=MAtG3uE0tT5taMNL8kfqRtC8H/v45hRYDA73RTtUiuStdMapLwTZteARQ7dh5XO9UFHuwxtFyZWoFyIJHnUaMYMko62fMuYoGh+6K8dvdCN7keN+LdyTI/VZ7X7syvcB7MvsAv2i6Jmda10E2QkB0RqXVyQBR8id1OBzHkXLd0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757015561; c=relaxed/simple;
	bh=clZg3DRP1WK628VKHxpm33A1dty/3Fut7NCYFv+NR+I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GH6I2NBWhfrIwS5TlKBXu5phGsmdUk7oka9Y10Ac4THUXHxcSn9YtPuU69brzEfl6hJtTy0wbe2EgbShVs6xBTfKOY8MzuOgZwi1Gz9OwQCo9ETgcCRyV39xG48Ficl18W0Ehp0t5pWLGPhgi0Wpz4dKNsQlpmdyDcWFaePW/Eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=bjhmky/C; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=90WWo3ngxb5YnOOH42tlOsV1yM7SHg+xd8fsX6IodEM=; b=bjhmky/C/K2jRa5b3zE06gWSXU
	6tKmzrhW2LUrjJa1VEiQauciIwOqHJVt36j19JdOlyek2tliV3LcMOmRtBfN/j3a1BIUhSfYduakv
	vOBI9aSZrU0qI5iUm18eL5WAhUMsaahG+LRegSn61APROOL3rJa7omiv4zVXge0XO3zCUpinDOHrt
	qhfy+Ycl/7mYf2khR2RQQVqbjOsU6k5gKsYBXyFfioFMUWBXCq57L+u1mIWNhF56v3sKjJDuztNCt
	CK2xb5xgtbeyPoP0gDRwNVm3L4mbWJlfayhGM4nXaNBjA58pTpPh3h65dd5VQ37m92ZTIs5GtUr96
	pnNFvGcg==;
Received: from [177.139.20.31] (helo=[192.168.15.100])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1uuG0U-006ySr-N4; Thu, 04 Sep 2025 21:52:30 +0200
Message-ID: <e3e00ba8-1516-4632-b987-4c0d1bb303d5@igalia.com>
Date: Thu, 4 Sep 2025 16:52:26 -0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] futex: don't leak robust_list pointer on exec race
To: Pranav Tyagi <pranav.tyagi03@gmail.com>
Cc: jann@thejh.net, keescook@chromium.org, linux-kernel@vger.kernel.org,
 dvhart@infradead.org, peterz@infradead.org, mingo@redhat.com,
 tglx@linutronix.de, skhan@linuxfoundation.org, dave@stgolabs.net,
 linux-kernel-mentees@lists.linux.dev
References: <20250813074201.6253-1-pranav.tyagi03@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
In-Reply-To: <20250813074201.6253-1-pranav.tyagi03@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Pranav,

Thanks for your patch! Some feedback bellow.

Em 13/08/2025 04:42, Pranav Tyagi escreveu:
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
> 
> Signed-off-by: Pranav Tyagi <pranav.tyagi03@gmail.com>
> Suggested-by: Jann Horn <jann@thejh.net>
> Link: https://lore.kernel.org/linux-fsdevel/1477863998-3298-5-git-send-email-jann@thejh.net/
> Link: https://github.com/KSPP/linux/issues/119
> ---
> changed in v4:
> - added task_robust_list() function
> changed in v3:
> - replaced RCU with scoped_guard(rcu)
> - corrected error return type cast
> - added IS_ENABLED(CONFIG_COMPAT) for ensuring compatability
> - removed stray newlines and unnecessary line breaks
> changed in v2:
> - improved changelog
> - helper function for common part of compat and native syscalls
> 
>   kernel/futex/syscalls.c | 108 +++++++++++++++++++++-------------------
>   1 file changed, 58 insertions(+), 50 deletions(-)
> 
> diff --git a/kernel/futex/syscalls.c b/kernel/futex/syscalls.c
> index 4b6da9116aa6..0da33abc2f17 100644
> --- a/kernel/futex/syscalls.c
> +++ b/kernel/futex/syscalls.c
> @@ -39,6 +39,58 @@ SYSCALL_DEFINE2(set_robust_list, struct robust_list_head __user *, head,
>   	return 0;
>   }
>   
> +static inline void __user *task_robust_list(struct task_struct *p, bool compat)

Function names inside of kernel/futex/ have the futex_ prefix

> +{
> +#ifdef CONFIG_COMPAT
> +	if (compat)
> +		return p->compat_robust_list;
> +#endif
> +	return p->robust_list;
> +}
> +
> +static void __user *get_robust_list_common(int pid, bool compat)

Same here

> +{
> +	struct task_struct *p;
> +	void __user *head;
> +	unsigned long ret;

down_read_killable() returns a int, but you are storing the return value 
in an unsigned long.

> +
> +	p = current;

Could this be initialized in the declaration?

> +
> +	scoped_guard(rcu) {
> +		if (pid) {
> +			p = find_task_by_vpid(pid);
> +			if (!p)
> +				return (void __user *)ERR_PTR(-ESRCH);
> +		}
> +		get_task_struct(p);
> +	}
> +
> +	/*
> +	 * Hold exec_update_lock to serialize with concurrent exec()
> +	 * so ptrace_may_access() is checked against stable credentials
> +	 */
> +	ret = down_read_killable(&p->signal->exec_update_lock);
> +	if (ret)
> +		goto err_put;
> +
> +	ret = -EPERM;
> +	if (!ptrace_may_access(p, PTRACE_MODE_READ_REALCREDS))
> +		goto err_unlock;
> +
> +	head = task_robust_list(p, compat);
> +
> +	up_read(&p->signal->exec_update_lock);
> +	put_task_struct(p);
> +
> +	return head;
> +
> +err_unlock:
> +	up_read(&p->signal->exec_update_lock);
> +err_put:
> +	put_task_struct(p);
> +	return (void __user *)ERR_PTR(ret);
> +}
> +
>   /**
>    * sys_get_robust_list() - Get the robust-futex list head of a task
>    * @pid:	pid of the process [zero for current task]
> @@ -49,36 +101,14 @@ SYSCALL_DEFINE3(get_robust_list, int, pid,
>   		struct robust_list_head __user * __user *, head_ptr,
>   		size_t __user *, len_ptr)
>   {
> -	struct robust_list_head __user *head;
> -	unsigned long ret;
> -	struct task_struct *p;
> -
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
> +	struct robust_list_head __user *head = get_robust_list_common(pid, false);
>   
> -	ret = -EPERM;
> -	if (!ptrace_may_access(p, PTRACE_MODE_READ_REALCREDS))
> -		goto err_unlock;
> -
> -	head = p->robust_list;
> -	rcu_read_unlock();
> +	if (IS_ERR(head))
> +		return PTR_ERR(head);
>   
>   	if (put_user(sizeof(*head), len_ptr))
>   		return -EFAULT;
>   	return put_user(head, head_ptr);
> -
> -err_unlock:
> -	rcu_read_unlock();
> -
> -	return ret;
>   }
>   
>   long do_futex(u32 __user *uaddr, int op, u32 val, ktime_t *timeout,
> @@ -455,36 +485,14 @@ COMPAT_SYSCALL_DEFINE3(get_robust_list, int, pid,
>   			compat_uptr_t __user *, head_ptr,
>   			compat_size_t __user *, len_ptr)
>   {
> -	struct compat_robust_list_head __user *head;
> -	unsigned long ret;
> -	struct task_struct *p;
> -
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
> +	struct compat_robust_list_head __user *head = get_robust_list_common(pid, true);
>   
> -	head = p->compat_robust_list;
> -	rcu_read_unlock();
> +	if (IS_ERR(head))
> +		return PTR_ERR(head);
>   
>   	if (put_user(sizeof(*head), len_ptr))
>   		return -EFAULT;
>   	return put_user(ptr_to_compat(head), head_ptr);
> -
> -err_unlock:
> -	rcu_read_unlock();
> -
> -	return ret;
>   }
>   #endif /* CONFIG_COMPAT */
>   


