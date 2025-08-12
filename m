Return-Path: <linux-kernel+bounces-764941-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 29996B22947
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 15:53:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 23DC92A0E38
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 13:39:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 148DA285CBD;
	Tue, 12 Aug 2025 13:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GTtbRx97"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A58C285C87
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 13:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755005782; cv=none; b=fVqn647CZD75WfZYnVjelIWStger1yZoH7gd0XU83SwDb8JWOhBIYU4MR7tVcRcAI0GG9tp/V28q8qZKh5+WHvWySJL+zKtM6FWh71zRxBLjjCCb45UggD4VKs2+FxRvKVA3Snmil8xjA8ncfWEWRmk5NyvSwitTqi4o888Yafo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755005782; c=relaxed/simple;
	bh=FfeqLL6dQOkRGa+2qH5Nfx6sExnoJH9Br0Sq46snNaI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iyG0VZmvjx0bzd26KxZWjPiqoxoqV5O042OiOFs9j4sL7sQg5nKu0n50cIyXkOsFjjNXoKJSmY2OjaiIp8uzmd1TOrpVtFaa57/qiLExxa7+nQyH6RcqmPl92952iffPwbYbiVoFk/IRCjTA+auGDf4BTs5se4hHrE53JyyYnQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GTtbRx97; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3b792b0b829so5347315f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 06:36:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755005778; x=1755610578; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FfeqLL6dQOkRGa+2qH5Nfx6sExnoJH9Br0Sq46snNaI=;
        b=GTtbRx97XiaJEGG7UCftlkG3XhyblU+WxIIJB8SFySDMDZl+kzOYoTwC78pW6c9u0f
         b0Rg5NVjpYz6I4mvdEOi1/eOsvKA3lKeCmOP2vfNchhgJCZ3UAhZDUmO+ztp4DD8Y0do
         QD7hDrj4GRj86jTqoznrj1xjuMOg5MH2vKMioFfeFnjBPlh+haJkyFKBEzZkUePnJHJS
         xMGhJZN3Va26lK3As7hZQz/8HJXyS7lhRQkkYDc59SVxalRcu8TkuRKnEUJFjW+YNq2a
         wJcSWy35IVRHN2lY45Tvi4FuUr4wU30q+uc9cwWzfA1yy0C9D/i/ic2aQGjlLP5PG29O
         9Bvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755005778; x=1755610578;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FfeqLL6dQOkRGa+2qH5Nfx6sExnoJH9Br0Sq46snNaI=;
        b=OJYBqwstXEC3YruQ7LQgO/PUivyqXSIUTmN6zl9onHG1zcYijzRC3okZc1m/WkGM0m
         BUgVnoCNmiQXjW9teO/DkFv0NzGqrmGeqOPPU/IIoUX4vKVLhfgzukFUdUfry07Krty8
         2CzimU7jt48KsfSY2cQMHwIZoyvjXwta5RzzLWFca3np3+geBg/N3WRF/QHm7TdQgeV8
         abkmDIJV5EQmkTViW7Y3Q6bRmdioHYhpocVijC5fc9XZ7KA74MMj8EK06eIa+5T0+YfV
         vIcK1ZEoOfsdFkX5G0bxsC44UaBUU1ZpnQB7ZaWL6sYSzSzcDRtuT7TUSAHVYJIlR56N
         Ybrw==
X-Forwarded-Encrypted: i=1; AJvYcCVPC8AXkk/k9PdFl+Zl3V/TNU6VWuTcEvUDhEq9aFH8RWNCTitdY3/D2DLrO9Q1Zu6KTmCjsipkg2XuOBI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3Qp1XcbwN8l6yLlRAYwk6m3cli22ZY9MNtOUnmnQBzoF4wnzh
	57mk55QnYWdcBoITR2BVWzk20hymtFfAkizFVfD5mVRqMf40kO3dT6sugWV5WEDUpvXCi+T2wH/
	RXwgM4hb8dEOK5qve/i2E0NdiPJygH99iv49WTmAn
X-Gm-Gg: ASbGncv/DSnRDv2I/lWavjWojCbkZ45sE98fngbeeYdVOjM4yJafPRAgsrQy+FQfeZs
	jz1nbCZaW5GLpLUku7IxEtzCNX8gVBmtH7Rk6RRZtsV/qa8dVT3vK1n0h5gdQHvSby4cjHJbPI7
	wsQQbE3H9yVRhoiqXkT1Qsa1FigjBQH+DwitM9dXdtFPu+zRV8+MaALSWZ1FtprU/ldTntMFXeH
	U78zaGmxT0ZTIrrXNakG0ZhF11LWmhU7t5OKg==
X-Google-Smtp-Source: AGHT+IGvi39HzBKuKECl3B4URDI7XM1LzzhtHLRMHVg4OfVEDl7Qv4mmJaL0Z/gOx5HNOgcCpFj+tchSrBuJVnqWU6o=
X-Received: by 2002:a05:6000:2010:b0:3b7:9d83:5104 with SMTP id
 ffacd0b85a97d-3b900b83ce4mr14406064f8f.51.1755005778141; Tue, 12 Aug 2025
 06:36:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250812132712.61007-1-baptiste.lepers@gmail.com>
In-Reply-To: <20250812132712.61007-1-baptiste.lepers@gmail.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Tue, 12 Aug 2025 15:36:06 +0200
X-Gm-Features: Ac12FXy01SQUE4GxmHxLMqxN5BkDGNIVt8wh-Nzq-CeDX_ijk0ldVPo5VW0VQoY
Message-ID: <CAH5fLgi4idH+bU-fQm-kup66+-oF2MkH5CDWp0jguHbkLHqU4Q@mail.gmail.com>
Subject: Re: [PATCH] rust: mm: Mark VmaNew as transparent
To: Baptiste Lepers <baptiste.lepers@gmail.com>, Andrew Morton <akpm@linux-foundation.org>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, Jann Horn <jannh@google.com>, 
	linux-mm@kvack.org, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 12, 2025 at 3:29=E2=80=AFPM Baptiste Lepers
<baptiste.lepers@gmail.com> wrote:
>
> Unsafe code in VmaNew's methods assumes that the type has the same
> layout as the inner `bindings::vm_area_struct`. This is not guaranteed by
> the default struct representation in Rust, but requires specifying the
> `transparent` representation.

Right. It's the case that the layout matches in practice, but we
should use repr(transparent) so that rustc guarantees it. Thanks!

> Fixes: dcb81aeab406e ("mm: rust: add VmaNew for f_ops->mmap()")
> Signed-off-by: Baptiste Lepers <baptiste.lepers@gmail.com>

Andrew, can you pick this up? Thanks!

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

