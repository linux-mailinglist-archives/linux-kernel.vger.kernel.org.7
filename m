Return-Path: <linux-kernel+bounces-838054-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1930FBAE538
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 20:39:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E08DD4E2804
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 18:39:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C134238175;
	Tue, 30 Sep 2025 18:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BdqRu4TM"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F5DF33EC
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 18:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759257556; cv=none; b=RyqM0puvZ7qsGkKRuiOhT8rNMq2yTRoFPvQsgPrfhZoSIeeKGCOMicJbnVKYEgrT1/Vn0IwU01HBlU7NsmKTEiaib4K4hu1+wF/XMC+3G9v15uo1H93WNCAjiA5vXC+uDa3H2z2xCorGEJe5OslknurMvBi25CruXC8G1eVfAq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759257556; c=relaxed/simple;
	bh=41FcYWDCd//svS7G9UxD4xdGwTB1l+wDZ7lVXeNhM1w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YQozwaWUuvmsjMPUjo+3LL5VACVNNIMKGD6yVh1sHCu760laRDOHF2XWDYs9MuJJYS8LiTzjASli2hbpnqiKMUT/4KuNqGKmuQPxh3kectlTlLjJTa976nfk7+YRosz7Y51+EWGe7wzTQUmjW2ih5zlHsFhmuZ/iI9H79MaxyJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BdqRu4TM; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759257553;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eOcI1ZIbD/HvHYX2YhFw02/XoFtTTRUFMmkH7W3cd1M=;
	b=BdqRu4TM5RPp+ZKTCMH1H1R8hB+IntqL0kCSFVGpQbkWxudc6DBZdjC+TZJWGVaXT5oQOH
	z4KGaSeMoE2aHUC2RBAlr3XFfwS+an/FY5yWt5FeVSEWsU/Q3lJ5F1HSWYJExR+Xx1TCfS
	C7sgEVC7HrM0mnQWwHEI+58CwByuQUQ=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-642-ZP-bO4GMOYqZwDwEs07doQ-1; Tue, 30 Sep 2025 14:39:11 -0400
X-MC-Unique: ZP-bO4GMOYqZwDwEs07doQ-1
X-Mimecast-MFC-AGG-ID: ZP-bO4GMOYqZwDwEs07doQ_1759257551
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-78e30eaca8eso178367526d6.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 11:39:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759257551; x=1759862351;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eOcI1ZIbD/HvHYX2YhFw02/XoFtTTRUFMmkH7W3cd1M=;
        b=izUWi7sxVVh7aHlvHL7JdC7KHnIAnswxqHrqVBxzd5F8qU/Cw4VL0SF5pC7cHOqWwb
         zHug2BmCZuPbPLC7phaerLvI9Vk/S0LVusiOHk5n57i1ND1ICr63JVJ0vfs5bbs+T8yC
         Mdye3XMg6tG/1HtYyn0Ah436z49aBCF6KKUo8TUSBTfAgDS4R4nQ3DcTKtspZETuSdDU
         bsmdkXSOcVeVlktSdKiKlXl42pmcJVYxTzb7blk4yGtXJcKDGUUMalBO6sJeH2BJKGa7
         rhweuJCB93RTtVmpOPv8dCI9vljTv0zc9lMIcDqBE/KaWEVn6GLFqV1RZldZyEnW0tXB
         oNpA==
X-Forwarded-Encrypted: i=1; AJvYcCWSGoj5XZ5wWs/GlQb/hgjcWN933dIs7PPFWuwbGonxteM/Nu5nJ7g7WPlDKf2EcnHqJcyPv4jHSQf+QBQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzX+zCQW5srzEMNsZYJpF1OitVjkgUVQDzqAarDAiddbBwwcy1U
	fJBmmQMV+OqUrt176gwvNhJ1Q/ILw4qIBT+sT6BuuQkC2EXmeNGBPb5vbuuqj4UwAbsjBzHADZH
	jqpgT7ckOa0p00PsDyD4rD4jkAHuzNYlOX5vJ6ws0CFXLloUG+pjn//aZHweIiP+QLA==
