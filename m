Return-Path: <linux-kernel+bounces-847016-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EA0C7BC9A91
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 16:58:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 96485353617
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 14:58:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F1452EB85C;
	Thu,  9 Oct 2025 14:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BKBTAQ6Y"
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E1DA2EAB8C
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 14:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760021929; cv=none; b=MBv4pQzaHwgMAwLyTcKBeO0U4Nn6Kt03esR/TwtDRLlJiKbUxfeVaJrwJTGkncQP153nsOkgJwPxoDHJB+6XRqLb+Mo0+a7sy1m7zyAnI+mQLNt1is/f9EHk+/nfrBm2GU2XaVoarjsrXr7bi1x6ZI11pd4xK+GXFeynicbeYjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760021929; c=relaxed/simple;
	bh=4WbS4ZmE5ty+nbST9vhQZHro/QQI8iMbVDclpn84JuQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iNJhc09HYe6cfZb006eAONqEi7B9CvsWB1FHE1utqczgAtT1doolPVaeSFLyJNniwpz1hLE852l0v0YQAyhlRpnNhXmsyCzvLLayO8pdZ/s/Ip1F/tDTQJWsLXjSf87J/Hvgovo9i13tjKLcF1Q44bo+Cm+/PsTG0hUIDkgPrd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BKBTAQ6Y; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-780fe76f457so5364347b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 07:58:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760021927; x=1760626727; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HjQMy0W5zY49EbzVVSPPF91Ji19NK64fWKIXcHylS1U=;
        b=BKBTAQ6Y1+5pWD0j//TaXDOZVjMUnFYrBlbHj3zOyX5+H+p5WdG17MoBZwAzN3RIO7
         LqjjRdj/4Ra4An4h1aLzezn330DyQ3kqt6HsYw6pcsPFIyjOEPXnjA0h2qgwtO1v7+RF
         UVbdAxlMX+a5EfFFYKsdh63dKw2Q4Z9ShjHiDWRwWY55QHM20lddlKNTUGzXDOTRh78L
         u8ggZEslZ+Jdv6VD4D7n3Gs3Ks5RV4FH3WHiOwcuF403zLS7T0J5jopVIKOanrMjzXU3
         6+65l636yjm/N5Tx6IEtsbzD48AS4DxNzaFbDAhY/9cINmPp65PA5CptCTMXy2gBGjx/
         et7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760021927; x=1760626727;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HjQMy0W5zY49EbzVVSPPF91Ji19NK64fWKIXcHylS1U=;
        b=XWpTnfQQuZnfeJiTdTr5fnTFayMZpb2kivrYJM5twuIbvSTHgivGYdruyrwxWnKQ2w
         bkJIawwBWdlWQaCqLoVQxi+25SjehEzBdN+D1KWCp9XEUv14C18hq8h94moH5U4VGUKV
         GfIhnKUe8LnysWYsdSEe5utL10qrKJKrGHUK3MRfiHtqC/H5qOeIYSmQNrtTEdeVHGJd
         rkiC/b6CiudPWeogA9tDOvb630OT9JlIpZvPp+JDwDEh9BMi3lMZpTD+WBfu4gekkSMu
         ibzjXQIB4tzFuFxUcB1lNLnISuTqS8eHe96EH9/RL6wkVFPN2XHguCWgZ5JVA+XRAuQ2
         06gA==
X-Forwarded-Encrypted: i=1; AJvYcCXwkdYHmFkZ2ll08DkIikHscQOP3q0VwcqKb6oM0Eug2Jy4MkIrIxMb0Qx2qi9pxmuvu/Nr1kj4u3I6lkU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3qjQLbYpp2+fjki4VuBqqckUxKzdn7ofr8dCFKq6HBvCFcOrk
	au8D8/pii9ObZrQfFwcbsJgkYKD5HIDjlAfYoGJWh2+xR6ouRjBjwF41
