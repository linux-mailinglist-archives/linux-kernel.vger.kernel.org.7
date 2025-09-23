Return-Path: <linux-kernel+bounces-828894-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ECA5FB95C61
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 14:05:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC29819C0CA7
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 12:06:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BE7C322DC7;
	Tue, 23 Sep 2025 12:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J+S/gl2/"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC50C322C87
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 12:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758629120; cv=none; b=bXiohR9Y334AecwKHFARC0Ok62zOAnP872kw4dli1lXQ6y6zFVoenUzrBbCY7rH0FjcbKJsPrmhk5XOJsDLk6sX6kZdJs62qp8vL30hWzNWPxYswfS6ICG25/fZbooPCKKlmTBpu53AxOWV4YLpqbTnklnY5lJPNDe1xdToe1bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758629120; c=relaxed/simple;
	bh=IOivFE/4TgCGiZPcyQd3ZbltVQMhtQSh/CcWwgB7pWs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jnjU5zusFbW2u33dcWqwFV3KghCAi+GwGNk7S1hCFD67p9F30BJmH+lmbiFFvfeGDG6S1Bmz6aUWsAl4wzS6F31HtYPY96iBgl3ma7BDuJ57do8wRDemvBx+wh2wgKr92XC4Oy0NAvdvtbf8X2F9oqhsN62WGr55y1XzvTc2xr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=J+S/gl2/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758629117;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/YXNPV2UHc2SkQj+Ybo8bEYR+xc7E2McmXptpNC84EI=;
	b=J+S/gl2/QtXwUYlIsKKCEXgv8+cOHrDcq+VqYbF370V+5k8g+2u77NDLdm241EBTWuX//G
	1irsceNvzT5wAChMgGgP+WkLLNAE+ugQfBEYvOGn71FahWDvLLX1AfaPptP1EJR8UeL1hV
	ZHgd0boibi8spNU7lvRDOx0928Xz4Mc=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-215-FU8tAXxIOOCdkbpog9sUJg-1; Tue,
 23 Sep 2025 08:05:13 -0400
X-MC-Unique: FU8tAXxIOOCdkbpog9sUJg-1
X-Mimecast-MFC-AGG-ID: FU8tAXxIOOCdkbpog9sUJg_1758629112
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BE35E1800562;
	Tue, 23 Sep 2025 12:05:11 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.44.32.16])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id A28C330001B5;
	Tue, 23 Sep 2025 12:05:09 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Tue, 23 Sep 2025 14:03:48 +0200 (CEST)
Date: Tue, 23 Sep 2025 14:03:45 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Demi Marie Obenour <demiobenour@gmail.com>,
	Mateusz Guzik <mjguzik@gmail.com>,
	Christian Brauner <brauner@kernel.org>
Cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] kernel: Prevent prctl(PR_SET_PDEATHSIG) from racing with
 parent process exit
Message-ID: <20250923120344.GA12377@redhat.com>
References: <20250913-fix-prctl-pdeathsig-race-v1-1-44e2eb426fe9@gmail.com>
 <ef4878fe-3edf-4bd0-bb33-116ced1a4eb8@gmail.com>
 <20250922154819.c3049158ca006e1561ff5dcb@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250922154819.c3049158ca006e1561ff5dcb@linux-foundation.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Hi Demi,

(add more CC's)

I think your patch is correct in that it fixes the problems described in
the changelog. Thanks for the detailed explanations.

But I obviously dislike the fact it adds read_lock(tasklist_lock) into
prctl(PR_SET_PDEATHSIG) ;)

For the moment lets forget about the data race. Of course you right, but
this is simple, we can add READ/WRITE_ONCE(pdeath_signal).

Lets only discuss the 2nd problem: the exiting parent can miss
child->pdeath_signal != 0 while the child can still see the old getppid().
I honestly do not know if we really care, I always thought that this API
is ancient/obsolete and "strange". If nothing else, pdeath_signal is sent
even in the case of a threaded reparent...

But OK, lets suppose we need to fix this problem. Not that it matters, but
I guess you didn't hit it in practice?

As you correctly pointed out, forget_original_parent/prctl lack the necessary
barries. So lets add the barriers instead of abusing tasklist? As for sys_prctl(),
I think that ret-to-user-mode + enter-the-kernel-mode should act as a full
barrier, so it only needs WRITE_ONCE()...

