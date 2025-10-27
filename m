Return-Path: <linux-kernel+bounces-871881-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6EE4C0EB23
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 15:58:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A60DD402E19
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 14:51:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CF922C21DC;
	Mon, 27 Oct 2025 14:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FtFWNiIj"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48E23239567
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 14:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761576689; cv=none; b=cK10xOjNNifKEeAutfHWD3GQo7PkGrC1QhKywLN3G89u00lm+blj5n26869A26uMUKAE6aWLNnuw0BYWwKNmlMcF3iGMlCEEv0RtH19Oc+ZIYl/XqobKJdIMeeJh+wUpFPmfWiAThWJ/ZGXhj6ntiSKha3w+00YklRIpvxCdtkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761576689; c=relaxed/simple;
	bh=8gtdnZQS1Ze1qnxybqPNZWNI8ysmJonaCunUbf97yJI=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=OR9NUUp8wHt4ujF7Wgpe3SjaMJXL7SUuSYj1h3gUAXVnHAz7TvdwwvexxUYnWbOZReucuQ5mgFHffC1STtyAKqWDwL/Ii46JyAcg9Ss8NKutJt7Nd0CO3hkttLDmqS49FebMFkmUOoHeZq3IgmxtRTVgDD//k1vXqzEJvA2yE24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FtFWNiIj; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761576686;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=a60wg3eS8XmeyLBfFoANHgeIYJM0c1Dc4IZk/cK3IZk=;
	b=FtFWNiIjDbZ/xdVjLtKQ80BhR79LHxDIMFM6y0y9bzhKmvdRKHcJsYtfAdVMDlmDEXf+y+
	kH7BP4VWn0AZPcFx3UTer6A5Iv9z4/sF37scU61Gwedm7ZCNTeQw31TtG8rZSOH/by+v9h
	At/C8BVMH7UWLPzIPFDbFHuY8Hg7/+I=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-288-mDZsaDckMve3E3Wib_fsTw-1; Mon,
 27 Oct 2025 10:51:22 -0400
X-MC-Unique: mDZsaDckMve3E3Wib_fsTw-1
X-Mimecast-MFC-AGG-ID: mDZsaDckMve3E3Wib_fsTw_1761576681
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 890161800D85;
	Mon, 27 Oct 2025 14:51:21 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.6])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B962E1800577;
	Mon, 27 Oct 2025 14:51:19 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20251026143140.GA22463@redhat.com>
References: <20251026143140.GA22463@redhat.com>
To: Oleg Nesterov <oleg@redhat.com>
Cc: dhowells@redhat.com, Alexey Gladkov <legion@kernel.org>,
    Andrew Morton <akpm@linux-foundation.org>,
    Mateusz Guzik <mjguzik@gmail.com>,
    "Paul E. McKenney" <paulmck@kernel.org>,
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] release_task: kill unnecessary rcu_read_lock() around dec_rlimit_ucounts()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2258819.1761576678.1@warthog.procyon.org.uk>
Date: Mon, 27 Oct 2025 14:51:18 +0000
Message-ID: <2258820.1761576678@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Oleg Nesterov <oleg@redhat.com> wrote:

> rcu_read_lock() was added to shut RCU-lockdep up when this code used
> __task_cred()->rcu_dereference(), but after the commit 21d1c5e386bc
> ("Reimplement RLIMIT_NPROC on top of ucounts") it is no longer needed:
> task_ucounts()->task_cred_xxx() takes rcu_read_lock() itself.
> 
> NOTE: task_ucounts() returns the pointer to another rcu-protected data,
> struct ucounts. So it should either be used when task->real_cred and thus
> task->real_cred->ucounts is stable (release_task, copy_process, copy_creds),
> or it should be called under rcu_read_lock(). In both cases it is pointless
> to take rcu_read_lock() to read the cred->ucounts pointer.

Yeah, accessing the pointer that task_ucounts() gives you isn't RCU safe
unless you're holding the rcu_read_lock() or are in a context where RCU safety
is irrelevant.  The task doing the dismantling in release_task() would seem to
qualify for that.

David


