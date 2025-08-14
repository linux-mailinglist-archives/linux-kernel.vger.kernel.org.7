Return-Path: <linux-kernel+bounces-769174-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFF21B26B23
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 17:36:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E5F85C5E65
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 15:31:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F1D622576C;
	Thu, 14 Aug 2025 15:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ang7R0oi"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F54942AB0;
	Thu, 14 Aug 2025 15:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755185499; cv=none; b=qyLOr8OsWMfi+EsO3ZB/sISNVNdj6Ze/yOupbcSRxpyQ/qOOVklRiGMCGYi3H/PPyrX5d1Tk30YxDdg86F42l3iloVfLeJxcTdeY0cfQqd/+x1O1e/qIb3CtWA6Dbg04mdcUMqtudoR22tWGKHhlJ9CAmuQK+ueIJDTpgyg/1co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755185499; c=relaxed/simple;
	bh=LU/1gKZOxz6+7ZvFfuJpr/JtkZeBl0hplrrh9n70z6U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EJacCKRfzUrAbJT673jJfWl/If51x8Uxkw9QOAPB3nDqbik+vNSol+MfHllzqTEo9LC8z0MPGbiiWDMDOTfem7SA5Wf5UDZ26wyNrb5bAiL12TgZoKM1oJhuzTdzAKqwoLBDqNurA2Kf8SxG3DvEZpQxGZFB6FusHHoHh1x88PY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ang7R0oi; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-244581fdfd8so1728055ad.3;
        Thu, 14 Aug 2025 08:31:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755185495; x=1755790295; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LU/1gKZOxz6+7ZvFfuJpr/JtkZeBl0hplrrh9n70z6U=;
        b=ang7R0oik3/hCSeDNUm0qnm9x+bxTgNGmC9EJlgnfLtJDiZKwgInWP+8UvTFodzfBD
         Hh2UUW+zZ3uiH2rPuIw8BdvrNSG8SW2TDFgzGJ0ejZ4yfhI2cnCOIqRJPuvopJ1j+wJY
         5CxNYc9jvMWy7klYvODFjB3kGY0rdoW1aVE0c2ckOyK0nGZ6E0/eGKEsNCiB4teFQkhg
         HiLORoo+DI7h1VzrGOn7FO/b7NacaQoxfOgfkCEeEv5uPTU004bGW/st0vibZcxUZFgK
         PJB3KZam24v2sVn7aOoRJ0ARCpHdj1AIwb52usqllOzp33PCg6rVmZff6uopHa4El6nH
         Hueg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755185495; x=1755790295;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LU/1gKZOxz6+7ZvFfuJpr/JtkZeBl0hplrrh9n70z6U=;
        b=s5vXxvb3EV9baO9QCnB7lil0eMW3tTObtq1sAFAGpii0EhTv/c+IgtImoYlFzWhD/I
         jV9u6uCcyAKDp3xuQOZuJQmIuuAYEOqCnyGfSzS8+BEEG0564PBELAGV97PUkXKmUnIV
         6sBrztRHeGAtia/Tvlh2xcoru3schTI09xwAydRwnOzwKfegFpjp4gGQ/S4qrE6ipf92
         XC61tOy1HnjeVukpc2oq5zIvXdUBae0uWuypJWoZLssxH0kzYhAGP59Sg+7fI09hgg2P
         DGLPWJcmUHZtT/XqwqBWH6EMN0ndFw6wuEcEF4/WwmKcC/+ogtgz2duuUiPhKPqSI231
         geQA==
X-Forwarded-Encrypted: i=1; AJvYcCU2CVYEBi2YuRxmV1j1Yuej5aDPfYr+HHwKSSWSBzd+G/MB/OBGM9M8l8kNOxHtk6UXUnJfWkmRiFDF0Ewt82Q=@vger.kernel.org, AJvYcCVTdM8K0CM1+NXW8FRIccnqPhqwPWYvI8JXPFK0uj3GAJTWXe49rA+tXIxuCmDF6kDn1p8XIJE1+WlW9Jo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYWKni5S6yO4bKTAdil75IiLrOKlcTRD4fpLIC3j2Ekk6mZrc6
	u3YiG4L85itDVBH157F5JPv6HCdrTIQKttDpjPDo8VvjQYgBjfS8owgtZ9OnPhhO4+msCmbbeB0
	HSk0F0+JtcvKjSyhp8nNh/apP5LQ/W/E=
X-Gm-Gg: ASbGncv6k9YU8S/YykvFoVbeonSpApusRLxdf6EUjCnl/RM3Q+OiTT2heezelstAUOx
	04zy5zoGv6RIc1HVdkXetHhScTSYkVO+N32P8/WuZzkbqc7tYFOchxStjWDCdW9PNUGniC6VqBj
	0sB2y/M5KfnTuknZ+bXWDXqhIeJQKgg7KHUQlhqZfMmIqqqpJWawAUPnw4LFtlaGEl0SqmgECXX
	ndz135/j7oValjI0JE=
X-Google-Smtp-Source: AGHT+IGJur8eDO9K1hdDxTlxOpgT5Pomr3SFU2C2Ghwp3vKU6/+Z8xJXEwvz8/CMBzLO6YN7bTkYzy1Nw2eogMXMjhw=
X-Received: by 2002:a17:903:32c1:b0:23f:fd0e:e5c0 with SMTP id
 d9443c01a7336-24458762ef6mr28265045ad.9.1755185495138; Thu, 14 Aug 2025
 08:31:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250814093046.2071971-1-lossin@kernel.org> <20250814093046.2071971-8-lossin@kernel.org>
 <CAHC9VhQXOezJ2=B1BQOqLgfuzDJEVS5G_r9+_bQ+OUNTpjZCKw@mail.gmail.com>
In-Reply-To: <CAHC9VhQXOezJ2=B1BQOqLgfuzDJEVS5G_r9+_bQ+OUNTpjZCKw@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 14 Aug 2025 17:31:22 +0200
X-Gm-Features: Ac12FXyXVVQV4_LxnJmVqszLhx8GaEU7HFqILUzoF73x_Ip0i_qaLuQpzE0emCE
Message-ID: <CANiq72=vhPsGjSx9u0FvDa6uzMFkFQFP9qG+DhtZ_U5TyV=bJQ@mail.gmail.com>
Subject: Re: [PATCH v3 07/11] rust: security: replace `core::mem::zeroed` with `pin_init::zeroed`
To: Paul Moore <paul@paul-moore.com>
Cc: Benno Lossin <lossin@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Fiona Behrens <me@kloenk.dev>, Jocelyn Falempe <jfalempe@redhat.com>, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 14, 2025 at 5:19=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> I'm happy to take this via the LSM tree, but it would be nice to see a
> Reviewed-by/Acked-by from someone with a better understanding of Rust
> :)

I think the idea is to take all these through the Rust one with
Acked-bys from the maintainers (or we can skip this one and do it in a
future cycle when the first patches get in).

In any case, Benno is very knowledgeable in Rust -- he wrote the
library being called here -- so unless you see something out of the
ordinary, it seems OK to me.

Thanks!

Cheers,
Miguel

