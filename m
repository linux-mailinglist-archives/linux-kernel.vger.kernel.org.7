Return-Path: <linux-kernel+bounces-874795-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2AD3C17196
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 22:54:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9BF1C3A93FD
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 21:52:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88DCE2FF661;
	Tue, 28 Oct 2025 21:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cjeG0KM3"
Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9A6D2E0901
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 21:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761688367; cv=none; b=XYUCWgGwyUUX0LW5Ru2Oh1f2VLLj1AXDE9LcKTOXfbs8l8Fa+RUL+9C2KR8hbxToYP8VzeLV3G4FhhP6p2E1x/PGcusBR2AJuLzeHWeUMNuV8MJYHjlo179wcMotbvuAbwTl9u2fck4Z0cWKOMlaQjx6/4B769UOR0RG8148F3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761688367; c=relaxed/simple;
	bh=Rew2DIZQjJQQJYPoWH0uGoFe28Wfig0fDjDy+zsgScA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ZRWOu0KtgwFDvrqjwwdODHJBcrtIsEDDLumREL9k+qC+TpZnnEoRTwUUurxjgniiBVpICInk80DPnIEAfK9sDAukK+r/sjP5U2ucVypIqTnXC8zA78ma5tuDHqD/+Ml7yfU0evKezZa/gvYeea+g7X6ICtzaSaeRFEwOfTuI+Ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cjeG0KM3; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-429af6b48a8so72773f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 14:52:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761688363; x=1762293163; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gxvTcp57iqNZaGWW5QgrfrUxUlyacGTsuw9SR8IN/F8=;
        b=cjeG0KM3S9e/fLCifyJnDq7staSsT06DuhJl6DFuIjBan130TqhHKatgMFDCF1nbZF
         VH/4S83CO20ZK2Hy9OxcD7uVDHr+7ERcUlDe4SK4JjuN6+kaF8l667yMg5iwXjXdTxMF
         Sr2Zr25Xrh8NZLbF+IBNBwh1sRcycWxCFWXzRfmiuR42Lpmj3BvoUYnMBaGaMIg2utp9
         5WAyWfNVkXsJMyTF1naTPoF0h6O5cBRQkqox2f+g+a5vonCxd2otZKUwbAoVMuU7PqUz
         Bu3poAlYQuxF+3qKZceu1YNNKO2LpR9/B9CXJujpYyvGFP7ZbBQsgiK+aHg0H3uijfc6
         tF/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761688363; x=1762293163;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=gxvTcp57iqNZaGWW5QgrfrUxUlyacGTsuw9SR8IN/F8=;
        b=OOMLBJ4hfsjaaSy+lF0TZ+CNX13r7EXRusqG9ORw7B4INbmFrMbEQwdiuDH5q6WtHO
         GQjjLMD0clXkCQkaES0YbPyMj9aek7KiruUgNHCXMk4LbVnjwMTBTPvXleTldfw5Adxu
         atqKrJEm6xPyvOOqabW1enUEWjARl75VHqDjOzCuevX0DUxp1E8L98JkW53whKYGlbJi
         zc/fGYPRCVu1JcUDg9aYrwksQct7i6N8w4J1BN7fR8JpbDP1rpJtEKOPW6doP00rWW6m
         8M/ErphdNzfsJqh+AKB/sKSGzsG8YN+BCHcYFpMg4EQSXUifz1rUVLMpnSZOFcIf9WCb
         zkcA==
X-Forwarded-Encrypted: i=1; AJvYcCUzK+MVfcDqTMxDV/Kt5vqRWRAbLfaiap7jTpFWHLtBIm+HMDyy5hEqTlYNRygPrKNtNJg2T4dFB/ism6I=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPJZInrekgatU27R4DpAAINye9FlP5j66QgrMvzMQ1kjS/LJnx
	lGPj9mIKcciNY5K/BtIi7Mo8750TNw7VrgSckyxtzm4U1uivIh+PCaWhfbnHguroqOb4L/OM1Hr
	OgCRcrMbqA9MBt6as/w==
X-Google-Smtp-Source: AGHT+IFqfPgRstRelzXH+amB/IjwATor/dkpPTNhB7q+WHWYQFrq8HCUWQ8G/CKZe92IMAQ4Z7r4uuvZpYk2Ums=
X-Received: from wmkg4.prod.google.com ([2002:a7b:c4c4:0:b0:46f:aa50:d70f])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:5250:b0:46d:9d28:fb5e with SMTP id 5b1f17b1804b1-4771e16e471mr7732565e9.5.1761688363173;
 Tue, 28 Oct 2025 14:52:43 -0700 (PDT)
Date: Tue, 28 Oct 2025 21:52:42 +0000
In-Reply-To: <20251028211801.85215-1-lyude@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251028211801.85215-1-lyude@redhat.com>
Message-ID: <aQE7KliosIU_0Bll@google.com>
Subject: Re: [PATCH] rust/dma: Take &mut self in CoherentAllocation::field_write()
From: Alice Ryhl <aliceryhl@google.com>
To: Lyude Paul <lyude@redhat.com>
Cc: dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Danilo Krummrich <dakr@kernel.org>, 
	Abdiel Janulgue <abdiel.janulgue@gmail.com>, Daniel Almeida <daniel.almeida@collabora.com>, 
	Robin Murphy <robin.murphy@arm.com>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 28, 2025 at 05:18:01PM -0400, Lyude Paul wrote:
> At the moment - CoherentAllocation::field_write() only takes an immutable
> reference to self. This means it's possible for a user to mistakenly call
> field_write() while Rust still has a slice taken out for the coherent
> allocation:
>=20
>   let alloc: CoherentAllocation<CoolStruct> =3D /* =E2=80=A6 */;
>=20
>   let evil_slice =3D unsafe { alloc.as_slice(/* =E2=80=A6 */)? };
>   dma_write!(alloc[1].cool_field =3D 42); /* UB! */
>=20
> Keep in mind: the above example is technically a violation of the safety
> contract of as_slice(), so luckily this detail shouldn't currently be
> causing any UB in the kernel. But, there's no reason we should be solely
> relying on the safety contract for enforcing this when we can just use a
> mutable reference and already do so in other parts of the API.
>=20
> Signed-off-by: Lyude Paul <lyude@redhat.com>
> Cc: Danilo Krummrich <dakr@kernel.org>

Didn't we do this intentionally so that it's possible to write to
different parts of the allocation without protecting the entire region
with a lock?

Alice

