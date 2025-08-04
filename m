Return-Path: <linux-kernel+bounces-755257-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CAA7B1A3BB
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 15:45:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D8733AC1DF
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 13:45:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E11E619D092;
	Mon,  4 Aug 2025 13:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cv5YlAha"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BD6B25D208
	for <linux-kernel@vger.kernel.org>; Mon,  4 Aug 2025 13:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754315118; cv=none; b=tbwHRNNerFDbDBcvsNUfBE0OguiaLV1KkOZg7EecyqwhqMBg9zDwDEpjDnpzoyFy993MN5N1w7FCGvOIQtC8L35Gcdl6CTSmVKYY2dYP+jwI11IbYgY9HYw4jEQP17mCP/IhGVs4E2Y8x+4fCA/9ixNggFGrP0yev3kwU1UmuOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754315118; c=relaxed/simple;
	bh=1jH5khfvRzgjhCuPquHsfZtTT8xyalgl+ik0yhOuA/w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VUMW2jjEY99j7qa3AdcrDUIBHIqgZXyEo3vm1P4KQat4e9CAWAlmwNTz6svPDkrZ2M7kUgBzfDUELzDA+/h2uYA1PrlofjJVbMv9DJqRE8eGOvx3JUAqx848N+w8DNVb530guKJ/sbFyYZza834kfT/50G/LgFQoNEQe8Ph39VY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cv5YlAha; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4589968e001so28913105e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Aug 2025 06:45:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754315115; x=1754919915; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lVxfLjqZpUxA7k2P1DVAmCagXBwL2u2PCEjKY9dcPbA=;
        b=cv5YlAhablHCtX/qr2i86/WWkxQRjwknqyG+u0FgOGCvdCEoDBrpo9XPt9cm/HLJZX
         Obkw9E6tjY2KOJMEau33wv2H2xQH7UW8sZEmpqell3KFW+dLK21fZ5px3Nd22Y/gXhTm
         WRnE8GSi90aehZiuQ2kTy4htHGnUJzK53B/BJ3dPLHlpB4TZr6RxEU+QEO2F6bNLonFJ
         g7UTRNrqnInEx57j7EabRWc9M9VmvHuYmCe8WsCG+dx0MYqmHPkFKMF10bBjaGghZ0ez
         EnUiFUZIxZqhctr9lBdpKnssTpbtDC3OSukMRY4pbon9DnXn9WSDrNPmnEbTH5z3nfAi
         euVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754315115; x=1754919915;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lVxfLjqZpUxA7k2P1DVAmCagXBwL2u2PCEjKY9dcPbA=;
        b=wbe3jc3GlL9XV4+t1gD1OwxW2xoRV0HZA4balBD/VGxEOGHeF6k9S5N/Jr1igdXusM
         c7QzVJqGPVRQasTRHMNLaO0ssZoxQMHD3MGrknkkujs6GkvZkVHN1xZL/3YfzOoK53sQ
         X9a8Qrcsx/+kZZsZ65UszcfszYsz2QGfn0t7B/rud8OSAx8lHOPmYtwf3fdLIvKMXywt
         zYX7MhaB5XWLaUbSTgKYdgomMzq0bLWNZqxCq+SfEQLOxG00zyGvWiKhUi29dRQ56uRS
         pWUyvk8TxusCLUn8+ZqgNMnVtaXyVaprMO1TBsjeibiD9iZ777gbI7ICWWVOLcNLVfZH
         iScQ==
X-Forwarded-Encrypted: i=1; AJvYcCXzxiWTCFSFhu1QZNKnazndOUY7Xbd+MxzI0t7u+xeG7pMEvJVaOxD8Tw9U6lCJH5WMg4W43gtGZ9ovfrY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxsu2Om4hKtfVzIdamLMcCD/waj3WB3EmW3HwAp/WOkaBjXSVlK
	ZzhaExvVBtMZr2hqmqS/Pqxfgab49eLxjAh7aqBrMdQemHBBSNK6FuQhARpWjKwCUdsXYFf6/AB
	zNTzMXKkGEnc7oHRCwHdCJ3bYTn21zB6+MgNP/5Pk
