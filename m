Return-Path: <linux-kernel+bounces-842896-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id CF595BBDEA8
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 13:50:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 966D44EBC05
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 11:50:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64573274B5E;
	Mon,  6 Oct 2025 11:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jeRrfD/J"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6C48271467
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 11:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759751408; cv=none; b=tmLbuBx2+mABQSCCOrOlvr+P7N2JufPYA1EtZSB+6uMBpYWZuCMFn+KrU6nLk3TOEijB4cSAC77tgFVdIrPFMEVU+/WGEQRNMC4Qsr7mixQvVVVupNDELHSThVGWd6/64qg7PGeKXCM/YbAjyQkpFjttunstYkNbUDR+E38ko60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759751408; c=relaxed/simple;
	bh=rPtJyXEXF1+4sYy5GmvFIXGs+qoVQWtZoL4HjuY7d4c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IcSf0d/xr8TJrHSiTn4uAXGzPmaJj9qGV9kTXLAT8xYEyC54eovx7XoimqrctJMa+fUjZq7jqvp0JOajYNLHq1vDqwTftlok7Ig9NTs+G5IDNlIeaYI9EEsbvB6ZEpTlr8BrY6/96bWgC2Oy2WOYdYYbdXiCz5KDi8S+TRdjTzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jeRrfD/J; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3ee130237a8so3232037f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 04:50:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759751405; x=1760356205; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UyBasw6oNk2zpnfotHn17QmW8sov2N1oJVYn9mrVizM=;
        b=jeRrfD/J94zn/3ng52zkitEsEFyeiMsbNHJyklI2GPwjCBYNzpEi5uIBDGtYV/UIlI
         FXVGfS6sxuwQG332wvuirs2vAI1sp1TX+PYmTWhZgovHru6GcGuNQDP10fQkKiwXvJJD
         tvRDE6oEFFI951uwXyv/0WICvNMj81hLFt6ZsGUqLRKhFEhZVhvAh1XA6YTXT5BTZsND
         5ArWmyXVnUlOP6n5YEcVYAKtZtQBrb244qXsxtROOIzCHBh5KKjzsiCpTbmiT/rgH7e3
         3Ka1IxbahtkAyJot8+Kvn9b/NsrWqXcuV9mfLnI90dp7CVP7+Trkrq3p8pPw6q3Sokaq
         DoWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759751405; x=1760356205;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UyBasw6oNk2zpnfotHn17QmW8sov2N1oJVYn9mrVizM=;
        b=L1+g6tiS1/HBwNjDqdyrfgNIGTXfnLHhopaqm0CypCut8SRAy97S0w5E0N2cpTxcyx
         SKh299cr1SDD59UCyOxas2N1nOmJtOkLVyyZfNw7g74Qg0bRGJ0sZBihKcQ3oiJZyOFR
         uUtlGJg0txaluqpxmc+inBRJ2m3AVPfpV4OLoKD55k8XVuOfRDFAS3cm2/Z0fhtla17k
         XuP6PdoJ6MvuM3JrtFDS5BTghNudmnpCGQKK5/8RhA4E+bNb7JnJNyLv0u1dPiXRMfTU
         6lLx/PL3lTRfzAwIt5OrsLBjVTwXQjkG9LlCCQmrk/IvqUI81OsJ/b5W4cr2wRgtLDEm
         IyJQ==
X-Forwarded-Encrypted: i=1; AJvYcCXrziyMIqec1zMd4cbQfNNEssACYS6NK0myc1vcNjjb+0wmsy/oEBCpVhRZLwG6Kw2JsNd059xtOiRYyio=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfbGV8wi5n3/IBsn0JAQMb0qNPubTD1RxN+PXHBS7B/arGuKix
	6Mut7BfEmAPdPuTFUR/PAxbMSpr928I/nPGnhPVmroWbfi5QxFfAxIdX8pc5ht5Pilvh9bSCsox
	oorSFxUOrj40UJbEG7kyET8kf4us1kP3DHSzriIHb
