Return-Path: <linux-kernel+bounces-816010-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FF7FB56E23
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 04:11:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E0CE3A72DB
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 02:11:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DAFD218EA2;
	Mon, 15 Sep 2025 02:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MghyeOKW"
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E1A71E520D
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 02:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757902255; cv=none; b=I/pV8rXbc4obalhGYZ0LlTnDW1mIP11GCYC4Lklx18q+sa7wQ9tHny7U8IrD92Mmp5GEAl1BHwLbCMBBX3svV/rPg6HPzuHkMM6FTBcWY+FRr+m31TYJduj8xT0+rvZfFtR3K0/FggS6xglxeLM39GTKBK1i8cG2pvUaCuLIwNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757902255; c=relaxed/simple;
	bh=E8SaG3rK9OPYG2h30/QNxZDdik6CZIZaWWjp+wbNWmM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YSua/cNV0PLwkMp9DOQNDgunV2yDqinnZBgkkl2uszcx44C3Pbx5Esdm0ORustX/8ujTkKi2PGxJvHRr9+by9ObSd6As37efL/2BH+kpxO+FSgOLBjrSt0uQHUDsRx1L0KlVNtZ94MKCZFfVbz6kcBEt8cdfDynmK9fvibVNTTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MghyeOKW; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-723ad237d1eso32968897b3.1
        for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 19:10:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757902253; x=1758507053; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bb/70s7hZ9XnWpsor82v4Uu8WD+M2Uwq/i5EJIsF6h8=;
        b=MghyeOKWg4xXYvFBQYoS8RGAWusiYPq5Jgw6WANpgM1P+05USoeL/L7AwZLKNdxrqj
         4Z0ykeJckUgFI4Y3y9uvyns2+FukgUR4c0nYX9IhQFHTeUmq/M5wa1T1+055hQwWvQjf
         sx9gyRNdVV8vqW7Zu4tqkkr9Jb4ZmwUR7N+kNxbXYkBJ4G3jBPmqpoldIFA64UP9csc4
         2RbOmu+zq3wq5xiOX/Tt+18ilvVln9kIl3QolbTZeWkV3TbFYHc817VZNbxCaeNxKbak
         mkU8QpILU4UTo/0Nn9W4jeRO+kzjyR1iAGjR8le5bBef+EQEvN2bM6jx5PaLEbc2EjpS
         SvHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757902253; x=1758507053;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bb/70s7hZ9XnWpsor82v4Uu8WD+M2Uwq/i5EJIsF6h8=;
        b=Sw/FTat4ZDop3KQ8Hrb5Oh15rzJ6H0s35j6c2Yr76XKcebdtNZg76aJKtCOxNuen+s
         +QK0UzHmM6p14qZDWE6nlIF68agwEDDOVStZRPhl3U9FPS58Ny/SX5FrjqXrjjDqlL8w
         bDTyvUJmkAzBeig1I7riWS3/iUk31x+cxpgOgb9ekNzNXAaBwbB/hupvvGRX5+QmBB3H
         dkVglaax8fEqjQMYwgiy6IYWNSMGu2JyKj/WflUeqy63yWLPFfR1R5+hLt16v0c6MyQ3
         lk8uFw+c2IF6d8gWG99/eyZZsY2jfegp3Z2MK4Lx68TQSpuOBYyjKKWWj4cys3/itMiC
         ZRkw==
X-Forwarded-Encrypted: i=1; AJvYcCVx/1X/coUnFyzjs/H6URo33Bn/VRtih7DsDewnn1Et9zpL2Z3m3EaRqPZe/9+UwxdRKdDQbx0QuR34xU4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw34X8LR9rhCga6AME+x3zhCdCpF/LHJ4/YvY8k4qhsZaIAtSIZ
	ugjgT0KQ2f33kL/cYjtDAqSgnkP954bMlRBkxs78sbn8Y4pwN9C7A8b7Z22opJ7dimHhNy8232/
	dNkQm2mAeDNtE1waJaxRiGtFJrcanY2A=
X-Gm-Gg: ASbGncsJKlhUuAwUBLlUfN/U39TTL5zf/AX8qt2Rewc2eWAxAl2O0jDUotH/wM5C62L
	AVavSik3VDQdTJbisxTN13rwnVn5qR9/WyN5rwhKSwCyEGp3ijI+wKTAW2COMsOkHjsm7mybXZG
	VNpi0Vnl+XbCb4qGjQOJEaJ5xElgOYbI71fe12btvPx8vLTGenb1AJ4JzrpcEH6G12VNt+NHiVB
	3R+cmJeLmv48nYBYbTU/rs9GYr8esV8HAsVocCw2qRyGzmCiv4=
