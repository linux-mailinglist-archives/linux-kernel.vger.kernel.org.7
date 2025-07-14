Return-Path: <linux-kernel+bounces-730910-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A78BB04C59
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 01:32:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BA9EB7A9295
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 23:30:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 873BC276058;
	Mon, 14 Jul 2025 23:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I0UjMoJ9"
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B705DF76;
	Mon, 14 Jul 2025 23:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752535913; cv=none; b=uBFvW9NQK+1EBoqQyLDHU0/nOOA6+fHqsMYq6Ovdo4BTM7EbDvdpss8vEF9IphOLG17VHDOnYjgqAiEbtYgxIjGzF3sT0WAVFa/gOpq3BkcbTD/FhrjFjQaZHpllCUkwjXvyuWJ2tnMqsHmqcF13h3kRNBnErd2EzPAbaCSnj0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752535913; c=relaxed/simple;
	bh=VZcSFep2MkUzEp1HcwREjrWQXILilZW/IxidSrQV8ZY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y0awDJUZeokIDsoCfSOuXN5FC+7BuFs6jpgyxUFZ4OGBUEmtdx7qB4KT7tAcimorwG0Ib//SQKqEMoLu8IVK/LFZN9LNNbLSBNb+gz08fZtQVcUVIkqdgn11hO1vToR57azd8aP5FA64cF1x9GfEfU7HK7rlP1A/hcb7S31APw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I0UjMoJ9; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-312a806f002so847449a91.3;
        Mon, 14 Jul 2025 16:31:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752535911; x=1753140711; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aswGT4n6XBplotGt1P69i2Jxc64wbmKylvGdX6lFK2Q=;
        b=I0UjMoJ9/zlo6mN+jyPvlfb8+5bL32/gziF558IA/B8bl7i8Fh9XMK0dg7MW4B6U1z
         fndkbMCsF3/jC4viOcyRy6ZgwQE3iTuzKP76F0vUz/KmOfF1Z1OPWXh8VJA85Rg0h31P
         QhQnPr+uUwb5qIfCaz3kKYRNsqatrzN1JvbxUNvkSdP45cO9YMumRe7PhVRGb1OrdYcN
         yqGq7iG7zyCUaev/SjTWNyS4EfTwLxyHzCwgEd3WSO1T6Tn69NIpgVNV8VLOClTmIZ1i
         jb3LjzIvpvINz4qD1zt/WGYTVAm+Lu5JqHoGzZkyl9p1Fo40CtmqcSnSNGDeRZBCmQ0m
         8eGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752535911; x=1753140711;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aswGT4n6XBplotGt1P69i2Jxc64wbmKylvGdX6lFK2Q=;
        b=TQHWK3sM5xIJSeKM24ybMIEYAClrOq49kABlTHXk1NWXkuNObI3AdVX5PYESSWeNZ8
         rXb2QxEmFTcHZlNtGewcISTy+7xiwvSINvwZ5oQQrMFEr8kOL/yFI1mT0mHsNuIb0heV
         46GIYyUmkfMdEmO1uqKWFw0u8CA8Qe0s9JmwvNDRSw3m81py87k8Gad03QEr3nuvg400
         3CF7rKPkKBRRjOro0sAB2NIL9sWcWQ/p+BzzVJQe9Wpi6XuvnJoTf05fxRH0l6l9hkeu
         Xwk5e5ybUNj2jqj6vFta5TzYwCbIRJj10NBGtZHXahkyFqftsDzf1LVGrDgo+/uhZnQS
         DNJg==
X-Forwarded-Encrypted: i=1; AJvYcCUBu2kp86ip53dRnzqjt7VBM20VQYk9HlOkytZce1m5FZ4MWQoxtY1UVY8+aAQ0elO+7cnxrc1GqZMgFm6OeaM=@vger.kernel.org, AJvYcCVjny5brLnxSVt8KO2LiaCpm3SdyNqCNmEwaFZFp5hPdINPMdfTpooA4Nm4LPG2S39D8M+gAicaLJ1qaDs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfJX6JiPMVWIo4Vevcd3dwK8TIUNjDa3I3/4SQCyEQUOuNAyOF
	csbqbZiXJgXjc5uFVfJ/5kszuKJ96OKtZ6k076xz1Zg6SDJ0o1+zvZ13F1nYAEAnF7bGOcfBZuP
	daTlcwS81hyDAaX/iUO90fnfQ0d2jC2U=
X-Gm-Gg: ASbGncvjk60EbifLmLb2yBVhwWz4bt/+UgukJ86ladcumz035mEQXInFBdS3S2thhwi
	AV/lAC15ZXKcj8TtIye9+9P3O8lElI3SgzyT9152VWgjLRvRGv0LJ0rT/ru8fAjHj826OM+zfwg
	0wTiLIz1pFKvqY3eOpZRC9qjcf652l8OWGIwmI7NDdjUCHma3jFJUCNdXZrKNIJahdTPKEvK76f
	qxRkce6
X-Google-Smtp-Source: AGHT+IHIEq1inOGlKuw7g3qrwCn1OBeJnYOpvs6/i/7HrepT1d/pQi+yDLO/0GzSeX5sgezj5xjADr58sl5ninR08jA=
X-Received: by 2002:a17:90b:2747:b0:314:29ff:6845 with SMTP id
 98e67ed59e1d1-31c4cce3657mr8967498a91.4.1752535910819; Mon, 14 Jul 2025
 16:31:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250616-userptr-newtype-v3-1-5ff7b2d18d9e@google.com>
In-Reply-To: <20250616-userptr-newtype-v3-1-5ff7b2d18d9e@google.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 15 Jul 2025 01:31:38 +0200
X-Gm-Features: Ac12FXyGSEJpMaOYi_mHrkvH-SRpjq7JEvHXsyUH8zt6u9u17SJ98MTKjyCA8MY
Message-ID: <CANiq72njeRLijF8Vt+Kgv_gCD6O4E67rH87bGOG6mZCs7wS+=g@mail.gmail.com>
Subject: Re: [PATCH v3] uaccess: rust: use newtype for user pointers
To: Alice Ryhl <aliceryhl@google.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>, 
	Andrew Morton <akpm@linux-foundation.org>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Christian Schrefl <chrisi.schrefl@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 16, 2025 at 3:46=E2=80=AFPM Alice Ryhl <aliceryhl@google.com> w=
rote:
>
> Currently, Rust code uses a typedef for unsigned long to represent
> userspace addresses. This is unfortunate because it means that userspace
> addresses could accidentally be mixed up with other integers. To
> alleviate that, we introduce a new UserPtr struct that wraps a raw
> pointer to represent a userspace address. By using a struct, type
> checking enforces that userspace addresses cannot be mixed up with
> anything else.
>
> This is similar to the __user annotation in C that detects cases where
> user pointers are mixed with non-user pointers.
>
> Note that unlike __user pointers in C, this type is just a pointer
> without a target type. This means that it can't detect cases such as
> mixing up which struct this user pointer references. However, that is
> okay due to the way this is intended to be used - generally, you create
> a UserPtr in your ioctl callback from the provided usize *before*
> dispatching on which ioctl is in use, and then after dispatching on the
> ioctl you pass the UserPtr into a UserSliceReader or UserSliceWriter;
> selecting the target type does not happen until you have obtained the
> UserSliceReader/Writer.
>
> The UserPtr type is not marked with #[derive(Debug)], which means that
> it's not possible to print values of this type. This avoids ASLR
> leakage.
>
> The type is added to the prelude as it is a fairly fundamental type
> similar to c_int. The wrapping_add() method is renamed to
> wrapping_byte_add() for consistency with the method name found on raw
> pointers.
>
> Reviewed-by: Benno Lossin <lossin@kernel.org>
> Reviewed-by: Danilo Krummrich <dakr@kernel.org>
> Reviewed-by: Christian Schrefl <chrisi.schrefl@gmail.com>
> Reviewed-by: Boqun Feng <boqun.feng@gmail.com>
> Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>

Applied to `rust-next` -- thanks everyone!

    [ Reworded title. - Miguel ]

Cheers,
Miguel

