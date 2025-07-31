Return-Path: <linux-kernel+bounces-751495-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EAF21B16A4A
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 04:05:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 240B818C073E
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 02:06:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4846D7E110;
	Thu, 31 Jul 2025 02:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="ZRIQNDx/"
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14F843D69
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 02:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753927535; cv=none; b=snLpY1CQ+NzGrnwJr/8JSwwj/Wl/QfWsPcPZl7xOTglZ9jMz9+v/G0XDS0EVdOp07m5WEAyc0S1QXfQVc7k5EDED5tevkcCkV21xiSXbg8OnUWipDJX8lAcROrEVp3VRpyJNTtJLFbDIdRh6HnTM8a5uZxbGsipYzF9qHxXiZVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753927535; c=relaxed/simple;
	bh=2sw65rHbGffAgvv17Gh7nSSbZ1BX+pehhvD6F6Sj550=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K+NlztxXDMhQY98vcEyycETbFbpyWam3qfz0N6HjnhRuttfxiQaiyrokkXt/CXvcVQe914hBIZTVr7HuCrNsTe5hN5Rz9mwIa3G4cQMLjkSfILc2GbbgzFuwRFlg3R0YBQ10+mB+Qr6vPak8qgL66uJbgG/XkFXhfIy2wAK1ZEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=ZRIQNDx/; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-87c32f46253so12976639f.1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 19:05:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1753927531; x=1754532331; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HoVI6Rgwek+KBblFywc0H+donkBr9IvZkTxUowyv/T0=;
        b=ZRIQNDx/NgbXU+kBnJs58jyPGd6EOOi+ENrCWMItNoNqwe22nOXaF/O212Y5wNQuY8
         cbPtgK+hA3+2Bl2khk6qnYpsv07nhYpuDDgLpXh0bAEKKKTtrGqLJjqw82UD2R3aelAt
         aoXdCtOFlc5L7ug6WiFg2sXKbYHEWKsDpN8PSWrSmqag2oTncHuRE5NurcxOuY354grW
         o34mT+1tNkX/91KAhTWy9MfjQ0pzfQgUKNnpgSZL6pPEhgH3yqfZQb0F68T0rjxrTJXT
         Sj3MjyYrFniy5gXWtQb4dmwo2XrqS9QyqfTDiNhMoHLsPjzaHJ2pfYZlGbibfFkaKNAw
         qXcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753927531; x=1754532331;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HoVI6Rgwek+KBblFywc0H+donkBr9IvZkTxUowyv/T0=;
        b=M+vc5SSqnBHsWfGax9RgpX6mJHjirSdtzQSWdZCQswHmsu9NdIGxPcE5t33ylwh2kY
         NFs6zQkMMa/GJvmO+ThDyvrUFx/PF0iwzzmHsC2ozbR0ejm20YvyaBlA38h4B0IiEIZ+
         YxT6qJb//iGWgwvyXezG2S4Z7M3VqepHBgiwW6lbzIvKBlLZHSwDgibnNeCwB4xTChi9
         oMKyYBkdAyl5TEchWcRyC/UZM1SZIpZN9cA3+w8/201+ljROcVf2GWPnKydmzlW2jiu1
         3rkXjK+0T8LG5UKtyQVKqnRz+hgLa5zYgwtqwxLxAAo5DDY4mIOqxEW403WNhffWc21+
         JvvA==
X-Forwarded-Encrypted: i=1; AJvYcCVtCVbXxTqWd8j0iqnUVUtV0y676o7hloJkC/zvzAqe1dvIeQ/v80P2y/lXuEc0aQyCyIoadE5XW4GhkNY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCnz0qKidxivm2uUGWxrX3RgiymJE+nkkdYXAiu+2w/jg0sQTV
	cWaSTLzLo70RKx+y+0WxEbnRaNeq+b4R/R3vcifV1DkyyAYbWEa6tvCvYLrE9IYck/6NMG54Tl/
	fgf+4
X-Gm-Gg: ASbGncskK+RkmYe4glMnBG2EKtHfFFPZxD2Sy+Qgdq+ZSoOQdS9WAOQLMD5JkW95/e4
	7eZPP+BDTe4DtR/LPovvJRLI8vW5ianvR++Gj5eeESojAdDPUCgfpyy9DMErO9XVofsGSqtHB56
	x3hm7fffcWcVZI4nTZeYrTTIFV1M2pHQ5VsP9jXwUxHy3gYnoTjeHD/v+tsrqNg4odxnvLQIjpA
	xiqGNcTqUvpb3SqwPY1KeihuU/1CV9LsGdXmd5OML4XYl6O9sV6yVkrZE1UpqLYvKYB2+fOaNVH
	jGACfrHdFdqtFegg82I39DyyS+SEaQ1cl+jJF2Ty+mmArdARfOKI3EIw1NPYXIZVIN0iNSadjX1
	aahs8GeWlzJdh5LXpG7Y=
