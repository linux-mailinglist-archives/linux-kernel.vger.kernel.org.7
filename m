Return-Path: <linux-kernel+bounces-823432-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 600D7B8667E
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 20:22:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C14D5478F7
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 18:22:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37DE528C00C;
	Thu, 18 Sep 2025 18:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JsN0JHng"
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BBDD145B16
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 18:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758219741; cv=none; b=qa8dbhHzfatYpDIgG9+aQp9pqTDyrFmuIi8GT/eKAYhENDNfZ6eXZBIxV7JFQqN0shBNSJT+Wf8cyeE38dyVi9pnrxbsrPBsqywzR6IJoWYCXJU1XGxaGnvF0mIZX0UXlQnZON1NAOzB9ghnpvRgfnnuiv+8gphvkVG2LWF7TdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758219741; c=relaxed/simple;
	bh=rezYPpZz3X4W9ApFbHhJThBqYRrd9DvtahKpXyRXxlE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bj6CfI4Xi7n9flsrL9jmf5CaBS8zqXlp9aUUmdDCdnv9iLy4dUNbGpqY91x6ef3j1V7aOglJQ7CnnTk53aIMMf/UqJse2FXrNEwdUt9LrR9OFp+5IlkrXKABkBMuTUwpvg1qdAkeY/Nr7+3KBB+tuOJ00SFSCp3EGvbIvHXIeaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JsN0JHng; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-32e34f4735eso1296626a91.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 11:22:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758219739; x=1758824539; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BHxteDGNosyzWKc+zOp/6XpISmYb+dhvuSpnMwep5kg=;
        b=JsN0JHngXk+AMun0DP5EDqEsIqu8uZnI1wuugSsaKGLo0X1Fuf83gUFX+df+KRQyWE
         B2qS9znS8HMwTGrQ8JKL1A3EoKuIr5HP/t8gvEHkRoIXnSm9UVyinM4zmsbDB7t/8d2J
         JmqZSeW/0qp4uCrgwZElVIabIM1uNhZXCavqhl3SEXYqE+ZINQwxuminqD/B7HZTJk5O
         QQqLMUBFnQsgGDdaO9Mb/cqL9phaASDNECFyEpNnA6+nI5Qu4VoiaeNA3yemts3XPyIr
         5pyZTL6mPRHzmAEs/5XvWb9avCH55HhVFivGRwVIrglCdCJciQaxTrFKyCZjvY5aRiNb
         7hOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758219739; x=1758824539;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BHxteDGNosyzWKc+zOp/6XpISmYb+dhvuSpnMwep5kg=;
        b=UU7a96pXmYa9jKfVd5BqttToBpKKUPrmxjmlEkO+KnuCvS6FYWv1ZnJbm/hHI6xK4O
         7M+FMz8cmDbxmJHaK2ZOhdSK0DPqFrluNq5tecVO3g8lhN2x+HemZqg+wefSuGMEnjSp
         4XXp4Z/BntPghhidTblD937wWLkogIyDuKinEEisLH/4t6fhWPs8CjK87Z7z6vtvyVls
         xeTLcLZAwFPe9dfZ7jR6qmTAzg6TjUcLyACcOHjslxQnIdtbvNTtTg/VSF1JZ0QkdEj+
         yLviJFu/3DwaB+YKQdDnxW5Vu3zC3ZK148WNCVNEuFTGeHVaXfnWluaf1NQ06DiLemyQ
         GO9A==
X-Forwarded-Encrypted: i=1; AJvYcCXbOy7Du6LGYBHy3GtvVprmxodMC9U1QPN4xgKlZGbjehRE7bQ4ZXFJwUoCgaPUm/49LnI43rFSLyIi5PI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPtINyUqN0LJFGMYjZvz3FaP9KJ+ISt1Wu5xpqHWBxMfqoIz/9
	2uvZvc+Jh/EDKtT97+XsZ6yJmH+gauF6TLYEsOcgRnfzH31+DCh9GPba0n3I0g==
X-Gm-Gg: ASbGncus1xxFpdUHCCE/46NofF6Zq14YHXHLZQvJ+Lcko/fmuT1e5XOd96Toud46eUZ
	T6zpLVsBzjm23UHVXazWursCwgK+zE1EMnhxz2P5itWDNCxhcX4KafATDwOUkYij0xeluQSmRxF
	7U3M9qCyNG4b4L18VJeXhvStoESYLqa9SEox4JTB38CvKM8nV+VfeqdRCgRs2aIOQYd6qEwuhEO
	OTYECCx1BdsPwg+Gajrjwq51fgYIjU+Ly+BmU9dbCf+y+gZlNbadlrUPzz+PvSSW/+j+9hwFnEX
	VgVff5UrX1AEzwsxjK/4F99CeaH4mb0XRG0gcN2TlhVLtGqFKqm8yxzoWiBT+8AQ3rZnS0DCN55
	4qj2RaBeATQdF0v+PtESvgMPkiPw0kj1NmaZ8NuduswUpsJyKLo0xZAn1i0YF93Rzg+whTFhC8d
	3lKtVbq2o=
X-Google-Smtp-Source: AGHT+IE4MTForfXoRCJyi82LZstZN5nhOX6O3jVdL7jLH6I//PGX95RW3s/Me4+dx+KgwR9BKNHpXg==
X-Received: by 2002:a17:90b:288b:b0:330:88d7:961f with SMTP id 98e67ed59e1d1-33097ff703fmr443479a91.14.1758219739445;
        Thu, 18 Sep 2025 11:22:19 -0700 (PDT)
Received: from [192.168.1.3] (ip68-4-215-93.oc.oc.cox.net. [68.4.215.93])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b54ff373ffcsm2928582a12.16.2025.09.18.11.22.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Sep 2025 11:22:18 -0700 (PDT)
Message-ID: <1560a94c-a5a4-4769-887a-23d954d7639a@gmail.com>
Date: Thu, 18 Sep 2025 11:22:17 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.16 000/189] 6.16.8-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org, achill@achill.org
References: <20250917123351.839989757@linuxfoundation.org>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20250917123351.839989757@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 9/17/2025 5:31 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.16.8 release.
> There are 189 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 19 Sep 2025 12:32:53 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.16.8-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.16.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

On ARCH_BRCMST using 32-bit and 64-bit ARM kernels, build tested on 
BMIPS_GENERIC:

Tested-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian


