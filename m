Return-Path: <linux-kernel+bounces-691338-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC817ADE38E
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jun 2025 08:21:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 86BF817617F
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jun 2025 06:21:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CF5D202998;
	Wed, 18 Jun 2025 06:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="WKbnE0le"
Received: from omta40.uswest2.a.cloudfilter.net (omta40.uswest2.a.cloudfilter.net [35.89.44.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E30B1E3769
	for <linux-kernel@vger.kernel.org>; Wed, 18 Jun 2025 06:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750227694; cv=none; b=hRuw8AQwbIzJTRgQ6wEqKn09IAD7im8MhfpD1wPJpTC4rEnsb2QGlnMF8Aunr130TaTQ2IZjbGGHTzUMYD3BLRkFeO5hiRbdmxNG7gnHBr9xw+YHMy1Oi58sm2TrZcYHi173mElxW3fo8TG37QBUvgR7uYjGhwKbw5rTbSlnpHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750227694; c=relaxed/simple;
	bh=/wztygoLpBRgdvsL0AiTVhKIlMvYI46UtM4PRYaPe7Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ba0Vj8YVgrMtOMXrUcQmCqio6pAHIOl4H8EzlRj5mEFgY9k7BTMuTUKDCvu+ifxCe4jell4xFUQc1ilW2ITNhVuc9LKNbBrzFcJ66irkAP4sL+mFFJgs0YQjfpnCadGr4ikCv/SA703+7p0yP38OdFo0AVugI40CQl9Daey+8gQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=WKbnE0le; arc=none smtp.client-ip=35.89.44.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-6006a.ext.cloudfilter.net ([10.0.30.182])
	by cmsmtp with ESMTPS
	id RdPXuqsMBf1UXRm9MuK96L; Wed, 18 Jun 2025 06:19:56 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id Rm9LuHAcY3kpNRm9Mu87er; Wed, 18 Jun 2025 06:19:56 +0000
X-Authority-Analysis: v=2.4 cv=HLLFFJtv c=1 sm=1 tr=0 ts=68525a8c
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=7vwVE5O1G3EA:10 a=VwQbUJbxAAAA:8
 a=HaFmDPmJAAAA:8 a=TPakyfmQPUc9YFHtHfAA:9 a=QEXdDO2ut3YA:10
 a=nmWuMzfKamIsx3l42hEX:22 a=Wh1V8bzkS9CpCxOpQUxp:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=6O5bFY5lZZfH8gNd0u5vX+k9wjbquMfywNiJ7+nQpXE=; b=WKbnE0leviQGHgJ7m5nvZ0Void
	gvCXScp9UpFSK8Zv8ltYQKPbAA9CZPEwC2l4a7CZHcpdTOsLun4/wvDCtcaAWMs2dUJKBhq5N4tbs
	OXXpmRHzg9z1HpYFHUZWC4bfAai5RmkKcogjgCxwomwvmn6U43+1iCBZmo1II+mIIkKmWSn/fxr4C
	M7u5pRFPaVYOTz7tLM/zBRnddkDaepOnMkOP8dCiM7W4zx5/k2UsyCUcHxAEUTNIBBChuRfJGv6kq
	dT3n/YZPVyFnWF5KZAx3paOFg7sdPU+uZrCT9pYRalc+/WN5is/9aZiXdMjVn7wMwyIn72i8DcQFk
	Zoe487MA==;
Received: from c-73-223-253-157.hsd1.ca.comcast.net ([73.223.253.157]:60758 helo=[10.0.1.116])
	by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.1)
	(envelope-from <re@w6rz.net>)
	id 1uRm9J-00000002ozv-1d29;
	Wed, 18 Jun 2025 00:19:53 -0600
Message-ID: <ce4000c9-a038-499a-9a98-0910619fd30a@w6rz.net>
Date: Tue, 17 Jun 2025 23:19:49 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.15 000/780] 6.15.3-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250617152451.485330293@linuxfoundation.org>
Content-Language: en-US
From: Ron Economos <re@w6rz.net>
In-Reply-To: <20250617152451.485330293@linuxfoundation.org>
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
X-Exim-ID: 1uRm9J-00000002ozv-1d29
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-223-253-157.hsd1.ca.comcast.net ([10.0.1.116]) [73.223.253.157]:60758
X-Source-Auth: re@w6rz.net
X-Email-Count: 16
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfNqbc5zqd9BMR91ff+tRkjEP9hbAa5mXRi/czhPk5cSVyOrgObIcIx5QI/2dklXhB3YyunO32Qenv0zcpCo6oYQdeFK+fKJNTpDwfpOAUTMWH3vwht9B
 ie+o378jmuFAhMUDa1YG90ztrmXxDwb0oVzOFxC7MQg2zUI7rgHl0I/fC/f31csr/Q0AWVNqmljNjJujC3G/PKKP7YNJGxyg1vY=

On 6/17/25 08:15, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.15.3 release.
> There are 780 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 19 Jun 2025 15:22:30 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.15.3-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.15.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>


