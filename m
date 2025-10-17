Return-Path: <linux-kernel+bounces-858065-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69ED6BE8C33
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 15:11:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6071C3B7B01
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 13:11:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70DB0345751;
	Fri, 17 Oct 2025 13:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qlkPF/NI"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33E3C2E3703
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 13:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760706672; cv=none; b=MT05G9WNFkdji9JdMQCXjD8aUCGPRwFUYdNQNsKGuZklbagopo93ru4iVXb687SNPGsbHq3yPaG9gYWTg9f/zA/rJ5TVPAZrbQ0CiJ9i+bMB/wAzxlRRQs7BEiYS4hdLsUrvbLqlAV4NfVi7EuuIiSeT1JjIJKBx/Wqcl52Ln0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760706672; c=relaxed/simple;
	bh=sKhPhfboNdXMAsvHy3mTsZ5MyzK1PH2g5+lXSKRfy3I=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qYZRUCTZxwekmyoAKTk3vTR2rWOGed6jZuPCirTWnhHUiD5VEEM9djOUtyQI7Ox3vQD9xztTimye5EqKsYOzP1PcVSQATDESZWRD+mtw19iSDjYXwd6jBvPGncL1a7GA/VxIr+fjdUTF9HT9q2HHdg75hixQIHK3RlUchceIGgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qlkPF/NI; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-47114018621so11048825e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 06:11:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760706669; x=1761311469; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qBN/Cw+eQnfQcCTA3O6NXKqQGjAglVYeOYNDpCPHrj4=;
        b=qlkPF/NItmZPDpsHEpkWt+ra87HsC74n1ueafGXTG1U6S2V5MWeQcLxzPiDDD8IqlQ
         QtHQLN1hV5xZ5HCJnfjH79BOALNe0xldGmG1Zh5Adx6D2GhSjqN8vcdqh6yzdr6MmNni
         guGOHmkz16TM9UhZ8wEar+97SiWSBt9yz5T41J/LDVNCGAc4vFD0oYq/YyAq8IutdKwI
         VwvyVsW90folTn0s+xcDfKh4NpvF5wiJyZIDNmhzlMpfaqJ1AN2wjLgZqj5qILvSO6Uq
         1cnQ43tuEgUGaqXaTeTUk7nS4AIlIvpDjCqMXb8yOxheJYPlFPYkDtjjT+YjCWoX84UW
         7bag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760706669; x=1761311469;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=qBN/Cw+eQnfQcCTA3O6NXKqQGjAglVYeOYNDpCPHrj4=;
        b=TZXy9wD5iQFVRCzMWTYo1TvLfBOVULobd8C3dZoXm24IE9PvZi8xPcZrzQ9EW8boNU
         Ew9fxTU/cN1qC/YWFytj6D+2F9+vVcFYM7KY8B7sIgP0/uwRIivLNFDr90q4Pm9lLr1p
         Mwd3wCY+oBx2hM5EA3E1HqiMjW9RYwWCLq0sFbUuWIeVD2sD0zV+904qqzIsKMtf/9YI
         dMmWqi2JiRw3ZRzbPX7KBt5LTgadpyRQHucyYet9nNEOst8OlDRfTAyNTW/B5gh2okfx
         NOqzk74b1OTMS/YoDx/0J63Mm/usdt+iMn6g86y/QREK3x5ZIiUr3ybbthFfsozdvR6S
         8JbQ==
X-Forwarded-Encrypted: i=1; AJvYcCWVne0i9j6ZdrRMXbB8yWW7JCwD/ELw1Ejw2ulw6fKkvrHD4tmPeUb1UfQxffhAYLT8/EZnW38HarI6oRc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy96UvCKKfRzDQIk+/Uz9laLAO2MhTFKPpxp/1RzHXJdPOWNO7h
	aYjzBMy3EEnS0/aCJmm5QQ7xgXqsxmHhEpTs+sDNYaf75Aj6m86hDbmCLYvHQrLbNPEysk3PpYB
	9MUiYV3/ezx0FmXS7vg==
X-Google-Smtp-Source: AGHT+IHTktQkfKYsYJzw3V7qNFgXkgcqW3EHTpsr3Q8Lq0rXDd9Msb8bUuMxcu07kxcMNJQaoB+wGtgg8MCddxA=
X-Received: from wmgp5.prod.google.com ([2002:a05:600c:2045:b0:46e:684e:1977])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:19d4:b0:46e:4a13:e6c6 with SMTP id 5b1f17b1804b1-47117907234mr32563835e9.19.1760706669430;
 Fri, 17 Oct 2025 06:11:09 -0700 (PDT)
Date: Fri, 17 Oct 2025 13:11:08 +0000
In-Reply-To: <20251016210955.2813186-2-lyude@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251016210955.2813186-1-lyude@redhat.com> <20251016210955.2813186-2-lyude@redhat.com>
Message-ID: <aPJAbHz33FPpYGG5@google.com>
Subject: Re: [PATCH v4 1/9] Partially revert "rust: drm: gem: Implement
 AlwaysRefCounted for all gem objects automatically"
From: Alice Ryhl <aliceryhl@google.com>
To: Lyude Paul <lyude@redhat.com>
Cc: dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org, 
	Daniel Almeida <daniel.almeida@collabora.com>, Danilo Krummrich <dakr@kernel.org>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, 
	"=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Asahi Lina <lina+kernel@asahilina.net>, Shankari Anand <shankari.ak0208@gmail.com>, 
	open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 16, 2025 at 05:08:14PM -0400, Lyude Paul wrote:
> Currently in order to implement AlwaysRefCounted for gem objects, we use =
a
> blanket implementation:
>=20
>   unsafe impl<T: IntoGEMObject> AlwaysRefCounted for T { =E2=80=A6 }
>=20
> While this technically works, it comes with the rather unfortunate downsi=
de
> that attempting to create a similar blanket implementation in any other
> kernel crate will now fail in a rather confusing way.
>=20
> Using an example from the (not yet upstream) rust DRM KMS bindings, if we
> were to add:
>=20
>   unsafe impl<T: RcModeObject> AlwaysRefCounted for T { =E2=80=A6 }
>=20
> Then the moment that both blanket implementations are present in the same
> kernel tree, compilation fails with the following:
>=20
>    error[E0119]: conflicting implementations of trait `types::AlwaysRefCo=
unted`
>       --> rust/kernel/drm/kms.rs:504:1
>        |
>    504 | unsafe impl<T: RcModeObject> AlwaysRefCounted for T {
>        | ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ conflicting =
implementation
>        |
>       ::: rust/kernel/drm/gem/mod.rs:97:1
>        |
>    97  | unsafe impl<T: IntoGEMObject> AlwaysRefCounted for T {
>        | ---------------------------------------------------- first imple=
mentation here
>=20
> So, revert these changes for now. The proper fix for this is to introduce=
 a
> macro for copy/pasting the same implementation of AlwaysRefCounted around=
.
>=20
> This reverts commit 38cb08c3fcd3f3b1d0225dcec8ae50fab5751549.
>=20
> Signed-off-by: Lyude Paul <lyude@redhat.com>
>=20
> ---
> V2:
> * Rewrite the commit message to explain a bit more why we don't want a
>   blanket implementation for this.
>=20
> Signed-off-by: Lyude Paul <lyude@redhat.com>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

