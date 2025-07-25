Return-Path: <linux-kernel+bounces-746209-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 28D87B12435
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 20:41:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 840EC1892CE5
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 18:41:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FB0524FBFF;
	Fri, 25 Jul 2025 18:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="H5c/o9Ke"
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3138C248F4F
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 18:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753468890; cv=none; b=OA+KpP05jGBJOCWfkv3aRuapofU+jSa5ZPhL1wV053Dn6JUmTNsYTzl74gh+AbQdHkTLppd9iCr2SdVcijiYtETOo3AmKlTRWu2Ekh16JEdM9PbgHCxIgr1rjnRhKMzeAbGqAUnhv+v6XY7JfKFopxL1cUzb2QSXTDqR4XXuQGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753468890; c=relaxed/simple;
	bh=BRTNiKl6IlSe0CohaBcJ1cajXOvS2gPI0ttmISg+tPs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=izKGmwSr/l5ZD8S2ZqVaEXOE3oRRB/H8+KOxsq0kaB99DzLX3a5Bl+vP5G787tbDPwx/Nm3/cPeBfm5VgbBpRrMJmwvFbvwcguPRXUIYFUShzG9crJSoRgLhlAgMKitVPdgW9ixMFwoC5fhfP5RkBWeUMkPTKIjHqYNTm7BaVzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=H5c/o9Ke; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-72c02e22d96so150219a34.2
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 11:41:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1753468888; x=1754073688; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V2Rpb7FR3nTf+1NUVClXeCPQAamkonhV1DyVh3/yazQ=;
        b=H5c/o9KeXx4dVWrR64YFx5+VY44P69SmV/mb1SrHL18ycxs8zudXJPHGRc6CxiSZz6
         ia2cIdQCCZ3o/8O+DQ40Q56z0dU2ITbnshR9DRB3fm04L7wXl9Zlyz9oOhGqCzUy3Y88
         oBtlhciW9Rah7jobrrY5qZoRu3B6xUW1j9Ovg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753468888; x=1754073688;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V2Rpb7FR3nTf+1NUVClXeCPQAamkonhV1DyVh3/yazQ=;
        b=odGI5it11EaeB9PpWMjFYUdPV/G20CEgroiiSQ5oTPDN1iJzb3z4s9cUeEsosgTw0a
         HuE7pyHCjA37qnbtzBT5H/tzxrxYY84pKgmCOHbVjYDD1KHUKnzFyYC7/flaxROIxq/O
         p0x5N9YoMXqjmtGFDyEP3uDBuRENhcN3/rD4mpWDeKRkEJukmC7kGVJ4P8AFHnZ2BycE
         jxCqQHWG9gLwA7Yxa9zrTOM4oXFzDRgJdvpwKxPudAhhy9cNwuRt/3Z9MER2Rt7ddGnG
         Yeu6Ki1iZBdd0ev5CdGjYmrQhBsw7B7XvpfTYTkXhs4K5U/g1zcmBEFrqD8Dz2eiLj1e
         /3vw==
X-Forwarded-Encrypted: i=1; AJvYcCUcxEGnOi7kg4VshTjWrfchQqtpCJzv/1wERyV6uGZt/WbfTyPpOb7eSgWxBrmW+iTpCPbJE4ftOfo+yNs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBZbKUcioXlXQrYtLACLCKtGNomj2rI2VTcEm6jAhn+kG5T5CM
	1D8oUoZd+6hRPXol1h4I4NtdGzgEEd3wunTI1FOMJKABZIU2hanjIDDonBWa+UPvoCjcl4aJICY
	RInuXyWlaGIY+fghPsj228G+i0lVliU6CwnelPZeb
X-Gm-Gg: ASbGncs5bv/QLH5eyc3LiAIghteDC8bJ63fCok09DiylgTagn9WqKsaUO7sIipyhjMR
	R2+uZmAD17IYCqeC7aRaESfCtCr6jIdcH/kgfNvrH21kGmjBxyaYhoVpUiBuW9QIPOj6bGT1xbi
	zXWCkEqE1SuF5cznwgr7pHaJi5+kojAeTsz4PMU9kfaZxw9rsEKzjkBrIGXaH2rGq6r5pj3hNku
	N+MXZ6u86kgvs+FN7+cec6NNHJpjV714yYNuA==
