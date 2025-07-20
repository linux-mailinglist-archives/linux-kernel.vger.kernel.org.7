Return-Path: <linux-kernel+bounces-738123-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EFF3B0B49F
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 11:46:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 95FF17AAB1F
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 09:44:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E98041E9B0B;
	Sun, 20 Jul 2025 09:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YGy6qXu8"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B51B12D1F1;
	Sun, 20 Jul 2025 09:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753004759; cv=none; b=VZ7A5EgCJan+80DdLWszcSo1pjpdIBb4RKJrA/FuegY1t1mQkMSF2PeaSkmClM5g8ap3l3bbt+SFItONk9F2DS22XBwf72ivr0VdIhX4r9bVslWASnkOXEOBXQoCrz5JN4tWulGBKpoYAYnTfoQcnbt4gSsu1s7q5rYbZtR7YW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753004759; c=relaxed/simple;
	bh=fWi1BSw48dJ5MnmuCiKh1ZhQTGZGSkNjdo4jWx0gGL8=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=DNUm2DiABbdPFvrur0Ttyy1JzaCUPVEWSgyWjdNIG3fZhdODquHHt250X1BB1oRHU3B/YOSiOxwYGNRtFE+WiKT451xhKOKms2JBT/liX3LbCT57XlqJnP0SF1mxMkW++/vYOPrFXVTppeM0nnEGUcbS1HBKGXxlIXSfAyBJr+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YGy6qXu8; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3a6d1369d4eso1998672f8f.2;
        Sun, 20 Jul 2025 02:45:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753004755; x=1753609555; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Zwjkw9KFxFD4C47j/XMBwDbWOsjV7wxr/S1vVbiJ7vI=;
        b=YGy6qXu8HhT/4A0HkgGwn43DkZQiszp2RtTRHYQIRQiNLSKMjemZp7WSHP3t7fcRMJ
         4XopoPCpwR/aLVFUUS6soHTNTQg/WEfDwIw1aKcpB2JZDhxryqGfAiw0ekWwTKAWm3ry
         pcEW9U/eFNiq2bHfMq5R6zYI5q+0fsJDe5hOdgvj5Jnk90TzsoTy5FgaiU7+4CTppzS6
         C0qmtHPTj7E5ZkNg0BqFpp+kK1FnUNOknmRAq/46fF7N2YXdzD+uZjiMesl4z5T9DwKz
         UNB2HoZd9btsbeUZQIYLjG7OZwocK9sbqojaYZh+kRdl9AEJ+/ismeWPQfUumxdC1n5M
         EyFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753004755; x=1753609555;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Zwjkw9KFxFD4C47j/XMBwDbWOsjV7wxr/S1vVbiJ7vI=;
        b=fspVdrt3YV1S6g2YXoWbJM0WuYL0+bBcuPNtJK5FdUb7lN4Ze2v4dGevCqyE2KkQOd
         BlATfWB04USdrjmYYk0jdBnpgEue5ozQ/9iFO7FRW6dQqKjIQsMFd3VQqPcdMcvIMvRB
         R2w/JCq0nVVwdOcjETRgdRlMRL2n9F29iVgS4+K4Pci3kXY9xJBDLXw94A33oU25v+7q
         ClOItQm8ZAmPKnGNeCYZxI/sHK1tAC8CrlLE2M67FFm6BcUNUkESsPkG7nkoWekQTPzS
         7dimYN2LDTAIYCbsHiFrCoKuG3uIHb6+UnvaemToqHorEFyclwigooPgOzLpcDYj7JyT
         G6ZA==
X-Forwarded-Encrypted: i=1; AJvYcCWKGVahNn47SUeST4DWNSD842daAQbYia8ZiJiBMgSmPRY/YV/yQiI6j077SX1HNkc6SmZiYaYFY8+XH3E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4Wb8NtPIieOr/YkTqdtyES/81SeM5uEstlxpRUtSpWm48ujMz
	qxZdGE/PbnqWh0kWgUKcr9fa4ouMmEcV4TypnYFzVUvoDMsNDnnlct8=
