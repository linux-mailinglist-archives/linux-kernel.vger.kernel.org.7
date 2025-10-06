Return-Path: <linux-kernel+bounces-842511-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B3A2BBCE71
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 02:27:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD2B53B6B82
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 00:27:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C98A318FDBE;
	Mon,  6 Oct 2025 00:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FGnQqJAI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CEE315667D
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 00:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759710468; cv=none; b=uAtf1CkMQV79gfARWcLch1ZGBA+mx7ZGqXha/nPxMp+LiEmuxKWZu2XDhdv3ajadrL85+sxm5VmZoh4bFV1J0/XTWOzF4g6OgFvTecyNG+S7SDJFCL20uJPf89OwXS9CvlbAcQXeOTboEIvgjmxZbO/p4DibGC9v7uEkPv0oAhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759710468; c=relaxed/simple;
	bh=X5cVIO8baff3ScFfSO+chK+gXKaeiJ49jcjJ5QYjaQo=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=mB0GIhnj3LG4ZHjEYt2jFUQewQCKlVzGdBqrVFKsIul8xlFH0CRDP8TAGL8XP1mRfwdODBu9YSZKgAU1T4Oao9reuyCkoHSDmymtLK7X6WFiYBV3xC6kGAArbP0xycNHOKnF6P5aAEIs1AMjPedWzieCwbgKoKyGRkZDqAksA9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FGnQqJAI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1040C4CEF4;
	Mon,  6 Oct 2025 00:27:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759710467;
	bh=X5cVIO8baff3ScFfSO+chK+gXKaeiJ49jcjJ5QYjaQo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=FGnQqJAIKQYB8NMl+bspoFySbEmGY2Uz8P68kowqfQ17lim0iJX0D2xDTOJxcB2et
	 z6qZe80RybiTXxCDCh8uciyRYHDT9L+QkRytE9HHBi2k2BLnf8Hz7BXRVcuCcURDTJ
	 QcV+ZUdQNS9ThhPwehKGkN67p6FL71yEdN46lpjNCBnKySlIZg8qfvjSn34e8bftd6
	 8JFAy06Uyca3Kj0H0bfgxiELiLQagYcuum/pNqkA4//I0lfDAZvN6SoDOtOthF4M0a
	 lpoiV5c/0xAHswDF/Qhfy+zxbLG3f7eS7kYWbvH6Xocsgdu5tf7W0RSHBspLnzqXr7
	 B0rZEuDGK9ctA==
Date: Mon, 6 Oct 2025 09:27:43 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Menglong Dong <menglong8.dong@gmail.com>, Thorsten Blum
 <thorsten.blum@linux.dev>, Steven Rostedt <rostedt@goodmis.org>,
 linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] probes: Update for v6.18
Message-Id: <20251006092743.295205e486acf1b69ca61b89@kernel.org>
In-Reply-To: <CAHk-=wg6=DwTD7xT3=Zya-ytYrtS2969KtnTWRPskq5fx2Ev+g@mail.gmail.com>
References: <20251003084426.f2de6028fd74e1af4e13d190@kernel.org>
	<CAHk-=wg6=DwTD7xT3=Zya-ytYrtS2969KtnTWRPskq5fx2Ev+g@mail.gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Sun, 5 Oct 2025 09:20:29 -0700
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Thu, 2 Oct 2025 at 16:44, Masami Hiramatsu <mhiramat@kernel.org> wrote:
> >
> > - wprobe: Introduce a watchpoint probe event based on hw_breakpoint.
> 
> This doesn't even build.
> 
>   kernel/trace/trace_wprobe.c: In function ‘__register_trace_wprobe’:
>   kernel/trace/trace_wprobe.c:176:20: error: cast to generic address
> space pointer from disjoint ‘__seg_gs’ address space pointer [-Werror]
> 
> and I see from the code that it has tried to brute-force it with an
> ugly cast, and it still is horribly horribly wrong.

Hmm, I applogise this error. I locally ran build tests and it passed.
But I might missed something.

> 
> The fix for compiler errors is basically never to just add a random
> cast. That will just make things worse, and in this case that
> 'IS_ERR()' function literally exists to find bad users like this.

OK.

> 
> I wondered why this hadn't been reported in linux-next, and the reason
> appears simple: none of this has BEEN in linux-next.
> 
> So no. I'm not pulling this. This violates all the regular rules for
> sending me new development, and then it doesn't even compile.
> 
> Since the pointer is a percpu pointer, the trivial fix is ato use the
> per-cpu specific functions (IS_ERR_PCPU(), PTR_ERR_PCPU(), etc).

OK.

> 
> However, since this wasn't in linux-next, that's not what I'm doing.
> 
> This is not getting pulled for 6.18 AT ALL, and for 6.19 it had better
> be in linux-next for a LOONG time.

Got it. Sorry about my mistake. Let me fix it on for-next, and
keep checking it is in linux-next and tested well.

Thank you,

> 
>            Linus


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

