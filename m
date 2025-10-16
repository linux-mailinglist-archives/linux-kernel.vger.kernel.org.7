Return-Path: <linux-kernel+bounces-856985-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CF405BE5967
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 23:46:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E725D424E3D
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 21:46:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87EA62E36F6;
	Thu, 16 Oct 2025 21:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VblxKrxW"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D4CC1547EE
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 21:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760651192; cv=none; b=GwJPosfHlLXVBNXsYlFNT6dIJdIHQYUiR/6VpLjJcNJi57/xlLo58tx2fnNPnA5oMuALilz4S/isL6KnnhO74WlbUUbi/nmjjtJI21CqrN0X8K9pRKVI/dSrr59qra0sksaQ4ySJUVG1OM43TItbhaMPz5XrHX+N1cZx7xoPRMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760651192; c=relaxed/simple;
	bh=9jQWlajEMSQKY7+qnTit+xxMvnKuDZeRR/e9BH0v+t8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UnJcRKyXAK2sfit6rpXh3/5VYVTUgtpKFQd9+8tZ9QIBWltoF6UhHZY0iBnQLi50Kx0Pv+IVO6oVNonQ6SS5FMLcJ64Lj2R5yEDzkH0XxvEgeiSl465a4XxAU9/sHLAOjWMlOcCibo/BFDfr53Y7a34xliww0hV1fHjs7nH1jY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VblxKrxW; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3ee64bc6b85so1126115f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 14:46:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760651189; x=1761255989; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qLVbGWoACrgE9VODWgB1TKnJBzMVwNUtM6cFxhgg3wc=;
        b=VblxKrxWjNlAZSVAr9Ey/sAfc5GlEhybqkM9A/UATuks84VcgVu7VnjBdv31Nvm1yj
         VfDX05J5lT6AgTbyKDwedRht7qKWyLHAOOAY4Xt8xOEffnZLo03haL7tKdbytdIx6Qpn
         rXB2cyZkABo3IEfP5/HGvYIsm+GgP/PHaGr1wOVWDpl+gwVm8xo4d3rNVQz9KV/CDilC
         4n6nPg799d05MJsbSNHem9HQ10uf0rAVewtPqGMrTjaNIG0j9YEgZ0wdfZ609DVBgSX9
         IqeQAKk9FG2SIL/Mj/MIJ3CVToNSII6wkV62FOfXWpp+iOpsyZckAIONhSno+dcFYU1e
         ye6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760651189; x=1761255989;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qLVbGWoACrgE9VODWgB1TKnJBzMVwNUtM6cFxhgg3wc=;
        b=ezO3d0AezayPmzqAaBK1LtKnpjAZCVqU+LIbD24SPZcBe3sp44XlWQPba2DAs3g4Pz
         iWpYMZuuYr/ygCJ2JCBtcfG9RTGtcKs9Ot1DveUMQQwUmZEE8bT1SAolgKXA9ST66bKH
         R5LDvYe8/8adGcbQghjF8jZFWjiqLqpgLZrgW3J1HRPXfxo+yEEsTaFrfk20of+VOiZ0
         P+YNGKnb5lCFC7Mvef/8HNlZJUIyhSSoVQjcUXig6W7v3lpbcbbvzhxrG8cb0LkHKyRQ
         d0VfiV3KNgk76aYK09hFA5kKGQXV4Buj7LcXz3jVIpXvpLqLO0i/wptXRoLr+2ZCvq31
         JvPg==
X-Forwarded-Encrypted: i=1; AJvYcCVjH6Q+VPiwcsDT3gHGVWpUHODM/k8hIKnRiFgMQg3bTE8ZysbdMmdiz8E7t/5VXhL6MqhbFkD7UM45New=@vger.kernel.org
X-Gm-Message-State: AOJu0Yybc1TSwywfcM4ycb4p1sVkibbDD36hvdVr6XBv8Sacl5gFh8T/
	W1d99oNB+3TAsHPL+e+gEWPBQLnAtwJg4X2oEMBazA37VRaNoxO0fjaZ
