Return-Path: <linux-kernel+bounces-836932-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EC22BAAEA2
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 03:49:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C7BEE4E1410
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 01:49:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A3A314F121;
	Tue, 30 Sep 2025 01:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VENu9R5T"
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 167EB54654
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 01:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759196955; cv=none; b=tY0RExsbj9LcZQPo+H95dcyr7J1nHlAb3yCNqu9MFlJ71WMjU9p6vRBSycte5P5Y4FUc94k/Hsc3hd/tcQ0yT6ZTAdxq0xNlvz/XeqjPZr7gWoDFg8vZDnyAslqZzGzJjI/u3hh3IybgykIiHS2OgELSUo0QNxwSihN802OdeSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759196955; c=relaxed/simple;
	bh=tDBBezcPYlp7FmqilK/rpFOYzXgomJ6GsoGy48Fxknc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Zv1xcEXgmDJ6OAqYP5PEwE+DDRwn75U5Wunt1xDi7eSDh6WMBRO9pKMaYAwdHbjgnyDiBn6vCQQNk8Sis17syNpAJFpcMXFsmiE4kSDCFQbmLQwXnaYMbRiRRjXrQz09vSbYirvZE4Qbt+Cy2cxmDBMBLAwBLxSX3BuT+bF2HgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VENu9R5T; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-b550eff972eso3559539a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 18:49:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759196953; x=1759801753; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=s95NyL2H6y5qz+puhM9dU0vSSqG26p81gIOvv61Fd4I=;
        b=VENu9R5TS0L0rJoHqJHQNnF9BYN5p4MgfEWaj4E02tCNQ7erB9cQyHQ1BziJlCE5Lv
         We6MWI6VvkHzOilOHUiS54ujweABhSFy+azDLV5AvnXVtOkEXEZWAfWazFqkcCwyIaeo
         mUXWxyUn8eT5GCsi7x9FKC7K8KvDmmCiDZ50ueCuif6vvSvoB4eMmDIkVgRgfcj5+acm
         ifDLvBfSkPBq9lPiC/bvHqF63QOLgB8+R4eKtwWeV9xovK04FL2C9kl9LmFUQZmiNBQ3
         8Xnndgw7iU0CyT/dSjNsnv6xVHRyiiA7R8g+FakxhKyxJucB9DdDgU439d0gdah5hXvr
         s38Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759196953; x=1759801753;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s95NyL2H6y5qz+puhM9dU0vSSqG26p81gIOvv61Fd4I=;
        b=WEYZMdkIzWfKAiG+Ev8G90S4/uM3X5Ex2nmnDi/aABVHRAIdSAkaGn4x69cOQFKRtz
         DDTfYKIuH9ovKDzQY+i1BDId7turBcc/QObWxl6GLyah/Rn27XDxzHu2LqlWxlxYtIJn
         VApT1IIEzhJg07QlHEMelLYsMtrPnYQR7lCppVFzz4Yb42RT/pUV6dOIuow5z0jDpK0W
         tb3n1V5aWM9+6qR01hU89sFzJphCnU8fcg4JNHEGzt1+ekFdjtjrssTXqY+Ayd0ajDYp
         MsLoO6m5iGKTkYW7BeiTACW1UyLdXjxunsQJ/t6+/uwkJxV2jDivn/ahbVIK8x9dIn0a
         giLw==
X-Forwarded-Encrypted: i=1; AJvYcCXYueskOCxovAa6amPz6HHtIaLXJaALHdnnYDGGmQIuWWDacxy+ntCPJf0y4fWGWf8FnU6OMIUXAJMRDeE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTvjFxGrQ8ouX1tbP9ssag/EeZAN2IE8mEgivP4nBhdzo74d52
	nu9Hfm9ULb+WO22CENk2dr9jkE1JpsV2uaJEjEyjT7mzZzWYtAfmGUki
