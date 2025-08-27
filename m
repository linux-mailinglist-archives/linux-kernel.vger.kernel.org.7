Return-Path: <linux-kernel+bounces-788515-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 22752B38594
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 16:58:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E66F2202D3E
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 14:58:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21DF724C06A;
	Wed, 27 Aug 2025 14:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XWakI95J"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE8A9218E97
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 14:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756306701; cv=none; b=WHdQcCvJ7RnOhGnSU6IHqF7kZgUQ3vqsrsM+WsC4FHzfcPo/WNdiMAgIdZeiScO0Oevvvrp7mI56Yu7XygrGuCU8zCip052Ji/ARjufgkYhgv4p2/ArHZnOWhp7AMoKMBvtHUtc3xmnBal7QyzV9IT6EZ+pWCKTzJkq/OVr4oVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756306701; c=relaxed/simple;
	bh=Po9SNbRnPB4D/Oxw0e/rka4k0gimDFLlA2PNdNWu56o=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=D/2NFzxiFAhRtYf33GuMG5CzgtGY1WxjIgi8skTOGritgteP8PfEQTvhgHi1aSd25cLijZBPlgs6W6V9kbDry+QxNp2VYiqqzODSmtfrVXANFEzYAI+IDJ+kPDOk4KXtDNcbBOQuZVmSvDfgMDIKpfNO9NzXQYmvqoEVOS8YRRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XWakI95J; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756306698;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Po9SNbRnPB4D/Oxw0e/rka4k0gimDFLlA2PNdNWu56o=;
	b=XWakI95Jv3EJh9qTvKyAOhoxvs5osJBPr1VpJmDBW6fVO8tIZmokIV/pdTANu3RT3LI+y3
	FM1GizIG53d/IGymqbOvUfbMfs07IqwcRpWa2/0/Vembbt/EwK0dpoTdBye0oqMB+3KluR
	V8aRRA0hY6OV/GtLoCEjrCp0gpkMBp8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-146-JjnDjPdTMaaw-sP4bPPyVw-1; Wed, 27 Aug 2025 10:58:17 -0400
X-MC-Unique: JjnDjPdTMaaw-sP4bPPyVw-1
X-Mimecast-MFC-AGG-ID: JjnDjPdTMaaw-sP4bPPyVw_1756306696
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3cd34034c02so389095f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 07:58:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756306696; x=1756911496;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Po9SNbRnPB4D/Oxw0e/rka4k0gimDFLlA2PNdNWu56o=;
        b=r2eg8/959dQv1mnxlNVv3icyuIax5PSRmTAu4qOE8Mqc8dbpO+JpktgyvrCJKvfPF9
         krxCUPN6vebcq4/AW8KkDIeUpbiNvfaW0v/IFSACEno9jIFFBHCGtSLCL4ar1RiHc0xs
         vHAuEzCSCLyFHruL5y957EEIDhyuKCC7KNSXGJqjUXIC9oH7NpYvuDn0+/MxjFWF0U/M
         7/Q2LSQEbIp3VkQeiZRu+UxHFKVaoiFDKuRiP5o1wruw4k94RNy0r0FnHPAPCxOFvcaq
         uO8ig1JCOOIZYTxbnrlNnQAdiiVEc9Wdi5vaDlcpLRzyGnvzDx6vpmls9dHKlc9fCaFd
         zxmQ==
X-Gm-Message-State: AOJu0Yz0xJsME8qniSDJchTWUCcGmjlMYKprzpFMbKZlQ+sMKTelBeAH
	xzFgeb1BLRGPrNIHQqw7k3O6JDvZIw22s56TsMLnPWhjsYllMKeqBQV88tT2/v6ZqKu+udhUfls
	XgkC7wrI8JnWk6HbsmxzIo0wab/WYqWyggXtGHaEKqpHpUua/8XhhZv8NaQAh/IwSTg==
