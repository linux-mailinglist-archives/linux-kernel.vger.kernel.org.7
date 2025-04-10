Return-Path: <linux-kernel+bounces-597711-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 27285A83D92
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Apr 2025 10:54:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12D264625B2
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Apr 2025 08:53:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BF8F2040A8;
	Thu, 10 Apr 2025 08:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TCpTonVv"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2502920C496
	for <linux-kernel@vger.kernel.org>; Thu, 10 Apr 2025 08:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744275223; cv=none; b=cwzhrGA1XA2ABxGBrkyP5FMZIHW58rfkWtvAwMCAGewy+D08TARWOm2FTP9vTepqQQXsye22EXQJql6JrN/bAZEE/8s4Db6hW9clGn5ehhWKtIZaPIWyyRcwvGQfR6QCLBn+1UDLLCXLFJljSq7hVpms6D5jVgWL4Llcxa7iY38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744275223; c=relaxed/simple;
	bh=fVLSQBRdXbHr2MS5+vi7RGVvfjmTrBOZyZlbctzX2cc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lo+NMxMzoqa7DXFQOyunNjCYquKmOiaVzrAosFK6km1S/+OTrPkM3gOM7IFXyug57GprcQUcTFt5oNci1Jjk7ZeBpwO940pYO7DPN6I9ogjThOv1ER8CA9E/cyg2adb6YCHqGbbLc6Nrx9Dt4iWuzQxUuE5MO8S1kVEcAnLRScw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TCpTonVv; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744275220;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1SmiyRMjzQQqXjsSoU5Im9okCaP3DYrJ1REzbecGMgA=;
	b=TCpTonVvuigIvCbx17poL+0fkQIE/fhaY6Fuyr3aIjeh2vc9gTPTQjmbjrM955xPFeJafS
	aGUUv7Bi7PfETgKHsMC7S8SQzm8X4cDwwhkD3Iiu+0oEGoPfmF9eAGnZ3eRcd7wmRy/M/Z
	fXxX31WdfEOactaNXgh3eTfRmxx8cSY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-460-exxo2KvyN5Gu5V4Iw-NycA-1; Thu, 10 Apr 2025 04:53:38 -0400
X-MC-Unique: exxo2KvyN5Gu5V4Iw-NycA-1
X-Mimecast-MFC-AGG-ID: exxo2KvyN5Gu5V4Iw-NycA_1744275217
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-43cf44b66f7so4607545e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Apr 2025 01:53:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744275217; x=1744880017;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1SmiyRMjzQQqXjsSoU5Im9okCaP3DYrJ1REzbecGMgA=;
        b=B7YGk1rWYxFbAoFI5/JyCg7uhe0kJ6fTUQR8KMJxsGmPFPrvbJDLkTm9N4Jv+YQh3K
         WRmjnCsVLsRmTvPT/EOr6sxR5i2IPXzfyd5b6PqqWBI55mefWuqb4iMniHB+d8zKoU7k
         hfIh0f3kJQb9IFQDSTBfzvauXrYZWJhMU4xtQaiKrms6/11JuFcIZiQpWkbI4SLtVVs3
         pwtXMak0bQuxLk6EmHd6qJzKfGjoXtaxhvd4G3KLPCx7x1sJuTu+4IUf5X98cm9l979F
         Q/3V0uQ9NvIMOL0f/QfuiKUL0301nkBoHIVb6+4EY4n5HUEyd/8TqzffhbmmORpYzhbi
         +PYg==
X-Gm-Message-State: AOJu0Yz+roubb1se/FAQfqV/C4CB/NhAqeCA7zRovC/Awa5xj25CFJny
	cJdBvBxsaPJY4AS0ioOFmULlKzIYoR/FM32ZusnWXKvtkT9+VB3iNq3WOyucDdVQ2PRWwr0EYoG
	15syQE6vk+IeGProMY2gVu8PeEmX1x1tLGQJeUFxV7F/Vh1Nq84HdDESme1hMBg==
X-Gm-Gg: ASbGnct2ObVGBT9kj8r4vDLsa0fwef67LBBwpomuljQ9waF/MLABS63/5cwu+TelEVd
	vNxHnwYMzblp3bIzcnCN4wnlbyd7XPoBlj3OeQ1vjC5TmfW2wfCznQvief75PgB5PdQ0JzyF7VF
	wvFIdZGObiVTzh5aLesZh5GshxCvEPH8ABoTp2SkbBl2suMNJqPPE+wuG6SsPzksWpmnJyUQORE
	XchZWyTWnCu/+9W+D4EkcZB8NCphu5UKSrQzWkYEiEjtCmWZo9Risxd2+81ZjoVXoPMjD3qSotG
	6eObdsBtou58RJkpePR4mEZRaAIya94L6zsdIGnGBPw=
