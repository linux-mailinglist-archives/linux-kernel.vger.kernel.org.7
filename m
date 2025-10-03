Return-Path: <linux-kernel+bounces-840967-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DF92BB5D67
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 04:55:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 830FA4EAA7A
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 02:55:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E16882DC797;
	Fri,  3 Oct 2025 02:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A6zridJU"
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 108F2285075
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 02:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759460146; cv=none; b=aTFMk51vEmvXHO8nSA/133/UkJ+usU6cUSdMd0vxCxHb+MqXopvMjMshnMc45OCUAPbUSewTtZN8HZxbKT6+BmU3RBC2S1n0GSYe638olgrTbJeRGyouAfQ1Ns1d2UG1zBhBXx3ohhL4tS2DCyPFz2Ukor7xEkK6jdjJ8KWZ+DY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759460146; c=relaxed/simple;
	bh=IbqIfwodQqiBv6KC6vQja57uOyoAxGxu3556N+ke0bM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=le1up1btkSEA2coSJGjFbZfNadpMN9yjwXyyI6zwKSjhGnSMgMn/wYtzHOaknCV1mwJO4gGvPZIC1+jUOUQka9LxHKrYN217SexPTqr2q6pXiQXNAGhX03NGiheJZycxnYybs+MhRMBqVM4wQy7+YXqCwDFCrmmxK/u6cmHaLlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A6zridJU; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-3352018dfbcso1533718a91.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 19:55:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759460140; x=1760064940; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3XzN1IX0x1HKKD8cWvxUYr0p4ZQjvWytXA8ADa16YOw=;
        b=A6zridJUpXEWHRKXQBQYefaJbIYMHtS4qcYF6r4rXrsxoXWNBvTTdylqs1CLy/dVux
         65hjoBeJO/kUUV95Ot4I3az80UUBpqAxRnY7rKdW5Y+cFx75sQVZM0XisRZ0E0wtXgV3
         fqXrL1kyP0LnsSE85LBJd55RXLhPABo69KQ7kvi8XUZxI3XV54XpiG2KGS9U+30WOk2D
         D7Z1WDZulRvGmxCvw6qGnDzzY/bng86isvcpG4I8mbSGhcNs7BJfLYYzn4Vgt6JsyMrK
         rCzVQ66/v4SCrTZXl8FAz/gbXKf82H6jpKjELrGg7iSSdIb0nTlaleOzgXnQYr3/SNjg
         9RHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759460140; x=1760064940;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3XzN1IX0x1HKKD8cWvxUYr0p4ZQjvWytXA8ADa16YOw=;
        b=mAnmYmt/PzqPdh6la+8Ia4ViOZt7mSrwLs578NeeQbfafGZRJUUDSyOL0+CiA39omz
         jAODvZxSpH/mNpXt3mtaFVa8s5svTmzb/7i+CCUapIyT7pvqLt/O9LQ2ig8CFFOmkrRY
         4bACrsp4ZQxRVDg9VKPMmniW+jBLvozU7eMCmBByjbPmPDW0s1S8r+WgCWuTD5n9g4O7
         zWRZDMhgxTVpwxJiUK96NFtU5TokviQv4Syk2AICc/LFaY5RQ9YWnKrl3FYwQAqjKgq2
         zDCqt0Ye9ywUCQ7BjB+M87MOQJdyahWcLsUS4nDrqLKGNfzmJ9ZyNVTMITuW2hZTSdg4
         EiSg==
X-Forwarded-Encrypted: i=1; AJvYcCVPd8fA1ooEomrlT1d6wrIfN47fMF0FrCauu40kifRJf4h/zsbAKTw8S7PaJ13ZyP/kv7FpTGVhGOxNMnM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBEe3tm1t3/DjltLTLHLHwinSKlq8P1WU9SLTEK7AjiQlvmlDq
	s4Ktrbm1N8vOZ0cSmz4TSUkPuaBy0yoFP0KFJxXZE1kiueBrtuQLHgNl
X-Gm-Gg: ASbGnctv4vpd2Ikz5EflOQ7qS80UhRfHgCDrDY7VmRBzAVePPiLKOSm+NXg4iZ4J9cT
	Ib8urGf7hd8XnmVxHYpkRzNEmMqScGstg1LuJyMhv33JWwMHS9QU96uemz7rjvoaQ2QB7/hMcF4
	iAkgOeKVKSr8fVKZWR+Cw6rKE8Qdv6j+Q32Wle0YzZAilO+kO8+QXrYC3wVKNp2xSOBlMhXJmue
	tmsZan3Y06oEXgKnqdz1dCs0rxwMfvdXFuVtBqz6USEW/LcpULPnIjQWtxXKQQ2JE3usApuvGkN
	ftphzc7QorJE09I2gC4VlFzaaLCnfODrp4dC31rrNBWn0sFQs1iWgnpPyQWQ//7YV77GoD3NrYw
	/GI9i1nRB3AoZWccInafDcgaNhbUgrknLV1F9nnolh1qGCh6ehlcmUsSoI0568ESMp7az4PRhG5
	57aE63GHgbLhdjArN7dTpDNU1zKGv8Kmk=
