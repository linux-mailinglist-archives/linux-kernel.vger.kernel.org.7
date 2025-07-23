Return-Path: <linux-kernel+bounces-743158-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 128ACB0FB48
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 22:13:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E7963BD14E
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 20:13:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61C0E230270;
	Wed, 23 Jul 2025 20:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZYbfbELI"
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36C571F582A;
	Wed, 23 Jul 2025 20:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753301604; cv=none; b=T+xgmTQsCNIkjAgQf68EGl4DOOT6vpJZm1CZDs5zuqOn0/16nNrPPJjj/J7lW9vN2xR4OkOInO3Ne3plptRXSDLeNtB9xR1HX4wXOeHMrPmIivTTV1VPcIIw6LdKumkSTT6QsK3KJ9FqknOj0IiGDh0m8PwbuZAZXyRzJGAUkXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753301604; c=relaxed/simple;
	bh=ylYanMq4QiH/Nuxn+ZxPn1KRHnHotyxLQy5lT3t7C3k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dIGxIamOOeOUkrSNQbJViL5QsYcVWSa8mZkX7DGWCKKEk4uFwkAbuFEJuCGauTUqX4ccZRBd8jMqg9jpyb4bdkW3jxeCb5JE0bUQkXGmscdBAnHpAp6DEWn0K13NqAWM6P8uQkdQ4nMWK0H/NIzAwPU1Hfy3fXW4TiB+vDhAch8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZYbfbELI; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-32b31afa781so1615461fa.3;
        Wed, 23 Jul 2025 13:13:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753301601; x=1753906401; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ylYanMq4QiH/Nuxn+ZxPn1KRHnHotyxLQy5lT3t7C3k=;
        b=ZYbfbELI7a2bVuGyLo1r1Rbgc1O125H34h3kY5YfdUcM+eJlNPInDuYWZ8Skz1Xgnm
         6hAEzNlUFfa4Ndm6hj5i4y3Kjo5p6qX/qHUNxo0NeWai1hWphHSD/7G8LXWmU13jjDUh
         PNCK3kZ/n6R5Op3X304DK8LngnhVa/FeMkE2iskfkSQFZWYM0onzTCqKPHbAjJHW6icJ
         G7sMvAKsfgI1rtaodQH4IAkA+IByaEG74Bj1xMQbeYnwYZo/tJLAl8xPdp7ZDnlaW0wR
         qu6jjrkc2rE8Y2UcwhK8jY5HQUwWa868+KzFx+61TR9H/12NXSKXtqhiXkmJfL4PQbC9
         ujVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753301601; x=1753906401;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ylYanMq4QiH/Nuxn+ZxPn1KRHnHotyxLQy5lT3t7C3k=;
        b=NzdzcmZdWMEbGdop4D5RmwBN1EW7VARmgJP+uzF7iWjnHCggS5QztBJqiHPGpEww94
         7XYzu9AzCuepE9EB9fDdImsM1qgIz4rBx/P9YxsEArBF0fGPkAlRyGSB4D2q+SiCzVc9
         CCKVBhwReaeKpfrELpS01P1m0QAIRJMrvUf4LM3/3HQoD1PhBxqC38X9Nmyz+2wE9uR/
         i3DqGa1NFVkeUJvDwelLW7iRTIkHjgBZQNjtYp87vxDRswkiocQIZsjpfptA6Y/mzpp4
         mcaflFFgpC0aE/UHlgdXdeN3L4agMpM7mnzltgAWg7qPL28Jg0bIyXtv7ovCUdDEagfX
         WRKA==
