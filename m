Return-Path: <linux-kernel+bounces-722174-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 46361AFD645
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 20:17:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F187D1C203A0
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 18:17:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E497E21B1AA;
	Tue,  8 Jul 2025 18:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="An5mrefw"
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 312412AD16
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 18:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751998613; cv=none; b=EBj0aGuhaiMbytETB0mdlANjJJC97dpJVxWCYwgN8FJiSU3o60PKZT2AwDkFbCZVjHQgAxKPiasidPB7M2JTI7muQMu5D70M/yE97SDOCVg2b7EzU+S0+y25u1GOv//I7osB7uXx4XDcP8wRb1utPsyukU7PTaGN0DTFsBORHOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751998613; c=relaxed/simple;
	bh=j2g5+Is/hApnidHglP5yM9mLknqV0ultVfEaIH/wJ8Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WFsbZrECaVVUBpiNDEIITat7oaO4ngYTIAdjLl2mMdNZ//ZgIV9j3Ql7ULpAoam1jbTFBPaDTWRMcIDZbxF7JNdMAjuPPV6ea9TwqmpERv+vtGFTOlM/1Pz+k6gXPB0cFrseYmgWC9VR7ZycnHOWIHx4nmR5GWz/Ew6bz1PHnAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=An5mrefw; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-3df2f937370so17103745ab.3
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jul 2025 11:16:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1751998610; x=1752603410; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=C7jo4rHGV68En57t/lie16xVqPLtbUOSRY9RxAWU0Dk=;
        b=An5mrefwiL8aNZB9GJ1zJ87Dij5zBjhjhYknTa1ck3tBxhdzGtP1W5Qm/jEAlFhHiS
         LGM2yb7b5XqaWcuR+INFXycquk+pjqNOANaJotP8VA2hbdtRrxvQorQt9iUAKYe2UFbg
         x4Zvqa1rcEv9snsB0RV4+siPd8wNhaBjOfP6E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751998610; x=1752603410;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C7jo4rHGV68En57t/lie16xVqPLtbUOSRY9RxAWU0Dk=;
        b=C9D1SFl3xGqrKqMg7IntcG/GYw9CSGBEOQ2YRCLQukuYIhSK22xCXLXexrBGSlAnqD
         FLnvnsD99PC6jyVLj2MQYGzvJe3OE8O9DLrn7d5nbRkPiKWKY8tEpweLTqHGGC34h5iR
         RULNhTXQBiR19zc7WGfAiqERCeT1rR+qrHt+pWjq6aRWzqkwOFPkydfMuweEmzSNQeko
         5s9Lu+QQqth6klUFKNvMvkKKG1WRaARYOcjTDCoQl5fVNRGSasbWtqnr6cNijSXHg4Yn
         zgWxYRpo1u6GRBLq2zhnY3DvfH0jU2glNilHwoRMLbJfW28I/vOTeBBPufO11iZcx0R+
         S8aA==
X-Forwarded-Encrypted: i=1; AJvYcCWzYvCC95hODPWLGEeYPR577gK8dD5Vl3/MUkugKiimqD1B/1HZTJkPFLId6jLU/n0/Yd9KlNkRRUwmomc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYb/KSsFG8QjnGJ8gzbsPeovX2AYQYdcY7MK3UJ7yW9oXnwqPt
	v3WCS+UTUpyVRH46ggeTIso+brWCxCfoDiHO5G7DSLKT3I9Q5BAZg7PbTlnh2F1qvK8=
X-Gm-Gg: ASbGncsJMEiRS2Gwm4mJKOH0SW6y3i4z1dUG2Auxd0cKK5mW9C8Lz+r7URxD5XThBQk
	AYnVYWnVkHB5buPRJe+qa/7rkssV1Np6OTt80d3gnlcjZDcG7fedWwa9vavt2+KULI2wcCP6b0z
	Ldb5rt8N+httgkAO+q1qtqQHVg2hlKgjjLGTgZFLkp+mUKfVTies1q9cAgF/RIdsRucKAUlLtgT
	w0Cfjuyv2qIgu/CIFdHNPQjegxDUILmR4aRxyGsfe3+uj7zJWiF4sfd18Y9CmVO6zmUIYK+1svs
	P3w5DXqxZIyLC17dHRayIBumkVUjk4mouT16bNDo1ASz/p3EZ62VxL6LfPT9P1NvJix7Sd7u+g=
	=
