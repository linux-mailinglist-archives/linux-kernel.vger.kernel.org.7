Return-Path: <linux-kernel+bounces-680326-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C2332AD43AE
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jun 2025 22:25:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6AA753A5C52
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jun 2025 20:25:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C2E8265630;
	Tue, 10 Jun 2025 20:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TJY/C8uS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A37CE264A77;
	Tue, 10 Jun 2025 20:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749587117; cv=none; b=RlDUH/f+lXagbY2MJlH1gr2E30H73iMpx35x/yEkBRXlCdpbFFtYznOngCCJSv/BHmKdDqxDCY/CcQFZQqIYOxbcJC7iYKlanu0nrqx9YA5306adxfjBKVlptN2kQYeFZercPKhp8OWvhRDoFGKdD0EqTJVvMvYgGajuzGOUmnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749587117; c=relaxed/simple;
	bh=3JhNaFKU4fAX0PjKiEpwFEj36Ijx7tlYiQ1yVdzkVm8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XcMF/jTSxASkzyoThod+8aZm+TNROe/uGc0JrxzyMA7+bRRbo7UiC/wdoc2Cz6pWoKcyGm+Z4jfbcIJPeK7aCK8QFJnA6QY5DUHJRRyHoCwbSJ9jPQqkMPsAZ6nMJ3oeL5c8i9aiPsScKjqSoJHB7SOgr+8eN8mzRK6bPLI00aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TJY/C8uS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C278CC4CEED;
	Tue, 10 Jun 2025 20:25:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749587117;
	bh=3JhNaFKU4fAX0PjKiEpwFEj36Ijx7tlYiQ1yVdzkVm8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TJY/C8uSdS4V4MdS75lL+3C5T7IgZxJkb3K5DbycJvfvW4ouZj9AI2cw+oHsQbLII
	 iM5sjGqOcdvQRo6yQpj6tktDq39eCS644OcAF0f9Uaz8xB20VFjd8x55Zc8QYFJ/21
	 d43XqqoZv5PRA4YbhQL2e92KOlhukSW8EbJ97rc/GPDyxuNuahl4BF+N90ykvEAoE0
	 lGCBvbpLzcrJzWgkTKNc6cVxrBKKPOkzJCdHh4iSZKnVQ3ZWy2Hszg8gzAn8CX/uAq
	 erm5gSTz+5fL3kyxRArg+MDgERR+tJruG598QWTI0Hobq/ek5wZLqfU/3A66Znyaul
	 Ky1t6iRqjUQow==
Date: Tue, 10 Jun 2025 17:25:14 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: "Falcon, Thomas" <thomas.falcon@intel.com>
Cc: "alexander.shishkin@linux.intel.com" <alexander.shishkin@linux.intel.com>,
	"peterz@infradead.org" <peterz@infradead.org>,
	"mingo@redhat.com" <mingo@redhat.com>,
	"mark.rutland@arm.com" <mark.rutland@arm.com>,
	"Hunter, Adrian" <adrian.hunter@intel.com>,
	"namhyung@kernel.org" <namhyung@kernel.org>,
	"irogers@google.com" <irogers@google.com>,
	"jolsa@kernel.org" <jolsa@kernel.org>,
	"kan.liang@linux.intel.com" <kan.liang@linux.intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>
Subject: Re: [PATCH 2/2 v3] perf top: populate PMU capabilities data in
 perf_env
Message-ID: <aEiUqtB9Zg9ZBQO6@x1>
References: <20250513231813.13846-1-thomas.falcon@intel.com>
 <20250513231813.13846-2-thomas.falcon@intel.com>
 <a327dc2e5837a743a08403b5ad58dbe5e8c4f926.camel@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a327dc2e5837a743a08403b5ad58dbe5e8c4f926.camel@intel.com>

