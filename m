Return-Path: <linux-kernel+bounces-836931-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4783BAAE9C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 03:48:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F2841C4BB2
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 01:48:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43F491A0711;
	Tue, 30 Sep 2025 01:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g3+C4XfY"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4F6135949
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 01:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759196872; cv=none; b=ctQwXmV3fQaU3HQnJ3IP01R8+mz/ZVnsCNzapEykuAuOpb3W25EaW+ekZrvyWbzj/X6kVUkU4SS0GTBMof7Wftr35MGoaHJoVhXwHyh3LHJ0nBDls+qCd5c3jTkQD6h0KGWGCs4P7XQianIRgFKCce+sQXbyVP5URClHxbdsQAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759196872; c=relaxed/simple;
	bh=T7eDYUjFU80Dlq07o+hp0QoOEqbgtu0A1ygo87/yaok=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HSJzEhRmVpWlXiVlE/897Y80rwHEkpFOMBNFcQp79GzKe5FgjCnwWLpCwYqhi+S6cEFWyP00PsOO4N6X36W1oPmD94XWhMS+OSsD9st6Or/SWyemMdUXYTkTI89gkuqA+RO7uJ6H/fQ3K6z2YGSCPSn3IaOl6zGrD2Hc8g1Obv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=g3+C4XfY; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759196869;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=g+YKhUgCh7OhdSLPUhGgZFIjW4FthirrPXduUKW35jI=;
	b=g3+C4XfYiYc2SChYwv1nz5V2iizGtnCbtzsij2b2rTuQwcpMPanIKf35xkZugbdLFvux1w
	VcLWZQZRW3hGtJqb307XMjbHQFMqOTdqKU39Stp6tyQ91B5Orr7B8yrAIneTzQeGqnEG/8
	Q5ziwuxgGQGYDVIfQ98iF2jeKf1q1jQ=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-561-ofLblLm9O2KwBChwZyv3Cw-1; Mon, 29 Sep 2025 21:47:46 -0400
X-MC-Unique: ofLblLm9O2KwBChwZyv3Cw-1
X-Mimecast-MFC-AGG-ID: ofLblLm9O2KwBChwZyv3Cw_1759196865
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-26983c4d708so50282585ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 18:47:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759196865; x=1759801665;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g+YKhUgCh7OhdSLPUhGgZFIjW4FthirrPXduUKW35jI=;
        b=PKEm+ibgJkJ1y4ogfkAMCRpbGB5k3OCGH8tiMPO78iSCHtt1QGYDSMRXEZ1Opr5VbW
         p4KI+6myn2CQP2nC7iP5Rj6m7oncOfBjsk2diqJuFriYO+hfatteNmizTJi72CPUkPSO
         VxoAIeKBwmZZBNjWVTsEORKHA2GixMltqjeRwKzT0/BEv+pOlqtVvSPYesTAOFDW8ado
         gIOvFVMFtCdemIpHvTHhNxm0yYBth4LhyUV7CJV7g2Z8iR+zRDQk1sNASZ4S1C+MXE5T
         B1QmZNtPzKF4xuQAS8Q5s+LyXgNCKsAQgGa8kIkKMElA8WhiRvj7xsJ02kdCHRjY354x
         rBBQ==
X-Gm-Message-State: AOJu0Ywhs1chO9fSuRiIEYMtQsyPNA+EIOz1YrIwgx+wGacnKaUmmFam
	EPxjuhB8yaEUrMHONK/xNThWTtaL/QUewC4sJl3VWOaoMt1vJPCuYNN6j5uHd45ZVZqVdP3vX/0
	Sfi/Fg3LbG6TRRZkLil2FH3cMFDefQlrRpyjFzFi+NIJ/U5duQNTiOPzRFagNLXROvK1Fyfvbyu
	15/AZRVyD6uSm1OAopYPaxsBmtbbSEXzAI+ZmFCA6W
