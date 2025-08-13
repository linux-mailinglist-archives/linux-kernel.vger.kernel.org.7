Return-Path: <linux-kernel+bounces-766240-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63017B24440
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 10:26:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 248D53A8BE3
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 08:24:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 368AB2ECEBD;
	Wed, 13 Aug 2025 08:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Y+9B8ZRY"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F1CA2D8382
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 08:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755073468; cv=none; b=iri6WH3PaVwe91SVpBiVQqPvFHzPhLUddWBjFu0HvQynGnJJOHvvx/+/MBRMoNHafiZ1NvRJpluiwYN+9Rz4l0LrvgQ9wmJxAhW8omY81NqjeEi9aluPOn3Kl4fnQC9l/eJ0kmCk7iiPzi7JUp8AC4bu4ktVZWVhMnZGwBZrM6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755073468; c=relaxed/simple;
	bh=i7q6cu4XOofJpPaygp+2HmHMBYvZuvOZRgvH9TX/sCA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mLh1co13DFBGftQ3Ar1T/84MJrWHLgNrMRGUsfhT3IoSFBwwQVqsbiQOdOm7I/SviJ16Vwi/An5cZwYh2FLROAHgP4PhXE2qJIgnQUep3BAoCQv8khHir1HhHvqymYvYTXhmlzWQ+683CK6U7Jq728iQ1ufDVf6EMS/6kG8Jw6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Y+9B8ZRY; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3b78b2c6ecfso3363736f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 01:24:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755073465; x=1755678265; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j36Wt2d1lcdfM4qMmSBsoKx8o0T/CsoyesZWxgamGL8=;
        b=Y+9B8ZRYLT/LKQm7fSfdHyyHSbWoIpIx4/0+X63tmrj0EwmgPjpeTaDixHbPtKSUbD
         GSgk+jJDpySj7jousX3IT7j9bMezBv9ubwAAz0ZQ7ZnJ9RUFLzDXdrhCsLPeaeZZ8j8A
         IWhlag8AUXpgR3sehbL+rzLpHHwIP2NGhQGSl5B1JqQzg/yFsv7OGoEFSsJY1yHG+YRO
         uSu6pAwAejbkUhUlHo2bTZx5YgwtacVUerSffuGpCQW14WXZBlb5h81u94mE7wkUmwvn
         /RrbnZztNMHAuEc66rCev58tRMFnnXzVGsWShBfCJnABwT7kqy8wxCRlpEDn2yeA6o/J
         xKxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755073465; x=1755678265;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j36Wt2d1lcdfM4qMmSBsoKx8o0T/CsoyesZWxgamGL8=;
        b=VzW8l+nPB0mbeqrYYkB28IxYG4bMOGXUzdbhTJk1jqra8djKuKjJ8uCJ0FQkqYjAVk
         JGmwV7vSBv8qPzdk6zpWjpgnJOrrghmX1eniLTPhv6biAxLZ4kKO1NyxJRdW1Q2HliNF
         QdNhCkp9Y4FiOaMIdr5RU/N240AtYuPVhpvO2/Gid09/6A/E7PM+HOAnZWnMqorrjZYg
         JSLnGRs6CwY1OJvGB51+djno5Kub+nr1beH4BGii02kbFWbOl7ziWRCjO9PZkj608jv0
         GN/XiU1oA9k+QX/96HpnOSgH2div0a9hp4DKqlrtbxk7D6DhU+WQEk8Bx4dfd2K4dL/b
         QPvQ==
X-Forwarded-Encrypted: i=1; AJvYcCXMMHMbcwFpOyTNU/0YUVLlKq59HmJ6giqGT/w0zAvvIYaSeFKwOItL1oUQJzL2fPl2ZM6SbTKLjtVc51I=@vger.kernel.org
X-Gm-Message-State: AOJu0YykmP7UjWPqMomDUjz/VwhsgQ7ZCQCxapcHHrztfDZYJeE/yFMH
	QUFldsXRgKafd18nXKXYJFqQ08W36mOKOSJ8E2W39e4RTZ6wwQBUAzZJKenxuC9kAT/5QxP7EoS
	ZvTOiT9FAXgVrWcObcwnkf+KLbweI5STDWvGI7Vzn
