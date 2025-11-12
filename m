Return-Path: <linux-kernel+bounces-897850-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 52BDDC53D78
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 19:04:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8A41B5079E4
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 17:42:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 396AE34D39D;
	Wed, 12 Nov 2025 17:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="eIIwNQYL"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F88D346FD0
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 17:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762969209; cv=none; b=EbdTbaL7Gpo4T+7xeLWqWk02R7PrckH36aeRdbDDjYltvMlxwKk2BKDJojGSDbak26WQpFM7413NZ6xJv5ji1kcu5W07HswKHgFXl0zmE0QKzVBehGcO/wHO3thE/Ltt3ymbFSOYsqc6ByU5r7JJg/mTfsqTexJ+Sm/XjvfMP2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762969209; c=relaxed/simple;
	bh=RE2eA7P/7Vz7M8h0H7B1pE8WkmHGrQTJe78R5r6TM8g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PlOQt10pfh8OV5TUbpPLo1rh3Sj1oz8nRz7OdZcGnpRSo3cJX3rRz4Hzs7nZZ6dO/Vl6KFUdHBXd8TW5WSRSmtZQAm5lDeXXHql7q/p1zNtxXLGczPYbkUlvHMMTlxNYXZJUIe78xiMHz5GQYr5GKu+pLSPgQeLvtpYERucQOtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=eIIwNQYL; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-b4736e043f9so4655966b.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 09:40:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1762969205; x=1763574005; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RE2eA7P/7Vz7M8h0H7B1pE8WkmHGrQTJe78R5r6TM8g=;
        b=eIIwNQYLJxPgZlwsY881cSRdETEThaay41fWBo1NX4hWs15FQGFiQkpH0LqkOLbrhV
         sjvsi4E12Zz3TJfXuHRCT6SDPxhrBqrHZIYy9Ay/d4OeDfNgJ0jPO9lfAEQc+ew00M9O
         2HCt2Qf7nnujlkcJx5BFKXNCuzX9RJYi/RoXRlZmiN9a+R5Ik+xI8RVLt9ZTed7b2mgA
         Ef8XPih9mn76hX35YIze2X3tPp8OdqiIWlVWT3o2s5BceTvm4AnNsD5HVnYZSUU63HtA
         MkgY/UmA3Drr3Zk3sdcPo+blqbiEVooc0gcNsO6yK+gVb+D1auZCmCi0T7t/HLhfJ+zT
         NPiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762969205; x=1763574005;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RE2eA7P/7Vz7M8h0H7B1pE8WkmHGrQTJe78R5r6TM8g=;
        b=RkR0W2usH3z6qxPl9fezo68gADXs+rytEOXnMci5GUw/Dgn3FOwcfMFrl121T9HUhf
         K8abuN3hn33yfQSltqgDBukdK9L2SZe/t3pUmcz3kh/cNkf6pckcOmRMksltwq9m5si3
         xAcdJ2zekbaH+glhlK4rHQIv3NayiHCWOeOQw4U0ADKAU0Tn8x3sDuItI67ItbTMxbry
         iPdI9ePDn7RcN/iI1Q+GYoHs3ojNIY9cUOlbB423FqQZK7SIuvvG3RlunRlFxetHJSRn
         zxeMsGF0+IDae+YY3Vl3rfGLxmpiALtR0rgoL7506aLUTKoW44OSTCW3dtZB3VQAlvmG
         p83Q==
X-Forwarded-Encrypted: i=1; AJvYcCXFadWRAjPDAoTYlUNeXkePGPbxL8alpdaohpITfsj6+E6YPd1WuZAb5nQAm53YcaXCUnTCFpEQbf1Yucw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbrXFQ01pOst7FfFeRgWsHK/VYJGCRcMTxMMOTVxafAUuv6BAB
	WHZT9BVup4xeBn77cG273+Dnev3dqqepAwyLz8kLI9IAIeIf6dPmj9cqRQ6LjWxqDk8M9fhly28
	YWY80cZ4U79S5cOvzFV3ZZyrzzEJLR+tIF4oV7uvkVQ==
X-Gm-Gg: ASbGncvuNraPRwMJFpOpNzI9yFch19wILp6YEaVPK9fo2sY1tPNt/eDp0fl+h6fSfLM
	iUoU9RItLb2eDOMZ6HaZ/XohkBMNEz/GsmJxPKcMq9U0ghje1l5P69C5lcz5pqSjzlDUpoFKyQd
	Hj143zi4hyndHY16JakzcK6nddAH1Eym5qQ1w6NkHSs/YzPp3w1ZkYiP6R8e45HyVxyd03JwLXe
	wEsO+0W1QPUVxRfUA3wFA9d4GTmoAhlIPGadPk5wlR+7hpX/mLpKKx2AA==
