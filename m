Return-Path: <linux-kernel+bounces-741147-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8661BB0E0A8
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 17:36:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D52D8564798
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 15:36:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5559C278E5D;
	Tue, 22 Jul 2025 15:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="Zo/i6WCf"
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9E05279323
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 15:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753198579; cv=none; b=HGBtC4CoqxBITlVXnL4hLGkMWvvmmediR7QSYCIdVE7gDEYexpTpAKZMKhIB6Tacw+hRSNdBOXFdlYNENBU+DUzNnGRgZKumZOwkA06+HEkecWHLkRzWI2uzZuPT9Sm22Ms18yPJgPg5klIhoHtivQ7jGneo5cIxfpymaltC8oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753198579; c=relaxed/simple;
	bh=CpImRA/MNF6ygemwiM580UfVJuGAeyS4pEPmQRxmmDo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G7fpqtlAz+RNEykLgfyrXncfoMwlvhmTU7NAEPtcVamrHzaXI4B5LldVxZAGn0W0xPuamr81qFCtsw1rywc/RzR8kiCGd2q8og9O/N+gdL/vx2nHkhZwnukLngWc8x0V7uVaENS9oq/m6WUqAAHHrAkXJ1KdLuexZ6PV/m6rYe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=Zo/i6WCf; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-3df303e45d3so17794255ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 08:36:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1753198574; x=1753803374; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kUVC54+EoQx7608UlnTnCAf9wCePVkITE/xRBCso7Co=;
        b=Zo/i6WCfVXp0KIuhM0en9xdu89youOSfL62NH1Uj+boEEVyJ3UiDgJ4cAo5cfIii4O
         NA4JZNhRBNs1Oo2+NlWY0QjavZ9rxizngn91OmECvqieE7EaXCE2WPoWqCyRbDH1MUNK
         1kdl1kSpcn8j9KT/ej4Rz26Jo84I3WK3JNTPjioxIcpulJ7I6IfIhklk+qnCE/A84fzR
         tSsJmgvVWEISRtFrjtmqBip415O8nsqzHxrZRuxFavLtW/ECOXnU9qeUhaDJVZrNQnD6
         SK2fE67u/M0TyKIxuNt1j0fY24dC4zQyyh8GWKAFeBKqqmc6wzXObA3HoEyRE4hVd5xW
         XelQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753198574; x=1753803374;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kUVC54+EoQx7608UlnTnCAf9wCePVkITE/xRBCso7Co=;
        b=pdSEwurQh2psm/g8qRLhBnGikRb20pdt0rREWgQAQGT1511+eehGRIQ8QCQmpIdXvI
         wJnaWOq9XGrMpDGiGcPsbljEdwiZECaH/JMa5z7kth0noKLFULKkYKKm+QvPWq2fFmms
         I+mBGHuG6MH8Q6mZ2/cizsxLi39qoyuXQ66KjzToT0e9xhdBNuISSi3YbwTH8bZ523N/
         /MbCjDwliL5SRRQDUPsLiCDTsQnXjbYh73E2FhpSMG0hacyuZagXj46s3k1X0wBFgTQl
         fJltvwBum1j4QTdVMFH3RO0kqUOSM8wjd30R8R/LnmUlgvemG4doRFvQmDijrqcYP2M/
         1Taw==
X-Gm-Message-State: AOJu0YxV+yCunOj+uT7ahLUXv/Mbh65IE4oa9JAk/V4R1WEjOFWfEmd1
	0LiJ34ECBeTOYxrfagag192m6GFs5yunR1r32c6vnt5hwacvYSgMOfcrJ6muzhj4wsg=
X-Gm-Gg: ASbGncuw6RZxD/yRfI/oSojAnqXGeMMF+uVoojUuioTF0PEn39KfnPlpeTuUzHyOiF5
	eRGKsFUsh8coNHHx99DUzhiNerkZSXUGm0QrFXvXx6MxXevhyPEei6Xj9GM3VfAUka7ZHHscrRR
	gHUkbZSHCkepZ/FfAO8QcKn81HvEtq7zo4LauSJRQUb5sYUBZRvpK12X7lhpGp9UHoN/JyttkD+
	znRUa1abpYuzmjlaJlPqbd17Sv8zuJVxX1AbRvDzG/Cl7g8yuqjMt4zwGyH5yVTFTBihNg0Wnlq
	WmzQxakBgzDUa2MJCSRhWTvhqBl8etM6vJwaJn9W3hlMQWesHaatwdbrv2LCDi2zcQFgS2IbbP7
	p8DG7nD7jssmqLzCJwg==
X-Google-Smtp-Source: AGHT+IFt3/mKsFa3R4egXJfuUVvj6bEsTKiwwleHCqVW2MoDc3Ifov3VrbtC/7+i1FAZqWMxxaVthg==
X-Received: by 2002:a05:6e02:2786:b0:3dd:8663:d182 with SMTP id e9e14a558f8ab-3e28d49a89amr242572365ab.13.1753198573713;
        Tue, 22 Jul 2025 08:36:13 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3e29816021asm31566225ab.16.2025.07.22.08.36.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Jul 2025 08:36:13 -0700 (PDT)
