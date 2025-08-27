Return-Path: <linux-kernel+bounces-788683-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE17DB388A9
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 19:30:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78AAF5E47E9
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 17:30:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF60A2C15AE;
	Wed, 27 Aug 2025 17:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="02oNzWZg"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADADE273D68
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 17:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756315833; cv=none; b=TJ2Mzmtmtz3SKtNpJ4az6P6ysJ39YunYsPWV1ZdLDKFandwvA8XPvok9jAnpaBDEfPG9XYlUzleEU1KK6xnx7n/AEJ++8VweuPFp/+4TKt2HjmaedHdYV3m1eTx9qaEHm03QzkYvYPlBlz3zFr1KYn3XbuFBWcpi8Ve3eafXYK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756315833; c=relaxed/simple;
	bh=10JvqHYd1g2pjuuvL77GTnpK9XnQZIJBzWWTfyesHUc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R6+Sj+y4M/DCyJp1EzJTIOb5F1fWku43g7lVT0A1PYafjbvn8pMjn1U2EVbzvUFOjIHNWrwOtR0N9cpSSjGsALjsQDg50H27c9o0jcSV5aCVJZnX3DQHbm06FieVnL+5mHU/khQKireVqvjhXtP33zcOJ2WQQBT+SUWYOkEVy1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=02oNzWZg; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-45a1b066b5eso291525e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 10:30:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756315829; x=1756920629; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uYYctumKADjof5tvwCf6IXKsYDBtRsoy66Tbx2zq3Nc=;
        b=02oNzWZgDKxeUYLeYZyxfXCaHRhyCnCH+OYgwfnV3ouZgExBwMZ9lwVT4FhWKnAWpS
         z2KZtm3ttWwDECG78NqcfYnodz9aFbPIJ9UOZk+vvOzbEnrTUh3/I7Ijv41Z4dchOqVb
         EpR4dlJjHAq/GXbMMqSxR2dYC5JkM98dMRAN1vCnOGvraRxCoKKVDlCLTEam3BTh/yma
         YR30vNcoi8jyVCvcYoeTxmhfQf7jyWB7nE4TM0MI6VtvSAM9UL37udXJdPRywgUNpoJe
         oEryLTwQw0QjZr48HwGz4S8khNRf3Tkf7SN8HWcU2jcimhtNGXroinoCfknGFFXKasfm
         64JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756315829; x=1756920629;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uYYctumKADjof5tvwCf6IXKsYDBtRsoy66Tbx2zq3Nc=;
        b=wmGlJMyYm6ds7VmRRwq7KSl2wiJ6zwkZ11mtGeehHHv1LM5iU1VIGfVQ1ho4l6+pU4
         eZagn9O/YPOkYeqgNJ2EElw+QgzaiKhuOjJxQ6gaug+HYdhUeFux6Wx6MZcW6rk7PpRX
         6mgydXah1dnMlVswTNV2cKY350wFIEMgsPNCPzch/6d2Ih+Gio25dxyqcI+1WHvtWTMU
         dbILCIH3yigR5fokukE852QcbYb0gt4HTmegH7+lElAmk0WmSlBlr7z3/pXkQJmN9v8s
         6AHXGECqI3WcZfPi0/qhAe5nnppgRyJ9tUS+ezgz7uGjss9EQNYGUEy5SDOnGeseM9RT
         rvcg==
X-Forwarded-Encrypted: i=1; AJvYcCVs7P6MCvLhpwI0rTSHPTCKjxwnpgs5ld4kuD7/WKovWhrolTIhjyzcOU3YDYOqNDq7ec9p/tYfPL08KWA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxE9TtVHozYfqedqg4JJysJRJj9jgZkxuD31HlKW/9IDZijD25p
	h38HdqTA/j343rezlJt2SrfQSottfrJ5ixQ/hxV90gNWZkn7+JO6kFUkbBxsSk+n0cQe34lFsJY
	M5JlUTxuFxRpXBFOMUFGdz+aMkyHurn9MrW8pl2Ga
X-Gm-Gg: ASbGncsc8Z7JAFgJMUxUBaRfEB8zc4rHj5qu5Xzx5yndXCoLxuaMLfVl4xtzVsDoBZQ
	CjwKv9sklnMkQwFBEl0zHKy+BYWco9O872LGehMFaP7PfXbM5TUgjBxue904XDIEEQZdCDRN7x4
	zTmvzaaIRsoSBjIgrCM4f1/kWORfW+RfYRW9nWYmtpj/cqqcJCY8FKJ4SF7JjgIvsxfIlI3D7fQ
	o+sG3oM/qv2j20kv2CS+ikKJ86ijHLVe5IlxhvxfYlolldrlCjxjYrY1g==
X-Google-Smtp-Source: AGHT+IFsy9m0Nmxt0WGUHWkcUUxKRAaFu/H3NPqh4ubgQxSGvZgjCCoC6FYqLnSy/hQbQZtlABh+GmuHsgAHUVGl+uU=
X-Received: by 2002:a05:600c:4e90:b0:458:a559:a693 with SMTP id
 5b1f17b1804b1-45b517b957emr198037425e9.18.1756315828898; Wed, 27 Aug 2025
 10:30:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250814093046.2071971-1-lossin@kernel.org> <20250814093046.2071971-2-lossin@kernel.org>
