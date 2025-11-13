Return-Path: <linux-kernel+bounces-898987-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 78BE8C56807
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 10:10:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id CE4BE351B36
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 09:02:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAD8E2D0C9D;
	Thu, 13 Nov 2025 09:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DxDlAlvT"
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A87E332EBE
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 09:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763024408; cv=none; b=oIOiEnr0PGGdWJ3TLrJRKlSlq6RjcEWCWYThdWdjWDu74fXWRuOw4/ujHwI6PDx95Shr389a1ry7S47oXF2fboE/YONGCIaKgn5zUJf7ieIb01z8ujvLGBNduUKf2PF8XiiW4eIAia1EQoSpFtwNwMhldkv9cC3oPvS3NTIyXRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763024408; c=relaxed/simple;
	bh=ouBWRSQkqObNPCYyOfa5KSkt6tU/5X4PXnRX+aE/p1o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NQ95tpFdOAVW5ucHtm8e1xoPWHuk5wlPP6GKXiJRRju9Z9f0B+iW+gltSDhTkFnoSB1lTXVD+o9Df5OnflfevOiWhVXeD6/vlhCVCboTzQIhAnzwykJa85xaBt72VIcd78v+qo2pK2/pbF4VYxak4okWIZIFNIt//JgModoM2wI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DxDlAlvT; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-3414de5b27eso498618a91.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 01:00:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763024407; x=1763629207; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GGwoPMrkSHa1iiDGS9d3Z3qrdDtwH2Dm6udTm98pGDY=;
        b=DxDlAlvTHURz6Wmu+jVbGrKxEPk2Gn8Ef8rz0uQJns1XDDJurxE0M7I7+jdGkLCy27
         xK29LaOmg2c7uV4G2BXlRO3Og1u3upz4txxFQIbv0kFaWCsrVsVND88LefR3Kabb8Mdt
         TsbMKf/S8FZNdofypyYnXVja/7TIJp5glBiZPOxd5aEIKVJvy82ilOtqZM9fb0QCiRUd
         0SEuE/iuSxnt131EnN0LcWbR4jaJKYdJYPH6RtR1igcQ5SSyFXnAxvT9YT3O7ZYXQLXx
         cy4L69zOVZTi9P6YPDOtVgEMro1r/ZPoDWZal4LuLEJoMXec0YCvANATW2KZgfNLzotH
         15Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763024407; x=1763629207;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GGwoPMrkSHa1iiDGS9d3Z3qrdDtwH2Dm6udTm98pGDY=;
        b=iydcSs8ZWOj3uILDEKOG2OCclFLeCBEs0Q/KHEonvOIS0x7ou9GQVAZHnQkYAyznYd
         ++3u9kJrSP8B8i9JGnmP9TP4121ivNclmZIKDS4WOtelTCTllOvO9G73DdlMSMyR07Ss
         GiP95GGsUsNq1EWFTiWSSch8yDnczgCXcAj64TXVXBAHWezUKV2hV4v+q5oBjcyll7qH
         RjxSgzGC1e4vaH5WzVPFMT5UbZxYw3dMG+4ftTxhkCgJgxpMBPcmUgSKhHHs3X3v/jfU
         HcXGmm82gcjobyw436BeyP4t2a9PmpCaLpY/gPFD5sWx+JD1X3DxPa25uLT6CKWgOyhp
         lNXw==
X-Forwarded-Encrypted: i=1; AJvYcCVYB96Xikh5mbITXJrIWoGuLeKnY2j6LnAd461aUp6bzbgaC7G1O9pOAjj0+KirMWE7bflezoN+ytaXlAs=@vger.kernel.org
X-Gm-Message-State: AOJu0YylB+uLDxWePbcM/1qXleZBEJ78GHIqeAtylXgtwfuAlBeR3aAC
	+CCQX6f9qKSdx2Ucq8crVGT1jeCYyl9gX+99coF0FXFCO59QSjwGO9Co4eTb1NcbdaBxnofbJi5
	AGLYQze3gWjX4XaIH6UJhSN6qwnzBEzQR40aMYuw=
X-Gm-Gg: ASbGncuLS9xfgyAgizzqW+YIDZeLsnGU1M+0UdL7v7iATaTBeTrWJqLMCg0FJe9q5w+
	ceD167IFyfHV4r76Tmh75bM6IWmFeaKFRIZXH8/EYKDO4mZOsFLlnUGKlsQQWcKvU+i1KM42/ZG
	01YmgNCgx2nA0D2XODJeX0ldDz0PuPw5YqZNN6Pq8mvDGFNg6pHFBWuT8Pnhu6vDs8oe4X25Qkd
	aeg4M0Gz1LpNm/N1OYr1vLnup3qiBJUl0YLxR02hcBpy+f6h2j82XhpesOgZLa6YoPTQfI=
X-Google-Smtp-Source: AGHT+IGxk+DFj5hkqlHUjnskpiFt5G+BO0vo5WjuDUr4EbXJ7o80USBJYinkz2q18L7EBZFU69LhyV3jhhUtABUc+/Y=
X-Received: by 2002:a17:90b:4c07:b0:32d:dc3e:5575 with SMTP id
 98e67ed59e1d1-343dddc6ee8mr6926079a91.5.1763024406530; Thu, 13 Nov 2025
 01:00:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251110033232.12538-1-kernellwp@gmail.com> <20251110033232.12538-4-kernellwp@gmail.com>
 <74b13a0d-9f49-4a5d-8554-3e68be7cca88@amd.com>
