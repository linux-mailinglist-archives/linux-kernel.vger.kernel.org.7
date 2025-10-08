Return-Path: <linux-kernel+bounces-845555-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 582D2BC55A8
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 16:05:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 04D8334ED22
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 14:05:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE0A728C03D;
	Wed,  8 Oct 2025 14:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AoRYueJ4"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C167289E0B
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 14:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759932321; cv=none; b=Bp8VQHuhPe57k2ompN7RoRXGHkCNZqyCGi2t/76CEVp9xsU8cePZ4JA1ZienDZvDQvZx979OnZwT+/VXpMfVIYfuoaqynNykxLZiVWfHmQM4VOk0R+AG66VsKSpA95txfVR9dkEQBIs1DIM1sJHtWO3dQkZbDHrdRlZFgzf8C9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759932321; c=relaxed/simple;
	bh=F6IH1UUuRkcLE+CnqnTRKITctuOhDmCi+4zdK2zYidU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TZQ+ZNbCfiheeFihxMYcyV4xsyXtmBB8u2EvnzugppRIxCNxX+MdEDuh+BhJdCTTNox+RqtYNsbBDEn0kf2WBtmqqRsLe6QhOVEllNl8IvgWrNxA7OWeiRM5QCC0qMlK30To8n64rb5vFukhBVZ2qsubfrgcdPaYneKEcCr9cNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AoRYueJ4; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3ee1381b835so6312701f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 07:05:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759932318; x=1760537118; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pnFNM1hwuEwchUfhEuJaKySc2Ut3Y6Tp66F6XTEbLGo=;
        b=AoRYueJ48bVEgyGD/n88L6PvDQPhPAgKdqeMBxQFhW1vqdui2yif0lOOKRxdSYwZEY
         Gh2un4XkJPfhauj/qoPcgUS2bz9n6foRhy1VG0JDDlL1Kqg08MCcCqjXinoH/M/EdvPb
         KJvaufESPITN6mbI0M8rm9QkVtLtbX+GjAfqdgMQUG/ygBA3vlZCiXrYqWPP4IIr1ikS
         7ptZOAV1q/yD/7VAgfbDLwte6aUtudgbCe/wofqDzxsdWRdAC9hQ/EBi95TZGlaTqtBq
         STNzGfr1ZmgkUE/p+dNeMWq65JWEVDV6To95sAKmI9h4NtsBukkqDMK8YU6UopT5hGye
         8XLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759932318; x=1760537118;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pnFNM1hwuEwchUfhEuJaKySc2Ut3Y6Tp66F6XTEbLGo=;
        b=WAcb293mPE242kSf3fjzNl3svPmxwOw6eipdZcEnOeS5mt+f3EzewiE4iTTu2TTLVC
         NkWffBpi4Q09NhXrivaDcQHczPhjRKqtFGgd1YQq5iX1tFikl2kRmUjnRatr4y0T4FyI
         cUtQqtm3zNY4baCYWuzndmqKumn86vcteMCdSbcol9wtInjsNEO5bUFTKPblQ+RkQL2L
         mf2zQtCIhLEqRzOJotYbwvd8GEIzpATrRFY53pTRqMK0k0PYRn3EYTu3mDSjskl3gidU
         E0V8kvQSaorBTnDWwatLQm9nLTUfVtQjA2NuXYoH8KlbOd/roxmgAB/fjnuhiukKdUbi
         pmSA==
X-Forwarded-Encrypted: i=1; AJvYcCUULqJo7JctX366koc/n2G31i07LxdQmf+N8vpJyVCAp3ZX8DxBH9wlzHSA+sdrUMqmz4oKODqUFczwAU0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxZOoSqGL5sA2/S9auyogkkK1IyEBaDxCbyqj7+nvD/9s9DuFT
	ERwh869h0Q9xbs8ZGhuT44WKGUwipEzTn9a7x5LBIBGCojLPWXRDdgmTXzxrXNx5MtU800VXugL
	S27uJDpQCkrKJahIHCEyV0dYKyzBeOlzZUzOxV8HY
X-Gm-Gg: ASbGncvbWOXCkN/Kg2JHRRIkVgXsGjrmANAU9MRdtEwmKrFi+wgbJpalHD1NS2qBZUo
	jeYaS74lgotRjIpILL5bcC2ZihhhqjB718G7OQQSGS9iFr4oeMrm3d6iVA/919e7YJzCH24unp5
	7199FoB8gdvXxSUEPsslj7Trp2TLK8F7nqgKYItklRCUsoR016nTG866OT1RYZlXVKvEbexbkWh
	bEZZkULmDVYJK9ir+DejdIQveisyawkjJgE0Ybcbnjlm6zl7om5V7dwvpP0ixWoDNA=
X-Google-Smtp-Source: AGHT+IEtL1VUjwteFF0aUMusK9O6vaSfUkvwFkxXShRQV/K9msyLkRj+XdqkEBNkBGqLRAXp1DSu3/HCWH6QZ7gPJbw=
X-Received: by 2002:a05:6000:2c0d:b0:3ec:df2b:14e2 with SMTP id
 ffacd0b85a97d-4267260e143mr2316476f8f.51.1759932317676; Wed, 08 Oct 2025
 07:05:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251008124619.3160-1-work@onurozkan.dev> <20251008124619.3160-3-work@onurozkan.dev>
 <aOZhS9nTDnH3Zh7N@google.com> <aOZpwUD50MwSBycB@casper.infradead.org>
In-Reply-To: <aOZpwUD50MwSBycB@casper.infradead.org>
From: Alice Ryhl <aliceryhl@google.com>
Date: Wed, 8 Oct 2025 16:05:05 +0200
X-Gm-Features: AS18NWCZJ-_06NHTt-9pvac60ma3Z_7vD0cIto5b6ZZ5rLx2-etkF4_odDy_JZs
Message-ID: <CAH5fLghoDEKnpq6WaD3zzV9UHm6gYzYXCOG_Q=pOUomcNcQhPg@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] rust: xarray: abstract `xa_alloc`
To: Matthew Wilcox <willy@infradead.org>
Cc: =?UTF-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
	rust-for-linux@vger.kernel.org, ojeda@kernel.org, alex.gaynor@gmail.com, 
	boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, 
	lossin@kernel.org, tmgross@umich.edu, dakr@kernel.org, 
	linux-kernel@vger.kernel.org, acourbot@nvidia.com, airlied@gmail.com, 
	simona@ffwll.ch, maarten.lankhorst@linux.intel.com, mripard@kernel.org, 
	tzimmermann@suse.de, corbet@lwn.net, lyude@redhat.com, 
	linux-doc@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 8, 2025 at 3:40=E2=80=AFPM Matthew Wilcox <willy@infradead.org>=
 wrote:
>
> On Wed, Oct 08, 2025 at 01:04:11PM +0000, Alice Ryhl wrote:
> > > +        limit: Range<u32>,
> >
> > The Range type is inclusive/exclusive but xa_limit is
> > inclusive/inclusive. They should match to avoid confusion.
>
> ... and xa_limit is inclusive at the top end to be sure that we can
> actually allocate 2^32-1.  Or does Range handle that by using 0 to mean
> that 2^32-1 is allowed?

Rust has multiple range types for inclusive and exclusive cases. The
Range type is usually used for indexing arrays where the length fits
in the integer type. To include 2^32-1, you have to use RangeInclusive
instead of Range. It should be possible to write code that handles all
of the range types without repetition.

Alice