X-Gm-Gg: ASbGncseHgENXCLf5EH/RGxDLYFAS4viMmLllDC4bLSFwqrD6EjVf9YJzuuwNL1yZiV
	GEZ/C5jbv7ETlidV7VWnNf7jrf9xF/gtMlrtjW0L8gypSc1Vj+izA6YOuTQgK76bSFvbHOHOA3v
	x9Qh5FUyuGGc5RXK3obXfnyBadpCK/+2UvyiAkfu/Eg6DXvWOUpNdyho+z6nu/VJ0AGw/bvMcCv
	yX9mjWhl8tYKVA7CI0bazvytfPY93CXjHkFOw==
X-Google-Smtp-Source: AGHT+IEQTBj4vbtzEEQ6lxltaO/FqbXF7A9ORef0fFY6z6R00Et5UkVsjPhHS6jo/ghAMR6v/ylRnCX7wGQtfB7kXBU=
X-Received: by 2002:a5d:5d10:0:b0:3b9:1457:df79 with SMTP id
 ffacd0b85a97d-3b917d1e6b2mr1381034f8f.5.1755073465088; Wed, 13 Aug 2025
 01:24:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250722-iov-iter-v3-0-3efc9c2c2893@google.com>
 <IMil7T48wWl_KirFiwKV5bNm7TuVsFNPEX3_6CJWEzwQ6n4jaVn943ujBotHAettCFL5Slnb0v_3Cz50enMdqw==@protonmail.internalid>
 <20250722-iov-iter-v3-1-3efc9c2c2893@google.com> <871ppq9fve.fsf@kernel.org>
In-Reply-To: <871ppq9fve.fsf@kernel.org>
From: Alice Ryhl <aliceryhl@google.com>
Date: Wed, 13 Aug 2025 10:24:13 +0200
X-Gm-Features: Ac12FXyZHCu-I22etoYCjoFadSFqXkK4cOQ639JdLkpUnt1K4hiGXS3NmFf7rkc
Message-ID: <CAH5fLghb_YoZgNGGJOa1aLA3bM=tyZKziDwyUqnVPHMg8NW4CQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] rust: iov: add iov_iter abstractions for ITER_SOURCE
To: Andreas Hindborg <a.hindborg@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Arnd Bergmann <arnd@arndb.de>, Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, Matthew Maurer <mmaurer@google.com>, 
	Lee Jones <lee@kernel.org>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, Benno Lossin <lossin@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 5, 2025 at 1:18=E2=80=AFPM Andreas Hindborg <a.hindborg@kernel.=
org> wrote:
> > +
> > +    /// Advance this IO vector backwards by `bytes` bytes.
> > +    ///
> > +    /// # Safety
> > +    ///
> > +    /// The IO vector must not be reverted to before its beginning.
> > +    #[inline]
> > +    pub unsafe fn revert(&mut self, bytes: usize) {
> > +        // SAFETY: By the struct invariants, `self.iov` is a valid IO =
vector, and `bytes` is in
> > +        // bounds.
>
> "... and by method safety requirements `bytes` is in bounds", right?

Will reword.

> > +        unsafe { bindings::iov_iter_revert(self.as_raw(), bytes) };
> > +    }
> > +
> > +    /// Read data from this IO vector.
> > +    ///
> > +    /// Returns the number of bytes that have been copied.
> > +    #[inline]
> > +    pub fn copy_from_iter(&mut self, out: &mut [u8]) -> usize {
> > +        // SAFETY: `Self::copy_from_iter_raw` guarantees that it will =
not deinitialize any bytes in
> > +        // the provided buffer, so `out` is still a valid `u8` slice a=
fter this call.
>
> I am curious if there is a particular reason you chose "deinitialize"
> over "write uninitialized" for the wording throughout this patch? It's
> an unfamiliar phrasing to me.

I've seen it a fair number of times, but I'll change it to less niche wordi=
ng.

Alice

