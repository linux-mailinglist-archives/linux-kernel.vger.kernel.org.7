Return-Path: <linux-kernel+bounces-829197-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52AF9B96807
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 17:10:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F9DB161A32
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 15:10:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D83125B31B;
	Tue, 23 Sep 2025 15:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="19F5z1+I"
Received: from omta036.useast.a.cloudfilter.net (omta036.useast.a.cloudfilter.net [44.202.169.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D058244685
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 15:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758640207; cv=none; b=pE7HXJvE1/g8mTOzqhI0Cl6aZmj1dHNZ18PqFq7P1f5ukpRJNwidMPdw7CBfEU7Q6t1yAmKIBXYoa57ZvUJlc0HLBnqTNZ4GFiZHb17+O8Q/PBwRnzeTSZ90/1767qatn01ON/jSyuG6hMmy4J2ajH4mYflSUNOQ4i2X08/z9Bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758640207; c=relaxed/simple;
	bh=SSiy2TRluSryN9ADgpVQ0qferuYOUc6LMJJchbc4wbo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tT4RfQh+L6CC9Ac16sCWGYTA7z30U80HDWd81W6jttKQRTyPSzPxW+GGT7bXbXv4cXNRHECVLy15X3q1asGPngfCrOEvfl/wyCW/b42D8866Cq/Nn9wybZY/x3E3U69+R+GMk8MiznYVVlfoNwvtEnB+tdMxFw82blEMpICYdX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=19F5z1+I; arc=none smtp.client-ip=44.202.169.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-6007b.ext.cloudfilter.net ([10.0.30.166])
	by cmsmtp with ESMTPS
	id 0pVsvVZYlKXDJ14eavENeo; Tue, 23 Sep 2025 15:10:04 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id 14eZvvoPsp0Hq14eZvk5vu; Tue, 23 Sep 2025 15:10:03 +0000
X-Authority-Analysis: v=2.4 cv=H/nbw/Yi c=1 sm=1 tr=0 ts=68d2b84c
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=7vwVE5O1G3EA:10 a=VwQbUJbxAAAA:8
 a=HaFmDPmJAAAA:8 a=_vbObBfMJV-T1l9kk0gA:9 a=QEXdDO2ut3YA:10
 a=nmWuMzfKamIsx3l42hEX:22 a=Wh1V8bzkS9CpCxOpQUxp:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=fMDigIkoQzPyQti19xkVm/iKCrXMe3NdMvsHL5IpVBo=; b=19F5z1+IVgeEERpYhE2+nSYk0J
	qnE57NSUmku7tjedQ99U7JoTmP1XZXYRrZUvE6rSynQThMLMCHCsPvWK9PMi7J7JZrJEmOBjHmdy7
	0gJkGAzwTz6+M079JR9bbucYZ88oHJSEQ6wEekwhz33ZmcucNyKp0QDfnOvwf+CtNQj7sB1NipP+e
	CIffzP2yKoaGZmh+ar40bcueQ5rDj9EFf0Xpd6nji1G+znMZ1qKzP8JhbQy0a7BErr31vf9AmdkVN
	jampZIG+5HA3uqCcjHmcYjumn2PEj4nZ+Y+n18kFaA+6iBzn9RJwWnlrdKK2f8FeGEDmjOsO8p8oY
	CJ/xnWcg==;
Received: from c-73-92-56-26.hsd1.ca.comcast.net ([73.92.56.26]:50504 helo=[10.0.1.116])
	by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.1)
	(envelope-from <re@w6rz.net>)
	id 1v14eY-00000000xJR-2SyM;
	Tue, 23 Sep 2025 09:10:02 -0600
Message-ID: <2ad53a59-6178-4938-8d61-a46e503be3b7@w6rz.net>
Date: Tue, 23 Sep 2025 08:10:00 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 00/70] 6.6.108-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org
References: <20250922192404.455120315@linuxfoundation.org>
Content-Language: en-US
From: Ron Economos <re@w6rz.net>
In-Reply-To: <20250922192404.455120315@linuxfoundation.org>
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
X-Exim-ID: 1v14eY-00000000xJR-2SyM
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-92-56-26.hsd1.ca.comcast.net ([10.0.1.116]) [73.92.56.26]:50504
X-Source-Auth: re@w6rz.net
X-Email-Count: 37
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfI+OiqvXcWHBRLM8sYRC/FosxRF6JOO8AvKbqeDn0Wqqt38T9K/TPhU11WqafENh5JXkS8Gr2k+sX3RCK/3SWZLCjt38v9g1gzPi0CmKjBFALP6c1UrT
 RCMG1OLQgte4OrI4BpwzFfPwb1zljrvbm86bIMStpThV9l1uGqJWNGVrtQWJhdyE2rS1UaFHU11WzeYM9MrTuthFTF4BI7bBJV0=

On 9/22/25 12:29, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.108 release.
> There are 70 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 24 Sep 2025 19:23:52 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.108-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>


