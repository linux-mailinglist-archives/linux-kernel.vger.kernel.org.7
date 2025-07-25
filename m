Return-Path: <linux-kernel+bounces-745594-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F12D1B11C00
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 12:15:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC7BFAE3BFA
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 10:15:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4029D2E2EFD;
	Fri, 25 Jul 2025 10:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mev.co.uk header.i=@mev.co.uk header.b="eZVGx9kx"
Received: from smtp68.ord1d.emailsrvr.com (smtp68.ord1d.emailsrvr.com [184.106.54.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E76482E175C
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 10:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=184.106.54.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753438308; cv=none; b=uiU+wGc7Yq8rNgyspZKvisopBcCkjGbXW9MvHEwVUQq7Ta0BTZnGp5KuvolS4sRmJQzAL6RZRLgNY5oH0yZeHtB0SkEjSIcXtu0evNdjgEGWSSVrWBlPn55oiimi8/7s9I5UeBSYtBWXdpok0uuzvOhV3rthsN+TOZX+r+bvDno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753438308; c=relaxed/simple;
	bh=LYYCWO+7PdRzywvs4qZwMuLPIvyONtO80m0O2/k5WCw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ax1LG9ifNDsE8QApeztEXpL9TawNx137F0SvD+EQv3FpOeUyJ+JsKTv1493DPrud8EaTGqHHjcNrUZLXEJp7UlwhKPmTLP+SUMQlrRwYiDk3mFbn6KG8AwVGV68GLHI8WvgGYIGMkJJUpdJlD0kcuJTu1eL5HpDpsMjRPBIakqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mev.co.uk; spf=pass smtp.mailfrom=mev.co.uk; dkim=pass (1024-bit key) header.d=mev.co.uk header.i=@mev.co.uk header.b=eZVGx9kx; arc=none smtp.client-ip=184.106.54.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mev.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mev.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mev.co.uk;
	s=20221208-6x11dpa4; t=1753437864;
	bh=LYYCWO+7PdRzywvs4qZwMuLPIvyONtO80m0O2/k5WCw=;
	h=Date:Subject:To:From:From;
	b=eZVGx9kxgmVTr15QJzB42M/aq9smyaCk+s7Q8AL/0CaELUwqd0PbuaVleF/l6Ino6
	 hRPApwQ2+lZHPBuUdriVSUFaFqd1ktH0dlIQZuwpzZOohNb3eiIjGnlhk0pKH+Wn2D
	 Kuc0VAgpRl9Nljmsu5r7ld3O5NxAYXlfGJwZby9Q=
X-Auth-ID: abbotti@mev.co.uk
Received: by smtp17.relay.ord1d.emailsrvr.com (Authenticated sender: abbotti-AT-mev.co.uk) with ESMTPSA id 888AF20235;
	Fri, 25 Jul 2025 06:04:23 -0400 (EDT)
Message-ID: <a7ab6827-771b-48b4-98b2-4789d78e19e0@mev.co.uk>
Date: Fri, 25 Jul 2025 11:04:22 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] comedi: zero-init data in do_insn_ioctl
To: "Lecomte, Arnaud" <contact@arnaud-lcm.com>, hsweeten@visionengravers.com,
 gregkh@linuxfoundation.org,
 syzbot+a5e45f768aab5892da5d@syzkaller.appspotmail.com
Cc: jannh@google.com, linux-kernel@vger.kernel.org,
 syzkaller-bugs@googlegroups.com
References: <20250724210451.108177-1-contact@arnaud-lcm.com>
 <7cc194c0-1ce2-411b-92e3-fb1b6c63f062@mev.co.uk>
 <89c2e255-fd5c-4533-8ec2-1864ddf5eaa3@arnaud-lcm.com>
Content-Language: en-GB
From: Ian Abbott <abbotti@mev.co.uk>
Organization: MEV Ltd.
In-Reply-To: <89c2e255-fd5c-4533-8ec2-1864ddf5eaa3@arnaud-lcm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Classification-ID: 7a1cf043-8149-4345-997f-8ba8edd587a7-1-1

On 25/07/2025 10:43, Lecomte, Arnaud wrote:
> Hi Ian,
> Thanks for the feedback, I can send the revision of the patch by the end 
> of the day if it is fine for you.

Actually, I'm just building a (hopefully) fixed version at the moment. 
I'll add you to the Cc list for it.

> On 25/07/2025 10:41, Ian Abbott wrote:
>> On 24/07/2025 22:04, Arnaud Lecomte wrote:
>>> KMSAN reported a kernel-infoleak when copying instruction data back to
>>> userspace in do_insnlist_ioctl(). The issue occurs because allocated
>>> memory buffers weren't properly initialized (not
>>> zero initialized)  before being copied to
>>> userspace, potentially leaking kernel memory.
>>>
>>> Reported-by: syzbot+a5e45f768aab5892da5d@syzkaller.appspotmail.com
>>> Closes: https://syzkaller.appspot.com/bug?extid=a5e45f768aab5892da5d
>>> Tested-by: syzbot+a5e45f768aab5892da5d@syzkaller.appspotmail.com
>>> Signed-off-by: Arnaud Lecomte <contact@arnaud-lcm.com>
>>> ---
>>>   drivers/comedi/comedi_fops.c | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/comedi/comedi_fops.c b/drivers/comedi/comedi_fops.c
>>> index c83fd14dd7ad..15fee829d14c 100644
>>> --- a/drivers/comedi/comedi_fops.c
>>> +++ b/drivers/comedi/comedi_fops.c
>>> @@ -1636,7 +1636,7 @@ static int do_insn_ioctl(struct comedi_device 
>>> *dev,
>>>           n_data = MAX_SAMPLES;
>>>       }
>>>   -    data = kmalloc_array(n_data, sizeof(unsigned int), GFP_KERNEL);
>>> +    data = kcalloc(n_data, sizeof(unsigned int), GFP_KERNEL);
>>>       if (!data) {
>>>           ret = -ENOMEM;
>>>           goto error;
>>
>> I thought my commit 46d8c744136c ("comedi: Fix initialization of data 
>> for instructions that write to subdevice" would have fixed this as 
>> long as all the driver code was playing nicely, but it seems I was 
>> mistaken.
>>
>> I don't think it is necessary to use kcalloc().  The buffer already 
>> gets initialized (partly by `copy_from_user()`) when `insn->insn & 
>> INSN_MASK_WRITE` is non-zero, so it just needs to be initialized when 
>> `insn->insn & INSN_MASK_WRITE` is zero too.
>>
>> There is nearly identical code in `do_insnlist_ioctl()` that needs 
>> fixing, so it would be better to fix both at the same time.
>>


-- 
-=( Ian Abbott <abbotti@mev.co.uk> || MEV Ltd. is a company  )=-
-=( registered in England & Wales.  Regd. number: 02862268.  )=-
-=( Regd. addr.: S11 & 12 Building 67, Europa Business Park, )=-
-=( Bird Hall Lane, STOCKPORT, SK3 0XA, UK. || www.mev.co.uk )=-

