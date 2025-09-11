Return-Path: <linux-kernel+bounces-812990-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C593DB53F4D
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 01:56:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F2B9A1C238CD
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 23:56:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CEEC2673B7;
	Thu, 11 Sep 2025 23:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="woUpxw0L"
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87B922DC77F
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 23:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757634969; cv=none; b=AoN+dCyhZFnf3xfs1Wo/Lh5+vjE2E9e5muUuOoykADES3UWzxiLdxDeZc5WjaG8vO25C380mH7Iy+6V4nzxv8NZyk2Ow/Z3xlLwXZzGJUxfRJUdH5PfXsDwaGkWh5Ylb9dykq3tl6GOK2/26xTbJWX1ru+1WbxX+UjEyAzaJcyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757634969; c=relaxed/simple;
	bh=2SLqIZvVqTp0Xy3pzV8sZI6v1JFQgoSalXRaoM1+Tmw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=urhw6OHyiqVHElRf2N0Y68Eo4K3fcmoSJHWZl5jNqcPEIxJdX6DKv1PjxEdOWafYWUYfMzJls/lkoUZenmxs+77C2Rju0mTtECdZvGnNl0m1NPV15uTqBtA2fe/BfCcA54NgcAs2FyumqOQaFHtyEkWixegEZKuFmgQ/mdkMNgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=woUpxw0L; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 11 Sep 2025 16:55:55 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1757634962;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=H1syGOpRMTLt/2HES4uKtyZYHkD0JGY65K8XvQf+2yI=;
	b=woUpxw0Lvx2lNuiyEe9jO0AcBG5pByFcVWwU5B0QKOHtZDf9/l2FReWiI5Meepw10iTRjE
	C10QmKSidujzUGJsNRTPnzuwAkv6addj4INaQ1XCPEOxwtQtf6/DQlaA2DC+CXrxZxNprb
	UU8hf4URR+WvcsxU8T34PD0IQyboj+U=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: zhongjinji <zhongjinji@honor.com>
Cc: mhocko@suse.com, rientjes@google.com, akpm@linux-foundation.org, 
	tglx@linutronix.de, liam.howlett@oracle.com, lorenzo.stoakes@oracle.com, 
	surenb@google.com, lenb@kernel.org, rafael@kernel.org, pavel@kernel.org, 
	linux-mm@kvack.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	liulu.liu@honor.com, feng.han@honor.com
Subject: Re: [PATCH v9 1/2] mm/oom_kill: Thaw the entire OOM victim process
Message-ID: <y7hdpmq6smlv2eztltwilmxcvalax63y66ttbckewa6mrk45yl@nu2kv3vtbsxv>
References: <20250910143726.19905-1-zhongjinji@honor.com>
 <20250910143726.19905-2-zhongjinji@honor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250910143726.19905-2-zhongjinji@honor.com>
X-Migadu-Flow: FLOW_OUT

On Wed, Sep 10, 2025 at 10:37:25PM +0800, zhongjinji wrote:
> OOM killer is a mechanism that selects and kills processes when the system
> runs out of memory to reclaim resources and keep the system stable. But the
> oom victim cannot terminate on its own when it is frozen, even if the OOM
> victim task is thawed through __thaw_task(). This is because __thaw_task() can
> only thaw a single OOM victim thread, and cannot thaw the entire OOM victim
> process.
> 
> Also, freezing_slow_path() decides whether a task is an OOM victim by checking
> the task's TIF_MEMDIE flag. When a task is thawed, the freezer bypasses PM
> freezing and cgroup freezing states to thaw it. But TIF_MEMDIE is not a thread
> group shared flag, and only one thread is marked with TIF_MEMDIE. If other
> threads are thawed, they may still remain frozen due to PM freezing and cgroup
> freezing states.
> 
> To solve this, thaw_process() is introduced to thaw all threads of the victim,
> ensuring every thread in the victim process can be thawed. The freezer uses
> tsk_is_oom_victim() to determine whether a task is an OOM victim, because
> tsk->signal->oom_mm is data shared by all threads. This allows all victim threads
> to rely on it to be thawed.
> 
> This change will thaw the entire victim process when OOM occurs,
> ensuring that the oom victim can terminate on its own.
> 
> Signed-off-by: zhongjinji <zhongjinji@honor.com>
> 
> Acked-by: Michal Hocko <mhocko@suse.com>

Acked-by: Shakeel Butt <shakeel.butt@linux.dev>

