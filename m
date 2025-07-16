Return-Path: <linux-kernel+bounces-734369-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 31977B080AF
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 00:50:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5942C1895D5A
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 22:50:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A68882EE979;
	Wed, 16 Jul 2025 22:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YrfSYGoI"
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5CC72B9BA;
	Wed, 16 Jul 2025 22:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752706204; cv=none; b=boR8RyLpmcWhqMQTRZqAdomfN+kuB2gKqNoRF5CmDwJ+AjLjfrfvxXgCL9aaNUJ6cF88rp4TNus0K982HnyHvawDMatGveQrmqXw07wlM1ldinhB/Y27NolGZAa1Bl2ANUPR9RB1x+htATqwW0IPntiJhGDq6IorZ4DzUR2tSX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752706204; c=relaxed/simple;
	bh=OfUMEMQOMzzSGQFLVdUDoMaa4cvjgwf9psymKx3Lkjg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QjQRvxQ0cqGcoOrqqPi7Fpt4vgD4YlMVh+zUeoqhJa8qhCx6bqVw8A2drqBP5ymC4vtLc4WbSOGiLDpHHglVKqn0uhkTwDXLCgC1WFyUfmi6AVV/Gdx2oJGEpY3znlFh5MaLjOXnxn+BOfBmsZKzmzMIZ5q3zMNPGYsIgw3dk0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YrfSYGoI; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-313290ea247so65856a91.3;
        Wed, 16 Jul 2025 15:50:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752706202; x=1753311002; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MbH+u1rodwpAxNucK/64q5+dFLdR7tYEvjWaz3anAlk=;
        b=YrfSYGoIM/+tV4v8nRqrhVWHhRygDH0ZkL/rqBXqDzjBylDtQHORjcXpomyGG4DkmU
         OCD/NiiKRT7+bwe1tsPxG9rbnMXicwHPPE5Zf5kaop2Ke9WEoebFFC4E2SFPqHiISrmD
         cDiJRsN1p8Fb1Io9JfT/tcT0tK/eBV58xyOM+xK8TJanse3gTJKVVbX7mG6jJP5x++Pi
         fool7zGXmHKHPOrrWAlIruW5tD9lsjggMRgHTib01eW2EfvdAcf/G/NRWXP+3pCSq/H3
         vND/e3xj1lIUFuEUoLOV7FHZSgF+daXmZPCloQRi+NXKiUrftn7xxamQnmaRaUra0hG3
         P3Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752706202; x=1753311002;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MbH+u1rodwpAxNucK/64q5+dFLdR7tYEvjWaz3anAlk=;
        b=XNTNAeIg0n4ZBNJ2o1g2ohjPbi8ZgJZk/ePa5zJtGMgWib8XPGos1A1YmqWfk44ro7
         shmFoCAUF/kNluCHe+BX1V7kwLpNgdfYqXOdRzBVGDtjO748tpBu5F1fCgjeeK5ytXll
         J5ZNXLHZRSvdgyItB5N0QFZXe7KQjwGkW+jWZJz9aLTCXD4mXk6HVtXfO4YfWlU/9OVU
         YNKRHoBVBLrPu/nVe0TMpfctVqL8iQyQ/xNUkaY50I2p2VnYGAA4hehlXDeuHLnOU0BL
         qgeQpV1QzCidftyXv054AyHYsgOE3Vqh80re39kh1vXVTMZ+fvZbgSBpvlIyKNzxwMfn
         4FZg==
X-Forwarded-Encrypted: i=1; AJvYcCVV1JPwTUOFUEC96k4JUBclCbLG0c+jf8/7Mj/IjFSnRFgpOIK4MZP5fCx8haBTt2CAX3eua/+5A2Ot1HIcihY=@vger.kernel.org, AJvYcCW3sDEF8+zhk1OWryj8G6X64QUG7s9mQofN8pWn8ArP2D0dJgrO3+SwLL4ZyOEf1zQoIOHqTk+ryZA4yCI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5WnXj210zLrWPATJ+oT5ouxUbLaYBzuBvr8qFGfAXpgl4TBil
	Ohha8hAXP7TnD6GjaXlplSm3nUmxbqb/vem/vduCi+T5endKUl9hi7nibRS/r4q4qRIMqeMn/Aw
	QNmsj3EOCOIP2qh/htsWwl/+xPkZ27gc=
X-Gm-Gg: ASbGncsU4EhkaeV1pckzXu++aTQgXD76xflCh2EOpH3OauB+fTr6iahIPUZ2LdzwhpL
	GNpv7sj49ifQQwEbRGYEMqyTpSUKpiXa+L2CAku+tihCrmBjIKVAJ+FHcU21GllZ6Tfgtsdywdi
	HTXlwz/moekxWB8MK4SmgJoR8PhmOEuYPxzdnTosqX2qXcXhL7KIpi6Yl5Soplvyrhh2kpqdp1O
	x1LcA==
X-Google-Smtp-Source: AGHT+IH/Ka6hw5E7gG36YyGJiFuuWuCKIIhNvFZcbhwn5egc+1wUI4lMTxD9cYoe0tsgADSzp//4XWshYb9b14UOmDY=
X-Received: by 2002:a17:90b:3b4c:b0:312:e9d:3fff with SMTP id
 98e67ed59e1d1-31c9e6e8353mr2688611a91.1.1752706201861; Wed, 16 Jul 2025
 15:50:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250711-workqueue-delay-v3-1-3fe17b18b9d1@google.com>
In-Reply-To: <20250711-workqueue-delay-v3-1-3fe17b18b9d1@google.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 17 Jul 2025 00:49:48 +0200
X-Gm-Features: Ac12FXwbBrk8wwAlRr13R4eh9A_hS75UpMEt3Vnbz8b2DxoYGuJFLuERBeNx7qo
Message-ID: <CANiq72mwz1_CV9Gckcdg-WRa1ufOrKNU1Z8V9rM6POcwesD4KA@mail.gmail.com>
Subject: Re: [PATCH v3] workqueue: rust: add delayed work items
To: Alice Ryhl <aliceryhl@google.com>
Cc: Tejun Heo <tj@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Lai Jiangshan <jiangshanlai@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Daniel Almeida <daniel.almeida@collabora.com>, 
	Tamir Duberstein <tamird@gmail.com>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Benno Lossin <lossin@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 11, 2025 at 9:59=E2=80=AFAM Alice Ryhl <aliceryhl@google.com> w=
rote:
>
> This patch is being sent for use in the various Rust GPU drivers that
> are under development. It provides the additional feature of work items
> that are executed after a delay.
>
> The design of the existing workqueue is rather extensible, as most of
> the logic is reused for delayed work items even though a different work
> item type is required. The new logic consists of:
>
> * A new DelayedWork struct that wraps struct delayed_work.
> * A new impl_has_delayed_work! macro that provides adjusted versions of
>   the container_of logic, that is suitable with delayed work items.
> * A `enqueue_delayed` method that can enqueue a delayed work item.
>
> This patch does *not* rely on the fact that `struct delayed_work`
> contains `struct work_struct` at offset zero. It will continue to work
> even if the layout is changed to hold the `work` field at a different
> offset.
>
> Please see the example introduced at the top of the file for example
> usage of delayed work items.
>
> Acked-by: Tejun Heo <tj@kernel.org>
> Reviewed-by: Boqun Feng <boqun.feng@gmail.com>
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>

Applied (yesterday) to `rust-next` -- thanks everyone!

    [ Replaced `as _` with `as ffi::c_int` to clean warning. - Miguel ]

Cheers,
Miguel

