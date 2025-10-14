Return-Path: <linux-kernel+bounces-853179-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 28508BDADC6
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 19:54:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6667C19A4ADA
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 17:55:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E39DB2F5A37;
	Tue, 14 Oct 2025 17:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZibrZNOT"
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A93E3016F5
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 17:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760464474; cv=none; b=kOPvSuX47myxVv78+K1YtC/Bwm9VN9pyJmpOXUUR+u5j6V4Vxj+tvLkpy1Ob1rbLJSfQm7htWa1G4LrvrwfAppSQYE9JgWe2AYjR/2Dy4B0g680BER3CfyO3sny3eEVTxOAMkU+0AXBO/acI0Vt/9gBOXalrusjLGmY2zU8+bpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760464474; c=relaxed/simple;
	bh=3MmYi1JoNQdXRWMSOtVp8Kdazcv+3jagEkZthqrzwI8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dpJWaAZnRLbgGiEmNdL9ce9AAAoZYFZ+4U0QJzcOLjOfv/n8CHN7JZOVhn1iMnwMy2N51mOeyPOG8YDScAiory05AwYEh2EyTSLP4+n0Qu/U9eRlbsIA0bsexpzDw0k54hjFs70a+UV1BZaK4dr2hfJnHuRD998BAMlpBHaleDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZibrZNOT; arc=none smtp.client-ip=209.85.166.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-887764c2868so624114839f.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 10:54:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1760464471; x=1761069271; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gseXM3xre7+2r0O+6iOJ8UCID/6DfgPEO9X0+p8TwIw=;
        b=ZibrZNOTzP+AVHvxcE03N1aTFa6mkuFN7Z1jNy0Dk7kB4gYdKyQVbchWpNgfmfuUdY
         El0j4q1Wi/HTskXL2VGh+wW/P+4yqlHc7ebaXnrYhNhYi0JU7tjZDU+5ZUKvpeEOYCwW
         N/+eFiFRS3tlhj6vEcF2lZz3RqsmvvkGdyxVk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760464471; x=1761069271;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gseXM3xre7+2r0O+6iOJ8UCID/6DfgPEO9X0+p8TwIw=;
        b=YeI84uH5m+Wr8lWM2TDGvTAQqbyqbbdOzdJuyOAFtRFVgP/gF/8ZpyxLT3QzB+XrA9
         0U24Sjxm7CCldJ5qeTk8KgB7I01z62pV8pK0YIwKrpUC2v3YJQHK5aKJCIO0+f8uq6Gw
         qrKROY6X4N6XnjcqXmWzfuJDC7TH8W8s90KLp9cU6CWzmt2gNPvg5N7aY+zTvJcuxrmh
         WNh/lFBntZ6G5ucCg5ytP68uRGC/l+Buae8GpkIjWwBIJpgIcEkCCg6spzZVGfaH9xRH
         4ZoSvY9O0+nA6bIhoJ3m0F6pQXFSq+rbN+vV6M7B/yuj1EMx3ava9pUzFEuEIq0S4yB8
         XPCQ==
X-Forwarded-Encrypted: i=1; AJvYcCUeU0q02iJsKkSamd9CttzgKwgv1dvd2hSan03S+YDl5jlVtTxmthjbb8fXFEXST/QAuy9/A1ncNevebdk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+UBgKvRofO6LEG8JRY/TxmN4AaTnc1liSjxvJkzZowh7qVf/4
	8C7JtG7ZrNUzmwcy3WwwPwaaq1S3ubpiL9RI5uJ5BZew6DWyBJ4axGPaAi7YfqeK1rk=
X-Gm-Gg: ASbGncuhLZXqD8AMLt8MntsSdugJ1WYav0qGdhT26n0/Tzfio329x6GaR2VW/lcgicH
	QS8eMhE2nkGZNKIDt3X/fbovRSjBM+xsMXlQz4RraEX655qzkqDk6Gb/zISOTZtFUx+ND4K4fVu
	H144PLDGFCJ++aH2K2jIHCx9dGEYBRolsJp/bg9J6lbQhgGzwMusmgPkQk42HpDtGfGa0pbq6z+
	GaqtMHu+9rnnx+MuUEMzMDhwx29+yvkw56MlwXwxCxD+zqTRVbAvqHe/0qRepg0rvZih3vip4vw
	P/aFWkRO605QQ2g2tRJhzXTT+KHJMIvqyCertJw9cr7Lp51A2wNLlCMrt6bFAYkA7iWZxFPzu1P
	caybLBxwhMlip417KxxzzctnzRiAS1iNU6lUGEYtI2tcj/Eqpz7V+kwCwrKNxSNE0TesPIne1h7
	Y=
X-Google-Smtp-Source: AGHT+IE9FQ0RqivT93CbQNVR3TRDywFKmKjMA7BmDG66JT1FsSkEi3MfzaXsz5AoqvIulaE8YE+msw==
X-Received: by 2002:a05:6e02:1b04:b0:42f:a535:4120 with SMTP id e9e14a558f8ab-42fa5354357mr187377375ab.15.1760464471589;
        Tue, 14 Oct 2025 10:54:31 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.187.108])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-58f7328a26csm4930728173.67.2025.10.14.10.54.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Oct 2025 10:54:31 -0700 (PDT)
Message-ID: <ee0b612b-2266-474e-b0de-b70ee6c392d7@linuxfoundation.org>
Date: Tue, 14 Oct 2025 11:54:30 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 000/196] 6.6.112-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20251013144315.184275491@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20251013144315.184275491@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/13/25 08:43, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.112 release.
> There are 196 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 15 Oct 2025 14:42:41 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.112-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
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

