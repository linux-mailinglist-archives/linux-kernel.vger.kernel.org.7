Return-Path: <linux-kernel+bounces-651545-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 169FAAB9FE5
	for <lists+linux-kernel@lfdr.de>; Fri, 16 May 2025 17:32:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35CD93B4AC4
	for <lists+linux-kernel@lfdr.de>; Fri, 16 May 2025 15:31:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A45B21B87C0;
	Fri, 16 May 2025 15:32:06 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14E5414A639;
	Fri, 16 May 2025 15:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747409526; cv=none; b=PkQSFqrIbWsGjyJ13Hq41mCp0nM1Ij8fiE9wwYXPd92aDhu0hBpmRZnsyJ/e19TlPjvXDCROMaa7V2upavVJBq18W10m5d5t+qRbix+M50RXyXz/Ygh2QIgYH1wE1Q07jyG2Bu9EURDR8eknGdMucRZNvTtRqjEIclw1DDXYI34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747409526; c=relaxed/simple;
	bh=UGQd2vpEGtZoNWxqSs0iTpV6XWH9Pxv+t8tsGF8k1Ug=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p2gvZgtte6QaSrnJ4zHVZCfhIOYTUGYjJxYYZz36telj7MPIrhXcOiGhkpdEkTdCHNZfNo4yWeyKxVqKigrZ+DG7My6OzsZ7J3muh/L70Bz5g7NBOAB9wJHtvUU0AAWKi3CDnmqVCvpUYs9/ECoSbPFRhF2L1SXB9VlqqY859uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 338B6169C;
	Fri, 16 May 2025 08:31:51 -0700 (PDT)
Received: from localhost (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C36823F673;
	Fri, 16 May 2025 08:32:02 -0700 (PDT)
Date: Fri, 16 May 2025 16:31:58 +0100
From: Leo Yan <leo.yan@arm.com>
To: Ian Rogers <irogers@google.com>, Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	James Clark <james.clark@linaro.org>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf tests switch-tracking: Fix timestamp comparison
Message-ID: <20250516153158.GH412060@e132581.arm.com>
References: <20250331172759.115604-1-leo.yan@arm.com>
 <CAP-5=fVsgahBhOEOac52PmL0V+n1jqAxzf7n9PVWgWsxq9TvgQ@mail.gmail.com>
 <20250401091422.GA115840@e132581.arm.com>
 <CAP-5=fUGLy9xGmMO+6PXvfviB4U8Q8O7H3iTSSqEf72vin8gDA@mail.gmail.com>
 <20250402090516.GG115840@e132581.arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250402090516.GG115840@e132581.arm.com>

Hi Ian, Namhyung,

[ - Mailing list ]

On Wed, Apr 02, 2025 at 10:05:16AM +0100, Leo Yan wrote:
> On Tue, Apr 01, 2025 at 12:54:12PM -0700, Ian Rogers wrote:
> > On Tue, Apr 1, 2025 at 2:14 AM Leo Yan <leo.yan@arm.com> wrote:
> > >
> > > On Mon, Mar 31, 2025 at 01:18:31PM -0700, Ian Rogers wrote:
> > >
> > > [...]
> > >
> > > > I'm reminded of a Java check I wrote for this:
> > >
> > > Nice short article.
> > >
> > > > In clang -Wshorten-64-to-32 looks to cover this. I'll see if we can
> > > > clean those warnings up a bit.
> > >
> > > I checked a bit and seems GCC has no this flag, but it makes sense for
> > > me to enable the flag for Clang.
> > >
> > > > Reviewed-by: Ian Rogers <irogers@google.com>
> > >
> > > Thanks a lot, Ian.
> > 
> > I made a small variation to the change in:
> > https://lore.kernel.org/lkml/20250401182347.3422199-10-irogers@google.com/
> > to avoid a subtract and just directly compare the values.

Do you mind to pick up my this patch? :) Our internal CI reports the
test case 109_Track_with_sched_switch failure daily, I am just wandering
if we could apply the fix quickly.

Ian is working on a patch series for resolving the Clang warning which
also includes a fix [1], if Ian could extract the fix for the compar()
function in switch-tracking.c, this either would be fine for me.

Thanks a lot for your helping!

Leo

[1] https://lore.kernel.org/linux-perf-users/20250401182347.3422199-10-irogers@google.com/

