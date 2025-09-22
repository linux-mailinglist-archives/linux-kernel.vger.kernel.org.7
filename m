Return-Path: <linux-kernel+bounces-827259-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0341AB914BD
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 15:07:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4BC9E2A2C7A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 13:07:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D0B430AAAF;
	Mon, 22 Sep 2025 13:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="b7Xag655"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94737309F09
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 13:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758546433; cv=none; b=UhmLwpPyg1Ciw1f5Z2ErXlkfDNS67zGAOzNGn8KtBn5XjK6/W06eABRV6dkrIM3Tf/1wbrB1rptCvNghGpjxq8PsRBTh9FoRDFHOSeiko2m1RcoYaNNHMh/cSqAUpxuTv+8j84ySvEkMTjHLM28ABytXW0PmIAmEzIK3rJJ2K/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758546433; c=relaxed/simple;
	bh=zv879v8IpLvhbadVbPUjTIXbDPFELh7WD4HC8x/76us=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kHm/5DjmenFTB7UZczHgmSdYP/KmnOnxuAmGFLkLzHtsIK+eu4LeygYzpCj1lyDzsIn2N77ze3lp3JkhvVO5l+rW3/zp90V5WWK7Zt55rp4BnNIjXqzsnnljMVH7UrAKjvz/mZitAXrl5N51KO5BNk+IEIvLMaRMd0Z2TQP7h3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=b7Xag655; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-62fc14af3fbso6433194a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 06:07:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1758546430; x=1759151230; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=V5I0E6zUKzQLaX/EzSWa7WfLXYyAGyIhbG839ROFjSY=;
        b=b7Xag655ujxeaHHd0nYiQRUs9TVEYWKtYCm00NYFkGsKq2edg4tYdqcnkIkyZtxGjO
         tkduQ+yHkBBhUZUWYzNDfE3j/osAwZWmr78spqrMi11jhNo5lVk+hjom8Ue3xz2tbQUu
         UUWp0DMQjf6QGUgbSFUVLquCOA64Jvu/DJzItbpvSLBbCxbr3n9UCqbkTgfSMnHDrZnQ
         ule8MLzVLhbgz6FWT+lyEnb5gWVWjIdFzte8sybPZOVQLFv5u2CkSmw0GAns9C0XbBPg
         SZBO1JQNlIfCkcqJlz0Tlnjdai9MqpHiisDN7igKuPU2g4zPXLmAe4WRCLZaxwN5Cs/m
         8bNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758546430; x=1759151230;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V5I0E6zUKzQLaX/EzSWa7WfLXYyAGyIhbG839ROFjSY=;
        b=duw6SqRl5ucB67Sfpl/RVgwiRROU2kkYdcKrvX4oHpys6n9sSomjPLFckg+mqyB4IQ
         db0yM505gS31wrmScqbbOW9mcGVl04RFyJL9XDy04t1GPg7wVAGOmnuog22n8lKPGH9o
         w0wnh266SO5o4Pj2rBBvxaKdd8GuWcHfVWi0I+ZPHfmxN26MPAFI0rhBAot1/3PLJx4O
         tcfGxmeVsTwSgmAIB373BK7sGM6twJ4S4UAlIHC2WA0FYxJkInceIvFaTN1li6/wYTDI
         R2b6pYZis5lEYNzVEvMuZQ5MDKUY2/jrhI5BWTnDaECvbm8AhAcbQB+A7t74TWC3uoRo
         rFkQ==
X-Forwarded-Encrypted: i=1; AJvYcCWmWDG6RIH8BZdOrt+ss+gNkqD83sNE9sufQug8bWBuEIuUDV6Pw66uu0LDGRyg5iAuObKw7Suo2lebcP4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwyiOpaKjXuRaI0NQCe1XYc9ekBR/dcCNQ12iMyqapaNzHltl9h
	ZntlYjgVWPBfFvkqUCR8nanPrFtGcUCzRNcLaBZLoWhHraGEsDfyH1ICBUnCdPUxd5U=
