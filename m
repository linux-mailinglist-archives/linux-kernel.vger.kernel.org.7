Return-Path: <linux-kernel+bounces-838030-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA9F7BAE44A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 20:03:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6355016C52B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 18:03:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 190E726E6EB;
	Tue, 30 Sep 2025 18:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HuYkwP2j"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6601269CE1
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 18:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759255422; cv=none; b=BAeP5HzjbgxszNVoj4XGkxBWyabfP5EPsL8ggwHylVqZFt0hWfk9VoH5GEMEixFTRPN6CQNI9ganhkQZEj28C6ysGTBXDgOcce0AaHn7hCXHmSAuruWQ/8kRCIPc70R2yZnGoj1oj+N0lWlTTMRo68xkicU5wUHXAt5jm39jhck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759255422; c=relaxed/simple;
	bh=o/tyxP0U536RGB7W21MbYDAtzb/vpg8C5OXT9teXWqc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C58henD/U1p15y4D1bE4LMslMnwq8yn9qf95LgjOcz3KGhPP8CG4h6d17DlAej9YGhNzNAn9OWrZ2/mJ52jhIzRRLjvRCr71Pm2cRGsxbt3kNszPbRTCVtS9p67RHeT+YKCFP+Veo9O2FtygVBPjKHfnAtRZxEQQqKSQCb9bjiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HuYkwP2j; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-77e87003967so3205623b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 11:03:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759255420; x=1759860220; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0kzqY2GXdADZuJoQ7BaFhRIAR3HFmpw/5lK4k+D6Ym4=;
        b=HuYkwP2j7F2VTsqdZDhDVBQBtmgMyB5pUHNKio97pOlbipxsR37szEF6YqyacyQel6
         SVWUQvIVZPGiB3Db9SRa01sVI6A3uJcziLV05vg0aTRuxYLbaZDkkXXa4rJ7vp3baCxK
         zz6ZHPv8N8M2EuMaiq2hfI61keW0qLnEpRU9MJNflkzqJNUhGpcsWYih5t0Jrd0ZyO4B
         pIYUZNRzdtMuTtUl6JmC7210GH5WJYJzQyCaDT+45RjJWyVVVFw/VALWrKZ70M/d7pmq
         UrnExXjbkNYCvwRtZUX3GaFoJewAknRRLjbscqZa2stC6XNXJnJ5WjpO8ZzDi0HLQUVp
         +NFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759255420; x=1759860220;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0kzqY2GXdADZuJoQ7BaFhRIAR3HFmpw/5lK4k+D6Ym4=;
        b=oZEZZczYKcEw5a8Cd9RgWmJj0N7oKWbzsGo+H0r+A+XlF8cB5DtVQPM5D8/WSs+pI1
         f+1mmEJaJDCtEVkuxWve7c8+dQqD9A+vmjaurCbg+88vyLZEzmtKmE7xi0jOcF7Bslzb
         8LRsL7+P4ry8idXeS02ZPu9jl+P95cUnpE0uUjMIWk7heo3ZcnB9fXuzIj1QuZFltJ+0
         KD6Lk0nRytOJ0yo7nLdGl5rQMwTPRyGi+vVuj1i1pghEN6qGe/qFz/HR3lwd3kLQhxsJ
         SExYayP783j6RKfPYWHJ0lUa9KA/FbGwom4W/4wNzPQ5mhqyjlyQxkvz2mw8wusBRlKh
         B8RQ==
X-Gm-Message-State: AOJu0YxKxPW7kysAJTKXWO48wdbik1JKdeniJEfmA+fFjfMZ1Lc+JEIA
	KZXMBUo6iaYfG9ar+cR1QyrIZ3JMWc5ymYUtbBp3h8Lv8CHM1gC1X8LE
