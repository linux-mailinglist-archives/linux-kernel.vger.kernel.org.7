Return-Path: <linux-kernel+bounces-881844-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 10108C290D8
	for <lists+linux-kernel@lfdr.de>; Sun, 02 Nov 2025 16:10:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8844834785C
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Nov 2025 15:10:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D01941C5D59;
	Sun,  2 Nov 2025 15:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dkwzDHQf"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B4A81E9B1C
	for <linux-kernel@vger.kernel.org>; Sun,  2 Nov 2025 15:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762096200; cv=none; b=FsO9vTEbSivOnbfSGv9FBHLDkdoPmA63uHyGEI1MMX9Y4oED/s1ODYJ46pUp8I61W9UxVmR6uywPsv2NF3W4KcqkJyZKKHM3JI8HkGjR+HjIzyT33+GK8+ULCPsKzeV94KD4Fj4WNjNt+/w29NmyzkV+edqXhwxEP00HYkSMHwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762096200; c=relaxed/simple;
	bh=VFtW55W+C0l2GRxIradwFto3E/PPS/mhZrfmGYwcP1w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UHDdJ8bQnzl4cnjJZYu3V6tPuaYWD5YWhA3deP/p7Req5mI74pyGHSZizqIfuWC5aAm/6+1FCox+RW/DhRckQKQ6+oLdf8a1uxjKRUIQBLowR3yXWCgjVOpy+AmdWkjcf9FJ6GP6E0LNhjNBJwqr2zbtq3uj4wBiywmuj87jxc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dkwzDHQf; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-47112a73785so24205245e9.3
        for <linux-kernel@vger.kernel.org>; Sun, 02 Nov 2025 07:09:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762096197; x=1762700997; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KeEh++c4R7x24Ob6ITABSkGpnIKxyH2JeGroaXixafA=;
        b=dkwzDHQf6aUvrak43dtmnSs3yEmAuXHmGNVc6ZWp8yuokLUv3keiXEc7X0g56RQUqW
         mAwypnhopt71tab7IR1zKIcOu0wZ4eL58hhvUWAkiKIpeHMHErlFoWpeb4yde2PhxY1h
         s/zeIlJ8N2lYyf5XXQMx0UC43wVdxGrrCuwH3ftDugeXTdbBplihWtmRJCn8trc7tWgS
         7MeH0Hh3CuX+z4G+/mAssmte7DWa1dEN8rpdwww/7zZdbPY7Oa1oBIfeBzg3PmPtYio+
         pzTqGztif9KkqUxrLI5f8DqT065A/aflwrjn4rRAZUkGc/qrtjCL3v7Kdk+VRt6A3RCO
         9UVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762096197; x=1762700997;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KeEh++c4R7x24Ob6ITABSkGpnIKxyH2JeGroaXixafA=;
        b=wo4dryP8pv43Bs88dL6x0fwd3krTqM5tTEGkqdeOY7+pRLSI4f4Xz/JkofSDavuBeN
         7j1z5FdfGYKuwlVuJGkCdq4MfQR2wBkZS1UrTNmwL9sccUW5Zdt6PqT01Ms7YcBOqBdx
         O6iDPp/DALCIAO4Bz2DN8MCyIz0coNVM/agUnnL8Zi72r385K/CQKGJ9EH5AlI6M+LdD
         UsEToDGLK7JSEY9iHkXmhOlKj2DV1BuxzVDpVZ5J/IowVouRv4vvSNCrO7u6iLqR8M2W
         yenQFtwB4d6K5yFEC4uiHV6d0w1UqHHIhhZR8bJwxy0natOcZjNAliIlJAbB5S3uawZ/
         fYFw==
X-Forwarded-Encrypted: i=1; AJvYcCX4y7Q7NyqBU8/t+gwJRyyrYYSkcEnHL8Rk3IdPPlgkEarGc8PsYF+y6RDIxzVkiOkqI+ME8oez2migGaM=@vger.kernel.org
X-Gm-Message-State: AOJu0YylstRWLsz15w6rA08KrhORmfZHef/ehBQ+pooONdYX7ih1SpCP
	5Z8Y/cCURn1319GGBt4mIJuN26+gk5EAQay+o+dHP6aB9ou3Q9Rgt1gU
X-Gm-Gg: ASbGncv3EeCxXpdjaYAZDsDJiu7HkIkh8wvBerwlGdwRJ26GY0iL9IaYVFpJ6MrxuGt
	wVIPYPNYZ64tbNeivR88kQ/W5iPtPDTw5CZE79A1IOe/QzuN6y4HpJF7ujTJ7hcVkKqVRPADHm5
	UKEFbUaXvhUuTFm6BgMs//0LKNaissGdcl0V5EXmfk/GzLHzKvsX/J9h57fKctBoAnFJPh8C+f4
	3UbLKj1NI6Pg4TBFWlfB9V8VLDOFFYSuvPSdsWDaUz5C7WbtX9yS9T3t+oyTaKkw3/6VH112o2C
	b+sX9kWuDjxP6KfzrM2GAa3Gg4nfX0B+K3npRd+NUWhee5olUpymUJeQYlsVIJf0edTTum0kTUj
	HdVlmujv4sfHcVx6UNPPMfRVaS3zvyVaoCe32rKFxrnhxBJC8L7WF3TKEgyshTJWgbyyM5aeIvw
	X7pWJvoA0mHOGv0CiT76URc+97+KROJ6jyGlXPgVuewvaGA7f7ahEW4ZfAmBwrHk62V3I=
