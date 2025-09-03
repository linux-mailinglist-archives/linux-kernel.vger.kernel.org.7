Return-Path: <linux-kernel+bounces-798385-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 34251B41D26
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 13:36:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9ED277ACC5E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 11:34:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E8E62F658A;
	Wed,  3 Sep 2025 11:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="TB3Bk3SC"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 977322D94AF
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 11:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756899367; cv=none; b=LffGu/iGvPstg2mNiOMEWexnR4vIb/781iw+jkbahZufbyBicm8cRY1mpu5Snv7TfmsG8PApB8clELVKOBzxyTfCBTgndeZqG3qIZKwJsZ8QsidHo7ijPB6jzBp0Xm5IsSC+tK4bXMyzvyDyZoBb/uaM8D+AIochppHqahmvkvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756899367; c=relaxed/simple;
	bh=rVkkiLIbkhghvX8tVHIMRmMASfiwcf+UnHmTuMgcrFU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JMunql82eoUUGYSNwnb1kJWfJl5ycKFsqn6nJWWCCJ6/Q+lSNU4n5g04ZVQWQ3VEFss5poe84i7tfA8rjb8Aw5Mf+JMZZ7qoANKW9UnV6XWosOAKvF47V1ExZvsrdJ7fdedWn2BWuORz5LSw85/61WM72ta4nBnTOFCXvYK4EKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=TB3Bk3SC; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-7726c7ff7e5so1981522b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 04:36:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1756899362; x=1757504162; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=dkBpKZronXOQP/JAa6pSPyXvntZwp6vqmbajrLen8AA=;
        b=TB3Bk3SCuH1epe6OibRKGZY95hbAjecm3RU9l2eIbhILjvXj2wZx4qxq2+Ht4iCTxz
         iWn6CC5m2eVlD1bSVDjib5+r6+O0C8VUSpSP0vDn3do0bjQ2nVfbGSAxrLzSFmv7wgcy
         AYjpQGT3KRH27oE2cPYaQy/4PE1zAj4FDD9Rf5+DtbTFBEMTkFXnDKfcYnmh77qVbxap
         fLEn6CqoiwzuaqOcYsokYFUR2d28zzKPsSgnunNlocG8afqtoxN7SKPjDjxTX7mJvKrm
         MzP1Ug1umZ5J2mkBBwkAfiQ8fdoqThtN4wwqu+8BR6g0G6PU84Z+G6rjbUkvbyzGCNTF
         Mmeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756899362; x=1757504162;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dkBpKZronXOQP/JAa6pSPyXvntZwp6vqmbajrLen8AA=;
        b=Zng0Se/UlxFWvGv9LcV9HacRPwyrYbXRjCMCOIHPcwOrL3WccuZdgMwYpvftRZd+kV
         mJV3q7Qu5T1vqliEKtsjCDeQvMyd+7Xi9CMw4mm4Ip0xwRVzLja5MuHEIBaldScuTQlg
         KRZ0nNHvOlenLaAm/cjH8Yd5a7ucFxTf5hX92nlhPSLJmvuL8LYdXxeNzDpnw5BClQEg
         YoaC4NGptq1FlMJdtkJ8oDBfXMhuKlEgJKQaoFTm1xUQahZO+JffQHEe+TJBrk9TtoJM
         qoJ7yEV580BHJf1JQh6/TySymPA8dwCtgkcza3HlWO52kb+89Jfm+1vJvqaUdss//X+1
         DkQQ==
X-Forwarded-Encrypted: i=1; AJvYcCVGrXjjjXWW2H/UN95cuyQ/gAo8+J1m+X2yqMwzD/+eIPtQ2+Cdu015+6E4a7J42rw5UMsmNyihgk2RQEs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpqaHm9ZvXn0hlHswSCOVF9YsHInba3hrZjNE7Z7tpTfy2E9x4
	AryAA8ZLPYpnoIrjngucNC57J7+ktoTzroPUc9t/CGchhCxEf1uG0M+w/cPqN17S9A==
X-Gm-Gg: ASbGncsn+tsQh5HZ8RJqLsoSrhS5+V3HA4imtm0AwwnB6Qzy+SSOO0jO2dOF5n6fJ0Z
	F7ts3F4LasETUT4OXKfBs79HvP36rAegSWGINzyvuT0CO08clImNYFryeLOVx5h4uAzAjbxIYX5
	+R9KPChkC4OBzrILXGEGnFlB1hDXexYVOJZDdVQrnY7AsfErrG2eIuFcyafOZslN2oy4gRGojeX
	kx52EPT62XGoGawukOre55UnUd1bPUqDYjT/Z5u3b0FeFVgK6nQJBkEbrYYxZnYBbnnvfT/WFJ0
	PinNx7NktemQNSxt/yaT9Bh9xVVYQyEi+5PgVza9MqXyLabLPjxagPoWrJtRdr7gCj9yo+WFjFa
	yVmrO+TzopW04rHYjlffwHhbzg8diHdLaH5bW7cMVApH946AcBg==
