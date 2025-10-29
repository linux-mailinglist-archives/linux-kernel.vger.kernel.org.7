Return-Path: <linux-kernel+bounces-875717-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F33EC19AD3
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 11:24:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBE6B467173
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 10:23:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43D6A306D26;
	Wed, 29 Oct 2025 10:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OKWEaIVw"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 594B72FDC5D
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 10:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761733353; cv=none; b=l1UpQC1pAn5z3GbqmMj0+wCde0VBcMDv4jbgdUhxPsJFcSeuHOWLiJabVVH+TOgcd2CpB5QzK5ouM6fvmBreUZ0rHhMVbkNTjWp+aOWSUNUiszZBiVRhGI/xdpEA6i1EGhHCa4Z+uqMTD7kBfGdEYcG/zgzNhDdMzQS6+HbdZkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761733353; c=relaxed/simple;
	bh=mnRRV5HPXBW9tuX4FZ04zHvXEUxQ069sL5rllrsykhk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=exvumUkWJkvE9iVFIMH+l2CtW1lXzpVoRburi+Kklf+h/JqNrsUDhSAZNc2TVS8jg66sqci4+ACVmkY1su1gAcflptA/+ohhGHZdMSzySuEus21Wkr1ygfh/TQgJTwazgbx4U14F6abj/NHFbsZcFlofICfoWvrrRVPYL0hql+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OKWEaIVw; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-78118e163e5so725457b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 03:22:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761733351; x=1762338151; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=CaK0Y+U8EyOJTcVJLV4yd3je0ipYJSA70UshUjw3R/A=;
        b=OKWEaIVwYYG4B75p9ev3jOv1LWYQ4o4BExelKaj0Drf8VtQhRXWEbnVSy/wfMh7r0Z
         A6Y9Z3TPk+Ab82N+NmYB2OnVKWaCUHCTgHN0UhwwMUQMNVjPIoQEil8H63bmws1ajyLm
         c8SgZr+FrY9GTFMZCW0L6fhhEzU6Y69PXz6uKur8M+Mc4P9fAF3r/3YIwJDcs0a0LpS6
         Q4fDdmvatvlWqNnQgJTKC1fD6aX9bs2/gf9Osd5oLBNmpg3tN/Z9CoUO4/zBucqN8BlP
         0dtkdl8YpMdaAWtvpScKUKi8oCSlC7VcPplBvojfKWEUMUgN8u1h7/6B5qx6R7rHDmfx
         Cy0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761733351; x=1762338151;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CaK0Y+U8EyOJTcVJLV4yd3je0ipYJSA70UshUjw3R/A=;
        b=Ar8FWhHHB6ScmCvDEq0rZwzXvHpV5EDsBJ8gWU6losADAB8wBsU7cy7nBGk5Tu0R+D
         WrbDIQzzjo8GoBiWn+uNJNs617aDtwo1QgHLnMSYVS/S9eHjEj7tfgvv1uMGSn20fPfJ
         wgqdJXgioU+ZI5BD+WNjxre/eggTreQtVKWRjc50XMipGlJ/tgQKrsnG0MQtKFY8d91M
         xK02aYWNkMmGddjLRNqfDsstUPghsB7mPCnV6tSE8q4F8ElpZxlTXW77SSWQAa8MpaNm
         4DEq4i/Uq5lzbjHS0vcs7HszIWr+6s8c9DPiAWYicmGRlOWXeLGBe6hleuL+vMiXYSVL
         xoGA==
X-Forwarded-Encrypted: i=1; AJvYcCWh44aP2xDl3M9uJEddYM09t3WRyN3g5I8tk9Y2PlwXkhm36tWiFzzQjEJn5inqTVi9zAAHLHeh3bG0lys=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxERLrd9InSHhTkwDIgn2EyK2doEvu9fF1oRyiJj6qBBWoioK7
	bC2yoASFGoj3+ayrNiCR+57QZNuWTVJvPcVgh66PG3D0N8L5eVDJfzAa
