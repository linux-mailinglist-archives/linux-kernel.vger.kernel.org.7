Return-Path: <linux-kernel+bounces-834599-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BCD5BA50C9
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 22:12:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 331A31BC7691
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 20:13:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 858B02848AD;
	Fri, 26 Sep 2025 20:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SZd8QQja"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DAAA7260A
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 20:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758917567; cv=none; b=JECEq1lT7KBr2+UlG+I/FmAkUw4quIq1HJG0IkEL3zzRUJ1WAAzb34vSit70Pwrnn8MIMN+eUwZo0YmNs6cxvOR64GnBpjIbul4UJUBe3gYhfgHycfDSseHC/vN7+WEjZTqmjB9F/1laEokPKOqDilgWjddb4BRq1L3OPeUNH8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758917567; c=relaxed/simple;
	bh=SHvOt7VK9h1a8VMvHTMUR9OyGMuA76h7dvqv+u7yN3Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ClhWuL12bXYK/wTbabCv2A0zwVrGPdVTQXJqHyxCBLrdt/TbDs+QZ7z8Vps8U342mLBG4xHATdzMpLmLpsSaGrO2fcqtKbgT6ORbgKCXRmJTc2AeOUPh48uYCknXgOGLNJf2Y0l0g6TBPOV5FBbFFpBLCKJ+chOodFivgRedKh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SZd8QQja; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758917565;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mnEXrO/yHPd4+KaF2i+nZKvfG9cca57paS48FvdNNfM=;
	b=SZd8QQjaUybwk3vXtAVg+UrLj0NIZgkd8D/rBcVMS5ZTUFn7WE6Go9wga1ATsxiz9btUah
	ULLGyrCzyvc/EH4yzMaRvnqqqiuOV9ySRAEVzxNN2Jky6t6EOssUefv9sY1BEXiWQ5KTJn
	RBjpnCmmqK/Cdng35kk2UTLLXlRbqzo=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-674-cHQZ6_aSMv-kMkgssTKRvw-1; Fri, 26 Sep 2025 16:12:42 -0400
X-MC-Unique: cHQZ6_aSMv-kMkgssTKRvw-1
X-Mimecast-MFC-AGG-ID: cHQZ6_aSMv-kMkgssTKRvw_1758917562
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-8574e8993cbso323285585a.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 13:12:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758917561; x=1759522361;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mnEXrO/yHPd4+KaF2i+nZKvfG9cca57paS48FvdNNfM=;
        b=aZeZPLcOyBFsZy/xAO6qL1M+lqAvErrb94eT+Cees9iTOyZ12FwkdRXc86Z+C+yCGe
         LfOCgd6hKCnfjXnKSzJQWDMbmUddiJlviQAUO+6bfqs8/1Bha3XqhflcsikWx/oKVhLT
         +Ocls5a1ah/LeJ/WRQJN76dNF38PzjIFaB10a8kEx99Ym6X2NmdwIu3kTT9t6xiAkGzM
         Re8TvbCLgefn5gP1NQriYAlBOTyhPVqI+X3HR8TLGnTWqYnfNk6QR5ftugRP6uGbtspV
         AwQ7S0qe3D4Xz3bYHgyyLlXnUaZ0v9tQgB4ZAiWSkpkvtbRPlvsimeRig7PLDVrDEqIs
         TsMg==
X-Gm-Message-State: AOJu0YxU0tpeYyww4TQi/M37kDeKGeQYzElEItp+G9DVL7biqe0oGBtp
	GP77f1e2DUuUPXOXO+ik9j8hmCRqD/0pi9zWac9/yZv33XtNy4hBfy7YcP6Y7y7bhiKKF/VgpZE
	3OGdaM1VPEt+iTfSYtFsXY69/BaQp3We3/t1rCghOCq0gQDf87VK6RkSY/hxEf3jkv3Fh1IBIIA
	==
X-Gm-Gg: ASbGncvES9vkyHWfn7n+Lz5iV0w2T4rpQhFKesYf4AQBOMfUFZ/eDBvYQjgKaTbN+Nj
	/miqdq9jeHg8mB/G6mLDgztY9d5Sh3MkuXAbLTARrkV1cAWybHatdr23O/b3sWtC0AOwRAZQxW4
	8HHwT2rFr6xXy/X/EPUtDYneg5y98N5fJmRe8ceNm1JOadNFDALYZI0bQBZy1UDUdIbLMdEzhvu
	bqdzOaVErHRyQzJD0P0DAakUjo/MpKW/dX0OyiR7xE6vcHggb7SB4+RNPAPGdwZEaH53yBO3MAO
	9qu74CxKMItpmy/NrV6QdVam7bfEpg5nSSAnO1A=