X-Gm-Gg: ASbGnctqzw1hLK2i1GJ/J3Fj3hPwhldJxbw5x8DQ9mfcVKSA4aIv0HlXhV4KcqsPIhv
	ziRPkjQ4z0Y1SJpLjqPZ6+nEQ5Dd+gWKdOYSW54EjculoAWalul9C4mb/lV1qtRItdZYrKMjC7D
	hPhmc6VHfFd79i9ke17aT37oic7d6JXhjwx8Q4xW18vFskRtuWylThftAc+xyyP8Tt00islZQ9N
	Ef4yucsAJllkkkRloowSCZuAqUeuPxFzho2J7RNLXEWQtzWdZ6+1ZbE7QJmIcjfREOE1nqckLza
	K8QV5YaOgNh6ycnXa9165Sj58MOMXZ2P3xsB87vc58cwWBtNih6NNqlPIQnTr2QLniWSmHM1Aqx
	2OzXGWSAsDiy9o3qlieMdS178JWieStaxEstr4fIC46oLd/qxf01cIn44Bir1ceudtBc=
X-Google-Smtp-Source: AGHT+IGlqklnb+3B8yX2mbys2RSKE1rUzSRhGovSCTwzJgtKy5reTE4M+Y3TOYyZYCHCr6FA4M71yg==
X-Received: by 2002:a05:6a20:6a1f:b0:2df:37cb:6b73 with SMTP id adf61e73a8af0-321d7f8c0cbmr788120637.11.1759255419738;
        Tue, 30 Sep 2025 11:03:39 -0700 (PDT)
Received: from localhost ([216.228.125.130])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-78102c06fe8sm14239678b3a.77.2025.09.30.11.03.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Sep 2025 11:03:38 -0700 (PDT)
Date: Tue, 30 Sep 2025 14:03:37 -0400
From: Yury Norov <yury.norov@gmail.com>
To: Joel Fernandes <joelagnelf@nvidia.com>
Cc: linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
	dri-devel@lists.freedesktop.org, dakr@kernel.org,
	acourbot@nvidia.com, Alistair Popple <apopple@nvidia.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	bjorn3_gh@protonmail.com, Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	John Hubbard <jhubbard@nvidia.com>, Timur Tabi <ttabi@nvidia.com>,
	joel@joelfernandes.org, Elle Rhumsaa <elle@weathered-steel.dev>,
	Daniel Almeida <daniel.almeida@collabora.com>,
	Andrea Righi <arighi@nvidia.com>, nouveau@lists.freedesktop.org
Subject: Re: [PATCH v5 8/9] rust: bitfield: Add hardening for out of bounds
 access
Message-ID: <aNwbeQ6iXuKIsQHK@yury>
References: <20250930144537.3559207-1-joelagnelf@nvidia.com>
 <20250930144537.3559207-9-joelagnelf@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250930144537.3559207-9-joelagnelf@nvidia.com>

On Tue, Sep 30, 2025 at 10:45:36AM -0400, Joel Fernandes wrote:
> Similar to bitmap.rs, add hardening to print errors or assert if the
> setter API is used to write out-of-bound values.
> 
> Suggested-by: Yury Norov <yury.norov@gmail.com>
> Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
> ---
>  rust/kernel/bitfield.rs    | 32 +++++++++++++++++++++++++++++++-
>  security/Kconfig.hardening |  9 +++++++++
>  2 files changed, 40 insertions(+), 1 deletion(-)
> 
> diff --git a/rust/kernel/bitfield.rs b/rust/kernel/bitfield.rs
> index a74e6d45ecd3..655f940479f1 100644
> --- a/rust/kernel/bitfield.rs
> +++ b/rust/kernel/bitfield.rs
> @@ -29,6 +29,20 @@ pub const fn into_raw(self) -> T {
>      }
>  }
>  
> +/// Assertion macro for bitfield
> +#[macro_export]
> +macro_rules! bitfield_assert {
> +    ($cond:expr, $($arg:tt)+) => {
> +        #[cfg(CONFIG_RUST_BITFIELD_HARDENED)]
> +        ::core::assert!($cond, $($arg)*);
> +
> +        #[cfg(not(CONFIG_RUST_BITFIELD_HARDENED))]
> +        if !($cond) {
> +            $crate::pr_err!($($arg)+);
> +        }
> +    }
> +}

