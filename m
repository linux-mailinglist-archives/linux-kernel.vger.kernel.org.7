Return-Path: <linux-kernel+bounces-878467-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E8DF5C20BA5
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 15:51:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B84E84EFBFE
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 14:46:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2F48276028;
	Thu, 30 Oct 2025 14:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PxhXs4JB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D9281F151C;
	Thu, 30 Oct 2025 14:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761835563; cv=none; b=hgk+qvD65bE6CB+bsiSrmETE1YKWaFXVwuB7YvIJO/vAud4tQYTJqk9u/Pf+M+zZmXKMO9Xn4gxMTqIv2Z64/EoXgVpACY096c9WimgCJd5nJ6rIhiEeoz1W/rZwmEfjZqDol/Z7gq/x+zj6YwR6Bgu6IJ+rOFCG/Gvp6Ima5Ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761835563; c=relaxed/simple;
	bh=P6OeGJeDpadoVy4JMF0e0f1jzLKG2wtlWUYKOJhRJ5M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QO8iOIujHCd6kF65ii0rbm0doyggK1kpqCdYIK0Mpn+P5E0CJxiq+HVLXFsbU8Q2xscTCbW+pwcwj0KNoAZg9s+OsZVTVMWwO/Fj1oFdvtrdKyp2Agwx2jubLV990DWJxmURYn+qd/njlBFge8t/SHYkl+9wfvFhz1WyNwrsC/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PxhXs4JB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C88A9C4CEF1;
	Thu, 30 Oct 2025 14:45:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761835562;
	bh=P6OeGJeDpadoVy4JMF0e0f1jzLKG2wtlWUYKOJhRJ5M=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=PxhXs4JBJw2rJl9t/rzoMywma2ZzFbMmJavH4kJNf1PN+A+dDmK3QGKpTFEFuNTDn
	 uzl05wStMd5oMf3H05Q5UDxaXsYRfQyIeiedA5P/nkJD0JJjglBoxruAR/SV5Dre8X
	 Qc7Up9Y2cpvaQ9somuQyUC3Uo4yfY4qIErXNgKwafAnnsOSP2UuBPAYJ1mSFriZYfq
	 6C4LZKoKYbYOjMAY07J5/Cp9cLBXQLEcV256cxSR+mH+8EFYv4nnV3DWuL8zDpX0wY
	 j95PGc4mj2bFJ91gS8iRPXoh4tLkG3oMqGgaDh3fTns7IquJyXSJRA1NvoUfJmQ2iS
	 DHckKOPJ3Xt2w==
Message-ID: <6ac08d3e-6057-4869-ae41-03a0f900a0bb@kernel.org>
Date: Thu, 30 Oct 2025 15:45:56 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] gpu: nova-core: add boot42 support for next-gen
 GPUs
To: Timur Tabi <ttabi@nvidia.com>
Cc: John Hubbard <jhubbard@nvidia.com>, "lossin@kernel.org"
 <lossin@kernel.org>, "a.hindborg@kernel.org" <a.hindborg@kernel.org>,
 "boqun.feng@gmail.com" <boqun.feng@gmail.com>, Zhi Wang <zhiw@nvidia.com>,
 "simona@ffwll.ch" <simona@ffwll.ch>, "tmgross@umich.edu"
 <tmgross@umich.edu>, "alex.gaynor@gmail.com" <alex.gaynor@gmail.com>,
 "nouveau@lists.freedesktop.org" <nouveau@lists.freedesktop.org>,
 "ojeda@kernel.org" <ojeda@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "rust-for-linux@vger.kernel.org" <rust-for-linux@vger.kernel.org>,
 "bjorn3_gh@protonmail.com" <bjorn3_gh@protonmail.com>,
 Edwin Peer <epeer@nvidia.com>, "airlied@gmail.com" <airlied@gmail.com>,
 "aliceryhl@google.com" <aliceryhl@google.com>,
 "bhelgaas@google.com" <bhelgaas@google.com>,
 Joel Fernandes <joelagnelf@nvidia.com>,
 Alexandre Courbot <acourbot@nvidia.com>, "gary@garyguo.net"
 <gary@garyguo.net>, Alistair Popple <apopple@nvidia.com>
References: <20251029030332.514358-1-jhubbard@nvidia.com>
 <20251029030332.514358-3-jhubbard@nvidia.com>
 <DDURPPIWWIA7.27RFSM7KRLN7I@kernel.org>
 <a24876cd-1a41-488f-968f-38d2ebebdd39@nvidia.com>
 <72be0fbab026191152154b1f04a45b32dfeb402d.camel@nvidia.com>
 <b9686644-e2dd-4abf-9dd7-fc12081f400f@nvidia.com>
 <479ae6b7fb05376d21bdfe1fcde9e3705c11ecc4.camel@nvidia.com>
 <b8796ee0-05fc-48e1-a075-2bad99b938d2@nvidia.com>
 <35c2d37d02409be8fea5acd713832da938966c43.camel@nvidia.com>
 <a1622011-6c86-4052-a808-31553e0b4916@nvidia.com>
 <18f013a69371ecd86783d09f73c7fb66d860e7df.camel@nvidia.com>
From: Danilo Krummrich <dakr@kernel.org>
Content-Language: en-US
In-Reply-To: <18f013a69371ecd86783d09f73c7fb66d860e7df.camel@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/30/25 3:22 PM, Timur Tabi wrote:
> On Wed, 2025-10-29 at 22:30 -0700, John Hubbard wrote:
>> However, I don't want anyone to have to risk reading boot42 on some
>> ancient GPU (earlier than Fermi, even), with uncertain results.
>>
>> And our HW team has promised to leave behind arch0==0, arch1==1 in
>> in boot0, more or less forever, specifically to help us out here.
>>
>> With that in mind, I *do* want to read boot0 for the forseeable future,
>> as a guide to whether to look at boot42. I really think that is the
>> way to thread the needle here.
> 
> Sure, and this is exactly what is_ancient_gpu() does.  It tells you whether to use boot42
> instead of boot0.  It is the only function that looks at boot0.

I think you're indeed talking about the same thing, but thinking differently
about the implementation details.

A standalone is_ancient_gpu() function called from probe() like

	if is_ancient_gpu(bar) {
		return Err(ENODEV);
	}

is what we would probably do in C, but in Rust we should just call

	let spec = Spec::new()?;

from probe() and Spec::new() will return Err(ENODEV) when it run into an ancient
GPU spec internally.

