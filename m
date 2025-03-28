Return-Path: <linux-kernel+bounces-579337-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EB93A74219
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Mar 2025 02:40:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 162BA176BF5
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Mar 2025 01:40:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E60001C5F2D;
	Fri, 28 Mar 2025 01:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b="Nd9OZvfP"
Received: from sender3-pp-f112.zoho.com (sender3-pp-f112.zoho.com [136.143.184.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA20C224CC
	for <linux-kernel@vger.kernel.org>; Fri, 28 Mar 2025 01:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.184.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743126004; cv=pass; b=tm8rbjZWV+Tp6UXYpztu4/eVwQi/Ak0aKK29vQ8pSYRIxQEnCoyQcMgfqc1kqFSGAlxp9mLLj1LAa4wIbIeCuUoyxjGmSbxIwqTqWJjvNHp4hDxGT7jSrzsH6r1MojqHbL7M+ZOpZ2rMiLy7GrynE6hTfsfxD6vtLMhBE6GQ4es=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743126004; c=relaxed/simple;
	bh=JkBhY9pOgIClwKBni1BBTOZ5kTvHJY9rbnRef3t0GMo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gJGaHSKaAroF1k1KlweJfgWsmW+WO/gjV65orBQaWQiWGHFJKhOKJ/44iRPrvPYijYdzqQJG0POT3pfJ/WtmEGxHjycLvsMsKG0WpMtYYEfHteFFkoOwG7KO9C3+dr3w7LOG3M9Ho3nn7iAFBflXufSMp7UJtmzMeF6fJIYGG10=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b=Nd9OZvfP; arc=pass smtp.client-ip=136.143.184.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1743125981; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Mhn/ZCxU8t9otcHXbh/Fb/XObMRcFW3Rrqq71NbRA2QDbD6oWYkRfbk6y76apzqVmWm0FpoVht8UesUlBDMPtM0nams9t1CYA6axvIcaxbcT9gzhB0/XLlnocbNplsdz97+WFB5IexRSf77u58Pu3Av3R31z6dey7Y0WNtshRPg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1743125981; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=bLlskPcsFqLG0KS6/xzkgCRavgzWpJNLaxnhVXBKMzM=; 
	b=RlamE35L/9NgA8dX9DBNKSc9LZG3VlJCSlqOfd4Y3oxtnm2b4huo8j294YKtEa6x2KtoLwuZd0RsxO8k9DcNRzHZVhwWIz7Ctt8XxLUyly/uNEIJRYLZJBQ3xFGhd/WlFEQhgNABLpVhJhbA8YpWl1VNvlX9vZyMSiXqr8Ch0Ww=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
	dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1743125981;
	s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=bLlskPcsFqLG0KS6/xzkgCRavgzWpJNLaxnhVXBKMzM=;
	b=Nd9OZvfPZzsgevFY98n4hPoKGcrGoZdtXxSFbGVca/AtDCiPpJAYs23K3PEo/u6c
	gr9ycLvS2syOCuGCk8kNIW2+1VvGQ7sfcj3BY9LcH649pYiOH02GWW+G3ibrD3xf/dh
	GEe5YDGxShS6nWYDxaNDBa2aUklOC32+6O/fSFt4=
Received: by mx.zohomail.com with SMTPS id 1743125979819361.1158011960416;
	Thu, 27 Mar 2025 18:39:39 -0700 (PDT)
Message-ID: <e9122ec3-3d85-40ac-983a-553a498e5203@collabora.com>
Date: Fri, 28 Mar 2025 04:39:32 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/7] virtio-gpu api: add blob userptr resource
To: "Huang, Honglei1" <Honglei1.Huang@amd.com>,
 Demi Marie Obenour <demiobenour@gmail.com>, David Airlie
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
 <79d642cc-fe61-48c3-bda1-aafeeb07fe2a@amd.com>
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Content-Language: en-US
In-Reply-To: <79d642cc-fe61-48c3-bda1-aafeeb07fe2a@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

On 3/27/25 06:00, Huang, Honglei1 wrote:
> 
> 
> On 2025/3/26 22:46, Dmitry Osipenko wrote:
>> On 3/6/25 13:51, Huang, Honglei1 wrote:
>>>
>>> On 2025/3/1 5:21, Demi Marie Obenour wrote:
>>>> On 2/28/25 12:36 AM, Honglei Huang wrote:
>>>>> From: Honglei Huang <Honglei1.Huang@amd.com>
>>>>>
>>>>> Add a new resource for blob resource, called userptr, used for let
>>>>> host access guest user space memory, to acquire buffer based userptr
>>>>> feature in virtio GPU.
>>>>>
>>>>> - The capset VIRTIO_GPU_CAPSET_HSAKMT used for context init,
>>>>> in this series patches only HSAKMT context can use the userptr
>>>>> feature. HSAKMT is a GPU compute library in HSA stack, like
>>>>> the role libdrm in mesa stack.
>>>>
>>>> Userptr should not be limited to HSMKMT contexts.  Userptr can
>>>> accelerate shm buffers by avoiding a copy from guest to host, and
>>>> it can be implemented using grant tables on Xen.
>>>
>>> Yes, I totally agree userptr can accelerate shm buffers, but I currently
>>> don't know if there are any other projects working on similar features,
>>> or if maintainers have any opinions or better ways to implement them, so
>>> I temporarily limit this feature to HSAKMT context only.
>>>
>>> I am waiting for everyone's opinions, please provide your thoughts.
>>
>> USERPTR should be relevant for anything Vulkan-related, like Venus and
>> native contexts. I expect that this new feature will work universally
>> good for all context types.
>>
>> In order to merge USERPTR support upstream, we at least will need to
>> prototype the guest USERPTR in one of native context driver to know that
>> it works. You'll need to post the whole set of host/guest USERPTR
>> patches including QEMU and etc, not just the kernel patches.
> 
> Ok totally understood, I will upload other components as soon as
> possiable, cause we only have limited resource for this matter, please
> understand the speed is relatively slow.
> And for Vulkan use case, yes it is very important, I will make some
> prototype implementation for it, and will test it locally. The
> implementation for USERPTR must comply with Vulakan's standard.
> Really thanks for your comments.

We aren't in rush, thanks for working on this feature.

-- 
Best regards,
Dmitry

