Return-Path: <linux-kernel+bounces-837250-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C9C0BABC8D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 09:20:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E2853A4010
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 07:20:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 846B723D2AB;
	Tue, 30 Sep 2025 07:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QRN+JZbK"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EB781EBA14
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 07:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759216814; cv=none; b=i0z3FCdx+clXxT+la2WgGPdU7WIILTliU/k9M87DplgjDnzqg+E+e669AwIbwFYzYFMa/OmCcvdGxDasbxbhjqPk7zb6gaxNHF21VpYX7JAif7cjFsTxhO+ByPgfF1vOjOXu3iBG6EG8Hw/j3PhNc3QPsKDeXNvgYXQHg8ix6Mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759216814; c=relaxed/simple;
	bh=Djmjq+bvFKDrobRU0/6wxNjlcny+j0lxghfJ5tvjHIo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pRbw+BP1f+KERe9hL1v6zBzqGAExebJ7Cp8R2P0kUhgiIb3qIZnptzKHjqdfd4jbWbkv/sTTAjYLExb8qS5SiCB7Z5W8iheSeNTBirbmpMop5yJg3kTpk4wZmThVaM38I77i/+chAq4XX+1PATfbzh6c/75FkCMpF3/7OkB29Nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QRN+JZbK; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759216811;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=f6/TNb+QfEKOT/JEoEFXDqSrXCMjTPg/Ih1Yww11BFw=;
	b=QRN+JZbKRC3D34QZ/NdDcG1fSmOvB5SNR/SjYOWGlvWm4u3r4cUWv+uze+GQnS5Q6yuB/1
	ACDRnWJym3Ae/NhxyFGJhv7liMEEqkT9p7AzW+c3J+RJXR+YP2HEbUqbba7FB9dDJ5EORU
	L3aEwgQ7RMA1t28SiZ4X+P6RsfDB0ZA=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-310-w2B352W-PZKjr7WjnwsIpQ-1; Tue, 30 Sep 2025 03:20:09 -0400
X-MC-Unique: w2B352W-PZKjr7WjnwsIpQ-1
X-Mimecast-MFC-AGG-ID: w2B352W-PZKjr7WjnwsIpQ_1759216809
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3ecdfe971abso3713324f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 00:20:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759216809; x=1759821609;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f6/TNb+QfEKOT/JEoEFXDqSrXCMjTPg/Ih1Yww11BFw=;
        b=hZ0+ktaaqZm/iFOxXbkCB2OQvd3JYCoKJPmauYIxsvLn6wNG1Ec3r0tXdHgGp4uq6N
         Z+UOrkmBR9eKEGiNdw3HBtQw9mzsmOGbnPkznnhzWmXmKiXQbK7FVIpYb/t4EquuWgD3
         Far90bvhCPvPY0/jC+gzjwBeZcpAczDi3Cf1nJdv03ROD8HZD3YNtGWRcNiTSjw3767T
         3FdpDJtjFWVre219iIePNnFZjeFVsUggUPbyCMXLCZPWKG0L9BaOgxjri7HeYkQUbLZe
         MwAjPxEB3coReFLkwZAJbQtR9+l5KQoir9PdySU1wRjnKQ+OQ54PT98fI3S0ARYe5z0v
         yWuQ==
X-Forwarded-Encrypted: i=1; AJvYcCUxUvl0itLL3M4PxluWYJmb0n0lgpN3FsXHIXYhIQPiTh2W9oH4DNL43iqCOZZvkwGaVmwsCMvvdPuJw80=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUi1uslwyN3kkktSAvR9GAlbT023bK2tEdVzzFAoMLqQ8mdbCi
	+47jcSe5tCOxyoYREkdcuCkjTaSF8sKf3m5A3/wx5YTuSLHb/nz5DlXMZBDZUy9NgwxtQ4IhhCC
	vieUtNUTZ/SZnF+ttF/FA5ZtR2robykWxalbtmm3GmjGg4lj+5GXpffe4sM6PSCd53Q==
X-Gm-Gg: ASbGnctMJAcoMJK29nZx+zy+25+xYBZCuskE4KU8v6gTZgbeRRV1eqq2b0+HS6kvjQJ
	fI3M/RgiUqgJsvjmQV1Ul8oCJvhw7UNe7FUkKJQzMeKg0H0nycvTkK54/1N4oZwoVkIr4yESXTu
	xafOoO1itCZW4Xc2IuvQ9JDspK4VQdWjNi9jJevR/TVeSOw9WsyssFNo+i7VGZC3Se+f+kmZDXh
	sAFlBhpbbJJloLWyylLDaZnFv+eVgfOqkP6lU/JNXOiyrFWWyrpKopWc0EbwXeGEq09pF38EwFy
	vV/1f8BH/VwkylifNGbuafxupyPt8++tIXFEFPnQk9wTkOhqePFdZAG5lQ4U7qdXyKIbIJDAGCw
	58SMPlgZBUeN2DfmopAx0KyugaVuxvWEmDdE=
