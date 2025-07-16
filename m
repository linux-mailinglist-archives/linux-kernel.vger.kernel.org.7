Return-Path: <linux-kernel+bounces-732821-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27EB6B06C6A
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 05:43:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 291014E175F
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 03:43:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BBD627281D;
	Wed, 16 Jul 2025 03:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="W9CHQ1+/"
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F34631D63C2
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 03:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752637418; cv=none; b=QiMxWa/lVBrpQe+I2EZxFwvhCexQe/NBlDWjFlVTmXPoZLgQZPXETzdJubCOtLM2OKd0LPApj1GNO/diqkSd9jqR1kHTwPp7WWKbW6UYyWThwGWqMWt9IDFnYGPJPE9x6c4VQ6cri3Ue5T6Y+J96Mn7ZQafCQR4PGvqKtoN1NZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752637418; c=relaxed/simple;
	bh=nCAGHOxBrWJMiNmuV6rU+Bsoovnn5lhKXQbZkBf6elA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XBVxoC0hpmRTakZ5x8oFkR/4kV+hdHKy4LMl/2EyzY6sXPq6JXOXCa/nqMX6uBDlfY6em73q9LMrzTZYiNJx3nfmasM2wqIK+OhjFEGuBRPTSWHzwl6NKnqlaqpPbdlIoiePSt8E5ry6EVkNvysmnBbanvKLewRzJGeG6365tZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=W9CHQ1+/; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-3e057f2c8d8so48952715ab.1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 20:43:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1752637415; x=1753242215; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kRywPbjPUNECVqSBDs9YEV41gpTJb8HiQEnMySC/yNU=;
        b=W9CHQ1+/nmyUZ8YwZKWDMGQR/qXuL65XqySM0IrFePyV/hQwP3/mp4SOYRTTMHXgqo
         xKRbRAGVPf0apH9u15r7bFAASu+QqCNN4XQK23H+d/GCr5ce5934fqRSlfff/iG95JnH
         uT2Tx9dgggcBNQ8bxfqmyfTO3lIOfu3utJJPNI4qkEi8CBl+cS4gwSwmHQlLvB5Tdy/8
         ChQVHnll6SytBFDZMfRvS8JbGkV7oslANyIb7sE718ryL4Cdhu3EjuC8v/DxhVtvRcue
         BiG8LGn6Hu/BO7nc89+osDTwy42dIXHmCIKzwCIvbxdBVJ8T3YMmZJiF2ZdQs3N4fkrH
         00MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752637415; x=1753242215;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kRywPbjPUNECVqSBDs9YEV41gpTJb8HiQEnMySC/yNU=;
        b=GdPIXDpwqTw+FHG5aqowVYmz07sWu8xcDQ05A/w6yvFPGg44BQLjhUL92eaHwrhF9n
         4kAwHMkZfZgNigJiVsJxK2l5MqWZ0IGKcFodXscZ4yUzakgi9ViduA47+EfiI9g9mHww
         Sl/oy97gUhmaypWP1/kgtZgw5E9zZi3kI1nXW8zdzgDnnxcATd5LQo5pmgo7DRFcdfFI
         uz2UDYCyTjCTjYqQP142fNMnSKBMtHx+NctHYPAn0MRNBhZ0HICTUlfgTzikj9eGgcy+
         kMWfXRvWNPAcVwtdcClelEBHK4e01q4zUOfzp5ZfpIHvd4tY0g3tkgsHBEkygSjsSokV
         isVQ==
X-Forwarded-Encrypted: i=1; AJvYcCUrdGzDmz3Kjth7oSKO36Oq7fp6lHkYpsNZGT2+fM+7B93mgzvhCf3rB555kRc5MqUwuS4wlF9OgSh9vuY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxR1/YVgMcBaOYGKtgmBNTdAJcdF1rPrIs24/X5E1XK4b4lR5Q/
	CG0QsBSgtYfIYaYHBAEPfVWvF0SXA7ICC4fOg+mGMeNd30obUAEubWirE6m28BOeu+0=
