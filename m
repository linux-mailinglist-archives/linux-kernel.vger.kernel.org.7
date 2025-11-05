Return-Path: <linux-kernel+bounces-886260-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F9F7C351C0
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 11:33:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B8A554E0F13
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 10:33:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D08F302CDC;
	Wed,  5 Nov 2025 10:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b="P06Viwhx"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 600601EA7FF
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 10:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762338800; cv=none; b=hniSOQjv10j4K0byzqGxqDbPQXMRKSzF3N2ephpMVhgbpma1G5UC0+BPfHRCf1e2zDCQCzzjiTXm9nySBvSa+zgQdhJbCw6O44ywm5k9nCMeOvn1b+h4Je7/Zf9hXK9VPMFs+gR5M0NkEvyHrUKiEdA3hjJ8M79WkxCzyuDE1D0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762338800; c=relaxed/simple;
	bh=c9wuqi0SxrCAjffdVwW0x2qZQdlD0QG6wYx0WrPTSoE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oP2W/g5nRabP8UM+67gv2nyQOpWDUlABm4bRZ9g/tJf1VeTYyxPUb76YXQJ7gLH+dkHFiXHM3GSuy58ktYlygnpXVequgmZ/B5HkVZZ8fWn+Ho/ckjKu5EaLDD9qkUoAzG5yms+ZQrs86jN6IsIXTlThQiWsx8MxrzvDkPceXMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b=P06Viwhx; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-29555415c5fso55013265ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 02:33:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc.com; s=google; t=1762338797; x=1762943597; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=39uIckh4SoWr03ZIJh4ib+/wvpmKdVIU8qgMasnqseQ=;
        b=P06ViwhxEkb+P8pd2RycSh64aYTigXKRQTHOjrDc4aEeQqL+Tm/hC+ycmX/FzdOFNl
         kWoaMeClgm02WuehoZFRUA4+E35gFU+EvYX0r6n0HoqecjNaxwg4PC50THW8++3exss7
         xr1N5iOFrAsipDK+IiQbII0VARIQd2PTHo0h7SwIPi7cDWKE9IdUaNIsQKlTvGP1IxqW
         MpT2pltPwP4bgqjPu2fyf4M8XouKLIgrpXU2JRbgmvs/jwyAcV/u2gg3/lepOHpJ/lKO
         rg8eBGg9I3ey5BkZoVl3i4yaB20B8TWPIS6of8KZ9crn859WqyVTceOoXxgnshsOyKjD
         YBjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762338797; x=1762943597;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=39uIckh4SoWr03ZIJh4ib+/wvpmKdVIU8qgMasnqseQ=;
        b=crXAsfcFAhCCUH96nT7Vwpd/sBXW9zXVKRUV71hUL6CK8KWOe29DTozO/9MjE9xRqc
         kYFz1RTa14dzEFFdS0bH+mS9JkO9lfBxCni9t5IBvyDLkAOrsQEDcL5P1RHhEy8+lkOv
         3YgXYyEiz0m4gQpV6ZpD4Wlv8JPrR3yHN6At2MWLJNaMqwLuXnnY4WpI5N4D/Ie7LpR0
         72+PNrK4+RlXhHB9pUx3Ywlif60yMvufhXgvUteGVilo9cbb/7Ddsrhia71ghcHBQfHo
         efHZ0Ix0ZIdBnS3FnWY2kebF7dyJGLrEm+c+TAdtGy3EpLiFX9JB+y8H8AVwl7BKOZIp
         dWZQ==
X-Forwarded-Encrypted: i=1; AJvYcCXrdvY1WQq1zbzRBmh1se6sd+0nYEIgPmvb2xLQwMEx8+LF/tUO5cYsR71ZVI5LQn8r07LHkybk+U0nNa4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxI4UVoyZJUmnjzO0qyx02f5/GtcY8glf/Ajtr8JArSWtaxC1sV
	BH5FKe9LPBQEZTZ9FHtwFTEOytl8Q9ShuxmlPr91IBxHAMYYVnI7XfZKZ3XJOyViG98=
