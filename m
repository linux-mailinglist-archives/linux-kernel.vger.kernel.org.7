Return-Path: <linux-kernel+bounces-875086-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AEFEFC1832A
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 04:39:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E4F35502704
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 03:36:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 497D32D3EF5;
	Wed, 29 Oct 2025 03:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FpH1A/HY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7095E1D63F7;
	Wed, 29 Oct 2025 03:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761709002; cv=none; b=FVRq9U5tw1Ndpr8vYKGywZ7CsQz0LTwo0iMroOHpSaGeM2vioDT6FWbbJGPrkwQesTZHF6uVvVDirzE+evzFNBss8Zt+FKVW+QHnyaUgMU8a6gTOd3nQFBhQ+VOn2IhySraeMB96JgQFQGPkv4nrhh4AXOJn0olxjSlWgkYJ98A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761709002; c=relaxed/simple;
	bh=9qRhhGvfTLdwJr1iXuuFQyovRxzJtOp6LSdJdw5KdG0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bf+ZuwtJrnGsFZruTVHq+LUclh5JSltFLaXwFdz3d5lneCKD/SYU1/qHG0K2uPOqpMjBgUY2ds8NhAyIufw6JV7sNR5Rj2sm00Tezd6ZXF5PsMGYCW4AA93oJ88BCoX/jfAk6yWEeyfsqTcNHDR2AlsPB+6TNroJAa5NqUm/A5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FpH1A/HY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFE63C4CEFB;
	Wed, 29 Oct 2025 03:36:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761709001;
	bh=9qRhhGvfTLdwJr1iXuuFQyovRxzJtOp6LSdJdw5KdG0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=FpH1A/HYi7A29fNt3+fwne0WZzA4OmnRhuKHdbzj8q0cGh1l1OtfY4w4ehiNVzPpk
	 5MOJWGuwyyS3croOtob3R3CgH/TIxvnxQCEKR8pL6QPAREbv38KjK7IfbWx1gGmKKk
	 o8cjRy8t0OW3nz4PdYzjiJpjbx0Lzo+W9nSswK4DO7G+4yOsvOxAuDtAPWEicv32cO
	 2fyoOWiSeUrR6YSayAtVDdFu5TdNiGqJN8fUIeymNNfKtS4pYGREKKLphmm9/DPmmr
	 EqpFIm6nKOQWxrkT9HlrH5DjJLpbQvMPC6GxKG339XjPNdPW1MjG9KTDJE0LahVRGC
	 ohujoBaMYZriQ==
Message-ID: <b98a8486-e90a-4bd5-b3a7-3b2ba1b16398@kernel.org>
Date: Tue, 28 Oct 2025 22:36:39 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/6] platform/x86: ayaneo-ec: Add suspend hook
To: Antheas Kapenekakis <lkml@antheas.dev>
Cc: platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hwmon@vger.kernel.org, Hans de Goede <hansg@kernel.org>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Derek John Clark <derekjohn.clark@gmail.com>,
 =?UTF-8?Q?Joaqu=C3=ADn_Ignacio_Aramend=C3=ADa?= <samsagax@gmail.com>,
 Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>
References: <20251015084414.1391595-1-lkml@antheas.dev>
 <20251015084414.1391595-7-lkml@antheas.dev>
 <38a49942-58d3-49cf-90d7-1af570918ae5@kernel.org>
 <CAGwozwEmjms0H=GPbevuOjJfed6x69wmg8E9begBhUKbF8B2AQ@mail.gmail.com>
 <000cd38e-7052-4987-b5bc-b8de176363cf@kernel.org>
 <CAGwozwFDsn0xm_mG4ypEym=K8c81qqi=qtJL=06nP6SzdFaFoQ@mail.gmail.com>
Content-Language: en-US
From: "Mario Limonciello (AMD) (kernel.org)" <superm1@kernel.org>
In-Reply-To: <CAGwozwFDsn0xm_mG4ypEym=K8c81qqi=qtJL=06nP6SzdFaFoQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/28/2025 4:39 PM, Antheas Kapenekakis wrote:
> On Tue, 28 Oct 2025 at 22:21, Mario Limonciello <superm1@kernel.org> wrote:
>>
>> On 10/28/25 3:34 PM, Antheas Kapenekakis wrote:
>>>>> The fan speed is also lost during hibernation, but since hibernation
>>>>> failures are common with this class of devices
>> Why are hibernation failures more common in this class of device than
>> anything else?  The hibernation flow is nearly all done in Linux driver
>> code (with the exception of ACPI calls that move devices into D3 and out
>> of D0).
> 
> I should correct myself here and say hibernation in general in Linux
> leaves something to be desired.
> 
> Until secure boot supports hibernation, that will be the case because
> not enough people use it.

The upstream kernel has no tie between UEFI secure boot and hibernation. 
  I think you're talking about some distro kernels that tie UEFI secure 
boot to lockdown.  Lockdown does currently prohibit hibernation.

> 
> I have had it break for multiple reasons, not incl. the ones below and
> the ones we discussed last year where games are loaded.
> 
> For a few months I fixed some of the bugs but it is not sustainable.
> 
>> Perhaps you're seeing a manifestation of a general issue that we're
>> working on a solution for here:
>>
>> https://lore.kernel.org/linux-pm/20251025050812.421905-1-safinaskar@gmail.com/
>>
>> https://lore.kernel.org/linux-pm/20251026033115.436448-1-superm1@kernel.org/
>>
>> https://lore.kernel.org/linux-pm/5935682.DvuYhMxLoT@rafael.j.wysocki/T/#u
>>
>> Or if you're on an older kernel and using hybrid sleep we had a generic
>> issue there as well which was fixed in 6.18-rc1.
>>
>> Nonetheless; don't make policy decisions based upon kernel bugs.  Fix
>> the kernel bugs.
> 
> My problem is I cannot in good conscience restore a fan speed before
> the program responsible for it is guaranteed to thaw.
> 
> The best solution I can come up with would be in freeze save if manual
> control is enabled, disable it, and then on resume set a flag that
> makes the first write to fan speed also set pwm to manual.
> 
> This way suspend->hibernate flows, even if hibernation hangs when
> creating the image, at least have proper fan control because they are
> unattended, and resume hangs work similarly.
> 
> Antheas
> 

This sounds like a workable approach for what I understand to be your 
current design; but let me suggest some other ideas.

What happens if you're running something big and the OOM comes and 
whacks the process?  Now you don't have fan control running anymore.

So I see two options to improve things.

1) You can have userspace send a "heartbeat" to kernel space.  This can 
be as simple as a timestamp of reading a sysfs file.  If userspace 
doesn't read the file in X ms then you turn off manual control.

2) You move everything to a kthread.  Userspace can read some input 
options or maybe pick a few curve settings, but leave all the important 
logic in that kthread.



