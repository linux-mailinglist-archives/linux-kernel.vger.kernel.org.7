Return-Path: <linux-kernel+bounces-825852-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BCEB6B8CF2E
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 21:34:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60E5D5672CE
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 19:34:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBBA61E1DF0;
	Sat, 20 Sep 2025 19:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ThL1ZGvE"
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AD8B1F582B
	for <linux-kernel@vger.kernel.org>; Sat, 20 Sep 2025 19:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758396850; cv=none; b=LM+S74olUhFPJplMJaAtSsBzAS4puTODjMUuLbYUE0EutabP8EqG27/H0eM0oQ5BOaRCBRNTVDjnmQQ6+zP/u2hykiCNtFy0h+WN+iYVBQ7nVgX3rCgJqPrPfffkeTEHwFDV/389qUPeeV9RCqoFJBSDC6GbTDVpfS3ovOUFjFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758396850; c=relaxed/simple;
	bh=DoTNAuOzU3EjzBg6upNXUalp/TGhCZnHU6ZjgCgRCWw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jvHiyDpfqh19b/qB9DdMypQ4FoJMrRx0JXuY6Iarf25a1lMo2Tqg3tWHGD1caiz85xypHTWCbjhuSNBzJNnTrI6HEEuxZxwGweTbhbafLLkCCWiUySYjr58zUUW66jx0YQPlZl8+NngzaRNBOJ6DGAuY7rcPl4KVDdlg/oYTOKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ThL1ZGvE; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-807e414bf03so431667585a.0
        for <linux-kernel@vger.kernel.org>; Sat, 20 Sep 2025 12:34:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758396847; x=1759001647; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n6xkL+e5O5vlTy5zdD2Q5ov6tJYSg710f4pj8Zlx3T8=;
        b=ThL1ZGvE4lIse44xJWlbqnto3C7ta9GnK9e51vY+VDMRJJnNNbGm2jWsTRqN9MfaUl
         Herl4zlf8nNkXSPnXB6kwNE9oDfyTWSYvWU8e4b6LqRkPMQso4jvahCa2Kfs6zHntO4/
         fZWk9cyBUfaynYCaLavhOSesD9We4JAnqYFGOnj9BDaWhZJvkJMKhftmV9nB5r2rx1Qm
         Dckpw5ZJ9cHEMfsOVX7AdsrICJQdXhwZWR7mNBG1Zz4LJNej7riNgXv6l7KYcu4fyu22
         SzK4wgKiqqLhkxMMbWIbAzZLS6FFYLfwKM1YckLo/y8VtO+e700KJbWCrVUOGuEjf0L/
         fdQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758396847; x=1759001647;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n6xkL+e5O5vlTy5zdD2Q5ov6tJYSg710f4pj8Zlx3T8=;
        b=Om2/6cLUKHbflVLomv12ImE54ghWmKx+mYHYCmgJALGYxz9iJCFEArwoGhR4qQQEki
         VlB8vaZO6FPuxmZaAXKZUsI4cW6DFdSf+BiBmvGD3t4u15BbKUW5f72ElAny69Yqn6Mn
         JxU7U43u5bZNpqo5hukhmTcC4r7zZ2sTsoFZ42rV+3BnCSXlu5eS4GdCZv2uH38OO5GO
         bxA1jLaD9Qod1XFTD5p+i7hGW2RP50hfaxswjEa1BJ7LDg4s+b/0oLpucUq5Peynq10m
         wLWk79/lJNKDcw4Hk3yU/hMeZKxulaLgXQwjnAZsYu/N/hfNpKU4uyl/9hIPwct5yis2
         AWgg==
X-Gm-Message-State: AOJu0YwBWUhvFevXbb8SrORVCM4iT/uJHUR1hLu1z9UZ5TppNL+L83B9
	qss2BRPUvY0rkHhgLrsC24qM1hO3Q043ZiHTeOLohfmKhEQenbg5rpbQ
