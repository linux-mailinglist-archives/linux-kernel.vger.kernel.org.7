Return-Path: <linux-kernel+bounces-781786-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 32695B316C0
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 13:54:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15C93AE1C29
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 11:54:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7446D2F49E4;
	Fri, 22 Aug 2025 11:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B+6ahfEF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB3AA29346F;
	Fri, 22 Aug 2025 11:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755863678; cv=none; b=k1UTwKqqjaXRgKQ4rEeD/WjKCmrxg+yQcH4627vcq7ML0xMbVkJkZQaZfivhM1OryUGSTJnPhyrMSCX0pI1mubigbZvEcAAY1KZxLQVdCJO4BxuFYXxB+1RQLOzn5i+6cIESXfgNEe4dNlKD2qtsj09cKFFKswSKAjcvzQ+VjOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755863678; c=relaxed/simple;
	bh=a449o365dTmk7vAPQGk8yaoprM7v/2ObKzhh22X6wOw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uQSkKlpCKB2ex+xgr01cEkOkg+k2V7kergRWMfEJboXPzGLUbQr6FBcBfm79PzXo2+UnKWMPiAhiMbvihj0s0VLHVgQBJB43EF7PEZGAzL19ZWL2p9bXbqj/ajc6viPQeUtAEkMp9MEqOIoVbI9CEXkmrfOAYEkMVWNeEn0D1yI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B+6ahfEF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C712C4CEED;
	Fri, 22 Aug 2025 11:54:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755863677;
	bh=a449o365dTmk7vAPQGk8yaoprM7v/2ObKzhh22X6wOw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=B+6ahfEF/Es5LKHSxhc7yaLi5rQcjtWzEnrEnIsgaoFSqj32OEBD2hvEHw1R+zzxG
	 yfhRCc79phP9GRv+qIL1/2fovxfa7l9h3AU+OvSWp9ndgOyIXqAnQqisz8fMnTrPKk
	 qFEe0ZBni48jmW7VH+WLCAkq8wK5fTH8hxklTeP3Mm0Sqm7Sip5VUxQTzlte+aDDZm
	 6XYHY0BiGMikNJcsCkePzZU8rfXOSuNhruOE6Ir072UajEdRAhHPwc2E4ZIIJaz8zZ
	 qr2NzMFfSmiFZAq8uuAWNP844dnUZSnT07sT6BJVteGf7+3YGiAIm3ae2WKsRu0UIP
	 rdVFOIxmiV+qw==
Message-ID: <d30f085a-a031-4208-a15a-e85c7a56347f@kernel.org>
Date: Fri, 22 Aug 2025 13:54:32 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/5] rust: scatterlist: Add type-state abstraction for
 sg_table
To: Alice Ryhl <aliceryhl@google.com>
Cc: akpm@linux-foundation.org, ojeda@kernel.org, alex.gaynor@gmail.com,
 boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com,
 lossin@kernel.org, a.hindborg@kernel.org, tmgross@umich.edu,
 abdiel.janulgue@gmail.com, acourbot@nvidia.com, jgg@ziepe.ca,
 lyude@redhat.com, robin.murphy@arm.com, daniel.almeida@collabora.com,
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250820165431.170195-1-dakr@kernel.org>
 <20250820165431.170195-4-dakr@kernel.org> <aKhYCf6wgSztcdXU@google.com>
 <DC8XLP6C3E5I.10QJQVI4LORSF@kernel.org> <aKhZ9jdiNS2SAZv2@google.com>
From: Danilo Krummrich <dakr@kernel.org>
Content-Language: en-US
In-Reply-To: <aKhZ9jdiNS2SAZv2@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/22/25 1:52 PM, Alice Ryhl wrote:
> On Fri, Aug 22, 2025 at 01:48:47PM +0200, Danilo Krummrich wrote:
>> On Fri Aug 22, 2025 at 1:44 PM CEST, Alice Ryhl wrote:
>>>> +impl<P> Owned<P>
>>>> +where
>>>> +    for<'a> P: page::AsPageIter<Iter<'a> = VmallocPageIter<'a>> + 'static,
>>>> +{
>>>> +    fn new(
>>>> +        dev: &Device<Bound>,
>>>> +        mut pages: P,
>>>> +        dir: dma::DataDirection,
>>>> +        flags: alloc::Flags,
>>>> +    ) -> Result<impl PinInit<Self, Error> + '_> {
>>>> +        let page_iter = pages.page_iter();
>>>> +        let size = page_iter.size();
>>>
>>> Variable naming here is confusing. There's another variable called size
>>> in an inner scope, and then afterwards in RawSGTable you use *this* size
>>> variable again.
>>
>> I can change the size in the assignment block of max_segment to max_size, or do
>> you have other suggestions?
> 
> How about just this?
> 
> let max_segment = {
>      // SAFETY: `dev.as_raw()` is a valid pointer to a `struct device`.
>      let max_segment = unsafe { bindings::dma_max_mapping_size(dev.as_raw()) };
>      if max_segment == 0 {
>          u32::MAX
>      } else {
>          u32::try_from(max_segment).unwrap_or(u32::MAX)
>      }
> };

Looks good, thanks!

