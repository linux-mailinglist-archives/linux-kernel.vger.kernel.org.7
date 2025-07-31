Return-Path: <linux-kernel+bounces-751525-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F322BB16A8F
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 04:54:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF98B3A5195
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 02:53:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1184419ABDE;
	Thu, 31 Jul 2025 02:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="H3/UbbTT"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD4338F5E
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 02:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753930441; cv=none; b=kiu7P5LJU+qp+LRH4RgshGvAFa1A3+7VZunRVaBRccNlhjSJLH9LLYnRMR77gCRoQ/39LHcTYmS27brulSDiRn/YE4AX+DA7RBcXcaK7EMdH8jrpDNiu5BBBNcyUDECPcFWlDyIwE9aJ6gU7pUg1rnD/tVCOrSYH12zb77+EFMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753930441; c=relaxed/simple;
	bh=GXejdXjqdmd2rmUGJCjbs0k/PT8rSw5ZBfuVAdRQxYA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MPN4Q4b4K6hTI/8l5a7nxssLxD4pUJWLadkhJgKASiJiVoqn4oI+gQhh7uMFk+O9ZyTac0/s6HxS8GiW5Dd84qzZv1wS4EDpT0FRTxq8Re5EXJbv9KBYVASd34U7OUh8j0PnUf5pimkAmy9nu7celmCtwAyCbm+wsj2K8dNQkdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=H3/UbbTT; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-24063eac495so5435215ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 19:53:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1753930438; x=1754535238; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=plJXMlWO611XnkPmWVz0r8AowdIWtJJQTPLkN0kk73U=;
        b=H3/UbbTT5UZbflpSPmZ7fSSakvBbSVsXv07SH6AN/G+ukLDV0uLp62VhhRJ377qFJj
         P5HLy9Hyf2F3siM9GMS7i7c1qEqkyMZmkl2m/IaGpGCuhqRkOC+p1oCzH9BcsttRE+kn
         2XArm/HXBxmpHC8I7kIdPAo3HXQelXX9k3TJI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753930438; x=1754535238;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=plJXMlWO611XnkPmWVz0r8AowdIWtJJQTPLkN0kk73U=;
        b=Ekifp8RG2NViaMiIrsAFcjMG12nqr+Bv2+zH0TmKg/rk+RZsW5p5FyNqgESsE5HC3q
         dKC1+4t1lZEwk6UaqV9HKTdyOdVuX9E+KM5JMDJa5wLcpV80Xs8WjLhhtmZGI/1YmWor
         YUgT9Am5o4YR/SkR3zN84JOylfuQ0mojA3+c/4KQyyVQQX7yn0lCxkuad9Ub1r+Nbian
         W/BK8M0xjMQpCIm8fppbq2t3hir9scSvFseViD83uG/m5qztDo8sSzwjGxTKT3/cbRyp
         kZOV5wAYPIy4lP9VfokQDDPjFSkBgHkiBvOK1EkO8i6f1cCq3s0O37YsEVaRAHJ+zAhi
         oLwg==
X-Forwarded-Encrypted: i=1; AJvYcCU+mVM1cchPTsI9XUYH5Pn5tLHXpnevlEw8HOZ5IjYGFkQs9GI+ZwGvqsKTmA4WoIf7hfQbF+vKxjvXBLs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUyfGI3yEbsgwdK1B2+uQ42nnHNz0Zvjm+KLqA65YAJjmNOswN
	MT11tkyN2TG3gG3P3RtMdIsyWW8OSzed1iqPC1QJ3/gHfSdbJjYlUWyFYW8qpZMnDw==
X-Gm-Gg: ASbGncu995imx+5uxwb2GPxLJS3QcCkm82hP753WS+phuqRlOM9QuoVCVPtlVn3sALs
	mV9aqW+BRLar9x0mwNnol0rhIgLUkfPSDO2zXgqdaD7gtbgu+uaP+Mgg7vj3OlgDnqNHrLaFHvJ
	q6u6C9Azyi3mm5RAqWkDbUXfwns6HQllvf3ZNM0Wen8Wf3hKXb7kUKkHV6HTN6lzn9wwEIsr+Xm
	4pgP46I3xV8x7H2wu42wiM2M2SF0svY/6QfDKwXKV8zkDlewfsVXPgpTsOWUUdG06aA0xj3Jbyn
	AunVf4vnZJPDU7Pp2nzOOm0DMNOXp4BLdcjVtHvtEkxnv1Q33LKjUd0lO53fgYgkah35i8yOgwM
	4IssrrTCa8T0NQpWjCdRTA9l3
X-Google-Smtp-Source: AGHT+IFz8ZJMT4YJMh60w5gHRhmEgRaoR0U4EZm+0DLBe2dbC/Waccg0zZH2htiVJDFyDuqOmxiHow==
X-Received: by 2002:a17:902:e811:b0:22e:4d50:4f58 with SMTP id d9443c01a7336-24096b79746mr71854395ad.31.1753930438056;
        Wed, 30 Jul 2025 19:53:58 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:6490:361:df77:361d])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241e899a917sm4317585ad.116.2025.07.30.19.53.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jul 2025 19:53:57 -0700 (PDT)
Date: Thu, 31 Jul 2025 11:53:51 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, 
	Waiman Long <longman@redhat.com>, Joel Granados <joel.granados@kernel.org>, 
	Anna Schumaker <anna.schumaker@oracle.com>, Lance Yang <ioworker0@gmail.com>, 
	Kent Overstreet <kent.overstreet@linux.dev>, Yongliang Gao <leonylgao@tencent.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Tomasz Figa <tfiga@chromium.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] hung_task: Dump blocker task if it is not hung
