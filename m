Return-Path: <linux-kernel+bounces-819050-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D24F5B59AA4
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 16:45:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D83C63A7104
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 14:41:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25DA83218A7;
	Tue, 16 Sep 2025 14:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YZu3ijss"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AB85221DA5
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 14:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758033684; cv=none; b=KXwb5NIeXl+BhffL67EXuDDiRTyoPg8SZqCxDgkn8O34Ru4zrs6udlSY4zLp1cnD1yfqB3JJfL/JYv1MgqI/yGChdWC4o4pNCMyNOAGufYd+5ulWANcPXLxcoXONbCLaHGAfdXgNe6+LrB5xIAkzQ6fzzMGYJ+mpWOx0n/UnAvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758033684; c=relaxed/simple;
	bh=pmJ6FNI376ycjtQaaN8sACRuV+7IyNdiBXbvSGwTn4I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hmPvM2KEvUpagDvsoZrgqDfXYq747YPDpIbvkQJqQ9LsPCoAnZ+bNG3+m6YyU7qV26rvDyX00znP+x1ncgJKf1mSnwmskxzQNTKV8LESdXFc8bBaymCiwf4PPDq5vAgii2oDsD3ARJBDoKRysUJPX054Lo9LRGFfFooHVmENWp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YZu3ijss; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B066C4CEEB;
	Tue, 16 Sep 2025 14:41:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758033684;
	bh=pmJ6FNI376ycjtQaaN8sACRuV+7IyNdiBXbvSGwTn4I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YZu3ijssENglOnURSerpM3JLIbhS9/hpMCoVqQhWFCXpniBu2lgaawd2xNTfv4uK0
	 JnpYYuGXLpWk90+FMLagcSonqqfnaooTN9wEe9SRLGVNu26OLG9/JRjYxIHB70L4ab
	 YXcPZ5kYoapZGdwLZ4Trt5SFbW87F/uh+1nvgYFBk1X+pCOKe1FNROUDL0QkytGNTI
	 bidl46eVofmaBxLtcF0hKniskx0ZHbbsOSS/rk8TwLp3AvHc5bzZf50IGO5UI9iUFg
	 +P5V7b9EmaXQS7OfqIuJS3aQY0MnuaV+3wOzcKhCmp38KfTNapAH6JJpnioAoJuN/F
	 Sg7urIoXBE0Sw==
Date: Tue, 16 Sep 2025 17:41:15 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Pratyush Yadav <pratyush@kernel.org>
Cc: Pratyush Yadav <me@yadavpratyush.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Alexander Graf <graf@amazon.com>, Baoquan He <bhe@redhat.com>,
	Changyuan Lyu <changyuanl@google.com>, Chris Li <chrisl@kernel.org>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	kexec@lists.infradead.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] kho: add support for preserving vmalloc
 allocations
Message-ID: <aMl3C-jSa1_TBv0K@kernel.org>
References: <20250908103528.2179934-1-rppt@kernel.org>
 <20250908103528.2179934-2-rppt@kernel.org>
 <mafs0ldmon784.fsf@kernel.org>
 <mafs0ldmnlmq0.fsf@yadavpratyush.com>
 <aMgey9qEC_XUejXm@kernel.org>
 <mafs0bjnaimvc.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <mafs0bjnaimvc.fsf@kernel.org>

On Tue, Sep 16, 2025 at 02:48:55PM +0200, Pratyush Yadav wrote:
> On Mon, Sep 15 2025, Mike Rapoport wrote:
> 
> > On Tue, Sep 09, 2025 at 04:33:27PM +0200, Pratyush Yadav wrote:
> >> Hi Mike,
> >> 
> >> Also, I am not a fan of using kho_restore_page() directly. I think the
> >> vmalloc preservation is a layer above core KHO, and it should use the
> >> public KHO APIs. It really doesn't need to poke into internal APIs. If
> >> any of the public APIs are insufficient, we should add new ones.
> >> 
> >> I don't suppose I'd insist on it, but something to consider since you
> >> are likely going to do another revision anyway.
> >
> > I think vmalloc is as basic as folio. At some point we probably converge to 
> > kho_preserve(void *) that will choose the right internal handler. like
> > folio, vmalloc, kmalloc etc.
> 
> Sure, but do you need to use the internal APIs? Because doing this way
> would miss some improvements for the public APIs. See my patch for
> adding more sanity checking to kho_restore_folio() for example:
> https://lore.kernel.org/linux-mm/20250910153443.95049-1-pratyush@kernel.org/
> 
> vmalloc preservation would miss this improvement since it uses the
> internal API, even though it will clearly benefit from it.

The core restore API is kho_restore_page() and the improvements should land
there, IMO.

Then whatever uses that core API will benefit from them.

-- 
Sincerely yours,
Mike.

