Return-Path: <linux-kernel+bounces-828850-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51614B95A27
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 13:25:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06C922A4991
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 11:25:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46C9A322549;
	Tue, 23 Sep 2025 11:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="XjMHEih1"
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49EFF2F6184
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 11:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758626724; cv=none; b=uB1uHpNXVAwQjg/ulROdOMtzlGmJU3o8fGVhBvKuuCNbYlcloa/0t96gz9ahdyHXNb4f5bTNll4NT7Bqlh+KCcI0EzJKBgvS1zUYmgr85zGsyZjMKKWIYeAxKR9/koqWyGQPEqbmh5yvbDJsrRctoLoTcaCGrKT1gGTIQXx2aBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758626724; c=relaxed/simple;
	bh=9bb7cenbRAabK1eUQqUZ/f1wVe95eLsoBOmqPKJ7uVY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Bl14isi/efZcIclc8KDdbJjPVjEu/RK/30Gksh/SACNpNJNYt6rcyfeRStmCkAWG+ecYrFuqkgdvuFGcm+mjLK7/3fZYmVv0xpCN3Sjd+if03c+5uCH/X1U5BzFmZCCC70tInJqr1Dzn4xp3gt3ca6pFw40Z2kaG3wv8uLjKh0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=XjMHEih1; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-eab80c807faso2791852276.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 04:25:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1758626720; x=1759231520; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8OlNXv5M4hnSJGnXD2+q1Q2fYJOPGtK5Q0KIhQM3t9Q=;
        b=XjMHEih1qNsY8KU8h8NVwHBs7oZxKNRK4Lz4MF6rw49Pm5b8o2JkJBIcYRb6BkhhRu
         nu4QkuCjB5z3akduXu8Ez5w0A5dUWxj5PK9U5ipCrj5UV5vmmIgmlliwdQFfbuBYeKdC
         ZdK6HxGKx08POMrhvRe2l87/Np/aNH1vwZ6kHt/6oz8HHidScPKVIFDfPxi6zLz2wvSt
         6ZCBV07sl9qXhupshR8kFJL97aklNr/5cqYAwq3UY/KuiHcG1BolmEDarYq640cMQ6KG
         nIBiQQqz42DkHnGHmcKfkz2K6zyhsi4xMnMEpD89OAD+Thi4HmL5saXdeO7UbGfKQD0+
         aN8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758626720; x=1759231520;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8OlNXv5M4hnSJGnXD2+q1Q2fYJOPGtK5Q0KIhQM3t9Q=;
        b=QlDy4BUcj+AaScVfs21kapwkwOcT2p8CFDbSDNB6tTAX3hMwNhtlRy9S+i1uWEGLci
         MKE4yNb0bIlh97HPsq0H3oQy2wwIWbHSKA3K0ny6Vmy1miNUT8jtZHMEtG28rnjf8EG+
         eUuQIb9Gjp9ko8DWqWmci3Dxr9vK3sKajoaAw2Q+GODyy8+qI2TLdAh7TNKxWb5w4kQa
         PI7ZTpSemhO6IVwBR8v+hVfnQhj6nok/RLeI8pOBV8T8xTD7JKw+Ue4/o2+1eHZ2EhSe
         F/GQfViIHp4audyZ3ozZWeMVj4RiE9xH+tbKrelz0Rt6CqXpUaGMPVRwd1tzDH111bLy
         hkqA==
X-Forwarded-Encrypted: i=1; AJvYcCWuKkKvMOrCquX5ohg29Mg/wKZibPXZ/o5qw8iq1mYtnMbTmiQXCiDz/BxwiS3G0zl0/sAdAq6BQqlhMws=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzn+uc3uG12cmtJblfF60o6gTlPXGCubbyLxmCHcIdL0N4GESep
	k2EmNKI0JwXaHzNNu7isxiVsOb1f7gRXssOHv+h23H69AOWoEcufaHevofn+65wE1+M3E5sPQi8
	MtWGMjXI=
X-Gm-Gg: ASbGncvXqQPtGJ6HjfxKzKatAhZzfUBGqE/V1+VKrD7WwYzMP5JoxRCpQa0cDLLc3rS
	yD5hbvzdp/Pj0VhmB/3uuhAltBoj4kjPEugg+Qam8lH+k/HBMrjiG50urgmMDEFtGJzVKCP1Jbs
	vXC74lMWr66Y6kBx067Rv0CyHblRCK5J8R407pEV7wYjiP2hG5uKotMK52vvMFUqju7+dW5EymW
	bh9XyfsjjHeLPvk5kUtzsESy6SFBXlgwS5vj4xEIS1OGbr+7aXRf/GphxiXUdnfPy+1MGOEqvI5
	3nqRAphkp6fgZpNJSly63sGV5Uwz8vxKKJcUwZbG4AHSVoOBF6SZSy9+spxLh+fKL8QecXB88kf
	gWqM2XtmWcVCFW2mtu9GTY0kElt1WPjOZ2evgvnM8XMoBz9qze+DwVCsECdveUKU0YA==
