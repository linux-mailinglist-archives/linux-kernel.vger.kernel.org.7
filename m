Return-Path: <linux-kernel+bounces-627478-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E13DFAA513D
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Apr 2025 18:11:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5884C3AC38B
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Apr 2025 16:11:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C80632620D1;
	Wed, 30 Apr 2025 16:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N0Vs6JGV"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45F3A7405A
	for <linux-kernel@vger.kernel.org>; Wed, 30 Apr 2025 16:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746029482; cv=none; b=ryZs0ThSpqEMPzh7AfKRG1SHBCuEkpfllU4vmXwQDqCgTLSram+SjSQH2li9nIt43UhL6G50rfB/SW25dqh4CWN41gIZGO9NFjMlcLaE+Odmzs+eMggv1YfcwQnbvtjqYVnUsD+s2Z+YOFGuQdbbRnT5UGANAmwb8Q7PRy1cthM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746029482; c=relaxed/simple;
	bh=/UKda8ol4nKkoyi9tsolOoY9jpy0uQOmCDPEuORxq9Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cEGvvF74dGndD39LkQ8HPBfjfLbnghPAR92Ae1A15K9Y6dMR/xRxO7iHrNkZBUcVcVeCcqDO+0eZBZucZOdvT8KXuE7WncpWsmqpjdr3Eezlu85zrHgJafKwH+VVkL+pgXcbMnEFB2bd8zAOFgFKD/exaGVhcKKt58oxa+Yolkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N0Vs6JGV; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-224191d92e4so81955935ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 30 Apr 2025 09:11:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746029479; x=1746634279; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=8QdI9zAXM1EXk6JfijMSDnvKDuolz6Ggda+w8j/WGZE=;
        b=N0Vs6JGVTGxe1ciWL9PgMgr08zoi5F1na7tq2uf6+iDKWpDhuRduIPR967bJa36V8C
         GS6YYn5RA/tVHk+9ytmFLK0xpNwTz5MOBrALETnhknm/WBvjdKz8Flhxp0k+6JB37keS
         rpAjhXL/HN3hR+znBExpaEryO/GUEGL2QO4XxSq04szWBumEFYJGOy7yDkt0k5E/a5CS
         cUiy3/ZkqXgq36amaFU037cNTK0SzncmUvzfB7wRuWtj0DSycLSZ+YMCk76b1Nnl1DJu
         VzMmSTuzPtjHbPz4QPzS0gYYvC0EKLQBHJMlzOQwxqEWGxgCNtd7AfaAcwVqLZnaj3Vx
         vVGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746029479; x=1746634279;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8QdI9zAXM1EXk6JfijMSDnvKDuolz6Ggda+w8j/WGZE=;
        b=sMhw3QYTsIubux4zArrDxehMWztDFu62TeSkOQidO0VrviWCUcWhcBXYqIlUybw+Gk
         QqrsWLeHdBbgksffCsbqaAJCRDDmf8Pg7avNc7gcjuWT2MnDNb8u0bG7V3+B4DVkgBcl
         B+Kv54fulD6qqacryMYGzSlNldTA1E9RPq42ojDiFpe3CAnlAzRa3oKXqPG9GVNjlgbx
         rDaPK7CJFgC+IVuA7aufarkv1aQBHcHT0zyqgrI8yz7gJfEdFRKNmjfhBdm0EK9qVjc8
         Yj9uB6HPFx0pU0UhwdfKS/KIN5JEx1/btVUPnPiUdlXOGffL+9daqt0YJTrWvYsThg7J
         SfVQ==
X-Forwarded-Encrypted: i=1; AJvYcCWRKSMr2DF5Raj+ZeavlMFM8iLzHuQGivOaGoGS+sZVGvw0lR2l8QlPwozAAkzPDTUebDTz2WHkABUtNng=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw14P8wIVfGtNJKEN3iMlNYeCAAzaB1wO6+h0dJckup/ptsDDKL
	NTzNcDNzduK6mlK4RibEVVc5QTkchm/YaTqGLA/IyVyk4lO/IfwO
X-Gm-Gg: ASbGncsiEV8sYDaKCmcQE/F079FnUyuerjNdEZLWA+ZOI10XRlp0LU/sa8jNQ8yFm9U
	1I73HoTkADGdMDv857SopzRzQ7djk8k/mSVVNsxBwk5NImaiZjVBnrfpT3qy9tTWSi/fPcthP4p
	6ILpEsZw4b9v7DnLOSIbu6e8zVN1CdzflEQkMh5hoPzxIBPF4w/Pk9Z6P5bsiP6DlPwUOSrGi0x
	78V1S4ZTUuRf2p5J/Qvg/F7BPBZerbvwG2+846Hv9e1w6j6aqKX6Z81PKevatY3pY1dhz8Za4Pz
	6dEitRYljYvEX0s1qw53f6mipZ+3H/8VPRvs0pkSwvU6bvScQEeiHB5oVZm+n6KJjfMBq+QrBm9
	NX9fk3/H0ijBMew==