X-Google-Smtp-Source: AGHT+IGj9dQseM5k/iDfec+km8ogr6XNe1dTdVEh/R3pE6YxafYySqeBDRxt7W8BoaEjAQ70Hr0qQw==
X-Received: by 2002:a05:6a00:14c2:b0:76b:995c:4bb1 with SMTP id d2e1a72fcca58-7723e309fa9mr19308490b3a.15.1756899361697;
        Wed, 03 Sep 2025 04:36:01 -0700 (PDT)
Received: from bytedance ([61.213.176.55])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7722a2bf5e0sm16533324b3a.36.2025.09.03.04.35.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 04:36:00 -0700 (PDT)
Date: Wed, 3 Sep 2025 19:35:51 +0800
From: Aaron Lu <ziqianlu@bytedance.com>
To: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: Valentin Schneider <vschneid@redhat.com>,
	Ben Segall <bsegall@google.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Josh Don <joshdon@google.com>, Ingo Molnar <mingo@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Xi Wang <xii@google.com>, linux-kernel@vger.kernel.org,
	Juri Lelli <juri.lelli@redhat.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>, Mel Gorman <mgorman@suse.de>,
	Chuyi Zhou <zhouchuyi@bytedance.com>,
	Jan Kiszka <jan.kiszka@siemens.com>,
	Florian Bezdeka <florian.bezdeka@siemens.com>,
	Songtang Liu <liusongtang@bytedance.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH v3 3/5] sched/fair: Switch to task based throttle model
Message-ID: <20250903113551.GC42@bytedance>
References: <20250808101330.GA75@bytedance>
 <xhsmhsei2ox4o.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
 <20250812084828.GA52@bytedance>
 <xhsmhh5y9j3ut.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
 <20250815092910.GA33@bytedance>
 <20250822110701.GB289@bytedance>
 <20250903071410.GA42@bytedance>
 <2b2e91e7-0514-4728-a3a3-96282a0d4286@amd.com>
 <20250903101102.GB42@bytedance>
 <13467b08-96a6-478d-bb97-060b7d8887e4@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="+GmrL/yv/mu/Iea8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <13467b08-96a6-478d-bb97-060b7d8887e4@amd.com>


--+GmrL/yv/mu/Iea8
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Wed, Sep 03, 2025 at 04:01:03PM +0530, K Prateek Nayak wrote:
> Hello Aaron,
> 
> On 9/3/2025 3:41 PM, Aaron Lu wrote:
> > Hi Prateek,
> > 
> > On Wed, Sep 03, 2025 at 02:41:55PM +0530, K Prateek Nayak wrote:
> >> Hello Aaron,
> >>
> >> On 9/3/2025 12:44 PM, Aaron Lu wrote:
> >>> On Fri, Aug 22, 2025 at 07:07:01PM +0800, Aaron Lu wrote:
> >>>> With this said, I reduced the task number and retested on this 2nd AMD
> >>>> Genoa:
> >>>> - quota set to 50 cpu for each level1 cgroup;
> >>
> >> What exactly is the quota and period when you say 50cpu?
> > 
> > period is the default 100000 and quota is set to 5000000.
> 
> Thank you! I'll do some tests on my end as well.
>

I've attached test scripts I've used for your reference.

> [..snip..]
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index df8dc389af8e1..3e927b9b7eeb6 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -9370,6 +9370,9 @@ int can_migrate_task(struct task_struct *p, struct lb_env *env)
> >  	if ((p->se.sched_delayed) && (env->migration_type != migrate_load))
> >  		return 0;
> >  
> > +	if (throttled_hierarchy(task_group(p)->cfs_rq[env->dst_cpu]))
> > +		return 0;
> > +
> 
> This makes sense instead of the full throttled_lb_pair(). You'll still
> need to put it behind CONFIG_CGROUP_SCHED (or better yet
> CONFIG_CFS_BANDWIDTH) since task_group() can return NULL if GROUP_SCHED
> is not enabled.
> 

