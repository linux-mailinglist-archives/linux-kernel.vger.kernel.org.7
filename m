Return-Path: <linux-kernel+bounces-766824-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99F6BB24B99
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 16:10:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 824083A800E
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 14:06:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 539CA2EB5D3;
	Wed, 13 Aug 2025 14:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bUPAWFnk"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A28A2E92BE
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 14:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755093990; cv=none; b=har6VJNL27FRehZGhtpITa1pz+nRxV4pM1Y4ULtCYJkA5cUf/4tveaLFcSEjhB8E+czoVXxitFe8LtTpjGSXP8ig4bERtPzdtHRS41gyBVi09KxhLgS+rLdjNJhdz2NIWeGKIyCZcFyDP5uOqwhKwS8SNFWbvSz8VcTYzR5gpgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755093990; c=relaxed/simple;
	bh=D0DZ2uROb05qaUlvOQ5URzp/In4V4djcpvl6Rtlg/js=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XMR6w7X5Z6wncXur0mzJfAche+cTupZPIMXYkhwJemVHQvfXURY5j4+f39UW44hqNpDB5b5DABUkwQmsf7Xb8uTKU83BJF0yp7T4iR1AKLjadLCa+OWXGFxpHwm3/Lov8ZEfN/5xkpsIBQ80evGL5RmMk0wsu22WWtc7I7N5UK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bUPAWFnk; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755093987;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ctyVPpTuqcSneKx96iZ06qJB4Y6RFczuX8svkSHwDd4=;
	b=bUPAWFnkZ1HCQ4cjuljPDpfHP52O8pK7XNUw1O56wa0ZiY4YdbuTpVTonJYtqhxyR68KBk
	wHhv6i6Z7kZPvvYkJFcgQXSvqfs+n0ocRSH6iai8Q83UTtpagymNeLdfL4e/fXNiqLb8Uy
	NPYKo+A59KQHUTBEflqaXNLuFNrkIWk=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-10-kRVKDvmPNXKUL_QJJ0k4WQ-1; Wed, 13 Aug 2025 10:06:25 -0400
X-MC-Unique: kRVKDvmPNXKUL_QJJ0k4WQ-1
X-Mimecast-MFC-AGG-ID: kRVKDvmPNXKUL_QJJ0k4WQ_1755093985
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4b096d8fc3bso153967031cf.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 07:06:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755093985; x=1755698785;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ctyVPpTuqcSneKx96iZ06qJB4Y6RFczuX8svkSHwDd4=;
        b=sGhe0bwuqW5SBWhUxjVfdrWUzMB/Z/NNfKTmt7l8N0m4saeAoCuRGa5QHH8OWELd8s
         BdA365IOvLRPH8pCgUP/mDNZ0ene9eR+dOXub7vxFq+lJtDHDtJW07eJNpmuZXrofi5a
         T9+H9Bv86TZAECrDC27oL9gkQOXrpuzn1k16+P35KsF88hpXfByBferPppIWdHNfejtE
         1bq4aIL3bi+eCmd9BXVeIt5ULPF15HNDlLlh6ftDUu4Xe1aWhMXLY6vSRMfPdSlAwV70
         2CBw/unqtzLztuJaHh3ZJzqR+um2SpTbiVttZNlixEkJ5oT5BHPQDrK1yfOZS66w2Apo
         XGxA==
X-Forwarded-Encrypted: i=1; AJvYcCUgblp1UT0NzOiKY0n0eenwPHeTKDJHmKfcM7JbpW7i5GQZDlc78s6qbkeHwDntZiRbhRxYR1LFAY0diR8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yysv/UpMGs4guGlFFB8GSD8O1NC0QTr0LjJY5AyulIs8yidT4Vu
	vs2sYlNwwkLSlnrDElypTewEMtx/85vrk2QeKs3rN6CGoM5ygaw/XzRStuusJJ2xS7sId/DFXTP
	4J12UR9eZQhDGFUnT7ThCNHqHlbqdWwuGcQhc0ihVo8DTSaH9NCYkdFAgmhY9NpXwhQ==
