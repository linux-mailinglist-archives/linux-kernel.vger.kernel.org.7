Return-Path: <linux-kernel+bounces-750973-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A901B1638A
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 17:21:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 172A71AA3DCE
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 15:21:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 730FB2D9EEA;
	Wed, 30 Jul 2025 15:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="O1U5Bewq"
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1B8728726C
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 15:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753888860; cv=none; b=d+A+extxT4WQjFnCrIcjeGPMGpAoVdphbCUNlq1RwR6lU7r4pSl8+XbkaozWackDQnpXnofu61jsKAeXqpJAu4kgb399q36YOUO54yZKXTFLCvMdj9pb4jL55I2uaDaO1uCBg5SGmp0cuwMep9VFNKXO18yKNUBJa0qVVkf8g2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753888860; c=relaxed/simple;
	bh=Ht2ar+uJvSuCh1Ikj4KCGSwv35IuRlbJLzN8oreri/M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kPXo8C7/soYy+0AXmYBvA/UBAUY6TMq7wFTZ9x8l7TZsl4UQRn4iF0mg1tUTHFBpqJC5/ojCAAZoaU6ezhc06Tu19GrKpPCEn8OaGEqGx9nVbpQ6iVDWr63S0tHpk0oFPY21X5Z97+ebVdvQtUxbQGBdP2trCrf5bHsGXkLMicI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=O1U5Bewq; arc=none smtp.client-ip=209.85.166.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-87c3e35b3cbso62511339f.2
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 08:20:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1753888857; x=1754493657; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dGvN81tK3SiKuUwwOdxVCQ6vX1YLyW1gSNQPEFsAu5s=;
        b=O1U5Bewq+McHAMFL72hbHG/9pPSqZpacW33QB46kuoWfNG7MMCG2oAGez00Xv8ITYk
         sLzVI4tJ9zV9PhvL8wupihRyqoiawOoBaTGO8u3Nq/8s+eXxev4A3GsaACCgG+I6Ry1l
         Wztjr62n9LgnwNOAYQKs/Twd+x7e8LgdE1tyBtJQs2Ft60vS0E9i0dsgHerGWbs6gjC0
         2H7cxUM7U0//R8CCNqpaCsjgy3GWQcbLE9yaaMvzgcUKcd/UdO5yy7K5HMrF8OZfoP8m
         3EsrHqRyotIWsZ0Sq48+9xlFc3rN69M5EssLXGZ+BMA78qR90TGkLHGpzgCdDefs8YUC
         y4cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753888857; x=1754493657;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dGvN81tK3SiKuUwwOdxVCQ6vX1YLyW1gSNQPEFsAu5s=;
        b=EgRv72XF2dRPd5MS+kE0T8YWOb5WcJS3Dma33C0v+ExBngVTZUdiuiv875YmVcmyNu
         sujRbuw2jHisigdZYMh5uhHO5JlF0xhZYNGZ6a8L5njJq5OFiisOwe35/v4nTvEGyFEF
         LFw48qTHe8BMy3iBkiixV6goarmpwh1rqSWw6pCVi1F+GSX9n0yPWZQsq8LdhGPP76A1
         PXtINX0h0U75SeXiFD/v/Ikpqp5Kh4HmZA9X7Sze5+pfSS7mTOGFXe3pBp+1Qy+Vkpg8
         tUtbZoL0/89NduCJG0NOUF7MyNkrgAaF9Bj3YehkKNILa0E4tr/gD9772g1MmwnVaddo
         o9kQ==
X-Forwarded-Encrypted: i=1; AJvYcCXCkjias1SjT6Q9b2Ok/XvQ7uVs6rRU1004s1xXiU9oWZmls3B9/3lWqcepH3cGIr+QbE5foshv/sF04tw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2g2u7Q3quvm38QsqaT31F/upRIdhP4Ll1O6BGfYmII87tqXSY
	FJ+X7w5kYJ2Elywv+JnCRhDc54dof4aJ4GvNPUqNTI5dtPiV5MZ5xY07lT8mhE8QWr8=
