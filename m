Return-Path: <linux-kernel+bounces-745518-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 42103B11B14
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 11:43:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 390167AE9C2
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 09:42:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 446F62D372F;
	Fri, 25 Jul 2025 09:43:27 +0000 (UTC)
Received: from plesk.hostmyservers.fr (plesk.hostmyservers.fr [45.145.164.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9189B291C0C
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 09:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.145.164.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753436606; cv=none; b=rAFKf/ndojPoQQjCQAXGf2bj7WVQuKxv+S9aIUDpwu3VDwF9tlgSfPEYmYoI5Vh767K/AWOEey2qvd8HamFOAJm+7L1dR32TiE6TYKD3ufunTMBYxfheONF4mmyqLvfoyGHnKJJnTV5fs8kUZvA2KuzrZUqdUqKW4MnQ9vghgHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753436606; c=relaxed/simple;
	bh=Fux21xSbuJ0ZFS/EA9jN72X8tgguqMOGBDqtx1Ps97Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HvTaL/b/Aav5L9EjVgLK6eTlBfA4bRIXUtsOtbDFZ2MKUJj3HJc3t0nAicqA5xhYPL/ddMxbghxh3WJe8QGEKzhs7QxpBvf55JT/3j+mGBLYt9D/a5FKbV5yGiF5FFD+tePB+RW2wAskpNQE1beBrqUlo7dd0Ys7ywO+lqIHudg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=arnaud-lcm.com; spf=pass smtp.mailfrom=arnaud-lcm.com; arc=none smtp.client-ip=45.145.164.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=arnaud-lcm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arnaud-lcm.com
Received: from [10.48.132.14] (unknown [15.248.2.230])
	by plesk.hostmyservers.fr (Postfix) with ESMTPSA id E311041D2D;
	Fri, 25 Jul 2025 09:43:20 +0000 (UTC)
Authentication-Results: Plesk;
        spf=pass (sender IP is 15.248.2.230) smtp.mailfrom=contact@arnaud-lcm.com smtp.helo=[10.48.132.14]
Received-SPF: pass (Plesk: connection is authenticated)
Message-ID: <89c2e255-fd5c-4533-8ec2-1864ddf5eaa3@arnaud-lcm.com>
Date: Fri, 25 Jul 2025 10:43:20 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] comedi: zero-init data in do_insn_ioctl
To: Ian Abbott <abbotti@mev.co.uk>, hsweeten@visionengravers.com,
 gregkh@linuxfoundation.org,
 syzbot+a5e45f768aab5892da5d@syzkaller.appspotmail.com
Cc: jannh@google.com, linux-kernel@vger.kernel.org,
 syzkaller-bugs@googlegroups.com
References: <20250724210451.108177-1-contact@arnaud-lcm.com>
 <7cc194c0-1ce2-411b-92e3-fb1b6c63f062@mev.co.uk>
Content-Language: en-US
From: "Lecomte, Arnaud" <contact@arnaud-lcm.com>
In-Reply-To: <7cc194c0-1ce2-411b-92e3-fb1b6c63f062@mev.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-PPP-Message-ID: <175343660144.31009.17424778932350954475@Plesk>
X-PPP-Vhost: arnaud-lcm.com

Hi Ian,
Thanks for the feedback, I can send the revision of the patch by the end 
of the day if it is fine for you.


On 25/07/2025 10:41, Ian Abbott wrote:
> On 24/07/2025 22:04, Arnaud Lecomte wrote:
>> KMSAN reported a kernel-infoleak when copying instruction data back to
>> userspace in do_insnlist_ioctl(). The issue occurs because allocated
>> memory buffers weren't properly initialized (not
>> zero initialized)  before being copied to
>> userspace, potentially leaking kernel memory.
>>
>> Reported-by: syzbot+a5e45f768aab5892da5d@syzkaller.appspotmail.com
>> Closes: https://syzkaller.appspot.com/bug?extid=a5e45f768aab5892da5d
>> Tested-by: syzbot+a5e45f768aab5892da5d@syzkaller.appspotmail.com
>> Signed-off-by: Arnaud Lecomte <contact@arnaud-lcm.com>
>> ---
>>   drivers/comedi/comedi_fops.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/comedi/comedi_fops.c b/drivers/comedi/comedi_fops.c
>> index c83fd14dd7ad..15fee829d14c 100644
>> --- a/drivers/comedi/comedi_fops.c
>> +++ b/drivers/comedi/comedi_fops.c
>> @@ -1636,7 +1636,7 @@ static int do_insn_ioctl(struct comedi_device 
>> *dev,
>>           n_data = MAX_SAMPLES;
>>       }
>>   -    data = kmalloc_array(n_data, sizeof(unsigned int), GFP_KERNEL);
>> +    data = kcalloc(n_data, sizeof(unsigned int), GFP_KERNEL);
>>       if (!data) {
>>           ret = -ENOMEM;
>>           goto error;
>
> I thought my commit 46d8c744136c ("comedi: Fix initialization of data 
> for instructions that write to subdevice" would have fixed this as 
> long as all the driver code was playing nicely, but it seems I was 
> mistaken.
>
> I don't think it is necessary to use kcalloc().  The buffer already 
> gets initialized (partly by `copy_from_user()`) when `insn->insn & 
> INSN_MASK_WRITE` is non-zero, so it just needs to be initialized when 
> `insn->insn & INSN_MASK_WRITE` is zero too.
>
> There is nearly identical code in `do_insnlist_ioctl()` that needs 
> fixing, so it would be better to fix both at the same time.
>

