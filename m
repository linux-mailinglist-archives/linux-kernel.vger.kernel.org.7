Return-Path: <linux-kernel+bounces-729361-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E263B0356C
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 07:00:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 717E63B9AB1
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 05:00:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 408B61F3BA2;
	Mon, 14 Jul 2025 05:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NswDMG6t"
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0336F1F19A
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 05:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752469226; cv=none; b=OOA9iL0HwTf3mxj/vpvOG9zK0ILVCz1+XwFglDoIfGXtaHhkXhHW1hPMHQx/XAcBI0MdBkSV5NpoZUJJnjPItRanO5ShMVdalB1MDK801WEvKH1AiH5437eQ64sLTnEieKkfRxqewlNU4bfAe+D39cSAA0m03hf/J7Ve0vfqF44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752469226; c=relaxed/simple;
	bh=gHxlnA6LgZxKV5dmbJqffiJrRw82NzIBqp5YGau3qC4=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=O350wb5MhQwPXYG7xY02oSIx+1jb3oAMnXG/cd8a5GkiszT+P+lN6MDbHkxST7G8WPixGwcJ9CsIAeUsUpTi49DQ323Une0cho/cMWvjqqq8qrVxuAqLB6D2fb9RsTE5ShTHMO4IA2KgourL4R/oenOrgPD4TBd8C19MbwAkjZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ynaffit.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NswDMG6t; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ynaffit.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-74943a7cd9aso6290375b3a.3
        for <linux-kernel@vger.kernel.org>; Sun, 13 Jul 2025 22:00:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752469224; x=1753074024; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Fu+1xKZsCbp8EBtYxAQNv93eMws3Yjoib2aAx/i+j5Y=;
        b=NswDMG6t8zRVA+9eHnMvHFqPb6btgHCc0VCDKH6gF514Fk+LQuRa9RufBwQijc6ft9
         m69VymXAQMGODwC7vp9Jx91JVZXtfbrp3TzUOwabm/Futxty9HyN7p4SIRlk1s/u2HF4
         XGYBGpxuPJtEwVVJ2s2Tkw2NiBLfsMgauyqz42MFQ8wYU/aSy9YSH5T9IkZ801Hd7Qli
         DIcSochVegsS8zJshtOFsUNmRskWP0KoDVtUQcdcAs84kSqT8+ci6VochdB1636OB2oc
         1rGPnQj2x4JWxZp8rU8OBlxt7LkxjTidTRiRBla1AugzP0C0VTRHFIrKKByfRq5WwX59
         IT8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752469224; x=1753074024;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fu+1xKZsCbp8EBtYxAQNv93eMws3Yjoib2aAx/i+j5Y=;
        b=nOZk6CVFJZtd6N4JpkDZOCeeDw65stjcqTaItJYZ56/4jH7IUf27QQ34fhCfjbpioj
         doBBoTUKaTftTunba6zXwe1GNIMfUjC4h4j0A1aD18cxskTB+ZSynvOULRY8MyMT2wO4
         I+o3LMJQdA6P0vhyXzAWsmfcLmf0MsfLQ47R3osaWy1hp1LNCDod2o0Qwp6JEZkSQCkU
         mpv/sjlJAWCGZ5zX02uPsQ7QtfpwPaHEyIFhxEUofTsJU8Jnkf9UlIwRPOPf4flR996Y
         KOqYQWVAYcAfoPE8gmqdDEESzhduTeEXPnsZV+s69W85Hjmb2X/HXPQ2Ai/fcUcWx+pX
         dmkQ==
X-Gm-Message-State: AOJu0Yz2ofBrOUrqscFaHBUumr3Xl5WRa27OQmX7P03G8f96fxRjMS/x
	SNzJfactBN9sCe8Koip8AoZQANhZS8dnE7+T4Es+4JThx+099Yw+L1j2sUsRvszMyrrbr2mws+3
	OezLktlUf2CeJWfBXCfMF3ZsDRoJ8xhM/RDKJM1lRuL+YgCQ853oMUDH1ZDGxoJw4IxZ6F+TBw8
	UTpPOZzVJEMt1/ikkrwHP1ofr5bWX78kbQckiFIHcLSxYtJFnliw==
