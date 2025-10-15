Return-Path: <linux-kernel+bounces-854471-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AC6C0BDE76A
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 14:27:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 091F51899FB4
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 12:27:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E51B326D4B;
	Wed, 15 Oct 2025 12:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kggi3Oau"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DBFD326D5C
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 12:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760531245; cv=none; b=LddydoA5AP4s3AcoWfP2u0WDO8myxg0srySgEZnvw2SotV5mk4OBFLM3+JaWy2AgFYsVm2LLX2VfJ/9VCXpEZC4P7TxBzrAG3/nrsqjDtf8yiE2h/P0j2wJvg5yDCCw4v7wUYb3y3t5GECvSlAMpg5yqE3GRCdCus8BzEX+PMDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760531245; c=relaxed/simple;
	bh=aUedLoKamCVVxyfQfUAMTvYhMOssaT/HBZaPQZ62VXU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SroY2ErsI9dHhDiZO1SuF9OqnYlag7eVic8KRFwLorPfZ9WDOCnrpdxHRKyeSZ/mPbFB06NNogzzIW0d9Z8VixHCaOdVpTu7z0R5oRK3TeLFIFy34x9sEwAyB+NkiEP89/huqe79MDppWVj3HlCFfP7nI+p7+RP23tuudpOvaMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kggi3Oau; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3ee12a63af1so3904502f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 05:27:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760531242; x=1761136042; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wjoMwghPIohukayZuKoD3nhrdjl4TgPiMFjbi9Rs2ZQ=;
        b=kggi3OausfVTItOIOXYoMEOqhRi8NYmPY3ahpQC1RmvWivK/BuwGKF2deu79YDnZ8/
         BLXC+yS12xXtRNzg7+A2hl6xBtXeqDMN6IPaXzBSWmKb7pFRjXB6GQ1Uunz2lszcYhzZ
         KrPmuBM9xrHh1CQ9VDeQuLYmgHAHNnyu936+WhKHAm2OIqqe7+XaBlXpspLrWUnrB9KQ
         +ZfvcQgxjsqdUWE8hv4ldikppo/msRcYCF9LFiaIGWzf/GunwY9tGpKrS8S3VeuoT0ov
         +ro2nHRbhgvpMmCQPcjWEMpD0jJ5Z+c2YH1peYGjR1Bmen1kXlipzaNYK1ZMD/hs/zDf
         P5JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760531242; x=1761136042;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wjoMwghPIohukayZuKoD3nhrdjl4TgPiMFjbi9Rs2ZQ=;
        b=mT+hzUqfhAblfDECTDmNnLGvZv2f6ZeSXVYZqPfsZVAijutz0EdlDZLmuDZmbdULtO
         SFV+98nH6VtvADjt5BOK03987NLKBnfyFEOJ9YtRQHMY7NMaGJWw5Q+kvkki3zwQTuBD
         EMX96FMkhQBe/5IzRfWsXb/Cu1vq7YBOjgmRVEHRDM17p7RnP9ZIn7PCd/9g4A7wAmjq
         Pjb1xJVKrxGbrGX1EO/ZpqSQ3DoDW6vkdATMCjBObITLC5+2YUIVwg3KYg8vtj20TjQi
         2URSCaB2OPd9w1091gHq1a7g7TOTXpi5aEvtqVO1zfJSkbLhqYUOy1YwRlgPbEJ4gmL7
         Pj+A==
X-Forwarded-Encrypted: i=1; AJvYcCXs3z92tNiBGhzJNR3YBjfc6VFHz3mZp+e+Hqao3+AfB9gCYEOP2CvzRGJGJgm5IxoHGXZ/F2grqW/B5c0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0u8LDZGQOk/WhwNrW/lx+aJ0pNNZ429hV3hFamTVUeIrSKa5A
	b3nva+OzDur2MmtIf84X/zHm7BcvxaT4pV/Jz3C9X2y6v8Hv9NxO1jm+PbgO5w==
X-Gm-Gg: ASbGnct2r8dk4qD6wVmDurYFW/qWLLEhZ6GI+xZjWh9YRbWk14ayBWfs2zbh187cd9X
	4GKNhyWXf0gMmu9XQQrfTMiMbpmz9uEYW874HmatEQ3+yYUy0TjhMILdDAmOJLBfMHxp1l3Bljt
	3a7GCW9J7DooYyyGYfVfgZ6RyRhM6N7YRhAQNTPNWwBmlQWAJcnh18Pw5q0XegKmsRKDl9ltVni
	mCayWXf1xuOnbGi1WHsbuUqtbOMDNls++XUrWwUt9dBC6UvoApT70KxKlxVKvRMn5FlZNijwixZ
	WaMHJ42ADXth5mEbOEg3uxGTLC+QY8FrvJhckJGpM9iOuCRNxf6ZRNbWApLSnIYp9HGthFhaIC0
	EzUXrOqrZD8S7/LYHrweoZzJWPkDvVhZsjRmqzJMcdLuUliATkFp/GldDOG+xUKF41A==