X-Gm-Gg: ASbGncvXE2Q7iLA5vXlXdAn2IGjdoZkGruK+igMxUOD13xqJbl+BDEVpBpU7vYg7gls
	RPpBzdjImuuvUcWWSXYhs/2h+y5EfMRotxtt9c/+1aHj85zuKhgKQkttB0VfokFuPx3xlwt1K+S
	QnrCGcCz5nvvCQ7k60s/PpBxNbh0Sg9tB28MBVJ81qJgME78ePrOveAgyOlzrO385ZBKjTDMWuV
	Z3RvpK3DOijcJ7hX8iPCk6e4t9W7lLn15hhdi7cYE4shExqWprFGGTnVK9cRsb8EQkW
X-Google-Smtp-Source: AGHT+IGdp16P4q3VGxgx4jyAAd2iLI6qXsHfTNaFHR/GVV+aLzAEqlqtmbDJfQnsohQ/UjB+WbHSm9RuxOZuBjPKnec=
X-Received: by 2002:a05:6000:186e:b0:408:ffd8:2742 with SMTP id
 ffacd0b85a97d-4256719e408mr8952972f8f.33.1759751404729; Mon, 06 Oct 2025
 04:50:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251001-vmbo-defer-v3-0-a3fe6b6ae185@google.com>
 <20251001-vmbo-defer-v3-1-a3fe6b6ae185@google.com> <DD71GUKZKFPR.2OVPQ9KOI89YG@kernel.org>
 <CAH5fLghM_fmaHn561_e7StHAwdV=8gPxAwUToDxPQiBY8E+aVA@mail.gmail.com>
 <20251001171346.482142eb@fedora> <CAH5fLgjteqdWVBfzU_2iq2v=9MV9rD+s3z6i2ZjrmqBUq6_byQ@mail.gmail.com>
 <20251006134108.6a5cdcb7@fedora>
In-Reply-To: <20251006134108.6a5cdcb7@fedora>
From: Alice Ryhl <aliceryhl@google.com>
Date: Mon, 6 Oct 2025 13:49:52 +0200
X-Gm-Features: AS18NWC8HPIggNn6cfh3OrVUBPpfb3xMvycWVOnJhKokRI560k6qhwtD5DdKd4M
Message-ID: <CAH5fLghbbybzaQx0kwoEU9aCew8RAMyzVcO7JXytWPUseHvHaA@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] drm/gpuvm: add deferred vm_bo cleanup
To: Boris Brezillon <boris.brezillon@collabora.com>
Cc: Danilo Krummrich <dakr@kernel.org>, Matthew Brost <matthew.brost@intel.com>, 
	=?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Steven Price <steven.price@arm.com>, Daniel Almeida <daniel.almeida@collabora.com>, 
	Liviu Dudau <liviu.dudau@arm.com>, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 6, 2025 at 1:41=E2=80=AFPM Boris Brezillon
