Return-Path: <linux-kernel+bounces-787978-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6531EB37E58
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 11:07:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1651B3B0387
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 09:07:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCF8D33A023;
	Wed, 27 Aug 2025 09:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="3oHQmmcJ"
Received: from omta36.uswest2.a.cloudfilter.net (omta36.uswest2.a.cloudfilter.net [35.89.44.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C6C0340D9C
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 09:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756285671; cv=none; b=nv6SjhN1z2wO+ioYz+vfFNyXQGUbLF6EJbke/pnLEDM+jbhfSrvxoo9a07ClPWARn49rgubjL24tUbKOKl0SDwKmEFRUAHEPkC+5AtJ1/nGM1yY8xckEvZB6yAlO520On+sK6P+7H5EaJ7sdDZ+6lWwLk7zBFAtSLm8umIc/xjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756285671; c=relaxed/simple;
	bh=klb05lpdI4kaKBVrc0TwPb7cdhRmkZQDYnxWizwMpkY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=roDV7d6Ydj0C1d0YuXTMXxL/8YUbaaImZnTFjmI7cM3HZ4HH1/oDQ3uUlrv41zn7Jx6LjnMAt6SJg2QAagIpW6HYN2mGvgc+P7kKd8Oe8YfMc/ppe0AE3TGIY16kZzoAWSm6QTENJN99ml7MD1D2vfxPQB9o9qVdXCp4vU1rMfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=3oHQmmcJ; arc=none smtp.client-ip=35.89.44.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-5005b.ext.cloudfilter.net ([10.0.29.189])
	by cmsmtp with ESMTPS
	id rAPquavjizNRxrC6eu4SbF; Wed, 27 Aug 2025 09:06:12 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id rC6euP5Bsb6dmrC6euU4l7; Wed, 27 Aug 2025 09:06:12 +0000
X-Authority-Analysis: v=2.4 cv=bs9MBFai c=1 sm=1 tr=0 ts=68aeca84
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=7vwVE5O1G3EA:10 a=VwQbUJbxAAAA:8
 a=HaFmDPmJAAAA:8 a=nDJXrlvuemic_4Ofhm4A:9 a=QEXdDO2ut3YA:10
 a=nmWuMzfKamIsx3l42hEX:22 a=Wh1V8bzkS9CpCxOpQUxp:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=HQQeENt7JHfYmG9hkaa7t21nor9vhOWUk1xWH/UFGhI=; b=3oHQmmcJxQMlHJpiYJpD2fQXXX
	a+A4TYT3oibobr6/U5qmOWSNe0g33mtxlK/AOvbRza7BaO4VKzjboD4sfxwu3e1aNXaOvQPFgQpRh
	rr7p2+q93TL5Z8Dmk5BHU9cfZIG6amCtE+KbfauVQp4pX3ZlaunzlU2nip8RCowxXvdrQaU/wQHBT
	xhspZK2etvYkYIfdJ43NbamWrq+wfhtOogVq745f+sXG3NOs2Zoby2x90wOoaD5ZhOmxZZyScoyaN
	uMUrs0EqKB86nAGnJgt1dH64yuJPtaIsImqtzFLwN8G8fIuZVBPE6RLDHHQu98k+8Q+2B8lwpwzTQ
	T46YQjew==;
Received: from c-73-223-253-157.hsd1.ca.comcast.net ([73.223.253.157]:49356 helo=[10.0.1.116])
	by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.1)
	(envelope-from <re@w6rz.net>)
	id 1urC6d-00000004AGp-1oJj;
	Wed, 27 Aug 2025 03:06:11 -0600
Message-ID: <ca193a08-1667-498e-a4c6-c579002b004b@w6rz.net>
Date: Wed, 27 Aug 2025 02:06:09 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.12 000/322] 6.12.44-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org
References: <20250826110915.169062587@linuxfoundation.org>
Content-Language: en-US
From: Ron Economos <re@w6rz.net>
In-Reply-To: <20250826110915.169062587@linuxfoundation.org>
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
X-Exim-ID: 1urC6d-00000004AGp-1oJj
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-223-253-157.hsd1.ca.comcast.net ([10.0.1.116]) [73.223.253.157]:49356
X-Source-Auth: re@w6rz.net
X-Email-Count: 17
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfJgrsBQMXqk90yPFmZRIQVCAdihohciVVtd9cNwTzalAIp2/I2HHcRFJ6cT9q0NImh8622FnAIXfnrv5C5KFrHVMxsiVd6rURMQl96m7FhEvbyhD3sJP
 p5MBSdlhk0OyT5YU7jaCpEYszmCkiOLkV1rEHdT2YmNMGl+rzyfTf+D/CQ+GeLo0uo7rSxJ1Yb7374UQ1/JsUyE/SEcDAahnhO0=

On 8/26/25 04:06, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.12.44 release.
> There are 322 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 28 Aug 2025 11:08:26 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.12.44-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.12.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>


