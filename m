Return-Path: <linux-kernel+bounces-723727-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0836AAFEA5A
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 15:37:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B98155C0179
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 13:36:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 852992DAFD2;
	Wed,  9 Jul 2025 13:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zRDP7tmq"
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A70AA292B33
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 13:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752068185; cv=none; b=ThZRw86zHwQuxwnGkwLkflDQTNOBXrdl615/9AADQOKhZVk56852ei/IgtRxzO2tVhuPFCCGqDV3uiMj5hj30bbqwvS3Xb/cKuwKfUFdzknE4f/oT6fYGmEJQsreyeHWpTqOzA+q06tf+GlgSl/zlbrEF3eMBbcYBoKY/D7Csso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752068185; c=relaxed/simple;
	bh=unlKXJBhWL7HE7TTDy2vTAHpjeg4BcukQ6864uuG9pY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KOLTY/k/K7cqnxaaZ0tmYVha2F5poKCewgC0kpqvMbdjxkLGL/7emhG9S+5gu8cj0t9GkDuyJ36G7/6C/gQEsESfkGqa88OFFu0P3vAPjtKgkyX5fVefSYbpCVjaySVoQk/0mSyXwjcbQovVTFEbXR0SLbOA/m1CEeUEPzyAFMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zRDP7tmq; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-b3220c39cffso5441552a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jul 2025 06:36:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752068183; x=1752672983; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X8QwFWHnoroOy7d+kOIv7RQtuglWSW8t0P8/KSAe0Eg=;
        b=zRDP7tmqJWIOfk3IHMdsl/YFqxj2YIaAUKXyr02Lx+sJyw1vqVGFScjMTsRIy6CEtW
         vAGVaFGLCnYmOMOzRvTI+lNnamUymqAbxS9fs5O/451M9YxvgvPQm0H6EGigRfIQzdDW
         BZ4l5380icUd2gk0J8dgWczb73A5KQU/H843ULa/U9mxgMjAMOv5HSQ+FWSBWEpi55mh
         0kQTw2bMbMsAKGwKeL8j3zCU1TFjIKhQQ84lJ10uIOkyUZzZWE+R1DTTbJegus2Y2Pqr
         sJWF2PZrlLqZgfOVHteYqOUE/RVyT4eED/0gDTyuftDOTgvTz3aP+NRfLiLJX4DrFj9D
         COCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752068183; x=1752672983;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X8QwFWHnoroOy7d+kOIv7RQtuglWSW8t0P8/KSAe0Eg=;
        b=Xo/Pj8I9b/RSNBPAtr+4Q9Q1vpxbd71q+3yPv9M7k3ddDbmJc6TYfW2fDb9pSOq4tq
         sLnX9G4JymubqTjthieeBZPvOLKF1jUxlZxa31X0QpzXYDzW4O0TD5rf7TXG1YrheP38
         StzPjflQvh/hLnPWNjddIAzTb09dIOf3wElIt5BkMjRXDpwPjrEwMmqtoWHoyWIEzMOF
         OU56sV5HuGBlybOz1sO+qK+SjXWcZkaZLYNBXlrYzcaKoglNI2X1/30fs8IKoFbbj7/3
         ccDfQeFlj96VcbDnjypbFiXXhVN+vvLDBpXR65ACa2aFkGLuqpAwb13EiCB0OMFtCPoz
         4HvQ==
X-Forwarded-Encrypted: i=1; AJvYcCVA30S6HrswRUaii49+R0/amgSMH4WhnsWYt7S/Irq56l/R0yTC2CSRnwYv1eHZTMZxZtSeDBfIRJToxn8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXoBp6YjnvRrqhqYMrVnNv1TrHanBAeNz/UTHUMLKY+1eyu2w5
	opbs45O+Xss+C32IFloHw6BvVPGdwO/0gZVWHqIOs7L4VH1hbi8NMK4IR92OQssLWNSkhbQ9U1w
	QfocImJj/UY/9H3y955ctqV6b+hLKc/wQ2SiMFU2C
X-Gm-Gg: ASbGncv5f02tkC0R0mq+23HKITg99SPZupVtvf3TJnKBu+SZoPny2Ts/uzoIcrXYgKH
	+AtAHhJrNnjic9pSnQeHYov/E8nLvT0I33Z7u/hUrUlp0vTNJqw3XAHMK12R4eYnvGvVxIIwvyD
	haXj6Hl0RUBdOpXBqnPi4tEN3diEqHqd8AwkSLQYpoc0zYjy+XPtc7yiEOYxRXQBbE+LzYTkO7L
	A==
X-Google-Smtp-Source: AGHT+IHLUaG78pPpolWgvKxo7JAqt+c+YIceLIH7tszHkOE1Sbi1pPFiMPOEdkHK6zyKwEyy9jYPRuBMaEXTzhgKa9Q=
X-Received: by 2002:a17:903:8c3:b0:235:e942:cb9d with SMTP id
 d9443c01a7336-23ddb2e2117mr44522245ad.17.1752068182802; Wed, 09 Jul 2025
 06:36:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250704-topics-tyr-platform_iomem-v12-0-1d3d4bd8207d@collabora.com>
 <20250704-topics-tyr-platform_iomem-v12-1-1d3d4bd8207d@collabora.com>
 <aGt6CZAUeuK0XnmP@google.com> <F1EA22CF-1C01-495D-97ED-59D51A45A8B0@collabora.com>
In-Reply-To: <F1EA22CF-1C01-495D-97ED-59D51A45A8B0@collabora.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Wed, 9 Jul 2025 15:36:08 +0200
X-Gm-Features: Ac12FXx8MsH1eDIFhZjajAuMUIOv4XaodeklU_8Hl_wL84YrJfqndKHflkJLh7E
Message-ID: <CAH5fLgg9pL0LhaWAMNKig+vnoB97U9zybqjdQieWYB7QdyAwAg@mail.gmail.com>
Subject: Re: [PATCH v12 1/3] rust: io: add resource abstraction
To: Daniel Almeida <daniel.almeida@collabora.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, 
	Ying Huang <huang.ying.caritas@gmail.com>, Benno Lossin <lossin@kernel.org>, 
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	Fiona Behrens <me@kloenk.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 8, 2025 at 7:44=E2=80=AFPM Daniel Almeida
<daniel.almeida@collabora.com> wrote:
>
> Hi Alice,
>
> [=E2=80=A6]
>
>
> >> +
> >> +impl Resource {
> >> +    /// Creates a reference to a [`Resource`] from a valid pointer.
> >> +    ///
> >> +    /// # Safety
> >> +    ///
> >> +    /// The caller must ensure that for the duration of 'a, the point=
er will
> >> +    /// point at a valid `bindings::resource`.
> >> +    ///
> >> +    /// The caller must also ensure that the [`Resource`] is only acc=
essed via the
> >> +    /// returned reference for the duration of 'a.
> >> +    pub(crate) const unsafe fn as_ref<'a>(ptr: *mut bindings::resourc=
e) -> &'a Self {
> >
> > We usually call this method `from_raw`.
>
> Hmm, pretty sure I have seen the exact opposite being asked. In fact, thi=
s was
> discussed a bit at length a while ago. See the thread starting at [0] for=
 context.

I will submit a patch.

Alicej

