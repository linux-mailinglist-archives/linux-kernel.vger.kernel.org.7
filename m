Return-Path: <linux-kernel+bounces-853065-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B70CBDA91B
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 18:09:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E2AEB18A518B
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 16:09:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA4F630171A;
	Tue, 14 Oct 2025 16:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AAFGSV5A"
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99E153002C8
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 16:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760458154; cv=none; b=CpTYjOcKrDOoeGNJ8SwUhk5A4uzv6X2fxXknNdw8VB/Huknyro1EETA877zBocX7e0R4Gsj5pzrFCFQJDwjZ2FbzInYWJ9r3u2M0B8IQsLxDc//pGnt2v9h5sA4DW7u6x2MeHXqrEeZE7duIFFgG6BU4OG8DZP1tPKpN9AgXFYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760458154; c=relaxed/simple;
	bh=MyDZ+5xbfpDbRdcjNPPtRkhMLKRMmMRRRYNXyrRIfp0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hhsWCb0Kc/sFgIWtPlk0esft6oo5tjT5L34Q2RMGfZl7OCCs4Kj9eiTZ5ww1JpouDkQpiE+3rFrWUP4qUzv7HGn05xNJVnwOW4tVL7KpEhQZxE3FgLBNnzr4SkARxMBJsc7oUMIkN5F73104axP2SCAzN6xe+tDItIiBXuQaewI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AAFGSV5A; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-855733c47baso1068569185a.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 09:09:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760458151; x=1761062951; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=N4lRqPExRAyMWRp9Rfjmg4SkkmqlcZGNh8vWt5+XF28=;
        b=AAFGSV5A7gtxhBTm2GLz6kIfyMee2NNo+qC3TWlq/erdxS7U3zcNl+nZJDyzf/Wp9h
         vKzQul6e/lfjtDgqtngaFtoDZSDZtzKKSN/0DUdjFMJ3DGaJFmDIu72EswHd/cMD9c8y
         oLg7YBR0tWdVCHowsUe71bSy/Dn13vqyofgyiE0wffQcODRrT5W40tL3w22gwpq+Ylol
         XjgoxEq4moS3FyBK6YoW7Y+cRigs0126KMW6qpISoKqG2UOURzpEWiLeM+fbUYldhBF3
         6sS1gCwLTfTK96tfj6zGEi9uMJ4L/408x2yJv/mmXRiToXPNL8JGHz1mmtTcwB6KjHXe
         yz1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760458151; x=1761062951;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N4lRqPExRAyMWRp9Rfjmg4SkkmqlcZGNh8vWt5+XF28=;
        b=DUFJ973JK4RtX1coTpopAV6/uTIkBiL+c8EFAP0V0moJ2Bl2UShYPvaGuRwIi1bPeo
         BCKqSCpyDv10vfPpKqFbjFmIqe0RDpskYxi7UtUhTf4D6Ovkx4zWZDcX0Kn23GdN4FpH
         ZwQGi5hVX18vV9hEaJ84n0IVUmcK5U76Nv4xk1tmtIws80+OdV5JLR54GOcL2hONiYC0
         T+onhvFXlLGzSnoxPktnEk4e6IHnWukIJzr7TcKcCEPEOcxnOH2k5v8OgU6vaUA6kCUE
         Jva467Jklwmg/GYp9FBS/U2NuaTcvTRMxHpVkz55NFhVQGQWJTWw1nPktH2Ky5FJ0DHt
         YNZg==
X-Forwarded-Encrypted: i=1; AJvYcCUqVZfcyscAkDZLv4g6PG/vvpJxKLmoI2xogAIAuIZEnQbjna/GgK5C7MfBexNRTKhRyWNRBa2eUqDmnkE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwXHz3LbRRcelVBUaj2tmyGk0OjSuBSmRoqXcpdgtJodZ3hf4Z
	JfFH5LW2KMJxPreHXvKPmBpQftUr2IvlfRhiFMUsy6hYcyB5mkEhuyGaClLFsQ==
X-Gm-Gg: ASbGncv8IfZuFLOoIXOnZx+IasrznasZvWCwYm6GwG9So1pV/yFqRZrnLYMUatdqhCX
	rbuA6shFo/TzfgILy+tqWx8wEq6muD8vMdzuylrboa2QSYbnpzOLPtB/G7jKWYgCZL6b2gMrxet
	WYkiRcqvpB2ZJ2kHsJTfoEz8Eb7Phe42pk+2Ehl62/Eoo6kl+V9JhNwwwM8+Tw47PHLtZW9ZTcJ
	0BhmXGdJkaYpcZvwpj/Kvpm923DOPtE2/qyDBqyR44/r3uCQK6I6F856KhKnZUyqwDE4zpUFM+R
	i1lTZZijp0YS5ZM3C8Tizgek21XhAr6oV9sojOB2Gc3BMl0dAT3JyFPhyWuUXyOHehDsqXWRzVR
	3eXqHuUcn2KCIayguvbZhIpr/7tmQB5s4lgNKXLP4TZ06a3Bu
X-Google-Smtp-Source: AGHT+IEoehLXwqxEN/cc9TnKoWCH0/efz6jmoKuyzf/OPOzqS4tT8DPcYGiD2jioZTZbNhTh/I2HrA==
X-Received: by 2002:a05:620a:a515:b0:886:ea5d:9270 with SMTP id af79cd13be357-886ea5d939fmr1674523285a.72.1760458151266;
        Tue, 14 Oct 2025 09:09:11 -0700 (PDT)
Received: from localhost ([12.22.141.131])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8849f3d70easm1249358885a.12.2025.10.14.09.09.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 09:09:10 -0700 (PDT)
Date: Tue, 14 Oct 2025 12:09:09 -0400
From: Yury Norov <yury.norov@gmail.com>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
	Burak Emir <bqe@google.com>, Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org, patches@lists.linux.dev
Subject: Re: [PATCH] rust: bitmap: clean Rust 1.92.0 `unused_unsafe` warning
Message-ID: <aO51pV5WSmqnT4rL@yury>
References: <20251013001422.1168581-1-ojeda@kernel.org>
 <aOzET46lagm-p8go@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aOzET46lagm-p8go@google.com>

On Mon, Oct 13, 2025 at 09:20:15AM +0000, Alice Ryhl wrote:
> On Mon, Oct 13, 2025 at 02:14:22AM +0200, Miguel Ojeda wrote:
> > Starting with Rust 1.92.0 (expected 2025-12-11), Rust allows to safely
> > take the address of a union field [1][2]:
> > 
> >       CLIPPY L rust/kernel.o
> >     error: unnecessary `unsafe` block
> >        --> rust/kernel/bitmap.rs:169:13
> >         |
> >     169 |             unsafe { core::ptr::addr_of!(self.repr.bitmap) }
> >         |             ^^^^^^ unnecessary `unsafe` block
> >         |
> >         = note: `-D unused-unsafe` implied by `-D warnings`
> >         = help: to override `-D warnings` add `#[allow(unused_unsafe)]`
> > 
> >     error: unnecessary `unsafe` block
> >        --> rust/kernel/bitmap.rs:185:13
> >         |
> >     185 |             unsafe { core::ptr::addr_of_mut!(self.repr.bitmap) }
> >         |             ^^^^^^ unnecessary `unsafe` block
> > 
> > Thus allow both instances to clean the warning in newer compilers.
> > 
> > Link: https://github.com/rust-lang/rust/issues/141264 [1]
> > Link: https://github.com/rust-lang/rust/pull/141469 [2]
> > Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
> 
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>

Added in bitmap-for-next.

Thanks,
Yury

