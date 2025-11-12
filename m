Return-Path: <linux-kernel+bounces-897614-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B4B2C53332
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 16:54:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 64CE335361A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 15:46:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBD5833A036;
	Wed, 12 Nov 2025 15:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I3R9gCJt"
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6B5133F8A6
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 15:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762962190; cv=none; b=QY7zw80lhpQvWaxoGr4XDR9XrQfC4lZ7ZXv0C5Mu+xCfeV1rU3Qus6pfrxomhBEFvvFMih8g1ORQJFDUIa7Ps+btMfEvy7HxcZlAaj6boJoJIMz5tSwc6cVgtkmatFiJmxFtvozNR8f9Hzs1LinZ+7xAbjwb4Pl5k6wisdjizI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762962190; c=relaxed/simple;
	bh=Uik64VpUErV1SJU8h+jwWcPvCJT49s291XFBAXXxroc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DUsakjhhHTnWcMtskizilgyn5ANXR3jWpfVpcD37kqGrMlzSXscqk/YFhYXWEiDUjoz1ERkR1bGK7GnnvvG1QhWOdtUEWLb9NRrDXawy6BbQAc5MlFNuLUYo9ga7iqKNNmt/XM4OqfAFIZ7dJNOSTLRA+jEQHdg7oPye9kjcrqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I3R9gCJt; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-786a822e73aso11119007b3.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 07:43:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762962187; x=1763566987; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9LBqzlfElQ1lIb0u+DOZLTm9WdaVuBKFQTOfsVgxO3Q=;
        b=I3R9gCJt4DEC/jfapMqxB/HZKE8owpZ8Ja7YFqMeRiitaEn+81yW2YEIXoCnTPN6vS
         8COTkA7ksDJSOXANgzEmCWbQhI5qoj9e1XNPxWiuSzhNdDZeLU57jrnNKEA0oRXIdyeq
         2fvOl65mZm3rEnZpOqN7ZVn5m7/VcnsXpRcbZz6XpehDK7zBhk8Rnhaxg3hlWjW59OJn
         FbVNrRYNiVcyPjUP6dUEExcJG10XktYq3YKffYbD4ySRuwehE6MQvyzNBQmhGg7r9bJF
         OyRFIsbfv1eisqSJCjV1JlO/pjGPGdIfyucsIK7MlG70aQJXlzZqNJFwi9s0MMgCWVYh
         sw0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762962187; x=1763566987;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9LBqzlfElQ1lIb0u+DOZLTm9WdaVuBKFQTOfsVgxO3Q=;
        b=hv1uxdyE0oHspin3HXh/v8pDky1/ON1JFcPVE8idlbxAONCldw+LpugRWH89A5bdd6
         RTNs0c/zuL1p9eWIQotH3r4wKjJUkLC+HGbBkN/taZ6BARuupxKEpWB4+RO4dusABNiP
         vlgZQP5WR0wYMk+A5sgJvMzy7Tn+V8YJOxD4THkPZBAgr/uISrQ+HD8F8CZs0Cuk0qZk
         i1cNlfQYDnjuP4g0LuYo3HDBPQEgEF4HUDOz4Z/v5CXEbMrXv3VyrdV6ZGeJPOGo/3k9
         oGFlcvWENCoRC3tBzSe9LnS58Ohr3gvgjpxcGgsPg1C11qwzTa3g3sKHw/VCqnTsp2qL
         L3rA==
X-Forwarded-Encrypted: i=1; AJvYcCUnPoL5TT3m17TPRQXA3uiv2aHd3ldTpmSaTtJR2Uh5VLBVTnJWM4JKS5pygfR/4wCl6N6IjoN675QmsSs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVOhwUAKODAhCAfjMigmdmmIVc8LPUQDxW8nZcZaH4thglATB5
	fYfaVQpwEhmtTvZZaTzoBq23qUlFKDx7YXnyKdz6dK9UJKAV5sL5DwjZ
X-Gm-Gg: ASbGncuPIDjpDSFl/h3oBQ5DGqyaUE1GjDJLUVxSl5+8+lCuqFjY9HqewkJrnRd32Hu
	Ooio2mmoRvji5myzC6SYo9A4dukONGOyKOoLLoULcJwJbFRE2JNPuebzssoVRFrThGaMyHTgZ2M
	1Sh72iXDTVciBDRan4jSdINQmozk1P1YIh6LRx4LH9qYFIx+VBgpuXUa1I9WxVuNKGS6Uirfd0t
	Esq9RGi/4XCc7zxJgLenUBa55+G07pKPfc/oaVDszJNcpPDvN6ZWY58fBsKDoazGOaJUIgS4Ok7
	28Ud7jowBtz/J2z0OeLbSdXTT3L5J57HNF2PhdTUiz/m9pQISlUstXnVT5pkWpRGd2ITsiwHuSz
	p7LyIM/O0NVbrKTqnFyDi2Oi4YI7zp1KNaMcSkClISIn1FjT4S8huincH5firDPvq70zSBFLhuC
	02iYuTcA6ZhFyMwz9MpyI7iCikHMmPToMi