X-Gm-Gg: ASbGnct0FEj8vv2r8gHrp/VVxDQkNpGQuTIg0QNzwdF9QBImKyzGOk6Tu4aj/jH624h
	3pb8i5QykkjpjDqSBXJg//q9wmk8Voaegx37qHkf4QHuPCaqCPwJV9eQKZGRrGGNmoiMswe91lf
	mnp9eVTIwDfZgFUB6BS24W72EQIYhbpspH+QSBfQSN5OQQFR8vdlFMlr5exKhQFGWFkxIqoOMWY
	OKvfrQcCBH2Ogj883p4r5lNLr+ERIb3rWcP+w+tgtFqJMhjUDipvev6f+tu5/oseP6JdBPn7i1r
	nso6MOlf8de1UghKT1jV+jcZHvkovU06XQ6M92pt7Dkntn7C1ZYO+XTHo6QeQ+e/F1qznjS6Xoq
	E7gUo5kRr0FM9WpYg14+tFRWGq2gg40iVHsTdLUq21FUH8ZE6K0tRsoUYoz5gcblWe8uve0KemU
	BVXgV/9TEsiarjyOZrm+OPnYPl/kwUuE4btFyI8C4Nhp8QWS5/
X-Google-Smtp-Source: AGHT+IGCCgzey2mzi6yDKN8dSfxqXC9OWyqwu17oecdDRdDppwX8pd9wygSxZg2vNpCi3EKa8rTTBA==
X-Received: by 2002:a17:903:246:b0:27e:d66e:8729 with SMTP id d9443c01a7336-294de3ff602mr28472395ad.0.1761733350541;
        Wed, 29 Oct 2025 03:22:30 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498d274b6sm144928165ad.59.2025.10.29.03.22.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Oct 2025 03:22:30 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <8f7c2544-2b9d-4997-942a-5bd3ea72e3a3@roeck-us.net>
Date: Wed, 29 Oct 2025 03:22:27 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/6] platform/x86: ayaneo-ec: Add suspend hook
To: Antheas Kapenekakis <lkml@antheas.dev>,
 "Mario Limonciello (AMD) (kernel.org)" <superm1@kernel.org>
Cc: platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hwmon@vger.kernel.org, Hans de Goede <hansg@kernel.org>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Derek John Clark <derekjohn.clark@gmail.com>,
 =?UTF-8?Q?Joaqu=C3=ADn_Ignacio_Aramend=C3=ADa?= <samsagax@gmail.com>,
 Jean Delvare <jdelvare@suse.com>
References: <20251015084414.1391595-1-lkml@antheas.dev>
 <20251015084414.1391595-7-lkml@antheas.dev>
 <38a49942-58d3-49cf-90d7-1af570918ae5@kernel.org>
 <CAGwozwEmjms0H=GPbevuOjJfed6x69wmg8E9begBhUKbF8B2AQ@mail.gmail.com>
 <000cd38e-7052-4987-b5bc-b8de176363cf@kernel.org>
 <CAGwozwFDsn0xm_mG4ypEym=K8c81qqi=qtJL=06nP6SzdFaFoQ@mail.gmail.com>
 <b98a8486-e90a-4bd5-b3a7-3b2ba1b16398@kernel.org>
 <CAGwozwHa3GSNGyRRp4=bR+Wsy2VLgwAbSmcdWb2=5rEyi7jdQw@mail.gmail.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <CAGwozwHa3GSNGyRRp4=bR+Wsy2VLgwAbSmcdWb2=5rEyi7jdQw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/29/25 01:48, Antheas Kapenekakis wrote:
> On Wed, 29 Oct 2025 at 04:36, Mario Limonciello (AMD) (kernel.org)
> <superm1@kernel.org> wrote:
>>
>>
>>
>> On 10/28/2025 4:39 PM, Antheas Kapenekakis wrote:
>>> On Tue, 28 Oct 2025 at 22:21, Mario Limonciello <superm1@kernel.org> wrote:
>>>>
>>>> On 10/28/25 3:34 PM, Antheas Kapenekakis wrote:
>>>>>>> The fan speed is also lost during hibernation, but since hibernation
>>>>>>> failures are common with this class of devices
>>>> Why are hibernation failures more common in this class of device than
>>>> anything else?  The hibernation flow is nearly all done in Linux driver
>>>> code (with the exception of ACPI calls that move devices into D3 and out
>>>> of D0).
>>>
>>> I should correct myself here and say hibernation in general in Linux
>>> leaves something to be desired.
>>>
>>> Until secure boot supports hibernation, that will be the case because
>>> not enough people use it.
>>
>> The upstream kernel has no tie between UEFI secure boot and hibernation.
>>    I think you're talking about some distro kernels that tie UEFI secure
>> boot to lockdown.  Lockdown does currently prohibit hibernation.
>>
>>>
>>> I have had it break for multiple reasons, not incl. the ones below and
>>> the ones we discussed last year where games are loaded.
>>>
>>> For a few months I fixed some of the bugs but it is not sustainable.
>>>
>>>> Perhaps you're seeing a manifestation of a general issue that we're
>>>> working on a solution for here:
>>>>
>>>> https://lore.kernel.org/linux-pm/20251025050812.421905-1-safinaskar@gmail.com/
>>>>
>>>> https://lore.kernel.org/linux-pm/20251026033115.436448-1-superm1@kernel.org/
>>>>
>>>> https://lore.kernel.org/linux-pm/5935682.DvuYhMxLoT@rafael.j.wysocki/T/#u
>>>>
>>>> Or if you're on an older kernel and using hybrid sleep we had a generic
>>>> issue there as well which was fixed in 6.18-rc1.
>>>>
>>>> Nonetheless; don't make policy decisions based upon kernel bugs.  Fix
>>>> the kernel bugs.
>>>
>>> My problem is I cannot in good conscience restore a fan speed before
>>> the program responsible for it is guaranteed to thaw.
>>>
>>> The best solution I can come up with would be in freeze save if manual
>>> control is enabled, disable it, and then on resume set a flag that
>>> makes the first write to fan speed also set pwm to manual.
>>>
>>> This way suspend->hibernate flows, even if hibernation hangs when
>>> creating the image, at least have proper fan control because they are
>>> unattended, and resume hangs work similarly.
>>>
>>> Antheas
>>>
>>
>> This sounds like a workable approach for what I understand to be your
>> current design; but let me suggest some other ideas.
>>
>> What happens if you're running something big and the OOM comes and
>> whacks the process?  Now you don't have fan control running anymore.
>>
>> So I see two options to improve things.
>>
>> 1) You can have userspace send a "heartbeat" to kernel space.  This can
>> be as simple as a timestamp of reading a sysfs file.  If userspace
>> doesn't read the file in X ms then you turn off manual control.
> 
> The OOT scenario is something I have not handled yet specifically, or
> have had happen.
> 
> Systemd will restart the service in the case of OOT after 5 seconds
> and in the case of a crash there are multiple fallbacks to ensure the
> custom curve turns off.
> 
> Most of the hibernation hangs that I have experienced happen before
> journalctl turns on, so I assumed that it's before userspace
> unfreezes. I am also not sure if restore() gets to run in those cases
> or not.
> 
> Re: heart beat, read below.
> 
>> 2) You move everything to a kthread.  Userspace can read some input
>> options or maybe pick a few curve settings, but leave all the important
>> logic in that kthread.
> 
> I think this is what Luke tried to do with the Zotac Zone. But in the
> end, the kernel is limited to what calculations it can do, esp.
> floating point and what it can access, so you end up with a worse
> curve with limited extendability, and a driver specific ABI. And we
> also risk duplicating all of this code on hwmon drivers and making it
> harder to access.
> 
> I think part of this reason is why the platform side of the Zotac
> stuff has not been upstreamed, even though the driver itself other
> than that is pretty straightforward with an established ABI by now.
> And it is also the reason we have not been able to add the module to
> Bazzite, because 1) we cannot validate the new fan curve calculations
> without a device and 2) they are worse that what we provide through
> userspace (a polynomial ramp-up which embeds hysteresis to avoid
> jittering, plus choice for both Edge and Tctl sensors).
> 
> In summary, I think there would great potential for a common set of
> "hwmon" helpers that can use a temperature function and a speed set
> function to handle a basic multi-point curve for basic, e.g., udev
> use-cases. To that end, there could be a helper with a 5 second
> timeout that turns off the custom speed. But it would be good for that
> to be implemented globally, so it does not block device hw enablement.
> 

Maybe I misunderstand. If so, apologies.

Thermal _control_ is what the thermal subsystem is for. hwmon is for
hardware monitoring, not control. You may do whatever you like
in platform drivers, including the duplication of termal subsystem
functionality, but please do not get hwmon involved. That includes
any kind of helpers to compute any kind of temperature curves.

Thanks,
Guenter


