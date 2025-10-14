Return-Path: <linux-kernel+bounces-852744-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1140BBD9CA4
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 15:42:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 366414E9465
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 13:42:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A37A3148AB;
	Tue, 14 Oct 2025 13:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YBvy9DjB"
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E79E0313E32
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 13:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760449333; cv=none; b=Ros6KcNfgkmXt3SUk8x8WTJN99q51thBwQg4Ms9M7LG5aW8uNB7uZcugE00+WGKvktFK+kZcUTWMJ+rsEmmYUTHNGmNrnxYTThdnCDd2NOtZGzYBq8JIkPucS0YnzZHZBXDea6pR6SgcpQU3WyZeTpmJMVhrxPyPIiG5CsZN1q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760449333; c=relaxed/simple;
	bh=OKOMtNPPPvwpUDAua7xe8iqVmBDTcsCkgiidETRvTIk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gO/iosvB2loHnZX9xOQeYG8gkyZ2xOXeJ0Q7iBNJYrE6fIPxSu1ufCLaa9dblvTw64tNxlWs3tLwlQat//vN5fEsaIODnAUEtDzpmK1hwxtfiYIgxwq1pDgZXHAIf8wRAhIRjE3saA+Gdl5Kx+vwk6n3C0LkgxfWltmtGjmYxTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YBvy9DjB; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-72e565bf2feso55544647b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 06:42:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760449331; x=1761054131; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iShRlMjD16vCOvZiANOmQCZA2Q2Y8AtPdzjclXG3tnc=;
        b=YBvy9DjB5UPp4yhyuSNlbBhPHzFTxs1ot8Tzcs/bBCIH4lUN+Pan+GuEZsgXek74JS
         GSk7knL1nVF0XkaQhON//ZmMNu4qvzHwz32ahQTl9oRpS39MCsEy7aw6DHVJcA0vfKeK
         WF4jZVSwo6eeTT/OovBtJrHyPB4AzV862jzvxEJ+gisjtsKcekwhrFBCLHImbosgcKpY
         x/sN38SkT8qtM9rxdEEbKNHLISzFhKV2iLIxYHUQMSc4b/xLM6gb+fvrFmmSBbxM45ks
         Myju8ox6DAs+aQ/1befs43bI6ZuTFqQUmHRrTD0zrVTMhRyZmAUM3M+aqYijvUEy4vvk
         RjaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760449331; x=1761054131;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iShRlMjD16vCOvZiANOmQCZA2Q2Y8AtPdzjclXG3tnc=;
        b=mOseFxHhPVgMwP4c7kW1+dh2Xn0huWDTGA4Hp3PPpJMi9M+MPqopXFah4Yb37iNdZZ
         PvpvGnj+Vol5QlNRwM2t8Ugx3HLSNhmm1jb70j1eUFPXmz/+alJ4TbmK+Ey/3vrbiEHO
         Ke8IZik8R5KPxjwsPm0Ty36nkhRn/ckP0z42tWIgBu5CmtDCNI37yXEF/f52tL8jQ5eF
         k5LrjV37Fb3BfZCr8iJuD6kpZMa/Eljjkt9RFYj5/wlTsTeQue+Smt7c9HBXCAkDb4f4
         Nbvc64jdWeVXVbnAfgRxiCnDPHweWN0fjrKTgJjZMOsp3rjiy0UJwhNi6bVu372lvMgZ
         KF/Q==
X-Forwarded-Encrypted: i=1; AJvYcCW4c6x41SG4T26ea9SoPFsUS4QjPx0aQxFEVTkfVmq0U49vQx9W0QBObPbn3MZRwqGA5fuAk2CIfBV2Y04=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrlZ1Dm1sPpgb+bJACAItY+0BDGnasjcQt5DeQhPb3ZvlkaVeQ
	iy6SvXXCtqChESrHLpH8u0i+3QOK5EEKYQLXgGHZVmtVxwhp9BmfOU2g
