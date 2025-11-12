Return-Path: <linux-kernel+bounces-896999-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 66435C51C71
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 11:52:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8E13C4F72E4
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 10:43:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B08283054EE;
	Wed, 12 Nov 2025 10:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RRkp8ueR"
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81812223DD6
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 10:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762944211; cv=none; b=kMst37wW68fXSx+D50p98kkDjmZMTq/ZcfAbTnd/aw6l2/euv8z5/KNESrQ1cSLdAOZmSdRl973tUZTAvJ+WU2YuwpY/IyY+9npp57XslRyjrvbwLZ+JsEGFI8Z2CAksdKC80mHX0zmP+/Lu0qV3nBS52E4MJSDO2uNz/SljoaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762944211; c=relaxed/simple;
	bh=qsGK2vvgIjSrGY79hbtJ2kdI3rL7jpuRQsUVkFhylGk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Ugfs5WGTgtoOnZx/zdhjiOEzwjPKjkSmA0KJC4FhN7eyC9ryQ9/HOPw1ED08BQNzB/OFqBP20PZGrcW+kno67LdbZe2NTIKAc+awP/1MaHirke1yKJpluV0NCPz1KM6ZcFvw1u6kTaXb1MUG7Z0zTfEJt9NGUt6np5/xZaET9tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RRkp8ueR; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-42b2c8fb84fso321886f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 02:43:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762944208; x=1763549008; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qsGK2vvgIjSrGY79hbtJ2kdI3rL7jpuRQsUVkFhylGk=;
        b=RRkp8ueRJE/nY1igK+J4JZYEwrJIuOvz34QXWKjGmP9ySFhncNZLri8vZQe20BkDfD
         4/xnkV0kICdPyaXJntv/kekQToDkEJyZvgW20j3UIlhO9YvxJ2HvGz3nh2U7kG6FTO8o
         CsS9bx0ZLU5FPpMKALyDmWKr3yjWqjpFM6HSYlIEJkFPTqkyRbIlkmTWCHH+WiSO4cNR
         NUw4Kkll4Wg4J9BlDkOLsPOe1tWRoFEUxabwUWjaZlF0Qj1zDlJop1WSvkSDRANy1A3A
         8kH4md/8X27VJlJjvcj+tyVvbq+LRmABKOK4cX5RsV36iUmBzPZoOa6byImMoWU51b38
         deWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762944208; x=1763549008;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=qsGK2vvgIjSrGY79hbtJ2kdI3rL7jpuRQsUVkFhylGk=;
        b=rj9AyMogizG3waxnxt+Ozbdto/qbRp8keH+NILpdfBmARZU+wpL8tg7dgdIaz/0eEr
         oXNUbxwF1p1H9xr8h7A0gq4Q0iqzdhhfr7AhuyfbCzq1dHcrFFDXu29u72NMLVH1JFN0
         q/1H2OtUuO/lmFdkCaK5pLS5Kzrm1Vjrjm0/ULZhzGoWySpgEEmhbw7nBz6QcvHotFEP
         Y7i0rW8CSJ7qePmuIBACk5NLoQWTW9F4fX3u/e2yw8pj6w1zclBv9L9IQMLXizB8tWCX
         U9P+UfKLMPJ2REiCOlp7+Wa3Y5sAwQtpoyCc/c+YIS0dET/tS3Ymvlxk6Ed20JWjsL0B
         KC2A==
X-Forwarded-Encrypted: i=1; AJvYcCVyxvd1chg20asphkBPyCpoiSFCuBZe+9F/wUuP2h/w2UX+CMewOwocSG1lw3jqKn4KerYujgsFGpvJAVI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzfri4wmFoF9n11udHeBy5/rgJEyrjMn+fqaKWUSk8ckNBG6LVn
	JUjZxSJqtR5Lrv2CnLP6pGnKsPY/Kn0zJ7QP3vgW/pWKWkwNK6Y0RCGz5k/e9BaVVuivW5vSAsJ
	TxIH9KokMWRX245IMuw==
X-Google-Smtp-Source: AGHT+IHmCFXHpp5cauitqHBpDGeJg4dbeHWzIhTk4Pbjn82zVph0DB0Y4c5pbPV7FQxsGrBXCKpMvGCvcCH7RKM=
X-Received: from wrbfp24.prod.google.com ([2002:a05:6000:2798:b0:42b:4843:f05d])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:144c:b0:42b:3bc4:16dc with SMTP id ffacd0b85a97d-42b4bb9c952mr2020672f8f.21.1762944208032;
 Wed, 12 Nov 2025 02:43:28 -0800 (PST)
Date: Wed, 12 Nov 2025 10:43:26 +0000
In-Reply-To: <aRRgbZ67cuW4ZoBN@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251112-resource-phys-typedefs-v2-0-538307384f82@google.com>
 <CANiq72maV_j1uV=2nPGbTgRabnk8cpc7TNN_FQ+ou52OpZ=k6Q@mail.gmail.com> <aRRgbZ67cuW4ZoBN@google.com>
Message-ID: <aRRkzrUw1iYNt8KJ@google.com>
Subject: Re: [PATCH v2 0/4] Rust: Fix typedefs for resource_size_t and phys_addr_t
From: Alice Ryhl <aliceryhl@google.com>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Danilo Krummrich <dakr@kernel.org>, Daniel Almeida <daniel.almeida@collabora.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Abdiel Janulgue <abdiel.janulgue@gmail.com>, Robin Murphy <robin.murphy@arm.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 12, 2025 at 10:24:45AM +0000, Alice Ryhl wrote:
> On Wed, Nov 12, 2025 at 11:12:32AM +0100, Miguel Ojeda wrote:
> > On Wed, Nov 12, 2025 at 10:49=E2=80=AFAM Alice Ryhl <aliceryhl@google.c=
om> wrote:
> > >
> > > This changes ResourceSize to use the resource_size_t typedef (current=
ly
> > > ResourceSize is defined as phys_addr_t), and moves ResourceSize to
> > > kernel::io and defines PhysAddr next to it. Any usage of ResourceSize=
 or
> > > bindings::phys_addr_t that references a physical address is updated t=
o
> > > use the new PhysAddr typedef.
> >=20
> > Should we have these as actual types instead of aliases? i.e. same
> > discussion as for `Offset`.
> >=20
> > If there is a change of these getting mixed up, then I think we should
> > just pay that price (not necessarily now, of course).
>=20
> Maybe later. Right now I think it's more trouble than it's worth.
>=20
> > > I included some cc stable annotations because I think it is useful to
> > > backport this to v6.18. This is to make backporting drivers to the 6.=
18
> > > LTS easier as we will not have to worry about changing imports when
> > > backporting.
> >=20
> > For context, will those drivers be backported upstream too?
>=20
> I could imagine cases where a normal fix gets backported upstream and
> benefits from this, but I mainly thought it was useful for backports
> that happen downstream.
>=20
> > i.e. we have sometimes backported bits to simplify further backporting
> > elsewhere, which is fine and up to the stable team of course, but I am
> > not sure if using Option 1 (i.e. the Cc tag) may be a bit confusing in
> > the log, i.e. Option 2 or 3 offer a better chance to give a reason.
>=20
> Using a different option makes sense to me.

On the other hand, I think that the first patch qualifies as an actual
fix.

Alice

