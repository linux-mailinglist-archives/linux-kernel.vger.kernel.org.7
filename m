Return-Path: <linux-kernel+bounces-879877-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D59CFC244AF
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 10:56:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 539304F285A
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 09:56:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B040333755;
	Fri, 31 Oct 2025 09:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OnTHcybT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFAF8333732;
	Fri, 31 Oct 2025 09:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761904545; cv=none; b=IZfwWwqlrutQC9CY3V2Wip80s+kt1AlimVRsuh3cDKRKTiRPQdqfE2sTjcJDFvbI6tpxlJIyv/wKaBh0NEf78JlC5pz+YkM9fQbUcGpV61qbpNWbx0wlgGoD6F/0CED6Fdgrl8VlquUCWmi27SC7Hirho7KoSAaLZFnWfBUnRGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761904545; c=relaxed/simple;
	bh=BR+XILA1s8yJi6O33BYKvuM+NkzYfxTNO7+aD821Iew=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M7TUoo+tq53EoJTzEglapTBj/XuP09+FqDIJ5oQY+vqyOP0ssGHWLoiGFe8jIfzISaoMEUgGAOWBdmqekmr5iZPJgQshlGlwdrQdMKBb1SLkz83Ifb1HqIlSV4D8cSzAedxha+9OurC7+ryY69+6nMVs0ZzNnzRULnpzEV9J7jU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OnTHcybT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 659F4C4CEF8;
	Fri, 31 Oct 2025 09:55:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761904545;
	bh=BR+XILA1s8yJi6O33BYKvuM+NkzYfxTNO7+aD821Iew=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=OnTHcybTRn4KGQO4PVufk8E7HKd7cNebPY5AQpFbDKiB+JQeR9Kh/DBWcq2Q7GWra
	 HZVmgd7OymVZfmuWW83d/Cf13wRTJuGvN+S4Sc7LJ7+y4UbKRWjhGeITKexs3j3kYf
	 SXsgzIoTFWemOdnPpXUFmIwGk3QQvt48bKAFz1QnUZWqstTceosMnGUlUkQ7eI8xHW
	 NU/9zYSR+PellJKOZtxbbKGgr4w+8iS/TcwPZ4nrao7FoQd6tHi3TSe7LL75yqYXHL
	 8oKbJJhtbvYd+/YmBiDM1+nd3nMzy3ZftTciVEWAyIJHe9HpqKAJQOSL08YKwa2Z58
	 uEcpP8gVRxgZg==
Message-ID: <a8cf6c32-c270-43b7-998e-ab8558278621@kernel.org>
Date: Fri, 31 Oct 2025 10:55:40 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] rust: of: replace `core::mem::zeroed` with
 `pin_init::zeroed`
To: moritz.zielke@gmail.com
Cc: Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>,
 Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>, Benno Lossin <lossin@kernel.org>,
 devicetree@vger.kernel.org, rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20251031-zeroed-of-rs-v2-1-f89ff71e943e@gmail.com>
From: Danilo Krummrich <dakr@kernel.org>
Content-Language: en-US
In-Reply-To: <20251031-zeroed-of-rs-v2-1-f89ff71e943e@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/31/25 10:51 AM, Moritz Zielke via B4 Relay wrote:
> From: Moritz Zielke <moritz.zielke@gmail.com>
> 
> All types in `bindings` implement `Zeroable` if they can, so use
> `pin_init::zeroed` instead of relying on `unsafe` code.
> 
> If this ends up not compiling in the future, something in bindgen or on
> the C side changed and is most likely incorrect.
> 
> Link: https://github.com/Rust-for-Linux/linux/issues/1189
> Suggested-by: Benno Lossin <lossin@kernel.org>
> Signed-off-by: Moritz Zielke <moritz.zielke@gmail.com>

Reviewed-by: Danilo Krummrich <dakr@kernel.org>

