Return-Path: <linux-kernel+bounces-732900-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DC72B06D7E
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 08:00:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 59D1E1AA3724
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 06:00:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3502A2E88BD;
	Wed, 16 Jul 2025 05:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QVR3GIao"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8857317D2;
	Wed, 16 Jul 2025 05:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752645598; cv=none; b=a+JDvznsoRCmzJIGnREZEnVdS8xgRdeGjoODuYq9CZRa9Uz54rsEkhVqP200IHVXAgWGUBrPZyDMEvOl/SVVyLuYpPT/0pCJ0+lC1aKJoP1SCAlqWj7sd/Wp0Ez8+lFtVnwnZThab8IcxeglRhV3EZAFEChhZ89xO59vJRkypWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752645598; c=relaxed/simple;
	bh=RaEV9yK8YW7NoqQi03NiaVlozt06p1HwyWjvdwJeNcQ=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=HL4CKUau5MrFx0//ZwstfoU/Q9Q1/B6KNAh6L8Q+xqWp8D25MgOXO2Jz5gg6ROq5/3Fr6na4IZObXTZPLxlbXohlgMC0NsTdgw3I0JVwQQ3/7GGEg5k5gPnuNhamUBnKUUrPf65EF8YbnRFy4bAajpKqcM06TMzLHDiXqvttNmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QVR3GIao; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8096EC4CEF5;
	Wed, 16 Jul 2025 05:59:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752645598;
	bh=RaEV9yK8YW7NoqQi03NiaVlozt06p1HwyWjvdwJeNcQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=QVR3GIao9s0EZ7T4iXMxDlbroBBBMEdQPbVSs3nLs8s2+jcjE3AmtE9egWHytLPUy
	 0jrPRafDodWOQbdd1Keq5xKHvGgPpPR1Kvh/qUs9zTyAdLuAhWqAdt/rvHFNPCaMqj
	 mnfxo5cJq0tjj+hD/60NLR24KwB4vWnTFort/ZQGLTea2Tv5gf3kHnOAjkMBayqEzu
	 HDmXePnEWWrPbS2MwhFX+Kczvo2PyZX75cXJngLsp8Dt6AArAYoxcAtCUZHNhtIefB
	 0MzPWIjtA3FA2dO7taUUbiZkXljZr17BSOceBoz02QNI1MkqTcs+jjYKjgerxxrozO
	 o54LhpUSiqjDg==
Date: Wed, 16 Jul 2025 14:59:54 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: kernel test robot <lkp@intel.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
 linux-kernel@vger.kernel.org, "Steven Rostedt (Google)"
 <rostedt@goodmis.org>
Subject: Re: kernel/trace/trace_fprobe.c:1264:12: warning: stack frame size
 (1032) exceeds limit (1024) in 'trace_fprobe_create_cb'
Message-Id: <20250716145954.93465b106813127bad546ed0@kernel.org>
In-Reply-To: <202506240416.nZIhDXoO-lkp@intel.com>
References: <202506240416.nZIhDXoO-lkp@intel.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 24 Jun 2025 04:18:46 +0800
kernel test robot <lkp@intel.com> wrote:

> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   86731a2a651e58953fc949573895f2fa6d456841
> commit: 57faaa04804ccbf16582f7fc7a6b986fd0c0e78c tracing: probe-events: Log error for exceeding the number of arguments
> date:   3 months ago
> config: s390-defconfig (https://download.01.org/0day-ci/archive/20250624/202506240416.nZIhDXoO-lkp@intel.com/config)
> compiler: clang version 21.0.0git (https://github.com/llvm/llvm-project 875b36a8742437b95f623bab1e0332562c7b4b3f)
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250624/202506240416.nZIhDXoO-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202506240416.nZIhDXoO-lkp@intel.com/
> 
> All warnings (new ones prefixed by >>):
> 
> >> kernel/trace/trace_fprobe.c:1264:12: warning: stack frame size (1032) exceeds limit (1024) in 'trace_fprobe_create_cb' [-Wframe-larger-than]
>     1264 | static int trace_fprobe_create_cb(int argc, const char *argv[])
>          |            ^
>    1 warning generated.

Hmm, maybe this includes the stack consumed by internal
inlined function (trace_fprobe_create_internal()). If so,
we can allocate some temporary buffer in it.

Thanks, 

> 
> 
> vim +/trace_fprobe_create_cb +1264 kernel/trace/trace_fprobe.c
> 
> 8275637215bd3d4 Masami Hiramatsu (Google  2025-01-17  1263) 
> 8275637215bd3d4 Masami Hiramatsu (Google  2025-01-17 @1264) static int trace_fprobe_create_cb(int argc, const char *argv[])
> 8275637215bd3d4 Masami Hiramatsu (Google  2025-01-17  1265) {
> 8275637215bd3d4 Masami Hiramatsu (Google  2025-01-17  1266) 	struct traceprobe_parse_context ctx = {
> 8275637215bd3d4 Masami Hiramatsu (Google  2025-01-17  1267) 		.flags = TPARG_FL_KERNEL | TPARG_FL_FPROBE,
> 8275637215bd3d4 Masami Hiramatsu (Google  2025-01-17  1268) 	};
> 8275637215bd3d4 Masami Hiramatsu (Google  2025-01-17  1269) 	int ret;
> 8275637215bd3d4 Masami Hiramatsu (Google  2025-01-17  1270) 
> 8275637215bd3d4 Masami Hiramatsu (Google  2025-01-17  1271) 	trace_probe_log_init("trace_fprobe", argc, argv);
> 8275637215bd3d4 Masami Hiramatsu (Google  2025-01-17  1272) 	ret = trace_fprobe_create_internal(argc, argv, &ctx);
> b1d1e90490b6714 Masami Hiramatsu (Google  2023-08-23  1273) 	traceprobe_finish_parse(&ctx);
> 334e5519c375701 Masami Hiramatsu (Google  2023-06-06  1274) 	trace_probe_log_clear();
> 334e5519c375701 Masami Hiramatsu (Google  2023-06-06  1275) 	return ret;
> 334e5519c375701 Masami Hiramatsu (Google  2023-06-06  1276) }
> 334e5519c375701 Masami Hiramatsu (Google  2023-06-06  1277) 
> 
> :::::: The code at line 1264 was first introduced by commit
> :::::: 8275637215bd3d447b31d37f9b8231a013adb042 tracing: Adopt __free() and guard() for trace_fprobe.c
> 
> :::::: TO: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> :::::: CC: Steven Rostedt (Google) <rostedt@goodmis.org>
> 
> -- 
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

