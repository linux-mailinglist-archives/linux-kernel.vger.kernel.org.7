Return-Path: <linux-kernel+bounces-768205-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9503BB25E33
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 10:00:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ECFD81CC17CA
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 07:58:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA3812E2DD0;
	Thu, 14 Aug 2025 07:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NVjK8kSu"
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6EAC2D63E0
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 07:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755158246; cv=none; b=NfkBfJE31chTAis77P2hv02hTpTpm/9CWQd17ErGhJ8ycXVA6qhYuBvYR7tsrIQ22ah4SLnuTQJhD3LPhndHk/L8u0g8mZF3wHDaZYJqZgxvqIUAylVwS0OpmtvchkFh8DTu8cEj7EztoLpQlBUgo7gz2doxKVsa5Dt2WcPhHUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755158246; c=relaxed/simple;
	bh=W6MtOrDogN544oWxAZb3pFnY2Fo2+9FpOpoTzPtH90E=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ab76ElsD5EW7M/7ok1mUTZP4tPDzt3k5zuIFkZrQnGT5zDYYcjxx1aGbiw1uxRsnVFThVfM+kG7BsQ/Gi1Jerl2uwCVsQAfQz8/4lTHGbpVXX+6lt8h6iz4JEC6NmA5eehrjOp13gafzIOh66VqBEF0CGw8o8IpoVQV5zfROXM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NVjK8kSu; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-3b9d41b88ffso287577f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 00:57:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755158243; x=1755763043; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iPHqnQ8xAazI/ywfiKc7DTnC7ionAOpO2TaL8wZxk98=;
        b=NVjK8kSu+B/fRF55yfnQoX6COqn6mjzaLoQWWKk27/+c2QRc8BV1Af+UsMjFhXjSkv
         rddfcTgiVIUThG2Dowboubu+jf7YSPhSwFxiNA00l7TokFM0URVgwgZDJj1XfqDWBpND
         5SeTzZPgG+eEyH/f04JrSuik2WbvekxRkUeUzrMelIrGElJf9pdyVyG3zV1m6gs85WAo
         cmT8dh5wGd0f34E/1reQhO6g8Pvd8uLv0M4xpt2nFEZhhOSW8CfyKS0PqhqzxnYyNfcS
         TCjZtPPwdlCysQNIO+CJl5ujyHj2eezveSaLwiRvmTWVfmeaU/CcyVH3OYhCKSbTF3NU
         D/fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755158243; x=1755763043;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=iPHqnQ8xAazI/ywfiKc7DTnC7ionAOpO2TaL8wZxk98=;
        b=TBc7tW49TJIMP4OWa3cfICfQgl+RWDxmpFq/mjvehcOT6ldoxUaIawAuDiETMdB/vq
         gYgQzYpoyIobg9fs6z/aoYPw7RmJok7IYiMBzPOb9glQfLjKgqdtFxXqVoNhVwWlWdnQ
         iuPvDkSl2ULYaXgsVqEoVKrVdEUt+myB2Gro1WbAmDMmFN6IfqQsz+lLe90qnHgeoctX
         bMvajy6Q2upHvAG/tQgFgaq7mFKgmNj9W3LXqKzGiuCBRwmXNF2IeMukHSbmijsvTXOY
         E+VkwUd9Hyjt5XIjGTvvOzEz46bhM5tlcL1/an5teFFDKWv9WV9Uf3DVpU2Xh3+bv7ek
         NPvQ==
X-Forwarded-Encrypted: i=1; AJvYcCUqYwoSFhwci1IagAX3Y1V4aKfCj/YDGLhzT0ahfJErA9baw62EiOlm2p0hYBpnoOoPy8RyDr3mUCNsSWs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx28x8njW0XzJYYcscSBwomitxO96IaRr35Dg5Niz8re8XEg6yq
	eT02XI89JNH/Bmaz+KjgGKzwD78W88J5rZTWH8wQZdHs9wAB/oeqjVGPcj3awRBvunOtn3ycwKo
	t0YQPQQKk1goQMHXk1Q==
X-Google-Smtp-Source: AGHT+IF8RLKUaVnA0eLlocCvsSggHMlTflVsZLjcx9Tqx3h5icjUoOZkCLvDvCHGu7338kKfEuuoa0VKz/yQfgc=
X-Received: from wmbea8.prod.google.com ([2002:a05:600c:6748:b0:459:ddb6:d66c])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:2410:b0:3b9:48f:1960 with SMTP id ffacd0b85a97d-3b9fc34d96amr1517515f8f.49.1755158243251;
 Thu, 14 Aug 2025 00:57:23 -0700 (PDT)
Date: Thu, 14 Aug 2025 07:57:22 +0000
In-Reply-To: <20250813133343.7877-1-benoit@dugarreau.fr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250813-iov-iter-v4-2-c4f1932b05ef@google.com> <20250813133343.7877-1-benoit@dugarreau.fr>
Message-ID: <aJ2W4kgJGJPItC9F@google.com>
Subject: Re: [PATCH v4 2/4] rust: iov: add iov_iter abstractions for ITER_DEST
From: Alice Ryhl <aliceryhl@google.com>
To: "=?utf-8?Q?Beno=C3=AEt?= du Garreau" <benoit@dugarreau.fr>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Arnd Bergmann <arnd@arndb.de>, Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, 
	"=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, Matthew Maurer <mmaurer@google.com>, 
	Lee Jones <lee@kernel.org>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, Benno Lossin <lossin@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 13, 2025 at 03:33:39PM +0200, Beno=C3=AEt du Garreau wrote:
> On Wed, 13 Aug 2025 08:27:18 +0000 Alice Ryhl <aliceryhl@google.com> wrot=
e:
>=20
> > +    /// Utility for implementing `read_iter` given the full contents o=
f the file.
> > +    ///
> > +    /// The full contents of the file being read from is represented b=
y `contents`. This call will
> > +    /// write the appropriate sub-slice of `contents` and update the f=
ile position in `ppos` so
> > +    /// that the file will appear to contain `contents` even if takes =
multiple reads to read the
> > +    /// entire file.
> > +    #[inline]
> > +    pub fn simple_read_from_buffer(&mut self, ppos: &mut i64, contents=
: &[u8]) -> Result<usize> {
> > +        if *ppos < 0 {
> > +            return Err(EINVAL);
> > +        }
> > +        let Ok(pos) =3D usize::try_from(*ppos) else {
> > +            return Ok(0);
> > +        };
> > +        if pos >=3D contents.len() {
> > +            return Ok(0);
> > +        }
> > +
> > +        // BOUNDS: We just checked that `pos < contents.len()` above.
> > +        let num_written =3D self.copy_to_iter(&contents[pos..]);
>=20
> This should use `contents.get(..pos)` instead of doing the bound check ma=
nually.

Using contents.get(pos..) does not have the same behavior as the bounds
check, because the bounds check exits early with Ok(0) if pos is equal
to contents.len(), whereas the proposed change would pass an empty array
to copy_to_iter.

Alice

