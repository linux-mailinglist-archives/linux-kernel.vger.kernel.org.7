Return-Path: <linux-kernel+bounces-580892-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BB656A757BE
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Mar 2025 20:50:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5649316AF5D
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Mar 2025 19:50:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 124841DF27D;
	Sat, 29 Mar 2025 19:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Um7Z4yih"
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D472C1D6188
	for <linux-kernel@vger.kernel.org>; Sat, 29 Mar 2025 19:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743277830; cv=none; b=gAgpu3ZLNMqcT9G0S/VXqop7jEDuiJj334nH2tJYRs1BD14iHLSP86ij5hT+dmRkFClpIvPb4RAWipLWMHO5kyEXmQPINtszZrZjqkTr2OjvFCZ4u3e9GPcxtezrqK+tBEn3/MsBLz5IyOy6CYAhN92R06tIz+u8IHL4Y3Yilt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743277830; c=relaxed/simple;
	bh=/b3dSuh7I0AxoN3ATNw0fUcPywc6KnLw+3CYpa/w2PM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=plJQyH+yRTIVquuJT/vwFDsWqYScfWM0BjZKUF7FhW4MF+Pv5d9skyRNsElXIzJZToa2zdtiQ9Q+2z+m9DHs+EjT9oVVRDJoKt3Ks/ugEd0POYIDKhTr91iWEq/ndGzTJ9hFfpCdwjsfZUsxZL7zoDUvTRaG5Pz2+8guo5yVQ8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Um7Z4yih; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-e6405e4ab4dso3743124276.0
        for <linux-kernel@vger.kernel.org>; Sat, 29 Mar 2025 12:50:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743277828; x=1743882628; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kgUng1lsLClhuHLGL9t/6EycDsTNPfaDVFfdT+Zvh3A=;
        b=Um7Z4yihc6oP8FyGpJf+OSQEYKN95FaccRXbnZe9O1A7Go/Alqj/df6eqTeZrt16Db
         23G0yDR4fmeOjr0jPx405xt3c+c6Avo70l1YvxCaFmc/bwmGG/E4NgwqC5QbrpmM24+S
         yF2Xz/CBIHgUhfjIpSkppldh5fpVOmRjRyOid1yoGWVrw8SD5/qqKweQUhfHQi2Q0Ztv
         CRbV5ftB8BIp51LrUmW10/xfyBWIjvnCbGpOfKeXkJALUvDCHZTvNTirPWwobZU9Jeec
         O9aUztY1Nj3Lo7VmIAsItrfc9I0zDV+p+vrjuFB2KFpUg2XpncD6bmIpzDiodmuoaXLj
         XApg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743277828; x=1743882628;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kgUng1lsLClhuHLGL9t/6EycDsTNPfaDVFfdT+Zvh3A=;
        b=XcTBjGF2xHubpkE42+5Hwb02fqWlUyfTboNhnST7KWdj3g+CbqGppxus0xKcbn1HDb
         LGY0PI1BDr2cAezQwWsSH88tngy4CHUwnRuaEyolQkeCEoXP3msU8MAjsz/G0i6FcRuI
         RE7Xo2MVj2pcK1aOh8XNLug9AHgUJwk/Ii0yhE/bKf8j58iINoeAiuRps7R5USMMJ/qf
         W2TekCOxmj0xawjP1b8Mq0W58VrxRfUhAcI8yvAFFsEeKaOfoCYhL9GblMykCIBsy+gm
         RoZqjd43kE2DgdAhPN1d7nnS+OsFWXcAmz5c8Zo/6DnMGyWT/7HiHgtwMmPKFNHgkq3K
         UJKw==
X-Forwarded-Encrypted: i=1; AJvYcCU9dQSJ6DPhRtH5EFjKUmQSiKfCClxcejJq1FNFZ0Txk8Iu535Z6HlVx2RfJM3U8BPH23Uzy+JDVeP9m0E=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTel1kphMHkM0BpuLW/siQaEG0zfK+EiwUa2Yt7TwDhtaCHk3Y
	kNFfmzocCcUBmSBzFR+JGEmi9ismEsMyWP1HpcgVA3yFJaQAEzwe
