Return-Path: <linux-kernel+bounces-600126-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C788A85C0F
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Apr 2025 13:42:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0F1D47AEB27
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Apr 2025 11:41:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39A8027934C;
	Fri, 11 Apr 2025 11:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="APb9ELGb"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2013520FA81
	for <linux-kernel@vger.kernel.org>; Fri, 11 Apr 2025 11:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744371746; cv=none; b=Y0NkfWVeydBJibINRYTFIw5cR0PWb2DuLQjt9MxFmJZrLbUz6emarTuJJ+Bujmw6IjVUxB2KVXXpuOmrwc+k8BQ+sFpkO+kUcIvDhwjN0hFpMqatr37mYcjbntgMXpvuWOvx/Eev4+huuR54i6Ux7/HB/qX8D4hz3tJIdTpEneo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744371746; c=relaxed/simple;
	bh=I6aUlf76Hj9oWT5IUPqlEFEXUQbl+N0fO/0i+e7uNSw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FCXHUDW86jaDmlVRaJ/PFe2xkeKIJCcnJgGNC8+Mf2x9pIaMk7WNKgKiIO6bZvLGvPz/TrB9E4XOBZFAMmzIgxKQ5uASykN6MJ/Zx9yj/McASV94V8KViLA3/svqYQkVT4VIZKsSx8TsUv0/QbDXg0pP2lvy2kCN7Dd8Yr+mt34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=APb9ELGb; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744371743;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PQvxCPteal/twSkIPQWB0ZTQdjoa0MyFaK2SpsJtBd4=;
	b=APb9ELGbZuKGx7mQ4q2qJzx5X8BA8dDjUZBReoNRGFGLTfYCwgOuUayrKeh0KDfIc/aW6y
	AUtupOlFjm+M/PJ6qlrCO/unA1D0EhLcbacY9GBeRrB/i4UPHt8xRXtmy+4AZDTfZ/cJ0E
	td4IER8U/m2Juvkps9zOdr3k2tJUW2g=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-344-PrPHMUzqPKihBeJxiBIG4g-1; Fri,
 11 Apr 2025 07:42:20 -0400
X-MC-Unique: PrPHMUzqPKihBeJxiBIG4g-1
X-Mimecast-MFC-AGG-ID: PrPHMUzqPKihBeJxiBIG4g_1744371739
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7EDBD1800361;
	Fri, 11 Apr 2025 11:42:18 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.222])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 50B251808882;
	Fri, 11 Apr 2025 11:42:15 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Fri, 11 Apr 2025 13:41:42 +0200 (CEST)
Date: Fri, 11 Apr 2025 13:41:38 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>,
	Lennart Poettering <lennart@poettering.net>,
	Daan De Meyer <daan.j.demeyer@gmail.com>,
	Mike Yuan <me@yhndnzj.com>, linux-kernel@vger.kernel.org,
	Peter Ziljstra <peterz@infradead.org>
Subject: Re: [RFC PATCH] pidfs: ensure consistent ENOENT/ESRCH reporting
Message-ID: <20250411114137.GD5322@redhat.com>
References: <20250409-sesshaft-absurd-35d97607142c@brauner>
 <20250409-rohstoff-ungnade-d1afa571f32c@brauner>
 <20250409184040.GF32748@redhat.com>
 <20250410101801.GA15280@redhat.com>
 <20250410-barhocker-weinhandel-8ed2f619899b@brauner>
 <20250410131008.GB15280@redhat.com>
 <20250410-inklusive-kehren-e817ba060a34@brauner>
 <20250410-akademie-skaten-75bd4686ad6b@brauner>
 <20250411-tagwerk-server-313ff9395188@brauner>
 <20250411112532.GC5322@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250411112532.GC5322@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On 04/11, Oleg Nesterov wrote:
>
> On 04/11, Christian Brauner wrote:
> >
> > > Looking close at this. Why is:
> > >
> > >         if (type == PIDTYPE_PID) {
> > >                 WARN_ON_ONCE(pid_has_task(pid, PIDTYPE_PID));
> > >                 wake_up_all(&pid->wait_pidfd);
> > >         }
> > >
> > > located in __change_pid()? The only valid call to __change_pid() with a NULL
> > > argument and PIDTYPE_PID is from __unhash_process(), no?
> >
> > We used to perform free_pid() directly from __change_pid() so prior to
> > v6.15 changes it wasn't possible.
>
> Yes, exactly ;)

To clarify, it was actually possible because the caller, release_task(),
does

	thread_pid = get_pid(p->thread_pid);

before __exit_signal() and detach_pid(PIDTYPE_PID) uses the same
task_struct->thread_pid. But I didn't want to rely on this fact.

And it seems we can do another cleanup... We can kill the no longer
needed get_pid/put_pid in release_task(). I'll send the patch.

> > Now that we free the pids separately let's
> > just move the notification into __unhash_process(). I have a patch ready
> > for this.
>
> Agreed,
>
> Acked-by: Oleg Nesterov <oleg@redhat.com>


