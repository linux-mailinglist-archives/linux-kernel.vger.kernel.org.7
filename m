Return-Path: <linux-kernel+bounces-856005-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EECD5BE2D2F
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 12:35:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C0931A633E7
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 10:35:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF4C32D97A8;
	Thu, 16 Oct 2025 10:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="n9JRPkLF"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65ABF1FDE14;
	Thu, 16 Oct 2025 10:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760610893; cv=none; b=mtfhdj0azGuhLnEZ6h5ghR1/SMlr8utl5g4ukUK5m6R8pJtHem7K83GQYVXzPoMA4kOz/lYj9MqjHlD9hVZff3ntnf347dCRzfXJL+hmsHxrB3O2UbkYhZy86c2HEI+XMuxuN5BCNFGau3Vwt95apC42ALgnYgSepjyYOtZbYHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760610893; c=relaxed/simple;
	bh=VZDy0vrN8u7n/1W5AyMEFHFQCIwaQ3bG9u+5tTcVhok=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FsES22jI9IgR2BhAwqzcsKv1KpzoSgexB72YfJcgGBC6qvcugtFB6luwD1avFkoA96wD3VBji3vfBaFYQIJkxNVgyOf1IN/4TGYGbOzzYz1yWddDXX6Gzn6a1lM6o9RPc1ky9AGufWuoIVtBazoUwMgwMwjuzE+FlRp55yG+wfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=n9JRPkLF; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760610891; x=1792146891;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=VZDy0vrN8u7n/1W5AyMEFHFQCIwaQ3bG9u+5tTcVhok=;
  b=n9JRPkLFHwLm6/puM/PV0+npuahmhNQHqxVgV1EIGDEU8lzyKiOFKywY
   fdtCRlOAdjKIXjRaRy/mDs8HjWnIWdQWMa2uRsq4Mw4+023x8Zpj/j23l
   G/508gPA1slz5XDpB6LAWO926N6pZ+CMiWLSXI3vpRcvA7/Cn7vBiOR3x
   bxREWX45CccgoFjUG9BwjVqgJNldC8JifHDrc8nTS9GHXuWZfsD7VEWrI
   WjU1Vy+35Ne3EBFmP9bDnYui22GOReMdv6Cay9X+/jzmjmrzT7mUcEVvX
   xVetYuVZKicmeleCccuUFl8fUqPSlWXhz9s1yCX9pMWMcNMvyPEjtCVCd
   Q==;
X-CSE-ConnectionGUID: OpUQQCenSheuNOKDsz4sqA==
X-CSE-MsgGUID: Z1BYVp9zRTa4pWTvK7tW6g==
X-IronPort-AV: E=McAfee;i="6800,10657,11583"; a="66662337"
X-IronPort-AV: E=Sophos;i="6.19,233,1754982000"; 
   d="scan'208";a="66662337"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2025 03:34:51 -0700
X-CSE-ConnectionGUID: IkronhQIRV+O9w2fLMS2OA==
X-CSE-MsgGUID: WGp9F29oRwqrVtgcUTtTxg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,233,1754982000"; 
   d="scan'208";a="187514273"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by orviesa005.jf.intel.com with ESMTP; 16 Oct 2025 03:34:45 -0700
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1v9LJR-0004hr-1H;
	Thu, 16 Oct 2025 10:34:30 +0000
Date: Thu, 16 Oct 2025 18:33:19 +0800
From: kernel test robot <lkp@intel.com>
To: Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linux Memory Management List <linux-mm@kvack.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Takaya Saeki <takayas@google.com>, Tom Zanussi <zanussi@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ian Rogers <irogers@google.com>,
	Douglas Raillard <douglas.raillard@arm.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Ingo Molnar <mingo@redhat.com>
Subject: Re: [PATCH v3 13/13] tracing: Have persistent ring buffer print
 syscalls normally