Can you discuss performance implication? I'm OK if you decided to make
the check always on, but we need to understand the cost of it.

>  /// Bitfield macro definition.
>  /// Define a struct with accessors to access bits within an inner unsigned integer.
>  ///
> @@ -358,9 +372,25 @@ impl $name {
>          $vis fn [<set_ $field>](mut self, value: $to_type) -> Self {
>              const MASK: $storage = $name::[<$field:upper _MASK>];
>              const SHIFT: u32 = $name::[<$field:upper _SHIFT>];
> +            const BITS: u32 = ($hi - $lo + 1) as u32;
> +            const MAX_VALUE: $storage =
> +                if BITS >= (::core::mem::size_of::<$storage>() * 8) as u32 {

If BITS > storage then it should be a compile time error. Can you
elaborate under which condition this check makes sense, and is not
covered with the "(1<<BITS) - 1" case?

> +                    !0
> +                } else {
> +                    (1 << BITS) - 1
> +                };
> +
> +            // Check for overflow - value should fit within the field's bits.
>              // Here we are potentially narrowing value from a wider bit value
>              // to a narrower bit value. So we have to use `as` instead of `::from()`.

The new comment sounds opposite to the old one: if you check for
overflow, then there's no chance to "potentially narrow the value".

This "potentially" wording simply means undefined behavior.

> -            let val = ((value as $storage) << SHIFT) & MASK;
> +            let raw_field_value = value as $storage;
> +
> +            $crate::bitfield_assert!(
> +                raw_field_value <= MAX_VALUE,
> +                "value {} exceeds {} for a {} bit field", raw_field_value, MAX_VALUE, BITS
> +            );

Can you hide all the internals in the assertion function? Like:

            $crate::bitfield_set_assert!(bitfield, field, value, "your message", ...);

We don't need assertion implementation in the main function body.

> +
> +            let val = (raw_field_value << SHIFT) & MASK;
>              let new_val = (self.raw() & !MASK) | val;
>         all the internals in the assertion     self.0 = ::kernel::bitfield::BitfieldInternalStorage::from_raw(new_val);

User wants to set an inappropriate value, and you know that because
you just have tested for it. But here you're accepting a definitely
wrong request. This doesn't look right.

On previous rounds you said you can't fail in setter because that
would break the "chain of setters" design. I understand that, but I
think that it's more important to have a clear defensive API that
returns an error when people do wrong things.

So please either find a way to return an error from the setter, or
some other mechanism to abort erroneous request and notify the user.

This "chain of setters" thing looks weird to me as I already said. So
if it messes with a clear API, just drop it.

And to that extend,

        a = a.set_field1()

looks more questionable than just

        a.set_field1()

because it implies an extra copy. If I do 

        b = a.set_field1()

would it change the content of 'a'?

Can I do just 'a.set_field1()'? There's no such an example in your
test.

Is that 'a = a.set_field()' thing really a zero-cost comparing to just
'a.set_field()'? Can you ensure it holds, say, on 32-bit machine when
'a' is a 64-bit bitfield? Would it work if we decide to support
bitfields larger than 64-bit, like C does?

Thanks,
Yury

> diff --git a/security/Kconfig.hardening b/security/Kconfig.hardening
> index 86f8768c63d4..e9fc6dcbd6c3 100644
> --- a/security/Kconfig.hardening
> +++ b/security/Kconfig.hardening
> @@ -265,6 +265,15 @@ config RUST_BITMAP_HARDENED
>  
>  	  If unsure, say N.
>  
> +config RUST_BITFIELD_HARDENED
> +	bool "Check integrity of bitfield Rust API"
> +	depends on RUST
> +	help
> +	  Enables additional assertions in the Rust Bitfield API to catch
> +	  values that exceed the bitfield bounds.
> +
> +	  If unsure, say N.
> +
>  config BUG_ON_DATA_CORRUPTION
>  	bool "Trigger a BUG when data corruption is detected"
>  	select LIST_HARDENED
> -- 
> 2.34.1

