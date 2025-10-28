Return-Path: <linux-kernel+bounces-874366-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 94D2AC16262
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 18:29:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C9C5D4FD7DE
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 17:26:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 886E434B408;
	Tue, 28 Oct 2025 17:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="m/62cDGV"
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 968B8346A19
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 17:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761672372; cv=none; b=TmoXPnwJliotj3G4xZTC8E0BiFZiRWuS+jVAzt3jrnDkxWMpfJGmqPLidzDlETBOGULIN8K+BiOPfC83HXk2vrwCV+2jrA10rbqMshtQssAcY+hP2P0m724mWP++XAgPT8KkirCWryx0Bxhsj+0lTT5iSG59UEtbeg2/ifs32Vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761672372; c=relaxed/simple;
	bh=hUoc2EMWGfVpMCL29y/hoRq4GG7g4bFbyAf6f2DnhR8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IB3zZJFEHgK8CRpIxuSoODMsVBXLiHlAyi80pqgHlwz6r2qKPe1CrVbQf1gzAEclS7BTtQNpYRDJ3u71D74ZcHlT4CySvPAqsGms9esk7KGz1tSJdCS4eBHeddTfNqBcfu3xv4NewWG3VrX1QE1vdb4qVD75Wp1E2Z0wCS3Ug+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=m/62cDGV; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4ea12242d2eso19211cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 10:26:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761672369; x=1762277169; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JfkiUG6+iw2UhSy31dGJmvgvAekk/kMSwRwnJkf7r0s=;
        b=m/62cDGVMmSwzyjY1OhS85CFMa2yHyq0uly7u1sr7duEMdQb5g4nWi0pjo6Izt9bWK
         kzCAmn1rACOjbGJV3vNBHLIv/vCzXwgkZzqok/qAjpLnpmZHNDygAlD1wojCeb/9XM/g
         gWEHGCwXIgnLBjHkZYWTxyxi7l4f/pR9jt6iDB2nJCzehtJK/9cyitAbtQOGt4SosDKP
         Vbv2jC3F1KWbxFAAt0yCB7uYAoiEZapdavGGHbDsLT9hJj+fiWV2gd+lOkfxq5ERtFjI
         K2ihjDPhNC6+EFi34soqG6tRHg+cthkVtS8GcQ347cjH/Kzsk9PnxITvHAb699VOixIr
         MOoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761672369; x=1762277169;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JfkiUG6+iw2UhSy31dGJmvgvAekk/kMSwRwnJkf7r0s=;
        b=X6+t0IxO4p+ZYy9XrCW/DzFDG3lunyI5jwQKlik2V+jto5BZHH/357ciDFyjtwGlRz
         MziJrl3uHucyTmb0CQAR7/S7fbYGQHhg4E1DzqIW8xbCH/afMmlzsf2Hqm4EOgHHec3U
         G54RnfxtkV99jHY5WyJ3kxx0aKFUkpq/5Sd1zKNAdkl6v/Ns9pL2b8ImYFpN+EMmdoG9
         LuAhS85L8dLSX/SUt9xf004iilbifIVJpVPyYrFUmjHQmFG0UPwPB8aXKBgfDXZ+k8FZ
         9R5trlEtbpP9/9Ys09gRYS7x7tBTeDAT2eGTM8X9xZG/nWAOuqCUK2ITAKF01NsL2VJq
         uWyg==
X-Forwarded-Encrypted: i=1; AJvYcCVwtbYy7MEhHxN1hlgF5m1ipuNj39HgqytQsfguq4Z559T7mxhm2S0kt+U0oy9rIrs41/tiXYx+ocggFw4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/8QrQOyzhn4BN7CZ6aCNqG86/wBxSeH12o8pg4Enrp9aoDhIT
	kgXiOxdPT7c01vwwHOe4AHNEdnUUT4WYgedWDSUY4u5P21tuCh3gGKrX5rrRENqU2xV0ecSWrSs
	+H39fYhHaRhn1d9oGq8oaUyuEGvEmJvHxf9C+mkcU
X-Gm-Gg: ASbGncuwTt3Z0Cff67zq/WLvIqbb5FMNV0amdC1s17dOgAwxgZ2BQr/nRaHoVdOEC89
	buMdei3WAzZrk35uyf64F8lkBeV8wxuLREbUMdej0IpjMzNjpwjOYAuguhNKRsUF6rfsGIQDrkw
	Z02snHXR3eGdbbZhJcxPTakxgAnQ/+Ep1/wf0gzFvedrXH3uOpjgRBOqrdP8GhWP+OHEa0m+AEM
	TctAFy9GdhIQ2U7sfEYESZjw8wl4khukWcZxY/N/FbCfirlsw29BNlLn1dsBFaNJiulZlefleP6
	t52B57fCnZl7TLpxxCsnMXDddQ==
