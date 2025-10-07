Return-Path: <linux-kernel+bounces-844776-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 458C4BC2BE9
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 23:28:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 287544E4B67
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 21:28:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D73E523C38C;
	Tue,  7 Oct 2025 21:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HKdhchtk"
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DC71244670
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 21:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759872514; cv=none; b=SmClW69668+KPpRBGMcpIvI6RAZgR5rX7+Fh2ogy2gOyzddoc4NGOJLYzD0BAnxBPx2envV82SRG5MadFnMVCk+akXFYVYFF2OMti8LGCPpa5BpjF9kYZ42cS5Tfgv/MAhwcgW0pcDeiCK9SRjn7rdOpeIKKv0lnQRGRanCRNM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759872514; c=relaxed/simple;
	bh=ybSy4Tv5iFVM78XbJXlpVrFeVjI9pBLjjyVsYoM1g0M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C9h3WW0lnmHzDacaPBa+hKuiynbEjZUoSv/UgBPA/cYIUSswQ55XXOSwVsh0DPVHDNqUtTCnXhsH9BRWM6UKYqvcnzaH+0jGuFke7eTRl8tW6V2hYjEVwDWyLzzsz1znrpN35p1tgC3Q1KV+sAxfMKBdhP807YAVcQfrwS5MKLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HKdhchtk; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-42f3acb1744so24751855ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 14:28:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1759872511; x=1760477311; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZRsJlXyUS+y130OtDxYwG/Abbe7/BVe6s/xFEvukloE=;
        b=HKdhchtkR+FWMaUfn5zONBMeu+VhWhi53TMZrA7/83MebU3c9P9bgS8Ah8EHmrRws6
         /eTWHI5acSctuzM7qgvtsyMd1CQP+4ltox1zFD9rosk0ophxZZ2O6OCsv15WKDM8GaQF
         X7LYkvxTND08APB3nzA0XeF/bZ/4MhU53ga4I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759872511; x=1760477311;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZRsJlXyUS+y130OtDxYwG/Abbe7/BVe6s/xFEvukloE=;
        b=RkxOB+9x1tjvHgRM16QHDfFhIubyi/egPBdAEfQ0J6mY+9mvvQCFnLFM1UOcoW3Wll
         imBdFpXeC8QrYZZNU4kTEIZQpTntPGofy+37SEmxDem0SIt4YQwLS7qG7erOS5Ows4jG
         ZXhHDenXamq1PGsraFy+DqBG6Km7tn/L1canXPoQMRSSWgzwiLMJVl1VKEeKiOILG9+d
         GuOnD8bfLH9+EL8M0RQV4OT6Pqgrso9HjOjs9Bw1D1b/6XOR9HhY2R0TvlExsKsvktlt
         Q/1DnJWB3UAPJ1LZRxip3b3wkhT+v2Qu9ePOt5yPeDrKon6afI5j4e2kiEDwDcH1UnBQ
         O+cg==
X-Forwarded-Encrypted: i=1; AJvYcCVlWGxcnhdjfaqFFGzX9brj7LKBxQrOCOHEsHG4ltIZSig8IBMs0i6otlAkmX2bEkNCOdr67Xlwrpm7E/A=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPzbimPWBZICdFAs8vQ1VeNH0pwPmkRTV/7Hssa8tCRXCO6PNV
	82S/k3BJReuZPSPbbwtbRUOVzJu+C/SDToTHKmyhFp7e/cHM6QKyGQDlhDv7WD+IhIw=
X-Gm-Gg: ASbGncsxu7HbcQuwg30niVXgK7pg4GOEljAb4QYpOuOtq/JVAGHrHZEAIUrG9XRWUIb
	laLonzjiUh8KV599Z4wpwkO+70UloTCeab8CyhxJDM8iYpL0WioIqhjUCxGnXuzHGrxTYBlDtUI
	wVsaEXGp+7n8fN2V79AcXCVCfaoU4xxcOYqGjrXowP9Sbv5K2iUT2Ht1U4FbCXhsZ7a7f1RxS9z
	n8Kq8ZGyaARGwJv5m6R6UWqd6h+aK8VZ8WjsuBwn2nMjBbbbJYmTJl2iPGIX+TgFPfxcVngIMY2
	WA06FHNP86QfBV/vP+XJMQ9+EJKv1vBI4nKECHXxrgE8brB0hAYOjPg5sxuyGT2f9i6cvSQpWKp
	Zhvg7eU0ZyS3u+4PbouZQ7bZIONRtCe+448M3VyretdoR2so0FvElmPMRcsQ=
