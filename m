Return-Path: <linux-kernel+bounces-750954-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 69576B1634C
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 17:04:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C7B0A18C5FD3
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 15:04:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89F0F2DAFC6;
	Wed, 30 Jul 2025 15:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ai6KNZe3"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50105298CA6
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 15:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753887845; cv=none; b=kl8cNbK/errfgu7V8wmL2y3aoa0O3xAc7g01mrAHnv66LyU4U4wWpOvg3/ur0qwladdFZM/ZXJnzyq1l0E1xpsaScu2pzTpfKdhnti2HCJ9KmeiQBm35mx1lmVs7FvGgD7QQpTUoqZx9YVBh89ZR3VAhss339p0LFWHfqBSfoCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753887845; c=relaxed/simple;
	bh=P2sb9Wxh2HNcQtj5a3ToZ+BlnqwIx6/sUQxyr+rzIdY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z1rvs7ZTiEuhzpvItOqtYn+wyOlj0fzeBXKvdhDTna2JGy/HjkcrOxE0mYjFAj1n+ddJ14RxUJFoo07qRMV3Xir5eAaP97gqfm2+yC3aMbofoGKVaQYEf9WGVcJPgXD6XbIbXnmvU3dP/sio4Ler2F1/6G2qSmsAn5xjolQQG4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ai6KNZe3; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753887842;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zav2XZqNEreY0Boep1f4fIHt4Q3yOSkNqNeHfPqcOLs=;
	b=Ai6KNZe3IKEqX3p5SVWGODU+AZqYku13xZbg0RD7XS4nCef0qAg7fsLrP6nsdyWQqisB5g
	ASW3fg05EJaW+oVyr6SwybvnJnrYK7OI1AhlXE0/7HzdcbeTSuNqCWOv6X2i5QZnjpLUsY
	7cmamUIPGBuBoDkFtRYscgtAS0FWUuE=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-157-3ACFM3QGObyd2G7LA4-wew-1; Wed,
 30 Jul 2025 11:03:58 -0400
X-MC-Unique: 3ACFM3QGObyd2G7LA4-wew-1
X-Mimecast-MFC-AGG-ID: 3ACFM3QGObyd2G7LA4-wew_1753887836
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 980D719560B4;
	Wed, 30 Jul 2025 15:03:55 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.80])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id D89771800242;
	Wed, 30 Jul 2025 15:03:50 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Wed, 30 Jul 2025 17:02:47 +0200 (CEST)
Date: Wed, 30 Jul 2025 17:02:40 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: fan.yu9@zte.com.cn, Thomas Gleixner <tglx@linutronix.de>
Cc: frederic@kernel.org, peterz@infradead.org, brauner@kernel.org,
	iro@zeniv.linux.org.uk, joel.granados@kernel.org,
	lorenzo.stoakes@oracle.com, akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org, xu.xin16@zte.com.cn,
	yang.yang29@zte.com.cn
Subject: Re: [PATCH linux-next v2] signal: clarify __send_signal_locked
 comment in do_notify_parent
Message-ID: <20250730150240.GB5339@redhat.com>
References: <20250729152759994n3YKgjxLglCCPkOtYtU2U@zte.com.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250729152759994n3YKgjxLglCCPkOtYtU2U@zte.com.cn>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On 07/29, fan.yu9@zte.com.cn wrote:
>
> @@ -2252,8 +2252,10 @@ bool do_notify_parent(struct task_struct *tsk, int sig)
>  			sig = 0;
>  	}
>  	/*
> -	 * Send with __send_signal as si_pid and si_uid are in the
> -	 * parent's namespaces.
> +	 * Use __send_signal_locked() instead of send_signal_locked()
> +	 * because si_pid and si_uid are already in the parent's
> +	 * namespace. send_signal_locked() would incorrectly modify
> +	 * them when crossing PID/user namespaces.
>  	 */

Well, Thomas doesn't like the idea to kill this comment, I won't argue.

However, this comment still looks confusing to me, and I don't know how to
make it more clear. Yes, send_signal_locked() may, say, clear info->si_pid
but not "because si_pid and si_uid are already in the parent's namespace".

There are several obvious reasons not to use send_signal_locked():

	1. do_notify_parent() has already correctly filled si_pid/si_uid,
	   the "has_si_pid_and_uid()" checks in send_signal_locked() are
	   pointless.

	   That is why I think this comment should simply die.

	2. send_signal_locked() assumes that different namespaces mean
	   "From an ancestor namespace", but in this case the child can
	   send a signal to the parent namespace while "from parent ns"
	   is not possible.

	3. send_signal_locked() assumes that "current" is a) the sender
	   and b) alive task. Both assumptions may be wrong if "current"
	   is the last exiting thread which calls do_notify_parent() from
	   release_task().

	   In this case task_pid_nr_ns(current, task_active_pid_ns(parent))
	   will return 0 because current->thread_pid is already NULL, and
	   send_signal_locked() will misinterpret this as "from parent ns"
	   and clear si_pid.

	   But imo, it is simply unsafe to use send_signal_locked() in this
	   case, even if currently nothing "really bad" can happen.

OTOH. This patch doesn't make the comment more confusing, plus it removes
the reference to __send_signal() which no longer exists, so let me ack
this patch and forget this surprisingly long discussion ;)

Acked-by: Oleg Nesterov <oleg@redhat.com>


