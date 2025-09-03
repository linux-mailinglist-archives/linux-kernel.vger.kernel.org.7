Return-Path: <linux-kernel+bounces-798103-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E426B41985
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 11:03:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 384103AF8E9
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 09:02:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E169E2D8DDB;
	Wed,  3 Sep 2025 09:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="I1jzlikU"
Received: from omta36.uswest2.a.cloudfilter.net (omta36.uswest2.a.cloudfilter.net [35.89.44.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62099223DCE
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 09:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756890156; cv=none; b=LINDL14vvYwMquTBP3OYLN50JRrOSp/RL9zJfeoohDysxeEKD0wTCQ8uny8Ga6MSEHlF+xN2vfDO7/CSUvXCvV4RU7ZugKgiSjxLgMe2hrHpwvu8lUAKspVPgp1nTqyuJAD096rytKgbGCbqYH6DRZI8B6LWdqsgjtvC3GnLB+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756890156; c=relaxed/simple;
	bh=ZghjQ4sGxAlRlaK/9MCqmpKge6JXaWtLZ7jFDobDRzQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C+/PhGns0iuH0n/ZSBdjYWHnGYonxYkJflZCyAOrvZGg5DKNs7uUwM9vZ8zHTuakJl3Ir0pV85n6oZeNaL2lK9LPm4GaGJehy9VSQns6LJ9nhX5TlVfrF6Q0aaana8sXYNtx73bdGMz41HmnsfGpLDrWw/se8EGLOGaEXXC3MHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=I1jzlikU; arc=none smtp.client-ip=35.89.44.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-6004b.ext.cloudfilter.net ([10.0.30.210])
	by cmsmtp with ESMTPS
	id tgXwuIfZsjzfwtjNruGO5N; Wed, 03 Sep 2025 09:02:27 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id tjNruNeLS6yOitjNruBsPD; Wed, 03 Sep 2025 09:02:27 +0000
X-Authority-Analysis: v=2.4 cv=OduYDgTY c=1 sm=1 tr=0 ts=68b80423
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=7vwVE5O1G3EA:10 a=VwQbUJbxAAAA:8
 a=HaFmDPmJAAAA:8 a=wQHQzwf_Hs2TCVCgcZgA:9 a=QEXdDO2ut3YA:10
 a=nmWuMzfKamIsx3l42hEX:22 a=Wh1V8bzkS9CpCxOpQUxp:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=MC4NAYLhwdC8vxhcTZFRp8+26vLRnoQroBbJEV28rQI=; b=I1jzlikU2GyTAgOwC2LHY5euQ6
	ROTBq/ObxrTSCmLRayVGzv/2ChWnlVudD8v+OXXdkELfP21ylKEatdVAmafmGAjrzczTFvkpdJq/4
	gtAn9BlgeRlqwD4/BqRUEXOmHWTdTjXkE7YIZ1d4mzWoKF5cbARMGxidHA0xTy4vtXHZrFw/JJLCf
	uPYCoM+Sjl6a9818+xpFQXuCldtI+3iCRm6onp9dPq/0FRlWsblkLiwdkSGVWt71usc4Sc+5G2Hdj
	7dw7iM2ObpWcRCEBFpeCwlUNZKLfKqwaBFWvI0ZazlJzT3M6oE4BANUBltUT7xbQtlViiqW1j5qJF
	FveRf2iA==;
Received: from c-73-223-253-157.hsd1.ca.comcast.net ([73.223.253.157]:54690 helo=[10.0.1.116])
	by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.1)
	(envelope-from <re@w6rz.net>)
	id 1utjNq-00000000mGZ-2B4i;
	Wed, 03 Sep 2025 03:02:26 -0600
Message-ID: <3e9342b1-4e3d-4551-9b48-b1fcdfc7e0b8@w6rz.net>
Date: Wed, 3 Sep 2025 02:02:24 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 00/75] 6.6.104-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org
References: <20250902131935.107897242@linuxfoundation.org>
Content-Language: en-US
From: Ron Economos <re@w6rz.net>
In-Reply-To: <20250902131935.107897242@linuxfoundation.org>
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
X-Exim-ID: 1utjNq-00000000mGZ-2B4i
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-223-253-157.hsd1.ca.comcast.net ([10.0.1.116]) [73.223.253.157]:54690
X-Source-Auth: re@w6rz.net
X-Email-Count: 17
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfK4j9d8SJVOlnI9Ns0JOsYk4lRGEuAGMhYCHZ3BpE0BEODgJgmG4v2G47IdNV7E/XdECnlvePNxSwZWcMQEs95z6ZxRqv4cJsQPtbqerKLsMVjTaHf7z
 jV6LTXHRsCY/GeeO0Kv3x6w52D9I7UaejIqK6F6Z4mst1DVu+8ZYG5+v0nkfl01e4W4huTQ0+cHlT6TmqdbJbsFVjTRSmaGQYs8=

On 9/2/25 06:20, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.104 release.
> There are 75 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 04 Sep 2025 13:19:14 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.104-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>