X-Gm-Gg: ASbGncttHRWOg5v0gLHVp3/IP5Y/XCB0URlLgLBqQIomwGxRewzmd2nH96jgMSXqU4M
	5Rc4zJRN/Hw4Wqq4+PwTQm/GRW0CCZfbHcF5k9UoQOycwjoYueK9fY4JClMmTBc2jfIJJdyZFxJ
	JCFQ+VcPeon8yLShkKn+YIZvRvHPhGOYFELOLJFjq1AouSzyyH3atjODGsravtX7jM07dPI6bwd
	2Zn1b2G1uUv1w/7M3a2rvBGf7LmNMVa2O0lOD6H2yzi8uYLGZIJVTqVY7chBa5wzX2U/pWUBX0i
	OfYS5WHRWi7tTyme0REZr+lpHPkG4m3YhmH0FOlsIWwEMKWIJ2xBLMMUeSFzCEVQFqiGWJFGcGm
	i3DZJY1/zSCBvhq2s1dY=
X-Google-Smtp-Source: AGHT+IH02x1phQkO00qnSsbe4+BZhG/aefkD3YoymzBKr1j8mthw1kEynEw5v/HN7uryywBkg+07QQ==
X-Received: by 2002:a05:6e02:1566:b0:3dd:920f:d28e with SMTP id e9e14a558f8ab-3e282420e2fmr14473775ab.13.1752637414673;
        Tue, 15 Jul 2025 20:43:34 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3e24611e6cdsm42309755ab.3.2025.07.15.20.43.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Jul 2025 20:43:33 -0700 (PDT)
Message-ID: <51168786-6c30-4065-be82-6d07b2ae74a8@kernel.dk>
Date: Tue, 15 Jul 2025 21:43:33 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] f2fs: f2fs supports uncached buffered I/O
To: hanqi <hanqi@vivo.com>, jaegeuk@kernel.org, chao@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
References: <20250715031054.14404-1-hanqi@vivo.com>
 <056e083b-8e41-45a2-9b0f-2ec47d1a9f71@kernel.dk>
 <f7408161-eaef-47ed-8810-8c4e8f27bfc6@vivo.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <f7408161-eaef-47ed-8810-8c4e8f27bfc6@vivo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/15/25 9:34 PM, hanqi wrote:
> 
> 
> ? 2025/7/15 22:28, Jens Axboe ??:
>> On 7/14/25 9:10 PM, Qi Han wrote:
>>> Jens has already completed the development of uncached buffered I/O
>>> in git [1], and in f2fs, the feature can be enabled simply by setting
>>> the FOP_DONTCACHE flag in f2fs_file_operations.
>> You need to ensure that for any DONTCACHE IO that the completion is
>> routed via non-irq context, if applicable. I didn't verify that this is
>> the case for f2fs. Generally you can deduce this as well through
>> testing, I'd say the following cases would be interesting to test:
>>
>> 1) Normal DONTCACHE buffered read
>> 2) Overwrite DONTCACHE buffered write
>> 3) Append DONTCACHE buffered write
>>
>> Test those with DEBUG_ATOMIC_SLEEP set in your config, and it that
>> doesn't complain, that's a great start.
>>
>> For the above test cases as well, verify that page cache doesn't grow as
>> IO is performed. A bit is fine for things like meta data, but generally
>> you want to see it remain basically flat in terms of page cache usage.
>>
>> Maybe this is all fine, like I said I didn't verify. Just mentioning it
>> for completeness sake.
> 
> Hi, Jens
> Thanks for your suggestion. As I mentioned earlier in [1], in f2fs,
> the regular buffered write path invokes folio_end_writeback from a
> softirq context. Therefore, it seems that f2fs may not be suitable
> for DONTCACHE I/O writes.
> 
> I?d like to ask a question: why is DONTCACHE I/O write restricted to
> non-interrupt context only? Is it because dropping the page might be
> too time-consuming to be done safely in interrupt context? This might
> be a naive question, but I?d really appreciate your clarification.
> Thanks in advance.

Because (as of right now, at least) the code doing the invalidation
needs process context. There are various reasons for this, which you'll
see if you follow the path off folio_end_writeback() ->
filemap_end_dropbehind_write() -> filemap_end_dropbehind() ->
folio_unmap_invalidate(). unmap_mapping_folio() is one case, and while
that may be doable, the inode i_lock is not IRQ safe.

Most file systems have a need to punt some writeback completions to
non-irq context, eg for file extending etc. Hence for most file systems,
the dontcache case just becomes another case that needs to go through
that path.

It'd certainly be possible to improve upon this, for example by having
an opportunistic dontcache unmap from IRQ/soft-irq context, and then
punting to a workqueue if that doesn't pan out. But this doesn't exist
as of yet, hence the need for the workqueue punt.

-- 
Jens Axboe

