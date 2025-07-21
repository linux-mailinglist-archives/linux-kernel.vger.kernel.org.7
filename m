Return-Path: <linux-kernel+bounces-738906-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B5A5B0BED6
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 10:27:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 06286189D0B0
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 08:28:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86B0228983B;
	Mon, 21 Jul 2025 08:25:53 +0000 (UTC)
Received: from plesk.hostmyservers.fr (plesk.hostmyservers.fr [45.145.164.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D0501DEFDB;
	Mon, 21 Jul 2025 08:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.145.164.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753086353; cv=none; b=FL1xMAqE0yemZhydUMYstqeU85DCvZKkohB39Yh5Gw+WZI+Dq314WVpNG8DoehgEORi6OgKYVS+S8E2z/7AgEm9ZnID5S2OvxuVTeBFi4vZECSL2qC2mXjB80DXSifANJ7C7gAAa80OAfhaqEpzUM/AYZVWI2OsIAfknhyhyClM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753086353; c=relaxed/simple;
	bh=GKnYUcABafVSlPIjZjOOP0oBm2DtJK6Mf/yfl5Xu6qU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nKPc9x/IAt2uoIpfuuOHueyUc297y6bMmFMxaPGYeEOjFaMrYqdjsHbx2QIIhYNGoIRJUJ/BAzPWGpLobbUZS9rM7y/etZ5KB/HzMoFNZgJfaCOKWvPKPzaefn+nOukrkc/bUo3q4GQYrbv1/o+60eTUtQbYMvMhEcnDFulWL+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=arnaud-lcm.com; spf=pass smtp.mailfrom=arnaud-lcm.com; arc=none smtp.client-ip=45.145.164.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=arnaud-lcm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arnaud-lcm.com
Received: from [10.48.132.14] (unknown [15.248.2.230])
	by plesk.hostmyservers.fr (Postfix) with ESMTPSA id 35F9040A1F;
	Mon, 21 Jul 2025 08:25:48 +0000 (UTC)
Authentication-Results: Plesk;
        spf=pass (sender IP is 15.248.2.230) smtp.mailfrom=contact@arnaud-lcm.com smtp.helo=[10.48.132.14]
Received-SPF: pass (Plesk: connection is authenticated)
Message-ID: <e0f3b6da-eb4b-4270-9f20-f93b892a3a5c@arnaud-lcm.com>
Date: Mon, 21 Jul 2025 09:25:47 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] usb: mon: Fix slab-out-of-bounds in mon_bin_event due to
 unsafe URB transfer_buffer access
To: Alan Stern <stern@rowland.harvard.edu>
Cc: gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk, snovitoll@gmail.com,
 syzbot+86b6d7c8bcc66747c505@syzkaller.appspotmail.com,
 syzkaller-bugs@googlegroups.com
References: <20250720200057.19720-1-contact@arnaud-lcm.com>
 <8bbc84ee-44c9-4a85-b5bf-3980b3c81e5c@rowland.harvard.edu>
Content-Language: en-US
From: "Lecomte, Arnaud" <contact@arnaud-lcm.com>
In-Reply-To: <8bbc84ee-44c9-4a85-b5bf-3980b3c81e5c@rowland.harvard.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-PPP-Message-ID: <175308634876.8747.6921415578368422269@Plesk>
X-PPP-Vhost: arnaud-lcm.com

Hi Alan, thanks for your reply.

Your point raises an important question for me: Is there a specific 
reason why we don’t have
  a synchronization mechanism in place to protect the URB's transfer 
buffer ?


Arnaud


On 21/07/2025 02:29, Alan Stern wrote:
> On Sun, Jul 20, 2025 at 09:00:57PM +0100, Arnaud Lecomte wrote:
>> The syzkaller fuzzer uncovered a kernel slab-out-of-bounds
>>   write in the USB monitoring subsystem (mon_bin) when handling
>>   a malformed URB (USB Request Block) with the following properties:
>>   - transfer_buffer_length = 0xffff
>>   - actual_length = 0x0 (no data transferred)
>>   - number_of_packets = 0x0 (non-isochronous transfer)
> This kind of problem is fixed not by changing the way mon_bin reacts to
> malformed URBs, but rather by correcting the code that creates the URBs
> in the first place so that they won't be malformed.
>
>> When reaching the mon_copy_to_buff function,
>>   we will try to copy into the mon rp bin with the following parameters:
>> off=0xcc0, from=0xffff8880246df5e1 "", length=0xf000
>>
>> At the first iteration, the step_len is 0x340 and it is during the mem_cpy
>> that the slab-out-of-bounds happens.
>> As step_len < transfer_buffer_length, we can deduce that it is related
>>   to an issue with the transfer_buffer being invalid.
>> The patch proposes a safe access to the kernel
>>   kernel buffer urb->transfer_buffer with `copy_from_kernel_nofault`.
>>
>> Reported-by: syzbot+86b6d7c8bcc66747c505@syzkaller.appspotmail.com
>> Fixes: 6f23ee1fefdc1 ("USB: add binary API to usbmon")
>> Closes: https://syzkaller.appspot.com/bug?extid=86b6d7c8bcc66747c505
>> Tested-by: syzbot+86b6d7c8bcc66747c505@syzkaller.appspotmail.com
>> Signed-off-by: Arnaud Lecomte <contact@arnaud-lcm.com>
>> ---
> This is unnecessary.  The underlying cause of the problem was fixed by
> commit 0d0777ccaa2d ("HID: core: ensure __hid_request reserves the
> report ID as the first byte") in the HID tree.
>
> Alan Stern

