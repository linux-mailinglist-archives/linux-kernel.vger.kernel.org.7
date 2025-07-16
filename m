Return-Path: <linux-kernel+bounces-733292-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B9170B072C0
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 12:10:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C5693A8708
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 10:09:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58DAF2F2C6A;
	Wed, 16 Jul 2025 10:10:24 +0000 (UTC)
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48F3529DB73
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 10:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752660623; cv=none; b=LIsqLh+1eu4qc+GpxA3/3rnBdCO67vOGFt9kVOAkWesVjdx2vGB5LrAd5JNT4AioUYYsv9o9heGt04I5ahm0/DEjrYmCEi8hLAyL2Fgrl8O+lidHA27wjXCsQWu3mLb2sh/BSYIPmtgQEgPVfZL0NvQLPtNswV+4+71VyKGSGPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752660623; c=relaxed/simple;
	bh=4WvQT9YsqETDpdaDZDA0qYrtm+4JgH3/aPK1MaUOjFQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hhUZ7+Vkf+EQY64ykxCsb6meVa9uenrXaoOkQq1+Oh7SX3wMC/BOnGSvHpw1fx/8lCMJERXMXGvMMrYuQiqWLQEt6k/jQo7gLgN0OLPq2h/9B7Xww8EhtxmacytQQVcajhKt8Y1jsfXe+Joubdkvms9ZHe1XBKZyP7Qe/qpU98s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 56GA9pSh019646;
	Wed, 16 Jul 2025 19:09:51 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 56GA9p5x019637
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Wed, 16 Jul 2025 19:09:51 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <a44d5568-48d6-44f7-af93-e1b966489a84@I-love.SAKURA.ne.jp>
Date: Wed, 16 Jul 2025 19:09:51 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] media: imon: make send_packet() more robust
To: Sean Young <sean@mess.org>, Alan Stern <stern@rowland.harvard.edu>
Cc: Hillf Danton <hdanton@sina.com>,
        syzbot+592e2ab8775dbe0bf09a@syzkaller.appspotmail.com,
        LKML <linux-kernel@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
References: <53c07aa0-9f83-4c83-8ab5-6d8663f51b91@I-love.SAKURA.ne.jp>
 <8be733a4-2232-4bb9-942d-f13f8766a6de@I-love.SAKURA.ne.jp>
 <40417f2a-e0d8-4f3c-9a37-a0068b6f268a@I-love.SAKURA.ne.jp>
 <0ad3effe-efed-4304-862f-4c8f901e79e9@I-love.SAKURA.ne.jp>
 <2ac5d313-c754-4fb9-acd3-21f3b948d653@I-love.SAKURA.ne.jp>
 <282345b9-9aff-43ed-b66d-76cf51cc0deb@I-love.SAKURA.ne.jp>
 <20250713081148.3880-1-hdanton@sina.com>
 <d6da6709-d799-4be3-a695-850bddd6eb24@rowland.harvard.edu>
 <aHa3xpKfGNqAocIO@gofer.mess.org>
 <c4e88c28-28ee-4e37-9822-8e2999d0f0ee@rowland.harvard.edu>
 <aHdzD7EowAKT4AhQ@gofer.mess.org>
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <aHdzD7EowAKT4AhQ@gofer.mess.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Virus-Status: clean
X-Anti-Virus-Server: fsav203.rs.sakura.ne.jp

On 2025/07/16 18:38, Sean Young wrote:
> On Tue, Jul 15, 2025 at 09:30:02PM -0400, Alan Stern wrote:
>> On Tue, Jul 15, 2025 at 09:19:18PM +0100, Sean Young wrote:
>>> Hi Alan,
>>>
>>> On Sun, Jul 13, 2025 at 11:21:24AM -0400, Alan Stern wrote:
>>>> On Sun, Jul 13, 2025 at 04:11:47PM +0800, Hillf Danton wrote:
>>>>> [loop Alan in]
>>>>
>>>> I assume you're interested in the question of when to avoid resubmitting 
>>>> URBs.

I think that what Hillf wanted to know (and I wanted maintainers of this
driver to respond) is whether timeout of 10 seconds is reasonable

-		/* Wait for transmission to complete (or abort) */
-		retval = wait_for_completion_interruptible(
-				&ictx->tx.finished);
-		if (retval) {
+		/* Wait for transmission to complete (or abort or timeout) */
+		retval = wait_for_completion_interruptible_timeout(&ictx->tx.finished, 10 * HZ);

because the reproducer for this problem sometimes prevents
usb_rx_callback_intf0() from being called. Unless we somehow
handle such situation, the hung task reports won't go away.



>>> I think that is why this driver code is so awkward.
>>
>> That's what usb_driver_claim_interface() is for.  IIRC, the cdc-acm 
>> driver uses it in exactly this way.
> 
> Very interesting, we should look at re-writing this driver. Note this
> function is not documented in Documentation/driver-api/usb/

OK. Then, what do you want to do for this syzbot report?
If you want to apply this patch, I'll send an updated patch with Alan's comment.
If you want to directly rewrite this module, this patch will be discarded.


