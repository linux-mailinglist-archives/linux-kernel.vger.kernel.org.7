Return-Path: <linux-kernel+bounces-746946-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BEE4B12D60
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jul 2025 03:37:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBE1C3AF627
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jul 2025 01:36:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF8D26F305;
	Sun, 27 Jul 2025 01:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fwKkZSQo"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F8D3CA5A;
	Sun, 27 Jul 2025 01:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753580232; cv=none; b=B4hFaOXwphKHYedhY2ouaUeuOC7lTpewAGMTGBf03rs97gcXIsF7zcOyriJ1Lg2AOO9DOsAjL8uXyLvCe7/oy9cH2iqyTOsNu9uQ3DMbAWDni4pllyqK3yNs0OdkxiJ1pIjc3qVViJVexADYlfKexNOT+oXStj1pqccORKctrU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753580232; c=relaxed/simple;
	bh=GARqaKeGqvKORdT1s71kP1FtI2F5yaeP8069Adu8HmM=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Yb9FfEYAdEsNKYw2fug59H0r2F+W4skcx5+Rz+ecSOgsM9386EVmh6FXlwWY2PYC709xX/FQN34Yxg+a/G+WTsvVALsLeHy5TUyaW7zW3Sr5X9Ygozy7QXmyeDIPvz/oMR2rCwofcVG+Tg5/ItU1OJTDh0namD9bdgyo2ymTRWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fwKkZSQo; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3b783ea5014so86705f8f.0;
        Sat, 26 Jul 2025 18:37:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753580229; x=1754185029; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=fz5CvwFTaUWZf7FF2jNo/Q6Lw3+xJs22d4zTmd4NkJg=;
        b=fwKkZSQozO3hX6V41FqvZchVtUA3BOKgvJz7CU9YKjIUmxFvCIqMDTQmoWUJY+XcNp
         GBziQcE2aYc9Ik2QM+NuECjS0zpD+gEZzuv6t51S2bTnVn9YgTPDq/esaz28p05wmfko
         k9tCpKApGP0qj+R9KCvP0MPNoi+iZnPoCzyVYcOwJyIAMxADZKlNEyeUyZxmYFC5eg1H
         d/HpQX3WXPI2jz3jxxQBuMyrrnzeZ0a2tpMMB4YlBbxfW2zdNFeWCx8Ur0buyaG5aCHu
         ZCIZx4gJZsgfr+DR+gotfuHQFSMFMveEU27fDJkIWHnuuliwSJXsQpX8zAjx+G3RpEEq
         hEpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753580229; x=1754185029;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fz5CvwFTaUWZf7FF2jNo/Q6Lw3+xJs22d4zTmd4NkJg=;
        b=d1tpD35LavEpdqkj8H61WFb1BbfBMOMbg+/8cehEjUTd9/g7l9ocQWFH2gQZWpUbuZ
         K7sZ065O5eJ4I1+SuR5IGXjOnG5qd480vez7IfYJpgQyyvzRv/3y+8/7vQcKctmyVRMp
         fz/UEkgdGNUUT+g+OUoOWVW8XbBH8kSkinPaCq90xsvWxNtGPUKHcdfOsmJfe4wk/EPP
         TwuckpdxS+HtA5G3j0DpiabOn5hSWBQxiTJkXSEe9np4OLvG7lXVLU6Zo4pZ9lXtG47r
         wKuKyso9aUjeiaiCYBdTxsbeCKAIDLQcFzY6MxlwNVmmc4BLubpIRPYtyJkvewnck3HE
         4ppw==
X-Forwarded-Encrypted: i=1; AJvYcCUWS91iHV1V9vob3RwOMgGRzPM+b4memKVKrxNQyKHk4D0hdpiYM2GGLhz+T0fnBCqVHj0REBoPls83bbW8mkg=@vger.kernel.org, AJvYcCUfmeyObLk15QDtXRgWH135u6CukDz8ghmTWBVuhS4mqXDPshNu8lJUdK5cWvq3W85EXwTvSPx1zu/1Pz8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcjKn6yya7Nz74zy2Se5Cpxs+eEiwTRu/a/QB0ff2RZPsk6KFM
	xOQd7cuV0aKmg6Qv535AUeVTjNXxs0sHtXmryiS1WQC9HJ2gcWhKsBtBBY9PnvOLRalCBA5pLCn
	3UF4jJganypwxcNI0S3WYnPSYT7liVTA=
