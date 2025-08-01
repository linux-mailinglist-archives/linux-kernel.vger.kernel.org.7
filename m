Return-Path: <linux-kernel+bounces-753598-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D4D7B18515
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 17:36:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC75CA84EFA
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 15:36:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BDF1271469;
	Fri,  1 Aug 2025 15:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NeTbiJYP"
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80A1726CE06;
	Fri,  1 Aug 2025 15:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754062572; cv=none; b=FxItkQ6hl4xSU0nU/Uujec9tD+o9Jrftdz6oYDyYJ/ihMvOa5+ab0jOhuN/mNvV3gJcjGfIIgcuY5uIGgR5tEP/Ih7BLi5ytmzA6Jrz9J7Xq0YpwJ+zLVBQBmMvyMgx2F1IirecXM74k5YYj6V14snp6UMtP6rWjaXSbBPdBQlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754062572; c=relaxed/simple;
	bh=aZQwspZkYDsMYZ9F9Yy7SFi+A0vpDpdUoNJSp+qMEdY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ixYEcATAdqPQDjOLIAagCQeV9Lwv4tvmPiX9PK46q25oLSqlsVQp1cVQvOcTomK2Xh0bjGI68v+ct3xv6xGm8Bf4xy4nOwixa9sowmCpGrY6MMaaNoU/zoIE7ly12Ut5/2ftCG2pxsr7VvnWI1C61ACcFH4LrnS5Y3WmJtwt9QA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NeTbiJYP; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-b38fdac002bso240377a12.0;
        Fri, 01 Aug 2025 08:36:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754062570; x=1754667370; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aZQwspZkYDsMYZ9F9Yy7SFi+A0vpDpdUoNJSp+qMEdY=;
        b=NeTbiJYPSDkZ0waKeOiBPRkRYys0B/NaBR/nQq7VRtc17Tn40ZCjgDGVmGUvKCnENo
         +gLJ/05zgC+kFPFP5SMOyGOEW4goNxXImFTUN3X4SKkpcAQcFcg1vlwj4z50eTgoEdDa
         J7Qzsz/p5kUUaF+beITC+jxoyB1IBUQTVmuYIBtUp7U+Cd0YsaI0owNcyN3FrMmLzW/F
         agcPEhjxRIpd7xARWUEj4s3y4z9PKO+22F2MEyceQ0Lea3lQepOt+fAe5h4CYO3Xr1pw
         F01f9RJd+y04Zi7K/mkbxZ2YmADyf2YiMkY92AzK9a1xU+ELd7tM9usQ4enVL9Arz10u
         kxlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754062570; x=1754667370;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aZQwspZkYDsMYZ9F9Yy7SFi+A0vpDpdUoNJSp+qMEdY=;
        b=lnJ/GFufdOCNAMKoMamXeqRSC4sRQ9YgKhMoVFXDgKlL09Gqzka0GcspfOr/ZJlFqu
         uMwO4pEiGEyvjMNyAX1OO3hXt/thN82l+vpZL7/cbSbd4waazsRrK3FweGoslbZ31P8p
         YGSg051E2iE5Jo6VGF/HFs6CuE/5qX/57ENZORLlI+wzSmsyke8TzLRHWNMlz/cVMgcG
         8YEhjos8xT2mJy9Q1vd5kaOakBSWTrjlrIM7t80wJF9zur3J96kbeepbduZ6SyLHIHSy
         SyFTH2FDqWQq48OKA7ILbaGY+dxmvWlv70OVqB746OFUSEg37w9FlSkgXJgQvqvsjN8q
         fwcQ==
X-Forwarded-Encrypted: i=1; AJvYcCV1JiObnBXBIGZN4CfEZ6ck1WaVsxaFxYBXOdeBbxDcR6zvq7z/9H5iZ62veTnViL8pHlH9sa4vJHhwQSz97p0=@vger.kernel.org, AJvYcCWaHehbmeLwbX7QimYvoXeXbC3PWf4GhjJhfTmoqLJPno2S+ttEa/X2dee7RN5sguTApVItVG+fN4JEp/g=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFs7YZkFlPYCm9Kfp6VjACZkajPmfF3b9zSLTJnzf7fawrDwno
	31GjEb+saQuGx1aZi+TtK50Ias4rAhdX7672jYA3oqzPK9lT+s0UHvuZw0DOnt8bZ2Fy1lez5Zt
	3VM8AjAYkTdAd0CwI+IWWup5mYBZgzOg=
X-Gm-Gg: ASbGnctN1nnWAQk4wwtLRNXmbEWdXd0l9uPJhf+bGh7ST/0wZbU72WS5OTLbx4abwQT
	D5pVpRFDLK2wpbZt+/q/e7GX2nLNLjO5Rjx582GdIdR0HkWx0S61GMIe2DL6oAFoLm9sFBwOO4/
	TnXgeSt8yRQuIsls0XsHwEJEgg3s8jRLva9Hg7WjFAnozYuak+kZQXzNR+L5ixyWkenIuTkeNLM
	+MdhLrN
X-Google-Smtp-Source: AGHT+IEejn7+Ub0GRMZe2KS2o3Avdid2AwRwDRKfrybwb6UtyYJLJk5yJHEpnyBS4UgGIvTJFtAn9Y3saj4i/iSs81M=
X-Received: by 2002:a17:90b:1c03:b0:311:a314:c2c9 with SMTP id
 98e67ed59e1d1-321161e2197mr137642a91.1.1754062569787; Fri, 01 Aug 2025
 08:36:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250624042802.105623-1-christiansantoslima21@gmail.com> <DBR3913BFPSK.18K4JBYOPQVRG@nvidia.com>
In-Reply-To: <DBR3913BFPSK.18K4JBYOPQVRG@nvidia.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 1 Aug 2025 17:35:57 +0200
X-Gm-Features: Ac12FXxC69kafbGgVSNnodv16N9ncoi3UbZB8MkI2F19sB87rpeIcrxjT3vU6sQ
Message-ID: <CANiq72kOLYR2A95o0ji2mDmEqOKh9e9_60zZKmgF=vZmsW6DRg@mail.gmail.com>
Subject: Re: [PATCH v8] rust: transmute: Add methods for FromBytes trait
To: Alexandre Courbot <acourbot@nvidia.com>
Cc: "Christian S. Lima" <christiansantoslima21@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, ~lkcamp/patches@lists.sr.ht, 
	richard120310@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 1, 2025 at 3:22=E2=80=AFPM Alexandre Courbot <acourbot@nvidia.c=
om> wrote:
>
> Another small nit: this is not a macro, so you don't need to use the
> `::` prefix here. Actually even `size_of::<T>()` seems to work.

Yeah, it works because Rust 1.80 moved it into the prelude. However,
we still have to support 1.78.

What we can do is adding it into our prelude meanwhile.

Cheers,
Miguel

