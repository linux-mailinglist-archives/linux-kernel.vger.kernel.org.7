Return-Path: <linux-kernel+bounces-897228-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FF6AC52540
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 13:52:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0CA054F81AB
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 12:47:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5DE633557B;
	Wed, 12 Nov 2025 12:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="jUvqWmJa"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E265335555
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 12:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762951624; cv=none; b=I1i45rDEANmoI88TPFbz14LmW2VACA+zVe6RSk0JGkegrPvIV9cs8DtUmcNKGUHqCLsfo4Bp8HU8+nuB5+Fqs9SRg9yFMIvj/UI8paENx5REJYccRj2zvBUYNk9DWL44rQAvvl8bZ85e2S7Zv8W7meJbudqu2SMzrFth6/jvoNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762951624; c=relaxed/simple;
	bh=znZuQwa1aOziNsVVDXXpqJjJ+lN7ig6byCFqqLdTusA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Rt0MbsVXmszA9j4eAm5rW5Iuwkc6dw/SxaXqVf5O715j0cW7BBXpGD45w8ePdMhoEvPsYj0orQXkPgCvzg9WIlIXpC8ZjM1XmrRnD6A7mtJk4GrCj5QZw+Iqmpdq+j8hteyAdGls2CsD/2l90134wPD+UXIyq+OqashtwZ5CiOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=jUvqWmJa; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-64074f01a6eso1350004a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 04:47:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1762951621; x=1763556421; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NlYd6Xq+AnhKekfFM+8+8cT83BwyMkqy6p8G3DXg5+E=;
        b=jUvqWmJaXXN0cLEFVgCu1IoCmnJo4k8vi984y/p5n95rUUkqfnAAuIfq7cVevvIql+
         /XzUQpvtZujaqXLy9a7qyr9HqBncxaSBiP9TMtKSmtsRZvg4VyAytzD1QqrmvEnwzaqa
         0/hGsRWJ7fWOtg97EaV3/FG3Lf7PwYnhAPEhJiOry93QV7b1929GxqqRFtdmDHL4VbkU
         83pQT9I/AKnQ9BEvYiHaKl5lncv6/47ge4iv6d/KUsYfMbNm62XodQPUPPq/Nkdo11b7
         8n4HyHw7fRDxG8XpgnzpOHwtj75vn2lgHDvzrdARfG+mJZ6UYldPnwuV2U7D7v41ZNRz
         cRlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762951621; x=1763556421;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NlYd6Xq+AnhKekfFM+8+8cT83BwyMkqy6p8G3DXg5+E=;
        b=KUgMYH0ArwF+x+9AWsjfck4s9H8pUbiEk7tTW1OdqQEvOftH+DZr94JLbk70Kkeg5f
         26NDNatdj8gtcn5jyw5wmr9NA7O5Y9P4g5H5Ln1ePEIMtB6X/rUoekQrp388I6/rWM3+
         R0a/0Fh8eoknyzQG3juTi9YOPtw/pZA5UVQnxvDQlmx9rQIBuvKRTolgSz7HJDvcwSMa
         9aBxt7qT4FiBbgCge+4/fKNJ0Q6gbfTCP1/0QUtAY6Rn3ahdy15cnRugXalne+cjugJ4
         NWUkKx7wTleE7FnAMiDFddXLCqgriNQwO5xo8ab47b1Hse/8BBaRneEy9UyrnumFyi8b
         NuuA==
X-Forwarded-Encrypted: i=1; AJvYcCWeVpAZnUxfrWHnz1f/Gn39gExHuSxf5h2ImFQLdfCYrWGD2SJxBLJgyLDRjpOgS6DGN9Uvr4OyWLki4UE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKRRoz5NNQj0m+itaIo6RodMZwFuDpJVp4dmsX78RKiYeNB1Z+
	CHKUEUBX/AUze89thEPwuZMALmFPdJgjE07v7v+16N9MTrmiTktIJ/mLjaomQ0vUhem53tayM4v
	62MDJnvGqHuEDeKLLjiDZRnbWajsYYfpI2sKVaNLO9g==
X-Gm-Gg: ASbGncvos9aj/QZ/Kl/jetvtIe/+6SkXRBFmI+wXi67cdC+sazRpBSMQug6EvHUNpTC
	PqDIp4b9k57/IVjIF/XTMkKTqzAxVlliXeLJnDDFihq++s7RqstMpYNlHVlyPdRTcEShiwT/uYx
	TrN5UXGl4KGi1PtEhpHYK4m9wkV8jtxwBu8tQQrgFHSpLwKWaiwConcZEn0OWfaxJQHbZze6s7a
	pS70NfPpo020lXXJclL8ePb0JFblwt7RzKMCw4iYMm1CBjepA36KxmnPw==
X-Google-Smtp-Source: AGHT+IHPQjz/pJ437pH7YFtSiDGAQ3VcFvPXvPvzuQHBM0+kWPerbB0r4L6RkLw74giNqTUgcHTcvt5mHbrdxH4Haek=
X-Received: by 2002:a05:6402:5186:b0:640:9c99:bfac with SMTP id
 4fb4d7f45d1cf-6431a4d609bmr2586786a12.13.1762951620623; Wed, 12 Nov 2025
 04:47:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251107210526.257742-1-pasha.tatashin@soleen.com>
 <20251107210526.257742-3-pasha.tatashin@soleen.com> <aRObz4bQzRHH5hJb@kernel.org>
 <CA+CK2bDnaLJS9GdO_7Anhwah2uQrYYk_RhQMSiRL-YB=8ZZZWQ@mail.gmail.com>
 <CA+CK2bD3hps+atqUZ2LKyuoOSRRUWpTPE+frd5g13js4EAFK8g@mail.gmail.com> <aRRflLTejNQXWa1Z@kernel.org>
