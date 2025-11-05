Return-Path: <linux-kernel+bounces-886533-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A8EFC35DC6
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 14:36:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6789F42386E
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 13:34:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99B92316905;
	Wed,  5 Nov 2025 13:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hOEIWuRf"
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B344A41
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 13:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762349662; cv=none; b=i/Wt5y/O+VeM6rnGZnposqWGV2bUTc0pGHfO3NdgJWqF1VjkG1OARukBEPBBE8H/6KFK97d419miM6z5Z3UyURVRU4x5IUC5n93riw9hGBZ0j7Hj1nQntGF3jiuHCHdqV5DFTWm837zImAxuF4wT0TSUVnHQSV7JttE4nfbRAvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762349662; c=relaxed/simple;
	bh=ypdo8zAl0DVgm/CDQ6pygGtiv/KsYO7yoA/9YhLk1M8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HdomHzRdRvkf96+BGUD4lq8fcRGAZTrYY7TCQYIsrEykaPnA0ACes2hLBLjWfp61TYuFyfvq5Op8ugpRHuBRg9/qK3zhpRvROqV5ZX9Wqoci0PP2w2h1h1t5HvGOvRZplJdTlA8msT7gj/c/sTKKLl7OK+4UV1czp++UkWWzbvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hOEIWuRf; arc=none smtp.client-ip=209.85.161.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-656b32a0cc4so448609eaf.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 05:34:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762349659; x=1762954459; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Sv/JzecOhMA8cZ94wcVGV+A+peoLF8ip0q5xsIEB14k=;
        b=hOEIWuRf8xTVW0N7flEfmF86lDUhcljEugS6OKLFvMyRP6zXPQlt0ITiIG0bFu5Prz
         T83ydlwkVsUcFDKKTVv0K5JGhXdBym2pz1L716XFhb8JoH6Q7MBlKjcOX6FfHHmpasl+
         HhiDZg+iqnf8LO3sFw/oZnpOM6IowAgX0C6sPdw5BWzW2R3Bj1gbsN2VtVhk9nL/RRna
         zGL7WAMokTo2lYoHZJ6lykm5oe+NCzlQnagUh4xgy+e9S5ytst4bofNmh/rozsenQZDo
         7A2zw0nEmTn9KQwZkBHltTyoJPX9sKxY3GnzbUFSoKFAO+YFATjaL/6fsnVJ+JENRqra
         n+Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762349659; x=1762954459;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sv/JzecOhMA8cZ94wcVGV+A+peoLF8ip0q5xsIEB14k=;
        b=jRhJUKy0O2J/Rq8CH62ESg1pfeCIzIUj+bh6/9KexKPlzkXQubrufzKeqcV5Lv2OQM
         k/V3VEPbNGdpEAlc9JnGBS08v8wIf1IgedgdfGQkpaD5lCaIqVmJfXJ0Lv3Tmdvaww4s
         JiHJmP4ACR9QyDqpty1QbZF/dkmrdsOgcWpEOX79gGrqydHfIj1XMhn4ww0D775klrpI
         tdJ68gmtngnIXSyKemgDGxQ6jOBNtn5mOO+jg8EvU3VBWsl3UzDR0Q6Y7PGFW/4jJH7o
         mQv4zAneaDwxeNtzcjstt8/sOIrSERFlEn9FkA6/c6it+0pzqrw/mZmA8WsUCIHSP7mp
         uoqQ==
X-Forwarded-Encrypted: i=1; AJvYcCUg3fiwzULtfBZephq6rMD/D77YWGFI8JlDggTHhl2I2cKs3ao3z3ITF0vVQWBR97EeMRMSSM2COEzNIfE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwN5/X74LOkZeb8V7Ga8+RIMVztpruTv5UCOE2Ulj0SHxtsX6kR
	IwQxR5mEjYv7eTTRkCNoMVru9DakNqopjEtKgmI8AAK9DhmfIs5pgO7i8M+dNP2ToMo=
X-Gm-Gg: ASbGncuiORehAcXdrtQZwrbBlHQeZ56xLZf8pfuNkisp6ASz32sjUojKoXOBezgitGj
	znNwLimQ1kUMJsUzvOrWYRnQvvwDr01/CkXwj5viSxWwnABUyQfPnjvDUSmX6ex3Q31UAn2GLVI
	bhD2Raq7x4j9Vx/2aqgInWtS9FICRl6NSG34bkJa2EK2WQtfiw4wZtPSgmepoqM20weqHNuNUi9
	4+cfCyrVhGVysA8b0AQpn83o5hpFnYYQ1MCcM25uRbgqR5HnaKiiqzWGoN5CZBsLJVGstOk2ySy
	SBNLDMoJvF6OKlXZE+K8/gorTBHnndA9K4RbdIrD+/BfVJNMzXyIEuD+czBvOsKp1jV9PRzZmSR
	wjptFrTiLpbbtqn2SWE0goGmsZbTOTn7ZE/bsMsatfAKq/xf9L+ZwJpN8CzO6L+Z1T14cJZclHR
	e6vK2sjZr5TQ7Xj2urxda1yUYTy2O4UH4fmZhMkCd4ggXbTrupb6tzPA==
X-Google-Smtp-Source: AGHT+IE8z6TNiU3ePk48BI+doqg/bH4NTxWdTXISMyBVQ21lhT2P1M3hdipDnXRTCcDABOBcmXjW8w==
X-Received: by 2002:a05:6871:878a:b0:3c9:7e9b:632b with SMTP id 586e51a60fabf-3e19af07bc3mr1381694fac.30.1762349659507;
        Wed, 05 Nov 2025 05:34:19 -0800 (PST)
Received: from weg-ThinkPad-P16v-Gen-2 ([177.73.136.69])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-3dff46fa5afsm2245210fac.5.2025.11.05.05.34.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 05:34:19 -0800 (PST)
Date: Wed, 5 Nov 2025 10:32:23 -0300
From: Pedro Demarchi Gomes <pedrodemargomes@gmail.com>
To: "David Hildenbrand (Red Hat)" <david@kernel.org>
Cc: David Hildenbrand <david@redhat.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Xu Xin <xu.xin16@zte.com.cn>, 
	Chengming Zhou <chengming.zhou@linux.dev>, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] ksm: perform a range-walk in break_ksm
Message-ID: <ff4jfxphz32fackvh2236an7575zhqnwntrx5ledudb4afu2ag@sk4vigyq5jif>
References: <20251031174625.127417-1-pedrodemargomes@gmail.com>
 <20251031174625.127417-3-pedrodemargomes@gmail.com>
 <cd632ad0-c73e-4e6d-872b-2f4dad285e9d@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cd632ad0-c73e-4e6d-872b-2f4dad285e9d@kernel.org>

On Mon, Nov 03, 2025 at 06:06:26PM +0100, David Hildenbrand (Red Hat) wrote:
> On 31.10.25 18:46, Pedro Demarchi Gomes wrote:
> > Make break_ksm() receive an address range and change
> > break_ksm_pmd_entry() to perform a range-walk and return the address of
> > the first ksm page found.
> > 
> > This change allows break_ksm() to skip unmapped regions instead of
> > iterating every page address. When unmerging large sparse VMAs, this
> > significantly reduces runtime.
> > 
> > In a benchmark unmerging a 32 TiB sparse virtual address space where
> > only one page was populated, the runtime dropped from 9 minutes to less
> > then 5 seconds.
> > 
> > Suggested-by: David Hildenbrand <david@redhat.com>
> > Signed-off-by: Pedro Demarchi Gomes <pedrodemargomes@gmail.com>
> > ---
> >   mm/ksm.c | 88 ++++++++++++++++++++++++++++++--------------------------
> >   1 file changed, 48 insertions(+), 40 deletions(-)
> > 
> > diff --git a/mm/ksm.c b/mm/ksm.c
> > index 922d2936e206..64d66699133d 100644
> > --- a/mm/ksm.c
> > +++ b/mm/ksm.c
> > @@ -607,35 +607,55 @@ static inline bool ksm_test_exit(struct mm_struct *mm)
> >   	return atomic_read(&mm->mm_users) == 0;
> >   }
> > -static int break_ksm_pmd_entry(pmd_t *pmd, unsigned long addr, unsigned long next,
> > +struct break_ksm_arg {
> > +	unsigned long addr;
> > +};
> 
> Leftover? :)
> 

Yes, I am sorry.
I will remove it in the v3.

> > +
> > +static int break_ksm_pmd_entry(pmd_t *pmdp, unsigned long addr, unsigned long end,
> >   			struct mm_walk *walk)
> >   {
> > -	struct folio *folio = NULL;
> > +	unsigned long *found_addr = (unsigned long *) walk->private;
> > +	struct mm_struct *mm = walk->mm;
> > +	pte_t *start_ptep, *ptep;
> >   	spinlock_t *ptl;
> > -	pte_t *pte;
> > -	pte_t ptent;
> > -	int ret;
> > +	int found = 0;
> 
> Best to perform the ret -> found rename already in patch #1.
>

Ok

> With both things
> 
> Acked-by: David Hildenbrand (Red Hat) <david@kernel.org>

Thanks!

> -- 
> Cheers
> 
> David
> 

