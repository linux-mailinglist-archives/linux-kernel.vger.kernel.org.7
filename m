Return-Path: <linux-kernel+bounces-785439-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2245B34AA6
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 20:51:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 636B65E2F1E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 18:51:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3695327BF95;
	Mon, 25 Aug 2025 18:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GRnVg7vm"
Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com [209.85.222.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 384D71F3FF8;
	Mon, 25 Aug 2025 18:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756147905; cv=none; b=DHAJNSDATp8lNQbBGheCY32niSw5/YZecaTb9oS3ilZVerIBbmJkOvH29RW0bMrHWI7Ymstb/OrxJxiIIxUOhIcfBOr1CS83SRLrd8QtCIH0IOIPt0o14Z/s5m5QrqSQ6zfBFi5Af8HUcjDPYINdwC8qkEBteL0rlxuxoZHoZ4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756147905; c=relaxed/simple;
	bh=/rHh4BvQOei3th3IQ7b5lYsoHix6qru85pxwACl5uWo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=spG68TiCJpGuKdqTRFJYgTvtUXKmhuEPfzUVut9lRJZBD5oBmluehvTYPiOreFCiOLoDUjAdLm0lXc179UCwsBgq3N7DkZ9UcKcpXCCP49Smp1cn/U+9U333VeqgRxJAIsoZGmmTSeDxQbYM8+KihvJcIOVvysS8wSynei9dSWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GRnVg7vm; arc=none smtp.client-ip=209.85.222.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-89225e4dce0so185111241.0;
        Mon, 25 Aug 2025 11:51:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756147902; x=1756752702; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=N9gSthjVRUNAxhEYmrWI6LMUBfLgyiUmc4+22PTE7lc=;
        b=GRnVg7vmTdWbNvRwUX4NUrHtrnq0SKyt97VltNVNokbhugINcIrZZ59q4ukBUSqnEi
         mFSA0A27Un96l/8PZOwG2StLPu+9Mu3ovLqTdoqoMoDni5BzBMmOngBwJnkePqeEVXYx
         dNjLkT3zRlqHuh0KpNGnyQUh7K/gEOdnrmkieg2P5D41p8eqOPhsivzDP3rDw6oFvm/W
         APk8gt8EXVTT/vSrN3deO2FL3tNIbMbMWnaLMA0FY3aKz3ngFndRZ2VwmXG0I5RaJ7ud
         /dSjYv1DOxDaT3ARLMebYDbfrf9yNUzVaSaOKjtFUKEsCiw3pfEtOmn4x5WxbRt2CBua
         DB/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756147902; x=1756752702;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N9gSthjVRUNAxhEYmrWI6LMUBfLgyiUmc4+22PTE7lc=;
        b=fcn+bdnSq/UXQfc8GbSH40u78fNvaEF05eFuPvVTQEiMVVVjRqRu9NEr/tCQ2E2FZs
         CygeUFAoDOJmtttCRe7hUbr4YOl0lw5uoAyk+mbABi4EkM4pNy64Aqn+7D0ZOsLQ4lHZ
         vOiJmUz0PZMqPj+L9zm+yMOW9FYLJ48vqisubmLeLX+BBTFNvzk7p6scARfCsWYcFMWw
         1ti3t961257aNuUnJl7bB1cbskzH25qKyRdgeLA3niPiUY4dobimUCaSmVQGgRq7bpoS
         kYWif4fBMIqNV94UIxxA+YPcSc2g12OMkSUOVwTNTBCUDd3Oa02lXxyIGgFAx/6lhC2J
         FLpQ==
X-Forwarded-Encrypted: i=1; AJvYcCVOJxdRDeWLhj3u3pM1VaAr9BKDMHjr6JLB/a+JD7t6sqiMxdyZgVvG8OwgLcLrbsSpzlPVZhcl1okcFLxoCGw=@vger.kernel.org, AJvYcCW0UdpIQOuG7oh89qFusI5SanY1+ycbM3PunPg7kWQOuceoitbCCbE7GLWuogliy5OTZirWTqhVMC5POHc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJkYi0GsQn+2p2YH2Omta1rMCnDPb6Jv7H1ZeoEAKtdfDhBVdi
	BxU/Q6PtxCkQ4TPRBPuxfgv4BnhfN3Ee/bUmoHvdyukNjurFyYj5w/us1G/9T0LOU46y94jGcaE
	kflPxhwLOEUCwEaU8LV3dJic7vbJoBng=
X-Gm-Gg: ASbGncsUMB4FvNqvkpBvOFwVSkQScj2DOD7rTa3xmu8KtseqjjNdNtiMtYXXvSqDr/5
	9KWRglMjsrV8EVGXCRvfP2c4IzB65Wz1+Hp1QPqEadNkB0fmSK+HXxBApRNkj6gzWZ5RH9ScXR4
	iRjEsPgFyIVz5HBQQaI4xXrzWf1Ug1p7Le40OFaZ6EGD9kvtlpHoVcbCFn++TQR9DsCaGbS/IgR
	Y4Rhpai
X-Google-Smtp-Source: AGHT+IGSd+iQLyEoaZt9OmHkHFfyQ7QoR9aV62C0yhYhEHa2QM2w9RACJB/X729wwTC+MV/YStX2mMWRl1iqE2iAy9E=
X-Received: by 2002:a05:6102:41a6:b0:4e2:955a:b243 with SMTP id
 ada2fe7eead31-51d0c3a2b39mr1463920137.2.1756147901890; Mon, 25 Aug 2025
 11:51:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250824213134.27079-1-christiansantoslima21@gmail.com> <aKw52m-lh62DXwz7@google.com>
In-Reply-To: <aKw52m-lh62DXwz7@google.com>
From: Christian <christiansantoslima21@gmail.com>
Date: Mon, 25 Aug 2025 15:51:30 -0300
X-Gm-Features: Ac12FXyAoKVFD5JWtFK452UZasgDx94ILFyp9nK6CMJJT6h7MoOB86RgzaHBKEE
Message-ID: <CABm2a9fFR-qOApEX7MQ5s-MKeBCHbX_Ja3Dh_RybWBHONfa=kg@mail.gmail.com>
Subject: Re: [PATCH v10] rust: transmute: Add methods for FromBytes trait
To: Alice Ryhl <aliceryhl@google.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, ~lkcamp/patches@lists.sr.ht, 
	richard120310@gmail.com
Content-Type: text/plain; charset="UTF-8"

Hi, Alice.

> Does the warning appear on all configurations? If so, this #[allow]
> should be an #[expect].

If clippy is disabled, nothing is reported.

> >  macro_rules! impl_frombytes {
> >      ($($({$($generics:tt)*})? $t:ty, )*) => {
> > @@ -28,7 +94,6 @@ macro_rules! impl_frombytes {
> >
> >      // SAFETY: If all bit patterns are acceptable for individual values in an array, then all bit
> >      // patterns are also acceptable for arrays of that type.
> > -    {<T: FromBytes>} [T],
>
> Why is this impl removed? I would think that with the Self: Sized
> bounds, you don't need to remove it anymore.

I interpreted too literally the idea of removing the implementation of slices.

Thanks,
Christian

