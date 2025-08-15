Return-Path: <linux-kernel+bounces-771318-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2448B28576
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 20:02:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CEFAAA8A6D
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 18:01:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF3BB225A35;
	Fri, 15 Aug 2025 18:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SjvNWJqE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 131023176EB;
	Fri, 15 Aug 2025 18:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755280912; cv=none; b=qpeMe0j+fhHJjwUxZJ6PXROhcD+6ChOxI5kY7BKLtp1gHg1O38TQ/znJ3NvgCC1HA7DcoF6czPmEyca1RhkTiZ4u1xwxjcvOBuMfNuk5oiwbUtpJS+6GdUwZl2VX5Ic6uLPyAMLK/xXJJGWt2GbQ7PR5zUkByCe/WYPclmWxtHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755280912; c=relaxed/simple;
	bh=AFyYB0wpVMm3e8zRTQY3fAP9SvqL9JqCgXTigHPqAqY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ADws9/9cesV09/TFp6LSNLrQE836zUsb2JStMAjnJSXtEGbLFPJIpfS8rb6dLulnOoV4acSiID1R3A1q4B3C75lA+riAFzkWIj1Md7LisrlsAsCibJiy4CPTopp14kCeBK6RkfgUpz/kXFs3EgRDpOQpCksgSDO+aisDLlBpkok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SjvNWJqE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99146C4CEEB;
	Fri, 15 Aug 2025 18:01:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755280911;
	bh=AFyYB0wpVMm3e8zRTQY3fAP9SvqL9JqCgXTigHPqAqY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=SjvNWJqE1dQmWUGZQGKJfIYZi8bWmh8qxwH+Hotz+VSBwrfLVcXOSy3IfKm0z+6O5
	 Iz1mY7X1zO7NHlou5+U6l6cEqgrDJE1CuqW8eVgMjH9metAhf1nKQGKchvCMfTxYTW
	 lgeSWLdabq8OMCWbAn5cmdS+IncPxe+96kpXzxLYT1UI6CZ558RMgBwj3+0H0nLirh
	 b9C1o3jvTfoefycOGsYle14WOOPaikn4x2GbIhHecF2lj8tdKieT4o6x2hSMi7UzDr
	 r/77nJr5IkLasMpJ4DWeHHzmGVJANwnE0FGnklUkg8icNO+kW6GNDEBpHSGLy+JFut
	 x4cCjTZ7DLcBA==
Message-ID: <b45acdf6-045c-4bec-972b-cfc11c77e87d@kernel.org>
Date: Fri, 15 Aug 2025 20:01:47 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/3] rust: make various `alloc` functions `const fn`
To: =?UTF-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>
Cc: rust-for-linux@vger.kernel.org, ojeda@kernel.org, alex.gaynor@gmail.com,
 boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com,
 lossin@kernel.org, a.hindborg@kernel.org, aliceryhl@google.com,
 tmgross@umich.edu, linux-kernel@vger.kernel.org
References: <20250720094838.29530-1-work@onurozkan.dev>
From: Danilo Krummrich <dakr@kernel.org>
Content-Language: en-US
In-Reply-To: <20250720094838.29530-1-work@onurozkan.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 7/20/25 11:48 AM, Onur Özkan wrote:
>    rust: make `allocator::aligned_size` a `const fn`

I dropped this patch, since it would conflict with [1].

>    rust: make `ArrayLayout::new_unchecked` a `const fn`
>    rust: make `kvec::Vec` functions `const fn`

Applied to alloc-next, thanks!

[1] https://lore.kernel.org/all/20250731154919.4132-2-dakr@kernel.org/

