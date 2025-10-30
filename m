Return-Path: <linux-kernel+bounces-878285-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3416BC202D0
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 14:11:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 69F841A26BFD
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 13:11:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83374354AC1;
	Thu, 30 Oct 2025 13:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W4vgHX98"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB7E92C178D
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 13:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761829859; cv=none; b=YPCC0d6zx9rWx5DcpoRDqDWvtw6eu7y2q7FukMREocdZD4H15f7H0XinukAAaARf9hPcxpjl/TsZWZDkVrnnYjyJKQRg+qDSAuitlsYa20l9btST25tQyR6buM8pdyrsT84ZNOaV3H3PTuvEYryRsKiwfL1/EM773f2OTneqL7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761829859; c=relaxed/simple;
	bh=Gp/Jvrf7tHHauieh4rcvoy+5Xgyk613IZ0KbBZlVyfI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RCBFa6rxHuRWQG2B+PJ7gkhlfeQGY1sEe2UMYPZ7lokCu7DT8PdWgTzfEdidDQMGZddMujKg6hDpN5j22Lp10Wt8kFlxg3rQkqByfKba7NNVmk9vmHz6SIQ5O6H4zpQjYj6ikoBFNB1AsZb3STX+hTGvoZCeYh7lpzp7VDKdXNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W4vgHX98; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A259BC4CEF1;
	Thu, 30 Oct 2025 13:10:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761829859;
	bh=Gp/Jvrf7tHHauieh4rcvoy+5Xgyk613IZ0KbBZlVyfI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=W4vgHX98QvlO/PTj0Gf/hxYEUWtXabNzH9PYO+RYW39NWREY7qKXACjHor3pPjPQS
	 ntX+Q3f+OKHhR4cx/ybxv3rnx1jFbOSV82eiJKNz3RqDc5WrJLEhR0PhlnS65pKUzd
	 luzhaZARTpWeZliG0ybHZ8MWecRKYwQoNiiOaIc2tsiDv9iMLsIdRT6SGFSFxk5e3S
	 398yZhFqoKbR+E3nEUua6Yax/7eHWIWvgDg0Dp2NEV+vc2Hlwcs5KdD7oD0vLCaXED
	 REV1Eh7ZmUSuHr8XLN6JE9nylyZSy5tmNgMK7LIG0cEXkjEgvRq2wYF6Bbc+DQEQ0i
	 KnftfuyZgK2jw==
Date: Thu, 30 Oct 2025 13:10:54 +0000
From: Will Deacon <will@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Zhichi Lin <zhichi.lin@vivo.com>, elver@google.com,
	andreyknvl@gmail.com, samitolvanen@google.com, yee.lee@mediatek.com,
	keescook@chromium.org, linux-kernel@vger.kernel.org,
	xiejiyuan@vivo.com
Subject: Re: [PATCH] scs: Fix a wrong parameter in __scs_magic
Message-ID: <aQNj3hLLqq8gUx1j@willie-the-truck>
References: <20251011082222.12965-1-zhichi.lin@vivo.com>
 <20251011101117.0b48ecef0dc7cfdd1f871273@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251011101117.0b48ecef0dc7cfdd1f871273@linux-foundation.org>

On Sat, Oct 11, 2025 at 10:11:17AM -0700, Andrew Morton wrote:
> On Sat, 11 Oct 2025 16:22:22 +0800 Zhichi Lin <zhichi.lin@vivo.com> wrote:
> 
> > __scs_magic() needs a 'void *' variable, but a 'struct task_struct *'
> > is given. 'task_scs(tsk)' is the starting address of the task's shadow
> > call stack, and '__scs_magic(task_scs(tsk))' is the end address of the
> > task's shadow call stack.
> > Here should be '__scs_magic(task_scs(tsk))'.
> 
> What are the userspace-visible runtime effects of this bug?  Please
> always describe this when fixing something.
> 
> > Fixes: 5bbaf9d1fcb9 ("scs: Add support for stack usage debugging")
> 
> This might need backporting into -stable kernels, that depends on the
> answer to the above question.
> 
> > --- a/kernel/scs.c
> > +++ b/kernel/scs.c
> > @@ -135,7 +135,7 @@ static void scs_check_usage(struct task_struct *tsk)
> >  	if (!IS_ENABLED(CONFIG_DEBUG_STACK_USAGE))
> >  		return;
> >  
> > -	for (p = task_scs(tsk); p < __scs_magic(tsk); ++p) {
> > +	for (p = task_scs(tsk); p < __scs_magic(task_scs(tsk)); ++p) {
> >  		if (!READ_ONCE_NOCHECK(*p))
> >  			break;
> >  		used += sizeof(*p);
> 
> Thanks, I'll grab the patch for now, maybe Will would prefer to take it?

Apologies for the slow reply, I was away for a couple of weeks.

It looks like you've already put this in -next (thank you!), so please
go ahead and send it to Linus as a fix.

Acked-by: Will Deacon <will@kernel.org>

Cheers,

Will

