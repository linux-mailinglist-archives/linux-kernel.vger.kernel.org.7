Return-Path: <linux-kernel+bounces-741688-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 52C74B0E7E6
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 03:05:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1EFF01C871BC
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 01:06:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52CAE156F45;
	Wed, 23 Jul 2025 01:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rhrJrcpx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E87F78F26;
	Wed, 23 Jul 2025 01:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753232740; cv=none; b=LE9EywCjyw812bN72Nu955U8Mwp67GkY4/zMCRi4ke83ErimidHm7SigE6zCwkmHCWDN+xySBfVBADIWQPmNec73TwjOE1Nhu6bM5Pfo28PmX/a0UK6Y4AaNGSrx7KT63bIahoSrPaBwdfairdo33LmFP8WB6JVT0Ixz+Ukv1do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753232740; c=relaxed/simple;
	bh=e2DyZmmSsCT3bMt2g8K8/Y1GL9j82NXslnA1an1SnSY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mzQaay9qV7cowHCSZv9S4s7F7tybS/vWnToDz10GPc81ZD2pXVrFrszSRcjBlj6sPjW34iwdBAABCl/5Uo9pi45CLs9ALEUyxZP4bBO72QNc6HTqG/PPNeoDuyJFqEnUQ9icuEromybH5j9RxleOmENnI6jgNcznsqhrvG8yNrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rhrJrcpx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64A1AC4CEEB;
	Wed, 23 Jul 2025 01:05:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753232740;
	bh=e2DyZmmSsCT3bMt2g8K8/Y1GL9j82NXslnA1an1SnSY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rhrJrcpxZM6pvFEQtZRlMwqaiAeQSTkK/AR6+GQWCxMmbsPCJGvEKjkYp3CDjV0mR
	 JkO2hnI+ClH75XAEXQzehaAKYvYLkWsk1uB5W5XeIXj4QVLiK8LIvjiiAYKuvZADkC
	 K25vnIGNPSWG/fmTN2ro6KZBoCu87Z71SIBKrA8tynwBFB+jV3l0hmowPI3KhHfV3H
	 gyVab42sfid5DIa52gJz4gubuhTAHnO4Vk8dWo1DhxX0fGqR8xAqqb9S4+OI65gtLD
	 3mw8pESVVKFLcZfI/70/0SwdOEqBLSXTQOwxEN5HA4AeW0njsElTANJQTxxJ0z1A6N
	 4yL8HQL8f4KhQ==
Date: Tue, 22 Jul 2025 18:05:38 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: "Falcon, Thomas" <thomas.falcon@intel.com>
Cc: "linux-actions@lists.infradead.org" <linux-actions@lists.infradead.org>,
	"alexander.shishkin@linux.intel.com" <alexander.shishkin@linux.intel.com>,
	"Biggers, Caleb" <caleb.biggers@intel.com>,
	"Hunter, Adrian" <adrian.hunter@intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
	"mingo@redhat.com" <mingo@redhat.com>,
	"irogers@google.com" <irogers@google.com>,
	"kan.liang@linux.intel.com" <kan.liang@linux.intel.com>,
	"mark.rutland@arm.com" <mark.rutland@arm.com>,
	"peterz@infradead.org" <peterz@infradead.org>,
	"Wang, Weilin" <weilin.wang@intel.com>,
	"mani@kernel.org" <mani@kernel.org>,
	"acme@kernel.org" <acme@kernel.org>,
	"afaerber@suse.de" <afaerber@suse.de>,
	"jolsa@kernel.org" <jolsa@kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v1 00/19] Intel TMA 5.1 metrics and event updates
Message-ID: <aIA1YubpL7wpiC0X@google.com>
References: <20250719034515.2000467-1-irogers@google.com>
 <e09bab119c9fb6b0c2b5bcd39c6f2b508445ca37.camel@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e09bab119c9fb6b0c2b5bcd39c6f2b508445ca37.camel@intel.com>

On Tue, Jul 22, 2025 at 06:14:30PM +0000, Falcon, Thomas wrote:
> On Fri, 2025-07-18 at 20:44 -0700, Ian Rogers wrote:
> > Update events from:
> > v1.31 -> v1.33 for alderlake
> > v1.09 -> v1.12 for arrowlake
> > v1.14 -> v1.16 for emeraldrapids
> > v1.10 -> v1.12 for graniterpaids
> > v1.14 -> v1.17 for lunarlake
> > v1.14 -> v1.16 for meteorlake
> > v1.28 -> v1.30 for sapphirerapids
> > 
> > Update TMA 5.0 to 5.1 removing the slots event workaround as the patch series:
> > https://lore.kernel.org/lkml/20250719030517.1990983-1-irogers@google.com/
> > is assumed.