X-Google-Smtp-Source: AGHT+IHGrARufC9tZYIoG9QCHsV4kZ8J2Ovz4A4hPVeK83i602JTm5CAJj2RXLSVlTY6X+3zPvhvCQ==
X-Received: by 2002:a05:600c:83ce:b0:471:989:9d85 with SMTP id 5b1f17b1804b1-47730871fa6mr104046745e9.19.1762096196688;
        Sun, 02 Nov 2025 07:09:56 -0800 (PST)
Received: from ?IPV6:2a01:e0a:acc:bb60:756b:64e3:20ef:1d08? ([2a01:e0a:acc:bb60:756b:64e3:20ef:1d08])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429d1061efasm3179609f8f.24.2025.11.02.07.09.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 02 Nov 2025 07:09:55 -0800 (PST)
Message-ID: <70210168-ee28-4996-89f0-83f8590cb716@gmail.com>
Date: Sun, 2 Nov 2025 16:09:54 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] nova-core: Simplify `transmute` and
 `transmute_mut` in fwsec.rs
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
 <DDXC17HXPXFZ.3TIX7FHUJHAI7@nvidia.com>
Content-Language: en-US
From: Daniel del Castillo <delcastillodelarosadaniel@gmail.com>
In-Reply-To: <DDXC17HXPXFZ.3TIX7FHUJHAI7@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Alexandre,

On 11/1/25 12:47, Alexandre Courbot wrote:
> On Fri Oct 24, 2025 at 5:51 AM JST, Daniel del Castillo wrote:
>> This patch solves one of the existing mentions of COHA, a task
>> in the Nova task list about improving the `CoherentAllocation` API.
>> It uses the new `from_bytes` method from the `FromBytes` trait as
>> well as the `as_slice` and `as_slice_mut` methods from
>> `CoherentAllocation`.
>>
>> Signed-off-by: Daniel del Castillo <delcastillodelarosadaniel@gmail.com>
>>
>> ---
>>
>> I confirmed by talking to Alexandre Courbot, that the reading/writing
>> methods in `CoherentAllocation` can never be safe, so
>> this patch doesn't actually change `CoherentAllocation`, but rather
>> tries to solve one of the existing references to [COHA].
>>
>> V1 -> V2: Split previous patch into two. One per reference to COHA.
>>           Improved comments. Let me know if they are okay now.
>>           Use of `{...}` syntax for the `if let`
>>
>>  drivers/gpu/nova-core/firmware/fwsec.rs | 129 +++++++++++-------------
>>  1 file changed, 60 insertions(+), 69 deletions(-)
>>
>> diff --git a/drivers/gpu/nova-core/firmware/fwsec.rs b/drivers/gpu/nova-core/firmware/fwsec.rs
>> index 8edbb5c0572c..507ef3868565 100644
>> --- a/drivers/gpu/nova-core/firmware/fwsec.rs
>> +++ b/drivers/gpu/nova-core/firmware/fwsec.rs
>> @@ -11,12 +11,12 @@
>>  //! - The ucode signature, so the GSP falcon can run FWSEC in HS mode.
>>  
>>  use core::marker::PhantomData;
>> -use core::mem::{align_of, size_of};
>> +use core::mem::size_of;
>>  use core::ops::Deref;
>>  
>>  use kernel::device::{self, Device};
>>  use kernel::prelude::*;
>> -use kernel::transmute::FromBytes;
>> +use kernel::transmute::{AsBytes, FromBytes};
>>  
>>  use crate::dma::DmaObject;
>>  use crate::driver::Bar0;
>> @@ -35,7 +35,7 @@ struct FalconAppifHdrV1 {
>>      entry_size: u8,
>>      entry_count: u8,
>>  }
>> -// SAFETY: any byte sequence is valid for this struct.
>> +// SAFETY: Any byte sequence is valid for this struct.
>>  unsafe impl FromBytes for FalconAppifHdrV1 {}
>>  
>>  #[repr(C, packed)]
>> @@ -44,7 +44,7 @@ struct FalconAppifV1 {
>>      id: u32,
>>      dmem_base: u32,
>>  }
>> -// SAFETY: any byte sequence is valid for this struct.
>> +// SAFETY: Any byte sequence is valid for this struct.
>>  unsafe impl FromBytes for FalconAppifV1 {}
>>  
>>  #[derive(Debug)]
>> @@ -68,8 +68,10 @@ struct FalconAppifDmemmapperV3 {
>>      ucode_cmd_mask1: u32,
>>      multi_tgt_tbl: u32,
>>  }
>> -// SAFETY: any byte sequence is valid for this struct.
>> +// SAFETY: Any byte sequence is valid for this struct.
> 
> I appreciate the capitalization, but these changes are a bit
> distracting. :) If you absolutely want to do this, let it be its own
> patch so the current one stays focused on what it actually does.
> 
>>  unsafe impl FromBytes for FalconAppifDmemmapperV3 {}
>> +// SAFETY: This struct doesn't contain unitialized bytes and doesn't have interior mutability.
> 
> Typo: s/unitialized/uninitialized (and in other comments as well).
> 
I will move the capitalization to another patch and fix the typo.

> Otherwise this looks ok - it doesn't apply cleanly on drm-rust-next
> though, could you rebase for the next version?

About this, I was basing myself on nova-next [1]. I will rebase on top
of drm-rust-next for the next version.


Link: https://gitlab.freedesktop.org/drm/nova [1]
Link:
https://gitlab.freedesktop.org/drm/rust/kernel/-/tree/drm-rust-next [2]

> 
> Thanks for the cleanup!

Thanks to you for the reviews and the patience!




