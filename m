Return-Path: <linux-kernel+bounces-766636-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E4123B24950
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 14:16:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D03F1880413
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 12:16:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 194183D3B3;
	Wed, 13 Aug 2025 12:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XbTwTFmm"
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31F8922301
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 12:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755087376; cv=none; b=Ua15RfpRILVdUgwNw93fZiTztknaFE40txjc6rp8JNus0ztzBvDuMaV9smzNtyuKBPOkxD3d3sb20tNeN1qB3bNhRbPIadSkuxHs0LHb/Uep5uExVnNx95AbwW0a6sG7WS6dM5Rb1ctSw2SLQq0k09rw5uDYlPSLjgAslZRXGyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755087376; c=relaxed/simple;
	bh=KTxhxErkoGgk/leFb1vBfn7BgYRjz8Airvmxh2BK/so=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=nLPrEX0LAjLgIDJTfQ7ZO3P2OHWBPuXIHNZfLh8sVVXEiWTGVOyQ7j3W+jXyfnWN0wOgZN7vCLHf7EP3yox7gmEnY1jnkPo0+CtS7uE5yhGq8mzCcOXogRR0PYLHm81hw8G/qHUFaE9qIQoXsTbFsjZqXJUcM2QFtELIaTuq3cM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XbTwTFmm; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-3b783265641so1342809f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 05:16:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755087372; x=1755692172; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=aAcPy6OOvaDLuQladKA+UxyQehpIidG6jH1BCeWHQN8=;
        b=XbTwTFmmbHI5J3agCyaBGjc5d4WYnjRRJtHLO3V0bI95ko4skDPrXR5L7dhz3qoccV
         JUfcsuB8TldH0d0cRTa5Stg/iVeStSAHanr9Vk06QxUynCxt8HtWLnzl8j0PwplaefTx
         fqe/7VjNgySAV/HcVD2fkuu/DLbkZ9sZJg875Q0gEEFTMe92PBGYc+I3n3BMvkmtwWvw
         q7nyuz2dL/fUUz8giOxHvkusFWCpi8UtJEwIR3CV+oKJvsGLeumcGMf9s1qKfQj7ltyi
         UdPeZY/KhWyiVoBKlaRnTPfjL8ArmkQW+JupUE07rJ3FqUXFvvHEEBF4Ws0sw8gIUjwW
         NZzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755087372; x=1755692172;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aAcPy6OOvaDLuQladKA+UxyQehpIidG6jH1BCeWHQN8=;
        b=PjWQDsK254KcTJUJ0R8cz9wkoIVxi5AgNK4hdmbvFbKEgSSy6vUZKLik4g4F8GMy1N
         fzFYz8uRiILZgown/jWWjApHaVOvDHrr+5a1OO6aTEClKn1/mD0ISPfqymabYRZoCmD6
         4yjDaaKJVqaueEFFtXS6Cx4a8wLusbw9ZsBt88FlpvuxRRHovZcMktrPhD5CN/uFknek
         EBweHiBW1e9W2vGQ9wx11flxUJxFOq/19/DSeoZAmyoW+oYXTkk932vTkBJyJiuuxtqQ
         2Vi946TQAot9SNPYnUx6pbyeC6+KQd+Bx5gXMB86xgTxbDytbIcled+tCGpSa3dZ1RUn
         VK/w==
X-Forwarded-Encrypted: i=1; AJvYcCWOZpqF6e1DiqYdCTs+LbaW4w4XJ22RN0W7BMoqi7W+8qRrku1S0/dSSt28DMcXwod3LhZHnMBLh3PmB+4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwScdNRo1oZ3w6uSokO9wpuQaV6LwuZllHRCIqmg+bvzTE8IF2J
	fSKPwfuCEfLXZMpmfjWj0NIFx90lv2zaGK7La5FFsDnyeSGFslBZV8s51stDoJPw3ao+j4xWru4
	TdKqukRcryzjqRtsecA==
X-Google-Smtp-Source: AGHT+IHQ0m8F2SjtH5Qg/7q2hHM6FptOekHUq3DOw5fmB7MUe0ubMRTJVwa0W90hEX/2RnQENQYYs5PVkQXrucY=
X-Received: from wrbed6.prod.google.com ([2002:a05:6000:20c6:b0:3b7:84f0:22c7])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:238a:b0:3b9:53c:24a4 with SMTP id ffacd0b85a97d-3b917eb4a14mr2231295f8f.39.1755087372444;
 Wed, 13 Aug 2025 05:16:12 -0700 (PDT)
Date: Wed, 13 Aug 2025 12:16:11 +0000
In-Reply-To: <DC19IMWVL93E.S1AO2KPXB3HU@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250813-iov-iter-v4-0-c4f1932b05ef@google.com>
 <20250813-iov-iter-v4-1-c4f1932b05ef@google.com> <DC19IMWVL93E.S1AO2KPXB3HU@kernel.org>
Message-ID: <aJyCC9E1kr4onwJ3@google.com>
Subject: Re: [PATCH v4 1/4] rust: iov: add iov_iter abstractions for ITER_SOURCE
From: Alice Ryhl <aliceryhl@google.com>
To: Danilo Krummrich <dakr@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Arnd Bergmann <arnd@arndb.de>, Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, 
	"=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Matthew Maurer <mmaurer@google.com>, Lee Jones <lee@kernel.org>, 
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	Benno Lossin <lossin@kernel.org>
Content-Type: text/plain; charset="utf-8"

On Wed, Aug 13, 2025 at 01:27:41PM +0200, Danilo Krummrich wrote:
> On Wed Aug 13, 2025 at 10:27 AM CEST, Alice Ryhl wrote:
> > +    /// Read data from this IO vector and append it to a vector.
> > +    ///
> > +    /// Returns the number of bytes that have been copied.
> > +    #[inline]
> > +    pub fn copy_from_iter_vec<A: Allocator>(
> > +        &mut self,
> > +        out: &mut Vec<u8, A>,
> > +        flags: Flags,
> > +    ) -> Result<usize> {
> > +        out.reserve(self.len(), flags)?;
> > +        let len = self.copy_from_iter_raw(out.spare_capacity_mut()).len();
> > +        // SAFETY: `Self::copy_from_iter_raw` guarantees that the first `len` bytes of the spare
> > +        // capacity have been initialized.
> 
> Technically, this covers the safety requirements from inc_len(). However, do we
> want to provide a list of justifications if the unsafe functions has a list of
> requirements, such that they are easier to match?

I will reword to:

// SAFETY:
// - `len` is the length of a subslice of the spare capacity, so `len`
//   is at most the length of the spare capacity.
// - `Self::copy_from_iter_raw` guarantees that the first `len` bytes of
//   the spare capacity have been initialized.

Ok?

> > +        unsafe { out.inc_len(len) };
> > +        Ok(len)
> > +    }
> 
> Either way,
> 
> Reviewed-by: Danilo Krummrich <dakr@kernel.org>

Thanks!

Alice

