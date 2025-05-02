Return-Path: <linux-kernel+bounces-630376-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DF20AA793C
	for <lists+linux-kernel@lfdr.de>; Fri,  2 May 2025 20:21:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DBC281B640A1
	for <lists+linux-kernel@lfdr.de>; Fri,  2 May 2025 18:21:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB329268FCD;
	Fri,  2 May 2025 18:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SEHKmZ3D"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E11431411EB;
	Fri,  2 May 2025 18:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746210088; cv=none; b=aSg8PS2xk9SQonanQWTMzzYXhMtfCDa/YM5UbeSd2G5xSLdYlv+FewNcv5AdyEyA+Y4VAzlDSUzHH/k9DqV7KDXr++mjtuoR4irl/HPZznwNiySQuLMddZIfNQsoCPFa/o/BxB42gFrQBxdNxuxKP0NYXHXnCi2EKomniCiJT5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746210088; c=relaxed/simple;
	bh=k2AnEacsYePeVuRAVIsjGVBr9PJikvSKuHI3JSXnClw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f76DTXpApx+2Xiw55KCS+BY+GEokQ+CfPnq71Ehf/3FF8OEFrZY5768+teuCArqixXeCNRaco/nJCt3Gn1p5J+NmoRjw9BdLif21ZyhCqYzzjzzXwiHW4BneXHqc3CqbLkIrBaK9dl7qvB5h87ozkapLCHJ2+89mg4xlFZYMHm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SEHKmZ3D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA8C9C4CEE4;
	Fri,  2 May 2025 18:21:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746210087;
	bh=k2AnEacsYePeVuRAVIsjGVBr9PJikvSKuHI3JSXnClw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SEHKmZ3DNrn5ysnE4sBg1soNB0ATh8Wbyyb/jplXpYHxyUUNqSj0D9HocUWrCNILs
	 4nW9bruTftQCj5AptGtMZL2MNUDoJPHIjs2gdWmWIKlEdU/4WezMD/Ge0CnQ5yxbRO
	 Fz3hkeAwvQnnYmsv/MrDl8GaD504OHhTg1CslVaMUR2bPgJ4gx7yWREc3x1ozjy55k
	 pqLiijaVKSJ6I3m9odMWRUp7HpGrQYOCxkvOhBiMREsZug4buBpAl9YDPQnihffif3
	 4Sn5Ey8LQP/1mxL2baoc5/eYdCPP8xDs7r5U7kBTG9I4s+Pl0iynrsvOg3y/kKX2PK
	 OZVrNtEIxAFyQ==
Date: Fri, 2 May 2025 11:21:25 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Kan Liang <kan.liang@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Ravi Bangoria <ravi.bangoria@amd.com>, Leo Yan <leo.yan@arm.com>
Subject: Re: [PATCH 08/11] perf hist: Hide unused mem stat columns
Message-ID: <aBUNJQ_XPZs9JsI5@google.com>
References: <20250430205548.789750-1-namhyung@kernel.org>
 <20250430205548.789750-9-namhyung@kernel.org>
 <aBTyYv_yXCPkn2d0@x1>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aBTyYv_yXCPkn2d0@x1>

On Fri, May 02, 2025 at 01:27:14PM -0300, Arnaldo Carvalho de Melo wrote:
> On Wed, Apr 30, 2025 at 01:55:45PM -0700, Namhyung Kim wrote:
> > Some mem_stat types don't use all 8 columns.  And there are cases only
> > samples in certain kinds of mem_stat types are available only.  For that
> > case hide columns which has no samples.
> > 
> > The new output for the previous data would be:
> > 
> >   $ perf mem report -F overhead,op,comm --stdio
> >   ...
> >   #           ------ Mem Op -------
> >   # Overhead     Load  Store  Other  Command
> >   # ........  .....................  ...............
> >   #
> >       44.85%    21.1%  30.7%  48.3%  swapper
> >       26.82%    98.8%   0.3%   0.9%  netsli-prober
> 
> /me curious about this "Other" column.

They are instructions that don't have memory operations.

