Return-Path: <linux-kernel+bounces-785757-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 714C7B3508D
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 02:58:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C33177A161B
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 00:56:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 062242550CD;
	Tue, 26 Aug 2025 00:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ksh3ef1Z"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0979C149C6F
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 00:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756169905; cv=none; b=PUDHsYgS1u7PBgkilAUKhFwGsWnhOjHM+jgmwf39V08Q7ORj3TBQyxblIb01xXls1otjfV+SBSdwAxPw3eBUEpnP+7XMdxfiWyMQinBRuRhh6EXeimXs+9SulEVZj2Ln6D55gNYfb9TQabY3Oa/vRApeN3k50zGOyIPAlZdtWto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756169905; c=relaxed/simple;
	bh=4gaX2XlcckANCEEc9yuhUn1Qx+eRlzo0H7MYzgfWBpE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tI3JltiUShKHAvAQEfScPlp3HQKSy1mSZPsB/jQtlh+596fhwGRk33t69XKRKaXuGBhf5TYipzZJPefOXu/5C+4GQRmr6b6/AbyipT6UlqiLmYqdSFeER5p1ufodN7ym/W8JEF5/AdTAvzLk8e8lbvyIS6ttUh1RYxmxevPQ6pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ksh3ef1Z; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-24457fe9704so46113385ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 17:58:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756169903; x=1756774703; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=74P6fo6XxZXMmO6G8CcbeGGu5ldJKgBq/pfz/wibO5g=;
        b=ksh3ef1ZM2dsrBIie2o+SL4/erDpQkBqZdiKc1uw66Kjm7eWfJ4nk1DXRhQoAqWnV0
         Su0FX7QDtZaocvBTF2fgU0z1qjUmMiyM5JfZYDOhvOqe310X0K4I8Q34PrzRmYxNucq3
         5hoECYrrafBH7q0LrtCF9aIWcNa/TZTNVpY1dTdYR7tT49HDjF4fbfFRuf2R5jLFN2+1
         3uLKZRoNeqeE/UNJ7f8sI+mSuLlau530l2NxF/d4uxU5pAm0H1AM1fu2T6ZF+2v2y1OW
         pdgx0A0tr5OWcVDSuRFQKu0jfldkxlDKVwBhDFQMqJkz9TCNnPGQ7zEA4rsnlPMrVwts
         jg9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756169903; x=1756774703;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=74P6fo6XxZXMmO6G8CcbeGGu5ldJKgBq/pfz/wibO5g=;
        b=rGZWJAd8WHr2LGD7vbBwiHoF8QpjLCVnD7427hRCdq4sxuoolLXzbAOCTiIbehpZ+T
         kwVDebqxnJZKn3qGY10fsD1SnNUovC6CJARmdEkAWW+zuC2fZq7lEVoHcKbg3Om88kOR
         370+ULwbOj6XJrCs+bEpNOClivEUOw43OfW+s0VCZQ7Xw9M/OcUAq1p9gMyztgkre4YA
         nerHme+6hDYrJ2ExWNwB199a+GtzOPJ/yiL9mryEuVj4rXD8uzDURm2EtAkLk3z6pVio
         QPqGFsqi4erv1vL4No/DjfN2CR9oezeIc3k2KiiJhYs3mJNdC9Hu1FY+NuGh9kKxs2CC
         mxKg==
X-Gm-Message-State: AOJu0Yx2mBkbEWjBV57DF5GcD1Xu4n3TcswK7EH34p52xsL/Z4JoQ9LR
	AeT/93TnDRdm2PIw5u3lz67dJh/qDVyBz1Zx/eTHdd1ygrtPzqTePIlXIXsq4E8VpnDUnQ==
