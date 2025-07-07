Return-Path: <linux-kernel+bounces-720524-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E05AAAFBCD0
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 22:50:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FD131AA7A0B
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 20:50:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEBF121FF53;
	Mon,  7 Jul 2025 20:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fO4ttkuz"
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A3DF1F4CB2
	for <linux-kernel@vger.kernel.org>; Mon,  7 Jul 2025 20:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751921389; cv=none; b=XhY+WSR4u9fWtBworc/faJI5+RwF7Io+kEwF017O5sGTsQkyTnbWklqGmSirFwMDBLTe5dzU5rIDXfpcR3wue4GyTqn8AEVKhEhgoypNxjGn6U7Qv2hXJqAeAUteoDcl7Ophfy9vPqi0Yz0H0fHhxH/zmJ3XZaBuZLB+KMTv9FY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751921389; c=relaxed/simple;
	bh=IspjqW9AJxL94QHeCDqVcm0GgMOpDvrXqiCbdiYaCPk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Amwk1WAqQD+3yX5Ku+6VpNHomWfiCkHnVgPcOgDdvLPr+3fKAkyq1BoBfRKMLEMlJtYDldmHiUC243e4io8Oi0+Rjtn5qkSVicrIc+WigpXd8qA/4Kv6CvwS+5ki1p9qf5fydVDxr6wCtSHwNUSkqx+YGJa05GbPJxJuP39Z3X8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fO4ttkuz; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-73b5350980cso2631611a34.1
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jul 2025 13:49:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751921386; x=1752526186; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AhuS84hSOQt0uRcZgKJ1vRg95j8tQVHeFUW1xUTAPH8=;
        b=fO4ttkuz5yosi4OUMNQQSqO3TTeVdOzQUcgJIYFkjF6OjOgZLKegSA/JjMzXjt70pf
         4MwHot0AIaoLsnCAvw8A+LOTFz9PVIAqcnAcwtpjvENLWzljzPtfiZf51EZKU9qjssqZ
         9qMosUPgoHl1cwbfGWFEL2F6+ebK9oGOMXZ28Y02H26AA6E6vQ0cR7MxZ20HnqAOeHIU
         lKwInEJH1MAB7zg/OA76kKQW1SfmPhENxtU8YSP3OtSlw1cGmldv2901UJSCMI18Ayc1
         GQMEo8DIJTFFvVo3U7Nw4wSzHPwJtyxFKw/AcC4Y9gPrfvUA6Zr5NkpnXR0lqUYGqbEE
         VajA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751921386; x=1752526186;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AhuS84hSOQt0uRcZgKJ1vRg95j8tQVHeFUW1xUTAPH8=;
        b=jSWS5h5vIUejP36lorHeZM0WaRPIatYdoynE/qKO5YvXAIPGJ9FUuQ59dQKASTZvNA
         qFBWS/PjAfbD9VgbIO7QrlHferqKCmIfR9V+Jmn33upnZmRzXQClClCW/8r95Z4VxMiL
         LjC5hX6WEeH4Vena1PwgVoWSBd161V7kJko/qEjnCHxk6wtKGI2NhS9C8qo+OZu9CbP8
         fAfd65cpju6rtuREHucgiymc/slwuXl9nQQQecYvYmMFFWF7Tjq+JKvEk8IrIUp+ylzQ
         mF9MWXb4mw55WtWpVXIDIp7xC5YjQjgIYAI2TcgPdevUpNXkDthQM7CqWpuUOUzhuRjP
         1jJA==
X-Forwarded-Encrypted: i=1; AJvYcCWWKipiN04V5RJU9WLizjjaTQoaySeVfBYmXAvgX00roU8cK8ReQ2INXGNJA18zn/g5i1iKP78uOsLh0wQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywe7Rg/frleoesdWiLjQ6S6FGeO555rzI+HBshLdXxaOBrylYzm
	s7Q6PAA4mB49eer4A0y76NlfXsvZhP2xf3rrtJK0RMVbsxriGEiBCfbxxZ/I7y1G
