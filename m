Return-Path: <linux-kernel+bounces-790806-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8C8FB3AD49
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 00:10:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3672C16F0CA
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 22:10:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CD3029B8E2;
	Thu, 28 Aug 2025 22:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HwtaVXms"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BE12196C7C
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 22:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756419010; cv=none; b=iyHaNlep4xX6t16uZmA5DIUzNjPgi/33ui9S5Ys7GTuaWsSwE9fLktBaRshj5PgrEWgaE8EW8bZDJzd6FPR8WzQGysviv0r3r/CnMq7jEe7XmrQ43WBqsKgGYGDvMH4BV19JOFYgfI31phrYam+mg3ThKIBShAXKzOrhV3yORHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756419010; c=relaxed/simple;
	bh=ntDuM+i2CiJdrfEvKVb4hG8nZ7wLSjf/cPPhPWDtEaA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KZkwPaPL1u8343gzVrzOs2FOpyQPljNP+NV16I6eCbejPas33QLnoV9oyXoVpeKP2tlFvECnjIIiSCdJlaE55eipbILBLdTtp75dtbhElPfV2PCNWY0KQt8jT2A9+a9W5MbepnL+AMzzFv7GFrIRPHqoYFiey7A22wYUdtSAsEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HwtaVXms; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3c985f13d45so988605f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 15:10:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756419007; x=1757023807; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=skVMf4Y64VvWuVdkg790UsFu5YpWQWWVSI/rnXUaOE8=;
        b=HwtaVXmsDbvKvK2y2Z+w6LWxmHF+BSKbkDxzYC7wzOsRO6up538kncIswe0AzcCmDi
         W2xPlSEfURPevJvEGLMjBK0AhXzBxZTFB0nh1kR7ePGoxp0lCbY7DV1kuRyIqYLCe6d0
         mjrqiJuAiO31t7kdSuzPHT7sxYXrhcZbgS/SMDOvnh77QGXs92WfNCRWKhHwnAFi9SCa
         x/W9V3T8SXaxysgBsVOAXM8byyplLdP19e/Bg3CoxJLi/7Zc3dojcmMfh19BoDZeJc9i
         8vRu70EcSSwjZK+P24W5XiXAeMSkuXKrf6v3YGrqf0RzgYsUScRa62fchXB+vYmZyQLb
         53Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756419007; x=1757023807;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=skVMf4Y64VvWuVdkg790UsFu5YpWQWWVSI/rnXUaOE8=;
        b=UtaeuUqi/kPysiywSwN//BHbMc5AqmmSSNSwpmDhxWvvmMEpo/kWwdB4im/h6h5Qod
         HGc4KJcND21x2ZC+Gjv56FYj/pNDl7qcxir1sQgmEE4GQ3FfjZKnvmaeFTzmMrqF4YOq
         Ns9WUpukwYHFhRe5lHybjqQSLTN2Ei+kSgN4JCYs4swkK2/F47KCDUjXYtmD45Yaa6kK
         SgZjjSvgFt/FWf0kvq9+wcOB/kFM0EOPKZz6ohrzGMe7j6nkjZIc7JKgZnzWA0aYs5md
         WUeQcgdO8BobtJVYoAm+cp9Z+ihycJsqTOfzAvMhSD0Ve9QTnm0hjMQZa790Afa7bJqf
         P68A==
X-Forwarded-Encrypted: i=1; AJvYcCWgfBQkFUqATdpV5uv1MzOVz8oNHFxprnxtXzDtqGLVkYrDpwQmwtCarEkTWy49cu+Jafu41HDmp4ELpeQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAbk499z9yeiSVHmd/C7tb2c4qrgwxm25gm4sAO1mgq3k+2gTy
	1f/zipIOtdqdrCE+ohzD/RQMkYZH/GfVVgR4D4o7E0C2lYXSbseHz8of
X-Gm-Gg: ASbGncsBVHf+BZErUUGfXctw0www4S+hTUg0YHC5yt3EBVYK/ICtqUB4PjRYXFyFqFT
	mlBVqkHCyjWW6FC5SLFB80cXlpsiLfeOSgdWDjgSwnMNdSU+2yTfQe/ZuY9MZz2aeful8g1AzYZ
	H6DCS8BIJsRUM9NLbbkWwtgGNqzzNRH1VfkHHXhem4ByOwfuDw/GuwZs4ziNiOQ36RJMqJS7PZ/
	0PTEZarJvEh1/p3g27pAGDqG+ri9E91SlWWv+rskkdEyt2b0RuV9t4d86RViFAJYSHxkEvGvKhb
	7h9U4WGOdp0unQ5o69P2xFK+KH+4KfQMQIQ2f3z0VPH5bFDUNxo7pfiQrljNBQtZgEAdA6on/J2
	PRWtBluBM5oKPuaK/WBjlfrNF2YPsKguL3IIwcgfmvyMib0D+C5yRMgo+er+C
