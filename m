Return-Path: <linux-kernel+bounces-813286-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DDEFB54324
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 08:44:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22D04AA1C0E
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 06:44:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ACC7285C82;
	Fri, 12 Sep 2025 06:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VCYA8JHj"
Received: from mail-lf1-f68.google.com (mail-lf1-f68.google.com [209.85.167.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E75EA284B33
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 06:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757659486; cv=none; b=DpqgCkOvvW9Yr+lK9akqVwFhpvRApH5CmXW40JZBTRrgrMav1huMLd8pnX3KzipyglkKyj2mC7Y5ZsSONGVPPn2A3isgZM17KImfXyAvK/xAJjjLuqyvVxxJl547S5KYOpxLLHgGdzSo2diAs4V0ozwWtp7BTYo733/zkwiETXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757659486; c=relaxed/simple;
	bh=2HSOW5nkoP7gYRCfZIysdf+wF4upO3G23/sXmLSYs5k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BglINdN5dUNdKohaUfc3SEQSZ1zOfPyikH6pDMggsrA+vFohuA44kVWKFZRNm+j9OG47XdKfrJuEwSqYihwR7LZB4K7s1lRkvaY8sJjvyqaBHWEtR8QJsBgdiBNh0GlINVBw/KHLZFBYJxJkfHV3Llu6UghnYC4CAIDJ/RXXlmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VCYA8JHj; arc=none smtp.client-ip=209.85.167.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f68.google.com with SMTP id 2adb3069b0e04-56afe77bc1eso1655553e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 23:44:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757659482; x=1758264282; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ihMDkIVZPu0vRt9mESexaXtW1swGqs9/4c69zS1ipTU=;
        b=VCYA8JHjyU8SUUFVNGG3Fe2Y59MWXVy6DmRaNguI5XJXe3NXmx44oLEYLivQmZib+t
         itOj3/jLPO9gV25OAImpdSQuLG5qYW7CkgeqpfSAfiPLKS7AZPvaLfgZG80lxq8XqXc4
         a5Aoszm4MkCwkXlHG8MM/+Br7qipg11zRszevJxImqSBrSiCrflQnSBBEi5WHxQZhyuk
         Q8Wd680JNkJjXdu3w7jfzRjbm+M/wq4ncTXpNPi6Bcc8VivXP7V8wKGn6mfPtEyDgQGW
         JWfBYXJjJX+FQI/Anp/Dd0OEt0EIphFTufH5pRfUevALYi5FvjzQbgayB9vNo/ZWwM6t
         rjUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757659482; x=1758264282;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ihMDkIVZPu0vRt9mESexaXtW1swGqs9/4c69zS1ipTU=;
        b=pi6ffenP/EH0yQOACCFx3nAlcXXCdJRg1H598MaM/w+Uqu0DCs1ay8UxR4dq2DATZm
         VPGOt3o6Patif6fd0T+d5mroAd5C7jkhWzDPoTVeVcV91hOgZL/tyS0Bz60voqZN4wBC
         dGXVDWqMXoc/kTH71QIZgVzuogF8WVRgQy+G4pFE13ktNaPCKkBL9e0K9k6jmM7rXUy1
         MSl3g/FECSWarDtfQrt9R3LFqglJaxTSbipF5tBPhTBk01gCyOtRaGoMz4l263LP54DT
         T2qgT93TVJB3ntCJjEKfmu3qfDGS7taU1kmGlkklzxhvW94VQAm2UxJwNtKtDWDKjYJe
         5YEA==
X-Forwarded-Encrypted: i=1; AJvYcCUirWENoFYyauu/dQyOyPYXleFFo6megN2FQZbxEPnBLNgWYBbXOE8EDAEI3vWumJ+ZKlhMlWLu7tsm7qM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrWZnA3pKoBWzZHgtSfXODVq4mi0FwNHpcc7fXwRjx/XB+jp9x
	lF6gq++F/nvd3xLWBeOmULgMJQhVa0fpchbsW9XhfbkqNTgQR1Dtjvr8nQBBAeLm97WIaxSR2q+
	sgklHl8WTTU7tZpsPEQVrbYGwK04Bsgo=
X-Gm-Gg: ASbGnct8ZZ1rplhJ8GiwvP2CFmqKBQ4f61E7A0RgIeHgncxv7qc1lp/lxsEPeTxHlgt
	2XlNeNYCxLzpYi9rzKVXzdUZrw6Nk4rw5Vd81BNX70mjeaWbeOKvho2Th1f0hsPchpXtorZ8AGP
	a+fZI7obxmZnuFLdDy1t++ixXpe0fmuTpSfb/baWgP/Rs1IPL1QfaiqCBhE80KZpEdn5ZlVkHBB
	TaSpwlvTSjIMZwi8YQ=
X-Google-Smtp-Source: AGHT+IGghfIH1Px4J8uXiqDN3PPJGDprrq+RK7jdWZKW9XUgbMptXwOQECzLiPTZZPnenewJ1VKO+CqnvA5OtzC3PDc=
X-Received: by 2002:a05:6512:12c4:b0:562:d04d:fa07 with SMTP id
 2adb3069b0e04-5704f3befcbmr634750e87.32.1757659481559; Thu, 11 Sep 2025
 23:44:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250910084316.356169-1-hupu.gm@gmail.com> <CAKfTPtCyL=ofg4yLtfG7zsoBMDnP48KCeUELT_Hddd3gnWeYEw@mail.gmail.com>
In-Reply-To: <CAKfTPtCyL=ofg4yLtfG7zsoBMDnP48KCeUELT_Hddd3gnWeYEw@mail.gmail.com>
From: hupu <hupu.gm@gmail.com>
Date: Fri, 12 Sep 2025 14:44:29 +0800
X-Gm-Features: Ac12FXxY8vNgtojMgM7adlBFGier-_BKVNRQuOJF0TbT6WGqzP5BzUaPQnrcY9U
Message-ID: <CADHxFxTkexicChcg3To4=AsX8c+s2RNWZ5NfA9UBLMfYRZtmKg@mail.gmail.com>
Subject: Re: [RESEND][RFC] sched: Introduce removed.load_sum for precise load propagation
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com, 
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com, 
	mgorman@suse.de, vschneid@redhat.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Vincent Guittot
Thank you very much for your reply.

On Thu, Sep 11, 2025 at 4:01=E2=80=AFPM Vincent Guittot
<vincent.guittot@linaro.org> wrote:
>
> On Wed, 10 Sept 2025 at 10:43, hupu <hupu.gm@gmail.com> wrote:
> >
> > Currently, load_sum to be propagated is estimated from
> > (removed_runnable * divider) >> SCHED_CAPACITY_SHIFT, which relies on
> > runnable_avg as an approximation. This approach can introduce precision
> > loss due to the shift operation, and the error may become more visible
> > when small tasks frequently enter and leave the queue.
>
> Do you have a level of error ? Do you have a typical use case ?
>

In fact, I derived the error here from the underlying mathematical
relationship. The error mainly comes from two sources:
a) The approximation of load_sum using runnable_avg;
b) The truncation introduced by the right shift (SCHED_CAPACITY_SHIFT).

