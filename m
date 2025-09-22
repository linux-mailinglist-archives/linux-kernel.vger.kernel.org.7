Return-Path: <linux-kernel+bounces-827676-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38558B9262B
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 19:18:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E04FA2A6989
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 17:18:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A2A8313D48;
	Mon, 22 Sep 2025 17:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="VfAULzj0"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E96072EA72C
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 17:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758561494; cv=none; b=Ot+1/1f9+oRHmC6un164HVPoafwqebLxorTl3oC01S4w+7DYhtXOH8h3dB146MUFNpkRnOo5N+JUxfhGYuTz0G1APVHwQp75oZCLIAS1irSPNYnWnLsbC47J+XpLprIKDvKs/CiRjw2dgVaLuYG/sGNdfaWit6RXRITNCAuJF7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758561494; c=relaxed/simple;
	bh=h23jT0lD1N06Ba7ngBAjZL3uKVwx/wGpZmwj/K5oFVU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZLEFSFMgfxG1jV8khCut06weCfxsmYwpjlhsnHVbABCtPDX9C0mrGyFBw/gpJVsJgldsfgoCEUkTRdE3E22LO8dRCUcCBNtIh7iV4BtSXc+G8Bewps2g1ibRZHYo31L1F80mELpbiB13FJh+zqQrH3mfMZ7FxeZ2dhnKk6vnzy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=VfAULzj0; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3f2ae6fadb4so2670396f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 10:18:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1758561490; x=1759166290; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=y5wud1lSV0wbWVfXsBYPf/NNYAcPsEVVEIqquff6paA=;
        b=VfAULzj0ECsYAQFEdLZEMJK4wlpDA7ZVSGGGwfBvJOeCOWWWpiFw3aFyZ6fEoJttmO
         Q926gxlmjWqoUSj3ftUSriBdu5xXUISeNH6hPTalHf4RYeAVNd3STVG+rkC4gDv6s/K/
         vq4A6S0Ji3uZ3Fa1zaPtl3m6v5ZTIE2PsGqBQdX8x4/gloFftklo6enUiaEVp29SZIIA
         lxHgJ995SiAgqCW+PV9MyLwypeqGpRdMuSh79VJZVMiyk3WGhY7yTIlM2nXswKL57iMw
         y18WI2ykUlNVEVwGX47XASCtPobvSYDHUtnEKkWajwKjreeIEI6C+4odFGOmITqkApkf
         pdOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758561490; x=1759166290;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y5wud1lSV0wbWVfXsBYPf/NNYAcPsEVVEIqquff6paA=;
        b=lGlSH3HYDd6QKkiDDX4SYM15M4TqISCN/2BPwOlsiWrMCkdPXvOXqDBzTx0PK2ZRXM
         u960W+uMUJOMwZTwVNQ+/cXqzaTBN1ukY1WghN2Yeqm9dGR7P4RSOrlZhPT2AAh3aPPe
         Usens8GXIHa4Ns3bZiXMSUYnRua+WXg0LH/Jg5GIz81yHEiAEUG73l7/kWJcdIvO2MWQ
         cJ3kKlkbC5jrl/4El1CCcjVfMJjxsTVSgUYyWQvWCGZLdQJMrftRuJdWx59KuqFMJLDN
         j99lEzUj/0HFBYhgXXJ/CmRNxY/+2QsN6dr1fCXMwsnj99UutKLfJI1STlleP3OW0Gy0
         Z9Yg==
X-Forwarded-Encrypted: i=1; AJvYcCXRBbhXo/6EL1ymO6Qp6VgMNGCo67jarY8BWUtU6cEylh85CGwTdeJLKWqMteMZ2WLdd9HE+TMMW4+NV5k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVQ9Gg6OY3a6zvvYfuORIxe0HBTsXZGyBWnopKJZAW4Bg5fJ/w
	sMdQnBO5Ql1xXSguy/U5Kr7ONj5hRq6AqyDfIJMNP9GQ7+xPttbeQY2x6ziHJzwh9U0=
X-Gm-Gg: ASbGncuCBin8DG5kddAasNKOkZg3bTjAzwQMzb8UtrQ+JVJBsivXLuW6Ne0pbh/RQtj
	rb8Y8KdxBjjVWytsOFlW4CTRddYBAhzr5KfnHZWqfY90C57V7aaKFLivrWXDNrMjGE7R5XuNP3j
	s5FGKG2FPVf7npAqnAlZVNmuDDovQZXQ1vdBNo0URMlT89FdU8fS8hF5C3Nc5umiKn6Wz0pAQBz
	KMYhwXZEl85BVdHeM8xoaUQ2i08s906zoFfiUwdFLAnSj+wVsUv3fwZMj2Zoo3reUlFxgu0FBZn
	nwiaahwY0DBVGiDa1gCDxlxKmby9ENMvRRz/TzOThwJ+N/cZgIIpfu6ou5Lytpv+3o3t5lIzpkP
	80D4iZEDGVevOYIF7LU1ji3hvV8ki1gmE4Me4J6oItyAQnQV2VfvPjMgEKX1qZvYzXXxa/NpNgg
	Io8FBcqA==
X-Google-Smtp-Source: AGHT+IHO/UO2nNy8R+3qajssdW17mzOXAbqfr27EmoY4nf8f1wtEGz+MCivYp3KbUmmU18a/YxXG1w==
X-Received: by 2002:a5d:5f95:0:b0:3ea:71c4:8e1b with SMTP id ffacd0b85a97d-3ee86d6cf37mr10443452f8f.63.1758561490119;
        Mon, 22 Sep 2025 10:18:10 -0700 (PDT)