X-Received: by 2002:a05:600c:3b0d:b0:43c:ea40:ae4a with SMTP id 5b1f17b1804b1-43f2d98b709mr23627005e9.31.1744275217430;
        Thu, 10 Apr 2025 01:53:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHkgjS6DJy42J7oCRD/T/lyrUvWYjKsmRJi3sXXVt5rMwqXTVWXcayHO7ebX6QAYtA3nxJyWA==
X-Received: by 2002:a05:600c:3b0d:b0:43c:ea40:ae4a with SMTP id 5b1f17b1804b1-43f2d98b709mr23626755e9.31.1744275217030;
        Thu, 10 Apr 2025 01:53:37 -0700 (PDT)
Received: from jlelli-thinkpadt14gen4.remote.csb ([176.206.22.101])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39d893f0a75sm4175687f8f.62.2025.04.10.01.53.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Apr 2025 01:53:36 -0700 (PDT)
Date: Thu, 10 Apr 2025 10:53:34 +0200
From: Juri Lelli <juri.lelli@redhat.com>
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Tomas Glozar <tglozar@redhat.com>, Juri Lelli <jlelli@redhat.com>
Subject: Re: [RFC PATCH 9/9] rv: Add srs per-task monitor
Message-ID: <Z_eHDlLIG2SZwyfY@jlelli-thinkpadt14gen4.remote.csb>
References: <20250404084512.98552-11-gmonaco@redhat.com>
 <20250404084512.98552-20-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250404084512.98552-20-gmonaco@redhat.com>

Hi Gabriele,

On 04/04/25 10:45, Gabriele Monaco wrote:
> Add a per-task monitor for task switches as part of the sched model:
> 
> * srs:
>     Monitor to describe conditions for different types of task switch.
>     This monitor enforces rules such as preempt after setting need
>     for reschedule and suspend after setting a task to sleepable.
> 
> This new monitor implies the previously introduced snroc (set non
> runnable on its own context), so replace that monitor with srs.
> 
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
> ---

...

> +Monitor srs
> +-----------
> +
> +The switch after resched or sleep (srs) monitor describes conditions for
> +different types of task switch. This is a complex model, below we are going to

Quite the ASCII art indeed. :-)

> +explain it step by step. Unfortunately splitting this into smaller monitor is
> +not trivial due to some shared events such as ``switch_in``::

Not splitting, but maybe providing several separate diagrams for the key
cases and transitions might help grasping the complete picture? Not
sure, just a thought.

In the below, set_{sleepable,runnable} corresponds to set_state_
{sleepable,runnable} in the code, does it? Not a big deal, but I was
confused at first.

Thanks,
Juri