X-Google-Smtp-Source: AGHT+IHGrAuuZogaOqKoDaYMbOfBAJ6945Z6uLUhTaT77JDUVgSGXD/OFcwY5bIrrh4qPYT0vOL8dw==
X-Received: by 2002:a05:6e02:3191:b0:3df:43ac:af5a with SMTP id e9e14a558f8ab-3e1637ebf77mr10609085ab.2.1751998610029;
        Tue, 08 Jul 2025 11:16:50 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-503b5a29eb4sm2332522173.57.2025.07.08.11.16.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Jul 2025 11:16:49 -0700 (PDT)
Message-ID: <2a901b8a-9052-41d9-a70d-76508ebd819b@linuxfoundation.org>
Date: Tue, 8 Jul 2025 12:16:48 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] usbip: convert to use faux_device
To: Zongmin Zhou <min_halo@163.com>, Greg KH <gregkh@linuxfoundation.org>
Cc: shuah@kernel.org, valentina.manea.m@gmail.com, i@zenithal.me,
 linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
 zhouzongmin@kylinos.cn, Shuah Khan <skhan@linuxfoundation.org>
References: <2a327b520760271471717fff9b222cdc34967489.1746662386.git.zhouzongmin@kylinos.cn>
 <20250604065410.76069-1-min_halo@163.com>
 <2025061926-paycheck-footnote-a2b8@gregkh>
 <c7a2cc26-794e-49e1-bf8c-35617bb8060f@163.com>
 <2025062010-hardiness-flashily-cb0f@gregkh>
 <9d95bb75-586c-48dc-9e34-432cc13fd99f@163.com>
 <2025062004-navy-emboss-4743@gregkh>
 <2e0bbc5a-e74a-4fb5-884c-686dbaf99caf@linuxfoundation.org>
 <48ab511e-2847-4daa-98de-a234b8584b78@163.com>
 <fac026d8-12c8-4c1f-96a7-264ced8391f1@linuxfoundation.org>
 <a29703bd-08b7-489b-8fb0-15838a1245ab@163.com>
 <1a13cf53-ffed-4521-917e-9c2856a5e348@linuxfoundation.org>
 <4fc877f0-b55b-4fa3-8df4-2de4ba1ac51b@163.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <4fc877f0-b55b-4fa3-8df4-2de4ba1ac51b@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 7/3/25 00:04, Zongmin Zhou wrote:
