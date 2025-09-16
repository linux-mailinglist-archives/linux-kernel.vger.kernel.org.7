Return-Path: <linux-kernel+bounces-819738-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B02FAB7DA1C
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 14:32:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3DCD31B226D5
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 23:34:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3EA3261B65;
	Tue, 16 Sep 2025 23:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SKdSFMo4"
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBD03BA45
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 23:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758065628; cv=none; b=OzmG6v16mT7cqEOYbwFiUhNvEzF+X983UxdYUJnpUqLpmoAJxN13s7hscAlgnfIRSpqn9qXRIaGxj6dOdWsowJxVu5YuZChjSax6Lx+w/quO7GAcWQ6ljolorGGkKWVf7OwpTVBwiakhRJKa8SXGo1c/z0QDeLBOe5yGYlukrvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758065628; c=relaxed/simple;
	bh=+BBQUal0gcLkU4J+/wGKUcLf+qGcByY5UaOyrYgF5Lk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T19EYDX3EFV0WOBjswmunDfu9/eHDLNuIbcAtmFNr5gEqVn427DYuZQrmfsKCGOub3Gcofp9si+hRd3WtZFK8TmKxBDani267Xqgdg5dfc/Bj+X6UAGwOah43bsgB7RJKwkcv0Yb+fub2wt7F6g2k5Jty0QUKrItKFqM6oBJj3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=SKdSFMo4; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4b48eabaef3so60519701cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 16:33:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1758065626; x=1758670426; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=K1wN9hF9riUo1dM90iinoi52Pit9VGaxH3PleUBd1GE=;
        b=SKdSFMo4fmuUASOw4OJxPPvhR9QnS0miCepjUlsWYnN1HC6Ti1yPugBo4t45SV6cFg
         jChT314A+vNmjpBreZbG1y6cjw3vrKhulF8pdb0nMMe2sDK3msPgkNz0Lacbs0bxhwVJ
         /4PtiTd6A6oYje2KhGvESgyaBR1zvBv7ytKyI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758065626; x=1758670426;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K1wN9hF9riUo1dM90iinoi52Pit9VGaxH3PleUBd1GE=;
        b=sGVKF1KsT6HAbu+26GNYgKty/7kH5lJSeRJ6MEdgUv2FsFE1p/QPVq9lO0nNoY51oj
         gIJSPylvJwSHzFxPpuoICBSw1xxtee4CZTBQ/Bm1kZnVHtTaBp3mcCZ1ABEpmOkcYEc4
         yYNrhGwegob8w1IM17glnQwkVSZ914gmGHJdYY+XxqF6+G/LOAuxAPhv57dFXHKGpAZy
         nHpN3LVDtGqz7XhBFBNTcHYRFbHJbocBfdWB0vQRh/4PAAwRg89eRx40W8dwNWR3pfYy
         VvcvSrvKQGx7bxvLk4mWnxnABzU/VvSfzv3Yl5s4OBk2dQCHChuQnIDVyTkKRVlPDZ1Z
         TZog==
X-Forwarded-Encrypted: i=1; AJvYcCVAL3KIp1ldkoT8VEIlRZekQLCdlZmZQ1xFEbIsSvSY5D8ulhdudHzdTPGNvUskzoBcEJ4Lc9sO+LqwQ+8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsOoIj4GA0Mls7U0K/8TWcAlC0138fsRvR4pK49+X+uRhCe0a8
	GZDkRCvGSFhPYnxitcCLbmC24WjmKB3MocftZSYKn2lykvhsjisi/Z/sQMaWb1DpgLA=
X-Gm-Gg: ASbGncvz01OeyBPjdvJ/2ap0lknbHKvJmgCrPlc1UoiVVtrqQo8j0j3DNwzQYKgfjW7
	IOBlqjqR3Pc+WXf9ZVLpTRh9KqV7W9zOQXCOVvYwpVRKZf1FEwUrB7U96atxYQpVYUKctsczXm4
	k5aENhs8+43LTOrVmt0abwlaeJ2rUcj4kytympkp9MkuPiGbvuAWDxmRudm/5NumoxutOJ6SjDm
	MMQkMmFopO/avuzHsVJCQpNF0UcPrs7+T9RZEXRXEBwcxC6lZ9J6nzA7r0Mra6VE0Pa1eFXe37O
	WQrL7Kk7KJ3qSHcMi5gtXLNzp4+y1p9WBbMtnJUoDwdIxDzDKGhwG19hB+9fAryDXWel3IPozAq
	S9/G95LdcJyvh+u/A8OTfG+be8ELReAglrPKWWYqCmYvZBqG3S0ox+hAT5wTNPahy6WxeZ1JcJO
	fYCvU2OiF44+0KZsPesVN52UX1xeMgDSlPfVX2lp2g79o=