> 
> Maps to MEM_STAT_OP_OTHER, that comes from mem_stat_index, that comes
> from:
> 
> int mem_stat_index(const enum mem_stat_type mst, const u64 val)
> {
>         union perf_mem_data_src src = {
>                 .val = val,
>         };
> 
>                 int idx = mem_stat_index(hists->mem_stat_types[i],
>                                          mem_info__const_data_src(mi)->val);
> 
> struct mem_info *mi
> 
> 
> union perf_mem_data_src {
>         __u64 val;
>         struct {
>                 __u64   mem_op:5,       /* type of opcode */
>                         mem_lvl:14,     /* memory hierarchy level */
>                         mem_snoop:5,    /* snoop mode */
>                         mem_lock:2,     /* lock instr */
>                         mem_dtlb:7,     /* tlb access */
>                         mem_lvl_num:4,  /* memory hierarchy level number */
>                         mem_remote:1,   /* remote */
>                         mem_snoopx:2,   /* snoop mode, ext */
>                         mem_blk:3,      /* access blocked */
>                         mem_hops:3,     /* hop level */
>                         mem_rsvd:18;
>         };
> };
> 
> As the percentage for "Other" is so high I think some other patch in
> this series will elucidate that :-)

IIUC AMD IBS cannot sample memory instructions specifically.  It'd just
pick random uops/instructions and capture the data.  So it's natural to
see large 'Other' operations on AMD.

