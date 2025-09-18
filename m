Return-Path: <linux-kernel+bounces-750236-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 786E8B158F4
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 08:27:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 036FD3B93BD
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 06:27:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DCEB1EFF80;
	Wed, 30 Jul 2025 06:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jgcqt0VY"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F1981EF09B;
	Wed, 30 Jul 2025 06:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753856845; cv=none; b=hSeujtpE9KnVJMK+zcBVHOr4UawNtBfrwUY053scZtJVNcp9kec4XDAr2FTOmBeHAr5VAmO1a8K4q59cHyCx8SUbqd4RoClulhLaVNghtyzREIQsycKJUZzbG0+k29J4UgScevMGqeCG5IESWO85GEuFvQBNHfy/Qm+Lc5oRVR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753856845; c=relaxed/simple;
	bh=t6lKU18geCu0Nksnwnjhpo7QzjaPW74xkwpo0dYYKJQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m32DIgmfoEQNpx6gQor4TUsIaK4G0FatF9zZHL55tt6fX24HGe0SKhA7VErbEMmHOrot+cD0lGAfON7ofXlwKNs521cHmy1z3UdaZl72rXe9wStHmvKaDRI7QiUu39RkjfTaMl0qAc5XkliZ0pCIGhogjz4TIh6Je8Pa7KHDPA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jgcqt0VY; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753856843; x=1785392843;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=t6lKU18geCu0Nksnwnjhpo7QzjaPW74xkwpo0dYYKJQ=;
  b=jgcqt0VYqVQXMiy731Yk3khgnvBogxloRGiYgsCof2lXgneJLBE7CJBc
   pQKsA+Hrbp0MIjyFy5TcYPsUYSq40misBV3cCKAmPJWLebO0ivkeTbWYP
   BIXFYF5IhdoHSwfRpivxWKLJ/9q7opPU30Ngswshklg1JQuxsVRhj2Ya9
   z6VBNhDRZ9bGBV84h7qEhxG22blaY9moOh725pp3Gn6gstU8vEtt/rSZJ
   846nOuu0Bg8iW2DTDPgqgk5dUyO4aHTnm19Nv+y5dsgD62wMq0FYMVfxO
   eNm5fjpzOlbpx1A9DOkagoR5JGCq9X9UTJQ8FJDYLtP6cfqJv0j9sopHN
   Q==;
X-CSE-ConnectionGUID: 1+v09RGPQtusLbAMEpkxyw==
X-CSE-MsgGUID: ZoBAMZRhTciNKvrwfIeDwQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11506"; a="81590258"
X-IronPort-AV: E=Sophos;i="6.16,350,1744095600"; 
   d="scan'208";a="81590258"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2025 23:27:22 -0700
X-CSE-ConnectionGUID: bR1T/FHFQoSIlTb6WTDKbA==
X-CSE-MsgGUID: I9S+ys2JSAqiZKwz0H/ZtA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,350,1744095600"; 
   d="scan'208";a="162487497"
Received: from lkp-server01.sh.intel.com (HELO 160750d4a34c) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 29 Jul 2025 23:27:18 -0700
Received: from kbuild by 160750d4a34c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uh0HT-00026s-2R;
	Wed, 30 Jul 2025 06:27:15 +0000
Date: Wed, 30 Jul 2025 14:27:08 +0800
From: kernel test robot <lkp@intel.com>
To: Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linux Memory Management List <linux-mm@kvack.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH v2 1/2] tracing: Have eprobes have their own config option
Message-ID: <202507301452.JPAcMvT0-lkp@intel.com>
References: <20250729161912.056641407@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250729161912.056641407@kernel.org>

Hi Steven,

kernel test robot noticed the following build errors:

