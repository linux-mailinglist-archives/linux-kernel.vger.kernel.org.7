Return-Path: <linux-kernel+bounces-861870-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DDDABF3DFA
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 00:18:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 96FA318A71B4
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 22:19:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEBBA2F12B1;
	Mon, 20 Oct 2025 22:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="ZTByCyCd"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 959BF2ED165
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 22:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760998719; cv=none; b=gLb1d5rKB9fQZ9LsRbVODXKlCVep30vEKszOUf5sDSdFtBmB+PxkR4TmxUPhdbmT5MQMMA49eFM/MBj/oIBA8Jkb5y1x9NgkJgrnhtDYBPBPfSYFIPiBVCXPgoBmtyl9jWvUIrSwaBrltVbjDMq9puckKlYcgel2iYD2e7YnHQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760998719; c=relaxed/simple;
	bh=zLmWNmAW92CD9qSTih2QZcvchQ8YRmVf7S/2MT1w9iY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Sdj1Awub8sFgfyMJGEoy7UTAbS6b+yhxwCJ/JPe0qq9f0JzDFe93UyVBxtn8j1PL4r4KVvmcZ8mWto105q9zOP9YSkkg8HKgcVzFpyT9hCA+ZZ/HtmLlEKhGjBD1YiCF6K/G09o9cIX7BjhPxiPn/hlDCpNgsRIGZ0U19HdP03A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=ZTByCyCd; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-62fca01f0d9so9975877a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 15:18:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1760998716; x=1761603516; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WDaMUs9ysjJq2V2EnmmexrY7sMGK4Wn3C8vR2OOio/g=;
        b=ZTByCyCdUwr9qTKu+iQ8w6U553LZlnqK2jhirZtEIaN2kA3Gcpe3jVoPAdL9aPbqb3
         lYC0ysh69a0FbgdGzNKIpO9X13b9HxU9JXxuzpPQhM4VzRwkPW0L1PWzs3YG2PmCotsm
         NhWgCKjukW4427ZeegbKQZG/JpeVKitn9ErP8TZ18VVLLsgziQaSTlxVrW5MTxeZnuuf
         0Su+YIYjjACHAV5Ynr+vrRXeXBhYpL41+QvR8qCx67ddp1c6aZ5ievhA7OmP080Z3eAn
         P3pvzkHN5wSWKFMXKZcbzeE7Mz1I/LerjFCsdd5pTRCBuccM/HS7NJAxyL80g4cpO06m
         BRrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760998716; x=1761603516;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WDaMUs9ysjJq2V2EnmmexrY7sMGK4Wn3C8vR2OOio/g=;
        b=eCOu0mOt+dTMWjbTlndD6xwxkWQUIHK/OX0JOjoEZQbrOIk+Nq+EJEJaRy69I+CkRj
         Q+Scez1RrtSXouOipUssLJn1IGysuq2jv+Nmdi4+7V93Wrp4AjdgFesVAtYuN6No1vM2
         EmHHVFgeoSBfXOlHJv7qIPqVD/WoN4L9XghLd0KnBm9cb6yn4TYm7nizAXjbDw15kxwo
         P8TDjUEPHI/ZLn61C77SxjB3JA5RKPog8K2GAWl/qNxWeAUkgW/dcYdOpNHERK9AJ0hZ
         W2usEK3stw+ix67xppn9XO6kOt99weMe7qHuD2pknxPbAJ8MovhGCaxlQjo4T/StthW5
         b2KQ==
X-Forwarded-Encrypted: i=1; AJvYcCXuKdjRP3L5RqlMmvg6Wy0xhlIf5bpM1sS4DeN1YUvszIYAoaSMlYihT4f7POkTFJrsSdCnpCB2QD7YAVU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2+JnEVTJLqNXrinQFN8aEOUAdXU6c8eo1PK8Z+0m6cP8oW7Kd
	fiQswsgqPQ2AQrw3Gxdg+/3yzX7RdXwgCJPb1blBBlzuJobDEPIfja2TGMII7kvnluLknbJQvIt
	Klnt20G0WPjePBeJYEkfZQcqKD9srALMUeankWySc3g==
X-Gm-Gg: ASbGnctXig/Ahy/590Xg9DDacQtqdKgoL2Q9Jj9Ljd76lwC98WYYqFMyvDLEomE05j+
	uxDFI67SOuLjlSWq+Ja84RCcU1F2369dHee4G/vZhNygtKYZSZVbEUMQOgEUjYDSIkBAiNv0TGM
	glxcOirbuvrIubtkDMKDD4o5bnbox5khzWel8gW7DmF7tV2CtpB7mMys9cGgxloz+WoHWgS6Eh9
	etab9B7HnUxB2zV6Hod/tb4hR4GDX9YlFisc7SPTOFKYTxOV2bK/SVQig==
