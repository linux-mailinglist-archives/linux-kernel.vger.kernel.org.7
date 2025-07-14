Return-Path: <linux-kernel+bounces-730775-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 62D92B049A0
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 23:40:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4F234A5DE5
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 21:40:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95D1926B955;
	Mon, 14 Jul 2025 21:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="g59QyOR7"
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C3EE27979A
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 21:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752529191; cv=none; b=Ki6i3F1UXfB4nYbhE0eFMvwnJVIp+s05ZeTGFI9hz3584YNLCu2zXNj7tbS6HesaVNyH/wdCICW+tdzdXbPbSLIXK4sseYlavpl1k3gdiAraSGIL7AZmJgqAN6wkspHaWR1bivjDi1MSDS5RVTXokujmnGvsogIMYeBoWFjcpRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752529191; c=relaxed/simple;
	bh=byOnCqYF64rOy8DAsTZ2BEvHNm98JjJN3Uhts9L1MJw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tQgKis0IY4uNpJNE4Zcv+lYTKrfk1n4SQYOSZDPk13Jt+KY+kRHH6S5fGLewhmqfsRP4smaxrnWcwES53VG8LKLaXNhzexBvNztv8r5pxToZwlMvpmV99IlDvnT0vMZd1qtDhO3aSYhFp5UyRCD43QWs7nEkH32W5C80lItjP68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=g59QyOR7; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-875ce3c8e24so183761839f.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 14:39:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1752529188; x=1753133988; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kC1l6xOWOZrwno4uERJ87nCgkRwlplFZ9aXWC5xa/bk=;
        b=g59QyOR79osOfV1qc/XAOY9DI6tKPlX69TtuaDfF0YXZLXbSzAgnJFUILyXMBWIK6x
         TfrAXUjF5/HukC7eQVz592rFyaNb+yp25hmSFXvY1lRcjR6g89Rp/DTXH0dslsfvSMVZ
         aW4XXvw9Pun6jgYZDvtN/1/0mdKsCH+W84dxg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752529188; x=1753133988;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kC1l6xOWOZrwno4uERJ87nCgkRwlplFZ9aXWC5xa/bk=;
        b=ISl/1NH/+Ld6x0bxlYtNPVk/ycbSnlilnfz4Ev9YFD9qVa6/cnSyACosfbcqhFhazP
         15r7wPFyCUCicN20kSXg87rB3SskvafWoTw4u2jgiYl49YtK4BFH1E/qDpDPbB/w8BEp
         6y64RKF0wnAt2F0m7zQ0kqznt+eZEXssSCO37qAuxSUrDi3mGIJQxWCP/4oPaxYlqdZu
         zs3BCfwibTPVBQZSSGyMQVMtlthL6EWLPAZy8Iin6q2i48RbclFVOef+2ud6R6+T2LJd
         yhoa7WTPzNiy3uXoClXUTJruiKSNK7P7V5e7cxvM3osZ7evDAWs4kqPFE3y1v3xCiTpE
         W31g==
X-Forwarded-Encrypted: i=1; AJvYcCXTFygFJ8bU2C5YlbMlQUi8tBXvzZDK0AB6sqHWkJizR0pVZCEBg0WVM2k/vF32ttuvkg1PkHR/JtGqS10=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJoVRzoQDHIWPVenV52a+WZ4sGqNkKuVeiF9D2InAdmECOwLwT
	ATua5EQH4U5UOtYIe2s28zEI50s2DJaQ9jskDjeMRFwWr+DfN8RIyS7Y9VtzTThdeYc=
X-Gm-Gg: ASbGncvykUI9w5lEwXSOdGL4wuLj2NgtE4N5C+T37VYD6lWT///XfiamnKqLV5RjCwF
	sQDNeDMJeOyb5cvT6hLkuv+6yermOWqgqTOqUaDa8GrSLHbNw2CXrMgcN89ikHFiPesJc0GZ3ku
	qcGjsR4i6ACJVoiQkaVHIv7rke0IncieZsSpeD1s+YvYQF3USF4W81PnY7jQKXtIh4bphiolkdJ
	cIYPqD5/vfZqhscRQROYSWG/tFr/YpsSoKro79ULfzmL9pJNZu5AYDVqTy56w1jsod40QnOHcYa
	iC9mBmD8281AuWQRqopb4U3+iFqV3Kq2ou5IOaW6IIhCufXoxqVsBS/wfriAVMfYcGNWfaPdhzh
	Xkp1tBvoso27gqgfxdBSF4aKAlcVklqqwqg==
