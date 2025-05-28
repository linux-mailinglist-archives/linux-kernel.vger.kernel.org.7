Return-Path: <linux-kernel+bounces-665296-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AF4AAC6719
	for <lists+linux-kernel@lfdr.de>; Wed, 28 May 2025 12:37:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6CE43B1FA3
	for <lists+linux-kernel@lfdr.de>; Wed, 28 May 2025 10:36:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7729427603D;
	Wed, 28 May 2025 10:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="B5eSM2ys"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA8F727602A
	for <linux-kernel@vger.kernel.org>; Wed, 28 May 2025 10:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748428597; cv=none; b=bUCbXRDZPoA+ZW5CHgu+QQm/YA3j/Y+ruY3knJyaaNj0zMJ07xreA0VIHehS4oXV0ffs5rBeEbvpp8ELKqqSrEfOjh4DyN0JnIsruRH+3uaEmMKE6MpFFd0pgVZj4cJkq1uMmiVzQ/6pTYxVYstlwFys+7MnQ+S2RNeP//5wPl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748428597; c=relaxed/simple;
	bh=Si1j6uouuZRKixZgcv6BHoJXWodMnlY2oC/q9yWhRtM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=pC533zs9iHDHy+6qD5Ypj7cc6TkAQgLCEnQfeG/cwx3N/cI0KO5xQlLzD7Ko+khM6GkNecx2e02q129/MXyCi0vLJDC3wwWtGSXHktBX2UeE/TFZZkLCX4Wo+VzMOFyzLuccZ07+sExCr06A8yKLXJu6Ra4Rut2KDXwzHyHorf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=B5eSM2ys; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-43d4d15058dso32373775e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 28 May 2025 03:36:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748428594; x=1749033394; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Si1j6uouuZRKixZgcv6BHoJXWodMnlY2oC/q9yWhRtM=;
        b=B5eSM2ys+lzU9jsSKW8f2NVwNe8eM8+bJ9Ksg0qLUykjwmdFPweLQsA2/kF+LfbdR8
         EsIc+idddvAhVYGr1+sUwYD72Xxq4Phgts9qUcpqLWH+zBunCLT3mtJRvorYWaH269ia
         76WYrmuuTpaSXQ8kuLwNcE2+uzJ/VTMxs1CwpmHEICrvEzUCg77IGhCE9EiXGSZf7oO6
         cdUa6gukkH8IQC4asmvi9L4vk+ZfJZwyoAAApzCpjJjmSJxvcZjnKFqxENnZ6YR8a/4u
         CwEEY+jVnVwEYzBGXymd/EtIjY0b5Fek0EzcpNvaUSIVlrGx5DPowZVn1EwrZkjzaW1r
         Tgbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748428594; x=1749033394;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Si1j6uouuZRKixZgcv6BHoJXWodMnlY2oC/q9yWhRtM=;
        b=e1nuA+80HyVrup+dxnyOTVwXto3ruAVNLvgL6RhryQC0NOQVKYcsc70y9em/nneX2p
         7MMolX0/Sy6TdeJlJPdlwaYSmfxWo/Q3BJ8/VEneGVFZ4oUr++rlsKrrgCzTtqtibuw+
         aIia5NXwVv6qNQRgH3GKVwGZ0TtT9XOL1xXNx3XXm4pQvKQpO5MXYrKW4QpyK4uzXEMw
         ufausxdgsr2rWZs6jWGL/IEFHNmUygYVd69gvYTG+i9P9o/z0836XO/ak0nS69EZ2FU7
         fvzwrTikkO0bJKmCenCHJ4wsDbxS3JrK65YdXDxGQfX9Z96JyWGwQdG0iTDiVO52jNHM
         vgoQ==
