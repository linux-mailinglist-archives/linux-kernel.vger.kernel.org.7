Return-Path: <linux-kernel+bounces-898408-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E04C3C553AC
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 02:18:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AA6EF4E1E13
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 01:14:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C637120F09C;
	Thu, 13 Nov 2025 01:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jikklphl"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C21451D9A54
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 01:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762996450; cv=none; b=EcDedN0eHD5gjdZz78PIXoYIDSKzm7mxJMa+nGm8kGO6mFDgah0mRd4IDlXovISGSbvYK0abQsusBDuWUgSfg0Ulk5Akby/SqF3pA6Nh75xLh3xmltrsEPgevhTbVxVyf8s06BV46tS/D1BxI5E9AjiHo2sgnWab8tNdDuZfSjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762996450; c=relaxed/simple;
	bh=8Ved29fQzOyg3BLCaHXcRBTfarkaM0jw5ruLU5eeRJI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JbrFnW//7U3Gg0Gmi3QbMwo/VxLh+r3SnookXAXXW+UsKvf7yyyodnRRLJOtiv5CcpFZAr7PW6NMo2y2prCAg3mpcoLe2sLghAeCvMNBurn/feUILA26TZpYS8Iuwu1tWTd28AQqbNrB9Ub6QG/dv03InNRS3euxyhgPxWBXclQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jikklphl; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-477770019e4so3072805e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 17:14:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762996447; x=1763601247; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3HLrbAJ6c43LfFYkTKqROc4lQ0+rhYe8fH5v5jNUMZs=;
        b=jikklphlAJJslu9dfe3oprJmSVgR3b3AxyUtLw/UixOCMloMDMfDgUzPOyXG7iQgfh
         xzjT+eRcvQkeeZI3aUwBcti77deWE0NAKIGbzZrMUS29RD91IRnFETeMsDe2kxR55eZV
         q4esQ/PHiqJNzCkqeFrC60NJel4UdYuFe5ZfDLTOXrkK5ts59Wh77e5E0JCCAJ9bKzAH
         YPk9Ckz32ZumnU6oH9XKyhV/mGCo3+B3X0FAMiFU94FTOMGXwwoIDWgyMRyzPLjzd0d4
         liCKj20u3YCgZf4dCk/Ohxp6l0hvoPZwclSXhy25NlYT77XbUrQkI8kcFasIlgw4Uqvu
         RR5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762996447; x=1763601247;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3HLrbAJ6c43LfFYkTKqROc4lQ0+rhYe8fH5v5jNUMZs=;
        b=AiX9p3C3VodTJwPOx38LxwyQbCWPG8rxQ0ITN/6VrJ+VOmdxd2K2aUJxBWXsQ77qrZ
         CRkfPy0qulEXpCr+QAvtySRbdqsu25MeBOqImoT9DdMGg0NiIWOv9nwEEVL46c18lv9G
         t89XcTN5upZe2LGYgrVRIH4L6LuvVf8mF+7WgKJZ80fodupMx2RQ6ESgFD6vf6oo6Yrn
         nkXj296GwSL8uyTzEBI2n9cTIe6MCUeYTddwTfLz2E5Q3KRIgXN33JA5u3krYt5mCAV8
         C6whIeb4sxpUn0YVKvrTWdrF7EgNSH/Bt/2KK6lHWjNfxP1gl0jAjZZByq4rB+qMs42G
         ZpnA==
X-Forwarded-Encrypted: i=1; AJvYcCV0/iSKo0KBn0f5hkhfOmfS0hXSknleOB744NhZ56JDMB8g26csn+LmhcTPWv4mp49QX6y0zqn2RGpJFrk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNVi7P0UN8TAlRm6PTbzW3sSIzuwmdy73UMxtOIXZQgdFpeB9r
	CCHsnmS2Tz6MrfdkqXvkqX0Kc9DDMvDaJVEaxuDoy3O57HpVCgp+2WqH