Message-ID: <496a7fa6-0850-41b1-9528-3448a562f25a@kernel.dk>
Date: Tue, 22 Jul 2025 09:36:12 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] comedi: include poll wait state in busy assessment
To: Ian Abbott <abbotti@mev.co.uk>, hsweeten@visionengravers.com,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>
References: <de833d76-0176-4514-b102-dc83bf93491f@kernel.dk>
 <4c4400e0-dd8c-4694-8030-f35273e5522d@mev.co.uk>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <4c4400e0-dd8c-4694-8030-f35273e5522d@mev.co.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/22/25 9:29 AM, Ian Abbott wrote:
> On 22/07/2025 13:49, Jens Axboe wrote:
>> syzbot reports a use-after-free in comedi in the below link, which is
>> due to comedi gladly removing the allocated async area even though poll
>> requests are still active on the wait_queue_head inside of it. This can
>> cause a use-after-free when the poll entries are later triggered or
>> removed, as the memory for the wait_queue_head has been freed. The
>> notion of being busy in comedi seems mostly centered around sync
>> syscalls, where the comedi subdevice stores the file in 'busy' as a
>> marker. This is obviously broken for things like poll which can be
>> persistent across syscalls.
>>
>> Rename is_device_busy() to start_detach(), and move it under the
>> dev->attach_lock. The latter serializes it with poll attempts. If
>> start_detach() is successful, then it will have marked the device with
>> ->detaching == 1 and this will prevent further poll attempts.
>>
>> Similarly, have start_detach() check for active polls on the device, and
>> return busy for that case.
>>
>> Cc: stable@vger.kernel.org
>> Fixes: 8ffdff6a8cfb ("staging: comedi: move out of staging directory")
>> Link: https://lore.kernel.org/all/687bd5fe.a70a0220.693ce.0091.GAE@google.com/
>> Reported-by: syzbot+01523a0ae5600aef5895@syzkaller.appspotmail.com
>> Tested-by: syzbot+01523a0ae5600aef5895@syzkaller.appspotmail.com
>> Signed-off-by: Jens Axboe <axboe@kernel.dk>
>>
>> ---
>>
>> diff --git a/drivers/comedi/comedi_fops.c b/drivers/comedi/comedi_fops.c
>> index c83fd14dd7ad..58b034e45283 100644
>> --- a/drivers/comedi/comedi_fops.c
>> +++ b/drivers/comedi/comedi_fops.c
>> @@ -782,24 +782,33 @@ void comedi_device_cancel_all(struct comedi_device *dev)
>>       }
>>   }
>>   -static int is_device_busy(struct comedi_device *dev)
>> +static int start_detach(struct comedi_device *dev)
>>   {
>>       struct comedi_subdevice *s;
>> -    int i;
>> +    int i, is_busy = 0;
>>         lockdep_assert_held(&dev->mutex);
>> +    lockdep_assert_held(&dev->attach_lock);
>>       if (!dev->attached)
>>           return 0;
>>         for (i = 0; i < dev->n_subdevices; i++) {
>>           s = &dev->subdevices[i];
>> -        if (s->busy)
>> -            return 1;
>> -        if (s->async && comedi_buf_is_mmapped(s))
>> -            return 1;
>> +        if (s->busy) {
>> +            is_busy = 1;
>> +            break;
>> +        }
>> +        if (!s->async)
>> +            continue;
>> +        if (comedi_buf_is_mmapped(s) ||
>> +            wq_has_sleeper(&s->async->wait_head)) {
>> +            is_busy = 1;
>> +            break;
>> +        }
>>       }
>> -
>> -    return 0;
>> +    if (!is_busy)
>> +        dev->detaching = 1;
>> +    return is_busy;
>>   }
>>     /*
>> @@ -825,8 +834,13 @@ static int do_devconfig_ioctl(struct comedi_device *dev,
>>           return -EPERM;
>>         if (!arg) {
>> -        if (is_device_busy(dev))
>> +        /* prevent new polls */
>> +        down_write(&dev->attach_lock);
>> +        if (start_detach(dev)) {
>> +            up_write(&dev->attach_lock);
>>               return -EBUSY;
>> +        }
>> +        up_write(&dev->attach_lock);
>>           if (dev->attached) {
>>               struct module *driver_module = dev->driver->module;
>>   @@ -2479,7 +2493,7 @@ static __poll_t comedi_poll(struct file *file, poll_table *wait)
>>         down_read(&dev->attach_lock);
>>   -    if (!dev->attached) {
>> +    if (!dev->attached || dev->detaching) {
>>           dev_dbg(dev->class_dev, "no driver attached\n");
>>           goto done;
>>       }
>> diff --git a/include/linux/comedi/comedidev.h b/include/linux/comedi/comedidev.h
>> index 4cb0400ad616..b2bec668785f 100644
>> --- a/include/linux/comedi/comedidev.h
>> +++ b/include/linux/comedi/comedidev.h
>> @@ -545,6 +545,7 @@ struct comedi_device {
>>       const char *board_name;
>>       const void *board_ptr;
>>       unsigned int attached:1;
>> +    unsigned int detaching:1;
>>       unsigned int ioenabled:1;
>>       spinlock_t spinlock;    /* generic spin-lock for low-level driver */
>>       struct mutex mutex;    /* generic mutex for COMEDI core */
>>
> 
> Thanks for the patch.  I'll post my version shortly.  One problem with
> this patch is that dev->detaching does not get cleared.

I'm fine with your patch, no obligations on this one. Main thing was
getting to the bottom of what that issue was, you know the code better
and can propose a better solution based on that. I only wrote this one
to ensure the issue didn't get ignored.

-- 
Jens Axboe

