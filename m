Return-Path: <linux-kernel+bounces-843910-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id BA7D9BC08CD
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 10:06:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 937234EEF8C
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 08:06:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC0CA238145;
	Tue,  7 Oct 2025 08:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ghwOfKNl"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86415218AB4
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 08:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759824412; cv=none; b=LO0TKq8r5pnC42r647Jf2SHGIg4/7M+EUkod7nC90wuRN6mWy0hBtnsQDj8BBn1wxZKkVx696K4npJXwFqRaT/GtD0bxHNraOn5QkhaMHCiGmO+tsrc9b9luvvvAHoiWLscWbj9/JLDmk7QUKLLQJyhLFyYJ4Kys3C9Pplcbz6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759824412; c=relaxed/simple;
	bh=0nuVQOkwJzeH7k9ho0X0QYWBaSW1FiKlHuDOyl8At9I=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=nih/naiDtYnLkpfqc7I9CLcAwa1Dgfxryc/mb63t9utW1z9S6waH61A5iAAFJRFza8ge9VaIbI78/K8wu3k+nTZg5Ju40zpjHF/MjytUCuVukiww+7rl3A22WcS2r3FmvBqFdZAI3DqSmKPkIhlDvX8ewe1wVE9NtNspYa7b/DY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ghwOfKNl; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-46e2cfbf764so7271625e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 01:06:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759824408; x=1760429208; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+DemagZ3lwdnPbdAD7J+Cx+hPerc6FDpVY4UH1BSMao=;
        b=ghwOfKNlAxJnl/QpK+Tx4wr6ORYXHno92o3YfmUZqzquMrncQ7vPHwEaBZGRkPjMFC
         tBsLwTCJyEgD9MQrgwRW2UOmTzBELWH13fbydMrdMuztvMdV0h8HwhlmHBqG4mXislYk
         jeCgS4RRU0Mi/KojdEYXVZSUsmyvPHweARJ4Wsa3VAO7iWzn4P89x2X0zqWpRPxsgJJI
         kuVblAsWGQSRUA5n4k+8nJgj3zcfvHlXWh5JO3UaGXkXUK59BsrbtovkTHuMPB6BarqU
         RxsuaOuHyQzLWg2Hf8y9vHAQ87kJR5qhRXzm2ja2fL1iZKuSg1/jv6UvV3FyZcOES8nD
         J0YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759824408; x=1760429208;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+DemagZ3lwdnPbdAD7J+Cx+hPerc6FDpVY4UH1BSMao=;
        b=jD9CP5Dtl17VB4XNTQQHvh+sPL6OW2dSMpMBuAR3TEmshQ3sDI0kuKUVxzug0lq1aC
         T641ubcIpAjw88FX3hRI5MS0QC9BIJtsIzDwcNkR/rIUMnLSZ5lNkKFWm54EymQ+0SGM
         uNwMsuzyqGQVsynCl75Nx0OSkzILH35l299m0HQ1j40aZc/epNSH0zhnpmGd9+sFUtjk
         OVxmwfvrA2UJe8W2nGD4VbY+T2dnvVXgVRSpBzcsHQCUzcNFUNpf11W8gZqIajugBduu
         wt8d/BdEUGAnSlx6YwRn1MqvABoDecqUd4lfx9uFpc5WKI/TWQNZ+CeypRnf9LF8+h9q
         RNvw==
X-Forwarded-Encrypted: i=1; AJvYcCWfd7ov9pINVEQNUoJC9jrEEINEYeQlmQU5v6vwHQy4w9HveKjwUNP9wNn7w5y+PK5Axj89jfwLYjWwIB8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRInlsOQ1czFzwLRCPN4AEZNbVXHcgM2leL7I/p7RcTJzDXaBJ
	thAEvFXXp8haQ8RURZvFWW9Jr2ZpoACyzS/3lU6GkCAp/TPVUTh7o0bY