X-Google-Smtp-Source: AGHT+IGSARAJPsgY7DKq/2UWn0Qgs3Gt/9qvM16JbDHv3KDLoJQkGtaNs2DBUCW1ZV9cWRNyH27uIXWhigo6SRbl6oQ=
X-Received: by 2002:a05:690c:450d:b0:721:1649:b05b with SMTP id
 00721157ae682-73063094a3dmr99044467b3.13.1757902252841; Sun, 14 Sep 2025
 19:10:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250912222539.149952-1-dwindsor@gmail.com> <20250912222539.149952-2-dwindsor@gmail.com>
 <CAPhsuW4phthSOfSGCrf5iFHqZH8DpTiGW+zgmTJQzNu0LByshw@mail.gmail.com>
 <CAEXv5_gR1=OcH9dKg3TA1MGkq8dRSNX=phuNK6n6UzD=eh6cjQ@mail.gmail.com>
 <CAPhsuW44HznMHFZdaxCcdsVrYuYhJOQAPEjETxhm-j_fk18QUw@mail.gmail.com>
 <CAEXv5_g2xMwSXGJ=X1FEiA8_YQnSXKwHFW3Cv5Ki5wwLkhAfuA@mail.gmail.com> <CAADnVQLuUGaWaThSb94nv8Bb_qgA0cyr9=YmZgxuEtLaQLWzKw@mail.gmail.com>
In-Reply-To: <CAADnVQLuUGaWaThSb94nv8Bb_qgA0cyr9=YmZgxuEtLaQLWzKw@mail.gmail.com>
From: David Windsor <dwindsor@gmail.com>
Date: Sun, 14 Sep 2025 22:10:41 -0400
X-Gm-Features: Ac12FXwZkmA9MvRhoKidTeoeExlcsVdM8EuLRP0jfvl-W24TeL0RAL68lYTM2B4
Message-ID: <CAEXv5_griDfE03D1wDLH8chgCz0R2qZ5dAeiG0Rcg5sAicnMsg@mail.gmail.com>
Subject: Re: [PATCH 1/2] bpf: Add BPF_MAP_TYPE_CRED_STORAGE map type and kfuncs
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Song Liu <song@kernel.org>, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard <eddyz87@gmail.com>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 14, 2025 at 9:10=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Sat, Sep 13, 2025 at 3:27=E2=80=AFPM David Windsor <dwindsor@gmail.com=
> wrote:
> >
> >
> >
> > On Sat, Sep 13, 2025 at 5:58=E2=80=AFPM Song Liu <song@kernel.org> wrot=
e:
> >>
> >> On Fri, Sep 12, 2025 at 5:27=E2=80=AFPM David Windsor <dwindsor@gmail.=
com> wrote:
> >> [...]
> >> > >
> >> > > Maybe I missed something, but I think you haven't addressed Alexei=
's
> >> > > question in v1: why this is needed and why hash map is not suffici=
ent.
> >> > >
> >> > > Other local storage types (task, inode, sk storage) may get a larg=
e
> >> > > number of entries in a system, and thus would benefit from object
> >> > > local storage. I don't think we expect too many creds in a system.
> >> > > hash map of a smallish size should be good in most cases, and be
> >> > > faster than cred local storage.
> >> > >
> >> > > Did I get this right?
> >> > >
> >> > > Thanks,
> >> > > Song
> >> > >
> >> >
> >> > Yes I think I addressed in the cover letter of -v2:
> >> >
> >> > "Like other local storage types (task, inode, sk), this provides aut=
omatic
> >> > lifecycle management and is useful for LSM programs tracking credent=
ial
> >> > state across LSM calls. Lifetime management is necessary for detecti=
ng
> >> > credential leaks and enforcing time-based security policies."
> >> >
> >> > You're right it's faster and there aren't many creds, but I feel lik=
e
> >> > in this case, it'll be a nightmare to manual cleanup with hashmaps. =
I
> >> > think the correctness we get with lifetime management is worth it in
> >> > this case, but could be convinced otherwise. Many cred usage pattern=
s
> >> > are short lived and a hash map could quickly become stale...
> >>
> >> We can clean up the hashmap in hook cred_free, no? The following
> >> check in security_cred_free() seems problematic:
> >>
> >>         if (unlikely(cred->security =3D=3D NULL))
> >>                 return;
> >>
> >> But as far as I can tell, it is not really useful, and can be removed.
> >> With this removed, hash map will work just as well. Did I miss
> >> something?
> >
> >
> > No I think actually this is easier.
> >
> > I will prepare a patch for the race in cleanup I stumbled on earlier wh=
ich is still there and could affect other users.
> >
> > That said, is there any use case for local storage for these structs:
> >
> > - struct file
> > - struct msg_msg
> > - struct ipc
> >
> > I can off the top of my head think of some security use cases for these=
 but not sure if hashmaps are needed, perhaps struct file
>
> Sorry, no. This is not a copy paste territory.

no i get it's not copy/paste but I have the series for struct file
ready for submission, with selftests. this is also a performance
critical use case and there will be numerous struct file on edge
servers.

> The existing local storage maps were added because
> performance was critical for those use cases,
> but we made a few mistakes. There is a performance
> cliff that has to be fixed before we adopt it to
> other kernel objects.

ahh wasn't aware of this.

> Please use hash map and consider wrapping rhashtable
> as a new bpf map type if fixed max_entries is problematic.
>

makes sense thanks

> pw-bot: cr

