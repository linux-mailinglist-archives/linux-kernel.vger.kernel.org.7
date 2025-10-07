Return-Path: <linux-kernel+bounces-844700-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EEFE2BC28A7
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 21:42:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 759DA350490
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 19:42:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 803C62E62C7;
	Tue,  7 Oct 2025 19:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q6iITTHQ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA8602DC333
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 19:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759866121; cv=none; b=YPWuHMNppu0ndqZpuXT8ckiP8DCj82VQh7K95tQuHR90v/NHddr3Ru/rRmQXmkRsMUFkrsXjnOyxqc5sXX9X/lfaLLnLi8mKu54DMHO7F1Hm+VtzujJIKiXyrGSeCEQwq+RJiivzLnQtik6qIjegl6TzKNDstJ/8DesdHbe9zLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759866121; c=relaxed/simple;
	bh=2Bp0PwZHyW3wF+C/YUNQSaYvrZmPJZZxfki4LO/e75w=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gn2n153JhwWkvWOhYHu6azrHrcAP4+gXw7J2jYPlHZffCQ8cUDbNIjhTDwY+Ckt9q5U6v6WydW5xNRdXwgq6vBfgsVP+YQjOKJkQMIvQpUGn/LlaVRRk2RX1b/lKh6Mk51NbWtyA/79GxdoPlsvNxar4HOspqtjY1VBW2+c49pM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Q6iITTHQ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759866118;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zRD8Y24rfOwZBHOlWyyDCKiTB/jD/NkvAE4w5vB3uEw=;
	b=Q6iITTHQYvb11sUb0WooAJWW+t8YUFEpn+gw+9vss1pYAjSVPinQo/ecqF1n68ldU9RsHa
	UU/zvlK7wxdeijjcUlGr7Mx2TvqrOIV4khwTQEDB24RAmvZnAAlqGVI6v3+JvUY4zSm4/y
	S4cHsRH4UrUxtRG7TXhO3U6oarmBHMw=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-426-VgYFpL_kNSiyNxwxTzqklA-1; Tue, 07 Oct 2025 15:41:56 -0400
X-MC-Unique: VgYFpL_kNSiyNxwxTzqklA-1
X-Mimecast-MFC-AGG-ID: VgYFpL_kNSiyNxwxTzqklA_1759866116
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4dfc05dec2fso253568051cf.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 12:41:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759866116; x=1760470916;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zRD8Y24rfOwZBHOlWyyDCKiTB/jD/NkvAE4w5vB3uEw=;
        b=AKv/DiS/qSnEokZZ/fda5/qbXl32ASjgRgMqiipT4x/ZpIhsanHUuoDcriKmc6Naco
         VHDJ/c86h/q6yTqM9xB1OHZ6PkFpnHbmHCk/rdaRoP8UFulZZ0w/9P+pO1R0GRRNS1qr
         Q+muT+mf/hdbO8bMFVqt69vB1o/O60+nDbwS7HBJz2xNIFb0lnIAnslCu/iQqxCxyAFX
         e3cJ1L/Hq6sYkkNiYbls7+uBpMq78AfD3ADcfsMwtrbimuCekfch4uKvIn+53OtWXDu0
         7epquP0EbKcs661KPARbsKA2rA7Yg0obmlvz7FR0EiGzowLO9QIcDd+/v07gPYJY31NT
         +z4A==
X-Forwarded-Encrypted: i=1; AJvYcCVJqfEGd9e5/tCayD00M0H46gAwvAm/6M4ruChtmD/ggY0yEZHIiOC/UuNjzyKrjawkYZLnkPAR/u2cfEA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfiiUJtqxP8GeL3zr8PiDfhE/S73ytPaEa2zcmOpOaGCOYjEjR
	6kbwevw9LEg3IyvVAVTMPP3CVWg3pIB9q6+f7felpBg/NFv0GUC/rYe3elJ+ikxlLQ9F9f0ITG+
	MpwToTDFCmViw0zaJvqacHBpboOWBJLZ/Q9f+5sqN3D9a4uShFXwDlCqpo2+cqUr3rw==
X-Gm-Gg: ASbGncve3FBYcpg6aCqBMsn8vMC5nRPc3r2FXY1cjnb9aP/agIJVTd7yoPWAwqfBR3q
	fc9fnjhdbI4ql+Cafo8Pb8Naysp6r98IdVa5FIQMTZMrEU6BM5OlQObGUjrFhn9Od3ltXfxIYoZ
	nazJi4UUCNoYCwAb+P+W2NAblbV6tIkKBlIrH7h16gyHAvvqu/Y//Uc0FzgzwpdASxy0poj9DNW
	9IdWGa8HrhWPn5L8/qw2bET7Ad70tBxRy47GR2Sy5SyhvP8oiOFb7OoxMqUxjdpVzl+gCkU/tfL
	/1Bo6nqcP65klsRBtDkUsXGbVcABx7c5HG7p0A==
X-Received: by 2002:a05:622a:2593:b0:4dd:2d5a:4c81 with SMTP id d75a77b69052e-4e6ead6b8d2mr10550771cf.80.1759866115748;
        Tue, 07 Oct 2025 12:41:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFGlDdIA/7LCIBCuSR0IVfWs+CBYQn3+44+6aZyv0zDCvJHB0MK6MuVqYhuG/1465hjHYnfrw==
X-Received: by 2002:a05:622a:2593:b0:4dd:2d5a:4c81 with SMTP id d75a77b69052e-4e6ead6b8d2mr10550231cf.80.1759866114994;
        Tue, 07 Oct 2025 12:41:54 -0700 (PDT)
Received: from x1.local ([142.188.210.50])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4e55c9e77bcsm149262041cf.24.2025.10.07.12.41.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 12:41:54 -0700 (PDT)
Date: Tue, 7 Oct 2025 15:41:52 -0400
From: Peter Xu <peterx@redhat.com>
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>,
	David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Axel Rasmussen <axelrasmussen@google.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	James Houghton <jthoughton@google.com>,
	Nikita Kalyazin <kalyazin@amazon.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Ujwal Kundur <ujwal.kundur@gmail.com>,
	Mike Rapoport <rppt@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Andrea Arcangeli <aarcange@redhat.com>,
	Michal Hocko <mhocko@suse.com>, Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>, Hugh Dickins <hughd@google.com>,
	Suren Baghdasaryan <surenb@google.com>
Subject: Re: [PATCH v3 1/4] mm: Introduce vm_uffd_ops API
Message-ID: <aOVtAMm8PqEbGANh@x1.local>
References: <ad124fb6-a712-4cf5-8a7e-2abacbc2e4be@redhat.com>
 <aN_XZbQjuYx-OnFr@x1.local>
 <cq3zcvnajs55zr7cplf5oxxjoh54fb7tvo23hehd5dmh4atvum@6274mneik6hu>
 <aOQuZy_Hpu1yyu29@x1.local>
 <akld3v2mtnjdqvs5dgwr4gnffdqf5dojwhmfylq3mkfzakjj7j@5oqqxsymkcbp>
 <aOUa8C8bhWvo5TbV@x1.local>
 <frnos5jtmlqvzpcrredcoummuzvllweku5dgp5ii5in6epwnw5@anu4dqsz6shy>
 <9089d994-262f-4941-8bed-f3c6ee05a769@redhat.com>
 <aOVEDii4HPB6outm@x1.local>
 <6csw4pmymno4kdtlbzd74posr3dekamq4zkje2mfkmbg5q7xbx@y3o323tbm7h3>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6csw4pmymno4kdtlbzd74posr3dekamq4zkje2mfkmbg5q7xbx@y3o323tbm7h3>

On Tue, Oct 07, 2025 at 02:46:46PM -0400, Liam R. Howlett wrote:
> * Peter Xu <peterx@redhat.com> [251007 12:47]:
> 
> ...
> 
> > > > 
> > > > This way is_vm_hugetlb_page() never really needs to be used because the
> > > > function pointer already makes that distinction.
> > > > 
> > > > Right now, we have checks for hugetlb through other functions that "pass
> > > > off to appropriate routine", and we end up translating the
> > > > ioctl_supports into the function call eventually, anyways.
> > > 
> > > Right, it would be great to get rid of that. I recall I asked for such a
> > > cleanup in RFC (or was it v1).
> > 
> > I didn't send RFC, likely you meant this reply in v1?
> > 
> > https://lore.kernel.org/all/0126fa5f-b5aa-4a17-80d6-d428105e45c7@redhat.com/
> > 
> >         I agree that another special-purpose file (like implemented by
> >         guest_memfd) would need that. But if we could get rid of
> >         "hugetlb"/"shmem" special-casing in userfaultfd, it would be a
> >         rasonable independent cleanup.
> > 
> > Get rid of hugetlbfs is still not my goal as of in this series.
> 
> My example picked hugetlbfs because it is the most special of the types
> of memory we have (so very special).  If the interface works for
> hugetlbfs, then the rest will use a subset of the features and be happy.
> 
> IOW, doing the hard thing first makes what follows easy.  Doing the easy
> thing first may mean rewriting the easy thing once you arrive at the
> more difficult part.

In general I agree, but hugetlbfs is special when it is major-feature
frozen.  IMHO we shouldn't design an API to suite hugetlbfs, but only
trying to move it closer to all the rest of file systems as much as
possible.

So the generic API should be designed without hugetlbfs involvement.  Then
if there is guest-memfd / hugetlbfsv2 / ... they should fit into this API.

> 
> > 
> > OTOH, I generalized shmem and removed shmem.h header from userfaultfd, but
> > that was prior versions when with uffd_copy() and it was rejected.
> > 
> > What should I do now to move this series forward?  Could anyone provide a
> > solid answer?
> 
> My understanding is that we need an interface for memory types so they
> are modularised, with the short term goal of solving the faulting
> support for guest_memfd and the long term goal of code cleanup, or at
> least don't make things worse.
> 
> I think we all agree on that?
> 
> I propose that we need to add the minimum amount of uffd_ops to support
> guest_memfd's specialness without creating an interface that makes
> things worse.
> 
> It is very difficult to see a reason to pass in two variables (modes and
> ioctls) to dispatch to the correct function in a struct that could

The reason is "modes" cannot directly be intepreted into ioctls.  But
indeed ioctls can be intepreted into supported modes.

> simply point to the function in the first place.  If we can avoid that,
> then it would be good.
> 
> Looking at the example you pointed to here [1], It appears the minimal
> viable product would need to implement this:
> 
> uffd_ops = {
>         .get_folio = <>,
>         .minor_fault = <>,
>         .atomic_fill_continue = <>,

These three are fundamentally the same thing.  As explained, if we have
get_folio() we don't need the rest.  However we still need something to
describe e.g. shmem supports MISSING mode.

> }
> 
> Then shmem and hugetlb can define these and end up calling them in
> today's spaghetti, but we are free to append more uffd_ops to reduce the
> spaghetti later.
> 
> If using new #defines to clears up translations of features/modes and
> ioctl codes, then please do that.  These should be removable once the
> uffd_ops grows to support all necessary calls.
> 
> If there are places where you need to consult the modes/ioctls and a
> translation does not work, then you could add something to uffd_ops that
> is NULL for guest_memfd and use it to determine if the code path is
> valid.  But this code should already exist for the other memory types.
> 
> What does everyone think?
> 
> [1]. https://lore.kernel.org/all/114133f5-0282-463d-9d65-3143aa658806@amazon.com/

Would it look better to you if I drop uffd_modes_supported, deducing it
from uffd_ioctls_supported?

I believe that's what David mentioned very initially here:

https://lore.kernel.org/r/f1da3505-f17f-4829-80c1-696b1d99057d@redhat.com

I'd rather go with the two fields, but if we're trying to introduce another
feature sets almost only for vm_uffd_ops, I'd prefer keeping it simple, and
deduce the modes from ioctls.

Is that ok for you?  So it'll have (1) get_folio(), (2) supported_ioctls.
That's all.

Thanks,

-- 
Peter Xu


