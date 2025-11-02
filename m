Return-Path: <linux-kernel+bounces-881938-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 18AC9C2944E
	for <lists+linux-kernel@lfdr.de>; Sun, 02 Nov 2025 18:54:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 976D23A71AC
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Nov 2025 17:54:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E83221B1BC;
	Sun,  2 Nov 2025 17:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EmUXQoX6"
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D075128819
	for <linux-kernel@vger.kernel.org>; Sun,  2 Nov 2025 17:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762106038; cv=none; b=pd5t88XOIjVHncGFzeIXzAC/g0ROcN+n5j06Cxn99ZB9PNhlTZbXaiRPf/b3RQpwaSfY8lwM6Y5BG6NPG5IWj9DeKg1zG3Jp18gKTP77MExZkbQzXd01nzx147fuyHPRWB1EzfIxE32fsHcq44DwmqmVr//MDlaB/fyeHfCOgOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762106038; c=relaxed/simple;
	bh=hSN9QeULJIG/N1VKpn8Fge1G8WgCsbC/Si6SdehOt0U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fPCtKnfMl5US1z9faKdj2fVq0njHPa8HlMQqPDVl5jYTGcLmsV9I7Shp2RfcTzLXLfzUgAs8VkXpaLzO+8Y6gFHoThK6nY/VDCHxS2ibfnukG0swx5nRkmrrFfJxm1zTOodf2sHks8qCVU5jY2bvOdB0BMWMB4WHEese/8BL368=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EmUXQoX6; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-b98983bae80so461186a12.0
        for <linux-kernel@vger.kernel.org>; Sun, 02 Nov 2025 09:53:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762106035; x=1762710835; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=IfJHdPhbP2WBePsO4xmIC0qOMXrninjFm/OpgG5WwJU=;
        b=EmUXQoX6O+yDNVHL5pxmkx1RN+Ug2id95F2K3JDbV1q9hOm5+wgODbuncwWUQ4lVQy
         j+3Ni3MYpKBxlihK22tyUgVy7OBTm1SvGbIXXEGYUyAxJWMQvMqZZQRCfoBolUSsq03H
         Eq5+m6cbog2jqknYOKo5AYIaqnxo9p6ZYMvxGwpdSAtAViqaHJo0C0Zwss3TssLuIjZb
         ixCQp/KPiPKZBfg4Kzp6+eb/2zXcUYVjYpM7lkgIcEZ4J6Uz2WJl5m8vLLNAmt8m3eiG
         +RdjcERSqC7RgTKqxc8CO27GBreiriLfUy7PiiVLvRWFHRqMXrin7p9zsDoYgtizorJF
         enWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762106035; x=1762710835;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IfJHdPhbP2WBePsO4xmIC0qOMXrninjFm/OpgG5WwJU=;
        b=OSPyCB3VlfysPXugTrOeJk9BzUvRl9HY4RSgpeAsvSfgqUboKggGNT8a0cR8KDcOL3
         T9Vkl48CmjgVvSfdAfus9rMTwEySki6PURz1Jge473UbL616ShU6J6dUdZkB/t8YI4Ik
         YkeNgtQkZUrMhwII3PzD8rCq4sjjgq0gb87vFRqpfSFLeWOJozAQSCDzqoY7jOO7G4jg
         FMLtvuc15BJqoSbtS5f3ZbsQOdpgU3WD8NmjFKhXwxikYPVyPfDMTej3K5yLBkPYpHOp
         VqssrZ8PodxPDlkklVaiGlK1GzdzW106C+kAYxOVtkUbwlxuSIFAop02TarALhEfejDp
         IJ8w==
X-Forwarded-Encrypted: i=1; AJvYcCUbo4W00zUwybjg5lfxOHDNU3sdcHcJh3A95IVMXX9exxYQV6OF5un3oVuvje3NI8bFErUMQvmJbUJ2spo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzozRxKFJaNYD7NM7sit70KVuxOEToYu4TgnmiGc/bvLZ28lZip
	dXRknJcR9QJtg+mr7WVgXHX/OBKqbPwMgc4fSR/xH+MGdzBPFUj1Rkwa
