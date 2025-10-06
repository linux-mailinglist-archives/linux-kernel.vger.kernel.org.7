Return-Path: <linux-kernel+bounces-842787-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 24BB0BBD9A7
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 12:06:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0CE4B34A0D6
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 10:06:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAF1821CC71;
	Mon,  6 Oct 2025 10:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a9+yEDuy"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 633C53BB5A
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 10:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759745180; cv=none; b=mQyjOBGDVOPP4u3qU7nhgLLBl1SA4kDXTaYoJYaSFzCCxArEzkgZxxaEb6wDNEiXhxcenRt1qYrXD7sPYEIodhkEnfQCCei/k6al+NanDWSIC8IYUctr/EwY1pjX83HJ7tVogwNV7XP2IHrAH8GORg7gPH+75j6UiTBYPEBlurI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759745180; c=relaxed/simple;
	bh=aga48O5DWLcOiiUnLC8nhPrJD9lPABPuCVOSpvvKuI0=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hIpRuPjuLVmtgBO8vVVYqxUbTJNiFTJO2L7/BJLw8py5PiFm+UgocWt6V47bLTjpB1WJUuSGjHJ9GjzSXtR3GDvdkDPgrLZmckXg3EtbF6XuqnLhMQezIJCvqptAHnJuAK+PlvjhXLZp90zgAKEZYbtMQnfFlmJ+o/5XZO15N5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a9+yEDuy; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-57b35e176dbso6165217e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 03:06:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759745176; x=1760349976; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qdL3Gjg4YnZQbKleKeTBCKkou2FNTLhQNiPxLrTgrlE=;
        b=a9+yEDuyCEk0LkPZJHOxhmLlRjU8oQtGq+iwfY8ArjJa642WobwaxCYMZWcRptViCD
         AMhBLzHjGavxbBm04Or0f88iQ56KM0mcPNd7BpUYgPmmeCmBDhxcOb2t6FIySlcZd55D
         1qIWA0KtrV4+E7XIi56hQfqnFzc/caVrFgZZCoEDZgLjXThCWv0kwgtAktyKFzurTEeV
         wmSWLFxPer8Y0fnwi+BfBTG7JwJ2O5d9/8iuB/Dwzh8MKru3FqpwsF4fV4cDo3fBT1YF
         Kqb0Zgc9CD4x9i6PyNB0xI34Sm4wP+RnuTy1xUtPpNO+FaUhIUP7hb/0jGCaUVkgQLhw
         xQGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759745176; x=1760349976;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qdL3Gjg4YnZQbKleKeTBCKkou2FNTLhQNiPxLrTgrlE=;
        b=FNHNiswx+SMeLMaWL9MZPmVG27gkHXfxLNwuGIIrPmsWgQxrloWsZ3m2FRRahqaFKx
         zGjqpi+Ddouk9GiOOWHkuhPGsMdzT0AWtwRjN2XRcNjkaPfA9VAUq/Xl+YSF75icc5Yj
         Oh5G6l++GtspKlGQyCZGo8OmhoFvxugzmJ49grHpN3+ELG0ZfFN0T7mlpCZs5HC+xesS
         zalGStrK3oZwFkpwqHw6AduUkiTe0E+R89it67VMjyhoKZ5HnUpgljPzpBEhwM180khF
         NluYD6UDh4LlLer61Di7C6LPyGnRpLOyhvAJ43rdbhOdvsjPETzkUUEg4kkTxz+ecmQQ
         /Llg==
X-Forwarded-Encrypted: i=1; AJvYcCXtv+Z6YLoze0PUDg27VN2sauGLg3IhZH6gg50Jzp7iGGNFQ/OvoWqX/qe4LWmdK6LsBIA0j10oxIp+59Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxX2RnwLBcOHdLHfn9Y15AXNr6Gf8Tk0DWLS/5/5oh45U1S+z/q
	FlypHAsSWdA2qzg9bvYvgJywqOXzLC85VTUiDlA3zQ3TTzEWOCSkbxXa
X-Gm-Gg: ASbGncvdSWsnIOvNpnCip+rAo9vDHBBz35eCWQhe3PvDTNk/cZx4Qn2PKoXOxseoM4b
	wVe12SCX41DRKTqO0OjQKeT2qk2noRHfVNj++ThWC9V7miBtrOtQ2xfzEjvInAZ9A9M58DmCYQI
	syizZ2G0DoC/HLniuw+og/2hFs4tFGw/xUHgvE0Il9bVC+yi8x4P5RzNjj4Qua46bDcQWf8c643
	OQAc/rIduf4fKZEhd3ArePgJQ/2na4VjCGTzYxHbYc3maiJ74z5u18AW5ePmYAhxse9Z8VAXrNw
	xX5utleZP2t4AThhV/7bQy24jYFTa6Str3Z77HCprCJOp8/wfUkAVXpreUwNzi+Q49Bg54DOVdq
	eJ1nWlBMCP5e2sQ==
X-Google-Smtp-Source: AGHT+IGkGnHbLIn801xCGU82RWbYfOTtwD3A6j+paaPOoROSvLFCIITJYaZdYOz0jWnjfr9kA2bjBA==
X-Received: by 2002:ac2:5684:0:b0:560:9702:4fe6 with SMTP id 2adb3069b0e04-58cb9f0b790mr4028661e87.24.1759745175951;
        Mon, 06 Oct 2025 03:06:15 -0700 (PDT)
