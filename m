Return-Path: <linux-kernel+bounces-762821-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C356B20B2D
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 16:05:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 136A51883DFC
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 14:05:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00339244685;
	Mon, 11 Aug 2025 14:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JYPDMmnO"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4D3B23ED76
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 14:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754920946; cv=none; b=RZ6s0yMXiQYtUNgsanQYgcaeQ9GxkBWyyfIUi/+Mpiw0NoxgFbr8DWbPZcDUJXohym1KND3nO4DLKFqmVXymEH3i1LVRuuXMAO1qsTSoaV2yGJL5fC6VyB2BuRNfDHDreDQ3EL8XKR5qTTz+3gnTcBm8Qkf5GGtFG0i2f/r+MEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754920946; c=relaxed/simple;
	bh=PBWiY0BOEoP72MaQZ2kz+hXaTBDNh+3RKPnzCU9vDF0=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=kIGpVAoNUyRPbE+qkbLKDj21eAD8IDSUIxl7NwiZ7juo9Wbavlts0yVwgkKjvJuekCMCjiKDCFiHqe9/F/09e2/gdiCZE1sk6r9wcxIWY7QJE2YgoGu815e8jsUuU1Sqn+ZmR7Oj6ZBgOkpv4p9e+G1p/coWr3LcnC6V1du2NoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JYPDMmnO; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754920943;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rXCVL6y8aPD3KKxEM1gx0c5E0H9w4tmsi8l5+IrKhGs=;
	b=JYPDMmnO9Z+vk32klgbXZ63GqNhzwI+1XMLdP7Y31Xx7hFNRTA3dfns1ugqVp1TAD9l5/4
	/FN9IVJqu48rIQjz0QvqdoYD+OLEqrIKpgEHW8lGtSnrrdyID9fk7phNtm8eg7Dq2xc1Pk
	9o4CsWmDVQ2hpoK3ZXR6u7d1w4nOo+w=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-9-0ZdjjcMrNxCgkzSaGXJk9g-1; Mon, 11 Aug 2025 10:02:17 -0400
X-MC-Unique: 0ZdjjcMrNxCgkzSaGXJk9g-1
X-Mimecast-MFC-AGG-ID: 0ZdjjcMrNxCgkzSaGXJk9g_1754920932
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-71839bc5591so64093367b3.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 07:02:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754920932; x=1755525732;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rXCVL6y8aPD3KKxEM1gx0c5E0H9w4tmsi8l5+IrKhGs=;
        b=B7NxI65sLEHzF5Y/gbeuwxU/ItyroBAS05hDnmCj53ivldNywsXXYg8dtkvAdzfNvH
         i6ytS6UbH7uPj/hhd0q8fTDDumgVPdpjCOmJI1k8tTenQNcWCr2Bcmc3OmrygisWIUgG
         24kajyxPCuHjZdyf8x/W+4zz4aLXmbTWwbhsnu4G5o12hdVHaNpHjopx677tqmgnQo5K
         R3N4fNDK6i1dJZ3VFHyWpl7is6GivIDX7gqIR+GFOtjxsrSvDVj881neJKvcPXrsxU6V
         lBYHRFQMcquYMkZhgwtiVWHXkXUtsmZgdBhWtkGCCpdVHOrGnLHBhOdTNsz5Qqz+n8N/
         n+Kw==
X-Gm-Message-State: AOJu0Yzmq33ZzN0aTkOBPkPK6oBQ7+PKUEMCC9pVUV8AaBYGmc1eD1+z
	Mtxj4qdV59xbrv8ZozcqzGvxH9ZMLUquddO6CpyMGFKLXuGkbKfo73xIc4pmiY4o7C1C/NhjQpf
	AwAkfC1dobreoIINPRzYdvm+QZhI0ajYLeUwckdMCH8YoNqKYsbVeeWs6kHnRdidENg==