In-Reply-To: <aRRflLTejNQXWa1Z@kernel.org>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Wed, 12 Nov 2025 07:46:23 -0500
X-Gm-Features: AWmQ_bl87XR7836bCxIna383p3224VYBM84reJOLcIDxOxFdtSf2hXG1yTbnSeY
Message-ID: <CA+CK2bB8731z-EKv2K8-x5SH8rjOTTuWkfkrc4Qj6skW+Kr7-g@mail.gmail.com>
Subject: Re: [PATCH v5 02/22] liveupdate: luo_core: integrate with KHO
To: Mike Rapoport <rppt@kernel.org>
Cc: pratyush@kernel.org, jasonmiu@google.com, graf@amazon.com, 
	dmatlack@google.com, rientjes@google.com, corbet@lwn.net, 
	rdunlap@infradead.org, ilpo.jarvinen@linux.intel.com, kanie@linux.alibaba.com, 
	ojeda@kernel.org, aliceryhl@google.com, masahiroy@kernel.org, 
	akpm@linux-foundation.org, tj@kernel.org, yoann.congal@smile.fr, 
	mmaurer@google.com, roman.gushchin@linux.dev, chenridong@huawei.com, 
	axboe@kernel.dk, mark.rutland@arm.com, jannh@google.com, 
	vincent.guittot@linaro.org, hannes@cmpxchg.org, dan.j.williams@intel.com, 
	david@redhat.com, joel.granados@kernel.org, rostedt@goodmis.org, 
	anna.schumaker@oracle.com, song@kernel.org, zhangguopeng@kylinos.cn, 
	linux@weissschuh.net, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-mm@kvack.org, gregkh@linuxfoundation.org, tglx@linutronix.de, 
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, 
	hpa@zytor.com, rafael@kernel.org, dakr@kernel.org, 
	bartosz.golaszewski@linaro.org, cw00.choi@samsung.com, 
	myungjoo.ham@samsung.com, yesanishhere@gmail.com, Jonathan.Cameron@huawei.com, 
	quic_zijuhu@quicinc.com, aleksander.lobakin@intel.com, ira.weiny@intel.com, 
	andriy.shevchenko@linux.intel.com, leon@kernel.org, lukas@wunner.de, 
	bhelgaas@google.com, wagi@kernel.org, djeffery@redhat.com, 
	stuart.w.hayes@gmail.com, ptyadav@amazon.de, lennart@poettering.net, 
	brauner@kernel.org, linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	saeedm@nvidia.com, ajayachandra@nvidia.com, jgg@nvidia.com, parav@nvidia.com, 
	leonro@nvidia.com, witu@nvidia.com, hughd@google.com, skhawaja@google.com, 
	chrisl@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 12, 2025 at 5:21=E2=80=AFAM Mike Rapoport <rppt@kernel.org> wro=
te:
>
> On Tue, Nov 11, 2025 at 03:42:24PM -0500, Pasha Tatashin wrote:
> > On Tue, Nov 11, 2025 at 3:39=E2=80=AFPM Pasha Tatashin
> > <pasha.tatashin@soleen.com> wrote:
> > >
> > > > >       kho_memory_init();
> > > > >
> > > > > +     /* Live Update should follow right after KHO is initialized=
 */
> > > > > +     liveupdate_init();
> > > > > +
> > > >
> > > > Why do you think it should be immediately after kho_memory_init()?
> > > > Any reason this can't be called from start_kernel() or even later a=
s an
> > > > early_initcall() or core_initall()?
> > >
> > > Unfortunately, no, even here it is too late, and we might need to fin=
d
> > > a way to move the kho_init/liveupdate_init earlier. We must be able t=
o
> > > preserve HugeTLB pages, and those are reserved earlier in boot.
> >
> > Just to clarify: liveupdate_init() is needed to start using:
> > liveupdate_flb_incoming_* API, and FLB data is needed during HugeTLB
> > reservation.
>
> Since flb is "file-lifecycle-bound", it implies *file*. Early memory
> reservations in hugetlb are not bound to files, they end up in file objec=
ts
> way later.

FLB global objects act similarly to subsystem-wide data, except their
data has a clear creation and destruction time tied to preserved
files. When the first file of a particular type is added to LUO, this
global data is created; when the last file of that type is removed
(unpreserved or finished), this global data is destroyed, this is why
its life is bound to file lifecycle. Crucially, this global data is
accessible at any time while LUO owns the associated files spanning
the early boot update boundary.

> So I think for now we can move liveupdate_init() later in boot and we wil=
l
> solve the problem of hugetlb reservations when we add support for hugetlb=
.

HugeTLB reserves memory early in boot. If we already have preserved
HugeTLB pages via LUO/KHO, we must ensure they are counted against the
boot-time reservation. For example, if hugetlb_cma_reserve() needs to
reserve ten 1G pages, but LUO has already preserved seven, we only
need to reserve three new pages and the rest are going to be restored
with the files.

Since this count is contained in the FLB global object, that data
needs to be available during the early reservation phase. (Pratyush is
working on HugeTLB preservation and can explain further).

Pasha

