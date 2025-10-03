Return-Path: <linux-kernel+bounces-841567-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5201DBB7AB7
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 19:11:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B145C3A9C8F
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 17:11:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A5882D879B;
	Fri,  3 Oct 2025 17:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KuhPVNGE"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FA0A2D8785
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 17:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759511485; cv=none; b=nJSYlNRpk9YpjmdzgmFKTHYtFBAhfZjbKWP6xaarNR5M+d9wtGa9PbQwZKkUCz5asryf4O27Iz9Ue2FG9trhlO3Y532iVSqb6ynjJHabn4PdqUyMYgEqhR+N//Y40QmQqCN/OO4IoiX72kNV4v4TSUcMx4J6vI0YeIoseHjr+xQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759511485; c=relaxed/simple;
	bh=Eqopze8mLHmie+XpAFzVELpXFnRbtvL2IIe3/C0KdJU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=spa9mJV2zxp6in5aRHjxQzNWFkc5yH0XvVQl1SS9nBSZcXabr0D78Yd96iof6/uze98x/rqpzjONH5a3mthcTTm3Iv+McvjPNi/pXV8O5VLpHlkxUQnnb5QQDW8NU5mfepE9Zd1yBry8kHPH3nANpN56x6gY4HH+MbEwnUw01to=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KuhPVNGE; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759511480;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YPYNDkWkWnXcllRo0K9Cv4VDN4dwzK9qLlf5CsLGwPI=;
	b=KuhPVNGEL9sEHYk1d8gLPuuq50rlncD5SYZ3BcwXwbWxhFHMIUuha/AhmzhZvdeImCiFWL
	IUVI536Kxy1sASVcDKZso0ZbIZ2/pt4lysL3MMDVUphSh2lKYZg0XXL3uUnW+SezzX7djo
	x9KeTyvFC0u7PypP8E2FWGJCRpOw/LA=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-614-FKJkg4IyM-q4rWL8zmac8g-1; Fri,
 03 Oct 2025 13:11:16 -0400
X-MC-Unique: FKJkg4IyM-q4rWL8zmac8g-1
X-Mimecast-MFC-AGG-ID: FKJkg4IyM-q4rWL8zmac8g_1759511475
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3ABA618004D8;
	Fri,  3 Oct 2025 17:11:14 +0000 (UTC)
Received: from localhost (unknown [10.22.90.35])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9A5661800577;
	Fri,  3 Oct 2025 17:11:12 +0000 (UTC)
Date: Fri, 3 Oct 2025 14:11:11 -0300
From: "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Waiman Long <longman@redhat.com>, Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	Andrea Righi <righi.andrea@gmail.com>,
	Julia Lawall <Julia.Lawall@inria.fr>,
	Joseph Salisbury <joseph.salisbury@oracle.com>
Subject: Re: [PATCH] sched: cgroup: Move task_can_attach() to cpuset.c
Message-ID: <aOADr3PABpCs142e@uudg.org>
References: <20251003121421.0cf4372d@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251003121421.0cf4372d@gandalf.local.home>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On Fri, Oct 03, 2025 at 12:14:21PM -0400, Steven Rostedt wrote:
> From: Steven Rostedt <rostedt@goodmis.org>
> 
> At our monthly stable meeting, we were talking about documenting non
> static functions and randomly picked a function to look at. That was
> task_can_attach(). It was then noticed that it's only used by
> cgroup/cpuset.c and nothing else. It's a simple function that doesn't
> reference anything unique to sched/core.c, hence there's no reason that
> function should be there.
> 
> Move it to cgroup/cpuset.c as that's the only place it is used. Also make
> it a static inline as it is so small.
> 
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---
>  include/linux/sched.h  |  1 -
>  kernel/cgroup/cpuset.c | 19 +++++++++++++++++++
>  kernel/sched/core.c    | 19 -------------------
>  3 files changed, 19 insertions(+), 20 deletions(-)

That was a fun exercise. :)

Tested-by: Luis Claudio R. Goncalves <lgoncalv@redhat.com>


