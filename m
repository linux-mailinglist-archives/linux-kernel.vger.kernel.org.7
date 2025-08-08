Return-Path: <linux-kernel+bounces-760659-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62655B1EE51
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 20:23:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6CE4258505F
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 18:23:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACF8F2652B2;
	Fri,  8 Aug 2025 18:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="VlRrncev"
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9841B1DFD96
	for <linux-kernel@vger.kernel.org>; Fri,  8 Aug 2025 18:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754677380; cv=none; b=kMnL1cEQHJQ//7GLmUNjcXmg4YnQRKGJklIjGT81P57jcsVxo1aaMx11rGWp1Pblx116wjqJ+Vt1SDZikCzimn8KSwQmzeYUdhMw647+whB02F63FFzwEc2z8keh/eH4/q8TvO6MFa2mmRaY/D/EmE1YLzbcDc0NB1mjuFrplqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754677380; c=relaxed/simple;
	bh=6DJGxIZNB0MbLYPgS7uPnOFj4xUSHRfa44MOaAcBXVE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DuKRK3bwvTn+6Dr4yYCLHDbVFKpmht4BfgpvdfxS5Edx8oxlt7hJyrg88wHioQTzm/jbdYT+t0Im5t7I4RFWwxGcNjKT1tjY8zqStvPlBTZu5juK7Yh2aD9Vvd26hrBVBwxYCsbA4xlkOfLC9atUJTkHXWWtCka3E5XLSaMCnR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=VlRrncev; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-8817b8d2d0eso82493039f.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Aug 2025 11:22:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1754677377; x=1755282177; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JZH9CfwqA0hE9fcGIfSzdamQXb+OlOwdY/lyO0/9wlA=;
        b=VlRrncevT9yfPnvBR/5RmNz8Ns4Tx/jSG5RCkYz/QWGZn+SRUQo2AiLPKjaB9OIuU4
         IHOHh41tvSKKYsiSwjIaRy4KXBspNTZFj2u14mshE53Y4d1FA6bydyvIIiLowo6rZ4C5
         wEJh/ftCxIV8cPone+wCA2EMbyNELNWuNYeWPx9G0WKJYxJ++xNzbnCccVGufMMEygCD
         J/m2vTG3bV/PogjjtIdXndX4xn5cAiVFXwyVcaqIo7xCUyICnkjfWBu0Ghq+UqsXMF62
         TnnCMLnyQMf4Pnx3CeHDaSJD/lfU+4QxnYSfOCMBGCFUKCFtNERwVk422KEbmuJhjfI9
         KL6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754677377; x=1755282177;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JZH9CfwqA0hE9fcGIfSzdamQXb+OlOwdY/lyO0/9wlA=;
        b=Y6us5MNL4kfy91Soz/g0QbtxtWDFDTKzBg6pwoBrtPGrDcGnQLldUge+RoYoItKyBw
         Z9JBFUbVfdmgVIecSKIq8vIaP2dKygP9E8TnCUZUG4fuMLjo4mNsrwkR4BOMBr2ehIrI
         A1OSh53DjPAMxAAlpYTBv0AjiYgHhhqU0xYP8k+WbSwXQbhl2YrnGQwoJ/Uf+Gt/a0+H
         6XWo+2t5ZHZdNNXynXUnRQ2QHZl7ag7n40Ext5jgatO3De8lYOsUKl8S8rR3faTv6mTq
         pMAvHQTAJD9a74k26tB1vyu8o8u28WQZnXsdO7a3Lzql9SoFVqhIMP/71Yur1JefzdWP
         CNgw==
X-Forwarded-Encrypted: i=1; AJvYcCUTUutoJaLhzQ74fgUcqEh8HtF9XQWyAVxe1kNyTKzyFx89+Y26r1OuVjTcgrJagVsYuUK5aAFIbgwTmKU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yya8Zall1MpZmL9jhnjy83YHFfK619OezcN9zfkKxSWjOUX4IBs
	w3ypNSnu1QvEZ5W4+HV4fG45pmporHsgOBunSHrENusxnTUwUWCrdGhHQtimKgjirys=
X-Gm-Gg: ASbGncs4kU3mmrSpJBBqirCmRAoyWFuf76A7+CQm3i/ZAmDG2EwXozYHLSIpvg9Vahb
	GJoEi79LN/BWwmyc+VLpBGFCOmy96LhOIQ2xcqtcMOrsdbFG5IMTT9Zzcnd21B80KrxBoaPsRKa
	rzR/KOoEpie1NRUCsnT6lKMDbbpU4wUSlJ18GRQleblX67YmgUpYINfUcwhnnwxNsvdh3zgXBmX
	zGwqgyyCyZvXyr/P2xeApvcdn9JAQyhqMJ1g7gInZq6CuGRWGx0xbw8r8Ve60sZX0uS8drFTUBa
	XWxpg4AXqEvcAH6b+3AamSlyUnBh9hT+f2RVmlp+2zbLFnvsJ0hq/WpqRa7PvuOge/uh2ONWCQt
	kZhfD2D+M8ojyw/wTNQY=
