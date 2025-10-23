Return-Path: <linux-kernel+bounces-866326-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D84BBFF781
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 09:14:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 088EA189412B
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 07:15:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AE692BEFF3;
	Thu, 23 Oct 2025 07:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mly662LS"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF85C26E6E8
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 07:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761203672; cv=none; b=be6+JXrra0vd4QDg2iMg1pz2t9rRUVsy0b6iyvDCYm2CQJq9A/H+ss56AaCgRb0c5oQaOKRqct0KPV3kyyRrkwM32w8kxXIC4SgfNKUwzDPOAxeht5OiyRiDqoTeZH3Xw5/MnIb4GrBkNDLL63wLHuwoERsFkrv6JlRg9vvfmYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761203672; c=relaxed/simple;
	bh=iy5HTtFm7dpN+Me6tHRDSQSZHt+q3XPJc6WhQo7w9dQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bjaMKQzurMcLPc8z1cydGz3luMMqAIocu5nqeZNgS/xOB87wqnrNkiV8qGXwHjnQQxWCDZWnsmSYBDJ/RADc9opOFDccPTFD0WClg/nYd+H1dBd47jSI3nbWNpqNS3USOebAF98wrbyJ0OSPlk5CkL8SlbabHHczcozWd67sJrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mly662LS; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-47106fc51faso6824795e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 00:14:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761203669; x=1761808469; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FHZKwD0y2BSAHZQav3wChNXXRo6vZFDMSesZpxuz1Jo=;
        b=mly662LSk7P5yuPcUihyelz3YNZsBMA9VZ680Xv+pO42aKSUWUzdtTgihkOpg5/nkF
         QOsqqxso3R//HzyNUQERpYCr6XGgPxlbTD61qQwi7SYIbT6IkhSHPiq91zKvu+RptVb5
         8aekYhRBAtrVDy9lQpax124NiN5dT/W39wR5b+zO8kVZyAB2WeCTS6i8dPfJwzqZzVQt
         Q3q0eJ8lhmS+c2JQL66ayOXQkvVdjMI3A7CyeBg67WaVaHeE4siMk1L+Xe/zcxlqyNzL
         i7VyYxa9+iy4gnFHb2JVr7mbu4IgAp9+4xtNV7mVIcfxfVpJ5Qshq/c+qwtKKGekk3hX
         u6GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761203669; x=1761808469;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FHZKwD0y2BSAHZQav3wChNXXRo6vZFDMSesZpxuz1Jo=;
        b=ljcHcKKrCj9UIcGa1xBDPIu8F2jbqF48Om9KXhbV/w6pcqL+Dy6NLRWgY01a+Fq0au
         PHJFSXv/w6sHQ+/tcHIa1wQHd4K8/6t9Y1GsK/QF1NjF0HMTUtc+lcLNw9DYXGgNkhXn
         RTaOA3V5WD5/Q66bJFMB33kSUtuSFVQFMB6LmZYTM1cnCifrC2LxEyOzmcg3PozhNmYd
         vvODhraOUWiBDPeXEt5UfkTYxeHeAyAzPdzVokYtYFFEyl+jPmH2A7+QYW1cIEtgL468
         VVv5ajnLNE27xvFTTQzZNYCPe8QKBQmbiDT2oV+3D6Lffpqhah+JTMPBCVnT44XC+NLx
         dqVA==
X-Forwarded-Encrypted: i=1; AJvYcCVrO3BsNWbfMSIs8XNB2biXE/hnbZx77vS3xR77dtaTFHjbAe8R0ssIMl8sHhDGhyMF3MJwwEFYWkMyPC4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFAlawl0qaTIwM6XLV6lCLF6J85+jbjLFZXHHc0peoE7/KfhDV
	uTqrMoXsMQ149NO0lI5ifUU2rNbbU2Pzvp5XWQbW9zYSvkin5p6N1U6m
X-Gm-Gg: ASbGnctJmWcdihCPsgMNd0Uz4fuUnnAV6TVFULphKCiioYRx3STfdD+YDaBgVYM1ezP
	SP1OnS9bH4U3R2kpUE6EzcfGSUdxRWg9khvVyJLG/wmses8LfFWYfhc04v3xlYLsNkEWhrmcsA0
	CyEYswf9HNAZHVZUXFvl+CkqUuZSFXdVw8bQ7x40apzhBD/Zo7tirRbn/u0s+LosG5MA2HLBxMa
	mwnx1RFJDPEjUl54Ok6sc9+oRSCLk966+RHSchaTaSuVezyb1emiDIFBQIk/IRafoj8tkRqJrw6
	j7GEJgG/xsk0J9WLZ4gfp06CibeMka2eSGj9pejvpEGTV9pcg/ox2qICap87vIBtGnCl9gYqLCa
	FzKmZy2qDRox5AqaKe3d6hWCHXOg+LxNgY19GF98JVIK0aAIOlXeRQO1b8RWfRHUZug9GjNbkg9
	KFObxFZfOu33kqyCkHUNh9pR0lCit1XzLFlA==
