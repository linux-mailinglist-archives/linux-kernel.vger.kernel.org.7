Return-Path: <linux-kernel+bounces-745402-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B43E9B11969
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 09:53:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 790F7AA5503
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 07:52:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BDBC288C03;
	Fri, 25 Jul 2025 07:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="U+iSlB/o"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFC7D224B1F
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 07:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753429979; cv=none; b=Mv4I8IeVAKJfZ64bSIdEeCZl0z9PyATJAgz6qdGSmbgW4Va3NhrwEbw0UhFpjceHmyhdNOe47EHngYyoc3ZudSJU792ULlGZ0+OK414n5pFH2GAliDm5GmPkCxl5QUsZUpoF4uBysuY03xrr3udoKy7W80/S5fuHaLWUQY29SC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753429979; c=relaxed/simple;
	bh=eoH797mqsBs6xuZVyOmv4d8RqF6BV6h4eqvrF5elnEA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=esY5qGR/zBQ586LP4KYKWbVc1wfTjhtpV33N5WvW06BESKecJm5L/DltuR8y0sgkCvJvEid2lDevFoX2PziQVh3igsRkzcSf3zshkXzPm0Z0BT4PZKElTMHOTQijA0Q6qDufJ2p2RVUPX7PIPCM4I6K+f4wyFWGXMSrKAq+V+gA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=U+iSlB/o; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-45600581226so18910795e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 00:52:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753429976; x=1754034776; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y29kz7A/MwWwfz7+3cYa/ddLNXrpkNMO3/l7w3Mnzko=;
        b=U+iSlB/oUymTwCGp4rcHy9phiPWmvC8u3upkSSrE94AThHMZmS8Fr3UO2WMfzDctBS
         UZSSNEOfqKst9F4E2qfSaeeP+DzNQYCwLaFiNwjvW+uCeRn5P6/t61N4RAdv+CJh81vx
         ih7sjqEhWhVhsogc7zpBu6iWTQ74j9chUnK9I9GabjwmqrxEFmESFxJ/quFyuRdG3SWY
         xrVyTK3IWRmM/NbeHWN6pIN0Wp1KnDJLzLz3aOUVTZ7+5TWqkR3m3skuFGRk3TTaFvFB
         er/L6pgkbjuhPVdJbB1v2QSLswVsgTbwznWz6eGJVttSTKkjAbor731fjMu1qhMqXAnG
         1PAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753429976; x=1754034776;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y29kz7A/MwWwfz7+3cYa/ddLNXrpkNMO3/l7w3Mnzko=;
        b=T2x9uVWI00tmo2k4hm4aSQaqogylVgVYtzqX3NF/mO43n6iWxlUdGmbe5LxLqYBo6h
         Qnm8TagoUFIwZLpJ3mov79SLZlqkxk3Ij9B02jV59JBbwTxLCTi73mO2hZWZ6v2mYHSM
         jpj3TQX/2lHN/mXWmrvKPnZTmdOCQhOrSo2/AuuPKHjP3O5EX64QxACfnvTeLS18D33E
         /SIRoKzwwZWXaRjE4kVZOSSkHRlfyxuoADN7hUOWCeA4w1c1Ix00TpTHIM274pUzlLt0
         ep5UsJHAyEYtkRZZ/dG/lUMOPG2NCe1/K86dVE+xXjFvPTPcwXXDjWE5iQu5KHvFsQKJ
         8+vA==
X-Forwarded-Encrypted: i=1; AJvYcCUodmh+c7LLXghGIQpt4le8Sbx05YdQ4GcrRk61tWP4E8cGpegg1FsbZXs9xzoHPG7xtj0U0TkqSiKrNj8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4QLdXmVVTQRQlTSl3LBErt089+A3HhhdpVtsCluKPVV75fp/c
	ty4uxp2g3YZrrlBO0gkC1Ig5fzFRpIfuUnB/JptjxwtFSluDe9396pC6QwOXgVbxO6dnpGDNVRd
	NpiRbP6P9yMa88AgvF5YkRhSBFSi6zkW0LV4nIEY8
X-Gm-Gg: ASbGnctTOgNUwQ3f7+Z2rkHqxJkVz3nZnMpMA9Ew517LUFExlzZpzNd3Ak3/GmOpnzm
	T2nIkzMvQHnODe0xLS1QhtGpUA5YouqwsLLihwOH3OkFUq0RcVqrVeX3NsXDitgCRGPQIsstn8p
	7ZARxypdleoqHdziBX7mI3GNAv8LIJgVydJ2HjryO55tHgo+vd4uKZksWTEf1NckPwunNvbQ21w
	lXbqwHlf3e58bRbMal/DkVYvPsRpyy4kLxRXQ==
X-Google-Smtp-Source: AGHT+IFHuZC1ODuNXR4+D0YRFC92UGO95cgOvdX0pp5B59jjxgohXWOCJs+nNlprNVTypzFwYYDOrz034joMKfbYF5o=
X-Received: by 2002:a05:6000:2306:b0:3a5:527b:64c6 with SMTP id
 ffacd0b85a97d-3b7765e57c8mr883949f8f.1.1753429975962; Fri, 25 Jul 2025
 00:52:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250725-as_bytes-v1-1-6f06a3744f69@nvidia.com>
In-Reply-To: <20250725-as_bytes-v1-1-6f06a3744f69@nvidia.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Fri, 25 Jul 2025 09:52:44 +0200
X-Gm-Features: Ac12FXwZc0zXjraoA2_kHSwY21ka4KMAD_Cj3XPo4-E82LVGRioQvMFt8WOI1AQ
Message-ID: <CAH5fLgj-crrKyZbgPBLyWNmzw_oB6ZVc==rqAFt5jr6402nHLA@mail.gmail.com>
Subject: Re: [PATCH] rust: transmute: add `as_bytes` method for `AsBytes` trait
To: Alexandre Courbot <acourbot@nvidia.com>
Cc: Abdiel Janulgue <abdiel.janulgue@gmail.com>, Danilo Krummrich <dakr@kernel.org>, 
	Daniel Almeida <daniel.almeida@collabora.com>, Robin Murphy <robin.murphy@arm.com>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	"Christian S. Lima" <christiansantoslima21@gmail.com>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 25, 2025 at 4:11=E2=80=AFAM Alexandre Courbot <acourbot@nvidia.=
com> wrote:
>
> Every time that implements `AsBytes` should be able to provide its byte
> representation. Introduce the `as_bytes` method that returns the
> implementer as a stream of bytes.
>
> Since types implementing `Sized` can trivially be represented as a
> stream of bytes, introduce the `AsBytesSized` proxy trait that can be
> implemented for any `Sized` type and provides an `AsBytes`
> implementation suitable for such types. Types that are not `Sized` need
> to implement `AsBytes` directly and provide a method implementation.
>
> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>

Is the AsBytesSized trait necessary? Can't we just do this?

pub unsafe trait AsBytes {
    /// Returns `self` as a slice of bytes.
    fn as_bytes(&self) -> &[u8] {
        let size =3D size_of_val(self);
        let ptr =3D self as *const Self as *const u8;
        unsafe { slice::from_raw_parts(ptr, size) }
    }
}

Alice

