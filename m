Return-Path: <linux-kernel+bounces-769160-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C12F3B26AD3
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 17:25:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D97741BC2C45
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 15:20:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB6E7221DA3;
	Thu, 14 Aug 2025 15:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="cO3aaJg+"
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7DAC21CA1E
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 15:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755184785; cv=none; b=G+qNzQD0juCfvBRk/A9ZxDtaOe4jjUA6l3R+QOEFIxiMv7EjauuUUqMsTcG8l9FINAND3COFKOGsY/Agpc5X8WzEcDp1m+9dhdSKu34VLV0glZWSoJryj+Ut1KQ2/QWSko4q49dbD2EFR4Llmq4vHa+9KaaJNESJepYxQJOXto8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755184785; c=relaxed/simple;
	bh=1aU9Fc2hnGJ7q3vxrXZn0TdZMRj1SgPzOxTn6GYad6A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B9jb0WY1Af8xdRbMufKTBIB/XDJJJLRXcgXfIIKmoGEOXJ/vQ5l4oauc2V3Un+ErZYVHtqDSYQTgTlMzCLNH+Yab1TUx4J9A4DsoOQ3/Gw7OabpEYyjphBKroCSPLBd+Vp3K0dNqd0jnXuRJq/g9iNIsb33vz1PqRXE7mWWkUnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=cO3aaJg+; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-b4716fb798dso654267a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 08:19:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1755184783; x=1755789583; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=20H1bX4SpHlHB/4n1zlWbsrFeE3+kzUJdvfUi51WrVs=;
        b=cO3aaJg+D5WvHXZxcUw6WR4/PCqN6/ZkwlI6RaRt/Rd6juinuCrDOpDDiYetM67QDF
         lvUWVo9pLFE6F+CcxejYY34BNU+VEmngy70/n7dI+uVGLPnxxyNtGhfCakPAh1MdMNRk
         VcNe+An/DlupHnOdN64B8pHd9mKgl9+AWqd/c3BR8a3wZi4d9YWNOpCSCqqz7//Q/3ME
         w/KrjoTBQ9IricBPCQpfXNFIEY2YGtjawjVjlRqoV4CltJTBgwJZ3a05norIbGIBCCb7
         LVus6Pu8ovTCEx7KYIYn2CNQmkNXsHejmZSHRq3qzSF27nv6ZPp3PR7KTqyQ6L3ZHgkL
         Xd1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755184783; x=1755789583;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=20H1bX4SpHlHB/4n1zlWbsrFeE3+kzUJdvfUi51WrVs=;
        b=PhZ8zmZxUfosPoIRuVvMKdFwbUG95QMknh0D54+DATSp6oUON5Jw3+49Bbzv9K4fkF
         wngKjYIB1WIfEjRyKd8x/pK3tCHZZ58foFfHjavQ7qXUfz6QUu9EskuJ5KL66J8gb2yE
         8Hj08JJbMfEyru8ybiIHyGdCY7bnODWF0DJu98XZzujKiwHcgYaIQ71aEHdcduGYK8Dx
         CKrAUQjgdMFegO7yXazjDyeld1El6qkdORnwjkS5E5baCts3Y95CtvCULX0uiwV45DY2
         AddBpReuY7R+dQSFgSq/U5VuvlovsAW6sf2L1JJOtM/IN6xlisdzEBZwG6+YLEeeDvnN
         imBg==
X-Forwarded-Encrypted: i=1; AJvYcCWKABc1YBTRCJXzWozcefGk6ukzR4FeBz02CAOlHwiIL4jducmCM8qGiHEF+zxZWiIe850L5Nf5+X/SVhg=@vger.kernel.org
X-Gm-Message-State: AOJu0YycJktLVsd3DwhyzyatRF2xLqvDqVotGd4U/KWMZvU5pWCmArjF
	CMmU2NJa92ozqR8moxEjaonFH630hl9f+bYwA7wVF0oJEc1Kb4XLfGiBLfuJnI6Icb9olR6u50x
	Q6Pf6bmNjdQ8HhLhrcI67Hv2nqCVGnjZ1twCryCAD