X-Forwarded-Encrypted: i=1; AJvYcCWD3cJ+uAXK38BuCUs5lrtMd2lbkb3UcCj5rt6kzW9UXjlE9FckUX6BNRvF6QyLsPkU8yVjGNClRLdcyVqAGOc=@vger.kernel.org, AJvYcCWhCnp3AAmnTs6kZO5tegCtq0lTaYLMLAX6sZ+smIRljTdpBgidXuWd80LXA5kOf03giCM0gwbywjIE8k4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOf2JRGShdY52gKpL25uAgUpYKFgqCPb8HS219YS2FQc62qO5E
	YwyT/OhCv59RkNP4RRSghhDzYUAAFj7IRST/6YrQMPu84P/jvdkSx66xvvTb+FuoJXS80D8CQG+
	UbPvisse3G7AowKvX1c17RtZKuo8CbME=
X-Gm-Gg: ASbGncvXViZxVrWCdJ9eTnkSBLfMzdd7/V6WOa/p8nRcPm5k4Gt3U/o3vciH4eBEW64
	JxLj/2mYhNy6hX/6rPyd304EWYImq77zRbRLRFUt4PrG9OoxvvKfRisZW8IJ4Fl+qnULqIdMfe8
	PeupwcI6sXCMLiriS6inylDtWoX2ntg0wTjtaKu1WrV+ZZJBipPO1R2rwcjCkVqgch5NjJlmjNL
	b0NRtsu
X-Google-Smtp-Source: AGHT+IHlO6G7bCbrG9T5hhq16v8glKCdv3hfhn9O3kkyOZIuvZOWRcqBb7C98wTwk3/Qh4cF9V8eQKt4DMOvfGtuA5Y=
X-Received: by 2002:a2e:be93:0:b0:32a:88b8:9bf with SMTP id
 38308e7fff4ca-330dfc75adcmr13660331fa.9.1753301600965; Wed, 23 Jul 2025
 13:13:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250720-rust-remove-compiler-builtins-deps-v3-1-0df3a493973f@gmail.com>
 <CANiq72m=vYbZZPwF9u9PQJ7Jce0KPR7jPybk3AHV50U9fOmEvQ@mail.gmail.com>
 <CAJ-ks9kuCTnmhJRJyuuyGST-W_9TDQkg8iWm3YoOtP7_d_NR0w@mail.gmail.com> <DBJP45SOWFQI.3FY7X96EZT2HG@kernel.org>
In-Reply-To: <DBJP45SOWFQI.3FY7X96EZT2HG@kernel.org>
From: Tamir Duberstein <tamird@gmail.com>
Date: Wed, 23 Jul 2025 16:12:44 -0400
X-Gm-Features: Ac12FXxRQU00yuNnZFxxh9RzuLjpTgjvTJ9XgiSmLDC7uF5fwyQxxPWxgmV2-tg
Message-ID: <CAJ-ks9ns1nK9ZdYO4DBwp6JaC6DEVafXjW4OKnsF3mGEVc3X7Q@mail.gmail.com>
Subject: Re: [PATCH v3] rust: remove spurious compiler_builtins dependents
To: Benno Lossin <lossin@kernel.org>
Cc: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 23, 2025 at 3:53=E2=80=AFPM Benno Lossin <lossin@kernel.org> wr=
ote:
>
> On Wed Jul 23, 2025 at 5:18 PM CEST, Tamir Duberstein wrote:
> > On Mon, Jul 21, 2025 at 8:25=E2=80=AFAM Miguel Ojeda
> > <miguel.ojeda.sandonis@gmail.com> wrote:
> >>
> >> On Sun, Jul 20, 2025 at 7:20=E2=80=AFPM Tamir Duberstein <tamird@gmail=
.com> wrote:
> >> >
> >> > Remove these dependency edges.
> >>
> >> I should have replied in previous versions: this is wrong -- the 3
> >> changes each individually break the build.
> >>
> >> I guess that you are not cleaning everything in your tests before
> >> testing the build.
> >
> > You're absolutely right, this patch is incorrect. I was indeed not
> > blowing away build artifcats.
>
> So is the `compiler_builtins` dependency correct for all crates?

Looks that way to me.