X-Google-Smtp-Source: AGHT+IHeHTgxlltTMg2jkQR8M4ckc7kuuLQqcNCSqE/YdELv/3ZHWfkOaY8nRgco+jsklhYgevWYbA==
X-Received: by 2002:a05:6e02:18cc:b0:425:8744:de7d with SMTP id e9e14a558f8ab-42f87419a6amr8445705ab.30.1759872511151;
        Tue, 07 Oct 2025 14:28:31 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.187.108])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-42d8b294f91sm67698345ab.34.2025.10.07.14.28.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Oct 2025 14:28:30 -0700 (PDT)
Message-ID: <dc360969-c1af-4b87-a259-cc265a8d553d@linuxfoundation.org>
Date: Tue, 7 Oct 2025 15:28:29 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] Fix to avoid the usage of the `res` variable
 uninitialized in the following macro expansions.
To: Alessandro Zanni <alessandro.zanni87@gmail.com>, jgg@ziepe.ca,
 kevin.tian@intel.com, shuah@kernel.org
Cc: iommu@lists.linux.dev, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20250924165801.49523-1-alessandro.zanni87@gmail.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20250924165801.49523-1-alessandro.zanni87@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 9/24/25 10:57, Alessandro Zanni wrote:

Fix to avoid the usage of the `res` variable uninitialized in the following macro expansions.

ret not res?

You can simplify the shortlog "Fix ret unitialized warning" perhaps.


> It solves the following warning:

Fix the following warning.

> In function ‘iommufd_viommu_vdevice_alloc’,
>    inlined from ‘wrapper_iommufd_viommu_vdevice_alloc’ at
> iommufd.c:2889:1:
> ../kselftest_harness.h:760:12: warning: ‘ret’ may be used uninitialized
> [-Wmaybe-uninitialized]
>    760 |   if (!(__exp _t __seen)) { \
>        |      ^
> ../kselftest_harness.h:513:9: note: in expansion of macro ‘__EXPECT’
>    513 |   __EXPECT(expected, #expected, seen, #seen, ==, 1)
>        |   ^~~~~~~~
> iommufd_utils.h:1057:9: note: in expansion of macro ‘ASSERT_EQ’
>   1057 |   ASSERT_EQ(0, _test_cmd_trigger_vevents(self->fd, dev_id,
> nvevents))
>        |   ^~~~~~~~~
> iommufd.c:2924:17: note: in expansion of macro
> ‘test_cmd_trigger_vevents’
>   2924 |   test_cmd_trigger_vevents(dev_id, 3);
>        |   ^~~~~~~~~~~~~~~~~~~~~~~~
> 
> The issue can be reproduced, building the tests, with the command:
> make -C tools/testing/selftests TARGETS=iommu
> 
> Signed-off-by: Alessandro Zanni <alessandro.zanni87@gmail.com>
> ---
>   tools/testing/selftests/iommu/iommufd_utils.h | 8 +++-----
>   1 file changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/testing/selftests/iommu/iommufd_utils.h b/tools/testing/selftests/iommu/iommufd_utils.h
> index 3c3e08b8c90e..772ca1db6e59 100644
> --- a/tools/testing/selftests/iommu/iommufd_utils.h
> +++ b/tools/testing/selftests/iommu/iommufd_utils.h
> @@ -1042,15 +1042,13 @@ static int _test_cmd_trigger_vevents(int fd, __u32 dev_id, __u32 nvevents)
>   			.dev_id = dev_id,
>   		},
>   	};
> -	int ret;
>   
>   	while (nvevents--) {
> -		ret = ioctl(fd, _IOMMU_TEST_CMD(IOMMU_TEST_OP_TRIGGER_VEVENT),
> -			    &trigger_vevent_cmd);
> -		if (ret < 0)
> +		if (!ioctl(fd, _IOMMU_TEST_CMD(IOMMU_TEST_OP_TRIGGER_VEVENT),
> +			    &trigger_vevent_cmd))
>   			return -1;
>   	}
> -	return ret;

Hmm. with this change -1 is returned instead of ret

> +	return 0;
>   }
>   
>   #define test_cmd_trigger_vevents(dev_id, nvevents) \

thanks,
-- Shuah