Below is the detailed derivation and explanation.

removed_runnable records the sum of se->avg.runnable_avg for tasks
that have migrated to another CPU. It represents the decayed
cumulative contribution of a task=E2=80=99s runtime, with the unit being
microseconds (=CE=BCs). Right-shifting by SCHED_CAPACITY_SHIFT (10 bits) is
equivalent to truncating the low part below 1024 =CE=BCs. In other words,
if a task has accumulated less than 1024 =CE=BCs of runtime before
dequeueing, its load contribution will be completely discarded by the
shift operation. Even if the accumulated runtime exceeds 1024 =CE=BCs, the
shift may still introduce up to nearly 1024 =CE=BCs of truncation error
(about 1 ms).

For example, suppose a task has accumulated 4095 =CE=BCs (4.095 ms) of
runtime on CPU0, then goes to sleep and is migrated to CPU1 upon
wakeup. Ideally, CPU0 should remove that task=E2=80=99s contribution fully.
However, after the shift, the result is 4095 >> 10 =3D 3 ms, which means
CPU0 will still retain about 1023 =CE=BCs (~=3D 1.023 ms) of the task=E2=80=
=99s
contribution.

Experimental results also confirm this. By adding debug output before
add_tg_cfs_propagate and comparing the actual removed_load_sum (the
true value to be removed) with the approximate value obtained through
the shift, we observed that the latter is smaller in most cases. This
discrepancy is exactly due to the approximation and truncation
introduced by the shift.

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
old mode 100644
new mode 100755
index b173a059315c..92396da04520
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4561,7 +4561,8 @@ static void migrate_se_pelt_lag(struct
sched_entity *se) {}
 static inline int
 update_cfs_rq_load_avg(u64 now, struct cfs_rq *cfs_rq)
 {
-       unsigned long removed_load =3D 0, removed_util =3D 0, removed_runna=
ble =3D 0;
+       unsigned long removed_load_sum =3D 0, removed_load =3D 0;
+       unsigned long removed_util =3D 0, removed_runnable =3D 0;
        struct sched_avg *sa =3D &cfs_rq->avg;
        int decayed =3D 0;

@@ -4572,6 +4573,7 @@ update_cfs_rq_load_avg(u64 now, struct cfs_rq *cfs_rq=
)
                raw_spin_lock(&cfs_rq->removed.lock);
                swap(cfs_rq->removed.util_avg, removed_util);
                swap(cfs_rq->removed.load_avg, removed_load);
+               swap(cfs_rq->removed.load_sum, removed_load_sum);
                swap(cfs_rq->removed.runnable_avg, removed_runnable);
                cfs_rq->removed.nr =3D 0;
                raw_spin_unlock(&cfs_rq->removed.lock);
@@ -4609,8 +4611,10 @@ update_cfs_rq_load_avg(u64 now, struct cfs_rq *cfs_r=
q)
                 * removed_runnable is the unweighted version of
removed_load so we
                 * can use it to estimate removed_load_sum.
                 */
-               add_tg_cfs_propagate(cfs_rq,
-                       -(long)(removed_runnable * divider) >>
SCHED_CAPACITY_SHIFT);
+               trace_printk("DEBUG BYHP: removed_load_sum=3D%lu,
raw_removed_runnable_sum=3D%lu\n",
+                               (long)removed_load_sum,
+                               (long)((removed_runnable * divider) >>
SCHED_CAPACITY_SHIFT));
+               add_tg_cfs_propagate(cfs_rq, -(long)removed_load_sum);

                decayed =3D 1;
        }
