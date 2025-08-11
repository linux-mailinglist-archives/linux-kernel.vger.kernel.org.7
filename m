Return-Path: <linux-kernel+bounces-762004-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 136E5B200F9
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 09:57:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A41316D12D
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 07:57:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B6F32D9ED7;
	Mon, 11 Aug 2025 07:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="nPpi8pn4"
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C1D12798FA
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 07:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754899032; cv=none; b=ChDsl8eEC5Dx+yZuRMPJsHP5PqvO4Yoi4Cqwd3rBgPi0gOivRC5bp1YUTT0IuhiRmD8SddYkFG0R729Ay/quKx6JSnRRLTcvH+8x8IX+fCGjAjyVkIn92SUuC3SspnSCOB1i6XbbysW9QKsv4BFxpTLeWqlV2/RB0srM6VYBKHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754899032; c=relaxed/simple;
	bh=Qdo4ojJNPKgsV72XrkScA6AEe0K8cZSsHAEJhABiejg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SzNXw5qXA2Fg+HowuNDoFVSeLsNSZfQ35y19XPju/oeyQuquBPn7xWGRtmlss85FvrVfyq/ofob/AGLmQ7o/Z1SwA6fNfLCi4cuNUKzgq7DD9OUkCSVbLwDrOj6flDpAyHhxcFpY2HIl1oCOFWkWOGwCj5RLmgD1t5gADons3IQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=nPpi8pn4; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <87c18bb9-b2a7-4326-b163-01641ffff065@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1754899017;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xGtRyL+J38IPEDlsw/c4flcu7oDXk2oXjvYy0dtAjgY=;
	b=nPpi8pn4DguGTM479/w/xESMlTuHMwIaLRdULa1+Qs4/TSYXDO8XquKmnKy0sLwyZ2J8Fr
	R8IOVBy8A/SzTzyjdYVyFTwhcCkYB3aW4f2CN81r0r4GXva6227AhNk5WIZNpoOfO+b7nT
	NCb4n4ZJOpvtNLo/UqcD/LW3RPyYU/A=