> 
> Lemme continue testing...
> 
> - Arnaldo
> 
> >        7.19%    51.7%  13.7%  34.6%  perf
> >        5.81%    89.7%   2.2%   8.1%  qemu-system-ppc
> >        4.77%   100.0%   0.0%   0.0%  notifications_c
> >        1.77%    95.9%   1.2%   3.0%  MemoryReleaser
> >        0.77%    71.6%   4.1%  24.3%  DefaultEventMan
> >        0.19%    66.7%  22.2%  11.1%  gnome-shell
> >        ...
> > 
> > On Intel machines, the event is only for loads or stores so it'll have
> > only one columns like below:
> > 
> >   #            Mem Op
> >   # Overhead     Load  Command
> >   # ........  .......  ...............
> >   #
> >       20.55%   100.0%  swapper
> >       17.13%   100.0%  chrome
> >        9.02%   100.0%  data-loop.0
> >        6.26%   100.0%  pipewire-pulse
> >        5.63%   100.0%  threaded-ml
> >        5.47%   100.0%  GraphRunner
> >        5.37%   100.0%  AudioIP~allback
> >        5.30%   100.0%  Chrome_ChildIOT
> >        3.17%   100.0%  Isolated Web Co
> >        ...
> > 
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > ---
> >  tools/perf/ui/hist.c   | 35 +++++++++++++++++++++++++++++++++--
> >  tools/perf/util/hist.c |  2 ++
> >  tools/perf/util/hist.h |  1 +
> >  3 files changed, 36 insertions(+), 2 deletions(-)
> > 
> > diff --git a/tools/perf/ui/hist.c b/tools/perf/ui/hist.c
> > index 427ce687ad815a62..661922c4d7863224 100644
> > --- a/tools/perf/ui/hist.c
> > +++ b/tools/perf/ui/hist.c
> > @@ -178,6 +178,9 @@ int hpp__fmt_mem_stat(struct perf_hpp_fmt *fmt __maybe_unused, struct perf_hpp *
> >  	for (int i = 0; i < MEM_STAT_LEN; i++) {
> >  		u64 val = he->mem_stat[mem_stat_idx].entries[i];
> >  
> > +		if (hists->mem_stat_total[mem_stat_idx].entries[i] == 0)
> > +			continue;
> > +
> >  		ret += hpp__call_print_fn(hpp, print_fn, fmtstr, 100.0 * val / total);
> >  	}
> >  
> > @@ -405,12 +408,31 @@ static int hpp__header_mem_stat_fn(struct perf_hpp_fmt *fmt, struct perf_hpp *hp
> >  	int ret = 0;
> >  	int len;
> >  	enum mem_stat_type mst = hpp__mem_stat_type(fmt);
> > +	int mem_stat_idx = -1;
> > +
> > +	for (int i = 0; i < hists->nr_mem_stats; i++) {
> > +		if (hists->mem_stat_types[i] == mst) {
> > +			mem_stat_idx = i;
> > +			break;
> > +		}
> > +	}
> > +	assert(mem_stat_idx != -1);
> >  
> > -	(void)hists;
> >  	if (line == 0) {
> >  		int left, right;
> >  
> > -		len = fmt->len;
> > +		len = 0;
> > +		/* update fmt->len for acutally used columns only */
> > +		for (int i = 0; i < MEM_STAT_LEN; i++) {
> > +			if (hists->mem_stat_total[mem_stat_idx].entries[i])
> > +				len += MEM_STAT_PRINT_LEN;
> > +		}
> > +		fmt->len = len;
> > +
> > +		/* print header directly if single column only */
> > +		if (len == MEM_STAT_PRINT_LEN)
> > +			return scnprintf(hpp->buf, hpp->size, "%*s", len, fmt->name);
> > +
> >  		left = (len - strlen(fmt->name)) / 2 - 1;
> >  		right = len - left - strlen(fmt->name) - 2;
> >  
> > @@ -423,10 +445,14 @@ static int hpp__header_mem_stat_fn(struct perf_hpp_fmt *fmt, struct perf_hpp *hp
> >  				 left, graph_dotted_line, fmt->name, right, graph_dotted_line);
> >  	}
> >  
> > +
> >  	len = hpp->size;
> >  	for (int i = 0; i < MEM_STAT_LEN; i++) {
> >  		int printed;
> >  
> > +		if (hists->mem_stat_total[mem_stat_idx].entries[i] == 0)
> > +			continue;
> > +
> >  		printed = scnprintf(buf, len, "%*s", MEM_STAT_PRINT_LEN,
> >  				    mem_stat_name(mst, i));
> >  		ret += printed;
> > @@ -1214,6 +1240,11 @@ int perf_hpp__alloc_mem_stats(struct perf_hpp_list *list, struct evlist *evlist)
> >  		if (hists->mem_stat_types == NULL)
> >  			return -ENOMEM;
> >  
> > +		hists->mem_stat_total = calloc(nr_mem_stats,
> > +					       sizeof(*hists->mem_stat_total));
> > +		if (hists->mem_stat_total == NULL)
> > +			return -ENOMEM;
> > +
> >  		memcpy(hists->mem_stat_types, mst, nr_mem_stats * sizeof(*mst));
> >  		hists->nr_mem_stats = nr_mem_stats;
> >  	}
> > diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
> > index 7759c1818c1ad168..afc6855327ab0de6 100644
> > --- a/tools/perf/util/hist.c
> > +++ b/tools/perf/util/hist.c
> > @@ -354,6 +354,7 @@ static int hists__update_mem_stat(struct hists *hists, struct hist_entry *he,
> >  
> >  		assert(0 <= idx && idx < MEM_STAT_LEN);
> >  		he->mem_stat[i].entries[idx] += period;
> > +		hists->mem_stat_total[i].entries[idx] += period;
> >  	}
> >  	return 0;
> >  }
> > @@ -3054,6 +3055,7 @@ static void hists_evsel__exit(struct evsel *evsel)
> >  
> >  	hists__delete_all_entries(hists);
> >  	zfree(&hists->mem_stat_types);
> > +	zfree(&hists->mem_stat_total);
> >  
> >  	list_for_each_entry_safe(node, tmp, &hists->hpp_formats, list) {
> >  		perf_hpp_list__for_each_format_safe(&node->hpp, fmt, pos) {
> > diff --git a/tools/perf/util/hist.h b/tools/perf/util/hist.h
> > index 3990cfc21b1615ae..fa5e886e5b04ec9b 100644
> > --- a/tools/perf/util/hist.h
> > +++ b/tools/perf/util/hist.h
> > @@ -135,6 +135,7 @@ struct hists {
> >  	int			nr_hpp_node;
> >  	int			nr_mem_stats;
> >  	enum mem_stat_type	*mem_stat_types;
> > +	struct he_mem_stat	*mem_stat_total;
> >  };
> >  
> >  #define hists__has(__h, __f) (__h)->hpp_list->__f
> > -- 
> > 2.49.0.906.g1f30a19c02-goog

