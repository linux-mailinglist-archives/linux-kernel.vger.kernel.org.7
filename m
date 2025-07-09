Return-Path: <linux-kernel+bounces-723174-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F672AFE405
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 11:23:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94970543AE2
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 09:23:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C930B284B59;
	Wed,  9 Jul 2025 09:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="XfQI2MuO"
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5163327CCE7;
	Wed,  9 Jul 2025 09:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752052990; cv=none; b=Ps3zNMDx3/T/5qobIEejGvSPdEf4jgyFUpkOUlCEEICMaVgkLHH45CBnu78zwAVx1njk4aud8J6eDlszlk/5No1Qy4Wa38QwbhCeHSoAHMjJmxk7wCXXInFidivFjPRxXHGuh1MDoNpsC5s1d4Ul+knxkkd1HOrCujccB+GW+9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752052990; c=relaxed/simple;
	bh=HuVIzXBfCv79bzIT1h8TkemmfI13AOm0EPLux+pvoZU=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To; b=DhlApKRGKdQ2a44pp0dEy8LpDtytmw9BBkzIBWp6vm2f7NeRqVlAKr1Mei+4hmUErVg94D64BnysfjWlZadFdqWymXDvBEPz7oqs3E7ACTOdpZVDYZTFuDDSE30kvhWMXvLnoFEe65dm1FdB3g/j9I96RFGxIWmEw/3zVQvYuns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=XfQI2MuO; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Content-Type:Message-ID:Date:MIME-Version:Subject:
	To:From; bh=WES0uWYlfNWXpvgX3KzaRPhfHA7ooqXVIipWNURhpYs=; b=XfQI
	2MuO+cr8LC7/Df50yVIn3pN8kLsXddNQEt+Kexoy7dG0NNGx6C6YT0SQgcz+o2V3
	d1hA5YY6fZObjQGFlxiomca0ABqXo+HcyCGcDl7rVZfWAQ1+tCdJMykSullCjajq
	kSq1pi+fORia5Wj5VhGn4HZxDA6403mGULQBjR0=
Received: from [10.42.12.155] (unknown [])
	by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id _____wAnLMRMMW5oIHcZDg--.4053S2;
	Wed, 09 Jul 2025 17:07:25 +0800 (CST)
Content-Type: multipart/mixed; boundary="------------jn3AIRR01B8SkEpGew43qimZ"
Message-ID: <4759911b-8c35-4ca9-bc34-09dd41b14582@163.com>
Date: Wed, 9 Jul 2025 17:07:24 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] usbip: convert to use faux_device
Content-Language: en-US
To: Shuah Khan <skhan@linuxfoundation.org>,
 Greg KH <gregkh@linuxfoundation.org>
Cc: shuah@kernel.org, valentina.manea.m@gmail.com, i@zenithal.me,
 linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
 zhouzongmin@kylinos.cn
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
 <2a901b8a-9052-41d9-a70d-76508ebd819b@linuxfoundation.org>
From: Zongmin Zhou <min_halo@163.com>
In-Reply-To: <2a901b8a-9052-41d9-a70d-76508ebd819b@linuxfoundation.org>
X-CM-TRANSID:_____wAnLMRMMW5oIHcZDg--.4053S2
X-Coremail-Antispam: 1Uf129KBjvAXoW3KFyDAFyDuF1kGr4kArW8Zwb_yoW8XF4fto
	WrZw1fC3W8Jr1UJ3Wjy3WDJw1UJ3WkXw1kJFy5tr15Crs8t3W5Wr18Jr1UWa15tw45CF4D
	Jw18tws8AFyUXryfn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
	AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxU0c_TDUUUU
X-CM-SenderInfo: pplqsxxdorqiywtou0bp/1tbiUBeEq2htWYjX9QACsc