[auto build test ERROR on trace/for-next]
[also build test ERROR on lwn/docs-next akpm-mm/mm-everything linus/master v6.16 next-20250729]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Steven-Rostedt/tracing-Have-eprobes-have-their-own-config-option/20250730-001958
base:   https://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace for-next
patch link:    https://lore.kernel.org/r/20250729161912.056641407%40kernel.org
patch subject: [PATCH v2 1/2] tracing: Have eprobes have their own config option
config: xtensa-randconfig-002-20250730 (https://download.01.org/0day-ci/archive/20250730/202507301452.JPAcMvT0-lkp@intel.com/config)
compiler: xtensa-linux-gcc (GCC) 12.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250730/202507301452.JPAcMvT0-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202507301452.JPAcMvT0-lkp@intel.com/

All errors (new ones prefixed by >>):

   kernel/trace/trace_probe.c: In function 'parse_probe_arg':
>> kernel/trace/trace_probe.c:1105:23: error: implicit declaration of function 'regs_query_register_offset'; did you mean 'ftrace_regs_query_register_offset'? [-Werror=implicit-function-declaration]
    1105 |                 ret = regs_query_register_offset(arg + 1);
         |                       ^~~~~~~~~~~~~~~~~~~~~~~~~~
         |                       ftrace_regs_query_register_offset
   cc1: some warnings being treated as errors


vim +1105 kernel/trace/trace_probe.c

a42e3c4de9642d Masami Hiramatsu          2019-06-20  1080  
8ab83f56475ec9 Srikar Dronamraju         2012-04-09  1081  /* Recursive argument parser */
533059281ee594 Masami Hiramatsu          2018-04-25  1082  static int
533059281ee594 Masami Hiramatsu          2018-04-25  1083  parse_probe_arg(char *arg, const struct fetch_type *type,
533059281ee594 Masami Hiramatsu          2018-04-25  1084  		struct fetch_insn **pcode, struct fetch_insn *end,
1b8b0cd754cdbb Masami Hiramatsu (Google  2023-06-06  1085) 		struct traceprobe_parse_context *ctx)
8ab83f56475ec9 Srikar Dronamraju         2012-04-09  1086  {
533059281ee594 Masami Hiramatsu          2018-04-25  1087  	struct fetch_insn *code = *pcode;
8ab83f56475ec9 Srikar Dronamraju         2012-04-09  1088  	unsigned long param;
e65f7ae7f4da56 Masami Hiramatsu          2019-05-15  1089  	int deref = FETCH_OP_DEREF;
bf173ca92da978 Steven Rostedt (VMware    2018-10-12  1090) 	long offset = 0;
8ab83f56475ec9 Srikar Dronamraju         2012-04-09  1091  	char *tmp;
34fee3a104cea1 Namhyung Kim              2013-11-26  1092  	int ret = 0;
8ab83f56475ec9 Srikar Dronamraju         2012-04-09  1093  
8ab83f56475ec9 Srikar Dronamraju         2012-04-09  1094  	switch (arg[0]) {
8ab83f56475ec9 Srikar Dronamraju         2012-04-09  1095  	case '$':
d157d7694460b9 Masami Hiramatsu (Google  2023-08-23  1096) 		ret = parse_probe_vars(arg, type, pcode, end, ctx);
8ab83f56475ec9 Srikar Dronamraju         2012-04-09  1097  		break;
8ab83f56475ec9 Srikar Dronamraju         2012-04-09  1098  
8ab83f56475ec9 Srikar Dronamraju         2012-04-09  1099  	case '%':	/* named register */
1b8b0cd754cdbb Masami Hiramatsu (Google  2023-06-06  1100) 		if (ctx->flags & (TPARG_FL_TEVENT | TPARG_FL_FPROBE)) {
334e5519c37570 Masami Hiramatsu (Google  2023-06-06  1101) 			/* eprobe and fprobe do not handle registers */
1b8b0cd754cdbb Masami Hiramatsu (Google  2023-06-06  1102) 			trace_probe_log_err(ctx->offset, BAD_VAR);
2673c60ee67e71 Steven Rostedt (Google    2022-08-20  1103) 			break;
2673c60ee67e71 Steven Rostedt (Google    2022-08-20  1104) 		}
8ab83f56475ec9 Srikar Dronamraju         2012-04-09 @1105  		ret = regs_query_register_offset(arg + 1);
8ab83f56475ec9 Srikar Dronamraju         2012-04-09  1106  		if (ret >= 0) {
533059281ee594 Masami Hiramatsu          2018-04-25  1107  			code->op = FETCH_OP_REG;
533059281ee594 Masami Hiramatsu          2018-04-25  1108  			code->param = (unsigned int)ret;
8ab83f56475ec9 Srikar Dronamraju         2012-04-09  1109  			ret = 0;
ab105a4fb89496 Masami Hiramatsu          2019-03-31  1110  		} else
1b8b0cd754cdbb Masami Hiramatsu (Google  2023-06-06  1111) 			trace_probe_log_err(ctx->offset, BAD_REG_NAME);
8ab83f56475ec9 Srikar Dronamraju         2012-04-09  1112  		break;
8ab83f56475ec9 Srikar Dronamraju         2012-04-09  1113  
b7e0bf341f6cfa Namhyung Kim              2013-11-25  1114  	case '@':	/* memory, file-offset or symbol */
8ab83f56475ec9 Srikar Dronamraju         2012-04-09  1115  		if (isdigit(arg[1])) {
bcd83ea6cbfee5 Daniel Walter             2012-09-26  1116  			ret = kstrtoul(arg + 1, 0, &param);
ab105a4fb89496 Masami Hiramatsu          2019-03-31  1117  			if (ret) {
1b8b0cd754cdbb Masami Hiramatsu (Google  2023-06-06  1118) 				trace_probe_log_err(ctx->offset, BAD_MEM_ADDR);
8ab83f56475ec9 Srikar Dronamraju         2012-04-09  1119  				break;
ab105a4fb89496 Masami Hiramatsu          2019-03-31  1120  			}
533059281ee594 Masami Hiramatsu          2018-04-25  1121  			/* load address */
533059281ee594 Masami Hiramatsu          2018-04-25  1122  			code->op = FETCH_OP_IMM;
533059281ee594 Masami Hiramatsu          2018-04-25  1123  			code->immediate = param;
b7e0bf341f6cfa Namhyung Kim              2013-11-25  1124  		} else if (arg[1] == '+') {
b7e0bf341f6cfa Namhyung Kim              2013-11-25  1125  			/* kprobes don't support file offsets */
1b8b0cd754cdbb Masami Hiramatsu (Google  2023-06-06  1126) 			if (ctx->flags & TPARG_FL_KERNEL) {
1b8b0cd754cdbb Masami Hiramatsu (Google  2023-06-06  1127) 				trace_probe_log_err(ctx->offset, FILE_ON_KPROBE);
b7e0bf341f6cfa Namhyung Kim              2013-11-25  1128  				return -EINVAL;
ab105a4fb89496 Masami Hiramatsu          2019-03-31  1129  			}
b7e0bf341f6cfa Namhyung Kim              2013-11-25  1130  			ret = kstrtol(arg + 2, 0, &offset);
ab105a4fb89496 Masami Hiramatsu          2019-03-31  1131  			if (ret) {
1b8b0cd754cdbb Masami Hiramatsu (Google  2023-06-06  1132) 				trace_probe_log_err(ctx->offset, BAD_FILE_OFFS);
b7e0bf341f6cfa Namhyung Kim              2013-11-25  1133  				break;
ab105a4fb89496 Masami Hiramatsu          2019-03-31  1134  			}
b7e0bf341f6cfa Namhyung Kim              2013-11-25  1135  
533059281ee594 Masami Hiramatsu          2018-04-25  1136  			code->op = FETCH_OP_FOFFS;
533059281ee594 Masami Hiramatsu          2018-04-25  1137  			code->immediate = (unsigned long)offset;  // imm64?
8ab83f56475ec9 Srikar Dronamraju         2012-04-09  1138  		} else {
b079d374fd8463 Namhyung Kim              2013-07-03  1139  			/* uprobes don't support symbols */
1b8b0cd754cdbb Masami Hiramatsu (Google  2023-06-06  1140) 			if (!(ctx->flags & TPARG_FL_KERNEL)) {
1b8b0cd754cdbb Masami Hiramatsu (Google  2023-06-06  1141) 				trace_probe_log_err(ctx->offset, SYM_ON_UPROBE);
b079d374fd8463 Namhyung Kim              2013-07-03  1142  				return -EINVAL;
ab105a4fb89496 Masami Hiramatsu          2019-03-31  1143  			}
a6682814f37124 Masami Hiramatsu          2018-08-29  1144  			/* Preserve symbol for updating */
a6682814f37124 Masami Hiramatsu          2018-08-29  1145  			code->op = FETCH_NOP_SYMBOL;
a6682814f37124 Masami Hiramatsu          2018-08-29  1146  			code->data = kstrdup(arg + 1, GFP_KERNEL);
a6682814f37124 Masami Hiramatsu          2018-08-29  1147  			if (!code->data)
a6682814f37124 Masami Hiramatsu          2018-08-29  1148  				return -ENOMEM;
ab105a4fb89496 Masami Hiramatsu          2019-03-31  1149  			if (++code == end) {
1b8b0cd754cdbb Masami Hiramatsu (Google  2023-06-06  1150) 				trace_probe_log_err(ctx->offset, TOO_MANY_OPS);
ab105a4fb89496 Masami Hiramatsu          2019-03-31  1151  				return -EINVAL;
ab105a4fb89496 Masami Hiramatsu          2019-03-31  1152  			}
533059281ee594 Masami Hiramatsu          2018-04-25  1153  			code->op = FETCH_OP_IMM;
a6682814f37124 Masami Hiramatsu          2018-08-29  1154  			code->immediate = 0;
533059281ee594 Masami Hiramatsu          2018-04-25  1155  		}
533059281ee594 Masami Hiramatsu          2018-04-25  1156  		/* These are fetching from memory */
ab105a4fb89496 Masami Hiramatsu          2019-03-31  1157  		if (++code == end) {
1b8b0cd754cdbb Masami Hiramatsu (Google  2023-06-06  1158) 			trace_probe_log_err(ctx->offset, TOO_MANY_OPS);
ab105a4fb89496 Masami Hiramatsu          2019-03-31  1159  			return -EINVAL;
ab105a4fb89496 Masami Hiramatsu          2019-03-31  1160  		}
533059281ee594 Masami Hiramatsu          2018-04-25  1161  		*pcode = code;
533059281ee594 Masami Hiramatsu          2018-04-25  1162  		code->op = FETCH_OP_DEREF;
533059281ee594 Masami Hiramatsu          2018-04-25  1163  		code->offset = offset;
8ab83f56475ec9 Srikar Dronamraju         2012-04-09  1164  		break;
8ab83f56475ec9 Srikar Dronamraju         2012-04-09  1165  
8ab83f56475ec9 Srikar Dronamraju         2012-04-09  1166  	case '+':	/* deref memory */
8ab83f56475ec9 Srikar Dronamraju         2012-04-09  1167  	case '-':
e65f7ae7f4da56 Masami Hiramatsu          2019-05-15  1168  		if (arg[1] == 'u') {
e65f7ae7f4da56 Masami Hiramatsu          2019-05-15  1169  			deref = FETCH_OP_UDEREF;
e65f7ae7f4da56 Masami Hiramatsu          2019-05-15  1170  			arg[1] = arg[0];
e65f7ae7f4da56 Masami Hiramatsu          2019-05-15  1171  			arg++;
e65f7ae7f4da56 Masami Hiramatsu          2019-05-15  1172  		}
e65f7ae7f4da56 Masami Hiramatsu          2019-05-15  1173  		if (arg[0] == '+')
e65f7ae7f4da56 Masami Hiramatsu          2019-05-15  1174  			arg++;	/* Skip '+', because kstrtol() rejects it. */
8ab83f56475ec9 Srikar Dronamraju         2012-04-09  1175  		tmp = strchr(arg, '(');
ab105a4fb89496 Masami Hiramatsu          2019-03-31  1176  		if (!tmp) {
1b8b0cd754cdbb Masami Hiramatsu (Google  2023-06-06  1177) 			trace_probe_log_err(ctx->offset, DEREF_NEED_BRACE);
533059281ee594 Masami Hiramatsu          2018-04-25  1178  			return -EINVAL;
ab105a4fb89496 Masami Hiramatsu          2019-03-31  1179  		}
8ab83f56475ec9 Srikar Dronamraju         2012-04-09  1180  		*tmp = '\0';
bcd83ea6cbfee5 Daniel Walter             2012-09-26  1181  		ret = kstrtol(arg, 0, &offset);
ab105a4fb89496 Masami Hiramatsu          2019-03-31  1182  		if (ret) {
1b8b0cd754cdbb Masami Hiramatsu (Google  2023-06-06  1183) 			trace_probe_log_err(ctx->offset, BAD_DEREF_OFFS);
8ab83f56475ec9 Srikar Dronamraju         2012-04-09  1184  			break;
ab105a4fb89496 Masami Hiramatsu          2019-03-31  1185  		}
1b8b0cd754cdbb Masami Hiramatsu (Google  2023-06-06  1186) 		ctx->offset += (tmp + 1 - arg) + (arg[0] != '-' ? 1 : 0);
8ab83f56475ec9 Srikar Dronamraju         2012-04-09  1187  		arg = tmp + 1;
8ab83f56475ec9 Srikar Dronamraju         2012-04-09  1188  		tmp = strrchr(arg, ')');
ab105a4fb89496 Masami Hiramatsu          2019-03-31  1189  		if (!tmp) {
1b8b0cd754cdbb Masami Hiramatsu (Google  2023-06-06  1190) 			trace_probe_log_err(ctx->offset + strlen(arg),
ab105a4fb89496 Masami Hiramatsu          2019-03-31  1191  					    DEREF_OPEN_BRACE);
ab105a4fb89496 Masami Hiramatsu          2019-03-31  1192  			return -EINVAL;
ab105a4fb89496 Masami Hiramatsu          2019-03-31  1193  		} else {
1b8b0cd754cdbb Masami Hiramatsu (Google  2023-06-06  1194) 			const struct fetch_type *t2 = find_fetch_type(NULL, ctx->flags);
1b8b0cd754cdbb Masami Hiramatsu (Google  2023-06-06  1195) 			int cur_offs = ctx->offset;
8ab83f56475ec9 Srikar Dronamraju         2012-04-09  1196  
8ab83f56475ec9 Srikar Dronamraju         2012-04-09  1197  			*tmp = '\0';
1b8b0cd754cdbb Masami Hiramatsu (Google  2023-06-06  1198) 			ret = parse_probe_arg(arg, t2, &code, end, ctx);
8ab83f56475ec9 Srikar Dronamraju         2012-04-09  1199  			if (ret)
533059281ee594 Masami Hiramatsu          2018-04-25  1200  				break;
1b8b0cd754cdbb Masami Hiramatsu (Google  2023-06-06  1201) 			ctx->offset = cur_offs;
a42e3c4de9642d Masami Hiramatsu          2019-06-20  1202  			if (code->op == FETCH_OP_COMM ||
a42e3c4de9642d Masami Hiramatsu          2019-06-20  1203  			    code->op == FETCH_OP_DATA) {
1b8b0cd754cdbb Masami Hiramatsu (Google  2023-06-06  1204) 				trace_probe_log_err(ctx->offset, COMM_CANT_DEREF);
533059281ee594 Masami Hiramatsu          2018-04-25  1205  				return -EINVAL;
ab105a4fb89496 Masami Hiramatsu          2019-03-31  1206  			}
ab105a4fb89496 Masami Hiramatsu          2019-03-31  1207  			if (++code == end) {
1b8b0cd754cdbb Masami Hiramatsu (Google  2023-06-06  1208) 				trace_probe_log_err(ctx->offset, TOO_MANY_OPS);
ab105a4fb89496 Masami Hiramatsu          2019-03-31  1209  				return -EINVAL;
ab105a4fb89496 Masami Hiramatsu          2019-03-31  1210  			}
533059281ee594 Masami Hiramatsu          2018-04-25  1211  			*pcode = code;
533059281ee594 Masami Hiramatsu          2018-04-25  1212  
e65f7ae7f4da56 Masami Hiramatsu          2019-05-15  1213  			code->op = deref;
533059281ee594 Masami Hiramatsu          2018-04-25  1214  			code->offset = offset;
c440adfbe30257 Masami Hiramatsu (Google  2023-08-23  1215) 			/* Reset the last type if used */
c440adfbe30257 Masami Hiramatsu (Google  2023-08-23  1216) 			ctx->last_type = NULL;
8ab83f56475ec9 Srikar Dronamraju         2012-04-09  1217  		}
8ab83f56475ec9 Srikar Dronamraju         2012-04-09  1218  		break;
6218bf9f4d2942 Masami Hiramatsu          2019-06-20  1219  	case '\\':	/* Immediate value */
a42e3c4de9642d Masami Hiramatsu          2019-06-20  1220  		if (arg[1] == '"') {	/* Immediate string */
1b8b0cd754cdbb Masami Hiramatsu (Google  2023-06-06  1221) 			ret = __parse_imm_string(arg + 2, &tmp, ctx->offset + 2);
a42e3c4de9642d Masami Hiramatsu          2019-06-20  1222  			if (ret)
a42e3c4de9642d Masami Hiramatsu          2019-06-20  1223  				break;
a42e3c4de9642d Masami Hiramatsu          2019-06-20  1224  			code->op = FETCH_OP_DATA;
a42e3c4de9642d Masami Hiramatsu          2019-06-20  1225  			code->data = tmp;
a42e3c4de9642d Masami Hiramatsu          2019-06-20  1226  		} else {
6218bf9f4d2942 Masami Hiramatsu          2019-06-20  1227  			ret = str_to_immediate(arg + 1, &code->immediate);
6218bf9f4d2942 Masami Hiramatsu          2019-06-20  1228  			if (ret)
1b8b0cd754cdbb Masami Hiramatsu (Google  2023-06-06  1229) 				trace_probe_log_err(ctx->offset + 1, BAD_IMM);
6218bf9f4d2942 Masami Hiramatsu          2019-06-20  1230  			else
6218bf9f4d2942 Masami Hiramatsu          2019-06-20  1231  				code->op = FETCH_OP_IMM;
a42e3c4de9642d Masami Hiramatsu          2019-06-20  1232  		}
6218bf9f4d2942 Masami Hiramatsu          2019-06-20  1233  		break;
b576e09701c7d0 Masami Hiramatsu (Google  2023-06-06  1234) 	default:
b576e09701c7d0 Masami Hiramatsu (Google  2023-06-06  1235) 		if (isalpha(arg[0]) || arg[0] == '_') {	/* BTF variable */
25f00e40ce7953 Masami Hiramatsu (Google  2024-03-04  1236) 			if (!tparg_is_function_entry(ctx->flags) &&
25f00e40ce7953 Masami Hiramatsu (Google  2024-03-04  1237) 			    !tparg_is_function_return(ctx->flags)) {
b576e09701c7d0 Masami Hiramatsu (Google  2023-06-06  1238) 				trace_probe_log_err(ctx->offset, NOSUP_BTFARG);
b576e09701c7d0 Masami Hiramatsu (Google  2023-06-06  1239) 				return -EINVAL;
b576e09701c7d0 Masami Hiramatsu (Google  2023-06-06  1240) 			}
c440adfbe30257 Masami Hiramatsu (Google  2023-08-23  1241) 			ret = parse_btf_arg(arg, pcode, end, ctx);
b576e09701c7d0 Masami Hiramatsu (Google  2023-06-06  1242) 			break;
b576e09701c7d0 Masami Hiramatsu (Google  2023-06-06  1243) 		}
8ab83f56475ec9 Srikar Dronamraju         2012-04-09  1244  	}
533059281ee594 Masami Hiramatsu          2018-04-25  1245  	if (!ret && code->op == FETCH_OP_NOP) {
533059281ee594 Masami Hiramatsu          2018-04-25  1246  		/* Parsed, but do not find fetch method */
1b8b0cd754cdbb Masami Hiramatsu (Google  2023-06-06  1247) 		trace_probe_log_err(ctx->offset, BAD_FETCH_ARG);
8ab83f56475ec9 Srikar Dronamraju         2012-04-09  1248  		ret = -EINVAL;
8ab83f56475ec9 Srikar Dronamraju         2012-04-09  1249  	}
8ab83f56475ec9 Srikar Dronamraju         2012-04-09  1250  	return ret;
8ab83f56475ec9 Srikar Dronamraju         2012-04-09  1251  }
8ab83f56475ec9 Srikar Dronamraju         2012-04-09  1252  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

