Return-Path: <linux-kernel+bounces-739179-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C503B0C2DD
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 13:26:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF7473B7633
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 11:26:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1ACA29B8DB;
	Mon, 21 Jul 2025 11:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZwAKtZ3u"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69ABB29ACEA
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 11:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753097143; cv=none; b=QGXySV/fx8bb6oAu5rsYCJ2oWnm4PrKZZqhwsbXYp9O2aKjsHcphxqL/J+Zz6KSwrt0QqfsnEKJLU0ZZjUJW5yt/Xy4GOQ3V3VUKM6YLrNN7XL2tJExH9aDoeyWLmZsd+SdTv6vbWeyoCk/2Rcw7DC08BFT7+jCdygVw4t3YmxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753097143; c=relaxed/simple;
	bh=+h0qgyFAIZh9TvE6JANV+tpEHP7rFWwM6prPwetA4d4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GzIOjjnB/kgTbD5uE3aWe4AE3RWsMzB5N/4SjEK1jncK0LJmcg2/eC3WvbJWI36IqYnMM8ICNy7pd6D6WEWsnmDR7APKzty9ADLieHb+0k02TG39G/N6fdo+oxh2CCJ7YkO3NV8b/onfvEqOq9u/3iEbWSnDy1Qg3x1G6C4wcbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZwAKtZ3u; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753097140;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=I9xHIUZGDixZ4oA3O6QnP/ENCMTQ0evD0jQLzmoUP1s=;
	b=ZwAKtZ3uXoeI8PUKGbY/Hl+IMkNaNznqN4mLlZQLeNvCrMfHoLpVKoAnrxY1R+qlFQbYRS
	OE1gtXt+tfaol7u14XgRJPMGY90zbp3uxHl8etiqelatRRTkC7YpUrKtSoeGpGkVFVZS7v
	N8zjZQj2TonAsogyCTRgjqLfCsj6nq0=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-681-WWWvZ43bP9aebbYimlf95w-1; Mon, 21 Jul 2025 07:25:39 -0400
X-MC-Unique: WWWvZ43bP9aebbYimlf95w-1
X-Mimecast-MFC-AGG-ID: WWWvZ43bP9aebbYimlf95w_1753097138
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3a579058758so1651829f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 04:25:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753097137; x=1753701937;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I9xHIUZGDixZ4oA3O6QnP/ENCMTQ0evD0jQLzmoUP1s=;
        b=VxYSKk24GHJsMNvs7oJAwr6QRckxNtadTTQHX4bSlRtnLGhxT1yliszYsne+z0Wuje
         yN1q5eQwpdFKAda0AUFt82iKVlxYBcAeOk57OA9CiKmLwyZNBMxSQsgfttKwMc+8LtcS
         GMOxKi74kXpLKPUnoqOkwGwxi04VLI3nZuxd7M/wFt48bfvBWUiRmp1qFmsfYIPuLSGS
         TAbox2SEWHTYSzwxr/HJ6iJq3euO73CFUsYHJprIZq5ceCAC2fQNy7ntwQtk7lYBKZg3
         GAmc15Y9TUwaAUv4hhuTtVYQaJpmdls+LjECtWmCX6/M6jDl5MayFXxwmH2zaDBwT7xT
         zgmQ==
X-Forwarded-Encrypted: i=1; AJvYcCXHStn0KFCHp9DixCqhgBLAdXmI8awiKEOGZy3bqiDUsqYIv/r1KR/p0dIqcnOx3remhfYOHzM3Al7qXO8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSsqfgbDJ9G4Coy+Hk0aB8wy2GNlCk/xS/0jPXtEQNjKMyOus3
	2Rl4yvL+R2uhE8fgtsQTnZIDZ3CvduPfaKnM01fdw7X1VikP4uKZ5Ph7VaIX3H8j86PXIkhU/tu
	rOLh5RCu0sRCsK0RWn+qNtdpIrs/a/yfxvRU/ej+otpKPsXqfcIYDLHyG6QfNoy3CebQi1lLXi7
	ZrLLq75DEmrran42vlxhjmZbli3AMFNWLulV77MY51fXGBK2ORIw==
X-Gm-Gg: ASbGncsjX/Dc4xEMygudlG8HsbyIPdPljW5aKH4f3+segVh/OFM0xTin6668VyHJtgh
	J6RYwnesJJuzw9fFWhDg/0/NyXRGXvWKWDy1ja9tRki99DMNRsgnfRipYx5fevVnIidwyi447vs
	IscwsFcju/0ZIhtEof/1NjvdmMZ9wJ5JzXe7NBMGwEdeetLSvNmGqj/qL5rcLeyyZkV47IgBXZ6
	UUGulQgudPdW3Esxb8hNq31dTFlsWpFyWiM1/sMH9fhr52rjEFEK99IjXAVgFUVwxs9aZkgXUcd
	QDXsl6zJDhn5dg/mGxl3iORMDfm2g1XYyWkROpiEoF/g37aYg4M6qSI99/+BxomGynjF+v/i2nj
	AANfaium8wNOS/i1yh9DV0C2j
