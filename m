Return-Path: <linux-kernel+bounces-806639-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1EA9B499BE
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 21:20:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E5F03416CE
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 19:20:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0B31261B98;
	Mon,  8 Sep 2025 19:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="m8mKrQx3"
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D34A62472B1
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 19:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757359198; cv=none; b=QskRtXkYETUWRB+daU5EpyO74OiqFwaWmFBo98/qNz/X9smjS9DBABMPVQULkceD9yoGj29UojfF29NODEAOXp0psAYo3amaBR6+wRCr7pkYgJ0/HnnfTuxc7AcGtUoFoSw1pm/VQ8knNIkJZDcgtCXjpYifo8veM9a28ECWkB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757359198; c=relaxed/simple;
	bh=4e4g1IiZ8YnmsTRTvzVogdSRnaGkWDvyrbvctrtPG10=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G3GUXxCK9cvYmMEjqOE4ziln87p3PTT3g3uagwkhh/n/JFSUYxvDFkyz7LlEv15n/mg+xYj4TBhUgEhgBiBiN77qriG5uFFm9apOjqYqI01Wi9ZpmBuD70eO6xjABTe8kTytAYGqQZ/j6fkAifdp6LzFd6VElJoJweejAGQMX1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=m8mKrQx3; arc=none smtp.client-ip=209.85.166.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-8876de33c86so283352939f.3
        for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 12:19:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1757359194; x=1757963994; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ulKtJOuKiGZPKXYAmUAbPqb1QZQ57vmP9fPSuv2Vk/I=;
        b=m8mKrQx37qo+UVMQpEF9NkimsG4jE635mY8LeOQcNZNs9Iaw+RP0X7Nd771EtOr3Pp
         +iuD8LnTqv9lGPmeJf7IKJledRHTGsS6Me8koRFgF4o6XJKUFG/+OE82pr2j7c+axrA1
         4ckduRUkwOm98h5caV/3Bc0SnN7w7sTxQxUjKS9ku53HQGTWMe17+0RFRlLuj23qS6tM
         gX4wtjEc2aFusW+xCJwvPuct9YfvLVuYzTnCdExDWAH+KujhJi7QGiYUdjQ1NNbAjsC1
         teWgssEFnjP7ViXxnn/RbsQmN1r8IZoLJAkQFZ1YP51vFqQv3LSW9iOtgAaiM5XYkzHU
         frqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757359194; x=1757963994;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ulKtJOuKiGZPKXYAmUAbPqb1QZQ57vmP9fPSuv2Vk/I=;
        b=sxwGvOQxMn7LcB36jFN3GhDe2tdq3dISUfxV5etvY5UvGsp7+fw5AQBOkzsfTI/9fQ
         D1xF+yQ3mnsFM/3Gj4wAc2ZvqDtJzlyFsNod6tAPvId9RcDMXHkJ5a5MKq2F1Ye5ujYa
         f28QquqmLC3ffN4JOPH7JvGBLFItXQDmMSTiCaK1qyvgjeJNCWgGh+oHGIBQh/ycBj+a
         YF0Sdhd0ox7oJI+ONuEn4gn7CtDG3zRK2b/eLDAtsFT27BOULIX6utWaa4UlG3DfSSXv
         9/GSktomWAqR8IKmdCxOm2uUxBUNfCHE0keEYKexXucFnYEkYzwZ3gYk5F5UtOAFGr9+
         ICOQ==
X-Forwarded-Encrypted: i=1; AJvYcCWYpKJnyOp1ZpcyfsqQqwykZqC155cTwX4qNB354wLqJpEn1Z48EKFm5MC3HwCDwfFHh64ya4O/gJ+wjwo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQQZUMljacImu+M2b1AdV67Zb04lT/2kqRKcRMyUiXG/C5BuTX
	bP8bmkZCK1sEbhsmUmS4hy7VcKvTqiE7pWoftgNo0rGOj3Sw5v0d5MLDC9Y7fbU5eps=
X-Gm-Gg: ASbGncvlImqhoqM0pcrC1YTVyBT+ujR6P9bnAblQakgqJlmZxfgleMG4pUP0Cc8Ym06
	mbKjuKLN4nBf6rhyDrx+JNQ9VZ3hQDbaU9j1VKXbiEDCnyS349Kw8HNs3x9zbykgHgmg5nKs3of
	HhzTZdLpzeZi0OMDNE05bkBGfEYhdr1a5o5v99nc0QJ2YcAa4hdDCiePjeUXKjBZQPYi/bWelrs
	2V/rjmPxWklaWq9OS6SnI/4hRugvjY7vWkyqRgUGrn7vDO+vKdCo+wqEWLOd/VZfvXLx1Qyh4xC
	8E2BjnlxS0EXnLJrZx8+GpZ7iiM4SPTPu/SU6jayW4TEV8FdUUitRF417mUpyhci6P5oL7QcgLU
	FHjcJpSud2kufY8CsKcw=
X-Google-Smtp-Source: AGHT+IGXrqO2/TmlaLxs2btRyugMh/qdnCVxn01lCsIFTUtgLR+a8XDso0hWxX40MNNYPrNSIMsuzw==
X-Received: by 2002:a05:6e02:178d:b0:3fa:e602:737 with SMTP id e9e14a558f8ab-3fd94a140b0mr136360485ab.17.1757359193811;
        Mon, 08 Sep 2025 12:19:53 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-402758bb0f2sm23808205ab.39.2025.09.08.12.19.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Sep 2025 12:19:53 -0700 (PDT)
Message-ID: <2e424956-9884-48fc-93ad-de0d08f3485b@kernel.dk>
Date: Mon, 8 Sep 2025 13:19:52 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/5] io_uring: clear IORING_SETUP_SINGLE_ISSUER for
 IORING_SETUP_SQPOLL
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: io-uring@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250904170902.2624135-1-csander@purestorage.com>
 <20250904170902.2624135-4-csander@purestorage.com>
 <07806298-f9d3-4ca6-8ce5-4088c9f0ea2c@kernel.dk>
 <CADUfDZovKhJvF+zaVukM75KLSUsCwUDRoMybMKLpHioPpcfJCw@mail.gmail.com>
From: Jens Axboe <axboe@kernel.dk>
Content-Language: en-US
In-Reply-To: <CADUfDZovKhJvF+zaVukM75KLSUsCwUDRoMybMKLpHioPpcfJCw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/8/25 12:11 PM, Caleb Sander Mateos wrote:
> On Mon, Sep 8, 2025 at 7:13?AM Jens Axboe <axboe@kernel.dk> wrote:
>>
>> On 9/4/25 11:09 AM, Caleb Sander Mateos wrote:
>>> IORING_SETUP_SINGLE_ISSUER doesn't currently enable any optimizations,
>>> but it will soon be used to avoid taking io_ring_ctx's uring_lock when
>>> submitting from the single issuer task. If the IORING_SETUP_SQPOLL flag
>>> is set, the SQ thread is the sole task issuing SQEs. However, other
>>> tasks may make io_uring_register() syscalls, which must be synchronized
>>> with SQE submission. So it wouldn't be safe to skip the uring_lock
>>> around the SQ thread's submission even if IORING_SETUP_SINGLE_ISSUER is
>>> set. Therefore, clear IORING_SETUP_SINGLE_ISSUER from the io_ring_ctx
>>> flags if IORING_SETUP_SQPOLL is set.
>>>
>>> Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
>>> ---
>>>  io_uring/io_uring.c | 9 +++++++++
>>>  1 file changed, 9 insertions(+)
>>>
>>> diff --git a/io_uring/io_uring.c b/io_uring/io_uring.c
>>> index 42f6bfbb99d3..c7af9dc3d95a 100644
>>> --- a/io_uring/io_uring.c
>>> +++ b/io_uring/io_uring.c
>>> @@ -3724,10 +3724,19 @@ static int io_uring_sanitise_params(struct io_uring_params *p)
>>>        */
>>>       if ((flags & (IORING_SETUP_CQE32|IORING_SETUP_CQE_MIXED)) ==
>>>           (IORING_SETUP_CQE32|IORING_SETUP_CQE_MIXED))
>>>               return -EINVAL;
>>>
>>> +     /*
>>> +      * If IORING_SETUP_SQPOLL is set, only the SQ thread issues SQEs,
>>> +      * but other threads may call io_uring_register() concurrently.
>>> +      * We still need uring_lock to synchronize these io_ring_ctx accesses,
>>> +      * so disable the single issuer optimizations.
>>> +      */
>>> +     if (flags & IORING_SETUP_SQPOLL)
>>> +             p->flags &= ~IORING_SETUP_SINGLE_ISSUER;
>>> +
>>
>> As mentioned I think this is fine. Just for posterity, one solution
>> here would be to require that the task doing eg io_uring_register() on a
>> setup with SINGLE_ISSUER|SQPOLL would be required to park and unpark the
>> SQ thread before doing what it needs to do. That should get us most/all
>> of the way there to enabling it with SQPOLL as well.
> 
> Right, though that may make io_uring_register() significantly slower
> and disruptive to the I/O path. Another option would be to proxy all
> registrations to the SQ thread via task_work. I think leaving the
> current behavior as-is makes the most sense to avoid any regressions.
> If someone is interested in optimizing the IORING_SETUP_SQPOLL &&
> IORING_SETUP_SINGLE_ISSUER use case, they're more than welcome to!

True, though for most cases that won't matter, but for some it certainly
could. I certainly agree that this is a problen that's best deferred
anyway, SQPOLL is a bit of an oddball use case anyway.

> I appreciate your feedback on the series. Do you have any other
> thoughts on it?

Looks pretty clean to me, no big concerns honestly.

-- 
Jens Axboe

