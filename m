Return-Path: <linux-kernel+bounces-752653-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 08F31B178DF
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 00:04:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC4C83A8793
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 22:04:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB218265CBE;
	Thu, 31 Jul 2025 22:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kLOF8dgc"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A514A921
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 22:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753999459; cv=none; b=tHUtdSav9RxjrlnJjl5e3yNmlWphv4nMv5IL2e/XdE5dYbbwo2Cc636EBetcC5gnq0iKo1i1PqPluZOY/+J2Ce890/6FZVCcNxVN1Z7A9aw+tPMb99JQtf7DVx4Y9XkVRGCKZBrcRrK9bua5epsw6rPUiboM6uKv68qmJnRtfpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753999459; c=relaxed/simple;
	bh=T+U1llJWqanj2eP8cHM7nhvCfUiqnhYB4EmMGd2LH1A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hEJyyHOolVVclbryeHQ9SYdfD/BAIz8y0sO9x3sYEa6XXwK42g+FXAZ7XKCDcD3WKUsy0WTZiH0qydi5CqAtXHv0TxoquU4Cw6wRt++gK3GemgQ+RIcRbC4LpmvAJmRQR9M+UDPj7ySILHzLfQuvelq4PDLWhkAuLE6qqwnkAvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kLOF8dgc; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3b785a69454so91635f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 15:04:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753999456; x=1754604256; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YuVXeYr7FDtql94sM1ldGgDheznzgmdavsiQoAB2NVw=;
        b=kLOF8dgcf/fsfzbA0CEhuCN6SjbVWPGj3nudfi860U5y09NoHiUoNFAxPyzIiFvQn7
         Ihje7HEVuZec93fz/Uzzdu2p/3HXsGvV5xwm1AmUzt4eRK2m+TmWEMzEg82msqW6GRt0
         +Ekrpdf2b8ulWcFLd3Lq2WWEcu2AaSxnLUq65znoFjsk+aLlb46a7VZs/B5lmnQ5vs2P
         AkajooRc+mKjEcAzKOOasIlCVBLYh9eesLLXOhpvWOUg/oCC8mkav4G7roPdqAgA13ou
         d1xh8UGJoIlFrimFRSsQw0Nm18OlsqGHIZzITWIztwMnWvsYn6L4x8Cs15OZEnB4NL+r
         LysA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753999456; x=1754604256;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YuVXeYr7FDtql94sM1ldGgDheznzgmdavsiQoAB2NVw=;
        b=mLgmKvdo3hIRmtl6wtnLDk6rnM6R24fH2JM115+Vlf4BxFkZOFPjqb+0qq3Ykja4w0
         k1hjsCbOzhS5jGLO5Ns6G4AtMkVHcy5//1KJSgeGfTwC0N86QtYxcuXzSxfj4o7+na/Y
         SacRLEJUn3ZFunNgJXp3lK7u2XbUZYgJ5sK8gpq9xxH5O50SSoTeec0D9u1QddMNIzyJ
         BNT6xm44KnqWUgCGIS6ESbRSpOTdNJDUWvo+yip7drJAMLefk+2bEE3DqfdnwzOrtIbk
         dsWxv407IQpZgMHtiEsZxp01cSFL5x8qPrXuIabhKaWMmpXM+yFx81E8Tf/AAVWo+QKW
         /YXg==
X-Forwarded-Encrypted: i=1; AJvYcCUdQMZRZcdV0Mfw7JvD5uYpgznSum9SluwOB2IBK2XwIqXiiqkuY1wZtcejkgfNBZRbwR1uhc2mmsU6X/s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyv21DUI+kKoaov1cKxZ8oNRL0OGlf0oZY0YMwDJi672JvVg/Mw
	6mCKsc1nmUZGf8mASGmXIzSsSM0DNFdO+nzJV2fXi7NJm/bTNT96C+p7
X-Gm-Gg: ASbGncvGh0WRVXklZ/yvTZOQXEsN11jTLJy+t+nlkygMpWa3aZAj4JRTfUUZMzlt9tH
	SXTgxG/96j8im3LyGhIrv1DjUyYQYwldepjJ6V2M5CFynijhK25uDdB4eu13q+SKLdc9/Yd1MEB
	FyickJV08yCPvRWjGyVBIFMX9No/EV3IzXkgo4cjE3r2te1ZLvuO9V+sp//eUOTjP3E6fJx9In2
	xptLl8Pbzvjf7xpXNsWSiuchWwQ+2QRweuOVBWF5/MJBLeMlsUZMcPdLMNghULAeFrN7GjHM6rR
	BHlkT1iCJZ4Uj0qGB8peToso39cYaNWkrbhJpulgUbEWNL8w+3s8z0fKhBgAis0JNlWIXQx5YYI
	bXD0JIzkCCiCmc6l0jpFW0Kus1pPqbmK5iru8xBfNTOJLIf5DjeO54fSoPjsNv8my7fjwutv6Rl
	dXgyaJhz8=