X-Gm-Gg: ASbGncuIkJHInTSjbzaAR8j5WGY12zVJm/2nCYYL5PP4G3jsbnA9UKp+iIQHnIoyn8m
	4yQ8yx8ltuqxLcz8TmWEeGq3pOzemJiRr923vI0GO0UXhyhS/DzKzYvw3TfS/VWfleUcDR/6w+f
	PuQKoGtIhtJz4/b4opaxYxtpe3rPlrvZ+wOf84uiQgpZv8Gf/HC7uOCl69kZVb9DuY6CAUgR2lc
	vZRJzetb9eBhmv2r5Rczt1vLtVFQ0KtGr+xjmXnVyASns0qgkGSWfvmFLdr8jCpd7DRQlZbfKFE
	NhQm52t0HRBq2KyBQtkSpAdnb1Vx6MQiY7GtaJP3xJphxBddhsOVCu81wbmzed3OqQi+LX4QmxX
	C7GZPxnDpamwEAMY=
X-Google-Smtp-Source: AGHT+IG9IwJIwDLhLw5XIGzPYiyPunkt8KjddUPeVGIGwXQ24y8jpmPvrHWII/pIY4COXT31JMrdjw==
X-Received: by 2002:a17:902:fc4b:b0:246:76ed:e25d with SMTP id d9443c01a7336-24676edecf2mr127218405ad.50.1756169903198;
        Mon, 25 Aug 2025 17:58:23 -0700 (PDT)
Received: from [127.0.0.1] ([2403:2c80:6::3058])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24668779fe3sm80200525ad.11.2025.08.25.17.58.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Aug 2025 17:58:22 -0700 (PDT)
Message-ID: <504d5b94-e656-4c84-8da8-294459d3af2a@gmail.com>
Date: Tue, 26 Aug 2025 08:58:16 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/9] printk/nbcon: use panic_on_this_cpu() helper
Content-Language: en-US
To: John Ogness <john.ogness@linutronix.de>, pmladek@suse.com,
 akpm@linux-foundation.org, Steven Rostedt <rostedt@goodmis.org>,
 Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: linux-kernel@vger.kernel.org, feng.tang@linux.alibaba.com,
 joel.granados@kernel.org, namcao@linutronix.de, sravankumarlpu@gmail.com
References: <20250820091702.512524-1-wangjinchao600@gmail.com>
 <20250820091702.512524-2-wangjinchao600@gmail.com>
 <20250820091702.512524-3-wangjinchao600@gmail.com>
 <20250820091702.512524-4-wangjinchao600@gmail.com>
 <20250820091702.512524-5-wangjinchao600@gmail.com>
 <20250820091702.512524-6-wangjinchao600@gmail.com>
 <20250820091702.512524-7-wangjinchao600@gmail.com>
 <84wm6rbucz.fsf@jogness.linutronix.de>
From: Jinchao Wang <wangjinchao600@gmail.com>
In-Reply-To: <84wm6rbucz.fsf@jogness.linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/25/25 17:53, John Ogness wrote:
> On 2025-08-20, Jinchao Wang <wangjinchao600@gmail.com> wrote:
>> nbcon_context_try_acquire() compared
>> panic_cpu directly with smp_processor_id().
>> This open-coded check is now provided by
>> panic_on_this_cpu().
>>
>> Switch to panic_on_this_cpu() to simplify
>> the code and improve readability.
>>
>> Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>
>> ---
>>   kernel/printk/nbcon.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/kernel/printk/nbcon.c b/kernel/printk/nbcon.c
>> index 646801813415..7490865e2f44 100644
>> --- a/kernel/printk/nbcon.c
>> +++ b/kernel/printk/nbcon.c
>> @@ -2,6 +2,7 @@
>>   // Copyright (C) 2022 Linutronix GmbH, John Ogness
>>   // Copyright (C) 2022 Intel, Thomas Gleixner
>>   
>> +#include "linux/panic.h"
>>   #include <linux/atomic.h>
>>   #include <linux/bug.h>
>>   #include <linux/console.h>
> 
> Please use angle brackets. Also, the includes are sorted
> alphabetically. So it should look like this:
> 
>   #include <linux/irqflags.h>
>   #include <linux/kthread.h>
>   #include <linux/minmax.h>
> +#include <linux/panic.h>
>   #include <linux/percpu.h>
>   #include <linux/preempt.h>
>   #include <linux/slab.h>
> 

Thanks for the feedback. This patch, v2, has been merged to the -mm 
branch already, but I will fix the include style in a separate cleanup 
patch.
-- 
Best regards,
Jinchao

