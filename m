Return-Path: <linux-kernel+bounces-631488-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33733AA88CF
	for <lists+linux-kernel@lfdr.de>; Sun,  4 May 2025 19:54:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99B593AD665
	for <lists+linux-kernel@lfdr.de>; Sun,  4 May 2025 17:53:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EA1D2472AD;
	Sun,  4 May 2025 17:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SZUUxokH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04F90246787;
	Sun,  4 May 2025 17:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746381239; cv=none; b=b435Uu6X9eLX0onSp810PX9i1MgxbMOlY75d7npJI12p7RqB8eAZRPCwOkuNws+PVLqoavnB2khALw/KEdLeUGqgGcJU/elCtjNhMFe6Bt3QW2JvlLXREz/xLYy1K2mvBDpJ1UVBeaZKchsEK5pTJexYcsF8r5Wie3TAAMcEfeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746381239; c=relaxed/simple;
	bh=V9SLCk/s901Jv+xGXp4XjDNnwupvqbB2wZ4BZq2RkY8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MeLBpqu0CFuaBqPxGou3RnVKoJhiht1YmrNgXQpBv8pYKhjPpRSGOYBsaZrl4wXt8Y2WdB1XKQaIC3B0se8mbQ5P+ZtEgYTejwNWA0SzmzNi2/45Vj0icIwAkIf6iUo1aiUDcRGhhaUFcJPR/cRD3kwRshC775YV4S7yVfYdau8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SZUUxokH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 157EDC4CEE9;
	Sun,  4 May 2025 17:53:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746381238;
	bh=V9SLCk/s901Jv+xGXp4XjDNnwupvqbB2wZ4BZq2RkY8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SZUUxokHt1sAAWq9rkEfdZfIudjfuOFApvxhCv/UptRnRIcdnNjcfPj4IOKsNOy50
	 E2nhlN3E869xr5q/6dUKMYzBV0D/l8LtOLn87na2+44+PdZP8KLmnM7xOvg77Ws94f
	 dTFSQ9gtczbvL0zW4QK0sLMwV4DZAGLMRA3xux5P2qWCLQ1cROBpXbcUJE30r/MDZo
	 0K2Vz+qXFKGge4acCpH81HuyvXX16enjmZ+yDW7JgQD8q5Aa3vOOoi5KuOInWYF3Rr
	 lpX95dc8aJ9PFj0S0YT3mYviO+3Cx6ozH7gMx/QaHOsFSzkdTds9yqJrzL7TjDtbsF
	 KiVkYc40uc6ww==
Date: Sun, 4 May 2025 10:53:56 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Peter Zijlstra <peterz@infradead.org>, x86@kernel.org, 
	Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>
Subject: Re: [PATCH v7 01/17] unwind_user: Add user space unwinding API
Message-ID: <bgnoc3j5etfi53otrrn4u23k7ly5ltyun7uhhmw5vhebsqlzgs@bl7ymu7bd74z>
References: <20250502164746.178864972@goodmis.org>
 <20250502165007.549687075@goodmis.org>
 <aBczuIoPIV3kkCnu@gmail.com>
 <20250504124330.6a62e7b5@batman.local.home>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250504124330.6a62e7b5@batman.local.home>

On Sun, May 04, 2025 at 12:43:30PM -0400, Steven Rostedt wrote:
> On Sun, 4 May 2025 11:30:32 +0200
> Ingo Molnar <mingo@kernel.org> wrote:
> 
> > > +struct unwind_user_state {
> > > +	unsigned long ip;
> > > +	unsigned long sp;
> > > +	unsigned long fp;
> > > +	enum unwind_user_type type;
> > > +	bool done;
> > > +};  
> > 
> > Will any of these types be visible to tooling via ABIs?
> 
> Not that I'm aware of. Josh can confirm. Josh?
> 
> With the exception of BTF (which exposes pretty much all structures), I
> believe this is completely internal for the generic code of the unwinder.

Correct, these types are strictly internal to the kernel.

-- 
Josh

