Return-Path: <linux-kernel+bounces-855795-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BF4ABE258D
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 11:23:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D08623AD21E
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 09:23:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76B2A30FC33;
	Thu, 16 Oct 2025 09:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="GOzOcIeO"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ACAB325496
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 09:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760606592; cv=none; b=l10PpRl/heBMhvEXzK2gWkjRfnBmeX1ajWxgebJj2k1KAHSNN02ak7kfGV0NK3Lp/KgfHYWsZBP56toCf2K568EYBYvmRTjZmkyCi/v/c5JrP7efJSwSqt4U5NIYoV9iZ+xOBNEus2qtLU07tfukWFK/VxwjwHnNO66NXV7pwOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760606592; c=relaxed/simple;
	bh=0g2ALJv08WfR9TQvI4tM6CEuCmzbWTJKnoTOooQNnxs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PjDEXRgaVVTKVW/jSyhdWcMrFAG8ZTL00z2lo0ClR7SNHPzEzIKU+eUdviIGoHF7dCNLQ8ZbW5w8e4+nrafIyy2y+8cTnW9tG/Sn7LpGlbUC/NyZSNQ+kaMDKp5xQ0poOyZ+jupk+3/evmLICOhF2od9aQN+0BqWnrE7O/A5lM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=GOzOcIeO; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-29091d29fc8so6094825ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 02:23:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1760606589; x=1761211389; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uQ2pNXn44VLO4HvAI5EnYGbS5HTH9KlTErGULIEWzuE=;
        b=GOzOcIeOQQT2SGFZgTaQ+J5+TRg4hfHlNeC7Heh1d4sqDU2cff9FB3ZJgwvl9UnZjc
         1XY5BaaBI3YFY8rP8B9hWdEWGyBrA9rfiPI2nLprcNmQFUSy2oCWeSyLAh1ZVEY9nLv9
         OXv+GKoySwUDp/ipidxajg+pPIawXKFKcTfGrfVO5jlDwFgIreZWANBcahdGaAdjJBXU
         dbtdzz2L2TiN5ljf0JNipb6of/MF3LU2Z0pwjHRlI/DxdrjNxm2eA61RQDTGW3fc91Nl
         Sy+zkSV69z4uB/G2/yGbWYaYamkyGABa/Dnqu+iEetiKPfb6RAEg/C0rxCXoFeoOk6d+
         as7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760606589; x=1761211389;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uQ2pNXn44VLO4HvAI5EnYGbS5HTH9KlTErGULIEWzuE=;
        b=kanCQxvdQN1ijCGMvQ2zQW2ggZuCfbcwZ2LL6EadoqHklsnKLMNajIuG1QegvXTIs/
         LQWK9AlMbv1A/WSh5zXyXZhxezqEUSf5VSJ7//WS6rxzbxjpP1hTprC1M/ewrd/DXL3B
         1b54ozrtCc0TUwiKwEjjD4bydsoBEJiaR83oD+E9QEZsdSfvfxRpQS02hX37M62qT/me
         cwzFB5qtrBv6H7RTqVnYfz13UL5CooFMm7jdnXeCmCjSewUFzlVJMUnnyGvdRMm8wY7V
         NrSsCdIvecY8ZuqzfgfdhvzdzvCSVKAZPh3dYeu3STUT4/4wzedjFzcer5lx7DT/yHdV
         n17A==
X-Forwarded-Encrypted: i=1; AJvYcCXwWbgYSQcBAtphfpyRZw6mVWl6j++1eklcUqauClVt29fw6w/mEdOdUQwMs99wHxX8OXTCya44u1rk4rY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFnRQzyGn4OWYn7FzzDdo6mYba8ynPod2py+U85mNy5eIs/mCv
	EuP7CkBdEHDHKzqNurNeO5hMdkOQayyF0s5Kz2ltNvo3lFSTfUXmixKyPSsiQIIJVQ==
X-Gm-Gg: ASbGncs30GGbvSXTdNvPwRwuhhzwmX56hOV2U054HI8kLcNjoooTie1CxkhF3iPg3En
	JKHtLidWzbk6IXG8YK+WXOWxYZYdNo00kA6wXQK910WFKrh6u5EZ+XGFC1V+XUivaKW2f8UJuKI
	1O2V3Jr6FPJSUlSVlCZfPcEK8KVTRB/RTobdoOVLWEgOWpFYiFbzqz3g8urU6lGdV1iwbSLX4/f
	hmLA3uh9aUdc0Mlmr/ZQsPcs75vWKDqYEpdmXhtZdVZCNyuo4jkjcgJ0XqN0RB2nexMcHUz7vh0
	fPRb9+OE/WtABMtqMHwbHRuOAkWDcS2rtpvtPDFBTfHWj+YdqRTShs0zvQSSwh8//4YZOIOsr6B
	601qoZN7rwonALQb1PPyrcftZnLKMgOK7mX6/tXCghBo+WmRhxkLNFHAGun0Lp9rbaqzIWte+8+
	pXCC1Lcf6boHqn0SGVk8lwo/UINQ==