Message-ID: <202510161708.yF2I7Qqq-lkp@intel.com>
References: <20251015173550.225723717@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251015173550.225723717@kernel.org>

Hi Steven,

kernel test robot noticed the following build errors:

[auto build test ERROR on akpm-mm/mm-everything]
[also build test ERROR on linus/master v6.18-rc1 next-20251015]
[cannot apply to trace/for-next acme/perf/core]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Steven-Rostedt/tracing-Make-trace_user_fault_read-exposed-to-rest-of-tracing/20251016-014059
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/20251015173550.225723717%40kernel.org
patch subject: [PATCH v3 13/13] tracing: Have persistent ring buffer print syscalls normally
config: s390-randconfig-001-20251016 (https://download.01.org/0day-ci/archive/20251016/202510161708.yF2I7Qqq-lkp@intel.com/config)
compiler: clang version 18.1.8 (https://github.com/llvm/llvm-project 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251016/202510161708.yF2I7Qqq-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202510161708.yF2I7Qqq-lkp@intel.com/

All errors (new ones prefixed by >>):

>> kernel/trace/trace.c:4258:26: error: use of undeclared identifier 'enter_syscall_print_funcs'
    4258 |                             (event->funcs != &enter_syscall_print_funcs) &&
         |                                               ^
>> kernel/trace/trace.c:4259:26: error: use of undeclared identifier 'exit_syscall_print_funcs'
    4259 |                             (event->funcs != &exit_syscall_print_funcs))
         |                                               ^
   kernel/trace/trace.c:11443:32: error: use of undeclared identifier 'CONFIG_TRACE_SYSCALL_BUF_SIZE_DEFAULT'
    11443 |         global_trace.syscall_buf_sz = CONFIG_TRACE_SYSCALL_BUF_SIZE_DEFAULT;
          |                                       ^
   3 errors generated.


vim +/enter_syscall_print_funcs +4258 kernel/trace/trace.c

  4222	
  4223	static enum print_line_t print_trace_fmt(struct trace_iterator *iter)
  4224	{
  4225		struct trace_array *tr = iter->tr;
  4226		struct trace_seq *s = &iter->seq;
  4227		unsigned long sym_flags = (tr->trace_flags & TRACE_ITER_SYM_MASK);
  4228		struct trace_entry *entry;
  4229		struct trace_event *event;
  4230	
  4231		entry = iter->ent;
  4232	
  4233		test_cpu_buff_start(iter);
  4234	
  4235		event = ftrace_find_event(entry->type);
  4236	
  4237		if (tr->trace_flags & TRACE_ITER_CONTEXT_INFO) {
  4238			if (iter->iter_flags & TRACE_FILE_LAT_FMT)
  4239				trace_print_lat_context(iter);
  4240			else
  4241				trace_print_context(iter);
  4242		}
  4243	
  4244		if (trace_seq_has_overflowed(s))
  4245			return TRACE_TYPE_PARTIAL_LINE;
  4246	
  4247		if (event) {
  4248			if (tr->trace_flags & TRACE_ITER_FIELDS)
  4249				return print_event_fields(iter, event);
  4250			/*
  4251			 * For TRACE_EVENT() events, the print_fmt is not
  4252			 * safe to use if the array has delta offsets
  4253			 * Force printing via the fields.
  4254			 */
  4255			if ((tr->text_delta)) {
  4256				/* ftrace and system call events are still OK */
  4257				if ((event->type > __TRACE_LAST_TYPE) &&
> 4258				    (event->funcs != &enter_syscall_print_funcs) &&
> 4259				    (event->funcs != &exit_syscall_print_funcs))
  4260				return print_event_fields(iter, event);
  4261			}
  4262			return event->funcs->trace(iter, sym_flags, event);
  4263		}
  4264	
  4265		trace_seq_printf(s, "Unknown type %d\n", entry->type);
  4266	
  4267		return trace_handle_return(s);
  4268	}
  4269	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

