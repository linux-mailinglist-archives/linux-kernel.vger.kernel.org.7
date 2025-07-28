Return-Path: <linux-kernel+bounces-747412-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49157B13385
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 06:00:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5ACC47A7FF6
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 03:59:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93E59405F7;
	Mon, 28 Jul 2025 04:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z9zTjbpI"
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90CBC1FC3;
	Mon, 28 Jul 2025 04:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753675240; cv=none; b=p+9KgHGssLCKSq5aVL/E45rQQsIvrGzfpGb3hREQltTQ0wc4jvp7uLDcXPKVDPl5ZCU4AHmZ9kZvT9stlQ4JHlDmoAoNkrMidF6ZWbu7a2OYFKVCRnSydUtO01tEkPKoAT9XqCZRwasKjSbxv3SuPdusI4OZX+GhDc8CQldHK48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753675240; c=relaxed/simple;
	bh=qvN3pWCHp4FPHVOjEd0CKFbCWxdZzTv+jVDywDNGm0U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t9bWHSR02tP9H/qtnJgcHnQIKnXEbmArU2GkAxS6HV7CFWzV3e4VigYhsX09tISsRnt8LeKSMtnh4xGrH9IhsaeoAaWLXI0ry3dCD5dUsUBEgRaPby75vMEa9NwK1RaorxKuPzLwVYL00b1GhJyEMNHcEzbhLxmW3dspUsMjjhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z9zTjbpI; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-2cc89c59cc0so3312623fac.0;
        Sun, 27 Jul 2025 21:00:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753675235; x=1754280035; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qvN3pWCHp4FPHVOjEd0CKFbCWxdZzTv+jVDywDNGm0U=;
        b=Z9zTjbpI/L3wo91CXaGP7lha8wDf/Nc8BPa0N+TH+PbylexMLqXv2YKuXEQ1u5N4HK
         Lm1WLyL5ImS3Bu72Rycs/G23edOP8oJUQQ9L9mIDOgi0FDBryitLlJDrubRuu7qs9k3v
         CroHtHX+wJO6yoQTYoQMSRF5FIDBCIunwOEzny8G82LCniTbGvlxPlAUAohL0mYZRujP
         RDwTKvOWsiYGBb4Cwqw/VJANZ1Kgm6VmWFBqi7bZz9ER0p3UK7NeUAdP9av37t3cDMIZ
         6cc1dTsK7Pb0i4J9kCQ+HfCG4MeTXIA1dICYw9csy9WSdQcdPvgAzEOXAIVcVRLCA4sT
         g9wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753675235; x=1754280035;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qvN3pWCHp4FPHVOjEd0CKFbCWxdZzTv+jVDywDNGm0U=;
        b=eRCvbHTU4BaiYIPkwpiE297myEhOtH2MOppYFsjEVoY5w920LRNxkUV+WQmCoQ/EwU
         Q53fjulUGXCx2finLVMOD/UFrMzysE72TyNVwbtkFbytZTWu7TE701XT0SSlESXCqpZ5
         vvSl15LAP6cv0EOU/MzDqCsKU3oYbAWTBySBKjy1a4STy4FJmmhaxaUYvPcvCXXEZMvr
         Q4D40s4nTes4BODKMc4gjax7ek2DvXqSevqeNRmSZCNCuEQdJCHjCBFDi7FQWwYChbEt
         9qRUU+8l/HX0Sj7W3Tq9W3YjDO3VetJAQWAWw1f9WzO9/ggnZXEsL9l03fGvL3p/EjeD
         tEiw==
X-Forwarded-Encrypted: i=1; AJvYcCX1hotgzZtnGKELMrHvds0SQBNiiK0w/k4FDleDS+0XrpA9imKrbnmo46z0k7FQS7xtHNb+8hQ6X6tmDjA=@vger.kernel.org, AJvYcCXLWAa+hyIknsAGa3nHMYZwOiCB26YWFehrSom6rm2DhoeTjS7ec3mp6vZKMaO4YS67h0OXP7IcJsA8z2uHHfE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqSOSFFDQEdYWkbJxyaGCtY5Yn4sxP1CI8yZ0Za37hl56rsi6d
	ThEVzubGWoEA/QZlNfgL2QKx4nW0kcWY0hPulXmihHiUP+i1QuzEsTC6gqgwA8PnpihY/FhDU4H
	8VixxbINSSrNSX3PH2aph2kB1a+2Afvs=