@@ -4792,6 +4796,7 @@ static void remove_entity_load_avg(struct
sched_entity *se)
        ++cfs_rq->removed.nr;
        cfs_rq->removed.util_avg        +=3D se->avg.util_avg;
        cfs_rq->removed.load_avg        +=3D se->avg.load_avg;
+       cfs_rq->removed.load_sum        +=3D se->avg.load_sum;
        cfs_rq->removed.runnable_avg    +=3D se->avg.runnable_avg;
        raw_spin_unlock_irqrestore(&cfs_rq->removed.lock, flags);
 }
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index be9745d104f7..659935a5c694 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -682,6 +682,7 @@ struct cfs_rq {
        struct {
                raw_spinlock_t  lock ____cacheline_aligned;
                int             nr;
+               unsigned long   load_sum;
                unsigned long   load_avg;
                unsigned long   util_avg;
                unsigned long   runnable_avg;

The logs are as follows: raw_removed_runnable_sum is often smaller
than removed_load_sum. This difference is exactly caused by the
approximate calculation and the truncation introduced by bit shifting.

   stress-ng-cpu-183     (-------) [001] dnh1.   144.338335:
update_load_avg: DEBUG BYHP: removed_load_sum=3D35463,
raw_removed_runnable_sum=3D35429
   stress-ng-cpu-184     (-------) [007] dNs1.   144.346203:
sched_balance_update_blocked_averages: DEBUG BYHP:
removed_load_sum=3D20607, raw_removed_runnable_sum=3D20496
   stress-ng-cpu-185     (-------) [001] d.h1.   144.568803:
update_load_avg: DEBUG BYHP: removed_load_sum=3D0,
raw_removed_runnable_sum=3D0
   stress-ng-cpu-183     (-------) [000] d.h1.   145.526897:
update_load_avg: DEBUG BYHP: removed_load_sum=3D11103,
raw_removed_runnable_sum=3D11072
   stress-ng-cpu-183     (-------) [000] d.h1.   145.563980:
update_load_avg: DEBUG BYHP: removed_load_sum=3D0,
raw_removed_runnable_sum=3D0
   stress-ng-cpu-185     (-------) [002] d..2.   145.593563:
sched_balance_update_blocked_averages: DEBUG BYHP: removed_load_sum=3D0,
raw_removed_runnable_sum=3D0
   stress-ng-cpu-181     (-------) [005] d.s1.   145.653525:
sched_balance_update_blocked_averages: DEBUG BYHP:
removed_load_sum=3D2537, raw_removed_runnable_sum=3D2508
   stress-ng-cpu-183     (-------) [003] d.s1.   145.657599:
sched_balance_update_blocked_averages: DEBUG BYHP:
removed_load_sum=3D28510, raw_removed_runnable_sum=3D28473
   stress-ng-cpu-180     (-------) [007] d.h1.   146.049167:
update_load_avg: DEBUG BYHP: removed_load_sum=3D9548,
raw_removed_runnable_sum=3D9526
   stress-ng-cpu-184     (-------) [005] d.h1.   146.057200:
update_load_avg: DEBUG BYHP: removed_load_sum=3D5974,
raw_removed_runnable_sum=3D5963
   stress-ng-cpu-182     (-------) [000] d.s1.   146.062025:
sched_balance_update_blocked_averages: DEBUG BYHP:
removed_load_sum=3D55, raw_removed_runnable_sum=3D45
      kcompactd0-65      (-------) [001] d..2.   146.095334:
update_load_avg: DEBUG BYHP: removed_load_sum=3D0,
raw_removed_runnable_sum=3D0
      kcompactd0-65      (-------) [001] d..2.   146.095433:
sched_balance_update_blocked_averages: DEBUG BYHP:
removed_load_sum=3D17493, raw_removed_runnable_sum=3D17461
   stress-ng-cpu-186     (-------) [006] d.h1.   146.118910:
update_load_avg: DEBUG BYHP: removed_load_sum=3D11404,
raw_removed_runnable_sum=3D11389
   stress-ng-cpu-186     (-------) [000] d.h1.   147.112614:
update_load_avg: DEBUG BYHP: removed_load_sum=3D0,
raw_removed_runnable_sum=3D0
             cat-234     (-------) [005] d.s2.   147.161900:
sched_balance_update_blocked_averages: DEBUG BYHP:
removed_load_sum=3D36778, raw_removed_runnable_sum=3D36768
   stress-ng-cpu-181     (-------) [004] d.h1.   147.406979:
update_load_avg: DEBUG BYHP: removed_load_sum=3D3029,
raw_removed_runnable_sum=3D3014
   stress-ng-cpu-185     (-------) [003] d.s1.   147.474502:
sched_balance_update_blocked_averages: DEBUG BYHP:
removed_load_sum=3D1242, raw_removed_runnable_sum=3D1205
   stress-ng-cpu-186     (-------) [000] d.h1.   147.533368:
update_load_avg: DEBUG BYHP: removed_load_sum=3D11,
raw_removed_runnable_sum=3D0
   stress-ng-cpu-181     (-------) [001] d.s1.   148.341639:
sched_balance_update_blocked_averages: DEBUG BYHP:
removed_load_sum=3D15837, raw_removed_runnable_sum=3D15804
     migration/7-51      (-------) [007] d..2.   148.384219:
sched_balance_update_blocked_averages: DEBUG BYHP: removed_load_sum=3D0,
raw_removed_runnable_sum=3D0
          <idle>-0       (-------) [004] d.s2.   148.431501:
sched_balance_update_blocked_averages: DEBUG BYHP:
removed_load_sum=3D4292, raw_removed_runnable_sum=3D1924
             cat-234     (-------) [007] d.h1.   148.434474:
update_load_avg: DEBUG BYHP: removed_load_sum=3D10380,
raw_removed_runnable_sum=3D9945
   stress-ng-cpu-184     (-------) [001] d.h1.   148.853949:
update_load_avg: DEBUG BYHP: removed_load_sum=3D15896,
raw_removed_runnable_sum=3D15869
   stress-ng-cpu-185     (-------) [007] d.s1.   148.862267:
sched_balance_update_blocked_averages: DEBUG BYHP:
removed_load_sum=3D31, raw_removed_runnable_sum=3D0
   stress-ng-cpu-183     (-------) [006] d.h1.   149.157805:
update_load_avg: DEBUG BYHP: removed_load_sum=3D20553,
raw_removed_runnable_sum=3D20527
   stress-ng-cpu-179     (-------) [007] d.h1.   149.330189:
update_load_avg: DEBUG BYHP: removed_load_sum=3D9204,
raw_removed_runnable_sum=3D9177
   stress-ng-cpu-185     (-------) [002] d.h1.   149.434768:
update_load_avg: DEBUG BYHP: removed_load_sum=3D11198,
raw_removed_runnable_sum=3D11176
          <idle>-0       (-------) [006] dNs2.   149.456004:
sched_balance_update_blocked_averages: DEBUG BYHP:
removed_load_sum=3D2826, raw_removed_runnable_sum=3D465
   stress-ng-cpu-184     (-------) [005] d.s1.   149.483636:
sched_balance_update_blocked_averages: DEBUG BYHP:
removed_load_sum=3D11607, raw_removed_runnable_sum=3D11595
   stress-ng-cpu-186     (-------) [001] d.h1.   149.668063:
update_load_avg: DEBUG BYHP: removed_load_sum=3D0,
raw_removed_runnable_sum=3D0
          <idle>-0       (-------) [001] d.h2.   149.672477:
update_load_avg: DEBUG BYHP: removed_load_sum=3D0,
raw_removed_runnable_sum=3D0
   stress-ng-cpu-183     (-------) [007] d.s1.   149.684045:
sched_balance_update_blocked_averages: DEBUG BYHP:
removed_load_sum=3D5657, raw_removed_runnable_sum=3D5458
     ksoftirqd/1-22      (-------) [001] d.s1.   149.700089:
update_load_avg: DEBUG BYHP: removed_load_sum=3D0,
raw_removed_runnable_sum=3D0
   stress-ng-cpu-183     (-------) [004] d.h1.   149.807666:
update_load_avg: DEBUG BYHP: removed_load_sum=3D10481,
raw_removed_runnable_sum=3D10474
   stress-ng-cpu-184     (-------) [000] d.h1.   149.817148:
update_load_avg: DEBUG BYHP: removed_load_sum=3D3,
raw_removed_runnable_sum=3D0
          <idle>-0       (-------) [001] d.s2.   149.866309:
sched_balance_update_blocked_averages: DEBUG BYHP:
removed_load_sum=3D4010, raw_removed_runnable_sum=3D3999
   stress-ng-cpu-184     (-------) [000] d.s1.   149.914423:
sched_balance_update_blocked_averages: DEBUG BYHP:
removed_load_sum=3D1920, raw_removed_runnable_sum=3D1876




> >
> > This patch introduces removed.load_sum to directly accumulate
> > se->avg.load_sum when tasks dequeue, and uses it during load
> > propagation. By doing so:
> >
> >   a) Avoid relying on runnable_avg-based approximation and obtain
> >      higher precision in load_sum propagation;
> >   b) Eliminate precision loss from the shift operation, especially
> >      with frequent short-lived tasks;
> >   c) Reduce one multiplication and shift in the hotpath, which
> >      theoretically lowers overhead (though the impact is minor).
>
> This doesn't work because rq's load_sum tracks current weight whereas
> se's load_sum doesn't include the weight which is only applied on se's
> load_avg. So you can't directly add/sub se's load_sum and rq's
> load_sum. Only load_avg of both se and rq use the same unit.
>