X-Gm-Gg: ASbGncsALeuJw+WH4tY1TvO3VI5u6hzXfPdDxE3EhaQD9Dxm+guCRHkauJj3SyVDPoK
	iDpX2498Ujzp3ZEf6zOMpuLpbEF+Rlm3QoluVAe/Q0+kf2+/ZB09bITP7OHRiATtCTu/P/EkX4G
	Ri2hss3Xj5nNwUJ0XN756psYXuvT5FS3cwCnji7dWoUBUyM204JpfvvxrzAlzVOCRbg+BXMxSex
	31HwRCgmwY5ewNymy7L1eVaffRQBCfeelXZu4B+n5amH/5gLQ8B9IYeRgpLIf5ogh+ATxMzidrm
	zCIykOzxF/uRKA/mIxkwEE9I7pYvDtuOHyxWoPsp+FqsH+KyC1NuKJPqr7kCZ1R782bKQ2GC6mh
	Bn7fPA/6Nvw==
X-Received: by 2002:a05:690c:c92:b0:71b:8cc6:6d41 with SMTP id 00721157ae682-71bf0d1032cmr160295377b3.17.1754920931033;
        Mon, 11 Aug 2025 07:02:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGGkmukiGqhNKS9YkeyAI2dphd0kj1shFttrp7nfe9d/BF9URMMJinvskWz+nfybGEa1c1ZHA==
X-Received: by 2002:a05:690c:c92:b0:71b:8cc6:6d41 with SMTP id 00721157ae682-71bf0d1032cmr160294437b3.17.1754920930255;
        Mon, 11 Aug 2025 07:02:10 -0700 (PDT)
Received: from ?IPV6:2601:188:c180:4250:ecbe:130d:668d:951d? ([2601:188:c180:4250:ecbe:130d:668d:951d])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-71bf6c00033sm19811377b3.17.2025.08.11.07.02.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Aug 2025 07:02:08 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <abc42dd6-43fc-4a44-a839-477c693e5dff@redhat.com>
Date: Mon, 11 Aug 2025 10:02:07 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] futex: Use user_write_access_begin() in futex_put_value()
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Darren Hart <dvhart@infradead.org>,
 Davidlohr Bueso <dave@stgolabs.net>, =?UTF-8?Q?Andr=C3=A9_Almeida?=
 <andrealmeid@igalia.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-kernel@vger.kernel.org
References: <20250809212442.240540-1-longman@redhat.com>
Content-Language: en-US
In-Reply-To: <20250809212442.240540-1-longman@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 8/9/25 5:24 PM, Waiman Long wrote:
> Commit cec199c5e39b ("futex: Implement FUTEX2_NUMA") introduces a new
> futex_put_value() helper function to write a value to the given user
> address. However, it uses user_read_access_begin() before the write.
> For arches that differentiate between read and write accesses, like
> powerpc, futex_put_value() fails with a -EFAULT return value.  Fix that
> by using user_write_access_begin().
>
> Fixes: cec199c5e39b ("futex: Implement FUTEX2_NUMA")
> Signed-off-by: Waiman Long <longman@redhat.com>
> ---
>   kernel/futex/futex.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/futex/futex.h b/kernel/futex/futex.h
> index c74eac572acd..2b6ae6a2b2a2 100644
> --- a/kernel/futex/futex.h
> +++ b/kernel/futex/futex.h
> @@ -319,7 +319,7 @@ static __always_inline int futex_put_value(u32 val, u32 __user *to)
>   {
>   	if (can_do_masked_user_access())
>   		to = masked_user_access_begin(to);
> -	else if (!user_read_access_begin(to, sizeof(*to)))
> +	else if (!user_write_access_begin(to, sizeof(*to)))
>   		return -EFAULT;
>   	unsafe_put_user(val, to, Efault);
>   	user_read_access_end();

Sorry, I forgot to use a matching user_write_access_end(). Will send out 
a v2.

Cheers,
Longman