X-Google-Smtp-Source: AGHT+IHF3QpIBvHbO664dQtYn1vPzXqJe1fWVDo+5Z0XZfkV9YVe45fmMUl5EE7efd/FPw08qbICAg==
X-Received: by 2002:a05:600c:871a:b0:471:14f5:124e with SMTP id 5b1f17b1804b1-4711791ef9bmr172539805e9.35.1761203668800;
        Thu, 23 Oct 2025 00:14:28 -0700 (PDT)
Received: from [10.221.206.54] ([165.85.126.46])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-475caf2f3bbsm20267125e9.16.2025.10.23.00.14.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Oct 2025 00:14:28 -0700 (PDT)
Message-ID: <3450b913-d205-4b19-8690-d3191cb680a2@gmail.com>
Date: Thu, 23 Oct 2025 10:14:29 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] driver core: auxiliary bus: Fix sysfs creation on
 bind
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Tariq Toukan <tariqt@nvidia.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
 Danilo Krummrich <dakr@kernel.org>, linux-kernel@vger.kernel.org,
 Mark Bloch <mbloch@nvidia.com>, Gal Pressman <gal@nvidia.com>,
 Aya Levin <ayal@nvidia.com>, Saeed Mahameed <saeedm@nvidia.com>,
 Leon Romanovsky <leon@kernel.org>, Simon Horman <horms@kernel.org>,
 Shay Drory <shayd@nvidia.com>, Przemek Kitszel
 <przemyslaw.kitszel@intel.com>, Parav Pandit <parav@nvidia.com>,
 Amir Tzin <amirtz@nvidia.com>
References: <1761200367-922346-1-git-send-email-tariqt@nvidia.com>
 <2025102347-fridge-happier-ea97@gregkh>
Content-Language: en-US
From: Tariq Toukan <ttoukan.linux@gmail.com>
In-Reply-To: <2025102347-fridge-happier-ea97@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 23/10/2025 9:46, Greg Kroah-Hartman wrote:
> On Thu, Oct 23, 2025 at 09:19:27AM +0300, Tariq Toukan wrote:
>> From: Amir Tzin <amirtz@nvidia.com>
>>
>> In case an auxiliary device with IRQs directory is unbinded, the
>> directory is released, but auxdev->sysfs.irq_dir_exists remains true.
>> This leads to a failure recreating the directory on bind [1].
>>
>> Using the attributes group visibility interface, expose the IRQs
>> attributes group if"f the xarray storing IRQs entries is not empty. Now
>> irq_dir_exists field is redundant and can be removed.
>>
>> [1]
>> [] mlx5_core.sf mlx5_core.sf.2: mlx5_irq_affinity_request:167:(pid 1939):
>>     Failed to create sysfs entry for irq 56, ret = -2
>> [] mlx5_core.sf mlx5_core.sf.2: mlx5_eq_table_create:1195:(pid 1939):
>>     Failed to create async EQs
>> [] mlx5_core.sf mlx5_core.sf.2: mlx5_load:1362:(pid 1939):
>>     Failed to create EQs
>>
>> Fixes: a808878308a8 ("driver core: auxiliary bus: show auxiliary device IRQs")
>> Signed-off-by: Amir Tzin <amirtz@nvidia.com>
>> Reviewed-by: Mark Bloch <mbloch@nvidia.com>
>> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
>> ---
>>   drivers/base/auxiliary.c       |  13 +++-
>>   drivers/base/auxiliary_sysfs.c | 117 +++++++++++++++++++++++++--------
>>   include/linux/auxiliary_bus.h  |  26 ++++++--
>>   3 files changed, 118 insertions(+), 38 deletions(-)
>>
>> diff --git a/drivers/base/auxiliary.c b/drivers/base/auxiliary.c
>> index 04bdbff4dbe5..b0fb31279257 100644
>> --- a/drivers/base/auxiliary.c
>> +++ b/drivers/base/auxiliary.c
>> @@ -225,7 +225,16 @@ static int auxiliary_bus_probe(struct device *dev)
>>   		return ret;
>>   	}
>>   
>> -	return auxdrv->probe(auxdev, auxiliary_match_id(auxdrv->id_table, auxdev));
>> +	ret = auxiliary_bus_irq_dir_res_probe(auxdev);
>> +	if  (ret)
>> +		return ret;
> 
> Please always use scripts/checkpatch.pl so that you don't get grumpy
> maintainers asking you why you didn't use scripts/checkpatch.pl...
> 

Sure. Always running it before submissions.
It passes for me. Anything I miss?


total: 0 errors, 0 warnings, 258 lines checked
patch has no obvious style problems and is ready for submission.



