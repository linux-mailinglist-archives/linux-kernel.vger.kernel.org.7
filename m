Return-Path: <linux-kernel+bounces-881384-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BEB0C281D0
	for <lists+linux-kernel@lfdr.de>; Sat, 01 Nov 2025 16:48:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C968B18901E1
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Nov 2025 15:48:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 090D3285CA3;
	Sat,  1 Nov 2025 15:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U27pwbkC"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2827B136358
	for <linux-kernel@vger.kernel.org>; Sat,  1 Nov 2025 15:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762012084; cv=none; b=u5ojbTV5W8Jyg92n2CQwi7hLOc0OsjjdPay1PawaU6RDHwkKzNWyA5UYLu+J+T6kcKWpCX4bGCw2SDjVSjlp31mp7r4/mdvr11h/6/+KcJTUkEfs7UhfZn1u5iKaHnhdmQ8lByV40MruZRm3Uo8Xu4+BBruC6Cs1c5fkGU6tVEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762012084; c=relaxed/simple;
	bh=jamIEloEQhiPyz5eXgKCJiNa+AjH+v3pihsy8kT47Q0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C7i7FXSE7/5yZgudrQUplbTJP/SJemokBlw6DZnWYrwyIrZdvI5w5iTsLZjVFHbvwUVjltWQ0RrrN7w8l/nIRdmLgvWKvwx3CGBjy4rnQVEsNXwS9NWtqrxoi9P2URieSnrsE8fx3Wx4mVJ0ehEnkGPS9zSc/2HuUfoJSq2o1OY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U27pwbkC; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2950fab14beso1543275ad.0
        for <linux-kernel@vger.kernel.org>; Sat, 01 Nov 2025 08:48:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762012082; x=1762616882; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jamIEloEQhiPyz5eXgKCJiNa+AjH+v3pihsy8kT47Q0=;
        b=U27pwbkCRvpSp7ZnJF7pCchM1byq4luxz92KMKalmhBGv/g6Mtuu8FjqmeStTQ7kFL
         mXob26AAb5xAH9fqmMO25cL6tdd/Mb9I53KPcZhjOcvO7xYqbPmqw+aMNIkwwDqXi0Sz
         BgNqu0cP+yOkBzSUHEa6WROcvKpEIiHqWZD5gvru1mtxHHYo6MP2h0WNslkV7aYUZamU
         T3HpNrJUKhhp8SnglDWX6cBEBm6VYbNTE+qs7XUD1lksu2u+UEHK3ntt1DTXw3K/PFFz
         wvGMmATE3FGFZI0hQ0pgsTydqQECIZlPoZdF5rhb+Is21A44LyYAzVVqPiPCkrLJKMuJ
         5Kmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762012082; x=1762616882;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jamIEloEQhiPyz5eXgKCJiNa+AjH+v3pihsy8kT47Q0=;
        b=nDYTPxo9SbmwifTUU1APzv/CUNmPajvHdf3pNW5WuJaulV95XaeX+a+xzFdmjzUra4
         W8Mryb4Wd9dIlaEigNl57iewcHUWgNJ3hDA0Q1UYDGXH78rFfCjztcBN8wdzR/7X7bIA
         5+YfiwH+5U7s2SXMwFob/AkRUofDsjTajprJ99VWfExipIvuPiTehQSezKk6sfsWsbPM
         kob5v9GjVD0vX0Ruj5A7yrKpHVud7fGKuadQmxqa31ZfxdtRKNU/8oK+pX3RDGMmFWjN
         L628rWQL+qh+1hT2pEMy5lu7ffp4Fj8KH0U47fHC0K52RK2yYvhdW1YJrxKl7JAbLNlb
         ZczQ==
