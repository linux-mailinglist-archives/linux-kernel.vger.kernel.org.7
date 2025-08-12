Return-Path: <linux-kernel+bounces-765381-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AD89B23144
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 20:03:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 480726E009C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 18:01:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E04B2F5487;
	Tue, 12 Aug 2025 18:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LBGUyBUv"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D6E9199385;
	Tue, 12 Aug 2025 18:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755021620; cv=none; b=fIITNglXxHBoKFYaxIGOnvryWtN1FhFqOYxGgTBwz2Qp5W9V4GGVUw1twgif3WCb7bWdsMHXHSnMVgjpfsmL6CdccuqYJaWvO1xICmAD77cCOd92JzZVrxlC7P6Nx0wCT+lZumrwrvdNsMLpZWQdzuguPl47NuT88E4WHOQd860=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755021620; c=relaxed/simple;
	bh=iDyxY/PZQM7oGCOy+paVEs7C+/hlmIaMwEsNZ1lDMps=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=XbkR1f/MoJMzEgqgNKQBdZnAIulXfDrEompkP1Fo0yQdbHubaKle9mKKJgmh72vRydy+siPOPZYE+ECnavMePlXxmQAwuNG8FC9/KwJnPfgDa3lw6HZOVKYtBLkrQH8NApUlPTntbaQr1YZvOoHtIMu+zaQ0lLAYkWT1/oo3QHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LBGUyBUv; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-75f7fc34691so437443b3a.1;
        Tue, 12 Aug 2025 11:00:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755021617; x=1755626417; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=voR0zXJlK2R52Nv6d0LXSLHhujcZH2Ghy4ugQmK1XkI=;
        b=LBGUyBUvux08M6me3pZ9Aoy9wt39iB3Kxk8A0zWG71uluKoFoD63+hxx60NKdNpuKb
         lhCbxJ5kcS2jf0GD7N5O/dEGahYAKTi5DnUfk2saTf5bxvYtaiNfwg3MNBLyz/DkFrYm
         J5KgItEiMNZjV0x9Ykdux1KtDVIUicYzTsXunnJx4xQpX5vIqACeqcyvbboCsaXiyx/f
         WW3vqQrZ04F1CC9ioY8/ci4NJL5kdmAjvwtFyOxZEU2obSOPZtWfw4yUuFiwqouTtqcO
         3pzcIJR9pqq5R5bLpOfIQNTApBL0Ts5LrfX979ZgOUWGh431Q4P5sREv9aosu7Xo/FaG
         FMMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755021617; x=1755626417;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=voR0zXJlK2R52Nv6d0LXSLHhujcZH2Ghy4ugQmK1XkI=;
        b=lpEn8+7oCdauLbLljmMv1JWECk6optax/kGKRgSZec4aelCPyJN57PYwk+NyXQHwxP
         YqDuB5jVJsnkuXLMP9ALdw/BfuHuMoOHJdagfqIkSCREtXxoYkQ+7zFKYAJMH3PqxNTO
         cxmW38yOIwNv/EQP46UNgFTBLUGskwvOzKywm2m8XVE8qrS0g3xCC59K+9DPDDv1HgzX
         fkq2oa7WnD0+r3vq+NGpXQGEJNgPJCHG+XuOo8YUAPTEwUn2t4N5yabA+XgQupPcTx1o
         zFGfvgOTZL4nVB1rC+VGmjGUEOC83MKDu1P2ed4wDQZan1tGaAuKbEqjIEpxCkqUQhmJ
         VoEg==
X-Forwarded-Encrypted: i=1; AJvYcCU+6TUX1xBcercvv/pm5d32qqhunqXZoUdZEKdIgDX0t6kQRhTMdHqs14sD7AolpgBxixGbAzY3UTvna9eWSa8=@vger.kernel.org, AJvYcCXbIEec+vJsUGFX2XfQW2R8lOHSNOSV0YCLHbNAtfOWKDa2avaM2KjV333AYGbSHHvIUhW1jRyleC73Gks=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywgp0rsl3undyax4KjWnyIHS7GcMy9bmq1z+K1lk9foaCqYQHpT
	OpTk8O9QkCEdpw6HgOKL/zggeYT5chr6X7KvxAxf3JFkTNa/1dyBPoVG
X-Gm-Gg: ASbGncumvaQurwNWd9AkLnS+UlXkSznWVaV/NQmAH0wUih+XsSCsjjpFyiZZPR7uFu0
	Niaa1pn3uKMek8kIUN9HS3sKmYt5hdkqdCyQghcSpIsdtdmNAF7oOu0Y9q4WYfcOWXksJqmm3hT
	C08MXfjXjR2+wAoQ3M2QQP82uwYZCaqZNLS55Qvzy/QwNqK0m2KxdQho0hvVgMnDdQgmcVihCVN
	cmL8kBZD6V9p4SKEG64vR5d0ZigibxciHQGle7UEbPQ0H2xuNptgK7Fk7k7C+F4PGqv8I3aKPbp
	ptqoTgjVUmT/j3/Vis/TmLCx+1RDF/+7fNR7MSIrxaY/qm39nitI2CpASIF5yKgo7nD6TlMcsnj
	2waVxoOf16/xArg6GSBlHCLA5KBiQs8Ih2cYfTRYFsnw=
X-Google-Smtp-Source: AGHT+IHw0jgfljEaeUHz/KoG72Dm8SGNFvRENR44IU43ChOyBFGQXszRhCZbmlGaNKZKrTALAGX2Ng==
X-Received: by 2002:a05:6a00:928b:b0:76b:cf2b:18ab with SMTP id d2e1a72fcca58-76e20c9a15emr87578b3a.1.1755021617194;
        Tue, 12 Aug 2025 11:00:17 -0700 (PDT)
