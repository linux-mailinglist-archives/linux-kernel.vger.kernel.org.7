Return-Path: <linux-kernel+bounces-870436-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EAED2C0ACEB
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 16:44:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 007843A4A84
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 15:44:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC72F2236F2;
	Sun, 26 Oct 2025 15:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TagcIWFb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53DEF2A1BB
	for <linux-kernel@vger.kernel.org>; Sun, 26 Oct 2025 15:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761493471; cv=none; b=X/qIUwYB9ARUpH7dyZTLBH5qPJG78WKVeW82a19UfjjohVnqHzsbJuZcwRMt1V+E7BPqcLBbBFSd/K3hwgK4gNMjJgJjn3yXAyUDi+ROJxHW9slIx6dgKAlNzDiWfVbMAalUjDZpYgA72FNZi8zi+KqOhNWENDMGgc7vklOehlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761493471; c=relaxed/simple;
	bh=YMWggytIRxLAB18ZvMWhhDCTr3P5FChYah1BHvklFV0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FCGQWxwiCGTUucmqj0Q59knzOjGMWzfgFtfrWirG27G5hJY3L4d1nm7QNsI7sq2mGbOZ5lJWeIoZ0yyE11cpgPwreGN281RRWA1NGLm9IIzBI0H/E+5T2KHnqFOFBlB4ovGKvr36b/nXlXqQgz/FyIecYJQz4w17mlMaM8lbR2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TagcIWFb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74212C4CEE7;
	Sun, 26 Oct 2025 15:44:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761493470;
	bh=YMWggytIRxLAB18ZvMWhhDCTr3P5FChYah1BHvklFV0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TagcIWFbmYDAXBNdWI2y6jTh1hcfZ+6aOBKM+mcnSPyGCdDKke3EIIAYeMEHvKKr8
	 Qb6docmLLtzXMcZA78PC5DOU4huuoqP+p0tGDW49OVQntiCYAVqJVV3l8o/5f8ezxv
	 SZvoxj8MTS9wxBexgvTOhgwzT//0r42nnqt3zu7EbN1Y627HxDppIgsVT1rm6G0b5f
	 zyIDRVdlc17c1dKEE4virahqcv/XdkuP9C/auBqLge6x9XoDUelz4pgfO9CeR4iinm
	 AuMQOScToq6luQK/y5qbZuJLjABLjRZvPMXk9bZMZWVIv947GcaRpHqUed9Ln5OQMZ
	 J2jmmQ3DYSzbA==
Date: Sun, 26 Oct 2025 16:44:26 +0100
From: Alexey Gladkov <legion@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	David Howells <dhowells@redhat.com>,
	Mateusz Guzik <mjguzik@gmail.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] release_task: kill unnecessary rcu_read_lock()
 around dec_rlimit_ucounts()
Message-ID: <aP5B2tKhFAcdKhlO@example.org>
References: <20251026143140.GA22463@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251026143140.GA22463@redhat.com>

On Sun, Oct 26, 2025 at 03:31:40PM +0100, Oleg Nesterov wrote:
> rcu_read_lock() was added to shut RCU-lockdep up when this code used
> __task_cred()->rcu_dereference(), but after the commit 21d1c5e386bc
> ("Reimplement RLIMIT_NPROC on top of ucounts") it is no longer needed:
> task_ucounts()->task_cred_xxx() takes rcu_read_lock() itself.

Yes, it makes sense.

Acked-by: Alexey Gladkov <legion@kernel.org>

> NOTE: task_ucounts() returns the pointer to another rcu-protected data,
> struct ucounts. So it should either be used when task->real_cred and thus
> task->real_cred->ucounts is stable (release_task, copy_process, copy_creds),
> or it should be called under rcu_read_lock(). In both cases it is pointless
> to take rcu_read_lock() to read the cred->ucounts pointer.
> 
> Signed-off-by: Oleg Nesterov <oleg@redhat.com>
> ---
>  kernel/exit.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/kernel/exit.c b/kernel/exit.c
> index 9f74e8f1c431..f041f0c05ebb 100644
> --- a/kernel/exit.c
> +++ b/kernel/exit.c
> @@ -251,10 +251,8 @@ void release_task(struct task_struct *p)
>  	memset(&post, 0, sizeof(post));
>  
>  	/* don't need to get the RCU readlock here - the process is dead and
> -	 * can't be modifying its own credentials. But shut RCU-lockdep up */
> -	rcu_read_lock();
> +	 * can't be modifying its own credentials. */
>  	dec_rlimit_ucounts(task_ucounts(p), UCOUNT_RLIMIT_NPROC, 1);
> -	rcu_read_unlock();
>  
>  	pidfs_exit(p);
>  	cgroup_release(p);
> -- 
> 2.25.1.362.g51ebf55
> 
> 

-- 
Rgrds, legion


