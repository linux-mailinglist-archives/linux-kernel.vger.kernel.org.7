Return-Path: <linux-kernel+bounces-807230-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F050B4A1D6
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 08:14:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 493CA1BC387A
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 06:15:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A8702FD7CE;
	Tue,  9 Sep 2025 06:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="LpfGQQoo"
Received: from omta34.uswest2.a.cloudfilter.net (omta34.uswest2.a.cloudfilter.net [35.89.44.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C08482D8791
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 06:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757398485; cv=none; b=tbBjVyL93Bk07giSryg7AnAcugLqgF0XspqixKXFxK9BaXUs+vBVUMlt2cBp2XM/3NewmL2mFb2sVvCXxcjOKEmEJOmBwJe+7gigyHnIIGPmMiGDWOeSkV5CxLMkusKeWGpor3xVFqLDYTqGmBL7vR0Mm37Bm1OWb1PyH76aAdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757398485; c=relaxed/simple;
	bh=v/89VcX40cv5rPYAFtiLWLHb0FrP3KYzt/dEt23vyU0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f0kbuIl5Jh3X1Xjpf1EkVHVrlzscsqWuh1pnPAjDTRLUw2i1eAhdj2AbquCxiPOxW9413epbdZmvlitk/oHO0a6im27a9qf26vqNbZnDthlYXk4CsQ+/KSQiAlyQD9VAMk0s3VF4Y2/M9G74T+xCpFIiGtLczOp7v3dqfxcJ09U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=LpfGQQoo; arc=none smtp.client-ip=35.89.44.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-5005b.ext.cloudfilter.net ([10.0.29.189])
	by cmsmtp with ESMTPS
	id veHyu3sBWLIlMvrcpuPdNS; Tue, 09 Sep 2025 06:14:43 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id vrcouVAP9HNANvrcouivfn; Tue, 09 Sep 2025 06:14:43 +0000
X-Authority-Analysis: v=2.4 cv=UOHdHDfy c=1 sm=1 tr=0 ts=68bfc5d3
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=7vwVE5O1G3EA:10 a=VwQbUJbxAAAA:8
 a=HaFmDPmJAAAA:8 a=49j0FZ7RFL9ueZfULrUA:9 a=QEXdDO2ut3YA:10
 a=nmWuMzfKamIsx3l42hEX:22 a=Wh1V8bzkS9CpCxOpQUxp:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=QpNAaOlFSb97IArHZxEccTBaMZ5vk2xWmyRwpRZ8vfw=; b=LpfGQQooYL56yFLsa0r+lO0wsW
	30ZNQHdqrZr1Yr96lIEXwgUSS7QKb/uP5ultvqXj4SSoPQq9htN9TYy/GWtBZFjSl62e+zv08Hzl7
	O30mOyTn9VF/OiiPwanfxlXhtLjIh7yk/GI4u3NQCFEvsGVOsf1YazNF7ZKgZOpm4DTmQl9yqCS1N
	JpyhD9I06HRrWNYBzp4JP1BhG/zsUzWW4JVIoiTVxxR2XQRpxXpXWUESDIzEIph4tO4rzwVD/QK4U
	kJVixIhH/+dj0G0hcw665ItfiZLklWo/IyploENghEVTHAzTxU5TjTyRcm5iGGeGPqRXOjUnlPskB
	ZqUt6FYw==;
Received: from c-73-92-56-26.hsd1.ca.comcast.net ([73.92.56.26]:36498 helo=[10.0.1.116])
	by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.1)
	(envelope-from <re@w6rz.net>)
	id 1uvrcn-00000001x4y-2szu;
	Tue, 09 Sep 2025 00:14:41 -0600
Message-ID: <6612a382-b5dd-422f-beb8-5f20459972ec@w6rz.net>
Date: Mon, 8 Sep 2025 23:14:39 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.15 00/64] 5.15.192-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org
References: <20250907195603.394640159@linuxfoundation.org>
Content-Language: en-US
From: Ron Economos <re@w6rz.net>
In-Reply-To: <20250907195603.394640159@linuxfoundation.org>
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
X-Exim-ID: 1uvrcn-00000001x4y-2szu
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-92-56-26.hsd1.ca.comcast.net ([10.0.1.116]) [73.92.56.26]:36498
X-Source-Auth: re@w6rz.net
X-Email-Count: 37
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfIPlH3vJn6ldNQ8E8Mvs5U7E7mmXUJmh4q5/E+bobX59jLscQDVhS9Fwq47zzlCd1dyEadA5oY+/AQbHdIeeZzqiPYqcUsSQmV/+OYMrca/qYnUxTzIa
 3Hp2xK/MlvXa6MhNxmjSENw9wTeyC9roTseu7kMMYm+YRxucbiOQJwHeOJnBA3Ees/N0ZQ7PCZKEDHZM72iCl5MA+anxipSwOVk=

On 9/7/25 12:57, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.192 release.
> There are 64 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Tue, 09 Sep 2025 19:55:53 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.192-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>