X-Forwarded-Encrypted: i=1; AJvYcCWbHhBatMyJpjio/lmPchpJIjUMI/Jmtd1J2eq3WSfn6Kg+FMv/iSQh+3tCXP0N4CdzfLSojQSeI1jecu4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3iJYuLCi9iOanoTF4sZJa85m/yKSSgF09QO3TyErKUiyUgPfK
	LRicPm/gyboTFtoPbn9G8Y7+07f99gkIcGlZ04DT6/oQuZbn1Q+6M0/F8hA7JP6ZNpz5P4jb3Sc
	I+Ud+ZSnXuHGwTmD2TbBXHM4EWJp/Juo=
X-Gm-Gg: ASbGncvq8xjdiQiMK/lGbYUjSRStO8Ij5ZA2IxMt6ctdI12w4w2KDWL9aiCkgOiRWeT
	4H8lgl/w1jdbrEbVmx4+xoNWBims8Mbh26iEgbktHj97RudXPyXvAa2QGh/2ooVWjV+975kW7kC
	kpQE/wjKVZUSh+GUscoht8DkrzHtuQgp0HNHvBMAJhEiAXYSqIj691NE0aKfaX11xtjWUugmxW/
	mTq9U96UoMclh6KaHITcRM15HRdDAg41Na10hkFMq3HIXWdI8iNv5nC5Gi0/xMzt822Evkdp75+
	hOEujHtYngNJ4oNDO8zEkCWRtqd426Hmt2Yev8tXcfXWfsC9YPLZdrft6UgmNXn9VOazuaIMVLC
	Y6kcDBL6QOMSu7g==
X-Google-Smtp-Source: AGHT+IFeUdEiRDYhzdYh9fW3/jmt01WqbIkn5Mq3SaBz0gC57ZxcOJdIQVq5xYtfcf//SPWY5i1+n1E8bScNYE7sAx0=
X-Received: by 2002:a17:903:3846:b0:295:62d:501c with SMTP id
 d9443c01a7336-2951a3eda2emr49742475ad.5.1762012082347; Sat, 01 Nov 2025
 08:48:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251030190613.1224287-1-joelagnelf@nvidia.com>
 <20251030190613.1224287-3-joelagnelf@nvidia.com> <DDVYVKDW8WG2.2STCJ4ZU00MZF@kernel.org>
 <DDX1Y0EUNNPR.1KQ7OF9H4T81E@nvidia.com>
In-Reply-To: <DDX1Y0EUNNPR.1KQ7OF9H4T81E@nvidia.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sat, 1 Nov 2025 16:47:49 +0100
X-Gm-Features: AWmQ_bn8sxdowUb4pdCsaJVkR0Kpv-lxkf62UR4OPlqQBFH0kCL_DBSvQwqzdW4
Message-ID: <CANiq72nJEGMaV7=omoM+9pKvQpUTq_sXNB5APhEY5vg_6KFoNA@mail.gmail.com>
Subject: Re: [PATCH RFC 2/4] samples: rust: Add sample demonstrating C linked
 list iteration
To: Alexandre Courbot <acourbot@nvidia.com>
Cc: Danilo Krummrich <dakr@kernel.org>, Joel Fernandes <joelagnelf@nvidia.com>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	David Airlie <airlied@gmail.com>, Alistair Popple <apopple@nvidia.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, bjorn3_gh@protonmail.com, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Simona Vetter <simona@ffwll.ch>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	John Hubbard <jhubbard@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, joel@joelfernandes.org, 
	Elle Rhumsaa <elle@weathered-steel.dev>, Daniel Almeida <daniel.almeida@collabora.com>, 
	Andrea Righi <arighi@nvidia.com>, Philipp Stanner <phasta@kernel.org>, nouveau@lists.freedesktop.org, 
	Nouveau <nouveau-bounces@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 1, 2025 at 4:53=E2=80=AFAM Alexandre Courbot <acourbot@nvidia.c=
om> wrote:
>
> Yup, we can probably move this into the doctest examples and have them
> serve as examples as well.

 +1, in general, one should consider whether a test makes sense as an
example first.

Cheers,
Miguel

