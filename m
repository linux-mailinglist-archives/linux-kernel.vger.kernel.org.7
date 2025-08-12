Return-Path: <linux-kernel+bounces-764903-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B1C80B228A3
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 15:35:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF0611AA0DE5
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 13:28:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49D0E284684;
	Tue, 12 Aug 2025 13:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TDS8zN6I"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7C2E284674
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 13:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755005238; cv=none; b=drBByPJkZGTjt5HI7qPjm1KYcGq6ImcOYRnVJLiiwuVUxzBOsr2MbgrYf1cbazusCIUnQ7VG9UI7g3OQJoi2XuUIA3isETvdZ60PJFaTzxw13o+jUSDaitpn4isPfcXcfScuta1q7wKPls7g4b4uEKQ93seviLltoiKZzljqNMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755005238; c=relaxed/simple;
	bh=+tYwRVYfz39O2qKcfCmjsJE4tB0a5Ttt7ts9UV0Q1kE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Onz1iIMND+RhCkYfk++aWSVMfNbWH36nQI/z/uDon3VSqjc3MFdgdoZd5F97WkBadt79z3PHm85vV5Wqd1GuPb9VPOCxDrCHR2zPstCZFEyqhWQP1+nEC4JIXntcjY6su9PMh23syBt19U1EwKBH9acHIro/nI67na815/Kmeww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TDS8zN6I; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755005235;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5ek84SNcPpQCmMHvcqQa3TlILZVgRFvPfl/s5BFwLTA=;
	b=TDS8zN6ILtDcti5ieUFOGNCGBIn98LI75i0ViiYG7oS/puQgk5l2EGCOkwhPqFp2EPR2Nc
	k2J6KD3uY83xZiecnFl+YUCFf+jPLkbT2yEgPcV2L9p/krcuunH/DX8E3oA85P0YOFedq/
	x1senS6YmJO5RYx1V2HahvNpDFez6tA=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-610-l3ZgW3CKOGqqNd4zvWIV_g-1; Tue,
 12 Aug 2025 09:27:12 -0400
X-MC-Unique: l3ZgW3CKOGqqNd4zvWIV_g-1
X-Mimecast-MFC-AGG-ID: l3ZgW3CKOGqqNd4zvWIV_g_1755005229
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C128018002C8;
	Tue, 12 Aug 2025 13:27:08 +0000 (UTC)
Received: from localhost (unknown [10.72.112.156])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9513530001A1;
	Tue, 12 Aug 2025 13:27:07 +0000 (UTC)
Date: Tue, 12 Aug 2025 21:27:02 +0800
From: Baoquan He <bhe@redhat.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: SeongJae Park <sj@kernel.org>, linux-mm@kvack.org,
	ryabinin.a.a@gmail.com, glider@google.com, andreyknvl@gmail.com,
	dvyukov@google.com, vincenzo.frascino@arm.com,
	akpm@linux-foundation.org, kasan-dev@googlegroups.com,
	linux-kernel@vger.kernel.org, kexec@lists.infradead.org
Subject: Re: [PATCH 4/4] mm/kasan: make kasan=on|off take effect for all
 three modes
Message-ID: <aJtBJgC82CpUkwTi@MiWiFi-R3L-srv>
References: <20250805062333.121553-5-bhe@redhat.com>
 <20250806052231.619715-1-sj@kernel.org>
 <9ca2790c-1214-47a0-abdc-212ee3ea5e18@lucifer.local>
 <aJX20/iccc/LL42B@MiWiFi-R3L-srv>
 <b5d313ef-de35-44d3-bcbc-853d94368c87@lucifer.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b5d313ef-de35-44d3-bcbc-853d94368c87@lucifer.local>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On 08/08/25 at 02:24pm, Lorenzo Stoakes wrote:
> On Fri, Aug 08, 2025 at 09:08:35PM +0800, Baoquan He wrote:
> > On 08/06/25 at 05:26pm, Lorenzo Stoakes wrote:
......
> > > > diff --git a/include/linux/kasan-enabled.h b/include/linux/kasan-enabled.h
> > > > index b5857e15ef14..a53d112b1020 100644
> > > > --- a/include/linux/kasan-enabled.h
> > > > +++ b/include/linux/kasan-enabled.h
> > > > @@ -8,11 +8,22 @@ extern bool kasan_arg_disabled;
> > > >
> > > >  DECLARE_STATIC_KEY_FALSE(kasan_flag_enabled);
> > > >
> > > > +#ifdef CONFIG_KASAN
> > > > +
> > >
> > > Shouldn't we put this above the static key declaration?
> > >
> > > Feels like the whole header should be included really.
> >
> > You are right, kasan_flag_enabled should be included in CONFIG_KASAN
> > ifdeffery scope.
> 
> Firstly I _LOVE_ the term 'ifdeffery scope'. Fantastic :)

Learned from upstream people with expertise on both english and kernel, :-)

> 
> >
> > Since CONFIG_KASAN_HW_TAGS depends on CONFIG_KASAN, we may not need
> > include below CONFIG_KASAN_HW_TAGS ifdeffery into CONFIG_KASAN ifdeffery
> > scope. Not sure if this is incorrect.
> 
> Well I don't think CONFIG_KASAN_HW_TAGS is necessarily implied right? So these
> should remain I think, just nested in CONFIG_KASAN, should be fine.

After investigation, I keep the CONFIG_KASAN_HW_TAGS ifdeffery scope out
of CONFIG_KASAN scope. Otherwise, I need define the dummy
kasan_hw_tags_enabled() function twice. I am personally not fan of the
style. While if that is preferred in kernel, I can change it.

#ifdef CONFIG_KASAN

#ifdef CONFIG_KASAN_HW_TAGS
......
#ifdef CONFIG_KASAN_HW_TAGS
static inline bool kasan_hw_tags_enabled(void)
{
        return kasan_enabled();
}
#else /* CONFIG_KASAN_HW_TAGS */
static inline bool kasan_hw_tags_enabled(void)
{
        return false;
}
#endif /* CONFIG_KASAN_HW_TAGS */
.....
#else /* CONFIG_KASAN */
static inline bool kasan_hw_tags_enabled(void)
{
        return false;
}
#endif


