Return-Path: <linux-kernel+bounces-783100-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C96E2B3295E
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 16:44:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3074C1BC399F
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 14:43:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EB3925F994;
	Sat, 23 Aug 2025 14:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lylh8f7W"
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42B642580EE
	for <linux-kernel@vger.kernel.org>; Sat, 23 Aug 2025 14:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755960027; cv=none; b=lHQdkI0wlq6R3TitJJ/sSFcYv3LAPTUzaN0x9MSdspZzCdxdkRSoe36ErV0FuKDww/ZAedTDrYHeX4BmpgPV4EZ4OcvuvDIA1JFBxQP+1GD9v3+9+hPXv4UGLyH4JOFf213GQrcZ27UX6qqvkldCyD6/+gjon3CRcmNKntR6oyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755960027; c=relaxed/simple;
	bh=QyueQOGvhuM9MTfsPL7HZ2OUki0vmuOXowQjZ0/HBSQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hqE3zq4LUm+mvt6OZfXfka5XxGy38dgfT+Ka7jPG5T3mfB7I7U1NaCfcE6LHsnMZJSMCiV0BLFAc65XPfAkG4pkw1EC8oGg3d/haxr4mJB3qqDHzxs1QfUGO2EUEcue9Hez+xSiaHhKrDnRhVsupyegXX9mxLpvva4ctZ1B9zZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lylh8f7W; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-323266d6f57so3206572a91.0
        for <linux-kernel@vger.kernel.org>; Sat, 23 Aug 2025 07:40:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755960025; x=1756564825; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=OXTmM8WbRUxy55QD29FRQw973UJ9zMubKoRh6IKSvDM=;
        b=Lylh8f7W3hd96M6tHC1WA8b2df0kBl30EVOeyUF5sO8QJKBsFQtbKdHzZIsWnYH4CH
         +Y9SzGLpJ86xAK3UAaTIjlA/Z+WtkkY7iPET82iRMSk4+WCj8vy99tX68AgkZ4xVEMjs
         x9NyhpogWKRz40iK9qSgUoJlNqwrNUm2oe6Nr9R3IWZO405wC4EPEuCyofry7gfPyfIS
         TQjHzWaHrNsFq3tJ1Vz2IvozZ1YOymMbJ+ioiWQwa6MJFr84JWybgSiiEZrrupA6jgUv
         iG08fRMUdyv+2QCQXi4NLbODhz8rtekNYiwDMBA36OKLyLfShP6NzKu0mhiQPd0BpjhA
         Vz9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755960025; x=1756564825;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OXTmM8WbRUxy55QD29FRQw973UJ9zMubKoRh6IKSvDM=;
        b=XSGG4XX5ab2dN/FEBHpO1Af+QXsboycyjNIXXZmup5D0+6mQ1tgS6MsX9R4FvBlboN
         r/qLkmuRuMmEgqtGGdfO9N2szaYHVOL1H124kMJ1INaLP9BqwlQUPoWVaGwLGK2YckoZ
         pzy1rk8c0Hc/Fwu/BN/ZrFFUlnQxAUNh3OmGj00nxOV8RgsRa7Ab0cg6du0hIBjfobp+
         EjGd2pMA3Xldgz0AgUaO2UECYRk4AQUci0+RKh3O8njPgYTgGaq6QuNxLOOaHQvy1wxo
         IgDgbK160KLRve4LKWUw190b/b8g5ezmTDZZR4STe5RHj1G8MMeoCNxISVtZ55+HVFFw
         Dl/g==
X-Forwarded-Encrypted: i=1; AJvYcCU192Tqnw2zYQFcJ01d2FNUDLQ+K8TvfvXTEVFpn9sa9T2D3mJ9dD3hyX4dP90342YN5//p5i+R761PUfw=@vger.kernel.org
X-Gm-Message-State: AOJu0YykLJyOKenRNPhHQYrQsLL3wQl/F6xLzKW7UtQNjOXvLT3Wrcy+
	C1/cT4Hwpy9rgzsnVDPNvyx2m39FcQBhkcrCEpL7cT7RwJNY5dqDeh4RL0n+gXWpFO2+y1GJEYK
	e4ywJm44RE2Z30cXZ8zo5WHEpBNBzCCE=
X-Gm-Gg: ASbGncviOvRvFXEUbW0a1zJVPU/yLe4uKkzO2VxpMGC1rGDpdEnxtZAgaoIBx0Y6kLb
	5Qqz1qcpmBfuuNeI8ByFbQziTYW6rOua1Aw0gC24Vnuwzib3eWlW6J93nTimFbS1shLH6D7Ddu3
	lIsNS1m2b5NdMH0iz/uqNPvRl76K0KqAU4gC724I/CJtIohF9WK/8+3NjHFo9SvgZFaSoyDh4mj
	wRlDJBiMw==