This is a multi-part message in MIME format.
--------------jn3AIRR01B8SkEpGew43qimZ
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 2025/7/9 02:16, Shuah Khan wrote:
> On 7/3/25 00:04, Zongmin Zhou wrote:
>>
>> On 2025/7/3 07:54, Shuah Khan wrote:
>>> On 7/1/25 20:12, Zongmin Zhou wrote:
>>>>
>>>> On 2025/7/2 06:56, Shuah Khan wrote:
>>>>> On 6/23/25 21:21, Zongmin Zhou wrote:
>>>>>>
>>>>>> On 2025/6/21 01:26, Shuah Khan wrote:
>>>>>>> On 6/20/25 03:27, Greg KH wrote:
>>>>>>>> On Fri, Jun 20, 2025 at 05:19:33PM +0800, Zongmin Zhou wrote:
>>>>>>>>>
>>>>>>>>> On 2025/6/20 12:29, Greg KH wrote:
>>>>>>>>>> On Fri, Jun 20, 2025 at 10:16:16AM +0800, Zongmin Zhou wrote:
>>>>>>>>>>> On 2025/6/19 19:01, Greg KH wrote:
>>>>>>>>>>>> On Wed, Jun 04, 2025 at 02:54:10PM +0800, Zongmin Zhou wrote:
>>>>>>>>>>>>> From: Zongmin Zhou <zhouzongmin@kylinos.cn>
>>>>>>>>>>>>>
>>>>>>>>>>>>> The vhci driver does not need to create a platform device,
>>>>>>>>>>>>> it only did so because it was simple to do that in order to
>>>>>>>>>>>>> get a place in sysfs to hang some device-specific attributes.
>>>>>>>>>>>>> Now the faux device interface is more appropriate,change it
>>>>>>>>>>>>> over to use the faux bus instead.
>>>>>>>>>>>>>
>>>>>>>>>>>>> Signed-off-by: Zongmin Zhou <zhouzongmin@kylinos.cn>
>>>>>>>>>>>>> ---
>>>>>>>>>>>>> Changes in v2:
>>>>>>>>>>>>> - don't change faux create api,just call probe on 
>>>>>>>>>>>>> vhci_hcd_init.
>>>>>>>>>>>>>
>>>>>>>>>>>>>     drivers/usb/usbip/vhci.h |  4 +-
>>>>>>>>>>>>>     drivers/usb/usbip/vhci_hcd.c         | 86 
>>>>>>>>>>>>> +++++++++++-----------------
>>>>>>>>>>>>>     drivers/usb/usbip/vhci_sysfs.c       | 68 
>>>>>>>>>>>>> +++++++++++-----------
>>>>>>>>>>>>>     tools/usb/usbip/libsrc/vhci_driver.h |  2 +-
>>>>>>>>>>>>>     4 files changed, 72 insertions(+), 88 deletions(-)
>>>>>>>>>>>> I get the following build errors from this patch:
>>>>>>>>>>>>
>>>>>>>>>>>> drivers/usb/usbip/vhci_hcd.c:1462:12: error: 
>>>>>>>>>>>> ‘vhci_hcd_resume’ defined but not used 
>>>>>>>>>>>> [-Werror=unused-function]
>>>>>>>>>>>>     1462 | static int vhci_hcd_resume(struct faux_device 
>>>>>>>>>>>> *fdev)
>>>>>>>>>>>>          |            ^~~~~~~~~~~~~~~
>>>>>>>>>>>> drivers/usb/usbip/vhci_hcd.c:1418:12: error: 
>>>>>>>>>>>> ‘vhci_hcd_suspend’ defined but not used 
>>>>>>>>>>>> [-Werror=unused-function]
>>>>>>>>>>>>     1418 | static int vhci_hcd_suspend(struct faux_device 
>>>>>>>>>>>> *fdev, pm_message_t state)
>>>>>>>>>>>>          |            ^~~~~~~~~~~~~~~~
>>>>>>>>>>>> cc1: all warnings being treated as errors
>>>>>>>>>>>>
>>>>>>>>>>>> Are you sure you tested this?
>>>>>>>>>>> I apologize for not enabling -Werror, which resulted in 
>>>>>>>>>>> missing this error
>>>>>>>>>>> warning.
>>>>>>>>>>> I have tested usbip feature use the new patch,but not test 
>>>>>>>>>>> system
>>>>>>>>>>> suspend/resume.
>>>>>>>>>>> The faux bus type don't add pm function,and vhci-hcd driver 
>>>>>>>>>>> can't register
>>>>>>>>>>> it.
>>>>>>>>>>> Maybe have to add suspend/resume for it.like below:
>>>>>>>>>>> static const struct bus_type faux_bus_type = {
>>>>>>>>>>>       .name        = "faux",
>>>>>>>>>>>       .match        = faux_match,
>>>>>>>>>>>       .probe        = faux_probe,
>>>>>>>>>>>       .remove        = faux_remove,
>>>>>>>>>>>       .resume     = faux_resume,
>>>>>>>>>>>       .suspend    = faux_suspend,
>>>>>>>>>>> };
>>>>>>>>>>>
>>>>>>>>>>> Is that right?
>>>>>>>>>>> Your expertise would be greatly valued.
>>>>>>>>>> As this is not real hardware, why do you need the suspend/resume
>>>>>>>>>> callbacks at all?  What is happening here that requires them?
>>>>>>>>> @greg,
>>>>>>>>> The vhci_hcd_suspend/vhci_hcd_resume interfaces are not 
>>>>>>>>> designed for this
>>>>>>>>> faux device, but rather to
>>>>>>>>> manipulate the HCD_FLAG_HW_ACCESSIBLE bit in the hcd flags 
>>>>>>>>> associated with
>>>>>>>>> the faux device.
>>>>>>>>> For example:
>>>>>>>>> During system standby: clear_bit(HCD_FLAG_HW_ACCESSIBLE, 
>>>>>>>>> &hcd->flags)
>>>>>>>>> During system wakeup: set_bit(HCD_FLAG_HW_ACCESSIBLE, 
>>>>>>>>> &hcd->flags)
>>>>>>>>>
>>>>>>>>> Previously, these two functions were registered through 
>>>>>>>>> platform_driver,
>>>>>>>>> but faux bus does not have the relevant interface, so they 
>>>>>>>>> were not called,
>>>>>>>>> resulting in this compilation warning error.
>>>>>>>>>
>>>>>>>>> This raises the question: Should the faux bus implement 
>>>>>>>>> PM-related
>>>>>>>>> interface?
>>>>>>>>> I'm uncertain whether these functions are essential for the 
>>>>>>>>> vhci-hcd driver
>>>>>>>>> or if they can be safely removed.
>>>>>>>>>
>>>>>>>>> However, during system standby/wakeup tests with remote USB 
>>>>>>>>> devices bound to
>>>>>>>>> the vhci-hcd driver,
>>>>>>>>> I observed consistent failure scenarios across both the 
>>>>>>>>> original platform
>>>>>>>>> bus and faux bus patch implementations.
>>>>>>>
>>>>>>> suspend and resume hooks have been in the code from beginning
>>>>>>> in the CONFIG_PM path. The original authors are skeptical about
>>>>>>> what should happen during suspend"
>>>>>>>
>>>>>>> /* what should happen for USB/IP under suspend/resume? */
>>>>>>> suspend hook checks for active connections and sends EBBUSY
>>>>>>> back to pm core.
>>>>>>>
>>>>>>> Active connection means any of the ports are in 
>>>>>>> USB_PORT_STAT_CONNECTION
>>>>>>> state. So as long as there are active connections between vhci 
>>>>>>> client
>>>>>>> and the host, suspend won't work. So we really don't know what 
>>>>>>> happens
>>>>>>> to the active connections if there are no suspend/resume hooks.
>>>>>>>
>>>>>>> If there are no active connections, then it will clear the 
>>>>>>> HCD_FLAG_HW_ACCESSIBLE
>>>>>>> bit and returns to pm core to continue with suspend.
>>>>>>>
>>>>>>> resume sets the HCD_FLAG_HW_ACCESSIBLE flag to indicate hardware 
>>>>>>> is accessible
>>>>>>> and initiates port status poll.
>>>>>>>
>>>>>>> - suspend hook prevents suspend
>>>>>>>
>>>>>>> With faux device since there is no suspend and resume hook, I 
>>>>>>> would expect
>>>>>>> these hooks are not a factor in suspend and resume.
>>>>>>>
>>>>>>> vhci_hcd is a special case virtual driver as it is a proxy for 
>>>>>>> controlling
>>>>>>> hardware on the host.
>>>>>>>
>>>>>>> Zongmin,
>>>>>>>
>>>>>>> Do suspend/resume work when vhci_hcd is not loaded?
>>>>>>> What happens when when system suspends and resumes with faux 
>>>>>>> device?
>>>>>>> Can you send me dmesg logs and pm logs?
>>>>>>>
>>>>>> Hi Greg,shuah
>>>>>>
>>>>>> Yes, system with vhci_hcd unload or just load vhci_hcd driver
>>>>>> without usbip devices bound to vhci_hcd,system suspend/resume 
>>>>>> worked well.
>>>>>> Some logs for you.
>>>>>
>>>>> Sorry for the delay. I was at a conference last week.
>>>>> Thank you for sending these logs.
>>>>>
>>>>>> 1.system with vhci_hcd driver load,but don't bound any usbip 
>>>>>> devices to vhci_hcd,suspend/resume worked well.
>>>>>> see dmesg-faux bus-load.log
>>>>>
>>>>>
>>>>>>
>>>>>> 2.usbip device bound to vhci_hcd,and do system suspend 
>>>>>> action,suspend/resume worked failed.
>>>>>> I observed two distinct failure scenario:
>>>>>> Scenario 1: System failed to enter suspend state,and will auto 
>>>>>> resume;
>>>>>
>>>>>
>>>>>> the log for use platform bus:
>>>>>> dmesg-platform bus-device bound-auto resume.log
>>>>>
>>>>> This is clear from the suspend hook in the vhci_hcd.
>>>>> When it returns EBUSY, suspend will fail and move to
>>>>> auto resume.
>>>>>
>>>>>> the log for use faux bus:
>>>>>> dmesg-faux bus-device bound-auto resume.log
>>>>>
>>>>> It is good that the behavior is same with faux bus even though
>>>>> suspend hook isn't called. I will take a look at the log.
>>>>>
>>>>>>
>>>>>> Scenario 2: System resume failed with black screen freeze,a 
>>>>>> forced restart of the machine is require.
>>>>>> the log for use platform bus:
>>>>>> dmesg-platform bus-device bound-black screen.log
>>>>>> the log for use faux bus:
>>>>>> dmesg-faux bus-device bound-black screen.log
>>>>>
>>>>> That is bad. When does this happen? Is there a difference in
>>>>> configuration?
>>>>>
>>>> No, there's no difference. The same code is used for two different 
>>>> failure scenarios.
>>>> I just tested many times. These two different situations occur 
>>>> probabilistically.
>>>> But they both happened only when the USBIP device is bound to the 
>>>> vhci_hcd driver.
>>>>> The behavior same for platform bus and faux bus. Sounds like
>>>>> an existing problem that needs to be debugged separately.
>>>>>
>>>>> I will take a look at all these logs and get back to you in
>>>>> a day or two.
>>>>>
>>>
>>> I looked at the logs and here is what I found:
>>>
>>> Scenario 1:
>>>   dmesg-faux bus-device bound-auto resume.log
>>>   dmesg-platform bus-device bound-auto resume.log
>>>
>>> In this case suspend bailed out way before driver suspend
>>> when vhci_hcd is using platform and faux bus.
>>>
>>> Freezing remaining freezable tasks failed after 20.006 seconds (0 
>>> tasks refusing to freeze, wq_busy=1)
>>> Restarting kernel threads ... done
>>> OOM killer enabled.
>>> Restarting tasks ... done.
>>> random: crng reseeded on system resumption
>>> PM: suspend exit
>>>
>>> Auto-resume of the user-space worked. Scenario 1 isn't really
>>> interesting.
>>>
>>> Scenario 2:
>>>   dmesg-faux bus-device bound-black screen.log
>>>   dmesg-platform bus-device bound-black screen.log
>>>
>>> Even though the result is the same in seeing blank screen, how
>>> we get there is different.
>>>
>>> =================
>>> faux-bus device:
>>> =================
>>> - suspend worked - looks like
>>>   usb 4-1: PM: calling usb_dev_suspend @ 6054, parent: usb4
>>>   usb 4-1: PM: usb_dev_suspend returned 0 after 13675 usecs
>>>   usb usb4: PM: calling usb_dev_suspend @ 6055, parent: vhci_hcd.0
>>>   usb usb4: PM: usb_dev_suspend returned 0 after 9 usecs
>>>
>>> vhci_hcd suspend isn't in play here. usb_dev_suspend() returns.
>>> See below
>>>
>>> usb 4-1: PM: usb_dev_suspend returned message.
>>>
>>> -------------------------------------------------------------
>>>
>>> - resume started (assuming it has been initiated by user)
>>>
>>> [  650.027491][ T6056] pci 0000:00:01.0: PM: pci_pm_suspend_noirq 
>>> returned 0 after 304 usecs
>>>
>>> See see timestamp difference between the last suspend message and the
>>> first resume message.
>>> [  674.000257][   T39] pci 0000:00:00.0: PM: calling 
>>> pci_pm_resume_noirq @ 39, parent: pci0000:00
>>>
>>> usb 4-1 usb_dev_resume never returns.
>>>
>>> [  674.071125][ T6117] usb usb4: PM: usb_dev_resume returned 0 after 
>>> 21110 usecs
>>> [  674.113991][ T6126] usb 4-1: PM: calling usb_dev_resume @ 6126, 
>>> parent: usb4
>>>
>>> -------------------------------------------------------------
>>>
>>> =====================
>>> platform bus device
>>> =====================
>>>
>>> - suspend was aborted because vhci_hcd suspend routine returned error
>>>
>>> [  297.854621][ T9402] usb 4-1: PM: calling usb_dev_suspend @ 9402, 
>>> parent: usb4
>>> [  297.868524][ T9402] usb 4-1: PM: usb_dev_suspend returned 0 after 
>>> 13214 usecs
>>> [  297.869994][ T9403] usb usb4: PM: calling usb_dev_suspend @ 9403, 
>>> parent: vhci_hcd.0
>>> [  297.871959][ T9403] usb usb4: PM: usb_dev_suspend returned 0 
>>> after 30 usecs
>>> [  297.873644][ T9394] vhci_hcd vhci_hcd.0: PM: calling 
>>> platform_pm_suspend @ 9394, parent: platform
>>> [  297.874738][ T9394] vhci_hcd vhci_hcd.0: We have 1 active 
>>> connection. Do not suspend.
>>> [  297.875369][ T9394] vhci_hcd vhci_hcd.0: PM: dpm_run_callback(): 
>>> platform_pm_suspend returns -16
>>> [  297.876078][ T9394] vhci_hcd vhci_hcd.0: PM: platform_pm_suspend 
>>> returned -16 after 1341 usecs
>>> [  297.876774][ T9394] vhci_hcd vhci_hcd.0: PM: failed to suspend: 
>>> error -16
>>>
>>> - the following triggers resume
>>> [  297.877321][ T9394] PM: Some devices failed to suspend, or early 
>>> wake event detected
>>>
>>> [  297.881065][ T9403] usb usb3: PM: usb_dev_resume returned 0 after 
>>> 19 usecs
>>> [  297.904551][ T9408] usb usb4: PM: usb_dev_resume returned 0 after 
>>> 22911 usecs
>>> [  297.905148][ T9418] usb 4-1: PM: calling usb_dev_resume @ 9418, 
>>> parent: usb4
>>>
>>> usb 4-1 usb_dev_resume never returns.
>>>
>>> Note - In both cases, usb_dev_resume doesn't return. When it is 
>>> called is the
>>> difference.
>>>
>>> I don't think suspend/resume works when devices are bound. Suspend 
>>> exits and
>>> starts resume which seems to fail because it doesn't handle the 
>>> virtual usb
>>> device resume. There is a missing piece here.
>>>
>>> When vhci_hcd imports a device and acts as a proxy between the 
>>> virtual mass
>>> storage device (e.g in this case) - it appears suspend and resume are
>>> handled as if it is a usb device. Maybe this is incorrect?
>>>
>>> usb_dev_suspend() works and usb_dev_resume() on these virtual usb 
>>> devices?
>>> Do we need to handle this in usb_dev_resume()?
>>>
>>> Talking out loud - I have to do some looking into.
>>>
>> Re:
>> Yes, your analysis is completely correct.
>>
>> In fact, I've experimented with adding PM hooks to the faux bus,
>> and found that faux bus devices then behave identically to platform 
>> bus devices during suspend/resume.
>> See the attachment.
>>
>
> Thanks for checking this scenario. No surprises here.
Another part of my purpose in doing this is that the vhci-hcd driver seems
should still retain suspend/resume hooks. Therefore, the faux bus should
add corresponding hooks to allow the driver to call its own pm functions.
Though currently don't know how to fix this problem yet.
>
>> This is likely a historical legacy issue.
>
> It is an existing problem in the way vhci_hcd and the bound devices
> handle suspend/resume. vhci_hcd suspend assumes once it returns
> "don't suspend" the rest works. However suspend for the bound device
> runs first and a subsequent resume on it fails.
>
> This problem needs fixing - I don't know yet how to.
>
>> Regarding this matter, is there anything else you'd like me to assist 
>> with?
>>
>
> One thing I am curious about is the status of the bound devices after
> "forced restart of the machine" when you see blank screen or hang?
That's an excellent question.Another persistent problem has surfaced 
during troubleshooting：
After a USB/IP device is bound to the vhci-hcd driver, when the machine
reboots or performs a forced restart(include resume fail,forced restart),
attempting to re-bind the device to the vhci-hcd driver will generate 
the error message
"usbip: error: Attach Request for 4-2 failed - Device busy (exported)".
At this point, the device must first be explicitly detached
from the usbip-host driver before it can be bound again.

