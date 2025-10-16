Return-Path: <linux-kernel+bounces-857059-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A7DBBE5C9A
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 01:26:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E20585E7D6F
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 23:26:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 023782E7162;
	Thu, 16 Oct 2025 23:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OB6K8bD5"
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6E2D2E62BE
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 23:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760657166; cv=none; b=RtQlt1wHhPfwn/0tUS51oRkOg1g3m0ckfzFpwQGJql8GVK9/V684tI3LQQAqNjkQw+q+lF+1ssHIzCNFTOBBShj/fObTw6tObN2pCNf7GnzEv4/dntUYbZxYg8/pwPcyV0N95G4wW+FltF2HlAqkhILPOoPz7Xg0xwccxI8jSnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760657166; c=relaxed/simple;
	bh=E+JggmdmCtBj6KDkuLqnnfKIt7/ceu80PeaihGVC/S0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L9ommKBr1d6xRJYZcsOEjkEIv2+WfOtzVQsTUtFDAaLVbDHyC2AkYuF2nExjDw/B4mzv1LcEp01PwHVsuyEs/ueZhs8Xgq+vuLX31rYNOtKjMElhAzdwaFuURhvimxtu5zaSyL8tVVHOhPQQw5Dp26knzMd+8tZh/6jLwfFsIKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OB6K8bD5; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-32edcc68e0fso221269a91.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 16:26:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760657164; x=1761261964; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E+JggmdmCtBj6KDkuLqnnfKIt7/ceu80PeaihGVC/S0=;
        b=OB6K8bD56ASaMYFx2Q6bEGd+8H+Yq5PnTNog417MqTaOwJWYDeRDhcDG0edCGMX+nL
         JYWxvu0rI9pmnE9zeWwd/hX3KEbtVbxEN2CRa8FU2W78Z2EIm8cm20SGWjYUG9bNCfEo
         A+sP4vS6AX9S26Nqsxq1oPDDPty2JCbvBukNTM4IjEqzRKEhYroqYHAuQtWdv5/WFV9w
         lnTQ0hibQOyMxdEsE4f4igDR8VvS1SwaskChKQqzAKO8xZTJi3KH9bRNeZGyajlVryGe
         1BLDvnmPoObYptEBGUIZ2H3GHedLlIV/M9jGWwWYUCzfbFs/DiIt1vqFx7eDtVec3/Z9
         ew1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760657164; x=1761261964;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E+JggmdmCtBj6KDkuLqnnfKIt7/ceu80PeaihGVC/S0=;
        b=p4vXaVtUvxkJ4BuVKZ/1mRU+Io3o/kt9WARghVxq/Fb1Mf3Gjam0HiEZWs+Ikh8IvW
         wEdq3Xd79XEMLT/TMYKc2elCMR8f12n9kWzBts7aK89leyUZ0YzFu48zR2wqIWezMVyR
         YyNDPJ94Ainh+qqQHTssiXROFKNEcdbxVRfnI5roeYPveZhkxqA1fQdP4wqh9MNuLPBN
         MYIFET93fI7ouBrgazq2qr3Wq6cvwHk2CrCWsw/ZZXeSXGC0xJAJIcNyUQVevBVBQJts
         8zKLal4SXoWE9IedG7YsjDCQZOC8IY4174k2rrCRRuwnLEyu6oQc5/qMxeIvJuJCULaD
         UnuQ==
X-Forwarded-Encrypted: i=1; AJvYcCXL66FccLHQiKlOwZ0sCfG5dckHmxlgSGRXfa9oqH71xl13dGdlHO00gonSDWgkcdftTvnPAsMjsF3RD5M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyre5fOtPnyu5gBxDiuTcPqUGKfQr87npRTwxOPLgYqO5AM7WKD
	y49TtfErBFp73g5tZuoPbu5UDKm+l6OHXnfZI2ku4TBG9GS+eGdgI/urC6hWnwegPnl19YgRNth
	Fa3OKairQLrhsNHjrDQfUF3/hL7yWuXQ=
X-Gm-Gg: ASbGncupRRRpFhNSJi5ZlRlfsi5rpSRmQatISIGDcrZSCM4Qx9tYIEiJCfrq5V1BMPx
	5zt9rW3aZra6Y+6od7/4qbLX/38qD5bH/PC/KdBdCw8T3xLGgVLUCZWneUPx2IVcNFnNM4MezGk
	xglcHaiQ7dPgdX6snx1Awm5gBGFQOBF0AVwHuESFRb93pAI3Skd7xkxLL5+BAP9n5ODKZ0SzbZE
	XHpxqzyt2ACFwMnXAXJef2TIzHqkFUhwYxZlyEZ+rIqY4MyhncXJdR28B9FOZqH9djNdXMQeZC5
	RcFz2j5VWC+M01r01U5IPuzpMPcKC5atnRqeM129Pjkv6RdQvg8IVHJfEBL77KGHWZmi98QEGvD
	NC71sIOEqPv06sg==
X-Google-Smtp-Source: AGHT+IHnRUogCTLR4j2SRK3tnx9yJeIhgejmiTK6A9npVoSOmDy3a5IB+8s4WFVWl7NclfK6Oapzgp8ltJtmKXRKyH0=
X-Received: by 2002:a17:902:d484:b0:269:80e2:c5a8 with SMTP id
 d9443c01a7336-290cba419fdmr9896625ad.7.1760657163954; Thu, 16 Oct 2025
 16:26:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251013062041.1639529-1-apopple@nvidia.com> <20251013062041.1639529-4-apopple@nvidia.com>
 <DDJJ4ECCSE2I.1EUAJRU9JBGNI@nvidia.com> <zwaefk62to77b5nyakeiboyj53fge3lysc3z7arp54tyyherdo@nsqhuig7bmbc>
 <DDK4KADWJHMG.1FUPL3SDR26XF@kernel.org>
In-Reply-To: <DDK4KADWJHMG.1FUPL3SDR26XF@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 17 Oct 2025 01:25:51 +0200
X-Gm-Features: AS18NWAntWCgqHJ-0gybXjQxgpqfISwElGAlnBfAxtiow_eCYUtIQUGW5snmefQ
Message-ID: <CANiq72=bXR4oodrPS8_Dk59cNQa54EOzAPxp3r6e7BAKoZy2Wg@mail.gmail.com>
Subject: Re: [PATCH v5 03/14] gpu: nova-core: gsp: Create wpr metadata
To: Danilo Krummrich <dakr@kernel.org>
Cc: Alistair Popple <apopple@nvidia.com>, Alexandre Courbot <acourbot@nvidia.com>, 
	rust-for-linux@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, John Hubbard <jhubbard@nvidia.com>, 
	Joel Fernandes <joelagnelf@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, linux-kernel@vger.kernel.org, 
	nouveau@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 17, 2025 at 1:11=E2=80=AFAM Danilo Krummrich <dakr@kernel.org> =
wrote:
>
> Since nova-core depends on CONFIG_64BIT, I think we want a helper functio=
n that
> converts usize to u64 infallibly.
>
> This helper function can simply generate a compile time error, when
> !CONFIG_64BIT, etc.
>
> We can do this locally in nova-core, but it could also find it's place in=
 the
> generic infrastructure. nova-core clearly won't be the last driver runnin=
g into
> this inconvinience.

Indeed.

Cheers,
Miguel

