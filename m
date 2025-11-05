Return-Path: <linux-kernel+bounces-886577-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 91989C35FEB
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 15:13:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CCD2D1A207CA
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 14:13:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86F90329C44;
	Wed,  5 Nov 2025 14:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="H1cLUadX"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 101E131329C
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 14:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762351997; cv=none; b=DA9zA5marbPKpTw6meISz8tET0K/Fb/GN+QH4pkvnDVsckP+QXMKxsthADs4R24MqCQIOm8I+xypBcdbj3Z4z35anXxhvV2ZRbw96Dgr7uFZhOWgH7sT/LCFohriSq1SJ2w3j9Yp/B4/cfqcud/IYjxNZS0xSMbEyPf2qDIzG+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762351997; c=relaxed/simple;
	bh=6cYiiw9104Yb6fMc0wD7G4qHbAAaDcdcDrHaNNwNRDE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=sKPeCN/oe3IwRyb9wBtXDl0sYQWoI32Xcrxeqa6D0zOvUWwBKvATmOvC1iJux1EugJ4QZ0TC60zLoyUbjhbCkgJHve0zT5fElO0Mq7jKpPnKzvIT2j7k63pInKMWx+96qL+jwQlvehFCLJ3H9r5TKwBr0gy068hxrheAKyxlXXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=H1cLUadX; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-471001b980eso52590995e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 06:13:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762351994; x=1762956794; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4EIDxmF8t8qJeARjr3ym13RSNGJvtuHFHsGeNEqHjS4=;
        b=H1cLUadXE5/8ZTqg8DQtYE96KItWKYhj3iY9pce+SlSWqa3j+gopvGpFTX8BZgathj
         lPPT8fvGAo8bioqdNpMWGbdVKYtOPa+YOUy/iGcDzHtwXaPldPGVr7Gzf1eGmG0O1EIw
         7HQPHc6AXu5v0qUyZLvWpjH+7Hxh01sfajRcsREJMt+KogpmvHji7TJDdZhoIcdnv3r3
         w/pD7Jt8HTEgK1bSy/7g1Fv1pKwEQ2XToWi4YP9v3TWD+Hilj0QFz+PpzB/fWxDtpZdn
         pOc/U+ptv4CFEm7fW+xAUywMDENm+lGDQldgA/rFTx8jPSuoUYGuhpvSdJtwQjuHJJC3
         NGgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762351994; x=1762956794;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4EIDxmF8t8qJeARjr3ym13RSNGJvtuHFHsGeNEqHjS4=;
        b=aOFVZRnnNb45u6y23ez1cOFXxeCzi0mc9IFn+aOWBKIKl6m3YBfJ1H8uIcqCJ7wcdi
         ucvdLA64G5vnENBV916e0htk7X4sqGuwlFmLkv39+C2cOUVrHbXn24xc4+AnfiaRM5yE
         0f5Wop85Q75sbCLnD4ko4k19dJ8umJcYAXy0vvacnWkWCUmOX6bheH2beMfDqjRsR78w
         HXx2pZeaYSvVRZhhIHnFMlOu98BU3he588uVH+iHx7ONceJ/95h+x6o2DdjQtjzM7WZ1
         hBZMgIpfRCbEpu2HoNtVucbIxB9t2zZSLUhzv17lzCHkkg58k7+j6h1UayZ5zSUDj3eu
         B8Bw==
X-Forwarded-Encrypted: i=1; AJvYcCUqtOMmJwfqSU0MdRh8K0jLFpTCstzPKhcBhkuEMjIjBS8wwGHVUp1lBjZ+xRpXC05yWaFTSJtEOFX37xs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0DQBdn4eKXk+8YxFcIVNGZ1U4+okyd+N1Ja9N8yAF3kZOQCeg
	TKQdMExLPfqeuJj4y46ss3NaEvj/uL/405V8YK3JGmVFkkFrjSdzRqIHIb4DEQR1MJX1gLTMAMs
	JTU0eXx82IPx01OwNSA==
X-Google-Smtp-Source: AGHT+IFhgYMpKvHGI0oer51UBMb9nMj8xKyijjOOTMvZJYXyZcIs9AF61ghSjDZ5bURHFXaNxi8u/xryVkSHzIk=
X-Received: from wmcn19.prod.google.com ([2002:a05:600c:c0d3:b0:477:11b7:17fc])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:821a:b0:471:1765:839c with SMTP id 5b1f17b1804b1-4775cdf4770mr24497135e9.20.1762351994489;
 Wed, 05 Nov 2025 06:13:14 -0800 (PST)
Date: Wed, 5 Nov 2025 14:13:13 +0000
In-Reply-To: <90bfcb3e-dee1-4f78-a1b2-02ce99db4997@openatom.club>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <df3a68334760b2b254219a69426982bf858dee39.1762221537.git.chenmiao@openatom.club>
 <aQoIliAbrn0Re7E3@google.com> <b3f50745-5351-4e69-b3e2-ede99511e8dc@openatom.club>
 <aQtTRUMUaaUmTAWZ@google.com> <90bfcb3e-dee1-4f78-a1b2-02ce99db4997@openatom.club>
