Return-Path: <linux-kernel+bounces-788299-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D85C6B38289
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 14:38:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 18A6F7B4704
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 12:36:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B461E34AAE0;
	Wed, 27 Aug 2025 12:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="J0brmTur"
Received: from mail-ej1-f73.google.com (mail-ej1-f73.google.com [209.85.218.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 822F034A30D
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 12:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756298266; cv=none; b=opqiuu/RyGVwK3G0yUyRlXSoFCXGrIMFvVsBtupAov7pAwDnMU8FoIm91QYHbtMzil1qCik2tz/0uAaAOgMR9W/tA05JZ+kmBcDivq2xXMr2nekKPqvsXic/3Uv+dOS5ySJMBJf8qITbR7H5LYnBfVLZcR9tiG6t54BekGDKu0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756298266; c=relaxed/simple;
	bh=X/L8x71WT/eLbzgjFJfsirCbOk0rwj/xGN0XEsdza58=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=jCq91a9w9wwmlJ9g2rnQZqUd/nk+I4Ra8149uznyYxpZ0/ETkYR7aBm+M0530lWB6uVx89KDuDA59PK3rvc9b25yjPxsdNBMuvobNX0p/yrV/OKXvSc3cHKvkf8ESPKgOtdzv7JGLpXVnPL5Hiuq4L1s06kSF9liMVtrs0zXK2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=J0brmTur; arc=none smtp.client-ip=209.85.218.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-ej1-f73.google.com with SMTP id a640c23a62f3a-afe94bdd86aso113251166b.3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 05:37:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756298263; x=1756903063; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PHlZ4FUGjTYbyYIeiOkCe6l8zJlx/Qt0X5GixYi+qFA=;
        b=J0brmTurL7vf3rMf3w9AKN3AK8XMWzZYDNZPy8v6VY49PtCqYpNO0mN/XjacVBjYrC
         1BDFkrJqo7Dm83LPGvROtYHUle84SCnuQk42nHI5/FOy/F/GYwEUY+kEzkg8G9D9Lvjt
         LghtmZt/6rOLpGeFyzCMLItomeYEVUKC9QxehEfA1vdrlJeocq2Kd3NqOxLUUHoynEsp
         jyTfUbdXfzfhxKShdoVSOgyiAOiMA/OVGfKEje90Uyd3+nlYYJImN+aHEDJVm/y5LWuR
         yWKZjBwblVkOGKGqZjr2pJfoGJego9NMCP2wR3XDlpnKjx5do+cEMCDfx1jvL/0SSCf8
         +nkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756298263; x=1756903063;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PHlZ4FUGjTYbyYIeiOkCe6l8zJlx/Qt0X5GixYi+qFA=;
        b=spi4uerhbolDZpU3L3CxlN4U3iIeNgCaFXfzVhNOWplWleHhy77YgL5LNyYpmA2Uo6
         V6JbJJ2XdU/klJNhUVDuezB6dUzuVfueGNPekTO03EN76ZN9+HVYtcnT7V1TBHyeAZwU
         I6smuGvfdl7JTbm8uNoGTyxmfZX9kjJjzTJV6JSvJE2pWOMZ89fPNSokunEAj490p53R
         jT5m3G6VRibRTpcf9MPrG3KhcjIgcyT+fq3/KCOZkqTfFAy++NSgeUgV/OFaLbqRXGWo
         J4/8PZhJLXR6GUJzOv/Q49qstAcn6I5kMBKPWZz3kk7vkBEwnVMGYwmWL9J4+lg9nYrN
         DdyQ==
X-Forwarded-Encrypted: i=1; AJvYcCVbf/12I8LH56L+7U3iFDRl4PWfSu+b3DYjcpqSwhtstmRt81YPPRWkUCvMW8aD7VO5kyJ6KgLzydGBxJ8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzzq5RPv9TGRbzb0H9iGmU9q6/Z8ZuGo8/3HXCz/x5aQufeBjwW
	eCOsnK5qjCGkcgJeZWV8IYRzCjNwSeSf3WuGMhnsOjSeb7SgSULoenTBwQO60WoWMVbVlUguVr4
	V/wZ6Kg0ixoUa3odpBw==
X-Google-Smtp-Source: AGHT+IH0jTqhQCc3o7iTxWA6hTslX9AebGIsdzPOVI9oqOTQ+BfQJDAXi9TjCHSy/v+Pknx7OhAmDoPj4AWRRnw=
X-Received: from ejcty13.prod.google.com ([2002:a17:907:c70d:b0:afe:8897:3390])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:907:9486:b0:afa:1a67:e012 with SMTP id a640c23a62f3a-afe28f86573mr1588124266b.8.1756298262860;
 Wed, 27 Aug 2025 05:37:42 -0700 (PDT)
Date: Wed, 27 Aug 2025 12:37:41 +0000
In-Reply-To: <9179276d-275a-49fd-8697-82283fea4bfb@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250823130420.867133-1-vitaly.wool@konsulko.se>
 <CANiq72kQv9nJYyiuHvTdaJs2SvZ_bFAnexoEBgjb0CDzPjBTYQ@mail.gmail.com> <9179276d-275a-49fd-8697-82283fea4bfb@kernel.org>
Message-ID: <aK78FckaX26MOVAF@google.com>
Subject: Re: [PATCH v4 0/2] rust: zpool: add abstraction for zpool drivers
From: Alice Ryhl <aliceryhl@google.com>
To: Danilo Krummrich <dakr@kernel.org>
Cc: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, Vitaly Wool <vitaly.wool@konsulko.se>, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Uladzislau Rezki <urezki@gmail.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, "Liam R . Howlett" <Liam.Howlett@oracle.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	Bjorn Roy Baron <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Johannes Weiner <hannes@cmpxchg.org>, Yosry Ahmed <yosry.ahmed@linux.dev>, 
	Nhat Pham <nphamcs@gmail.com>, linux-mm@kvack.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 26, 2025 at 01:37:22PM +0200, Danilo Krummrich wrote:
> On 8/26/25 12:43 PM, Miguel Ojeda wrote:
> > On Sat, Aug 23, 2025 at 3:04=E2=80=AFPM Vitaly Wool <vitaly.wool@konsul=
ko.se> wrote:
> > >=20
> > > This patch provides the interface to use Zpool in Rust kernel code,
> > > thus enabling Rust implementations of Zpool allocators for Zswap.
> >=20
> > In v1 the usual use case question was asked -- could we get some more
> > details in the cover letter or ideally in the patch itself?
> >=20
> > >   bindings/bindings_helper.h |    1
> > >   helpers/helpers.c          |    1
> > >   helpers/zpool.c            |    6 +
> > >   kernel/alloc.rs            |    5
> > >   kernel/lib.rs              |    2
> > >   kernel/zpool.rs            |  338 +++++++++++++++++++++++++++++++++=
++++++++++++++++++++++++++++++++
> >=20
> > Should a `MAINTAINERS` change be added? Was maintenance in general disc=
ussed?
>=20
> @Alice: I assume this should go under the Rust MM entry?

That makes sense to me.

Alice