X-Google-Smtp-Source: AGHT+IEFU8NJPmbYkF/oI9KZMdUcX0Ny+72Vd74Lmwe1/0YjVojIvVz6a6+Qnd8NCCAE48yauMCrRlYLd1qXP5jE+Xw=
X-Received: by 2002:a05:6871:286:b0:2c1:5011:56e2 with SMTP id
 586e51a60fabf-3070189dd2bmr789116fac.3.1753468888290; Fri, 25 Jul 2025
 11:41:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1753431105.git.lorenzo.stoakes@oracle.com>
 <492a98d9189646e92c8f23f4cce41ed323fe01df.1753431105.git.lorenzo.stoakes@oracle.com>
 <CABi2SkVSjRV_zz0mhuRF3t3UJM_x=+gct1jbV=qd7eNMPBbvkQ@mail.gmail.com> <a1691645-18ce-4e7f-846a-a5b498df948d@lucifer.local>
In-Reply-To: <a1691645-18ce-4e7f-846a-a5b498df948d@lucifer.local>
From: Jeff Xu <jeffxu@chromium.org>
Date: Fri, 25 Jul 2025 11:41:15 -0700
X-Gm-Features: Ac12FXzzRYItdebvqb0dwqotR9zarn6x23i_7sZkKKOiMnKZOphccisVFs5oxdI
Message-ID: <CABi2SkVuS21VgXXB80bs20=fg6+Bqm_LfQjknZhqRMGYYv7-BA@mail.gmail.com>
Subject: Re: [PATCH v4 2/5] mm/mseal: update madvise() logic
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, "Liam R . Howlett" <Liam.Howlett@oracle.com>, 
	David Hildenbrand <david@redhat.com>, Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>, 
	Pedro Falcato <pfalcato@suse.de>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Kees Cook <kees@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Lorenzo,


On Fri, Jul 25, 2025 at 10:54=E2=80=AFAM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
>
> On Fri, Jul 25, 2025 at 10:28:57AM -0700, Jeff Xu wrote:
>
> > > -static bool is_ro_anon(struct vm_area_struct *vma)
> > > -{
> > > -       /* check anonymous mapping. */
> > > -       if (vma->vm_file || vma->vm_flags & VM_SHARED)
> > > -               return false;
> >
> > In this patch, the check for anonymous mapping are replaced with:
> >
> >  if (!vma_is_anonymous(vma))
> >       return true;
> >
> > vma_is_anonymous()  is implemented as following:
> > static inline bool vma_is_anonymous(struct vm_area_struct *vma)
> > {
> >    return !vma->vm_ops;
> > }
> >
> > I'm curious to know if those two checks have the exact same scope.
> >
> > The original intention is only file-backed mapping can allow
> > destructive madvise while sealed. I want to make sure that we don't
> > accidentally increase the scope.
> >
> > Thanks and regards,
> > -Jeff
>
> Thanks, that's a good question.
>
> So for a function to be mmap()'d and file-backed, vm_ops _must_ be
> supplied.
>
This says that all file-backed mappings must have vm_ops set, but what
about the reverse? Are mappings with vm_ops always file-backed?

> You can see this in the fault-handler:
>
> do_pte_mising()
> -> do_fault()
> if anon -> fault anon otherwise fault file-backed
>
> So if this were not the case, you'd have file-backed mappings going into
> the the anonymous fault handler logic.
>
> This covers off MAP_PRIVATE mappings of file-backed mappings too, as this
> is handled in do_fault() by:
>
>         } else if (!(vmf->flags & FAULT_FLAG_WRITE))
>                 ret =3D do_read_fault(vmf);
>         else if (!(vma->vm_flags & VM_SHARED))
>                 ret =3D do_cow_fault(vmf);
>
> That does the CoW fault handling.
>
> So the vma_is_anonymous_check() here should have the same semantics.
>
Just to be extra careful, does the reverse hold true as well?

In anycase, if you are confident about this, please do state this
change in the commit description that vma->vm_file and VM_SHARED flag
check is replaced by vma_is_anonymous_check(), which is expected to be
a non-functional change.

Thanks and regards,
-Jeff

> Cheers, Lorenzo