X-Google-Smtp-Source: AGHT+IG7sqPk4NgexsHEwfKSDUgxoaY6sX4HssO4A1bOwvoI1qk3OSnmTHvN1PpR3P1Fa+fxWX7d6w==
X-Received: by 2002:a05:6e02:188f:b0:3e5:29a3:b552 with SMTP id e9e14a558f8ab-3e5330b606cmr75359305ab.3.1754677377222;
        Fri, 08 Aug 2025 11:22:57 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-50ae9cbb6dasm631298173.95.2025.08.08.11.22.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Aug 2025 11:22:56 -0700 (PDT)
Message-ID: <c43ad3c8-0a4c-41c5-9d28-d138b012863b@kernel.dk>
Date: Fri, 8 Aug 2025 12:22:55 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ublk: check for unprivileged daemon on each I/O fetch
To: Caleb Sander Mateos <csander@purestorage.com>,
 Uday Shankar <ushankar@purestorage.com>
Cc: Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250808155216.296170-1-csander@purestorage.com>
 <aJY7fPmOLMe7T5A7@dev-ushankar.dev.purestorage.com>
 <CADUfDZqz1R=aTuyRhsVjpJnoUgXBgsf1Jkg4qX_sn+NtP4TPeQ@mail.gmail.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <CADUfDZqz1R=aTuyRhsVjpJnoUgXBgsf1Jkg4qX_sn+NtP4TPeQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/8/25 12:03 PM, Caleb Sander Mateos wrote:
> On Fri, Aug 8, 2025 at 2:01?PM Uday Shankar <ushankar@purestorage.com> wrote:
>>
>> On Fri, Aug 08, 2025 at 09:52:15AM -0600, Caleb Sander Mateos wrote:
>>> Commit ab03a61c6614 ("ublk: have a per-io daemon instead of a per-queue
>>> daemon") allowed each ublk I/O to have an independent daemon task.
>>> However, nr_privileged_daemon is only computed based on whether the last
>>> I/O fetched in each ublk queue has an unprivileged daemon task.
>>> Fix this by checking whether every fetched I/O's daemon is privileged.
>>> Change nr_privileged_daemon from a count of queues to a boolean
>>> indicating whether any I/Os have an unprivileged daemon.
>>>
>>> Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
>>> Fixes: ab03a61c6614 ("ublk: have a per-io daemon instead of a per-queue daemon")
>>
>> Nice catch!
>>
>>> ---
>>>  drivers/block/ublk_drv.c | 16 +++++++---------
>>>  1 file changed, 7 insertions(+), 9 deletions(-)
>>>
>>> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
>>> index 6561d2a561fa..a035070dd690 100644
>>> --- a/drivers/block/ublk_drv.c
>>> +++ b/drivers/block/ublk_drv.c
>>> @@ -233,11 +233,11 @@ struct ublk_device {
>>>
>>>       struct ublk_params      params;
>>>
>>>       struct completion       completion;
>>>       unsigned int            nr_queues_ready;
>>> -     unsigned int            nr_privileged_daemon;
>>> +     bool                    unprivileged_daemons;
>>>       struct mutex cancel_mutex;
>>>       bool canceling;
>>>       pid_t   ublksrv_tgid;
>>>  };
>>>
>>> @@ -1548,11 +1548,11 @@ static void ublk_reset_ch_dev(struct ublk_device *ub)
>>>               ublk_queue_reinit(ub, ublk_get_queue(ub, i));
>>>
>>>       /* set to NULL, otherwise new tasks cannot mmap io_cmd_buf */
>>>       ub->mm = NULL;
>>>       ub->nr_queues_ready = 0;
>>> -     ub->nr_privileged_daemon = 0;
>>> +     ub->unprivileged_daemons = false;
>>>       ub->ublksrv_tgid = -1;
>>>  }
>>>
>>>  static struct gendisk *ublk_get_disk(struct ublk_device *ub)
>>>  {
>>> @@ -1978,16 +1978,14 @@ static void ublk_reset_io_flags(struct ublk_device *ub)
>>>  /* device can only be started after all IOs are ready */
>>>  static void ublk_mark_io_ready(struct ublk_device *ub, struct ublk_queue *ubq)
>>>       __must_hold(&ub->mutex)
>>>  {
>>>       ubq->nr_io_ready++;
>>> -     if (ublk_queue_ready(ubq)) {
>>> +     if (ublk_queue_ready(ubq))
>>>               ub->nr_queues_ready++;
>>> -
>>> -             if (capable(CAP_SYS_ADMIN))
>>> -                     ub->nr_privileged_daemon++;
>>> -     }
>>> +     if (!ub->unprivileged_daemons && !capable(CAP_SYS_ADMIN))
>>> +             ub->unprivileged_daemons = true;
>>
>> Shorter:
>>
>> ub->unprivileged_daemons |= !capable(CAP_SYS_ADMIN);
> 
> I was trying to avoid the capable() call if unprivileged_daemons was
> already set. But maybe that's not a common case and it's not worth
> optimizing?

Definitely worth it, you did the right thing.

-- 
Jens Axboe

