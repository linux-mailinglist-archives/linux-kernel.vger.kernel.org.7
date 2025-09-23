Return-Path: <linux-kernel+bounces-829104-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E49E1B964BC
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 16:36:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 853C318941C7
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 14:32:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A7373128B7;
	Tue, 23 Sep 2025 14:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RY8x6hpO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 944862FD1CF;
	Tue, 23 Sep 2025 14:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758637551; cv=none; b=fmw9Y/YA9g9wlt5beQqFvWnkYZXbBDGa8n6D971jGTkM7WOSgn/MHun/cuSWzqVbGXXK0ul4bEP8D7FQ9c1xyH/WZiNn2pmNnnHjXHiU1DkarsKxsOQD+D9ivq7kJTVqGmJVgLQL79II204PdKZ4Co+iE4w0ey9m111ZItKb1LE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758637551; c=relaxed/simple;
	bh=B62fy58K218VlBt3HtXEYP+rlRS1dhQAoP6Mpc2NLVQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u0r5d2ms8Dw/Xg3MreZvHtfos65MHx6Pk2ar5q3oTsBGuDl9/XOJ5BQyBPRxLqioqZcTJIqjShKlVsJygn+GqB+tx7N8rvtPQGOtdqJedVVzW+wgqXiX7Yhjriss8QX8Do3K7Mr//YVlD+aFPaMJh1m8hrCFNJwkDSlcpKP3L+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RY8x6hpO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A9DEC113CF;
	Tue, 23 Sep 2025 14:25:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758637551;
	bh=B62fy58K218VlBt3HtXEYP+rlRS1dhQAoP6Mpc2NLVQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=RY8x6hpOsdeNgW62Dzv+sDzuhIdKC17nyPDC9mzl1NbMgEnMFrRaKCBnIWyQ9Mica
	 SiX6I9xxM35Pk/nYDVoneTJM57+rkGpuZQZjVoIbwzMA+H8/F3wd/j+pah0DhL18q7
	 UqS5qJXkx3QlMY9lZP1S2vMM8Xjy/81wqIwpmlZbW6Vb2E4CuibuD+zuFrp0QKoCQG
	 EEGxeDkfgLmuedfJDLdPbkU6X13UJNfM+ziVdECGGq1fls42YQif2gYZN19d35oFKI
	 FnFDD3JW+FdgLK0yn8tu0/UTfioRjmdvVrgmHAKfAMEyuIMcxHFSkqqbh7TyJjejRi
	 RaAGk/e6DFUPg==
Message-ID: <13ce0ad0-f0d5-4579-9a48-db727baa177f@kernel.org>
Date: Tue, 23 Sep 2025 16:25:46 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] rust: usb: add basic USB abstractions
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Oliver Neukum <oneukum@suse.com>,
 Daniel Almeida <daniel.almeida@collabora.com>,
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
 <2025092356-rounding-eligibly-c4b7@gregkh>
 <f5a802a4-ac9b-4b45-8d1c-871e2e06d7ac@suse.com>
 <2025092307-scoop-challenge-4054@gregkh>
From: Danilo Krummrich <dakr@kernel.org>
Content-Language: en-US
In-Reply-To: <2025092307-scoop-challenge-4054@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/23/25 4:22 PM, Greg Kroah-Hartman wrote:
> On Tue, Sep 23, 2025 at 04:16:36PM +0200, Oliver Neukum wrote:
>> On 23.09.25 16:13, Greg Kroah-Hartman wrote:
>>
>>> Functions like usb_fill_bulk_urb() takes a pointer to a usb_device, not
>>> an interface.  Yes, we should fix that, but that "mistake" dates way way
>>> way back to the original USB api decades ago.  So much so that I didn't
>>> even remember that we used that pointer there :)
>>
>> How would we do that? We need to be able to send at least control
>> request to devices before we have established which configurations
>> or interfaces the device has.
> 
> Oops, I thought that usb_dev in struct usb_interface was a pointer to
> struct usb_device, but no, it's something else...  So no, we need to
> keep that as-is for now.

You can still get it via interface_to_usbdev(), no?