X-Gm-Gg: ASbGnctIZoEtDO62KZaG2MLNGt7VQ11EkbmnoRgdQWfFXHKS5u0yQulDgDWUYNttplC
	8hCeG8xAS8E8Ooezogh8VQ4GmzIfh8XAdEIXr04q/xJmyseX7/rG/oLynlnR62YaZbp7y88FFRQ
	tin1uBmyWG4HXh1X+Q7ztVfR4by0sM+EX+zu+q3TDinvHWHXxOtKw3u0ZeMuKvAUpiT8J7XsLzN
	/6ilPdih4doj+er5FBp481U4HxOOhx1HvelRSGAlsaoDHDTZbBp3ydCbqYcYqLVkpfnBl1bnjV9
	Y6SMsmU7Cjvzo/l9HzU83wz0TM9IOtd88GE/eWobSUV0sA6fSi6TFUE2GowLcF4WWopjIzX0xhO
	zjoryAy6nAoprqctsNcbh8JzognLXfjJb9dVbJT/+CxrHE93bSUXDYY2iDrwX15EtmKy9LdLaKC
	wnYVcKMm6p58Pi58lIGEzzzJ8=
X-Google-Smtp-Source: AGHT+IEZ3ARjfpVbgZ/4uoIhuTXWTeNbTj8D7ABJ4oL8uHI3L/hqSdCbTWjJZYPEjVZyP1PBOfYVEw==
X-Received: by 2002:a05:620a:19a1:b0:829:217e:eab1 with SMTP id af79cd13be357-83bac4afcf3mr923599085a.80.1758396847085;
        Sat, 20 Sep 2025 12:34:07 -0700 (PDT)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-836278b77fasm553972285a.23.2025.09.20.12.34.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Sep 2025 12:34:06 -0700 (PDT)
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfauth.phl.internal (Postfix) with ESMTP id 0CB2CF40067;
	Sat, 20 Sep 2025 15:34:06 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Sat, 20 Sep 2025 15:34:06 -0400
X-ME-Sender: <xms:rQHPaKwCKt3N-GUnLOJz-noJBB3oX8m4GBwhQTxh7XYPhHjmMJ9dkA>
    <xme:rQHPaL0KjTucS_1d7sQvuZCDobgKL0fqEL1681k3aFWExKwZzOtMb6wYS6wuMubrp
    -VZLPnZaatViWzkgQ>
X-ME-Received: <xmr:rQHPaF7oQPOcWZcvoGgn2odVGXgNojqDtxEIdmX4NEsOyyvZm4i3m9YUWZOymIogoBEiFYJqvbkaJL-g9GhwOEsxK52MX4dy>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdehvdelgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhquhhnucfh
    vghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrthhtvg
    hrnhephedugfduffffteeutddvheeuveelvdfhleelieevtdeguefhgeeuveeiudffiedv
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghoqh
    hunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieegqddu
    jeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigihmvg
    drnhgrmhgvpdhnsggprhgtphhtthhopeduiedpmhhouggvpehsmhhtphhouhhtpdhrtghp
    thhtohepjhhovghlrghgnhgvlhhfsehnvhhiughirgdrtghomhdprhgtphhtthhopehlih
    hnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopeho
    jhgvuggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegrlhgvgidrghgrhihnohhrse
    hgmhgrihhlrdgtohhmpdhrtghpthhtohepghgrrhihsehgrghrhihguhhordhnvghtpdhr
    tghpthhtohepsghjohhrnhefpghghhesphhrohhtohhnmhgrihhlrdgtohhmpdhrtghpth
    htoheplhhoshhsihhnsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegrrdhhihhnuggs
    ohhrgheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghlihgtvghrhihhlhesghhooh
    hglhgvrdgtohhm
X-ME-Proxy: <xmx:rQHPaBailX2lvoKSZAppwPnGJJpmQdAkka0NnNE-V2ghEdFl_gvMdw>
    <xmx:rQHPaDTjmd654q-jkRoYqgGgTTSkNvxGIaxiMGWeqv2SS2MJq7CRcg>
    <xmx:rQHPaOLA_GbuxPT-FoB2peBSmutWuYcg-ohgaLXnnvLa-o8yU6uZxw>
    <xmx:rQHPaBVqQIs7I9T6iQsUxZFLiuTVnMLSILhk1XMeqbZeODQG-DpfzQ>
    <xmx:rgHPaCiHUGehw2u-RgrzT9mTKuk9PMnJFFNB1RIyy329up8zkiyEo60h>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 20 Sep 2025 15:34:05 -0400 (EDT)
Date: Sat, 20 Sep 2025 12:34:04 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Joel Fernandes <joelagnelf@nvidia.com>
Cc: linux-kernel@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>, acourbot@nvidia.com,
	Alistair Popple <apopple@nvidia.com>, Timur Tabi <ttabi@nvidia.com>,
	rust-for-linux@vger.kernel.org