I implemented a shutdown hook (can refer to the attached file) in the 
vhci-hcd driver
to perform vhci_hcd remove before system shutdown.
This resolves failures where devices cannot rebind to
the vhci-hcd driver after normal reboots. However,
it remains ineffective for forced shutdown/reboot scenarios
since no shutdown functions are executed in such cases.

That's all details I've gathered yet.
>
> thanks,
> -- Shuah
--------------jn3AIRR01B8SkEpGew43qimZ
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-driver-core-add-shutdown-hook-on-faux-bus.patch"
Content-Disposition: attachment;
 filename="0001-driver-core-add-shutdown-hook-on-faux-bus.patch"
Content-Transfer-Encoding: base64

RnJvbSBmZmQ4NjNhMmRiZWJiYWIwNjU2NTNlYjJjMzUxYWY2MTg3MWQ1YzkzIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBab25nbWluIFpob3UgPHpob3V6b25nbWluQGt5bGlu
b3MuY24+CkRhdGU6IFR1ZSwgOCBKdWwgMjAyNSAxMToxOTowNyArMDgwMApTdWJqZWN0OiBb
UEFUQ0hdIGRyaXZlciBjb3JlOiBhZGQgc2h1dGRvd24gaG9vayBvbiBmYXV4IGJ1cwoKU29t
ZSBkZXZpY2VzIGJhc2VkIG9uIGZhdXggYnVzIG1heQpoYXZlIHRvIGRvIHNvbWV0aGluZyBk
dXJpbmcgc3lzdGVtIHNodXRkb3duLgpTbyBhZGQgc2h1dGRvd24gaG9vayB0byBsZXQgaXQg
dXNlIGl0cyBvd24gc2h1dGRvd24gaG9va3MgaWYgaGFkLgoKU2lnbmVkLW9mZi1ieTogWm9u
Z21pbiBaaG91IDx6aG91em9uZ21pbkBreWxpbm9zLmNuPgotLS0KIGRyaXZlcnMvYmFzZS9m
YXV4LmMgICAgICAgICAgfCAxMSArKysrKysrKysrKwogZHJpdmVycy91c2IvdXNiaXAvdmhj
aV9oY2QuYyB8IDEyICsrKysrKysrKysrKwogaW5jbHVkZS9saW51eC9kZXZpY2UvZmF1eC5o
ICB8ICAxICsKIDMgZmlsZXMgY2hhbmdlZCwgMjQgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdp
dCBhL2RyaXZlcnMvYmFzZS9mYXV4LmMgYi9kcml2ZXJzL2Jhc2UvZmF1eC5jCmluZGV4IGNi
YWYyNjVlOWI2Yy4uNjFjYzBhMjVkMmM3IDEwMDY0NAotLS0gYS9kcml2ZXJzL2Jhc2UvZmF1
eC5jCisrKyBiL2RyaXZlcnMvYmFzZS9mYXV4LmMKQEAgLTkyLDYgKzkyLDE2IEBAIHN0YXRp
YyBpbnQgZmF1eF9wbV9yZXN1bWUoc3RydWN0IGRldmljZSAqZGV2KQogI2RlZmluZSBmYXV4
X3BtX3Jlc3VtZQlOVUxMCiAjZW5kaWYKIAorc3RhdGljIHZvaWQgZmF1eF9zaHV0ZG93bihz
dHJ1Y3QgZGV2aWNlICpkZXYpCit7CisJc3RydWN0IGZhdXhfb2JqZWN0ICpmYXV4X29iaiA9
IHRvX2ZhdXhfb2JqZWN0KGRldik7CisJc3RydWN0IGZhdXhfZGV2aWNlICpmYXV4X2RldiA9
ICZmYXV4X29iai0+ZmF1eF9kZXY7CisJY29uc3Qgc3RydWN0IGZhdXhfZGV2aWNlX29wcyAq
ZmF1eF9vcHMgPSBmYXV4X29iai0+ZmF1eF9vcHM7CisKKwlpZiAoZmF1eF9vcHMgJiYgZmF1
eF9vcHMtPnNodXRkb3duKQorCQlmYXV4X29wcy0+c2h1dGRvd24oZmF1eF9kZXYpOworfQor
CiBzdGF0aWMgY29uc3Qgc3RydWN0IGJ1c190eXBlIGZhdXhfYnVzX3R5cGUgPSB7CiAJLm5h
bWUJCT0gImZhdXgiLAogCS5tYXRjaAkJPSBmYXV4X21hdGNoLApAQCAtOTksNiArMTA5LDcg
QEAgc3RhdGljIGNvbnN0IHN0cnVjdCBidXNfdHlwZSBmYXV4X2J1c190eXBlID0gewogCS5y
ZW1vdmUJCT0gZmF1eF9yZW1vdmUsCiAJLnN1c3BlbmQJPSBmYXV4X3BtX3N1c3BlbmQsCiAJ
LnJlc3VtZQkJPSBmYXV4X3BtX3Jlc3VtZSwKKwkuc2h1dGRvd24JPSBmYXV4X3NodXRkb3du
LAogfTsKIAogc3RhdGljIHN0cnVjdCBkZXZpY2VfZHJpdmVyIGZhdXhfZHJpdmVyID0gewpk
aWZmIC0tZ2l0IGEvZHJpdmVycy91c2IvdXNiaXAvdmhjaV9oY2QuYyBiL2RyaXZlcnMvdXNi
L3VzYmlwL3ZoY2lfaGNkLmMKaW5kZXggNzljMDI2MTA4ZDdiLi4wMWNlNTBiNmFiZDUgMTAw
NjQ0Ci0tLSBhL2RyaXZlcnMvdXNiL3VzYmlwL3ZoY2lfaGNkLmMKKysrIGIvZHJpdmVycy91
c2IvdXNiaXAvdmhjaV9oY2QuYwpAQCAtMTQ4MSwxMCArMTQ4MSwyMiBAQCBzdGF0aWMgaW50
IHZoY2lfaGNkX3Jlc3VtZShzdHJ1Y3QgZmF1eF9kZXZpY2UgKmZkZXYpCiAKICNlbmRpZgog
CitzdGF0aWMgdm9pZCB2aGNpX2hjZF9zaHV0ZG93bihzdHJ1Y3QgZmF1eF9kZXZpY2UgKmZk
ZXYpCit7CisJLyoKKwkgKiBNdXN0IHRvIGRvIHNvbWV0aGluZyBiZWZvcmUgc3lzdGVtIHNo
dXRkb3duLgorCSAqIHVzYmlwIGRldmljZXMgYXR0YWNoZWQgdG8gdmhjaS1oY2Qsc2hvdWxk
IGJlIGRldGFjaGVkIGJlZm9yZSBzeXN0ZW0gc2h1dGRvd24uCisJICogT3RoZXJ3aXNlLHRo
aXMgZGV2aWNlJ3Mgc3RhdHVzIG9uIHN0dWIKKwkgKiB3aWxsIGFsd2F5cyBiZSBTREVWX1NU
X1VTRUQsYW5kIGNhbid0IGJlIGF0dGFjaGVkIGFueW1vcmUuCisJICovCisJdmhjaV9oY2Rf
cmVtb3ZlKGZkZXYpOworfQorCiBzdGF0aWMgc3RydWN0IGZhdXhfZGV2aWNlX29wcyB2aGNp
X2RyaXZlciA9IHsKIAkucmVtb3ZlID0gdmhjaV9oY2RfcmVtb3ZlLAogCS5zdXNwZW5kID0g
dmhjaV9oY2Rfc3VzcGVuZCwKIAkucmVzdW1lCT0gdmhjaV9oY2RfcmVzdW1lLAorCS5zaHV0
ZG93biA9IHZoY2lfaGNkX3NodXRkb3duLAogfTsKIAogc3RhdGljIHZvaWQgZGVsX2ZhdXhf
ZGV2aWNlcyh2b2lkKQpkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9kZXZpY2UvZmF1eC5o
IGIvaW5jbHVkZS9saW51eC9kZXZpY2UvZmF1eC5oCmluZGV4IDlkYzRiODFjNjcyYy4uYjNi
NjZhYjVkZTI4IDEwMDY0NAotLS0gYS9pbmNsdWRlL2xpbnV4L2RldmljZS9mYXV4LmgKKysr
IGIvaW5jbHVkZS9saW51eC9kZXZpY2UvZmF1eC5oCkBAIC00Nyw2ICs0Nyw3IEBAIHN0cnVj
dCBmYXV4X2RldmljZV9vcHMgewogCXZvaWQgKCpyZW1vdmUpKHN0cnVjdCBmYXV4X2Rldmlj
ZSAqZmF1eF9kZXYpOwogCWludCAoKnN1c3BlbmQpKHN0cnVjdCBmYXV4X2RldmljZSAqZmF1
eF9kZXYsIHBtX21lc3NhZ2VfdCBzdGF0ZSk7CiAJaW50ICgqcmVzdW1lKShzdHJ1Y3QgZmF1
eF9kZXZpY2UgKmZhdXhfZGV2KTsKKwl2b2lkICgqc2h1dGRvd24pKHN0cnVjdCBmYXV4X2Rl
dmljZSAqZmF1eF9kZXYpOwogfTsKIAogc3RydWN0IGZhdXhfZGV2aWNlICpmYXV4X2Rldmlj
ZV9jcmVhdGUoY29uc3QgY2hhciAqbmFtZSwKLS0gCjIuMjUuMQoK

--------------jn3AIRR01B8SkEpGew43qimZ--


