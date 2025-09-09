Return-Path: <linux-kernel+bounces-808293-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 68C57B4FD99
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 15:42:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B11B1C64508
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 13:39:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90CA1343D6B;
	Tue,  9 Sep 2025 13:38:09 +0000 (UTC)
Received: from relay.hostedemail.com (smtprelay0016.hostedemail.com [216.40.44.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E98A6215198;
	Tue,  9 Sep 2025 13:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757425089; cv=none; b=qPPYrAXESVlreYIaa+89sRGxdmFpIpBzlnom7bsaI7QtQ+Z/HtqFG2AE9U/7EmHCyY1GqWXZ97unuetaN6hu6BSohjrqv6Fo2kU3aIZupQGXD9Pfc6708gKi88KcwNEcR7S3rPesvzYATuUawH8cFM7TsXfrleOtzA1kIiDVrTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757425089; c=relaxed/simple;
	bh=2BJeKSYyt2QeV17fbx9+Ox1ZHzz/kjSxSb3PMy93A1Y=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LPELenDOLtSx45PtE9r+hwwFKUBgE5VD1fAB441SU6FpwIe4JpQ4ECHassi6HswZn9KlJJBYxiZ0RHJxFtgyRsk6jeQkiopmv85gPCnRgYeojDQlsM6VTydL3SjPANaNQeDAwzEynNENp+m+9bcXA4JfLhvlmj+mSf/36Fz3i58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf10.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay10.hostedemail.com (Postfix) with ESMTP id 3E1F0C0522;
	Tue,  9 Sep 2025 13:38:04 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf10.hostedemail.com (Postfix) with ESMTPA id D27A430;
	Tue,  9 Sep 2025 13:38:00 +0000 (UTC)
Date: Tue, 9 Sep 2025 09:38:48 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Vincent Donnefort <vdonnefort@google.com>
Cc: mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
 linux-trace-kernel@vger.kernel.org, maz@kernel.org, oliver.upton@linux.dev,
 joey.gouly@arm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com,
 kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 jstultz@google.com, qperret@google.com, will@kernel.org,
 aneesh.kumar@kernel.org, kernel-team@android.com,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 03/24] tracing: Introduce trace remotes
Message-ID: <20250909093848.402674b7@gandalf.local.home>
In-Reply-To: <aMAYvA9LSvfxvt_C@google.com>
References: <20250821081412.1008261-1-vdonnefort@google.com>
	<20250821081412.1008261-4-vdonnefort@google.com>
	<20250908193606.47143d09@gandalf.local.home>
	<aMAYvA9LSvfxvt_C@google.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: D27A430
X-Stat-Signature: 1s7jby4e1f59eijakdh5dmnw6a8s4s5n
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+b/T21/hKOjzR7gNCBVyeet5D9OLclCrM=
X-HE-Tag: 1757425080-965095
X-HE-Meta: U2FsdGVkX19VwrFDIvaXh2/25xJubPmnV4q+Sr9wRzIe2LHd9NOD0fypN81SxorUfRNk3louWVAXupbKvR6AOCmY8xCfj+sDUCOjQ8oGOwFNHSJ6YRbmIsjYM8XqtOZsZdSQ4hCfEuM3e9AiUGJsD9nrIdcLRQM9zLWzAWVK9hwbZGIlN7Tdv/KV/Bk5NuYjXXwkQVGMeDrVUrA5os9pgJsBCYk0kJKo33fzgzqt1s7NA2vswDqZN9ZJUAoexPIgv1bq2izsTWIPEl0KhVLd1eR3j6H4waYdR2NxW2whBncEsO54iFRPoRneqfcuqrHpMSD3xgydcOOS5876As3l4P7rFStwpDgM

On Tue, 9 Sep 2025 13:08:28 +0100
Vincent Donnefort <vdonnefort@google.com> wrote:

> > > +		rb_desc = __next_ring_buffer_desc(rb_desc);  
> > 
> > Is there no check to make sure that the cpu mask matches what the rb_desc
> > will have?  
> 
> The function is filling rb_desc[], based on the cpumask input, so both will
> match when returning from this function.
> It is then easy to handle the case where some CPUs are not part of the cpumask.
> See remote_test_load() where for_each_ring_buffer_desc() iterates over all the
> CPUs from the trace_desc but uses rb_desc->cpu.
> 
> Is it what you meant?

I'm more worried about the allocation not being big enough for the rb_desc
being filled. I just noticed that the trace_remote_register() function is
missing a kerneldoc header. Please add one and specify what the parameters
are for as well as their requirements.

It's fine to state that the allocation of desc must match what the cpumask
is. But the lack of comments about what the function does and what is
expected of the parameters makes it hard to know if it is performing
properly.

-- Steve

