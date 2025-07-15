Return-Path: <linux-kernel+bounces-732495-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C979B067A5
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 22:18:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44B014E45E3
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 20:18:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 001762BE7D9;
	Tue, 15 Jul 2025 20:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LJ43VV1Z"
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1749246769
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 20:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752610698; cv=none; b=fqpSOSCLc4R0/Q+X1gmYPGXd5JdrjsSCqSDg5lYlNX6logCnDpzW39jJOgDLrhLyoRbcCQcebsivylD8hAhlL8nmHQ0YtYSuF3qU4iSe/u80qdTwNbFEbj/UgINlzj//6Hoiu6NFQvY0e4+9wKxb9OoIGxAFWSXIk+0/uDYjB48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752610698; c=relaxed/simple;
	bh=s2ktJkEJEUaWsaEALaqTUWvGoIB35UIRafKufaYtazA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZqobChL7l0oxHoTxrOiAffNPuZgCGofqDHNTNP1N31YfkrSrh7F3bE8ngIXl2Kkf0pCbxDyLu7EZLagdlM2iIXksg5kzO6P2NKHTYIlfByP3KBxDoCaucSmwvkz/UwcfxAm4Ilpn3fZGYCUr7lqxHATk7kdqwCNUOjadI1mQR64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LJ43VV1Z; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4ab3ad4c61fso120361cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 13:18:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752610695; x=1753215495; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4h3Ep2VWmJ725V4zeell0WprNHA0l7LEqrQxhnNjHu8=;
        b=LJ43VV1ZbLSsj9qfS+Z55jlpJVka01rmFc5XV6UDJf3dSt2ssVeJAEHfQdbL9P8mea
         dGEvfDQpnIXBcXYGjPWFHxp6a2RHn+wMMKz3VnYhYNlT/pZPEj17ANmbfbSowCKlqR6w
         ihxD5EhiW3xnQj3gLtjiqsSu+Ca++hiMjyGZCKPF6XvKJiklpGEvUaObAuaJVrrCl1zS
         gBMaGmZtbdXxH6MI5BoGEKBvzM4gCOMf8JL55P0jYMt/RXpI8JPLdhnGXO7JZ693B3oG
         2reQinwZ4FTqZiY9aaImo6nW+/cN2lDnuCAUysxSmRRVnNBezIJsyiWL1r7se2sMcXWA
         CNNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752610695; x=1753215495;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4h3Ep2VWmJ725V4zeell0WprNHA0l7LEqrQxhnNjHu8=;
        b=U2NImoKEnwmfNtVSn7AfuI8mESdTV0qaG4CV9m+s6XBFBkc3Wv8i2FNnSSlWWv7ZdS
         3qSIstnXgDKtk6Rl993gcsaTUL6JqkD1cBbCvv3vf3hDIPDJMiGxTVtMc4G2ps9nU58V
         iDqDq5VMU+FydOUl6y8kug8p+lTWaWKczYBM+DaJRELfGzSinZ/9jyiGuOesPI/63MLD
         oIJJtOw0U1SjiShxctHIWUpYIIM+0jek5MNmUgeZiblkhDvIVI/lxxs9qpW5HQdZmGDY
         BrTFOIZGqPJHn08GufT8RhQvJvIhJ56XNZezL4z5ZIIZIDalVeHnEeyi7x5tIE0cbD5c
         znVA==
X-Forwarded-Encrypted: i=1; AJvYcCVPp6cigvxizRO8gbyQkdRJoLxuxxE1fV5jFUZN4niXSUl1cm6thZFBeZwNPm8b/pocSPlKgxotRp+SYvI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8ipkweZRu+lQvnTSeJeBc5kt4ljtmbBg72neyE0H/tyKWQckR
	gDeHOvTdj9oLsJG3+70Yqdc3r8B4GwkaNBbGt6UrKN6NndBtKPHVtOdWUBryDMrQ0tCE5jjCVGV
	C1kqR0yWESbTr9b+2lviD5aMXt4KYdyn21YLEt+QQ
X-Gm-Gg: ASbGncssSHfiOeQ8vW+ArhJwULmzYwld6IF0p18IHicLkz8EdHkthUi0SK6Bgrril7S
	ZvrApaVk5NbP/OUuqTENrlj7CDuh69xcqR4jgu7U7qRBrsITbvfyJvLdXCBln04Yc4JNE9BBl5B
	HvyZXlREyMtBDah8+gO0F7qKR1k/Sm4mhu+JxNFYC6FDt6fIli6jWJt4DAgZL37XidpbsOZinfh
	q9TXrd35bvpT27JFptdrVbx3mGN+ry4+xkVYe778aQwMSs=
X-Google-Smtp-Source: AGHT+IGH4M4H5yhWaOUW04EMOoMVNaNdnS8aTx/in7/xD6LRAKlI7amTM7yUE22F+ar6ZwOBueaAeL5WAceT+XowSog=
X-Received: by 2002:a05:622a:a492:b0:4a7:26d2:5a38 with SMTP id
 d75a77b69052e-4ab92bdf67fmr419201cf.19.1752610695062; Tue, 15 Jul 2025
 13:18:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJuCfpFKNm6CEcfkuy+0o-Qu8xXppCFbOcYVXUFLeg10ztMFPw@mail.gmail.com>
 <CAJuCfpG_dRLVDv1DWveJWS5cQS0ADEVAeBxJ=5MaPQFNEvQ1+g@mail.gmail.com>
 <CAJuCfpH0HzM97exh92mpkuimxaen2Qh+tj_tZ=QBHQfi-3ejLQ@mail.gmail.com>
 <5ec10376-6a5f-4a94-9880-e59f1b6d425f@suse.cz> <19d46c33-bd5e-41d1-88ad-3db071fa1bed@lucifer.local>
 <0b8617c1-a150-426f-8fa6-9ab3b5bcfa1e@redhat.com> <8026c455-6237-47e3-98af-e3acb90dba25@suse.cz>
 <5f8d3100-a0dd-4da3-8797-f097e063ca97@lucifer.local> <CAEf4BzaEouFx8EuZF_PUKdc5wsq-5FYNyAE19VRxV7_YJkrfww@mail.gmail.com>
 <7568edfa-6992-452d-9eb2-2497221cb22a@lucifer.local> <7d878566-f445-4fc2-9d04-eb8b38024c9b@lucifer.local>
 <CAEf4BzYDktFt9R78tQifMrJ7okzA+1LhhiqCi+SpSdq3h4zKyw@mail.gmail.com>
