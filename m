Return-Path: <linux-kernel+bounces-806609-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 786ADB49947
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 21:03:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C4A857AA0BC
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 19:01:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A4EB231845;
	Mon,  8 Sep 2025 19:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="D5Sg1Mdw"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A087D22ACF3
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 19:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757358183; cv=none; b=SkRevBbXVU2BArMg5KSOo3dMNyoXEIHTTpTijbJ7heKBKhpRcMea9YZmvnF8WzAN6YLBMhQ5UlY1k6SGuCn/UO/Mhh3tKGame9pubZZKe8koZHzg0z5ETFiyYr4cdVCRGwTwUD2gPFlFSQCH7ddB4ag0VaCo1IwLSWUpTjCyZMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757358183; c=relaxed/simple;
	bh=kHTSV8jfrTaUVkrn/wg4xsZHJegEbBiLAKt+O42yjxE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YGNc5sEpLcB7XzUFkZhk5W2Q1y6kwma59qK1DXoyxqCWOYLqlcrKlRX5/c1lqL8NwO8esP/pdnou0GDXv36HbkeU/i0jRTBwnrbNmiHPfyZN9ltL/LRJXj50XKt8Uy86DVoMcmVUIz8f/zrcOomlUP/U5Ax5GW6pWyg0789tzqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=D5Sg1Mdw; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-45cb6180b60so30307275e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 12:03:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757358180; x=1757962980; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YGkvJHfAPV/3bX3cS+jtsH6Oy+pYikY5VFUSFXl/ge4=;
        b=D5Sg1MdwqDnOr01SJSjmoOTan3vlAfPGKr1HP4sKqh0Ik0HvWqnIj4uRfO8Ip4Bwgd
         RomQxpSe+pKsbIAypJcv1GMFXbRpnuTfpo3nuVwdDlh2YFgE20x+RffS21SeCky71r6N
         9ddMK0uSgb/R8ocv/+kQE0JBxNK+xi+YtaiweFU4UkQVhHy8urja/mZzv6D4LQ8x1oSo
         AjdgV/fYmz74KtCxrZNkatqRy4uiNu0YO9Jx0ywIx2qItbAT/Sin1RzhM4PNeGxgKlGG
         WZzuPt83/Jm9H+e0d6KgqzXJ5eUiS8RybtzLOdcz9KfYdlr/j/Vo2U7CB9CH3Z1Ax/aZ
         1GiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757358180; x=1757962980;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YGkvJHfAPV/3bX3cS+jtsH6Oy+pYikY5VFUSFXl/ge4=;
        b=JVCIhVdiX175XMde3GqFmRLTVrlD1LhwlsWUZ8j6RPb2+ODWL51t8ZSrULSDGHwp4/
         qKz5sytdTqOo+HQWHRZTVRydxDdhoiy1wWMD2M7g1SOMxTQJUYqQl8lDnVNB84XDPCjp
         UwXFx6VbXxdOBC7Q1Z3uIM8NSyJxtZR7Q5bjeCmbtT9x8cTM5q3nENv2UpLsTcF4WyaD
         I7HYjSNSsGr6DQHcw4guT/AgeHU3sVerZfHdWDCSTovmkzASXhDPUQ2xlmG+UlQkRYbD
         jE5+3kWJXWSBZJaGi1OOVsl1rk39yumpd85Cc6qbjbvfTtES2elWPIDt218g2mVPEAnZ
         7IIw==
X-Forwarded-Encrypted: i=1; AJvYcCUUsJOA7nfwQDNdPf3SUlCgK752S5rBNpBt2guFbR52gUzGodiQMPO7dLasjir1dKPEG3yLMlN5pqcRH44=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7aohJz+Ze27kGQLmTse99IpuG5foRJTM6rtZjvNvB3xzBvFke
	Xl6+cMvL86B4tIgRbjx0sxUUC09G23mzfZCE1i9/7FdsNxg9hEsiWmWPE8+lWKw/sRTthoaUUxi
	NlI8E+QGPXQzhvRLlxd/L5WfPOSphjtW4se57BKDq
X-Gm-Gg: ASbGnctPJ1TRaIqkcz1woPJWGF385F2p4z6w8GqRna5b+fiytvRT+shHquQTjYJ7taQ
	z0J1lx7G3sTCeITHwe7urZipUz/AqNTCl3DlhneAY3STg6//Ac7wtUHj6rn3UyRjblw50vCm1OM
	4WuCtTvIZOhAJJHW1BmrxN3yYPAE0kPaYvdvf5PQTLPwX5NRqYmC8SHv2dgXZD5YzK3SlMYmx4+
	uGT0Jci68Ja9cGN4QGxqjQMwdaQ+FPbLgP+WPvSbtpmA9M=
X-Google-Smtp-Source: AGHT+IHD9xXpzxFp5PJ1LiMALVk8G2qCrHktRr6s3MtGbxUdLsV0q4AzUS7LRxtsm9cmQI9P4cr+vh4V5ldORb0FTlQ=
X-Received: by 2002:a05:6000:288c:b0:3d4:2f8c:1d41 with SMTP id
 ffacd0b85a97d-3e6429ce523mr7165940f8f.20.1757358179561; Mon, 08 Sep 2025
 12:02:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250908185239.135849-1-lyude@redhat.com>
In-Reply-To: <20250908185239.135849-1-lyude@redhat.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Mon, 8 Sep 2025 21:02:47 +0200
X-Gm-Features: AS18NWA9JjcfFmYV0JQId5ES12OkLgTAZUupg-74m7pAwM3NG9Y9Z08Ctn_PmSc
Message-ID: <CAH5fLgh8_pmtwgOPuXpDqhiK7rsj0S-ySrX9M_yEsn6n5pKHpA@mail.gmail.com>
Subject: Re: [PATCH v4 0/3] rust/drm: Misc. gem bindings cleanup
To: Lyude Paul <lyude@redhat.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 8, 2025 at 8:52=E2=80=AFPM Lyude Paul <lyude@redhat.com> wrote:
>
> This is the first few patches that were originally part of the series to
> introduce gem shmem bindings for rust into the Linux kernel, which can
> be found here:
>
> https://lkml.org/lkml/2025/8/29/1533
>
> These patches don't have any dependencies besides needing to be applied
> on top of drm-rust-next.
>
> Lyude Paul (3):
>   rust: drm: gem: Simplify use of generics
>   rust: drm: gem: Add DriverFile type alias
>   rust: drm: gem: Drop Object::SIZE
>
>  drivers/gpu/drm/nova/gem.rs |  8 ++--
>  rust/kernel/drm/driver.rs   |  3 ++
>  rust/kernel/drm/gem/mod.rs  | 93 ++++++++++++++++---------------------
>  3 files changed, 47 insertions(+), 57 deletions(-)

For all 3 patches:
Reviewed-by: Alice Ryhl <aliceryhl@google.com>

