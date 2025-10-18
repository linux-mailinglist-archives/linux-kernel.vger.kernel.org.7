Return-Path: <linux-kernel+bounces-858904-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E0503BEC308
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 02:45:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D32E74F0633
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 00:45:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C726D7DA66;
	Sat, 18 Oct 2025 00:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QsxsN5NH"
Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 542F13B2A0
	for <linux-kernel@vger.kernel.org>; Sat, 18 Oct 2025 00:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760748341; cv=none; b=dBY6OvgcLfteu5VDvIy0kMTx2ByHCnnaWTNhDR5BFjeAOr7+5jZ6RyL4BW6JnM1jdwCZqiZhinsmYGL8H8RI5nGjkbgBXrSoji8SME90DlQwJfWMnCeAhHL88MFTk3hoy8KncoiStY8ISXIndj4yZt3StLNuW+S6zc7aqIx4dTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760748341; c=relaxed/simple;
	bh=lLlH5s59nYXoff3V5w7MB5vjZvxauckcZwYn0IdVOIg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NPMfROckgEYAF5MbgU/wLvQXKl3iJgKFLr/sOy87dd+HYCG+79iDoM5t9jrk/SNe7oOQSEpaJuB6Wv8FzR7PYTebRjKf3dY15fxNLnfBd6snUiSjt2Jw8tPTyjb56ojIr8Ogs5Y60z+bW8DHCHF5PjQo9sKMGnk9UIZtPYkPwck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QsxsN5NH; arc=none smtp.client-ip=209.85.166.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-42d857dcf92so10585795ab.1
        for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 17:45:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1760748338; x=1761353138; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CtaDUW02iUUQ1t4dCWqp4SISu2Hc4QtPf6jVY1/LtYs=;
        b=QsxsN5NHVRF+GvUKHMP7lfa+3evHwCoLGcW3inwEgLT14sqaaXqfw3ycJ1jCa+N/tF
         qU6vSI2QsenZeBjNeIe/PLa8QhnxTiRPVOgsDT7WJuzhigmsq+OhhYRzYhmhOT84Z1MB
         2AiXLNVESaCKn7b6I+JLhrh7toGlqXYRVEAAw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760748338; x=1761353138;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CtaDUW02iUUQ1t4dCWqp4SISu2Hc4QtPf6jVY1/LtYs=;
        b=sINBUuYk9At94xGqPdm76fySTEf/F/JDN1+KxHMtzpJF2UTW+GwptryCgk0rBmZ+AK
         F8pFIoHo4BCIq7+GeJk1UjOr3IghCdIudpBuG4u6qzsgsgxkr3trrRKTb+CG+2AKjgwy
         1uKvVRz4pDCDgtlwksfG5TZL5a8WzW338RhFB9wKpjjEsyn5yj0lddtCXMLJLprkdcp9
         joJyVJi6YYlFWHkEj8OceUaDT8gRNdqXlIzvaKsLeiLdeGYBFDjdWovgjR0gABeW2uKV
         jv77DlxA7n28t8OWXUzNw3wGzHLLn5bD+xY49oJ0LRuw9u1XIr+LfHTGFkazCjukollp
         5vOA==
X-Forwarded-Encrypted: i=1; AJvYcCVXr5yuwH9qfeQQLX+INxiufC8zLZLE2acloGFQjlsnjLJedXcHsPAu96+8Qd/puc7CfJhcBRNP7E/IrEE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxn4IrwO6SRZr58Mtv+XQRNpj+xV/37sdsYZfEdV9HZ+DGysjnZ
	ipOWxiPPgxCU0qhWAwvzVEulv1DTR+6MocjPiHV28eEIH/r2cFQts1ugJRrzNgAFxB8=
X-Gm-Gg: ASbGncuArKv3EiY6jIQfeGqph+RvE3LWz1Gh+kRcKQlBVpSKBxcmOOx+KF186Vbbatp
	IYSaosD+Tj0nVcpIjzL5NVfLiOwmLfUgyfgOLDwAlUp0fgpn46EgZDMfxE3D/kPh38+a3b8ySz4
	pj3mmmIvtvfAbPoFsOGznvcE+ZjhFw53+6N1Ore9KJujwV7n4DcaLKeEWDfFRQK9umQ4uhh5r8i
	EDYgx1S7TkFDlfVrGvEKmruWvsj83kWh6KWLPNZ5EahahAEgOrZ8qN8+28RM1iakfWXwUc+s80B
	vWPigfpP41FiUuRL5IAVCp9gZ/X4VlzPQTVk0zYLWmSTrafHp1RdUPi4WNw7K2RODlnm0XZ8L6E
	86pMmdynJWRwz/odZHAbHmvn0J/rlqefv8MerB0897xEwUD/8sKEyK9MSXB/Z+YmT1eeYA7Er11
	i9RF1li61foIgsPWoHc+zG09R1T+Tza5pGnQ==
X-Google-Smtp-Source: AGHT+IEmcHTne11ARqkxlAT/n2gIYyAQRzz477vLz0vdj43VMGWBnukSxF91rbE6R3Bm6WP++4meow==
X-Received: by 2002:a05:6e02:2307:b0:42f:a60a:8538 with SMTP id e9e14a558f8ab-430c52b5afemr68440605ab.16.1760748338318;
        Fri, 17 Oct 2025 17:45:38 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.187.108])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5a8a97406d7sm409328173.34.2025.10.17.17.45.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Oct 2025 17:45:37 -0700 (PDT)
Message-ID: <90e26028-e9b9-4c22-9bfe-b039327b2912@linuxfoundation.org>
Date: Fri, 17 Oct 2025 18:45:36 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.15 000/276] 5.15.195-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20251017145142.382145055@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20251017145142.382145055@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/17/25 08:51, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.195 release.
> There are 276 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 19 Oct 2025 14:50:59 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.195-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
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