X-Google-Smtp-Source: AGHT+IFn/Sv03hAbPEtfRtU4QUN2+r1XjoSgvD0vjCMXa7RbcZKdfRXMpo9ZrIkSWyRZyMbwOT6ndQ==
X-Received: by 2002:a05:6e02:378a:b0:3e3:d093:2069 with SMTP id e9e14a558f8ab-3e3f6252f8bmr94184705ab.12.1753927530580;
        Wed, 30 Jul 2025 19:05:30 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3e4029a2ad8sm2678215ab.15.2025.07.30.19.05.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Jul 2025 19:05:29 -0700 (PDT)
Message-ID: <0025981b-9acc-4b6c-a7bb-77bb0e3e543c@kernel.dk>
Date: Wed, 30 Jul 2025 20:05:29 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] f2fs: f2fs supports uncached buffered I/O read
To: hanqi <hanqi@vivo.com>, Chao Yu <chao@kernel.org>, jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
References: <20250725075310.1614614-1-hanqi@vivo.com>
 <d258ab6d-a97a-4232-bf90-5afedd5cccb2@kernel.org>
 <e1a1dbfe-165f-4cb3-9d5b-8ac4ba61265e@vivo.com>
 <087f7937-20b5-4151-8a3f-5b6b2b045b41@kernel.org>
 <b1cf56a6-d23d-40ca-acaa-07944140b1b5@vivo.com>
 <1b420389-d46b-48ef-aa49-585d84e2710f@kernel.dk>
 <d3ced6d7-4037-4962-a2d4-382af0aad4cd@vivo.com>
From: Jens Axboe <axboe@kernel.dk>
Content-Language: en-US
In-Reply-To: <d3ced6d7-4037-4962-a2d4-382af0aad4cd@vivo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/30/25 7:58 PM, hanqi wrote:
> 
> ? 2025/7/30 23:20, Jens Axboe ??:
>> On 7/28/25 2:28 AM, hanqi wrote:
>>> ? 2025/7/28 16:07, Chao Yu ??:
>>>> On 7/28/25 16:03, hanqi wrote:
>>>>> ? 2025/7/28 15:38, Chao Yu ??:
>>>>>
>>>>>> On 7/25/25 15:53, Qi Han wrote:
>>>>>>> Jens has already completed the development of uncached buffered I/O
>>>>>>> in git [1], and in f2fs, uncached buffered I/O read can be enabled
>>>>>>> simply by setting the FOP_DONTCACHE flag in f2fs_file_operations.
>>>>>> IIUC, we may suffer lock issue when we call pwritev(.. ,RWF_DONTCACHE)?
>>>>>> as Jen mentioned in below path, right?
>>>>>>
>>>>>> soft-irq
>>>>>> - folio_end_writeback()
>>>>>>     - filemap_end_dropbehind_write()
>>>>>>      - filemap_end_dropbehind()
>>>>>>       - folio_unmap_invalidate()
>>>>>>        - lock i_lock
>>>>>>
>>>>>> Thanks,
>>>>> That's how I understand it.
>>>> So I guess we need to wait for the support RWF_DONTCACHE on write path, unless
>>>> you can walk around for write path in this patch.
>>>>
>>>> Thanks,
>>> I think the read and write paths can be submitted separately.
>>> Currently, uncached buffered I/O write requires setting the
>>> FGP_DONTCACHE flag when the filesystem allocates a folio. In
>>> f2fs, this is done in the following path:
>>>
>>> - write_begin
>>>   - f2fs_write_begin
>>>    - __filemap_get_folio
>>>    As I understand it, if we don't set the FGP_DONTCACHE flag here, this
>>> issue shouldn't occur.
>> It won't cause an issue, but it also won't work in the sense that the
>> intent is that if the file system doesn't support DONTCACHE, it would
>> get errored at submission time. Your approach would just ignore the flag
>> for writes, rather than return -EOPNOTSUPP as would be expected.
>>
>> You could potentially make it work just on the read side by having the
>> f2fs write submit side check DONTCACHE on the write side and error them
>> out.
> 
> Hi Jens,
> 
> Thank you for your suggestions. I am currently working on modifying
> F2FS to handle the dontcache unmap operation in a workqueue. I expect
> to submit the patch soon, after which F2FS should also support uncached
> buffer I/O writes.

Sounds good, that's the right approach. Userspace needs to be able to
rely on the fact that if RWF_DONTCACHE io is submitted without error
that the target does the right thing as well, barring bugs of course.

-- 
Jens Axboe

