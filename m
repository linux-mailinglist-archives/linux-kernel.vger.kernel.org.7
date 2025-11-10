Return-Path: <linux-kernel+bounces-892951-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 635A2C462EE
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 12:17:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 429674E9BDA
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 11:17:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D51B73074A7;
	Mon, 10 Nov 2025 11:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H90T5VYd"
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B797330214B
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 11:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762773444; cv=none; b=DT4LhG0LUHsAA5rxvEUi01pqgEwwUAVKMmntBMJzaLIBfScor143kf8tdbAjNkbGJ9TLGOccxGNLSbRbAi4267N0Vm55QNbF9uc+Mh8hXiuyjAL8+jqft6Th2iwXZuZdQZf5ds3uS5fW9lA0IxQgGOdA5J9lrkf0rvGarFgE96o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762773444; c=relaxed/simple;
	bh=Qe3d2RAqo7YTKqv4jYgqUMxYnjMyEHYM/6ALuA5VeDc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QZg5XYjkU5gXUBQmeTv8gdANPJ1mPCVVnp8RdY8f+K4Fvcj6Pq9qdr5neOe3UmB2ALZQD2gJF75Jj8MjAM+uLfYZO8hovP4fTkH6SJ9jFH8bj4tuzC1tqg/2LB3Qom5JoNv4yr7bGJE7jzR3BcP3zUnKyL2hQ0ZU82KP+sZPHAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H90T5VYd; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-3727280ce17so4866771fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 03:17:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762773441; x=1763378241; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qe3d2RAqo7YTKqv4jYgqUMxYnjMyEHYM/6ALuA5VeDc=;
        b=H90T5VYdjMAn2DU/l789CThU9ybdM9HDtaPfv4+VVYTlb5o1bXOucbWJ9NrMvKo+mv
         bWERo6YD2uNoGA1ghAwukLx47fz041VPjx534b6BOsRz/viioJ5uVKX8OAwKB5FXPvCZ
         NOOl0OtYdqgLxAiS3OmMo9Q3b+1X33fNgkC6jD4yHjpu/yPidtSna3HWvZDSCbHpIR1l
         Zc+xp5wvElJTsnzUGpwZVGruYHlI4t8QDBta/d7u0kk9MRKR8/XN1w11ybT1ynANJ4g7
         Zp8s/YTkxShi9cZWSy1yB1YZ8RLV7njLLokQT07txxHd3EbKuB4rEH+omRwO3eODimBE
         lpcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762773441; x=1763378241;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Qe3d2RAqo7YTKqv4jYgqUMxYnjMyEHYM/6ALuA5VeDc=;
        b=aOrmQh9cdTzBD4BKhjHQcarlFeckqgMqjyNlBNTRAXhoc9nEhVUqOisi3MgtwNcoQR
         TgYO5LgT2u221daxkMqX+fb5FJO+mDe6KVDWm7HjnLpQyq1vr9vKMO2JiuZk2G1nmDuk
         uWiLK+XZ7p5BXrqk66e9YE1yV7iGcPgZkXcZ1ab+8jJPgfMwaDBwQcUqgV75hgfdH3ht
         vwhvk/KKnCSYD+zxmi/G0C4tRYR/7PVM2h7wcOPoko6tZo0g+lnk1361obdcppEzOl6a
         wkt+JrYnxRiEsj4196KjyvGaFjJzkgOadXxJWsxzA/ISAcDaJQE6nWgvKO1XPJ5J5LPT
         2HwA==
X-Forwarded-Encrypted: i=1; AJvYcCUgbobIoNjpauNgTSH0csKUpqTpZ6IwDnZdHrQuZUf/eMi86zj2I0/mkiHde7Cy/KyIYt/3zUhGqA/kPYA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOrIylZjKNZdDkoTrTMQfoz0BF94YsTks78vd14IK+aqvnLWBf
	8ibwCgMQ/igkrEhhsgOJiD6L67iICeylNJHQTyVo2Th7w1HYR4fb0hZAr0vp3eBj4LqhUyWOqSy
	tNzZmsrXDkTjpUiuu7SN9mxHfAPPDEc0=
X-Gm-Gg: ASbGncuIQOUPSuzeM/qzoMxKp5zHWxoJ6dGeiTMTB8SpkVwrB07BkLL4+JAbDoOYLbA
	w/3iy0HhnNZXyY6cR6KJsj/l7vP1JarWBoQ9YQH0Qe5zVLPA6akTsn8Iu03P7vQc6hFHJx4LErp
	XuPTol43wJE0U/Nk7zPjLwAQhXpFHkM9zFIM4Jo6DRQXnrU+uD8UKNXSSTRfLBP2M/j/lfGIChJ
	HRiDP4dJI3vAQeQQd9AWqJMXgSng7vz0Agz3bUzi8rG15sU2xfjNzqzWlEO56+5iXMq4mfq5znW
	XkvR4JjLVLKxa17yJaNCbZcVkzFV217L8By26myo36fH8dtiJboKvVKfGqxnROJ1kzpeMNoaeob
	c8JU=
X-Google-Smtp-Source: AGHT+IFBdQ/Kf/pBba056RwUp0V08lYe+9haO2B8HlujtJik6R+WJ/BwK9jrSO5+6zHV9sZYoG2V1Cx82A2l5RDsRZI=
X-Received: by 2002:a05:6512:104a:b0:594:253c:20ad with SMTP id
 2adb3069b0e04-5945f1e1fa8mr1168234e87.5.1762773440599; Mon, 10 Nov 2025
 03:17:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251110095025.1475896-1-ojeda@kernel.org> <20251110095025.1475896-5-ojeda@kernel.org>
 <aRHBu3RoOLTrMA8n@google.com>
In-Reply-To: <aRHBu3RoOLTrMA8n@google.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 10 Nov 2025 12:17:02 +0100
X-Gm-Features: AWmQ_bkXotkhTxYYTuTPjRF1aS8uhIalsBfLfpXM8Q6vG63LofMfHcNy_ClSXmQ
Message-ID: <CANiq72kdkTif=HHL9ypoztDc8JiQUFCEuKyigQ_6ujXjR=cTyg@mail.gmail.com>
Subject: Re: [PATCH 04/18] rust: kbuild: add host library support
To: Alice Ryhl <aliceryhl@google.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
	patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 10, 2025 at 11:43=E2=80=AFAM Alice Ryhl <aliceryhl@google.com> =
wrote:
>
> This is a library for the second case, not the first case, so it may
> make more sense to name this rule procmacrolibrary?

Making it more concrete sounds good to me. We can always rename later
if we find some other use.

Cheers,
Miguel