X-Gm-Gg: ASbGncsxvdeBSs8tlwMEfsK91rUE9xqqZwibS2/J61mYRLnZl2f1J58OGYEORYDbEul
	tlE/5HmzXS0tzKbdiLmWcD47b6dxj0wO/+c7KKDqpD5UnpXeU0BQpz+QOzMjtSWCwstaWu39Cit
	A5w7N1DDg+GlERp/C89nUhN1BxGKLXdBKoZCy+J0zw0sZ8g3luwjaUR8CtUzW6Y96QwWnMDt1/p
	cd67rkoaVifEF/BKWnMSE7If8zoskT2S1kvZWbCqoL0sJjUNo8t+655Qkef/Ko5xkp0WkPHwK/F
	Ba+DpLGF9W2UYJ0uMSLs4GYplJsf16EihIEvVofSpzx8GrcrkCtl2ADzu309rh/UWR6leNnx6k7
	/rKngCczRbPJgl3Hh1g==
X-Google-Smtp-Source: AGHT+IEYoOQssgXqmLYl6Ge/P/+WMJXz1cstrJMMaV4kH+gwrSXxse4HeKT5xLsNZC2QjL8pj4jG4g==
X-Received: by 2002:a05:6e02:2388:b0:3e2:9253:a19 with SMTP id e9e14a558f8ab-3e3f624cea4mr59279225ab.13.1753888857506;
        Wed, 30 Jul 2025 08:20:57 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-508c93751a4sm3317700173.96.2025.07.30.08.20.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Jul 2025 08:20:56 -0700 (PDT)
Message-ID: <1b420389-d46b-48ef-aa49-585d84e2710f@kernel.dk>
Date: Wed, 30 Jul 2025 09:20:56 -0600
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
From: Jens Axboe <axboe@kernel.dk>
Content-Language: en-US
In-Reply-To: <b1cf56a6-d23d-40ca-acaa-07944140b1b5@vivo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/28/25 2:28 AM, hanqi wrote:
> ? 2025/7/28 16:07, Chao Yu ??:
>> On 7/28/25 16:03, hanqi wrote:
>>> ? 2025/7/28 15:38, Chao Yu ??:
>>>
>>>> On 7/25/25 15:53, Qi Han wrote:
>>>>> Jens has already completed the development of uncached buffered I/O
>>>>> in git [1], and in f2fs, uncached buffered I/O read can be enabled
>>>>> simply by setting the FOP_DONTCACHE flag in f2fs_file_operations.
>>>> IIUC, we may suffer lock issue when we call pwritev(.. ,RWF_DONTCACHE)?
>>>> as Jen mentioned in below path, right?
>>>>
>>>> soft-irq
>>>> - folio_end_writeback()
>>>>    - filemap_end_dropbehind_write()
>>>>     - filemap_end_dropbehind()
>>>>      - folio_unmap_invalidate()
>>>>       - lock i_lock
>>>>
>>>> Thanks,
>>> That's how I understand it.
>> So I guess we need to wait for the support RWF_DONTCACHE on write path, unless
>> you can walk around for write path in this patch.
>>
>> Thanks,
> 
> I think the read and write paths can be submitted separately.
> Currently, uncached buffered I/O write requires setting the
> FGP_DONTCACHE flag when the filesystem allocates a folio. In
> f2fs, this is done in the following path:
> 
> - write_begin
>  - f2fs_write_begin
>   - __filemap_get_folio
>   As I understand it, if we don't set the FGP_DONTCACHE flag here, this
> issue shouldn't occur.

It won't cause an issue, but it also won't work in the sense that the
intent is that if the file system doesn't support DONTCACHE, it would
get errored at submission time. Your approach would just ignore the flag
for writes, rather than return -EOPNOTSUPP as would be expected.

You could potentially make it work just on the read side by having the
f2fs write submit side check DONTCACHE on the write side and error them
out.

-- 
Jens Axboe

