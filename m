Return-Path: <linux-kernel+bounces-849145-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C224BCF4A7
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 13:45:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 368CA19A0B90
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 11:45:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C340226A1BE;
	Sat, 11 Oct 2025 11:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="0w3AeXoA"
Received: from omta036.useast.a.cloudfilter.net (omta036.useast.a.cloudfilter.net [44.202.169.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A8A721E0BA
	for <linux-kernel@vger.kernel.org>; Sat, 11 Oct 2025 11:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760183103; cv=none; b=lOVG1Z5i/9aGhxviGtbjXL9zHTe0YY0BiJ1Mn1iBB+2suvXMxXpFSCCfkfDJxcU2/NaRGe/EI8FXNb7F9dCO4GnEoDrqMQOIrj/IdOzvzK0+pfB+AmB7rWAWGPDMqTkx6TCrkW15Y/Id5wddUMLqrH/QHxWIS9HQi02E/VD7TYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760183103; c=relaxed/simple;
	bh=ZdC65IeEjHjlxcthPH7zP2TDdV3KLjQgjd+d5Z4/tns=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J2hVUzX28QRhlSbFqMaDIdC9WXOtMTFqUMk0mXYRypnLud6bDU77b3gcbbgibeuKwm6SVPRaNOMz3BvjcgE5930pxdnRu4ztFGeODfXn7658JSsOCT6APcReAULHBDboDUUv/icILzg5yaREmeI9ynwuYpbz19hRhR8WJlZpjKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=0w3AeXoA; arc=none smtp.client-ip=44.202.169.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-6003b.ext.cloudfilter.net ([10.0.30.175])
	by cmsmtp with ESMTPS
	id 7JHXvFKoYKXDJ7Y1wvWHEi; Sat, 11 Oct 2025 11:44:56 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id 7Y1vvreUit4eL7Y1wv0dUh; Sat, 11 Oct 2025 11:44:56 +0000
X-Authority-Analysis: v=2.4 cv=FN0bx/os c=1 sm=1 tr=0 ts=68ea4338
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=7vwVE5O1G3EA:10 a=VwQbUJbxAAAA:8
 a=HaFmDPmJAAAA:8 a=Q0YZzimFZhAAkqj1izUA:9 a=QEXdDO2ut3YA:10
 a=nmWuMzfKamIsx3l42hEX:22 a=Wh1V8bzkS9CpCxOpQUxp:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=1a+kP9hA9Ap8VKtupm4GAFPcZUpybl2r3wcPivGm2+E=; b=0w3AeXoAj/gUdRH3SSxH/hKXDg
	UaiEQeu91+ojRc+5nVflaDauwppJYpD9sIPjjQqWg/1VTk9qWDG/ck7hhy37qqfNbiH8cAktxwe3D
	PC5pTjgynSGuKIGwV25+TKuhCKjnvgaOtdxv2QeXQJWfsd7tcxtFnttpBQ4KBzRRMa8qBDJ3IEU6g
	rTGOqL8D+Y3dRufd6h5v1nMej10a3ZThtL1ZhKZ5e2ubGYdoCIGYUGgUQKEANIbFR0lfAj2IXyEnG
	jvpDhvJgPgc8KisS94lCHak6Ox2Atl5tRE8iEb4YW/ODTMpMQ+1bdidWtQ29qWJzCZy0udiAifUI8
	ik5EXsBA==;
Received: from c-73-92-56-26.hsd1.ca.comcast.net ([73.92.56.26]:42038 helo=[10.0.1.116])
	by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.1)
	(envelope-from <re@w6rz.net>)
	id 1v7Y1u-00000000v1t-46c0;
	Sat, 11 Oct 2025 05:44:55 -0600
Message-ID: <62895745-7bfe-426c-b69b-9b867d86e679@w6rz.net>
Date: Sat, 11 Oct 2025 04:44:53 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.12 00/35] 6.12.52-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org, achill@achill.org
References: <20251010131331.785281312@linuxfoundation.org>
Content-Language: en-US
From: Ron Economos <re@w6rz.net>
In-Reply-To: <20251010131331.785281312@linuxfoundation.org>
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
X-Exim-ID: 1v7Y1u-00000000v1t-46c0
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-92-56-26.hsd1.ca.comcast.net ([10.0.1.116]) [73.92.56.26]:42038
X-Source-Auth: re@w6rz.net
X-Email-Count: 54
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfIrV0zsMATk2DbsO7j/GOvBwp3PtU0wOUyNccZ2Al5vj/avmWhfZ+JOod2CW5YL8AmcCj6Pu1birb+1AGj50L0zy9KQjzQa7qmjNS3UYnbC2UKcVKCZp
 gItrKY6v0QIeTEEBgPD/TmcM5WTIytMrpmIDQ0XUNwzQCKmw8nOtq3TsZyQ4ZZIFExfDDJep60d8LrL6qUWgT7D9y4nJvmfIgKA=

On 10/10/25 06:16, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.12.52 release.
> There are 35 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sun, 12 Oct 2025 13:13:18 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.12.52-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.12.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>