X-Google-Smtp-Source: AGHT+IFP8YizIsbAVUU/5CgNa3JJSdLizH9cuCkzMxNk2L537QkrRDpx7uF1m2EXsw4kfsouEeK6vg==
X-Received: by 2002:a17:90b:390f:b0:336:b60f:3935 with SMTP id 98e67ed59e1d1-339c27db5a8mr1874281a91.23.1759460140125;
        Thu, 02 Oct 2025 19:55:40 -0700 (PDT)
Received: from ?IPV6:2601:1c0:5780:9200:326a:8939:a05c:b9d5? ([2601:1c0:5780:9200:326a:8939:a05c:b9d5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-339a701bf31sm6353140a91.19.2025.10.02.19.55.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Oct 2025 19:55:39 -0700 (PDT)
Message-ID: <f76cee52-1230-4cd5-b6c2-9cf4f0823228@gmail.com>
Date: Thu, 2 Oct 2025 19:55:39 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/vblank: downgrade vblank wait timeout from WARN to
 debug
To: Thomas Zimmermann <tzimmermann@suse.de>,
 maarten.lankhorst@linux.intel.com, maxime.ripard@kernel.org,
 airlied@gmail.com, simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 syzbot+147ba789658184f0ce04@syzkaller.appspotmail.com
References: <20251002025723.9430-1-chintanlike@gmail.com>
 <840dfd6f-3417-4667-a808-70d3d3f331c0@suse.de>
Content-Language: en-US
From: Chintan Patel <chintanlike@gmail.com>
In-Reply-To: <840dfd6f-3417-4667-a808-70d3d3f331c0@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 10/1/25 23:34, Thomas Zimmermann wrote:
> Hi
> 
> Am 02.10.25 um 04:57 schrieb Chintan Patel:
>> When wait_event_timeout() in drm_wait_one_vblank() times out, the
>> current WARN can cause unnecessary kernel panics in environments
>> with panic_on_warn set (e.g. CI, fuzzing). These timeouts can happen
>> under scheduler pressure or from invalid userspace calls, so they are
>> not always a kernel bug.
>>
>> Replace the WARN with drm_dbg_kms() messages that provide useful
>> context (last and current vblank counters) without crashing the
>> system. Developers can still enable drm.debug to diagnose genuine
>> problems.
>>
>> Reported-by: syzbot+147ba789658184f0ce04@syzkaller.appspotmail.com
>> Closes: https://syzkaller.appspot.com/bug?extid=147ba789658184f0ce04
>> Tested-by: syzbot+147ba789658184f0ce04@syzkaller.appspotmail.com
>>
>> Signed-off-by: Chintan Patel <chintanlike@gmail.com>
> 
> There should be no empty lines among those tags
> 
>>
>> v2:
>>   - Drop unnecessary in-code comment (suggested by Thomas Zimmermann)
>>   - Remove else branch, only log timeout case
>> ---
>>   drivers/gpu/drm/drm_vblank.c | 9 +++++++--
>>   1 file changed, 7 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/drm_vblank.c b/drivers/gpu/drm/drm_vblank.c
>> index 46f59883183d..a94570668cba 100644
>> --- a/drivers/gpu/drm/drm_vblank.c
>> +++ b/drivers/gpu/drm/drm_vblank.c
>> @@ -1289,7 +1289,7 @@ void drm_wait_one_vblank(struct drm_device *dev, 
>> unsigned int pipe)
>>   {
>>       struct drm_vblank_crtc *vblank = drm_vblank_crtc(dev, pipe);
>>       int ret;
>> -    u64 last;
>> +    u64 last, curr;
>>       if (drm_WARN_ON(dev, pipe >= dev->num_crtcs))
>>           return;
>> @@ -1305,7 +1305,12 @@ void drm_wait_one_vblank(struct drm_device 
>> *dev, unsigned int pipe)
>>                    last != drm_vblank_count(dev, pipe),
>>                    msecs_to_jiffies(100));
>> -    drm_WARN(dev, ret == 0, "vblank wait timed out on crtc %i\n", pipe);
>> +    curr = drm_vblank_count(dev, pipe);
> 
> Please don't call drm_vblank_count() here. It's not necessary for 
> regular operation. Simply keep the debug message as-is.
> 
>> +
>> +    if (ret == 0) {
> 
> "if (!ret)" is the preferred style.
> 
>> +        drm_dbg_kms(dev, "WAIT_VBLANK: timeout crtc=%d, last=%llu, 
>> curr=%llu\n",
>> +            pipe, last, curr);
> 
> Aligning the pipe argument with dev from the previous line is the 
> preferred style.
> 

Hi Thomas,

Thank you for your review and helpful suggestions.
I’ll drop the unnecessary comment and remove the else branch as you 
recommended.

I’ll send a v3 with these changes.

Best regards,
Chintan