X-Google-Smtp-Source: AGHT+IHCw7TRuJh2aGg/Nw+v2xuOt+mi8XWdyGvHc40uQSFW40upZ5IOazoX2RAMaX9h6uizaidJkA==
X-Received: by 2002:a05:6000:1a86:b0:3b7:8ddc:87a1 with SMTP id ffacd0b85a97d-3b794fc187emr6918829f8f.4.1753999455654;
        Thu, 31 Jul 2025 15:04:15 -0700 (PDT)
Received: from Yueyangs-MacBook-Pro.local (vpn-254-003.epfl.ch. [128.179.254.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4588dd77cbbsm67628505e9.2.2025.07.31.15.04.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Jul 2025 15:04:15 -0700 (PDT)
Date: Thu, 31 Jul 2025 23:04:12 +0100
From: YUEYANG PAN <pyyjason@gmail.com>
To: SeongJae Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Usama Arif <usamaarif642@gmail.com>, damon@lists.linux.dev,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] mm/damon: Move has filter to ops-common
Message-ID: <aIvoXMbW57IL9X1o@Yueyangs-MacBook-Pro.local>
References: <06734aa15198e542f9defbc1d29fc0731671c3d8.1753895066.git.pyyjason@gmail.com>
 <20250730174506.60001-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250730174506.60001-1-sj@kernel.org>

On Wed, Jul 30, 2025 at 10:45:06AM -0700, SeongJae Park wrote:
> On Wed, 30 Jul 2025 10:19:55 -0700 Yueyang Pan <pyyjason@gmail.com> wrote:
> 
> > This patch moves damon_pa_scheme_has_filter to ops-common. renaming
> > to damon_scheme_has_filter.
> > Doing so allows us to reuse its logic in the vaddr version
> > of DAMOS_STAT
> > 
> > Signed-off-by: Yueyang Pan <pyyjason@gmail.com>
> > ---
> >  mm/damon/ops-common.c |  9 +++++++++
> >  mm/damon/ops-common.h |  2 ++
> >  mm/damon/paddr.c      | 11 +----------
> >  3 files changed, 12 insertions(+), 10 deletions(-)
> > 
> > diff --git a/mm/damon/ops-common.c b/mm/damon/ops-common.c
> > index 99321ff5cb92..3ebfa356ca46 100644
> > --- a/mm/damon/ops-common.c
> > +++ b/mm/damon/ops-common.c
> > @@ -412,3 +412,12 @@ unsigned long damon_migrate_pages(struct list_head *folio_list, int target_nid)
> >  
> >  	return nr_migrated;
> >  }
> > +
> > +bool damon_scheme_has_filter(struct damos *s)
> > +{
> > +	struct damos_filter *f;
> > +
> > +	damos_for_each_ops_filter(f, s)
> > +		return true;
> > +	return false;
> > +}
> 
> I should have tell this earlier, sorry.  I now think it would be good to have
> ops-common.c own prefix, since this namee makes me expect the function is on
> DAMON core layer.  Also, I use normal 'grep' and ctags at the best, and maybe
> I'm not the only one that that lazy at learning new tools.
> 
> Following the weird and none-public naming convention we have on DAMON,
> damos_ops_ for DAMOS-related functions and damon_ops_ for monitoring-related
> functions would be the prefix for ops-common.c.
> 
> So, what about renaming this to damos_ops_has_filter() if we have a chance to
> revision this once again?

Thanks. I will fix it in the next version.

> 
> > diff --git a/mm/damon/ops-common.h b/mm/damon/ops-common.h
> > index 61ad54aaf256..8d5c5c7631ac 100644
> > --- a/mm/damon/ops-common.h
> > +++ b/mm/damon/ops-common.h
> > @@ -21,3 +21,5 @@ int damon_hot_score(struct damon_ctx *c, struct damon_region *r,
> >  
> >  bool damos_folio_filter_match(struct damos_filter *filter, struct folio *folio);
> >  unsigned long damon_migrate_pages(struct list_head *folio_list, int target_nid);
> > +
> > +bool damon_scheme_has_filter(struct damos *s);
> > diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
> > index 53a55c5114fb..daeceed981a0 100644
> > --- a/mm/damon/paddr.c
> > +++ b/mm/damon/paddr.c
> > @@ -262,22 +262,13 @@ static unsigned long damon_pa_migrate(struct damon_region *r, struct damos *s,
> >  	return applied * PAGE_SIZE;
> >  }
> >  
> > -static bool damon_pa_scheme_has_filter(struct damos *s)
> > -{
> > -	struct damos_filter *f;
> > -
> > -	damos_for_each_ops_filter(f, s)
> > -		return true;
> > -	return false;
> > -}
> > -
> >  static unsigned long damon_pa_stat(struct damon_region *r, struct damos *s,
> >  		unsigned long *sz_filter_passed)
> >  {
> >  	unsigned long addr;
> >  	struct folio *folio;
> >  
> > -	if (!damon_pa_scheme_has_filter(s))
> > +	if (!damon_scheme_has_filter(s))
> >  		return 0;
> >  
> >  	addr = r->ar.start;
> > -- 
> > 2.47.3
> 
> Otherwise, all looks good to me.
> 
> 
> Thanks,
> SJ

Best Wishes
Pan