X-Google-Smtp-Source: AGHT+IE3LWuBObioSz5WRjpUQmOLiurHOMha6G61MD9ycBRKzq1jJmOJGa4KadiZiBM16zRrb9XsyQ==
X-Received: by 2002:a17:902:ccc3:b0:215:9bc2:42ec with SMTP id d9443c01a7336-22df5838ce0mr44920465ad.47.1746029479561;
        Wed, 30 Apr 2025 09:11:19 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22db4dbd230sm123543045ad.77.2025.04.30.09.11.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Apr 2025 09:11:18 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <2ec928ad-cd84-4964-9f7b-c414033412cb@roeck-us.net>
Date: Wed, 30 Apr 2025 09:11:17 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] nvme: only allow entering LIVE from CONNECTING state
To: Daniel Wagner <dwagner@suse.de>, Keith Busch <kbusch@kernel.org>
Cc: Hannes Reinecke <hare@suse.de>, Daniel Wagner <wagi@kernel.org>,
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, James Smart <james.smart@broadcom.com>,
 Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20250214-nvme-fc-fixes-v1-0-7a05d557d5cc@kernel.org>
 <20250214-nvme-fc-fixes-v1-1-7a05d557d5cc@kernel.org>
 <0134ea15-8d5f-41f7-9e9a-d7e6d82accaa@roeck-us.net>
 <cb46aa83-8033-4d64-a3c7-420172c3f3f5@flourine.local>
 <9763c4cf-8ca5-45d4-b723-270548ca1001@suse.de> <aBEW4W40ZelIXfs2@kbusch-mbp>
 <253e0551-d4d7-4ffe-8842-daecf1f6c753@roeck-us.net>
 <aBEdkUky_-bfgISv@kbusch-mbp>
 <8121b8d6-2b30-4086-b2fb-bce354f203dc@flourine.local>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <8121b8d6-2b30-4086-b2fb-bce354f203dc@flourine.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/29/25 23:43, Daniel Wagner wrote:
> On Tue, Apr 29, 2025 at 11:42:25AM -0700, Keith Busch wrote:
>> On Tue, Apr 29, 2025 at 11:23:25AM -0700, Guenter Roeck wrote:
>>> On 4/29/25 11:13, Keith Busch wrote:
>>>> On Mon, Apr 28, 2025 at 03:21:18PM +0200, Hannes Reinecke wrote:
>>>>>> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
>>>>>> index b502ac07483b..d3c4eacf607f 100644
>>>>>> --- a/drivers/nvme/host/core.c
>>>>>> +++ b/drivers/nvme/host/core.c
>>>>>> @@ -4493,7 +4493,8 @@ static void nvme_fw_act_work(struct work_struct *work)
>>>>>>                    msleep(100);
>>>>>>            }
>>>>>>
>>>>>> -       if (!nvme_change_ctrl_state(ctrl, NVME_CTRL_LIVE))
>>>>>> +       if (!nvme_change_ctrl_state(ctrl, NVME_CTRL_CONNECTING) ||
>>>>>> +           !nvme_change_ctrl_state(ctrl, NVME_CTRL_LIVE))
>>>>>>                    return;
>>>>>>
>>>>>>            nvme_unquiesce_io_queues(ctrl);
>>>>>
>>>>> I would rather have a separate state for firmware activation.
>>>>> (Ab-)using the 'RESETTING' state here has direct implications
>>>>> with the error handler, as for the error handler 'RESETTING'
>>>>> means that the error handler has been scheduled.
>>>>> Which is not true for firmware activation.
>>>>
>>>> But the point of having firmware activation set the state to RESETTING
>>>> was to fence off error handling from trying to schedule a real reset.
>>>> The fw activation work schedules its own recovery if it times out, but
>>>> we don't want any other recovery action or user requested resets to
>>>> proceed while an activation is still pending.
>>>
>>> Not only that; there are various checks against NVME_CTRL_RESETTING
>>> sprinkled through the code. What is the impact of introducing a new state
>>> without handling all those checks ?
>>
>> Good point, bad things will happen if these checks are not updated to
>> know about the new state. For example, nvme-pci will attempt aborting IO
>> or disabling the controller on a timeout instead of restarting the timer
>> as desired.
>>
>> Can we just revert the commit that prevented the RESETTING -> LIVE
>> transtion for now?
> 
> Unfortunately, it will break the FC error handling again(*). The
> simplest fix is right above, add the transition from RESETTING to
> CONNECTING and then to LIVE, IMO.
> 
> (*) ee59e3820ca9 ("nvme-fc: do not ignore connectivity loss during connecting")
>      f13409bb3f91 ("nvme-fc: rely on state transitions to handle connectivity loss")

I don't know if having nvme-fc _depend_ on state transition restrictions is good
or bad, and I don't know anything about the NVME state machine.

However, given that there _is_ a real regression in the code right now, I agree
that the solution (or call it workaround) suggested by Daniel (or something
similar) should be the way to go, and it would be easy to backport. After all,
firmware update is now broken in all stable release branches, and that is not
a good situation to be in.

Introducing a new state for firmware updates should be done carefully and not be
part of a regression fix which needs to be backported to all stable release
branches.

Thanks,
Guenter