X-Gm-Gg: ASbGncvVLk/EVq21QYu6UHuTfhB3CCmrEjlWW2hSSPuoXTbySPi8D+i0javxhKkgYM9
	LttxtJVghbilHZY712VMGdvFYXspkenM7flv0kbjJ9lTihTO2gu7K9wNmdJZ07dQ/kdUpi3azpM
	g9tmS6pEFNJgjLsYoejI4Mf9zVF7b60mjB/MsPHU9o3gjWuJI1JjfqulPCAf/7vpUSw5PjonQjO
	IXq9C78Pkqh66wB2XX/gs81fDJETZn47dFHaSop56KiSpHguPy/K6+vIbArf4k+tNWjyP4MbC4V
	QnZT+T2CrSNHdDj5e/w7PHv02zLx1InyCtkABE1YYxSSBYRBSc/L2aRwXcNz3d+6lfCXUYWvatd
	ZZcFXt1B0PSZ0PFDk31A6CFdWUkx6gAN98ub2qaidhzkBu3A=
X-Google-Smtp-Source: AGHT+IE0m3KiMcrUCPn36GAt4PUQHG1cRife0ZxrezKMpHjq87MM6KoumROGi7AszjAdUQlehbGN4w==
X-Received: by 2002:a05:6830:3688:b0:73a:8a05:cd3d with SMTP id 46e09a7af769-73cd7774ca3mr176859a34.0.1751921386367;
        Mon, 07 Jul 2025 13:49:46 -0700 (PDT)
Received: from [192.168.1.7] (syn-067-048-091-116.res.spectrum.com. [67.48.91.116])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-73c9f90d1ccsm1701930a34.44.2025.07.07.13.49.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Jul 2025 13:49:45 -0700 (PDT)
Message-ID: <fd941519-6f71-4286-9517-2dc861ee99a5@gmail.com>
Date: Mon, 7 Jul 2025 15:49:44 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 0/5] shut down devices asynchronously
To: David Jeffery <djeffery@redhat.com>,
 Sultan Alsawaf <sultan@kerneltoast.com>
Cc: Jeremy Allison <jra@samba.org>, Christoph Hellwig <hch@lst.de>,
 linux-kernel@vger.kernel.org, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, "Rafael J . Wysocki" <rafael@kernel.org>,
 Martin Belanger <Martin.Belanger@dell.com>,
 Oliver O'Halloran <oohall@gmail.com>, Daniel Wagner <dwagner@suse.de>,
 Keith Busch <kbusch@kernel.org>, Lukas Wunner <lukas@wunner.de>,
 Jeremy Allison <jallison@ciq.com>, Jens Axboe <axboe@fb.com>,
 Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
 Nathan Chancellor <nathan@kernel.org>, Jan Kiszka <jan.kiszka@seimens.com>,
 Bert Karwatzki <spasswolf@web.de>
References: <20250625201853.84062-1-stuart.w.hayes@gmail.com>
 <20250703114656.GE17686@lst.de> <aGaklKejxefXTQB4@jeremy-HP-Z840-Workstation>
 <CA+-xHTFC6KTs6D8EdvmVe=buqw9oN5P7GJ-WWvam6M3SzeZF4g@mail.gmail.com>
 <aGgAuje4tpIOveFc@sultan-box>
 <CA+-xHTFNRwbxH=zNMM4kasB=kUAne0b6cxPM+sq5FyM32k8peg@mail.gmail.com>