X-Gm-Gg: ASbGnctWFC8y485+PzLads7bx3Ke7HhEQ+eBXfsy4sx/ACMIvBuL5afzZvE35wggBqo
	7KyCnqTFkLJdUSssgbi3iHM+1lz1GAw1yx4r+sBWMSb3HQYR6s2HqNdM8AztGLQPypgLtqM13+j
	amBZgsDkctknHmKmuaaQOjN5piyC/61YlF6qjkniOG4EpC8uUBeErEt4Nc8uX2sZ+CjVPmytKlt
	NZzs5ntQ3Rw7FsoT2eRurpdtwXYk7GikyU9TirR1c8S6cnXVbxiMcm3LMuxayc8YZMJ+LC0D323
	98gi6aIShZvKRPaBdWtnFB12fczKT2jL0xo8IE1RB5ovyMkQ1FJPvCSGKRYkQICWBjiSAAa/eSh
	K5oIkHu7SCYGXWBVGxCzdGnJPPaHU30n8FA==
X-Google-Smtp-Source: AGHT+IHjQTvK8GvwSXsCGHP+yjQ8SIPT2LP8nwGDGqdQKPBmQ+zHQYGgHfCPA13wqo8OaxL+Zcu3vg==
X-Received: by 2002:a05:6402:5212:b0:634:4d7b:45c2 with SMTP id 4fb4d7f45d1cf-6344d7b4f0bmr1491168a12.0.1758546429819;
        Mon, 22 Sep 2025 06:07:09 -0700 (PDT)
Received: from localhost (109-81-31-43.rct.o2.cz. [109.81.31.43])
        by smtp.gmail.com with UTF8SMTPSA id 4fb4d7f45d1cf-62fa5f4173csm9072355a12.49.2025.09.22.06.07.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 06:07:09 -0700 (PDT)
Date: Mon, 22 Sep 2025 15:07:08 +0200
From: Michal Hocko <mhocko@suse.com>
To: Julian Sun <sunjunchao@bytedance.com>
Cc: cgroups@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk,
	brauner@kernel.org, jack@suse.cz, mingo@redhat.com,
	peterz@infradead.org, juri.lelli@redhat.com,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
	vschneid@redhat.com, akpm@linux-foundation.org,
	lance.yang@linux.dev, mhiramat@kernel.org, agruenba@redhat.com,
	hannes@cmpxchg.org, roman.gushchin@linux.dev,
	shakeel.butt@linux.dev, muchun.song@linux.dev
Subject: Re: [PATCH 0/3] Suppress undesirable hung task warnings.
Message-ID: <aNFJ_EKj4fnRDg1_@tiehlicka>
References: <20250922094146.708272-1-sunjunchao@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250922094146.708272-1-sunjunchao@bytedance.com>

On Mon 22-09-25 17:41:43, Julian Sun wrote:
> As suggested by Andrew Morton in [1], we need a general mechanism 

what is the reference?

> that allows the hung task detector to ignore unnecessary hung 
> tasks. This patch set implements this functionality.
> 
> Patch 1 introduces a PF_DONT_HUNG flag. The hung task detector will 
> ignores all tasks that have the PF_DONT_HUNG flag set.
> 
> Patch 2 introduces wait_event_no_hung() and wb_wait_for_completion_no_hung(), 
> which enable the hung task detector to ignore hung tasks caused by these
> wait events.
> 
> Patch 3 uses wb_wait_for_completion_no_hung() in the final phase of memcg 
> teardown to eliminate the hung task warning.
> 
> Julian Sun (3):
>   sched: Introduce a new flag PF_DONT_HUNG.
>   writeback: Introduce wb_wait_for_completion_no_hung().
>   memcg: Don't trigger hung task when memcg is releasing.
> 
>  fs/fs-writeback.c           | 15 +++++++++++++++
>  include/linux/backing-dev.h |  1 +
>  include/linux/sched.h       | 12 +++++++++++-
>  include/linux/wait.h        | 15 +++++++++++++++
>  kernel/hung_task.c          |  6 ++++++
>  mm/memcontrol.c             |  2 +-
>  6 files changed, 49 insertions(+), 2 deletions(-)
> 
> -- 
> 2.39.5

-- 
Michal Hocko
SUSE Labs