X-Google-Smtp-Source: AGHT+IE06Za2GkbVaT3yedLLN1TfcqNW6xvRNpCqh4QjhJzjXvilBzZnVIJjEOx1QcmkNHao5XAqxw==
X-Received: by 2002:a17:902:d58f:b0:290:2735:7285 with SMTP id d9443c01a7336-2902735728emr405449515ad.47.1760606589350;
        Thu, 16 Oct 2025 02:23:09 -0700 (PDT)
Received: from bytedance ([61.213.176.56])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2909930a92bsm23413755ad.10.2025.10.16.02.23.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 02:23:08 -0700 (PDT)
Date: Thu, 16 Oct 2025 17:23:00 +0800
From: Aaron Lu <ziqianlu@bytedance.com>
To: Hao Jia <jiahao.kernel@gmail.com>
Cc: Valentin Schneider <vschneid@redhat.com>,
	Ben Segall <bsegall@google.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
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
	Chen Yu <yu.c.chen@intel.com>,
	Matteo Martelli <matteo.martelli@codethink.co.uk>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH] sched/fair: Prevent cfs_rq from being unthrottled with
 zero runtime_remaining
Message-ID: <20251016092300.GB32@bytedance>
References: <20251014090728.GA41@bytedance>
 <84382429-02c1-12d5-bdf4-23e880246cf3@gmail.com>
 <20251014115018.GC41@bytedance>
 <ded8b9bf-c9bb-8a41-541d-1bef354e4296@gmail.com>
 <20251015025154.GA35@bytedance>
 <4902f7d4-c6ee-bc29-dd7f-282d19d0b3b2@gmail.com>
 <20251015084045.GB35@bytedance>
 <6bcc899c-a2a5-7b77-dcff-436d2a7cc688@gmail.com>
 <20251016065438.GA32@bytedance>
 <ff16098b-00ff-80ee-5130-f1327b0af17d@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ff16098b-00ff-80ee-5130-f1327b0af17d@gmail.com>

On Thu, Oct 16, 2025 at 03:49:15PM +0800, Hao Jia wrote:
> 
> Hi Aaron,
> 
> On 2025/10/16 14:54, Aaron Lu wrote:
> > On Wed, Oct 15, 2025 at 06:21:01PM +0800, Hao Jia wrote:
> > > On 2025/10/15 16:40, Aaron Lu wrote:
> > ... ...
> > > > Hao Jia,
> > > > 
> > > > Do I understand you correctly that you can only hit the newly added
> > > > debug warn in tg_unthrottle_up():
> > > > WARN_ON_ONCE(cfs_rq->runtime_enabled && cfs_rq->runtime_remaining <= 0);
> > > > but not throttle triggered on unthrottle path?
> > > > 
> > > 
> > > yes. but I'm not sure if there are other corner cases where
> > > cfs_rq->runtime_remaining <= 0 and cfs_rq->curr is NULL.
> > > 
> > 
> > Right, I'm not aware of any but might be possible.
> > 
> > > > BTW, I think your change has the advantage of being straightforward and
> > > > easy to reason about. My concern is, it's not efficient to enqueue tasks
> > > > to a cfs_rq that has no runtime left, not sure how big a deal that is
> > > > though.
> > > 
> > > Yes, but that's what we're doing now. The case described above involves
> > > enqueue a task where cfs_rq->runtime_remaining <= 0.
> > > 
> > > I previously tried adding a runtime_remaining check for each level of task
> > > p's cfs_rq in unthrottle_cfs_rq()/tg_unthrottle_up(), but this made the code
> > > strange and complicated.
> > 
> > Agree that adding a runtime_remaining check for each level in
> > unthrottle_cfs_rq() looks too complex.
> > 
> > So I think you approach is fine, feel free to submit a formal patch.
> > With your change, theoretically we do not need to do those
> > runtime_remaining check in unthrottle_cfs_rq() but keeping that check
> > could save us some unnecessary enqueues, so I'll leave it to you to
> > decide if you want to keep it or not. If you want to keep it, please
> > also change its comments because the current comments will be stale
> > then.
> > 
> 
> Thank you for your suggestion. I'll send a formal patch later.
> 
> I'm also happy for you to submit a patch for the next version. This warning
> needs to be fixed, regardless of the method.

With your change, task enqueue in unthrottle path will not call
check_enqueue_path(), thus the warn on non-empty limbo list in
tg_throttle_down() should not happen, so I suppose we do not need
this patch anymore, no?

> 
> However, I've discovered a minor bug in your current patch.
> 
> In kernel/sched/core.c tg_set_cfs_bandwidth()
> 
> ...
> if (cfs_rq->runtime_enabled && !cfs_rq->throttled) {
>     update_rq_clock(rq);   <----
>     throttle_cfs_rq(cfs_rq);
> }
> ...
> 
> Call update_rq_clock() to avoid the warning about using an outdated rq_clock
> in tg_throttle_down()->rq_clock_pelt().

With the above said, this shouldn't matter anymore but just out of
curiosity: did you notice this by inspecting the code or actually
hitting the warning about using an outdated rq clock?

Per my understanding, most likely: __assign_cfs_rq_runtime() in
throttle_cfs_rq(cfs_rq) will grant 1ns runtime to cfs_rq so it won't
reach tg_throttle_down(). The comment I added above that if condition
is kind of misleading though.