X-Gm-Gg: ASbGncs0spfeD9SqzSN9xiDctIs8BbT2PhVBM6SxUft7JQh93TQIHzD9Jmwompr0aiV
	3CLeF8sa5aeMwLLxL2i0fcdekOIKM/xLh79LrfjqFO+ug/EoTe1kbPdLgUpNo47Vcdk1PDVsvMG
	jtjPBdnEgkmV5jvs6GE0l5TNIOS16a+FLzbUm/mnyo47+HVjZOxGYonkZ0g348qcmPpBZZZVwlT
	OgY+e5MvmEeUVEo1P6a+8fpwu3DR8HddYojzZr7Q702glA10EPZYJNuGkMidnGEkahVg+cVFs1t
	Jm2plBwqoKEBFDXpPHSgnATqLSaK1HtLFMr9CKQxjZ8TTSfkH3A0FFEC7TIQUFKbDBZgOMTxcd8
	Yeg3RFCl9DeMG9B23zNG6iWsgUmZv2QS5fhzWEUqq+vv9CA8nkrL5zbvEK70eLvfbdo3U
X-Google-Smtp-Source: AGHT+IGq7fcfZpYeNzACrrAxWMs1ClbmBrmlPl+zvYuNlRQCCRF3nxdfAa5q1h5I6jmuSNUlkpRoBg==
X-Received: by 2002:a05:6000:4305:b0:3a4:d0dc:184d with SMTP id ffacd0b85a97d-3b60dd95c4dmr14388787f8f.27.1753004754967;
        Sun, 20 Jul 2025 02:45:54 -0700 (PDT)
Received: from ?IPV6:2a02:810b:f13:8500:8b91:8a7e:bd07:2736? ([2a02:810b:f13:8500:8b91:8a7e:bd07:2736])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b61ca2b81asm7107712f8f.20.2025.07.20.02.45.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 20 Jul 2025 02:45:54 -0700 (PDT)
Message-ID: <86814bf6-5d1b-47f3-ad1d-962cae4a543f@gmail.com>
Date: Sun, 20 Jul 2025 11:45:53 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/6] arm64: dts: rockchip: Add ROCK 2A/2F, Sige1 and
 NanoPi Zero2
From: Alex Bee <knaerzche@gmail.com>
To: Chukun Pan <amadeus@jmu.edu.cn>
Cc: devicetree@vger.kernel.org, heiko@sntech.de, jonas@kwiboo.se,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-rockchip@lists.infradead.org, ziyao@disroot.org
References: <104a501d-b9b2-494e-b073-932ddadd7129@gmail.com>
 <20250719143008.54288-1-amadeus@jmu.edu.cn>
 <24ef5e60-dcea-4102-b87f-8a5572c7497f@gmail.com>
Content-Language: en-US
In-Reply-To: <24ef5e60-dcea-4102-b87f-8a5572c7497f@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


>
>> Hi,
>>
>>> The issue I was seeing is that there actually *is* a variant called
>>> 'RK3528' which at least according to the latest datasheets slightly 
>>> differs
>>> from 'RK3528A'. We are doing development based on 'RK3528A' and 
>>> calling it
>>> 'rockchip,rk3528' which might make it hard to add the non-A-variant in
>>> future (unless we call it 'rockchip,the-actual-rk3528').
>> I think this can be ignored, because rockchip only provides RK3528A 
>> chip.
>> RK3528A should be a revised version of RK3528, which solves some bugs,
>> so we have never seen the silk screen printed with RK3528.
> Thanks for sharing that inside.
> I wonder why there's an v1.4 of "Rockchip RK3528 Datasheet" dated
> 2024-05-12 which differs from v1.4 "Rockchip RK3528A Datasheet" dated
> 2025-05-12. Anyway: If everybody is happy as-is I guess it's fine.
>
Just for the record: There actually is a non-A version of the
RK3528, which I actually own (but forgot about - perhaps my subconscious
made me reply to this thread). It's on the Mango Pi MK28 board [0][1][2] -
which, to my knowledge, is one of the first RK3528-based SBCs.

[0] https://mangopi.org/m28k
[1] https://x.com/mangopi_sbc/status/1729384633979322512
[2] 
https://pbs.twimg.com/ext_tw_video_thumb/1729382603202170880/pu/img/k-mVxtpl3ey4V3sX.jpg:large

>> Thanks,
>> Chukun
>>
>> -- 
>> 2.25.1
>>

