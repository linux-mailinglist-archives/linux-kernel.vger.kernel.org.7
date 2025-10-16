Return-Path: <linux-kernel+bounces-856791-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65F58BE5171
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 20:45:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 205A2584238
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 18:45:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9A6323D2B4;
	Thu, 16 Oct 2025 18:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TtH9HYM5"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8B1523ABB9
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 18:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760640306; cv=none; b=QJg59c4NjuUyYYfNixvHygShfAk4MhS9MvfywiiECM5hPUZ0ogW+aEIg/Ou8CbzGbM9uaCWWxBiOUhRJ9WVP3t+cAjN9AX17So6mKHmxac/Yng9aLEGqUeHv5rL+A+FfKi9bEF07U2cGxk5iIUpEvXelPtawJBUaHmjAr+RS8Ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760640306; c=relaxed/simple;
	bh=MVvmC7MY2M1TL7VrB7aCmsPWhi1lCkdO2TRKjAq+FoM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VDz4m1h8ughhgR3K+jkmTIv/PSxcTXBw3wOhvNuWagsYs8PbC55df6LSv0Qx31FZwdoOKxSKtfRRVrGSb2Nxk7dmnm9R9T0Ld2054xfa1N9A4FIKoIFLdtwrdyTZXE5+JtUR/mIFJCesgSKjRJktE4wQXlXcuav9ABW/OcDwnN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TtH9HYM5; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-290a38a2fe4so1158875ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 11:45:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760640304; x=1761245104; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FPl4GNeEvYNsD07xkIxR49GzR8yYXDLG1l9YclgP27g=;
        b=TtH9HYM5a4FUeYoXz+SZqe6MYw3kP3BExPqNjklDmC5IaRgZkKr3RXBb9m0tLrjdxe
         q3Lw9cEF2ZNlNJyi8MGtsfvkeg1dQTgunkaxgXnpLA72lFMrcx2du2N3rNQxFwl0T7i9
         Iylq8ZvQHDBO2BwA+rzs/COHIDMbwi40e0w54NDQrSMyPmeJsQTgVgj2XVagAlXdgnQ4
         4xWCLqxVoT9lJi38TMDHIzQ2MWo/udIMntFZM2/73asVgwGmvi1uuCgvGNF+jt0r6tFC
         WtvByxqZallAeHHGWLwiv7/vHLHMiUAhHiaphgcUKFVSI4HnGz2dshh+K9kKdaaXC5fN
         UQ7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760640304; x=1761245104;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FPl4GNeEvYNsD07xkIxR49GzR8yYXDLG1l9YclgP27g=;
        b=q/mzSfUdt5iFp81teg9sLJUehv+WKNxKt6VS2Vps9nRS6EARb79P6yKihFwcsYRZyM
         I+bO0e67V5v35QV9Xzbx0mTIoNwdR37DxuNaJZjy9PRGxEgDSp94ysCIAJ7/mw1N5uq2
         eocGpL9d0TH3rQX5+HOYt7mSextPN/RfG42Fu9yxXX/QTpxz5psRjMRtnFcJ15WAj7xC
         /HhuFekj2AANFh6RPjpRxswQITJGRROo7DqC0dUozCe+AilMLQBq0QoFETxe6dYaSxaB
         +K+89taJW6b9C1pcNTGZj9gmvcWvZ7OUEc0J2/npxUlhMRA71G0cSmq4x7qi0S+fr5Ev
         8KkQ==
X-Forwarded-Encrypted: i=1; AJvYcCUgswvxag0vm6EaJDxeu22cYjoNDejlH0g2+wrT5AFECmHFkvSYaEOiWWM3d45b1uxw8pyz5Lc1NbGQ8/c=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFg6NpiJ62c7IaaOi9ssSwc00gzPKt3h0BrMFFWvgh/X551b5f
	Gp85uf75uZhQ/yQUEWrn+kQ3iS8S2z4Qv9dnFpDDGen58O8L3qF0XB5wwMvXITcD7j6ROYRAtqj
	vhw7qvpZLj3ki1Mnd5pfEe9nFI8dh0q4=
