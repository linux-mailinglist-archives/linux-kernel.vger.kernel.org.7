Return-Path: <linux-kernel+bounces-837247-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D4D6BABC7A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 09:15:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F07443AF453
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 07:15:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8E7E242D79;
	Tue, 30 Sep 2025 07:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lv+mSRl1"
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFD9122EE5
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 07:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759216544; cv=none; b=RggVnpwx5cIp8cNxXis38h5EGWeMmCfST7vK6kz56w0eZTKip0YZdo+g3oc/4AXvCLauWzhhyVP6WOzH0X46NQVkerffL1DfNkC4FBo40FY//VxiMIiNcgMizDVFn0vQY/H5ceUILiBZAC2MvtGsKE6Au1gOrHccWUivoGyUMlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759216544; c=relaxed/simple;
	bh=bYKtjmuSp8WHPKGo1stRMHk4Zp8bG7Oz5IVoChYgOsc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XWkdq3hEQoe3W+rc+Lak0B/pYU01D7W+QKP3mxPHbp9wg8TZe0XDHfKClKBb/omganhPPg+LpaCS1Vh52Gqwaui4yGMbZUWhtBESJitcZmQpkU5cQ9nuARIYljuaUboB+cCsPYhLHnT5kD90dcVA3xfQJniKbl+9JYgkaK8sWAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lv+mSRl1; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-333abc4394dso840737a91.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 00:15:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759216542; x=1759821342; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bYKtjmuSp8WHPKGo1stRMHk4Zp8bG7Oz5IVoChYgOsc=;
        b=Lv+mSRl1VvllX1NVtIc+eWBArMnEd0v/czIe1dpDDZLSA/2z12+ELTjbx6iWe8BEcI
         uwb1kbhApot73seBboah0ZOb8B4tHBJl+SeHANJzVHRqMFqBnhBGStHEpL5cFfTk03xq
         TZY4CstprQXmEnq8j9Pa3y2Pf451/y6HLgLISgrL3ecLYgClXaoYcHEZmicitPx6mwFo
         sMJQB0ECiYmLqZPNG6nyuFj1yto/WDFs9JkQRjc5jEN3xiJW7lw1JjsOPF+w7UOTIVJK
         ZZkiygyO0eWpbIutO2W8UzhckrphKVad6pffJBo+MLyiF8mKQ+iQcL5RXoUAA5K6GBmx
         wN0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759216542; x=1759821342;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bYKtjmuSp8WHPKGo1stRMHk4Zp8bG7Oz5IVoChYgOsc=;
        b=YCZ6h3a5R+okreBIAKxt3fSV3HB8Ik9gPsptXR75fDnvsUO6MwbzJw0wbknZ4rjMgc
         yCcyf/VHQQPuvMq+hCQt6p2zx5vHXlJLjhqbBJAM7f78saWPu7ABnTWfU4qU8tMzLbc1
         gSBq/xCFORht6yp79oLHaUikax4hS0ZfRG++b74Dv6xlRbphinjbkOYJj1pfAj38ytQK
         A4EHMxL5+HFZfMu6sklPR3+6BO2JD2mqIz8F+IBIu/2OBUiuEFCC2z1o7TXSkppv4nWd
         WnjXyfDNJ550xG0BbhdZ8nODyVh7IeUyyD40rdmNMwGTyj7jHJdmz66ebFsXHdhQ6YRF
         hqUQ==
X-Forwarded-Encrypted: i=1; AJvYcCVcSVh8oKyQsxnCvNzS5g8gwNNegaeDeNyQp2A4yLJGc85wp9V4hofWTDkwESHdOaTCQ0+ju1lJMWvOh5o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzi6dM4DfNRtuK5x+2J456W3Lb622tDlcz7ZNtpfgiSD5b4H++6
	CbGWrIScXhJl3JRz64WLw2NoNC4p8Eda8pG0vGUevxzjggZtsD5gXVZC6jEE4Ti3oz/H7+QFKu9
	kuGQWiIMMtt3pacsOwnve2xIgyDCazvc=
X-Gm-Gg: ASbGncsITf3E2q0G1lIyKeLRrPJoGw/x8J/Gbu/ozMn152+8GJpCKKMywhLrWs6oS+S
	rXxXMIfniWAypFMFcDCn7AxxXt1ccRjLvGWsbBNMXnJVa2grURbnjG5fj3V1B/y5WSIdKexKDcw
	beWQXyAJ66yn+kO33xnpluo/n05SYDQn6u3LtdbEQnsn+KciaNVK6T6pdLyyt/R+Qoh5Wgyz7UG
	8Y9X3W7ojkqnvR7RgLv+GLrePkxatY7qWr4CBvQmfHjXiH+TvXmA10QPCwESBooyc8tHtfvcErM
	RMFegVyjIk7Th/yCoMs5Z7U45thinas/+gks5cWxZbQhMm9JWj3zpaGdBygy
X-Google-Smtp-Source: AGHT+IFP7t5MzVLMeqCeEzPgWwzMMlQ35L2NiKbBPcqBGD7XWZx+ZpB9ob6tpl2FHQgys9W1N33lBcgRC3EHBmH+gvM=
X-Received: by 2002:a17:902:ec85:b0:272:f27d:33bd with SMTP id
 d9443c01a7336-27ed44d5f06mr135508985ad.0.1759216542032; Tue, 30 Sep 2025
 00:15:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250930-nova-tryfrom-v1-1-0cc1bb507047@nvidia.com>
In-Reply-To: <20250930-nova-tryfrom-v1-1-0cc1bb507047@nvidia.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 30 Sep 2025 09:15:28 +0200
X-Gm-Features: AS18NWBXJDrDh3CHU3MG4Bnt1-ohuc72B_SoqOSakBKgfBdQNMLxKs7VmYo9yF8
Message-ID: <CANiq72n_pG8u7N7=jS4LfNjz+cP8xi1nVOxaGH=XXfr1+nea7w@mail.gmail.com>
Subject: Re: [PATCH RFC] gpu: nova-core: use the TryFrom/Into derive macros
To: Alexandre Courbot <acourbot@nvidia.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Jesung Yang <y.j3ms.n@gmail.com>, 
	Danilo Krummrich <dakr@kernel.org>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, rust-for-linux@vger.kernel.org, 
	nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 30, 2025 at 6:55=E2=80=AFAM Alexandre Courbot <acourbot@nvidia.=
com> wrote:
>
> As requested on [1], this is how these macros are used in Nova-core.

Thanks!

Cheers,
Miguel

