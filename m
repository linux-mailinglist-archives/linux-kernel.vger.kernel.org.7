Return-Path: <linux-kernel+bounces-857955-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id B2384BE854D
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 13:32:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5BEB735CB4E
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 11:32:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1383724A066;
	Fri, 17 Oct 2025 11:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L6IGzWJ+"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8074B3346BF
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 11:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760700715; cv=none; b=jA7iGl73hxSLTLhL4u7fz/OE01ZeOM0HwOXCAlPj/y4dGgaWsvyJoAD9A0I8I42vupoJlD29JPTSF6YddoQWnR215gK2h3NPx4PvIBXH93OxDtJvW46/8GCAoItBTeHFoit3+6p6jCim3JjK5Q9BSwRpARs0DmN6Wls7DCvhg9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760700715; c=relaxed/simple;
	bh=auMrRRq9nvq41h+0QsOEhf4+D2nLIAxomKch7W8mJeA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZxsVQ4RVTJAjPURxjcEJRCg9jG/MHz8V+xRsu/FMC8UMjeMNT+uvyJxz1U09KjmBiQQ7EdUG9JEgj7EK/l9X4iLAe92iXt6s0XPRILezc7OzZYWf4ty7e7YRzXAyvTMe+syk2hCmlvTRo9B6Z6cNAJLCScsykMctHQq+65ke0Vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=L6IGzWJ+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760700712;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IfYQfO7jJxosEiXMGUFLpMtY1IKb0H/Omai+HLZ8yss=;
	b=L6IGzWJ+No1u4iFyJEm4Kd2d2ppa2mKducjlJKS5INaPXjtnLYRgRmkbuaoKoIqhN3+cdr
	HuYmFiQUcedC7e1ODRbEgladbadXJcLqdW9qaHb3QwlArqHJcGH8fQzx3stRaWWEq8EBcu
	6rRe9QueFrcdDohS0tC++H2e0Zvh7lM=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-642-XZ9arnIPMjaSFt7wBZPQBA-1; Fri,
 17 Oct 2025 07:31:47 -0400
X-MC-Unique: XZ9arnIPMjaSFt7wBZPQBA-1
X-Mimecast-MFC-AGG-ID: XZ9arnIPMjaSFt7wBZPQBA_1760700705
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7A5C618002F5;
	Fri, 17 Oct 2025 11:31:45 +0000 (UTC)
Received: from fweimer-oldenburg.csb.redhat.com (unknown [10.45.225.12])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8E66919560B2;
	Fri, 17 Oct 2025 11:31:41 +0000 (UTC)
From: Florian Weimer <fweimer@redhat.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>,  Peter Zijlstra
 <peterz@infradead.org>,  Gabriele Monaco <gmonaco@redhat.com>,  Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>,  Michael Jeanson
 <mjeanson@efficios.com>,  Jens Axboe <axboe@kernel.dk>,  "Paul E.
 McKenney" <paulmck@kernel.org>,  "Gautham R. Shenoy"
 <gautham.shenoy@amd.com>,  Tim Chen <tim.c.chen@intel.com>,  TCMalloc Team
 <tcmalloc-eng@google.com>
Subject: Re: [patch 00/19] sched: Rewrite MM CID management
In-Reply-To: <20251015164952.694882104@linutronix.de> (Thomas Gleixner's
	message of "Wed, 15 Oct 2025 19:29:23 +0200 (CEST)")
References: <20251015164952.694882104@linutronix.de>
Date: Fri, 17 Oct 2025 13:31:39 +0200
Message-ID: <lhuzf9plq78.fsf@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

* Thomas Gleixner:

> The CID space compaction itself is not a functional correctness
> requirement, it is only a useful optimization mechanism to reduce the
> memory foot print in unused user space pools.
>
> The optimal CID space is:
>
>     min(nr_tasks, nr_cpus_allowed);
>
> Where @nr_tasks is the number of actual user space threads associated to
> the mm.
>
> @nr_cpus_allowed is the superset of all task affinities. It is growth
> only as it would be insane to take a racy snapshot of all task
> affinities when the affinity of one task changes just do redo it 2
> milliseconds later when the next task changes its affinity.

How can userspace obtain the maximum possible nr_cpus_allowed value?

Thanks,
Florian


