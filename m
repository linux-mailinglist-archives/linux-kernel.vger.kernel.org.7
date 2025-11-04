Return-Path: <linux-kernel+bounces-884475-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 28A3BC303A1
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 10:21:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 65F00189E6EC
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 09:19:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2C1F328B48;
	Tue,  4 Nov 2025 09:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UGhFr3aj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36A7B313286;
	Tue,  4 Nov 2025 09:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762247594; cv=none; b=NW5Dl0t00F66ubzK8GkYZyVuGrVgBnUBx/FD7psXxpSGgucOMkRO9mYCApqV/nin4sRNSN6dqESw717/CFbAYYLmIfESlCSVjgBHjRK9CVQlrh9A2pXaRlMj6XX7fYjPP3khqEhbYgtRwQU9ert1L1PbIM1ezMOurard2cxGqDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762247594; c=relaxed/simple;
	bh=EtbHnvt/8TBAZWxsUiSDawhDKsRAtOZiY+4ssMblItk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m4aofmEdLT8Pn02j9/e/+Y/cQ2F/iY7xwvYK9Hnsg/8P2o1S5HjKzgGiGIomQwxRgUNXnuJSfOn4Mt0lkCNZ1qhKmWZoqD9WZq8rsRPCHI5guDKeBZk+5XzvRx7AfwvpAmCduAuTN8Rs7A8LwfTKp4mKdPyFKMiKtGz01/JMCUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UGhFr3aj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D578DC4CEF8;
	Tue,  4 Nov 2025 09:13:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762247593;
	bh=EtbHnvt/8TBAZWxsUiSDawhDKsRAtOZiY+4ssMblItk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=UGhFr3aj+PFrejE6ps480mvWBPSH6qzG3rXHos1PrEM1k6I+pdFHBtfDu7fGxStjh
	 Q3d2afiM+AK83U8q4i4dSVB53evvcL5w3c/xggHrXkVWIalv2RVXQKlx0PG2f1d3rM
	 BOESroDmuBsUWe8/AHAugf4fJdPozrM+17AcQO3OeetphoQcr28j9Jruhe4Mjoxm0u
	 j8DEwRZLugPMMf3cBhPRVkpdF4V9wZVs5bUdnJmYPqjyQXlDiP308tH3lEmu+RcbhS
	 kUpWO9mhY6+JD9Nmmp3seQiD9oR6VJq9XMA4rxnnAtz8EcHfkPa/n/4sqqyfL9L3HK
	 v3ZCN108r7Zmw==
Message-ID: <ad2963c2-3d44-4b6d-b975-75a9ea96ba1c@kernel.org>
Date: Tue, 4 Nov 2025 10:13:08 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] rust: dma: make use of start_ptr() and
 start_ptr_mut()
To: Alice Ryhl <aliceryhl@google.com>
Cc: abdiel.janulgue@gmail.com, daniel.almeida@collabora.com,
 robin.murphy@arm.com, a.hindborg@kernel.org, ojeda@kernel.org,
 alex.gaynor@gmail.com, boqun.feng@gmail.com, gary@garyguo.net,
 bjorn3_gh@protonmail.com, lossin@kernel.org, tmgross@umich.edu,
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
References: <20251103190655.2326191-1-dakr@kernel.org>
 <aQm7qLybSn6bOlCy@google.com>
From: Danilo Krummrich <dakr@kernel.org>
Content-Language: en-US
In-Reply-To: <aQm7qLybSn6bOlCy@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/4/25 9:39 AM, Alice Ryhl wrote:
> On Mon, Nov 03, 2025 at 08:06:49PM +0100, Danilo Krummrich wrote:
>> Using start_ptr() and start_ptr_mut() has the advantage that we inherit
>> the requirements the a mutable or immutable reference from those
>> methods.
>>
>> Hence, use them instead of self.cpu_addr.
>>
>> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> 
>>          // and we've just checked that the range and index is within bounds.
>>          // - `offset` can't overflow since it is smaller than `self.count` and we've checked
>>          // that `self.count` won't overflow early in the constructor.
>> -        Ok(unsafe { self.cpu_addr.add(offset) })
>> +        Ok(unsafe { self.start_ptr().cast_mut().add(offset) })
> 
> I guess this shows that the mutable/immutable requirements we inherit
> aren't actually what we need?

item_from_index() is used for the dma_read!() and dma_write!() macros, hence
this one is on purpose.