X-Gm-Gg: ASbGncvztQiq0DIc5oW7fFh80eeHlLfcNQ+dE3n9M7Gf8ITrwr/1M3tmvR6u6/bKCmP
	eeU/FalXgz8VpjVtAcsji7uMj8vFpK86Syz2V6l0/gXK+26CqUy9DUldATSVFWr32hgqBvWDrSS
	9bvj5HlaZEzJLISYOnxWSWl83TPN4m91Yc74pxvvclDPClCUUihzhGULfel9xtctDRXLEg7BEzi
	f6BpDt1MHZzMy//QA6cvGztvGhaOrCIVia4ki9jgTy51r4bDkPPWfKWbaByuUAbG5EfiVFiZ1Yn
	T1gPY2vITPVKf9IGBxKxXRMyMYLaAIMQ4fShMjJAYfrIgZEMDMneBdD0FBdWlaFnbSSoyJd8xXj
	CpPYEJMjytjeMdLniYCNSnJ407nEA5ky+JPY+nAR3UjkQ5gmYcwFZ8WlWzcCJBe+E+8EKwfNcH4
	LlcxHVb1JkVGlTTNJqMbeO0jbZjkDAAXfL4nyEsjg0L6BlFQ==
X-Google-Smtp-Source: AGHT+IHdw/96/OCAC1Nx+H3pSqIGsf399zmz5OwGHSCzXvqg9BWyA4UoKggLFqHvpU21yZ0+LgXqjw==
X-Received: by 2002:a17:902:e54e:b0:295:8db9:3059 with SMTP id d9443c01a7336-2962ada1d5fmr42185075ad.38.1762338796647;
        Wed, 05 Nov 2025 02:33:16 -0800 (PST)
Received: from ?IPV6:2a01:e0a:e17:9700:16d2:7456:6634:9626? ([2a01:e0a:e17:9700:16d2:7456:6634:9626])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29601a60761sm55885165ad.90.2025.11.05.02.33.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Nov 2025 02:33:15 -0800 (PST)
Message-ID: <7b267b11-a204-447e-afc6-86722518cf58@rivosinc.com>
Date: Wed, 5 Nov 2025 11:33:04 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 06/10] riscv: Add functions to register ghes having
 SSE notification
To: Himanshu Chauhan <hchauhan@ventanamicro.com>,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-acpi@vger.kernel.org, linux-efi@vger.kernel.org,
 acpica-devel@lists.linux.dev
Cc: paul.walmsley@sifive.com, palmer@dabbelt.com, lenb@kernel.org,
 james.morse@arm.com, tony.luck@intel.com, ardb@kernel.org, conor@kernel.org,
 robert.moore@intel.com, sunilvl@ventanamicro.com, apatel@ventanamicro.com
References: <20251029112649.3811657-1-hchauhan@ventanamicro.com>
 <20251029112649.3811657-7-hchauhan@ventanamicro.com>
Content-Language: en-US
From: =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>
In-Reply-To: <20251029112649.3811657-7-hchauhan@ventanamicro.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/29/25 12:26, Himanshu Chauhan wrote:
> Add functions to register the ghes entries which have SSE as
> notification type. The vector inside the ghes is the SSE event
> ID that should be registered.
> 
> Signed-off-by: Himanshu Chauhan <hchauhan@ventanamicro.com>
> ---
>  drivers/firmware/riscv/riscv_sbi_sse.c | 147 +++++++++++++++++++++++++
>  include/linux/riscv_sbi_sse.h          |  16 +++
>  2 files changed, 163 insertions(+)
> 
> diff --git a/drivers/firmware/riscv/riscv_sbi_sse.c b/drivers/firmware/riscv/riscv_sbi_sse.c
> index 6561c7acdaaa..46ebc9e9651c 100644
> --- a/drivers/firmware/riscv/riscv_sbi_sse.c
> +++ b/drivers/firmware/riscv/riscv_sbi_sse.c
> @@ -5,6 +5,8 @@
>  
>  #define pr_fmt(fmt) "sse: " fmt
>  
> +#include <acpi/ghes.h>
> +#include <linux/acpi.h>
>  #include <linux/cpu.h>
>  #include <linux/cpuhotplug.h>
>  #include <linux/cpu_pm.h>
> @@ -700,3 +702,148 @@ static int __init sse_init(void)
>  	return ret;
>  }
>  arch_initcall(sse_init);
> +
> +struct sse_ghes_callback {
> +	struct list_head head;
> +	struct ghes *ghes;
> +	sse_event_handler_fn *callback;
> +};
> +
> +struct sse_ghes_event_data {
> +	struct list_head head;
> +	u32 event_num;
> +	struct list_head callback_list;
> +	struct sse_event *event;
> +};
> +
> +static DEFINE_SPINLOCK(sse_ghes_event_list_lock);
> +static LIST_HEAD(sse_ghes_event_list);