X-Google-Smtp-Source: AGHT+IF4SzWn3vtQifv883LV9d3tomZRn0WL6hS9NJ6ytkSTfUKzd7vsmbPAK1Fx8oxblnSuZUlpbg==
X-Received: by 2002:a05:6902:2807:b0:ea4:1522:4d00 with SMTP id 3f1490d57ef6-eb331236497mr1643185276.53.1758626719998;
        Tue, 23 Sep 2025 04:25:19 -0700 (PDT)
Received: from ?IPV6:2600:380:527c:43cf:9b4f:680a:1ae0:9de3? ([2600:380:527c:43cf:9b4f:680a:1ae0:9de3])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-ea5ce72a110sm4949983276.14.2025.09.23.04.25.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Sep 2025 04:25:19 -0700 (PDT)
Message-ID: <f6d995fc-daba-45e1-9fbc-18b7e5723b69@kernel.dk>
Date: Tue, 23 Sep 2025 05:25:17 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] io_uring/rsrc: remove unnecessary check on resv2
To: clingfei <clf700383@gmail.com>
Cc: io-uring@vger.kernel.org, linux-kernel@vger.kernel.org
References: <CADPKJ-7cb9fcPbP3gDNauc22nSbqmddhYzmKeVSiLpkc_u88KA@mail.gmail.com>
 <b0b0db4c-ac91-482a-85a4-2acd2884e5ae@kernel.dk>
 <CADPKJ-78+=j_HkUcJt2k6Xsn-fjs8=xT97j+coWNAEzTFvHr6g@mail.gmail.com>
From: Jens Axboe <axboe@kernel.dk>
Content-Language: en-US
In-Reply-To: <CADPKJ-78+=j_HkUcJt2k6Xsn-fjs8=xT97j+coWNAEzTFvHr6g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/23/25 3:10 AM, clingfei wrote:
> Jens Axboe <axboe@kernel.dk> ?2025?9?23??? 16:50???
>>
>> On 9/23/25 2:41 AM, clingfei wrote:
>>> From b52509776e0f7f9ea703d0551ccaeeaa49ab6440 Mon Sep 17 00:00:00 2001
>>> From: clingfei <clf700383@gmail.com>
>>> Date: Tue, 23 Sep 2025 16:30:30 +0800
>>> Subject: [PATCH] io_uring/rsrc: remove unnecessary check on resv2
>>>
>>> The memset sets the up.resv2 to be 0,
>>> and the copy_from_user does not touch it,
>>> thus up.resv2 will always be false.
>>
>> Please wrap commit messages at around ~72 chars.
>>
>>> Signed-off-by: clingfei <clf700383@gmail.com>
>>> ---
>>>  io_uring/rsrc.c | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/io_uring/rsrc.c b/io_uring/rsrc.c
>>> index f75f5e43fa4a..7006b3ca5404 100644
>>> --- a/io_uring/rsrc.c
>>> +++ b/io_uring/rsrc.c
>>> @@ -372,7 +372,7 @@ int io_register_files_update(struct io_ring_ctx
>>> *ctx, void __user *arg,
>>>     memset(&up, 0, sizeof(up));
>>>     if (copy_from_user(&up, arg, sizeof(struct io_uring_rsrc_update)))
>>>         return -EFAULT;
>>> -   if (up.resv || up.resv2)
>>> +   if (up.resv)
>>>         return -EINVAL;
>>>     return __io_register_rsrc_update(ctx, IORING_RSRC_FILE, &up, nr_args);
>>>  }
>>
>> White space damaged patch, but more importantly, I don't think this is
>> worth adding. Yes it'll never overwrite resv2 because of the different
>> sizes. Curious how you ran into this?
>>
>> --
>> Jens Axboe
> 
> During my review of the io_uring code, I noticed that
> sizeof(io_uring_rsrc_update) is used to initialize a struct
> io_uring_rsrc_update2. My initial suspicion was that this might be an
> error, but upon closer inspection, I verified that this usage is
> intentional and correct.

Gotcha. Yes it overlays the struct. I'm not vehemently opposed to your
patch, but it'd be nice if it came with a comment as well as to why just
checking the first part is enough. And, of course, with the other things
I mentioned fixed too. So feel free to resend, if you wish.

-- 
Jens Axboe

