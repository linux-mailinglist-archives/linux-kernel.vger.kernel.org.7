Return-Path: <linux-kernel+bounces-738272-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C2DEB0B68C
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 17:02:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8616C7A95E9
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 15:01:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9723C1E633C;
	Sun, 20 Jul 2025 15:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OAFWVGNJ"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69C253D6F;
	Sun, 20 Jul 2025 15:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753023749; cv=none; b=T9x9QeESQy5DC3vhneBBeYOLZ0WUNk3KdMeMTHeSQN0QJJuVKiU7kOQO9aeozjm7CLf97IVBFlzA01gWXUVsDI7tAn3YmZ7i6WRB2+12xcMAbStlKGj2VCbuX0oLNyUK98zcsIVErO9p2CmhDKVj8lPHwm4fndQJLWdrtsB5cZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753023749; c=relaxed/simple;
	bh=+NU0f4p4nwF4AjyVPqBrzsnpMY/oszbnf1fJk84DbU0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ar6kjo2pKVNh5f4pCz9PO6ORLdfv4ZxnxSDI+0L2nN+1vwbIGvyo7OdiQPxrY3dZz1MsAlppuyHtIJFTeueCvnG2ExntTnZ7uhg0Lr4MrGlUc9Pk01LY8SXx4w/N8B8lJJYwWCh5QBLKFG3wKP0f+e6WOmc+bjMV3GE8EMg/Mr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OAFWVGNJ; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-ad572ba1347so481032566b.1;
        Sun, 20 Jul 2025 08:02:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753023746; x=1753628546; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yBq4s7IgvgeI8LlVi+Zh51XwjN6MneGpapQDOgcp+VY=;
        b=OAFWVGNJPunRp1pnBTklgKQ+sllBh0Zqal7F3lPmOw5Tlpw8ESn4fECIPQghKzpyn3
         EoHmN8rgQUB69FeyguHFxOCVFgcE5pPMpn4GxXZTLQbT82Bg7h0D84hRvO5RxzC3C8hz
         bwa5CydzeGBQ/HQsljACC/ksH6WpJDGFPo5LZK7jk7akV43Iqm64Vs6gqP7j73Iiey31
         TjKdJ6RHpFdeXIW/umshbtkmEgdSp0koBrD9qHbfl1ptIiMNh34PfPjpRNShg+1gNfRz
         5zSzPH5MuTQNTzuUa86Lt97CuslGOInRaR6ARBRXrgBnZxulHSsSJdNjf+COX8xrn6sg
         9ddw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753023746; x=1753628546;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yBq4s7IgvgeI8LlVi+Zh51XwjN6MneGpapQDOgcp+VY=;
        b=gq6Q9v9iM8XppeuDi3FNL8omi7TAqf518ZEJ716kUwqhKuewRpOzF60LesdKGNyCPg
         Kz0SHbNvolspF7l0FytkW60ZUy8vR1OcqrEhC2FFPMM2JUaksWSHIx77O2IgJ5swWHEX
         RFnPVMN4OqhobzmmbzEDy+pQT4a2izz//n0bB07meOeB9NSqDjdyzVd5uhCQv9bA8xB4
         uRLAJjSkJw+nRF2KCEeTrAWhZXRKVbhTB/b/D01zhcd5hx8Wbq9cNaec2hW5lOZiATRx
         NwOOBdGPdvEpme2rUS4GcJmYFgW6F7yUiQB6oARtSoYc4jggmgEU37rmGsSfM8H/SMig
         KWGQ==
X-Forwarded-Encrypted: i=1; AJvYcCUMBiyd/jEJZVULnVrQHq8qAhMrChMsaojTltENI8YRtfuW7DN7z2U6dApG7asRdG7rTFZaajDmTTWJt/o=@vger.kernel.org, AJvYcCVI9XC/h4xw91OSCavfmfLiyPXc1nbqh+Ldj+DPSosN65wBMMJ6aLgV4NzcqQAcB8cCctb7ryo/z+OtVUwwOJw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyg4Juq1spYU3HDXPTH81CyA+kdffjZWjEZtT3cRSSoOOYryohB
	/mfKLXVmCU12qZ2JomZcLMKtXrzC6Ct0kNnIKkg7EYf3d/W5aiMW3cV3Mbh6pZGMh/qYF0mIyJJ
	wEiXlc5xbpc7viiILAsUMMnZbyF5K560rTY/F4xnQqQ==
