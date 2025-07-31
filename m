Return-Path: <linux-kernel+bounces-752111-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 07380B17151
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 14:34:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F225FA804B4
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 12:33:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D23E222A7EF;
	Thu, 31 Jul 2025 12:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4kozBWDA";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xdAvVktV"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FD0C1E4A9
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 12:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753965261; cv=none; b=rd2s5LMpiZAT+FXW2tUlZCLXj66PBARmEiwggKigv6aL6xGl0ZwGcB5o7C3wRqNtO76UoXaeE7fSh8YiF6Bsdh7Ql2HFqgB5DtZ1hE37FwPUvuuH5FQKAlWv2FdYgiuffpIN9kX7c+KfTciIPke2MjDHBB06RIBdWATDVNGMUoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753965261; c=relaxed/simple;
	bh=rSCXRgHcs2dB8mW64lEFFzUSj87HxZJq3hBFWyGj4vo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WJVm8X16jmrHgHTlR79F+Xnct9OqChJ1s8xq/cpMxQar+aogo4VQ0lUEsB0AKEB5r5M4kI5glAObgP7IWfSCO5W34XXI16XeZNtd7XraeMWXLP3NPw96yhxGCidmZF4NpIgeEZynUajhP+0WBEDXoyR6MfkCSnrSlXYAxJztFZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4kozBWDA; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xdAvVktV; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1753965257;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=piJPPQK15+eacRq11wpIMXBC/ANS/3ROU0AjgU8/DEw=;
	b=4kozBWDACIVhk4AgSuW/LaKzqZqADa6eKZMGovRkMoOf/hzdNjOpwtk8qagoGPrIWVZAG9
	xissf/I8eiGpk7XaKSz90Ag8avWnR19R5ZV0tUKIih9Uv5pi8r91+7Nym6Qdaeqle85DL/
	xzxbzFCkWyqVOZSFGS9xveczlMO4v85xXNe2DJR5NbHvSVrLnojhHUzOAhWphaLMtaVBbi
	Wiwj+t2kt1kO3PXeebnupBSEbO/shcHDWGoYVGr06cvfIgQWpTSq3g/WIUoWLlxmQawxbR
	SfbXH6Z68mTgyNSnCoztqDKb/kbtz2nB1ISFaEjTf5VypiWKVXhs/1T4BXmpcQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1753965257;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=piJPPQK15+eacRq11wpIMXBC/ANS/3ROU0AjgU8/DEw=;
	b=xdAvVktV1g1FyNPxMs0xsHnY1ekC79OJ0tsUeBduMM8PqPzOb1qQE+MUlHSyRMdQAHFOn9
	jgz20NZw3U6fN3DQ==
To: Oliver Sang <oliver.sang@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, oe-lkp@lists.linux.dev,
 lkp@intel.com, linux-kernel@vger.kernel.org, x86@kernel.org, Sebastian
 Andrzej Siewior <bigeasy@linutronix.de>, linux-mm@kvack.org,
 ltp@lists.linux.it, oliver.sang@intel.com
Subject: Re: [tip:locking/futex] [futex]  56180dd20c:
 BUG:sleeping_function_called_from_invalid_context_at_kernel/nsproxy.c
In-Reply-To: <aIrJipeLsGUM92+R@xsang-OptiPlex-9020>
References: <202507231021.dcf24373-lkp@intel.com> <87a54usty4.ffs@tglx>
 <aINKAQt3qcj2s38N@xsang-OptiPlex-9020> <87seikp94v.ffs@tglx>
 <aIgUUhKWesDpM0BJ@xsang-OptiPlex-9020> <87wm7ro3r7.ffs@tglx>
 <aIrJipeLsGUM92+R@xsang-OptiPlex-9020>
Date: Thu, 31 Jul 2025 14:34:15 +0200
Message-ID: <87cy9gilo8.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Oliver!

On Thu, Jul 31 2025 at 09:40, Oliver Sang wrote:
> On Tue, Jul 29, 2025 at 09:27:56AM +0200, Thomas Gleixner wrote:
>> > but bot seems not be able to capture other new dmesg stats.
>> 
>> Ah. The tracer does not dump on warnings by default. You need
>> 'panic_on_warn' on the command line as well. Forgot about that earlier.
>
> attached one dmesg FYI.

Hmm, that trace dump was cut off before it completed by a reset
(probably your test timeout).

Either you make the timeout longer or try the following on the kernel
command line instead of 'ftrace_dump_on_cpu':

       ftrace_dump_on_oops=orig_cpu trace_buf_size=100K

That reduces the output to the CPU which triggers the problem and with a
smaller buffer.

Thanks,

        tglx