X-Gm-Gg: ASbGncvFpkb8bp2OtoYsqFSPZoS3uFMXKuEJJ34tOqUip9oW1l2b8dUE2Fn0TKIDKuT
	ba7VSYm7RPRJ5OGkqVFT+ot/7FVkrcR+Hjo/txtbCHtNwhUxVkylNayx2H7/Dry1KDrXzGB0rPQ
	Qz8uSGTQqd9afrV4YnkAEiap+Il59iWNj2Yb/L/8n2nU9DN9RGma0YZ6u809VuNbXxSSLSRpIDP
	IBT/qg5svgP12EEr43HkO7AD9d7lHjJAwygCPEr1xwVZZWvo8FQPd6KVUoxQpv9N3FSNj2SqmPl
	mJelTynoa+a4jA/WiivJmctNF4NQq1tl/FNCMO2uDY8OvcLEA9xlGf+cYiblRvqCV9ADVkoMDz1
	JPJQy3fMzEVH0EkDEXQa6xI4eUwfp0sMDgo8VtLi4BaEmhcFTy+dS3aACsV8bh0goME7EN82gbb
	dpwaQGAXcQgp+h6A==
X-Google-Smtp-Source: AGHT+IEBlJeeD/fVPl432wy9c52nnaFfRNJyxt1nmVeSPsAdYf5XIPTW4lc8o6yEmNCIPpKliHt5NA==
X-Received: by 2002:a05:690c:6204:b0:77e:5eb8:278c with SMTP id 00721157ae682-780e16fc173mr119127917b3.46.1760021926831;
        Thu, 09 Oct 2025 07:58:46 -0700 (PDT)
Received: from localhost (c-73-105-0-253.hsd1.fl.comcast.net. [73.105.0.253])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-77f81c4e065sm73855237b3.28.2025.10.09.07.58.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 07:58:46 -0700 (PDT)
Date: Thu, 9 Oct 2025 10:58:45 -0400
From: Yury Norov <yury.norov@gmail.com>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Rik van Riel <riel@surriel.com>, Ingo Molnar <mingo@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Roman Kisel <romank@linux.microsoft.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] smp: simplify smp_call_function_any()
Message-ID: <aOfNpZF5jlkVgN0k@yury>
References: <20251008165746.144503-1-yury.norov@gmail.com>
 <1a0b35d0-d739-4f1c-9a50-95780eed02e4@efficios.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1a0b35d0-d739-4f1c-9a50-95780eed02e4@efficios.com>

On Wed, Oct 08, 2025 at 01:06:18PM -0400, Mathieu Desnoyers wrote:
> On 2025-10-08 12:57, Yury Norov (NVIDIA) wrote:
> > The functions calls get_cpu()/put_cpu() meaningless because the actual
> > CPU that would execute the caller's function is not necessarily the
> > current one.
> > 
> > The smp_call_function_single() which is called by
> > smp_call_function_any() does the right get/put protection.
> > 
> > Signed-off-by: Yury Norov (NVIDIA) <yury.norov@gmail.com>
> > ---
> >   kernel/smp.c | 8 ++------
> >   1 file changed, 2 insertions(+), 6 deletions(-)
> > 
> > diff --git a/kernel/smp.c b/kernel/smp.c
> > index 02f52291fae4..fa50ed459703 100644
> > --- a/kernel/smp.c
> > +++ b/kernel/smp.c
> > @@ -754,17 +754,13 @@ EXPORT_SYMBOL_GPL(smp_call_function_single_async);
> >   int smp_call_function_any(const struct cpumask *mask,
> >   			  smp_call_func_t func, void *info, int wait)
> >   {
> > -	unsigned int cpu;
> > -	int ret;
> > +	unsigned int cpu = smp_processor_id();
> 
> I wonder whether this passes any moderate testing with kernel debug
> options enabled. I would at the very least expect a
> raw_smp_processor_id() call here not to trip debug warnings.
> 
> AFAIU smp_call_function_any call be called from preemptible context,
> right ?

You're right, we need to retain current CPU unless the work is
scheduled. I need to test better. Sorry for the noise.

