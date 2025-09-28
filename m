Return-Path: <linux-kernel+bounces-835160-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 73E19BA669F
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 04:59:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 20D7017D3C8
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 02:59:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85B632494F8;
	Sun, 28 Sep 2025 02:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HK2vPX3Q"
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62D8734BA24
	for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 02:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759028369; cv=none; b=t6+z1OHyOVFoM99S3Qlcz7kG34e27pL+UWBQxV1P3yaqiT6UD3qKIYiiroM+liZc/EDDINW2eufwFFphvX7nhQWxnXD3soeZ4/Xw299+XQyBG5KNhYVO7x7gnypYMfX6PYgGBwIrYai1iSDJ2nE/e7vIzfb6SdM56rC2mfNoIhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759028369; c=relaxed/simple;
	bh=ZxzPhH8msAHrLGbslPHCpiVKvLZwqZuC0UrHyj7DJI4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qsbwnEUHzZR5oDnXJaiwHpN98SmDYF7AG9jkuzVrA9vK/hFrg7QUdOZvSGl7lwkFLZM6+ySly++YU+nMXKMT2qki86n5hfomT9aPUwzHb8o/A8dOGPUdQVQYKfyEYZUnRkpAeLC51asE1WslcFqLx7KXfmv7WC1kivFnnpkCrvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HK2vPX3Q; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-79390b83c7dso26367556d6.1
        for <linux-kernel@vger.kernel.org>; Sat, 27 Sep 2025 19:59:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759028367; x=1759633167; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RbYlG8kir9C4NWsQtGw4HVo4aLYIvyfCcEM9DUL4BGE=;
        b=HK2vPX3Qv0m6wIIAZHw8I/Ya56qgewHWk9hhhzhNoT1eVRMHLIKQS4Z3Oy1dw5RDGT
         FhrBouWzMpVGzyQOjwJcVu1qIoVMdmW3BCISsJLRQJRbAMe2d8s8VoEcg3zWpFHtp1xP
         dVknVMWKquZUunjQPoGNYyCu9++CTlqLl/VxMxl8/Ogsx/NgYYjPZLWu5KiRt2ExMRPz
         juxZNceWA36XE3DqyY/r7WFwJg2vgODFhtMXiVROnxMzvynXiD9T3yqgeR/lg9FFOlEp
         3LY7+fTUNZ6kZ0SI7D6c2ceNYAo/YFWFMYOgW+AMs5avXp7gGz28couaTFmLRDLBivt8
         5Z4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759028367; x=1759633167;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RbYlG8kir9C4NWsQtGw4HVo4aLYIvyfCcEM9DUL4BGE=;
        b=XL7j2MIRYBRIcZHxTZ4FqHXtxvSecxRDxgasvqnxgs/lkbj3yO0HacPuz9OibNGl/u
         73jOP5L4O9NGH/1NmgbgDOTLEFdEvQbNoDGrf+KLc2xJKPQEZhk6EScohTNrdMPdqv0F
         PE/1kQnEcwExqntw+b98U13x8oKkkIX1UxgcreF9N3o2D+OSJR5Nqz2HwURqJHJ93bzi
         /BzFL/j63WvSZuDmTcZhtjRgVrm95aegwEIh/j0m8Kz7nUyh12aH3A/DX0OU7hf9iQl5
         fyk4+J4XLWE//AV4JMZ8Eg3QDIJeEdseUHpHIzvuaLRgz8PR6ZYK8JjSlkGKSAXkZTuS
         vMAA==
X-Forwarded-Encrypted: i=1; AJvYcCW1qAXnYHi3zMR3WFwv4hamiIQKKOmwbOVDTs/FUOQ43TcVE+E4QaHu2X1NWx+q/2E88ItWmkFB2KJCj/A=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywy3W/4ECHPSLmf1OfiuoTOVf+kgz4iBwHr0F5eiOjMyPOFV5nz
	WgOhC6TppSqW6TGUi1KKGex/tAViZHsb89IPBkqvCmue3SgvqtGiMmTnZjb5LvpfSt8ACK7XuMW
	TalHqZXPicT+j5Xe9m1ygmXjId3QFmgM=