X-Received: by 2002:a5d:5d07:0:b0:3f3:3c88:505e with SMTP id ffacd0b85a97d-40e4886df12mr15589875f8f.29.1759216808653;
        Tue, 30 Sep 2025 00:20:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFonj6JfvsAR3ldO007O2vnaoVDkk6BRw4xOnnnX+A5SMPT/agn9siSplENLXH4bnXWBp6olA==
X-Received: by 2002:a5d:5d07:0:b0:3f3:3c88:505e with SMTP id ffacd0b85a97d-40e4886df12mr15589850f8f.29.1759216808231;
        Tue, 30 Sep 2025 00:20:08 -0700 (PDT)
Received: from jlelli-thinkpadt14gen4.remote.csb (host-89-240-114-119.as13285.net. [89.240.114.119])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-40fb9768bdesm21582838f8f.23.2025.09.30.00.20.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Sep 2025 00:20:07 -0700 (PDT)
Date: Tue, 30 Sep 2025 08:20:06 +0100
From: Juri Lelli <juri.lelli@redhat.com>
To: Pingfan Liu <piliu@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org,
	Ingo Molnar <mingo@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>
Subject: Re: [PATCH] sched/deadline: Derive root domain from active cpu in
 task's cpus_ptr
Message-ID: <aNuEpt8IkvtkH9na@jlelli-thinkpadt14gen4.remote.csb>
References: <20250929133602.32462-1-piliu@redhat.com>
 <20250929135347.GH3289052@noisy.programming.kicks-ass.net>
 <CAF+s44Q4SDXPRfYc4Ms5TcJgRU07QJB5H5VOHvyrZ31x9z49nw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAF+s44Q4SDXPRfYc4Ms5TcJgRU07QJB5H5VOHvyrZ31x9z49nw@mail.gmail.com>

On 30/09/25 09:47, Pingfan Liu wrote:
> Hi Peter,
> 
> On Mon, Sep 29, 2025 at 9:54 PM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Mon, Sep 29, 2025 at 09:36:02PM +0800, Pingfan Liu wrote:
> > > When testing kexec-reboot on a 144 cpus machine with
> > > isolcpus=managed_irq,domain,1-71,73-143 in kernel command line, I
> > > encounter the following bug:
> > >
> > > [   97.114759] psci: CPU142 killed (polled 0 ms)
> > > [   97.333236] Failed to offline CPU143 - error=-16
> > > [   97.333246] ------------[ cut here ]------------
> > > [   97.342682] kernel BUG at kernel/cpu.c:1569!
> >
> > > [   97.514379] Call trace:
> > > [   97.516874]  smp_shutdown_nonboot_cpus+0x104/0x128
> > > [   97.521769]  machine_shutdown+0x20/0x38
> > > [   97.525693]  kernel_kexec+0xc4/0xf0
> > > [   97.529260]  __do_sys_reboot+0x24c/0x278
> > > [   97.533272]  __arm64_sys_reboot+0x2c/0x40
> >
> > > Tracking down this issue, I found that dl_bw_deactivate() returned
> > > -EBUSY, which caused sched_cpu_deactivate() to fail on the last CPU.
> > > When a CPU is inactive, its rd is set to def_root_domain. For an S-state
> >
> > You mean a blocked task?
> >
> 
> Yes.
> 
> > > deadline task (in this case, "cppc_fie"), it was not migrated to CPU0,
> > > and its task_rq() information is stale. As a result, its bandwidth is
> > > wrongly accounted into def_root_domain during domain rebuild.
> > >
> > > This patch uses the rd from the run queue of still-active CPU to get the
> > > correct root domain.
> >
> 
> Sorry that I haven't explained it clearly. I mean the still-active CPU
> in task->cpus_ptr,
> 
> > That doesn't seem right in general. What if there are multiple root
> > domains; how does it know which to use?
> >

I actually wonder if we shouldn't make cppc_fie a "special" DEADLINE
tasks (like schedutil [1]). IIUC that is how it is thought to behave
already [2], but, since it's missing the SCHED_FLAG_SUGOV flag(/hack),
it is not "transparent" from a bandwidth tracking point of view.

1 - https://elixir.bootlin.com/linux/v6.17/source/kernel/sched/cpufreq_schedutil.c#L661
2 - https://elixir.bootlin.com/linux/v6.17/source/drivers/cpufreq/cppc_cpufreq.c#L198