Content-Language: en-US
From: stuart hayes <stuart.w.hayes@gmail.com>
In-Reply-To: <CA+-xHTFNRwbxH=zNMM4kasB=kUAne0b6cxPM+sq5FyM32k8peg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 7/7/2025 10:34 AM, David Jeffery wrote:
> On Fri, Jul 4, 2025 at 12:26 PM Sultan Alsawaf <sultan@kerneltoast.com> wrote:
>>
>> On Fri, Jul 04, 2025 at 09:45:44AM -0400, David Jeffery wrote:
>>> On Thu, Jul 3, 2025 at 12:13 PM Jeremy Allison <jra@samba.org> wrote:
>>>>
>>>> On Thu, Jul 03, 2025 at 01:46:56PM +0200, Christoph Hellwig wrote:
>>>>> On Wed, Jun 25, 2025 at 03:18:48PM -0500, Stuart Hayes wrote:
>>>>>> Address resource and timing issues when spawning a unique async thread
>>>>>> for every device during shutdown:
>>>>>>    * Make the asynchronous threads able to shut down multiple devices,
>>>>>>      instead of spawning a unique thread for every device.
>>>>>>    * Modify core kernel async code with a custom wake function so it
>>>>>>      doesn't wake up threads waiting to synchronize every time the cookie
>>>>>>      changes
>>>>>
>>>>> Given all these thread spawning issues, why can't we just go back
>>>>> to the approach that kicks off shutdown asynchronously and then waits
>>>>> for it without spawning all these threads?
>>>>
>>>> It isn't just an nvme issue. Red Hat found the same issue
>>>> with SCSI devices.
>>>>
>>>> My colleague Sultan Alsawaf posted a simpler fix for the
>>>> earlier patch here:
>>>>
>>>> https://lists.infradead.org/pipermail/linux-nvme/2025-January/053666.html
>>>>
>>>> Maybe this could be explored.
>>>>
>>>
>>> Unfortunately, this approach looks flawed. If I am reading it right,
>>> it assumes async shutdown devices do not have dependencies on sync
>>> shutdown devices.
>>
>> It does not make any such assumption. Dependency on a sync device is handled
>> through a combination of queue_device_async_shutdown() setting an async device's
>> shutdown_after and the synchronous shutdown loop dispatching an "async" shutdown
>> for a sync device when it encounters a sync device that has a downstream async
>> dependency.
>>
> 
> Yes, but not what I think fails. This handles a sync parent having an
> async child. It does not handle the reverse, a sync child having an
> async parent.
> 
> For example, take a system with 1 pci nvme device. The nvme device
> which is flagged for async shutdown can have sync shutdown children as
> well as a sync shutdown parent. The patch linked pulls the async
> device off the shutdown list into a separate async list, then starts
> this lone async device with queue_device_async_shutdown from being on
> the async list. The device then is passed to the async subsystem
> running shutdown_one_device_async where it will immediately do
> shutdown due to a zero value shutdown_after. The patch sets
> shutdown_after for its parent, but there is nothing connecting and
> ordering the async device to its sync children which will be shutdown
> later from the original device_shutdown task.
> 
>>> Maintaining all the dependencies is the core problem and source of the
>>> complexity of the async shutdown patches.
>>
>> I am acutely aware. Please take a closer look at my patch.
>>
> 
> I have, and it still looks incomplete to me.
> 
> David Jeffery
> 

Also, the way it is implemented, it could hang if there isn't enough 
memory to queue up all of the async device shutdowns before starting the 
synchronous shutdowns.

When you call async_schedule_domain() and there's not enough memory to 
allocate an async_entry, the async function will be run immediately. If 
that happens when queuing up the async shutdowns, it could easily hang 
if there if there are any dependencies requiring an async device 
shutdown to have to wait for a synchronous device to shutdown, since 
none of the synchronous shutdown devices have been scheduled yet.

Before your patch, all device shutdowns are scheduled in order such that 
if the call to async_schedule_domain() runs the function immediately, it 
will still be able to complete, it just won't get the benefit of 
multiple threads shutting down devices concurrently. The V10 patch 
maintains that--it just lets one thread shut down multiple synchronous 
devices instead of creating one thread for each synchronous device shutdown.

