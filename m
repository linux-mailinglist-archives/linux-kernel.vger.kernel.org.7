Return-Path: <linux-kernel+bounces-881838-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 51FAEC2909A
	for <lists+linux-kernel@lfdr.de>; Sun, 02 Nov 2025 15:56:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 990AE4E6B5A
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Nov 2025 14:56:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 912AC2248AF;
	Sun,  2 Nov 2025 14:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ri67TBb1"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45D10E555
	for <linux-kernel@vger.kernel.org>; Sun,  2 Nov 2025 14:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762095381; cv=none; b=My8Gzz4T1peiEwbUG2olNrWHU6etlC8Bl/niMy/Y+vZNhJt+T+XQWtKZM9BErbjfmTM63rz1Q5r1HdDKIkwUklHDxp5ivPmUb6IB8m2Y4FXT1FOQ3LGDkFEMtIbBlccAUnIZC8p8EZEY6VoAzxVqNQG99Ie79otcrp1SsfPeQ9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762095381; c=relaxed/simple;
	bh=yFgefIJLP8zckZ1UG6YRxBztp31yy6enfYo3+NAi/9M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ENpWCcNJU2S5tpQEbCVqpXFs7VWEyBEt7CpM+GT+idmy4mNZZvQrk+Ble+55979XuBSzI8vVRoEzE72PDA7TpBRm1/Ygp2TNZmfuovU17L4f//oFiZjjUwSc92htNzrYzjnaa7IFug8XUEBGmomMe5a0nBls9fYtW2+O6w9v8h0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ri67TBb1; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-429c82bf86bso987455f8f.1
        for <linux-kernel@vger.kernel.org>; Sun, 02 Nov 2025 06:56:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762095379; x=1762700179; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WNRp8GBQqKKuNk9ZiQRhReDm9E3VEBrBLSW1DlgX55M=;
        b=Ri67TBb1iAqkttnpPLqRg+mSp++4WApFAxvTMRB87j8EpN/J11MPf9c15w3sv3DwTv
         3mH4XEGL8BSxb3QI4ukGZpdn6DojxMf608xZ8vRtF8lswPlkG0Sv6NTnjrh18+vaHTBi
         /XLtC3ClrOEhzcsA9Y35ndt4sQpJMsO1RcSR3o/mMdA9CozjwRDMaqDMjjctU4MJjauW
         Iz6S6gLmSSQxDoIvLq+mR8jOBRHBN65isMysKgW/Hj6ulgkAU8h7t9e++Eda7uC1+HOc
         KXmfeCMw+1E6cdtn79oMB55NVmNVei6PG1+eBNSUlE1KXkFQgnIZDKpnN3JI0Oyx9I96
         8cjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762095379; x=1762700179;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WNRp8GBQqKKuNk9ZiQRhReDm9E3VEBrBLSW1DlgX55M=;
        b=Zoxv8o3lWGELCRYF1d01JUmhvX7rBiPq2+3PiVKLxjHmby8GWgf+3jEi5hvCN5zAua
         YeZMoFOeMFM/0fn+TUbgA47iIPzm/P4liLRGOehX1BbM/km+63VzKaxTWbgjU2mBFdrV
         u9VXIska+2Ej0IgArLTIVNUHYaqObxSHBCbwjCrjarLZBGeLe7NTO3BzfksT+A54xTKv
         m1L9n/6KgH66W4Hi0o47iBRkUZ2BQhQa2S3W4fu1CpwbVgnkgDHtOGL+eesYNdm/l0es
         A2/noNIMsFKwvW+VqR6oPsGg4HER7jBXbbOEMX/SLMG5W49RJEZ/jdSBFZjHh0dGOVDL
         5IAw==
X-Forwarded-Encrypted: i=1; AJvYcCXtiJzQOw2MzBWDsGPiDPS2Ok9RtaWUeiAhwROqHdTwMt8isEVER/c6F/6dwyjv+nnci6P++gax1HXRTLY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxuTMjsDPphuPn6wVds/CneiYychrk7oTZXdIkA4VQ2p8mt4BFm
	wttxdwuAqpdnDgBUjF8OAK/sInGciCOLGkPNhiDvzwN+bf10ewhisRmh
X-Gm-Gg: ASbGncu8ZCgBSkzWo0BqBC6gYuuuWWJsK7k1auu1odgI4he1gIfwmTfwArjI8xuwK1F
	ZYDlRnqgRqhU0F9tLeaw5lSZr9F4z8KKFN4BzsiTpiMSO1xNaF9opPTWu7LFlb9oCPJQGrRBoOY
	UhQdBGIrprgj/sQ/92sHNL1sPK8j6k03DUdjwyLoZXUAI+KHI5UhL/02oBvUDwndkIx81WrKkxp
	4BP5ZoVHt45gLMVl/nSmKoBxLu7NwY6Br79mrflOZirfxDHpjV/4NAm19umB8+t1nzLLEY0CJCO
	j6AaH5iK/crCq+mMmkjo+e20vrQcwM4B6r9z0p/bCv/569EpbMvZqTlB1SZ4Tyj5TpPx/lkGs4F
	4jjWQoRLmm+KkQ9bIMHXQ7lcpuiHcCHoi7nDxQeIpBWAx+NbSStqPY6k7Wm93sTvvkwCAcgWD+2
	/qpsdfrSu+ZpnoEAYuXLn6DI0r3QRF7EcPxabSPEJKahQvp39cUU/F8kih3VWR6gTZpK0=
