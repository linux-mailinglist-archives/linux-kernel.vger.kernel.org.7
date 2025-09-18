Return-Path: <linux-kernel+bounces-812914-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CE4A3B53E19
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 23:51:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB3221B23F28
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 21:51:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DF7D2DF137;
	Thu, 11 Sep 2025 21:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ozq+D2C+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FA9C221FC7;
	Thu, 11 Sep 2025 21:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757627457; cv=none; b=RludT40Hbr9N+T/CiD9pYHrbI/sQAyG+OWeqzz7WAYaLJ+60Rg0YZIp0RoUS6bD0XE6XTh4QwdCz7sOYbp0T0p/hTMEQ1LYdv+DVcz62e/MgsYzVanbKoAJ+xMKGJ5SQt6/xIpl5bfpEmBKUEOUFws1tuhfaJQjwXmGxbm53bUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757627457; c=relaxed/simple;
	bh=Hz9e0HFlq+zXEzB/rfvsHu35U4ac6B40wqnCcPyJZIw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=swgGGppc8TRyA0+Q1CcwWAXYdCrgnu+oOxOcrWdL0cn4YcGLAIN0F2nhx2cC0qgL0Ly6CICICmltvD4cSFpuQKLxD82QftDX+EoU8vpDsyChu7qdF9qHqPcNRDDFBJMFBYTUXCObwVx76YWjwN94NhNmLZePGQz9YvWCZookS8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ozq+D2C+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5C9DC4CEF0;
	Thu, 11 Sep 2025 21:50:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757627457;
	bh=Hz9e0HFlq+zXEzB/rfvsHu35U4ac6B40wqnCcPyJZIw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ozq+D2C+V9PZ13HhyI4leB00OvhAlFKEwb8JfjE7gqQ8TRC4xioR5zopXOCuine7l
	 OffQXYToSok7eRxmzL8MML87r7nJpBB41ysbJdnJ4vbk9bq6dstBO8DhoFRROGT4yX
	 jUEjQTYlVG0j7sVkpx58EMsvqvnddZumtndaLehBJbOKTSkGbbrkZHMuw8cC3XBVkm
	 OojFD8oWk2OXdSM3I+aovqX7JgzML+WBjMl2zd97cv/dew/Z8glGEqlHPiyNW0NGrF
	 hGKfHP3xRzeXA3S5r+RAsJPx3vUBxN0iQ/9YmBIT4s4YTmcKLwAPGAfbPW3uc+4vq8
	 aYYy2cxP2clGQ==
Date: Thu, 11 Sep 2025 14:50:55 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	James Clark <james.clark@linaro.org>, Xu Yang <xu.yang_2@nxp.com>,
	Thomas Falcon <thomas.falcon@intel.com>,
	Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, bpf@vger.kernel.org,
	Atish Patra <atishp@rivosinc.com>,
	Beeman Strong <beeman@rivosinc.com>, Leo Yan <leo.yan@arm.com>,
	Vince Weaver <vincent.weaver@maine.edu>
Subject: Re: [PATCH v3 00/15] Legacy hardware/cache events as json
Message-ID: <aMNEP5rMBkq2ODAW@google.com>
References: <20250828205930.4007284-1-irogers@google.com>
 <aMHbIGRFeQlq9ABx@google.com>
 <CAP-5=fXN5oe7tLCnuBnoYKm68GhuMXP00AjszRyPc_XpDkacxQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fXN5oe7tLCnuBnoYKm68GhuMXP00AjszRyPc_XpDkacxQ@mail.gmail.com>

On Wed, Sep 10, 2025 at 02:58:05PM -0700, Ian Rogers wrote:
> On Wed, Sep 10, 2025 at 1:10 PM Namhyung Kim <namhyung@kernel.org> wrote:
> > A nit.  Can we have one actual event and an alias of it?
> >
> > I think 'branch-instructions' will be the actual event and 'branches'
> > will be the alias.  Then the description will be like
> >
> >   branch-instructions
> >       [Retired branch instructions.  Unit: cpu_atom]
> >   ...
> >
> >   branches
> >       [This event is an alias of branch-instructions.]
> >
> > The same goes to 'cycles' and 'cpu-cycles'.
> 
> Similar 'cs' and 'context-switches' in
> tools/perf/pmu-events/arch/common/common/software.json.
> 
> So there are a few different ways to do this:
> 
> 1) In perf list detect two events have the same encoding and list them together.
> 2) In the json have a new aliases list then either:
> 2.1) gets expanded in jevents.py as part of the build,
> 2.2) passes into the pmu-events.c and the C code is updated to use an
> alias list associated with each event.
> 
> Option (1) will have something like quadratic complexity, but a fast
> perf list isn't a particular goal I've heard of.
> Option (2.2) will mean the existing binary searches for events will
> become a binary search for an event and then linear searches through
> the aliases. To make this not a slowdown we'd likely need more lookup
> tables to avoid the linear searches.
> Option (2.1) feels the most plausible. I was hoping the json and the
> sysfs layout would kind of match, this would be true after the
> jevents.py expands the aliases. This option is already kind of already
> done in the legacy cache case as the
> tools/perf/pmu-events/make_legacy_cache.py is making this. We'd still
> need option (1) with this.
> 
> Anyway, I'm not sure these downsides are countered by a slightly
> smaller hardware.json and software.json, or maybe we should just go
> with option 1 if the perf list output is all you care about. Let me
> know if you see a different way of making it happen. I don't think the
> vendors will be particularly happy for their upstream formats to
> change given other tools will rely on them.

Well, I was asking just to update the description in JSON.  I'm not sure
if it's a common problem we need to solve.  Updating a few known aliases
in the hardware and software description would be fine.

Thanks,
Namhyung