X-Gm-Gg: ASbGnctn9jCZCAKUeTRyVzd0gJ3UwFkJVG7YGk/VcqzU0ulMUszqYfqN+vivJ6hNsq6
	XekFp7cQ+TfTqUdCR/7kAy7RzGjGsVe9yZ366zqSLFTKpJsH2VS2cOMCGm3iykCnHa/ThGsnvU8
	+NKJiXKg50tF+OxMuvf6xX/GNclOhqBMT96RY2rUXmBIyaJ56Ibv0fMvPKuZlt0vWkoi4ambKrh
	iUb4bfXyBnos5FI+ot0Oj0ESA75+H1vup7I246ZLA==
X-Google-Smtp-Source: AGHT+IG0lJPkWuVauq9Kk7wmPfK+95V5H7PAaLnR7rtecUWMdjLuVrjjOvS9g7KVdGyT92YjJl9LNkfMT+/MgwTDuo8=
X-Received: by 2002:a17:907:1c17:b0:ad8:ae51:d16 with SMTP id
 a640c23a62f3a-ae9ce198bf6mr1743464466b.55.1753023745422; Sun, 20 Jul 2025
 08:02:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250719232500.822313-1-ojeda@kernel.org>
In-Reply-To: <20250719232500.822313-1-ojeda@kernel.org>
From: Tamir Duberstein <tamird@gmail.com>
Date: Sun, 20 Jul 2025 11:01:48 -0400
X-Gm-Features: Ac12FXzqgH4mx0bfYQ1wCS2u-3aY2us21hvNcois8QEn62EbIRZeMeCNHcEFquk
Message-ID: <CAJ-ks9nq0wC2xpAr_AiSFa_hD+ss1DSvy-Uw4NG66E_1FaYCag@mail.gmail.com>
Subject: Re: [PATCH] rust: list: remove nonexistent generic parameter in link
To: Miguel Ojeda <ojeda@kernel.org>
Cc: Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 19, 2025 at 7:25=E2=80=AFPM Miguel Ojeda <ojeda@kernel.org> wro=
te:
>
> `ListLinks` does not take a `T` generic parameter, unlike
> `ListLinksSelfPtr`.
>
> Thus fix it, which makes it also consistent with the rest of the links
> in the file.
>
> Fixes: 40c53294596b ("rust: list: add macro for implementing ListItem")
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

Reviewed-by: Tamir Duberstein <tamird@gmail.com>

> ---
>  rust/kernel/list/impl_list_item_mod.rs | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/rust/kernel/list/impl_list_item_mod.rs b/rust/kernel/list/im=
pl_list_item_mod.rs
> index f4c91832a875..202bc6f97c13 100644
> --- a/rust/kernel/list/impl_list_item_mod.rs
> +++ b/rust/kernel/list/impl_list_item_mod.rs
> @@ -17,13 +17,13 @@
>  /// [`ListLinks<ID>`]: crate::list::ListLinks
>  /// [`ListItem`]: crate::list::ListItem
>  pub unsafe trait HasListLinks<const ID: u64 =3D 0> {
> -    /// Returns a pointer to the [`ListLinks<T, ID>`] field.
> +    /// Returns a pointer to the [`ListLinks<ID>`] field.
>      ///
>      /// # Safety
>      ///
>      /// The provided pointer must point at a valid struct of type `Self`=
.
>      ///
> -    /// [`ListLinks<T, ID>`]: crate::list::ListLinks
> +    /// [`ListLinks<ID>`]: crate::list::ListLinks
>      unsafe fn raw_get_list_links(ptr: *mut Self) -> *mut crate::list::Li=
stLinks<ID>;
>  }
>
>
> base-commit: cc84ef3b88f407e8bd5a5f7b6906d1e69851c856
> --
> 2.50.1
>
>