X-Gm-Gg: ASbGncvGWHjXfK7JQZDXdnA0uYvx456Wz1syoSZZeatNLwgVk2s4ik9Fs9T9Lku4h7Z
	GApjK4mLiSOIGk+92I/Gi/p0bgLbnl2ZWWa2H3h57Dsv4ND1yups5UoZJx4C3lC2zaan5/RzGqF
	9UurHyfESqQF8mrByjm3Jfj2gWXI0JiIV9qrUkOaxQSNwMm8QQxb/EP46gPXNGXR2Zj1juLuZEw
	obMtgRR02wcDcjxUO/cyH5dFb/xnKiUMSL2C2ePcW+dPQITeivCqoi4Ntl7KZvVEpWD26cOdXlI
	1JJm6Moxq8Ay0F2qeJH4OUq/I4owrgLz/A42COxpm4usBWYiokU6rqbJqfvnInhUhp1gDtFLipk
	=
X-Received: by 2002:a05:622a:1a23:b0:4ab:9586:bdd6 with SMTP id d75a77b69052e-4b0fc8cbeacmr46416011cf.53.1755093984871;
        Wed, 13 Aug 2025 07:06:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFpv/Q7IKmuRFIHu+ImHkmhrZ82RJLQyLwegKcmcFgerq7rvJej1rqP6epJt+qtTMwfMXYXRg==
X-Received: by 2002:a05:622a:1a23:b0:4ab:9586:bdd6 with SMTP id d75a77b69052e-4b0fc8cbeacmr46415431cf.53.1755093984373;
        Wed, 13 Aug 2025 07:06:24 -0700 (PDT)
Received: from jlelli-thinkpadt14gen4.remote.csb ([2a02:b121:8f07:d6f6:1329:41fe:82dc:a703])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b06787441fsm141781171cf.28.2025.08.13.07.06.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 07:06:23 -0700 (PDT)
Date: Wed, 13 Aug 2025 16:06:15 +0200
From: Juri Lelli <juri.lelli@redhat.com>
To: Yuri Andriaccio <yurand2000@gmail.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	linux-kernel@vger.kernel.org,
	Luca Abeni <luca.abeni@santannapisa.it>,
	Yuri Andriaccio <yuri.andriaccio@santannapisa.it>
Subject: Re: [RFC PATCH v2 00/25]  Hierarchical Constant Bandwidth Server
Message-ID: <aJyb143HTlGqCBeo@jlelli-thinkpadt14gen4.remote.csb>
References: <20250731105543.40832-1-yurand2000@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250731105543.40832-1-yurand2000@gmail.com>

Hi,

On 31/07/25 12:55, Yuri Andriaccio wrote:
> Hello,
> 
> This is the v2 for Hierarchical Constant Bandwidth Server, aiming at replacing
> the current RT_GROUP_SCHED mechanism with something more robust and
> theoretically sound. The patchset has been presented at OSPM25
> (https://retis.sssup.it/ospm-summit/), and a summary of its inner workings can
> be found at https://lwn.net/Articles/1021332/ . You can find the v1 of this
> patchset at the bottom of the page, which talks in more detail what this
> patchset is all about and how it is implemented.
> 
> The big update for this v2 version is the addition of migration code, which
> allows to migrate tasks between different CPUs (following of course affinity
> settings).
> 
> As requested, we've split the big patches in smaller chunks in order to improve
> in readability. Additionally, it has been rebased on the latest tip/master to
> keep up with the latest scheduler updates and new features of dl_servers.
> 
> Last but not least, the first patch, which has been presented separately at
> https://lore.kernel.org/all/20250725164412.35912-1-yurand2000@gmail.com/ , is
> necessary to fully utilize the deadline bandwidth while keeping the fair-servers
> active. You can refer to the aforementioned link for details. The issue
> presented in this patch also reflects in HCBS: in the current version of the
> kernel, by default, 5% of the realtime bandwidth is reserved for fair-servers,
> 5% is not usable, and only the remaining 90% could be used by deadline tasks, or
> in our case, by HCBS dl_servers. The first patch addresses this issue and allows
> to fully utilize the default 95% of bandwidth for rt-tasks/servers.
> 
> Summary of the patches:
>      1) Account fair-servers bw separately from other dl tasks and servers bw.
>    2-5) Preparation patches, so that the RT classes' code can be used both
>         for normal and cgroup scheduling.
>   6-15) Implementation of HCBS, no migration and only one level hierarchy.
>         The old RT_GROUP_SCHED code is removed.
>  16-18) Remove cgroups v1 in favour of v2.
>     19) Add support for deeper hierarchies.
>  20-25) Add support for tasks migration.
> 
> Updates from v1:
> - Rebase to tip/master.

Would you mind sharing the baseline sha this set applies to? It looks
like it doesn't apply cleanly anymore.

Thanks!
Juri


