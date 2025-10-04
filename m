Return-Path: <linux-kernel+bounces-842163-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A567ABB91F8
	for <lists+linux-kernel@lfdr.de>; Sat, 04 Oct 2025 23:06:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A7E61896243
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Oct 2025 21:06:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC9BA284B42;
	Sat,  4 Oct 2025 21:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="QBb3S+KH"
Received: from omta040.useast.a.cloudfilter.net (omta040.useast.a.cloudfilter.net [44.202.169.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 538491C1F0C
	for <linux-kernel@vger.kernel.org>; Sat,  4 Oct 2025 21:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759611968; cv=none; b=iLal0NgumcF88pt4EBrR5Y+jKpp0sNKbuEVIGqjHllb+mN5YxLhWbxsybLXv8J0JZI1YbXjBwo/hnL+5KvF4XFKOESdyPLrti4t9pvtrtUdYn3qCAOWn5HodQRo1PvKSg3eFSviNS4KE+LB0L7CO+NuCg61bqihAcDYMGPnra4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759611968; c=relaxed/simple;
	bh=Po/22EJqppzhG1Mk3xNl5M3uH6961WudLRFOeyPIs+Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gOr6bbG9ui3z8MXlW4OAMB6rkkbHVpTuwmSR3/b+52ryN3mZK6rAaCJpM+3w0zx6oafbZJ0rYf3YkXigheyhOTqfOSoR7E11rDnKvbzhcPXEhYPV7GXGpeZ/LOQavG8Zy96+VSBFiXn+Pnn3xdMXO2z846sNAoRSShFYjRdYyXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=QBb3S+KH; arc=none smtp.client-ip=44.202.169.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-6004b.ext.cloudfilter.net ([10.0.30.210])
	by cmsmtp with ESMTPS
	id 58QFvwGtgv72459S0vbEf6; Sat, 04 Oct 2025 21:05:56 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id 59RzviDpb25G759Rzv9CkN; Sat, 04 Oct 2025 21:05:55 +0000
X-Authority-Analysis: v=2.4 cv=LuqSymdc c=1 sm=1 tr=0 ts=68e18c33
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=7vwVE5O1G3EA:10 a=VwQbUJbxAAAA:8
 a=HaFmDPmJAAAA:8 a=49j0FZ7RFL9ueZfULrUA:9 a=QEXdDO2ut3YA:10
 a=nmWuMzfKamIsx3l42hEX:22 a=Wh1V8bzkS9CpCxOpQUxp:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=d7CMpgkK/20obOLAVZ+ihHpO1jnM5/h9/gRcJ33ehtg=; b=QBb3S+KHDIr2UDqA6Lg/QOGhIu
	M3J9XF/Y2d/MbOFNjlUzPIlZDe1cH3dUrzjQMum3FykxW/fVUTprj3oSu7IOZwyeXBIRv8Xys7vp3
	zxofYemrcvvD3XbQ8H22bl6hmpAKyfjaMb7UbYQRgjw2uKBdGYgjW2ZjjY3Eand/pDm+OgpASv48v
	YSgbORwe1t7GQz6N9SeE/TZqzh4tdlC88KCYvkQSVaKj/G2M+pW5GbY3WNFTSVGuOTfP6CviGXLxy
	Z/ZTqk55TiWkVMWWH0w3YGo1sVIoIhjeayKL5t6FoW/+eaKTd2qOQvW7PrbZEJHb/4AHFTLxb+cmO
	yQGOeZvA==;
Received: from c-73-92-56-26.hsd1.ca.comcast.net ([73.92.56.26]:48642 helo=[10.0.1.116])
	by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.1)
	(envelope-from <re@w6rz.net>)
	id 1v59Ry-00000003k58-24LW;
	Sat, 04 Oct 2025 15:05:54 -0600
Message-ID: <47b7c020-6ad2-4f04-9ae0-e1f5a0532006@w6rz.net>
Date: Sat, 4 Oct 2025 14:05:51 -0700
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
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org, achill@achill.org
References: <20251003160359.831046052@linuxfoundation.org>
Content-Language: en-US
From: Ron Economos <re@w6rz.net>
In-Reply-To: <20251003160359.831046052@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - box5620.bluehost.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - w6rz.net
X-BWhitelist: no
X-Source-IP: 73.92.56.26
X-Source-L: No
X-Exim-ID: 1v59Ry-00000003k58-24LW
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-92-56-26.hsd1.ca.comcast.net ([10.0.1.116]) [73.92.56.26]:48642
X-Source-Auth: re@w6rz.net
X-Email-Count: 16
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfB4zAdqJqblj9B+qKxe866oVxgadNp9/VQaxW0pW/tSEMAft0Ub/GC2Jlx/P2u3dhisz8b404ttERNRWNsOhi1t6tj0098vF3Lm85vZQM0ZK35i5/ujJ
 gYg5jAI6H6H2tt0ox3ZAaxsKsjoCUgVIvFiHmIncnu88ZKoYs8tbS8GTRhfPR4qfi7fxD70fZVMLewIJk3dBiSZ2o0d34SWUyow=

On 10/3/25 09:05, Greg Kroah-Hartman wrote:
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

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>


