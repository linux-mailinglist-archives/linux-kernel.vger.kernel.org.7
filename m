Return-Path: <linux-kernel+bounces-750328-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 184B2B15A19
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 09:59:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 260693A7FE2
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 07:59:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C47BD291C23;
	Wed, 30 Jul 2025 07:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="AULFQAK9"
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A64A101E6
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 07:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753862371; cv=none; b=pux+6I9UdImvhzTDFNVkFnrQ+hPYlOxHF2TScHuzeA9aUyQW8DGP/WW2IN5PfKi7AjVHfkfXcBdnQ5DFz2psYTAlQ8gpby/6Wsr7N6isBYjTC3OrkVFyPyrvb9oyXLK8T5XXnG1TWUE8yfGkmnoWfa/5oVP/1GkiqPjQnZP2BOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753862371; c=relaxed/simple;
	bh=y4SL9+GGy9xNGZOWmYz9n3AeLtr7OKx24Fizraj/nlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MzNIfWc080/t8EarmFT6ORu2/LEcD2X42ysiBQllWZU/wA5wkAY65o3dcRStnd/KmA84IogwwaB19mrXkC+HyRJb55tW/SSiM92tiHgLIIavkSWOnxrAMB36cv2RTBkuhs94Qw3QsBk03gD4aVMXYjandJfUO4qf/+inRH34yKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=AULFQAK9; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-b390d09e957so6898673a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 00:59:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1753862369; x=1754467169; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ppQEYA6PEQukgbI5/u3lRql6gX2RUDaFwY+o3TibgFw=;
        b=AULFQAK9KcwAktLvC5XKky/BNSr6szCSXVwez428jxFlwbo6kRPjyGjyH+SNMHb0FO
         xiWgKXROUFjU+at9ZJ8q44siekj/4qxwMDBLn6GXZmtggIfmQoijujQSSW7OEkt6HUbb
         LYsVquw35LkF7vbYwZOGSgvvyJSGkvPx6qGTM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753862369; x=1754467169;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ppQEYA6PEQukgbI5/u3lRql6gX2RUDaFwY+o3TibgFw=;
        b=F/mjWk1BxaVSHLznFQGJhMY19tcO8sujdh3mGHwFRQgY7tVxZooyH0ccEoUuWHLeis
         QeoI7/oiTqkn5txUcmBW6Fl5b+taX8tkYmw0YftqxLt89vzH1PkF/hgibLecOin4WrPN
         VXtBI2We2Avmtck3AwZNfx53/0wuVrBR+ReR0WqeRfhF7W3+vCTfneCYdYUE0IFjoLl3
         dxSEYrCDnUFnnEbaIcBXSWKx1c/N3eRT832Pt5fCmOXwj6UoIrRQcgQWroOlwlN671Tc
         Q0wF1mm197Xs34CTiLVIDxdCbNLkSQn/oThqVDsPdZrbT8oKpOWuHHwfwh1+0Q/TbCaO
         d2NA==
X-Forwarded-Encrypted: i=1; AJvYcCUEVRqJIMiKOazFAaNAunGXf5GkM0PUhNA4ENiF5Dj43RL8iKebhvi0S5QGhQwfmicOHFCrLArtJTrKBpc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3ao1iIdroYBRdKLegOtqLbqWwN0rF3pbgrs+i3pvAPuj1OUpz
	tMpg3o4whRCOzEw76Bs/cVQm1QLdsj96cThCfVtExe5X5pMq/SccFL/BUI/9fHytNg==
X-Gm-Gg: ASbGncuUw9QcQIbW8fqn+Sx0UKW1y6FUvaUVUfviGhKBoRXXtZMolXfjVoXtJEpMqaO
	RlliHhXZMabXNefX0cFzDA2jBa/dt6UQz4uTOEZ4wYq0J/raAfHUG/8beS75VK/Vg95LXc3xfP5
	cHrEju+8Fv8MaWEOp2zX4cBwdLM4G1nRUZTm+0CJtCWwXaqx9Fnr9kiIAT4KD/kZQliSusjftop
	net6Q+DfwOAWo/UO585MznmLZ0/+w7BzXN6WWXjjXpGjr9DFUTIjlC5LBL5J0CXOL99UpIwKwl6
	GYZTqbMsAfh/qW513kHPdVXK5lJRjOCfCPuMKeZFAOKwv8i85iixxUtZaq1DEpS/1s2rSO2ibZD
	X/qztZqzXeezl1aBrv4P7kPR8
X-Google-Smtp-Source: AGHT+IF5cqW+MyWJtIMuD182pcw/GH2UdNMbPs9F8Pey0BstbUXezcOMp1KRUzvls+wThdPqmHmhng==
X-Received: by 2002:a17:90b:1b48:b0:31f:4a91:4e97 with SMTP id 98e67ed59e1d1-31f5de1ea3cmr3455804a91.7.1753862368777;
        Wed, 30 Jul 2025 00:59:28 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:6490:361:df77:361d])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31f63e3bf4dsm1254134a91.36.2025.07.30.00.59.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jul 2025 00:59:28 -0700 (PDT)
Date: Wed, 30 Jul 2025 16:59:22 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Will Deacon <will@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Boqun Feng <boqun.feng@gmail.com>, Waiman Long <longman@redhat.com>, 
	Joel Granados <joel.granados@kernel.org>, Anna Schumaker <anna.schumaker@oracle.com>, 
	Lance Yang <ioworker0@gmail.com>, Kent Overstreet <kent.overstreet@linux.dev>, 
	Yongliang Gao <leonylgao@tencent.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Tomasz Figa <tfiga@chromium.org>, Sergey Senozhatsky <senozhatsky@chromium.org>, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/2] hung_task: Show the blocker task if the task is
 hung on mutex
