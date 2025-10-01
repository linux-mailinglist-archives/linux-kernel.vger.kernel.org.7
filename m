Return-Path: <linux-kernel+bounces-839480-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D3D9BB1B29
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 22:38:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 05A077A215D
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 20:36:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4A52286D44;
	Wed,  1 Oct 2025 20:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="e8GTt6mn"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FC6F1DA62E
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 20:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759351076; cv=none; b=ChEJXtohvrmM9TyvfioaMcvX0iAyTlUaOH5i7yvpAVcDx0Q11MlmP85qU9WbWoaj8YyZFzRtxg5HlVKkYCU0qav8SddQStB8YWSRh+0kmUFVcBrDfoF/KwGgA+WTQXggs9xOiYruXGoaf0RLfhOBvgd8fVpuKhfhDk9GUg6Af4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759351076; c=relaxed/simple;
	bh=Pm4xJTCROelAHqXxEt1c54iBkzqdYlMyM6hLW/ROOlc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nijOfeTZvBwEGo4eYIziRVbAHYvUNRRY6mMADZXakcpEpIUJomPsqSjrMrQVICJqTbLldwsMd7HNkak7W5FD7zRiVXfBWEAsynf845A5P9aICKsCrTkqe+Bk7YmcSQVh8VNbVp0Q46Y8uBbtv+kCnB5Xwm6LdIJ8o4T60cjpipc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=e8GTt6mn; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-781206cce18so265480b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 13:37:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759351074; x=1759955874; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RQNaEZKru4cWIdbGYnxXONNGlwJmrwLuNwmdLJa+R6E=;
        b=e8GTt6mnTMPg4ibJmw39dcksWQptBczbN2x5BnRtv0OgV1wdQNKbkBk0AOKw2MfTFu
         xW8Fl2rbLh8Q+gfUTDOHn0quGq0NTwi2kf0tToKPN74VPJaOY5iSeoEMjxzJVrhYFTV+
         14tpTrUsVwUkLMThvr76WS0gNIEtKeFyx1NgJvOYO5Qmh6nAtW52MIuKAYUeFRzY+MSh
         MzJCu+O1gNJYBOkWSS97prD1knpGcy8ZgwJWCopj5nJa0y1hYDCBzT+NgS0wglrvV6db
         n4IuCw7o/Z1zuOQb+jW1h+Hnu8nx1d+Q/l/ICObmj1Cd9muFTp4IRC0Kar1TAep6h33M
         CGUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759351074; x=1759955874;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RQNaEZKru4cWIdbGYnxXONNGlwJmrwLuNwmdLJa+R6E=;
        b=X7RkcTW5l/nDFjVwD8IhIUoGB9udIM7Xm6cyPJqaaxXSybGS2IEyiC2IFvRLBmyiiQ
         s2RoUE3uETcLZ1OGIbia6HqUta5DYVk71wWYANNnzI5iqLFGNPUB5916ezXU8Ov0rf13
         CYFjPMGkf/g63BFhyhrr9LLr6OQcmHJ84wU69yzx7YuoyNwgLRXJs4iLMphyxLdNGLte
         /nLyjf8FrEhOzBF2QaCKsJFWoZ79/ju7SdAa9UrCSJznQ3Q/CYTPdFv8PXQANeK9GRJf
         lgwvaYEEV8dUjsqe+kJV1q1NQkdX5jHVUBYFzjKv5ubKBxJO7zZ5iUpT1qWrm5Idjj6b
         oZFQ==
X-Forwarded-Encrypted: i=1; AJvYcCXdRxDnEj4kKCjcPQiH5re1v8ne7GKjRISWHmP6VhxjYdzfb6CUdKVBwRJzcUfQilTggdcvK3T0aF9+pIk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzI7gZq1A0INZk0Hfpbl7Y210fEN72Qs1bNMoVoA+ScCQzDJSB7
	BiDkXwt2rX/TUWbUXIGtC816MiYra/sKE42ZFYWsuesuWAdv/L3DIRnKb/Hr3YQvIg==
X-Gm-Gg: ASbGnct56RSQfv/CIYQ0RTOghG44OtKCcj8sKB/cqTIiH5+WRK4j236EQRW2+ybhewp
	AfzustDIbfsJEDHKF/O6J4y9IPo6bJm8tYelYLFBzD6d7gQeGHLKPzX4qmuFb6Cwu3kxYGSnymg
	NQgKZhDF7dNDDIfHJMLCqP5M+gLC4P9ZCSYuIEqP9SpwvDFp3uLmofB0q2R8rw6IR8FurcXGQE6
	fERU148wf/fFzpwtLVIeyd4+y6Q65GPE3UIjM9fgNAci7OBWubh9WM4h1VPq8fEgPqoOlky4BrM
	Nz7O+XP7bcrobzui/jHX6fv3oAexq82qCVAO3I5QoA4aLZotGdUnB2ZNxRHWvdmyhm3NGkzVELN
	kZbK4vUjXtqGs0hjuZXEFyUIxhOIZ+rOvttVogGFSXv0TkiHLR2/0KSOAO0198/ijHtnjz+3oh4
	mkIamixth7/TPAYRZwBDIFoI3dz8c=
