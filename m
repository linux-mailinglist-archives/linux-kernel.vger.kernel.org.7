Return-Path: <linux-kernel+bounces-789564-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CDBC6B39765
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 10:47:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 69626366ED0
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 08:47:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC6C82E0B5D;
	Thu, 28 Aug 2025 08:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DISUrNBa"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A3A02BEFF6
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 08:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756370873; cv=none; b=MXyNn8QvLL8tOD9tGGBlTfAg6uGLBvtziGO4cxoRu6I5Ya6wDBtMye+S3G6fjVGdWUQpCatz5lY0Z2KGVZfktd/tO6WVHQ4hm9Ne8ps1bvUrJJTkdhyNEvlFyCgFnLg/R4Maef+aCcq5sca+U9bwAxWpqnN4L3ouCJ4QukFCPsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756370873; c=relaxed/simple;
	bh=e7O3CiQxf9rK3ygrcnuvGGjsyH5ZuDEXvl3Al7IthkA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eztu780YdGKSbNTX6SLQcsaIw2CKrc6GmVpwb4mj9b0gIUaICqAKzVqv5FSjgbICpcgT4eAwof3xHjlg1YrjoS1/8SiA+G2vEcDLmIic4446rADXgJK+AM0X7xi7iYkox2G6ZK1kIS6AtlGU3CjehdLz1zV+lpUELBq173APR+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DISUrNBa; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-45a1b065d59so4149535e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 01:47:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756370870; x=1756975670; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8Hsk9DOGTHIa16VTkxnpvVMx5QHHrFZueYddM6GSS74=;
        b=DISUrNBaqRgTMGtzt0D/wNUOmnF2ym7Ud//iFg0oWhjTPltBfW4w7pTTMaQwkgA9jI
         fd38O/13X42/srQcU5m/sjxFjtpDAULFr19FxNpwB25V8sa2tGb4wly8MY6IQkxPPWNj
         SmLoS2tn6ncawXNGX8IznX7rv2JYmYAzjcvJtv9pYfSWIquI79eLUeJQN0ids14PaAOe
         2PIwM3X8jKTYhZ+fZDGT59jBOrrkwdr2f1kqPv9jbVQLiBo6XCgGzRmzZHoaBNljfi+R
         ieLo0+R77Lu91HAxxen9K6WrfYFz0NSfZIUDZiYKhRj2oVU8+VtJaYXuzwvPXmBMV8Js
         T3QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756370870; x=1756975670;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8Hsk9DOGTHIa16VTkxnpvVMx5QHHrFZueYddM6GSS74=;
        b=h8D40zob+7pEFD8PYrTYBJVe8dfUGNeGBvLAROKAyZoQPgWRCG0zpzDaHKZHQOCCit
         Ae+Lbx7/tGtQgctTPB9XrxWoiWHgzJ8bclhSJigja80BLWFziBgM77YvH+BHhgCdnhXc
         GeTAupC+waagg3U6wwG1y0j5dtlPBJdCwEWf5M0YjCOvx29DxxGNvdJGR9VtQypgUv65
         lBdK+rYTqzp3rub1YlfOxC3rHQymLtY+I8nh7YtWL5gautkhTf21U9DXxxRmjnufa4ih
         DoXDmNFOlVikC5yPCcwOPE4drV+XayP+cln4DJyRdDv+TtQHmObLNUe1zGAxQGBMW1/z
         CUkg==
X-Forwarded-Encrypted: i=1; AJvYcCXEnIpbq3sTuSQ8acRVyBtwf8pRh062eDFauKARhdd7h5BRuX7eDE6fWodvVlSuwoFDTuPETW16V1LEjLk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxiiDSdpmUa3rnLd+G3xyEfuKVgPu3S/12DyegUJmf1ZGi8p16z
	ROFOHboo+aocoJ/NDb5CU6+mU4WHuaUmoQ76rUCpkCdNjiZZjB3rBJkj
X-Gm-Gg: ASbGncvHcXM1SQOlouq/kr1F1CsHgdl53WMBZGmGJ9M5hKl493LxbXu2+zVIef/zVeD
	xU0nvm+7Rktrau8GE/+AQV3V37AfupARJrcuIQ9pFG9FJQg0tKa1eyQp5cljDmreiSiz0f8U4MI
	YnQS0bmXlecUIry6cyGuZXyxfBGqzD+q8fhkBCFZECbHjwVecjHpBL6xAVFbO3X5WzAz1H4RMuI
	FhigHzlP2TKxPlkq4ec09naIQ4I5YdsktHRwdxLyxnSJNYsG3pGqSYVqj2Ac6KZdv24bsM7jKmB
	/s9+91SW3oau+G2RT95rR06cX6eRBOltOgsMd20e77gTQ6yPWaUnc1+U1VyVVYl1Pti4JlllWeF
	H/P1ksoWQe/JFRuQlo3anpr0fg/T23tfbIIPewgY=
X-Google-Smtp-Source: AGHT+IFO8pLgjWSH39ZyRRQGsELfg8fZ4fAArTXSmMVZY3KOq7DLC8ULZtj3zAJ1AzMGuiKNKnJXcw==
X-Received: by 2002:a05:600c:5490:b0:45b:4a98:91cf with SMTP id 5b1f17b1804b1-45b5179cfe3mr193278165e9.15.1756370869196;
        Thu, 28 Aug 2025 01:47:49 -0700 (PDT)
Received: from devbig569.cln6.facebook.com ([2a03:2880:31ff:74::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3cbc6a5da6dsm9463817f8f.63.2025.08.28.01.47.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Aug 2025 01:47:48 -0700 (PDT)
Date: Thu, 28 Aug 2025 01:47:46 -0700
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
Message-ID: <aLAXsptN4cw05IoZ@devbig569.cln6.facebook.com>
References: <cover.1756318426.git.pyyjason@gmail.com>
 <7e2bc96faab1a338829e549246189ad96e6c866b.1756318426.git.pyyjason@gmail.com>
 <20250827150619.4e468e68988f224f9f9bea6f@linux-foundation.org>
 <aLAUhXeRVWzLCNNd@devbig569.cln6.facebook.com>
 <c8db3486-4f13-4922-a270-1fbf61e2d782@suse.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c8db3486-4f13-4922-a270-1fbf61e2d782@suse.cz>

On Thu, Aug 28, 2025 at 10:41:23AM +0200, Vlastimil Babka wrote:
> On 8/28/25 10:34, Yueyang Pan wrote:
> > On Wed, Aug 27, 2025 at 03:06:19PM -0700, Andrew Morton wrote:
> >> On Wed, 27 Aug 2025 11:34:23 -0700 Yueyang Pan <pyyjason@gmail.com> wrote:
> >> 
> >> > In production, show_mem() can be called concurrently from two
> >> > different entities, for example one from oom_kill_process()
> >> > another from __alloc_pages_slowpath from another kthread. This
> >> > patch adds a mutex and invokes trylock before printing out the
> >> > kernel alloc info in show_mem(). This way two alloc info won't
> >> > interleave with each other, which then makes parsing easier.
> 
> What about the rest of the information printed by show_mem() being interleaved?

Thanks for your feedback, Vlastimil. We cannot use trylock for the rest 
part as node filter can be different.
Do you think we need a lock to prevent the whole show_mem() from being 
interleaved and to acquire it at the very beginning? Will it be too 
heavy?

> 
> >> > 
> >> 
> >> Fair enough, I guess.
> >> 
> >> > --- a/mm/show_mem.c
> >> > +++ b/mm/show_mem.c
> >> > @@ -23,6 +23,8 @@ EXPORT_SYMBOL(_totalram_pages);
> >> >  unsigned long totalreserve_pages __read_mostly;
> >> >  unsigned long totalcma_pages __read_mostly;
> >> >  
> >> > +static DEFINE_MUTEX(mem_alloc_profiling_mutex);
> >> 
> >> It would be a bit neater to make this local to __show_mem() - it didn't
> >> need file scope.
> > 
> > Thanks for your feedback, Andrew. I will move it the next version.
> > 
> >> 
> >> Also, mutex_unlock() isn't to be used from interrupt context, so
> >> problem.
> >> 
> >> Something like atomic cmpxchg or test_and_set_bit could be used and
> >> wouldn't involve mutex_unlock()'s wakeup logic, which isn't needed
> >> here.
> > 
> > I was not aware of interrupt context before. I will change to test-and-set 
> > lock in the next version.
> 
> Perhaps simply spinlock_t with spin_trylock()?
> 

Agreed.

Thanks
Pan

