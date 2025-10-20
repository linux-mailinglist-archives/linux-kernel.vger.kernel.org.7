Return-Path: <linux-kernel+bounces-860317-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 99E3EBEFD56
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 10:12:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23AE93AAD80
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 08:12:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 172E92E9EA7;
	Mon, 20 Oct 2025 08:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hpxZilQG"
Received: from mail-ej1-f74.google.com (mail-ej1-f74.google.com [209.85.218.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACF292DF156
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 08:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760947925; cv=none; b=NifpivlZquD9YJnT6XrThZLNs/9BBII1AT26RYRECcEO31EZ/AScr7eprnGlhP5fyyfH5RvkyJFPO/vHgIkUnFo4EG1cBgwqry8XUNymdpBLwyPuZwYDH3dDUV/E8k+9yNEqA76h8vK3lLxfi3+ss3Qj7dblt3Pk30KCaU37cho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760947925; c=relaxed/simple;
	bh=ZoL14bgyedgpZA+5RpW1L1FIqwFscmzUrdyV0NBRSbM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Zui+41rk6pLenEZkHWTWyQnypKRgmn6juzqL9khcnjHxv5khH0sGFi40Qrca89zBeCvijFF7EGUdIti4v0eCnpYX/94A/m4XEr10zEJv/Qurr1AnUh+RuEXgLH11cff3WQD/mJ4MqgDWWcSCF3Ak3cHI0cyUCQnJqNExoabWIxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hpxZilQG; arc=none smtp.client-ip=209.85.218.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-ej1-f74.google.com with SMTP id a640c23a62f3a-b548c516b79so469814166b.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 01:12:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760947922; x=1761552722; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=fWJe7MZ8jwnEzwPjrfM3Hh8XieA1FNQV7aYyw1otPCc=;
        b=hpxZilQG+U7mIjok/Pj94mJitsin9uyOktIOgRW5KLpSnA5eXEwF68WnioQnpT0dDZ
         wJn1uGw/brpwVfkFOq7U6APsHMMRUcq+rNj6pttsPHEubiVLnFxMRv+U8eMRAeGTNHih
         ZvUXH9VlmRPUZy3B+s2tq6WzpQYdM0be/vDxs0Pp/2e0Panv5zve+erw0nDnq21buqGu
         5sVGdS/Unv3T3E6Ze+zcd5dGhkLvVT7q3BNEJRqEi4qOMDvyfRKvU/61/aZvx/KWvkPm
         bpCSgYmBum0gge2U1YTp0Zum3QuiB75NafT6R7OEUm0o/Nd3g6hRSv8oKxi+Ycc0dYsH
         WtOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760947922; x=1761552722;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fWJe7MZ8jwnEzwPjrfM3Hh8XieA1FNQV7aYyw1otPCc=;
        b=dABHMEEpVe3A4zXHkrKUJ4WWXf3fc25/6rG8Rx3WAFPU+l5vRpYcBc09NHJDwOwlKl
         Xob/yXr6Bf1j8wnllwsmMk5MjO3toXT4q3gyzhPeb0S+Y5YWxoge/t2NOBOZ7vH/YfQA
         0sViKPofffXUd7rqqpBFeb63gUxGAJWM+Y1VQkO7d2ib91QdfJ6CfHZTYlm4sW+E/awI
         Q7HS6Z+/95x9gPihLO/SbL/7Lwq7Snyrm/ZxRTVG17oekzKMO4mLO1Bkc8UH2YS45CJg
         GPYe8KRV+NK+43EzhNXJFp/gKgrLC7RsEOSe3547Reds+rHNrHZYo42iPgh0NgwpxaU4
         Fi7Q==
X-Forwarded-Encrypted: i=1; AJvYcCXUJOB2NAtlJk1D7v4ZifjY3smsn01CdghB1s9go61fu+jv1yoiKe9ivp3w4xRsDOnSI4+tKk3yzAK7f4Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjaTU4UekQwkJwzo3g2rNtadP4YCFTv6b2kgqJGQqTlaVphRgq
	BwI6npdzL7C+5xPRye/rmtdRk/goIwR0UnWgifWIXZF7UIEpYwYHg8XtCZ9YgzrPPQXqU/CvY+J
	9Z//WfwXbCH9/UJ32Bg==
X-Google-Smtp-Source: AGHT+IFU4/q/yrXzjompL2chxjZ/4cPYB/Mf5R5QHtThbKc/LpszZ+WmdtWzUgy8PhR/q3XKqv4iuEvIjH5lVHs=
X-Received: from ejbbs25.prod.google.com ([2002:a17:906:d1d9:b0:b3c:bf08:ba90])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:906:c113:b0:afe:764d:6b22 with SMTP id a640c23a62f3a-b6472d5bc0cmr1290270066b.9.1760947921904;
 Mon, 20 Oct 2025 01:12:01 -0700 (PDT)
Date: Mon, 20 Oct 2025 08:12:00 +0000
In-Reply-To: <DDMA6OR8V1L3.22YQDEKL20MB5@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251003222729.322059-1-dakr@kernel.org> <20251003222729.322059-4-dakr@kernel.org>
 <aPI9tNoh0I3KGDjl@google.com> <DDKO9M4P06HS.3UMGG3QR7BX67@kernel.org>
 <DDKOLD1897SY.84W93E6L8ITR@kernel.org> <aPSzE7DpA7DxTHmm@google.com> <DDMA6OR8V1L3.22YQDEKL20MB5@kernel.org>
Message-ID: <aPXu0FWUrbxyemPq@google.com>
Subject: Re: [PATCH 3/7] rust: debugfs: support for binary large objects
From: Alice Ryhl <aliceryhl@google.com>
To: Danilo Krummrich <dakr@kernel.org>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, ojeda@kernel.org, 
	alex.gaynor@gmail.com, boqun.feng@gmail.com, gary@garyguo.net, 
	bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org, 
	tmgross@umich.edu, mmaurer@google.com, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Sun, Oct 19, 2025 at 02:01:03PM +0200, Danilo Krummrich wrote:
> On Sun Oct 19, 2025 at 11:44 AM CEST, Alice Ryhl wrote:
> > On Fri, Oct 17, 2025 at 04:53:09PM +0200, Danilo Krummrich wrote:
> >> On Fri Oct 17, 2025 at 4:37 PM CEST, Danilo Krummrich wrote:
> >> > The reason I went with a trait is because that's consistent within the file.
> >> >
> >> > Otherwise, I don't mind one or the other. If we always want to use a struct, I'm
> >> > fine with that. :)
> >> 
> >> Actually, there's another reason I forgot about since I sent the series. :)
> >> 
> >> We need it because we derive it from blanket implementations:
> >> 
> >> 	impl<T: BinaryWriter + Sync> BinaryReadFile<T> for T
> >> 	impl<T: BinaryReader + Sync> BinaryWriteFile<T> for T
> >> 	impl<T: BinaryWriter + BinaryReader + Sync> BinaryReadWriteFile<T> for T
> >
> > You can still use a struct:
> >
> > struct BinaryWriterVtable<T: BinaryWriter + Sync>;
> >
> > impl<T: BinaryWriter + Sync> BinaryWriterVtable<T> {
> >     const VTABLE: bindings::foo = ...;
> > }
> 
> Yeah, but do we get something for adding yet another type in this case?
> 
> Another point to consider is if we want a more generic fops abstraction type.
> 
> In any case, I'd like to add this as good first issue for the whole file to be
> changed accordingly.

Yes, keep it as-is for consistency with the rest of the file, even if
the file is inconsistent with the rest of `kernel`. Please go ahead and
file a good-first-issue for this.

Alice

