Return-Path: <linux-kernel+bounces-824950-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9676AB8A880
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 18:15:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C76D5A84A3
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 16:15:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78A8A321260;
	Fri, 19 Sep 2025 16:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ao9vjwtQ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39CA6320CD5
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 16:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758298530; cv=none; b=YYtHLXGeyf2juErLnwC1JmkPflHiLVvgs3sebhnE4tBF5qJHYEUe6tX/IkyVMlEvoPZ2uVn4UoYB0uMvDmejAvFIjPjdfuK2ZVGsnU4k+9YxwgG6dhNHZRA3tWwhGkr3LS0hW0ZGUW8YdMn6b2/xYh3mPrwKf45XYQHHeNKcGeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758298530; c=relaxed/simple;
	bh=nqdyMymN425TI/5K5SDgLswxxxGJi9ZID2KaXox7sOA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YIw7XlBeY8NYojHWhDWhvbHz4RePrineGwdQiIbtV31Lv57YSaG15K563Jp280S2ui7GTpNqV4ZPPwFEXBWzwCZvabXBb3BZvkNGde9YF9F1+jBo/RP1Dm1iIJizagHMHJ6OHoJQQdtJ1c/GyXPR3kjRNFcWLTU7EKa3EhaOyqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ao9vjwtQ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758298527;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tFSWc29Bem6BFsJUg23DgE4402gn/p4b5SW0MKkdQF0=;
	b=Ao9vjwtQEE/7oz9VwMycwSyidUzcVtV8HHXh6BAQitZmnoYWW8A6yjH2NEiNmsHhLNcGEf
	rsSrQdFnqOsB84st5zdd+6XfxlyAVwnOJlCxSkdidmb3MRLtp6/lEqp+zG1ky1Fe+FOvjC
	iboJqGldilDVmrVdRqB0/0n+inqU00s=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-548-9jy5j-zZNyOFIxt8m5gdKw-1; Fri,
 19 Sep 2025 12:15:23 -0400
X-MC-Unique: 9jy5j-zZNyOFIxt8m5gdKw-1
X-Mimecast-MFC-AGG-ID: 9jy5j-zZNyOFIxt8m5gdKw_1758298521
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 30F1519560B5;
	Fri, 19 Sep 2025 16:15:21 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.44.33.8])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id A981519560BB;
	Fri, 19 Sep 2025 16:15:18 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Fri, 19 Sep 2025 18:13:57 +0200 (CEST)
Date: Fri, 19 Sep 2025 18:13:54 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Matt Fleming <mfleming@cloudflare.com>
Cc: Peter Zijlstra <peterz@infradead.org>, John Stultz <jstultz@google.com>,
	kernel-team <kernel-team@cloudflare.com>,
	LKML <linux-kernel@vger.kernel.org>,
	Chris Arges <carges@cloudflare.com>
Subject: Re: Debugging lost task in wait_task_inactive() when delivering
 signal (6.12)
Message-ID: <20250919161353.GB22933@redhat.com>
References: <CAGis_TWyhciem6bPzR98ysj1+gOVPHRGqSUNiiyvS1RnEidExw@mail.gmail.com>
 <20250919143611.GA22933@redhat.com>
 <CAGis_TUp9_V-kBn9CF55f08NVR+Bx3iyP=O=+PH0QAf73eGY2Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGis_TUp9_V-kBn9CF55f08NVR+Bx3iyP=O=+PH0QAf73eGY2Q@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Let me repeat that currently I have no idea, so let me ask another stupid
question...

On 09/19, Matt Fleming wrote:
>
> I do have some info. The callstack for the lost thread is:
>
> Call Trace:
>  <TASK>
>  __schedule+0x4fb/0xbf0
>  ? srso_return_thunk+0x5/0x5f
>  schedule+0x27/0xf0
>  do_exit+0xdd/0xaa0
>  ? __pfx_futex_wake_mark+0x10/0x10
>  do_group_exit+0x30/0x80
>  get_signal+0x81e/0x860
>  ? srso_return_thunk+0x5/0x5f
>  ? futex_wake+0x177/0x1a0
>  arch_do_signal_or_restart+0x2e/0x1f0
>  ? srso_return_thunk+0x5/0x5f
>  ? srso_return_thunk+0x5/0x5f
>  ? __x64_sys_futex+0x10c/0x1d0
>  syscall_exit_to_user_mode+0xa5/0x130
>  do_syscall_64+0x57/0x110
>  entry_SYSCALL_64_after_hwframe+0x76/0x7e

OK, thanks. Nothing "interesting" at first glance.

> do_exit+0xdd is here in coredump_task_wait():
>
>                 for (;;) {
>                         set_current_state(TASK_IDLE|TASK_FREEZABLE);
>                         if (!self.task) /* see coredump_finish() */
>                                 break;
>                         schedule();
>                 }
>
> i.e. the task calls schedule() and never comes back.

Are you sure it never comes back and doesn't loop?

> The waiting task
> sees p->on_rq=1 for this lost thread

Strange...

Oleg.


