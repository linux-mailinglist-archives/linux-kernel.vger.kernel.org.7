Return-Path: <linux-kernel+bounces-863094-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D7365BF6FF9
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 16:13:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A7E1D4EB1CF
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 14:13:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D43133B969;
	Tue, 21 Oct 2025 14:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="v155j+Mi"
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90F54333746
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 14:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761055995; cv=none; b=qFANIXO/t3u44zeIStoZmAJk086uyUsoj0/PGBeYpXUOy23S8QgPju5uWKAf284jUTzjN90PR+gDxTPSxS4WJyT7oeOqOLB0iS50m5GBMuTr1cmw7Cs4VAemqZ5/d0ckyJnq0HTbsT7cy9Y7bBFkY8uyXAZRdwLF/vE4imDWJOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761055995; c=relaxed/simple;
	bh=5tgj2qMi7SlzBgiUdrariI7mGTmx/Ggr0BUu5gAdEws=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S9Al65MfCc3QFNJeUgbgXT7/7e9QVog5AgBQKbUlSghEIEyjv1GMoQET+jja5rR4AJ8RgcYCIwmDSVmMtBuUln/6lQBLmKP3bRDxBoh1/hCHF/onbFaIWWQqGo7qvKtlDOY3oe/aDDV2UOa/SwOa+is4HfGYYamoxMekHVFDEn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=v155j+Mi; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-3c8f257b7e1so5410211fac.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 07:13:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761055992; x=1761660792; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5tgj2qMi7SlzBgiUdrariI7mGTmx/Ggr0BUu5gAdEws=;
        b=v155j+Mi8cCN4EfrIDjh03B+8n4iksYJhcpjiqZp2NUs22VM8tD2Aye7AmeUSgojtY
         pqez5GjeZyZ8hGDQXCZWCuXiNKRGrICFN5fZeX7ctUtG87RCb2zJ2xl31zVZzY4rX7rp
         eSeMwookZRwa+WDVaTsXtyVr3lAkhVhw4rYNpGLGkMEIMVn8Mh/NoN6IkkrX0SoS4skY
         7ANAv5enMHlTRuP4j8Y7lW/1p6mAToQtjycKsXSuaoBFcB9Kprwinlt9Oz1IbrO5gjyg
         yxbs1f3SG8AYGOe1yw/5n8KQDVAuZAvYCBfYe8HdLFnFqnmn5LOm6qmrVDpDsDob3/Yt
         8Zog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761055992; x=1761660792;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5tgj2qMi7SlzBgiUdrariI7mGTmx/Ggr0BUu5gAdEws=;
        b=buP6wfyTEApJbp/M1D7Zcs/gGB8ynobwLWvG6QW3z+qsZnZn0w61ir8HzG7sK8b74L
         qpu+/tFS5uB0yJpeeqm+DJ800ReYsG2LJZzLhCxeBowTxcosvLiwBdtkS45JUpSZWGMb
         TbeSrsiqsndyIZAPM5XXW80t/3BghnYuW4ZT5Q3z6Gjpue8xkOu0Whn3KOwG1SObDlJm
         BReP5UgpO9u7KLcIZpVKWzhQ6xakW0I7u1+KmQh0cgC4LK4zwKr3KiPwzhTPQkTNNOXj
         lbWI3/5GyQMRXGlDvmjAQW1eBNYh8L68Fij4n4FIclt5/YI9OXlsao02Ny1jcX+thZUf
         OLkQ==
X-Forwarded-Encrypted: i=1; AJvYcCWvHYOi+bENXR8zqY09bF4ItxOW8H8OTFw/LiSLj0iLnQMOWmA0ziFpBMmmYtPPe/tv5QwB8mOig2lJFQI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzm1BvuutRfU6aNs92Yg5A27GD9gjZ7a63Ql2PSH5XXZjsjpxmZ
	Q2hQhaWlK/s2BXsP59wIFkIJA/aRevScDVLHLAnyUJe3Sbiji8NJ52Aoq24kVEyFvs2o0T/bxDK
	d8hEj3msc6nhVcpK8h7URGLQ3dH/NsLFRVXYUyNP6
X-Gm-Gg: ASbGncu5FdZMutX56gSgQD32RLRFVIfEhkwaP0FoPVR5hynFZ9jSZ+RxJuKB3RQbMCS
	1l3mxajxQOfbx05M5OOi6GnbA0ZzDsacbrsm0LwOmsv+gX0GeoqzvhbQoff1op7RHICefOAe5ZN
	OeXBKqxqdDbPQpSZQ9WM1ClW/ymkg4AGJi27H38CdKPRgnp8tgE2IW7V3Im+yMaFauT8tVoP8fi
	SE71aqqoARmS6U0Mb2x6vtZA7hheqxpSRpisPjhVQFbFL0R3zNMNhNWeoKTe8LgvwU/DetRPwMO
	5YPfljRpJ7XMNGA=
X-Google-Smtp-Source: AGHT+IEgBLAwiY92VxAzxQr0LtJzSFCjgKZQr5ZEXjzVs1+p1QEiUDeiahwZ3bIAvuYODoXUkrJphRpGr/s3f4MFbIY=
X-Received: by 2002:a05:6870:3120:b0:314:9689:a467 with SMTP id
 586e51a60fabf-3cd9f87066bmr5212fac.23.1761055992354; Tue, 21 Oct 2025
 07:13:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251021-binder-bitmap-v2-0-e652d172c62b@google.com> <20251021-binder-bitmap-v2-4-e652d172c62b@google.com>
In-Reply-To: <20251021-binder-bitmap-v2-4-e652d172c62b@google.com>
From: Burak Emir <bqe@google.com>
Date: Tue, 21 Oct 2025 16:13:00 +0200
X-Gm-Features: AS18NWAZsNsOB4qRkAyLDHKfRZ-TFnjCAE5QmLhsY3piap9hO6936JhLNd9oelQ
Message-ID: <CACQBu=WC2C3j-okHtr=L1XFvAp247ChwHLKBnS795wG4RkJeUA@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] rust: id_pool: do not immediately acquire new ids
To: Alice Ryhl <aliceryhl@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Yury Norov <yury.norov@gmail.com>, 
	=?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>, 
	Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joelagnelf@nvidia.com>, Christian Brauner <brauner@kernel.org>, 
	Carlos Llamas <cmllamas@google.com>, Suren Baghdasaryan <surenb@google.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 21, 2025 at 3:33=E2=80=AFPM Alice Ryhl <aliceryhl@google.com> w=
rote:
>
> When Rust Binder assigns a new ID, it performs various fallible
> operations before it "commits" to actually using the new ID. To support
> this pattern, change acquire_next_id() so that it does not immediately
> call set_bit(), but instead returns an object that may be used to call
> set_bit() later.
>
> The UnusedId type holds a exclusive reference to the IdPool, so it's
> guaranteed that nobody else can call find_unused_id() while the UnusedId
> object is live.
>
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
Reviewed-by: Burak Emir <bqe@google.com>