X-Google-Smtp-Source: AGHT+IGc/SHtlRux5/7a430WDOIBX1I2izxIcoeV52lF/P4sb+/2zBfwOo+crSqj7W7bw303LxUrH54S8elfD8oTOPY=
X-Received: by 2002:a17:902:e84d:b0:242:d0c9:f08a with SMTP id
 d9443c01a7336-2462ee54c5bmr85587745ad.20.1755960025422; Sat, 23 Aug 2025
 07:40:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250822180708.86e79941d7e47e3bb759b193@linux-foundation.org> <1757f780-0228-476c-a5a0-ed980209852d@gmail.com>
In-Reply-To: <1757f780-0228-476c-a5a0-ed980209852d@gmail.com>
From: Jeongjun Park <aha310510@gmail.com>
Date: Sat, 23 Aug 2025 23:40:13 +0900
X-Gm-Features: Ac12FXz2zs8kTDdt8Rbe1nTLMLdadJ6bdQycanM4Z2NyQ8xBX2zy3f6pxKsXVCg
Message-ID: <CAO9qdTECQWV6E-sor-5o8xp56knF5LpReszsG4WpFbDKTiyY1Q@mail.gmail.com>
Subject: Re: [PATCH] mm/hugetlb: add missing hugetlb_lock in __unmap_hugepage_range()
To: Giorgi Tchankvetadze <giorgitchankvetadze1997@gmail.com>
Cc: akpm@linux-foundation.org, david@redhat.com, leitao@debian.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, muchun.song@linux.dev, 
	osalvador@suse.de, syzbot+417aeb05fd190f3a6da9@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"

Hello Giorgi,

Giorgi Tchankvetadze <giorgitchankvetadze1997@gmail.com> wrote:
>
> +               /*
> +                * Check surplus_huge_pages without taking hugetlb_lock.
> +                * A race here is okay:
> +                *   - If surplus goes 0 -> nonzero, we skip restore.
> +                *   - If surplus goes nonzero -> 0, we also skip.
> +                * In both cases we just miss a restore, which is safe.
> +                */
> +               {
> +                       unsigned long surplus = READ_ONCE(h->surplus_huge_pages);
> +
> +                       if (!surplus &&
> +                           __vma_private_lock(vma) &&
> +                           folio_test_anon(folio) &&
> +                           READ_ONCE(h->surplus_huge_pages) == surplus) {
> +                               folio_set_hugetlb_restore_reserve(folio);
> +                               adjust_reservation = true;
> +                       }
> +               }
>
>                 spin_unlock(ptl);
>
>

Why do you think skipping restoration is safe?

As specified in the comments, if scheduled restoration of anonymous pages
isn't performed in a timely manner, the backup page can be stolen.

And If the original owner tries to fault in the stolen page, it causes a
page fault, resulting in a SIGBUS error.

Of course, this phenomenon is a rare occurrence due to a race condition,
but in workloads that frequently use hugetlb, surplus_huge_pages increases
and decreases frequently, and backup pages that are not restored in time
due to this race continue to accumulate, so this is not a race that can be
ignored.

>
>
> On 8/23/2025 5:07 AM, Andrew Morton wrote:
> > On Fri, 22 Aug 2025 14:58:57 +0900 Jeongjun Park <aha310510@gmail.com> wrote:
> >
> >> When restoring a reservation for an anonymous page, we need to check to > freeing a surplus. However, __unmap_hugepage_range() causes data
> > race > because it reads h->surplus_huge_pages without the protection of
> >  > hugetlb_lock. > > Therefore, we need to add missing hugetlb_lock. >
> >  > ... > > --- a/mm/hugetlb.c > +++ b/mm/hugetlb.c > @@ -5951,6 +5951,8
> > @@ void __unmap_hugepage_range(struct mmu_gather *tlb, struct
> > vm_area_struct *vma, > * If there we are freeing a surplus, do not set
> > the restore > * reservation bit. > */ > + spin_lock_irq(&hugetlb_lock);
> >  > + > if (!h->surplus_huge_pages && __vma_private_lock(vma) && >
> > folio_test_anon(folio)) { > folio_set_hugetlb_restore_reserve(folio); >
> > @@ -5958,6 +5960,7 @@ void __unmap_hugepage_range(struct mmu_gather
> > *tlb, struct vm_area_struct *vma, > adjust_reservation = true; > } > > +
> > spin_unlock_irq(&hugetlb_lock); > spin_unlock(ptl); >
> > Does hugetlb_lock nest inside page_table_lock?
> >
> > It's a bit sad to be taking a global lock just to defend against some
> > alleged data race which probably never happens.  Doing it once per
> > hugepage probably won't matter but still, is there something more
> > proportionate that we can do here?
> >
>
>

Regards,
Jeongjun Park

