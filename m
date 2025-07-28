Return-Path: <linux-kernel+bounces-748309-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C40EB13F54
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 17:59:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BFEDB1642EF
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 15:59:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED5842701CB;
	Mon, 28 Jul 2025 15:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iCs3cJty"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFFCA1D5145
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 15:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753718382; cv=none; b=P1gNd5D6cWQJl23dnhScvyyTZPmyz90M0jos3dKoFgr/KVzglm+wkejPhbV03jCBeJVqsF6QVDlR039XvZdurXIJAddpioz5XR7R/hlhuMgNzaaZw4MwHkc/ZE2EsIsTOUpwMDoHOVyIDobMztIzHx2AhYnCOmN8Dg+StacvEr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753718382; c=relaxed/simple;
	bh=OTbor7ZS+5EB/3V+FxY9MjnWLw9oFMI8zg7m+8gL2UI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MUdCWKasmRKYCeVbskF8LpCtUsUJIco4owPmePtG86TIhLW46zf6Il/ybsUHCoQ+Wtnn5UfLe/Rj+whJDxSBuTVjdFmLXbXATCo9gGSe3bCcPVLTwQ2N6rhSQd2qxZE6fIJtaOFoXxM+NTUtCiXYqo6KwFbbnOkZnNhx0aRJh8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iCs3cJty; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753718378;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tj0EP2+JaKs27i5/OIfXj63DCYw43dYDBb8+cvYBTlU=;
	b=iCs3cJtyb7lilcgUxglPuq2nRBGmmHpU72Q9qP27M7UcCI7+R9bCR2M82wvD2EPKcFtOQ5
	YCv67Xm/czeC7od+WfQ++jvJ6CjZ+N7DivkDCBv/pFL7zbHbvcfoJZti8GoVbQ+CbpvJyZ
	fxxnqoWAQF5Fuvy70O7jDXPXfb+pXYw=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-327-AQn9nwiXNxKKoKjYBxNSaA-1; Mon,
 28 Jul 2025 11:59:34 -0400
X-MC-Unique: AQn9nwiXNxKKoKjYBxNSaA-1
X-Mimecast-MFC-AGG-ID: AQn9nwiXNxKKoKjYBxNSaA_1753718372
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 16211180045B;
	Mon, 28 Jul 2025 15:59:31 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.39])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 8798F1955F16;
	Mon, 28 Jul 2025 15:59:25 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Mon, 28 Jul 2025 17:58:22 +0200 (CEST)
Date: Mon, 28 Jul 2025 17:58:16 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: fan.yu9@zte.com.cn, frederic@kernel.org, peterz@infradead.org,
	brauner@kernel.org, iro@zeniv.linux.org.uk,
	joel.granados@kernel.org, lorenzo.stoakes@oracle.com,
	linux-kernel@vger.kernel.org, xu.xin16@zte.com.cn,
	yang.yang29@zte.com.cn
Subject: Re: [PATCH linux-next] signal: Remove outdated __send_signal
 references in  do_notify_parent
Message-ID: <20250728155815.GB25567@redhat.com>
References: <202507281624542763Kn377WvUMXlKHVJUdNjA@zte.com.cn>
 <878qk8pdkd.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <878qk8pdkd.ffs@tglx>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On 07/28, Thomas Gleixner wrote:
>
> > --- a/kernel/signal.c
> > +++ b/kernel/signal.c
> > @@ -2251,10 +2251,7 @@ bool do_notify_parent(struct task_struct *tsk, int sig)
> >  		if (psig->action[SIGCHLD-1].sa.sa_handler == SIG_IGN)
> >  			sig = 0;
> >  	}
> > -	/*
> > -	 * Send with __send_signal as si_pid and si_uid are in the
> > -	 * parent's namespaces.
> > -	 */
> > +
>
> Why are you removing the complete comment instead of just renaming the
> stale reference?

Then the comment should be updated to explain that we have to use
__send_signal_locked(), not send_signal_locked(), because the latter
can wrongly change si_pid/si_uid which are in the parent's namespace.

> commit 61e713bdca36 ("signal: Avoid corrupting si_pid and si_uid in
> do_notify_parent") put that comment there for a reason.

Yes, but the comment was a bit confusing, imo. I don't think it makes
the code more clear.

But I am fine either way.

Oleg.