X-Gm-Gg: ASbGncsHL/ZrKfpQqEshAQt/c+cS/A8rgdEVWNUlLP3zAr6N75Zc3l4hSTYsw3PCfRU
	iOvZgojx2BevFb1qSoPZiuVP22+ymZ0wOtW8YIYpl7SsPa6QjlQjctGEafS6ZYay54iD7ObE/IG
	8e+gqZXivEVZtorlsVPQKtKDPPkMXo21vF83IjlpgF2PsY+gdAVqxOJK2S/56I3CpmItJg/J7w9
	YHMeh3ssoVLcmrZuKdEdbPJojNs/hqnlIsRbQx0vA8jG+NKGn/1fXIDtHpGhiGpT7OZ7O0erOn+
	/3WO39lS9pIFA320MGIpnQA3XLzWBFe37QCVkQgQ3j+xTy7vi55Vmqqwxeu7AJm5hubAqw3QKZ1
	/uszhBbSDqJt8trah1fZXNlez/6j933SK0Pe0RQgF+TCTWoco2KNV3zUp1BazTmBM7uM3Bz1Djq
	/+tZVsw+SHN1oKP1BQlGsUOf8=
X-Google-Smtp-Source: AGHT+IGYzLut/ndHMiAn13hlQNrdk+3DuZME+uZLcTkIy36bWuua+C7dc9xlVCAQ0YRUZevDWEOlrg==
X-Received: by 2002:a05:600c:45c4:b0:475:e09c:960e with SMTP id 5b1f17b1804b1-477870a9fc0mr51493225e9.32.1762996446785;
        Wed, 12 Nov 2025 17:14:06 -0800 (PST)
Received: from [192.168.1.121] ([176.206.83.235])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4778c8479b7sm7021785e9.3.2025.11.12.17.14.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Nov 2025 17:14:06 -0800 (PST)
Message-ID: <4671d267-d823-4bf7-af30-b587e67dec49@gmail.com>
Date: Thu, 13 Nov 2025 02:14:05 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 00/10] HID: asus: Fix ASUS ROG Laptop's Keyboard
 backlight handling
To: Antheas Kapenekakis <lkml@antheas.dev>
Cc: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 platform-driver-x86@vger.kernel.org, linux-input@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>, Jiri Kosina <jikos@kernel.org>,
 Benjamin Tissoires <bentiss@kernel.org>,
 Corentin Chary <corentin.chary@gmail.com>, "Luke D . Jones"
 <luke@ljones.dev>, Hans de Goede <hansg@kernel.org>
References: <20251101104712.8011-1-lkml@antheas.dev>
 <CAGwozwE+3vkm0-amRqnNJBzxTvXabgBF9h_G_vG_L7OJj91LBg@mail.gmail.com>
 <27a74ecc-bff7-f3ae-b23e-a8362ac3a6b3@linux.intel.com>
 <CAGwozwGpacR=wYXpf3vOiwWNxaV6pJ6CdE-E-G1gRRpO4VHVMg@mail.gmail.com>
 <74f91d3c-6494-4754-a10f-4d8c1d45f7ff@gmail.com>
 <CAGwozwEKqqJxxmtjJhy2MzNVhmBTMmy8xG5TZGkKJqJCgK=X5w@mail.gmail.com>