> 
> On 2025/7/3 07:54, Shuah Khan wrote:
>> On 7/1/25 20:12, Zongmin Zhou wrote:
>>>
>>> On 2025/7/2 06:56, Shuah Khan wrote:
>>>> On 6/23/25 21:21, Zongmin Zhou wrote:
>>>>>
>>>>> On 2025/6/21 01:26, Shuah Khan wrote:
>>>>>> On 6/20/25 03:27, Greg KH wrote:
>>>>>>> On Fri, Jun 20, 2025 at 05:19:33PM +0800, Zongmin Zhou wrote:
>>>>>>>>
>>>>>>>> On 2025/6/20 12:29, Greg KH wrote:
>>>>>>>>> On Fri, Jun 20, 2025 at 10:16:16AM +0800, Zongmin Zhou wrote:
>>>>>>>>>> On 2025/6/19 19:01, Greg KH wrote:
>>>>>>>>>>> On Wed, Jun 04, 2025 at 02:54:10PM +0800, Zongmin Zhou wrote:
>>>>>>>>>>>> From: Zongmin Zhou <zhouzongmin@kylinos.cn>
>>>>>>>>>>>>
>>>>>>>>>>>> The vhci driver does not need to create a platform device,
>>>>>>>>>>>> it only did so because it was simple to do that in order to
>>>>>>>>>>>> get a place in sysfs to hang some device-specific attributes.
>>>>>>>>>>>> Now the faux device interface is more appropriate,change it
>>>>>>>>>>>> over to use the faux bus instead.
>>>>>>>>>>>>
>>>>>>>>>>>> Signed-off-by: Zongmin Zhou <zhouzongmin@kylinos.cn>
>>>>>>>>>>>> ---
>>>>>>>>>>>> Changes in v2:
>>>>>>>>>>>> - don't change faux create api,just call probe on vhci_hcd_init.
>>>>>>>>>>>>
>>>>>>>>>>>>     drivers/usb/usbip/vhci.h             |  4 +-
>>>>>>>>>>>>     drivers/usb/usbip/vhci_hcd.c         | 86 +++++++++++-----------------
>>>>>>>>>>>>     drivers/usb/usbip/vhci_sysfs.c       | 68 +++++++++++-----------
>>>>>>>>>>>>     tools/usb/usbip/libsrc/vhci_driver.h |  2 +-
>>>>>>>>>>>>     4 files changed, 72 insertions(+), 88 deletions(-)
>>>>>>>>>>> I get the following build errors from this patch:
>>>>>>>>>>>
>>>>>>>>>>> drivers/usb/usbip/vhci_hcd.c:1462:12: error: ‘vhci_hcd_resume’ defined but not used [-Werror=unused-function]
>>>>>>>>>>>     1462 | static int vhci_hcd_resume(struct faux_device *fdev)
>>>>>>>>>>>          |            ^~~~~~~~~~~~~~~
>>>>>>>>>>> drivers/usb/usbip/vhci_hcd.c:1418:12: error: ‘vhci_hcd_suspend’ defined but not used [-Werror=unused-function]
>>>>>>>>>>>     1418 | static int vhci_hcd_suspend(struct faux_device *fdev, pm_message_t state)
>>>>>>>>>>>          |            ^~~~~~~~~~~~~~~~
>>>>>>>>>>> cc1: all warnings being treated as errors
>>>>>>>>>>>
>>>>>>>>>>> Are you sure you tested this?
>>>>>>>>>> I apologize for not enabling -Werror, which resulted in missing this error
>>>>>>>>>> warning.
>>>>>>>>>> I have tested usbip feature use the new patch,but not test system
>>>>>>>>>> suspend/resume.
>>>>>>>>>> The faux bus type don't add pm function,and vhci-hcd driver can't register
>>>>>>>>>> it.
>>>>>>>>>> Maybe have to add suspend/resume for it.like below:
>>>>>>>>>> static const struct bus_type faux_bus_type = {
>>>>>>>>>>       .name        = "faux",
>>>>>>>>>>       .match        = faux_match,
>>>>>>>>>>       .probe        = faux_probe,
>>>>>>>>>>       .remove        = faux_remove,
>>>>>>>>>>       .resume     = faux_resume,
>>>>>>>>>>       .suspend    = faux_suspend,
>>>>>>>>>> };
>>>>>>>>>>
>>>>>>>>>> Is that right?
>>>>>>>>>> Your expertise would be greatly valued.
>>>>>>>>> As this is not real hardware, why do you need the suspend/resume
>>>>>>>>> callbacks at all?  What is happening here that requires them?
>>>>>>>> @greg,
>>>>>>>> The vhci_hcd_suspend/vhci_hcd_resume interfaces are not designed for this
>>>>>>>> faux device, but rather to
>>>>>>>> manipulate the HCD_FLAG_HW_ACCESSIBLE bit in the hcd flags associated with
>>>>>>>> the faux device.
>>>>>>>> For example:
>>>>>>>> During system standby: clear_bit(HCD_FLAG_HW_ACCESSIBLE, &hcd->flags)
>>>>>>>> During system wakeup: set_bit(HCD_FLAG_HW_ACCESSIBLE, &hcd->flags)
>>>>>>>>
>>>>>>>> Previously, these two functions were registered through platform_driver,
>>>>>>>> but faux bus does not have the relevant interface, so they were not called,
>>>>>>>> resulting in this compilation warning error.
>>>>>>>>
>>>>>>>> This raises the question: Should the faux bus implement PM-related
>>>>>>>> interface?
>>>>>>>> I'm uncertain whether these functions are essential for the vhci-hcd driver
>>>>>>>> or if they can be safely removed.
>>>>>>>>
>>>>>>>> However, during system standby/wakeup tests with remote USB devices bound to
>>>>>>>> the vhci-hcd driver,
>>>>>>>> I observed consistent failure scenarios across both the original platform
>>>>>>>> bus and faux bus patch implementations.
>>>>>>
>>>>>> suspend and resume hooks have been in the code from beginning
>>>>>> in the CONFIG_PM path. The original authors are skeptical about
>>>>>> what should happen during suspend"
>>>>>>
>>>>>> /* what should happen for USB/IP under suspend/resume? */
>>>>>> suspend hook checks for active connections and sends EBBUSY
>>>>>> back to pm core.
>>>>>>
>>>>>> Active connection means any of the ports are in USB_PORT_STAT_CONNECTION
>>>>>> state. So as long as there are active connections between vhci client
>>>>>> and the host, suspend won't work. So we really don't know what happens
>>>>>> to the active connections if there are no suspend/resume hooks.
>>>>>>
>>>>>> If there are no active connections, then it will clear the HCD_FLAG_HW_ACCESSIBLE
>>>>>> bit and returns to pm core to continue with suspend.
>>>>>>
>>>>>> resume sets the HCD_FLAG_HW_ACCESSIBLE flag to indicate hardware is accessible
>>>>>> and initiates port status poll.
>>>>>>
>>>>>> - suspend hook prevents suspend
>>>>>>
>>>>>> With faux device since there is no suspend and resume hook, I would expect
>>>>>> these hooks are not a factor in suspend and resume.
>>>>>>
>>>>>> vhci_hcd is a special case virtual driver as it is a proxy for controlling
>>>>>> hardware on the host.
>>>>>>
>>>>>> Zongmin,
>>>>>>
>>>>>> Do suspend/resume work when vhci_hcd is not loaded?
>>>>>> What happens when when system suspends and resumes with faux device?
>>>>>> Can you send me dmesg logs and pm logs?
>>>>>>
>>>>> Hi Greg,shuah
>>>>>
>>>>> Yes, system with vhci_hcd unload or just load vhci_hcd driver
>>>>> without usbip devices bound to vhci_hcd,system suspend/resume worked well.
>>>>> Some logs for you.
>>>>
>>>> Sorry for the delay. I was at a conference last week.
>>>> Thank you for sending these logs.
>>>>
>>>>> 1.system with vhci_hcd driver load,but don't bound any usbip devices to vhci_hcd,suspend/resume worked well.
>>>>> see dmesg-faux bus-load.log
>>>>
>>>>
>>>>>
>>>>> 2.usbip device bound to vhci_hcd,and do system suspend action,suspend/resume worked failed.
>>>>> I observed two distinct failure scenario:
>>>>> Scenario 1: System failed to enter suspend state,and will auto resume;
>>>>
>>>>
>>>>> the log for use platform bus:
>>>>> dmesg-platform bus-device bound-auto resume.log
>>>>
>>>> This is clear from the suspend hook in the vhci_hcd.
>>>> When it returns EBUSY, suspend will fail and move to
>>>> auto resume.
>>>>
>>>>> the log for use faux bus:
>>>>> dmesg-faux bus-device bound-auto resume.log
>>>>
>>>> It is good that the behavior is same with faux bus even though
>>>> suspend hook isn't called. I will take a look at the log.
>>>>
>>>>>
>>>>> Scenario 2: System resume failed with black screen freeze,a forced restart of the machine is require.
>>>>> the log for use platform bus:
>>>>> dmesg-platform bus-device bound-black screen.log
>>>>> the log for use faux bus:
>>>>> dmesg-faux bus-device bound-black screen.log
>>>>
>>>> That is bad. When does this happen? Is there a difference in
>>>> configuration?
>>>>
>>> No, there's no difference. The same code is used for two different failure scenarios.
>>> I just tested many times. These two different situations occur probabilistically.
>>> But they both happened only when the USBIP device is bound to the vhci_hcd driver.
>>>> The behavior same for platform bus and faux bus. Sounds like
>>>> an existing problem that needs to be debugged separately.
>>>>
>>>> I will take a look at all these logs and get back to you in
>>>> a day or two.
>>>>
>>
>> I looked at the logs and here is what I found:
>>
>> Scenario 1:
>>   dmesg-faux bus-device bound-auto resume.log
>>   dmesg-platform bus-device bound-auto resume.log
>>
>> In this case suspend bailed out way before driver suspend
>> when vhci_hcd is using platform and faux bus.
>>
>> Freezing remaining freezable tasks failed after 20.006 seconds (0 tasks refusing to freeze, wq_busy=1)
>> Restarting kernel threads ... done
>> OOM killer enabled.
>> Restarting tasks ... done.
>> random: crng reseeded on system resumption
>> PM: suspend exit
>>
>> Auto-resume of the user-space worked. Scenario 1 isn't really
>> interesting.
>>
>> Scenario 2:
>>   dmesg-faux bus-device bound-black screen.log
>>   dmesg-platform bus-device bound-black screen.log
>>
>> Even though the result is the same in seeing blank screen, how
>> we get there is different.
>>
>> =================
>> faux-bus device:
>> =================
>> - suspend worked - looks like
>>   usb 4-1: PM: calling usb_dev_suspend @ 6054, parent: usb4
>>   usb 4-1: PM: usb_dev_suspend returned 0 after 13675 usecs
>>   usb usb4: PM: calling usb_dev_suspend @ 6055, parent: vhci_hcd.0
>>   usb usb4: PM: usb_dev_suspend returned 0 after 9 usecs
>>
>> vhci_hcd suspend isn't in play here. usb_dev_suspend() returns.
>> See below
>>
>> usb 4-1: PM: usb_dev_suspend returned message.
>>
>> -------------------------------------------------------------
>>
>> - resume started (assuming it has been initiated by user)
>>
>> [  650.027491][ T6056] pci 0000:00:01.0: PM: pci_pm_suspend_noirq returned 0 after 304 usecs
>>
>> See see timestamp difference between the last suspend message and the
>> first resume message.
>> [  674.000257][   T39] pci 0000:00:00.0: PM: calling pci_pm_resume_noirq @ 39, parent: pci0000:00
>>
>> usb 4-1 usb_dev_resume never returns.
>>
>> [  674.071125][ T6117] usb usb4: PM: usb_dev_resume returned 0 after 21110 usecs
>> [  674.113991][ T6126] usb 4-1: PM: calling usb_dev_resume @ 6126, parent: usb4
>>
>> -------------------------------------------------------------
>>
>> =====================
>> platform bus device
>> =====================
>>
>> - suspend was aborted because vhci_hcd suspend routine returned error
>>
>> [  297.854621][ T9402] usb 4-1: PM: calling usb_dev_suspend @ 9402, parent: usb4
>> [  297.868524][ T9402] usb 4-1: PM: usb_dev_suspend returned 0 after 13214 usecs
>> [  297.869994][ T9403] usb usb4: PM: calling usb_dev_suspend @ 9403, parent: vhci_hcd.0
>> [  297.871959][ T9403] usb usb4: PM: usb_dev_suspend returned 0 after 30 usecs
>> [  297.873644][ T9394] vhci_hcd vhci_hcd.0: PM: calling platform_pm_suspend @ 9394, parent: platform
>> [  297.874738][ T9394] vhci_hcd vhci_hcd.0: We have 1 active connection. Do not suspend.
>> [  297.875369][ T9394] vhci_hcd vhci_hcd.0: PM: dpm_run_callback(): platform_pm_suspend returns -16
>> [  297.876078][ T9394] vhci_hcd vhci_hcd.0: PM: platform_pm_suspend returned -16 after 1341 usecs
>> [  297.876774][ T9394] vhci_hcd vhci_hcd.0: PM: failed to suspend: error -16
>>
>> - the following triggers resume
>> [  297.877321][ T9394] PM: Some devices failed to suspend, or early wake event detected
>>
>> [  297.881065][ T9403] usb usb3: PM: usb_dev_resume returned 0 after 19 usecs
>> [  297.904551][ T9408] usb usb4: PM: usb_dev_resume returned 0 after 22911 usecs
>> [  297.905148][ T9418] usb 4-1: PM: calling usb_dev_resume @ 9418, parent: usb4
>>
>> usb 4-1 usb_dev_resume never returns.
>>
>> Note - In both cases, usb_dev_resume doesn't return. When it is called is the
>> difference.
>>
>> I don't think suspend/resume works when devices are bound. Suspend exits and
>> starts resume which seems to fail because it doesn't handle the virtual usb
>> device resume. There is a missing piece here.
>>
>> When vhci_hcd imports a device and acts as a proxy between the virtual mass
>> storage device (e.g in this case) - it appears suspend and resume are
>> handled as if it is a usb device. Maybe this is incorrect?
>>
>> usb_dev_suspend() works and usb_dev_resume() on these virtual usb devices?
>> Do we need to handle this in usb_dev_resume()?
>>
>> Talking out loud - I have to do some looking into.
>>
> Re:
> Yes, your analysis is completely correct.
> 
> In fact, I've experimented with adding PM hooks to the faux bus,
> and found that faux bus devices then behave identically to platform bus devices during suspend/resume.
> See the attachment.
> 

Thanks for checking this scenario. No surprises here.

> This is likely a historical legacy issue.

It is an existing problem in the way vhci_hcd and the bound devices
handle suspend/resume. vhci_hcd suspend assumes once it returns
"don't suspend" the rest works. However suspend for the bound device
runs first and a subsequent resume on it fails.

This problem needs fixing - I don't know yet how to.

> Regarding this matter, is there anything else you'd like me to assist with?
> 

One thing I am curious about is the status of the bound devices after
"forced restart of the machine" when you see blank screen or hang?

thanks,
-- Shuah