X-Google-Smtp-Source: AGHT+IFFwRc18lvBjFwVcmOzO4MrdzagaspJbIh34n/XPx8DTabMIo+LE6fs6m4sJIJkIwB8ey7NLw==
X-Received: by 2002:a05:6a21:99a3:b0:309:48d8:cf1d with SMTP id adf61e73a8af0-32a22b279b7mr979781637.18.1759351073606;
        Wed, 01 Oct 2025 13:37:53 -0700 (PDT)
Received: from bsegall-glaptop.localhost ([2a00:79e0:2efc:9:e111:d068:1c5f:f79a])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-78b020749b6sm529186b3a.78.2025.10.01.13.37.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Oct 2025 13:37:53 -0700 (PDT)
From: Benjamin Segall <bsegall@google.com>
To: Aaron Lu <ziqianlu@bytedance.com>
Cc: K Prateek Nayak <kprateek.nayak@amd.com>,  Ingo Molnar
 <mingo@redhat.com>,  Peter Zijlstra <peterz@infradead.org>,  Juri Lelli
 <juri.lelli@redhat.com>,  Vincent Guittot <vincent.guittot@linaro.org>,
  Matteo Martelli <matteo.martelli@codethink.co.uk>,
  linux-kernel@vger.kernel.org,  Dietmar Eggemann
 <dietmar.eggemann@arm.com>,  Steven Rostedt <rostedt@goodmis.org>,  Mel
 Gorman <mgorman@suse.de>,  Valentin Schneider <vschneid@redhat.com>
Subject: Re: [PATCH] sched/fair: Start a cfs_rq on throttled hierarchy with
 PELT clock throttled
In-Reply-To: <20250926093801.GE120@bytedance> (Aaron Lu's message of "Fri, 26
	Sep 2025 17:38:01 +0800")
References: <e2e558b863c929c5019264b2ddefd4c0@codethink.co.uk>
	<20250926081918.30488-1-kprateek.nayak@amd.com>
	<20250926093801.GE120@bytedance>
Date: Wed, 01 Oct 2025 13:37:50 -0700
Message-ID: <xm26plb6icip.fsf@google.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Aaron Lu <ziqianlu@bytedance.com> writes:

> BTW, I'm thinking in propagate_entity_cfs_rq(), we shouldn't check the
> ancestor cfs_rq's pelt clock throttled status but only the first level
> cfs_rq's, because the purpose is to have the first level cfs_rq to stay
> on the leaf list and all those list_add_leaf_cfs_rq() for its ancestors
> are just to make sure the list is fully connected. I mean something like
> this:
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 75c615f5ed640..6a6d9200ab93c 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -13170,6 +13170,7 @@ prio_changed_fair(struct rq *rq, struct task_struct *p, int oldprio)
>  static void propagate_entity_cfs_rq(struct sched_entity *se)
>  {
>  	struct cfs_rq *cfs_rq = cfs_rq_of(se);
> +	bool add = !cfs_rq_pelt_clock_throttled(cfs_rq);
>  
>  	/*
>  	 * If a task gets attached to this cfs_rq and before being queued,
> @@ -13177,7 +13178,7 @@ static void propagate_entity_cfs_rq(struct sched_entity *se)
>  	 * change, make sure this cfs_rq stays on leaf cfs_rq list to have
>  	 * that removed load decayed or it can cause faireness problem.
>  	 */
> -	if (!cfs_rq_pelt_clock_throttled(cfs_rq))
> +	if (add)
>  		list_add_leaf_cfs_rq(cfs_rq);
>  
>  	/* Start to propagate at parent */
> @@ -13188,7 +13189,7 @@ static void propagate_entity_cfs_rq(struct sched_entity *se)
>  
>  		update_load_avg(cfs_rq, se, UPDATE_TG);
>  
> -		if (!cfs_rq_pelt_clock_throttled(cfs_rq))
> +		if (add)
>  			list_add_leaf_cfs_rq(cfs_rq);
>  	}
>
> But this is a different thing and can be taken care of if necessary
> later. Current logic doesn't have a problem, it's just not as clear as
> the above diff to me.

So the question is if we need to call list_add_leaf_cfs_rq in cases
where the immediate cfs_rq clock was stopped but the parents might not
have. It certainly doesn't seem to me like it should be necessary, but
I'm insufficiently clear on the exact details of the leaf_cfs_rq list
to swear to it.