X-Gm-Gg: ASbGncu+xmiTTzrNCWLdF0I+e8rXV+ec7gA3/m9LiRxOOwUEzCoSH70eVvYDG8Oj8rL
	AuEx8m/w1ehQlx78RU1EpcUS+MIzlc6x7u7Krz4pkU77qt9uyOTWWZ6llLt3T1IoddHuA85d669
	zcOBOWLjDot25CStBe6WougX6uFb5HyhmPA5fGE/GQW3ShZ7w+Tg/yHUr45yAAyEtDwsD5uFvKd
	oCmRbm//fMQeocxEyyaPJrfF9K9yNN+1gr9bnQisnPLDc8=
X-Google-Smtp-Source: AGHT+IFaotM+JyQ2Vpzm4IHwFj1sDugJTvhpJmHMDtD0C27FQSVnxByFTiRHFKX89CZ7UXKQfqoZ8hHgvXXbgq0byS8=
X-Received: by 2002:a05:600c:4692:b0:456:1a69:94fa with SMTP id
 5b1f17b1804b1-458b69dd831mr67244495e9.13.1754315114601; Mon, 04 Aug 2025
 06:45:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250731154919.4132-1-dakr@kernel.org> <20250731154919.4132-3-dakr@kernel.org>
 <aIyGdr8vKV4XE6Io@google.com> <DBQZHIS4VQBN.WSKBML2WYQE@kernel.org>
In-Reply-To: <DBQZHIS4VQBN.WSKBML2WYQE@kernel.org>
From: Alice Ryhl <aliceryhl@google.com>
Date: Mon, 4 Aug 2025 15:44:59 +0200
X-Gm-Features: Ac12FXwUx656MFEW5kmkNucJ1NlP5WVIBqML9iOkHHqR2MZNAaCDmASPCCRrZcU
Message-ID: <CAH5fLgi6W0g1mp6EyR16ayk_JT8pYJUUZbWXc-hyNxSxU_VeNQ@mail.gmail.com>
Subject: Re: [PATCH 2/4] rust: drm: ensure kmalloc() compatible Layout
To: Danilo Krummrich <dakr@kernel.org>
Cc: lorenzo.stoakes@oracle.com, vbabka@suse.cz, Liam.Howlett@oracle.com, 
	urezki@gmail.com, ojeda@kernel.org, alex.gaynor@gmail.com, 
	boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, 
	lossin@kernel.org, a.hindborg@kernel.org, tmgross@umich.edu, 
	maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de, 
	airlied@gmail.com, simona@ffwll.ch, rust-for-linux@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 1, 2025 at 11:29=E2=80=AFAM Danilo Krummrich <dakr@kernel.org> =
wrote:
>
> On Fri Aug 1, 2025 at 11:18 AM CEST, Alice Ryhl wrote:
> > On Thu, Jul 31, 2025 at 05:48:07PM +0200, Danilo Krummrich wrote:
> >> drm::Device is allocated through __drm_dev_alloc() (which uses
> >> kmalloc()) and the driver private data, <T as drm::Driver>::Data, is
> >> initialized in-place.
> >>
> >> Due to the order of fields in drm::Device
> >>
> >>   pub struct Device<T: drm::Driver> {
> >>      dev: Opaque<bindings::drm_device>,
> >>      data: T::Data,
> >>   }
> >
> > I'm not convinced this patch is right.
> >
> > Imagine this scenario: T::Data has size and alignment both equal to 16,
> > and lets say that drm_device has a size that is a multiple of 8 but not
> > 16 such as 72. In that case, you will allocate 72+16=3D88 bytes for
> > Device, but actually the size of Device is 96 because there is 8 bytes
> > of padding between dev and data.
>
> Are you saying that there is an issue with
>
>   (1) the existing implementation with uses mem::size_of::<Self>() or
>
>   (2) the proper one that uses Kmalloc::aligned_layout(Layout::new::<Self=
>())?
>
> I think neither has, because we're not allocating
> size_of::<Opaque<bindings::drm_device>>() + size_of::<T::Data>() as you s=
eem to
> assume above, but size_of::<Device<T>>().

Yes, you're right. I misunderstood how __drm_dev_alloc works.

Alice

