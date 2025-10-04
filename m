Return-Path: <linux-kernel+bounces-842112-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB241BB904E
	for <lists+linux-kernel@lfdr.de>; Sat, 04 Oct 2025 18:54:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A103E3C23D6
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Oct 2025 16:54:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50EF9281351;
	Sat,  4 Oct 2025 16:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="IYeF9Rzg"
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02D0927EFE9
	for <linux-kernel@vger.kernel.org>; Sat,  4 Oct 2025 16:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759596873; cv=none; b=KDqBVnGs5SpFiV3qJr2DmkH7rOzf8JnnUDRSmzlOCK1G926PLYh3S+FPllAbuDTtd5PnVTEzZB7V0f+vuUf+3ffFoHephpmVVDIvlndFMVUU0gNkF15zlqZsSLaj8jZlEgtvq565Rc/3G0//6PkpDmG/K2cxRJcqFmv0Sws464w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759596873; c=relaxed/simple;
	bh=7jwL6Vl5B43Ocy7VPpUCA/ZQ+E8vvJVNntNOaNWS/xs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mvswBVTuuVLzQ60zlrDGPHQT/l9Wr5NUnygHY9EKN91kdMzwtaj1r5VoxPS1AGbH7CDfCSXM+2OaF0bjbxgBEnGuurKE0HgtZgMFrbPJPmgNXB4aDjcuW6pC6EXUzy3Xt1kZobl5a+rlUEmeJcjPW+7QUaTfWDyzOcm7rEPZGc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=IYeF9Rzg; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-930a6c601b3so292535839f.3
        for <linux-kernel@vger.kernel.org>; Sat, 04 Oct 2025 09:54:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1759596871; x=1760201671; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KBHBG9tA41TCvQg7ZgtdnkfIFkrXuT8caUQqZNNWJoE=;
        b=IYeF9RzgpWzk3DBwvFk3rhF3sOI1oJZcW0nVtEHUEdDC/fXuOEmg9foFmSC6wg7N2z
         a9sWC/7nij6VX9NrwitjWxtvlhDWHleX5e96G77Oyu0pwNyDbsjeOzbQFyMWQfqO0/u2
         lVLDEujEFdjWVmT7fcvl8P4da/SEkrqdM8+Ao=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759596871; x=1760201671;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KBHBG9tA41TCvQg7ZgtdnkfIFkrXuT8caUQqZNNWJoE=;
        b=FDGsmSTZw6aAlUE8SVKMfxqll0lhsI5i0L5KkRNYhlBYTybahhfL/Y2QT6vHPjzcHK
         dP0dIBcSC91hhHhZhX92q7XU6/yv03/gHC25twxehL5zixb9stDZ3Ed4JAipAqP8H/Da
         h3GsTwJGSzoo3LguBSsIEN944sRGh1brA8lGfkoxCyf45PYpG6u5ESvQtHfsBF4DitWY
         NE9GQior7OieINpZik7yLV/cVMvckjV9Gb4mAZI7BR+19s2GPfZxfuuAn0hXWtkumUJA
         sWeYtXMCV23DMifIXXV/1cmV9gV2lB7l+tLG5r+k8d857uGgTjwRJW6kjL3Coy0TU4/j
         MUHw==
X-Forwarded-Encrypted: i=1; AJvYcCUnNDEgDnPCa6EBSk1COEA2G9a5Do6IOygCaJd57G3wrpULmUWbGmb9kjZY7XBVeNWIehsXkLQhOryWIWk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAWxp+YliKk29yyy28GorHUeGXM0HfqP0LLqDU8kRxu4EcFiKQ
	/X29c+DQYsRWiggD4ElfUMn2ImH4neFeitWf4rbvWAziRcgtuK7nNZP/uEudD3tULgQ=
X-Gm-Gg: ASbGncuIFUzLpFGuKhY4J9J8CmxTTxkUDNP8DbTOACrA25rwSAfju2MF0HoPl0KFNzp
	kRYFOIOx5DnR5KpIzHtLe0m6whjSX55TiezOxKa12yV8NWqbJGVp90+x6rtF02bq9F/09xxyZAB
	kdMUYyIQPvNeXtZBKmjXUezfF9+QwBV7wwHtKFlaBS773A8RtRvhPW9jiNJPGYeTna3zdRdHG+t
	RgUp90JV5CR7fn7TTyOhH4re2oBhOfrPylhIeR3ltCvh4CXlKKud5I5z8pQVDp1aYtmZ2mBLhwP
	dbH+9a+sJM5Ji3bIag2aKmusD2bGtqm0NtegqE3FU9OOZRv8/rMb38WzNB5hZs95BFAZ6EdFGLA
	jtrimtZEzVyd9chBhXQDbyhREdofPcYArROn/sK3v4Ds4+PMGfXjxg+errFU//VmAXtgrrg==
X-Google-Smtp-Source: AGHT+IFpIfH6lTTmG0N2imGQ5NqZw46VJZnySYfxkXs0eV2kmfblbxS3NNNdc8KyNLc1LeccYMthRw==
X-Received: by 2002:a05:6602:3fc8:b0:8d3:6ac1:4dd3 with SMTP id ca18e2360f4ac-93b969aa445mr985467539f.6.1759596871101;
        Sat, 04 Oct 2025 09:54:31 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.187.108])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-93a7d81c735sm291244939f.3.2025.10.04.09.54.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 04 Oct 2025 09:54:30 -0700 (PDT)
Message-ID: <edd6a626-a7fb-41a0-9b98-2100f85ec2ee@linuxfoundation.org>
Date: Sat, 4 Oct 2025 10:54:28 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.17 00/15] 6.17.1-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20251003160359.831046052@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20251003160359.831046052@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/3/25 10:05, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.17.1 release.
> There are 15 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 05 Oct 2025 16:02:25 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.17.1-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.17.y
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