In-Reply-To: <74b13a0d-9f49-4a5d-8554-3e68be7cca88@amd.com>
From: Wanpeng Li <kernellwp@gmail.com>
Date: Thu, 13 Nov 2025 16:59:54 +0800
X-Gm-Features: AWmQ_bkunMDKYsz6rtaRmUcTIJHykx1x5b3IqwmZ_GNG-_xd3PnWKsUhxr9Q75U
Message-ID: <CANRm+Czn4evAS=vTnm8rLuRRgN8hNb5AVS-tvX43r4V=z-=C7g@mail.gmail.com>
Subject: Re: [PATCH 03/10] sched/fair: Add cgroup LCA finder for hierarchical yield
To: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Paolo Bonzini <pbonzini@redhat.com>, 
	Sean Christopherson <seanjc@google.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Juri Lelli <juri.lelli@redhat.com>, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	Wanpeng Li <wanpengli@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Prateek=EF=BC=8C

On Wed, 12 Nov 2025 at 14:50, K Prateek Nayak <kprateek.nayak@amd.com> wrot=
e:
>
> Hello Wanpeng,
>
> On 11/10/2025 9:02 AM, Wanpeng Li wrote:
> > +/*
> > + * Find the lowest common ancestor (LCA) in the cgroup hierarchy for E=
EVDF.
> > + * We walk up both entity hierarchies under rq->lock protection.
> > + * Task migration requires task_rq_lock, ensuring parent chains remain=
 stable.
> > + * We locate the first common cfs_rq where both entities coexist, repr=
esenting
> > + * the appropriate level for vruntime adjustments and EEVDF field upda=
tes
> > + * (deadline, vlag) to maintain scheduler consistency.
> > + */
> > +static bool __maybe_unused yield_deboost_find_lca(struct sched_entity =
*se_y, struct sched_entity *se_t,
> > +                                 struct sched_entity **se_y_lca_out,
> > +                                 struct sched_entity **se_t_lca_out,
> > +                                 struct cfs_rq **cfs_rq_common_out)
> > +{
> > +     struct sched_entity *se_y_lca, *se_t_lca;
> > +     struct cfs_rq *cfs_rq_common;
> > +
> > +#ifdef CONFIG_FAIR_GROUP_SCHED
> > +     se_t_lca =3D se_t;
> > +     se_y_lca =3D se_y;
> > +
> > +     while (se_t_lca && se_y_lca && se_t_lca->depth !=3D se_y_lca->dep=
th) {
> > +             if (se_t_lca->depth > se_y_lca->depth)
> > +                     se_t_lca =3D se_t_lca->parent;
> > +             else
> > +                     se_y_lca =3D se_y_lca->parent;
> > +     }
> > +
> > +     while (se_t_lca && se_y_lca) {
> > +             if (cfs_rq_of(se_t_lca) =3D=3D cfs_rq_of(se_y_lca)) {
> > +                     cfs_rq_common =3D cfs_rq_of(se_t_lca);
> > +                     goto found_lca;
> > +             }
> > +             se_t_lca =3D se_t_lca->parent;
> > +             se_y_lca =3D se_y_lca->parent;
> > +     }
> > +     return false;
> > +#else
> > +     if (cfs_rq_of(se_y) !=3D cfs_rq_of(se_t))
> > +             return false;
> > +     cfs_rq_common =3D cfs_rq_of(se_y);
> > +     se_y_lca =3D se_y;
> > +     se_t_lca =3D se_t;
> > +#endif
> > +
> > +found_lca:
> > +     if (!se_y_lca || !se_t_lca)
> > +             return false;
>
> Can that even happen? They should meet at the root cfs_rq.

You're right. Tasks on the same rq will always meet at root cfs_rq at
worst, so the !se_y_lca || !se_t_lca check is indeed redundant.

> Also all of this seems to be just find_matching_se() from
> fair.c. Can't we just reuse that?

Yes, it does exactly what we need. The existing code duplicates its
depth-alignment and parent-walking logic. I'll replace our custom
LCA-finding with a call to find_matching_se(&se_y_lca, &se_t_lca) ,
then use cfs_rq_of(se_y_lca) to get the common cfs_rq.

>
> > +
> > +     if (cfs_rq_common->nr_queued <=3D 1)
> > +             return false;
> > +
> > +     if (!se_y_lca->slice)
> > +             return false;
>
> Is that even possible?

No, it's not possible. The check was defensive but unnecessary. As you
noted in question above, entities on the same rq must meet at root
cfs_rq at the latest, and the while loop condition se_t_lca &&
se_y_lca already ensures both are non-NULL before the goto found_lca .
Will remove this check.

>
> > +
> > +     *se_y_lca_out =3D se_y_lca;
> > +     *se_t_lca_out =3D se_t_lca;
> > +     *cfs_rq_common_out =3D cfs_rq_common;
>
> Again, find_matching_se() does pretty much similar thing
> and you can just use cfs_rq_of(se) to get the common cfs_rq.

Agreed. :)

Regards,
Wanpeng