X-Google-Smtp-Source: AGHT+IF15JwX9JjCA/ohr60KAYT3oXFXBvr6rVIcdeNIWwzjcYFkYA4W56ZEMkmDiPgl0IwQUnz9ag==
X-Received: by 2002:a05:690c:6c90:b0:786:6b92:b1f4 with SMTP id 00721157ae682-7881362a20cmr24973067b3.15.1762962187536;
        Wed, 12 Nov 2025 07:43:07 -0800 (PST)
Received: from localhost (c-73-105-0-253.hsd1.fl.comcast.net. [73.105.0.253])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-787d6a3e476sm42820047b3.59.2025.11.12.07.43.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 07:43:07 -0800 (PST)
Date: Wed, 12 Nov 2025 10:43:05 -0500
From: Yury Norov <yury.norov@gmail.com>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
	Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Christian Brauner <brauner@kernel.org>,
	Carlos Llamas <cmllamas@google.com>,
	Suren Baghdasaryan <surenb@google.com>, Burak Emir <bqe@google.com>,
	Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 0/6] Use Rust Bitmap from Rust Binder driver
Message-ID: <aRSrCRvCTu9Y3pW3@yury>
References: <20251112-binder-bitmap-v5-0-8b9d7c7eca82@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251112-binder-bitmap-v5-0-8b9d7c7eca82@google.com>

On Wed, Nov 12, 2025 at 12:47:18PM +0000, Alice Ryhl wrote:
> See commit message for rust binder commit for details.
> 
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> ---
> Changes in v5:
> - Rename NO_ALLOC_MAX_LEN to MAX_INLINE_LEN.
> - Update all uses of MAX_LEN/MAX_INLINE_LEN to reference the new
>   constants.
> - Link to v4: https://lore.kernel.org/r/20251110-binder-bitmap-v4-0-5ed8a7fab1b9@google.com

Patches 2 and 4 still refer to NO_ALLOC_MAX_LEN. I think you need to
resend.

Thanks,
Yury
 
> Changes in v4:
> - Keep existing IdPool constructor (renamed to with_capacity).
> - Undo docs changes that were due to the removal of the existing IdPool
>   constructor.
> - List id < pool.map.len() as invariant for UnusedId and mention it in
>   as_u32() comment.
> - Fix [`acquire`] docs links.
> - Link to v3: https://lore.kernel.org/r/20251028-binder-bitmap-v3-0-32822d4b3207@google.com
> 
> Changes in v3:
> - Also update documentation to fix compile errors.
> - Use new_inline() instead of new_small().
> - Reword commit message of "rust: id_pool: do not supply starting capacity"
> - Change UnusedId::acquire() to return usize.
> - Link to v2: https://lore.kernel.org/r/20251021-binder-bitmap-v2-0-e652d172c62b@google.com
> 
> Changes in v2:
> - Use id_pool.
> - Link to v1: https://lore.kernel.org/r/20251020-binder-bitmap-v1-0-879bec9cddc1@google.com
> 
> ---
> Alice Ryhl (6):
>       rust: bitmap: add MAX_LEN and MAX_INLINE_LEN constants
>       rust: bitmap: add BitmapVec::new_inline()
>       rust: bitmap: rename IdPool::new() to with_capacity()
>       rust: id_pool: do not supply starting capacity
>       rust: id_pool: do not immediately acquire new ids
>       rust_binder: use bitmap for allocation of handles
> 
>  drivers/android/binder/process.rs |  63 ++++++++++++++-----
>  rust/kernel/bitmap.rs             |  43 ++++++++-----
>  rust/kernel/id_pool.rs            | 129 ++++++++++++++++++++++++++++----------
>  3 files changed, 171 insertions(+), 64 deletions(-)
> ---
> base-commit: 211ddde0823f1442e4ad052a2f30f050145ccada
> change-id: 20251007-binder-bitmap-5aa0d966fb1f
> 
> Best regards,
> -- 
> Alice Ryhl <aliceryhl@google.com>

