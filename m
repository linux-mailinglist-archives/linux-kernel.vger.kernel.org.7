Return-Path: <linux-kernel+bounces-890054-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A7C31C3F27E
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 10:27:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 80529188E4D1
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 09:28:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2981D30146F;
	Fri,  7 Nov 2025 09:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2RM+Ujcj"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 230072FB612
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 09:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762507656; cv=none; b=bJ1yLpEicA9AZnfhSRjZjI4cg0XfWlmdLEvyf1B7w+8k2FaHw3r05M5Mv1Cq0pD7JA6nExOScPWoODc/QVL5ORfjjDKrhz8dAcmElFf/VKE+xTRL1n3iRK216o9BrywT04fZzdnM2JA9rgyt6eqGp2dHdfy3jMH/BLAQeHp5KHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762507656; c=relaxed/simple;
	bh=zql2idMxKn9IZQQNYisWu3dktGhNGu+7zZEYNX+6VNk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PguqVHyVAbbXyhaxUq9CVTCwv5ALQwv5OxWLJHIGq2ex9tRYlASWCRDCdtS4ysV98j3oQipPbnOToyW24+MsfPJopQiH5lPFLEc14UlN1pPgQnZevT/9wCBmuF0BJ+40c7FvOtM991U9M6fYJGbJj8GSdwDdDWPxx06sraWpDG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2RM+Ujcj; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4775e891b5eso2388135e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 01:27:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762507651; x=1763112451; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oJkdEVxT25O3GXjohNk3p6mQ6FsJrtPAoSVYfYSIvHw=;
        b=2RM+UjcjaqTLAVafLXzNXwiKtbPjfqz9ynfem20WPAOHycMxyVnEijfrZDrfEYR1AL
         uJ66LX6xQDX5R1UJd/lCY0YeaqPoZJM8JUBtxjlr43xPsbBR71Qy5w3E25aepGT5SI+6
         AMQVWmr2ygA4MNQGlfWOeUVxVjFqP9t65Uo/DXCQxtlxB7AVBQerL+9XO4PBVKeg250Q
         VMR+tD5Td0ou829j16Ma9EOmou3MG7xUA/pbW6Jo7XucieQOMqqVkqz58m6Q2lnE5Hfh
         bKrKbLk6+S1EdgOeB9L9xbR/zbfk/ekM+UYyeHMBiLw0DpcwM5HZfAkPHHimkBd/92bR
         6wDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762507651; x=1763112451;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oJkdEVxT25O3GXjohNk3p6mQ6FsJrtPAoSVYfYSIvHw=;
        b=hhkbdWjs6tkur4/bmUeFVcYVA8j/Efk2uxS+f+FEieIXuC+z/anWs0UzDtkc7OdTN0
         t0171fHJbCUnVGE16KtSf6w05Hlnz40L4cPr47qZwiXPkAwHSSEicRXKJqmx4FhBTRQ5
         e5IsGqEu2QjnAjjV2RIsLSOWSrnntHu6UFe+ZbXbasRBdCdv16HLids3cMjrA8V2C3Gy
         lVCO6XL0Su117NmUlUC9WbiAeLHFckPZYU+zofc9Ki2GnVq+BM1XlgCltf4ncoI1l5Rc
         tVzIUnlM/CIMJhe0T0Ulk5NRlLyqxTW2EozkEw1rRDS45hKvXtzo9nDTRh8HIuBKetFv
         ngBQ==
X-Forwarded-Encrypted: i=1; AJvYcCVbsa1hBMPvS7Pqop5RUacijHgJc3jOszQgm2dM9Ztzrp1CbHCE4KlJgnPPtpkuCKC79WfCdHDEOZNHeRo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2+1il+DYVudRgLUg3NHrA8FfuApPKMgjCGcMWnnC1Xrp+Ii7M
	vET7u7+ApJkdEkmVtIT+3Q8uo9ZrwzzvI+fGdjxzVm7nhsbP1fPDLNkiHKl3JQW0AbgA49rmKSW
	u8jCJuyfSjsg1da/HydwGbpJ84ZZGo02RdYLmX22G
X-Gm-Gg: ASbGncvokm+b6/fD3lpIq2G9N03AVMegyBErebOIV7+4VXk8bi8q7vl9c58KHU8voOV
	K/ISCNYSaI1vJNK6AoMZ91v+P9Ioe+htQG6Lnjxyv8FWN3UIlsghtOp1nH+LC03Xi/MTC+B3MYG
	PJ+a+TXntKFT19CMc8/drkFNlStFy5ZYvHF70kFOt3R1VQ+NzBfG1qpaCWpGG6XdsGWInHwqxUF
	BbgaQ5rKfydepnwIRCAY812sEqbRA+ZPiMUYaTMcI8wFuYV25QrKY9ADEsB97aV3Ve0teMVk5Xd
	biusSMbIPCuskQ==
X-Google-Smtp-Source: AGHT+IFle/w4e+aky9dDN00u9w5qMqMYp4+iwTBMRCAFPTApgJKqffnTXa0XQ44LPOLkMtHMiEidtNEEmO7onsmHZ4k=
X-Received: by 2002:a05:600c:474a:b0:477:55c9:c3ea with SMTP id
 5b1f17b1804b1-4776bcdb495mr21615615e9.35.1762507651253; Fri, 07 Nov 2025
 01:27:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251107050700.1086059-1-m18080292938@163.com>
In-Reply-To: <20251107050700.1086059-1-m18080292938@163.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Fri, 7 Nov 2025 10:27:16 +0100
X-Gm-Features: AWmQ_bn0_YpyoyCmwHnyMVeVnDhIAwFUr0Y5LT4OlVSRZWa7nbsVmxfJKIuTnIQ
Message-ID: <CAH5fLgirP4=RrDcuF0n74KvN05K4FkAm9uZUfwX0WYfM+pKP8g@mail.gmail.com>
Subject: Re: [PATCH] rust: rbtree: fix cursor method lifetimes to match tree lifetime
To: Hang Shu <m18080292938@163.com>
Cc: ojeda@kernel.org, Hang Shu <hangshu847@gmail.com>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
	Charalampos Mitrodimas <charmitro@posteo.net>, Borys Tyran <borys.tyran@protonmail.com>, 
	=?UTF-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
	Daniel Sedlak <daniel@sedlak.dev>, Tamir Duberstein <tamird@gmail.com>, 
	Matt Gilbride <mattgilbride@google.com>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 7, 2025 at 6:07=E2=80=AFAM Hang Shu <m18080292938@163.com> wrot=
e:
>
> From: Hang Shu <hangshu847@gmail.com>
>
> The returned keys and values of cursor methods should be bound by
> the lifetime of the rbtree itself ('a), not the lifetime of the cursor.
>
> Without this adjustment, examples like the following fail to compile:
>
> fn test_rbtree_cursor(rbtree: &mut RBTree<i32, i32>) -> &i32 {
>     rbtree.try_create_and_insert(1, 1, GFP_KERNEL).unwrap();
>     let mut cursor =3D rbtree.cursor_front().unwrap();
>     // compile error
>     // cannot return value referencing local variable `cursor`
>     cursor.peek_next().unwrap().1
> }
>
> This modification ensures that references to tree elements remain valid
> independently of the cursor's scope,
> aligning with the actual lifetime dependencies in the data structure.
>
> The changes will be applied to multiple similar methods
> throughout the Cursor implementation to maintain consistency.
>
> Fixes: 98c14e40e07a ("rust: rbtree: add cursor")
> Signed-off-by: Hang Shu <hangshu847@gmail.com>
> ---
>  rust/kernel/rbtree.rs | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/rust/kernel/rbtree.rs b/rust/kernel/rbtree.rs
> index 9e178dacddf1..702a1b6ef7a9 100644
> --- a/rust/kernel/rbtree.rs
> +++ b/rust/kernel/rbtree.rs
> @@ -742,7 +742,7 @@ unsafe impl<'a, K: Sync, V: Sync> Sync for Cursor<'a,=
 K, V> {}
>
>  impl<'a, K, V> Cursor<'a, K, V> {
>      /// The current node
> -    pub fn current(&self) -> (&K, &V) {
> +    pub fn current(&self) -> (&'a K, &'a V) {
>          // SAFETY:
>          // - `self.current` is a valid node by the type invariants.
>          // - We have an immutable reference by the function signature.
> @@ -750,7 +750,7 @@ pub fn current(&self) -> (&K, &V) {
>      }
>
>      /// The current node, with a mutable value
> -    pub fn current_mut(&mut self) -> (&K, &mut V) {
> +    pub fn current_mut(&mut self) -> (&'a K, &'a mut V) {

This would allow me to call current_mut() twice on the same cursor to
get two mutable references to the same value. That is not okay.

If you want to have methods that return a reference with the tree's
lifetime instead of the cursor's, then you need to add new methods
(probably called into_*) rather than modify the existing ones.

Alice

