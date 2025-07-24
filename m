Return-Path: <linux-kernel+bounces-745098-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BA26B114DD
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 01:46:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73D125A5A16
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 23:46:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD6FD247288;
	Thu, 24 Jul 2025 23:46:04 +0000 (UTC)
Received: from relay.hostedemail.com (smtprelay0016.hostedemail.com [216.40.44.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDF4323505F;
	Thu, 24 Jul 2025 23:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753400764; cv=none; b=ZnIJhTj3NdHgCwxMJ2ym2qbwEE8xBAlz4zPe6oAD55JDBdSAaaEjc1M6myhhTDng7DI6rqkfvrjdYyADAEwPuvAF7jRaMG9RfWFJhDly+movtXN++u3uXV8lfLkiGxT1xGSIv7J2tR/Byku9VkENiayRqWTeELjMPNvZWTC6Nsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753400764; c=relaxed/simple;
	bh=9YsPgnjWiFE8FdaTddixtOAuCO18p0RNAZIkar0SXDQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GJq3c9+to4+fjhUJFA+h8gqaJjqj84Cr0DsBaYYlxxA9mJyXbETs2rlGU010KTdS6VIl4OdWF6MzA8nPk5+a2dSO1gPSr+3POG/MWtKQw7K36sfnaCm0iSrBnLhdoMMqFpXlCSYgw5DQrDhQwHH50An9VQu85CJzSOA1QtNvPLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf06.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay04.hostedemail.com (Postfix) with ESMTP id 3EE581A0555;
	Thu, 24 Jul 2025 23:45:55 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf06.hostedemail.com (Postfix) with ESMTPA id 564AA2000E;
	Thu, 24 Jul 2025 23:45:53 +0000 (UTC)
Date: Thu, 24 Jul 2025 19:45:56 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Kees Cook <kees@kernel.org>
Cc: "Dr. David Alan Gilbert" <linux@treblig.org>, Konstantin Ryabitsev
 <konstantin@linuxfoundation.org>, corbet@lwn.net,
 workflows@vger.kernel.org, josh@joshtriplett.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] docs: submitting-patches: (AI?) Tool disclosure tag
Message-ID: <20250724194556.105803db@gandalf.local.home>
In-Reply-To: <202507241418.34AFD28C@keescook>
References: <20250724175439.76962-1-linux@treblig.org>
	<20250724-alluring-fuzzy-tanuki-6e8282@lemur>
	<202507241337.F9595E1D@keescook>
	<aIKhvubVqgeXIlrj@gallifrey>
	<202507241418.34AFD28C@keescook>
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
X-Rspamd-Queue-Id: 564AA2000E
X-Stat-Signature: jcmte6d8p7mnsf3r15shzxhp6q18wgfc
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+yNO9VbZbkVyeRZNPi2XKXi8bwscADxmE=
X-HE-Tag: 1753400753-595998
X-HE-Meta: U2FsdGVkX19PziNYj9FSpPojIyDzoh8bU6QlLhFo+pNW3MfsqwxWIOojJmLaAjiovssyW07wjHEfRrDHqbQu+DUCY/F1jFPeCK0nF5ZFHkAGivFhHAksQEhB+ufD9I0b77VfqG1Ji5ge69PP7hMqHaKd3eKgaw5kILDXzdrhZFlEgk8QmnWmKmpjW1mw9t3GiZIu9sut8FHTGdfI8yw6F21e4/ivmhiajbm7iN7VevVEdk0d/wvK8wzRD1pBGr0VFoWcEn/aMMSla3/+uxOZ4QIoHRT2xgq+RqZpn8UQEvp8UGjbhnigpYafhaGmHD4qkSBFTiukJRqNx8lmtvwq/DlR42Y8q++rM0T3fqMEIybsPUJM3LelVl8RwgKrVHA9ojACsbod+eIQEWGDOlMwdg==

On Thu, 24 Jul 2025 14:20:03 -0700
Kees Cook <kees@kernel.org> wrote:

> On Thu, Jul 24, 2025 at 09:12:30PM +0000, Dr. David Alan Gilbert wrote:
> > * Kees Cook (kees@kernel.org) wrote:  
> > > [...]
> > > do for Coccinelle or other scripts. It's a bit buried in the Researcher
> > > Guidelines[1], but we have explicitly asked for details about tooling:
> > > 
> > >   When sending patches produced from research, the commit logs should
> > >   contain at least the following details, so that developers have
> > >   appropriate context for understanding the contribution.
> > >   ...
> > >   Specifically include details about any testing, static or dynamic
> > >   analysis programs, and any other tools or methods used to perform the
> > >   work.
> > > 
> > > Maybe that needs to be repeated in SubmittingPatches?  
> > 
> > 'produced from research' is narrowing things down a bit too much I think
> > when it's people using the tools as their normal way of working.  

So I did bring this up in the last TAB meeting. I brought it up because I
found out from reading an LWN[1] article that I received a patch fully
written in AI without knowledge that it was written with AI. If I had known,
I would have examined the patch a little more thoroughly, and would have
discovered a very minor mistake in the patch.

> 
> Right -- as currently written we have the explicit guideline for
> "produced from research" and kind of an unwritten rule to detail any
> complex tools involved for regular development (e.g. Coccinelle,
> syzkaller, etc). We could generalize the existing statement and repeat
> it in a better location?

When a patch is generated by Coccinelle, checkpatch or any other tool, it
should most definitely be mentioned in the change log.

I strongly believe the same goes for AI. Now the argument is where do we
draw the line? If you are using AI that helps write your code, do you need
to disclose it every time?

My thought is to treat AI as another developer. If a developer helps you
like the AI is helping you, would you give that developer credit for that
work? If so, then you should also give credit to the tooling that's helping
you.

I suggested adding a new tag to note any tool that has done non-trivial
work to produce the patch where you give it credit if it has helped you as
much as another developer that you would give credit to.

-- Steve


[1] https://lwn.net/Articles/1026558/

