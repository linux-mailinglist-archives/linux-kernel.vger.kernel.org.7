Return-Path: <linux-kernel+bounces-801239-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 49401B44287
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 18:18:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3DC054E5EAC
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 16:18:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBBA622D4DC;
	Thu,  4 Sep 2025 16:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gentwo.org header.i=@gentwo.org header.b="hJ4ukgyj"
Received: from gentwo.org (gentwo.org [62.72.0.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E50741DE3DB
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 16:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.72.0.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757002723; cv=none; b=HepfYnN6EsQ0aSsiCF8ouzWg4i1QyeloPD8soMzysAKAjWiY53lqAdPrxuvU7aQl5pSkxcPhi9agLaAnN8lphRiJI6hwC6+5duvHXY4Jga4F+4FhhlkEFLT7u8MIeE99vlEqiaoxw26hP22Xigaz6pAyWIl/nZXtMs1T1vwFmtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757002723; c=relaxed/simple;
	bh=VBG9/vXIBN3fb0FxBRHUarFNSspP4Y/C7S3ncp+ntPI=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=S92OKbpKb5WUV6Xf/wVhxgm0k79HZkWXVIatm23kIVQtFhgsGlIAMyGgBi7euCM9PiAui9fi0vtg9Jrj3pKKiY5P3pwpaVB3ZunPYWNrEWUgM7VzGBDWRPlo54RtlG4rmqe4eQAsHLMJAX+/WQj89IupSE9EMhi2YWH5WFyBBXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gentwo.org; spf=pass smtp.mailfrom=gentwo.org; dkim=pass (1024-bit key) header.d=gentwo.org header.i=@gentwo.org header.b=hJ4ukgyj; arc=none smtp.client-ip=62.72.0.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gentwo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentwo.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gentwo.org;
	s=default; t=1757002229;
	bh=VBG9/vXIBN3fb0FxBRHUarFNSspP4Y/C7S3ncp+ntPI=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=hJ4ukgyjKj+6XBN7ep1dUFgMkR7BWom3Vr2Wfnish4GvZTPdMjQjULEEqiciJiMLe
	 I/tDll/S6S8chXwfR37Ghr01ALt6mooeq2oP6c7D6GfKzTJwP/gpf3Wf1yIBJvssN1
	 Bu/oVVaYyEgP1k/ofP2gq2yJYcuCkNdxE1gDWrUY=
Received: by gentwo.org (Postfix, from userid 1003)
	id C633F40196; Thu,  4 Sep 2025 09:10:29 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by gentwo.org (Postfix) with ESMTP id C4DF740195;
	Thu,  4 Sep 2025 09:10:29 -0700 (PDT)
Date: Thu, 4 Sep 2025 09:10:29 -0700 (PDT)
From: "Christoph Lameter (Ampere)" <cl@gentwo.org>
To: Frederic Weisbecker <frederic@kernel.org>
cc: Adam Li <adamli@os.amperecomputing.com>, anna-maria@linutronix.de, 
    tglx@linutronix.de, mingo@redhat.com, peterz@infradead.org, 
    juri.lelli@redhat.com, vincent.guittot@linaro.org, vschneid@redhat.com, 
    dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com, 
    mgorman@suse.de, linux-kernel@vger.kernel.org, patches@amperecomputing.com
Subject: Re: [PATCH RESEND 1/2] tick/nohz: Fix wrong NOHZ idle CPU state
In-Reply-To: <aLm4wRwKBMGkekkT@localhost.localdomain>
Message-ID: <6f14ff5c-cddb-f450-b4bb-fcc995b5ce5b@gentwo.org>
References: <20250821042707.62993-1-adamli@os.amperecomputing.com> <20250821042707.62993-2-adamli@os.amperecomputing.com> <aLm4wRwKBMGkekkT@localhost.localdomain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Thu, 4 Sep 2025, Frederic Weisbecker wrote:

> The current state is indeed broken and some people have already tried to fix it.
> The thing is nohz_full don't want dynamic isolation because it is deemed to run a
> single task. Therefore those tasks must be placed manually in order not to break
> isolation guarantees by accident.
>
> In fact nohz_full doesn't make much sense without isolcpus (or isolated cpuset
> v2 partitions) and I even intend to make nohz_full depend on domain isolation
> in the long term.

I have never used isolcpus with nohz_full. AFAICT isolcpus is depreciated
and cpusets are unnecessary complex overhead.


