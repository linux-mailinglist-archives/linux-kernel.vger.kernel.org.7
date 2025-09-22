Return-Path: <linux-kernel+bounces-827462-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B8BBDB91D3A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 16:58:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A39D119008B2
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 14:58:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B70C2D73B5;
	Mon, 22 Sep 2025 14:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="ZukVEC2T"
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E164B2D63F7
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 14:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758553099; cv=none; b=QfpvYFkfqCGfSR9gBxe1MvNZhAlVplsYA+v0Z3GNN4KRTiTJ/4z8QdxTc1J4QTdCHMOt4k/1uxGMbKKQVgIO1dH4Pl8RG+/i0HLtF3/1/vCQS4jFZRM0kcU/aMAdH2xnnhpo1XepDEXgfb+ViE0R3GSwgXIt4pc6ktjVo0stWd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758553099; c=relaxed/simple;
	bh=bk/uSOBhjlLpezuJ67nR7iyn8eOOajtcOPPkD+iN/3c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iuvZLlojGJSsuXsGC/Ss/IwCzbo67g9T7ZwgYanIGw8Syp2haDhwG8skEYir8n3zksPPfz9IdGmidetAaljPG0ax29LwCdHIVV9PsE1IPvw3G5ZBtES1O7M5LT3+iFk0e8i5K7yMu4SQ1RXRS4xetN/R+KHhu1H9fPXIgwL2nHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=ZukVEC2T; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4c794491480so21344011cf.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 07:58:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1758553097; x=1759157897; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eFVWZlAioBD8f+qAHkBJ/aidH/GZeFQvA+qClIUvAWI=;
        b=ZukVEC2TBHAzXAq1pJ57A+FQBf77prwd0uZpcCm7CiP1eyDs3Vm3KRA1I9PFOqLsH2
         2wPq27j3F3bQuCq5fUt9llx7sjeF0BMZUBWAY8ZQEmyf/liW3pqzv1IOYnT9I2ZBoEPX
         pswDF/EeI1DbHR/d3UeGJ2PgS1punXOeZhNwsrLv47atcgf9gqpDOTzDmtehGDYkw2O6
         20nmty0XcDB2YOvGe5MubykrS2Z4b+3MQBtcpKezm3apfn5w0CtFyp8/Pgnr3vWniMoD
         3szXovJtaP+6UTxvOsxqJmuft80jXG7XKzWwC/W5XaiDnCL1Ah13iLj6JoyKmexoszIY
         dDqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758553097; x=1759157897;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eFVWZlAioBD8f+qAHkBJ/aidH/GZeFQvA+qClIUvAWI=;
        b=obSfejKXFLLdIRJlCh/n/RgsqU+LiMBD+EbJrY75YhBqo5Qbn05AjBZCVqZlkqXONM
         v7P1RyeJ1b+jMQRx+QB4SHRDGycqS9tegK4sR9CaAXkCOIsGY/tlaRkT1ESGfiQ9ToOC
         Nuktf0wtXkB85AcchCN1aBBmUyPiqwLh338mK5fyhSA/NN0HrSoPELWD24JNwwWyFrtt
         LtqRji6ykgkxnhPYKtq5ok8qDWmLf1JJtawtPfTVK0dNKw9OK9XdV8dirKU08bNJTESq
         YMUsuhgcpYb+0CQziFZExzNn1n6UmL9qAbE/+7UHuQE0IWMaXstvp+Hx6/Ks4hhoohMh
         SKzg==
X-Forwarded-Encrypted: i=1; AJvYcCWW0A3ILkcUTM5keNpdL70TzSZmM8BlPEJnH/ui6CN9Zs4VdWSRSZGeWSsqSrlWDDEm5keidJc86SY0zGA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKQzSGKvjVNV8RDvFKQvgQpjrmEOY1orDbd6JbziHoBkdnRv6v
	vrcFNUHHRCvMBqtcqcxdil807fuc5GZwx7DNmEBifxFmzxLmrw4uX424n6yqKphuRVTOz0e0rcP
	8dR9BY8I0DAEo8viD0buJKtV0ZrNL8zThE9raUQeYPQ==
X-Gm-Gg: ASbGncsYT2mKmcRWj8IP4cu/toKdlojxz/wePmhWMvUyySck+PTJdOcswhxCRXF//ap
	4/ukMI3wFTCv1H02tP8OedjcoPUvWda03X/iNrxhM3YAEnlD28XgKA00CRYtbJuALxj1ljl4Zek
	bQqYDzY4lPyZ4S/8uPlUths82mAviRAtDLcWbTuxznnKbGwLrVSYIx9W7X2XJLeONYnO3QF1G2u
	TiD
