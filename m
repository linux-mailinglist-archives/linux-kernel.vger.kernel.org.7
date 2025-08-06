Return-Path: <linux-kernel+bounces-757544-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BE9F4B1C36F
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 11:36:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D75FC1728F5
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 09:36:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C4C0289375;
	Wed,  6 Aug 2025 09:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z+5kaKwS"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55BF3239591
	for <linux-kernel@vger.kernel.org>; Wed,  6 Aug 2025 09:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754472976; cv=none; b=VnjLx0c9x4TSxdm57EaE9k7U5/gfENxEHkl+51a7k4yflPenLMCHdGPADFuHUfvlgdQscF5l2FSgjTW11ynfkUNqujodAQq0Sb0UwbM6EA2VA0gXQ10Y8fkqSxXXRPFCrSF2QZfCb+ModnB8XbZt1a+EEt3ebUhPSYPOH7fkCTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754472976; c=relaxed/simple;
	bh=VmqMfGZemB11t5kdfa8eSgbSjXquaxwclNX3t5owNOg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Sder7mg069R1pLm80ofPRxt7f/HG9NXf7GlQD70llKaHl19k5SPFfFqNvAWZP2ZhrBAUTKqUhi7/HEXb1PAFBJP0PLlDTTaTCxLoTdmfP6BxXMXaGsKoiMe9vJTkpo+r7oqQd+cR3JrqJXB36G5amuucXUViLF6040szGxJnaGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Z+5kaKwS; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754472973;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9lYYsLzSzPrboBgIaB2CsUlJcp8uiiPFpeJB8b2vvMg=;
	b=Z+5kaKwSmq/z8ERDYNMBQ9bQh2vzWfEQ2+yFXze99LkQ8vIGERJp+HUKWaMAMrPTMPwH05
	yoPkV6mFIgAoMa3+f3j6OJbPDLRHTFabGO8ozZLr55RvqZLAj0gPFbqMEiku9NgrkQtO8O
	dlnqJRAWskZ3C1hsHXbRWMv4eqx2hjA=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-395-UFCNoUSGPC6BIOrNHzU-2A-1; Wed,
 06 Aug 2025 05:36:11 -0400
X-MC-Unique: UFCNoUSGPC6BIOrNHzU-2A-1
X-Mimecast-MFC-AGG-ID: UFCNoUSGPC6BIOrNHzU-2A_1754472970
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1772619560AE;
	Wed,  6 Aug 2025 09:36:09 +0000 (UTC)
Received: from localhost (unknown [10.72.112.218])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 791923000199;
	Wed,  6 Aug 2025 09:36:07 +0000 (UTC)
Date: Wed, 6 Aug 2025 17:36:03 +0800
From: Baoquan He <bhe@redhat.com>
To: SeongJae Park <sj@kernel.org>
Cc: linux-mm@kvack.org, ryabinin.a.a@gmail.com, glider@google.com,
	andreyknvl@gmail.com, dvyukov@google.com, vincenzo.frascino@arm.com,
	akpm@linux-foundation.org, kasan-dev@googlegroups.com,
	linux-kernel@vger.kernel.org, kexec@lists.infradead.org
Subject: Re: [PATCH 4/4] mm/kasan: make kasan=on|off take effect for all
 three modes
Message-ID: <aJMiA2hh3S9JCqOu@MiWiFi-R3L-srv>
References: <20250805062333.121553-5-bhe@redhat.com>
 <20250806052231.619715-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250806052231.619715-1-sj@kernel.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On 08/05/25 at 10:22pm, SeongJae Park wrote:
> Hello Baoqua,
> 
> On Tue,  5 Aug 2025 14:23:33 +0800 Baoquan He <bhe@redhat.com> wrote:
> 
> > Now everything is ready, set kasan=off can disable kasan for all
> > three modes.
> > 
> > Signed-off-by: Baoquan He <bhe@redhat.com>
> > ---
> >  include/linux/kasan-enabled.h | 11 +----------
> >  1 file changed, 1 insertion(+), 10 deletions(-)
> > 
> > diff --git a/include/linux/kasan-enabled.h b/include/linux/kasan-enabled.h
> > index 32f2d19f599f..b5857e15ef14 100644
> > --- a/include/linux/kasan-enabled.h
> > +++ b/include/linux/kasan-enabled.h
> > @@ -8,30 +8,21 @@ extern bool kasan_arg_disabled;
> >  
> >  DECLARE_STATIC_KEY_FALSE(kasan_flag_enabled);
> >  
> > -#ifdef CONFIG_KASAN_HW_TAGS
> > -
> >  static __always_inline bool kasan_enabled(void)
> >  {
> >  	return static_branch_likely(&kasan_flag_enabled);
> >  }
> 
> I found mm-new build fails when CONFIG_KASAN is unset as below, and 'git
> bisect' points this patch.
> 
>       LD      .tmp_vmlinux1
>     ld: lib/stackdepot.o:(__jump_table+0x8): undefined reference to `kasan_flag_enabled'
> 
> Since kasna_flag_enabled is defined in mm/kasan/common.c, I confirmed diff like
> below fixes this.  I think it may not be a correct fix though, since I didn't
> read this patchset thoroughly.

Thanks a lot for the reporting and fix. The below code is great to fix
the error. I reproduced it and tested with below fix, it works.

Since there's other reviewing comments, I will merge this into v2 post.

> 
> diff --git a/include/linux/kasan-enabled.h b/include/linux/kasan-enabled.h
> index b5857e15ef14..a53d112b1020 100644
> --- a/include/linux/kasan-enabled.h
> +++ b/include/linux/kasan-enabled.h
> @@ -8,11 +8,22 @@ extern bool kasan_arg_disabled;
>  
>  DECLARE_STATIC_KEY_FALSE(kasan_flag_enabled);
>  
> +#ifdef CONFIG_KASAN
> +
>  static __always_inline bool kasan_enabled(void)
>  {
>  	return static_branch_likely(&kasan_flag_enabled);
>  }
>  
> +#else /* CONFIG_KASAN */
> +
> +static inline bool kasan_enabled(void)
> +{
> +	return false;
> +}
> +
> +#endif
> +
>  #ifdef CONFIG_KASAN_HW_TAGS
>  static inline bool kasan_hw_tags_enabled(void)
>  {
> 
> 
> [...]
> 
> Thanks,
> SJ
> 


