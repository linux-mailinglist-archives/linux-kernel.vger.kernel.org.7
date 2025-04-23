Return-Path: <linux-kernel+bounces-615312-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 96D72A97B8B
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Apr 2025 02:12:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 96C3C1B61BCC
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Apr 2025 00:13:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B410DEC4;
	Wed, 23 Apr 2025 00:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Onhd3FHc"
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD0D18BEC
	for <linux-kernel@vger.kernel.org>; Wed, 23 Apr 2025 00:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745367167; cv=none; b=hje5GbJnGdD6yGOo+D3ggQKKykjYWY0ylKoLkdN85YsXfhxRak8rK46nxnqlIAVmVvEeCqCv0kuRUhZbUarilrap+0ErBwRr9auncxHDHNF5AIbRuEhMTt/0XSTO+CspIH8APTnDansPaDNnoqf7TVj/fIe3cWyz9qPIF6EM04E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745367167; c=relaxed/simple;
	bh=0Bg7GKhaJNgYElTeYrTXobRx9z3pfoLdQeFBBrjtsAQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CaJwWlsjlGXTbLMgcelFu8jmFNYOCTfjrxgCMCgRkK/ezSwN8eNR8U2LZFH+1G1mrUA2KO6unLTZe3WxOzvfZ8+YNwiA06DOA5vfCieoRWnx3TJJNqR3Q47CjYo30pW0wi74z3eVqVR7bKaL2ezi58BxH2UufSlb7TKXvDL1Wf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Onhd3FHc; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 22 Apr 2025 17:12:36 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1745367161;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=70rBAlR0qVsBxIj85/MzbQ/zQlV/awU58P9W9ld1or0=;
	b=Onhd3FHccHw6U3RedmsYOTaQfanX3ARpVxQkzwZelGFUvFqD+KHm8pWfNIBTRSpew1k9IQ
	bviRnZlx5wLa7l3rkcaiuz7ML4dqJoX25D1I8qPAhz5NZAlPylhSdkcQCrF6IbfgQqfVZ2
	7+MnVCstxmZhj5hIgTre8897ap41Y04=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Michael Larabel <Michael@phoronix.com>
Cc: Dave Airlie <airlied@gmail.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Alexei Starovoitov <alexei.starovoitov@gmail.com>, Sebastian Sewior <bigeasy@linutronix.de>, 
	Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, 
	Alexei Starovoitov <ast@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 6.15-rc3
Message-ID: <mhewqdlvb5ahqordw2nuebq7yvsxo7xvdas4vl6gehmbmypcil@v3fn7nzllglj>
References: <CAHk-=wgjZ4fzDKogXwhPXVMA7OmZf9k0o1oB2FJmv-C1e=typA@mail.gmail.com>
 <CAPM=9tzj_OBFJNsN9j7nMs4OR3=V9yrPmaH7VvN-KNYUYhf-vQ@mail.gmail.com>
 <CAADnVQ+KnfDLd-=Mg1BDJxCf80K_=RN0dJy_yp681gf1dQMhtg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQ+KnfDLd-=Mg1BDJxCf80K_=RN0dJy_yp681gf1dQMhtg@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

Ccing Michael

On Tue, Apr 22, 2025 at 04:37:59PM -0700, Alexei Starovoitov wrote:
> On Tue, Apr 22, 2025 at 4:01 PM Dave Airlie <airlied@gmail.com> wrote:
> >
> > > Alexei Starovoitov (2):
> > >       locking/local_lock, mm: replace localtry_ helpers with
> > > local_trylock_t type
> >
> > This seems to have upset some phoronix nginx workload
> > https://www.phoronix.com/review/linux-615-nginx-regression/2
> 
> 3x regression? wow.
> Thanks for heads up.
> I'm staring at the patch and don't see it.
> Adding more experts.

Hi Michael,

Can you please share a bit more on your nginx workload and how can we
reproduce locally? In the mean time, I can try netperf locally to
reproduce.

I do have some followup optimizations [1, 2] which hopefully are aimed
for next release but we can try those as well.

[1] https://lkml.kernel.org/r/20250416180229.2902751-1-shakeel.butt@linux.dev
[2] https://lkml.kernel.org/r/20250410025752.92159-1-shakeel.butt@linux.dev

thanks,
Shakeel

