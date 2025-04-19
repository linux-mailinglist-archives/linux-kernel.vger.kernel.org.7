Return-Path: <linux-kernel+bounces-611368-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2573BA940EA
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Apr 2025 03:40:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C20F51B63893
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Apr 2025 01:40:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7153D7E0E8;
	Sat, 19 Apr 2025 01:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="2j0VD+IN"
Received: from omta36.uswest2.a.cloudfilter.net (omta36.uswest2.a.cloudfilter.net [35.89.44.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 994A92EAF7
	for <linux-kernel@vger.kernel.org>; Sat, 19 Apr 2025 01:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745026805; cv=none; b=dD1/5Q+8KDjYfBlycXacJ0TOddpp+oLiOuW4EE6/6+tkGLuD0MYJoj64reoyMEccu6s6YYFV1YTp8IkUkbb9JM7+AM1tJ63K/WpdgOFkmEETVqzU2GCxJC5Ky18Qj81gCw+qborzgpdSoImQXvIC9psGSrzVjpSIeXbWr4yWXvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745026805; c=relaxed/simple;
	bh=pjbMhsnDJiDcVlV597R8ezaeAn0+5HjfbvSJN3qfqHg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p1PY76BD16JYHijiQdQJMyRgjPZkJrz9Ybzwhv2en/fpu0pCM8qvwUOqldsxNWV+RZf963ReGc4ICsHki6zNv2AafQVrKFtwB3/GdtQKnunnX6lW9fhnRzD99z9nFKt5rgQfbvV/sm/vkcUkW6M95Ufyit9OvvVgeg+IZbbd/lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=2j0VD+IN; arc=none smtp.client-ip=35.89.44.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-6003a.ext.cloudfilter.net ([10.0.30.151])
	by cmsmtp with ESMTPS
	id 5toyuK7IXMETl5xBauwtp1; Sat, 19 Apr 2025 01:40:02 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id 5xBZuVx6zh9Zx5xBZuBuYv; Sat, 19 Apr 2025 01:40:01 +0000
X-Authority-Analysis: v=2.4 cv=GODDEfNK c=1 sm=1 tr=0 ts=6802fef1
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=7vwVE5O1G3EA:10 a=VwQbUJbxAAAA:8
 a=HaFmDPmJAAAA:8 a=49j0FZ7RFL9ueZfULrUA:9 a=QEXdDO2ut3YA:10
 a=nmWuMzfKamIsx3l42hEX:22 a=hTR6fmoedSdf3N0JiVF8:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Ro7idKd4BtU0TkVne+lQsWOXuLWCVS++vWMksVF03wM=; b=2j0VD+INL1NyVHzSis8KGNfWPO
	2bKAGPku7RTp+imMTcT6ZfB3u5f+OGmDS2OHlRXoG9rzm8KsFykKgRDHuWsgh7DK6AuwG7l6eSq18
	SpRoR2jyiemh0mWZ0nw/pDHx4P9HrGeGFon9jxwCI12shtPZD4YuLAgqQKGm+rx7zge0SIYdGc/h6
	+VKx/aoZUOxv3pPyHc4tjHGAxJEYgdeNnYh8yhMzd8WmPO3ULUu6hMrlS/3FmT/C9LfO3iLxlkkRb
	/tlevdTPkF/F01TT+9ftfGHJ9RUMbLFd8KwWN98TaVUZxPYAcgX5hyx5Pm9YtjLQ/yqIwCmU/N99j
	JKvw+whA==;
Received: from c-73-223-253-157.hsd1.ca.comcast.net ([73.223.253.157]:48400 helo=[10.0.1.116])
	by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.1)
	(envelope-from <re@w6rz.net>)
	id 1u5xBX-000000009TE-1MI8;
	Fri, 18 Apr 2025 19:39:59 -0600
Message-ID: <031e3650-08bf-4c06-b1e6-2551c095c89b@w6rz.net>
Date: Fri, 18 Apr 2025 18:39:55 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.12 000/392] 6.12.24-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250418110359.237869758@linuxfoundation.org>
Content-Language: en-US
From: Ron Economos <re@w6rz.net>
In-Reply-To: <20250418110359.237869758@linuxfoundation.org>
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
X-Exim-ID: 1u5xBX-000000009TE-1MI8
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-223-253-157.hsd1.ca.comcast.net ([10.0.1.116]) [73.223.253.157]:48400
X-Source-Auth: re@w6rz.net
X-Email-Count: 54
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfHPeqqtDNkJ85jvM2wBbQB3PoqCswEMttfhalmAVzOAYsHVza3btZI/07EVm1a2V9D7+VzbTofKP/u3FBUAkSsXUSuvjaL4DBazDGf2ciaeMg9+UAbqN
 txJqtKzc5q5qlNwyOzEzHr9Mg4Iwdm2zXdoYTwN+7ZVLelZyITaJihd7tqqo+3WysaghkchpzY4iaKLoSjG8xXfwCAwKgjNczig=

On 4/18/25 04:05, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.12.24 release.
> There are 392 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sun, 20 Apr 2025 11:02:42 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.12.24-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.12.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>


