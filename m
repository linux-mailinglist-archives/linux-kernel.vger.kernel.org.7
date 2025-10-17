Return-Path: <linux-kernel+bounces-857925-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 92CFABE841D
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 13:11:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2A6BB4E52E8
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 11:11:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5D7933CEA8;
	Fri, 17 Oct 2025 11:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lmDcMGPJ"
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 791BC33CE8D
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 11:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760699474; cv=none; b=hbBiTvgqddMd9pVt7wVFkYWM9uiOro4wJqdIynyYSqGjfjaWUJZkrZke6YWj0IavAYTF/Dc+7ZDtvY/RwSqV0NO0UVqN99yY/C/bAP5R9Cia7aZ4vvyiYpluWaGzAY7Z9nccUmxZJYYFsc1VURx5QTJrcJiylSylsbqHan52jks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760699474; c=relaxed/simple;
	bh=MhZSD4MoKQuIdmvJLptvhaWaCOk0x2r/AtANTi0X07M=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=n7eK2iRc5vjCZi7ThOB2LUhjD3lyESVsNtoPIC5F9TFk4TET9Qhm+omlmyvgTXLSC/8r+EOHSBofHXGJJKEAN0o8GTuBsxc1vCFJ5GR+LxemUKXcRmQwXUA6Sr20Qeu3aU+KSW0vhAk+Emf+vwkcGq72XOKWYNepda33QV4N9UU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lmDcMGPJ; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-4270848ceffso575061f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 04:11:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760699471; x=1761304271; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=i2wzK6MiosI9/ERAVMVfGUCr8MWHBxLmt48MiuCJv8g=;
        b=lmDcMGPJEblBIjiFQ4SqKsYaWNOqQUYi1CXR8L/6uElRcQR+9C2NOEHJv6BC8D0cqK
         aXx7tZb6X+bMZ09gqnfhx7ZAntKRK/QLvsT/N8/kjxFAHFdZKkZ910/edYyrggU9RdIb
         PfMUApfOYzPI6Yc/46E4H3+fvJAv4k8jpb92VVr6ioRMzVnPw4ALPzLxL1cnO3dD1v1v
         UxAG3wBSsght6vQYY66pE+NADy0duvEQSAxsuJ9PVPf1I1ggnAvT/VLWMnpu5JcydSoo
         +hsab8Ik7ZM0zZfqwiRbD52O+J0GFQU67s5tFnLCbCaWnIC9WhomWnmACR1NJ88YDqRW
         7oug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760699471; x=1761304271;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i2wzK6MiosI9/ERAVMVfGUCr8MWHBxLmt48MiuCJv8g=;
        b=VR6xrM27HMTyLRsd39EUHQIqjbX2JRHgEGYqKiwYGiqyRxloLK3c6sX4j8jkDHp4QK
         0zUBddN5YWQCRrr4KFcUI0QomVc9U0YF8lVjks7AhyLu0V/xv6A+32/04lJZAc6PXq8P
         w2w9Cpv4z9/blk5llGRF5kqnkIpHEAAmZfpUKyl1GX3gV5YzI+AIXOcLmj9SJj432lrM
         kA5b/u72ui4yYwFPuQVOl9QaohnMt6FZDUwP5jyKzc63NAVARVI8PMkV1Byp0kMTXrel
         YzCtMgEp4FT+FuteA0TvkSRKx+NpYytOkJ/+TSJUDQ4ToZ7+C8QGDPJMEGJ0bp+/VEBX
         a0sA==
X-Forwarded-Encrypted: i=1; AJvYcCXq6/3UJL7KpbDNTlGVq14lmYNrRhQXFytr6/SauFwxGB669JbjYZgie3W+er8/z5pgXPzqqQMIcyJZ3O0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwH/Ul6iQB35+nnzSY7oPwW+4FiE3nkjkkTa3qKwNhqzTIMmZxy
	5Ur3U1cr+ZURZgCoPT7KDpZW3QI4yzfDO6qDhJQuXKCxB/lTDcdEegHzNZQs9B8tVgoJ5iepqtR
	PJ3tZXAMTLYb/cmDdAA==
X-Google-Smtp-Source: AGHT+IHYFyQyj1kLDpdNGuhEdH6AEjt4MzESRGh/PCle0M85/6aN3reSFKPj5aDv/9IoZZ+HFF5idXBzSlPyeVo=
X-Received: from wmbg27.prod.google.com ([2002:a05:600c:a41b:b0:46c:db55:f87])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:2911:b0:426:ffaa:8e9c with SMTP id ffacd0b85a97d-42704d83d30mr2587924f8f.13.1760699470868;
 Fri, 17 Oct 2025 04:11:10 -0700 (PDT)
Date: Fri, 17 Oct 2025 11:11:10 +0000
In-Reply-To: <20251003222729.322059-2-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251003222729.322059-1-dakr@kernel.org> <20251003222729.322059-2-dakr@kernel.org>
Message-ID: <aPIkTuGpR7VX_HoD@google.com>
Subject: Re: [PATCH 1/7] rust: uaccess: add UserSliceReader::read_slice_partial()
From: Alice Ryhl <aliceryhl@google.com>
To: Danilo Krummrich <dakr@kernel.org>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, ojeda@kernel.org, 
	alex.gaynor@gmail.com, boqun.feng@gmail.com, gary@garyguo.net, 
	bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org, 
	tmgross@umich.edu, mmaurer@google.com, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Sat, Oct 04, 2025 at 12:26:38AM +0200, Danilo Krummrich wrote:
> The existing read_slice() method is a wrapper around copy_from_user()
> and expects the user buffer to be larger than the destination buffer.
> 
> However, userspace may split up writes in multiple partial operations
> providing an offset into the destination buffer and a smaller user
> buffer.
> 
> In order to support this common case, provide a helper for partial
> reads.
> 
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> ---
>  rust/kernel/uaccess.rs | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/rust/kernel/uaccess.rs b/rust/kernel/uaccess.rs
> index a8fb4764185a..1b0b57e855c9 100644
> --- a/rust/kernel/uaccess.rs
> +++ b/rust/kernel/uaccess.rs
> @@ -287,6 +287,19 @@ pub fn read_slice(&mut self, out: &mut [u8]) -> Result {
>          self.read_raw(out)
>      }
>  
> +    /// Reads raw data from the user slice into a kernel buffer partially.
> +    ///
> +    /// This is the same as [`Self::read_slice`] but considers the given `offset` into `out` and
> +    /// truncates the read to the boundaries of `self` and `out`.
> +    ///
> +    /// On success, returns the number of bytes read.
> +    pub fn read_slice_partial(&mut self, out: &mut [u8], offset: usize) -> Result<usize> {
> +        let end = offset.checked_add(self.len()).ok_or(EINVAL)?.min(out.len());

Should this be?
let end = offset.checked_add(self.len()).unwrap_or(out.len()).min(out.len());

> +        out.get_mut(offset..end)
> +            .map_or(Ok(0), |dst| self.read_slice(dst).map(|()| dst.len()))

So if out.len() < offset, then we return Ok(0)?

Alice