Content-Language: en-US, it-IT, en-US-large
From: Denis Benato <benato.denis96@gmail.com>
In-Reply-To: <CAGwozwEKqqJxxmtjJhy2MzNVhmBTMmy8xG5TZGkKJqJCgK=X5w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 11/12/25 23:08, Antheas Kapenekakis wrote:
> On Wed, 12 Nov 2025 at 20:51, Denis Benato <benato.denis96@gmail.com> wrote:
>>
>> On 11/12/25 14:41, Antheas Kapenekakis wrote:
>>> On Wed, 12 Nov 2025 at 14:22, Ilpo Järvinen
>>> <ilpo.jarvinen@linux.intel.com> wrote:
>>>> On Wed, 12 Nov 2025, Antheas Kapenekakis wrote:
>>>>
>>>>> On Sat, 1 Nov 2025 at 11:47, Antheas Kapenekakis <lkml@antheas.dev> wrote:
>>>>>> This is a two part series which does the following:
>>>>>>   - Clean-up init sequence
>>>>>>   - Unify backlight handling to happen under asus-wmi so that all Aura
>>>>>>     devices have synced brightness controls and the backlight button works
>>>>>>     properly when it is on a USB laptop keyboard instead of one w/ WMI.
>>>>>>
>>>>>> For more context, see cover letter of V1. Since V5, I removed some patches
>>>>>> to make this easier to merge.
>>>>> Small bump for this.
>>>> I looked at v8 earlier but then got an impression some of Denis' comments
>>>> against v7 were not taken into account in v8, which implies there will be
>>>> delay until I've time to delve into the details (I need to understand
>>>> things pretty deeply in such a case, which does take lots of time).
>>>>
>>>> Alternatively, if Denis says v8 is acceptable, then I don't need to spend
>>>> so much time on it, but somehow I've a feeling he isn't happy with v8
>>>> but just hasn't voiced it again...
>>>>
>>>> Please do realize that ignoring reviewer feedback without a very very good
>>>> reason always risks adding delay or friction into getting things
>>>> upstreamed. Especially, when the review comes from a person who has been
>>>> around for me to learn to trust their reviews or from a maintainer of the
>>>> code in question.
>>> Sure, sorry if it came out this way. Dennis had two comments on the V7
>>> version of the series.
>>>
>>> The first one was that asusctl has a hang bug, which he hasn't had
>>> time to look into yet. This should have been fixed by dropping the
>>> HID_QUIRK_INPUT_PER_APP. I retested the series and that QUIRK was a
>>> bit of a NOOP that does not need to be added in the future.
>> So it is supposed to not regress it now, correct?
>>> The second is he is concerned with dropping the 0x5d/0x5e inits. Luke
>>> said (back in March) that it is fine to drop 0x5e because it is only
>>> used for ANIME displays. However, for 0x5d, it is hard to verify some
>>> of the older laptops because they have only been tested with 0x5d and
>>> we do not have the hardware in question to test.
>>>
>>> For this series, I re-added "initialize LED endpoint early for old
>>> NKEY keyboards" that re-adds 0x5d for the keyboards that cannot be
>>> tested again so this comment should be resolved too. With that in
>>> mind, we do end up with an additional quirk/command that may be
>>> unneeded and will remain there forever, but since it was a point of
>>> contention, it is not worth arguing over.
>>>
>>> So both comments should be resolved
>> The driver should also not late-initialize anything.
>>
>> Windows doesn't do it and the official asus application
>> can freely send LEDs changing commands to either WMI or USB
>> so I don't see any reason to do things differently [than windows]
>> and not prepare every USB endpoint to receive commands,
>> this has not been addressed unless I confused v7 and v8?
> Yes, it's been added on v8. 0x5d is init for the laptops it is
> problematic for. Not because it does not work, but because it has not
> been verified to work for those laptops.
I am not sure I am reading this right:
are you telling me that on recent models the windows driver
doesn't issue 0x5d?
>>> @Denis: can give an ack if this is the case?
>>>
>>> As for Derek's comment, he has a PR for his project where he removes
>>> the name match for Ally devices with ample time for it to be merged
>>> until kernel 6.19 is released. In addition, that specific software for
>>> full functionality relies on OOT drivers on the distros it ships with,
>>> so it is minimally affected in either case.
>> The part we are talking about depends on this driver (hid-asus)
>> and there are people on asus-linux community using inputplumber
>> for non-ally devices (the OOT driver is only for ally devices)
>> therefore it is very important to us (and various other distributions)
>> not to break that software in any way.
> This driver is only used for Ally devices. If you mean that people
> remap their keyboards using inputplumber I guess they could but I have
> not seen it.
I meant people remap keyboards using IP. I am sure there were
(and very probably still are) people doing that.
>> Weighting pros and cons of changing the name I am not sure
>> changing name brings any benefit? Or am I missing something here?
>> It's simply used by userspace so the hardware should be loading
>> regardless of the name...
> Users see the name of their devices in their settings menu. They
> should be accurate. Also, the early entry needs to be added anyway to
> prevent kicking devices.
If it's just aesthetics I don't see much reasons in changing the name.