X-Gm-Gg: ASbGncvmSFnDraY4VJH1nUqqM0u0lvtvAc1wZfrsvH18vZn9oMu0dOKRsQZf4DRxNPB
	k2ICYOF+OJ7+wdDh+YUc0mx0SuwZNww5nbodkJjOm9NhgY2UtSPd4asF1kpicA5Oosa9bzNyfls
	YZ28Kh1MloyEtN+ljbFQXuAtCiJTer5+O9xUdBLi9yq7Ya8KA9mnrhr6IwM3GIoK+7jW/kY5e8F
	IdWm3ZqaGaWfz24jDV7ql/rb17wNohRxwitGWaEkOuXteou0Lf7MiIPW9/Tdtk5gGmzb/1N5QeY
	sNW8CtVPi9POIJ1SZLvA9bo1wp1Xo80GBY/9qFobTL7Dkx9JSEe2Vo6ufhGfr4vhjQ78wWx5Wmq
	FJ/bXIc5syccHgj4nZMVbEKe611OVumDXTl6eOsmYNGWu8kHOFn2OvfMonGvqv+L2qcht/qRdF0
	R3q4Q5VA==
X-Google-Smtp-Source: AGHT+IHzKvtC312CNJHcPe3ofw05o8d9J5ChUEJRc4azx7isiQPUjOFoLRuYybPURIbTEG+xme86tQ==
X-Received: by 2002:a17:903:1b63:b0:269:a4ed:13c3 with SMTP id d9443c01a7336-27ed49df688mr248573895ad.5.1759196953248;
        Mon, 29 Sep 2025 18:49:13 -0700 (PDT)
Received: from [10.0.2.15] ([157.50.103.22])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed6702cf9sm142315065ad.38.2025.09.29.18.49.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Sep 2025 18:49:12 -0700 (PDT)
Message-ID: <6d6d18be-69ab-41f0-bae5-db7d0a12196d@gmail.com>
Date: Tue, 30 Sep 2025 07:19:06 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI: endpoint: pci-epf-test: Fix sleeping function being
 called from atomic context
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Kishon Vijay Abraham I <kishon@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Petr Mladek <pmladek@suse.com>,
 Tejun Heo <tj@kernel.org>, Miri Korenblit
 <miriam.rachel.korenblit@intel.com>, Frank Li <Frank.Li@nxp.com>,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kernel-mentees@lists.linux.dev, skhan@linuxfoundation.org
References: <20250917161817.15776-1-bhanuseshukumar@gmail.com>
 <te2mzunvwphcoiypwdb6oee3m54jquxk4br6f4tjxlp625whbr@kzzhai5eg2xv>
