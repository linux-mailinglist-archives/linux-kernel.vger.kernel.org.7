Return-Path: <linux-kernel+bounces-808948-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EA37FB506C3
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 22:12:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA3783BAFB2
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 20:12:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2514C3019D6;
	Tue,  9 Sep 2025 20:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qCd694x+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CD7F1D799D;
	Tue,  9 Sep 2025 20:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757448759; cv=none; b=WwLKM4XL/QvgSg2hija7ldnUgEqiwUOdxjQFhBLRzcA3pVQoDXlV3Rbn5vaee4VGqrMFCBrc7mug/WVEmIFLha9okCq7ukkedVL/OnatIUsaV+srr8yD01xvAToKtwe4hQp13osrjDuHAwqNrRd0ioWS7KWUdw8WAS6gvk6VxLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757448759; c=relaxed/simple;
	bh=3Q8yWau11/4sARhotXIQGFUob7A5LZjQAGqLaZ5h1ms=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TBawgogLDwxepYkoH6CraJ0LqUUj8zYu3LQCVlmMz27WEtsid8+Eq1BTwWv8ap0Jp8kGtsmiAYAuRUEgdTzYNPdarw7vvL3GEr4ZuKJpJzo3om0T2vKR8CV2g5WTcr8cxiOBkO8oJJ3XVItIJM5RZYWtWja3FcoC59jYYHukhOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qCd694x+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C39EEC4CEF4;
	Tue,  9 Sep 2025 20:12:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757448759;
	bh=3Q8yWau11/4sARhotXIQGFUob7A5LZjQAGqLaZ5h1ms=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qCd694x+xF7oQZlVmKxsA3K+368LN5LDag9BIgfXZII3UKH98+1k5vHw+fgJSZ/qm
	 0aRufwOPhQ7VTnTq3cp0CYcNPeio+N9OxvQrC/Nf4IArSl08hNcyc01uK+3Net+bW+
	 OpI4NnOqnVC2a5iJ9o/gaWnFXpOT7yejLgZ/Et7ERStX2pU3J/8huoNFKA69bLih/V
	 HdbtMuJRmDLYXuk0B6Zo3N1guu8lsTQ3ZgrU5sVAOWU4AtPao+R/KiBzQQNL3bIFUu
	 SKTpt37K3xvMlZtzkehsawycJrOKQbYN6DgxwN5xhZEsHy0KRak3vwJ4nH1KaszJnq
	 2qXFWVzrnbuTQ==
Date: Tue, 9 Sep 2025 22:12:34 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Linux Doc Mailing List <linux-doc@vger.kernel.org>, Jonathan Corbet
 <corbet@lwn.net>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kernel-doc: add support for handling global variables
Message-ID: <20250909221234.059fe52d@foz.lan>
In-Reply-To: <5cec20da-b8a6-4db9-ab4f-78ec6b327d28@infradead.org>
References: <80f85eacc306e62de8c9c68712c653ba290c2ff2.1757262141.git.mchehab+huawei@kernel.org>
	<20250907233447.0cbe9954@foz.lan>
	<5cec20da-b8a6-4db9-ab4f-78ec6b327d28@infradead.org>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Em Mon, 8 Sep 2025 23:22:13 -0700
Randy Dunlap <rdunlap@infradead.org> escreveu:

> On 9/7/25 2:34 PM, Mauro Carvalho Chehab wrote:
> > Em Sun,  7 Sep 2025 18:22:22 +0200
> > Mauro Carvalho Chehab <mchehab+huawei@kernel.org> escreveu:
> >   
> >> Specially on kAPI, sometimes it is desirable to be able to
> >> describe global variables that are part of kAPI.
> >>
> >> Documenting vars with Sphinx is simple, as we don't need
> >> to parse a data struct. All we need is the variable
> >> declaration and use natice C domain ::c:var: to format it
> >> for us.
> >>
> >> Add support for it.
> >>
> >> Link: https://lore.kernel.org/linux-doc/491c3022-cef8-4860-a945-c9c4a3b63c09@infradead.org/T/#m947c25d95cb1d96a394410ab1131dc8e9e5013f1
> >> Suggested-by: Randy Dunlap <rdunlap@infradead.org>
> >> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>  
> > 
> > Btw, this is still at RFC level, as, for the final version we need:
> > 
> > - to document this new kernel-doc feature;  
> 
> Yes, I thought of that one.
> 
> > - to suppress (or keep) the end ";";  
> 
> I'll need to see it, but I expect I would prefer to suppress it.

Ok. Yeah, that's probably the better.

> > - do some cleanups/improvements at the regex to ensure that it is generic
> >   enough. For instance, the way it was defineded, it doesn't handle yet
> >   variables with assigned values like:
> > 	extern int foo = 5;
> > - if it has a default non-zero value, should it be documented or not,
> >   and, if so, how;  
> 
> I think I came up with some examples (test cases) like these without even
> knowing that you had singled them out as possible issues.

Sounds good. Yeah, having some real-case scenarios will help discovering
what else we need for the regex and for the output.

> > - to decide if we add "extern" to all outputs, to none of them or if we
> >   just follow what is at the documented declaration (the current
> >   implementation does the latter;  
> 
> Follow what is documented for now (as you have it).

Ok.

> > - to decide weather use "global"/"var" or something else.  
> 
> Just stick with "global". It's fine.

Ok.

> > Also, it would be interesting to have a real case where we want
> > to document kAPI variables.
> > 
> > Randy,
> > 
> > if you have some real case examples, perhaps you could pick this patch
> > and add on a patch series after taking the above into consideration.  
> 
> I just searched for some real case examples and came up with around 6 from
> various source files. I put them into one source file that I will include
> in a Documentation/ .rst file for testing and let you know how that goes.
> 
> Sorry for the delay. I've had some other things going on.

No problem. Take your time.

> Thanks for working on the feature.

Anytime.

Thanks,
Mauro