Subject: Re: [PATCH] rust: print: Fix issue with rust_build_error
Message-ID: <aM8BrIT1clk_efE6@tardis.local>
References: <20250920161958.2079105-1-joelagnelf@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250920161958.2079105-1-joelagnelf@nvidia.com>

On Sat, Sep 20, 2025 at 12:19:58PM -0400, Joel Fernandes wrote:
> When printing just before calling io.write32(), modpost fails due to
> build_assert's missing rust_build_error symbol. The issue is that, the
> printk arguments are passed as reference in bindings code, thus Rust
> cannot trust its value and fails to optimize away the build_assert.
> 

I think "cannot trust" is a bit vague and misleading here, for this
kind of "workaround", we want the reason to be a bit clear. @Gary, could
you help explain it a bit more?

> The issue can be reproduced with the following simple snippet:
>   let offset = 0;
>   pr_err!("{}", offset);
>   io.write32(base, offset);
> 
> Fix it by just using a closure to call printk. Rust captures the
> arguments into the closure's arguments thus breaking the dependency.
> This can be fixed by simply creating a variable alias for each variable
> however the closure is a simple and concise fix.
> 

Similar here, "breaking the dependency" and "creating a variable alias"
can be described more accurately, e.g. the latter can be "creating a new
binding".

All in all, we need to establish a wide understanding of the issue and
agree on a reasonable fix. But anyway, thank Joel for doing this ;-)

Regards,
Boqun

> Another approach with using const-generics for the io.write32 API was
> investigated, but it cannot work with code that dynamically calculates
> the write offset.
> 
> Disassembly of users of pr_err!() with/without patch shows identical
> code generation, thus the fix has no difference in the final binary.
> 
> Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
> ---
>  rust/kernel/print.rs | 44 ++++++++++++++++++++++++--------------------
>  1 file changed, 24 insertions(+), 20 deletions(-)
> 
> diff --git a/rust/kernel/print.rs b/rust/kernel/print.rs
> index 2d743d78d220..5847942195a7 100644
> --- a/rust/kernel/print.rs
> +++ b/rust/kernel/print.rs
> @@ -143,34 +143,38 @@ pub fn call_printk_cont(args: fmt::Arguments<'_>) {
>  #[expect(clippy::crate_in_macro_def)]
>  macro_rules! print_macro (
>      // The non-continuation cases (most of them, e.g. `INFO`).
> -    ($format_string:path, false, $($arg:tt)+) => (
> +    ($format_string:path, false, $($arg:tt)+) => ({
>          // To remain sound, `arg`s must be expanded outside the `unsafe` block.
>          // Typically one would use a `let` binding for that; however, `format_args!`
>          // takes borrows on the arguments, but does not extend the scope of temporaries.
>          // Therefore, a `match` expression is used to keep them around, since
>          // the scrutinee is kept until the end of the `match`.
> -        match $crate::prelude::fmt!($($arg)+) {
> -            // SAFETY: This hidden macro should only be called by the documented
> -            // printing macros which ensure the format string is one of the fixed
> -            // ones. All `__LOG_PREFIX`s are null-terminated as they are generated
> -            // by the `module!` proc macro or fixed values defined in a kernel
> -            // crate.
> -            args => unsafe {
> -                $crate::print::call_printk(
> -                    &$format_string,
> -                    crate::__LOG_PREFIX,
> -                    args,
> -                );
> +        (|| {
> +            match $crate::prelude::fmt!($($arg)+) {
> +                // SAFETY: This hidden macro should only be called by the documented
> +                // printing macros which ensure the format string is one of the fixed
> +                // ones. All `__LOG_PREFIX`s are null-terminated as they are generated
> +                // by the `module!` proc macro or fixed values defined in a kernel
> +                // crate.
> +                args => unsafe {
> +                    $crate::print::call_printk(
> +                        &$format_string,
> +                        crate::__LOG_PREFIX,
> +                        args,
> +                    );
> +                }
>              }
> -        }
> -    );
> +        })();
> +    });
>  
>      // The `CONT` case.
> -    ($format_string:path, true, $($arg:tt)+) => (
> -        $crate::print::call_printk_cont(
> -            $crate::prelude::fmt!($($arg)+),
> -        );
> -    );
> +    ($format_string:path, true, $($arg:tt)+) => ({
> +        (|| {
> +            $crate::print::call_printk_cont(
> +                $crate::prelude::fmt!($($arg)+),
> +            );
> +        })();
> +    });
>  );
>  
>  /// Stub for doctests
> -- 
> 2.34.1
> 

