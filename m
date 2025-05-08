Return-Path: <linux-kernel+bounces-640412-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 36192AB045A
	for <lists+linux-kernel@lfdr.de>; Thu,  8 May 2025 22:11:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C14B31C06645
	for <lists+linux-kernel@lfdr.de>; Thu,  8 May 2025 20:12:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0385D28A73F;
	Thu,  8 May 2025 20:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PEa+Tns7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C1F229A0;
	Thu,  8 May 2025 20:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746735110; cv=none; b=XbwD/iDD5/MxIr/jPOIthKDt2g7WEPx3R59KAPkMD9Odym6eVv79OYa4jAKfLAGoy+2cYyvtdB7i4+RGZcSs3bi/W7Is0T5Q++ZWeSai/qzcdNd8jSjjTvaUoxnWVJ7TXvKZtl+/QhhPVZWDHsY07zryHbspkeJVLQiwfvntFR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746735110; c=relaxed/simple;
	bh=75zDtEacdz5lgQTje2kqGv4vmTwjjiHTeNicGqkB7Mc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ibrySwKcDGAdF2qEq26gChXO+Aii7SqZjPzr6WVMAzQHhai08nv2g3Fx37Nku3qJbhr/SWW1WPCH1xbVsxdk1pUxKzECME7BgqMlTDnb8yJup6ZhXeG0H/hbJ9Vn4av4CpO0jnNiN8FLRybBLssB3+TzmwkNOWg4sasKkYCkw0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PEa+Tns7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68B77C4CEE7;
	Thu,  8 May 2025 20:11:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746735110;
	bh=75zDtEacdz5lgQTje2kqGv4vmTwjjiHTeNicGqkB7Mc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PEa+Tns7aurb72cx860klS28E8S0nbOtKysURBPhcizadQy4aSoBMVMmX78897pzu
	 DijQetMT+lDtF057mxYhEPEWuKkkrGbN6jvo20rX92QlWzWEjKDO/ZfYtuOxb+Z3EM
	 Z89skuE59FLT2cw3eFlZuxV6j5rjUmA9bMREksyivy9iS3GOUJhjjF7EEBJfSN0Eer
	 ue/JxD8vV71zkMH7ZU85NWtYHbj9LSWaRYnNgnxnEJJWEJIuuDpNFU/jV0+eoprwQU
	 ReMvTaEoSkR4OPOJY9YgzGjf+hO60VAvFhsQv+Wiu01deTEnjfLomwijZCoGUKzrOr
	 h7IIo1zwXtmLQ==
Date: Thu, 8 May 2025 17:11:45 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] perf trace: Fix some more memory leaks
Message-ID: <aB0QAUw7N9RaeVVO@x1>
References: <20250401202715.3493567-1-irogers@google.com>
 <aBzFGKKubskQDLrs@x1>
 <aBzrkz0__S_eupgB@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aBzrkz0__S_eupgB@google.com>

On Thu, May 08, 2025 at 10:36:19AM -0700, Namhyung Kim wrote:
> On Thu, May 08, 2025 at 11:52:08AM -0300, Arnaldo Carvalho de Melo wrote:
> > On Tue, Apr 01, 2025 at 01:27:15PM -0700, Ian Rogers wrote:
> > > The files.max is the maximum valid fd in the files array and so
> > > freeing the values needs to be inclusive of the max value.
> > > 
> > > Add missing thread__put of the found parent thread in
> > > thread__e_machine.
> > 
> > Split it into:
> > 
> > ⬢ [acme@toolbx perf-tools-next]$ git log --oneline -2
> > 7900938850645ed4 (HEAD -> perf-tools-next) perf trace: Add missing thread__put() in thread__e_machine()
> > 8830091383b03498 perf trace: Free the files.max entry in files->table
> > ⬢ [acme@toolbx perf-tools-next]$ 
> > 
> > So that git --oneline is more descriptive, etc.
> > 
> > Thanks, applied to perf-tools-next,
> 
> PTAL this one as well.
> 
> https://lore.kernel.org/r/20250403054213.7021-1-namhyung@kernel.org

Split into two patches, as one fixes one long standing problem (from
2017:

    perf trace: Fix leaks of 'struct thread' in set_filter_loop_pids()
    
    I've found some leaks from 'perf trace -a'.
    
    It seems there are more leaks but this is what I can find for now.
    
    Fixes: 082ab9a18e532864 ("perf trace: Filter out 'sshd' in the tracer ancestry in syswide tracing")

But the other fixes a more recent bug:

    perf trace: Fix leaks of 'struct thread' in fprintf_sys_enter()
    
    I've found some leaks from 'perf trace -a'.
    
    It seems there are more leaks but this is what I can find for now.
    
    Fixes: 70351029b55677eb ("perf thread: Add support for reading the e_machine type for a thread")

- Arnaldo