I understand and agree with your point: cfs_rq->avg.load_sum includes
the weight while se->avg.load_sum does not, so the two are indeed in
different units and cannot be directly added or subtracted.

However, in this patch we DO NOT directly add or subtract
se->avg.load_sum to/from cfs_rq->avg.load_sum. Instead, the load_sum
of dequeued tasks is accumulated into cfs_rq->prop_runnable_sum.
Later, in update_tg_cfs_load, this prop_runnable_sum is used to
recompute the load_sum and load_avg of both gse and cfs_rq.

In other words, the update here is performed via recomputation rather
than direct arithmetic, so the =E2=80=9Cunit mismatch=E2=80=9D issue you me=
ntioned
does not occur.

update_tg_cfs_load
  |-- long delta_avg, runnable_sum =3D gcfs_rq->prop_runnable_sum;
  |
  |   runnable_sum +=3D gse->avg.load_sum;
  |
  |   load_sum =3D se_weight(gse) * runnable_sum;
  |   load_avg =3D div_u64(load_sum, divider);
  |
  |   delta_avg =3D load_avg - gse->avg.load_avg;
  |   delta_sum =3D load_sum - (s64)se_weight(gse) * gse->avg.load_sum;
  |
  |-- /* Recalculate the load_sum and load_avg of gse. */
  |   gse->avg.load_sum =3D runnable_sum;
  |   gse->avg.load_avg =3D load_avg;
  |
  |-- /* Recalculate the load_sum and load_avg of cfs_rq. */
  |   add_positive(&cfs_rq->avg.load_avg, delta_avg);
  |   add_positive(&cfs_rq->avg.load_sum, delta_sum);




