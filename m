Return-Path: <linux-kernel+bounces-819404-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 08FBAB5A020
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 20:08:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8BBE5818F2
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 18:08:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E8F228D8D0;
	Tue, 16 Sep 2025 18:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="O8q28+yW"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34DF0283FD0
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 18:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758046103; cv=none; b=Jn2mYfnpJq7Hrd2gBJY4ewa4rbRQ+jTHdDHZeo6ADoxMY+PKywyGF6+CrqZ/60TdH/cjwABBmrdOCwt6efQa7smkYl18tW3DpqMbyVza2sga0r7IEkqOp6nTpQXMwwywPJSvtFI1ZdPlohwgbBjgohY7f8ITSb4JrTn+HT1sJ4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758046103; c=relaxed/simple;
	bh=pDTan+4f+mSkkUiiRphY2uiAuCcHQQF6JhXCubg7vUo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oi1RVovHFabLfDDT5K/weyS3GU2d3B3iPfQEC7HUCyYAk3MnXvRIGh1+8lfvckHjG5tQ4y1Es149Zq45OKi5hJ1xZoowO3b9H3L9k9jZ+/LYtlr3Jw3B+53aawTErB34tSKW1UWZa9bdB9SLUTnZeCTFSss6jJoowF7z8LVZ1fY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=O8q28+yW; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-628f29d68ecso11313513a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 11:08:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1758046099; x=1758650899; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=C9wPiuMA/lNn5RD0leBMSssZIAOEsu9p7VC5bMNaBr4=;
        b=O8q28+yWwBeqOrbg8itzC5+WGZrzFrfonpwKTJOA8W3YfDBz3Lo+gr6fazx7riz3Ub
         jnAqxRnOjWVHVTeFqaKAG/nWGiGYHWqsg9Ata3JQ5EgDVNa+H/jHB0whb+wxjlRjFEKd
         w21Xd3yUiTlZ3hmJr7I5dobCdIClHbTaZfSu/ze91NRxjU1im60hWpCHqVgW6b+Cyxvy
         zDFSxeSAIF8uGh+lItXmLcUSa81hI81rQUH0UuXLMxPkVqm7zA9wQDxk3rC+0oASYvpH
         7obQityi6BAborM2tqCvN9tLm+nTsXBIvAEe/fjsnHTxvj23/o2ZbNWnM47nsXCWHfNc
         9WKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758046099; x=1758650899;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C9wPiuMA/lNn5RD0leBMSssZIAOEsu9p7VC5bMNaBr4=;
        b=uXIRh51LfVo2GgJGlzaXXZGkXDHVEGbP4rgCuMjkdVJp4sK+Hq+9NTipWDplsflU6X
         2MHo9KpiQpAivMBgPEQ9NV/XYifd2HxlW/hTyoZK+v/6+uGPo4LU+l7PA0HOBnfXJuu9
         1H1vEMTC7eQWiIfxWwMZxffGj8J5BFiNHuBUZAJh7MfoIYkjNA7Ip6X4wpJFFvUwaBnu
         RK7bpypQQ2plihlKnLVpmpv7+xsyOAXBG8rhzPTv5kb3iINIqVpOvaLmF7SbI1VXTh3O
         wm50aeXFLFhEhJPYJMeTii1tjPXY0ixn6dSOl/A5SjLutTJTmaQpB/LQ088v9lSSvA4S
         JLHA==
X-Forwarded-Encrypted: i=1; AJvYcCXnTRteYx79gVouEZnz0+6etlyxxs1GkBLOWK5cx4U3f4pQoVaFqgz3lFTeGlFtVLSzzwIdW3foSBh1BhQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4Q3XmtErRQeyhww6Zux2jSXQBLe+0T4pVqHwhOq2eURHMvz5M
	nqBHowgAp7nqjghU7dr/D64A/u3THgvWOvwwdNr6nEr1vOKdGuLWm7ULxvBaWV3NWVKtIbAJmkJ
	Vvd/j