X-Gm-Gg: ASbGncsrRIPX2jz64tJ0PIjc5zb8qRMXFxmckEfbEJBF/JLp/YOpJeslhqB9YjoiURn
	+weYL9iUMNY2KBjULJtuca1mQCH+Krw45sKSrPQNW8KY6SijEkchvoIldSoKLzvnq8ePkYBcg5i
	zxfHMv6yVzm1Xll7En0dtf7u/VWU4Nn2PlZPaqR+RfLNlDWftxIi+q/QMYJ4guBOPozFRrv0XVC
	GluupjlrnfTgTp8ggCejh0vaMW05Pgd1/vAH01Tf/U+xSvhWGWkmxg+HjlC7fNYWdUstjsTxMlA
	DX+r/W7vg7KkG7H5n0pP3RkFxTLH2XqRhPGnZu2uFDwVh+FuNeb5Ret+prioplgP8FnNDtxQHVf
	Vf0N57pc0wVAX5rqDit45XWdPdJmVscXdOADWiHbNOkDQIzYZQYT1vqaUqe5g1JVjeNE8zQOxdB
	RR2ATMmiifVaXDPQfE662u8Ev4NOB98w==
X-Google-Smtp-Source: AGHT+IHEmGnQT19nB8fpJYZ36lJocxSeUy5ie5UanJzwR4STBWqUUl84lcuO3sceBz22ooJBZ+7W0A==
X-Received: by 2002:a53:accc:0:20b0:63c:f5a7:3e1 with SMTP id 956f58d0204a3-63cf5a70b41mr9090122d50.61.1760449330421;
        Tue, 14 Oct 2025 06:42:10 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:51::])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-63cd95e3f9asm4749876d50.21.2025.10.14.06.42.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 06:42:10 -0700 (PDT)
From: Joshua Hahn <joshua.hahnjy@gmail.com>
To: Hillf Danton <hdanton@sina.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Vlastimil Babka <vbabka@suse.cz>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	kernel-team@meta.com
Subject: Re: [PATCH v4 0/3] mm/page_alloc: Batch callers of free_pcppages_bulk
Date: Tue, 14 Oct 2025 06:42:08 -0700
Message-ID: <20251014134208.2826738-1-joshua.hahnjy@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251014112946.8581-1-hdanton@sina.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 14 Oct 2025 19:29:45 +0800 Hillf Danton <hdanton@sina.com> wrote:

> On Mon, 13 Oct 2025 12:08:08 -0700 Joshua Hahn wrote:
> > Motivation & Approach
> > =====================
> > 
> > While testing workloads with high sustained memory pressure on large machines
> > in the Meta fleet (1Tb memory, 316 CPUs), we saw an unexpectedly high number
> > of softlockups. Further investigation showed that the zone lock in
> > free_pcppages_bulk was being held for a long time, and was called to free
> > 2k+ pages over 100 times just during boot.
> > 
> > This causes starvation in other processes for the zone lock, which can lead
> > to the system stalling as multiple threads cannot make progress without the
> > locks. We can see these issues manifesting as warnings:
> > 
> > [ 4512.591979] rcu: INFO: rcu_sched self-detected stall on CPU
> > [ 4512.604370] rcu:     20-....: (9312 ticks this GP) idle=a654/1/0x4000000000000000 softirq=309340/309344 fqs=5426
> > [ 4512.626401] rcu:              hardirqs   softirqs   csw/system
> > [ 4512.638793] rcu:      number:        0        145            0
> > [ 4512.651177] rcu:     cputime:       30      10410          174   ==> 10558(ms)
> > [ 4512.666657] rcu:     (t=21077 jiffies g=783665 q=1242213 ncpus=316)

Hello Hillf, thank you for your review.

> > While these warnings are benign, they do point to the underlying issue of
> 
> No fix is needed if it is benign.

