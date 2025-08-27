Return-Path: <linux-kernel+bounces-788018-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C956B37ED7
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 11:29:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0FCF7C735B
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 09:29:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B55A53451B0;
	Wed, 27 Aug 2025 09:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="GASRpSg2"
Received: from omta040.useast.a.cloudfilter.net (omta040.useast.a.cloudfilter.net [44.202.169.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00B3BEEA6
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 09:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756286971; cv=none; b=ZR0EuZ4uWjJ/AqotgCK/OsF7HAFo3n78QaaIVGfOeFX+m/Y6FeQNabEa15TcUVuv/BwhjEEUyy6oSBJ86WWONFP0YA4+AbGVuSYYZQASfw6tX/XGYZxqsgQwStAY0YxmljkPEQaMh+7MQ2C+Hiev2ldcM/zBsAb7F0dS76jok4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756286971; c=relaxed/simple;
	bh=K25gUegfkpHs5Am96in8kT0g2GhYBHTMCsYstLJf4h0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YUVn464Z61wE4xP86qDvR9UE/gJn/kGXGsMSTiUhmDRwrF44hWrE9vI6C8/v6HzB2P5GetOFyCWvg6eL682V1l1xrV0bZ8BEOJGtgXThFsOaQNECiV3+2o/6jKVhsAgm1EVQl+VLlzjmBrTr2NdXSgxFKyLLU/lBRRmmqeKJI5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=GASRpSg2; arc=none smtp.client-ip=44.202.169.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-6001b.ext.cloudfilter.net ([10.0.30.143])
	by cmsmtp with ESMTPS
	id rC0iuIRyKav9lrCT8ukitT; Wed, 27 Aug 2025 09:29:27 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id rCT8uKnh7WvdBrCT8uk2cv; Wed, 27 Aug 2025 09:29:26 +0000
X-Authority-Analysis: v=2.4 cv=cZfSrmDM c=1 sm=1 tr=0 ts=68aecff6
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=7vwVE5O1G3EA:10 a=VwQbUJbxAAAA:8
 a=HaFmDPmJAAAA:8 a=LA0ryxVzlY9gRhvUUasA:9 a=QEXdDO2ut3YA:10
 a=nmWuMzfKamIsx3l42hEX:22 a=Wh1V8bzkS9CpCxOpQUxp:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=ZpuQVkr+ncYTfHaur4Vk4N0UYIp1vbsfXbaP9mfv+lU=; b=GASRpSg2V/wwNvQHD6oXYPaZ5c
	PNg9GO8tmr6/LvWhi9jsLFy2Tqsf83duelmXlp+F5a59ThZIxU27KE+NeHxpKYZ0h0yrhQKzpGFOu
	zS4NBSQMmFNbBmgHVCYOT1A+AIBKBzhkZm4NgD61aTNvktzVQ10AqgpsIDC1fo0AqJfg6K67/fY4/
	Tsf0jKSoQD9avgu0pmHftRyzU/ufwC3pntAb7FlvgZKfq2E5IDB5LwMvAzomMIiDH8pb5fx+7gyUS
	7YiS2PPY18ZKsA6Qrf8rwu2xrHyLa5Ch1wohQvAMS5ZJmUNc5076tllr28lCeaZ4rYWe9HrfSoxz9
	9zqXnYSg==;
Received: from c-73-223-253-157.hsd1.ca.comcast.net ([73.223.253.157]:49774 helo=[10.0.1.116])
	by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.1)
	(envelope-from <re@w6rz.net>)
	id 1urCT7-00000004JhP-1Siu;
	Wed, 27 Aug 2025 03:29:25 -0600
Message-ID: <dd049c17-71f8-4af0-9b17-a3d607b77286@w6rz.net>
Date: Wed, 27 Aug 2025 02:29:23 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.15 000/644] 5.15.190-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org
References: <20250826110946.507083938@linuxfoundation.org>
Content-Language: en-US
From: Ron Economos <re@w6rz.net>
In-Reply-To: <20250826110946.507083938@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - box5620.bluehost.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - w6rz.net
X-BWhitelist: no
X-Source-IP: 73.223.253.157
X-Source-L: No
X-Exim-ID: 1urCT7-00000004JhP-1Siu
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-223-253-157.hsd1.ca.comcast.net ([10.0.1.116]) [73.223.253.157]:49774
X-Source-Auth: re@w6rz.net
X-Email-Count: 77
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfMCNW4m4etcrlaJasM/B+R8Z1QvbTMFa7F9VdYyUzvkLvmtrY1dAcpCy4cQkGREF9LmGp9Dy7F2Wv/AEQ+1Hk5QM6mws2Y5X3aBJmz3hjahsB1h+yFXD
 FafTVG0pXEgI6RqU9Yw6kpTWB6r0gaizWAUDgJYLsPC1yoLD5gWs/ikj6vR1mYpBOhizOcm0k9AZ0o0yA60nbgtx4Or7l7FcMfM=

On 8/26/25 04:01, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.190 release.
> There are 644 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 28 Aug 2025 11:08:21 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.190-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>


