Return-Path: <linux-kernel+bounces-823326-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D0CFB86210
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 18:55:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 486DA3A86B6
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 16:55:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B76A253958;
	Thu, 18 Sep 2025 16:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="O/ZQkTqD"
Received: from mail-ej1-f74.google.com (mail-ej1-f74.google.com [209.85.218.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3189D253358
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 16:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758214516; cv=none; b=qium4Kh98pbjE8FQy+i5JYxQOt2mEG+RwNhUHe/iFd6TKX/K4gwFEk0kSXDGfnKcFkWdXozJUrhqMS6LIXIwIx1qZ/0Fo4Ut4nEXo+NgY5OyugwNpQ2qgiVobM/CVAn4oYgIopyNKMIFFKb7cohQQjoW111nkKL14X/I7QMB4MA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758214516; c=relaxed/simple;
	bh=7yj+8e2r8iHEk5ANg8qImbXoBk4yFye88GKD4KMyPR8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=u3C/qTHFWQfAy28CZ8BjeyUkKVZuSYveAGX9I6WEmnZnmff0UGgrp2zQApE05PpZ6rAWOZ4xbl/Jd52GjQrI706wWNDy6nHaQDpZT6PrBbPrUMHUuf4uFT8Krx9UZxLPGckq2g1WbOe9vUnHZuky09jho29sfn6FSg40i3sLgNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=O/ZQkTqD; arc=none smtp.client-ip=209.85.218.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-ej1-f74.google.com with SMTP id a640c23a62f3a-b0f435a8e5eso105209966b.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 09:55:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758214512; x=1758819312; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=34EDgIXBDluEGauPQSlOKGzRZygW8gJTTorkuPVWZA8=;
        b=O/ZQkTqDLwK5VQ+nMrMUMrYC/4XCRTAgmL/qvsDGJQHjkxCx7/i8upWg5byKjlt37g
         hFtBbtu8Hepm3IN7p5sCEB4WIndP+d1kLBxy7S/U+EMJsntPtEX3U0ASwGJUGEwhFz8v
         0669gFCNKj2Gjzb+UfG7GIOvyQQ61wBZ5J66ZUt2GRZdYPObK49D5DOBa7lZgCDMFQP5
         oPLTX9C0+7oCleh8g/OM7jUsUf01BQRsPUcqoWv9TGAP+QIBbk++1p66tL5+Kff3kYGn
         9DR8eut4nP3VcNs6kMhK+kicFAXuH+5hzH+d/F96/cbrk90LAQq1J/6M+DSgg0gmNZ9b
         ewlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758214512; x=1758819312;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=34EDgIXBDluEGauPQSlOKGzRZygW8gJTTorkuPVWZA8=;
        b=NxPjEUbUyszAa5HkWcxBq6qAoxUaPejPNUDJDogTEHdVfBwzlUBzhWGw1j574EQqnx
         Lj/G2Ua0hmTMYj/qIQtMHMR6zuQAI7wGtJaKCEuFDkh5ulRhr2D3Vg4fKI1YXBOv1oCH
         tSxAVyGKHpoz5KBppxJZ+7C+F/N0JsjfeGuSx0XPxoZdYWmfWoz9Few7TWnS+rsJ3/w8
         Y3V3fnoy6VLPFEgCfsz6rz1RjvwYFq98c7xOgyoZWO2/DfH0Xy4HKIE8rr8fNXaYIcqZ
         6l3oVfe06W3tMuZzkqtmPrGKfkbzaWHUxHv9LblLsLer19ZImHcR2amA2JoQrIgiwz6q
         i64A==
X-Forwarded-Encrypted: i=1; AJvYcCWSG59o8vZwxEjTk75FPxK1EE3AAQuNquE+9WZcvwD2F0dBW+RsyNznNENdS7J+p8Uq9UnMN+/IC+g5X0o=@vger.kernel.org
X-Gm-Message-State: AOJu0YybaE71wgBkLgdyg+XCUsZ16LFYNLmYktUUb8YEopkomyd5eSBA
	89ssdG6ofBleQyNufUQyCYssHVRio35DOp8/XC/eA5kkILKbjoVY3I+01rgByatvvKpXNfUUDC2
	bgs5B9Ko08qK+YOZ1JQ==
X-Google-Smtp-Source: AGHT+IF4z5YMCca6wpSe2aYc/hXa4PxHhJwZJSFFGiM7lb0rzYJ7L07Kt4y+RBjUICVPayoJYG2995O0zayX9oE=
X-Received: from ejcli23.prod.google.com ([2002:a17:907:1997:b0:afc:aa75:6cae])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:907:94c3:b0:b07:b50d:df66 with SMTP id a640c23a62f3a-b1bb9d0f22fmr674804866b.19.1758214512173;
 Thu, 18 Sep 2025 09:55:12 -0700 (PDT)
Date: Thu, 18 Sep 2025 16:55:11 +0000
In-Reply-To: <aMwxLQubVOuGZGLf@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250918-rust-binder-v1-1-7a5559e8c6bb@google.com> <aMwxLQubVOuGZGLf@google.com>
Message-ID: <aMw5b7aNxoULilmg@google.com>
Subject: Re: [PATCH] rust_binder: add Rust Binder driver
From: Alice Ryhl <aliceryhl@google.com>
To: Carlos Llamas <cmllamas@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Arve =?utf-8?B?SGrDuG5uZXbDpWc=?=" <arve@android.com>, Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joelagnelf@nvidia.com>, Christian Brauner <brauner@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, 
	"=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Paul Moore <paul@paul-moore.com>, 
	Serge Hallyn <sergeh@kernel.org>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, Wedson Almeida Filho <wedsonaf@gmail.com>, 
	Matt Gilbride <mattgilbride@google.com>
Content-Type: text/plain; charset="utf-8"

On Thu, Sep 18, 2025 at 04:19:57PM +0000, Carlos Llamas wrote:
> On Thu, Sep 18, 2025 at 10:19:38AM +0000, Alice Ryhl wrote:
> > Please see the attached link to the original RFC for motivation.
> > 
> > I did not include all of the tracepoints as I felt that the mechansim
> > for making C access fields of Rust structs should be discussed on list
> > separately. I also did not include the support for building Rust Binder
> > as a module since that requires exporting a bunch of additional symbols
> > on the C side.
> > 
> > Link: https://lore.kernel.org/r/20231101-rust-binder-v1-0-08ba9197f637@google.com
> > Co-developed-by: Wedson Almeida Filho <wedsonaf@gmail.com>
> > Signed-off-by: Wedson Almeida Filho <wedsonaf@gmail.com>
> > Co-developed-by: Matt Gilbride <mattgilbride@google.com>
> > Signed-off-by: Matt Gilbride <mattgilbride@google.com>
> > Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> > --- /dev/null
> > +++ b/drivers/android/binder/Makefile
> > @@ -0,0 +1,9 @@
> > +# SPDX-License-Identifier: GPL-2.0-only
> > +ccflags-y += -I$(src)	# needed for trace events
> > +
> > +obj-$(CONFIG_ANDROID_BINDER_IPC_RUST) += rust_binder.o
> > +rust_binder-$(CONFIG_ANDROID_BINDER_IPC_RUST) := \
> 
> Since there is only one option for rust_binder.o, the target here should
> probably be just 'rust_binder-y := ...'.

Ok. I don't mind.

> > diff --git a/drivers/android/binder/dummy.c b/drivers/android/binder/dummy.c
> > new file mode 100644
> > index 0000000000000000000000000000000000000000..7e9f6ea3a474b59f11e723a709c0c21e8b8beae0
> > --- /dev/null
> > +++ b/drivers/android/binder/dummy.c
> 
> This dummy should be removed, we aren't going to need it here right?

Ah yeah, thanks. This file can be deleted.

> > +// SPDX-License-Identifier: GPL-2.0
> 
> I'm not sure if all these need to be "GPL-2.0-only" explicitly?

It should be the same.

> > +int init_rust_binderfs(void)
> > +{
> > +	int ret;
> > +	const char *name;
> > +	size_t len;
> > +
> > +	/* Verify that the default binderfs device names are valid. */
> > +	name = rust_binder_devices_param;
> > +	for (len = strcspn(name, ","); len > 0; len = strcspn(name, ",")) {
> > +		if (len > BINDERFS_MAX_NAME)
> > +			return -E2BIG;
> > +		name += len;
> > +		if (*name == ',')
> > +			name++;
> > +	}
> > +
> > +	/* Allocate new major number for binderfs. */
> > +	ret = alloc_chrdev_region(&binderfs_dev, 0, BINDERFS_MAX_MINOR,
> > +				  "rust_binder");
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret = register_filesystem(&binder_fs_type);
> > +	if (ret) {
> > +		unregister_chrdev_region(binderfs_dev, BINDERFS_MAX_MINOR);
> > +		return ret;
> > +	}
> > +
> > +	return ret;
> > +}
> 
> Hmm, is there anyway to keep a single binderfs.c implementation? In this
> case we now have separate CONFIGs we could use for the file creation
> callback? It would be nice to keep a single binderfs source file.

It could be nice, but it's pretty non-trivial to unify them. If we do
that, it will have to be a follow-up, and the follow-up will modify C
Binder too.

Alice