In-Reply-To: <20250814093046.2071971-2-lossin@kernel.org>
From: Alice Ryhl <aliceryhl@google.com>
Date: Wed, 27 Aug 2025 19:30:15 +0200
X-Gm-Features: Ac12FXxyNEyqCgkdXDD6Ij0Hk7m-4CU-xCxwWeT_l_WGRmeGZpIEa_WiEvkOoFc
Message-ID: <CAH5fLgg1gMBE1_LjwXqpbg8zK_1ve_STNwQZWmTq6nfsxpTHpQ@mail.gmail.com>
Subject: Re: [PATCH v3 01/11] rust: add `pin-init` as a dependency to
 `bindings` and `uapi`
To: Benno Lossin <lossin@kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 14, 2025 at 11:31=E2=80=AFAM Benno Lossin <lossin@kernel.org> w=
rote:
>
> This allows `bindings` and `uapi` to implement `Zeroable` and use other
> items from pin-init.
>
> Co-developed-by: Miguel Ojeda <ojeda@kernel.org>
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
> Link: https://rust-for-linux.zulipchat.com/#narrow/channel/291565-Help/to=
pic/Zeroable.20trait.20for.20C.20structs/near/510264158
> Signed-off-by: Benno Lossin <lossin@kernel.org>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

>  rust/Makefile                     | 14 ++++++++------
>  scripts/generate_rust_analyzer.py |  4 ++--
>  2 files changed, 10 insertions(+), 8 deletions(-)
>
> diff --git a/rust/Makefile b/rust/Makefile
> index 4263462b8470..09d4f389240a 100644
> --- a/rust/Makefile
> +++ b/rust/Makefile
> @@ -184,12 +184,12 @@ rusttestlib-kernel: $(src)/kernel/lib.rs rusttestli=
b-bindings rusttestlib-uapi \
>      $(obj)/bindings.o FORCE
>         +$(call if_changed,rustc_test_library)
>
> -rusttestlib-bindings: private rustc_target_flags =3D --extern ffi
> -rusttestlib-bindings: $(src)/bindings/lib.rs rusttestlib-ffi FORCE
> +rusttestlib-bindings: private rustc_target_flags =3D --extern ffi --exte=
rn pin_init
> +rusttestlib-bindings: $(src)/bindings/lib.rs rusttestlib-ffi rusttestlib=
-pin_init FORCE
>         +$(call if_changed,rustc_test_library)
>
> -rusttestlib-uapi: private rustc_target_flags =3D --extern ffi
> -rusttestlib-uapi: $(src)/uapi/lib.rs rusttestlib-ffi FORCE
> +rusttestlib-uapi: private rustc_target_flags =3D --extern ffi --extern p=
in_init
> +rusttestlib-uapi: $(src)/uapi/lib.rs rusttestlib-ffi rusttestlib-pin_ini=
t FORCE
>         +$(call if_changed,rustc_test_library)
>
>  quiet_cmd_rustdoc_test =3D RUSTDOC T $<
> @@ -521,17 +521,19 @@ $(obj)/ffi.o: private skip_gendwarfksyms =3D 1
>  $(obj)/ffi.o: $(src)/ffi.rs $(obj)/compiler_builtins.o FORCE
>         +$(call if_changed_rule,rustc_library)
>
> -$(obj)/bindings.o: private rustc_target_flags =3D --extern ffi
> +$(obj)/bindings.o: private rustc_target_flags =3D --extern ffi --extern =
pin_init
>  $(obj)/bindings.o: $(src)/bindings/lib.rs \
>      $(obj)/ffi.o \
> +    $(obj)/pin_init.o \
>      $(obj)/bindings/bindings_generated.rs \
>      $(obj)/bindings/bindings_helpers_generated.rs FORCE
>         +$(call if_changed_rule,rustc_library)
>
> -$(obj)/uapi.o: private rustc_target_flags =3D --extern ffi
> +$(obj)/uapi.o: private rustc_target_flags =3D --extern ffi --extern pin_=
init
>  $(obj)/uapi.o: private skip_gendwarfksyms =3D 1
>  $(obj)/uapi.o: $(src)/uapi/lib.rs \
>      $(obj)/ffi.o \
> +    $(obj)/pin_init.o \
>      $(obj)/uapi/uapi_generated.rs FORCE
>         +$(call if_changed_rule,rustc_library)
>
> diff --git a/scripts/generate_rust_analyzer.py b/scripts/generate_rust_an=
alyzer.py
> index 7c3ea2b55041..fc27f0cca752 100755
> --- a/scripts/generate_rust_analyzer.py
> +++ b/scripts/generate_rust_analyzer.py
> @@ -139,8 +139,8 @@ def generate_crates(srctree, objtree, sysroot_src, ex=
ternal_src, cfgs, core_edit
>              "exclude_dirs": [],
>          }
>
> -    append_crate_with_generated("bindings", ["core", "ffi"])
> -    append_crate_with_generated("uapi", ["core", "ffi"])
> +    append_crate_with_generated("bindings", ["core", "ffi", "pin_init"])
> +    append_crate_with_generated("uapi", ["core", "ffi", "pin_init"])
>      append_crate_with_generated("kernel", ["core", "macros", "build_erro=
r", "pin_init", "ffi", "bindings", "uapi"])
>
>      def is_root_crate(build_file, target):
> --
> 2.50.1
>

