Return-Path: <linux-kernel+bounces-723432-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D4A55AFE69F
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 13:00:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E0DE2188A199
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 10:59:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65D6C28D8EB;
	Wed,  9 Jul 2025 10:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="X7jDIuaX"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 169F227E05B
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 10:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752058732; cv=none; b=Q0u6DjcZJsoWhcHJg+NNohedM+BfWfSawobQ+8dasnXX6+tyoHpv6WLE3JuoRn8lAKTBcfG2zQJtVwE7pSjVI8bsv5VVro0iYZuXkucYeJ8/IGi/b8rcyPumIDLBzCb7H/mjCkSAGCmAmL8ASKARtoF5JW8eA4eBK3ijBnQLzbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752058732; c=relaxed/simple;
	bh=gHzWcOCz3sc3VIt6v1K7pqU3nk+zsaBzIN3PIAfwD0c=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=OIinJWajB4AhFPAhaqZkDE7TEBCmIqNTYmYPAhUi+zF34zxjX6tubfPEGkWUuY9Yca7cY6wuQqDNhMoDTyPWahsfmLVt8bgpkJDOrXfphioqd8tCVCSoH33DG79EQHDh2qDVaNDr3ku2wh7WYJ6xeHHoFx1LZ5peT1+JDsYB9P8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=X7jDIuaX; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-4538f375e86so44695355e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jul 2025 03:58:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752058729; x=1752663529; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=0Ufzj6YqaxPGXZ7DCvWZzYpEGIMdPZyH+W75nyNg9CQ=;
        b=X7jDIuaXV1m3GgTHf2YfBmQxRnYrm17CcW8aXRI4nt0FoFA3wbtJvBO54V4v0Hzj9Q
         5yDK8Q4e+L6OykFB3pXytPqI1HjNg6zDd54wVQ3HPmeTeCtlAAXmwNg6okhGs58wdi6g
         G/L+nWnAYv7cXq2cCgBu22aVsalqjIvhCP0rSivtWNxtkGKi+91ESoXvBD+jDw6grKOk
         aw4bhPhvs4FMEp5ex24T1eLhUNOGtup47sycTW2KzVki1KTLSlM2FiNFl7zo7xy9VJFC
         9+6wH8HbbTEs2BZyzszIDGQiDYKcc99wpIWn1RljRaE1slOctrKhsancvEksNpe+FA6P
         5NeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752058729; x=1752663529;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0Ufzj6YqaxPGXZ7DCvWZzYpEGIMdPZyH+W75nyNg9CQ=;
        b=IrklGU6EeTLieMu1e2BUe1OJQAZWNmutnK1phnnqkJRWAP0+Uj63vbVNj8H2nIr0zW
         yGOnufKdT7VVpN23wBrCZkI0Ml4W5DBvdcKstBJD2/mJh6KA4lu4nYsVSgbfE6uedoCA
         n5FBCNty67q/2zyPKwyIV3pM+nW+nqxffnyIXJ6AHeW079O4RzeXNRssAVTTj8jrkcma
         a+5kkAPBAF9p5+R99ts5dlgJu93sbI6+hTI6uO3vqKJ4QLxfWNDGZGoomgqOo6DprR00
         dDWNtAB8oYzB2gRkoSVOJfSScvnzQqPXz8iJyBP0UyD18dy4ojrWaiWArFzNvEy10V0/
         gjQg==
X-Forwarded-Encrypted: i=1; AJvYcCV3EO21n/QP1wLtfbJFz3L16RdggRJoo7Vs4Bq37XW6uAVyAxQ6fIXz3waj5h71Yi2iQ8fH7hIE0eObB0o=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyEEPq6b6rEFJEV7l0P8MzH+eOC+qsrj5C0VKP2xo6oGivir5o
	hHbx1qHXIJTMwyrtCX4K/iv8r/mFs4x7+zIg3geMRT7c5CyQcs9XqB5SfJXriLTjru85vtwtkDn
	EOnUP5LWLMGTNYuLrkw==
X-Google-Smtp-Source: AGHT+IGN7sIoCCk3NlTPmMYAv3Z3q38BFYn7msCvXHPNFB6alJvoxsbzz2fZGF3mfwttj2Fs1vKU2gG3U3nXuTw=
X-Received: from wmdd5.prod.google.com ([2002:a05:600c:a205:b0:454:acb0:359a])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:5305:b0:453:d3d:d9fd with SMTP id 5b1f17b1804b1-454d531e49fmr17268565e9.12.1752058729385;
 Wed, 09 Jul 2025 03:58:49 -0700 (PDT)
Date: Wed, 9 Jul 2025 10:58:48 +0000
In-Reply-To: <8734b6oi20.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250704-iov-iter-v2-0-e69aa7c1f40e@google.com>
 <bzRIJnmP3zwPCPlJ4GG9diQ2CKzp-7bKbOIEHrtXVfmQ5ImkOBNAxI8wlg0jdrT4nzELpnE3rVzr6T7cJ3xVFg==@protonmail.internalid>
 <20250704-iov-iter-v2-2-e69aa7c1f40e@google.com> <8734b6oi20.fsf@kernel.org>
Message-ID: <aG5LaDgyv2dowPjL@google.com>
Subject: Re: [PATCH v2 2/4] rust: iov: add iov_iter abstractions for ITER_DEST
From: Alice Ryhl <aliceryhl@google.com>
To: Andreas Hindborg <a.hindborg@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Arnd Bergmann <arnd@arndb.de>, Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, 
	"=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Matthew Maurer <mmaurer@google.com>, Lee Jones <lee@kernel.org>, 
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	Benno Lossin <lossin@kernel.org>
Content-Type: text/plain; charset="utf-8"

On Tue, Jul 08, 2025 at 04:47:51PM +0200, Andreas Hindborg wrote:
> "Alice Ryhl" <aliceryhl@google.com> writes:
> 
> > This adds abstractions for the iov_iter type in the case where
> > data_source is ITER_DEST. This will make Rust implementations of
> > fops->read_iter possible.
> >
> > This series only has support for using existing IO vectors created by C
> > code. Additional abstractions will be needed to support the creation of
> > IO vectors in Rust code.
> >
> > These abstractions make the assumption that `struct iov_iter` does not
> > have internal self-references, which implies that it is valid to move it
> > between different local variables.
> >
> > Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> 
> Please see the comments on v1 [1].
> 
> Best regards,
> Andreas Hindborg
> 
> 
> [1] https://lore.kernel.org/all/439baec2-dba8-4dab-abb5-faa14fbda943@gmail.com

Sorry I should probably have articulated this somewhere. After I looked
at this code with fresh eyes, I realized that the only things the two
types have in common are len, advance, and revert. I didn't think that
attempting to deduplicate the logic was worth it.

Alice

