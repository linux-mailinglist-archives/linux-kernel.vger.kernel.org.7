Return-Path: <linux-kernel+bounces-747000-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16C8DB12E16
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jul 2025 09:31:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E852174046
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jul 2025 07:31:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86E291DE4E7;
	Sun, 27 Jul 2025 07:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KszOIUdI"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F0C23B7A8
	for <linux-kernel@vger.kernel.org>; Sun, 27 Jul 2025 07:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753601488; cv=none; b=dh1mdJ3qRJZO/MfJzAYZIMdE1WOp/p9+qXSkTE93MA1s8bb+L6s4cZZ8ZzIGOX4oQP90t9b+K6SrCai1a+B4r0/aFnW/nGxxggFQtUrcyEMLL+bx4yAZfKMe/1BzlCK4Ds3igX3Sss+Prqy4MCfIiscpbol0Ey7ncIGkujON3Sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753601488; c=relaxed/simple;
	bh=rwL9Bk09x/8Ppe/AzcKq5fJru/j6uu466W/o2Hrf1wE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=nKGIy3DXkEGfZ6DaAT2x//xLXwxasWInG4puH7jh++pWCdivqetcHMMsbh6NpUxvl/EdjTHN2jjbI1Yj8n5uWdPcyoYSjkL3rirBPrYpMZyfOGIkTUTuTzUHqJjV3UnSm/wPjs/zf3+b5AVitVswQsOUE0hIeib7OBHw8mJXg+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KszOIUdI; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-45526e19f43so10549815e9.3
        for <linux-kernel@vger.kernel.org>; Sun, 27 Jul 2025 00:31:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753601485; x=1754206285; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=AxX4avwgBwqTzm5fHGJziIbRn6mR9uzlaZmjdSXJYJg=;
        b=KszOIUdIu4wQe4rRnWnym0taxGtPzuqMBEtxmAUrQBqpOLFRwCm6iA17udmR9/eCNA
         U0ClQjwtjz0MqdShncm8k/Y+yLfEiuISJSbr0BpAgPVCxjTzvn1/PECbWFzRkUK8lMB2
         iJaygkG+n2p7M/o+MvSyWenhzeCy6jR6tfM/vGnFa/3FsHtnM5pOteHLSLwYu4Rb+tIr
         zXJXaTksk0V732ER7hBJCBx6/K/3FrpNGJQsofk1SwQbeBrFCuz55n+DKpxSvGjrL1dZ
         PhUZn3TYH3k/BpAONVo52os9oOT97oHyILFz20MM7PWZqO3UDxbCBr7oW3mA/sgJVK/I
         Gizw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753601485; x=1754206285;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AxX4avwgBwqTzm5fHGJziIbRn6mR9uzlaZmjdSXJYJg=;
        b=qpCFCsoPOozr1QFLNrp58ag7SAOVQXNACp9kp7pmq581sy6E7tkRd9VZhpCxpmbjX7
         i5ABMyLEM6kVcwx+TuksrNVMZUX125FLIfw8rhu6oD/MMP25QCL3Xn4wQpSbxrfcUs71
         7gwme3vj6GurBxuGGny+IJPX3evyrnH5bgZN5rPOuxelBRCQkCIUmO6USrg8Jxftx4SX
         EJ1kAgKWzJKHOskHPX3T83+y3H3kpdM6WkmibuSKURNx5JEC41KthzEoiXp8UiOTumcP
         v8YwTKsxZrJJSi4p+8lqTnwxFrd23GmA+J2iyF0fRRJUgiojyvksyLlAN5EhfE708X8k
         Qwrw==
X-Forwarded-Encrypted: i=1; AJvYcCWgMmgjtQrWpnCjBwcO1YKunM5N2VErDANPs5rWqkzj2khJbUagNC6o7tpmzCnQbS90Tc1gJHiImNxHV80=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYG7TbP9zFJdXjDtLAQ5xwSx8mSO21H36wLifbRN6qu9a27pC+
	abMGeqedHgxJ27wJefp46VdvPzxHp428S8p8b+Qiv2l3jzpmAkt4BxdzqM+rHjLOqHYi7IfSyPE
	nyBhCbjzPV4LYUPHh5w==