X-Google-Smtp-Source: AGHT+IFRoshFhSAZ+T4lV66dmVbNfAnq3iuZJVF6Kg/ulCHno1XN9HC4PMC+28LuE6bhaFncVLfjmQ==
X-Received: by 2002:ac8:58c1:0:b0:4b3:122f:89d6 with SMTP id d75a77b69052e-4ba69d351d6mr3407291cf.45.1758065625673;
        Tue, 16 Sep 2025 16:33:45 -0700 (PDT)
Received: from [192.168.226.35] (207-181-222-53.s5939.c3-0.hnc-cbr1.chi-hnc.il.cable.rcncustomer.com. [207.181.222.53])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b639cb1b33sm89168221cf.14.2025.09.16.16.33.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Sep 2025 16:33:45 -0700 (PDT)
Message-ID: <c32f5c8b-0c62-4567-9d82-081ecb0889b1@linuxfoundation.org>
Date: Tue, 16 Sep 2025 17:33:44 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2] usbip: Fix locking bug in RT-enabled kernels
To: Alan Stern <stern@rowland.harvard.edu>, Lizhi Xu
 <lizhi.xu@windriver.com>, Valentina Manea <valentina.manea.m@gmail.com>,
 Shuah Khan <shuah@kernel.org>
Cc: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
 linux-usb@vger.kernel.org,
 syzbot+205ef33a3b636b4181fb@syzkaller.appspotmail.com,
 syzkaller-bugs@googlegroups.com, Shuah Khan <skhan@linuxfoundation.org>
References: <4f7805f7-805a-4678-8844-c38a97650dda@rowland.harvard.edu>
 <20250916014143.1439759-1-lizhi.xu@windriver.com>
 <61e796d2-0139-4459-a4e3-f27892384de2@rowland.harvard.edu>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <61e796d2-0139-4459-a4e3-f27892384de2@rowland.harvard.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/16/25 09:47, Alan Stern wrote:
> On Tue, Sep 16, 2025 at 09:41:43AM +0800, Lizhi Xu wrote:
>> Interrupts are disabled before entering usb_hcd_giveback_urb().
>> A spinlock_t becomes a sleeping lock on PREEMPT_RT, so it cannot be
>> acquired with disabled interrupts.
>>
>> Save the interrupt status and restore it after usb_hcd_giveback_urb().
>>
>> syz reported:
>> BUG: sleeping function called from invalid context at kernel/locking/spinlock_rt.c:48
>> Call Trace:
>>   dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
>>   rt_spin_lock+0xc7/0x2c0 kernel/locking/spinlock_rt.c:57
>>   spin_lock include/linux/spinlock_rt.h:44 [inline]
>>   mon_bus_complete drivers/usb/mon/mon_main.c:134 [inline]
>>   mon_complete+0x5c/0x200 drivers/usb/mon/mon_main.c:147
>>   usbmon_urb_complete include/linux/usb/hcd.h:738 [inline]
>>   __usb_hcd_giveback_urb+0x254/0x5e0 drivers/usb/core/hcd.c:1647
>>   vhci_urb_enqueue+0xb4f/0xe70 drivers/usb/usbip/vhci_hcd.c:818
>>
>> Reported-by: syzbot+205ef33a3b636b4181fb@syzkaller.appspotmail.com
>> Closes: https://syzkaller.appspot.com/bug?extid=205ef33a3b636b4181fb
>> Signed-off-by: Lizhi Xu <lizhi.xu@windriver.com>
>> ---
>> V1 -> V2: fix it in usbip
>>
>>   drivers/usb/usbip/vhci_hcd.c | 6 +++---
>>   1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/usb/usbip/vhci_hcd.c b/drivers/usb/usbip/vhci_hcd.c
>> index e70fba9f55d6..eb6de7e8ea7b 100644
>> --- a/drivers/usb/usbip/vhci_hcd.c
>> +++ b/drivers/usb/usbip/vhci_hcd.c
>> @@ -809,15 +809,15 @@ static int vhci_urb_enqueue(struct usb_hcd *hcd, struct urb *urb, gfp_t mem_flag
>>   no_need_xmit:
>>   	usb_hcd_unlink_urb_from_ep(hcd, urb);
>>   no_need_unlink:
>> -	spin_unlock_irqrestore(&vhci->lock, flags);
>>   	if (!ret) {
>>   		/* usb_hcd_giveback_urb() should be called with
>>   		 * irqs disabled
>>   		 */
>> -		local_irq_disable();
>> +		spin_unlock(&vhci->lock);
>>   		usb_hcd_giveback_urb(hcd, urb, urb->status);
>> -		local_irq_enable();
>> +		spin_lock(&vhci->lock);
>>   	}
>> +	spin_unlock_irqrestore(&vhci->lock, flags);
>>   	return ret;
>>   }
> 
> This looks right to me; it's the same pattern that the other host
> controller drivers use.  However, the final decision is up to the usbip
> maintainers.
> 
> Also, there are several other places in the usbip drivers where
> usb_hcd_giveback_urb() gets called; shouldn't they all be changed to
> follow this pattern?
> 

Looks good to me.
+1 on changing all other instances - can we do that?

thanks,
-- Shuah