Got it, thanks for the remind. Maybe I can avoid adding new wrappers
and just check task_group() first, something like this:

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index df8dc389af8e1..d9abde5e631b8 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -9362,6 +9362,7 @@ int can_migrate_task(struct task_struct *p, struct lb_env *env)
 	/*
 	 * We do not migrate tasks that are:
 	 * 1) delayed dequeued unless we migrate load, or
+	 * 2) target cfs_rq is in throttled hierarchy, or
 	 * 2) cannot be migrated to this CPU due to cpus_ptr, or
 	 * 3) running (obviously), or
 	 * 4) are cache-hot on their current CPU, or
@@ -9370,6 +9371,10 @@ int can_migrate_task(struct task_struct *p, struct lb_env *env)
 	if ((p->se.sched_delayed) && (env->migration_type != migrate_load))
 		return 0;
 
+	if (task_group(p) &&
+	    throttled_hierarchy(task_group(p)->cfs_rq[env->dst_cpu]))
+		return 0;
+
 	/*
 	 * We want to prioritize the migration of eligible tasks.
 	 * For ineligible tasks we soft-limit them and only allow


> >  	/*
> >  	 * We want to prioritize the migration of eligible tasks.
> >  	 * For ineligible tasks we soft-limit them and only allow
> > 
> >          base              head'               diff     head(patch1-5)
> > Time     82.55±4.82%       83.81±2.89%         -1.5%    99.69±6.71%
> > 
> > head': head + above diff
> > 
> > I also tested netperf on this AMD system as well as hackbench and
> > netperf on Intel EMR, no obvious performance difference observed
> > after applying the above diff, i.e. base and head' performance is
> > roughly the same.
> > 
> > Does the above diff make sense? One thing I'm slightly concerned is,
> > there may be one case when balancing a task to a throttled target
> > cfs_rq makes sense: if the task holds some kernel resource and is
> > running inside kernel, even its target cfs_rq is throttled, we still
> > want this task to go there and finish its job in kernel mode sooner,
> > this could help other resource waiters. But, this may not be a big deal
> 
> I think it is still an improvement over per-cfs_rq throttling from a
> tail latency perspective.
> 
> > and in most of the time, balancing a task to a throttled cfs_rq doesn't
> > look like a meaningful thing to do.Ack.

Just want to add that with the above diff applied, I also tested
songtang's stress test[0] and Jan's rt deadlock reproducer[1] and didn't
see any problem.

[0]: https://lore.kernel.org/lkml/20250715072218.GA304@bytedance/
[1]: https://lore.kernel.org/all/7483d3ae-5846-4067-b9f7-390a614ba408@siemens.com/

--+GmrL/yv/mu/Iea8
Content-Type: application/x-sh
Content-Disposition: attachment; filename="test.sh"
Content-Transfer-Encoding: quoted-printable

#!/bin/bash=0A=0ATEST_DIR=3D`dirname $0`=0Aecho "TEST_DIR: $TEST_DIR"=0A=0A=
CG_ROOT=3D/sys/fs/cgroup=0A=0Anr_level1=3D2=0Anr_level2=3D2=0Anr_level3=3D2=
=0Anr_level4=3D5=0Anr_level5=3D5=0A=0Afor i in `seq $nr_level1`; do=0A	CG_L=
EVEL1=3D$CG_ROOT/$i=0A	echo "cg_level1: $CG_LEVEL1"=0A	[ -d $CG_LEVEL1 ] ||=
 sudo mkdir -p $CG_LEVEL1=0A	sudo sh -c "echo +cpu > $CG_LEVEL1/cgroup.subt=
ree_control"=0A=0A	for j in `seq $nr_level2`; do=0A		CG_LEVEL2=3D$CG_LEVEL1=
/${i}_$j=0A		echo "cg_level2: $CG_LEVEL2"=0A		[ -d $CG_LEVEL2 ] || sudo mkd=
ir -p $CG_LEVEL2=0A		sudo sh -c "echo +cpu > $CG_LEVEL2/cgroup.subtree_cont=
rol"=0A=0A		for k in `seq $nr_level3`; do=0A			CG_LEVEL3=3D$CG_LEVEL2/${i}_=
${j}_$k=0A			[ -d $CG_LEVEL3 ] || sudo mkdir -p $CG_LEVEL3=0A			sudo sh -c =
"echo +cpu > $CG_LEVEL3/cgroup.subtree_control"=0A=0A			for l in `seq $nr_l=
evel4`; do=0A				CG_LEVEL4=3D$CG_LEVEL3/${i}_${j}_${k}_$l=0A				[ -d $CG_LE=
VEL4 ] || sudo mkdir -p $CG_LEVEL4=0A				sudo sh -c "echo +cpu > $CG_LEVEL4=
/cgroup.subtree_control"=0A=0A				for m in `seq $nr_level5`; do=0A					CG_L=
EVEL5=3D$CG_LEVEL4/${i}_${j}_${k}_${l}_$m=0A					[ -d $CG_LEVEL5 ] || sudo =
mkdir -p $CG_LEVEL5=0A				done=0A			done=0A		done=0A	done=0Adone=0A=0Afor i=
 in `seq $nr_level1`; do=0A	CG_LEVEL1=3D$CG_ROOT/$i=0A	for j in `seq $nr_le=
vel2`; do=0A		CG_LEVEL2=3D$CG_LEVEL1/${i}_$j=0A		for k in `seq $nr_level3`;=
 do=0A			CG_LEVEL3=3D$CG_LEVEL2/${i}_${j}_$k=0A			for l in `seq $nr_level4`=
; do=0A				CG_LEVEL4=3D$CG_LEVEL3/${i}_${j}_${k}_$l=0A				for m in `seq $nr=
_level5`; do=0A					CG_LEVEL5=3D$CG_LEVEL4/${i}_${j}_${k}_${l}_$m=0A					$T=
EST_DIR/run_in_cg.sh $CG_LEVEL5 &=0A				done=0A			done=0A		done=0A	done=0Ad=
one=0A=0Afunction set_quota=0A{=0A	quota=3D$1=0A=0A	for i in `seq $nr_level=
1`; do=0A		CG_LEVEL1=3D$CG_ROOT/$i=0A		sudo sh -c "echo $quota 100000 > $CG=
_LEVEL1/cpu.max"=0A		echo "$CG_LEVEL1: `cat $CG_LEVEL1/cpu.max`"=0A	done=0A=
}=0A=0A$TEST_DIR/run_monitor.sh=0A=0Aecho "set 50cpu quota to first level c=
groups"=0Aset_quota 5000000=0A=0Aecho "`date`: start"=0Await=0Aecho "`date`=
: done"=0A=0Acp /sys/fs/cgroup/1/cpu.stat 1_cpu.stat=0Acp /sys/fs/cgroup/2/=
cpu.stat 2_cpu.stat=0A=0A$TEST_DIR/kill_monitor.sh=0A
--+GmrL/yv/mu/Iea8
Content-Type: application/x-sh
Content-Disposition: attachment; filename="run_in_cg.sh"
Content-Transfer-Encoding: quoted-printable

set -e=0A=0ACG_PATH=3D$1=0A[ -z "$CG_PATH" ] && {=0A	echo "need cgroup path=
"=0A	exit=0A}=0A=0Aecho "CG_PATH: $CG_PATH"=0A=0Asudo sh -c "echo $$ > $CG_=
PATH/cgroup.procs"=0Asleep 5=0Aecho "$CG_PATH started"=0A=0Alogpath=3D`base=
name $CG_PATH`=0A/home/ziqianlu/src/rt-tests-2.7/hackbench -p -g 1 -l 50000=
 > $logpath=0A
--+GmrL/yv/mu/Iea8
Content-Type: application/x-sh
Content-Disposition: attachment; filename="cleanup.sh"
Content-Transfer-Encoding: quoted-printable

CG_ROOT=3D/sys/fs/cgroup=0A=0Anr_level1=3D2=0Anr_level2=3D10=0Anr_level3=3D=
10=0Anr_level4=3D10=0Anr_level5=3D10=0A=0Apkill hackbench=0Apkill netperf=
=0Apkill netserver=0A=0Afor i in `seq $nr_level1`; do=0A	CG_LEVEL1=3D$CG_RO=
OT/$i=0A	echo "cg_level1: $CG_LEVEL1"=0A	[ -d $CG_LEVEL1 ] || continue=0A=
=0A	for j in `seq $nr_level2`; do=0A		CG_LEVEL2=3D$CG_LEVEL1/${i}_$j=0A		ec=
ho "cg_level2: $CG_LEVEL2"=0A		[ -d $CG_LEVEL2 ] || continue=0A=0A		for k i=
n `seq $nr_level3`; do=0A			CG_LEVEL3=3D$CG_LEVEL2/${i}_${j}_$k=0A			echo "=
cg_level3: $CG_LEVEL3"=0A			[ -d $CG_LEVEL3 ] || continue=0A=0A			for l in =
`seq $nr_level4`; do=0A				CG_LEVEL4=3D$CG_LEVEL3/${i}_${j}_${k}_$l=0A				e=
cho "cg_level4: $CG_LEVEL4"=0A				[ -d $CG_LEVEL4 ] || continue=0A=0A				fo=
r m in `seq $nr_level5`; do=0A					CG_LEVEL5=3D$CG_LEVEL4/${i}_${j}_${k}_${=
l}_$m=0A					echo "cg_level5: $CG_LEVEL5"=0A					[ -d $CG_LEVEL5 ] || conti=
nue=0A					sudo rmdir $CG_LEVEL5=0A				done=0A=0A				sudo rmdir $CG_LEVEL4=
=0A			done=0A=0A			sudo rmdir $CG_LEVEL3=0A		done=0A=0A		sudo rmdir $CG_LEV=
EL2=0A	done=0A=0A	sudo rmdir $CG_LEVEL1=0Adone=0A
--+GmrL/yv/mu/Iea8--

