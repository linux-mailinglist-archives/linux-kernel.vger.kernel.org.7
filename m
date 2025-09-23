Return-Path: <linux-kernel+bounces-829195-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 372B8B967F8
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 17:06:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E614B7AA9CF
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 15:05:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA26B257842;
	Tue, 23 Sep 2025 15:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pKm4CGEm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15DFB22256B;
	Tue, 23 Sep 2025 15:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758639995; cv=none; b=iU6ds6tFhtIc3EfOeU8ZLVp1dmsYcc4sl/Pwj4C8+JsjLGg4zKwGl2/axvmLzb/eoBRnDwwu9G10qCkaFmjluExf3u+EEP8HKBq0HWAz4ru/E6UG9kiic6XxGtGb+nOrIPK6kNMNJ9Q0W/Hzut0uswowQAoz9ILJp6xuhtCoGfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758639995; c=relaxed/simple;
	bh=shE+6KLqFrMwrq0kg7jJcjUywO7EcJdZUSm6LuhUiBA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ej3QIgKDFpvkN/nQHfBl5x/CgAN3TlnSQJZ3wEi/1qPNoFizALz+lvfRZlwwpTBxCXhJf4gVoYUgLz3ZONjdqzKI6eHbQCclpUpOAm+/0vB85NPT+ZJtqudQoA5fzFQCFucdlqW9WwCO40CUbzqZJ3R6xVy3hsiVXsgP/riZjbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pKm4CGEm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E646CC4CEF5;
	Tue, 23 Sep 2025 15:06:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758639994;
	bh=shE+6KLqFrMwrq0kg7jJcjUywO7EcJdZUSm6LuhUiBA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=pKm4CGEma9kMbnKbA2/d6o/IWJruByochbPJgIGb2r1HCftLX2j75GyJY7YFjrBWx
	 osd15tv76Ok9MO/zXhWOKpguJaP+1UC7lPtL3YVX/NAlf54hzGXPDUuD7epRSAyY3t
	 z6lkOFY3YyFwpdKcr+b9z/lSlCr/zGLm8MOQAxxXa4T4gB6r92CzFHlW3DhlGniFkD
	 ElFsJlsUWzoMae23/DX5Xz9x2FtvrwAHyeZC3cLSR7FPxdsxwJMH4khiDWiD3siPfL
	 17ntNOtglGwQ4K7h6kh7qU+WHZCZsPrAQ425sFL2GNYA2+vDETHtmIn34IOZwC7/jq
	 1wBdsvRUJ7bRw==
Message-ID: <96c45391-e6e3-4972-b8ec-b611be655624@kernel.org>
Date: Tue, 23 Sep 2025 17:06:30 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] rust: usb: add basic USB abstractions
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Daniel Almeida <daniel.almeida@collabora.com>,
 Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
 linux-usb@vger.kernel.org
References: <20250825-b4-usb-v1-0-7aa024de7ae8@collabora.com>
 <20250825-b4-usb-v1-1-7aa024de7ae8@collabora.com>
 <DD07LUJXNZN9.3RHH9NJNRFVNN@kernel.org>
 <27AB9C59-BAE6-4F1F-8638-DF9244D0A616@collabora.com>
 <DD08HWM0M68R.2R74OSODBIWSZ@kernel.org>
 <2025092326-banked-resubmit-67c0@gregkh>
 <DD0994IZMBVQ.2HZOA2ZMWT2I@kernel.org>
 <2025092344-vacation-envelope-f0cf@gregkh>
From: Danilo Krummrich <dakr@kernel.org>
Content-Language: en-US
In-Reply-To: <2025092344-vacation-envelope-f0cf@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/23/25 4:52 PM, Greg Kroah-Hartman wrote:
>> Having a &usb::Device<Bound> would mean that for the lifetime of the reference
>> it is guaranteed that the usb::Device is bound to its USB device driver
>> (struct usb_device_driver).
> 
> Wait, usb_device_driver shouldn't be used here, that's only for
> "special" things like hubs and an odd Apple device.

I only mentioned it because if a struct usb_device is bound, then it is bound to
a struct usb_device_driver.

And because we're not doing this, I doubt that a *public* usb::Device
abstraction is required (at least for now).

The cases where we need a struct usb_device for operations on USB interface
(such as usb_fill_bulk_urb(), usb_submit_urb(), etc.) can be dealt with
internally in the abstraction itself, such that drivers only need to know about
the interface.

So, I wouldn't expose it just yet. If we see that further down the road we need
usb_interface drivers to mess with the usb_device directly for some reason, we
can still expose it.

>> The code above establishes that you can get a &usb::Device<Bound> from a
>> &usb::Interface<Bound>, i.e. an interface that is bound to a USB driver
>> (struct usb_driver).
> 
> Interfaces are bound to usb_driver, and are a child device of a struct
> usb_device.  There is no need to worry if a driver is bound to a struct
> usb_device at any time, it should be independent if a driver is bound to
> a struct interface.  All that we should care about is the driver that is
> bound to a usb_interface as that is what the rust binding should be for
> here.

Right, that's why I said I doubt that it is semantically useful to derive a
&usb::Device<Bound> from a &usb::Interface<Bound> or a &usb::Device<Core> from a
&usb::Interface<Core>.

But besides that I also think it's also just wrong, so we should remove the
corresponding code.

