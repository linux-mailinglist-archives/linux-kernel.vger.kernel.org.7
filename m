Return-Path: <linux-kernel+bounces-842115-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 63043BB9066
	for <lists+linux-kernel@lfdr.de>; Sat, 04 Oct 2025 18:57:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDB543C2527
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Oct 2025 16:57:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93A7128150F;
	Sat,  4 Oct 2025 16:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="OXU9/8IJ"
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8832927AC21
	for <linux-kernel@vger.kernel.org>; Sat,  4 Oct 2025 16:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759597033; cv=none; b=V2aw8zDHjLI9zSZIkFGBR9KfD+qxIHQr+9O+7J3LSNriXi9RBiSq4FXOmcm9rpGXg7PRboGQapKalqYJC09kabYwIaFrxie4f8sAaiNJ1TfrNISKn9kWNpSOEmBqhcCCOPNUNNAIKTGAUFCJw2sotpOWz0mhFD8g01XTUwoltUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759597033; c=relaxed/simple;
	bh=+UohY9HqNpMBf+gQ74FwUWrvvqUMkiginVNAaAKBJFA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Qa7FABNAwrvOP99GJHjCZkkj1r9yezpLmAQsCafMAxjb4PDOj6GZAfaXe+p/Dtr5oyQ50mJ7ygR5zS6ebeoxd1IqGcpxrYgnxm+o3xhDqBPHqPE83ugvWIQA9ksVtkNTlMLGa6hLhS4N/IxuqjeXTI3N7n6ox2VbeH9OvdkfW84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=OXU9/8IJ; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-8cf4f90b6f0so274187339f.0
        for <linux-kernel@vger.kernel.org>; Sat, 04 Oct 2025 09:57:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1759597030; x=1760201830; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=a1mMWuCz0t3r8/HFzzxA4DdadxyuLy3zuMlmevG8qBs=;
        b=OXU9/8IJYBw7XEtLbQTYR8QZ2eJXHvlUVlvK0JMjtArDfls214+PCp+AwK49zqXdO/
         cYxpPF/MuLYUCEeSz8KSowW3ay8+ho0W3s9zp3SdB5DGsXgU1CQWSRSJg0nyIlHFEaIU
         hlU8kUNO8FDF1OUTfrFxOwacdS19LCwaeE12s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759597030; x=1760201830;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a1mMWuCz0t3r8/HFzzxA4DdadxyuLy3zuMlmevG8qBs=;
        b=QIequbI9tIt2d/B8ZGgu6YnQoQ3sbRWn0AAJNwanly+3NP3mr0RbXv/gt9LsO+3Wiz
         OoCnmiBS4zpHIvAWQhIgoU8n31cwNabgxSavLo9N43LSRP1z4IFYKg6uXEl7T0a0Qsoi
         1MjP2rDkmOp5iWY5CCcrcHSPEb44Jf8mnG2T9d38wokzrPDFRyvf7yzPW6rTtIsjI68x
         ttKZ8vxJVD2PpylqahclW/U92dvp/qXkP/+EL9+3xIi3w0on4g+rfmAR/hDsYkv3r8qQ
         88Jtl5dXapOLCrvSIVb3y6Tq1E4YPGIspgau+C8ampbTjPl3iIRJAlyBacldci8zNpuk
         RpGA==
X-Forwarded-Encrypted: i=1; AJvYcCULS38n7fWcq1oZy8QLGzJV/JcwV2/82ZoamROoep4cnZJD4EhEf7l3qW2REoaCNevcVs7VbnsvD10zzao=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhTR9x/beb0X2E5klCSbRIYAC708U494EhBMTzlUA81ukqJOWG
	FnlW46d+VsT/FjvZeiyFiyWu+LFKX673twb3F6I41mSwTg8g9Z9bqiM0VOtdIXzXPz0=
X-Gm-Gg: ASbGncuB7c95zD8qIQPh1/XkQ9I0Nt41xHzI2hx8V+JdqpmeEz9RKfUlPT2Y8fZva54
	QozoA/jd0iy8iyo/dJ0PWx5m/svqm4nq0evAV5WZr+pMOlgeuiTDh3W5uj5q3lBYVYv1amZHxsW
	OLCJycoULCjp26pyzhIJ1EnmO0oV3I708zpTdNngOQHMgLF14u2fFa5MA0F38G5Lu83804q21q3
	cqfR+SHOKFIsCW4q/cIzbAqrNcky2hjH2GVyagyXnYiDQPdWlUNlGmYiGa39IXHfpE3aj6/VvdM
	b2P6sRB/MVuWtIhJhVQXG6IXyiBHfvHlvhRY68C58fhJS+fw6G4oLL2XrB7YE2RiwANmPALWUyC
	OlrXp51l7TvTgKV1O5nGMua/CSj9DeTRS07Z5n0ICTMlNZxohfdqf8/y7gRg=
X-Google-Smtp-Source: AGHT+IHef8taA+Z8P8AtiePPCV7SM1tDyeVyNmWwQlrFm7/YcjguSwVAX+OofP7dxS87Htom2Ta7NA==
X-Received: by 2002:a05:6602:6215:b0:887:26b5:a581 with SMTP id ca18e2360f4ac-93b96a5d491mr841505339f.12.1759597029719;
        Sat, 04 Oct 2025 09:57:09 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.187.108])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-57b5ea7f82asm2964305173.33.2025.10.04.09.57.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 04 Oct 2025 09:57:09 -0700 (PDT)
Message-ID: <052bd9ce-fb5a-49e7-a670-a75613ad0488@linuxfoundation.org>
Date: Sat, 4 Oct 2025 10:57:08 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.12 00/10] 6.12.51-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20251003160338.463688162@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20251003160338.463688162@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/3/25 10:05, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.12.51 release.
> There are 10 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 05 Oct 2025 16:02:25 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.12.51-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.12.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

Compiled and booted on my test system. No dmesg regressions.

Tested-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah

