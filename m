Return-Path: <linux-kernel+bounces-826760-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 496B4B8F450
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 09:22:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 44ADE189F224
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 07:22:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E34062F3C0E;
	Mon, 22 Sep 2025 07:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="OgDKT/Lp"
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EDCA221FCC
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 07:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758525744; cv=none; b=bqy5piQih88QEbBp7iakyG1CJoZKrqx668vvAQFrSOraTORTjRt9ngoqti72SlV9IHgS26PqISFOXVXFRqfn44C+KFp4reJA+obaT9uFwIqaWPWPPIi8IpwG65Gz/uWGCguCau+30fa81Bzdl/vEA+YgTkPIHRlIALMlRRK7L00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758525744; c=relaxed/simple;
	bh=euK4RO5zUm6QVrpPQhkpDL82zcRqCjyUf43cQAFA3vg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XHN8Wbin1NDc84z96DVGmMB1xNCOoSsfEYMATgN0+YsX089mIUvEiOKTub7pDRLWTchPZB0PwanYWWZFXn5PG7XnhpfR/BhATRnuz8kKpY75p85BEkybup/2JcUTJkTtrAyce/HxplNEEWHeMXuDASc3SxHuTsgEs9Iz9HG1fj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=OgDKT/Lp; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1758525727;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=J9OQzHaPNzYm7juBZ16CcNou5B+kBw4zgt0pq74WgRg=;
	b=OgDKT/LpgkQkAdEtUkE0M8mhN791q8lkoNCkEF7hRB9rnCndl6kvDLeg8YHOKpLf/aWkl/
	EiepyWK3fxehbBO3gdKDvVLFUZK0JKKB1Op/S1X/4l7wZ0PhL+vSOkaWIQmF3Iy0UZzC9R
	CmnB89/ITBukVckDVQAW/5IEto4kETM=
From: Menglong Dong <menglong.dong@linux.dev>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Jiri Olsa <jolsa@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, X86 ML <x86@kernel.org>,
 "H. Peter Anvin" <hpa@zytor.com>, Kees Cook <kees@kernel.org>,
 Sami Tolvanen <samitolvanen@google.com>, Mike Rapoport <rppt@kernel.org>,
 Andy Lutomirski <luto@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>,
 Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 LKML <linux-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>
Subject: Re: [PATCH] x86/ibt: make is_endbr() notrace
Date: Mon, 22 Sep 2025 15:21:58 +0800
Message-ID: <2384581.ElGaqSPkdT@7940hx>
In-Reply-To: <20250922071911.GQ3245006@noisy.programming.kicks-ass.net>
References:
 <20250918120939.1706585-1-dongml2@chinatelecom.cn>
 <6196970.lOV4Wx5bFT@7940hx>
 <20250922071911.GQ3245006@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
X-Migadu-Flow: FLOW_OUT

On 2025/9/22 15:19 Peter Zijlstra <peterz@infradead.org> write:
> On Mon, Sep 22, 2025 at 03:13:38PM +0800, menglong.dong@linux.dev wrote:
> 
> > > Anyway, I don't mind making is_endbr() invisible to tracing, that might
> > > just have security benefits too. But I think first the ftrace folks need
> > > to figure out how to best kill that recursion, because I don't think
> > > is_endbr is particularly special here.
> > 
> > So, does this patch seem useful after all?
> 
> The use lies in making it harder to find/manipulate endbr things.
> 
> > OK, I'll send a V2 base on your following suggestion.
> 
> Hold off until Masami/Steve have fixed the ftrace recursion issue. After
> that we can do this.

OK!

> 
> 





