Return-Path: <linux-kernel+bounces-852755-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 985FFBD9D02
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 15:52:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0AF514E3E1B
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 13:52:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC4C52D248E;
	Tue, 14 Oct 2025 13:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="hCLfVjke"
Received: from omta40.uswest2.a.cloudfilter.net (omta40.uswest2.a.cloudfilter.net [35.89.44.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58FF2749C
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 13:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760449927; cv=none; b=hMsNuv29CTmrDba7CoNtQsXdD5yAF+s6wuqGtDEdhnoHfHzdkNLFLQr9ealb6oNcFuzB23L9p7JIwtonkgISJeSuta3r5p7MUuVxubR7QtgltiC5z5AY86RcePTYKTLIX7bDDnHPjDV0B5ttoZCxQd6mT/ELg+nkbkjboMGofRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760449927; c=relaxed/simple;
	bh=nskP0eqzPM3FOd7xn+E9e/Vv+U70RRfZHhzrNk11I/E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dFbkzYGnb0xS92ZQmutj9JEpTJMgV468rgewmtC6JEP5S2tatgLW+UXQwBD8O9P+hIOiPPXeupFL/q9oLuWCZvRZZKqZGqkayYRw86f1yTBi4Ve4lSKz2UtnjI5jNYUqRKFd/1GUqh8C8Me+5stL/xtcWsUNgyPImj5BCidp7E0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=hCLfVjke; arc=none smtp.client-ip=35.89.44.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-5004b.ext.cloudfilter.net ([10.0.29.208])
	by cmsmtp with ESMTPS
	id 8aQ1vwscSaPqL8fRXvjUq7; Tue, 14 Oct 2025 13:51:59 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id 8fRWvw9QVBc9y8fRWvFZG3; Tue, 14 Oct 2025 13:51:58 +0000
X-Authority-Analysis: v=2.4 cv=ZcMdNtVA c=1 sm=1 tr=0 ts=68ee557e
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=7vwVE5O1G3EA:10 a=VwQbUJbxAAAA:8
 a=HaFmDPmJAAAA:8 a=7mImUwZGDDb17UAjreoA:9 a=QEXdDO2ut3YA:10
 a=nmWuMzfKamIsx3l42hEX:22 a=Wh1V8bzkS9CpCxOpQUxp:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=cD7Tb49ErmVJbMd2cXxUa/ewmY8h9WSczri/nvNIydo=; b=hCLfVjkeC/B51l4uVyTcIb1rId
	pvtVzkAhKmLb2+tPliNn0oELZgWncrw7dPgqoICWOYDjB85vq8ngqb9kQ4Mev4Uu02MFR2SPQS4m4
	ZzlJ8D4QcJxspyccBc5cUWqRMHzmokJzUI48fscZfcM3Y8rYlJR/loFCTJZH9PL0r/BSN1R6C/5r5
	pIXilyHfKfrIFFQ5oLbCJv91+5vvum+x4TDp4G8JVUrzFRpfORapxVdOduoF5HRSJJVceomIrbxgb
	e0cJxB1HZqTpIMgi3FNolJxlbLZmj5NFjGC9UMTnDJzLlddZLAN5ZJmKhCmgRQ9Qnklo91SpuyhHy
	IAMBLy5g==;
Received: from c-73-92-56-26.hsd1.ca.comcast.net ([73.92.56.26]:36628 helo=[10.0.1.116])
	by box5620.bluehost.com with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
	(Exim 4.98.2)
	(envelope-from <re@w6rz.net>)
	id 1v8fRV-00000001iHZ-43sO;
	Tue, 14 Oct 2025 07:51:57 -0600
Message-ID: <8ca3a16b-2eef-4e9c-9ff2-f13819829cf6@w6rz.net>
Date: Tue, 14 Oct 2025 06:51:55 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.12 000/262] 6.12.53-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org, achill@achill.org
References: <20251013144326.116493600@linuxfoundation.org>
Content-Language: en-US
From: Ron Economos <re@w6rz.net>
In-Reply-To: <20251013144326.116493600@linuxfoundation.org>
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
X-Exim-ID: 1v8fRV-00000001iHZ-43sO
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-92-56-26.hsd1.ca.comcast.net ([10.0.1.116]) [73.92.56.26]:36628
X-Source-Auth: re@w6rz.net
X-Email-Count: 16
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfBstJSCymvkS7TN7f/NIL2VVHblfiUkoC1LXOwvHJXYmWM1hJZBbdG4EWCNsr7zYmA8Z7vIR8gky1wZZr20E49J9YM1q685tVNVw5+VSAZCYjSvHhqdr
 3CN/iuBr/GRaKzOV+L5Av1h8wtb5aF3RrTvYEt8wvd6HYItV6FaIswR4+xacvFMNxqRYA5fCdLfgdnwHpYisg8WRcBeNyxIdclg=

On 10/13/25 07:42, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.12.53 release.
> There are 262 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 15 Oct 2025 14:42:41 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.12.53-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.12.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>


