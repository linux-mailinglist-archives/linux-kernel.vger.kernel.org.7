Return-Path: <linux-kernel+bounces-659907-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFE8CAC1689
	for <lists+linux-kernel@lfdr.de>; Fri, 23 May 2025 00:19:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 979E7505D66
	for <lists+linux-kernel@lfdr.de>; Thu, 22 May 2025 22:19:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C884326FA4C;
	Thu, 22 May 2025 22:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WggiKPvr"
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC55A26B968
	for <linux-kernel@vger.kernel.org>; Thu, 22 May 2025 22:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747952368; cv=none; b=uessypVfoPK/AvJ5ilM1e+vRSgK2JlFl8GI1HmpqUzwhhnWHgWhmhILfS3jAcJCCxAAThpR2yF00AM/ChBCE290hPi+WNZepsiAxgnrEhzeWFpIMGYlUtys0xqOW2MyygWgpdeXXnpV9V96m/fAw1mw2FQ1BrCMbco2pvLXGIv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747952368; c=relaxed/simple;
	bh=7NRYbwbYrh3x1KViQ1U6RIE08C8vCKcJ8G+srM/U/p8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mB+bbBKvOZ8rMikHVKX8axzyWBVfScgj3o1wemPeokqRiZ5nZvGuCvd5Mss9hZOmgxAHs+u/UaLefYUgByoCC4y4yz+SMy91I7MdDSczH2xKFECa+E8IX1YZUaQfHfQFCKNiBwXP0K+n8xDV674E78tfKRMj2LdX1GHvIcvHBR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WggiKPvr; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-3dc7830a386so15932615ab.1
        for <linux-kernel@vger.kernel.org>; Thu, 22 May 2025 15:19:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1747952364; x=1748557164; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=T2BBhyB5BSe8xiN4xkcpWffnGhtL3C+c766u9Ynb8BA=;
        b=WggiKPvr0tej5qduo7EGEx5EiOEToql8Z6USOF4LOnTBht3mjVPm5TR0Ug6yYxV7zX
         e3FUYoOJ/LsuMKFBSAZGmJvaRtqjHmFFnGmZuJ9/Zq42X+7+vpQx2c6KTWWV63HfRBig
         4PPAU7rjPapl7H9Txq9hZ1B3PUW+at8GShKsI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747952364; x=1748557164;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T2BBhyB5BSe8xiN4xkcpWffnGhtL3C+c766u9Ynb8BA=;
        b=CGa+/vwxuI6JzKXXCzWqXC37bfkTNvw/AxLlBipNaH0Gi4gk3fvaBHRQypaqcj/v+o
         hi7nJigGl/ByBK9z7h0tnQK/q6ZrXzMdMH/ILH4yMOjqgymQ0dqfpAej6CSjuYEQUdO1
         A013gfMgvI/LbqEV5/Z7FOE6LpzcKYmU3zRc/a86iKFzgs+rmZiYg8uE6nLNv2rtRzQe
         NigBXyp0kAY2kAbO8JXEPfO+flBCHLOaJYWCUJwr/Cz0bHKCXgLcXyOsOgq4m7LfPCk1
         MkP2RiyX7e+tJlm66gyAkA7JLIr7+0uRvrFlDZ1u5UH0/k+TBli01UkEcIIF9QxMExxP
         sM5g==
X-Forwarded-Encrypted: i=1; AJvYcCX85+9vc68zhRm0hEBy+N9yqPcUB5sgd0ENePNx1nN8wRcbMsZBsailUXbSogUpY3gvNHg2IVuCsnsNROM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7mr9TYwBB+xK0WQJEHPSRq6HgsszCMq7F+6t3XG31Y1wXU6Tx
	1MdgpeUqR3LGV7S2+oztvjzeB1l6GOF1hPwd7gD6cBobD39Zp680hKLpUR9ctNhaRg4=
X-Gm-Gg: ASbGncu+VLbWZHu0bZRKObXu1y8balXlrK8OGXOZURb0zhNT8+JwrMpgmw2cca0FqWd
	DZ7mSWjbdq+LAiplC6sjq7g8Oe83xxFM3JtE6zdB7JrICTleGvJtjwlD7wGj4sSHBUJCB3u+4+b
	bHVoY7TDQjoq2pPEEVZvj3STCBtR9xTPA+l1XSkePwphNJSZRwPyVEhWfN+r9bRK0uE++B09tZJ
	XK7yFfnxZvJD6iYs9izUBipdxHWaWPcxLDLBWQshby5Vwbsl/syzfxXCcYudvdwCeogF2z5UhYx
	FqXR47Rp5rHdSVV5WMYt9QKJ3QqEtcJ1EJJgeC7JhkHXMwCvuazJTdcZFLhrGX0ggxMIk8Vg
