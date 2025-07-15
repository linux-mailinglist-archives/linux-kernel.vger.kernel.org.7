Return-Path: <linux-kernel+bounces-731011-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 23039B04D7C
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 03:35:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C84A97AE98B
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 01:34:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41C942882B7;
	Tue, 15 Jul 2025 01:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y7pc4EeI"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5041828853C
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 01:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752543330; cv=none; b=H7x3fHiqGMp7DsabJApoxwr8+wGnjk89D7wQmgjfPO6qO0fGnMHYprtjq+eVt5HXTZfTdVBiyq6B0egG4RNjPlVjVIKia315kBbYZ4DRb+jkZ/eY4L89xgdcYyPc6WIxETJP4JfgsCON/3ndcVD7jAodbCAc2xj1nNgDba+LKQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752543330; c=relaxed/simple;
	bh=DirssM/qiyECs+ZxPsgzPOCIKRmGradbgmdXcGo10pM=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=mT7zfmPmCsx18ongJSDptt6aJ9i+YnWU0JID3kwyQI4QFgnXCTPSQkKtVowX7IOJen68yB530wlFV5djPf3snjrt2+WhXzRGA14bSw4sgfm5KZCmOXN0EpXUoLoNU3VGfBrDnykpHt8pdPA8pvFRWKHEQbBAT8nZ+958KghlpkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y7pc4EeI; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-237e6963f63so28968685ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 18:35:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752543328; x=1753148128; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:cc:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kWqU4b5GJwzvnOMkfXSAT9qnGHhw/SUAFqCu4AE8WQU=;
        b=Y7pc4EeIVdYaTHGmyMf6mYJC9oJh4/yV79nxcTodvLvnyeV4oTdD8aicvxoL/kXtdm
         IKtxzxRMszrj1NcK/2V7+aXTgTQ8c5ILPsQ93i4+bxxuy/yxmGbrSTfc63piJNkaiAHc
         SOww4chqKjcAQ4ilCM+Ptwh72w8Akz3EIGtD8AVR/Myb+VYVVwu9TEtjzZWl3OyaWADt
         daOetTUylZnbBV8FxYjSIxtm7hJQmGkDFeJoKjU2k90CSsKtKLaLKfv2HwbbodmHgxJ6
         b3844YhEDEyWUvLUzGgDkgxRxrhHgl3hKT7ir81dKBm47av5vHAW5dstrYKfTTd6PZOa
         zcyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752543328; x=1753148128;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:cc:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kWqU4b5GJwzvnOMkfXSAT9qnGHhw/SUAFqCu4AE8WQU=;
        b=jIX4EcwFhtXlrDHsrQezsBk2HXvCedzfAABorMBOtGz6RA9uFzBMSro4B9+aWqGcMp
         Yf/QGKaOuMVqEGFg5n2zreyHGU/Vet51f5o5sU64Nt3f3uASHlVquaXOM9VGovtVXX8M
         feteld5ClG6/nxmXuUVdd3hPysE76xmLIGxKXD2lwPpsSKxX+LMi6JOyIr3x/0/TPydR
         chC/bJ+v2nihfN2kgaEVE+kXU4ymxG6WqD+ESFPpPw6HrNr8uvNSZ4P9kjZMDjUxwW3f
         hT8WV+Dbvx8LcGsdzrYpDGDEFFPyCHUULOs2LbrPXqyNKl9DEW/r3zNe0XRY0VQQn2XE
         jIjQ==
X-Forwarded-Encrypted: i=1; AJvYcCUGKiCaijyjEI3ZJZmMyQOMurpCw2sSy0EXsaOtqx+2U7QpZyRD+y4ztzO/ina22nHueqqs4HawCiHdSyg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwuGojonk4cOK9Gr9ihyzr7KJ0aR60+4h9zfrul4xY9VX6k5BW3
	gwI/KH7677/ijBd24sSsiv8mfal5nMEBLvlnkvbWPAQiX4ZGqnJx7Np+
