Return-Path: <linux-kernel+bounces-789392-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3875CB394D0
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 09:14:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D67AE3AFBD2
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 07:14:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84F162D640F;
	Thu, 28 Aug 2025 07:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hnbCebaW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE97E2D46C0;
	Thu, 28 Aug 2025 07:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756365261; cv=none; b=DCkfAFozAtyaY5OOb8gs914Ymqo9zHpK4El2b/TYYoRxR0Q1+LWlDVbpv/nytlB/yxt111RhbyaxGw+rJv4RBASy3jtHcmkIHJSKTAlfIw/8KNfoPkfFbayjVO50FCfYO+Vp6UyStepHhU0NWQ20TQF/3ljAV9f8Xs8TqzLniLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756365261; c=relaxed/simple;
	bh=y2E6jAgZ1n8UgRxjbTT0G+yEp9u8bfmkdgducgSp1d0=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=RFdgHWFrn56gq9JPv6LZWFWnNKsZWMLhTWKKm1xM2HHg/pCkHbdOa2z6NYyRkYycWWa9WH1zvh5MBXOfxuWEHAd5NPLNm1tQ8nRSMIDhuky5oQWQXLEoW3msO/Y6DMTO9D+c7hImylUns7JOjB+FCKPdy6AuKsLrE27WRK0YY5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hnbCebaW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC691C4CEEB;
	Thu, 28 Aug 2025 07:14:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756365259;
	bh=y2E6jAgZ1n8UgRxjbTT0G+yEp9u8bfmkdgducgSp1d0=;
	h=Date:To:Cc:Subject:From:References:In-Reply-To:From;
	b=hnbCebaW+/ZLccWHgtmbMBfUty5cPnUOU61XOUviSlYcgKcJWP2w5mPHSKuR8506E
	 L7/GFGB7h1F5DvmwfHGHiGnMWwDvjXQ//Skzo75bYoAT+I7TFxP5y/M/p9P6pK4una
	 PZf86pEZZZIbrkZB5V32KUrREe4/8VLl6MisvX7/CYjkbJjTfyOBR3glAYCuChBSsn
	 N6fbUSv9iz+Z+FVi/ahE+E5o7L2wfZMq1VGByHcKCzQ2LvtK07YsjucUtj7/wAAJSw
	 /+qzg+v4+1FL0QtPe/SF3UexJjGjcdAi3bysML6W7q3q2n8bp1eZeVAEaFIWaGlnqv
	 Pl+ItArZnHVDw==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 28 Aug 2025 09:14:14 +0200
Message-Id: <DCDVIR91LFHQ.1C87G5A0OBJ39@kernel.org>
To: "Alice Ryhl" <aliceryhl@google.com>, "Jesung Yang" <y.j3ms.n@gmail.com>
Cc: "Miguel Ojeda" <ojeda@kernel.org>, "Alex Gaynor"
 <alex.gaynor@gmail.com>, "Boqun Feng" <boqun.feng@gmail.com>, "Gary Guo"
 <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Andreas Hindborg" <a.hindborg@kernel.org>,
 "Trevor Gross" <tmgross@umich.edu>, "Danilo Krummrich" <dakr@kernel.org>,
 "Alexandre Courbot" <acourbot@nvidia.com>, <linux-kernel@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>, <nouveau@lists.freedesktop.org>
Subject: Re: [PATCH v2 2/5] rust: macros: extend custom `quote!()` macro
From: "Benno Lossin" <lossin@kernel.org>
X-Mailer: aerc 0.20.1
References: <cover.1755235180.git.y.j3ms.n@gmail.com>
 <948a28f26a0e9924d82eb1d8d377e3ddc7335b24.1755235180.git.y.j3ms.n@gmail.com> <CAH5fLgjyd7zNqLFT4T0_=tzcPFyw9xwZX+QTA8ShBxZ_Fa6o6Q@mail.gmail.com>
In-Reply-To: <CAH5fLgjyd7zNqLFT4T0_=tzcPFyw9xwZX+QTA8ShBxZ_Fa6o6Q@mail.gmail.com>

On Thu Aug 28, 2025 at 8:39 AM CEST, Alice Ryhl wrote:
> On Fri, Aug 15, 2025 at 7:32=E2=80=AFAM Jesung Yang <y.j3ms.n@gmail.com> =
wrote:
>> +    (@proc $v:ident $span:ident =3D=3D $($tt:tt)*) =3D> {
>> +        $v.push(::proc_macro::TokenTree::Punct(
>> +                ::proc_macro::Punct::new('=3D', ::proc_macro::Spacing::=
Joint)
>> +        ));
>> +        $v.push(::proc_macro::TokenTree::Punct(
>> +                ::proc_macro::Punct::new('=3D', ::proc_macro::Spacing::=
Alone)
>> +        ));
>> +        quote_spanned!(@proc $v $span $($tt)*);
>
> Not a blocker, but if the way to implement this one is to push =3D
> twice, then I think the pattern should just be a single =3D and then you
> push a =3D once. The pattern can match twice to handle =3D=3D.

You can't do that, since the first one needs the `Joint` spacing and the
second one the `Alone` one. `=3D=3D` also is a single token in macro input,
so matching only on `=3D` doesn't work.

---
Cheers,
Benno