Hi Himanshu,

Please declare these structs/functions at the beggining of the file.

> +
> +static int sse_ghes_handler(u32 event_num, void *arg, struct pt_regs *regs)
> +{
> +	struct sse_ghes_event_data *ev_data = arg;
> +	struct sse_ghes_callback *cb = NULL;
> +
> +	list_for_each_entry(cb, &ev_data->callback_list, head) {
> +		if (cb && cb->ghes && cb->callback) {
> +			cb->callback(ev_data->event_num, cb->ghes, regs);
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +int sse_register_ghes(struct ghes *ghes, sse_event_handler_fn *lo_cb,
> +		      sse_event_handler_fn *hi_cb)
> +{
> +	struct sse_ghes_event_data *ev_data, *evd;
> +	struct sse_ghes_callback *cb;
> +	u32 ev_num;
> +	int err;
> +
> +	if (!sse_available)
> +		return -EOPNOTSUPP;
> +	if (!ghes || !lo_cb || !hi_cb)
> +		return -EINVAL;
> +
> +	ev_num = ghes->generic->notify.vector;
> +
> +	ev_data = NULL;
> +	spin_lock(&sse_ghes_event_list_lock);
> +	list_for_each_entry(evd, &sse_ghes_event_list, head) {
> +		if (evd->event_num == ev_num) {
> +			ev_data = evd;
> +			break;
> +		}
> +	}
> +	spin_unlock(&sse_ghes_event_list_lock);

That lock should cover the whole ev_data creation. Because if two CPUs
enters this function at the same time, the following scneario can occur:

   CPU0               CPU1
   lock
   ev_data = NULL
   unlock
                      lock
		      ev_data = NULL
                      unlock
	
   create ev_data     create ev_data

 -> Both will have read a ev_data = NULL and create an ev_data.

The lock should be kept and unlocked at the end of the function, you can
use a guard() for that.

> +
> +	if (!ev_data) {
> +		ev_data = kzalloc(sizeof(*ev_data), GFP_KERNEL);
> +		if (!ev_data)
> +			return -ENOMEM;
> +
> +		INIT_LIST_HEAD(&ev_data->head);

I think this isn't necessary since list_add_tail() will anyway overwrite
the head->next/prev field. BTW it's confusing to call this member head
since it will be used as a node in the list. It could probably be
renamed node/list.

> +		ev_data->event_num = ev_num;
> +
> +		INIT_LIST_HEAD(&ev_data->callback_list);
> +
> +		ev_data->event = sse_event_register(ev_num, ev_num,
> +						    sse_ghes_handler, ev_data);
> +		if (IS_ERR(ev_data->event)) {
> +			pr_err("%s: Couldn't register event 0x%x\n", __func__, ev_num);
> +			kfree(ev_data);
> +			return -ENOMEM;
> +		}
> +
> +		err = sse_event_enable(ev_data->event);
> +		if (err) {
> +			pr_err("%s: Couldn't enable event 0x%x\n", __func__, ev_num);
> +			sse_event_unregister(ev_data->event);
> +			kfree(ev_data);
> +			return err;
> +		}
> +
> +		spin_lock(&sse_ghes_event_list_lock);
> +		list_add_tail(&ev_data->head, &sse_ghes_event_list);
> +		spin_unlock(&sse_ghes_event_list_lock);
> +	}
> +
> +	list_for_each_entry(cb, &ev_data->callback_list, head) {
> +		if (cb->ghes == ghes)
> +			return -EALREADY;
> +	}
> +
> +	cb = kzalloc(sizeof(*cb), GFP_KERNEL);
> +	if (!cb)
> +		return -ENOMEM;
> +	INIT_LIST_HEAD(&cb->head);
> +	cb->ghes = ghes;
> +	cb->callback = lo_cb;
> +	list_add_tail(&cb->head, &ev_data->callback_list);

AFAIU, at this point, the SSE event is already enabled, it means the
sse_ghes_handler() can be called. This one can potentially access
&ev_data->callback_list concurrently which would result in a corrupted
list. You should mask/disable the SSE event while adding the callback to
this list.

BTW, accessing the ev_data->callback here means that if multiple CPUs
access this function at the same time, it could result in a corrupted
ev_data list. Not sure if it can happen but better be safe than sorry.

> +
> +	return 0;
> +}
> +
> +int sse_unregister_ghes(struct ghes *ghes)
> +{
> +	struct sse_ghes_event_data *ev_data, *tmp;
> +	struct sse_ghes_callback *cb;
> +	int free_ev_data = 0;
> +
> +	if (!ghes)
> +		return -EINVAL;
> +
> +	spin_lock(&sse_ghes_event_list_lock);
> +
> +	list_for_each_entry_safe(ev_data, tmp, &sse_ghes_event_list, head) {
> +		list_for_each_entry(cb, &ev_data->callback_list, head) {
> +			if (cb->ghes != ghes)
> +				continue;
> +
> +			list_del(&cb->head);
> +			kfree(cb);
> +			break;
> +		}
> +
> +		if (list_empty(&ev_data->callback_list))
> +			free_ev_data = 1;
> +
> +		if (free_ev_data) {

Remove free_ev_data and use the following:

		if (list_empty(&ev_data->callback_list)) {> +		
spin_unlock(&sse_ghes_event_list_lock);
> +
> +			sse_event_disable(ev_data->event);
> +			sse_event_unregister(ev_data->event);
> +			ev_data->event = NULL;
> +
> +			spin_lock(&sse_ghes_event_list_lock);
> +
> +			list_del(&ev_data->head);
> +			kfree(ev_data);
> +		}
> +	}
> +
> +	spin_unlock(&sse_ghes_event_list_lock);
> +
> +	return 0;
> +}

Please declare this above the arch_initcall() function

> diff --git a/include/linux/riscv_sbi_sse.h b/include/linux/riscv_sbi_sse.h
> index a1b58e89dd19..cd615b479f82 100644
> --- a/include/linux/riscv_sbi_sse.h
> +++ b/include/linux/riscv_sbi_sse.h
> @@ -11,6 +11,7 @@
>  
>  struct sse_event;
>  struct pt_regs;
> +struct ghes;
>  
>  typedef int (sse_event_handler_fn)(u32 event_num, void *arg,
>  				   struct pt_regs *regs);
> @@ -24,6 +25,10 @@ void sse_event_unregister(struct sse_event *evt);
>  
>  int sse_event_set_target_cpu(struct sse_event *sse_evt, unsigned int cpu);
>  
> +int sse_register_ghes(struct ghes *ghes, sse_event_handler_fn *lo_cb,
> +		      sse_event_handler_fn *hi_cb);
> +int sse_unregister_ghes(struct ghes *ghes);
> +
>  int sse_event_enable(struct sse_event *sse_evt);
>  
>  void sse_event_disable(struct sse_event *sse_evt);
> @@ -47,6 +52,17 @@ static inline int sse_event_set_target_cpu(struct sse_event *sse_evt,
>  	return -EOPNOTSUPP;
>  }
>  
> +static inline int sse_register_ghes(struct ghes *ghes, sse_event_handler_fn *lo_cb,
> +				    sse_event_handler_fn *hi_cb)
> +{
> +	return -EOPNOTSUPP;
> +}
> +
> +static inline int sse_unregister_ghes(struct ghes *ghes)
> +{
> +	return -EOPNOTSUPP;
> +}
> +
>  static inline int sse_event_enable(struct sse_event *sse_evt)
>  {
>  	return -EOPNOTSUPP;