X-Google-Smtp-Source: AGHT+IHiZ3WBoyZu/FzweeVRjC7PvnRoZSigUpwU+uJ3IFJU1fWXfFsuIEdijQh0lzqXSdjRkIa2fA==
X-Received: by 2002:a05:6000:2485:b0:3b7:9703:d99f with SMTP id ffacd0b85a97d-3cbb15ca058mr9165575f8f.27.1756419006524;
        Thu, 28 Aug 2025 15:10:06 -0700 (PDT)
Received: from devbig569.cln6.facebook.com ([2a03:2880:31ff:4a::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3cf33fbb238sm765573f8f.53.2025.08.28.15.10.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Aug 2025 15:10:06 -0700 (PDT)
Date: Thu, 28 Aug 2025 15:10:03 -0700
From: Yueyang Pan <pyyjason@gmail.com>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Brendan Jackman <jackmanb@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>,
	Usama Arif <usamaarif642@gmail.com>, linux-mm@kvack.org,
	kernel-team@meta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/2] mm/show_mem: Add trylock while printing alloc info
Message-ID: <aLDTu3GrvLd9jMhr@devbig569.cln6.facebook.com>
References: <cover.1756318426.git.pyyjason@gmail.com>
 <7e2bc96faab1a338829e549246189ad96e6c866b.1756318426.git.pyyjason@gmail.com>
 <20250827150619.4e468e68988f224f9f9bea6f@linux-foundation.org>
 <aLAUhXeRVWzLCNNd@devbig569.cln6.facebook.com>
 <c8db3486-4f13-4922-a270-1fbf61e2d782@suse.cz>
 <aLAXsptN4cw05IoZ@devbig569.cln6.facebook.com>
 <2182c715-aaf1-46d1-809e-e4142bc083af@suse.cz>
 <aLAmp4oayTfkPJ3o@devbig569.cln6.facebook.com>
 <92a3320e-2433-4ee8-8ed5-d5db6098b43e@suse.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <92a3320e-2433-4ee8-8ed5-d5db6098b43e@suse.cz>

On Thu, Aug 28, 2025 at 11:54:58AM +0200, Vlastimil Babka wrote:
> On 8/28/25 11:51, Yueyang Pan wrote:
> > On Thu, Aug 28, 2025 at 10:53:01AM +0200, Vlastimil Babka wrote:
> >> On 8/28/25 10:47, Yueyang Pan wrote:
> >> > On Thu, Aug 28, 2025 at 10:41:23AM +0200, Vlastimil Babka wrote:
> >> >> On 8/28/25 10:34, Yueyang Pan wrote:
> >> >> > On Wed, Aug 27, 2025 at 03:06:19PM -0700, Andrew Morton wrote:
> >> >> >> On Wed, 27 Aug 2025 11:34:23 -0700 Yueyang Pan <pyyjason@gmail.com> wrote:
> >> >> >> 
> >> >> >> > In production, show_mem() can be called concurrently from two
> >> >> >> > different entities, for example one from oom_kill_process()
> >> >> >> > another from __alloc_pages_slowpath from another kthread. This
> >> >> >> > patch adds a mutex and invokes trylock before printing out the
> >> >> >> > kernel alloc info in show_mem(). This way two alloc info won't
> >> >> >> > interleave with each other, which then makes parsing easier.
> >> >> 
> >> >> What about the rest of the information printed by show_mem() being interleaved?
> >> > 
> >> > Thanks for your feedback, Vlastimil. We cannot use trylock for the rest 
> >> > part as node filter can be different.
> >> 
> >> Right.
> >> 
> >> > Do you think we need a lock to prevent the whole show_mem() from being 
> >> > interleaved and to acquire it at the very beginning? Will it be too 
> >> > heavy?
> >> 
> >> It might be risky so perhaps let's not. Guess we can disentangle by dmesg
> >> showing the thread id prefix.
> > 
> > I have thought about this. Since each line can interleave with another, we 
> > would end up adding tid to each line. Not sure if this is acceptable.
> 
> I meant that printk/dmesg already does that so it's fine.

Cool. Then I will do this for the previous part before memory allocation info.

> 
> > Thanks
> > Pan
> 