On Mon, Jun 09, 2025 at 04:21:39PM +0000, Falcon, Thomas wrote:
> Ping?
> 
> Thanks,
> Tom
> 
> On Tue, 2025-05-13 at 18:18 -0500, Thomas Falcon wrote:
> > Calling perf top with branch filters enabled on Intel CPU's
> > with branch counters logging (A.K.A LBR event logging [1]) support
> > results in a segfault.
> > 
> > Thread 27 "perf" received signal SIGSEGV, Segmentation fault.
> > [Switching to Thread 0x7fffafff76c0 (LWP 949003)]
> > perf_env__find_br_cntr_info (env=0xf66dc0 <perf_env>, nr=0x0, width=0x7fffafff62c0) at util/env.c:653
> > 653			*width = env->cpu_pmu_caps ? env->br_cntr_width :
> > (gdb) bt
> >  #0  perf_env__find_br_cntr_info (env=0xf66dc0 <perf_env>, nr=0x0, width=0x7fffafff62c0) at util/env.c:653
> >  #1  0x00000000005b1599 in symbol__account_br_cntr (branch=0x7fffcc3db580, evsel=0xfea2d0, offset=12, br_cntr=8) at util/annotate.c:345
> >  #2  0x00000000005b17fb in symbol__account_cycles (addr=5658172, start=5658160, sym=0x7fffcc0ee420, cycles=539, evsel=0xfea2d0, br_cntr=8) at util/annotate.c:389
> >  #3  0x00000000005b1976 in addr_map_symbol__account_cycles (ams=0x7fffcd7b01d0, start=0x7fffcd7b02b0, cycles=539, evsel=0xfea2d0, br_cntr=8) at util/annotate.c:422
> >  #4  0x000000000068d57f in hist__account_cycles (bs=0x110d288, al=0x7fffafff6540, sample=0x7fffafff6760, nonany_branch_mode=false, total_cycles=0x0, evsel=0xfea2d0) at util/hist.c:2850
> >  #5  0x0000000000446216 in hist_iter__top_callback (iter=0x7fffafff6590, al=0x7fffafff6540, single=true, arg=0x7fffffff9e00) at builtin-top.c:737
> >  #6  0x0000000000689787 in hist_entry_iter__add (iter=0x7fffafff6590, al=0x7fffafff6540, max_stack_depth=127, arg=0x7fffffff9e00) at util/hist.c:1359
> >  #7  0x0000000000446710 in perf_event__process_sample (tool=0x7fffffff9e00, event=0x110d250, evsel=0xfea2d0, sample=0x7fffafff6760, machine=0x108c968) at builtin-top.c:845
> >  #8  0x0000000000447735 in deliver_event (qe=0x7fffffffa120, qevent=0x10fc200) at builtin-top.c:1211
> >  #9  0x000000000064ccae in do_flush (oe=0x7fffffffa120, show_progress=false) at util/ordered-events.c:245
> >  #10 0x000000000064d005 in __ordered_events__flush (oe=0x7fffffffa120, how=OE_FLUSH__TOP, timestamp=0) at util/ordered-events.c:324
> >  #11 0x000000000064d0ef in ordered_events__flush (oe=0x7fffffffa120, how=OE_FLUSH__TOP) at util/ordered-events.c:342
> >  #12 0x00000000004472a9 in process_thread (arg=0x7fffffff9e00) at builtin-top.c:1120
> >  #13 0x00007ffff6e7dba8 in start_thread (arg=<optimized out>) at pthread_create.c:448
> >  #14 0x00007ffff6f01b8c in __GI___clone3 () at ../sysdeps/unix/sysv/linux/x86_64/clone3.S:78
> > 
> > The cause is that perf_env__find_br_cntr_info tries to access a
> > null pointer pmu_caps in the perf_env struct. A similar issue exists
> > for homogeneous core systems which use the cpu_pmu_caps structure.
> > 
> > Fix this by populating cpu_pmu_caps and pmu_caps structures with
> > values from sysfs when calling perf top with branch stack sampling
> > enabled.
> > 
> > [1], LBR event logging introduced here:
> > https://lore.kernel.org/all/20231025201626.3000228-5-kan.liang@linux.intel.com/
> > 
> > Signed-off-by: Thomas Falcon <thomas.falcon@intel.com>
> > ---
> > v3: constify struct perf_pmu *pmu in __perf_env__read_core_pmu_caps()
> >     use perf_pmus__find_core_pmu() instead of perf_pmus__scan_core(NULL)
> > 
> > v2: update commit message with more meaningful stack trace from
> >     gdb and indicate that affected systems are limited to CPU's
> >     with LBR event logging support and that both hybrid and
> >     non-hybrid core systems are affected.
> > ---
> >  tools/perf/builtin-top.c |   8 +++
> >  tools/perf/util/env.c    | 114 +++++++++++++++++++++++++++++++++++++++
> >  tools/perf/util/env.h    |   1 +
> >  3 files changed, 123 insertions(+)
> > 
> > diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
> > index f9f31391bddb..c9d679410591 100644
> > --- a/tools/perf/builtin-top.c
> > +++ b/tools/perf/builtin-top.c
> > @@ -1729,6 +1729,14 @@ int cmd_top(int argc, const char **argv)
> >  	if (opts->branch_stack && callchain_param.enabled)
> >  		symbol_conf.show_branchflag_count = true;
> >  
> > +	if (opts->branch_stack) {
> > +		status = perf_env__read_core_pmu_caps(&perf_env);
> > +		if (status) {
> > +			pr_err("PMU capability data is not available\n");
> > +			goto out_delete_evlist;
> > +		}
> > +	}
> > +
> >  	sort__mode = SORT_MODE__TOP;
> >  	/* display thread wants entries to be collapsed in a different tree */
> >  	perf_hpp_list.need_collapse = 1;
> > diff --git a/tools/perf/util/env.c b/tools/perf/util/env.c
> > index 36411749e007..6735786a1d22 100644
> > --- a/tools/perf/util/env.c
> > +++ b/tools/perf/util/env.c
> > @@ -416,6 +416,120 @@ static int perf_env__read_nr_cpus_avail(struct perf_env *env)
> >  	return env->nr_cpus_avail ? 0 : -ENOENT;
> >  }
> >  
> > +static int __perf_env__read_core_pmu_caps(const struct perf_pmu *pmu,
> > +					  int *nr_caps, char ***caps,
> > +					  unsigned int *max_branches,
> > +					  unsigned int *br_cntr_nr,
> > +					  unsigned int *br_cntr_width)
> > +{
> > +	struct perf_pmu_caps *pcaps = NULL;
> > +	char *ptr, **tmp;
> > +	int ret = 0;
> > +
> > +	*nr_caps = 0;
> > +	*caps = NULL;
> > +
> > +	if (!pmu->nr_caps)
> > +		return 0;
> > +
> > +	*caps = zalloc(sizeof(char *) * pmu->nr_caps);

calloc?

> > +	if (!*caps)
> > +		return -ENOMEM;
> > +
> > +	tmp = *caps;
> > +	list_for_each_entry(pcaps, &pmu->caps, list) {
> > +

Needless blank line

> > +		if (asprintf(&ptr, "%s=%s", pcaps->name, pcaps->value) < 0) {
> > +			ret = -ENOMEM;
> > +			goto error;
> > +		}
> > +
> > +		*tmp++ = ptr;
> > +
> > +		if (!strcmp(pcaps->name, "branches"))
> > +			*max_branches = atoi(pcaps->value);
> > +
> > +		if (!strcmp(pcaps->name, "branch_counter_nr"))
> > +			*br_cntr_nr = atoi(pcaps->value);
> > +
> > +		if (!strcmp(pcaps->name, "branch_counter_width"))
> > +			*br_cntr_width = atoi(pcaps->value);

else if?

I.e. why test it repeatedly when it can't be the three of them?

What if it is not one of these three? Free and error out?

> > +	}
> > +	*nr_caps = pmu->nr_caps;
> > +	return 0;
> > +error:
> > +	while (tmp-- != *caps)
> > +		free(*tmp);

zfree(tmp)

> > +	free(*caps);
> > +	*caps = NULL;

zfree(caps)

> > +	*nr_caps = 0;
> > +	return ret;
> > +}
> > +
> > +int perf_env__read_core_pmu_caps(struct perf_env *env)
> > +{
> > +	struct perf_pmu *pmu = NULL;

why init it to NULL if it will be initialized to something else later on
before being used?

> > +	struct pmu_caps *pmu_caps;
> > +	int nr_pmu = 0, i = 0, j;
> > +	int ret;
> > +
> > +	nr_pmu = perf_pmus__num_core_pmus();

nr_pmu = 0 followed by this call?

> > +
> > +	if (!nr_pmu)
> > +		return -ENODEV;
> > +
> > +	if (nr_pmu == 1) {
> > +		pmu = perf_pmus__find_core_pmu();
> > +		if (!pmu)
> > +			return -ENODEV;
> > +		ret = perf_pmu__caps_parse(pmu);
> > +		if (ret < 0)
> > +			return ret;
> > +		return __perf_env__read_core_pmu_caps(pmu, &env->nr_cpu_pmu_caps,
> > +						      &env->cpu_pmu_caps,
> > +						      &env->max_branches,
> > +						      &env->br_cntr_nr,
> > +						      &env->br_cntr_width);
> > +	}
> > +
> > +	pmu_caps = zalloc(sizeof(*pmu_caps) * nr_pmu);
> > +	if (!pmu_caps)
> > +		return -ENOMEM;
> > +
> > +	while ((pmu = perf_pmus__scan_core(pmu)) != NULL) {
> > +		if (perf_pmu__caps_parse(pmu) <= 0)
> > +			continue;
> > +		ret = __perf_env__read_core_pmu_caps(pmu, &pmu_caps[i].nr_caps,
> > +						     &pmu_caps[i].caps,
> > +						     &pmu_caps[i].max_branches,
> > +						     &pmu_caps[i].br_cntr_nr,
> > +						     &pmu_caps[i].br_cntr_width);
> > +		if (ret)
> > +			goto error;
> > +
> > +		pmu_caps[i].pmu_name = strdup(pmu->name);
> > +		if (!pmu_caps[i].pmu_name) {
> > +			ret = -ENOMEM;
> > +			goto error;
> > +		}
> > +		i++;
> > +	}
> > +
> > +	env->nr_pmus_with_caps = nr_pmu;
> > +	env->pmu_caps = pmu_caps;
> > +
> > +	return 0;
> > +error:
> > +	for (i = 0; i < nr_pmu; i++) {
> > +		for (j = 0; j < pmu_caps[i].nr_caps; j++)
> > +			free(pmu_caps[i].caps[j]);
> > +		free(pmu_caps[i].caps);
> > +		free(pmu_caps[i].pmu_name);

zfree in all the frees above?

> > +	}
> > +	free(pmu_caps);
> > +	return ret;
> > +}
> > +
> >  const char *perf_env__raw_arch(struct perf_env *env)
> >  {
> >  	return env && !perf_env__read_arch(env) ? env->arch : "unknown";
> > diff --git a/tools/perf/util/env.h b/tools/perf/util/env.h
> > index d90e343cf1fa..135a1f714905 100644
> > --- a/tools/perf/util/env.h
> > +++ b/tools/perf/util/env.h
> > @@ -152,6 +152,7 @@ struct btf_node;
> >  
> >  extern struct perf_env perf_env;
> >  
> > +int perf_env__read_core_pmu_caps(struct perf_env *env);
> >  void perf_env__exit(struct perf_env *env);
> >  
> >  int perf_env__kernel_is_64_bit(struct perf_env *env);
> 