X-Google-Smtp-Source: AGHT+IGI57IQUmf9nN0SU1CXBFc9/Ki3m5/W+fcXygdYAFCm/ofKw82VShjxAzRHnUdy1iKY85Q3rw==
X-Received: by 2002:a05:6000:25c6:b0:3fa:5925:4b11 with SMTP id ffacd0b85a97d-4266e8dd4a0mr18552082f8f.42.1760531242037;
        Wed, 15 Oct 2025 05:27:22 -0700 (PDT)
Received: from [192.168.1.121] ([176.206.100.218])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce57cc0esm29129909f8f.6.2025.10.15.05.27.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Oct 2025 05:27:20 -0700 (PDT)
Message-ID: <ada4c640-1d35-4e79-bc00-e88bc60f646d@gmail.com>
Date: Wed, 15 Oct 2025 14:27:20 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 0/9] platform/x86: Add asus-armoury driver
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Mario Limonciello <mario.limonciello@amd.com>,
 LKML <linux-kernel@vger.kernel.org>, platform-driver-x86@vger.kernel.org,
 Hans de Goede <hdegoede@redhat.com>, "Luke D . Jones" <luke@ljones.dev>,
 Alok Tiwari <alok.a.tiwari@oracle.com>,
 Derek John Clark <derekjohn.clark@gmail.com>,
 Mateusz Schyboll <dragonn@op.pl>, porfet828@gmail.com
References: <20251015014736.1402045-1-benato.denis96@gmail.com>
 <0752fcde-6c25-4cde-b35f-2204e24ff0f1@amd.com>
 <8e381c36-3bdf-a1d6-8e51-53243ba8bf4d@linux.intel.com>
 <97c56897-ed9b-4d4d-ba54-d6e2abbc8b0d@gmail.com>
 <66bb61ca-94ae-7f0a-ce9f-f5c13b51eb01@linux.intel.com>
Content-Language: en-US, it-IT, en-US-large
From: Denis Benato <benato.denis96@gmail.com>
In-Reply-To: <66bb61ca-94ae-7f0a-ce9f-f5c13b51eb01@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 10/15/25 14:06, Ilpo Järvinen wrote:
> On Wed, 15 Oct 2025, Denis Benato wrote:
>
>> On 10/15/25 11:38, Ilpo Järvinen wrote:
>>> On Wed, 15 Oct 2025, Mario Limonciello wrote:
>>>> On 10/14/2025 8:47 PM, Denis Benato wrote:
>>>>> Hi all,
>>>>>
>>>>> the TL;DR:
>>>>> 1. Introduce new module to contain bios attributes, using
>>>>> fw_attributes_class
>>>>> 2. Deprecate all possible attributes from asus-wmi that were added ad-hoc
>>>>> 3. Remove those in the next LTS cycle
>>>>>
>>>>> The idea for this originates from a conversation with Mario Limonciello
>>>>> https://lore.kernel.org/platform-driver-x86/371d4109-a3bb-4c3b-802f-4ec27a945c99@amd.com/
>>>>>
>>>>> It is without a doubt much cleaner to use, easier to discover, and the
>>>>> API is well defined as opposed to the random clutter of attributes I had
>>>>> been placing in the platform sysfs. Given that Derek is also working on a
>>>>> similar approach to Lenovo in part based on my initial work I'd like to
>>>>> think
>>>>> that the overall approach is good and may become standardised for these
>>>>> types
>>>>> of things.
>>>>>
>>>>> Regarding PPT: it is intended to add support for "custom" platform profile
>>>>> soon. If it's a blocker for this patch series being accepted I will drop the
>>>>> platform-x86-asus-armoury-add-ppt_-and-nv_-tuning.patch and get that done
>>>>> separately to avoid holding the bulk of the series up. Ideally I would like
>>>>> to get the safe limits in so users don't fully lose functionality or
>>>>> continue
>>>>> to be exposed to potential instability from setting too low, or be mislead
>>>>> in to thinking they can set limits higher than actual limit.
>>>>>
>>>>> The bulk of the PPT patch is data, the actual functional part is relatively
>>>>> small and similar to the last version.
>>>>>
>>>>> Unfortunately I've been rather busy over the months and may not cover
>>>>> everything in the v7 changelog but I've tried to be as comprehensive as I
>>>>> can.
>>>>>
>>>>> Regards,
>>>>> Luke
>>>> As a general comment that applies to a few patches in the series.
>>>>
>>>> The S-o-b means that YOU sign off on them, it's like a chain of custody.
>>>>
>>>> Any patches that you're sending need your own S-o-B, even if they're 100% the
>>>> same as the original from Luke.
>>> There's also Co-developed-by tag which may be appropriate in cases where 
>>> both have touched the patch.
>>>
>> I have re-read the submission documentation and confirmed I need at least
>> S-o-b for all of them. Is it acceptable if I simply answer to the email with my S-o-b
>> and Co-developed-by (on patches I have touched) or do I need to resend
>> the whole patchset creating a v15?
> Hi Denis,
>
> Please wait a bit with v15, I'll try to take a look at this series 
> hopefully before the end of this week and I suspect there will be more 
> changes needed as a result (not to doubt your effort but it's long time 
> since I've looked at it).
>
Sure! I will fix everything that needs fixing! I'm just happy seeing progress
since this is a work that is both extensively used (valve and other distros)
and very requested.

Thanks for your time!