>
> Then, why is it a problem only for load and not util or runnable ?
>

I broke this question into three parts and derived the related
formulas step by step.


Q1: Why doesn=E2=80=99t util_avg have the same problem?
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
A1: Because the formulas of util_avg / util_sum are exactly the same
for both se and cfs_rq. Neither involves weight, and the units are
consistent, so direct addition and subtraction are valid.

The formulas for a sched_entity (tse) are:

             util_sum
util_avg =3D ------------
              divider


    decay(history) + contrib(running) * 1024
  =3D ----------------------------------------
                  divider


    (decay(history) + contrib(running)) * 1024
 ~=3D ------------------------------------------
                  divider


    decay(history) + contrib(running)
  =3D --------------------------------- * 1024
                  divider


Where:
util_sum =3D decay(history) + contrib(running) * 1024
util_avg < 1024
decay(history): represents geometric decay of the historical contribution (=
time)
contrib(running): contribution added when the task is in running state


For cfs_rq, the formulas of util_avg / util_sum are:

             util_sum
util_avg =3D ------------
              divider


    decay(history) + contrib(running) * 1024
  =3D ----------------------------------------
                  divider


    (decay(history) + contrib(running)) * 1024
 ~=3D ------------------------------------------
                      divider


    decay(history) + contrib(running)
  =3D --------------------------------- * 1024
                 divider


