Return-Path: <linux-kernel+bounces-735372-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B338FB08E65
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 15:38:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A281DA4242E
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 13:38:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07B052EBDD7;
	Thu, 17 Jul 2025 13:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ga4bU9jB"
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BCFD2EBB9C;
	Thu, 17 Jul 2025 13:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752759514; cv=none; b=JagPgsculPW4oo4fLIqqabp/+b+M+V6Dq81CYRBnhXWXQZTxuXwSFaFOEW5jzXHLS+OG0UX6N6uWm6CvlmyY6g25kqUaXPZaoDafmoUHqG12oYzj2IzEgbObeoL15EaLjlDfB58CGbuY4rj3NGW5qOrOAUGDZvaKWbSyVM+Folo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752759514; c=relaxed/simple;
	bh=VyJ+NsLDM7pT4kqmM2xgDPI5UrSq9184d49tqI37g3E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QpHkjMEYyiOj3K+kpGD0eEJ9qhENQpdfUqMBpJN0hfMtIslKGH5Bs1FU8JtDOVFcEdOhDru0VmxhokDw7JaU+Y2Khih1XXSAp62iw8ewQvX7AAqeSKnZjk416OZrHduMF8Ibkxumc9OOHZ+32FE7fqDAizzPWDn7vqegdFmYt8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ga4bU9jB; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-31306794b30so169019a91.2;
        Thu, 17 Jul 2025 06:38:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752759512; x=1753364312; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+AkjrzWPxBpSHEuKgQ5YjwK48qZvCjPPIkc2sko6UqM=;
        b=ga4bU9jBnaM2Jq9kjZhlgZjiPTZ3eJYnnYPjukB4oAdkHAMkdhb3AYioXkmnORf2TS
         6VvEIU6p9VEFIekhMutfsXqa6LOre5UsyDlBfy2EzrvUxokB7C9M8d/5rcdMR51QoDpG
         shKlGHyV1hJbsRvilKg/2eSFBPYK3yGvcw1I3QbwBb+XjeIMry1LjMdnUb84CdsBA2gX
         D73vglXpoATgtK7nlsF+JG3XUzDrfzuXpriCgCco5NudV8OxBCIh490VIMzydier/67Q
         MnSS+8XlQs5mkYllQmB8BwOcZs2qkib7ozRRFkpu7tpp3hdVQrzH5bO0BccBFh4tsPeL
         m4jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752759512; x=1753364312;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+AkjrzWPxBpSHEuKgQ5YjwK48qZvCjPPIkc2sko6UqM=;
        b=mrZgVSyUiPoIlJbaIkDe/AG9mgTgVCByOC1W1MIjxT8syEmHQkut3bEi46DGRJgYo0
         6x+V8DywPLcOCCkS2ulaw5z36CFt0mgzzTBWTZMh92+fHFDOgjH+Z+qjjtdtsCrEAHo1
         KxX7rCdXh0ALvMQEOu2v9FLlTQpYrBpJKCHw0QqfGRLgACvr+iYHHzXGl4L52Nz+D/77
         sHyrpj4NdsDkHnDGDt822NSezLweg4myJJVqPxrYiwHHvi9XKtFVx7CHlGJZ8nvtQiBX
         4MNS8gw2v0Y14fadLtRsQveWQo7nVxPvHCqUeqIe+VACZyy+9BYhtXj2aOaUUz8PBRt6
         iPaw==
X-Forwarded-Encrypted: i=1; AJvYcCUILu80QmKCFas4C24ixCsLwUBmmxTrH3G4HDaCD6Q8OYdTjnWbeK/lrRZNL6ncdia0FJ5/2fLXoXUHTF4=@vger.kernel.org, AJvYcCWsbwxgJwuWs2A2CBmOF71AmSmkRDoX+jr7j7cRiNtipurjCNsain9JQR+eZ0TtHNFA78OdjWbiryuiXIDxh7s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIjtLR89CD58j92uyaSxOfFnARroIL9RDXP3dBpGHZKYiEa71M
	uifu78sEw9ERCYe2p6iIDvTLHcBZuVgAiOgVWOdxR8YKqK1vhA11ao6uhgnB6NNWpWitPISdpof
	8s14iaNOiWzS1horGrN+sdEJq/9LTaiA=
X-Gm-Gg: ASbGnctgDkB1UNm/VMItyJ1aMEmfO+I1EjLXe7di0shktUoAc65G3hb9/FRQrbewJWo
	3Oet/bwmUWXv0Ma0bEWooSOhHV/0JfoVTnSeBp9qv2HguKPfS+M9J2nOhu467Hb8I16yA9V4Kwb
	uTSdhFlvAsh4SI7eoMZsb9VwBRIGhBsgH8gjepogzB7W2TD/dBE/nLhXlNRrzO54KH4/NLjpHO0
	4yjA5gINjpuGPdw11M=
X-Google-Smtp-Source: AGHT+IGEsaFtyUBV0IjuVA7MPyoMvjy1LlulgWESoeSjWkqBQ+KEr3dS7TNu0MNbKccxo3wsApk66kr6WAzpxVFMFM8=
X-Received: by 2002:a17:90b:4f8f:b0:30a:80bc:ad4 with SMTP id
 98e67ed59e1d1-31c9e5fd68dmr3601644a91.0.1752759512264; Thu, 17 Jul 2025
 06:38:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250624-opaque-from-raw-v2-0-e4da40bdc59c@google.com> <20250624-opaque-from-raw-v2-2-e4da40bdc59c@google.com>
In-Reply-To: <20250624-opaque-from-raw-v2-2-e4da40bdc59c@google.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 17 Jul 2025 15:38:19 +0200
X-Gm-Features: Ac12FXz1hbZauBNzw9Btshfw3inaQsSA1Vx4_yL-0LcTTBRjd_Srl1BbiM_MOFU
Message-ID: <CANiq72mMJRpiE0AKbP0MtvnnxP4fSnOHGhRn+GCm=D5VeLduLA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] rust: types: rename Opaque::raw_get to cast_into
To: Alice Ryhl <aliceryhl@google.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Miguel Ojeda <ojeda@kernel.org>, Danilo Krummrich <dakr@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, dri-devel@lists.freedesktop.org, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 24, 2025 at 5:28=E2=80=AFPM Alice Ryhl <aliceryhl@google.com> w=
rote:
>
> -                let cell_inner =3D ::core::cell::UnsafeCell::raw_get(sel=
f_ptr);
> +                let cell_inner =3D ::core::cell::UnsafeCell::cast_into(s=
elf_ptr);

Bah, we also missed this one -- I will rebase / send a patch.

Cheers,
Miguel