X-Google-Smtp-Source: AGHT+IFB/CQ+Stx8wqmihXNU+u019GIyHx6IROg0+AJtIcKFDHMuxhnTyNrT+0blnUsLunK7sMerRGUSSQ0zeNBJCw8=
X-Received: by 2002:a05:622a:1aa0:b0:4b5:d70a:2245 with SMTP id
 d75a77b69052e-4c073ab0d34mr174036401cf.77.1758553096737; Mon, 22 Sep 2025
 07:58:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250807014442.3829950-1-pasha.tatashin@soleen.com>
 <20250807014442.3829950-9-pasha.tatashin@soleen.com> <20250814133009.GC802098@nvidia.com>
In-Reply-To: <20250814133009.GC802098@nvidia.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Mon, 22 Sep 2025 10:57:39 -0400
X-Gm-Features: AS18NWDigaezp8KdbFsh6YfrVI9s8S_j72gr5tDnCBaGxghJTTvfOltyGvHBbhQ
Message-ID: <CA+CK2bDDo7xVxFd=-vkkXuUyStj9ShmURmGNPkMyJvi96KrV7Q@mail.gmail.com>
Subject: Re: [PATCH v3 08/30] kho: don't unpreserve memory during abort
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: pratyush@kernel.org, jasonmiu@google.com, graf@amazon.com, 
	changyuanl@google.com, rppt@kernel.org, dmatlack@google.com, 
	rientjes@google.com, corbet@lwn.net, rdunlap@infradead.org, 
	ilpo.jarvinen@linux.intel.com, kanie@linux.alibaba.com, ojeda@kernel.org, 
	aliceryhl@google.com, masahiroy@kernel.org, akpm@linux-foundation.org, 
	tj@kernel.org, yoann.congal@smile.fr, mmaurer@google.com, 
	roman.gushchin@linux.dev, chenridong@huawei.com, axboe@kernel.dk, 
	mark.rutland@arm.com, jannh@google.com, vincent.guittot@linaro.org, 
	hannes@cmpxchg.org, dan.j.williams@intel.com, david@redhat.com, 
	joel.granados@kernel.org, rostedt@goodmis.org, anna.schumaker@oracle.com, 
	song@kernel.org, zhangguopeng@kylinos.cn, linux@weissschuh.net, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-mm@kvack.org, 
	gregkh@linuxfoundation.org, tglx@linutronix.de, mingo@redhat.com, 
	bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, 
	rafael@kernel.org, dakr@kernel.org, bartosz.golaszewski@linaro.org, 
	cw00.choi@samsung.com, myungjoo.ham@samsung.com, yesanishhere@gmail.com, 
	Jonathan.Cameron@huawei.com, quic_zijuhu@quicinc.com, 
	aleksander.lobakin@intel.com, ira.weiny@intel.com, 
	andriy.shevchenko@linux.intel.com, leon@kernel.org, lukas@wunner.de, 
	bhelgaas@google.com, wagi@kernel.org, djeffery@redhat.com, 
	stuart.w.hayes@gmail.com, ptyadav@amazon.de, lennart@poettering.net, 
	brauner@kernel.org, linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	saeedm@nvidia.com, ajayachandra@nvidia.com, parav@nvidia.com, 
	leonro@nvidia.com, witu@nvidia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 14, 2025 at 9:30=E2=80=AFAM Jason Gunthorpe <jgg@nvidia.com> wr=
ote:
>
> On Thu, Aug 07, 2025 at 01:44:14AM +0000, Pasha Tatashin wrote:
> >  static int __kho_abort(void)
> >  {
> > -     int err =3D 0;
> > -     unsigned long order;
> > -     struct kho_mem_phys *physxa;
> > -
> > -     xa_for_each(&kho_out.track.orders, order, physxa) {
> > -             struct kho_mem_phys_bits *bits;
> > -             unsigned long phys;
> > -
> > -             xa_for_each(&physxa->phys_bits, phys, bits)
> > -                     kfree(bits);
> > -
> > -             xa_destroy(&physxa->phys_bits);
> > -             kfree(physxa);
> > -     }
> > -     xa_destroy(&kho_out.track.orders);
>
> Now nothing ever cleans this up :\

It is solved with stateless KHO. The current implementation is broken,
dropping everything in abort should never happen for stuff that was
independently preserved.

> Are you sure the issue isn't in the caller that it shouldn't be
> calling kho abort until all the other stuff is cleaned up first?
>
> I feel like this is another case of absuing globals gives an unclear
> lifecycle model.

Yes. But, we have a fix for that.

Pasha

