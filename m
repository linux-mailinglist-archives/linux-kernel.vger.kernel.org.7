Return-Path: <linux-kernel+bounces-600052-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E54EA85B6F
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Apr 2025 13:22:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FD078C149D
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Apr 2025 11:18:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38F2821146C;
	Fri, 11 Apr 2025 11:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NB8K1QP4"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB2A5278E65
	for <linux-kernel@vger.kernel.org>; Fri, 11 Apr 2025 11:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744370321; cv=none; b=BBWi/ZxfypbZqOc0EHOQkkSpj/elLjqwYuzkRZb5n1iGu4ORkzWWkOVFZiQLcGv8089mkBrQ+iAJ3RO/g6K1LvkQAQ0XinHVxVaQo4kNiccAAX8IeNZx724BgT7gpRJBTIMkQbDre9l4WH9qA4LrjlZY+WwmrN6KK/TQTmVhgEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744370321; c=relaxed/simple;
	bh=LZwNmgCPFq7nbWJwY1YZRvo5zyzZEPHCrEpZSqWk/iE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C8G6OAtX9nK8Rv1UCVG8YizR9RDExoiTJpZO9PuNP7BftkCuiSQQUhgS1wveqUYgoMqSXCm6z8jPChuoN0SBO0pmr6UhyGGKQVeg9zzW1UN+fHKaJW9ovCys50ZmGFysgjTmkXP3e0JJ8xuxUvq9gelEVIfO1e8ToU/631zR9Bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NB8K1QP4; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744370318;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ghsBXLaD+jr8PE/8uGFiMEIPGIBz355o90DVZ8Kf+0g=;
	b=NB8K1QP4At9bEmoM//KTPhSbWFOvEvSyyQFhTcaArQOhqYiy3MBw9uAC/GY5D5u/vP4ss5
	kPSc+w36OWtTDElUl1FEH3bSENOvkIpE4ZEqr3Cg0EdF5zp184KSs6vXpLgHB2uOsOoZ44
	scd2JrR6jCpViski60CY+K8DjAdEF8E=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-261-Cnkze5OMNXWj-IHjOe4VTA-1; Fri,
 11 Apr 2025 07:18:37 -0400
X-MC-Unique: Cnkze5OMNXWj-IHjOe4VTA-1
X-Mimecast-MFC-AGG-ID: Cnkze5OMNXWj-IHjOe4VTA_1744370315
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0C6801955BC1;
	Fri, 11 Apr 2025 11:18:35 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.222])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 2D7B41955BF2;
	Fri, 11 Apr 2025 11:18:29 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Fri, 11 Apr 2025 13:17:59 +0200 (CEST)
Date: Fri, 11 Apr 2025 13:17:53 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: jiang.kun2@zte.com.cn, "Eric W. Biederman" <ebiederm@xmission.com>
Cc: tglx@linutronix.de, frederic@kernel.org, peterz@infradead.org,
	brauner@kernel.org, joel.granados@kernel.org,
	viro@zeniv.linux.org.uk, lorenzo.stoakes@oracle.com,
	linux-kernel@vger.kernel.org, fan.yu9@zte.com.cn
Subject: Re: [PATCH] signal: Update send_signal_locked in relevant comments
Message-ID: <20250411111752.GB5322@redhat.com>
References: <20250411182448645tJ7XVmvNHqUXluy9xYQ_7@zte.com.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250411182448645tJ7XVmvNHqUXluy9xYQ_7@zte.com.cn>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

On 04/11, jiang.kun2@zte.com.cn wrote:
>
> --- a/kernel/signal.c
> +++ b/kernel/signal.c
> @@ -2252,7 +2252,7 @@ bool do_notify_parent(struct task_struct *tsk, int sig)
>  			sig = 0;
>  	}
>  	/*
> -	 * Send with __send_signal as si_pid and si_uid are in the
> +	 * Send with __send_signal_locked as si_pid and si_uid are in the
>  	 * parent's namespaces.

Thanks, but I think that today this comment looks confusing either way.
It was added by 61e713bdca3678 along with this

	-               __group_send_sig_info(sig, &info, tsk->parent);
	+               __send_signal(sig, &info, tsk->parent, PIDTYPE_TGID, false);

change.

To me this comment looks outdated, perhaps it would be better to simply
remove it?

Or it should be updated to explain that we use __send_signal_locked()
instead of send_signal_locked() because the latter can wrongly change
si_pid/si_uid...

Oleg.