Or perhaps user-space can do something else to sync with the exiting parent
instead of using getppid() ?

Oleg.

On 09/22, Andrew Morton wrote:
>
> From: Demi Marie Obenour <demiobenour@gmail.com>
> Subject: kernel: prevent prctl(PR_SET_PDEATHSIG) from racing with parent process exit
> Date: Sat, 13 Sep 2025 18:28:49 -0400
>
> If a process calls prctl(PR_SET_PDEATHSIG) at the same time that the
> parent process exits, the child will write to me->pdeath_sig at the same
> time the parent is reading it.  Since there is no synchronization, this is
> a data race.
>
> Worse, it is possible that a subsequent call to getppid() can continue to
> return the previous parent process ID without the parent death signal
> being delivered.  This happens in the following scenario:
>
> parent                                                 child
>
> forget_original_parent()                               prctl(PR_SET_PDEATHSIG, SIGKILL)
>                                                          sys_prctl()
>                                                            me->pdeath_sig = SIGKILL;
>                                                        getppid();
>   RCU_INIT_POINTER(t->real_parent, reaper);
>   if (t->pdeath_signal) /* reads stale me->pdeath_sig */
>            group_send_sig_info(t->pdeath_signal, ...);
>
> And in the following:
>
> parent                                                 child
>
> forget_original_parent()
>     RCU_INIT_POINTER(t->real_parent, reaper);
>     /* also no barrier */
>      if (t->pdeath_signal) /* reads stale me->pdeath_sig */
>              group_send_sig_info(t->pdeath_signal, ...);
>
>                                                        prctl(PR_SET_PDEATHSIG, SIGKILL)
>                                                          sys_prctl()
>                                                            me->pdeath_sig = SIGKILL;
>                                                        getppid(); /* reads old ppid() */
>
> As a result, the following pattern is racy:
>
> 	pid_t parent_pid = getpid();
> 	pid_t child_pid = fork();
> 	if (child_pid == -1) {
> 		/* handle error... */
> 		return;
> 	}
> 	if (child_pid == 0) {
> 		if (prctl(PR_SET_PDEATHSIG, SIGKILL) != 0) {
> 			/* handle error */
> 			_exit(126);
> 		}
> 		if (getppid() != parent_pid) {
> 			/* parent died already */
> 			raise(SIGKILL);
> 		}
> 		/* keep going in child */
> 	}
> 	/* keep going in parent */
>
> If the parent is killed at exactly the wrong time, the child process can
> (wrongly) stay running.
>
> I didn't manage to reproduce this in my testing, but I'm pretty sure the
> race is real.  KCSAN is probably the best way to spot the race.
>
> Fix the bug by holding tasklist_lock for reading whenever pdeath_signal is
> being written to.  This prevents races on me->pdeath_sig, and the locking
> and unlocking of the rwlock provide the needed memory barriers.  If
> prctl(PR_SET_PDEATHSIG) happens before the parent exits, the signal will
> be sent.  If it happens afterwards, a subsequent getppid() will return the
> new value.
>
> Link: https://lkml.kernel.org/r/20250913-fix-prctl-pdeathsig-race-v1-1-44e2eb426fe9@gmail.com
> Signed-off-by: Demi Marie Obenour <demiobenour@gmail.com>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> ---
>
>  kernel/sys.c |   10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> --- a/kernel/sys.c~kernel-prevent-prctlpr_set_pdeathsig-from-racing-with-parent-process-exit
> +++ a/kernel/sys.c
> @@ -2533,7 +2533,17 @@ SYSCALL_DEFINE5(prctl, int, option, unsi
>  			error = -EINVAL;
>  			break;
>  		}
> +		/*
> +		 * Ensure that either:
> +		 *
> +		 * 1. Subsequent getppid() calls reflect the parent process having died.
> +		 * 2. forget_original_parent() will send the new me->pdeath_signal.
> +		 *
> +		 * Also prevent the read of me->pdeath_signal from being a data race.
> +		 */
> +		read_lock(&tasklist_lock);
>  		me->pdeath_signal = arg2;
> +		read_unlock(&tasklist_lock);
>  		break;
>  	case PR_GET_PDEATHSIG:
>  		error = put_user(me->pdeath_signal, (int __user *)arg2);
> _
>