X-Gm-Gg: ASbGncuGcwhQelruCnTgQx4qWXVMJDGB3Da3gQ0VncIGBdVr2PApGtVmtCTda4HGzQB
	6p7HiTAxzOQYOGFIhFR3vwGUySAwXBDzWGPPsE0TsabHWoqD+Sp1n1EwJrAmXKJ+KN+EcjubdTf
	lsQqPsx+KRKEf8oWAz+729pvYM4dPDW7OVNwFyx6btE3pHYn1Nkbf2xXMbk+AIRr8AFtGM42OdZ
	KHytGVCooxrgP2JqUobr98kEnTOp8McAmo29bYFFYfAYJUMADR/D3LacFM6ryxLNMqmaSl/2EAt
	BRwbiS00CZEVgsU8kNpMDX6jXoNd46chENXWO6ZCmn6xIuZdD9lGeR68eYsm1Ti6OsADZOZ1rdc
	fjJTI2bCWNSxRYB0CP+/hXTGC
X-Received: by 2002:a05:6000:2410:b0:3c9:d1b0:809f with SMTP id ffacd0b85a97d-3cbb15cb070mr4822220f8f.29.1756306696152;
        Wed, 27 Aug 2025 07:58:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHJ9/J++7yj1DNIVM/rV9vASXbUxOzJ+IOaqhEDm5+lvvbggnZ30QWxrW8+yalBGWHctC4Pdg==
X-Received: by 2002:a05:6000:2410:b0:3c9:d1b0:809f with SMTP id ffacd0b85a97d-3cbb15cb070mr4822193f8f.29.1756306695713;
        Wed, 27 Aug 2025 07:58:15 -0700 (PDT)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-135-146.abo.bbox.fr. [213.44.135.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3c711212924sm21010760f8f.33.2025.08.27.07.58.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Aug 2025 07:58:14 -0700 (PDT)
From: Valentin Schneider <vschneid@redhat.com>
To: Aaron Lu <ziqianlu@bytedance.com>, Ben Segall <bsegall@google.com>, K
 Prateek Nayak <kprateek.nayak@amd.com>, Peter Zijlstra
 <peterz@infradead.org>, Chengming Zhou <chengming.zhou@linux.dev>, Josh
 Don <joshdon@google.com>, Ingo Molnar <mingo@redhat.com>, Vincent Guittot
 <vincent.guittot@linaro.org>, Xi Wang <xii@google.com>
Cc: linux-kernel@vger.kernel.org, Juri Lelli <juri.lelli@redhat.com>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt
 <rostedt@goodmis.org>, Mel Gorman <mgorman@suse.de>, Chuyi Zhou
 <zhouchuyi@bytedance.com>, Jan Kiszka <jan.kiszka@siemens.com>, Florian
 Bezdeka <florian.bezdeka@siemens.com>, Songtang Liu
 <liusongtang@bytedance.com>
Subject: Re: [PATCH v3 0/5] Defer throttle when task exits to user
In-Reply-To: <20250715071658.267-1-ziqianlu@bytedance.com>
References: <20250715071658.267-1-ziqianlu@bytedance.com>
Date: Wed, 27 Aug 2025 16:58:12 +0200
Message-ID: <xhsmhms7klsl7.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 15/07/25 15:16, Aaron Lu wrote:
> There are consequences because of this new throttle model, e.g. for a
> cfs_rq that has 3 tasks attached, when 2 tasks are throttled on their
> return2user path, one task still running in kernel mode, this cfs_rq is
> in a partial throttled state:
> - Should its pelt clock be frozen?
> - Should this state be accounted into throttled_time?
>
> For pelt clock, I chose to keep the current behavior to freeze it on
> cfs_rq's throttle time. The assumption is that tasks running in kernel
> mode should not last too long, freezing the cfs_rq's pelt clock can keep
> its load and its corresponding sched_entity's weight. Hopefully, this can
> result in a stable situation for the remaining running tasks to quickly
> finish their jobs in kernel mode.

OK, I finally got to testing the PELT side of things :-)

I shoved a bunch of periodic tasks in a CPU cgroup with quite low limits
(1ms runtime, 10ms period); I looked at the _avg values using the
trace_pelt* tracepoints.

Overall there isn't much change to the averages themselves. There are more
updates since the tasks are genuinely dequeued/enqueued during a throttle
cycle, but that's expected.

I'll wait for your next version, but you can have:

Tested-by: Valentin Schneider <vschneid@redhat.com>