X-Gm-Gg: ASbGncuHO2kDV7hZ0vNKAGEsniWTFgkQxEevuJ1l3j6simB0NYuFDn84luYptKNibuJ
	UCJsVZ2mI9VYWLixN6ucZc12YkvBQk/piYX8eOEAo3dX3K4uMCee9iDgH/oZhy1OtFh+sb810gS
	jCEnwjiemL42uV8AdmIRPDCWtZY7+Kdgmq8sTWFuOOv3PPRxb1glVPC+C7WXuKaJUuIWyR568wa
	ncgpFnMNNQ+bnVPPhS39hcCOqrXPgivqs/o7ll6jua5WRfXVE4Gkd0tS2tXMgB4fVCWH0L46FTD
	269mFlSdeAEWd0SL2dNxmRrNz31GR7HnvicDYVsxIvyYNwswpKrKFDs60yN4kqXyIlHk4XDq5LS
	nsIjXpDtCkdnYfJ8unmTHHKeC+SmwWQIEapubzUOFHE3pkDAShCoB2KsXhfQKjfS67OPffb8eNU
	9712aNs6EOZWITsxSqwWLeC4nHVZqsWxKYXND0MEOpTwSaDrl2EF5m4PURl9iJVWnqjGFWf/VDL
	E4OXTePTWlu593u
X-Google-Smtp-Source: AGHT+IH/zjgPG/HV9ngqclxgSOqwAQJ1HFnhUiJ+6D/aP5dTWD4NXoIdy+KZQeUj/f6oIUnU/Azdag==
X-Received: by 2002:a05:6000:2911:b0:425:8bc2:9c43 with SMTP id ffacd0b85a97d-42704d7e987mr1012235f8f.1.1760651189397;
        Thu, 16 Oct 2025 14:46:29 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:acc:bb60:756b:64e3:20ef:1d08? ([2a01:e0a:acc:bb60:756b:64e3:20ef:1d08])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce57d4bbsm37423275f8f.2.2025.10.16.14.46.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Oct 2025 14:46:29 -0700 (PDT)
Message-ID: <a7ccda73-2c40-419c-a7c3-3155739648d0@gmail.com>
Date: Thu, 16 Oct 2025 23:46:28 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] nova-core: Solve mentions of `CoherentAllocation`
 improvements [COHA]
To: Danilo Krummrich <dakr@kernel.org>
Cc: Alexandre Courbot <acourbot@nvidia.com>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
 nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Boqun Feng <boqun.feng@gmail.com>,
 Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>,
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>, rust-for-linux@vger.kernel.org
References: <20251015194936.121586-1-delcastillodelarosadaniel@gmail.com>
 <409f2f03-2bc2-4cb8-9ca7-4e30f82077ff@kernel.org>
Content-Language: en-US
From: Daniel del Castillo <delcastillodelarosadaniel@gmail.com>
In-Reply-To: <409f2f03-2bc2-4cb8-9ca7-4e30f82077ff@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Danilo,

On 10/15/25 22:04, Danilo Krummrich wrote:
>> diff --git a/drivers/gpu/nova-core/dma.rs b/drivers/gpu/nova-core/dma.rs
>> index 94f44bcfd748..639a99cf72c4 100644
>> --- a/drivers/gpu/nova-core/dma.rs
>> +++ b/drivers/gpu/nova-core/dma.rs
>> @@ -25,21 +25,11 @@ pub(crate) fn new(dev: &device::Device<device::Bound>, len: usize) -> Result<Sel
>>      }
>>  
>>      pub(crate) fn from_data(dev: &device::Device<device::Bound>, data: &[u8]) -> Result<Self> {
>> -        Self::new(dev, data.len()).map(|mut dma_obj| {
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
>> -            dma_obj
>> -        })
>> +        let mut dma_obj = Self::new(dev, data.len())?;
>> +        // SAFETY: We have just created this object and there is no other user at this stage.
> 
> The safety comment should rather confirm that it is guaranteed that the device
> won't access this memory concurrently.

I actually don't know how this is guaranteed. It wasn't explicitly
explained before here, although unless I'm mistaken it was already a
requirement. Could you help me? I guess it's related to the already
mentioned fact that we just allocated this DMA memory and the device
isn't yet initialized?

Thanks,
Daniel