X-Google-Smtp-Source: AGHT+IEAwtgyxniTz4Ai5mtawKx2HjkKK2OW7gZ2ITGD+2oJ/4ffgGzrS5E/3uRYJ89wkLzNjfq3hg==
X-Received: by 2002:a05:6000:1a85:b0:429:d2a9:5dea with SMTP id ffacd0b85a97d-429d2a95f05mr675088f8f.15.1762095378417;
        Sun, 02 Nov 2025 06:56:18 -0800 (PST)
Received: from ?IPV6:2a01:e0a:acc:bb60:756b:64e3:20ef:1d08? ([2a01:e0a:acc:bb60:756b:64e3:20ef:1d08])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429c13f2b5asm14807337f8f.40.2025.11.02.06.56.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 02 Nov 2025 06:56:18 -0800 (PST)
Message-ID: <51200cc6-042a-4e83-81b0-720385c67bb5@gmail.com>
Date: Sun, 2 Nov 2025 15:56:16 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] nova-core: Simplify `DmaObject::from_data` in
 nova-core/dma.rs
To: Alexandre Courbot <acourbot@nvidia.com>,
 Danilo Krummrich <dakr@kernel.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Miguel Ojeda <ojeda@kernel.org>,
 Alex Gaynor <alex.gaynor@gmail.com>
Cc: nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Boqun Feng <boqun.feng@gmail.com>,
 Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>,
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>, rust-for-linux@vger.kernel.org,
 dri-devel <dri-devel-bounces@lists.freedesktop.org>
References: <20251023205146.196042-1-delcastillodelarosadaniel@gmail.com>
 <20251023205146.196042-2-delcastillodelarosadaniel@gmail.com>
 <DDXC0YKKJJT4.18JQ1MJQ7I31Y@nvidia.com>
Content-Language: en-US
From: Daniel del Castillo <delcastillodelarosadaniel@gmail.com>
In-Reply-To: <DDXC0YKKJJT4.18JQ1MJQ7I31Y@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Alexandre,

On 11/1/25 12:46, Alexandre Courbot wrote:
> On Fri Oct 24, 2025 at 5:51 AM JST, Daniel del Castillo wrote:
>> This patch solves one of the existing mentions of COHA, a task
>> in the Nova task list about improving the `CoherentAllocation` API.
>> It uses the `write` method from `CoherentAllocation`.
>>
>> Signed-off-by: Daniel del Castillo <delcastillodelarosadaniel@gmail.com>
>>
>> ---
>>
>> V1 -> V2: Split previous patch into two. One per reference to COHA.
>>           Added more details in Safety comment. Let me know your thoughts
>>           Kept the original map to avoid a temporary variable
>> ---
>>  drivers/gpu/nova-core/dma.rs | 15 +++------------
>>  1 file changed, 3 insertions(+), 12 deletions(-)
>>
>> diff --git a/drivers/gpu/nova-core/dma.rs b/drivers/gpu/nova-core/dma.rs
>> index 94f44bcfd748..620d31078858 100644
>> --- a/drivers/gpu/nova-core/dma.rs
>> +++ b/drivers/gpu/nova-core/dma.rs
>> @@ -26,18 +26,9 @@ pub(crate) fn new(dev: &device::Device<device::Bound>, len: usize) -> Result<Sel
>>  
>>      pub(crate) fn from_data(dev: &device::Device<device::Bound>, data: &[u8]) -> Result<Self> {
>>          Self::new(dev, data.len()).map(|mut dma_obj| {
>> -            // TODO[COHA]: replace with `CoherentAllocation::write()` once available.
>> -            // SAFETY:
>> -            // - `dma_obj`'s size is at least `data.len()`.
>> -            // - We have just created this object and there is no other user at this stage.
>> -            unsafe {
>> -                core::ptr::copy_nonoverlapping(
>> -                    data.as_ptr(),
>> -                    dma_obj.dma.start_ptr_mut(),
>> -                    data.len(),
>> -                );
>> -            }
>> -
>> +            // SAFETY: We have just allocated the DMA memory, we are the only users and
>> +            // we haven't made the device aware of the handle yet.
>> +            unsafe { dma_obj.write(data, 0)? }
> 
> This doesn't build for me:
> 
>     error[E0277]: the `?` operator can only be used in a closure that returns `Result` or `Option` (or another type that implements `core::ops::FromResidual`)
>       --> ../drivers/gpu/nova-core/dma.rs:31:44
>       |
>     28 |         Self::new(dev, data.len()).map(|mut dma_obj| {
>       |                                        ------------- this function should return `Result` or `Option` to accept `?`
>     ...
>     31 |             unsafe { dma_obj.write(data, 0)? }
>       |                                            ^ cannot use the `?` operator in a closure that returns `dma::DmaObject`
> 
> Could you double-check? I guess you will need to change the `map` into
> `and_then`.

You are totally right. I'm not sure what happened. I'll fix it. Thanks!