X-Google-Smtp-Source: AGHT+IFbwA9z7fuUsgLulCfX8O7JSbtjEH69zVTrR3Yzy6t4R4xWD7fwFlIaHEfCxHu+gxOEYb/yjeEvZe02
X-Received: from pfbbv3.prod.google.com ([2002:a05:6a00:4143:b0:749:8f7:e14e])
 (user=ynaffit job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:1743:b0:74a:e29c:287d
 with SMTP id d2e1a72fcca58-74ee244a366mr17343044b3a.11.1752469224214; Sun, 13
 Jul 2025 22:00:24 -0700 (PDT)
Date: Sun, 13 Jul 2025 22:00:09 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250714050008.2167786-2-ynaffit@google.com>
Subject: [RFC PATCH v2] cgroup: Track time in cgroup v2 freezer
From: Tiffany Yang <ynaffit@google.com>
To: linux-kernel@vger.kernel.org
Cc: John Stultz <jstultz@google.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Stephen Boyd <sboyd@kernel.org>, Anna-Maria Behnsen <anna-maria@linutronix.de>, 
	Frederic Weisbecker <frederic@kernel.org>, Tejun Heo <tj@kernel.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, "=?UTF-8?q?Michal=20Koutn=C3=BD?=" <mkoutny@suse.com>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Chen Ridong <chenridong@huawei.com>, 
	kernel-team@android.com, Jonathan Corbet <corbet@lwn.net>, cgroups@vger.kernel.org, 
	linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

The cgroup v2 freezer controller allows user processes to be dynamically
added to and removed from an interruptible frozen state from
userspace. This feature is helpful for application management, as
a background app can be frozen to prevent its threads from being
scheduled or otherwise contending with foreground tasks for
resources. However, the application is usually unaware that it was
frozen, which can cause issues by disrupting any internal monitoring
that it is performing.

As an example, an application may implement a watchdog thread for one of
its high priority maintenance tasks that operates by checking some state
of that task at a set interval to ensure it has made progress. The key
challenge here is that the task is only expected to make progress when
the application it belongs to has the opportunity to run, but there's no
application-relative time to set the watchdog timer against. Instead,
the next timeout is set relative to system time, using an approximation
that assumes the application will continue to be scheduled as
normal. If the task misses that approximate deadline because the
application was frozen, without any way to know that, the watchdog may
kill the healthy process.

Other sources of delay can cause similar issues, but this change focuses
on allowing frozen time to be accounted for in particular because of how
large it can grow and how unevenly it can affect applications running on
the system. To allow an application to better account for the time it
spends running, I propose tracking the time each cgroup spends freezing
and exposing it to userland via a new core interface file in
cgroupfs (cgroup.freeze.stat). I used this naming because utility
controllers like "kill" and "freeze" are exposed as cgroup v2 core
interface files, but I'm happy to change it if there's a convention
others would prefer!

Currently, the cgroup css_set_lock is used to serialize accesses to the
CGRP_FREEZE bit of cgrp->flags and the new cgroup_freezer_state counters
(freeze_time_start_ns and freeze_time_total_ns). If we start to see
higher contention on this lock, we may want to introduce a v2 freezer
state-specific lock to avoid having to take the global lock every time
a cgroup.freeze.stat file is read.

Any feedback would be much appreciated!

Thank you,
Tiffany

Signed-off-by: Tiffany Yang <ynaffit@google.com>
---
v2:
* Track per-cgroup freezing time instead of per-task frozen time as
  suggested by Tejun Heo

Cc: John Stultz <jstultz@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Stephen Boyd <sboyd@kernel.org>
Cc: Anna-Maria Behnsen <anna-maria@linutronix.de>
Cc: Frederic Weisbecker <frederic@kernel.org>
Cc: Tejun Heo <tj@kernel.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Michal Koutn=C3=BD <mkoutny@suse.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Pavel Machek <pavel@kernel.org>
Cc: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Chen Ridong <chenridong@huawei.com>
---
 Documentation/admin-guide/cgroup-v2.rst |  8 ++++++++
 include/linux/cgroup-defs.h             |  6 ++++++
 kernel/cgroup/cgroup.c                  | 24 ++++++++++++++++++++++++
 kernel/cgroup/freezer.c                 |  8 ++++++--
 4 files changed, 44 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-=
guide/cgroup-v2.rst
index bd98ea3175ec..9fbf3a959bdf 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -1018,6 +1018,14 @@ All cgroup core files are prefixed with "cgroup."
 	it's possible to delete a frozen (and empty) cgroup, as well as
 	create new sub-cgroups.
=20
+  cgroup.freeze.stat
+	A read-only flat-keyed file which exists in non-root cgroups.
+	The following entry is defined:
+
+	  freeze_time_total_ns
+		Cumulative time that this cgroup has spent in the freezing
+		state, regardless of whether or not it reaches "frozen".
+
   cgroup.kill
 	A write-only single value file which exists in non-root cgroups.
 	The only allowed value is "1".
diff --git a/include/linux/cgroup-defs.h b/include/linux/cgroup-defs.h
index e61687d5e496..86332d83fa22 100644
--- a/include/linux/cgroup-defs.h
+++ b/include/linux/cgroup-defs.h
@@ -436,6 +436,12 @@ struct cgroup_freezer_state {
 	 * frozen, SIGSTOPped, and PTRACEd.
 	 */
 	int nr_frozen_tasks;
+
+	/* Time when the cgroup was requested to freeze */
+	u64 freeze_time_start_ns;
+
+	/* Total duration the cgroup has spent freezing */
+	u64 freeze_time_total_ns;
 };
=20
 struct cgroup {
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index a723b7dc6e4e..1f54d16a8713 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -4050,6 +4050,23 @@ static ssize_t cgroup_freeze_write(struct kernfs_ope=
n_file *of,
 	return nbytes;
 }
=20
+static int cgroup_freeze_stat_show(struct seq_file *seq, void *v)
+{
+	struct cgroup *cgrp =3D seq_css(seq)->cgroup;
+	u64 freeze_time =3D 0;
+
+	spin_lock_irq(&css_set_lock);
+	if (test_bit(CGRP_FREEZE, &cgrp->flags))
+		freeze_time =3D ktime_get_ns() - cgrp->freezer.freeze_time_start_ns;
+
+	freeze_time +=3D cgrp->freezer.freeze_time_total_ns;
+	spin_unlock_irq(&css_set_lock);
+
+	seq_printf(seq, "freeze_time_total_ns %llu\n", freeze_time);
+
+	return 0;
+}
+
 static void __cgroup_kill(struct cgroup *cgrp)
 {
 	struct css_task_iter it;
@@ -5355,6 +5372,11 @@ static struct cftype cgroup_base_files[] =3D {
 		.seq_show =3D cgroup_freeze_show,
 		.write =3D cgroup_freeze_write,
 	},
+	{
+		.name =3D "cgroup.freeze.stat",
+		.flags =3D CFTYPE_NOT_ON_ROOT,
+		.seq_show =3D cgroup_freeze_stat_show,
+	},
 	{
 		.name =3D "cgroup.kill",
 		.flags =3D CFTYPE_NOT_ON_ROOT,
@@ -5758,6 +5780,7 @@ static struct cgroup *cgroup_create(struct cgroup *pa=
rent, const char *name,
 	 * if the parent has to be frozen, the child has too.
 	 */
 	cgrp->freezer.e_freeze =3D parent->freezer.e_freeze;
+	cgrp->freezer.freeze_time_total_ns =3D 0;
 	if (cgrp->freezer.e_freeze) {
 		/*
 		 * Set the CGRP_FREEZE flag, so when a process will be
@@ -5766,6 +5789,7 @@ static struct cgroup *cgroup_create(struct cgroup *pa=
rent, const char *name,
 		 * consider it frozen immediately.
 		 */
 		set_bit(CGRP_FREEZE, &cgrp->flags);
+		cgrp->freezer.freeze_time_start_ns =3D ktime_get_ns();
 		set_bit(CGRP_FROZEN, &cgrp->flags);
 	}
=20
diff --git a/kernel/cgroup/freezer.c b/kernel/cgroup/freezer.c
index bf1690a167dd..6f3fab252140 100644
--- a/kernel/cgroup/freezer.c
+++ b/kernel/cgroup/freezer.c
@@ -179,10 +179,14 @@ static void cgroup_do_freeze(struct cgroup *cgrp, boo=
l freeze)
 	lockdep_assert_held(&cgroup_mutex);
=20
 	spin_lock_irq(&css_set_lock);
-	if (freeze)
+	if (freeze) {
 		set_bit(CGRP_FREEZE, &cgrp->flags);
-	else
+		cgrp->freezer.freeze_time_start_ns =3D ktime_get_ns();
+	} else {
 		clear_bit(CGRP_FREEZE, &cgrp->flags);
+		cgrp->freezer.freeze_time_total_ns +=3D (ktime_get_ns() -
+			cgrp->freezer.freeze_time_start_ns);
+	}
 	spin_unlock_irq(&css_set_lock);
=20
 	if (freeze)
--=20
2.50.0.727.gbf7dc18ff4-goog