X-Gm-Gg: ASbGncs701TRoh7AWb+TNmpvNOGljF+46f2YMSlaRw11wQtj59Q3DIDtFwCmOqlUUm6
	5rNv9fJ0ImIZsWjJS5Z7gP6A4qLReox412XE0G78M5Dol3A6gW726xkqBj6D5Q9ld7LZQfE4IMX
	nKRIGAtuD5Xil4CmPwBlQw4d0ecc5rfsV420O+nrRt4X+6mDaMbFz6TWHuX8221XEMi0ISmEB+L
	IokdiejxCnZfw6F26EVv35Tf7wHVleOOZ6080rw
X-Google-Smtp-Source: AGHT+IFdRnFXl3N8Jp4Haml4M1RRKvlW3m2kzWVSMSBoU9EF1uuyEHWcCvydfgCbA9/kyPP0cUmHnjEU6SbmvUelvBA=
X-Received: by 2002:a05:6214:4001:b0:70d:6de2:50c0 with SMTP id
 6a1803df08f44-7fc43a4e9e0mr153355586d6.61.1759028367220; Sat, 27 Sep 2025
 19:59:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250926093343.1000-1-laoar.shao@gmail.com> <20250926093343.1000-7-laoar.shao@gmail.com>
 <035a8839-c786-45b6-8458-87ac1c48f3bc@gmail.com>
In-Reply-To: <035a8839-c786-45b6-8458-87ac1c48f3bc@gmail.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Sun, 28 Sep 2025 10:58:51 +0800
X-Gm-Features: AS18NWAAfWsnD0j5sPrJc3hEg82Xq_xZbRib5fRTmJ2-Yy1bnBsvdtfvitUBea8
Message-ID: <CALOAHbApB53XJBvkomsbRcvAFr8rzUajjB1vJDL92b+9cYgHgw@mail.gmail.com>
Subject: Re: [PATCH v8 mm-new 06/12] mm: thp: enable THP allocation
 exclusively through khugepaged
To: Usama Arif <usamaarif642@gmail.com>
Cc: akpm@linux-foundation.org, david@redhat.com, ziy@nvidia.com, 
	baolin.wang@linux.alibaba.com, lorenzo.stoakes@oracle.com, 
	Liam.Howlett@oracle.com, npache@redhat.com, ryan.roberts@arm.com, 
	dev.jain@arm.com, hannes@cmpxchg.org, gutierrez.asier@huawei-partners.com, 
	willy@infradead.org, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	ameryhung@gmail.com, rientjes@google.com, corbet@lwn.net, 21cnbao@gmail.com, 
	shakeel.butt@linux.dev, tj@kernel.org, lance.yang@linux.dev, 
	bpf@vger.kernel.org, linux-mm@kvack.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 26, 2025 at 11:27=E2=80=AFPM Usama Arif <usamaarif642@gmail.com=
> wrote:
>
>
>
> On 26/09/2025 10:33, Yafang Shao wrote:
> > khugepaged_enter_vma() ultimately invokes any attached BPF function wit=
h
> > the TVA_KHUGEPAGED flag set when determining whether or not to enable
> > khugepaged THP for a freshly faulted in VMA.
> >
> > Currently, on fault, we invoke this in do_huge_pmd_anonymous_page(), as
> > invoked by create_huge_pmd() and only when we have already checked to
> > see if an allowable TVA_PAGEFAULT order is specified.
> >
> > Since we might want to disallow THP on fault-in but allow it via
> > khugepaged, we move things around so we always attempt to enter
> > khugepaged upon fault.
> >
> > This change is safe because:
> > - the checks for thp_vma_allowable_order(TVA_KHUGEPAGED) and
> >   thp_vma_allowable_order(TVA_PAGEFAULT) are functionally equivalent
>
> hmm I dont think this is the case. __thp_vma_allowable_orders
> deals with TVA_PAGEFAULT (in_pf) differently from TVA_KHUGEPAGED.

Since this change only applies when vma_is_anonymous(vma) is true, we
can safely focus the logic in __thp_vma_allowable_orders() on
anonymous VMAs. For such VMAs, the TVA_KHUGEPAGED check is strictly
more restrictive than the TVA_PAGEFAULT check. Specifically:

- If __thp_vma_allowable_orders(TVA_PAGEFAULT) returns 0 (disallowed),
then __thp_vma_allowable_orders(TVA_KHUGEPAGED) will also return 0.
- Even if the page fault check returns a set of orders, the khugepaged
check may still return 0.

Thus, this change is safe. I'll clarify this in the commit log. Please
correct me if I'm missing something.

--=20
Regards
Yafang

