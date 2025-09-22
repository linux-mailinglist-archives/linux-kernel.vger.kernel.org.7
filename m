Return-Path: <linux-kernel+bounces-827149-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F2C7B9070C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 13:38:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D82C189CAB4
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 11:39:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C64C304BB7;
	Mon, 22 Sep 2025 11:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="hT3Tu5Ky"
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F80A29E0E5
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 11:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758541125; cv=none; b=FN5ItKEjiOIBzk6MBtXIaOVWWymaUTYeAGdVcWeoKZBuh8fZoJq1nbELSpV9jP+dv+I2836uCzapjaCp7BZWRfXr+WTjEHTPLeovY5+jtVRw2M9n/6H8YUWcTDsSoj5PqQBae++ByqYsnU28JcgrskVlKFche6CIrLa3LsRQCDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758541125; c=relaxed/simple;
	bh=ITlm86vMs8DjHgTB9CjE8JmKls4bgfQR0669KLbBxCA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EEmLIohEj+sEey6ESPRcs76IuAJr1LOtKgTCTVqgu8s7Vy8HtViUKaxu0d/qXpW6hUvoAiNkzghTTKYAqxSPubXMX6sLK2Gwf0qcQPto1lqJ9Mdi5ETUbd07Szx5TVV5Zhc8BIDkhWp50wzqV5dzVxhsZlKJRnWOHCiGyJSrSdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=hT3Tu5Ky; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <b31a538a-c361-4e3e-a5b6-6a3d2083ef3b@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1758541116;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rl3K3oWIzrxr0ibFAWHd+9Y5/LZoWqU9Plfysm+UJCs=;
	b=hT3Tu5KysY5QZvrrVX5h5gMMKiRLiZw86XKW6DpNh2R2dfc7K8cSoBypDWGNK2Mbe5ciTE
	/5qUTOSetyGsSPXm3U5goksf8rz2gDnObf+4cthMviOzXYPFBZkJGTSi3BfregRZk7jLKE
	bQXNGDsNXcroSk3+woDRvIkP9uypmac=
Date: Mon, 22 Sep 2025 19:38:21 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 0/3] Suppress undesirable hung task warnings.
Content-Language: en-US
To: Julian Sun <sunjunchao@bytedance.com>, mhiramat@kernel.org
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
 mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
 vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org,
 bsegall@google.com, mgorman@suse.de, vschneid@redhat.com,
 akpm@linux-foundation.org, agruenba@redhat.com, hannes@cmpxchg.org,
 mhocko@kernel.org, roman.gushchin@linux.dev, shakeel.butt@linux.dev,
 muchun.song@linux.dev, linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <20250922094146.708272-1-sunjunchao@bytedance.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Lance Yang <lance.yang@linux.dev>
In-Reply-To: <20250922094146.708272-1-sunjunchao@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

Hi Julian

Thanks for the patch series!

On 2025/9/22 17:41, Julian Sun wrote:
> As suggested by Andrew Morton in [1], we need a general mechanism
> that allows the hung task detector to ignore unnecessary hung

Yep, I understand the goal is to suppress what can be a benign hung task
warning during memcg teardown.

> tasks. This patch set implements this functionality.
> 
> Patch 1 introduces a PF_DONT_HUNG flag. The hung task detector will
> ignores all tasks that have the PF_DONT_HUNG flag set.

However, I'm concerned that the PF_DONT_HUNG flag is a bit too powerful
and might mask real, underlying hangs.

> 
> Patch 2 introduces wait_event_no_hung() and wb_wait_for_completion_no_hung(),
> which enable the hung task detector to ignore hung tasks caused by these
> wait events.

Instead of making the detector ignore the task, what if we just change
the waiting mechanism? Looking at wb_wait_for_completion(), we could
introduce a new helper that internally uses wait_event_timeout() in a
loop.

Something simple like this:

void wb_wait_for_completion_no_hung(struct wb_completion *done)
{
         atomic_dec(&done->cnt);
         while (atomic_read(&done->cnt))
                 wait_event_timeout(*done->waitq, 
!atomic_read(&done->cnt), timeout);
}

The periodic wake-ups from wait_event_timeout() would naturally prevent
the detector from complaining about slow but eventually completing 
writeback.

> 
> Patch 3 uses wb_wait_for_completion_no_hung() in the final phase of memcg
> teardown to eliminate the hung task warning.
> 
> Julian Sun (3):
>    sched: Introduce a new flag PF_DONT_HUNG.
>    writeback: Introduce wb_wait_for_completion_no_hung().
>    memcg: Don't trigger hung task when memcg is releasing.
> 
>   fs/fs-writeback.c           | 15 +++++++++++++++
>   include/linux/backing-dev.h |  1 +
>   include/linux/sched.h       | 12 +++++++++++-
>   include/linux/wait.h        | 15 +++++++++++++++
>   kernel/hung_task.c          |  6 ++++++
>   mm/memcontrol.c             |  2 +-
>   6 files changed, 49 insertions(+), 2 deletions(-)
> 


