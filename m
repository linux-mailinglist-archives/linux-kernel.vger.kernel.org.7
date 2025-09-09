Return-Path: <linux-kernel+bounces-807356-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0437BB4A35F
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 09:21:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80B1C3A389C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 07:21:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6752D303A1A;
	Tue,  9 Sep 2025 07:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jEBCAKS0"
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AA4A2DFA2B
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 07:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757402497; cv=none; b=P3tjHwkXG+CIF7iDEvfZMEMjuLbbrDvrBka+CKKrtS33pJmpaG/BEAIMTXQkaicqcaPRVMEx48PFv8lD5VVbajRWfAXzZixJXX+wJjhAxndUfi7Lq9LRvhRl7jSpKHJ8K+pwVYgsZC6JFuwEw/0h427nwde+5eeHAWkHUM+Q/xI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757402497; c=relaxed/simple;
	bh=l9DtedJsOYuVEvTUaq8Uosius3V8uLRiTM1xhY019yI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y+wrmyVY/D/MrPiA5Rwe9Ubgc5KU5fH4Mq1KNOZhg3YVzq84z117qWdmCnw9rByxOYQyIfb115K1VGl9l7JZOCIFo/1kUaMChntpIRWRwjL7TtG8es9q1njJhV53YjwF8Yqxk74vHfLZdlc5m+7d4V67DkYGJmfh6K9yUPbDn3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jEBCAKS0; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-323266cd073so452926a91.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 00:21:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757402496; x=1758007296; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l9DtedJsOYuVEvTUaq8Uosius3V8uLRiTM1xhY019yI=;
        b=jEBCAKS0vH2oZPOyesatisnufSqklM1Otmu7mtZ5ZOmD5x8qN8T3yjihHcvGMzsxUr
         yV4caEg1AELrR+Gb+cCNN7bLVfmJr8T0h/ljiMj4okBzjRdxsOLR6JYJnnBc+CZJaWv3
         yf2wuBGghcWMajC4WNMXzSbGeoEqIv7VmPnOQ6JEb40Bld12eqAQddf5FEqKdGDRjxLH
         Y6sVJSM0EdtEPfIdDaTmyKgfc72i0PZyS3Dqq6ftmUfLkNZnL1rSHtsul3zyQk54Xx5+
         K9ZGd66WUzYyqDzjDZ8GIf7jP2QmYI15ZTwJMWCDPPIABtHmgSZUzBZmRMWagkDF4tAn
         Hz4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757402496; x=1758007296;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l9DtedJsOYuVEvTUaq8Uosius3V8uLRiTM1xhY019yI=;
        b=V2EtbKKJwY/KfcUFz5EOhd19l2lVad/mqRqLMBku46IyjFnJut3Ke6M0dwa/1f//8i
         QhttB4lQAe5nj0TxL2oeAbUouJ3vVwwoM2F3qaNLO+79wEqauAqNAAHGA3wxdXIoPEM0
         eM2Fl/k0aQRzb4XQgZs7tqfUX2iyA9F2AfjNRIR4voyJYqIQm32eQYRSy8TIU1fCd2fL
         F5lxG8n7uHxSbStlYsWLqj+3SnKbBPEB3nOn+zufzEo+TeiXGVTRbC7A5LGNVSLtH5fj
         JKJJcu5VWe1u0voKS2LRTTleXzmY3N+o1WgKJcFS1I6P7AeAFXFQd7lauR6FRDvjIz/0
         Y/7A==
X-Forwarded-Encrypted: i=1; AJvYcCUeT5wISyaCTeRBMngGR3LHj3MAT01GUIAs575lxy+xSrHiId7B7ySIZsuXtOl4ly0GIGVXXCHeAucGWZk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxK0TwReg170kH0qhvfVk83nDWjD0AgLqmviuoGJJp48Mzg4iJn
	5BWrxjp63hqESjC8hqVhjHyeEEmB+kfo/KuaYCPLTWrJqEYYzo+XXAWmQi38FSp0SJ52Ejatp7u
	gP99kG/ON+cG6P4Mym69Hc7MFzpWWmI8=
X-Gm-Gg: ASbGncvrXgclDtjdZdvuguMdPLjrXD9iXIk5VHglbjySWHr+kE4E0TTtgNlyMZwdmHP
	QhjeUVEdEOhzu94hEenULKRAP5AgbrTnFeFo8EHqm639ic12yfPe0H3ZT3OuYUJuLFmj/FuWVrN
	4tmuQwbR7SZtzTMboOk6hBMJWmjWSt7RRorbvMRM4ouS7EzVRNbh9ZuPowWWNo4MOa39rRCvePg
	leiHPER6/kAAd907W9ZhVLJOHjwTBd1LOeUK6+J4KkkCo/FFGRnFa1iay7fNraaAvk/hMG8PiBE
	gBOqjYlGjBHgIOsqD97Fx5/3NQ==
X-Google-Smtp-Source: AGHT+IEIXETZN1hzIMbaPZTBAMFbsBjP+gyiUTRbHUQasXE8TDSwxmd/yWLYzZKSkpfL8EimpWar9GL+cCL5u2GOr5A=
X-Received: by 2002:a17:90b:4d0d:b0:32a:e70a:fe88 with SMTP id
 98e67ed59e1d1-32d440c4cf9mr7541621a91.7.1757402495698; Tue, 09 Sep 2025
 00:21:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250908-num-v5-0-c0f2f681ea96@nvidia.com> <20250908-num-v5-1-c0f2f681ea96@nvidia.com>
 <CANiq72kUsG10+E-W6zhFXhexZV+O_a-K1Px0kGkWPKvMMhAztQ@mail.gmail.com> <DCO2UHSV1FJH.146QJD3UR8FVR@nvidia.com>
In-Reply-To: <DCO2UHSV1FJH.146QJD3UR8FVR@nvidia.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 9 Sep 2025 09:21:23 +0200
X-Gm-Features: AS18NWDo9PmPkwt5HhFhUFBw5hG52sGUJOa3FDCEs24d7ACJy4H42N2u2Jnvv7M
Message-ID: <CANiq72khp7PVeKmbvM=ima7Tp7o1zPfjNY6dRK79aAQZsOvBPw@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] rust: add `Alignment` type
To: Alexandre Courbot <acourbot@nvidia.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, nouveau@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 9, 2025 at 9:05=E2=80=AFAM Alexandre Courbot <acourbot@nvidia.c=
om> wrote:
>
> With -rc6 approaching, I don't think we will merge any Nova code taking
> advantage of this for this cycle, so please feel free to take this
> patch. We can then merge patch 2 through drm-rust after -rc1 is
> released.

Sure, sounds good. I can also take patch 2 already as a user of this
if you prefer (ideally with an Acked-by).

> Should I send a new revision with your fixes, or will you apply them?

I can, no worries, thanks!

Cheers,
Miguel