Message-ID: <tfzs3z7yjs6ppobm53hxwjzhhptgq2aqc2obylblz5rk7mdstg@bkas4xcq66xk>
References: <174046694331.2194069.15472952050240807469.stgit@mhiramat.tok.corp.google.com>
 <174046695384.2194069.16796289525958195643.stgit@mhiramat.tok.corp.google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <174046695384.2194069.16796289525958195643.stgit@mhiramat.tok.corp.google.com>

On (25/02/25 16:02), Masami Hiramatsu (Google) wrote:
> The "hung_task" shows a long-time uninterruptible slept task, but most
> often, it's blocked on a mutex acquired by another task. Without
> dumping such a task, investigating the root cause of the hung task
> problem is very difficult.
> 
> This introduce task_struct::blocker_mutex to point the mutex lock
> which this task is waiting for. Since the mutex has "owner"
> information, we can find the owner task and dump it with hung tasks.
> 
> Note: the owner can be changed while dumping the owner task, so
> this is "likely" the owner of the mutex.
> 
> With this change, the hung task shows blocker task's info like below;
> 
>  INFO: task cat:115 blocked for more than 122 seconds.
>        Not tainted 6.14.0-rc3-00003-ga8946be3de00 #156
>  "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
>  task:cat             state:D stack:13432 pid:115   tgid:115   ppid:106    task_flags:0x400100 flags:0x00000002
>  Call Trace:
>   <TASK>
>   __schedule+0x731/0x960
>   ? schedule_preempt_disabled+0x54/0xa0
>   schedule+0xb7/0x140
>   ? __mutex_lock+0x51b/0xa60
>   ? __mutex_lock+0x51b/0xa60
>   schedule_preempt_disabled+0x54/0xa0
>   __mutex_lock+0x51b/0xa60
>   read_dummy+0x23/0x70
>   full_proxy_read+0x6a/0xc0
>   vfs_read+0xc2/0x340
>   ? __pfx_direct_file_splice_eof+0x10/0x10
>   ? do_sendfile+0x1bd/0x2e0
>   ksys_read+0x76/0xe0
>   do_syscall_64+0xe3/0x1c0
>   ? exc_page_fault+0xa9/0x1d0
>   entry_SYSCALL_64_after_hwframe+0x77/0x7f
>  RIP: 0033:0x4840cd
>  RSP: 002b:00007ffe99071828 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
>  RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00000000004840cd
>  RDX: 0000000000001000 RSI: 00007ffe99071870 RDI: 0000000000000003
>  RBP: 00007ffe99071870 R08: 0000000000000000 R09: 0000000000000000
>  R10: 0000000001000000 R11: 0000000000000246 R12: 0000000000001000
>  R13: 00000000132fd3a0 R14: 0000000000000001 R15: ffffffffffffffff
>   </TASK>
>  INFO: task cat:115 is blocked on a mutex likely owned by task cat:114.
>  task:cat             state:S stack:13432 pid:114   tgid:114   ppid:106    task_flags:0x400100 flags:0x00000002
>  Call Trace:
>   <TASK>
>   __schedule+0x731/0x960
>   ? schedule_timeout+0xa8/0x120
>   schedule+0xb7/0x140
>   schedule_timeout+0xa8/0x120
>   ? __pfx_process_timeout+0x10/0x10
>   msleep_interruptible+0x3e/0x60
>   read_dummy+0x2d/0x70
>   full_proxy_read+0x6a/0xc0
>   vfs_read+0xc2/0x340
>   ? __pfx_direct_file_splice_eof+0x10/0x10
>   ? do_sendfile+0x1bd/0x2e0
>   ksys_read+0x76/0xe0
>   do_syscall_64+0xe3/0x1c0
>   ? exc_page_fault+0xa9/0x1d0
>   entry_SYSCALL_64_after_hwframe+0x77/0x7f
>  RIP: 0033:0x4840cd
>  RSP: 002b:00007ffe3e0147b8 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
>  RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00000000004840cd
>  RDX: 0000000000001000 RSI: 00007ffe3e014800 RDI: 0000000000000003
>  RBP: 00007ffe3e014800 R08: 0000000000000000 R09: 0000000000000000
>  R10: 0000000001000000 R11: 0000000000000246 R12: 0000000000001000
>  R13: 000000001a0a93a0 R14: 0000000000000001 R15: ffffffffffffffff
>   </TASK>

One thing that gives me a bit of "inconvenience" is that in certain
cases this significantly increases the amount of stack traces to go
through.  A distilled real life example:
- task T1 acquires lock L1, attempts to acquire L2
- task T2 acquires lock L2, attempts to acquire L3
- task T3 acquires lock L3, attempts to acquire L1

So we'd now see:
- a backtrace of T1, followed by a backtrace of T2 (owner of L2)
- a backtrace of T2, followed by a backtrace of T3 (owner of L3)
- a backtrace of T3, followed by a backtrace of T1 (owner of L1)

Notice how each task is backtraced twice.  I wonder if it's worth it
to de-dup the backtraces.  E.g. in

	task cat:115 is blocked on a mutex likely owned by task cat:114

if we know that cat:114 is also blocked on a lock, then we probably
can just say "is blocked on a mutex likely owned by task cat:114" and
continue iterating through tasks.  That "cat:114" will be backtraced
individually later, as it's also blocked on a lock, owned by another
task.

Does this make any sense?

