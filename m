Return-Path: <linux-kernel+bounces-646673-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D78B8AB5F00
	for <lists+linux-kernel@lfdr.de>; Wed, 14 May 2025 00:04:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1AB716D9BE
	for <lists+linux-kernel@lfdr.de>; Tue, 13 May 2025 22:04:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03F38202983;
	Tue, 13 May 2025 22:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TDxiTuAB"
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4630F198A11
	for <linux-kernel@vger.kernel.org>; Tue, 13 May 2025 22:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747173840; cv=none; b=rBen5kor4Sp6pIZ4W+5rIv1BlJ7UCXaQgoB9kTKDCRG30As/ES0Qs+WwOIRmr4JI3sSVAH+yNksH3owW1DBR4spTjll14cQWNk/dIMmbYUFXU61pdvm9r6crrMEJt9eodQ3kkrc6Yy+/PSyQL0EbLdqj2QcpzfWeh6nvTqpsSBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747173840; c=relaxed/simple;
	bh=mht4Mu8KwpR6qpvUd9Q38WXeV/fBDsQSW7CDZBj5eSQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SHsC8A3XOeeWaENbPmLkbRMvfAX8PZ5CiizhyU7Y0aTzdpXcqIUNwB2uzOB266iS810BCcrMw83IavTTqFDNSHTv9CnXfFU/iJgP0TKwAowS5cogOTNR3qjjUtKKtEZ0ia5yKzDTJJ4p2EdBqr2ZF7ZfpHEqHhEmNRANtI7v5gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=TDxiTuAB; arc=none smtp.client-ip=209.85.166.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-85b4170f1f5so219896439f.3
        for <linux-kernel@vger.kernel.org>; Tue, 13 May 2025 15:03:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1747173836; x=1747778636; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MoKmI2raZuqSmtw+LIkwIvxwxu+cELMe9tnrTCWibeE=;
        b=TDxiTuABXQijeLzk3ZzOykXQsTBG0BDoxeUd5vFjzg0Ynf05H633aj8Rws9SIkYZnc
         oqZOhlSznruYx5iMXNtT3b0S7HvrnZpYP7KvO6bVsFBAr/T2sldSKkHDTD+uPp10Jbh/
         SAN0ojrFhOWCBUBcZltYIZ/Cz7UGpnHvYzENo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747173836; x=1747778636;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MoKmI2raZuqSmtw+LIkwIvxwxu+cELMe9tnrTCWibeE=;
        b=i5T5oMikRG2X3fQ7gS4bFz3RjsuWWBXdr+hewIO9KJfVeV8pvAXKatW7WlLwDRPCxw
         pojrM58ffN4H9sLNpC2b7D1C+q9IuF4ZzxxZZFs9MQeJh6vUeJvyaQW6qmu3M3fcqw+J
         LQGFEKjOXshr3Naxiq3gAWDUpOKJvaoK+M08bV2uNK7oG/xjmqD8ljIG0MHQFOqMH+tp
         HJjg2Muo3o42X0xUhIBn8vyS0LlJayZ1ypH2gPdLsNdeCxlj68w2w2AB/1soad29w8pg
         01c7m6MxxodsaPSB/AvdBi1PffkCtrVn6/1wbPlgLmWVs9Mn1fNYkuMbw32m5isAbqpW
         JIag==
X-Forwarded-Encrypted: i=1; AJvYcCVx5P6xEZ3OGOwdl4+M5caUttgn1ifh7TPiuz2BAV8a/S8CElMd4VEjlyyW3LzuBTHr6829zNCfGDgquxM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvnvS8eNOQTkO6us/tpnpc0d4fQWm+wsl+C1IwuN/61Ms8jLyy
	UJyBLVYQo0KRbEpudq9WDj1I78lZcptjcS857E87bkAhPCiAES2/bGLgP730hSA=