Where:
util_sum =3D decay(history) + contrib(running) * 1024
util_avg < 1024
decay(history): represents geometric decay of the historical contribution (=
time)
contrib(running): contribution added when the task is in running state


Therefore, se and cfs_rq share the same units for util_avg / util_sum,
which makes direct addition and subtraction valid. This is also why
update_tg_cfs_util performs direct subtraction when updating:

update_tg_cfs_util
  |-- /* Calculate the delta between gse and gcfs_rq directly by subtractio=
n. */
  |   long delta_avg =3D gcfs_rq->avg.util_avg - se->avg.util_avg;
  |
  |-- /* Set new sched_entity's utilization */
  |   se->avg.util_avg =3D gcfs_rq->avg.util_avg;
  |   new_sum =3D se->avg.util_avg * divider;
  |   delta_sum =3D (long)new_sum - (long)se->avg.util_sum;
  |   se->avg.util_sum =3D new_sum;
  |
  |-- /* Update parent cfs_rq utilization */
  |   add_positive(&cfs_rq->avg.util_avg, delta_avg);
  |   add_positive(&cfs_rq->avg.util_sum, delta_sum);


Q2: Why doesn=E2=80=99t runnable_avg have the same problem?
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
A2: Similarly, the runnable_avg / runnable_sum of se and cfs_rq also
do not include weight.

