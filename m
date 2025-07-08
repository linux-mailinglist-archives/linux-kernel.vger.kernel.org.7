Return-Path: <linux-kernel+bounces-721532-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18194AFCA7C
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 14:34:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37A97483E35
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 12:34:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8DC12DBF47;
	Tue,  8 Jul 2025 12:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d5jPaDGz"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AABF2DAFD4
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 12:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751978075; cv=none; b=NYcoO56t9cw/nCMRRVawmf+V8SCrd4l+E8UhvjNpiB/Lh1BgqT+p48D/U0ml6/8pBF5ETAuo9XMSY2+TlzZEvq3UQpeouHhEJORcLOAwtbWkOa8NYffdjrw97WOk7PuMd8y0LT6A0QbwmXu29xSBNOnl8QpwDS1Q+V+y44C7JsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751978075; c=relaxed/simple;
	bh=pf0HGCeJ2Nb6msHI0yQF0b34NgOCnYnA17pYijVozJU=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lw61z4lhaSBK8Bodw1hOyEUX4Aqw31QJUimOT6GibDj2nKGYgGPFcnvJlFSEzkxOJsi0vzoo0DOcc8wxTYdQnG+HSzv430ZMHoPIG3aV7Le9sar+jlTzkkwqKF6++aqXu/198AnyxliksQ4q2Fen4vYh5LNc1BRBfXhLbe0lI1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d5jPaDGz; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-555163cd09aso4036613e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jul 2025 05:34:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751978071; x=1752582871; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=n+JkPlumNTbxgwgF8kLIrGh4tq+DhXPrXWerFx8vvu8=;
        b=d5jPaDGzghJLbJgKYPD7P0Op7w/1ogEV098Y5wGQvaMFQWOox3O3Te4oY4s1U9maaO
         PdclGvA7VYzWPThvm363GxxgKNeOnR5C5cXLqsB+1yF9/fsLMovKRhFHL1NP49nWQxd6
         J+NxpZwsBhZt+ZoBoH6KBl/P+ZOC9tkY8/zMUli21WeRFx8jJHxOxGwCyXNR/SV72ALZ
         aC9cxmpyFdkKSKHHfqJRZfcs+4DDgyfoG2BZ4YzozaWwJnaNjBraAeSOr1lJJt6oiOvq
         F6iNcIWcGS3tmsi33uvOGqb2cS+z9NP09HOPMvZTwaNqSZpEBjZFwZIl8BaxOSKu+Q4v
         /THg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751978071; x=1752582871;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n+JkPlumNTbxgwgF8kLIrGh4tq+DhXPrXWerFx8vvu8=;
        b=TmUT+EquE8rHo8uXDOHm3FQJ2e0WVas5NwXdz1frprWyiJ3zlOjactOA4W4rA1Qs5O
         sOtqSr/d3sEH1ulGkGjhNqfGnNSFdVF4lf+gGNALSgla3Q+WUUcg2mXwq194q7+RTYON
         UDY050hGwd6Zdv8npJtUKQpE4sJHoDLP60n7H6jEuHX2vz19l9CUw7p8vN87pGACrKBx
         SOKsEa8DflOKvfVMjMOqBHEYnM6niowbqU61XpkcIM21gpwhVxUJwCF/gc7DMWgLdxo4
         IOwFTi6CE+jM8/nmaGuYwLfksUulX4Mgpk4FhUashLCay7/I/Pnu9NN3CHvDUJ3SdSqH
         rAqw==
X-Forwarded-Encrypted: i=1; AJvYcCVn2PYB+qApRXjYoCe1tCMgocjKuzzrPJekQvolDsP26kg+XHWvCJo7jXQcMYNOTNRVH8SBId+eLXnI5z4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzBdwA5KR5oTqKKpg6PMrIbzbHwR0/QSYWwBhxmnsRudN/QX0L
	VHwVt7EFB8DjrF2ql+HdFBdXc3Ni2zbB97twW1X3Ys038tUlyvoIYwh5