X-Received: by 2002:a05:6000:2309:b0:3b5:dc05:79b with SMTP id ffacd0b85a97d-3b60e4d0099mr17510110f8f.14.1753097136991;
        Mon, 21 Jul 2025 04:25:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE5qjUcgwoUH6h4Cn4yr43tPmB+jCm/2PCqBM5MSc3alqUkCaGQZXjrejWnZx0uQHpJY37V7A==
X-Received: by 2002:a05:6000:2309:b0:3b5:dc05:79b with SMTP id ffacd0b85a97d-3b60e4d0099mr17510072f8f.14.1753097136525;
        Mon, 21 Jul 2025 04:25:36 -0700 (PDT)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-135-146.abo.bbox.fr. [213.44.135.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4562e89c87esm155841815e9.33.2025.07.21.04.25.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 04:25:35 -0700 (PDT)
From: Valentin Schneider <vschneid@redhat.com>
To: Vincent Guittot <vincent.guittot@linaro.org>, Huang Shijie
 <shijie@os.amperecomputing.com>
Cc: mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
 patches@amperecomputing.com, cl@linux.com,
 Shubhang@os.amperecomputing.com, dietmar.eggemann@arm.com,
 rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] sched/fair: do not scan twice in detach_tasks()
In-Reply-To: <CAKfTPtC7+V6ubaGDPy0MW2MFG7w_yrnYCPQ-b2=3uYgeM+-+EA@mail.gmail.com>
References: <20250721023939.19703-1-shijie@os.amperecomputing.com>
 <CAKfTPtC7+V6ubaGDPy0MW2MFG7w_yrnYCPQ-b2=3uYgeM+-+EA@mail.gmail.com>
Date: Mon, 21 Jul 2025 13:25:34 +0200
Message-ID: <xhsmhv7nleqfl.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 21/07/25 11:40, Vincent Guittot wrote:
> On Mon, 21 Jul 2025 at 04:40, Huang Shijie
> <shijie@os.amperecomputing.com> wrote:
>>
>> detach_tasks() uses struct lb_env.loop_max as an env.src_rq->cfs_tasks
>> iteration count limit. It is however set without the source RQ lock held,
>> and besides detach_tasks() can be re-invoked after releasing and
>> re-acquiring the RQ lock per LBF_NEED_BREAK.
>>
>> This means that env.loop_max and the actual length of env.src_rq->cfs_tasks
>> as observed within detach_tasks() can differ. This can cause some tasks to
>
> why not setting env.loop_max only once rq lock is taken in this case ?
>
> side note : by default loop_max <= loop_break
>

I thought so too and dismissed that due to LBF_NEED_BREAK, but I guess we
could still do something like:

---
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index b9b4bbbf0af6f..eef3a0d341661 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -11643,6 +11643,7 @@ static int sched_balance_rq(int this_cpu, struct rq *this_rq,
 		.dst_grpmask    = group_balance_mask(sd->groups),
 		.idle		= idle,
 		.loop_break	= SCHED_NR_MIGRATE_BREAK,
+		.loop_max       = UINT_MAX,
 		.cpus		= cpus,
 		.fbq_type	= all,
 		.tasks		= LIST_HEAD_INIT(env.tasks),
@@ -11681,18 +11682,19 @@ static int sched_balance_rq(int this_cpu, struct rq *this_rq,
 	/* Clear this flag as soon as we find a pullable task */
 	env.flags |= LBF_ALL_PINNED;
 	if (busiest->nr_running > 1) {
+more_balance:
 		/*
 		 * Attempt to move tasks. If sched_balance_find_src_group has found
 		 * an imbalance but busiest->nr_running <= 1, the group is
 		 * still unbalanced. ld_moved simply stays zero, so it is
 		 * correctly treated as an imbalance.
 		 */
-		env.loop_max  = min(sysctl_sched_nr_migrate, busiest->nr_running);
-
-more_balance:
 		rq_lock_irqsave(busiest, &rf);
 		update_rq_clock(busiest);
 
+
+		env.loop_max = min3(env.loop_max, sysctl_sched_nr_migrate, busiest->h_nr_running);
+
 		/*
 		 * cur_ld_moved - load moved in current iteration
 		 * ld_moved     - cumulative load moved across iterations


