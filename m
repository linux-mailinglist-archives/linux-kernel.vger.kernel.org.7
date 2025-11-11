Return-Path: <linux-kernel+bounces-895501-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 72DB4C4E1C4
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 14:30:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BDE224E4FC6
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 13:29:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 163593AA195;
	Tue, 11 Nov 2025 13:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="eMH7JEr8"
Received: from omta38.uswest2.a.cloudfilter.net (omta38.uswest2.a.cloudfilter.net [35.89.44.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54D34328277
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 13:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762867792; cv=none; b=NLHTC3idRHUPVHvajzTrKmwfq5hwSe2qoGguizGEozGoHy4KN7Yx8xQL9nNA7XxBdKSvM7QRWpRKW29nDm+c3olRvs0wqONSb3cdxU8uGKVN3J2BS+bMqi+gNyrNWQWQJOwwNLitw+xOYhlL3J1OgkV5O87bTWZJe8G5cVlbGJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762867792; c=relaxed/simple;
	bh=c7hoMpsZ/baVmjPyu5d2MW13scjJuNdlGhc8XNhuo2E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O6xHgkZULcfDYqgxMbbsj5KkOVUuyfM/yP9rFQX9AA0zXY/v3hpXUitb98R4FX/Ndt50CLRpwOlUWjChzo6jZM3twG/ARyy1daozM9+NpDdSihvF0n8bH6/yWgLCfuYW4DUwDB3UVldD4gspVoIZZxaj3eKNhkpeanWoB3OZ6GI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=eMH7JEr8; arc=none smtp.client-ip=35.89.44.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-6004b.ext.cloudfilter.net ([10.0.30.210])
	by cmsmtp with ESMTPS
	id In6hv6sFZeNqiIoPsvVL8g; Tue, 11 Nov 2025 13:28:12 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id IoPrvkPOmEQP9IoPrvF84i; Tue, 11 Nov 2025 13:28:11 +0000
X-Authority-Analysis: v=2.4 cv=MpNS63ae c=1 sm=1 tr=0 ts=691339eb
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=7vwVE5O1G3EA:10 a=VwQbUJbxAAAA:8
 a=HaFmDPmJAAAA:8 a=PvfcHcKs8vLJRUA1CEIA:9 a=QEXdDO2ut3YA:10
 a=nmWuMzfKamIsx3l42hEX:22 a=Wh1V8bzkS9CpCxOpQUxp:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=1nc8SKrnLXmD//D0Rk4ZCLqJKHJMABP0TbWA7r0yOH0=; b=eMH7JEr8ETFiBRX7p6jcZwOC8O
	fYli8+6MWQs/50JgiHfAXsXSKWSdLNsnMzRtUlpsPwh1yl4+lPdRWr9Jam328enF53Sdvixd0CIo/
	fcB80SLfz53/NU3RRu/7nPrCk+GK0nx/nockKda6mkbZw4f2Ykvsbjy6PIFmse34zbJCrgxk5u1SC
	qcQelPi0ca/FmUQwGOTccFwCUoNd2QYBLXTXeLrkjEYRaBU+4ormNnZgMaChbKU44BQI+iyhkDDkB
	qgHO8YMAqGTaqkAH6I7OrwxlzbVpf7EYK9/Xj6Jh+nMY1lylQGja4OGAgB5W6n3/p3W9o6si/n33i
	5G5YvpAA==;
Received: from c-73-92-56-26.hsd1.ca.comcast.net ([73.92.56.26]:36292 helo=[10.0.1.116])
	by box5620.bluehost.com with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
	(Exim 4.98.2)
	(envelope-from <re@w6rz.net>)
	id 1vIoPr-00000002Ewj-14oO;
	Tue, 11 Nov 2025 06:28:11 -0700
Message-ID: <e3b75b12-5306-4515-bf9b-f3605a11bec4@w6rz.net>
Date: Tue, 11 Nov 2025 05:28:08 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.17 000/849] 6.17.8-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20251111004536.460310036@linuxfoundation.org>
Content-Language: en-US
From: Ron Economos <re@w6rz.net>
In-Reply-To: <20251111004536.460310036@linuxfoundation.org>
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
X-Exim-ID: 1vIoPr-00000002Ewj-14oO
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-92-56-26.hsd1.ca.comcast.net ([10.0.1.116]) [73.92.56.26]:36292
X-Source-Auth: re@w6rz.net
X-Email-Count: 17
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfFw5+Bck1BmZcK3L63owh5fsj8DZKsDUX0P+ekFxtcN68I4MIZvmdlhiTtTrQKoO8Q3q4zP5zPshnrcefaK47ILeLuLocaeQ5PWeh0ZyDpr09pkftIWy
 ZD3nsCYHr+3xFgV+6qym73YStXJkFdLJD9H+Duqi66LCOg3xgGtCH9dTfFO5TeVIoZF5BKo2NphsyIDlN+2Us6CCFaHZRaIK1Zg=

On 11/10/25 16:32, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.17.8 release.
> There are 849 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 13 Nov 2025 00:43:57 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.17.8-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.17.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>


