Return-Path: <linux-kernel+bounces-835924-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C6540BA85B9
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 10:08:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7530317CB7C
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 08:08:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5AD42BDC2F;
	Mon, 29 Sep 2025 08:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oto9ZJvV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74C13239E79;
	Mon, 29 Sep 2025 08:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759133274; cv=none; b=R/4nV/UE75RhsPp6g2654roQBQRkHhbWfeJ39P9uowe1EtcNJz+JTQW6rBw8KaQOHALevQ488dZi/UA/N4TZbOsXdSfCXFD0utRhsOyI+zA0zQDgQHL1KpEP53VioyFYDOiwd6Iie3V093UMNweYDmTCes2KiXPWkQhfaIRXASQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759133274; c=relaxed/simple;
	bh=bNjGwLKmpVwBXxYsFJkRS7rwCepqLb8el/123Qk7JbY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MD51a2UXltXNOcCYR4yjDm3gcM6BNtPvcPfDomAr094B6mcbkaoi0WSxcMf9iypLOVWiYv6d19QMjcA8TN4jEwMom6Xpdc9qzaKrKE6PMl0R2kDjp1IPE3ikxIRpfPrqdTELL9Pa0rfT3NRZOwy3puQD+bl07jFqAu4Q/aLxpds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oto9ZJvV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4019C4CEF4;
	Mon, 29 Sep 2025 08:07:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759133274;
	bh=bNjGwLKmpVwBXxYsFJkRS7rwCepqLb8el/123Qk7JbY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oto9ZJvVULaqlxzt88AWq+/BL0/rWZX+2Zqot+r1sEYIfPY7pEFaf5FIpRGECmcrd
	 aovbE3bN3yyWDnoJjdwFoyFiyUxGqEG+UetSDf5Q5xZBbbK1kgRQqq0pkuvWXA0/rR
	 gMX3jQ+AeMZTNw2zWvl5jPKeoEpUa7qdpYotsKU3EMxBE3AYvqYSvBMmSq+M1Kn1dM
	 WGgHI6OQ6N1X7Ws8pex/b94mZ6Uq3hRINg00551eXtrn+0AuarVUMIMGuECi2KGdke
	 TcroHQxzl/Fax3ZH9v83fwPc03ZShvrVAWxE5X7aP4dDgfttEHW69bhXDhbcyCajEI
	 /Rl2hhQykhf0g==
Date: Mon, 29 Sep 2025 17:07:47 +0900
From: Namhyung Kim <namhyung@kernel.org>
To: "Li, Tianyou" <tianyou.li@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>, wangyang.guo@intel.com,
	pan.deng@intel.com, zhiguo.zhou@intel.com, jiebin.sun@intel.com,
	thomas.falcon@intel.com, dapeng1.mi@intel.com,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] perf tools c2c: Add annotation support to perf c2c
 report
Message-ID: <aNo-U0KquRbcJam9@google.com>
References: <aMpWcdjoCBsRVo72@z2>
 <20250928090212.1324797-1-tianyou.li@intel.com>
 <be2b23a3-9951-4357-a3f2-3eebe7ef20a5@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <be2b23a3-9951-4357-a3f2-3eebe7ef20a5@intel.com>

Hello,

On Sun, Sep 28, 2025 at 04:16:16PM +0800, Li, Tianyou wrote:
> Rebased with latest perf-tools-next. Looking forward to your review
> comments. Thanks.

Sorry for the delay, I was on vacation.
 