Maybe this is poor wording on my part. What I mean to say is that these
warning messages can help us understand that the system is trending negatively,
even though the warning messages themselves may not indiate that something
has crashed or broken completely.

> > lock contention. To prevent starvation in both locks, batch the freeing of
> > pages using pcp->batch.
> > 
> > Because free_pcppages_bulk is called with the pcp lock and acquires the zone
> > lock, relinquishing and reacquiring the locks are only effective when both of
> > them are broken together (unless the system was built with queued spinlocks).
> > Thus, instead of modifying free_pcppages_bulk to break both locks, batch the
> > freeing from its callers instead.
> > 
> > A similar fix has been implemented in the Meta fleet, and we have seen
> > significantly less softlockups.
> > 
> Fine, softlockup is not cured.
> 
> > Testing
> > =======
> > The following are a few synthetic benchmarks, made on three machines. The
> > first is a large machine with 754GiB memory and 316 processors.
> > The second is a relatively smaller machine with 251GiB memory and 176
> > processors. The third and final is the smallest of the three, which has 62GiB
> > memory and 36 processors.
> > 
> > On all machines, I kick off a kernel build with -j$(nproc).
> > Negative delta is better (faster compilation).
> > 
> > Large machine (754GiB memory, 316 processors)
> > make -j$(nproc)
> > +------------+---------------+-----------+
> > | Metric (s) | Variation (%) | Delta(%)  |
> > +------------+---------------+-----------+
> > | real       |        0.8070 |  - 1.4865 |
> > | user       |        0.2823 |  + 0.4081 |
> > | sys        |        5.0267 |  -11.8737 |
> > +------------+---------------+-----------+
> > 
> > Medium machine (251GiB memory, 176 processors)
> > make -j$(nproc)
> > +------------+---------------+----------+
> > | Metric (s) | Variation (%) | Delta(%) |
> > +------------+---------------+----------+
> > | real       |        0.2806 |  +0.0351 |
> > | user       |        0.0994 |  +0.3170 |
> > | sys        |        0.6229 |  -0.6277 |
> > +------------+---------------+----------+
> > 
> > Small machine (62GiB memory, 36 processors)
> > make -j$(nproc)
> > +------------+---------------+----------+
> > | Metric (s) | Variation (%) | Delta(%) |
> > +------------+---------------+----------+
> > | real       |        0.1503 |  -2.6585 |
> > | user       |        0.0431 |  -2.2984 |
> > | sys        |        0.1870 |  -3.2013 |
> > +------------+---------------+----------+
> > 
> > Here, variation is the coefficient of variation, i.e. standard deviation / mean.
> > 
> > Based on these results, it seems like there are varying degrees to how much
> > lock contention this reduces. For the largest and smallest machines that I ran
> > the tests on, it seems like there is quite some significant reduction. There
> > is also some performance increases visible from userspace.
> > 
> > Interestingly, the performance gains don't scale with the size of the machine,
> > but rather there seems to be a dip in the gain there is for the medium-sized
> > machine.
> >
> Explaining the dip helps land this work in the next tree.

I do agree that I left this on a bit of a cliffhanger here. I'm a bit confused
as to why there is this kind of behavior as well, although I have a theory
as to why this behavior is seen. Going back to why we see zone lock contention
in the first place, I think it might have to do with the memory vs. processors
ratio that leads to such contention issues.

The lower the memory:processor ratio is, it seems like there is already
less zone lock contention. If we rank these machines by their mem:proc ratio:

Large machine : 2.38
Small machine : 1.72
Medium machine: 1.42

It seems like this is the order in which we see the gains as well. I this
explanation also kind of makes sense -- the more memory we have, the more
memory each pcp will have, and the longer free_pcppages_bulk would have taken
before (and vice versa). This is the case, at least for my setup, where each
machine is onlined in one node (zone) and so the pcp watermarks really
do scale with the size of the system.

I didn't want to include this in the cover letter, because this was purely an
untested conjecture.

I hope this helps!
Joshua