X-Gm-Gg: ASbGnctbCEvg+gUKw+xGby1ZCFkc41Z9zHbC3LHmbWlV8cmIsm66LlcQSZNhLUFJ50E
	5mbrphH7eI9EpJHAHOGIyZtMnP3zgjVvCajJ3j6hyWIZXlPwxYXAaQyYdX+ceq9MwmQzGMpiRZa
	Wb74fEVE/jtF2E0jT3KD6xU9vkM/Py5XoUp11EbBF6814xj5RAHqNrKcnm6eilSL8wLKc/hCnWH
	TvCpJJj0ArELdd6roaBBq8piMKZh2fCB1l/k/t0lKSs0Qs0943uM3cZBPnEXQAW7avPNtOpaTMV
	+fjlpCsBmGeWT4YDY/IAruHipgaCIPvMAyPz6eONbP8fp+MU4Og=
X-Google-Smtp-Source: AGHT+IFXYHGF1kbfN6DrpHRX6V4TwAnNDp2HMI6U89Z+SpTpIjE4sgJHSH4xQxwFLc3mE4l32HKTFg==
X-Received: by 2002:a05:690c:3345:b0:6f9:e4e1:a86 with SMTP id 00721157ae682-7023e105414mr105948257b3.16.1743277827709;
        Sat, 29 Mar 2025 12:50:27 -0700 (PDT)
Received: from [10.138.35.215] ([45.134.140.51])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7023a341a52sm13676117b3.23.2025.03.29.12.50.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 29 Mar 2025 12:50:27 -0700 (PDT)
Message-ID: <42048a80-a736-4ccc-953b-924d1e640cd0@gmail.com>
Date: Sat, 29 Mar 2025 15:50:46 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/7] virtio-gpu api: add blob userptr resource
Content-Language: en-US
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 "Huang, Honglei1" <Honglei1.Huang@amd.com>, David Airlie
 <airlied@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Gurchetan Singh <gurchetansingh@chromium.org>, Chia-I Wu
 <olvaffe@gmail.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Simona Vetter <simona@ffwll.ch>, Rob Clark <robdclark@gmail.com>,
 Huang Rui <ray.huang@amd.com>
Cc: dri-devel@lists.freedesktop.org, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20250228053650.393646-1-honglei1.huang@amd.com>
 <20250228053650.393646-2-honglei1.huang@amd.com>
 <cd9f85a5-0d99-4007-bba2-d792ac9d84da@gmail.com>
 <c2d1334f-6f5a-493f-bbf0-3e92789f128a@amd.com>
 <85470439-3c03-4787-be91-b6b680a5aca5@collabora.com>
From: Demi Marie Obenour <demiobenour@gmail.com>
Autocrypt: addr=demiobenour@gmail.com; keydata=
 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
 +MYSfkEjBz0E8CLOcAw7JIwAaeBT
In-Reply-To: <85470439-3c03-4787-be91-b6b680a5aca5@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 3/26/25 10:46 AM, Dmitry Osipenko wrote:
> On 3/6/25 13:51, Huang, Honglei1 wrote:
>>
>> On 2025/3/1 5:21, Demi Marie Obenour wrote:
>>> On 2/28/25 12:36 AM, Honglei Huang wrote:
>>>> From: Honglei Huang <Honglei1.Huang@amd.com>
>>>>
>>>> Add a new resource for blob resource, called userptr, used for let
>>>> host access guest user space memory, to acquire buffer based userptr
>>>> feature in virtio GPU.
>>>>
>>>> - The capset VIRTIO_GPU_CAPSET_HSAKMT used for context init,
>>>> in this series patches only HSAKMT context can use the userptr
>>>> feature. HSAKMT is a GPU compute library in HSA stack, like
>>>> the role libdrm in mesa stack.
>>>
>>> Userptr should not be limited to HSMKMT contexts.  Userptr can
>>> accelerate shm buffers by avoiding a copy from guest to host, and
>>> it can be implemented using grant tables on Xen.
>>
>> Yes, I totally agree userptr can accelerate shm buffers, but I currently
>> don't know if there are any other projects working on similar features,
>> or if maintainers have any opinions or better ways to implement them, so
>> I temporarily limit this feature to HSAKMT context only.
>>
>> I am waiting for everyone's opinions, please provide your thoughts.
> 
> USERPTR should be relevant for anything Vulkan-related, like Venus and
> native contexts. I expect that this new feature will work universally
> good for all context types.
> 
> In order to merge USERPTR support upstream, we at least will need to
> prototype the guest USERPTR in one of native context driver to know that
> it works. You'll need to post the whole set of host/guest USERPTR
> patches including QEMU and etc, not just the kernel patches.

Does the user-mode VMM need to be QEMU or would patches to
another open-source VMM, such as crosvm, be sufficient?
-- 
Sincerely,
Demi Marie Obenour (she/her/hers)