Received: from milan ([2001:9b1:d5a0:a500::24b])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-58b0118d372sm4887469e87.87.2025.10.06.03.06.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Oct 2025 03:06:15 -0700 (PDT)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@milan>
Date: Mon, 6 Oct 2025 12:06:13 +0200
To: Baoquan He <bhe@redhat.com>
Cc: "Uladzislau Rezki (Sony)" <urezki@gmail.com>, linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Michal Hocko <mhocko@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>, Michal Hocko <mhocko@suse.com>
Subject: Re: [PATCH v3 09/10] mm/vmalloc: Update __vmalloc_node_range()
 documentation
Message-ID: <aOOUlW0SbBcPM6Mq@milan>
References: <20251001192647.195204-1-urezki@gmail.com>
 <20251001192647.195204-10-urezki@gmail.com>
 <aOCejd0aghFS8iSO@MiWiFi-R3L-srv>
 <aOCqSrnazd2YwGbe@MiWiFi-R3L-srv>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aOCqSrnazd2YwGbe@MiWiFi-R3L-srv>

On Sat, Oct 04, 2025 at 01:02:02PM +0800, Baoquan He wrote:
> On 10/04/25 at 12:11pm, Baoquan He wrote:
> > On 10/01/25 at 09:26pm, Uladzislau Rezki (Sony) wrote:
> > > __vmalloc() function now supports non-blocking flags such as
> > > GFP_ATOMIC and GFP_NOWAIT. Update the documentation accordingly.
> > > 
> > > Acked-by: Michal Hocko <mhocko@suse.com>
> > > Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> > > ---
> > >  mm/vmalloc.c | 21 +++++++++++----------
> > >  1 file changed, 11 insertions(+), 10 deletions(-)
> > > 
> > > diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> > > index d7e7049e01f8..2b45cd4ce119 100644
> > > --- a/mm/vmalloc.c
> > > +++ b/mm/vmalloc.c
> > > @@ -3881,19 +3881,20 @@ static void *__vmalloc_area_node(struct vm_struct *area, gfp_t gfp_mask,
> > >   * @caller:		  caller's return address
> > >   *
> > >   * Allocate enough pages to cover @size from the page level
> > > - * allocator with @gfp_mask flags. Please note that the full set of gfp
> > > - * flags are not supported. GFP_KERNEL, GFP_NOFS and GFP_NOIO are all
> > > - * supported.
> > > - * Zone modifiers are not supported. From the reclaim modifiers
> > > - * __GFP_DIRECT_RECLAIM is required (aka GFP_NOWAIT is not supported)
> > > - * and only __GFP_NOFAIL is supported (i.e. __GFP_NORETRY and
> > > - * __GFP_RETRY_MAYFAIL are not supported).
> > > + * allocator with @gfp_mask flags and map them into contiguous
> > > + * virtual range with protection @prot.
> > >   *
> > > - * __GFP_NOWARN can be used to suppress failures messages.
> > > + * Supported GFP classes: %GFP_KERNEL, %GFP_ATOMIC, %GFP_NOWAIT,
> > > + * %GFP_NOFS and %GFP_NOIO. Zone modifiers are not supported.
> > > + * Please note %GFP_ATOMIC and %GFP_NOWAIT are supported only
> > > + * by __vmalloc().
> > > +
> > > + * Retry modifiers: only %__GFP_NOFAIL is supported; %__GFP_NORETRY
> > > + * and %__GFP_RETRY_MAYFAIL are not supported.
> > 
> > Do we need to update the documentation of __vmalloc_node_noprof()
> > accordingly? I see it has below description about "Retry modifiers"
> > where gfp_mask is passed down to __vmalloc_node_range_noprof() directly
> > but have different description. Not sure if I missed anything.
> > 
> > ===
> >  * Retry modifiers: only %__GFP_NOFAIL is supported; %__GFP_NORETRY
> >  * and %__GFP_RETRY_MAYFAIL are not supported.
> > ===
> 
> Sorry, I copied the wrong sentences. Below is copied from documentation
> of __vmalloc_node_noprof().
> ====
>  * Reclaim modifiers in @gfp_mask - __GFP_NORETRY, __GFP_RETRY_MAYFAIL
>  * and __GFP_NOFAIL are not supported
> ====
> 
> 
> > 
> > >   *
> > > - * Map them into contiguous kernel virtual space, using a pagetable
> > > - * protection of @prot.
> > > + * %__GFP_NOWARN can be used to suppress failure messages.
> > >   *
> > > + * Can not be called from interrupt nor NMI contexts.
> > >   * Return: the address of the area or %NULL on failure
> > >   */
> > >  void *__vmalloc_node_range_noprof(unsigned long size, unsigned long align,
> > > -- 
> > > 2.47.3
> > > 
> > 
> 
We need. But i am not sure it should be fully copy-pasted from the
__vmalloc_node_range_noprof(). At least __GFP_NOFAIL is supported
and thus stating that it is not - is wrong.

It has to be fixed but not by this series because when __GFP_NOFAIL
support was introduced the doc. should have to be updated accordingly.

--
Uladzislau Rezki