Received: from ?IPV6:2804:18:10d:538:67e6:b01b:caa9:3531? ([2804:18:10d:538:67e6:b01b:caa9:3531])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77dbc8e7cc4sm11725498b3a.29.2025.09.22.10.18.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Sep 2025 10:18:08 -0700 (PDT)
Message-ID: <75a60a40-a6fe-40f5-9d6a-aa9ff8cbfa3c@suse.com>
Date: Mon, 22 Sep 2025 14:15:57 -0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] cifs: client: force multichannel=off when
 max_channels=1
To: Steve French <smfrench@gmail.com>, Enzo Matsumiya <ematsumiya@suse.de>
Cc: rajasimandalos@gmail.com, linux-cifs@vger.kernel.org, sfrench@samba.org,
 pc@manguebit.org, ronniesahlberg@gmail.com, sprasad@microsoft.com,
 tom@talpey.com, bharathsm@microsoft.com, linux-kernel@vger.kernel.org,
 Rajasi Mandal <rajasimandal@microsoft.com>
References: <20250922082417.816331-1-rajasimandalos@gmail.com>
 <da3e2b5a-a5da-4526-9884-8789990ebf95@suse.com>
 <qmf3xwqq4hqj4issgci2g76eghytaqxihnrp236ithh2istkkf@n4s54vp3hblr>
 <CAH2r5mu9xUQz5e1Mf-dBCNh2_y2jnxPYMhmuHr1bVqKC6atd8w@mail.gmail.com>
Content-Language: en-US
From: Henrique Carvalho <henrique.carvalho@suse.com>
In-Reply-To: <CAH2r5mu9xUQz5e1Mf-dBCNh2_y2jnxPYMhmuHr1bVqKC6atd8w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 9/22/25 1:14 PM, Steve French wrote:
> . >Do we even need ->multichannel flag at all?
> 
> Yes - especially in the future.   The goal is for the user to have
> three options:
> 1) (preferred) "multichannel" (max channels will be dynamically
> selected and can change) the client gets to choose how many channels
> to connect to based on what it sees in the output of the most recent
> query interfaces call (it can change on the fly as server dynamically
> adds and removes channels or networks become temporarily unreachable)

I'm guessing this would be required while we are transitioning from
setting channels dynamically to having multichannel on by default, as
you commented below. Because once we have it on by default, I don't
think there is a point in having the flag.

> 2) "max_channels="   This is for the case where user wants to choose
> the number of channels rather than have the client automatically
> (hopefully soon in the future) choose it for you
> 3) if server has mchan bugs, allow client to mount with no
> multichannel (or equivalent max_channels=1)
> 
> But ... "remount" also has to work for the three above (and currently
> doesn't) and this is what I am hoping the recent patches can fix (?)
> but haven't tested them enough yet
> 

Yes, I agree the patches are important, I am also testing them here.

> On Mon, Sep 22, 2025 at 9:59 AM Enzo Matsumiya <ematsumiya@suse.de> wrote:
>> I'd actually like to propose going even further and having the whole
>> module behaving as if multichannel was always on, even with
>> max_channels=1
> 
> Obviously the goal (would love patches for this) is to turn
> multichannel on by default, have the client select the appropriate
> number of channels by default etc. but we have to let the user
> override it (as described above)
> 
>>
>> On 09/22, Henrique Carvalho wrote:
>>> Hi Rajasi,
>>>
>>> On 9/22/25 5:24 AM, rajasimandalos@gmail.com wrote:
>>>> From: Rajasi Mandal <rajasimandal@microsoft.com>
>>>>
>>>> Previously, specifying both multichannel and max_channels=1 as mount
>>>> options would leave multichannel enabled, even though it is not
>>>> meaningful when only one channel is allowed. This led to confusion and
>>>> inconsistent behavior, as the client would advertise multichannel
>>>> capability but never establish secondary channels.
>>>>
>>>> Fix this by forcing multichannel to false whenever max_channels=1,
>>>> ensuring the mount configuration is consistent and matches user intent.
>>>> This prevents the client from advertising or attempting multichannel
>>>> support when it is not possible.
>>>>
>>>> Signed-off-by: Rajasi Mandal <rajasimandal@microsoft.com>
>>>> ---
>>>>  fs/smb/client/fs_context.c | 7 +++++++
>>>>  1 file changed, 7 insertions(+)
>>>>
>>>> diff --git a/fs/smb/client/fs_context.c b/fs/smb/client/fs_context.c
>>>> index 072383899e81..43552b44f613 100644
>>>> --- a/fs/smb/client/fs_context.c
>>>> +++ b/fs/smb/client/fs_context.c
>>>> @@ -1820,6 +1820,13 @@ static int smb3_fs_context_parse_param(struct fs_context *fc,
>>>>              goto cifs_parse_mount_err;
>>>>      }
>>>>
>>>> +    /*
>>>> +     * Multichannel is not meaningful if max_channels is 1.
>>>> +     * Force multichannel to false to ensure consistent configuration.
>>>> +     */
>>>> +    if (ctx->multichannel && ctx->max_channels == 1)
>>>> +            ctx->multichannel = false;
>>>> +
>>>>      return 0;
>>>>
>>>>   cifs_parse_mount_err:
>>>
>>> Do we even need ->multichannel flag at all? Maybe we could replace
>>> ->multichannel for a function that checks for max_channels > 1?
>>
>> I agree with Henrique.
>>
>> I'd actually like to propose going even further and having the whole
>> module behaving as if multichannel was always on, even with
>> max_channels=1 -- the only difference being the need to run the
>> query_interfaces worker.
>>
>> This is probably work for another patch/series though.
>>
>>
>> Cheers,
>>
>> Enzo
>>
> 
> 

-- 
Henrique
SUSE Labs