X-Google-Smtp-Source: AGHT+IGFz985JP/FEtDxD1hvHY/7YU+GyiyLDce6kdCarRwFKUOACHslpISyiCG0GwShiHdoOO2eNcmYTRmxIn7oa2M=
X-Received: by 2002:a05:6402:5656:b0:637:8faa:9df7 with SMTP id
 4fb4d7f45d1cf-63c1f6cefdamr10653493a12.29.1760998715953; Mon, 20 Oct 2025
 15:18:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251018171756.1724191-1-pasha.tatashin@soleen.com>
 <20251018171756.1724191-11-pasha.tatashin@soleen.com> <aPXtWDPGHA2kCg32@kernel.org>
In-Reply-To: <aPXtWDPGHA2kCg32@kernel.org>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Mon, 20 Oct 2025 18:17:59 -0400
X-Gm-Features: AS18NWBy5p958YNTaetPtzYmdWYcTYv7f79OnV0oOta8WbMPy_4qsdcA5pKLWHA
Message-ID: <CA+CK2bDicreG8UPFPDmE9KAbKUy-M_oOPdrmwmsU0iFfjHKzvw@mail.gmail.com>
Subject: Re: [PATCH v6 10/10] liveupdate: kho: allocate metadata directly from
 the buddy allocator
To: Mike Rapoport <rppt@kernel.org>
Cc: akpm@linux-foundation.org, brauner@kernel.org, corbet@lwn.net, 
	graf@amazon.com, jgg@ziepe.ca, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, masahiroy@kernel.org, 
	ojeda@kernel.org, pratyush@kernel.org, rdunlap@infradead.org, tj@kernel.org, 
	jasonmiu@google.com, dmatlack@google.com, skhawaja@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 20, 2025 at 4:05=E2=80=AFAM Mike Rapoport <rppt@kernel.org> wro=
te:
>
> On Sat, Oct 18, 2025 at 01:17:56PM -0400, Pasha Tatashin wrote:
> > KHO allocates metadata for its preserved memory map using the slab
> > allocator via kzalloc(). This metadata is temporary and is used by the
> > next kernel during early boot to find preserved memory.
> >
> > A problem arises when KFENCE is enabled. kzalloc() calls can be
> > randomly intercepted by kfence_alloc(), which services the allocation
> > from a dedicated KFENCE memory pool. This pool is allocated early in
> > boot via memblock.
> >
> > When booting via KHO, the memblock allocator is restricted to a "scratc=
h
> > area", forcing the KFENCE pool to be allocated within it. This creates =
a
> > conflict, as the scratch area is expected to be ephemeral and
> > overwriteable by a subsequent kexec. If KHO metadata is placed in this
> > KFENCE pool, it leads to memory corruption when the next kernel is
> > loaded.
> >
> > To fix this, modify KHO to allocate its metadata directly from the budd=
y
> > allocator instead of slab.
> >
> > Fixes: fc33e4b44b27 ("kexec: enable KHO support for memory preservation=
")
> > Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> > Reviewed-by: Pratyush Yadav <pratyush@kernel.org>
> > ---
> >  kernel/liveupdate/kexec_handover.c | 8 +++++---
> >  1 file changed, 5 insertions(+), 3 deletions(-)
> >
> > diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kex=
ec_handover.c
> > index 7c8e89a6b953..92662739a3a2 100644
> > --- a/kernel/liveupdate/kexec_handover.c
> > +++ b/kernel/liveupdate/kexec_handover.c
> > @@ -132,6 +132,8 @@ static struct kho_out kho_out =3D {
> >       .finalized =3D false,
> >  };
> >
> > +DEFINE_FREE(kho_free_page, void *, free_page((unsigned long)_T))
> > +
>
> Just drop kho_ prefix and stick it into include/linux/gfp.h

done

>
> >  static void *xa_load_or_alloc(struct xarray *xa, unsigned long index)
> >  {
> >       void *res =3D xa_load(xa, index);
> > @@ -139,7 +141,7 @@ static void *xa_load_or_alloc(struct xarray *xa, un=
signed long index)
> >       if (res)
> >               return res;
> >
> > -     void *elm __free(kfree) =3D kzalloc(PAGE_SIZE, GFP_KERNEL);
> > +     void *elm __free(kho_free_page) =3D (void *)get_zeroed_page(GFP_K=
ERNEL);
> >
> >       if (!elm)
> >               return ERR_PTR(-ENOMEM);
> > @@ -352,9 +354,9 @@ static_assert(sizeof(struct khoser_mem_chunk) =3D=
=3D PAGE_SIZE);
> >  static struct khoser_mem_chunk *new_chunk(struct khoser_mem_chunk *cur=
_chunk,
> >                                         unsigned long order)
> >  {
> > -     struct khoser_mem_chunk *chunk __free(kfree) =3D NULL;
> > +     struct khoser_mem_chunk *chunk __free(kho_free_page) =3D NULL;
> >
> > -     chunk =3D kzalloc(PAGE_SIZE, GFP_KERNEL);
> > +     chunk =3D (void *)get_zeroed_page(GFP_KERNEL);
> >       if (!chunk)
> >               return ERR_PTR(-ENOMEM);
> >
> > --
> > 2.51.0.915.g61a8936c21-goog
> >
>
> --
> Sincerely yours,
> Mike.