X-Gm-Gg: ASbGnctDYLN9qG6pNmPCtuwvhsd/qGUFbygUAr9y6vkUkTofV/+J/gZy06N/YxlL7HJ
	StxySus1BJxMdXGwYlRiVt9Eo1Wu91uihYM0IP0FpTybEw/q+n/NQ6/GCaeBv6I2Uf0LhFQC3Ft
	POTPYhhyt/khSQW8FfNda0M2bjNhZ5tQMMpDjzjjkwzjekkg4bAw4q82HYm1mwPTpENkrA16ZrK
	GcI/T+gU93BtzwxEieO0DhlE6KthcWo8XUkFIm2v2AfxPKWwiNc0QrKDGnE2b+bZEWBL2SY6vzt
	nDIpg72xXTBQA8hs22lSyIEjUnvkdh/dqHp7n1B56Y6AI4+22Ksa5RjPEMyPJ3YL+U4bgqqQUpq
	vl3cmju4r/so=
X-Google-Smtp-Source: AGHT+IGslitvCMgfD4hwG2DI9E5eXm6p9TwNVlZAs/AD3mbRSrZGkM0LIz1pPn68rQKvPUV12fFubA==
X-Received: by 2002:a05:6512:b83:b0:553:381f:c45b with SMTP id 2adb3069b0e04-557f8322394mr1134312e87.19.1751978071092;
        Tue, 08 Jul 2025 05:34:31 -0700 (PDT)
Received: from pc636 (host-95-203-1-180.mobileonline.telia.com. [95.203.1.180])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-556384a8400sm1646812e87.164.2025.07.08.05.34.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jul 2025 05:34:30 -0700 (PDT)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Tue, 8 Jul 2025 14:34:28 +0200
To: Michal Hocko <mhocko@suse.com>
Cc: "Uladzislau Rezki (Sony)" <urezki@gmail.com>, linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>,
	LKML <linux-kernel@vger.kernel.org>, Baoquan He <bhe@redhat.com>
Subject: Re: [RFC 2/7] mm/vmalloc: Support non-blocking GFP flags in
 alloc_vmap_area()
Message-ID: <aG0QVClTHrP0oPLm@pc636>
References: <20250704152537.55724-1-urezki@gmail.com>
 <20250704152537.55724-3-urezki@gmail.com>
 <aGtzJyYPKA7Hn6kQ@tiehlicka>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aGtzJyYPKA7Hn6kQ@tiehlicka>

On Mon, Jul 07, 2025 at 09:11:35AM +0200, Michal Hocko wrote:
> On Fri 04-07-25 17:25:32, Uladzislau Rezki wrote:
> [...]
> > @@ -2030,7 +2033,8 @@ static struct vmap_area *alloc_vmap_area(unsigned long size,
> >  	 */
> >  	va = node_alloc(size, align, vstart, vend, &addr, &vn_id);
> >  	if (!va) {
> > -		gfp_mask = gfp_mask & GFP_RECLAIM_MASK;
> > +		if (allow_block)
> > +			gfp_mask = gfp_mask & GFP_RECLAIM_MASK;
> 
> I don't follow here and is this even correct?
> 
Allow nested flags to follow a user request if there is a request
to not block. For example if we apply GFP_RECLAIM_MASK to GFP_ATOMIC
GFP_ATOMIC is converted to zero, thus to GFP_NOWAIT.

> >  
> >  		va = kmem_cache_alloc_node(vmap_area_cachep, gfp_mask, node);
> >  		if (unlikely(!va))
> > @@ -2057,8 +2061,14 @@ static struct vmap_area *alloc_vmap_area(unsigned long size,
> >  	 * If an allocation fails, the error value is
> >  	 * returned. Therefore trigger the overflow path.
> >  	 */
> > -	if (IS_ERR_VALUE(addr))
> > +	if (IS_ERR_VALUE(addr)) {
> > +		if (!allow_block) {
> > +			kmem_cache_free(vmap_area_cachep, va);
> > +			return ERR_PTR(-ENOMEM);
> 
> I would suggest to add a comment for this. Something like
> 
> for blockable requests trigger the overflow paths because that
> relies on vmap_purge_lock mutex and blocking notifiers.
> 
Thanks, i can do it easily. Also, this is an RFC i think it should
be split and improved. Maybe to move out some functionality into a
separate function.

--
Uladzislau Rezki