X-Received: by 2002:a05:620a:198e:b0:84d:26f0:616 with SMTP id af79cd13be357-85ae23c58fdmr1282586785a.33.1758917561229;
        Fri, 26 Sep 2025 13:12:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHAynt1t1tPHuBTVAn2RN5YuygwbWeAPgMIul0Jp6AJzEsb6jExo8NrZP+3sbWteMLtRsVe2g==
X-Received: by 2002:a05:620a:198e:b0:84d:26f0:616 with SMTP id af79cd13be357-85ae23c58fdmr1282583685a.33.1758917560836;
        Fri, 26 Sep 2025 13:12:40 -0700 (PDT)
Received: from [10.26.1.94] ([66.187.232.136])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-85c3218f0b9sm335612185a.48.2025.09.26.13.12.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Sep 2025 13:12:40 -0700 (PDT)
Message-ID: <2893ebc0-325f-46e2-8694-7e6263e2a66b@redhat.com>
Date: Fri, 26 Sep 2025 16:12:39 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] intel_th: core: fix null pointer dereference in
 intel_th_irq
To: alex@ash.works
Cc: linux-kernel@vger.kernel.org, Jerry Hoemann <jerry.hoemann@hpe.com>,
 alexander.shishkin@linux.intel.com
References: <20250825174554.925679-1-darcari@redhat.com>
 <61a6cca8379529c49a031d51f90d2da6@linux.intel.com>
Content-Language: en-US
From: David Arcari <darcari@redhat.com>
In-Reply-To: <61a6cca8379529c49a031d51f90d2da6@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


Hi Alex,

On 9/26/25 12:19 PM, alex@ash.works wrote:
> On 2025-08-25 20:45, David Arcari wrote:
>> In certain cases intel_th_irq can reference a null entry in
>> the th->thdev array.  This results in the splat shown below.
>> The problem is that intel_th_output_enable() can modify the
>> thdev[] array at the same time intel_th_irq is referencing
>> the same array.  This can be fixed by disabling interrupts
>> during the call to intel_th_output_enable().
> 
> Hi David,
> 
> Thank you for the bug report and rootcausing! Can you please also
> detail the sequence of actions by which this is reproduced, so
> that I can test my fix and not bother you with a back-and-forth
> over-email debugging and also add it to our regression testing?
> Doesn't have to be a shell script (although I wouldn't say no
> to that), plain english would work in a pinch. If you have the
> time, I'm also curious about your use case for intel_th.

Unfortunately, I don't have a great reproducer.  I have a system which 
is afflicted in ~ 1 out of every 100 reboots.  Adding debug code made 
the problem easier to reproduce.

> 
> This has eluded our testing for about 10 years, so I'm very
> interested in the reproducer.
> 
>> BUG: kernel NULL pointer dereference, address: 0000000000000304
>> Oops: Oops: 0000 [#1] SMP NOPTI
>> RIP: 0010:intel_th_irq+0x26/0x70 [intel_th]
> 
> Yes, this is absolutely a bug.
> 
>> @@ -715,7 +715,9 @@ intel_th_subdevice_alloc(struct intel_th *th,
>>  int intel_th_output_enable(struct intel_th *th, unsigned int otype)
>>  {
>>      struct intel_th_device *thdev;
>> -    int src = 0, dst = 0;
>> +    int src = 0, dst = 0, ret = 0;
>> +
>> +    disable_irq(th->irq);
>>
>>      for (src = 0, dst = 0; dst <= th->num_thdevs; src++, dst++) {
>>          for (; src < ARRAY_SIZE(intel_th_subdevices); src++) {
> 
> [...]
> 
>> @@ -750,16 +752,19 @@ int intel_th_output_enable(struct intel_th *th, 
>> unsigned int otype)
>>              goto found;
>>      }
>>
>> +nodev:
>> +    enable_irq(th->irq);
>>      return -ENODEV;
>>
>>  found:
>>      thdev = intel_th_subdevice_alloc(th, &intel_th_subdevices[src]);
>>      if (IS_ERR(thdev))
>> -        return PTR_ERR(thdev);
>> -
>> -    th->thdev[th->num_thdevs++] = thdev;
>> +        ret = PTR_ERR(thdev);
>> +    else
>> +        th->thdev[th->num_thdevs++] = thdev;
>>
>> -    return 0;
>> +    enable_irq(th->irq);
>> +    return ret;
>>  }
>>  EXPORT_SYMBOL_GPL(intel_th_output_enable);
> 
> This is indeed a possible fix, but I believe a little bit of
> serialization can be employed here.

I was thinking there was a better approach.  Given the situation if 
you'd like me to test a fix, I can do so,

> 
> Lastly, my apologies for tardiness.

No worries.

Best,
-DA

> 
> Thanks!
> -- 
> Alex
> 


