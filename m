Return-Path: <linux-kernel+bounces-817116-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BB9CB57E2F
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 15:58:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66E593A3F1D
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 13:55:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B60830CD98;
	Mon, 15 Sep 2025 13:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SYz7aFmy"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8B072F618F
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 13:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757944486; cv=none; b=pgLq6du/iWdGLVU654LpvrOmu+bY8aWi7h3tXob7tMAJSV8SgkIdmvBZ46BB031G/xFPz+03ojOOH6y/7HUuIEAKIDnDK5PqqFlSyQTnMiEH8o4L7UlCh02OXDCQBXT9l4xFBSc0f7gb87/H+cvHciPWFE01fI1wyCv96h0kT+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757944486; c=relaxed/simple;
	bh=5kHZ2ZumyY6Uds49NUFaU03eekYBGWy5TgWunu2YoMg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SYmul74DgAMr2QJs1fUcEuytGs11lTqu/1hLhsL1ghKyw8yTMjaiug9nYjvmLETb5gegXVYce1+dqujJU4gUcPm62K0cYtLuEm+kQwcGxle9VlZlSLw0OUgvVJLjucEBxg/8SZTWqtlxhRTi7/ebq/Fp5LC3uKFy6YZdmN2I9TU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SYz7aFmy; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757944483;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3GLXIRLAPltnu0Qov66sDO9Rn9TOIYjilOF6l1LKNWw=;
	b=SYz7aFmyeDUHTPC8l4pQJc4FktkG4LRKG/fVaWnrBVxDlA/5DSW6LgqKB0rGJOZet6y7yZ
	MKVXFTlKqeiR8gz+NhZMQBK9ftaLQYCvFHrZ53YcjDqfQpTLFA9qfRnpiT76LOjR4brrEN
	KFW6n9tQ9MiYiPtIY9vdF837C9fwujs=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-315-pA8VY7XIPmuORCnTcuEkZg-1; Mon, 15 Sep 2025 09:54:42 -0400
X-MC-Unique: pA8VY7XIPmuORCnTcuEkZg-1
X-Mimecast-MFC-AGG-ID: pA8VY7XIPmuORCnTcuEkZg_1757944481
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3ccd58af2bbso1796163f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 06:54:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757944481; x=1758549281;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3GLXIRLAPltnu0Qov66sDO9Rn9TOIYjilOF6l1LKNWw=;
        b=B/w9tOaZNvRGvOfv57Z+6g862XQnhQxNivwc1DRssJka2CXC5me1tSZg6LGvjO6LTk
         oIu4dNRLaxj+S/UL/qm86cPkUb7Cgw/n2yrW7so/0y68+gPnFKjHTykfZNYvz7O4XYo8
         agzl1iOvgwGPaa+wARomhOfYloxXmy0Fh1jeggyJ8guyEORVwY2Q3vVtmPkNFBqMrZMh
         c4IUz+9dVtRlfuAgZ0wNU0RFXA4FE86wEW2ztb1n6I9YxRMCtZPo59iN86MAn7pAcQF9
         PUjSUUhKtApiJLnbJjJQ7riAdhGnkT8enbXeaT6Zv+Ei4QRpRgLXhlbwxo3sTpApN+jE
         vaPw==
X-Gm-Message-State: AOJu0Yw+aqNjpHydknl+FovAKq1Wxm9KDNcANtZhr4lDgWWHptfVZuTq
	AzDLHBQ5hECJQNNaVqkP1eS4zSAJEUpP1FN4Le2DFnPf/qherK9yiDo8b859IOkjBuWjezHMkui
	swdCA7SBkacBv7EZaxN1h9Wp75nrG7HpeysFJVC3WTNT/HGJuvZ0PiFUzk1fNHvIioA==
X-Gm-Gg: ASbGnctWSknQlKi8tVu4IeU4Vaqoc3JrHFZe8UsTNvOm3aINIkztzMjLODAbHIy6jZF
	J6hMcNn8/KbSYtaME18jAUk4YXZ+BUyjE4CxsEcsZ2HC8efZFSukEQ8V7DAI6BiPNfYbWb/EAH5
	kAIrPTOUZF4Qcrsj/ZWICebgiRsL40MbXv2R2gYL/bv9zw9F40llwyuQQccSnmgwj/qsHbjTZLR
	I5/ntGbcNlBqCuQMRl2B5hEno+dLFZ4PVWFZzlsPcbA5h2lv026CWVxpWRbqwg7Zq8pxWj6fGjX
	Rs2KYH/FGaTQFJ5CGZPgfStY0EyEFuFtQSMknrrSLZzobfBhe0n7sA+RjeP2jhy44ntBD9g=
X-Received: by 2002:a05:6000:240a:b0:3d8:3eca:a97d with SMTP id ffacd0b85a97d-3e7657aa17fmr10419978f8f.11.1757944481174;
        Mon, 15 Sep 2025 06:54:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHA5YDoT5ZonD1oRjm78gfqjL7toONiuwpXr3Qr7akewD6mU5mnA9noV9svX5tG2WrAmhbC0g==
