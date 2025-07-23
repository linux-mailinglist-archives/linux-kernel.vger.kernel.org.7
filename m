Return-Path: <linux-kernel+bounces-742881-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 71E56B0F7D5
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 18:10:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 49C0E1899C88
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 16:10:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C027D1E47CC;
	Wed, 23 Jul 2025 16:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JeBOIldg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D5EE28DB3;
	Wed, 23 Jul 2025 16:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753287021; cv=none; b=AY8H0+KQs3O/Dk/Ozt+uE75nVjV5Yu6Wo7PM1S97xTZ6mpxtlQP2+YJEaaL0wNhK0ubB1zDhoX8qbIOZWoVLZXHEv2+wE/xiZDAxBP2qLF5UEE22zbHsWcHF7K3lHEqevxuGSBXPO+P/e35kJ6PEXk9/1J/1y6P7KpAbxJ1/ja8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753287021; c=relaxed/simple;
	bh=S2JObOj26Yfdu/cvuIJxmh8ZRRaOuma9ZxsxLZbjwEA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eC3SiylQ8SxeAu7oE+OYAKdPTEF+UbwC4dh48nbgY3cjPMqbWS/WVLU51Ipn/m1lc17eJmZOqPpGX5qslq+1py3s64EfsJAyoO1aH/ZVAxG7QoXWTto2pK991dIYd71ARugpNwQMRVHnAqy9tbF3reSgPVqDZ+vN7RPs3ylm5Xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JeBOIldg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19D6AC4CEE7;
	Wed, 23 Jul 2025 16:10:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753287019;
	bh=S2JObOj26Yfdu/cvuIJxmh8ZRRaOuma9ZxsxLZbjwEA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JeBOIldgf1htqLX7c2u8qG5ZtUhUTdOeceHU76ZHjHAIoNIsbGVk6HqO9CWUuY2vn
	 PKX/aB5dVWKgC/HMlZVwMSs3MuUhSwsrKXEIXLu9bkPD9auX16daW58gtsPywoS2ma
	 0bHtWktfKgDKFMA42PDoRaAIyrl3HwHUsWDrheCoW1sDDoDY1XP3DyGnWOStd/nEtH
	 Sp+i8XO9Vx3tAHXWSpoRSu+zp9KnKpTfzLlT0ysqd9kEQSFBRtRKCm9WPqs+atNAPE
	 NHKtjfMhC6tuXx8uo9nxlt/YBwbuqKgM0USNTZSyd9fqsZWQgLjYLsd5nqk2Z97R06
	 r104UvVpOB8hA==
Date: Wed, 23 Jul 2025 13:10:16 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Namhyung Kim <namhyung@kernel.org>,
	Kan Liang <kan.liang@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v3 5/8] perf annotate: Add --code-with-type support for
 TUI
Message-ID: <aIEJaKDNBor71jIn@x1>
References: <20250716050054.14130-1-namhyung@kernel.org>
 <20250716050054.14130-6-namhyung@kernel.org>
 <CAP-5=fVAYNy9pk9zyQRySrJ-1j12dC9ogiW94133Li_WQHd6RA@mail.gmail.com>
 <aHfg5YPlVD_6iMg6@google.com>
 <CAP-5=fV=E4_9RVvf1CW0GM0VY+ubr8sOvnXc+xhGW66PhMFCnA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP-5=fV=E4_9RVvf1CW0GM0VY+ubr8sOvnXc+xhGW66PhMFCnA@mail.gmail.com>

On Wed, Jul 16, 2025 at 01:42:13PM -0700, Ian Rogers wrote:
> affects sorting. In general I think we should move away from file
> paths, inodes and the like as the build IDs will avoid races, work
> across systems, etc. I think in this case we could add:

<SNIP>

> but in the future we can find the debuginfo off of the build ID and paths, etc.

Yeah, agreed, we better move to make build-id the primary means of
getting what is needed, when that isn't possible, fall back to
filenames.

Then we should check if the hostname in the perf.data header is the same
as the machine running to warn the user about that, other options are to
check the time the perf.data file was created to warn that its likely
updates took place, so take the results with a grain of salt, etc.

If the architecture or distro is different, things we can also see from
the perf.data files, outright refuse to use filenames :-)

- Arnaldo