Message-ID: <aQtbeWpRD7ip8-2A@google.com>
Subject: Re: [PATCH] rust: kernel: Support more jump_label api
From: Alice Ryhl <aliceryhl@google.com>
To: Chen Miao <chenmiao@openatom.club>
Cc: ojeda@kernel.org, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, "Steven Rostedt (Google)" <rostedt@goodmis.org>, 
	"open list:RUST" <rust-for-linux@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	hust-os-kernel-patches@googlegroups.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 05, 2025 at 09:55:27PM +0800, Chen Miao wrote:
> On 11/5/2025 9:38 PM, Alice Ryhl wrote:
> > On Wed, Nov 05, 2025 at 09:28:39PM +0800, Chen Miao wrote:
> >> On 11/4/2025 10:07 PM, Alice Ryhl wrote:
> >>> On Tue, Nov 04, 2025 at 02:04:17AM +0000, chenmiao wrote:
> >>>> The initial implementation of arch_static_branch was achieved by acc=
essing
> >>>> the offset from the original type. However, this approach extended t=
he
> >>>> path and introduced redundant calculations when dealing with types l=
ike
> >>>> `static_key_true/false`, as shown below:
> >>>>
> >>>> ```
> >>>> static_brach_unlikely(tp, tracepoint, key)
> >>>>     =3D> tracepoint->key->key
> >>>>     =3D> &tracepoint->key(static_key_false) =3D=3D &tracepoint->key.=
key(static_key)
> >>>>     =3D> off: tracepoint->key - tracepoint
> >>>> ```
> >>>>
> >>>> In practice, the implementation of `arch_static_branch` overlooked m=
any
> >>>> detailed descriptions. To improve clarity, additional comments have =
been
> >>>> added to the original logic. The approach has been modified to direc=
tly
> >>>> locate the corresponding `static_key` instead of using offsets, ther=
eby
> >>>> reducing  computational overhead.
> >>>>
> >>>> If finding the offset from the primitive type is necessary for this
> >>>> implementation, I will abandon this change.
> >>>>
> >>>> Additionally, support for the `static_branch_enable/disable` APIs ha=
s been
> >>>> introduced.
> >>>>
> >>>> Signed-off-by: chenmiao <chenmiao@openatom.club>
> >>>> +    ($basety:ty, $branch:expr, $key:path, $keytyp:ty, $field:ident)=
 =3D> {{
> >>>>            let _key: *const $keytyp =3D ::core::ptr::addr_of!($key);
> >>>> -        let _key: *const $crate::bindings::static_key_false =3D ::c=
ore::ptr::addr_of!((*_key).$field);
> >>>> +        let _key: *const $basety =3D ::core::ptr::addr_of!((*_key).=
$field);
> >>>>            let _key: *const $crate::bindings::static_key =3D _key.ca=
st();
> >>>>   =20
> >>>>            #[cfg(not(CONFIG_JUMP_LABEL))]
> >>>> @@ -30,7 +71,88 @@ macro_rules! static_branch_unlikely {
> >>>>            }
> >>>>   =20
> >>>>            #[cfg(CONFIG_JUMP_LABEL)]
> >>>> -        $crate::jump_label::arch_static_branch! { $key, $keytyp, $f=
ield, false }
> >>>> +        {
> >>>> +            $crate::jump_label::arch_static_branch! { _key, $branch=
 }
> >>>> +        }
> >>> So ... this is changing from $key to _key. That's replacing the globa=
l
> >>> variable with a local variable holding a pointer to the global variab=
le.
> >>> However, the arch_static_branch! macro uses the `sym` operand which
> >>> requires you to pass it the global directly.
> >>>
> >>> Did you try this code? I don't believe it will work.
> >>>
> >>> Alice
> >> I'm very sorry for making a fatal mistake. My misunderstanding of sym =
led to
> >> this issue, so I shouldn't make any changes to that part. However, reg=
arding
> >> the other modifications, I believe it is necessary to support the dire=
ct
> >> passing of structures similar to `static_key_false`, just as in C lang=
uage.
> > It sounds like you are adding a new use-case for this macro. Can you
> > provide more information for this new feature? It is currently unclear
> > to me exactly how this will be used.
> >
> > Alice
>=20
> If there's a binding-required driver implementation in the future where a=
 key=20
> function uses if (static_branch_unlikely(&zoned_enabled))=E2=80=94 define=
d by=20
> DEFINE_STATIC_KEY_FALSE(zoned_enabled);=E2=80=94 then in Rust we can dire=
ctly=20
> implement it using if static_branch_unlikely!(zoned_enabled), without hav=
ing=20
> to call it via if static_branch_unlikely!(zoned_enabled,=20
> bindings::static_key_false, key).
>=20
> static_branch_unlikely!(zoned_enabled) instead of=20
> static_branch_unlikely!(zoned_enabled, bindings::static_key_false, key).

In general, you would never use "static_key_false" as the second
argument to static_branch_unlikely!. The second argument is the name of
the struct *containing* a field of type static_key_false.

I guess your point is that there's no way to use the macro right now if
the global is a bare static_key_false that is not wrapped in a struct?

Alice