X-Gm-Gg: ASbGncsaVwGgIaWVPP0IQ7+K5tA3ibnt+QgYYV3W5tQN7x7SRVdXeCoWI8vv2JiMMdw
	ldNS7G8CxIphL13GFP0o9JjIxtsyXAxew2NcEuWXecTkEAcjNQ6813Us52pU7fFUrJ4fKlw02yL
	SPmcnIemHrzYqnFR7iVmJBCkJ4iywN/KCNkgQBcn2Ktm7NXFJFg4PRAuPrFvP+I6u3ZMSqlh25t
	Vk1JcB11QrbiEWUwh8=
X-Google-Smtp-Source: AGHT+IG7FXpna1h57gCU/IkaF5+PeDeNtItAlACpGm7WezR0tx16skuQv/RQ8wWIaxf19/YYa05/tuTKHz5x2htsUQk=
X-Received: by 2002:a05:6870:c0b:b0:306:e708:c958 with SMTP id
 586e51a60fabf-30701e53fa4mr6524644fac.4.1753675235542; Sun, 27 Jul 2025
 21:00:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250727170217.206794-1-suchitkarunakaran@gmail.com>
 <DBN0JG0QP7TU.PZSZ8NZL5LD6@kernel.org> <CAO9wTFisWa5qY2qQE+BEdD40vacGwtzw=2xxPnV0V_w=Gt4jwg@mail.gmail.com>
 <DBN16LSXVANU.1LMW8POGVF2CJ@kernel.org>
In-Reply-To: <DBN16LSXVANU.1LMW8POGVF2CJ@kernel.org>
From: Suchit K <suchitkarunakaran@gmail.com>
Date: Mon, 28 Jul 2025 09:30:24 +0530
X-Gm-Features: Ac12FXwH_4SIl4ADStj1aszm5Xio2dj4WhMN5qSwGpTUqcV6kWhDWBsCgDQ-d28
Message-ID: <CAO9wTFhB1cJJOFOo1MWdXpoPau9pun8Of958DAB8Mwb-HPW5Yg@mail.gmail.com>
Subject: Re: [PATCH] rust/pin-init: remove workaround for type inference cycle
To: Benno Lossin <lossin@kernel.org>
Cc: ojeda@kernel.org, alex.gaynor@gmail.com, boqun.feng@gmail.com, 
	gary@garyguo.net, bjorn3_gh@protonmail.com, a.hindborg@kernel.org, 
	aliceryhl@google.com, tmgross@umich.edu, dakr@kernel.org, me@kloenk.dev, 
	chrisi.schrefl@gmail.com, rust-for-linux@vger.kernel.org, 
	skhan@linuxfoundation.org, linux-kernel-mentees@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, 27 Jul 2025 at 23:28, Benno Lossin <lossin@kernel.org> wrote:
>
> On Sun Jul 27, 2025 at 7:44 PM CEST, Suchit K wrote:
> > On Sun, 27 Jul 2025 at 22:58, Benno Lossin <lossin@kernel.org> wrote:
> >> On Sun Jul 27, 2025 at 7:02 PM CEST, Suchit Karunakaran wrote:
> >> > The `cast_pin_init` and `cast_init` functions previously used an
> >> > intermediate `let` binding before returning the result expression to=
 work
> >> > around a Rust compiler issue causing type inference cycles. With the
> >> > minimum Rust compiler version for the kernel now at 1.78.0, where th=
is
> >> > issue is fixed, the workaround is no longer needed. This patch remov=
es the
> >> > unnecessary `let` variables and returns the expressions directly.
> >> >
> >> > Signed-off-by: Suchit Karunakaran <suchitkarunakaran@gmail.com>
> >>
> >> I still encounter the cycle when compiling with 1.78.0, which version
> >> did you test this with?
> >>
> >
> > Oops, I just realised that I compiled it locally and forgot that I had
> > installed version 1.78.0 on my VM and not on my local system. I
> > actually compiled it with version 1.88.0. Sorry for the inconvenience.
>
> No worries.
>
> >> Do note the comment mentioning that it is needed for version 1.78 here=
,
> >> so I think this patch still needs to wait until we bump the minimum.
> >>
> >
> > Yup got it. I'll send the patch after the minimum version is
> > increased. Thanks for reviewing.
>
> If you do, then please send the patch upstream at [1], that makes things
> easier for me, thanks!
>
> [1]: https://github.com/rust-for-linux/pin-init
>

Sure, I=E2=80=99ll send the patch both here and upstream at [1]. Thanks!