X-Google-Smtp-Source: AGHT+IHJnQyPgGBAdAuHY14twQbuIYW9FbKEzdYh2FRGGOhbxVod/UkZzNkGo1gJhT+KQlcyNFV6MAoJMtkwnZc=
X-Received: from wmbez5.prod.google.com ([2002:a05:600c:83c5:b0:456:13a2:2e7e])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:4509:b0:456:285b:db29 with SMTP id 5b1f17b1804b1-4587c25c3a2mr29866255e9.29.1753601485755;
 Sun, 27 Jul 2025 00:31:25 -0700 (PDT)
Date: Sun, 27 Jul 2025 07:31:24 +0000
In-Reply-To: <20250724185700.557505-3-lyude@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250724185700.557505-1-lyude@redhat.com> <20250724185700.557505-3-lyude@redhat.com>
Message-ID: <aIXVzIwBDvY1ZVjL@google.com>
Subject: Re: [PATCH 2/2] rust: time: Implement basic arithmetic operations for Delta
From: Alice Ryhl <aliceryhl@google.com>
To: Lyude Paul <lyude@redhat.com>
Cc: rust-for-linux@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, 
	Boqun Feng <boqun.feng@gmail.com>, linux-kernel@vger.kernel.org, 
	Andreas Hindborg <a.hindborg@kernel.org>, FUJITA Tomonori <fujita.tomonori@gmail.com>, 
	Frederic Weisbecker <frederic@kernel.org>, Anna-Maria Behnsen <anna-maria@linutronix.de>, 
	John Stultz <jstultz@google.com>, Stephen Boyd <sboyd@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>
Content-Type: text/plain; charset="utf-8"

On Thu, Jul 24, 2025 at 02:54:07PM -0400, Lyude Paul wrote:
> While rvkms is only going to be using a few of these, since Deltas are
> basically the same as i64 it's easy enough to just implement all of the
> basic arithmetic operations for Delta types.
> 
> Note that for division and remainders, we currently limit these operations
> to CONFIG_64BIT as u64 / u64 and u64 % u64 is not supported on all 32 bit
> platforms natively. The correct solution we want to aim for here in the
> future is to use the kernel's math library for performing these operations
> so they're emulated on 32 bit platforms.

The CONFIG_64BIT restriction seems annoying. Could we not support 32-bit
from the get-go? Where is this going to be used?

After all, we have stuff like this:
https://lore.kernel.org/r/20250724165441.2105632-1-ojeda@kernel.org

> +impl ops::Mul for Delta {
> +    type Output = Self;
> +
> +    fn mul(self, rhs: Self) -> Self::Output {
> +        Self {
> +            nanos: self.nanos * rhs.nanos,
> +        }
> +    }
> +}
> +
> +impl ops::MulAssign for Delta {
> +    fn mul_assign(&mut self, rhs: Self) {
> +        self.nanos *= rhs.nanos;
> +    }
> +}

The units here do not make sense. I would not add multiplication of
Delta*Delta. It makes sense to have Delta*int, but it does not make
sense to multiply two Deltas together.

I would change the second type for both multiplication operators to be a
normal integer.

> +// TODO: When we get support for u64/u64 division and remainders helpers remove this, until then
> +// these ops only work on 64bit platforms.
> +#[cfg(CONFIG_64BIT)]
> +impl ops::Div for Delta {
> +    type Output = Self;
> +
> +    fn div(self, rhs: Self) -> Self::Output {
> +        Self {
> +            nanos: self.nanos / rhs.nanos,
> +        }
> +    }
> +}
> +
> +#[cfg(CONFIG_64BIT)]
> +impl ops::DivAssign for Delta {
> +    fn div_assign(&mut self, rhs: Self) {
> +        self.nanos /= rhs.nanos;
> +    }
> +}

Same here. The units don't work. If you divide two deltas by each other,
the correct unit is to return a kind of integer, not another Delta.

I would change Div to have an integer type as output and get rid of
DivAssign.

> +#[cfg(CONFIG_64BIT)]
> +impl ops::Rem for Delta {
> +    type Output = Self;
> +
> +    fn rem(self, rhs: Self) -> Self::Output {
> +        Self {
> +            nanos: self.nanos % rhs.nanos,
> +        }
> +    }
> +}
> +
> +#[cfg(CONFIG_64BIT)]
> +impl ops::RemAssign for Delta {
> +    fn rem_assign(&mut self, rhs: Self) {
> +        self.nanos %= rhs.nanos;
> +    }
> +}

The units here do make sense, so these are fine.

Alice