> +
> +                                                      set_runnable
> +                                  |                        wakeup +---+
> +                                  |                   switch_vain |   |
> +                                  v                               |   v      wakeup
> +                         #================================================#  set_runnable
> +      switch_in          H                                                H <----------+
> +    +------------------> H                    running                     H            |
> +    |                    H                                                H -----+     |
> +    |                    #================================================#      |     |
> +    |                         |        |                |         ^    ^         |     |
> +    |                         |  switch_yield      need_resched   |    |         |     |
> +    |                         |        |      need_resched_lazy   |    |         |     |
> +    |                set_sleepable     v                |         |    |         |     |
> +    |                         |      +-------------+    |         |    |         |     |
> +    |                +--------+----> |  preempted  | ---+- switch_in   |         |     |
> +    |                |        |      +-------------+    |              |         |     |
> +    |        switch_preempt   |        |                |              |         |     |
> +    |        switch_yield     |   need_resched          |   +- switch_vain       |     |
> +    |                |        |        v                |   |                    |     |
> +    |                |        |      +-------------+    |   |                    |     |
> +    |  need_resched -+--------+----> | resched_out |    |   |                    |     |
> +    |  |             |        |      +-------------+    |   |                    |     |
> +    |  |             |        |        |                |   |     need_resched   |     |
> +    |  |             |        |    switch_in            |   |     wakeup         |     |
> +    |  |             |        |        v                v   |     set_runnable   |     |
> +    |  |             |        |      +--------------------------+ -------+       |     |
> +    |  |             |        |      |                          |        |       |     |
> +    |  |             +--------+----- |       rescheduling       | <------+       |     |
> +    |  |                      |      |                          |                |     |
> +    |  |                      |      +--------------------------+ -----------+   |     |
> +    |  |                      |        |           ^ wakeup                  |   |     |
> +    |  |                      |  set_sleepable   set_runnable                |   |     |
> +    |  |                      |        v           |                         |   |     |
> +    |  |   +------------------+----- +---------------------------+           |   |     |
> +    |  |   |                  |      |                           |           |   |     |
> + +--+--+---+------------------+----> |     resched_sleepable     | ---+      |   |     |
> + |  |  |   |                  |      |                           |    |      |   |     |
> + |  |  |   |    +-------------+----> +---------------------------+    |      |   |     |
> + |  |  |   |    |             |        |           ^      |           |      |   |     |
> + |  |  |   |    |             |  switch_preempt    | need_resched     |      |   |     |
> + |  |  |   |    |             |        |           | set_sleepable    |      |   |     |
> + |  |  |   |    |             |        v           +------+           |      |   |     |
> + |  |  |   |    |             |       +---------------------------+ --+------+---+-----+--+
> + |  |  |   |    |             |       |    preempted_sleepable    |   |      |   |     |  |
> + |  |  |   |    |             |       +---------------------------+ --+------+---+--+  |  |
> + |  |  |   |    |             |         |             ^               |      |   |  |  |  |
> + |  |  |   |    |             |     switch_in   switch_preempt        |      |   |  |  |  |
> + |  |  |   |    |             |         v             |          switch_vain |   |  |  |  |
> + |  |  |   |    |             |        +-------------------------+    |      |   |  |  |  |
> + |  |  |   |    |             +------> |                         | <--+      |   |  |  |  |
> + |  |  |   |    |                      |        sleepable        |           |   |  |  |  |
> + |  |  |   |    +- need_resched------- |                         | ----------+---+--+--+  |
> + |  |  |   |       need_resched_lazy   +-------------------------+           |   |  |     |
> + |  |  |   |                              |      ^      |          switch_block  |  |     |
> + |  |  |   |                              |      | set_sleepable             |   |  |     |
> + |  |  |   |                      switch_block   | switch_vain    +----------+   |  |     |
> + |  |  |   |                    switch_suspend   +------+         |              |  |     |
> + |  |  |   |                              v                       v              |  |     |
> + |  |  |   |   switch_block          +-----------------------------+  switch_block  |     |
> + |  |  |   +-switch_suspend--------> |          sleeping           | <-----------+  |     |
> + |  |  |                             +-----------------------------+                |     |
> + |  |  |                               | wakeup                                     |     |
> + |  |  |                               v                                            |     |
> + |  |  +- need_resched ------------- +-------------+  wakeup                        |     |
> + |  |                                |   waking    | <------------------------------+     |
> + |  +------------------------------- +-------------+                                      |
> + |                                                                                        |
> + |                         +-----------------------+                                      |
> + +----- switch_in -------- | resched_out_sleepable | <-- sched_need_resched --------------+
> +                           +-----------------------+
> +
> +Types of switches:
> +
> +* ``switch_in``:
> +  a non running task is scheduled in, this leads to ``running`` if the task is
> +  runnable and ``sleepable`` if the task was preempted before sleeping.
> +* ``switch_suspend``:
> +  a task puts itself to sleep, this can happen only after explicitly setting
> +  the task to ``sleepable``. After a task is suspended, it needs to be woken up
> +  (``waking`` state) before being switched in again. The task can be set to
> +  ``resched_sleepable`` via a ``need_resched`` but not preempted, in which case it
> +  is equivalent to ``sleepable``.
> +  Setting the task's state to ``sleepable`` can be reverted before switching if it
> +  is woken up or set to runnable.
> +* ``switch_blocked``:
> +  a special case of a ``switch_suspend`` where the task is waiting on a
> +  sleeping RT lock (``PREEMPT_RT`` only), it is common to see wakeup and set
> +  state events racing with each other and this leads the model to perceive this
> +  type of switch when the task is not set to sleepable. This is a limitation of
> +  the model in SMP system and workarounds may require to slow down the
> +  scheduler.
> +* ``switch_yield``:
> +  a task explicitly calls the scheduler, this looks like a preemption as the
> +  task is still runnable but the ``need_resched`` flag is not set. It can
> +  happen after a ``yield`` system call or from the idle task.
> +* ``switch_preempt``:
> +  a task is ``preempted``, this can happen after the need for ``rescheduling``
> +  has been set, also in its ``lazy`` flavour. ``need_resched`` can be set as a
> +  flag to the task or in the per-core preemption count, either of them can
> +  trigger a preemption.
> +  The task was previously running and can be switched in directly, but it is
> +  possible that a task is preempted after it sets itself as ``sleepable``
> +  (``preempted_sleepable``), in this condition, once the task is switched back
> +  in, it will not be ``running`` but continue its sleeping process in
> +  ``sleepable``.
> +* ``switch_vain``:
> +  a task goes through the scheduler but it is picked as the next task to run,
> +  hence no real task switch occurs. Since we run the scheduler, this clears the
> +  need to reschedule.
> +

...

> +enum events_srs {
> +	sched_need_resched_srs = 0,
> +	sched_need_resched_lazy_srs,
> +	sched_set_state_runnable_srs,
> +	sched_set_state_sleepable_srs,
> +	sched_switch_blocking_srs,
> +	sched_switch_in_srs,
> +	sched_switch_preempt_srs,
> +	sched_switch_suspend_srs,
> +	sched_switch_vain_srs,
> +	sched_switch_yield_srs,
> +	sched_wakeup_srs,
> +	event_max_srs
> +};
> +