X-Gm-Gg: ASbGnctqBc2AzFOnHWIdEAWqkAdREgKtOLDVqnDkbduITVLYCzVrDaLEbY+G2fkJwTp
	pf8YMwArN3XG2lL54zHDpr5OPKVcV/IBe0rnhSQz9kuz6ujAzWrsKT67BX84jmwfMUMIZmbB3wy
	U8SQVEOdfatL6xFcu+lOO4qCGKsRxgGxO32y6fCTIS68fWumQy3TuRncoG3IOig166q9du7RCJi
	fbETEoUNTMGa7MhsB83aiuPRorwIakkFKHZ/zv+pByEgenZtAEpnTCfU/BzUMETiJSA9rZ8qy/w
	QRpVR8VLxShS5N3wyPUxAsBRF7WF29ytXTG4J7m80tZ9ZLtIXOHkzKhdVkj2jA7vaP3yNz+ydlK
	7ebcQn87V84SuYj7DChU1L7vpS76r/pJ/1fQZ8vtP1AD6sDNrJ+CLYPWRt616JRT7g61t7ON/gt
	s=
X-Google-Smtp-Source: AGHT+IG7W8TdSh7hajTVSLVxdSS/RLt63cBB9lWB3+Jv1QSy+dF+pbB9sKZOf60r/31B0nPg2XLA7Q==
X-Received: by 2002:a05:600c:3510:b0:45d:f7df:270b with SMTP id 5b1f17b1804b1-46e710b22c1mr53224255e9.0.1759824407277;
        Tue, 07 Oct 2025 01:06:47 -0700 (PDT)
Received: from [192.168.174.116] ([102.155.185.183])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4255d8e9780sm24118374f8f.29.2025.10.07.01.06.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Oct 2025 01:06:46 -0700 (PDT)
Message-ID: <20f049cc-41f4-4b23-b4a7-5d41dca7c7e5@gmail.com>
Date: Tue, 7 Oct 2025 09:07:01 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/gud: Use kmalloc_array() instead of kmalloc()
To: Thomas Zimmermann <tzimmermann@suse.de>,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, airlied@gmail.com,
 simona@ffwll.ch, mingo@kernel.org, tglx@linutronix.de, jfalempe@redhat.com,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-kernel-mentees@lists.linuxfoundation.org, skhan@linuxfoundation.org,
 david.hunter.linux@gmail.com, rubenru09@aol.com
References: <20250923085144.22582-1-mehdi.benhadjkhelifa@gmail.com>
 <26036ff3-2374-40a9-8597-271b93130a7e@suse.de>
Content-Language: en-US
From: Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>
In-Reply-To: <26036ff3-2374-40a9-8597-271b93130a7e@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/7/25 8:45 AM, Thomas Zimmermann wrote:
> Hi
> 
> Am 23.09.25 um 10:51 schrieb Mehdi Ben Hadj Khelifa:
>> Replace kmalloc with kmalloc array in drm/gud/gud_pipe.c since the
>> calculation inside kmalloc is dynamic 'width * height' to avoid
>> overflow.
>>
>> Signed-off-by: Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>
>> ---
>> Changelog:
>>
>> Changes since v1:
>> - Use of width as element count and height as size of element to
>> eliminate the mentionned calculation and overflow issues.
>>
>>   drivers/gpu/drm/gud/gud_pipe.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/gud/gud_pipe.c b/drivers/gpu/drm/gud/ 
>> gud_pipe.c
>> index 8d548d08f127..8898dc9393fb 100644
>> --- a/drivers/gpu/drm/gud/gud_pipe.c
>> +++ b/drivers/gpu/drm/gud/gud_pipe.c
>> @@ -70,7 +70,7 @@ static size_t gud_xrgb8888_to_r124(u8 *dst, const 
>> struct drm_format_info *format
>>       height = drm_rect_height(rect);
>>       len = drm_format_info_min_pitch(format, 0, width) * height;
>> -    buf = kmalloc(width * height, GFP_KERNEL);
>> +    buf = kmalloc_array(width, height, GFP_KERNEL);
> 
> One nitpick here: the first parameter is the number of elements and the 
> second parameter is the size of an individual element. [1] So the 
> arguments 'width' and 'height' should be reversed.  Please resubmit.
> 
Understood,I will be sending v3 shortly.

> Best regards
> Thomas
> 

Best Regards,
Mehdi

> [1] https://elixir.bootlin.com/linux/v6.17.1/source/tools/include/linux/ 
> slab.h#L15
> 
>>       if (!buf)
>>           return 0;
> 


