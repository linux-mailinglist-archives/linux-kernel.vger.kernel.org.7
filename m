Return-Path: <linux-kernel+bounces-837979-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DAC48BAE2A2
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 19:23:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B4D51C3E75
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 17:23:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B69F30BF62;
	Tue, 30 Sep 2025 17:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J+9hjDoH"
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4036A2FBE16
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 17:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759253003; cv=none; b=QXvhvuHr3+dP9UWzxaWFNWR0FtBGSYS9RklvtEieNN1qZo7AD52vQ2WX3eX1RovhEaOkWY2VFoUA1ag9yWcIaCAwPIJ1SnNA3tY2ngaP+H6bNuVLl7aZbHnc1MQcIa6tj+0UcKetTAi+OPCZpAgOaZy+QIVE4Wys90OWlu3P1p4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759253003; c=relaxed/simple;
	bh=Gmprb3G0hVbY/wqnk/AWfgc0XcA4SLvjCB8vCR8Kz1U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ygp+wxmE8p0eQ/cydwH/qLk2bLMZmTFawySDPQcS/D6GFFydy3eWN99r/KLqdF7SST9kYyLo6um/Jfgzn7u+59zKnk/6gJf2R1+EBJ0b73Dc4E0EmY3YWnDh9MYk8aBL1YCFVTvDt77n1ZLZmoOyx6rh0clZZ0hNOBbXQQhIYoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J+9hjDoH; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4dac61ed7a5so53261151cf.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 10:23:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759253000; x=1759857800; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sNXg0KH+3u6gOVaOqmzWivNbyQ6+EgiPLfdVOQgDUu0=;
        b=J+9hjDoHRYzJQxLIASQpF85NhmT8TKvp0GMN7GlIFhHhG5RGsAXDYebJDXMr1GD6pb
         OPUVoH8SIl+E607J9M533JIRiMYO8EpRdNeCd+kKU0ZmVmsDCKh/+LesbtfjTqf7r36r
         X/FpGULbPwqgQFqo6Z0NYqRSv41yELkQYqav/rPRHr7iiNkkUqoaR9n5NamqSqp7J64l
         pRMypillSb06sU7eL73TuOfOu/LW5+ZH8/08u9zt+VhVbTiJuIEktN9wfpTYBb1i0g7G
         t9qfEDrjtDDHMeOS4yX+fs3B+w61XRTcsVBN51Rt8U0MnwMv3wGttLvImvIxWEbnJ9D4
         qO7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759253000; x=1759857800;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sNXg0KH+3u6gOVaOqmzWivNbyQ6+EgiPLfdVOQgDUu0=;
        b=GJry/ANLRZgufrfm2aJwNT7b4qupFrljm38EMHFH32VF5DzxXpKkbfJ+9pkyeAW3K1
         Cni1/YaNQk3c1F51DM337ziOb3HemM4kblJ0PCVNkU+uyR6BDySEH2Yk9oQgEvdCYg7P
         X0Bcs923DGb2OWbpFLZExh9r9ORSOmQvd9y4UJli1dVQLaw4Kt3Gw90OjCrcyn6itify
         lPcDaiAnDVBxcU/NQgUlA7dbJYbWZdyx1XYykMqzaH8qN5J4lD7i4an5i1WWFzzhfHEJ
         goMYDSEAr4fUf3577mTkkcKgVZ6vLmRD4C9oSJAg2uf4jD+JIISQS0zcoCDldgZCGPt+
         Z0Pw==
X-Forwarded-Encrypted: i=1; AJvYcCVMynr5Vb6MOeLxS0rZckTCk9/XlV0mMa9SfO/lYydTqg2dQPeADE/dFvz6+bOy94Zfj+o8DFPzLN0qTXM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkqwwcseCDF7TpssTjKFJg8MRSlLKCvxBRQWBPNNELim/iE7O3
	A7noFd+as9R/dTPRSluhpAxF88vwUG60yj/L9QEt+DSiWJXdESZLup45
X-Gm-Gg: ASbGncsQOAXMLKQlMGZCBUsvNkzzVdTauWvv9QvSEvAd2OvcvBUQAYaCGbvKLz3/lz/
	JQ+gwkiIOTJoFopLkq216i/dsPaDalKTn6+fwCuMnZTEVdeSwRjP+b4E7U0KKeDHnh9kfrs3yD9
	tpaqp5q6IFqQLtLLmkDdHqBe1JM7UWFcr/fYfwPDOF/lc1hxoXVUl70laKPnkBwIfkip5MBpqnr
	qX/m/QqTg7CvMoHYDCpY8+5qjyxNtwYVsPJCvkAOrutuHxK6RydygamxsUTQ6ozpJJqGbyWHsJc
	aK1BY/x6zw7/h1iFYPIkakhT5bTVSz0NRCQ24hBP+q8//OHAH1AlfczOFfV6lN4xTl5oeKaz4Om
	vxJVG9WAhRG0MnY5Y32UBeUygo84FhRP9tSVyW9mFotnnx3Gd/+wIIB/5ud/kiFD0loSvzrCkPB
	AHTJgR95Rh
X-Google-Smtp-Source: AGHT+IE6pmTMC5913viVxHCB4hjx7BlppxYkXAL1vAw+AKddbNTwcrXB5U4RHHgog0XwsfyAUet6eA==
X-Received: by 2002:ac8:5741:0:b0:4b3:4a3a:48b8 with SMTP id d75a77b69052e-4e41e827c5emr4195621cf.73.1759252999952;
        Tue, 30 Sep 2025 10:23:19 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4db11222768sm101479241cf.37.2025.09.30.10.23.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Sep 2025 10:23:19 -0700 (PDT)
Message-ID: <3b5693e2-c63b-4977-96ba-72374832dfa4@gmail.com>
Date: Tue, 30 Sep 2025 10:23:16 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.10 000/122] 5.10.245-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org
References: <20250930143822.939301999@linuxfoundation.org>
Content-Language: en-US, fr-FR
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20250930143822.939301999@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/30/25 07:45, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.10.245 release.
> There are 122 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 02 Oct 2025 14:37:59 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.245-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.10.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

On ARCH_BRCMSTB using 32-bit and 64-bit ARM kernels, build tested on 
BMIPS_GENERIC:

Tested-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian

