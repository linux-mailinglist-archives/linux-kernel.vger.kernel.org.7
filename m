Return-Path: <linux-kernel+bounces-723708-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C7159AFEA24
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 15:28:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2824A1C43FDD
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 13:26:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA3342E54B8;
	Wed,  9 Jul 2025 13:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Q/3Ss61z"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54FBB2DEA7C
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 13:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752067513; cv=none; b=TSrRR/a/CJ1g1AHzdB8vyhvEQu/9nKI5UTumXbgX1AYcWunEqk4W2iqhAlogcFKhfQUv0K/hHYCOggwyhzudzvXgh6UMJCHKlA6ZCOfBSOpYxgm2icLcLLt8gedYMKn2zS9I+8ZbNQRln6mZAYSKHavFP05yjaCCwlcnzfm8TxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752067513; c=relaxed/simple;
	bh=NHNbSrqTeMsIn0Slu2oKDt0QDZh47Zum79PAprUdfFY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=nxZc2WG8diVA1JRH03cy4DDE6lqA7zgQwR/kGEU+2tqlW1fnlwdAHPBMK2fFP5j8nSH43hPjobn7Wj2p2+4qe0k84HkWCo8yxIN3Eq7adcrXeogyPhXs8fcEUQodmDguKc2LzslU54jZESiIswvzytSzBocUXlUR1A/SL+5oLcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Q/3Ss61z; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-454b907e338so35487935e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jul 2025 06:25:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752067510; x=1752672310; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=XXIlm31EilbmsYU5xvHTfVZMMQy9qv0LqnF1DXKbnRA=;
        b=Q/3Ss61zr1+8/ManDKoeOs/xHnCPg6+AgeC0y80ks7mHCGSQGxb/HzNjfr057Cw2u5
         2rUt7M6fr9eVnFerLOLZhG/JZbG3zLQrRDGAIAxr6oRMgpNUkdW91RbJr6+cMHPcEztp
         bykdVyLbz+WznjbnDQDFvtmAZD5krCj8g47boJSkHtNMYnGa6s+oS6tE0Qrn+U5Pub0i
         nMY2yfTDqxKR1b4RqhX3qswzd6HE0XL2KmyC3b97dwgAXoAM/3DnU0T0zyqwygUt7Q99
         1EMkEG2cN4/PwCQVMJrHjr3jImoWsU3AB7Zzqn3czc0kAknCI6Mc9qTm6DM2E9PcwbIM
         /fUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752067510; x=1752672310;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XXIlm31EilbmsYU5xvHTfVZMMQy9qv0LqnF1DXKbnRA=;
        b=GmydkXbVrK9+i1omJPrxXc5M8y9JxgULgKlsFJbWIZJzpyeOA3AlCZRiWFZ5XQGqu7
         Hm4GjTHUYnJ7fB/5x6NsXiach/TQzQjH7qKy1oTLa129KtAMWiyD/ibjuWjCXQBry1Sd
         pMreIb+AGiROuI+/9PzoSum/7rn0+LJOFdrvxMOOUq2QNYHrGsegO1bb4L0YQwzGDNt9
         aBHByrGHc6KhqtT2ZmUBtdm30il2eHyUdjc51Kork9GB/TZZGX7bYvTPXvCTpKTceJdm
         QAF/nEVrSm0UN+1uAX0dwlit01KPd+bR8ONjSeMq+Uw1SsWTqucLpG5nGvvi6t/YHFA+
         /UqQ==
X-Forwarded-Encrypted: i=1; AJvYcCWUdvqq+20x1twIDl+n6T234HeuRXm6UqYwUTam2i8e0hG0oCAydTY6+JUJQ84YiMJuMzeiYS3Rd5bnUXE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPLkrY1uq7/WTjviseSmEtHZ6KHUCHVXQQILSsckyhcU9dVsaZ
	rAoc6nciXDDtMy1UmaKbXG7LEO+1vEp7kR3U1J+eZ9c/npvLNk+Z71Fw/EJthxDZ5gf//PHsdz6
	1ocQaqM1Or+cCoQyAXg==
X-Google-Smtp-Source: AGHT+IHPHqf0UCSK/HlZxzPJodC8GgYw3644TdfQ+Ny0ndQqa0F+bXEPu1xA9YYDu6mVQp5mBA2+jSnEsE+oo9M=
X-Received: from wrod11.prod.google.com ([2002:adf:ef8b:0:b0:3b3:9c56:9547])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:26ca:b0:3a3:7115:5e7a with SMTP id ffacd0b85a97d-3b5e452bc17mr2122006f8f.42.1752067509573;
 Wed, 09 Jul 2025 06:25:09 -0700 (PDT)
Date: Wed, 9 Jul 2025 13:25:08 +0000
In-Reply-To: <20250708-rnull-up-v6-16-v2-5-ab93c0ff429b@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250708-rnull-up-v6-16-v2-0-ab93c0ff429b@kernel.org> <20250708-rnull-up-v6-16-v2-5-ab93c0ff429b@kernel.org>
Message-ID: <aG5ttHBYW3SQlSv7@google.com>
Subject: Re: [PATCH v2 05/14] rust: block: use `NullBorrowFormatter`
From: Alice Ryhl <aliceryhl@google.com>
To: Andreas Hindborg <a.hindborg@kernel.org>
Cc: Boqun Feng <boqun.feng@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	linux-block@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Tue, Jul 08, 2025 at 09:45:00PM +0200, Andreas Hindborg wrote:
> Use the new `NullBorrowFormatter` to write the name of a `GenDisk` to the
> name buffer. This new formatter automatically adds a trailing null marker
> after the written characters, so we don't need to append that at the call
> site any longer.
> 
> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
> ---
>  rust/kernel/block/mq/gen_disk.rs   | 8 ++++----
>  rust/kernel/block/mq/raw_writer.rs | 1 +
>  rust/kernel/str.rs                 | 7 -------
>  3 files changed, 5 insertions(+), 11 deletions(-)
> 
> diff --git a/rust/kernel/block/mq/gen_disk.rs b/rust/kernel/block/mq/gen_disk.rs
> index 679ee1bb21950..e0e42f7028276 100644
> --- a/rust/kernel/block/mq/gen_disk.rs
> +++ b/rust/kernel/block/mq/gen_disk.rs
> @@ -7,9 +7,10 @@
>  
>  use crate::{
>      bindings,
> -    block::mq::{raw_writer::RawWriter, Operations, TagSet},
> +    block::mq::{Operations, TagSet},
>      error::{self, from_err_ptr, Result},
>      static_lock_class,
> +    str::NullBorrowFormatter,
>      sync::Arc,
>  };
>  use core::fmt::{self, Write};
> @@ -143,14 +144,13 @@ pub fn build<T: Operations>(
>          // SAFETY: `gendisk` is a valid pointer as we initialized it above
>          unsafe { (*gendisk).fops = &TABLE };
>  
> -        let mut raw_writer = RawWriter::from_array(
> +        let mut writer = NullBorrowFormatter::from_array(
>              // SAFETY: `gendisk` points to a valid and initialized instance. We
>              // have exclusive access, since the disk is not added to the VFS
>              // yet.
>              unsafe { &mut (*gendisk).disk_name },
>          )?;
> -        raw_writer.write_fmt(name)?;
> -        raw_writer.write_char('\0')?;
> +        writer.write_fmt(name)?;

Although this is nicer than the existing code, I wonder if it should
just be a function rather than a whole NullBorrowFormatter struct? Take
a slice and a fmt::Arguments and write it with a nul-terminator. Do you
need anything more complex than what you have here?

Alice