The calculation formulas for tse's runnable_avg and runnable_sum are as fol=
lows:

                 runnable_sum
runnable_avg =3D ----------------
                   divider


    decay(history) + contrib(running + runnable) * 1024
  =3D ---------------------------------------------------
                        divider


    (decay(history) + contrib(running + runnable)) * 1024
 ~=3D -----------------------------------------------------
                         divider


    decay(history) + contrib(running + runnable)
  =3D -------------------------------------------- * 1024
                      divider


Where:
runnable_sum =3D decay(history) + contrib(running + runnable) * 1024
runnable_avg < 1024
decay(history): represents geometric decay of the historical contribution (=
time)
contrib(running + runnable): contribution added when the task is in
running and runnable states


The calculation formulas for cfs_rq's runnable_avg and runnable_sum
are as follows:

                 runnable_sum
runnable_avg =3D ----------------
                   divider


    decay(history) + contrib(running + runnable) * cfs_rq->h_nr_running * 1=
024
  =3D ---------------------------------------------------------------------=
-----
                                     divider


  (decay(history) + contrib(running + runnable)) * cfs_rq->h_nr_running * 1=
024
 ~=3D ---------------------------------------------------------------------=
-----
                                   divider


    decay(history) + contrib(running + runnable)
  =3D -------------------------------------------- * cfs_rq->h_nr_running *=
 1024
                      divider


Where:
runnable_sum =3D decay(history) + contrib(running + runnable) *
cfs_rq->h_nr_running * 1024
runnable_avg < cfs_rq->h_nr_running * 1024
decay(history): represents geometric decay of the historical contribution (=
time)
contrib(running + runnable): contribution added when the task is in
running and runnable states


The runnable statistic of cfs_rq is represented by h_nr_running, which
indicates the number of tasks and can be regarded as the accumulated
runnable of all se. Therefore, in update_tg_cfs_runnable, the update
can also be done directly using subtraction.

update_tg_cfs_runnable
  |-- /* Calculate the delta directly by subtraction. */
  |   long delta_avg =3D gcfs_rq->avg.runnable_avg - gse->avg.runnable_avg;
  |
  |-- /* Set new sched_entity's runnable */
  |   gse->avg.runnable_avg =3D gcfs_rq->avg.runnable_avg;
  |   new_sum =3D gse->avg.runnable_avg * divider;
  |   delta_sum =3D (long)new_sum - (long)gse->avg.runnable_sum;
  |   gse->avg.runnable_sum =3D new_sum;
  |
  |-- /* Update parent cfs_rq runnable */
  |   add_positive(&cfs_rq->avg.runnable_avg, delta_avg);
  |   add_positive(&cfs_rq->avg.runnable_sum, delta_sum);