X-Gm-Gg: ASbGncuF3Fh4KvM5gOg7JgghP+RNd7ITBMPUtLV7m8ErhVB8bE9ra7SVjCidLaG7WrW
	hoRtCYGcJTukm4Tq2pgwqiFDWIe7sISpguqWloHAZAoeTrzgVu1YCX+kYfbCs1/KNxaKgq9PkM9
	DGYpDIsSheq+n2+JLJXpSMQAVTBWf81jnZ3i8f1S/cP1NeyUHD0Zacpqu+KW4cgcVGFeFrzrGMn
	TiLKL5DRU4It6YwPqlwj/KQvkp95Y4o17vn/qD6k/5f+s7neN2VvHwH2yZFBg1L4yeqfKVGKOpf
	xUU04APzKYYhWYKidfN0bzXtWVyTi1musNdGyjAQjBhioBVhwsEZJPIsjojg9cMVvWMXHme0
X-Google-Smtp-Source: AGHT+IF6/RkZ9qQPZwCYgDY7fPoXtWFmtHPVQT+c1klITiTH2LENUwc6S+Wq5DRw/bkxC7oGI/dW2g==
X-Received: by 2002:a05:6602:2744:b0:85b:3f8e:f186 with SMTP id ca18e2360f4ac-86a08dcadfdmr145091039f.6.1747173836361;
        Tue, 13 May 2025 15:03:56 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4fa224d8d13sm2302262173.31.2025.05.13.15.03.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 May 2025 15:03:55 -0700 (PDT)
Message-ID: <09c7ad5e-4061-4c0b-b097-fa575c12a244@linuxfoundation.org>
Date: Tue, 13 May 2025 16:03:55 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tools/powercap: Implement powercap_set_enabled()
To: Suchit Karunakaran <suchitkarunakaran@gmail.com>, trenn@suse.com,
 shuah@kernel.org, jwyatt@redhat.com, jkacur@redhat.com,
 linux-pm@vger.kernel.org
Cc: linux-kernel-mentees@lists.linux.dev, linux-kernel@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20250510184709.44935-1-suchitkarunakaran@gmail.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20250510184709.44935-1-suchitkarunakaran@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/10/25 12:47, Suchit Karunakaran wrote:
> The powercap_set_enabled() function previously returned a dummy value
> and was marked with a TODO comment. This patch implements the function
> by writing the desired mode (0 or 1) to /sys/class/powercap/intel-rapl/enabled

The short summary should say cpupower: Implement powercap_set_enabled()
> 
> Signed-off-by: Suchit Karunakaran <suchitkarunakaran@gmail.com>
> ---
>   tools/power/cpupower/lib/powercap.c | 22 ++++++++++++++++++----
>   1 file changed, 18 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/power/cpupower/lib/powercap.c b/tools/power/cpupower/lib/powercap.c
> index 94a0c69e55ef..7947b9809239 100644
> --- a/tools/power/cpupower/lib/powercap.c
> +++ b/tools/power/cpupower/lib/powercap.c
> @@ -70,6 +70,22 @@ static int sysfs_get_enabled(char *path, int *mode)
>   	return ret;
>   }
>   
> +static int sysfs_set_enabled(const char *path, int mode)
> +{
> +	int fd;
> +	char buf[2] = { mode ? '1' : '0', '\n' };
> +	ssize_t ret;
> +
> +	fd = open(path, O_WRONLY);
> +	if (fd == -1)
> +		return -1;
> +
> +	ret = write(fd, buf, sizeof(buf));
> +	close(fd);
> +
> +	return ret == sizeof(buf) ? 0 : -1;
> +}
> +
>   int powercap_get_enabled(int *mode)
>   {
>   	char path[SYSFS_PATH_MAX] = PATH_TO_POWERCAP "/intel-rapl/enabled";
> @@ -77,12 +93,10 @@ int powercap_get_enabled(int *mode)
>   	return sysfs_get_enabled(path, mode);
>   }
>   
> -/*
> - * TODO: implement function. Returns dummy 0 for now.
> - */
>   int powercap_set_enabled(int mode)
>   {
> -	return 0;
> +	char path[SYSFS_PATH_MAX] = PATH_TO_POWERCAP "/intel-rapl/enabled";
> +	return sysfs_set_enabled(path, mode);

Did you compile this?

thanks,
-- Shuah