X-Gm-Gg: ASbGncsveQPFtf+sedPMGIEKoqyeaXPZQSuO5W3HeplaRJBlnpZPoERcA5Rda9hdoQh
	SSg5kVpXXS8tCsdcbDf8N3DW8NehKIqaWFA7dDh4jGAfchj3M/M/JeEkxM/3mO5R6sDWohfroYn
	N60e2Om8LuWKevxdr5/VFYcXWp60YWGzkFBGi1klM585U0V5PVdrKVbiBf5Jn65WbgeGxFnBGez
	qqXKe+fNNRpKXhsNpNRllKKeukAsRvvhVaGukdXIERPB/Tm7ASj+29IzcfALBL5Fmxqlobj5Va4
	Bx4dKRKsn8pB/u1ackB1eXBaorvCZqbxBCl3KwprrgrM+jqa+8hh4S4lYShDxWx7VB6LnosAZPk
	aiuA=
X-Google-Smtp-Source: AGHT+IF9I6SSPaZXt6fObKsCwr8z4pX/yL7H2Swh89Pd5qRMIU65WohMKqiraRMDzUotqhTJ9xFy0vEvU+nF48HX4/Y=
X-Received: by 2002:a17:903:2f87:b0:290:af0d:9381 with SMTP id
 d9443c01a7336-290cba4effcmr5451435ad.7.1760640303984; Thu, 16 Oct 2025
 11:45:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251013062041.1639529-1-apopple@nvidia.com> <20251013062041.1639529-8-apopple@nvidia.com>
In-Reply-To: <20251013062041.1639529-8-apopple@nvidia.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 16 Oct 2025 20:44:50 +0200
X-Gm-Features: AS18NWCjsMPV451tdiawVF8gJgOdhZslUWuxkRt4tznLBhQSO2tbezIdx1gta_0
Message-ID: <CANiq72kK4pG=O35NwxPNoTO17oRcg1yfGcvr3==Fi4edr+sfmw@mail.gmail.com>
Subject: Re: [PATCH v5 07/14] gpu: nova-core: gsp: Add GSP command queue handling
To: Alistair Popple <apopple@nvidia.com>
Cc: rust-for-linux@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	dakr@kernel.org, acourbot@nvidia.com, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, John Hubbard <jhubbard@nvidia.com>, 
	Joel Fernandes <joelagnelf@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, linux-kernel@vger.kernel.org, 
	nouveau@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 13, 2025 at 8:21=E2=80=AFAM Alistair Popple <apopple@nvidia.com=
> wrote:
>
> -rust_allowed_features :=3D asm_const,asm_goto,arbitrary_self_types,lint_=
reasons,offset_of_nested,raw_ref_op,used_with_arg
> +rust_allowed_features :=3D asm_const,asm_goto,arbitrary_self_types,lint_=
reasons,offset_of_nested,raw_ref_op,used_with_arg,slice_flatten

This is not sorted, and it is not mentioned in the comment right above
it -- in general, please try to clearly mention this sort of addition
in the commit message too.

As Alexandre mentions, it will not work to use it as-is. However, what
happened in 1.80 was just a rename, but the feature was available
since 1.67 as `flatten`.

If you want to still use it through an indirection or similar, then
please move it to a new commit that explains the addition of the
feature and the indirection to use it.

See e.g. the `file()` function I added in e.g. rust/macros/helpers.rs
in commit 36174d16f3ec ("rust: kunit: support KUnit-mapped `assert!`
macros in `#[test]`s") to see how to set it up.

Essentially it is:

    config RUSTC_HAS_SPAN_FILE
           def_bool RUSTC_VERSION >=3D 108800

And then:

    pub(crate) fn file() -> String {
        #[cfg(not(CONFIG_RUSTC_HAS_SPAN_FILE))]
        {
            ...
        }

        #[cfg(CONFIG_RUSTC_HAS_SPAN_FILE)]
        #[allow(clippy::incompatible_msrv)]
        {
            ...
        }
    }

I hope that helps.

Thanks!

Cheers,
Miguel