X-Google-Smtp-Source: AGHT+IHzoBJIe4jVodZbEvla5R7rampjy3ci2pHKZPMRnGU0o5gKAx9pVCoQf6YY6ezuy6hJhcna9HUVRGij/ntiFOc=
X-Received: by 2002:a05:622a:110c:b0:4e6:eaea:af3f with SMTP id
 d75a77b69052e-4ed1593dc59mr156611cf.3.1761672368890; Tue, 28 Oct 2025
 10:26:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251027122847.320924-1-harry.yoo@oracle.com> <20251027122847.320924-3-harry.yoo@oracle.com>
 <CAJuCfpGo=m9vdRQCqa-2MtAb9GBNsF4+6YXm7vzGFYtqsOzq1A@mail.gmail.com>
In-Reply-To: <CAJuCfpGo=m9vdRQCqa-2MtAb9GBNsF4+6YXm7vzGFYtqsOzq1A@mail.gmail.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Tue, 28 Oct 2025 10:25:57 -0700
X-Gm-Features: AWmQ_bmKilFBM39l_iVIomcjoYMaO1avK7j0mImfETowwXOoO4uxKbRGQDyfLKQ
Message-ID: <CAJuCfpHKWx2HO0cdrynxNe+PYBFnqZ91vDiezrewk=LnKBReMg@mail.gmail.com>
Subject: Re: [RFC PATCH V3 2/7] ext4: specify the free pointer offset for ext4_inode_cache
To: Harry Yoo <harry.yoo@oracle.com>
Cc: akpm@linux-foundation.org, vbabka@suse.cz, andreyknvl@gmail.com, 
	cl@linux.com, dvyukov@google.com, glider@google.com, hannes@cmpxchg.org, 
	linux-mm@kvack.org, mhocko@kernel.org, muchun.song@linux.dev, 
	rientjes@google.com, roman.gushchin@linux.dev, ryabinin.a.a@gmail.com, 
	shakeel.butt@linux.dev, vincenzo.frascino@arm.com, yeoreum.yun@arm.com, 
	tytso@mit.edu, adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 28, 2025 at 10:22=E2=80=AFAM Suren Baghdasaryan <surenb@google.=
com> wrote:
>
> On Mon, Oct 27, 2025 at 5:29=E2=80=AFAM Harry Yoo <harry.yoo@oracle.com> =
wrote:
> >
> > Convert ext4_inode_cache to use the kmem_cache_args interface and
> > specify a free pointer offset.
> >
> > Since ext4_inode_cache uses a constructor, the free pointer would be
> > placed after the object to overwriting fields used by the constructor.
> > However, some fields such as ->i_flags are not used by the constructor
> > and can safely be repurposed for the free pointer.
> >
> > Specify the free pointer offset at i_flags to reduce the object size.
> >
> > Signed-off-by: Harry Yoo <harry.yoo@oracle.com>
> > ---
> >  fs/ext4/super.c | 20 ++++++++++++++------
> >  1 file changed, 14 insertions(+), 6 deletions(-)
> >
> > diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> > index 699c15db28a8..2860e0ee913f 100644
> > --- a/fs/ext4/super.c
> > +++ b/fs/ext4/super.c
> > @@ -1474,12 +1474,20 @@ static void init_once(void *foo)
> >
> >  static int __init init_inodecache(void)
> >  {
> > -       ext4_inode_cachep =3D kmem_cache_create_usercopy("ext4_inode_ca=
che",
> > -                               sizeof(struct ext4_inode_info), 0,
> > -                               SLAB_RECLAIM_ACCOUNT | SLAB_ACCOUNT,
> > -                               offsetof(struct ext4_inode_info, i_data=
),
> > -                               sizeof_field(struct ext4_inode_info, i_=
data),
> > -                               init_once);
> > +       struct kmem_cache_args args =3D {
> > +               .align =3D 0,
> > +               .useroffset =3D offsetof(struct ext4_inode_info, i_data=
),
> > +               .usersize =3D sizeof_field(struct ext4_inode_info, i_da=
ta),
> > +               .use_freeptr_offset =3D true,
> > +               .freeptr_offset =3D offsetof(struct ext4_inode_info, i_=
flags),
>
> Hi Harry,
> AFAIK freeptr_offset can be used only with SLAB_TYPESAFE_BY_RCU caches
> (see https://elixir.bootlin.com/linux/v6.18-rc3/source/include/linux/slab=
.h#L302)
> and check at https://elixir.bootlin.com/linux/v6.18-rc3/source/mm/slab_co=
mmon.c#L234
> should fail otherwise. The cache you are changing does not seem to
> have this flag set.

Oh, sorry, your patches got reordered in my mailbox and I missed the
first one where you are removing this limitation. Let me review that
first. Sorry for the noise.

> Thanks,
> Suren.
>
> > +               .ctor =3D init_once,
> > +       };
> > +
> > +       ext4_inode_cachep =3D kmem_cache_create("ext4_inode_cache",
> > +                               sizeof(struct ext4_inode_info),
> > +                               &args,
> > +                               SLAB_RECLAIM_ACCOUNT | SLAB_ACCOUNT);
> > +
> >         if (ext4_inode_cachep =3D=3D NULL)
> >                 return -ENOMEM;
> >         return 0;
> > --
> > 2.43.0
> >