X-Google-Smtp-Source: AGHT+IHi5sZulNxTcGLT0vratWdEhRElVLK7EUhU9NgVJAmPvI9YHKYMUBo34Ck91lnZ5X8prgSv1FiptNF2v5kod6c=
X-Received: by 2002:a17:907:7f22:b0:b72:a899:169f with SMTP id
 a640c23a62f3a-b733195fe84mr372213066b.4.1762969204362; Wed, 12 Nov 2025
 09:40:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251107210526.257742-1-pasha.tatashin@soleen.com>
 <20251107210526.257742-3-pasha.tatashin@soleen.com> <aRObz4bQzRHH5hJb@kernel.org>
 <CA+CK2bDnaLJS9GdO_7Anhwah2uQrYYk_RhQMSiRL-YB=8ZZZWQ@mail.gmail.com>
 <CA+CK2bD3hps+atqUZ2LKyuoOSRRUWpTPE+frd5g13js4EAFK8g@mail.gmail.com>
 <aRRflLTejNQXWa1Z@kernel.org> <CA+CK2bB8731z-EKv2K8-x5SH8rjOTTuWkfkrc4Qj6skW+Kr7-g@mail.gmail.com>
 <aRSMsz4zy8QBbsIH@kernel.org> <CA+CK2bA6vCH=RkiZjAOsh5iR52BY567bJB3HNAGqDb307YxVdw@mail.gmail.com>
In-Reply-To: <CA+CK2bA6vCH=RkiZjAOsh5iR52BY567bJB3HNAGqDb307YxVdw@mail.gmail.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Wed, 12 Nov 2025 12:39:26 -0500
X-Gm-Features: AWmQ_blg_-YBJXBsWxA1u_AvYtpevCDE34qeWleg00Ut4TD4d0UoYoLFZzxduk8
Message-ID: <CA+CK2bBvVW0XbsQaFjB0SzsTuqLNLhM7ak8S+yORH=_6W3iPqw@mail.gmail.com>
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

On Wed, Nov 12, 2025 at 10:14=E2=80=AFAM Pasha Tatashin
<pasha.tatashin@soleen.com> wrote:
>
> > > FLB global objects act similarly to subsystem-wide data, except their
> > > data has a clear creation and destruction time tied to preserved
> > > files. When the first file of a particular type is added to LUO, this
> > > global data is created; when the last file of that type is removed
> > > (unpreserved or finished), this global data is destroyed, this is why
> > > its life is bound to file lifecycle. Crucially, this global data is
> > > accessible at any time while LUO owns the associated files spanning
> > > the early boot update boundary.
> >
> > But there are no files at mm_core_init(). I'm really confused here.
>
> This isn't about the files themselves, but about the subsystem global
> data. The files are only used to describe the lifetime of this global
> data.
>
> I think mm_core_init() is too late, and the call would need to be
> moved earlier to work correctly with subsystems. At the very least, we
> will have to add some early FDT parsing to retrieve data during early
> boot, but that would be part of the HugeTLB preservation work.
>
> I can move liveupdate_init() inside kho_memory_init(), so we don't
> need to modify mm_core_init(). Or, rename kho_memory_init to
> kho_and_liveupdate_memory_init() and combine the two calls into a
> single function in kexec_handover.c.
>
> > > > So I think for now we can move liveupdate_init() later in boot and =
we will
> > > > solve the problem of hugetlb reservations when we add support for h=
ugetlb.
> > >
> > > HugeTLB reserves memory early in boot. If we already have preserved
> > > HugeTLB pages via LUO/KHO, we must ensure they are counted against th=
e
> > > boot-time reservation. For example, if hugetlb_cma_reserve() needs to
> > > reserve ten 1G pages, but LUO has already preserved seven, we only
> > > need to reserve three new pages and the rest are going to be restored
> > > with the files.
> > >
> > > Since this count is contained in the FLB global object, that data
> > > needs to be available during the early reservation phase. (Pratyush i=
s
> > > working on HugeTLB preservation and can explain further).
> >
> > Not sure I really follow the design here, but in my understanding the g=
ist
> > here is that hugetlb reservations need to be aware of the preserved sta=
te.
> > If that's the case, we definitely can move liveupdate_init() to an init=
call
> > and revisit this when hugetlb support for luo comes along.
>
> This will break the in-kernel tests that ensure FLB data is accessible
> and works correctly during early boot, as they use
> early_initcall(liveupdate_test_early_init);.

We had a chat, so we agreed to move liveupdate_init() into
early_initcall() and liveupdate_test_early_init into somewhere later
initcall. And when HugeTLB support is added we will introduce a
variant for read-only access to do it early in boot from setup_arch().

> We cannot rely on early_initcall() for liveupdate_init() because it
> would compete with the test. We also can't move the test to a later
> initcall, as that would break the verification of what FLB is
> promising: early access to global data by subsystems that need it
> (PCI, IOMMU Core, HugeTLB, etc.).
>
> Thanks,
> Pasha

