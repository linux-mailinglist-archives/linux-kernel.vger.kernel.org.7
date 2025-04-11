Return-Path: <linux-kernel+bounces-601046-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4441CA86860
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Apr 2025 23:35:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 883A74463D4
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Apr 2025 21:34:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7469A29C35A;
	Fri, 11 Apr 2025 21:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lHHeVN7A"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 221EB280A45;
	Fri, 11 Apr 2025 21:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744407287; cv=none; b=EzraVnxP6615ytrgfOv8yQg4bZJC5AqJ+t6ze4Pd11nT/hvxvxmqQ5hxmN+2hLL8btSL8dfFPl/JmVkh0Pt3SQPXN1/FyzNfB8SKTEpcACV1wulEYqz04ms1Quh4EVKNAdYeGA7hLdz1xIZj+TRdvUmYtqINrdNhqCzVUijelVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744407287; c=relaxed/simple;
	bh=x/YC8ZhBYUR4zXQOSQJAlRVA1Mu6/vn9KrPwCxcY5YI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SxA/6+3ro0mSEk0jm2FejX5L0n/M7a1OClBzDY46rSLJLD+HmmC7Dght0kUg9PzYn7z1d3TdcepGsCY9n8yyeTpvvTGWRweLyqk72Wunu8/PlSN+/P2XC9i5IqI0eVY7BJM6IOLYLEQdsbphAfGRfXbsX7mGPNw+RiVRDVvF1S4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lHHeVN7A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FCF0C4CEE2;
	Fri, 11 Apr 2025 21:34:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744407286;
	bh=x/YC8ZhBYUR4zXQOSQJAlRVA1Mu6/vn9KrPwCxcY5YI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lHHeVN7A/B2anE2rQqzcGBvtcB9VbFGTUuZSjYfaKYZagq6Q26YiiGnxJdwjfN6xN
	 PJObiPQcr7U/OQgPgMfeTHgVgW/5p/VI5+XKfruGBJLrmRzZLBa4A1mzlN4+h2xvm7
	 U7PZjnb5k7wwXj2mR56LO+VM6oVIixd6J7nlHLH2jZ3XUlmL5i8+KD2s4hb0j22n6V
	 1Md0MMFmTaCf0Q5BG8faOtY4B7Z7ZsOOF5KFwmVx8WuHNSsS5z73sZHmt8kpYh37wa
	 XPNC2fLYEX5QYZD5Pynxob6TVvMClBPmt1pVsgPoemrJZ0+I4IXTQrRhqAsMZy/Xdp
	 RZrbldhdmDbew==
Date: Fri, 11 Apr 2025 14:34:44 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: Re: [RFC PATCH v1] perf build: Fix build for clang's
 -Wunreachable-code
Message-ID: <Z_mK9BVv16MT7shL@z2>
References: <20250410202647.1899125-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250410202647.1899125-1-irogers@google.com>

Hi Ian,

On Thu, Apr 10, 2025 at 01:26:47PM -0700, Ian Rogers wrote:
> Clang's unreachable code warning is able to catch bugs like the famous
> "goto fail" which gcc's unreachable code warning fails to warn about
> (it will complain about misleading indent). The changes here are
> sufficient to get perf building with clang with -Wunreachable code,
> but they don't really fix any bugs. Posting as an RFC to see if anyone
> things this is worth pursuing.

I'm not sure if it's useful and don't see what kind of bugs it can
address.  The proposed changes don't look like an improvement.

Thanks,
Namhyung

> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/lib/bpf/libbpf.c                        |   3 +
>  tools/perf/bench/breakpoint.c                 |   4 +-
>  tools/perf/bench/epoll-ctl.c                  |   2 +-
>  tools/perf/bench/epoll-wait.c                 |   2 +-
>  tools/perf/bench/evlist-open-close.c          |   2 +-
>  tools/perf/bench/find-bit-bench.c             |   2 +-
>  tools/perf/bench/futex-hash.c                 |   2 +-
>  tools/perf/bench/futex-lock-pi.c              |   2 +-
>  tools/perf/bench/futex-requeue.c              |   2 +-
>  tools/perf/bench/futex-wake-parallel.c        |   2 +-
>  tools/perf/bench/futex-wake.c                 |   2 +-
>  tools/perf/bench/inject-buildid.c             |   2 +-
>  tools/perf/bench/kallsyms-parse.c             |   2 +-
>  tools/perf/bench/pmu-scan.c                   |   2 +-
>  tools/perf/bench/synthesize.c                 |   2 +-
>  tools/perf/builtin-check.c                    |   6 +-
>  tools/perf/builtin-kvm.c                      |   5 +-
>  tools/perf/builtin-kwork.c                    |   5 +-
>  tools/perf/builtin-sched.c                    |   5 +-
>  tools/perf/builtin-trace.c                    | 108 +++++++++---------
>  tools/perf/tests/perf-record.c                |  10 +-
>  tools/perf/util/Build                         |   1 +
>  tools/perf/util/auxtrace.c                    |   2 +-
>  .../scripting-engines/trace-event-python.c    |   2 +-
>  24 files changed, 83 insertions(+), 94 deletions(-)
> 
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 194809da5172..4bfbb70d70a6 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -6823,6 +6823,8 @@ static bool need_func_arg_type_fixup(const struct btf *btf, const struct bpf_pro
>  			return true;
>  		break;
>  	case BPF_PROG_TYPE_PERF_EVENT:
> +		#pragma clang diagnostic push
> +		#pragma clang diagnostic ignored "-Wunreachable-code"
>  		if (__builtin_types_compatible_p(bpf_user_pt_regs_t, struct pt_regs) &&
>  		    btf_is_struct(t) && strcmp(tname, "pt_regs") == 0)
>  			return true;
> @@ -6832,6 +6834,7 @@ static bool need_func_arg_type_fixup(const struct btf *btf, const struct bpf_pro
>  		if (__builtin_types_compatible_p(bpf_user_pt_regs_t, struct user_regs_struct) &&
>  		    btf_is_struct(t) && strcmp(tname, "user_regs_struct") == 0)
>  			return true;
> +		#pragma clang diagnostic pop
>  		break;
>  	case BPF_PROG_TYPE_RAW_TRACEPOINT:
>  	case BPF_PROG_TYPE_RAW_TRACEPOINT_WRITABLE:
> diff --git a/tools/perf/bench/breakpoint.c b/tools/perf/bench/breakpoint.c
> index dfd18f5db97d..e1f046f0f464 100644
> --- a/tools/perf/bench/breakpoint.c
> +++ b/tools/perf/bench/breakpoint.c
> @@ -119,7 +119,7 @@ int bench_breakpoint_thread(int argc, const char **argv)
>  
>  	if (parse_options(argc, argv, thread_options, thread_usage, 0)) {
>  		usage_with_options(thread_usage, thread_options);
> -		exit(EXIT_FAILURE);
> +		__builtin_unreachable();
>  	}
>  	breakpoints = calloc(thread_params.nbreakpoints, sizeof(breakpoints[0]));
>  	parallel = calloc(thread_params.nparallel, sizeof(parallel[0]));
> @@ -205,7 +205,7 @@ int bench_breakpoint_enable(int argc, const char **argv)
>  
>  	if (parse_options(argc, argv, enable_options, enable_usage, 0)) {
>  		usage_with_options(enable_usage, enable_options);
> -		exit(EXIT_FAILURE);
> +		__builtin_unreachable();
>  	}
>  	fd = breakpoint_setup(&watched);
>  
> diff --git a/tools/perf/bench/epoll-ctl.c b/tools/perf/bench/epoll-ctl.c
> index d66d852b90e4..330aed478f82 100644
> --- a/tools/perf/bench/epoll-ctl.c
> +++ b/tools/perf/bench/epoll-ctl.c
> @@ -322,7 +322,7 @@ int bench_epoll_ctl(int argc, const char **argv)
>  	argc = parse_options(argc, argv, options, bench_epoll_ctl_usage, 0);
>  	if (argc) {
>  		usage_with_options(bench_epoll_ctl_usage, options);
> -		exit(EXIT_FAILURE);
> +		__builtin_unreachable();
>  	}
>  
>  	memset(&act, 0, sizeof(act));
> diff --git a/tools/perf/bench/epoll-wait.c b/tools/perf/bench/epoll-wait.c
> index 20fe4f72b4af..073fcd5b9977 100644
> --- a/tools/perf/bench/epoll-wait.c
> +++ b/tools/perf/bench/epoll-wait.c
> @@ -441,7 +441,7 @@ int bench_epoll_wait(int argc, const char **argv)
>  	argc = parse_options(argc, argv, options, bench_epoll_wait_usage, 0);
>  	if (argc) {
>  		usage_with_options(bench_epoll_wait_usage, options);
> -		exit(EXIT_FAILURE);
> +		__builtin_unreachable();
>  	}
>  
>  	memset(&act, 0, sizeof(act));
> diff --git a/tools/perf/bench/evlist-open-close.c b/tools/perf/bench/evlist-open-close.c
> index 5a27691469ed..89ae71d8e7e8 100644
> --- a/tools/perf/bench/evlist-open-close.c
> +++ b/tools/perf/bench/evlist-open-close.c
> @@ -231,7 +231,7 @@ int bench_evlist_open_close(int argc, const char **argv)
>  	argc = parse_options(argc, argv, options, bench_usage, 0);
>  	if (argc) {
>  		usage_with_options(bench_usage, options);
> -		exit(EXIT_FAILURE);
> +		__builtin_unreachable();
>  	}
>  
>  	err = target__validate(&opts.target);
> diff --git a/tools/perf/bench/find-bit-bench.c b/tools/perf/bench/find-bit-bench.c
> index 7e25b0e413f6..3a513d8400ca 100644
> --- a/tools/perf/bench/find-bit-bench.c
> +++ b/tools/perf/bench/find-bit-bench.c
> @@ -129,7 +129,7 @@ int bench_mem_find_bit(int argc, const char **argv)
>  	argc = parse_options(argc, argv, options, bench_usage, 0);
>  	if (argc) {
>  		usage_with_options(bench_usage, options);
> -		exit(EXIT_FAILURE);
> +		__builtin_unreachable();
>  	}
>  
>  	for (i = 1; i <= 2048; i <<= 1)
> diff --git a/tools/perf/bench/futex-hash.c b/tools/perf/bench/futex-hash.c
> index b472eded521b..5429210f23e6 100644
> --- a/tools/perf/bench/futex-hash.c
> +++ b/tools/perf/bench/futex-hash.c
> @@ -135,7 +135,7 @@ int bench_futex_hash(int argc, const char **argv)
>  	argc = parse_options(argc, argv, options, bench_futex_hash_usage, 0);
>  	if (argc) {
>  		usage_with_options(bench_futex_hash_usage, options);
> -		exit(EXIT_FAILURE);
> +		__builtin_unreachable();
>  	}
>  
>  	cpu = perf_cpu_map__new_online_cpus();
> diff --git a/tools/perf/bench/futex-lock-pi.c b/tools/perf/bench/futex-lock-pi.c
> index 0416120c091b..751c851d3cce 100644
> --- a/tools/perf/bench/futex-lock-pi.c
> +++ b/tools/perf/bench/futex-lock-pi.c
> @@ -249,5 +249,5 @@ int bench_futex_lock_pi(int argc, const char **argv)
>  	return ret;
>  err:
>  	usage_with_options(bench_futex_lock_pi_usage, options);
> -	exit(EXIT_FAILURE);
> +	__builtin_unreachable();
>  }
> diff --git a/tools/perf/bench/futex-requeue.c b/tools/perf/bench/futex-requeue.c
> index aad5bfc4fe18..037d61f642cc 100644
> --- a/tools/perf/bench/futex-requeue.c
> +++ b/tools/perf/bench/futex-requeue.c
> @@ -310,5 +310,5 @@ int bench_futex_requeue(int argc, const char **argv)
>  	return ret;
>  err:
>  	usage_with_options(bench_futex_requeue_usage, options);
> -	exit(EXIT_FAILURE);
> +	__builtin_unreachable();
>  }
> diff --git a/tools/perf/bench/futex-wake-parallel.c b/tools/perf/bench/futex-wake-parallel.c
> index 4352e318631e..4d20da078fc9 100644
> --- a/tools/perf/bench/futex-wake-parallel.c
> +++ b/tools/perf/bench/futex-wake-parallel.c
> @@ -251,7 +251,7 @@ int bench_futex_wake_parallel(int argc, const char **argv)
>  			     bench_futex_wake_parallel_usage, 0);
>  	if (argc) {
>  		usage_with_options(bench_futex_wake_parallel_usage, options);
> -		exit(EXIT_FAILURE);
> +		__builtin_unreachable();
>  	}
>  
>  	memset(&act, 0, sizeof(act));
> diff --git a/tools/perf/bench/futex-wake.c b/tools/perf/bench/futex-wake.c
> index 49b3c89b0b35..17e67ec28eee 100644
> --- a/tools/perf/bench/futex-wake.c
> +++ b/tools/perf/bench/futex-wake.c
> @@ -146,7 +146,7 @@ int bench_futex_wake(int argc, const char **argv)
>  	argc = parse_options(argc, argv, options, bench_futex_wake_usage, 0);
>  	if (argc) {
>  		usage_with_options(bench_futex_wake_usage, options);
> -		exit(EXIT_FAILURE);
> +		__builtin_unreachable();
>  	}
>  
>  	cpu = perf_cpu_map__new_online_cpus();
> diff --git a/tools/perf/bench/inject-buildid.c b/tools/perf/bench/inject-buildid.c
> index f55c07e4be94..3bc923f5391c 100644
> --- a/tools/perf/bench/inject-buildid.c
> +++ b/tools/perf/bench/inject-buildid.c
> @@ -478,7 +478,7 @@ int bench_inject_build_id(int argc, const char **argv)
>  	argc = parse_options(argc, argv, options, bench_usage, 0);
>  	if (argc) {
>  		usage_with_options(bench_usage, options);
> -		exit(EXIT_FAILURE);
> +		__builtin_unreachable();
>  	}
>  
>  	return do_inject_loops(&data);
> diff --git a/tools/perf/bench/kallsyms-parse.c b/tools/perf/bench/kallsyms-parse.c
> index 2b0d0f980ae9..54620d1eed74 100644
> --- a/tools/perf/bench/kallsyms-parse.c
> +++ b/tools/perf/bench/kallsyms-parse.c
> @@ -68,7 +68,7 @@ int bench_kallsyms_parse(int argc, const char **argv)
>  	argc = parse_options(argc, argv, options, bench_usage, 0);
>  	if (argc) {
>  		usage_with_options(bench_usage, options);
> -		exit(EXIT_FAILURE);
> +		__builtin_unreachable();
>  	}
>  
>  	return do_kallsyms_parse();
> diff --git a/tools/perf/bench/pmu-scan.c b/tools/perf/bench/pmu-scan.c
> index 9e4d36486f62..491c39d63788 100644
> --- a/tools/perf/bench/pmu-scan.c
> +++ b/tools/perf/bench/pmu-scan.c
> @@ -177,7 +177,7 @@ int bench_pmu_scan(int argc, const char **argv)
>  	argc = parse_options(argc, argv, options, bench_usage, 0);
>  	if (argc) {
>  		usage_with_options(bench_usage, options);
> -		exit(EXIT_FAILURE);
> +		__builtin_unreachable();
>  	}
>  
>  	err = run_pmu_scan();
> diff --git a/tools/perf/bench/synthesize.c b/tools/perf/bench/synthesize.c
> index 9b333276cbdb..c1e065159062 100644
> --- a/tools/perf/bench/synthesize.c
> +++ b/tools/perf/bench/synthesize.c
> @@ -242,7 +242,7 @@ int bench_synthesize(int argc, const char **argv)
>  	argc = parse_options(argc, argv, options, bench_usage, 0);
>  	if (argc) {
>  		usage_with_options(bench_usage, options);
> -		exit(EXIT_FAILURE);
> +		__builtin_unreachable();
>  	}
>  
>  	/*
> diff --git a/tools/perf/builtin-check.c b/tools/perf/builtin-check.c
> index 61a11a9b4e75..2f476938f99b 100644
> --- a/tools/perf/builtin-check.c
> +++ b/tools/perf/builtin-check.c
> @@ -170,9 +170,5 @@ int cmd_check(int argc, const char **argv)
>  	/* If no subcommand matched above, print usage help */
>  	pr_err("Unknown subcommand: %s\n", argv[0]);
>  	usage_with_options(check_usage, check_options);
> -
> -	/* free usage string allocated by parse_options_subcommand */
> -	free((void *)check_usage[0]);
> -
> -	return 0;
> +	__builtin_unreachable();
>  }
> diff --git a/tools/perf/builtin-kvm.c b/tools/perf/builtin-kvm.c
> index 67fd2b006b0b..a12a25bbccc9 100644
> --- a/tools/perf/builtin-kvm.c
> +++ b/tools/perf/builtin-kvm.c
> @@ -2126,8 +2126,5 @@ int cmd_kvm(int argc, const char **argv)
>  	else
>  		usage_with_options(kvm_usage, kvm_options);
>  
> -	/* free usage string allocated by parse_options_subcommand */
> -	free((void *)kvm_usage[0]);
> -
> -	return 0;
> +	__builtin_unreachable();
>  }
> diff --git a/tools/perf/builtin-kwork.c b/tools/perf/builtin-kwork.c
> index c41a68d073de..fa6ecd8e9588 100644
> --- a/tools/perf/builtin-kwork.c
> +++ b/tools/perf/builtin-kwork.c
> @@ -2522,8 +2522,5 @@ int cmd_kwork(int argc, const char **argv)
>  	} else
>  		usage_with_options(kwork_usage, kwork_options);
>  
> -	/* free usage string allocated by parse_options_subcommand */
> -	free((void *)kwork_usage[0]);
> -
> -	return 0;
> +	__builtin_unreachable();
>  }
> diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
> index 26ece6e9bfd1..af19b92e33b3 100644
> --- a/tools/perf/builtin-sched.c
> +++ b/tools/perf/builtin-sched.c
> @@ -3965,8 +3965,5 @@ int cmd_sched(int argc, const char **argv)
>  		usage_with_options(sched_usage, sched_options);
>  	}
>  
> -	/* free usage string allocated by parse_options_subcommand */
> -	free((void *)sched_usage[0]);
> -
> -	return 0;
> +	__builtin_unreachable();
>  }
> diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
> index 6ac51925ea42..43cf3d2c0147 100644
> --- a/tools/perf/builtin-trace.c
> +++ b/tools/perf/builtin-trace.c
> @@ -4378,25 +4378,34 @@ static int trace__run(struct trace *trace, int argc, const char **argv)
>  	trace->live = true;
>  
>  	if (!trace->raw_augmented_syscalls) {
> -		if (trace->trace_syscalls && trace__add_syscall_newtp(trace))
> -			goto out_error_raw_syscalls;
> +		if (trace->trace_syscalls && trace__add_syscall_newtp(trace)) {
> +			char errbuf[BUFSIZ];
>  
> +			tracing_path__strerror_open_tp(errno, errbuf, sizeof(errbuf),
> +						       "raw_syscalls", "sys_(enter|exit)");
> +			fprintf(trace->output, "%s\n", errbuf);
> +			goto out_delete_evlist;
> +		}
>  		if (trace->trace_syscalls)
>  			trace->vfs_getname = evlist__add_vfs_getname(evlist);
>  	}
>  
>  	if ((trace->trace_pgfaults & TRACE_PFMAJ)) {
>  		pgfault_maj = evsel__new_pgfault(PERF_COUNT_SW_PAGE_FAULTS_MAJ);
> -		if (pgfault_maj == NULL)
> -			goto out_error_mem;
> +		if (pgfault_maj == NULL) {
> +			fprintf(trace->output, "Not enough memory to run!\n");
> +			goto out_delete_evlist;
> +		}
>  		evsel__config_callchain(pgfault_maj, &trace->opts, &callchain_param);
>  		evlist__add(evlist, pgfault_maj);
>  	}
>  
>  	if ((trace->trace_pgfaults & TRACE_PFMIN)) {
>  		pgfault_min = evsel__new_pgfault(PERF_COUNT_SW_PAGE_FAULTS_MIN);
> -		if (pgfault_min == NULL)
> -			goto out_error_mem;
> +		if (pgfault_min == NULL) {
> +			fprintf(trace->output, "Not enough memory to run!\n");
> +			goto out_delete_evlist;
> +		}
>  		evsel__config_callchain(pgfault_min, &trace->opts, &callchain_param);
>  		evlist__add(evlist, pgfault_min);
>  	}
> @@ -4405,8 +4414,14 @@ static int trace__run(struct trace *trace, int argc, const char **argv)
>  	trace->opts.ignore_missing_thread = trace->opts.target.uid != UINT_MAX || trace->opts.target.pid;
>  
>  	if (trace->sched &&
> -	    evlist__add_newtp(evlist, "sched", "sched_stat_runtime", trace__sched_stat_runtime))
> -		goto out_error_sched_stat_runtime;
> +	    evlist__add_newtp(evlist, "sched", "sched_stat_runtime", trace__sched_stat_runtime)) {
> +		char errbuf[BUFSIZ];
> +
> +		tracing_path__strerror_open_tp(errno, errbuf, sizeof(errbuf),
> +					       "sched", "sched_stat_runtime");
> +		fprintf(trace->output, "%s\n", errbuf);
> +		goto out_delete_evlist;
> +	}
>  	/*
>  	 * If a global cgroup was set, apply it to all the events without an
>  	 * explicit cgroup. I.e.:
> @@ -4465,8 +4480,13 @@ static int trace__run(struct trace *trace, int argc, const char **argv)
>  	}
>  
>  	err = evlist__open(evlist);
> -	if (err < 0)
> -		goto out_error_open;
> +	if (err < 0) {
> +		char errbuf[BUFSIZ];
> +
> +		evlist__strerror_open(evlist, errno, errbuf, sizeof(errbuf));
> +		fprintf(trace->output, "%s\n", errbuf);
> +		goto out_delete_evlist;
> +	}
>  #ifdef HAVE_BPF_SKEL
>  	if (trace->syscalls.events.bpf_output) {
>  		struct perf_cpu cpu;
> @@ -4490,8 +4510,10 @@ static int trace__run(struct trace *trace, int argc, const char **argv)
>  		trace->filter_pids.map = trace->skel->maps.pids_filtered;
>  #endif
>  	err = trace__set_filter_pids(trace);
> -	if (err < 0)
> -		goto out_error_mem;
> +	if (err < 0) {
> +		fprintf(trace->output, "Not enough memory to run!\n");
> +		goto out_delete_evlist;
> +	}
>  
>  #ifdef HAVE_BPF_SKEL
>  	if (trace->skel && trace->skel->progs.sys_enter) {
> @@ -4505,9 +4527,10 @@ static int trace__run(struct trace *trace, int argc, const char **argv)
>  
>  	if (trace->ev_qualifier_ids.nr > 0) {
>  		err = trace__set_ev_qualifier_filter(trace);
> -		if (err < 0)
> -			goto out_errno;
> -
> +		if (err < 0) {
> +			fprintf(trace->output, "errno=%d,%s\n", errno, strerror(errno));
> +			goto out_delete_evlist;
> +		}
>  		if (trace->syscalls.events.sys_exit) {
>  			pr_debug("event qualifier tracepoint filter: %s\n",
>  				 trace->syscalls.events.sys_exit->filter);
> @@ -4532,13 +4555,24 @@ static int trace__run(struct trace *trace, int argc, const char **argv)
>  	if (err)
>  		goto out_delete_evlist;
>  	err = evlist__apply_filters(evlist, &evsel, &trace->opts.target);
> -	if (err < 0)
> -		goto out_error_apply_filters;
> +	if (err < 0) {
> +		char errbuf[BUFSIZ];
> +
> +		fprintf(trace->output,
> +			"Failed to set filter \"%s\" on event %s with %d (%s)\n",
> +			evsel->filter, evsel__name(evsel), errno,
> +			str_error_r(errno, errbuf, sizeof(errbuf)));
> +		goto out_delete_evlist;
> +	}
>  
>  	err = evlist__mmap(evlist, trace->opts.mmap_pages);
> -	if (err < 0)
> -		goto out_error_mmap;
> +	if (err < 0) {
> +		char errbuf[BUFSIZ];
>  
> +		evlist__strerror_mmap(evlist, errno, errbuf, sizeof(errbuf));
> +		fprintf(trace->output, "%s\n", errbuf);
> +		goto out_delete_evlist;
> +	}
>  	if (!target__none(&trace->opts.target) && !trace->opts.target.initial_delay)
>  		evlist__enable(evlist);
>  
> @@ -4646,42 +4680,6 @@ static int trace__run(struct trace *trace, int argc, const char **argv)
>  	trace->evlist = NULL;
>  	trace->live = false;
>  	return err;
> -{
> -	char errbuf[BUFSIZ];
> -
> -out_error_sched_stat_runtime:
> -	tracing_path__strerror_open_tp(errno, errbuf, sizeof(errbuf), "sched", "sched_stat_runtime");
> -	goto out_error;
> -
> -out_error_raw_syscalls:
> -	tracing_path__strerror_open_tp(errno, errbuf, sizeof(errbuf), "raw_syscalls", "sys_(enter|exit)");
> -	goto out_error;
> -
> -out_error_mmap:
> -	evlist__strerror_mmap(evlist, errno, errbuf, sizeof(errbuf));
> -	goto out_error;
> -
> -out_error_open:
> -	evlist__strerror_open(evlist, errno, errbuf, sizeof(errbuf));
> -
> -out_error:
> -	fprintf(trace->output, "%s\n", errbuf);
> -	goto out_delete_evlist;
> -
> -out_error_apply_filters:
> -	fprintf(trace->output,
> -		"Failed to set filter \"%s\" on event %s with %d (%s)\n",
> -		evsel->filter, evsel__name(evsel), errno,
> -		str_error_r(errno, errbuf, sizeof(errbuf)));
> -	goto out_delete_evlist;
> -}
> -out_error_mem:
> -	fprintf(trace->output, "Not enough memory to run!\n");
> -	goto out_delete_evlist;
> -
> -out_errno:
> -	fprintf(trace->output, "errno=%d,%s\n", errno, strerror(errno));
> -	goto out_delete_evlist;
>  }
>  
>  static int trace__replay(struct trace *trace)
> diff --git a/tools/perf/tests/perf-record.c b/tools/perf/tests/perf-record.c
> index 0958c7c8995f..c4bcef4e79e9 100644
> --- a/tools/perf/tests/perf-record.c
> +++ b/tools/perf/tests/perf-record.c
> @@ -67,7 +67,7 @@ static int test__PERF_RECORD(struct test_suite *test __maybe_unused, int subtest
>  	     found_ld_mmap = false;
>  	int err = -1, errs = 0, i, wakeups = 0;
>  	u32 cpu;
> -	int total_events = 0, nr_events[PERF_RECORD_MAX] = { 0, };
> +	int /*total_events = 0, */ nr_events[PERF_RECORD_MAX] = { 0, };
>  	char sbuf[STRERR_BUFSIZE];
>  
>  	perf_sample__init(&sample, /*all=*/false);
> @@ -165,7 +165,7 @@ static int test__PERF_RECORD(struct test_suite *test __maybe_unused, int subtest
>  	evlist__start_workload(evlist);
>  
>  	while (1) {
> -		int before = total_events;
> +		// int before = total_events;
>  
>  		for (i = 0; i < evlist->core.nr_mmaps; i++) {
>  			union perf_event *event;
> @@ -179,7 +179,7 @@ static int test__PERF_RECORD(struct test_suite *test __maybe_unused, int subtest
>  				const u32 type = event->header.type;
>  				const char *name = perf_event__name(type);
>  
> -				++total_events;
> +				//++total_events;
>  				if (type < PERF_RECORD_MAX)
>  					nr_events[type]++;
>  
> @@ -288,8 +288,8 @@ static int test__PERF_RECORD(struct test_suite *test __maybe_unused, int subtest
>  		 * PERF_RECORD_{!SAMPLE} events don't honour
>  		 * perf_event_attr.wakeup_events, just PERF_EVENT_SAMPLE does.
>  		 */
> -		if (total_events == before && false)
> -			evlist__poll(evlist, -1);
> +		// if (total_events == before && false)
> +		//	evlist__poll(evlist, -1);
>  
>  		sleep(1);
>  		if (++wakeups > 5) {
> diff --git a/tools/perf/util/Build b/tools/perf/util/Build
> index 946bce6628f3..fecf39836bb5 100644
> --- a/tools/perf/util/Build
> +++ b/tools/perf/util/Build
> @@ -170,6 +170,7 @@ perf-util-$(CONFIG_PERF_BPF_SKEL) += bpf_ftrace.o
>  perf-util-$(CONFIG_PERF_BPF_SKEL) += bpf_off_cpu.o
>  perf-util-$(CONFIG_PERF_BPF_SKEL) += bpf-filter.o
>  perf-util-$(CONFIG_PERF_BPF_SKEL) += bpf-filter-flex.o
> +CFLAGS_bpf-filter-flex.o += -Wno-unreachable-code
>  perf-util-$(CONFIG_PERF_BPF_SKEL) += bpf-filter-bison.o
>  perf-util-$(CONFIG_PERF_BPF_SKEL) += btf.o
>  
> diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
> index 03211c2623de..5a05b8e293c2 100644
> --- a/tools/perf/util/auxtrace.c
> +++ b/tools/perf/util/auxtrace.c
> @@ -384,7 +384,7 @@ static int auxtrace_queues__add_buffer(struct auxtrace_queues *queues,
>  		if (!buffer->data)
>  			goto out_free;
>  		buffer->data_needs_freeing = true;
> -	} else if (BITS_PER_LONG == 32 &&
> +	} else if (BITS_PER_LONG == (32) &&
>  		   buffer->size > BUFFER_LIMIT_FOR_32_BIT) {
>  		err = auxtrace_queues__split_buffer(queues, idx, buffer);
>  		if (err)
> diff --git a/tools/perf/util/scripting-engines/trace-event-python.c b/tools/perf/util/scripting-engines/trace-event-python.c
> index 520729e78965..ef7e34172659 100644
> --- a/tools/perf/util/scripting-engines/trace-event-python.c
> +++ b/tools/perf/util/scripting-engines/trace-event-python.c
> @@ -116,7 +116,7 @@ static void handler_call_die(const char *handler_name)
>  	Py_FatalError("problem in Python trace event handler");
>  	// Py_FatalError does not return
>  	// but we have to make the compiler happy
> -	abort();
> +	__builtin_unreachable();
>  }
>  
>  /*
> -- 
> 2.49.0.604.gff1f9ca942-goog
> 

