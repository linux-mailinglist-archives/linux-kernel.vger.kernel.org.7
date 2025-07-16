Return-Path: <linux-kernel+bounces-733384-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E555BB073F6
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 12:50:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3614717AD56
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 10:50:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B04B42F2C69;
	Wed, 16 Jul 2025 10:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="oYu7SUfM"
Received: from omta34.uswest2.a.cloudfilter.net (omta34.uswest2.a.cloudfilter.net [35.89.44.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74ABC2BF005
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 10:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752663043; cv=none; b=Rv9lkLlV3gE6erOyZoDtvv8PzJk9JvuVOS9VL3B1bgZdFm5EICthzGcZs7W9gT4vjbNT9FtKw/PeMmfUV7cHltYPEaxnHgxpE0fdF/Yde4ckcwGr9p2HBva5cdA9dHcl5L4HvS7nlFNEoF/ztDn2FuaNSHkO50jD6uxQgYMDcfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752663043; c=relaxed/simple;
	bh=b49Cun0UIi/X2wvmkqoMW71Ecfzv0WUit1rUd6cd/zo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VPnqCqBvZWvzB7d6MjaJrXaQNMAQws6Yn8k/0F/Zu+f65J3OdrKliv3kgRKZEf+gyxNy12R0icZwgCZCqanLLwO+UYYWAFUN2fCsufoxGOXnJkuwBWbXct9lsqM0yiAwoyj8OoMsTkp/4tfuc1VPf+P8Boxb439v56U7dv8X11g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=oYu7SUfM; arc=none smtp.client-ip=35.89.44.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-6008a.ext.cloudfilter.net ([10.0.30.227])
	by cmsmtp with ESMTPS
	id bvFSudAgZWuHKbziguup3h; Wed, 16 Jul 2025 10:50:38 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id bzifuqhuD8vXAbzifu5n9y; Wed, 16 Jul 2025 10:50:37 +0000
X-Authority-Analysis: v=2.4 cv=Fdcxxo+6 c=1 sm=1 tr=0 ts=687783fd
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=7vwVE5O1G3EA:10 a=VwQbUJbxAAAA:8
 a=HaFmDPmJAAAA:8 a=QHUtQvI2Ve2vEipCl2YA:9 a=QEXdDO2ut3YA:10
 a=nmWuMzfKamIsx3l42hEX:22 a=Wh1V8bzkS9CpCxOpQUxp:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=0gSRGIRmUA1jhOfMMNyErZgXS0KWs37oIPa/xGC0LzA=; b=oYu7SUfMNATZ6oLSvcKJzSoMKN
	FUh3mqOFj/pzsVha09Dof/wpyDtRfTZSkvomkqaVMjyeXoB2/4zzNHQsnehiIg0vbyJta1ABhKYa8
	XqU0PhA7OXHPQa8Mod9sa9DKCtaMiV/8fb5ZI+Z8sbG1q4/ObjhZ2hhtkpsNGkW6jcZtk4UrBJ5GE
	Qc6ysLGpGjpZRIhb5pVFodsqXOGCcpOq9f5tYjme6fA8HnyB4Ga0oWkvpoTKiOzZVXqfaJGHGA33q
	rZd+TSg2zho/KIjGevRBRBV7pV7nAaG0L8YPiGsCehSBbMXhy7xapFC8hH8aGTV4GGMUgNNCJhvt3
	BJhfqnxg==;
Received: from c-73-223-253-157.hsd1.ca.comcast.net ([73.223.253.157]:59720 helo=[10.0.1.116])
	by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.1)
	(envelope-from <re@w6rz.net>)
	id 1ubzie-00000002NLO-0K8v;
	Wed, 16 Jul 2025 04:50:36 -0600
Message-ID: <7bbc85e6-8967-4c58-8aac-403dea30200a@w6rz.net>
Date: Wed, 16 Jul 2025 03:50:28 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.15 000/192] 6.15.7-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250715130814.854109770@linuxfoundation.org>
Content-Language: en-US
From: Ron Economos <re@w6rz.net>
In-Reply-To: <20250715130814.854109770@linuxfoundation.org>
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
X-Exim-ID: 1ubzie-00000002NLO-0K8v
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-223-253-157.hsd1.ca.comcast.net ([10.0.1.116]) [73.223.253.157]:59720
X-Source-Auth: re@w6rz.net
X-Email-Count: 16
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfD1kHdctveV445HyMG4+DfginicoL1sss19ujVgkDvL2csKC6Q7x1BBu4cFx3SVjXKe8SBvGZ6QDFs5zr+Le/pAalZY9iMcwOpwQgwApWgpDjN+fGytv
 Hni6gYZbtYtYBb0pV1Kd37yKyn32Bh/IuMgRfBywSBHqXltVXp003lVpaBwyVB29yH09InehdQUewPvqkCqNHou12nuz+Cgom5k=

On 7/15/25 06:11, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.15.7 release.
> There are 192 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 17 Jul 2025 13:07:32 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.15.7-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.15.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>


