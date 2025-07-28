Return-Path: <linux-kernel+bounces-748552-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 63861B1428B
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 21:40:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 639193A65B5
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 19:39:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54D4B279334;
	Mon, 28 Jul 2025 19:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MnvB78fB"
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com [209.85.217.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C4241EDA2C;
	Mon, 28 Jul 2025 19:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753731595; cv=none; b=BMXRbhtlL+Zjt7U4r5rZJ/r/URsbnPhJ11LCCYlpoFdZrivpN4iikMO1XIhpht9mWW3gr5oe6EKUaXcexYM387c72qgr8LvbMfvQCeO7dibbSbwR69E2gojSVpRBMuCJwXzjbKy5Q2uks3Y5kL7H2+EtX1GTuZ0C5tct8UvVyo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753731595; c=relaxed/simple;
	bh=FsiH8wmV+/NXaDrw5cyeLVgzTcylRPgCsccWE/dFSi8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dxbaRw5kM8mvSqE0WZjvjtp/cu6zt7KYDpc752UeqMj7cuyjpS1bGxUpG8I1dNkchqsZINyvbv4oEmiG7ynm14verLLu3IqrH18QbWyVQVCbI24CsE7aSytsibRk8AWOky3SUUUGwXm9Gk5LuDHy5xd9PN5pawtNDSWhbvbNIcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MnvB78fB; arc=none smtp.client-ip=209.85.217.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f44.google.com with SMTP id ada2fe7eead31-4ecd5e83bf5so175039137.2;
        Mon, 28 Jul 2025 12:39:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753731593; x=1754336393; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Cb/Puc6k2kQ/rLVer+FHTn2Js4SR5RY38HA3oJ6PJ+c=;
        b=MnvB78fB+7lFsONtxmCDqrqwOip3PTnZPQwmGsgLQsWQFoZXhuphts8UK+g2nf2Zah
         CUcZqJ5LdShBrsOJKlemgSlJuo0Fle1XmDX610Lr3Gk6aWLEfWvuzWYalP7R76618rZy
         IAFIkjAvU2bq/XJ7hzarDaVryejk/qAu/bRNYqMSQ7azw+8YlUHE3+SHKFzP8luYjBz4
         3FalXcMNsbVQMK9Wp6IVzCfQHwLcXPsXpY0g6hy1vMXBwhmCGd2IKxflbOO8byoVLbZ8
         vcowVBZf2NHb4tMbP1suC3Iwnly8l5WbAlDeUhWArKgqsXkAvzbjR+2y0oFKNWzHL07N
         9Odg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753731593; x=1754336393;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Cb/Puc6k2kQ/rLVer+FHTn2Js4SR5RY38HA3oJ6PJ+c=;
        b=olL+v2VNYKDj03MZr+J5fNuQtP+VEKhKQctyRN1WnvFdgmzRXRk5Tpgn/+6EogaizW
         PlAPRfbR3WzrlS8sS8KiX4iinzcYwaCjwId+ZeozSOrulhV5aOJQxAnlD7BXLZd7Twb/
         AY6yddVwvrIwjKS+nH5hKhnxIvaW9Ujuxr5P99m9d/TITM5t36m5f6urlrbhhyMYzfrv
         uVEkpjSBd7xrFfIZXoBA39uyjbZ7sj47G1pWcQr6eq1iVTjdCpM2m9ikK5qiLlQFLIbk
         fW0ZcmbLf7ape6o0k2EWqdDdyfoZbYUVS3Jh3DE7ZtBWKm+4gQhFOcb5Zqq7WGBNIXOU
         B/Bg==
X-Forwarded-Encrypted: i=1; AJvYcCW5LkM7h2dNx4uzcuPQFyCBouqzpB0Zyz/HYuk59JS4G2nujh4HDoXCcPzPrVBdcvHeqwGq8uUS/c10kAA=@vger.kernel.org, AJvYcCXJ+9YBOGNhQTFwAriPHqWFtQ/CZyTq6hzsrsM5Ce4TWn5amTDnC31FvEb9g6B1swPM8pwghPfF/+zkm5o4GUY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyI/Y34btcgcbVtnbu/6jRcUtUUIBMxkUfuqxUSL4YKh92koZbB
	VlYSnVvzQov2ZjdDNoSsTQWpS+mvSyGqe7RawHavNz7RL7g+4wRCEMNVrzqlSTpR36Whb+GwynK
	hJGXhfdIVhec/SSe7fCTnZ+jAw5WlH9Q=
X-Gm-Gg: ASbGnct50MDsZmFu8G2jrf1p4u8Bys6EZGERjfuMS3opt/j8o9MOJJ7/J1r+S4YTPkB
	0GrEl/S2J2YtRicH/x6+kHUnlZyXZjHQ0Y6FpTpGtoYjUNO9ukUMdVDYjxm1R24+NJepOwTR9BK
	F7vDtt9eCAdMLnegTQGumLuU8m3Ft14iSrs0/cyxuRSyauhMSaoFRKcnvoNXGxvsjt0b7TH+hOx
	w6CrJNH
X-Google-Smtp-Source: AGHT+IEgps85u4juwKTrcpIq7xha+wAXQNuL7D0T81JIOoI8cEc6b1vkm045b4U5wn+aRWI+0305Yw28074hiZHd9/o=
X-Received: by 2002:a05:6102:2b8d:b0:4f4:aff8:18d with SMTP id
 ada2fe7eead31-4fa3ff31656mr1679974137.7.1753731593124; Mon, 28 Jul 2025
 12:39:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250624042802.105623-1-christiansantoslima21@gmail.com> <CABeNrKVYy=9QKvTwnDPfRhXuJLCFgA9bbvd34V-P8jHLEJSGEg@mail.gmail.com>
In-Reply-To: <CABeNrKVYy=9QKvTwnDPfRhXuJLCFgA9bbvd34V-P8jHLEJSGEg@mail.gmail.com>
From: Christian <christiansantoslima21@gmail.com>
Date: Mon, 28 Jul 2025 16:39:41 -0300
X-Gm-Features: Ac12FXzkiZOTJuCACsH9eciJXYbpbiB3RqMsqyg7AkQNSuAWABTDpt-07AlI38U
Message-ID: <CABm2a9egd7xq5OwEB+pq21wSPJS-89wY5Z3J8Kpay+3EsywDpQ@mail.gmail.com>
Subject: Re: [PATCH v8] rust: transmute: Add methods for FromBytes trait
To: Kane York <kanepyork@gmail.com>
Cc: a.hindborg@kernel.org, alex.gaynor@gmail.com, aliceryhl@google.com, 
	benno.lossin@proton.me, bjorn3_gh@protonmail.com, boqun.feng@gmail.com, 
	dakr@kernel.org, gary@garyguo.net, linux-kernel@vger.kernel.org, 
	ojeda@kernel.org, richard120310@gmail.com, rust-for-linux@vger.kernel.org, 
	tmgross@umich.edu, ~lkcamp/patches@lists.sr.ht
Content-Type: text/plain; charset="UTF-8"

Hi, Kane.

> > +// SAFETY: If all bit patterns are acceptable for individual values in an array, then all bit
> > +// patterns are also acceptable for arrays of that type.
> > +unsafe impl<T: FromBytes> FromBytes for [T] {
> > +    fn from_bytes(bytes: &[u8]) -> Option<&Self> {
> > +        let slice_ptr = bytes.as_ptr().cast::<T>();
> > +        if bytes.len() % ::core::mem::size_of::<T>() == 0 && slice_ptr.is_aligned() {
> > +            // SAFETY: Since the code checks the size and alignment, the slice is valid.
> > +            unsafe { Some(::core::slice::from_raw_parts(slice_ptr, bytes.len())) }
>
> This is incorrect -- the second argument to slice::from_raw_parts is the
> element count, not the byte count.

I don't understand, did you mean that the safety comment should be
changed or the argument? If you can explain in more detail.

Thanks,
Christian