X-Gm-Gg: ASbGncv1jKPkNRsEUbF5tNmKnFajtbj/AEOowm0yh0z3x/Y8x8rBROEYkISpOubEJLo
	JsxG77Ta0zu3CtXjYQ6TuSf5kdyxhrgLC4op1HDKLxpTxdWYxEYNyY/ObPM9WULvTislurCqqDg
	Ov8SedNL6hskpYjwIiriMUl6zNc6WBPJNhDirAeT/A4pHkChTaOmPPV9VuNjMEiKjWa8CN1kX/8
	DjKIY9Idda0bhZ5S9H6QlAATZJ1zb2y0zQgoX5OlK2SHuMJitNWs1Rlq3S/u3j82IdWpG7JSndr
	coNixTjB58JddWxtC+5+uXIs9MT/t8f8nG7Sbg==
X-Received: by 2002:a05:6214:f25:b0:86c:1f66:e2eb with SMTP id 6a1803df08f44-873a4dca4ecmr9343316d6.33.1759257550949;
        Tue, 30 Sep 2025 11:39:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IElCA+Ys8V7FHTo8o4fXzI+Tp8Ue5gMs0OVn2KTplxlHdrIW9wKkjuDv1J29s1qR50z6aY/Dw==
X-Received: by 2002:a05:6214:f25:b0:86c:1f66:e2eb with SMTP id 6a1803df08f44-873a4dca4ecmr9342926d6.33.1759257550445;
        Tue, 30 Sep 2025 11:39:10 -0700 (PDT)
Received: from x1.local ([142.188.210.50])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8013ca1f1desm100257506d6.23.2025.09.30.11.39.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Sep 2025 11:39:09 -0700 (PDT)
Date: Tue, 30 Sep 2025 14:39:08 -0400
From: Peter Xu <peterx@redhat.com>
To: David Hildenbrand <david@redhat.com>
Cc: Mike Rapoport <rppt@kernel.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Axel Rasmussen <axelrasmussen@google.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	James Houghton <jthoughton@google.com>,
	Nikita Kalyazin <kalyazin@amazon.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Ujwal Kundur <ujwal.kundur@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Andrea Arcangeli <aarcange@redhat.com>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Michal Hocko <mhocko@suse.com>, Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>, Hugh Dickins <hughd@google.com>,
	Suren Baghdasaryan <surenb@google.com>
Subject: Re: [PATCH v3 1/4] mm: Introduce vm_uffd_ops API
Message-ID: <aNwjzC1mlnHwEgsd@x1.local>
References: <20250926211650.525109-1-peterx@redhat.com>
 <20250926211650.525109-2-peterx@redhat.com>
 <f1da3505-f17f-4829-80c1-696b1d99057d@redhat.com>
 <aNur9nbdnlykqbU7@kernel.org>
 <186ef2e5-bd0a-46e1-a88d-2fc5448c1c72@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <186ef2e5-bd0a-46e1-a88d-2fc5448c1c72@redhat.com>

On Tue, Sep 30, 2025 at 12:18:37PM +0200, David Hildenbrand wrote:
> On 30.09.25 12:07, Mike Rapoport wrote:
> > On Tue, Sep 30, 2025 at 11:36:53AM +0200, David Hildenbrand wrote:
> > > On 26.09.25 23:16, Peter Xu wrote:
> > > > +	/**
> > > > +	 * uffd_get_folio: Handler to resolve UFFDIO_CONTINUE request.
> > > 
> > > Just wondering if we could incorporate the "continue" / "minor" aspect into
> > > the callback name.
> > > 
> > > uffd_minor_get_folio / uffd_continue_get_folio
> > > 
> > > Or do you see use of that callback in the context of other uffd features?
> > 
> > If someone picks the gauntlet of refactoring the loop in mcopy_atomic()
> > we'd need a similar callback for uffd copy. And as I see it it would be
> > different enough to warrant emphasizing minor/continue in the name here.

Sure, I can go with uffd_minor_get_folio when I repost.

> > 
> > I also think we can drop uffd_ prefix for the callback, as it's called as
> > uffd_ops->get_folio() or whatever it's be called.
> 
> Agreed. I got annoyed yesterday when typing vma->vm_mm often enough
> (vma->mm! ).

That's also why I kept uffd_ because that's the tradition mm/ uses in many
important data structures like vma and mm.  It helps most tagging systems
that most Linux developers use to avoid global name collisions.

So I tend to keep the prefix for now, until we want to switch away from
Hungarian-like notations completely. But let me know if anyone has strong
feelings.

Thanks,

-- 
Peter Xu


