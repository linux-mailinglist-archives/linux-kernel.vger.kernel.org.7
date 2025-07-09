Return-Path: <linux-kernel+bounces-723213-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E4225AFE478
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 11:44:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5DF44E5AF5
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 09:43:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97E9B2868B3;
	Wed,  9 Jul 2025 09:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="dyCBiPy2"
Received: from omta036.useast.a.cloudfilter.net (omta036.useast.a.cloudfilter.net [44.202.169.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE648286892
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 09:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752054243; cv=none; b=tXyID1DAPRIXTflo795cka4cyAUwBqrFiPNjlnZ84kE2tbvfbd9qQa9wlI1EdpoEIxlgYkSHziR5ZvENrmtPR2Czjp31OpMxK/EkSlx7nuf2u1gL6QI9QHfCu2Jhz5aQS4/4PJIe59ZOue6BmglH6/VutZj49LrrrrLWRgJGpPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752054243; c=relaxed/simple;
	bh=eX2dNpSdAR4tigb9OpnXR/7Hbwg+2ej9WoBDoNN7g+E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GHCoScTZ6gVGu6TkopKeGy6tcvWZs0k2xeMp0lOuTLbFn/vNUfli00C4ZHPxHkb1yz7zI114moda7H6V+2vv5Rg6V05Axn7o8lUOjIs1gsPWw5aPQfpqAV7L2I507skFZi0I1k6+FmdstBx6J4+fLv3txKxofL+Dm9IBrFnKLEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=dyCBiPy2; arc=none smtp.client-ip=44.202.169.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-6008a.ext.cloudfilter.net ([10.0.30.227])
	by cmsmtp with ESMTPS
	id Yx0vuxDxlbmnlZRLEuvswX; Wed, 09 Jul 2025 09:43:52 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id ZRLDuyn9I8vXAZRLDuIWcl; Wed, 09 Jul 2025 09:43:52 +0000
X-Authority-Analysis: v=2.4 cv=Fdcxxo+6 c=1 sm=1 tr=0 ts=686e39d8
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=7vwVE5O1G3EA:10 a=VwQbUJbxAAAA:8
 a=HaFmDPmJAAAA:8 a=49j0FZ7RFL9ueZfULrUA:9 a=QEXdDO2ut3YA:10
 a=nmWuMzfKamIsx3l42hEX:22 a=Wh1V8bzkS9CpCxOpQUxp:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=/L8kNVwOhLL5sBonuSb7cFKewPiPvCuB3EtyAlUtIfc=; b=dyCBiPy2+AVFnplXvEOYTlRDgV
	m7SqOqEZ2tXbodrrFhHTwK3OsXZ8BPWoGRsJxPAz9PJ57pmJFv7sT8ApqdNJVK3nqnZTx21Zdcmfd
	EzDgOzIsTlxI5fEBqsZs5dRNc/kehHB04nN7nGR1sXiqBrTo6lbQ7SihKwB/miHHZmiFuB9VUsLfG
	i/vulOS2TRgViqiJZ+7+nqLxBqnGg2LYHf5UxU9rMJdVr29ZlBVfg2QAluIorLwbUb55r5VEJBg9S
	QeRmlk1ZjuyU9Yu9qPo4z40cWR38oL3nVpznWS3Bd3JCVk8uEOdvw6GQD/kZDhWPQxEod5rcSSo0j
	VkfgJKrg==;
Received: from c-73-223-253-157.hsd1.ca.comcast.net ([73.223.253.157]:39944 helo=[10.0.1.116])
	by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.1)
	(envelope-from <re@w6rz.net>)
	id 1uZRLA-00000003KWw-43gY;
	Wed, 09 Jul 2025 03:43:49 -0600
Message-ID: <83b0e196-a22f-4447-80fe-34b10f02b152@w6rz.net>
Date: Wed, 9 Jul 2025 02:43:40 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.12 000/232] 6.12.37-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250708162241.426806072@linuxfoundation.org>
Content-Language: en-US
From: Ron Economos <re@w6rz.net>
In-Reply-To: <20250708162241.426806072@linuxfoundation.org>
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
X-Exim-ID: 1uZRLA-00000003KWw-43gY
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-223-253-157.hsd1.ca.comcast.net ([10.0.1.116]) [73.223.253.157]:39944
X-Source-Auth: re@w6rz.net
X-Email-Count: 35
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfMr5XAqadZpATjZ4XLDCTWOYQlzd1CRvpEgIvcQMYRLXqU7HI/EIJ/wkQB2jnMXMdNTlNQc1OyWS0npQBY+BC6Dp/vCncMgy38L7SUGcAIR4UkNq36FJ
 qAKN93IrGJAxxghCTlmRXpyVtleK/WWC7+vVkRo/F2GcWLDEsrk3mNQ+vZEqYJLJbuyLuBAuuBny8BJfHhGZ8RQ2fPO8JNxjasI=

On 7/8/25 09:19, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.12.37 release.
> There are 232 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 10 Jul 2025 16:22:09 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.12.37-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.12.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>


