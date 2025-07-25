Return-Path: <linux-kernel+bounces-745132-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BF3FBB11572
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 02:55:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C48991CC82D0
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 00:56:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB934166F1A;
	Fri, 25 Jul 2025 00:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="T9iFiWIa"
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FD99BA3D;
	Fri, 25 Jul 2025 00:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753404941; cv=none; b=FZAbRtChTuN36Nyht6ZFbC9Vr1PDQN1zoRG12QWM5qTP1WSNhHfMHDarRzW55s+hBzNp8/iCPSxOal+ZVrNnAu8Pqw9GrqMDnAZpAIG9tk2YbIoB4VIKJfdJbaLF8AEqw3E1zj6cNR7sGy0myFA8XD9uFaoRSk7AvDBnrbuYP5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753404941; c=relaxed/simple;
	bh=KvxN5DHjZGSXEwli5Su3Qm7vJiM8XvRrYqw6i3BZUkQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YDJiPLaAfHLD6/K0OTjawtb3wYw6cO8jnvzCB2uX9iQuIY5QE+G9c2M+cbnUZM22Mp5LsJ8NGyoQPORyxpgNrgjaCqjBDrwEhEA2Mp4pqr747mjIhWBYH+g10AuCvd/e9nLga6Mp6YKlyRRYtCeW4TRcz4+Tq2T/P0vjd5wv0Pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=T9iFiWIa; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
	:Subject; bh=StlREuo1scS0BfmCy3StaAeIUyCF5tPTsycVVaKcV94=; b=T9iFiWIagMi1C/Et
	gM5OuOyS+mMLiTMpLXVy/Qq4acvvgpRuwIiZCX6tEUSHgEeW2JA7f9gIJhOXXYgct4xOPzOhG9d7r
	FIfobPC6NrE5FHXJLlY4YbnKbQrO94NmDu+HqdjC3oTiOtJNgjuLmsvWczVoY62ziePsTOWjxVOOH
	UWNUsdlAJDg1Gt0clsjjx/Fpav8+UWOTRQI43YD4Zc76/CmG2mY0jKYc3ALgNCPgkff60OktqBMfH
	OeSYxHIkpAjRV+DlouvgOtU2CN9CW6soAJ0yaXjGBI8STCqTP5DSXLrXZGkVayFf+jlYPjltBhBxQ
	NeOQ9dgdYkzISq5rLw==;
Received: from dg by mx.treblig.org with local (Exim 4.96)
	(envelope-from <dg@treblig.org>)
	id 1uf6ie-000WVV-0z;
	Fri, 25 Jul 2025 00:55:28 +0000
Date: Fri, 25 Jul 2025 00:55:28 +0000
From: "Dr. David Alan Gilbert" <linux@treblig.org>
To: Kees Cook <kees@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
	corbet@lwn.net, workflows@vger.kernel.org, josh@joshtriplett.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] docs: submitting-patches: (AI?) Tool disclosure tag
Message-ID: <aILWAELwozskfIgj@gallifrey>
References: <20250724175439.76962-1-linux@treblig.org>
 <20250724-alluring-fuzzy-tanuki-6e8282@lemur>
 <202507241337.F9595E1D@keescook>
 <aIKhvubVqgeXIlrj@gallifrey>
 <202507241418.34AFD28C@keescook>
 <20250724194556.105803db@gandalf.local.home>
 <202507241651.5E9C803C70@keescook>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <202507241651.5E9C803C70@keescook>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.1.0-34-amd64 (x86_64)
X-Uptime: 00:53:00 up 88 days,  9:06,  1 user,  load average: 0.00, 0.00, 0.00
User-Agent: Mutt/2.2.12 (2023-09-09)

* Kees Cook (kees@kernel.org) wrote:
> On Thu, Jul 24, 2025 at 07:45:56PM -0400, Steven Rostedt wrote:
> > My thought is to treat AI as another developer. If a developer helps you
> > like the AI is helping you, would you give that developer credit for that
> > work? If so, then you should also give credit to the tooling that's helping
> > you.
> > 
> > I suggested adding a new tag to note any tool that has done non-trivial
> > work to produce the patch where you give it credit if it has helped you as
> > much as another developer that you would give credit to.
> 
> We've got tags to choose from already in that case:
> 
> Suggested-by: LLM

For me, 'Suggested-by:' seems fine for where an LLM has
responded to a 'suggest improvements to this function'.

> or
> 
> Co-developed-by: LLM <not@human.with.legal.standing>
> Signed-off-by: LLM <not@human.with.legal.standing>
> 
> The latter seems ... not good, as it implies DCO SoB from a thing that
> can't and hasn't acknowledged the DCO.

Yeh, the Co-developed-by:  isn't terrible,  but in both that and the
Suggested-by: is there a standard for how you would refer to the tool?
IMHO it should not have an email address there otherwise it'll confuse tools 
into cc'ing them.

Dave

> 
> -- 
> Kees Cook
> 
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

