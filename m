Return-Path: <linux-kernel+bounces-785539-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12768B34CA0
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 22:49:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 502597A181D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 20:48:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 196BD28F935;
	Mon, 25 Aug 2025 20:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FUGMML64"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C1BEDDAB;
	Mon, 25 Aug 2025 20:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756154977; cv=none; b=eQc5o4BS070dsq16063SIPgdPBE5pob2snl7oVsRYyXfTZ/YCHNX1JOIoW5BcfysfRwWFYHBnWfNDHRgCvg3QtTx7i7mRh+0WM+XGUimZZpZqjsmx1wuOafJ+XvJXCKllCuwudQxuam/SGuCsPYLv/8lf09WaMMxbLtl5qmLND0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756154977; c=relaxed/simple;
	bh=lfQ3Sx0ChDYUCraVA7DOv+MmxiNhx8zbUKzH+AEUEYA=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=So0VSZaieEiGYhUyAfdl9i9C26B79JH/KVVwlpgQOxnkvfOsD+cwdE3gRf4AI0292CYYgmmpId0NxIOqywcFgo4eYN8q0V73HdqRLqMCIUdpxVXbRQkZpLCYY39yd4hBBcRJE3wO1gyuq0JMnMwQ2IgnXrmPu3mv8cau7Gk7ldc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FUGMML64; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30860C4CEED;
	Mon, 25 Aug 2025 20:49:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756154975;
	bh=lfQ3Sx0ChDYUCraVA7DOv+MmxiNhx8zbUKzH+AEUEYA=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=FUGMML64tNEXag+bV1SOBjlKU7UPDgtS2WtS/70r75bdfkZI3P62/8iZLJJkVL5Gn
	 sOXc7kAaNx3wKASAjcisGE3UHjZL2wsQKxH0x2b6fjHqE+y4bBL+ocVb6x8gt+O5+D
	 i1UXN3OivVflrV/X0y+SL4wuzpW+AzHxmGvNygOWJv/hGYuL0XPONspc1a2go6BRKt
	 ufKKOyRs4yGB0OWtoflT+E9ii7nc9YwC7djooPX/e4YZHZi6DMAgHU0MZd9yGqIspW
	 eaOVQTV+yJJxw50LC1h7B3ECyxEFN7adbxfeSZGOyvoJDgfxuN83/f1rA510H4Gj0P
	 YJT2XyK13+Pdw==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 25 Aug 2025 22:49:31 +0200
Message-Id: <DCBSZC9IDT4L.SPHF4KVM5KEW@kernel.org>
Subject: Re: [PATCH 1/2] rust: usb: add basic USB abstractions
From: "Benno Lossin" <lossin@kernel.org>
To: "Daniel Almeida" <daniel.almeida@collabora.com>, "Miguel Ojeda"
 <ojeda@kernel.org>, "Alex Gaynor" <alex.gaynor@gmail.com>, "Boqun Feng"
 <boqun.feng@gmail.com>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>,
 "Trevor Gross" <tmgross@umich.edu>, "Danilo Krummrich" <dakr@kernel.org>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc: <linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>,
 <linux-usb@vger.kernel.org>
X-Mailer: aerc 0.20.1
References: <20250825-b4-usb-v1-0-7aa024de7ae8@collabora.com>
 <20250825-b4-usb-v1-1-7aa024de7ae8@collabora.com>
In-Reply-To: <20250825-b4-usb-v1-1-7aa024de7ae8@collabora.com>

On Mon Aug 25, 2025 at 8:18 PM CEST, Daniel Almeida wrote:
> +impl DeviceId {
> +    /// Equivalent to C's `USB_DEVICE` macro.
> +    pub const fn from_id(vendor: u16, product: u16) -> Self {
> +        Self(bindings::usb_device_id {
> +            match_flags: bindings::USB_DEVICE_ID_MATCH_DEVICE as u16,
> +            idVendor: vendor,
> +            idProduct: product,
> +            // SAFETY: It is safe to use all zeroes for the other fields=
 of `usb_device_id`.
> +            ..unsafe { MaybeUninit::zeroed().assume_init() }

You can avoid this usage of `unsafe` with this patch series:

    https://lore.kernel.org/all/20250814093046.2071971-1-lossin@kernel.org

I'd like to avoid introducing any new one of these.

---
Cheers,
Benno

> +        })
> +    }

