Return-Path: <linux-kernel+bounces-861466-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D776BF2CB4
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 19:47:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id CB12F34E23E
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 17:47:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 253C9330322;
	Mon, 20 Oct 2025 17:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mev.co.uk header.i=@mev.co.uk header.b="kgXBCtV8"
Received: from smtp110.iad3a.emailsrvr.com (smtp110.iad3a.emailsrvr.com [173.203.187.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCBC0287256
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 17:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.203.187.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760982413; cv=none; b=f5uWQjDUtgKIXWjg5irX3VmZ8dfoPmnpWJTD7BH/ozf506RLPfSxRoH40RaATuXJkGSSHvGbUMgT6BUn/32ZiuIrBFcwFm+AQXMnbVkh6JaC8Kg4kSVbGb5c3QiyNwvKTjXd4k2uonBnunD8qPy5tBW9lGJR3PIq3ig3Kazuqn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760982413; c=relaxed/simple;
	bh=6+pYspyYIeVVLXIIaxy1vj4VY1BtijXL1dkBCTC0r2s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UNNwYb3IIaGGTObB1Xhd2GRL3ONkjLATD5TOUdcqx6BCpWgr3JSy9AQ+laXD5/kFkR/+l23IReIKAFuMUeL7mS/7HN1TnNhRESzZhi4YU9SyCep/aYKA0tflt8LavSMRhdS9CR/M5nlGiXCfonJ1snq/zFkGz1x9xhlnkA5QaG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mev.co.uk; spf=pass smtp.mailfrom=mev.co.uk; dkim=pass (1024-bit key) header.d=mev.co.uk header.i=@mev.co.uk header.b=kgXBCtV8; arc=none smtp.client-ip=173.203.187.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mev.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mev.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mev.co.uk;
	s=20221208-6x11dpa4; t=1760981356;
	bh=6+pYspyYIeVVLXIIaxy1vj4VY1BtijXL1dkBCTC0r2s=;
	h=Date:Subject:To:From:From;
	b=kgXBCtV8aYYEq23927ei4ArK3Da/BO26CgexXW/H4ljvyOMeUhppxkpblPsk3a8Xb
	 LucCFh39LIRfZlm+Ob++ddxBu5ZRnko9UziWAkoE72Uu+68GnH+0LgkGige70OdEWh
	 T6zfahJkReCVvcmMUQDYE5euik/vtpOsfr6tYXrc=
X-Auth-ID: abbotti@mev.co.uk
Received: by smtp38.relay.iad3a.emailsrvr.com (Authenticated sender: abbotti-AT-mev.co.uk) with ESMTPSA id 998AD57CF;
	Mon, 20 Oct 2025 13:29:15 -0400 (EDT)
Message-ID: <07e71db1-d6ea-4cb6-8342-86da3c11773e@mev.co.uk>
Date: Mon, 20 Oct 2025 18:29:14 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [kernel?] divide error in comedi_inc_scan_progress
To: =?UTF-8?B?0JbQsNC90LTQsNGA0L7QstC40Ycg0J3QuNC60LjRgtCwINCY0LPQvtGA0LU=?=
 =?UTF-8?B?0LLQuNGH?= <n.zhandarovich@fintech.ru>,
 "syzbot+af53dea94b16396bc646@syzkaller.appspotmail.com"
 <syzbot+af53dea94b16396bc646@syzkaller.appspotmail.com>,
 H Hartley Sweeten <hsweeten@visionengravers.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "lvc-project@linuxtesting.org" <lvc-project@linuxtesting.org>
References: <20251016110511.3460094-1-n.zhandarovich@fintech.ru>
 <9c92913c-c04b-4784-9cdc-5d75b10d2ed9@mev.co.uk>
 <d4f354f0972243bebe81c2c132ac95b3@fintech.ru>
Content-Language: en-GB
From: Ian Abbott <abbotti@mev.co.uk>
Organization: MEV Ltd.
In-Reply-To: <d4f354f0972243bebe81c2c132ac95b3@fintech.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Classification-ID: 04377059-6e90-428b-9d11-b33ab9ce4da4-1-1

On 20/10/2025 14:36, Жандарович Никита Игоревич wrote:
> Hi Ian,
> 
> Thank you for your response!
> 
>>>       ...
>>>       if (!(s->subdev_flags & SDF_PACKED) && (cmd->chanlist_len != 0)) {
>>> 	async->cur_chan += comedi_bytes_to_samples(s, num_bytes);
>>> 	async->cur_chan %= cmd->chanlist_len;
>>>       }
>>>       ...
>>>
>>> Any suggestions are greatly appreciated!
>>
>> I have a plan to deal with these unexpected interrupts, at least within the
>> Comedi core functions.  The basic idea would be to for the Comedi core
>> functions called by the ISRs to check that the subdevice is in the running state
>> and increment a reference counter (either a refcount_t or a struct kref) if it is
>> safe to proceed.  Then it will be allowed to assume that the struct
>> comedi_async contents are reasonable until it decrements the reference
>> counter.  Some other task may be calling
>> do_become_nonbusy() in parallel with the above.  After
>> do_become_nonbusy() clears the COMEDI_SRF_RUNNING flag to mark the
>> subdevice as not being in the running state, it should wait until it is safe to
>> continue before calling comedi_buf_reset().  This will make use of the
>> reference counter and a struct completion.  The reference counter and struct
>> completion can be stored as members of struct comedi_async.
>>
>> There may be other parts of individual driver ISRs that use struct
>> comedi_async directly and may need changing to do similar checks.  The
>> checking and final decrement can done by a couple of new exported
>> functions:
>>
>> bool comedi_get_is_subdevice_running(struct comedi_subdevice *s); void
>> comedi_put_is_subdevice_running(struct comedi_subdevice *s);
>>
>> If comedi_get_is_subdevice_running(s) returns true, the ISR can safely
>> access s->async and then should call comedi_put_is_subdevice_running(s)
>> when it has finished.
>>
>>
> 
> I'll try to tackle this idea when I get the chance, thanks for your suggestion!

I'm trying to implement it at the moment.

-- 
-=( Ian Abbott <abbotti@mev.co.uk> || MEV Ltd. is a company  )=-
-=( registered in England & Wales.  Regd. number: 02862268.  )=-
-=( Regd. addr.: S11 & 12 Building 67, Europa Business Park, )=-
-=( Bird Hall Lane, STOCKPORT, SK3 0XA, UK. || www.mev.co.uk )=-

