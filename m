Return-Path: <linux-kernel+bounces-799550-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 69A02B42D72
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 01:31:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CDEAA486570
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 23:30:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74FAE277007;
	Wed,  3 Sep 2025 23:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="gYjEgMLd"
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2191F266574
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 23:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756942239; cv=none; b=MV52eY/A8nZnPzxmFCa3FErIZS1b7vK+l6cidlnay2P5QffyhFTQxGvVUiqrccbnOIxx1Ofu253YFTMVXxbLx663E+Q2muj1aKyFUnv3JCbLySVeEedClpHrz24anl0iuA6EeQgePohk7OK/SnW5tio38Uxfwt8nFkGvuBV792I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756942239; c=relaxed/simple;
	bh=9k8cwHFfS6mQi0rNbfS1VSFnFMFfe9G0/khjroNDtY0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=meZRXZ1WXWe8lWOw1UTqmt6osddbUM0e6SPVMAtFsS8U9UbZ/CHNMvwaJyxDsVl88C97XaexTWoLwPmWn45ngdPhw8RO9ywYVlcnENWgdR21BbYJZjEQ0lJ+cD6hWUUTmV6GzvdcUEQ/kImMoqCR3rboQky9qOzcrzvfTC6sN2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=gYjEgMLd; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1756942224;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2gF9nx6eMMapslYLJpUtDnYswISTCfOBidr6oM0KZc8=;
	b=gYjEgMLdGEMiHywRyPh4AwLwNc75TYOydh6kp33yMxnfVzV1BouIN0nxrkTulAYnaG2JBi
	yZsMEjQd92BV97Vi3eqFf0h1TtMm8Dv2xXaojDidujJ3jIoGt98F/++5B/gzwgQ/l0XafC
	yAAYoXegRTtt4lnB867FOPkjVtCwobw=
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Tejun Heo <tj@kernel.org>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,  Martin KaFai Lau
 <martin.lau@linux.dev>,  Kumar Kartikeya Dwivedi <memxor@gmail.com>,
  linux-mm <linux-mm@kvack.org>,  bpf <bpf@vger.kernel.org>,  Suren
 Baghdasaryan <surenb@google.com>,  Johannes Weiner <hannes@cmpxchg.org>,
  Michal Hocko <mhocko@suse.com>,  David Rientjes <rientjes@google.com>,
  Matt Bobrowski <mattbobrowski@google.com>,  Song Liu <song@kernel.org>,
  Alexei Starovoitov <ast@kernel.org>,  Andrew Morton
 <akpm@linux-foundation.org>,  LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 01/14] mm: introduce bpf struct ops for OOM handling
In-Reply-To: <aLeLzWygjrTsgBo8@slm.duckdns.org> (Tejun Heo's message of "Tue,
	2 Sep 2025 14:29:01 -1000")
References: <20250818170136.209169-1-roman.gushchin@linux.dev>
	<20250818170136.209169-2-roman.gushchin@linux.dev>
	<CAP01T76AUkN_v425s5DjCyOg_xxFGQ=P1jGBDv6XkbL5wwetHA@mail.gmail.com>
	<87ms7tldwo.fsf@linux.dev>
	<1f2711b1-d809-4063-804b-7b2a3c8d933e@linux.dev>
	<87wm6rwd4d.fsf@linux.dev>
	<ef890e96-5c2a-4023-bcb2-7ffd799155be@linux.dev>
	<CAADnVQ+LGbXXHHTbBB9b-RjAXO4B6=3Z=G0=7ToZVuH61OONWA@mail.gmail.com>
	<87iki0n4lm.fsf@linux.dev> <aLeLzWygjrTsgBo8@slm.duckdns.org>
Date: Wed, 03 Sep 2025 16:30:16 -0700
Message-ID: <87qzwnxgfr.fsf@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Tejun Heo <tj@kernel.org> writes:

> Hello, Roman. How are you?

Hi Tejun! Thank you for the links...

>
> On Tue, Sep 02, 2025 at 10:31:33AM -0700, Roman Gushchin wrote:
> ...
>> Btw, what's the right way to attach struct ops to a cgroup, if there is
>> one? Add a cgroup_id field to the struct and use it in the .reg()
>> callback? Or there is something better?
>
> So, I'm trying to do something similar with sched_ext. Right now, I only
> have a very rough prototype (I can attach multiple schedulers with warnings
> and they even can schedule for several seconds before melting down).
> However, the basic pieces should may still be useful. The branch is:
>
>  git://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext.git scx-hier-prototype
>
> There are several pieces:
>
> - cgroup recently grew lifetime notifiers that you can hook in there to
>   receive on/offline events. This is useful for initializing per-cgroup
>   fields and cleaning up when cgroup dies:
>
>   https://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext.git/tree/kernel/sched/ext.c?h=scx-hier-prototype#n5469

This is neat, I might use this for the psi struct ops to give a user a
chance to create new trigger(s) if a new cgroup is created.

>
> - I'm passing in cgroup_id as an optional field in struct_ops and then in
>   enable path, look up the matching cgroup, verify it can attach there and
>   insert and update data structures accordingly:
>
>   https://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext.git/tree/kernel/sched/ext.c?h=scx-hier-prototype#n5280

Yeah, we discussed this option with Martin up in this thread. It doesn't
look as the best possible solution, but maybe the best we have at the moment.

Ideally, I want something like this:

void test_oom(void)
{
	struct test_oom *skel;
	int err, cgroup_fd;

        cgroup_fd = open(...);
        if (cgroup_fd < 0)
		goto cleanup;

	skel = test_oom__open_and_load();
        if (!skel)
		goto cleanup;

	err = test_oom__attach_cgroup(skel, cgroup_fd);
	if (CHECK_FAIL(err))
		goto cleanup;