<boris.brezillon@collabora.com> wrote:
>
> On Mon, 6 Oct 2025 13:31:51 +0200
> Alice Ryhl <aliceryhl@google.com> wrote:
>
> > On Wed, Oct 1, 2025 at 5:13=E2=80=AFPM Boris Brezillon
> > <boris.brezillon@collabora.com> wrote:
> > >
> > > On Wed, 1 Oct 2025 16:42:35 +0200
> > > Alice Ryhl <aliceryhl@google.com> wrote:
> > >
> > > > On Wed, Oct 1, 2025 at 4:01=E2=80=AFPM Danilo Krummrich <dakr@kerne=
l.org> wrote:
> > > > >
> > > > > On Wed Oct 1, 2025 at 12:41 PM CEST, Alice Ryhl wrote:
> > > > > > +/*
> > > > > > + * Must be called with GEM mutex held. After releasing GEM mut=
ex,
> > > > > > + * drm_gpuvm_bo_defer_free_unlocked() must be called.
> > > > > > + */
> > > > > > +static void
> > > > > > +drm_gpuvm_bo_defer_free_locked(struct kref *kref)
> > > > > > +{
> > > > > > +     struct drm_gpuvm_bo *vm_bo =3D container_of(kref, struct =
drm_gpuvm_bo,
> > > > > > +                                               kref);
> > > > > > +     struct drm_gpuvm *gpuvm =3D vm_bo->vm;
> > > > > > +
> > > > > > +     if (!drm_gpuvm_resv_protected(gpuvm)) {
> > > > > > +             drm_gpuvm_bo_list_del(vm_bo, extobj, true);
> > > > > > +             drm_gpuvm_bo_list_del(vm_bo, evict, true);
> > > > > > +     }
> > > > > > +
> > > > > > +     list_del(&vm_bo->list.entry.gem);
> > > > > > +}
> > > > > > +
> > > > > > +/*
> > > > > > + * GEM mutex must not be held. Called after drm_gpuvm_bo_defer=
_free_locked().
> > > > > > + */
> > > > > > +static void
> > > > > > +drm_gpuvm_bo_defer_free_unlocked(struct drm_gpuvm_bo *vm_bo)
> > > > > > +{
> > > > > > +     struct drm_gpuvm *gpuvm =3D vm_bo->vm;
> > > > > > +
> > > > > > +     llist_add(&vm_bo->list.entry.bo_defer, &gpuvm->bo_defer);
> > > > > > +}
> > > > > > +
> > > > > > +static void
> > > > > > +drm_gpuvm_bo_defer_free(struct kref *kref)
> > > > > > +{
> > > > > > +     struct drm_gpuvm_bo *vm_bo =3D container_of(kref, struct =
drm_gpuvm_bo,
> > > > > > +                                               kref);
> > > > > > +
> > > > > > +     mutex_lock(&vm_bo->obj->gpuva.lock);
> > > > > > +     drm_gpuvm_bo_defer_free_locked(kref);
> > > > > > +     mutex_unlock(&vm_bo->obj->gpuva.lock);
> > > > > > +
> > > > > > +     /*
> > > > > > +      * It's important that the GEM stays alive for the durati=
on in which we
> > > > > > +      * hold the mutex, but the instant we add the vm_bo to bo=
_defer,
> > > > > > +      * another thread might call drm_gpuvm_bo_deferred_cleanu=
p() and put
> > > > > > +      * the GEM. Therefore, to avoid kfreeing a mutex we are h=
olding, we add
> > > > > > +      * the vm_bo to bo_defer *after* releasing the GEM's mute=
x.
> > > > > > +      */
> > > > > > +     drm_gpuvm_bo_defer_free_unlocked(vm_bo);
> > > > > > +}
> > > > >
> > > > > So, you're splitting drm_gpuvm_bo_defer_free() into two functions=
, one doing the
> > > > > work that is required to be called with the gpuva lock held and o=
ne that does
> > > > > the work that does not require a lock, which makes perfect sense.
> > > > >
> > > > > However, the naming chosen for the two functions, i.e.
> > > > > drm_gpuvm_bo_defer_free_unlocked() and drm_gpuvm_bo_defer_free_lo=
cked() is
> > > > > confusing:
> > > > >
> > > > > What you mean semantically mean is "do part 1 with lock held" and=
 "do part 2
> > > > > without lock held", but the the chosen names suggest that both fu=
nctions are
> > > > > identical, with the only difference that one takes the lock inter=
nally and the
> > > > > other one requires the caller to take the lock.
> > > > >
> > > > > It's probably better to name them after what they do and not what=
 they're part
> > > > > of. If you prefer the latter, that's fine with me too, but please=
 choose a name
> > > > > that makes this circumstance obvious.
> > > >
> > > > Fair point. Do you have naming suggestions? Otherwise I can name th=
em
> > > > drm_gpuvm_bo_defer_free_part1() and drm_gpuvm_bo_defer_free_part2()=
.
> > > > :)
> > >
> > > drm_gpuvm_bo_free_deferral_extract_locked() and
> > > drm_gpuvm_bo_free_deferral_enqueue()? Definitely not short names thou=
gh.
> >
> > With those names I have to do some additional line breaks. How about:
> >
> > drm_gpuvm_bo_into_zombie()
> > drm_gpuvm_bo_defer_zombie()
>
> Sounds good. I think I'd prefer if the second one was called
> drm_gpuvm_bo_defer_zombie_cleanup() to make clear what the deferral is
> about, but feel free to ignore this if you think it's too long.

Sounds good. It's more the first one that I want to keep short because
it's used with kref_put().

Alice

