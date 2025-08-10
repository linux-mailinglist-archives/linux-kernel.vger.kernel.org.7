Return-Path: <linux-kernel+bounces-761494-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D3972B1FAD7
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Aug 2025 17:44:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2ACA3AA42C
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Aug 2025 15:44:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35CAD26E71F;
	Sun, 10 Aug 2025 15:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YFzSe6yB"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B421BFC0B
	for <linux-kernel@vger.kernel.org>; Sun, 10 Aug 2025 15:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754840662; cv=none; b=oWjdXqdCUt7es2wsZrToj9VQgu+ZO7TDbg9ias6k7Qg7+Ie0yu8SRk4YBshcWwb/4V1BjF1+Wv+KiU1mgAI/fg9cRKV3Gj+F1fZvAr+lMT74RGCr7wAkjjhLlcgbfKU0ZWMbUZu/cBfkyJT+4P8xEkqebTieHzj4nEb/1q49IC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754840662; c=relaxed/simple;
	bh=mo3BkmkZcz4RrvyHPFvnYtr9kBp14hLUSvFThEc66i4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HtnW+fQx/cSpknNmfCxftIZUo42KcuHWiDpjHYdmNxN52lHu0QyhuWjdgpfeMi7ZmM2BCRQP6UvxTaG0aHoU5zv8x09IN8vWx/6qB/31YsgWjmHiKpHSJxQk2aTzXJJde/sRbOSPC2o1mfibCEFWxKN28fRtsiREW14KkO2C5zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YFzSe6yB; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754840657;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=q+czV7nM5qInm3XftdXKnxWAN+sI3lLzlF5n8cEHrSA=;
	b=YFzSe6yBB4mQ6q1zYwIlJU7LhaG9KNLgdjFXTwsekeRJ1qvqDo+b31DmpgJxyXqBFHbQFP
	TLkFJH92wGqp/opzZ0h/nzhTPm+fHLgF8RoKJFD708g/Xk3+P25DPpe4IAwTkFk3KoqwMf
	RfldDCYzVPzzcd2dTQMezEEtYg17kTI=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-29-U3a_-3cYMASI1ea8uqM2tg-1; Sun,
 10 Aug 2025 11:44:13 -0400
X-MC-Unique: U3a_-3cYMASI1ea8uqM2tg-1
X-Mimecast-MFC-AGG-ID: U3a_-3cYMASI1ea8uqM2tg_1754840652
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id ADB661956080;
	Sun, 10 Aug 2025 15:44:11 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.117])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 460E418004A3;
	Sun, 10 Aug 2025 15:44:07 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Sun, 10 Aug 2025 17:43:00 +0200 (CEST)
Date: Sun, 10 Aug 2025 17:42:55 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Christian Brauner <brauner@kernel.org>
Cc: =?utf-8?B?6auY57+U?= <gaoxiang17@xiaomi.com>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Xiang Gao <gxxa03070307@gmail.com>,
	"mjguzik@gmail.com" <mjguzik@gmail.com>,
	"Liam.Howlett@oracle.com" <Liam.Howlett@oracle.com>,
	"joel.granados@kernel.org" <joel.granados@kernel.org>,
	"lorenzo.stoakes@oracle.com" <lorenzo.stoakes@oracle.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] pid: Add a judgment for ns null in pid_nr_ns
Message-ID: <20250810154255.GA11928@redhat.com>
References: <20250802022123.3536934-1-gxxa03070307@gmail.com>
 <20250802022550.GT222315@ZenIV>
 <15b18541f37447dd8d5dbd8012662f67@xiaomi.com>
 <20250802084525.GB31711@redhat.com>
 <80be47cb31d14ffc9f9a7d8d4408ab0a@xiaomi.com>
 <20250804114900.GA6656@redhat.com>
 <20250804-gepfercht-delfin-0172b1ee9556@brauner>
 <20250804124402.GB6656@redhat.com>
 <20250805124300.GB27131@redhat.com>
 <20250808-erleichtern-hinreichend-35335e412d9e@brauner>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250808-erleichtern-hinreichend-35335e412d9e@brauner>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On 08/08, Christian Brauner wrote:
>
> On Tue, Aug 05, 2025 at 02:43:01PM +0200, Oleg Nesterov wrote:
> >
> > After the quick grep I don't see the problematic users, but if a zombie
> > task T does task_ppid_nr_ns(current, NULL) the kernel can crash:
> >
> > 	- pid_alive() succeeds, the task is not reaped yet
> >
> > 	- the parent/debugger does wait()->release_task(T), T->thread_pid
> > 	  is NULL now
> >
> > 	- T calls task_tgid_nr_ns()-> ... pid_nr_ns(ns => NULL) because
> > 	  task_active_pid_ns(T) returns NULL
> >
> > Do you think this worth fixing?
>
> If it's not too much work and it is an actual real-world concern then I
> think we should fix it. But I trust your judgement here!

Well, I don't really know what to do ;)

Initially I was going to do something like below to "fix" task_tgid_nr_ns()

	--- a/include/linux/pid.h
	+++ b/include/linux/pid.h
	@@ -299,7 +299,9 @@ static inline pid_t task_ppid_nr_ns(const struct task_struct *tsk, struct pid_na
		pid_t pid = 0;
	 
		rcu_read_lock();
	-	if (pid_alive(tsk))
	+	if (!ns)
	+		ns = task_active_pid_ns(current);
	+	if (ns && pid_alive(tsk))
			pid = task_tgid_nr_ns(rcu_dereference(tsk->real_parent), ns);
		rcu_read_unlock();

and then add WARN_ON() into pid_nr_ns(). But note that we should not check 'ns'
before 'pid', we need

	--- a/kernel/pid.c
	+++ b/kernel/pid.c
	@@ -491,7 +491,13 @@ pid_t pid_nr_ns(struct pid *pid, struct pid_namespace *ns)
		struct upid *upid;
		pid_t nr = 0;
	 
	-	if (pid && ns->level <= pid->level) {
	+	if (!pid)
	+		return nr;
	+
	+	if (WARN_ON_ONCE(!ns)
	+		return nr;
	+
	+	if (ns->level <= pid->level) {
			upid = &pid->numbers[ns->level];
			if (upid->ns == ns)
				nr = upid->nr;

Think of task_pid_vnr(current) from a zombie, it should return 0 without warning.


But this looks overcomplicated to me. So I am going to send the patch which simply
changes __task_pid_nr_ns()

	--- a/kernel/pid.c
	+++ b/kernel/pid.c
	@@ -514,7 +514,8 @@ pid_t __task_pid_nr_ns(struct task_struct *task, enum pid_type type,
		rcu_read_lock();
		if (!ns)
			ns = task_active_pid_ns(current);
	-	nr = pid_nr_ns(rcu_dereference(*task_pid_ptr(task, type)), ns);
	+	if (ns)
	+		nr = pid_nr_ns(rcu_dereference(*task_pid_ptr(task, type)), ns);
		rcu_read_unlock();


and leave pid_nr_ns() alone.

People will do mistakes, it is better not to crash and just return 0 if, say,
a zombie task does task_pid_vnr(another_task). Currently it is not simple to
do this correctly because, again, the pid_alive(current) check can't help.

pid_nr_ns() is more "low-level", its users should know what they are doing.

Although the quick grep suggests many of cleanups. Say, why kvm_create_pit()
does get_pid? why can't it simply use task_tgid_vnr(current). Even do_getpgid()
and sys_getsid() look overcomplicated. Later.

Oleg.