X-Gm-Gg: ASbGncsdFhRRM00JlilGM7BScf+RbFjE7YkEawS/XQ/LIVn5I+0g07puTfsT0XoPRSI
	/it46keFgCdT+EANKW8Q5V2mKUMq2afCnxvSpqRO80qNauVjYbsjrDRoQKzbaNTQKWBgW6e0ppV
	cc1cTpM9ZGszSpzZq5C+HohpM9TePojyd0h3apAi19GLg+TEUDOtvs5K5wDHS0YgGfj3DNZKWT1
	oDDuEJONkv80afN9ks9kGLBsmWD1IzCmE1tkBGt
X-Google-Smtp-Source: AGHT+IHUZvn6xDvv8KTa/ewPnwJQRzeoKj1ww+cScjSufeV4ZPempvFLmMtUJZ7YTtem4IjrG84UqCUrBm82uTibbiE=
X-Received: by 2002:a5d:5f8d:0:b0:3a4:eda1:6c39 with SMTP id
 ffacd0b85a97d-3b7765ec69amr4545794f8f.13.1753580228772; Sat, 26 Jul 2025
 18:37:08 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 26 Jul 2025 18:37:08 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 26 Jul 2025 18:37:08 -0700
From: Kane York <kanepyork@gmail.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250624042802.105623-1-christiansantoslima21@gmail.com>
References: <20250624042802.105623-1-christiansantoslima21@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sat, 26 Jul 2025 18:37:08 -0700
X-Gm-Features: Ac12FXxsuoJc-fmTEmPFr1-hwmxQeKFX0SZP2JjV51WV_k3pkZTS0X5ALYhYjiQ
Message-ID: <CABeNrKVYy=9QKvTwnDPfRhXuJLCFgA9bbvd34V-P8jHLEJSGEg@mail.gmail.com>
Subject: Re: [PATCH v8] rust: transmute: Add methods for FromBytes trait
To: christiansantoslima21@gmail.com
Cc: a.hindborg@kernel.org, alex.gaynor@gmail.com, aliceryhl@google.com, 
	benno.lossin@proton.me, bjorn3_gh@protonmail.com, boqun.feng@gmail.com, 
	dakr@kernel.org, gary@garyguo.net, linux-kernel@vger.kernel.org, 
	ojeda@kernel.org, richard120310@gmail.com, rust-for-linux@vger.kernel.org, 
	tmgross@umich.edu, ~lkcamp/patches@lists.sr.ht
Content-Type: text/plain; charset="UTF-8"

On Tue, 24 Jun 2025 01:28:02 -0300, Christian S. Lima wrote:
> +/// let result = u32::from_bytes(&foo)?;
> +///
> +/// #[cfg(target_endian = "little")]
> +/// assert_eq!(*result, 0x4030201);
> +///
> +/// #[cfg(target_endian = "big")]
> +/// assert_eq!(*result, 0x1020304);

I might start using this as a great example of conditional compilation.

> +// SAFETY: If all bit patterns are acceptable for individual values in an array, then all bit
> +// patterns are also acceptable for arrays of that type.
> +unsafe impl<T: FromBytes> FromBytes for [T] {
> +    fn from_bytes(bytes: &[u8]) -> Option<&Self> {
> +        let slice_ptr = bytes.as_ptr().cast::<T>();
> +        if bytes.len() % ::core::mem::size_of::<T>() == 0 && slice_ptr.is_aligned() {
> +            // SAFETY: Since the code checks the size and alignment, the slice is valid.
> +            unsafe { Some(::core::slice::from_raw_parts(slice_ptr, bytes.len())) }

This is incorrect -- the second argument to slice::from_raw_parts is the
element count, not the byte count.

> +        } else {
> +            None
> +        }
> +    }
> +
> +    fn from_mut_bytes(bytes: &mut [u8]) -> Option<&mut Self>
> +    where
> +        Self: AsBytes,
> +    {
> +        let slice_ptr = bytes.as_mut_ptr().cast::<T>();
> +        if bytes.len() % ::core::mem::size_of::<T>() == 0 && slice_ptr.is_aligned() {
> +            // SAFETY: Since the code checks the size and alignment, the slice is valid.
> +            unsafe { Some(::core::slice::from_raw_parts_mut(slice_ptr, bytes.len())) }

Same here.

> +        } else {
> +            None
> +        }
> +    }
>  }
>
>  /// Types that can be viewed as an immutable slice of initialized bytes.
> --
> 2.49.0