X-Gm-Gg: ASbGncte66AXJdJhKoSl09RySfzqv5F1772C+rpugpBv1s+JBgC+uUp6eWZm9sas9Uk
	McFGuQ91heU4wW7on3FutVNmcK54Isy93kU5cFQ2Ulclhwu8Qx/Kswz8nxrYfIB8yXYyhGQnOmf
	nUPzELy1AvL4BpBuHbr9geEuvnZ/VCjFmbwwguzOOaPF717Zr4SXfJV/uTYZLjZmYknyKRXa1p9
	w6Y2Rk=
X-Google-Smtp-Source: AGHT+IFj2nuw4OO0aHub04IY1bUUEIXMLpj8BpAPXS/WeiKdAX2g9e2Cm74izpij3E8Z0pJYOO+KflfoZ3I3eW+o1dw=
X-Received: by 2002:a17:902:f550:b0:234:c8f6:1afb with SMTP id
 d9443c01a7336-24458868a2cmr48666085ad.0.1755184782770; Thu, 14 Aug 2025
 08:19:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250814093046.2071971-1-lossin@kernel.org> <20250814093046.2071971-8-lossin@kernel.org>
In-Reply-To: <20250814093046.2071971-8-lossin@kernel.org>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 14 Aug 2025 11:19:31 -0400
X-Gm-Features: Ac12FXxDyG0PFgKScv9MjLNEC8CCg0DXSw1W94x7lFL8PxoeSTQQVlHWfNxxHrs
Message-ID: <CAHC9VhQXOezJ2=B1BQOqLgfuzDJEVS5G_r9+_bQ+OUNTpjZCKw@mail.gmail.com>
Subject: Re: [PATCH v3 07/11] rust: security: replace `core::mem::zeroed` with `pin_init::zeroed`
To: Benno Lossin <lossin@kernel.org>, Alice Ryhl <aliceryhl@google.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Fiona Behrens <me@kloenk.dev>, Jocelyn Falempe <jfalempe@redhat.com>, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 14, 2025 at 5:31=E2=80=AFAM Benno Lossin <lossin@kernel.org> wr=
ote:
>
> All types in `bindings` implement `Zeroable` if they can, so use
> `pin_init::zeroed` instead of relying on `unsafe` code.
>
> If this ends up not compiling in the future, something in bindgen or on
> the C side changed and is most likely incorrect.
>
> Signed-off-by: Benno Lossin <lossin@kernel.org>
> ---
>  rust/kernel/security.rs | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

I'm happy to take this via the LSM tree, but it would be nice to see a
Reviewed-by/Acked-by from someone with a better understanding of Rust
:)

Alice, you've reviewed/submitted LSM rust bits in the past, can you
look at this?

> diff --git a/rust/kernel/security.rs b/rust/kernel/security.rs
> index 0c63e9e7e564..11a6493525f3 100644
> --- a/rust/kernel/security.rs
> +++ b/rust/kernel/security.rs
> @@ -25,8 +25,7 @@ impl SecurityCtx {
>      /// Get the security context given its id.
>      #[inline]
>      pub fn from_secid(secid: u32) -> Result<Self> {
> -        // SAFETY: `struct lsm_context` can be initialized to all zeros.
> -        let mut ctx: bindings::lsm_context =3D unsafe { core::mem::zeroe=
d() };
> +        let mut ctx: bindings::lsm_context =3D pin_init::zeroed();
>
>          // SAFETY: Just a C FFI call. The pointer is valid for writes.
>          to_result(unsafe { bindings::security_secid_to_secctx(secid, &mu=
t ctx) })?;
> --
> 2.50.1

--=20
paul-moore.com