X-Gm-Gg: ASbGnctpG84tV3/pAO4cWRcHvDnjO0xvEW/PFpGwWBWNAlGK1kseP0nFaQdBvMg6NTK
	08tffwdUiJHqiNKs1KwjQbs8AfYnJVt23mKeojtOexhll0wkWB0z6BaPSVxglaMPXS5eQEWyoBl
	c/4nhFfdgS+bzPIB1AV2lRcX7nXy5adTjfOOAPQywOYb7HNLS9SiK0Gjt5t4k61J+fr8y/9TS0B
	NnEW4qdIj07TL730KVrxAnfTrST6m5u050YIqSlHikRi970RVC3AYpclKXn0SyqlunmwBvgetPO
	0MEWYwa4hcGpMB5orm9AtZrwuhwLr9f79adWlpRavvzAzQjWXu5BVccEZlRNu2iT/e7BweX10O8
	PFhEgdK7CE7YGN7JDlKJ4RqW6Sq0R+R2IohnLAoRqZOyghlDX7A3a45fCGHAOfxXl75Xj6N+0tR
	1wHNU/8RIWpgKTMQ5CsumMNKGPJI23X6MSeIoclcz2rYWUkrON
X-Google-Smtp-Source: AGHT+IHrl5E2v6vxaiMK0TNW1XHgxAV/kXko677RL/q1623vUdR+CHe0Ccw+8EDMlnT1Ejo4ZMUkBw==
X-Received: by 2002:a17:902:f60c:b0:295:9cb5:ae07 with SMTP id d9443c01a7336-2959cb5b093mr24104155ad.38.1762106035488;
        Sun, 02 Nov 2025 09:53:55 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2953e6835a3sm75036735ad.28.2025.11.02.09.53.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 02 Nov 2025 09:53:55 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <77129f40-2da6-4463-b06f-4c6d38135fed@roeck-us.net>
Date: Sun, 2 Nov 2025 09:53:53 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [char-misc-next] mei: hook mei_device on class device
To: "Usyskin, Alexander" <alexander.usyskin@intel.com>
Cc: =?UTF-8?Q?Marek_Marczykowski-G=C3=B3recki?=
 <marmarek@invisiblethingslab.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Abliyev, Reuven" <reuven.abliyev@intel.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20250826125617.1166546-1-alexander.usyskin@intel.com>
 <8deef7c4-ac75-4db8-91b7-02cf0e39e371@roeck-us.net>
 <CY5PR11MB6366B9836B306AD2A72BDDFEEDC6A@CY5PR11MB6366.namprd11.prod.outlook.com>
 <CABXOdTfOfrjP40DhZaqcXXUs0PbEZwv=qcZu=k=TwaRgMhFS_g@mail.gmail.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <CABXOdTfOfrjP40DhZaqcXXUs0PbEZwv=qcZu=k=TwaRgMhFS_g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11/2/25 07:37, Guenter Roeck wrote:
> On Sun, Nov 2, 2025 at 7:00 AM Usyskin, Alexander <linux@roeck-us.net> wrote:

That got messed up. Sorry for that. Really sending to Alexander this time.

Guenter

