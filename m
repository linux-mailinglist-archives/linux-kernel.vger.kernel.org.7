Return-Path: <linux-kernel+bounces-858053-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C21BCBE8AF8
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 15:00:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6AE9D35CA0C
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 13:00:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41409313284;
	Fri, 17 Oct 2025 13:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="D/BQL1Ym"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BFBA2BAF9
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 13:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760706047; cv=none; b=OpSF2X1QuaiyGWxFnm4Wqvuh7KGrreq7EqL6EonExx+FOADoOzbzDDqNvC4Sn6tWnujaRPaWTdzCmdwP5MfEqvnfdloE36/sowQ26trfi2gn9rK5n1nRs+bqxpAFzS3cyTAkqRi00ZViI0dVR9HE7eDDrcOhJuoqsQ0FFjfQ2CU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760706047; c=relaxed/simple;
	bh=yuIGDTY6jcTI4lY1dh0UG8jPw0Yz7dG+/3Lgikhw+xc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=YgW2qeehw7YtvZS7eTgTm5t3HfIfLFrUKu6RDva3824hfWvR5+SYMl5K7tHSETITAtOb93XGWo1BRjj6ztWzBY8HgkTDKs3EnOQGL+gO3H+BUrt5rgbBq4FkRQwTLoQd+AK4cV7xTFoE0Jb6WpX7Ca+5+xSftc0XWo1tWhpOEX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=D/BQL1Ym; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-470fd92ad57so34381445e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 06:00:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760706044; x=1761310844; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=baDIVkL6qPcD3aaf21CtYmUHWqgvKSn4TldyTmiJAq4=;
        b=D/BQL1YmUflwXUD2p/Eepi0h9KPhZzmNPml6AVdxxqVYl6aUaMP2yb7wdMZUb1B6Ps
         oAo6sy4jVFTaX+GfIqRm2yUKEARtbfZp9zgxS9GIWwRhxN5Z2kUkUltsr/6Tl8K200U+
         TbaCqD0hdIlzHVbxo1vT5PQM5E7aNBOOiFycmTCIhRWSaXuvmETnCQsbQDcILWwXZ8fD
         V6aFiEahWjroLcicBOxubB+lGlkXwYC7TxjJ9lKQZBJBUkfk5soGkd6p67ZkG9/jg4TQ
         WQRfO7xfACf4Kn1+qzNMB+vH0sXpU8wC2YoZcXUDKiFQ509uTS2XW+UMJcX8jcTBhIPh
         0EyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760706044; x=1761310844;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=baDIVkL6qPcD3aaf21CtYmUHWqgvKSn4TldyTmiJAq4=;
        b=Ef73zHlew0isFISErnuoLK3OPdDYvr7yFTdGwDNwk2DDkCC/FcJMrcKjn7Nd/3lHxH
         UWEBM1GdB8tDdT8iiioDIKesVdfODTpUZgOlKUObLdzl+O4m1E9gAmcKXw68Ivmrg9ll
         XOaMuUPGS0z5kyzp8ZQhHPe2zjGvUxGl0U7VJJ1jvs6pUzByQOwer9PKNtKtmSt3q3Jl
         w94uVmS/aqVGsmi8TBfTJls+3YLkNe5XQalsBh+D62r/wWHQieYTMwwOZdqSckdrXNIo
         Z3SkM3HiNukR30mfjtFN00DdtmyERAlgM4EUbogtfL5CazthnXj6XlZ/adtsS3jUYwoT
         +A9g==
X-Forwarded-Encrypted: i=1; AJvYcCX7oGReijL4EbaqSRtS66WBirS5D+plnQgDyUTW9XoTC2cTfAz6tJ5Ho5DeTbLuWcHj0oHGIrIdMuD8ZZI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwyvgcDL/BGc5KRs3nDmjxKIz4WPBKnasbzabBEzb3RTG+hQs8
	8YawpNUlDXVtNhqdhOUF5NopgXIS4rjBimND3cGZtgbLcBloZuJf2ld6gn0ooljrNtTw6WW84l+
	W7SBYrbpKA2ft/LAMrQ==
X-Google-Smtp-Source: AGHT+IG1bpI+LaOgjBQH9DFhBzKsJsdJgEyfHVAfJovk5BppUcFq8EGVxjZ3CA5D51LlfBkl3vOBFoQyKjneobc=
X-Received: from wmbid20.prod.google.com ([2002:a05:600c:a194:b0:45f:2b4d:3c2b])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:64cf:b0:471:12ed:f698 with SMTP id 5b1f17b1804b1-4711786c793mr28292685e9.8.1760706044065;
 Fri, 17 Oct 2025 06:00:44 -0700 (PDT)
Date: Fri, 17 Oct 2025 13:00:43 +0000
In-Reply-To: <20251003222729.322059-7-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251003222729.322059-1-dakr@kernel.org> <20251003222729.322059-7-dakr@kernel.org>
Message-ID: <aPI9-_6k4ZUKtA1C@google.com>
Subject: Re: [PATCH 6/7] rust: debugfs: support binary large objects for ScopedDir
From: Alice Ryhl <aliceryhl@google.com>
To: Danilo Krummrich <dakr@kernel.org>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, ojeda@kernel.org, 
	alex.gaynor@gmail.com, boqun.feng@gmail.com, gary@garyguo.net, 
	bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org, 
	tmgross@umich.edu, mmaurer@google.com, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Sat, Oct 04, 2025 at 12:26:43AM +0200, Danilo Krummrich wrote:
> Add support for creating binary debugfs files via ScopedDir. This
> mirrors the existing functionality for Dir, but without producing an
> owning handle -- files are automatically removed when the associated
> Scope is dropped.
> 
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> ---
>  rust/kernel/debugfs.rs | 45 ++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 45 insertions(+)
> 
> diff --git a/rust/kernel/debugfs.rs b/rust/kernel/debugfs.rs
> index 3c3bbcc126ef..0eb1719e4953 100644
> --- a/rust/kernel/debugfs.rs
> +++ b/rust/kernel/debugfs.rs
> @@ -531,6 +531,20 @@ pub fn read_only_file<T: Writer + Send + Sync + 'static>(&self, name: &CStr, dat
>          self.create_file(name, data, &T::FILE_OPS)
>      }
>  
> +    /// Creates a read-only binary file in this directory.
> +    ///
> +    /// The file's contents are produced by invoking [`BinaryWriter::write_to_slice`].
> +    ///
> +    /// This function does not produce an owning handle to the file. The created file is removed
> +    /// when the [`Scope`] that this directory belongs to is dropped.
> +    pub fn read_binary_file<T: BinaryWriter + Send + Sync + 'static>(
> +        &self,
> +        name: &CStr,
> +        data: &'data T,
> +    ) {
> +        self.create_file(name, data, &T::FILE_OPS)

Why isn't <T as MyTrait> need here when it's needed for the other
methods?

Alice