X-Gm-Gg: ASbGncufMhE8Zz/laKhSQVcwX/Q8sYO6c0VOQhRnJp8cZ+pLKmLAKZobACkj16cJQYH
	Q5cKzFuxOCM3Tdrazd50H3VxhhIzIQ8aeXkXmE2lOvzOI9BgsOgdPZsxnfYo3BclmddiBQRyiqu
	uCpNkGSSgd8b2n8+EFuklcnJ9mrfRk5SNiU8C4X1UJx+l1QrYccQjuQGr16/0ZgH4gOvcTp1ACj
	bXVrxhdL2NpgnzWb3Zhz7p99zDxHsf7VXtFBjzdRrhgYVy5L1vinU3XchGSGIdXdkVcimzmKbkn
	mshZE1rVyjNt53D3O85yFasFXXxkauK1VKkBPrgOK69v3keUg4qOGll7WDDisXWteZi/g/+jE9N
	d2t/Jv4So1mxfY1QYRhYuuPXwKYlUtHH4uA==
X-Google-Smtp-Source: AGHT+IHVvu1Myyf/p5AZNRKIaeRyNcKdGWZQBlbrWkXNlWKeq2HAAdsjdVVls1Dm9jFU3glmnLRX8w==
X-Received: by 2002:a17:902:e544:b0:23c:8f17:644c with SMTP id d9443c01a7336-23dee29622cmr226727975ad.35.1752543328542;
        Mon, 14 Jul 2025 18:35:28 -0700 (PDT)
Received: from [10.189.144.225] ([43.224.245.249])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de4334005sm99598725ad.158.2025.07.14.18.35.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Jul 2025 18:35:28 -0700 (PDT)
Message-ID: <17dbffb9-ded6-4605-a7bb-b6f2624313ed@gmail.com>
Date: Tue, 15 Jul 2025 09:35:21 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: shengyong2021@gmail.com, shengyong1@xiaomi.com, agk@redhat.com,
 snitzer@kernel.org, nhuck@google.com, dm-devel@lists.linux.dev,
 linux-kernel@vger.kernel.org, Wang Shuai <wangshuai12@xiaomi.com>
Subject: Re: [PATCH] dm-bufio: fix sched in atomic context
To: Mikulas Patocka <mpatocka@redhat.com>
References: <20250710064855.239572-1-shengyong1@xiaomi.com>
 <673ddfed-d874-9ffe-c2fe-a741e8fc69f1@redhat.com>
Content-Language: en-US, fr-CH
From: Sheng Yong <shengyong2021@gmail.com>
In-Reply-To: <673ddfed-d874-9ffe-c2fe-a741e8fc69f1@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/15/25 01:17, Mikulas Patocka wrote:
> 
> 
> On Thu, 10 Jul 2025, Sheng Yong wrote:
> 
>> From: Sheng Yong <shengyong1@xiaomi.com>
>>
[..]
>>
>> diff --git a/drivers/md/dm-bufio.c b/drivers/md/dm-bufio.c
>> index ec84ba5e93e5..caf6ae9a8b52 100644
>> --- a/drivers/md/dm-bufio.c
>> +++ b/drivers/md/dm-bufio.c
>> @@ -2742,7 +2742,9 @@ static unsigned long __evict_a_few(unsigned long nr_buffers)
>>   		__make_buffer_clean(b);
>>   		__free_buffer_wake(b);
>>   
>> +		dm_bufio_unlock(c);
>>   		cond_resched();
>> +		dm_bufio_lock(c);
>>   	}
>>   
>>   	dm_bufio_unlock(c);
>> -- 
>> 2.43.0
> 
> Hi
> 
> I accepted this patch. I changed it to:
> 
> -               cond_resched();
> +               if (need_resched()) {
> +                       dm_bufio_unlock(c);
> +                       cond_resched();
> +                       dm_bufio_lock(c);
> +               }
>          }
> 
>          dm_bufio_unlock(c);
> 
> so that we are not hammering on the dm bufio lock when scheduling is not
> needed.

Hi, Mikulas,

Thank you for the update. It looks good to me.

thanks,
Yong
> 
> Mikulas
> 


