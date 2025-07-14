Return-Path: <linux-kernel+bounces-729853-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D29BDB03C7C
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 12:51:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CFFC84A358A
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 10:50:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E07D2561AE;
	Mon, 14 Jul 2025 10:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YXH3ndLq"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E813F2459D2
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 10:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752489955; cv=none; b=KsGxt4XbO1rU61XarEQ3m4mEmnbqFdEQ24pg6XyWZNgUK0FJjhkn5yq68LjmL1Iirbj5/7XXW2k7dRptCZuDrGHnSrdOip5d/V3LFMeKUU9xUFgD2ZqSI7D+7O7XT+9sSfitYOrr1F2xOy5nXtYVD3ra+jRiPPU/6sEM7thtg2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752489955; c=relaxed/simple;
	bh=CzH9y1iUWR4nDaqh3cxGyltvFXJQU1S8nDrbLaFGHY4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tc4H9DK5UiAs97HBzI62rbkGctlVKpwDBP1PCIbbr68aRRXlduZB7aRezMa0jBzUwh6HFzxc38PAZoMCVChYDV+D8CEgmFWOhtINBh8kymrrDzGdI5o5pIPmzGFN3VXOzdDa2WZuFmqm3m3HotxaTu9qFooL2adn8pJNj6Ftjz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YXH3ndLq; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3a6d1369d4eso2356283f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 03:45:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752489952; x=1753094752; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CzH9y1iUWR4nDaqh3cxGyltvFXJQU1S8nDrbLaFGHY4=;
        b=YXH3ndLqABBXUGqAl3oZ9cCH5fxiV5KSVs/UfVqjeKjnnrQRG11j7MGbGSWcmJLFQw
         Ek5forruBccjkVZSg1TFrGjhP5AMPOxu8umCpz/cOqCyYNust+o1kimhkmbsecSNYc4n
         JNkF3eH0qzrqmyHC9inAONkQxWBmYyiIxpsgXE8NiqphIl1g/Z8Ud2nQPNoe8zQdJtf9
         qsX9Xll9Ba4tXLaw65fg/AE+dwrA5THT7M21Ujh/6TpsAP8dA6DMhLtxDKfzKrRoDEAV
         Bb9puqvx4FEsxB2qag4Ufj5CTKxg2AvEi36UVYHX9AwTseEBWjtPxU6Rju2EKb3yBFTb
         VuMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752489952; x=1753094752;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CzH9y1iUWR4nDaqh3cxGyltvFXJQU1S8nDrbLaFGHY4=;
        b=E8aKwk4GRwt+KRCm4UqxhW8Ublq3ruMgUB2hswhS3dHgVZgLtXUpWwTxnblsFMnIva
         eGa+Lb9AVHkfeAEepmVvooGX35Tfr6VdY114nN2GqyTGger0g01FvRMwXibkTIA0IzZm
         4p/by1kDkR/7aOQNhuasSbSXERcfy5UBWhRemQnKIX6x93fCShDnSV68Jpat9s6CtU/B
         Tn3+Zze7hRUSnBpBo5AV5J2h0Zotwp4lwV8nJTd2spnW5b3o0CVZSDmJVxxj15a2KwVV
         9EBOlPTZ9tZxfYenR5LJtZRn2R6KgqdZT8fpQd7Gyfy56c+mhvlJE65/i/PZwFKZBB7A
         jwcw==
X-Forwarded-Encrypted: i=1; AJvYcCX7PiaE5nOSqtteMzdKD6dyqF8oJy9rHKiAW+zCb3DuQIaER36gX9UYsDdIVvGgS3mlANBqG7ngCTyoDpU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzrsK+6SLy0sAL50iGJJ/+5Ts7Mkfq2nwRy11RuFJAjCv5FGSb
	gaKi9MDSkDIgH4v+prhSqSTjAXQDnJHc8ygdFUqEtrRaAeCGCIZgQKbVzZH4yaT04N5ybtWoLgp
	WdLxAaOuO8lpYvwAqn8FflqXkQPZ/xYDaUgx+CSOa
X-Gm-Gg: ASbGncu7SzXINzieQMKmnQ6jEVPP2t29ASnfp/MfkgIH7DspgCTskP72tfK74VTYShb
	mOl0bNhKJaxwP+AV6zNR3p13jJ1wBHVWgTaUWrYQkzGBiq/BTu592Woq0Z40JoeMdkeglu5HiSh
	H3/+j9Z1bIs+OmtGCEwD4giX9J/Gtfc2qk5zvsjUTv9K2HPAePowM3pUJ8J9wYqyb7gqAZ7E7ED
	UvaM4b6O7H8gG+uBApUNV6EyKCvsrpU1iPeKA==
X-Google-Smtp-Source: AGHT+IFuaThDu6sKyZay+yZyfsQDiG54qBZB91b9a1e1KVBlRl/3l2slwG5BRUZ3u59AAqElcvYFV3Cdo7cbx5oqoMo=
X-Received: by 2002:a05:6000:240e:b0:3a4:df80:7284 with SMTP id
 ffacd0b85a97d-3b5f351d7camr8115012f8f.1.1752489952076; Mon, 14 Jul 2025
 03:45:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250711-workqueue-delay-v3-1-3fe17b18b9d1@google.com> <DB9A8OPZK3DZ.YVQPQQSD12MU@kernel.org>
In-Reply-To: <DB9A8OPZK3DZ.YVQPQQSD12MU@kernel.org>
From: Alice Ryhl <aliceryhl@google.com>
Date: Mon, 14 Jul 2025 12:45:40 +0200
X-Gm-Features: Ac12FXyTRcfTKMH9Mvagvy6AdIiMuzAfB1WBR_848IQMThGSsgAnTgtWRJa9d90
Message-ID: <CAH5fLgg80eGbYQPeLtHsVqfQ4UmftUpzdhzWaah8qs5HwRhk6Q@mail.gmail.com>
Subject: Re: [PATCH v3] workqueue: rust: add delayed work items
To: Danilo Krummrich <dakr@kernel.org>
Cc: Tejun Heo <tj@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Lai Jiangshan <jiangshanlai@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Daniel Almeida <daniel.almeida@collabora.com>, Tamir Duberstein <tamird@gmail.com>, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Benno Lossin <lossin@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 11, 2025 at 4:07=E2=80=AFPM Danilo Krummrich <dakr@kernel.org> =
wrote:
>
> Hi Alice,
>
> On Fri Jul 11, 2025 at 9:59 AM CEST, Alice Ryhl wrote:
> > This patch is being sent for use in the various Rust GPU drivers that
> > are under development. It provides the additional feature of work items
> > that are executed after a delay.
>
> I thought I commented on this in a previous version already, but apparent=
ly I
> haven't (was it a different thread maybe?).
>
> For drivers, we should also support 'scoped' work items and worqueues, wh=
ere
> 'scoped' means limit the lifetime to the driver being bound to a device.
>
> For better understanding, in C one would call this devm_alloc_workqueue()=
, which
> would guarantee that the workqueue is terminated on device unbind. Simila=
r for
> individual work items on shared workqueues (such as the system ones), whi=
ch
> would be canceled synchronously on driver unbind.
>
> This is very useful for drivers, since it allows to provide a &Device<Bou=
nd>
> within the work's callback, which allows drivers to access device resourc=
es
> safely and directly without additional overhead.

I believe that additional feature is more closely related to
https://lore.kernel.org/rust-for-linux/20250411-create-workqueue-v1-1-f7dbe=
7f1e05f@google.com/

Alice

