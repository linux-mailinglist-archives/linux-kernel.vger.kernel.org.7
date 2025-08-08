Return-Path: <linux-kernel+bounces-760281-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D440B1E8E9
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 15:08:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE4B11AA7627
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 13:09:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECB1A27A91D;
	Fri,  8 Aug 2025 13:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WxVoOay7"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91FCB260592
	for <linux-kernel@vger.kernel.org>; Fri,  8 Aug 2025 13:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754658531; cv=none; b=edWdPDjiriUXIzRja6tCQPWMmfkdKYfuEeTKXSxewo0NUYZhHeVqq8E5moAIeeBcD8c1PiTBQD0akdG+5dLjPFi8XLINBQp8t3gsK5IyEu4ofiVO11oaD0rZlKjHSp/eTv1m0o+R/vw+zZAkBvJV0hRmWNqxD95veOGN63PdukM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754658531; c=relaxed/simple;
	bh=eKxIwPd96l8h30syl76nrBoNxReIYHGROH/fx390+EQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k4dc+SyktULTPnJ1TELyul7fAjgCLPONfr2v6sLggvmCzNbMenhrIbFpbH1MrLjDfkiYtOjknxF1oSpWfC/s4RsyDa2uRBgYBPjgTt/c2fudBwzDpL/eLDuSss38jYyLMuguVqi/Xyial/n/djzFHk9JPZ7q3UX9uAZzCbyGFAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WxVoOay7; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754658528;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=M0UiEs4Rh6Bq7jrDzS2r+cL0UHOZ82z9RlYdz/rMI4Q=;
	b=WxVoOay7MdvBVDcgRZY35CS7rQUkuszPg0xfYgRAJG3bW5qa1D3u0VBZCvR07VhZxJE7D1
	zGDlXMre0E9lwlbF9Ss5fxRtdQ3vARuMnAsUuGJ2ikRjA3dlkhKKybincoLANg3c2o/EbI
	ofjz0X1TWVB6xutW/+PT6Y6D/wyn+xU=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-228-46aA9S8HOqitMnE-iqR_lg-1; Fri,
 08 Aug 2025 09:08:44 -0400
X-MC-Unique: 46aA9S8HOqitMnE-iqR_lg-1
X-Mimecast-MFC-AGG-ID: 46aA9S8HOqitMnE-iqR_lg_1754658522
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 03A801956086;
	Fri,  8 Aug 2025 13:08:42 +0000 (UTC)
Received: from localhost (unknown [10.72.112.126])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1A81B19560AD;
	Fri,  8 Aug 2025 13:08:39 +0000 (UTC)
Date: Fri, 8 Aug 2025 21:08:35 +0800
From: Baoquan He <bhe@redhat.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: SeongJae Park <sj@kernel.org>, linux-mm@kvack.org,
	ryabinin.a.a@gmail.com, glider@google.com, andreyknvl@gmail.com,
	dvyukov@google.com, vincenzo.frascino@arm.com,
	akpm@linux-foundation.org, kasan-dev@googlegroups.com,
	linux-kernel@vger.kernel.org, kexec@lists.infradead.org
Subject: Re: [PATCH 4/4] mm/kasan: make kasan=on|off take effect for all
 three modes
Message-ID: <aJX20/iccc/LL42B@MiWiFi-R3L-srv>
References: <20250805062333.121553-5-bhe@redhat.com>
 <20250806052231.619715-1-sj@kernel.org>
 <9ca2790c-1214-47a0-abdc-212ee3ea5e18@lucifer.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9ca2790c-1214-47a0-abdc-212ee3ea5e18@lucifer.local>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On 08/06/25 at 05:26pm, Lorenzo Stoakes wrote:
> On Tue, Aug 05, 2025 at 10:22:31PM -0700, SeongJae Park wrote:
> > Hello Baoqua,
> >
> > On Tue,  5 Aug 2025 14:23:33 +0800 Baoquan He <bhe@redhat.com> wrote:
> >
> > > Now everything is ready, set kasan=off can disable kasan for all
> > > three modes.
> > >
> > > Signed-off-by: Baoquan He <bhe@redhat.com>
> > > ---
> > >  include/linux/kasan-enabled.h | 11 +----------
> > >  1 file changed, 1 insertion(+), 10 deletions(-)
> > >
> > > diff --git a/include/linux/kasan-enabled.h b/include/linux/kasan-enabled.h
> > > index 32f2d19f599f..b5857e15ef14 100644
> > > --- a/include/linux/kasan-enabled.h
> > > +++ b/include/linux/kasan-enabled.h
> > > @@ -8,30 +8,21 @@ extern bool kasan_arg_disabled;
> > >
> > >  DECLARE_STATIC_KEY_FALSE(kasan_flag_enabled);
> > >
> > > -#ifdef CONFIG_KASAN_HW_TAGS
> > > -
> > >  static __always_inline bool kasan_enabled(void)
> > >  {
> > >  	return static_branch_likely(&kasan_flag_enabled);
> > >  }
> >
> > I found mm-new build fails when CONFIG_KASAN is unset as below, and 'git
> > bisect' points this patch.
> 
> Yup just hit this + bisected here.

Sorry for the trouble and thanks for reporting.

> 
> >
> >       LD      .tmp_vmlinux1
> >     ld: lib/stackdepot.o:(__jump_table+0x8): undefined reference to `kasan_flag_enabled'
> >
> > Since kasna_flag_enabled is defined in mm/kasan/common.c, I confirmed diff like
> > below fixes this.  I think it may not be a correct fix though, since I didn't
> > read this patchset thoroughly.
> >
> > diff --git a/include/linux/kasan-enabled.h b/include/linux/kasan-enabled.h
> > index b5857e15ef14..a53d112b1020 100644
> > --- a/include/linux/kasan-enabled.h
> > +++ b/include/linux/kasan-enabled.h
> > @@ -8,11 +8,22 @@ extern bool kasan_arg_disabled;
> >
> >  DECLARE_STATIC_KEY_FALSE(kasan_flag_enabled);
> >
> > +#ifdef CONFIG_KASAN
> > +
> 
> Shouldn't we put this above the static key declaration?
> 
> Feels like the whole header should be included really.

You are right, kasan_flag_enabled should be included in CONFIG_KASAN
ifdeffery scope.

Since CONFIG_KASAN_HW_TAGS depends on CONFIG_KASAN, we may not need
include below CONFIG_KASAN_HW_TAGS ifdeffery into CONFIG_KASAN ifdeffery
scope. Not sure if this is incorrect.

Thanks a lot for checking this.
> 
> >  static __always_inline bool kasan_enabled(void)
> >  {
> >  	return static_branch_likely(&kasan_flag_enabled);
> >  }
> >
> > +#else /* CONFIG_KASAN */
> > +
> > +static inline bool kasan_enabled(void)
> > +{
> > +	return false;
> > +}
> > +
> > +#endif
> > +
> >  #ifdef CONFIG_KASAN_HW_TAGS
> >  static inline bool kasan_hw_tags_enabled(void)
> >  {
> >
> >
> > [...]
> >
> > Thanks,
> > SJ
> >
> 
> Cheers, Lorenzo
> 