X-Gm-Gg: ASbGncvyjSugvPpFbgwcD2kIcLYf86J87ZhpVNqPAlbcjzOrVpweCmSaJ2Rec7mcPgG
	p9fYHzIJgfnCjEieSDk7JE8Uap+iWlHCICK2+fSwgKwznl31sLn0ZEnBw/kEMZV/+wpNCM30nAx
	ZC5LTO/HJ9mL47IT2BucvXT5V93B91ZEt7Y3Ik7ralZ7eEfESMYl2l/sSYgGX7moQWZxYqla6m5
	HP0g9vBWarwVOTtMj+TbOXkgY0dGQ5A/CeUW+FLzkKDJWBpK7TaaQ2X8aH9TTYFZe9ngDQBC9RZ
	XxLqyOE5Knng7GHMTYSzJvXmsbuLhXu/w8ijV0uwC83BoGOkDQRqjXWqCGlrvfcHqCVlKLPwEKY
	vVUwyJmTIRdO+2/A+CytfdfPdwk7aPCty0Q==
X-Google-Smtp-Source: AGHT+IEmjqMbM7yAVIrWQBEMCgOpxwhHuI9jQbonVbCl/9GRXITN0RxctJFLvP6OJyCRvVP2xIq8PA==
X-Received: by 2002:a05:6402:1ec1:b0:62a:82e8:e1f6 with SMTP id 4fb4d7f45d1cf-62ed841e656mr16870681a12.36.1758046099490;
        Tue, 16 Sep 2025 11:08:19 -0700 (PDT)
Received: from localhost (109-81-31-43.rct.o2.cz. [109.81.31.43])
        by smtp.gmail.com with UTF8SMTPSA id 4fb4d7f45d1cf-62f11390075sm7251508a12.40.2025.09.16.11.08.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 11:08:19 -0700 (PDT)
Date: Tue, 16 Sep 2025 20:08:18 +0200
From: Michal Hocko <mhocko@suse.com>
To: Uladzislau Rezki <urezki@gmail.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <bhe@redhat.com>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 04/10] mm/vmalloc: Avoid cond_resched() when blocking
 is not permitted
Message-ID: <aMmnkm_E7hDO_yN0@tiehlicka>
References: <20250915134041.151462-1-urezki@gmail.com>
 <20250915134041.151462-5-urezki@gmail.com>
 <aMhIv3HfRMyjlSec@tiehlicka>
 <aMmCJOJFMTuCXH3m@milan>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aMmCJOJFMTuCXH3m@milan>

On Tue 16-09-25 17:28:36, Uladzislau Rezki wrote:
> On Mon, Sep 15, 2025 at 07:11:27PM +0200, Michal Hocko wrote:
> > On Mon 15-09-25 15:40:34, Uladzislau Rezki wrote:
> > > vm_area_alloc_pages() contains the only voluntary reschedule points
> > > along vmalloc() allocation path. They are needed to ensure forward
> > > progress on PREEMPT_NONE kernels under contention for vmap metadata
> > > (e.g. alloc_vmap_area()).
> > > 
> > > However, yielding should only be done if the given GFP flags allow
> > > blocking. This patch avoids calling cond_resched() when allocation
> > > context is non-blocking(GFP_ATOMIC, GFP_NOWAIT).
> > 
> > We do have cond_resched in the page allocator path, right?
> > So unless I am missing something we can safely drope these. I thought we
> > have discused this already.
> > 
> Yes, we discussed this. I did some test with dropped cond_resched() for
> !PREEMPT kernel and i can trigger soft-lockups under really heavy stress
> load.
> 
> I prefer to keep them so far for consistency. I need some time to
> investigate it more. As i noted in commit message, the vmalloc()
> path only has those two resched points. Probably i need to move
> them into another place later.
> 
> As for page-allocator, it is in a slow path which i do not hit in
> my stress-setup.

OK, so the fast path can trigger the soft lockup? If yes please mention
that in the changelog so that we know why this is needed. With that
included feel free to add
Acked-by: Michal Hocko <mhocko@suse.com>

-- 
Michal Hocko
SUSE Labs