X-Google-Smtp-Source: AGHT+IGIm2be03aa+hk73LqpnK7jFcUNiFbXggRZAdWiAlqqdT6OIX3F0RPmogpvOlodCQDE5M6LuQ==
X-Received: by 2002:a05:6e02:3709:b0:3dc:787f:2bb5 with SMTP id e9e14a558f8ab-3dc93407c47mr9424535ab.19.1747952363816;
        Thu, 22 May 2025 15:19:23 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4fbcc38a460sm3349280173.26.2025.05.22.15.19.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 May 2025 15:19:23 -0700 (PDT)
Message-ID: <73a4b1c9-44b4-4f06-a766-ea7ed391c578@linuxfoundation.org>
Date: Thu, 22 May 2025 16:19:22 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests: firmware: Add details in error logging
To: Harshal <embedkari167@gmail.com>, shuah@kernel.org
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kernel-mentees@lists.linux.dev, Shuah Khan <skhan@linuxfoundation.org>
References: <20250516153955.111815-1-embedkari167@gmail.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20250516153955.111815-1-embedkari167@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/16/25 09:39, Harshal wrote:
> Specify details in logs of failed cases
> 
> Use die() instead of exit() when write to
> sys_path fails

Please explain why this change is needed?

> 
> Signed-off-by: Harshal <embedkari167@gmail.com>
> ---
>   tools/testing/selftests/firmware/fw_namespace.c | 17 +++++++++--------
>   1 file changed, 9 insertions(+), 8 deletions(-)
> 
> diff --git a/tools/testing/selftests/firmware/fw_namespace.c b/tools/testing/selftests/firmware/fw_namespace.c
> index 04757dc7e546..deff7f57b694 100644
> --- a/tools/testing/selftests/firmware/fw_namespace.c
> +++ b/tools/testing/selftests/firmware/fw_namespace.c
> @@ -38,10 +38,11 @@ static void trigger_fw(const char *fw_name, const char *sys_path)
>   
>   	fd = open(sys_path, O_WRONLY);
>   	if (fd < 0)
> -		die("open failed: %s\n",
> +		die("open of sys_path failed: %s\n",
>   		    strerror(errno));
>   	if (write(fd, fw_name, strlen(fw_name)) != strlen(fw_name))
> -		exit(EXIT_FAILURE);
> +		die("write to sys_path failed: %s\n",
> +		    strerror(errno));

Hmm. Wrapper scripts key off of the EXIT_FAILURE - how does
the output change with this change?

>   	close(fd);
>   }
>   
> @@ -52,10 +53,10 @@ static void setup_fw(const char *fw_path)
>   
>   	fd = open(fw_path, O_WRONLY | O_CREAT, 0600);
>   	if (fd < 0)
> -		die("open failed: %s\n",
> +		die("open of firmware file failed: %s\n",
>   		    strerror(errno));
>   	if (write(fd, fw, sizeof(fw) -1) != sizeof(fw) -1)
> -		die("write failed: %s\n",
> +		die("write to firmware file failed: %s\n",
>   		    strerror(errno));
>   	close(fd);
>   }
> @@ -66,7 +67,7 @@ static bool test_fw_in_ns(const char *fw_name, const char *sys_path, bool block_
>   
>   	if (block_fw_in_parent_ns)
>   		if (mount("test", "/lib/firmware", "tmpfs", MS_RDONLY, NULL) == -1)
> -			die("blocking firmware in parent ns failed\n");
> +			die("blocking firmware in parent namespace failed\n");
>   
>   	child = fork();
>   	if (child == -1) {
> @@ -99,11 +100,11 @@ static bool test_fw_in_ns(const char *fw_name, const char *sys_path, bool block_
>   			strerror(errno));
>   	}
>   	if (mount(NULL, "/", NULL, MS_SLAVE|MS_REC, NULL) == -1)
> -		die("remount root in child ns failed\n");
> +		die("remount root in child namespace failed\n");
>   
>   	if (!block_fw_in_parent_ns) {
>   		if (mount("test", "/lib/firmware", "tmpfs", MS_RDONLY, NULL) == -1)
> -			die("blocking firmware in child ns failed\n");
> +			die("blocking firmware in child namespace failed\n");
>   	} else
>   		umount("/lib/firmware");
>   
> @@ -129,8 +130,8 @@ int main(int argc, char **argv)
>   		die("error: failed to build full fw_path\n");
>   
>   	setup_fw(fw_path);
> -
>   	setvbuf(stdout, NULL, _IONBF, 0);
> +
>   	/* Positive case: firmware in PID1 mount namespace */
>   	printf("Testing with firmware in parent namespace (assumed to be same file system as PID1)\n");
>   	if (!test_fw_in_ns(fw_name, sys_path, false))

The rest look fine.

thanks,
-- Shuah