"the early entry needs to be added anyway ...." has no meaning to me,
please rephrase. Sorry.

>> Along with IP and your tool and asusctl there is also openrgb,
>> and a newborn application for asus devices (I don't have contacts
>> with that dev nor I remember the name of the tool)
>> and I am not even that sure these are all asus-related
>> applications.
> My tool never checked for names, it briefly did for around a month
> after its creation for some devices until capability matches. Around
> 6.1 and 6.7 the kernel changed the names of most USB devices and that
> caused issues. It currently only uses name matches for VID/PID 0/0
> devices created by the kernel. Specifically, WMI and AT Keyboards. I
> am not sure there is a workaround for those. Asusctl also does not use
> names either.
But IP does, so I would like to hear confirmation from at least Derek
before the merge that there won't be future issues.

Interpret what I say here as a broad topic, not just name/PER_APP flag:
avoid changing data flow on older models...

>> Excercise EXTRA care touching this area as these are enough changes
>> to make it difficult to understand what exactly is the problem if
>> someone shows up with LEDs malfunctioning, laptop not entering sleep
>> anymore or something else entirely. Plus over time
>> ASUS has used various workarounds for windows problems
>> and I am not eager to find out what those are since there is only
>> a realistic way it's going to happen....
> These changes are not doing something extraordinary. It's just a minor cleanup.
>
>>> Moreover, that specific commit is needed for Xbox Ally devices anyway,
>>> as the kernel kicks one of the RGB endpoints because it does not
>>> register an input device (the check skipped by early return) so
>>> userspace becomes unable to control RGB on a stock kernel
>>> (hidraw/hiddev nodes are gone). For more context here, this specific
>>> endpoint implements the RGB Lamparray protocol for Windows dynamic
>>> lighting, and I think in an attempt to make it work properly in
>>> Windows, Asus made it so Windows has to first disable dynamic lighting
>>> for armoury crate RGB commands to work (the 0x5a ones over the 0xff31
>>> hid page).
>> Yes once ASUS introduces something new it sticks with that for
>> future models so it's expected more and more laptops will have
>> the same problem: I am not questioning if these patches are needed
>> as they very clearly are; I am questioning if everything that these
>> patches are doing are worth doing and aren't breaking/regressing
>> either tools or the flow of actions between the EC and these USB devices.
> Well, this series is needed to account for that. Sending the disable
> command is out of scope for now though.
Here I apologize for confusion: my comments were mostly about
older models: I absolutely don't want to break those, but if you find a way
to distinguish them from newer models that would give you more freedom with those.

No disable commands unless we find hard evidence those are strictly needed.

> Antheas
>
>>> Hopefully this clears things up
>>>
>>> Antheas
>>>
>>>>> Unrelated but I was b4ing this series on Ubuntu 24 and got BADSIG:
>>>>> DKIM/antheas.dev. Is there a reference for fixing this on my host?
>>>>> Perhaps it would help with spam
>>>> I see BADSIG very often these days from b4 (thanks to gmail expiring
>>>> things after 7 days or so, I recall hearing somewhere), I just ignore them
>>>> entirely.
>>>>
>>>> AFAIK, that has never caused any delay to any patch in pdx86 domain so if
>>>> that is what you thought is happening here, it's not the case.
>>>> If your patch does appear in the pdx86 patchwork, there's even less reason
>>>> to worry as I mostly pick patches to process using patchwork's list.
>>> Turns out I had to update my DNS records. It should be good now.
>>>
>>>> --
>>>>  i.
>> snipp
>>>>>> 2.51.2
>>>>>>
>>>>>>