> On 9/28/2025 5:02 PM, Tianyou Li wrote:
> > Perf c2c report currently specified the code address and source:line
> > information in the cacheline browser, while it is lack of annotation
> > support like perf report to directly show the disassembly code for
> > the particular symbol shared that same cacheline. This patches add
> > a key 'a' binding to the cacheline browser which reuse the annotation
> > browser to show the disassembly view for easier analysis of cacheline
> > contentions. By default, the 'TAB' key navigate to the code address
> > where the contentions detected.
> > 
> > Signed-off-by: Tianyou Li <tianyou.li@intel.com>
> > Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> > Reviewed-by: Thomas Falcon <thomas.falcon@intel.com>
> > Reviewed-by: Jiebin Sun <jiebin.sun@intel.com>
> > Reviewed-by: Pan Deng <pan.deng@intel.com>
> > Reviewed-by: Zhiguo Zhou <zhiguo.zhou@intel.com>
> > Reviewed-by: Wangyang Guo <wangyang.guo@intel.com>
> > ---
> >   tools/perf/builtin-annotate.c     |   2 +-
> >   tools/perf/builtin-c2c.c          | 130 ++++++++++++++++++++++++++++--
> >   tools/perf/ui/browsers/annotate.c |  41 +++++++++-
> >   tools/perf/ui/browsers/hists.c    |   2 +-
> >   tools/perf/util/annotate.c        |   2 +-
> >   tools/perf/util/annotate.h        |   2 +
> >   tools/perf/util/hist.h            |   6 +-
> >   7 files changed, 171 insertions(+), 14 deletions(-)
> > 
> > diff --git a/tools/perf/builtin-annotate.c b/tools/perf/builtin-annotate.c
> > index 646f43b0f7c4..f977e97a9c96 100644
> > --- a/tools/perf/builtin-annotate.c
> > +++ b/tools/perf/builtin-annotate.c
> > @@ -519,7 +519,7 @@ static void hists__find_annotations(struct hists *hists,
> >   			/* skip missing symbols */
> >   			nd = rb_next(nd);
> >   		} else if (use_browser == 1) {
> > -			key = hist_entry__tui_annotate(he, evsel, NULL);
> > +			key = hist_entry__tui_annotate(he, evsel, NULL, NO_INITIAL_IP);
> >   			switch (key) {
> >   			case -1:
> > diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
> > index 9e9ff471ddd1..bf2136d062ef 100644
> > --- a/tools/perf/builtin-c2c.c
> > +++ b/tools/perf/builtin-c2c.c
> > @@ -45,6 +45,8 @@
> >   #include "pmus.h"
> >   #include "string2.h"
> >   #include "util/util.h"
> > +#include "util/symbol.h"
> > +#include "util/annotate.h"
> >   struct c2c_hists {
> >   	struct hists		hists;
> > @@ -62,6 +64,7 @@ struct compute_stats {
> >   struct c2c_hist_entry {
> >   	struct c2c_hists	*hists;
> > +	struct evsel		*evsel;
> >   	struct c2c_stats	 stats;
> >   	unsigned long		*cpuset;
> >   	unsigned long		*nodeset;
> > @@ -225,6 +228,12 @@ he__get_c2c_hists(struct hist_entry *he,
> >   	return hists;
> >   }
> > +static void c2c_he__set_evsel(struct c2c_hist_entry *c2c_he,
> > +				struct evsel *evsel)
> > +{
> > +	c2c_he->evsel = evsel;
> > +}
> > +
> >   static void c2c_he__set_cpu(struct c2c_hist_entry *c2c_he,
> >   			    struct perf_sample *sample)
> >   {
> > @@ -334,6 +343,7 @@ static int process_sample_event(const struct perf_tool *tool __maybe_unused,
> >   	c2c_he__set_cpu(c2c_he, sample);
> >   	c2c_he__set_node(c2c_he, sample);
> > +	c2c_he__set_evsel(c2c_he, evsel);
> >   	hists__inc_nr_samples(&c2c_hists->hists, he->filtered);
> >   	ret = hist_entry__append_callchain(he, sample);
> > @@ -371,6 +381,7 @@ static int process_sample_event(const struct perf_tool *tool __maybe_unused,
> >   		c2c_he__set_cpu(c2c_he, sample);
> >   		c2c_he__set_node(c2c_he, sample);
> > +		c2c_he__set_evsel(c2c_he, evsel);
> >   		hists__inc_nr_samples(&c2c_hists->hists, he->filtered);
> >   		ret = hist_entry__append_callchain(he, sample);
> > @@ -2550,6 +2561,35 @@ static void perf_c2c__hists_fprintf(FILE *out, struct perf_session *session)
> >   }
> >   #ifdef HAVE_SLANG_SUPPORT
> > +
> > +static int perf_c2c__toggle_annotation(struct hist_browser *browser)
> > +{
> > +	struct hist_entry *he = browser->he_selection;
> > +	struct symbol *sym = NULL;
> > +	struct c2c_hist_entry *c2c_he = NULL;
> > +	struct annotated_source *src = NULL;
> > +
> > +	if (he == NULL) {
> > +		ui_browser__help_window(&browser->b, "No entry selected for annotation");
> > +		return 0;
> > +	}
> > +	sym = (&he->ms)->sym;
> > +
> > +	if (sym == NULL) {
> > +		ui_browser__help_window(&browser->b, "Can not annotate, no symbol found");
> > +		return 0;
> > +	}
> > +
> > +	src = symbol__hists(sym, 0);
> > +	if (src == NULL) {
> > +		ui_browser__help_window(&browser->b, "Failed to initialize annotation source");
> > +		return 0;
> > +	}
> > +
> > +	c2c_he = container_of(he, struct c2c_hist_entry, he);
> > +	return hist_entry__tui_annotate(he, c2c_he->evsel, NULL, he->ip);

I'm skeptical about using he->ip.  An hist_entry can collapse multiple
samples with different IP in a symbol (even if hpp_list has symbol sort
key).  That means he->ip cannot represent the entry is from the specific
point in the function.  This might lead users to an inaccurate place in
the annotation browser.  I'd recommend not passing IP.

> > +}
> > +
> >   static void c2c_browser__update_nr_entries(struct hist_browser *hb)
> >   {
> >   	u64 nr_entries = 0;
> > @@ -2617,6 +2657,7 @@ static int perf_c2c__browse_cacheline(struct hist_entry *he)
> >   	" ENTER         Toggle callchains (if present) \n"
> >   	" n             Toggle Node details info \n"
> >   	" s             Toggle full length of symbol and source line columns \n"
> > +	" a             Toggle annotation view \n"
> >   	" q             Return back to cacheline list \n";
> >   	if (!he)
> > @@ -2651,6 +2692,9 @@ static int perf_c2c__browse_cacheline(struct hist_entry *he)
> >   			c2c.node_info = (c2c.node_info + 1) % 3;
> >   			setup_nodes_header();
> >   			break;
> > +		case 'a':
> > +			perf_c2c__toggle_annotation(browser);
> > +			break;
> >   		case 'q':
> >   			goto out;
> >   		case '?':
> > @@ -2989,6 +3033,11 @@ static int setup_coalesce(const char *coalesce, bool no_source)
> >   	return 0;
> >   }
> > +static bool perf_c2c__has_annotation(void)
> > +{
> > +	return use_browser == 1;

Please check if it has symbol dimension in the c2c_hists->list like in
the ui__has_annotation().  Maybe you need to add this in the
c2c_hists__init_sort().

	if (dim == &dim_symbol)
		hpp_list->sym = 1;

Thanks,
Namhyung

> > +}
> > +
> >   static int perf_c2c__report(int argc, const char **argv)
> >   {
> >   	struct itrace_synth_opts itrace_synth_opts = {
> > @@ -3006,6 +3055,7 @@ static int perf_c2c__report(int argc, const char **argv)
> >   	const char *display = NULL;
> >   	const char *coalesce = NULL;
> >   	bool no_source = false;
> > +	const char *disassembler_style = NULL, *objdump_path = NULL, *addr2line_path = NULL;
> >   	const struct option options[] = {
> >   	OPT_STRING('k', "vmlinux", &symbol_conf.vmlinux_name,
> >   		   "file", "vmlinux pathname"),
> > @@ -3033,6 +3083,12 @@ static int perf_c2c__report(int argc, const char **argv)
> >   	OPT_BOOLEAN(0, "stitch-lbr", &c2c.stitch_lbr,
> >   		    "Enable LBR callgraph stitching approach"),
> >   	OPT_BOOLEAN(0, "double-cl", &chk_double_cl, "Detect adjacent cacheline false sharing"),
> > +	OPT_STRING('M', "disassembler-style", &disassembler_style, "disassembler style",
> > +		   "Specify disassembler style (e.g. -M intel for intel syntax)"),
> > +	OPT_STRING(0, "objdump", &objdump_path, "path",
> > +		   "objdump binary to use for disassembly and annotations"),
> > +	OPT_STRING(0, "addr2line", &addr2line_path, "path",
> > +		   "addr2line binary to use for line numbers"),
> >   	OPT_PARENT(c2c_options),
> >   	OPT_END()
> >   	};
> > @@ -3040,6 +3096,12 @@ static int perf_c2c__report(int argc, const char **argv)
> >   	const char *output_str, *sort_str = NULL;
> >   	struct perf_env *env;
> > +	annotation_options__init();
> > +
> > +	err = hists__init();
> > +	if (err < 0)
> > +		goto out;
> > +
> >   	argc = parse_options(argc, argv, options, report_c2c_usage,
> >   			     PARSE_OPT_STOP_AT_NON_OPTION);
> >   	if (argc)
> > @@ -3052,6 +3114,36 @@ static int perf_c2c__report(int argc, const char **argv)
> >   	if (c2c.stats_only)
> >   		c2c.use_stdio = true;
> > +	/**
> > +	 * Annotation related options
> > +	 * disassembler_style, objdump_path, addr2line_path
> > +	 * are set in the c2c_options, so we can use them here.
> > +	 */
> > +	if (disassembler_style) {
> > +		annotate_opts.disassembler_style = strdup(disassembler_style);
> > +		if (!annotate_opts.disassembler_style) {
> > +			err = -ENOMEM;
> > +			pr_err("Failed to allocate memory for annotation options\n");
> > +			goto out;
> > +		}
> > +	}
> > +	if (objdump_path) {
> > +		annotate_opts.objdump_path = strdup(objdump_path);
> > +		if (!annotate_opts.objdump_path) {
> > +			err = -ENOMEM;
> > +			pr_err("Failed to allocate memory for annotation options\n");
> > +			goto out;
> > +		}
> > +	}
> > +	if (addr2line_path) {
> > +		symbol_conf.addr2line_path = strdup(addr2line_path);
> > +		if (!symbol_conf.addr2line_path) {
> > +			err = -ENOMEM;
> > +			pr_err("Failed to allocate memory for annotation options\n");
> > +			goto out;
> > +		}
> > +	}
> > +
> >   	err = symbol__validate_sym_arguments();
> >   	if (err)
> >   		goto out;
> > @@ -3126,6 +3218,38 @@ static int perf_c2c__report(int argc, const char **argv)
> >   	if (err)
> >   		goto out_mem2node;
> > +	if (c2c.use_stdio)
> > +		use_browser = 0;
> > +	else
> > +		use_browser = 1;
> > +
> > +	/*
> > +	 * Only in the TUI browser we are doing integrated annotation,
> > +	 * so don't allocate extra space that won't be used in the stdio
> > +	 * implementation.
> > +	 */
> > +	if (perf_c2c__has_annotation()) {
> > +		int ret = symbol__annotation_init();
> > +
> > +		if (ret < 0)
> > +			goto out_mem2node;
> > +		/*
> > +		 * For searching by name on the "Browse map details".
> > +		 * providing it only in verbose mode not to bloat too
> > +		 * much struct symbol.
> > +		 */
> > +		if (verbose > 0) {
> > +			/*
> > +			 * XXX: Need to provide a less kludgy way to ask for
> > +			 * more space per symbol, the u32 is for the index on
> > +			 * the ui browser.
> > +			 * See symbol__browser_index.
> > +			 */
> > +			symbol_conf.priv_size += sizeof(u32);
> > +		}
> > +		annotation_config__init();
> > +	}
> > +
> >   	if (symbol__init(env) < 0)
> >   		goto out_mem2node;
> > @@ -3135,11 +3259,6 @@ static int perf_c2c__report(int argc, const char **argv)
> >   		goto out_mem2node;
> >   	}
> > -	if (c2c.use_stdio)
> > -		use_browser = 0;
> > -	else
> > -		use_browser = 1;
> > -
> >   	setup_browser(false);
> >   	err = perf_session__process_events(session);
> > @@ -3210,6 +3329,7 @@ static int perf_c2c__report(int argc, const char **argv)
> >   out_session:
> >   	perf_session__delete(session);
> >   out:
> > +	annotation_options__exit();
> >   	return err;
> >   }
> > diff --git a/tools/perf/ui/browsers/annotate.c b/tools/perf/ui/browsers/annotate.c
> > index 8fe699f98542..63d0e28fb991 100644
> > --- a/tools/perf/ui/browsers/annotate.c
> > +++ b/tools/perf/ui/browsers/annotate.c
> > @@ -605,7 +605,7 @@ static bool annotate_browser__callq(struct annotate_browser *browser,
> >   	target_ms.map = ms->map;
> >   	target_ms.sym = dl->ops.target.sym;
> >   	annotation__unlock(notes);
> > -	__hist_entry__tui_annotate(browser->he, &target_ms, evsel, hbt);
> > +	__hist_entry__tui_annotate(browser->he, &target_ms, evsel, hbt, NO_INITIAL_IP);
> >   	/*
> >   	 * The annotate_browser above changed the title with the target function
> > @@ -864,6 +864,7 @@ static int annotate_browser__run(struct annotate_browser *browser,
> >   	const char *help = "Press 'h' for help on key bindings";
> >   	int delay_secs = hbt ? hbt->refresh : 0;
> >   	char *br_cntr_text = NULL;
> > +	u64 init_ip = NO_INITIAL_IP;
> >   	char title[256];
> >   	int key;
> > @@ -873,6 +874,13 @@ static int annotate_browser__run(struct annotate_browser *browser,
> >   	annotate_browser__calc_percent(browser, evsel);
> > +	/* the selection are intentionally even not from the sample percentage */
> > +	if (browser->entries.rb_node == NULL && browser->selection) {
> > +		init_ip = sym->start + browser->selection->offset;
> > +		disasm_rb_tree__insert(browser, browser->selection);
> > +		browser->curr_hot = rb_last(&browser->entries);
> > +	}
> > +
> >   	if (browser->curr_hot) {
> >   		annotate_browser__set_rb_top(browser, browser->curr_hot);
> >   		browser->b.navkeypressed = false;
> > @@ -973,6 +981,18 @@ static int annotate_browser__run(struct annotate_browser *browser,
> >   				ui_helpline__puts(help);
> >   			annotate__scnprintf_title(hists, title, sizeof(title));
> >   			annotate_browser__show(browser, title, help);
> > +			/* Previous RB tree may not valid, need refresh according to new entries*/
> > +			if (init_ip != NO_INITIAL_IP) {
> > +				struct disasm_line *dl = find_disasm_line(sym, init_ip, true);
> > +
> > +				browser->curr_hot = NULL;
> > +				browser->entries.rb_node = NULL;
> > +				if (dl != NULL) {
> > +					disasm_rb_tree__insert(browser, &dl->al);
> > +					browser->curr_hot = rb_last(&browser->entries);
> > +				}
> > +				nd = browser->curr_hot;
> > +			}
> >   			continue;
> >   		case 'o':
> >   			annotate_opts.use_offset = !annotate_opts.use_offset;
> > @@ -1106,22 +1126,23 @@ static int annotate_browser__run(struct annotate_browser *browser,
> >   }
> >   int hist_entry__tui_annotate(struct hist_entry *he, struct evsel *evsel,
> > -			     struct hist_browser_timer *hbt)
> > +			     struct hist_browser_timer *hbt, u64 init_ip)
> >   {
> >   	/* reset abort key so that it can get Ctrl-C as a key */
> >   	SLang_reset_tty();
> >   	SLang_init_tty(0, 0, 0);
> >   	SLtty_set_suspend_state(true);
> > -	return __hist_entry__tui_annotate(he, &he->ms, evsel, hbt);
> > +	return __hist_entry__tui_annotate(he, &he->ms, evsel, hbt, init_ip);
> >   }
> >   int __hist_entry__tui_annotate(struct hist_entry *he, struct map_symbol *ms,
> >   			       struct evsel *evsel,
> > -			       struct hist_browser_timer *hbt)
> > +			       struct hist_browser_timer *hbt, u64 init_ip)
> >   {
> >   	struct symbol *sym = ms->sym;
> >   	struct annotation *notes = symbol__annotation(sym);
> > +	struct disasm_line *dl = NULL;
> >   	struct annotate_browser browser = {
> >   		.b = {
> >   			.refresh = annotate_browser__refresh,
> > @@ -1173,6 +1194,18 @@ int __hist_entry__tui_annotate(struct hist_entry *he, struct map_symbol *ms,
> >   		browser.he = &annotate_he;
> >   	}
> > +	/*
> > +	 * If init_ip is set, it means that there should be a line
> > +	 * intentionally selected, not based on the percentages
> > +	 * which caculated by the event sampling. In this case, we
> > +	 * convey this information into the browser selection, where
> > +	 * the selection in other cases should be empty.
> > +	 */
> > +	if (init_ip != NO_INITIAL_IP) {
> > +		dl = find_disasm_line(sym, init_ip, false);
> > +		browser.selection = &dl->al;
> > +	}
> > +
> >   	ui_helpline__push("Press ESC to exit");
> >   	if (annotate_opts.code_with_type) {
> > diff --git a/tools/perf/ui/browsers/hists.c b/tools/perf/ui/browsers/hists.c
> > index 487c0b08c003..3675a703de11 100644
> > --- a/tools/perf/ui/browsers/hists.c
> > +++ b/tools/perf/ui/browsers/hists.c
> > @@ -2485,7 +2485,7 @@ do_annotate(struct hist_browser *browser, struct popup_action *act)
> >   		evsel = hists_to_evsel(browser->hists);
> >   	he = hist_browser__selected_entry(browser);
> > -	err = __hist_entry__tui_annotate(he, &act->ms, evsel, browser->hbt);
> > +	err = __hist_entry__tui_annotate(he, &act->ms, evsel, browser->hbt, NO_INITIAL_IP);
> >   	/*
> >   	 * offer option to annotate the other branch source or target
> >   	 * (if they exists) when returning from annotate
> > diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
> > index c9b220d9f924..937effbeda69 100644
> > --- a/tools/perf/util/annotate.c
> > +++ b/tools/perf/util/annotate.c
> > @@ -2622,7 +2622,7 @@ int annotate_get_insn_location(struct arch *arch, struct disasm_line *dl,
> >   	return 0;
> >   }
> > -static struct disasm_line *find_disasm_line(struct symbol *sym, u64 ip,
> > +struct disasm_line *find_disasm_line(struct symbol *sym, u64 ip,
> >   					    bool allow_update)
> >   {
> >   	struct disasm_line *dl;
> > diff --git a/tools/perf/util/annotate.h b/tools/perf/util/annotate.h
> > index eaf6c8aa7f47..bbe67588bbdd 100644
> > --- a/tools/perf/util/annotate.h
> > +++ b/tools/perf/util/annotate.h
> > @@ -170,6 +170,8 @@ static inline struct disasm_line *disasm_line(struct annotation_line *al)
> >   	return al ? container_of(al, struct disasm_line, al) : NULL;
> >   }
> > +struct disasm_line *find_disasm_line(struct symbol *sym, u64 ip, bool allow_update);
> > +
> >   /*
> >    * Is this offset in the same function as the line it is used?
> >    * asm functions jump to other functions, for instance.
> > diff --git a/tools/perf/util/hist.h b/tools/perf/util/hist.h
> > index c64005278687..e544e1795f19 100644
> > --- a/tools/perf/util/hist.h
> > +++ b/tools/perf/util/hist.h
> > @@ -713,12 +713,14 @@ struct block_hist {
> >   #include "../ui/keysyms.h"
> >   void attr_to_script(char *buf, struct perf_event_attr *attr);
> > +#define NO_INITIAL_IP 0
> > +
> >   int __hist_entry__tui_annotate(struct hist_entry *he, struct map_symbol *ms,
> >   			       struct evsel *evsel,
> > -			       struct hist_browser_timer *hbt);
> > +			       struct hist_browser_timer *hbt, u64 init_ip);
> >   int hist_entry__tui_annotate(struct hist_entry *he, struct evsel *evsel,
> > -			     struct hist_browser_timer *hbt);
> > +			     struct hist_browser_timer *hbt, u64 init_ip);
> >   int evlist__tui_browse_hists(struct evlist *evlist, const char *help, struct hist_browser_timer *hbt,
> >   			     float min_pcnt, struct perf_env *env, bool warn_lost_event);