X-Received: by 2002:a05:6000:240a:b0:3d8:3eca:a97d with SMTP id ffacd0b85a97d-3e7657aa17fmr10419955f8f.11.1757944480748;
        Mon, 15 Sep 2025 06:54:40 -0700 (PDT)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.29.70.210])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e7607878c9sm17961049f8f.26.2025.09.15.06.54.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 06:54:39 -0700 (PDT)
Date: Mon, 15 Sep 2025 15:54:37 +0200
From: Juri Lelli <juri.lelli@redhat.com>
To: Marcel Ziswiler <marcel.ziswiler@codethink.co.uk>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Vineeth Pillai <vineeth@bitbyteword.org>,
	Luca Abeni <luca.abeni@santannapisa.it>
Subject: Re: SCHED_DEADLINE tasks causing WARNING at kernel/sched/sched.h
 message
Message-ID: <aMgana01-nsNq-XB@jlelli-thinkpadt14gen4.remote.csb>
References: <a90ee087c4dc21bbd548c933256d6b4a877a9fd9.camel@codethink.co.uk>
 <7481bbd7c6652a963f132191dc622f1003938706.camel@codethink.co.uk>
 <aLlabksolt1imHXe@jlelli-thinkpadt14gen4.remote.csb>
 <ac735cc59bbdccd3e99f5fa9c779b3904d19f990.camel@codethink.co.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ac735cc59bbdccd3e99f5fa9c779b3904d19f990.camel@codethink.co.uk>

On 12/09/25 12:03, Marcel Ziswiler wrote:
> Hi Juri
> 
> Thanks for getting back to me and sorry for my late reply.
> 
> On Thu, 2025-09-04 at 11:22 +0200, Juri Lelli wrote:
> > Hi Marcel,
> > 
> > On 02/09/25 18:49, Marcel Ziswiler wrote:
> > > Hi
> > > 
> > > On Tue, 2025-09-02 at 16:06 +0200, Marcel Ziswiler wrote:
> > > > As part of our trustable work [1], we also run a lot of real time scheduler (SCHED_DEADLINE) tests on the
> > > > mainline Linux kernel (v6.16.2 in below reported case).
> > > 
> > > Looking through more logs from earlier test runs I found similar WARN_ONs dating back as early as v6.15.3.
> > > So
> > > it does not look like a "new" issue in that sense.
> > > 
> > > [snip]
> > > 
> > > Any help is much appreciated. Thanks!
> > 
> > What's the actual workload composition leading the warning. I noticed
> > stress-ng in the report. Could you please share more details?
> 
> Yes, sure. It's actually the exact same workload as related to the regression I reported back in April [1].

Ah, OK. So it's the workload I reproduced (with rt-app) while working on
fixing that issues, and I didn't hit the WARN.

I am thinking that we might try to get more info about what's going on
by adding some trace_printks for balance callbacks and then stopping
tracing in case a WARN is hit.

Could you please, with the following, start tracing for sched_switch,
sched_migrate_task and sched_wakeup and add traceoff_on_warning to
kernel cmdline. Then share what was collected.

Thanks!
Juri

---
 kernel/sched/core.c  | 4 ++++
 kernel/sched/sched.h | 2 ++
 2 files changed, 6 insertions(+)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index da2062de97a2..7b32828b94bc 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5011,6 +5011,7 @@ static void do_balance_callbacks(struct rq *rq, struct balance_callback *head)
 		head->next = NULL;
 		head = next;
 
+		trace_printk("cpu=%d callback=%pS\n", rq->cpu, func);
 		func(rq);
 	}
 }
@@ -8211,6 +8212,7 @@ static void balance_push(struct rq *rq)
 	/*
 	 * Ensure the thing is persistent until balance_push_set(.on = false);
 	 */
+	trace_printk("cpu=%d callback=%pS\n", rq->cpu, &balance_push_callback);
 	rq->balance_callback = &balance_push_callback;
 
 	/*
@@ -8273,8 +8275,10 @@ static void balance_push_set(int cpu, bool on)
 	rq_lock_irqsave(rq, &rf);
 	if (on) {
 		WARN_ON_ONCE(rq->balance_callback);
+		trace_printk("cpu=%d on=%d callback=%pS\n", rq->cpu, on, &balance_push_callback);
 		rq->balance_callback = &balance_push_callback;
 	} else if (rq->balance_callback == &balance_push_callback) {
+		trace_printk("cpu=%d on=%d callback=%pS\n", rq->cpu, on, NULL);
 		rq->balance_callback = NULL;
 	}
 	rq_unlock_irqrestore(rq, &rf);
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index b5367c514c14..f91fc2d36c81 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1963,6 +1963,8 @@ queue_balance_callback(struct rq *rq,
 	if (unlikely(head->next || rq->balance_callback == &balance_push_callback))
 		return;
 
+	trace_printk("cpu=%d callback=%pS\n", rq->cpu, func);
+
 	head->func = func;
 	head->next = rq->balance_callback;
 	rq->balance_callback = head;
-- 


