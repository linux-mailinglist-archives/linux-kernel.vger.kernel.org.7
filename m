Return-Path: <linux-kernel+bounces-873981-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CEBDDC153FF
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 15:51:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 161CB5606F0
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 14:46:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66FE222A4F8;
	Tue, 28 Oct 2025 14:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Do3c/zBK"
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C176824BD
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 14:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761662763; cv=none; b=DoOQPiFVVyCFMfwPyRxU003u1nR/T34i14+4tduQohZb4u8mh6jQ2USKeDrLJf5SdayTZNgaEO6z1FN01AIvsrQ41SMNDLq3lT3QscvRHbdrRrT7QMonEHIjDre5SUZ5OFHLyTcKA8E21vrDWePLUpUjuQVSES1pMqubfj82pIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761662763; c=relaxed/simple;
	bh=Q3QENN6FeCfhFsoNoHhMZfljsDx2B+bokVmwUodOCKA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HViJYkejTc5U2Yg9CZX4c4YQWHhMKYcQqpWdCKq11Fc+ybSK6+dr4W+e4olcEa/M73jVld4omjMNeb91SUpf9nzNGc60Pn9x5R5sBQRvdMFUs8PtrCX4KPTL4xDhEeLvpojJDWnSlJN/dmQYin1cQ6gxPRVOqMxorn6aIDsBVfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Do3c/zBK; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-b67cd5d88ddso256493a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 07:46:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761662760; x=1762267560; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JcaJkvlevrlFiqDWQaxlxV75MgJ3OQA9Phd19FF0hYw=;
        b=Do3c/zBKZh458wkZaRsoJWAmRrxnKKPJP0GE8M9de2qwyfPv8mJNwaueR/6HQailx5
         /trsT1SZgWjWx+HnaSkkL8b0OyX21tisd8l3O4oSTJwcz1agihIvJlaKOP3ebQ86JhBD
         RcvMVtEJjPwio9f30vqsiUMZH0B53/NpRE0xe0ddF56vxn6hDFYnQjLvSrFpEaUPb7AP
         4dzD3/gpYD0lKVDdod8dOq5ayV7BQklJLbfduVSFhdZWnfARlH61kcHUHdbzy+aeq8Wq
         DdXFSPB8fJzm0y5oO3gJO9T0pRKguxApqptvQhsWtMotgMJBjLPPl/sVNTnAH3S6giwg
         42vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761662760; x=1762267560;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JcaJkvlevrlFiqDWQaxlxV75MgJ3OQA9Phd19FF0hYw=;
        b=Az3j08If4GbfYmF5u4xbqWKPhvKwZp68gKApeyo+lwip/8HQ3e7sQYeEZguyegBeGn
         0usDoOjs8VmokwZ+8pCpAqlT5XEGlGUX/97vbcu1qqS5bJnB2Bh0hsfIwoMpkS9rxEXl
         EvkCoXMcDRpoOXCFHht4XmonEARy5PC5AhufKx0qROEtUw3eNi4E29v5uZ45zs/NCK58
         ZGHOQOSocjK/rnaOw0FqBMjmD5wEN8EmL4CSe40sLGcV40OsTsxVeKxXUdSF4ugzhd9A
         MIDx7h3UaVllUFAg0r/i8cHlVgH31r1y74kskOd5pa6zVFtQcbezt98pPs+r+lsG903R
         +pSg==
X-Forwarded-Encrypted: i=1; AJvYcCWRS2fTqMGcRFK9v+0erR9qKCPUPftYBWoug0TYa/SzQwDIfBVfjocL+klWn42LRHEM6hGpZtsiq72l1mE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKNWqKpi7qYZgA+qBG1fHdeb4wSHGcx9mXk8plrdOhbnWZTMwL
	afO8vzzWws+TCsCZOGqL9YMNuuy6yZyyGNcQbE1DcmeOLTdWrDR9/MgNrBVtUEVNaJ6dYfm15HZ
	5UjBQzQQHLcy2ronm0ZajuEKgnlKI5Jg=
X-Gm-Gg: ASbGncuazshpw0nzxDXBCNXK3HGlIy+Unkz/bR2m9CJZ1HywRmeK+9eRQgxe6lMffjw
	rSo0vklLnOnGXuZE0SbGV8T92uwg5L2is0rHp1ONztDDOYXAe7rjPQ8r47IBvmP5FSLcPh2bLYl
	M06RXbyWNaFasgV9lcAjd/ZxxX0Mkz3u55Qx+qWQh3EDVcSCXGiKPfqVQVquIoyQUoKsKZh0bRg
	hUpMAAa5e5fPNlSSIy/YKbmMn/il2xbIZ1bgwHTS8JYQi9YcTQbszw2m7bVOER4vDa+cvnx6fAQ
	Ue03xkcWL0iu1fSyFjaOQ3tfDU8cBg/41qp2NtOCOiKPXz8HiJxSN7rKYDnropjPSj7pkvGl/XO
	BT230MTA6uHeDtQ==
X-Google-Smtp-Source: AGHT+IFfY89QqiTl3UPAk6WKNc6WSfg9maX4CslBrwsb+ya7LyhSlvq0HWbjx5qGqAFL/1tDdaDG4249vNygIfHTzN0=
X-Received: by 2002:a17:903:3c4d:b0:27e:eee6:6df2 with SMTP id
 d9443c01a7336-294cb3e8bb7mr26098245ad.7.1761662760526; Tue, 28 Oct 2025
 07:46:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251026-nova-as-v1-0-60c78726462d@nvidia.com>
 <20251026-nova-as-v1-7-60c78726462d@nvidia.com> <CANiq72m9ms-OznWQ5+4_JvAs4yruwgBRcm1u0gCAnasqO8uJOA@mail.gmail.com>
 <DDT3BTI26XFE.1Z5E9QZZJCPHQ@nvidia.com>
In-Reply-To: <DDT3BTI26XFE.1Z5E9QZZJCPHQ@nvidia.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 28 Oct 2025 15:45:47 +0100
X-Gm-Features: AWmQ_bkouzgy_TlroPyjfTyhvmFTe0497ZQoaOPqA8hULwK1yxqY9ku9pkOIYX4
Message-ID: <CANiq72kUDtc+6hrJ_=bbVfAjsWOYzSjVvUiT_GOBKHWQRaLDMA@mail.gmail.com>
Subject: Re: [PATCH 7/7] gpu: nova-core: justify remaining uses of `as`
To: Alexandre Courbot <acourbot@nvidia.com>
Cc: Alice Ryhl <aliceryhl@google.com>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, John Hubbard <jhubbard@nvidia.com>, 
	Alistair Popple <apopple@nvidia.com>, Joel Fernandes <joelagnelf@nvidia.com>, 
	Timur Tabi <ttabi@nvidia.com>, Edwin Peer <epeer@nvidia.com>, nouveau@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, Danilo Krummrich <dakr@kernel.org>, 
	dri-devel <dri-devel-bounces@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 27, 2025 at 1:07=E2=80=AFPM Alexandre Courbot <acourbot@nvidia.=
com> wrote:
>
> Sounds great, will do!

Thanks!

For reference, the other day I opened a couple issues for this on Clippy:

    https://github.com/rust-lang/rust-clippy/issues/15963
    https://github.com/rust-lang/rust-clippy/issues/15964

and added them to our usual list:

    https://github.com/Rust-for-Linux/linux/issues/349

Cheers,
Miguel