Message-ID: <reyd4bppb5tfon7gtqaelwknvptdeyhrsh5ijbcj77ezini3yq@ivkgxmiqzk3x>
References: <175391351423.688839.11917911323784986774.stgit@devnote2>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <175391351423.688839.11917911323784986774.stgit@devnote2>

On (25/07/31 07:11), Masami Hiramatsu (Google) wrote:
> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> Dump the lock blocker task if it is not hung because if the blocker
> task is also hung, it should be dumped by the detector. This will
> de-duplicate the same stackdumps if the blocker task is also blocked
> by another task (and hung).
> 
> Suggested-by: Sergey Senozhatsky <senozhatsky@chromium.org>
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> Acked-by: Lance Yang <lance.yang@linux.dev>

Tested-by: Sergey Senozhatsky <senozhatsky@chromium.org>


Wrote a simple 3 tasks circular lock test (same that I had in real
life).  The output looks good:

[   90.985431] [    T140] INFO: task T1:525 blocked for more than 30 seconds.
[   90.990981] [    T140]       Not tainted 6.16.0-next-20250730-00003-g5865c79d6085-dirty #261
[   90.996912] [    T140] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[   91.001617] [    T140] task:T1              state:D stack:0     pid:525   tgid:525   ppid:2      task_flags:0x208040 flags:0x00004000
[   91.007564] [    T140] Call Trace:
[   91.008767] [    T140]  <TASK>
[   91.009872] [    T140]  __schedule+0x137f/0x20c0
[   91.011606] [    T140]  schedule+0xdc/0x280
[   91.013115] [    T140]  schedule_preempt_disabled+0x10/0x20
[   91.015200] [    T140]  __mutex_lock+0x721/0x1590
[   91.016817] [    T140]  ? __mutex_lock+0x500/0x1590
[   91.018074] [    T140]  mutex_lock+0x81/0x90
[   91.019169] [    T140]  t1+0x62/0x70
[   91.020061] [    T140]  kthread+0x583/0x6e0
[   91.021140] [    T140]  ? drop_caches_sysctl_handler+0x130/0x130
[   91.022729] [    T140]  ? kthread_blkcg+0xa0/0xa0
[   91.023921] [    T140]  ret_from_fork+0xc8/0x160
[   91.025091] [    T140]  ? kthread_blkcg+0xa0/0xa0
[   91.026309] [    T140]  ret_from_fork_asm+0x11/0x20
[   91.027577] [    T140]  </TASK>
[   91.028326] [    T140] INFO: task T1:525 is blocked on a mutex likely owned by task T2:526.
[   91.030404] [    T140] INFO: task T2:526 blocked for more than 30 seconds.
[   91.031978] [    T140]       Not tainted 6.16.0-next-20250730-00003-g5865c79d6085-dirty #261
[   91.034069] [    T140] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[   91.036215] [    T140] task:T2              state:D stack:0     pid:526   tgid:526   ppid:2      task_flags:0x208040 flags:0x00004000
[   91.039233] [    T140] Call Trace:
[   91.040084] [    T140]  <TASK>
[   91.040810] [    T140]  __schedule+0x137f/0x20c0
[   91.041954] [    T140]  schedule+0xdc/0x280
[   91.042984] [    T140]  schedule_preempt_disabled+0x10/0x20
[   91.044329] [    T140]  __mutex_lock+0x721/0x1590
[   91.045464] [    T140]  ? __mutex_lock+0x500/0x1590
[   91.046624] [    T140]  mutex_lock+0x81/0x90
[   91.047632] [    T140]  t2+0x69/0x70
[   91.048473] [    T140]  kthread+0x583/0x6e0
[   91.049453] [    T140]  ? drop_pagecache_sb+0x200/0x200
[   91.050686] [    T140]  ? kthread_blkcg+0xa0/0xa0
[   91.051808] [    T140]  ret_from_fork+0xc8/0x160
[   91.052886] [    T140]  ? kthread_blkcg+0xa0/0xa0
[   91.054036] [    T140]  ret_from_fork_asm+0x11/0x20
[   91.055205] [    T140]  </TASK>
[   91.056011] [    T140] INFO: task T2:526 is blocked on a mutex likely owned by task T3:527.
[   91.058014] [    T140] INFO: task T3:527 blocked for more than 30 seconds.
[   91.059682] [    T140]       Not tainted 6.16.0-next-20250730-00003-g5865c79d6085-dirty #261
[   91.061708] [    T140] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[   91.063825] [    T140] task:T3              state:D stack:0     pid:527   tgid:527   ppid:2      task_flags:0x208040 flags:0x00004000
[   91.066668] [    T140] Call Trace:
[   91.067462] [    T140]  <TASK>
[   91.068121] [    T140]  __schedule+0x137f/0x20c0
[   91.069244] [    T140]  schedule+0xdc/0x280
[   91.070264] [    T140]  schedule_preempt_disabled+0x10/0x20
[   91.071723] [    T140]  __mutex_lock+0x721/0x1590
[   91.072848] [    T140]  ? __mutex_lock+0x500/0x1590
[   91.074032] [    T140]  mutex_lock+0x81/0x90
[   91.075054] [    T140]  t3+0x23/0x30
[   91.075932] [    T140]  kthread+0x583/0x6e0
[   91.076953] [    T140]  ? t2+0x70/0x70
[   91.077865] [    T140]  ? kthread_blkcg+0xa0/0xa0
[   91.078974] [    T140]  ret_from_fork+0xc8/0x160
[   91.080109] [    T140]  ? kthread_blkcg+0xa0/0xa0
[   91.081250] [    T140]  ret_from_fork_asm+0x11/0x20
[   91.082530] [    T140]  </TASK>
[   91.083248] [    T140] INFO: task T3:527 is blocked on a mutex likely owned by task T1:525.