X-Gm-Gg: ASbGnctbkJgXNQwkzMPfMq2aoNYNum/TAC9EbGNV2Au5DLhrlWzmJqX8cY8ShaULXA/
	melbCG6SKXqe+wPP50hbqZ67wgtzqqLwMtN5TdEcKPRZOte7pqao3Tu0xvF3vtdGuAwvQWxdKv/
	GCuTLOed3hmsBA1IeKB/QNFHb2Ps8=
X-Received: by 2002:a17:903:110e:b0:266:64b7:6e38 with SMTP id d9443c01a7336-27ed4a47150mr204565855ad.46.1759196865321;
        Mon, 29 Sep 2025 18:47:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IELlTIjKrLm7ujSfEdSpo9/yKWo+IfH0CK9KY/x4pZ4ek9FCmJkuGdSiPeYrnwRoGZWRCuZ+tmJfWq4OPG8ccE=
X-Received: by 2002:a17:903:110e:b0:266:64b7:6e38 with SMTP id
 d9443c01a7336-27ed4a47150mr204565495ad.46.1759196864928; Mon, 29 Sep 2025
 18:47:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250929133602.32462-1-piliu@redhat.com> <20250929135347.GH3289052@noisy.programming.kicks-ass.net>
In-Reply-To: <20250929135347.GH3289052@noisy.programming.kicks-ass.net>
From: Pingfan Liu <piliu@redhat.com>
Date: Tue, 30 Sep 2025 09:47:33 +0800
X-Gm-Features: AS18NWCgss5xzgIRRZfqUlF2qFGEgBxjI04Tzd8VFeZpBzuRItXimsF-HmjO75Y
Message-ID: <CAF+s44Q4SDXPRfYc4Ms5TcJgRU07QJB5H5VOHvyrZ31x9z49nw@mail.gmail.com>
Subject: Re: [PATCH] sched/deadline: Derive root domain from active cpu in
 task's cpus_ptr
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, 
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Peter,

On Mon, Sep 29, 2025 at 9:54=E2=80=AFPM Peter Zijlstra <peterz@infradead.or=
g> wrote:
>
> On Mon, Sep 29, 2025 at 09:36:02PM +0800, Pingfan Liu wrote:
> > When testing kexec-reboot on a 144 cpus machine with
> > isolcpus=3Dmanaged_irq,domain,1-71,73-143 in kernel command line, I
> > encounter the following bug:
> >
> > [   97.114759] psci: CPU142 killed (polled 0 ms)
> > [   97.333236] Failed to offline CPU143 - error=3D-16
> > [   97.333246] ------------[ cut here ]------------
> > [   97.342682] kernel BUG at kernel/cpu.c:1569!
>
> > [   97.514379] Call trace:
> > [   97.516874]  smp_shutdown_nonboot_cpus+0x104/0x128
> > [   97.521769]  machine_shutdown+0x20/0x38
> > [   97.525693]  kernel_kexec+0xc4/0xf0
> > [   97.529260]  __do_sys_reboot+0x24c/0x278
> > [   97.533272]  __arm64_sys_reboot+0x2c/0x40
>
> > Tracking down this issue, I found that dl_bw_deactivate() returned
> > -EBUSY, which caused sched_cpu_deactivate() to fail on the last CPU.
> > When a CPU is inactive, its rd is set to def_root_domain. For an S-stat=
e
>
> You mean a blocked task?
>

Yes.

> > deadline task (in this case, "cppc_fie"), it was not migrated to CPU0,
> > and its task_rq() information is stale. As a result, its bandwidth is
> > wrongly accounted into def_root_domain during domain rebuild.
> >
> > This patch uses the rd from the run queue of still-active CPU to get th=
e
> > correct root domain.
>

Sorry that I haven't explained it clearly. I mean the still-active CPU
in task->cpus_ptr,

> That doesn't seem right in general. What if there are multiple root
> domains; how does it know which to use?
>

In the case of task->cpus_ptr, there should be only one root domain, right?

Thanks,

Pingfan


