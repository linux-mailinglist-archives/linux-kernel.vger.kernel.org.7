Return-Path: <linux-kernel+bounces-715945-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A7B03AF7FF7
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jul 2025 20:26:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B82E91CA3415
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jul 2025 18:26:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D30C5184524;
	Thu,  3 Jul 2025 18:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Se93paWq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39C5C28A3F5;
	Thu,  3 Jul 2025 18:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751567111; cv=none; b=rO3sN0DoFc0AJsml1IicdW6N6ySgUTD4yjr49XgchjU/CFpx0KFZNMyxbmimXT78td9KnrltqpOYYwJVcD7kZgUpvx8RsrR3hjLxxCVLo4jIO5Ty7dp284/wMB27KF69oJ0x3KVgJaE7/drhGW6j3g12pp6nPd7UB9liruyq+UM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751567111; c=relaxed/simple;
	bh=WS6pQY4Deiid5WGjxJa0zsOYuwf3wzK0R3Ycaa8XW2U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UZzKH36j8rkorLBt9NhmMaJZ9WObbT56wrSelm+nXc4E7JELelnF6HKXuogbRK4aZJBDwdrUQQvsMyN2H2CdvBq6z+oditWaW3OSMrq4Lw6cjGELfbdw7jzwWl/mzkaOHN7kKySLeefYnTRWiidzICABLC9W09ZF9qZH3DRH0V8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Se93paWq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52D5DC4CEE3;
	Thu,  3 Jul 2025 18:25:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751567110;
	bh=WS6pQY4Deiid5WGjxJa0zsOYuwf3wzK0R3Ycaa8XW2U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Se93paWq0zr7rS+Sv/jaBYYHOxFMNepy6cGso4f6x25kDlluK6iSPEPEiMFJKbiH5
	 vEOSMBsWl3ljxUWjtoTEH5+UYouWyQK0KqXX0iGHGqzphZU8riEEB70zhHkxTYgeiL
	 buvUCDppbxJu9D6vA4IBwfJnbKFXZyuUiUoVOcKZqXTA964pppgEqUtSDp6ssGtNS6
	 +JubvNLZanvx8k3NgupP9lHx2eAdl4PAQ53mjfb8dJuvU0M/ijL2oncL/OKqB+JApe
	 51lLrdLVNcn+kFbOqhBjqPWWWr1IP2cddF0nKZEat+3kb/cjIvzj0tH7ygB2tLarGT
	 f9fdtZIT7J2Tw==
Date: Thu, 3 Jul 2025 11:25:08 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Kan Liang <kan.liang@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCHSET 0/8] perf sched: Fix various memory leaks
Message-ID: <aGbLBKOTAVywiqMd@google.com>
References: <20250703014942.1369397-1-namhyung@kernel.org>
 <CAP-5=fWyb54utMyi0uKj6ek4qBmHmX2Xr9RR=s4o-ek5HdHHnA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fWyb54utMyi0uKj6ek4qBmHmX2Xr9RR=s4o-ek5HdHHnA@mail.gmail.com>

On Wed, Jul 02, 2025 at 08:45:18PM -0700, Ian Rogers wrote:
> On Wed, Jul 2, 2025 at 6:49 PM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > Hello,
> >
> > While running the new perf sched test with ASAN, it fails due to
> > memory leaks.  They comes mostly from missing thread__put() but
> > sometimes it needs to release other data structures.
> >
> > Fix those leaks and add more subcommands to the test.
> 
> Thanks Namhyung, it may be worth adding Fixes tags for the benefit of backports.

I was too lazy to find the commits. ;-p

> 
> Tested-by: Ian Rogers <irogers@google.com>

Thanks for your review and test!
Namhyung