So I'll merge this series after the above patchset.

> > 
> > The patches are generated by:
> > https://github.com/intel/perfmon/blob/main/scripts/create_perf_json.py
> > with pull requests 323 and 324 applied.
> > 
> 
> Hi Ian, metrics tests look good on my alder lake and arrow lake.
> 
> Tested-by: Thomas Falcon <thomas.falcon@intel.com>

Thanks for the test!
Namhyung

> 
> > Ian Rogers (19):
> >   perf vendor events: Update alderlake events/metrics
> >   perf vendor events: Update arrowlake events/metrics
> >   perf vendor events: Update broadwell metrics
> >   perf vendor events: Update cascadelakex metrics
> >   perf vendor events: Update emeraldrapids events/metrics
> >   perf vendor events: Update grandridge metrics
> >   perf vendor events: Update graniterapids events/metrics
> >   perf vendor events: Update haswell metrics
> >   perf vendor events: Update icelake metrics
> >   perf vendor events: Update ivybridge/ivytown metrics
> >   perf vendor events: Update jaketown metrics
> >   perf vendor events: Update lunarlake events/metrics
> >   perf vendor events: Update meteorlake events/metrics
> >   perf vendor events: Update rocketlake metrics
> >   perf vendor events: Update sandybridge metrics
> >   perf vendor events: Update sapphirerapids events/metrics
> >   perf vendor events: Update sierraforest metrics
> >   perf vendor events: Update skylake metrics
> >   perf vendor events: Update tigerlake metrics
> > 
> >  .../arch/x86/alderlake/adl-metrics.json       | 104 ++++----
> >  .../pmu-events/arch/x86/alderlake/cache.json  |  99 ++++----
> >  .../arch/x86/alderlake/floating-point.json    |  28 +--
> >  .../arch/x86/alderlake/frontend.json          |  42 ++--
> >  .../pmu-events/arch/x86/alderlake/memory.json |  12 +-
> >  .../pmu-events/arch/x86/alderlake/other.json  |   8 +-
> >  .../arch/x86/alderlake/pipeline.json          | 163 +++++--------
> >  .../x86/alderlake/uncore-interconnect.json    |   2 -
> >  .../arch/x86/alderlake/virtual-memory.json    |  40 +--
> >  .../arch/x86/alderlaken/adln-metrics.json     |  20 +-
> >  .../x86/alderlaken/uncore-interconnect.json   |   2 -
> >  .../arch/x86/arrowlake/arl-metrics.json       | 180 ++++++++------
> >  .../pmu-events/arch/x86/arrowlake/cache.json  | 122 +++++++---
> >  .../arch/x86/arrowlake/frontend.json          |  40 +--
> >  .../pmu-events/arch/x86/arrowlake/memory.json |  22 +-
> >  .../arch/x86/arrowlake/pipeline.json          |  94 +++++---
> >  .../arch/x86/broadwell/bdw-metrics.json       |  30 +--
> >  .../arch/x86/broadwellde/bdwde-metrics.json   |  30 +--
> >  .../arch/x86/broadwellx/bdx-metrics.json      |  33 ++-
> >  .../arch/x86/cascadelakex/clx-metrics.json    | 139 ++++++++---
> >  .../arch/x86/emeraldrapids/cache.json         | 100 ++++----
> >  .../arch/x86/emeraldrapids/emr-metrics.json   | 131 +++++-----
> >  .../x86/emeraldrapids/floating-point.json     |  43 ++--
> >  .../arch/x86/emeraldrapids/frontend.json      |  42 ++--
> >  .../arch/x86/emeraldrapids/memory.json        |  30 +--
> >  .../arch/x86/emeraldrapids/other.json         |  28 ++-
> >  .../arch/x86/emeraldrapids/pipeline.json      | 167 +++++--------
> >  .../arch/x86/emeraldrapids/uncore-memory.json |  82 +++++++
> >  .../x86/emeraldrapids/virtual-memory.json     |  40 +--
> >  .../arch/x86/grandridge/grr-metrics.json      |  20 +-
> >  .../arch/x86/graniterapids/cache.json         | 227 +++++++++++++-----
> >  .../x86/graniterapids/floating-point.json     |  43 ++--
> >  .../arch/x86/graniterapids/frontend.json      |  42 ++--
> >  .../arch/x86/graniterapids/gnr-metrics.json   | 131 +++++-----
> >  .../arch/x86/graniterapids/memory.json        |  33 ++-
> >  .../arch/x86/graniterapids/other.json         |  30 ++-
> >  .../arch/x86/graniterapids/pipeline.json      | 167 ++++++-------
> >  .../arch/x86/graniterapids/uncore-io.json     |   1 -
> >  .../arch/x86/graniterapids/uncore-memory.json |  31 ---
> >  .../x86/graniterapids/virtual-memory.json     |  40 +--
> >  .../arch/x86/haswell/hsw-metrics.json         |  32 ++-
> >  .../arch/x86/haswellx/hsx-metrics.json        |  35 ++-
> >  .../arch/x86/icelake/icl-metrics.json         |  96 ++++----
> >  .../arch/x86/icelakex/icx-metrics.json        | 155 ++++++++----
> >  .../arch/x86/ivybridge/ivb-metrics.json       |  30 +--
> >  .../arch/x86/ivytown/ivt-metrics.json         |  33 ++-
> >  .../arch/x86/jaketown/jkt-metrics.json        |  20 +-
> >  .../pmu-events/arch/x86/lunarlake/cache.json  | 104 ++++++--
> >  .../arch/x86/lunarlake/frontend.json          |  40 +--
> >  .../arch/x86/lunarlake/lnl-metrics.json       | 216 +++++++++--------
> >  .../pmu-events/arch/x86/lunarlake/memory.json |  22 +-
> >  .../arch/x86/lunarlake/pipeline.json          |  85 ++++---
> >  .../x86/lunarlake/uncore-interconnect.json    |  10 +
> >  .../arch/x86/lunarlake/uncore-memory.json     |   8 +
> >  tools/perf/pmu-events/arch/x86/mapfile.csv    |  16 +-
> >  .../pmu-events/arch/x86/meteorlake/cache.json | 129 +++++-----
> >  .../arch/x86/meteorlake/floating-point.json   |  28 +--
> >  .../arch/x86/meteorlake/frontend.json         |  42 ++--
> >  .../arch/x86/meteorlake/memory.json           |  15 +-
> >  .../arch/x86/meteorlake/mtl-metrics.json      | 103 ++++----
> >  .../pmu-events/arch/x86/meteorlake/other.json |   5 +-
> >  .../arch/x86/meteorlake/pipeline.json         | 173 ++++++-------
> >  .../arch/x86/meteorlake/virtual-memory.json   |  40 +--
> >  .../arch/x86/rocketlake/rkl-metrics.json      |  97 ++++----
> >  .../arch/x86/sandybridge/snb-metrics.json     |  19 +-
> >  .../arch/x86/sapphirerapids/cache.json        | 100 ++++----
> >  .../x86/sapphirerapids/floating-point.json    |  43 ++--
> >  .../arch/x86/sapphirerapids/frontend.json     |  42 ++--
> >  .../arch/x86/sapphirerapids/memory.json       |  30 +--
> >  .../arch/x86/sapphirerapids/other.json        |  28 ++-
> >  .../arch/x86/sapphirerapids/pipeline.json     | 167 +++++--------
> >  .../arch/x86/sapphirerapids/spr-metrics.json  | 153 +++++++-----
> >  .../x86/sapphirerapids/uncore-memory.json     |  82 +++++++
> >  .../x86/sapphirerapids/virtual-memory.json    |  40 +--
> >  .../arch/x86/sierraforest/srf-metrics.json    |  20 +-
> >  .../arch/x86/skylake/skl-metrics.json         | 101 +++++---
> >  .../arch/x86/skylakex/skx-metrics.json        | 101 +++++---
> >  .../arch/x86/tigerlake/tgl-metrics.json       |  97 ++++----
> >  78 files changed, 2870 insertions(+), 2325 deletions(-)
> >  create mode 100644 tools/perf/pmu-events/arch/x86/lunarlake/uncore-interconnect.json
> > 
> 