Q3: Why does load_avg have this problem?
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
A3: The key difference is that cfs_rq=E2=80=99s load_avg and load_sum inclu=
de
weight information, while a task=E2=80=99s load_sum does not. Moreover, we
cannot reconstruct load_sum from a task=E2=80=99s load_avg.

For a task (tse), the formulas are:

             load_sum
load_avg =3D ------------ * se_weight(se)
              divider


   decay(history) + contrib(running + runnable)
 =3D -------------------------------------------- * se_weight(se)
                     divider


Where:
load_sum =3D decay(history) + contrib(running + runnable)
load_avg < se_weight(se)
decay(history): represents geometric decay of the historical contribution (=
time)
contrib(running + runnable): contribution added when the task is in
running and runnable states


For a cfs_rq, the formulas are:

             load_sum
load_avg =3D ------------
              divider


    decay(history) + contrib(running + runnable) * cfs_rq->load.weight
  =3D ------------------------------------------------------------------
                                  divider


    (decay(history) + contrib(running + runnable)) * cfs_rq->load.weight
 ~=3D --------------------------------------------------------------------
                                 divider


    decay(history) + contrib(running + runnable)
  =3D -------------------------------------------- * cfs_rq->load.weight
                      divider


Where:
load_sum =3D decay(history) + contrib(running + runnable) * cfs_rq->load.we=
ight
load_avg < cfs_rq->load.weight
decay(history): represents geometric decay of the historical contribution (=
time)
contrib(running + runnable): contribution added when the task is in
running and runnable states


From these formulas, we can see that tse=E2=80=99s load_sum does not includ=
e
weight, while cfs_rq=E2=80=99s does. Their units differ, so they cannot be
directly added or subtracted. In addition, weight is a "historical
variable" that changes over time, which means load_sum cannot be
derived from se=E2=80=99s load_avg.

To propagate load_sum changes from a child cfs_rq, the upstream
implementation uses runnable_avg to APPROXIMATE load_sum. The
derivation is as follows.

For tse:

                 runnable_sum
runnable_avg =3D ----------------
                   divider

    decay(history) + contrib(running + runnable) * 1024
  =3D ---------------------------------------------------
                     divider

     decay(history) + contrib(running + runnable)
 ~=3D --------------------------------------------- * 1024
                     divider


Thus:

decay(history) + contrib(running + runnable)


     runnable_avg * divider
 ~=3D -----------------------
             1024


 ~=3D (runnable_avg * divider) >> SCHED_CAPACITY_SHIFT        (1)


Equation (1) represents the contribution when a task is in running or
runnable state. The kernel refers to this as the "unweighted version
of removed_load", which is essentially time with exponential decay
applied.

It is worth noting that equation (1) happens to be equal to tse=E2=80=99s
load_sum. Therefore, for tse we have:

load_sum ~=3D (runnable_avg * divider) >> SCHED_CAPACITY_SHIFT     (2)

However, equation (2) itself is only an approximation, and the
right-shift operation introduces further truncation error.

My idea is that since the task=E2=80=99s load_sum already exists when it
dequeues, it is more reasonable to record this value directly. By
doing so, we can avoid both the approximation and the shift-induced
error. This is the motivation behind introducing removed.load_sum in
my patch.




> Also we don't want to track both load_sum and load_avg, only one is
> enough and by the above it is load_avg
>

My view is consistent with yours, but I personally lean towards
keeping load_sum and deprecating load_avg, since load_avg does not
seem to be accurate.

That said, this is only my personal perspective and may not be
comprehensive. I would like to further discuss the feasibility of this
approach with you.

Thanks.
hupu