> ...
>>
>> Seems I've missed the error flow in probe (my test machines always have an ME in a good state...).
>>
>> Below patch should fix the problem, can you confirm?
>>
> Yes, it does. With this patch applied, the log output is:
> 
> ...
> [   16.406790] mtdoops: mtd device (mtddev=name/number) must be supplied
> [   18.380400] mei mei0: wait hw ready failed
> [   18.384594] mei mei0: hw_start failed ret = -62 fw status =
> 00070355 002F0006 00000000 00000000 00000000 00000000
> [   20.428395] mei mei0: wait hw ready failed
> [   20.432542] mei mei0: hw_start failed ret = -62 fw status =
> 00070355 002F0006 00000000 00000000 00000000 00000000
> [   22.476390] mei mei0: wait hw ready failed
> [   22.480533] mei mei0: hw_start failed ret = -62 fw status =
> 00070355 002F0006 00000000 00000000 00000000 00000000
> [   22.490847] mei mei0: reset: reached maximal consecutive resets:
> disabling the device
> [   22.498718] mei mei0: reset failed ret = -19
> [   22.503012] mei mei0: link layer initialization failed.
> [   22.508261] mei_me 0000:00:16.0: init hw failure.
> [   22.513662] mei_me 0000:00:16.0: initialization failed.
> initramfs(out): Mounting system filesystems for initramfs init.d
> ...
> 
> Official Tested-by: tag below. Note that it is from my Google address
> since this is where I tested the fix.
> 
>   Thanks a lot for the quick turnaround!
> 
> Guenter
> 
>>  From c58f311df60f26df2efe1e0f9fc523bfa4b93936 Mon Sep 17 00:00:00 2001
>> From: Alexander Usyskin <alexander.usyskin@intel.com>
>> Date: Sun, 2 Nov 2025 10:57:22 +0200
>> Subject: [PATCH] mei: fix error flow in probe
>> MIME-Version: 1.0
>> Content-Type: text/plain; charset=UTF-8
>> Content-Transfer-Encoding: 8bit
>>
>> Dismantle class device last in probe error flow to avoid accessing freed memory like:
>>
>> [   87.926774] WARNING: CPU: 9 PID: 518 at kernel/workqueue.c:4234
>> __flush_work+0x340/0x390
>> ...
>> [   87.926912] Workqueue: async async_run_entry_fn
>> [   87.926918] RIP: e030:__flush_work+0x340/0x390
>> [   87.926923] Code: 26 9d 05 00 65 48 8b 15 26 3c ca 02 48 85 db 48 8b
>> 04 24 48 89 54 24 58 0f 85 de fe ff ff e9 f6 fd ff ff 0f 0b e9 77 ff ff
>> ff <0f> 0b e9 70 ff ff ff 0f 0b e9 19 ff ff ff e8 7d 8b 0e 01 48 89 de
>> [   87.926931] RSP: e02b:ffffc900412ebc00 EFLAGS: 00010246
>> [   87.926936] RAX: 0000000000000000 RBX: ffff888103e55090 RCX: 0000000000000000
>> [   87.926941] RDX: 000fffffffe00000 RSI: 0000000000000001 RDI: ffffc900412ebc60
>> [   87.926945] RBP: ffff888103e55090 R08: ffffffffc1266ec8 R09: ffff8881109076e8
>> [   87.926949] R10: 0000000080040003 R11: 0000000000000000 R12: ffff888103e54000
>> [   87.926953] R13: ffffc900412ebc18 R14: 0000000000000001 R15: 0000000000000000
>> [   87.926962] FS:  0000000000000000(0000) GS:ffff888233238000(0000) knlGS:0000000000000000
>> [   87.926967] CS:  e030 DS: 0000 ES: 0000 CR0: 0000000080050033
>> [   87.926971] CR2: 00007e7923b32708 CR3: 00000001088df000 CR4: 0000000000050660
>> [   87.926977] Call Trace:
>> [   87.926981]  <TASK>
>> [   87.926987]  ? __call_rcu_common.constprop.0+0x11e/0x310
>> [   87.926993]  cancel_work_sync+0x5e/0x80
>> [   87.926999]  mei_cancel_work+0x19/0x40 [mei]
>> [   87.927051]  mei_me_probe+0x273/0x2b0 [mei_me]
>> [   87.927060]  local_pci_probe+0x45/0x90
>> [   87.927066]  pci_call_probe+0x5b/0x180
>> [   87.927070]  pci_device_probe+0x95/0x140
>> [   87.927074]  ? driver_sysfs_add+0x57/0xc0
>> [   87.927079]  really_probe+0xde/0x340
>> [   87.927083]  ? pm_runtime_barrier+0x54/0x90
>> [   87.927087]  __driver_probe_device+0x78/0x110
>> [   87.927092]  driver_probe_device+0x1f/0xa0
>> [   87.927095]  __driver_attach_async_helper+0x5e/0xe0
>> [   87.927100]  async_run_entry_fn+0x34/0x130
>> [   87.927104]  process_one_work+0x18d/0x340
>> [   87.927108]  worker_thread+0x256/0x3a0
>> [   87.927111]  ? __pfx_worker_thread+0x10/0x10
>> [   87.927115]  kthread+0xfc/0x240
>> [   87.927120]  ? __pfx_kthread+0x10/0x10
>> [   87.927124]  ? __pfx_kthread+0x10/0x10
>> [   87.927127]  ret_from_fork+0xf5/0x110
>> [   87.927132]  ? __pfx_kthread+0x10/0x10
>> [   87.927136]  ret_from_fork_asm+0x1a/0x30
>> [   87.927141]  </TASK>
>>
>> Reported-by: Marek Marczykowski-Górecki <marmarek@invisiblethingslab.com>
>> Reported-by: Guenter Roeck <linux@roeck-us.net>
>> Fixes: 7704e6be4ed2 ("mei: hook mei_device on class device")
>> Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
> 
> Tested-by: Guenter Roeck <groeck@google.com>
> 
>>
>> ---
>>   drivers/misc/mei/pci-me.c       | 13 ++++++-------
>>   drivers/misc/mei/pci-txe.c      | 13 ++++++-------
>>   drivers/misc/mei/platform-vsc.c | 11 +++++------
>>   3 files changed, 17 insertions(+), 20 deletions(-)
>>
>> diff --git a/drivers/misc/mei/pci-me.c b/drivers/misc/mei/pci-me.c
>> index b017ff29dbd1..73cad914be9f 100644
>> --- a/drivers/misc/mei/pci-me.c
>> +++ b/drivers/misc/mei/pci-me.c
>> @@ -223,6 +223,10 @@ static int mei_me_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
>>          hw->mem_addr = pcim_iomap_table(pdev)[0];
>>          hw->read_fws = mei_me_read_fws;
>>
>> +       err = mei_register(dev, &pdev->dev);
>> +       if (err)
>> +               goto end;
>> +
>>          pci_enable_msi(pdev);
>>
>>          hw->irq = pdev->irq;
>> @@ -237,13 +241,9 @@ static int mei_me_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
>>          if (err) {
>>                  dev_err(&pdev->dev, "request_threaded_irq failure. irq = %d\n",
>>                         pdev->irq);
>> -               goto end;
>> +               goto deregister;
>>          }
>>
>> -       err = mei_register(dev, &pdev->dev);
>> -       if (err)
>> -               goto release_irq;
>> -
>>          if (mei_start(dev)) {
>>                  dev_err(&pdev->dev, "init hw failure.\n");
>>                  err = -ENODEV;
>> @@ -283,11 +283,10 @@ static int mei_me_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
>>          return 0;
>>
>>   deregister:
>> -       mei_deregister(dev);
>> -release_irq:
>>          mei_cancel_work(dev);
>>          mei_disable_interrupts(dev);
>>          free_irq(pdev->irq, dev);
>> +       mei_deregister(dev);
>>   end:
>>          dev_err(&pdev->dev, "initialization failed.\n");
>>          return err;
>> diff --git a/drivers/misc/mei/pci-txe.c b/drivers/misc/mei/pci-txe.c
>> index 06b55a891c6b..98d1bc2c7f4b 100644
>> --- a/drivers/misc/mei/pci-txe.c
>> +++ b/drivers/misc/mei/pci-txe.c
>> @@ -87,6 +87,10 @@ static int mei_txe_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
>>          hw = to_txe_hw(dev);
>>          hw->mem_addr = pcim_iomap_table(pdev);
>>
>> +       err = mei_register(dev, &pdev->dev);
>> +       if (err)
>> +               goto end;
>> +
>>          pci_enable_msi(pdev);
>>
>>          /* clear spurious interrupts */
>> @@ -106,13 +110,9 @@ static int mei_txe_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
>>          if (err) {
>>                  dev_err(&pdev->dev, "mei: request_threaded_irq failure. irq = %d\n",
>>                          pdev->irq);
>> -               goto end;
>> +               goto deregister;
>>          }
>>
>> -       err = mei_register(dev, &pdev->dev);
>> -       if (err)
>> -               goto release_irq;
>> -
>>          if (mei_start(dev)) {
>>                  dev_err(&pdev->dev, "init hw failure.\n");
>>                  err = -ENODEV;
>> @@ -145,11 +145,10 @@ static int mei_txe_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
>>          return 0;
>>
>>   deregister:
>> -       mei_deregister(dev);
>> -release_irq:
>>          mei_cancel_work(dev);
>>          mei_disable_interrupts(dev);
>>          free_irq(pdev->irq, dev);
>> +       mei_deregister(dev);
>>   end:
>>          dev_err(&pdev->dev, "initialization failed.\n");
>>          return err;
>> diff --git a/drivers/misc/mei/platform-vsc.c b/drivers/misc/mei/platform-vsc.c
>> index 288e7b72e942..9787b9cee71c 100644
>> --- a/drivers/misc/mei/platform-vsc.c
>> +++ b/drivers/misc/mei/platform-vsc.c
>> @@ -362,28 +362,27 @@ static int mei_vsc_probe(struct platform_device *pdev)
>>
>>          ret = mei_register(mei_dev, dev);
>>          if (ret)
>> -               goto err_dereg;
>> +               goto err;
>>
>>          ret = mei_start(mei_dev);
>>          if (ret) {
>>                  dev_err_probe(dev, ret, "init hw failed\n");
>> -               goto err_cancel;
>> +               goto err;
>>          }
>>
>>          pm_runtime_enable(mei_dev->parent);
>>
>>          return 0;
>>
>> -err_dereg:
>> -       mei_deregister(mei_dev);
>> -
>> -err_cancel:
>> +err:
>>          mei_cancel_work(mei_dev);
>>
>>          vsc_tp_register_event_cb(tp, NULL, NULL);
>>
>>          mei_disable_interrupts(mei_dev);
>>
>> +       mei_deregister(mei_dev);
>> +
>>          return ret;
>>   }
>>
>> --
>> 2.43.0
>>
>>
>>
>>