Content-Language: en-US
From: bhanuseshukumar <bhanuseshukumar@gmail.com>
In-Reply-To: <te2mzunvwphcoiypwdb6oee3m54jquxk4br6f4tjxlp625whbr@kzzhai5eg2xv>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 29/09/25 23:23, Manivannan Sadhasivam wrote:
> On Wed, Sep 17, 2025 at 09:48:17PM +0530, Bhanu Seshu Kumar Valluri wrote:
>> When Root Complex(RC) triggers a Doorbell MSI interrupt to Endpoint(EP) it triggers a warning
>> in the EP. pci_endpoint kselftest target is compiled and used to run the Doorbell test in RC.
>>
>> [  474.686193] BUG: sleeping function called from invalid context at kernel/locking/mutex.c:271
>> [  474.694656] in_atomic(): 1, irqs_disabled(): 1, non_block: 0, pid: 0, name: swapper/0
>> [  474.702473] preempt_count: 10001, expected: 0
>> [  474.706819] RCU nest depth: 0, expected: 0
>> [  474.710913] CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Not tainted 6.17.0-rc5-g7aac71907bde #12 PREEMPT
>> [  474.710926] Hardware name: Texas Instruments AM642 EVM (DT)
>> [  474.710934] Call trace:
>> [  474.710940]  show_stack+0x20/0x38 (C)
>> [  474.710969]  dump_stack_lvl+0x70/0x88
>> [  474.710984]  dump_stack+0x18/0x28
>> [  474.710995]  __might_resched+0x130/0x158
>> [  474.711011]  __might_sleep+0x70/0x88
>> [  474.711023]  mutex_lock+0x2c/0x80
>> [  474.711036]  pci_epc_get_msi+0x78/0xd8
>> [  474.711052]  pci_epf_test_raise_irq.isra.0+0x74/0x138
>> [  474.711063]  pci_epf_test_doorbell_handler+0x34/0x50
>> [  474.711072]  __handle_irq_event_percpu+0xac/0x1f0
>> [  474.711086]  handle_irq_event+0x54/0xb8
>> [  474.711096]  handle_fasteoi_irq+0x150/0x220
>> [  474.711110]  handle_irq_desc+0x48/0x68
>> [  474.711121]  generic_handle_domain_irq+0x24/0x38
>> [  474.711131]  gic_handle_irq+0x4c/0xc8
>> [  474.711141]  call_on_irq_stack+0x30/0x70
>> [  474.711151]  do_interrupt_handler+0x70/0x98
>> [  474.711163]  el1_interrupt+0x34/0x68
>> [  474.711176]  el1h_64_irq_handler+0x18/0x28
>> [  474.711189]  el1h_64_irq+0x6c/0x70
>> [  474.711198]  default_idle_call+0x10c/0x120 (P)
>> [  474.711208]  do_idle+0x128/0x268
>> [  474.711220]  cpu_startup_entry+0x3c/0x48
>> [  474.711231]  rest_init+0xe0/0xe8
>> [  474.711240]  start_kernel+0x6d4/0x760
>> [  474.711255]  __primary_switched+0x88/0x98
>>
> 
> You do not need to use full call trace. Refer:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?h=v6.17#n761
> 
>> Warnings can be reproduced by following steps below.
>> *On EP side:
>> 1. Configure the pci-epf-test function using steps given below
>>    mount -t configfs none /sys/kernel/config
>>    cd /sys/kernel/config/pci_ep/
>>    mkdir functions/pci_epf_test/func1
>>    echo 0x104c > functions/pci_epf_test/func1/vendorid
>>    echo 0xb010 > functions/pci_epf_test/func1/deviceid
>>    echo 32 > functions/pci_epf_test/func1/msi_interrupts
>>    echo 2048 > functions/pci_epf_test/func1/msix_interrupts
>>    ln -s functions/pci_epf_test/func1 controllers/f102000.pcie-ep/
>>    echo 1 > controllers/f102000.pcie-ep/start
>>
>> *On RC side:
>> 1. Once EP side configuration is done do pci rescan.
>>    echo 1 > /sys/bus/pci/rescan
>> 2. Run Doorbell MSI test using pci_endpoint_test kselftest app.
>>   ./pci_endpoint_test -r pcie_ep_doorbell.DOORBELL_TEST
> 
> This info is already part of the kernel documentation. So it is redundant here.
> It could be probably added in the comment section (where you added the Note).
> 
>>   Note: Kernel is compiled with CONFIG_DEBUG_KERNEL enabled.
>>
>> The BUG arises because the EP's Doorbell MSI hard interrupt handler is making an
>> indirect call to pci_epc_get_msi, which uses mutex inside, from interrupt context.
>>
>> This patch converts hard irq handler to a threaded irq handler to allow it
>> to call functions that can sleep during bottom half execution. The threaded
>> irq handler is registered with IRQF_ONESHOT and keeps interrupt line disabled
>> until the threaded irq handler completes execution.
>>
>> Fixes: eff0c286aa916221a69126 ("PCI: endpoint: pci-epf-test: Add doorbell test support")
> 
> Use 12 char commit SHA.
> 
>> -static irqreturn_t pci_epf_test_doorbell_handler(int irq, void *data)
>> +static irqreturn_t pci_epf_test_doorbell_irq_thread(int irq, void *data)
> 
> No need to change the function name.

Thank you Mani for your helpful comments on the patch. I will send a v2 patch to address above review comments.

-Bhanu Seshu Kumar Valluri