Received: from [192.168.0.110] ([138.94.103.170])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bccfbd98csm29777279b3a.67.2025.08.12.11.00.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Aug 2025 11:00:16 -0700 (PDT)
Message-ID: <5204b598-7792-460b-bec2-e3a4a4c7e32d@gmail.com>
Date: Tue, 12 Aug 2025 15:00:11 -0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9] rust: transmute: Add methods for FromBytes trait
To: Alexandre Courbot <acourbot@nvidia.com>, Miguel Ojeda <ojeda@kernel.org>,
 Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>,
 Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>,
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>,
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
 ~lkcamp/patches@lists.sr.ht, richard120310@gmail.com
References: <20250811213851.65644-1-christiansantoslima21@gmail.com>
 <DC0INEKNZPSE.WLEQH24SLW1I@nvidia.com>
Content-Language: en-US
From: Christian <christiansantoslima21@gmail.com>
In-Reply-To: <DC0INEKNZPSE.WLEQH24SLW1I@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi, Alexandre.

> I mentioned it on v8 [1] and v7 [2], but the tests that break due to
> this change need to be updated by this patch as well. This includes:
>
> * The doctests in `rust/kernel/dma.rs`,
> * The `samples/rust/rust_dma.rs` sample,
> * The example for `FromBytes` introduced by this patch which uses `?` without
> defining a function.

Sorry for my inattention, I'll fix this in the next version.

> Please make sure to compile with `CONFIG_RUST_KERNEL_DOCTESTS` and
> `CONFIG_SAMPLE_RUST_DMA` to see the failures.
>
> Also, now that we are on 6.17-rc1, the types in `nova-core` that implement
> `FromBytes` will also fail to build unless they are switched to
> `FromBytesSized`. Which I guess speaks in favor of taking this into the Nova
> tree if there are not other planned user for this cycle?
>
> [1]
> https://lore.kernel.org/rust-for-linux/DB5KEWX9EJ2Q.3CX5EGS66OVHH@nvidia.com/
> [2]
> https://lore.kernel.org/rust-for-linux/DANSZ6Q476EC.3GY00K717QVUL@nvidia.com/
>
> In case this helps, here is the diff I needed to apply to get the tests
> to build:
>
> diff --git a/rust/kernel/dma.rs b/rust/kernel/dma.rs
> index 1801836f31455..3797c70c13040 100644
> --- a/rust/kernel/dma.rs
> +++ b/rust/kernel/dma.rs
> @@ -597,7 +597,7 @@ unsafe impl<T: AsBytes + FromBytes + Send> Send for CoherentAllocation<T> {}
>   /// struct MyStruct { field: u32, }
>   ///
>   /// // SAFETY: All bit patterns are acceptable values for `MyStruct`.
> -/// unsafe impl kernel::transmute::FromBytes for MyStruct{};
> +/// unsafe impl kernel::transmute::FromBytesSized for MyStruct{};
>   /// // SAFETY: Instances of `MyStruct` have no uninitialized portions.
>   /// unsafe impl kernel::transmute::AsBytes for MyStruct{};
>   ///
> @@ -641,7 +641,7 @@ macro_rules! dma_read {
>   /// struct MyStruct { member: u32, }
>   ///
>   /// // SAFETY: All bit patterns are acceptable values for `MyStruct`.
> -/// unsafe impl kernel::transmute::FromBytes for MyStruct{};
> +/// unsafe impl kernel::transmute::FromBytesSized for MyStruct{};
>   /// // SAFETY: Instances of `MyStruct` have no uninitialized portions.
>   /// unsafe impl kernel::transmute::AsBytes for MyStruct{};
>   ///
> diff --git a/rust/kernel/transmute.rs b/rust/kernel/transmute.rs
> index ba21fe49e4f07..e7bd698ec99cd 100644
> --- a/rust/kernel/transmute.rs
> +++ b/rust/kernel/transmute.rs
> @@ -16,6 +16,7 @@
>   /// ```
>   /// use kernel::transmute::FromBytes;
>   ///
> +/// # fn test() -> Option<()> {
>   /// let foo = [1, 2, 3, 4];
>   ///
>   /// let result = u32::from_bytes(&foo)?;
> @@ -25,6 +26,7 @@
>   ///
>   /// #[cfg(target_endian = "big")]
>   /// assert_eq!(*result, 0x1020304);
> +/// # Some(()) }
>   /// ```
>   ///
>   /// # Safety
> diff --git a/samples/rust/rust_dma.rs b/samples/rust/rust_dma.rs
> index 9fb3ae1dd8587..36ad877d4804d 100644
> --- a/samples/rust/rust_dma.rs
> +++ b/samples/rust/rust_dma.rs
> @@ -65,7 +65,7 @@ fn new(h: u32, b: u32) -> Self {
>   // SAFETY: All bit patterns are acceptable values for `MyStruct`.
>   unsafe impl kernel::transmute::AsBytes for MyStruct {}
>   // SAFETY: Instances of `MyStruct` have no uninitialized portions.
> -unsafe impl kernel::transmute::FromBytes for MyStruct {}
> +unsafe impl kernel::transmute::FromBytesSized for MyStruct {}
>
>   kernel::pci_device_table!(
>       PCI_TABLE,
>
> -- end of diff --

Thanks for your diffs, it'll help a lot.

And sorry for the delay. I'll send a new version as soon as possible.

Thanks, Christian


