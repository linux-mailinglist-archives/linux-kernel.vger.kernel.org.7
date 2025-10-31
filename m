Return-Path: <linux-kernel+bounces-879442-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 052CFC231ED
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 04:06:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D86C34EBFD5
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 03:06:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7349526CE34;
	Fri, 31 Oct 2025 03:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="yhceSyQ8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A655F2475C7
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 03:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761879978; cv=none; b=nVS8Ij1ihgzF7A3jSb2ZRy/n9qEI6PLMpVcmIrVH0xwfqLgEUwbGXmWdq/MDWKhUKNar0nCFumoAnRXCUR1HHoTDJa901Fl1d5QaMtl3U5US4xwuH8FHqbJh53PCK19BVFphSNWX0OPXmYX9eHrXWAzgOcQ5biVvNHzVdA60TgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761879978; c=relaxed/simple;
	bh=Flp40yoiAjAR6UV8/gN3B+/wUEGD/4eFANODUHrb4OE=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=MD8TUzco33Ebj77VlhB/jUoh+2xPt3xdVkzTT26wmOeIXz3LxOVx/riAPUPE1fyhXvsqu6Xoe7yZ2lzpJ9qptpqsUS6eRLxlut8yNbUN8oV98qRazqPg7oaQi8ypoPG/lRtEmyyEmTUc7HlVLdu5INN158039Wx92Jc9475ODKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=yhceSyQ8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A88EC4CEF1;
	Fri, 31 Oct 2025 03:06:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1761879977;
	bh=Flp40yoiAjAR6UV8/gN3B+/wUEGD/4eFANODUHrb4OE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=yhceSyQ8hqiIOqNstNMiVRmAJdpRqsssmMf2499rYkqyoYkWUG/KKukpjiI2oO5AB
	 PbZUUa51Chgy+BLwOpV+sHHs2fNozH3JgzLhvFk4IBW9TyGh6DXS+lKbtVC27NVgzV
	 p17eNNpW5KGh7eW1wa3/9MkD7ZOuF7Nt8ra6wm8U=
Date: Thu, 30 Oct 2025 20:06:16 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Feng Tang <feng.tang@linux.alibaba.com>, linux-kernel@vger.kernel.org,
 Petr Mladek <pmladek@suse.com>
Subject: Re: [PATCH v3 3/6] panic: sys_info: Replace struct sys_info_name
 with plain array of strings
Message-Id: <20251030200616.741d411b7c44875854e89606@linux-foundation.org>
In-Reply-To: <20251030132007.3742368-4-andriy.shevchenko@linux.intel.com>
References: <20251030132007.3742368-1-andriy.shevchenko@linux.intel.com>
	<20251030132007.3742368-4-andriy.shevchenko@linux.intel.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 30 Oct 2025 12:44:19 +0100 Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> There is no need to keep a custom structure just for the need of
> a plain array of strings. Replace struct sys_info_name with plain
> array of strings.
> 
> With that done, simplify the code, in particular, naturally use
> for_each_set_bit() when iterating over si_bits_global bitmap.
> 
> ...
>
> -static const struct sys_info_name  si_names[] = {
> -	{ SYS_INFO_TASKS,		"tasks" },
> -	{ SYS_INFO_MEM,			"mem" },
> -	{ SYS_INFO_TIMERS,		"timers" },
> -	{ SYS_INFO_LOCKS,		"locks" },
> -	{ SYS_INFO_FTRACE,		"ftrace" },
> -	{ SYS_INFO_ALL_BT,		"all_bt" },
> -	{ SYS_INFO_BLOCKED_TASKS,	"blocked_tasks" },
> +static const char * const si_names[] = {
> +	[ilog2(SYS_INFO_TASKS)]			= "tasks",
> +	[ilog2(SYS_INFO_MEM)]			= "mem",
> +	[ilog2(SYS_INFO_TIMERS)]		= "timers",
> +	[ilog2(SYS_INFO_LOCKS)]			= "locks",
> +	[ilog2(SYS_INFO_FTRACE)]		= "ftrace",
> +	[ilog2(SYS_INFO_PANIC_CONSOLE_REPLAY)]	= "",
> +	[ilog2(SYS_INFO_ALL_BT)]		= "all_bt",
> +	[ilog2(SYS_INFO_BLOCKED_TASKS)]		= "blocked_tasks",
>  };

We have this const_ilog2() which appears to exist to work around a
sparse shortcoming.  But only net/ethtool/common.c uses it - plenty of
other sites do what you've done.

Which makes me wonder whether const_ilog2() can be removed, switch
everything over to ilog2().

