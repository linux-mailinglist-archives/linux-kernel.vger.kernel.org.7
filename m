Return-Path: <linux-kernel+bounces-878094-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CEF1C1FC27
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 12:15:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0C2874E9894
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 11:15:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 998602E5B32;
	Thu, 30 Oct 2025 11:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="poMPAQXu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F01E12DF3C6;
	Thu, 30 Oct 2025 11:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761822912; cv=none; b=i38u5BN9u8SsHO3nvH6beVntV/tEW4q8DoJd5w/sx/dXQzmQSvLONN6UiMTw5ffrb82WtTHwl94gtK0c8sJPjg6PviE4ESuViPcMSNbXxD3yWwD16y8KZqIUpGyt4vu6r7VHrTrwTQdpL1j6lRSz0KhOH4EUbjdlmYEiiWLu3gY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761822912; c=relaxed/simple;
	bh=gP5Y5jDLLpBVmQGmQqu9eVBjgKlOOZRJlIXu5Gz0Nm4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N2uDBmqpHi0k0K/dUSRuIDSqkrgvlf3TfffhP2l7S6mqCe4vcbr0Cnu+vnVfe1kYcBJF3b+8SMKXKBmWKdLnyT3zvHxXEinBkRhiYEHOBVSiR9kQ6GPtmx7ymTCA+W/HvmvvICre/hb0phS/3ilGR4p6bzc8J9gZgSFTaPck6vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=poMPAQXu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5893AC4CEF1;
	Thu, 30 Oct 2025 11:15:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761822911;
	bh=gP5Y5jDLLpBVmQGmQqu9eVBjgKlOOZRJlIXu5Gz0Nm4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=poMPAQXuSzuHhNnEazwK7onEIt+ouVImynsh6Oe59Qp1uSegSHuT/c3WQ+e5MB5dt
	 mAZ3k7cQFvbEhh75Pxxl6YUZawvqRtufJ3frKlOWnf/22owMraMZiDkq4WWI3F6V/y
	 1zLa5I4y/G0UWGfqxgcxJT0VwG8jITw1jrL2Z38QTVYraWHBUJH/aY9n1sqTvZ3vVg
	 GvtAAHb32NHOEtIkIwfuDVfUdhryyeM4TvtEMnxw6lDrIgwFOwSVawfZW6FucuaNH7
	 18sa/4W4j0NLODhN91BTofDBLVQavDrb/yZ/XTlW/VZ0XnM8H5A0yaRJ6GkVE/13HH
	 EYPq3wyzwcO/g==
Message-ID: <7c8ab212-3905-4652-baa4-b422e69fea0c@kernel.org>
Date: Thu, 30 Oct 2025 12:15:05 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nova-core: Ada: basic GPU identification
To: John Hubbard <jhubbard@nvidia.com>
Cc: Alexandre Courbot <acourbot@nvidia.com>,
 Joel Fernandes <joelagnelf@nvidia.com>, Timur Tabi <ttabi@nvidia.com>,
 Alistair Popple <apopple@nvidia.com>, Edwin Peer <epeer@nvidia.com>,
 Zhi Wang <zhiw@nvidia.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Bjorn Helgaas <bhelgaas@google.com>,
 Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
 nouveau@lists.freedesktop.org, rust-for-linux@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>
References: <20251025012017.573078-1-jhubbard@nvidia.com>
From: Danilo Krummrich <dakr@kernel.org>
Content-Language: en-US
In-Reply-To: <20251025012017.573078-1-jhubbard@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/25/25 3:20 AM, John Hubbard wrote:
> ...which is sufficient to make Ada GPUs work, because they use the
> pre-existing Ampere GPU code, unmodified.
> 
> Tested on AD102 (RTX 6000 Ada).
> 
> Signed-off-by: John Hubbard <jhubbard@nvidia.com>

Acked-by: Danilo Krummrich <dakr@kernel.org>

You may want to consider requesting committer access for the drm-rust tree [1].

[1]
https://drm.pages.freedesktop.org/maintainer-tools/committer/commit-access.html#access-request