Date: Mon, 11 Aug 2025 15:55:53 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] Minor documentation fixes
Content-Language: en-US
To: Bojanala Hithashri <bojanalahithashri@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
References: <20250722191139.7195-1-bojanalahithashri@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kunwu Chan <kunwu.chan@linux.dev>
In-Reply-To: <20250722191139.7195-1-bojanalahithashri@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2025/7/23 03:11, Bojanala Hithashri wrote:
> Signed-off-by: Bojanala Hithashri <bojanalahithashri@gmail.com>
> ---
>   Documentation/block/data-integrity.rst                | 2 +-
>   Documentation/bpf/standardization/instruction-set.rst | 2 +-
>   Documentation/cdrom/cdrom-standard.rst                | 2 +-
>   Documentation/trace/boottime-trace.rst                | 2 +-
>   Documentation/trace/events.rst                        | 2 +-
>   Documentation/trace/fprobe.rst                        | 2 +-
>   6 files changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/Documentation/block/data-integrity.rst b/Documentation/block/data-integrity.rst
> index 99905e880a0e..b7b10c8abbcc 100644
> --- a/Documentation/block/data-integrity.rst
> +++ b/Documentation/block/data-integrity.rst
> @@ -154,7 +154,7 @@ bio_free() will automatically free the bip.
>   ----------------
>   
>   Block devices can set up the integrity information in the integrity
> -sub-struture of the queue_limits structure.
> +sub-structure of the queue_limits structure.
>   
>   Layered block devices will need to pick a profile that's appropriate
>   for all subdevices.  queue_limits_stack_integrity() can help with that.  DM
> diff --git a/Documentation/bpf/standardization/instruction-set.rst b/Documentation/bpf/standardization/instruction-set.rst
> index fbe975585236..746eb3c421eb 100644
> --- a/Documentation/bpf/standardization/instruction-set.rst
> +++ b/Documentation/bpf/standardization/instruction-set.rst
> @@ -350,7 +350,7 @@ Underflow and overflow are allowed during arithmetic operations, meaning
>   the 64-bit or 32-bit value will wrap. If BPF program execution would
>   result in division by zero, the destination register is instead set to zero.
>   Otherwise, for ``ALU64``, if execution would result in ``LLONG_MIN``
> -dividing -1, the desination register is instead set to ``LLONG_MIN``. For
> +dividing -1, the destination register is instead set to ``LLONG_MIN``. For
>   ``ALU``, if execution would result in ``INT_MIN`` dividing -1, the
>   desination register is instead set to ``INT_MIN``.
>   
> diff --git a/Documentation/cdrom/cdrom-standard.rst b/Documentation/cdrom/cdrom-standard.rst
> index 6c1303cff159..22dc6db04a14 100644
> --- a/Documentation/cdrom/cdrom-standard.rst
> +++ b/Documentation/cdrom/cdrom-standard.rst
> @@ -89,7 +89,7 @@ CD-ROM devices behave **exactly** the same (insofar as the underlying
>   hardware will allow).
>   
>   The goal of the Uniform CD-ROM Driver is **not** to alienate driver developers
> -whohave not yet taken steps to support this effort. The goal of Uniform CD-ROM
> +who have not yet taken steps to support this effort. The goal of Uniform CD-ROM
>   Driver is simply to give people writing application programs for CD-ROM drives
>   **one** Linux CD-ROM interface with consistent behavior for all
>   CD-ROM devices. In addition, this also provides a consistent interface
> diff --git a/Documentation/trace/boottime-trace.rst b/Documentation/trace/boottime-trace.rst
> index d594597201fd..62646130e1a2 100644
> --- a/Documentation/trace/boottime-trace.rst
> +++ b/Documentation/trace/boottime-trace.rst
> @@ -198,7 +198,7 @@ Most of the subsystems and architecture dependent drivers will be initialized
>   after that (arch_initcall or subsys_initcall). Thus, you can trace those with
>   boot-time tracing.
>   If you want to trace events before core_initcall, you can use the options
> -starting with ``kernel``. Some of them will be enabled eariler than the initcall
> +starting with ``kernel``. Some of them will be enabled earlier than the initcall
>   processing (for example,. ``kernel.ftrace=function`` and ``kernel.trace_event``
>   will start before the initcall.)
>   
> diff --git a/Documentation/trace/events.rst b/Documentation/trace/events.rst
> index 2d88a2acacc0..c35f640e1cdc 100644
> --- a/Documentation/trace/events.rst
> +++ b/Documentation/trace/events.rst
> @@ -629,7 +629,7 @@ following:
>     - tracing synthetic events from in-kernel code
>     - the low-level "dynevent_cmd" API
>   
> -7.1 Dyamically creating synthetic event definitions
> +7.1 Dynamically creating synthetic event definitions
>   ---------------------------------------------------
>   
>   There are a couple ways to create a new synthetic event from a kernel
> diff --git a/Documentation/trace/fprobe.rst b/Documentation/trace/fprobe.rst
> index 71cd40472d36..d632073408d6 100644
> --- a/Documentation/trace/fprobe.rst
> +++ b/Documentation/trace/fprobe.rst
> @@ -118,7 +118,7 @@ will be cancelled.
>   @fregs
>           This is the `ftrace_regs` data structure at the entry and exit. This
>           includes the function parameters, or the return values. So user can
> -        access thos values via appropriate `ftrace_regs_*` APIs.
> +        access those values via appropriate `ftrace_regs_*` APIs.
>   
>   @entry_data
>           This is a local storage to share the data between entry and exit handlers.

lgtm


Reviewed-by: Kunwu Chan <kunwu.chan@linux.dev>

-- 
Thanks,
        Kunwu Chan.