X-Google-Smtp-Source: AGHT+IH6jaGrJdphEBbSNQ6l2EUhHn4JfelFXsGzhMoppvy4TwsMDBZMZGzkc/4PyNyfNI81NioliQ==
X-Received: by 2002:a05:6e02:2166:b0:3de:12ba:7d6c with SMTP id e9e14a558f8ab-3e2532799e5mr178191295ab.8.1752529188577;
        Mon, 14 Jul 2025 14:39:48 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3e24620ac53sm33540595ab.41.2025.07.14.14.39.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Jul 2025 14:39:48 -0700 (PDT)
Message-ID: <934dae5f-88af-41a3-9a0e-3aa5311b8f11@linuxfoundation.org>
Date: Mon, 14 Jul 2025 15:39:47 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] selftests: firmware: Add details in error logging
To: Harshal <embedkari167@gmail.com>, shuah@kernel.org
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20250714212650.17935-1-embedkari167@gmail.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20250714212650.17935-1-embedkari167@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/14/25 15:26, Harshal wrote:
> Specify details in logs of failed cases

How about changing the above to:

Improve error messages adding details on failuires

> 
> Signed-off-by: Harshal <embedkari167@gmail.com>
> ---
> v2:
> - revert back to exit() instead of die() to avoid modifying system behaviour
> 
> v1: https://lore.kernel.org/all/c7c071ed-6a4e-4a9c-ba9d-c745fd42c22f@linuxfoundation.org/
>   tools/testing/selftests/firmware/fw_namespace.c | 14 +++++++-------
>   1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/tools/testing/selftests/firmware/fw_namespace.c b/tools/testing/selftests/firmware/fw_namespace.c
> index 04757dc7e546..5b0032498ede 100644
> --- a/tools/testing/selftests/firmware/fw_namespace.c
> +++ b/tools/testing/selftests/firmware/fw_namespace.c
> @@ -38,7 +38,7 @@ static void trigger_fw(const char *fw_name, const char *sys_path)
>   
>   	fd = open(sys_path, O_WRONLY);
>   	if (fd < 0)
> -		die("open failed: %s\n",
> +		die("open of sys_path failed: %s\n",

Why not just use sys_path as a input parameter to die()?

>   		    strerror(errno));
>   	if (write(fd, fw_name, strlen(fw_name)) != strlen(fw_name))
>   		exit(EXIT_FAILURE);
> @@ -52,10 +52,10 @@ static void setup_fw(const char *fw_path)
>   
>   	fd = open(fw_path, O_WRONLY | O_CREAT, 0600);
>   	if (fd < 0)
> -		die("open failed: %s\n",
> +		die("open of firmware file failed: %s\n",

Why not just use fw_path as a input parameter to die()?

>   		    strerror(errno));
>   	if (write(fd, fw, sizeof(fw) -1) != sizeof(fw) -1)
> -		die("write failed: %s\n",
> +		die("write to firmware file failed: %s\n",

Same here

>   		    strerror(errno));
>   	close(fd);
>   }
> @@ -66,7 +66,7 @@ static bool test_fw_in_ns(const char *fw_name, const char *sys_path, bool block_
>   
>   	if (block_fw_in_parent_ns)
>   		if (mount("test", "/lib/firmware", "tmpfs", MS_RDONLY, NULL) == -1)
> -			die("blocking firmware in parent ns failed\n");
> +			die("blocking firmware in parent namespace failed\n");
>   
>   	child = fork();
>   	if (child == -1) {
> @@ -99,11 +99,11 @@ static bool test_fw_in_ns(const char *fw_name, const char *sys_path, bool block_
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
> @@ -129,8 +129,8 @@ int main(int argc, char **argv)
>   		die("error: failed to build full fw_path\n");
>   
>   	setup_fw(fw_path);
> -

Why did you remove this line?

>   	setvbuf(stdout, NULL, _IONBF, 0);
> +

Why is this line added

>   	/* Positive case: firmware in PID1 mount namespace */
>   	printf("Testing with firmware in parent namespace (assumed to be same file system as PID1)\n");
>   	if (!test_fw_in_ns(fw_name, sys_path, false))

The rest looks good to me.

thanks,
-- Shuah