In-Reply-To: <CAEf4BzYDktFt9R78tQifMrJ7okzA+1LhhiqCi+SpSdq3h4zKyw@mail.gmail.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Tue, 15 Jul 2025 13:18:03 -0700
X-Gm-Features: Ac12FXxyNmeLY-h4XS0JaeMQU9el1n8wMSHADzsB6KmgQZuTOsVzCS4Lh8cGUys
Message-ID: <CAJuCfpFx1vcv-a5Eez3AhoCUM2+jM6Sh0s9ms8FCWqZ8tFkTQg@mail.gmail.com>
Subject: Re: [PATCH v6 7/8] fs/proc/task_mmu: read proc/pid/maps under per-vma lock
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, 
	David Hildenbrand <david@redhat.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, akpm@linux-foundation.org, 
	peterx@redhat.com, jannh@google.com, hannes@cmpxchg.org, mhocko@kernel.org, 
	paulmck@kernel.org, shuah@kernel.org, adobriyan@gmail.com, brauner@kernel.org, 
	josef@toxicpanda.com, yebin10@huawei.com, linux@weissschuh.net, 
	willy@infradead.org, osalvador@suse.de, andrii@kernel.org, 
	ryan.roberts@arm.com, christophe.leroy@csgroup.eu, tjmercier@google.com, 
	kaleshsingh@google.com, aha310510@gmail.com, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 15, 2025 at 10:29=E2=80=AFAM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Tue, Jul 15, 2025 at 10:21=E2=80=AFAM Lorenzo Stoakes
> <lorenzo.stoakes@oracle.com> wrote:
> >
> > On Tue, Jul 15, 2025 at 06:10:16PM +0100, Lorenzo Stoakes wrote:
> > > > For PROCMAP_QUERY, we need priv->mm, but the newly added locked_vma
> > > > and locked_vma don't need to be persisted between ioctl calls. So w=
e
> > > > can just add those two fields into a small struct, and for seq_file
> > > > case have it in priv, but for PROCMAP_QUERY just have it on the sta=
ck.
> > > > The code can be written to accept this struct to maintain the state=
,
> > > > which for PROCMAP_QUERY ioctl will be very short-lived on the stack
> > > > one.
> > > >
> > > > Would that work?
> > >
> > > Yeah that's a great idea actually, the stack would obviously give us =
the
> > > per-query invocation thing. Nice!
> > >
> > > I am kicking myself because I jokingly suggested (off-list) that a he=
lper
> > > struct would be the answer to everything (I do love them) and of
> > > course... here we are :P
> >
> > Hm but actually we'd have to invert things I think, what I mean is - si=
nce
> > these fields can be updated at any time by racing threads, we can't hav=
e
> > _anything_ in the priv struct that is mutable.
> >
>
> Exactly, and I guess I was just being incomplete with just listing two
> of the fields that Suren make use of in PROCMAP_QUERY. See below.
>
> > So instead we should do something like:
> >
> > struct proc_maps_state {
> >         const struct proc_maps_private *priv;
> >         bool mmap_locked;
> >         struct vm_area_struct *locked_vma;
> >         struct vma_iterator iter;
> >         loff_t last_pos;
> > };
> >
> > static long procfs_procmap_ioctl(struct file *file, unsigned int cmd, u=
nsigned long arg)
> > {
> >         struct seq_file *seq =3D file->private_data;
> >         struct proc_maps_private *priv =3D seq->private;
> >         struct proc_maps_state state =3D {
> >                 .priv =3D priv,
> >         };
> >
> >         switch (cmd) {
> >         case PROCMAP_QUERY:
> >                 return do_procmap_query(state, (void __user *)arg);
>
> I guess it's a matter of preference, but I'd actually just pass
> seq->priv->mm and arg into do_procmap_query(), which will make it
> super obvious that priv is not used or mutated, and all the new stuff
> that Suren needs for lockless VMA iteration, including iter (not sure
> PROCMAP_QUERY needs last_pos, tbh), I'd just put into this new struct,
> which do_procmap_query() can keep private to itself.
>
> Ultimately, I think we are on the same page, it's just a matter of
> structuring code and types.

That sounds cleaner to me too.
I'll post a new version of my patchset today without the last patch to
keep PROCMAP_QUERY changes separate, and then a follow-up patch that
does this refactoring and changes PROCMAP_QUERY to use per-vma locks.

Thanks folks! It's good to be back from vacation with the problem
already figured out for you :)

>
> >         default:
> >                 return -ENOIOCTLCMD;
> >         }
> > }
> >
> > And then we have a stack-based thing with the bits that change and a
> > read-only pointer to the bits that must remain static. And we can enfor=
ce
> > that with const...
> >
> > We'd have to move the VMI and last_pos out too to make it const.
> >
> > Anyway the general idea should work!