X-Forwarded-Encrypted: i=1; AJvYcCWqJYWVOzQpJRLNZAC83Q46nFhNxJgN/ERPqa+kM+j3QKn5/KnjjMjNxzsvGDWkKHDMCfPEYdYO2edot14=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxy+N0yGAcjpUu0X6XMbTLeMmKA22AsAkohDDgq7uMeUSZ8vTbR
	YVJ4X99pWiiuRf0gz4u/DrZo3wTYRibCR0hAXhyXzfox4KGbT52FRDCrMnZfno4RDdFibrprpOp
	0yI5gjxC0BtRYKcDRIA==
X-Google-Smtp-Source: AGHT+IHiPY375iu6n+ZkU8ZC6vWYnO6vfkfIsES083JMYvmdbEogAqIJfVfK9XDvKlL1n6CsZmK6dlKKd2C91Us=
X-Received: from wmbhc21.prod.google.com ([2002:a05:600c:8715:b0:442:f984:ed5e])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:a13:b0:43d:160:cd9e with SMTP id 5b1f17b1804b1-44c91fbb448mr159783095e9.17.1748428594079;
 Wed, 28 May 2025 03:36:34 -0700 (PDT)
Date: Wed, 28 May 2025 10:36:31 +0000
In-Reply-To: <CAJ-ks9nd6_iGK+ie-f+F0x4kwpyEGJ-kQiQGt-ffdbVN5S6kOg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250524-cstr-core-v10-0-6412a94d9d75@gmail.com>
 <20250524-cstr-core-v10-4-6412a94d9d75@gmail.com> <DA66NJXU86M4.1HU12P6E79JLO@kernel.org>
 <CAJ-ks9nd6_iGK+ie-f+F0x4kwpyEGJ-kQiQGt-ffdbVN5S6kOg@mail.gmail.com>
Message-ID: <aDbnLzPIGiAZISOq@google.com>
Subject: Re: [PATCH v10 4/5] rust: replace `kernel::c_str!` with C-Strings
From: Alice Ryhl <aliceryhl@google.com>
To: Tamir Duberstein <tamird@gmail.com>
Cc: Benno Lossin <lossin@kernel.org>, Michal Rostecki <vadorovsky@protonmail.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Brendan Higgins <brendan.higgins@linux.dev>, 
	David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>, 
	Danilo Krummrich <dakr@kernel.org>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Luis Chamberlain <mcgrof@kernel.org>, Russ Weight <russ.weight@linux.dev>, 
	FUJITA Tomonori <fujita.tomonori@gmail.com>, Rob Herring <robh@kernel.org>, 
	Saravana Kannan <saravanak@google.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, Andrew Lunn <andrew@lunn.ch>, 
	Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Bjorn Helgaas <bhelgaas@google.com>, 
	Arnd Bergmann <arnd@arndb.de>, Jens Axboe <axboe@kernel.dk>, 
	"Krzysztof =?utf-8?Q?Wilczy=C5=84ski?=" <kwilczynski@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kunit-dev@googlegroups.com, dri-devel@lists.freedesktop.org, 
	netdev@vger.kernel.org, devicetree@vger.kernel.org, llvm@lists.linux.dev, 
	linux-pci@vger.kernel.org, nouveau@lists.freedesktop.org, 
	linux-block@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 26, 2025 at 06:29:46PM -0400, Tamir Duberstein wrote:
> On Mon, May 26, 2025 at 11:04=E2=80=AFAM Benno Lossin <lossin@kernel.org>=
 wrote:
> >
> > On Sat May 24, 2025 at 10:33 PM CEST, Tamir Duberstein wrote:
> > > +macro_rules! c_str_avoid_literals {
> >
> > I don't like this name, how about `concat_to_c_str` or
> > `concat_with_nul`?
> >
> > This macro also is useful from macros that have a normal string literal=
,
> > but can't turn it into a `c""` one.
>=20
> Uh, can you give an example? I'm not attached to the name.

I also think it should be renamed. Right now it sounds like it creates a
c string while avoiding literals in the input ... whatever that means. I
like Benno's suggestions, but str_to_cstr! could also work?

Alice

