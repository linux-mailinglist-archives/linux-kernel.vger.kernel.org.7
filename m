Return-Path: <linux-kernel+bounces-873699-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A16BAC1478F
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 12:53:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E61924EC693
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 11:51:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E666927FD74;
	Tue, 28 Oct 2025 11:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="G2nyqixh"
Received: from omta038.useast.a.cloudfilter.net (omta038.useast.a.cloudfilter.net [44.202.169.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB3BA30CD87
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 11:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761652280; cv=none; b=DSK9KKwysAq0mjRIyIh3dXuid+8kDdljM5MtWo+cNe+B12GAz0yF2vMB57nwcn/RfFel3vIFEoud6sr5qCNrDs/59c/ylhY9darHKHjEKg/PJxOtUduQuVw3szJA0rR4L9xxNYX0DK7OOs+0ge3Rq3SJTS2VPGSHuZxeBbVKH1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761652280; c=relaxed/simple;
	bh=FA24KbyXlHkSNjDnlij5cYhv6loEmd/5dDRVHJr3dQ4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ddq80LN1siU4pbogR0lnvUowVUrMPmoxKF8iApCAwAHsO5JVhcQoBeu/uwZF4oqrvx325Iuu4G53cG7TsWrsFV1aOVLwjGCRvRcZK8CoZUJbG4cd3kKzMMiKxLqq2UJLRLKMQu1crBIuW8sD1Kify9Fu6w/97ToIWnu+kxhYdT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=G2nyqixh; arc=none smtp.client-ip=44.202.169.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-5007b.ext.cloudfilter.net ([10.0.29.167])
	by cmsmtp with ESMTPS
	id DdWdvEJkQSkcfDiEPvAIND; Tue, 28 Oct 2025 11:51:17 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id DiENvabuOFPddDiENvd1ow; Tue, 28 Oct 2025 11:51:15 +0000
X-Authority-Analysis: v=2.4 cv=OphPyz/t c=1 sm=1 tr=0 ts=6900ae34
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=7vwVE5O1G3EA:10 a=VwQbUJbxAAAA:8
 a=HaFmDPmJAAAA:8 a=NZv-JJVNZ7gp_QotK4QA:9 a=QEXdDO2ut3YA:10
 a=nmWuMzfKamIsx3l42hEX:22 a=Wh1V8bzkS9CpCxOpQUxp:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=TqfalvD4g9sDc+z5rGZ0llaKTRI0iEvZ6aTIlcxMI5w=; b=G2nyqixhdhPKwMyYZCJCmM8rfS
	stM6e6BbjioVpcXHDdpBAZngKokN/fe2f6orD/pe3R9nOrNXOpzktcjgeYhp5j1JsYmrU8EhlojXS
	zdSJUbG4puHaBYSyCfTrCO7y6UZaGqfYE3NSHk2KjBCkPNVcmCr5exH1SB9wez4F1MVoShYOSPf0w
	/gPcaFmPmDeZfFxK3q9w9VftsiId5Rk7CkWjPSxWPgfk5eW0Xuc0TWy+lwVs+QTBB2iSd7b4HNVN2
	uWhFamFNPFyARSI0XgeEwZtRTW2VspkUWpEp2xUamXtu6Ars5VfYxSvD9iRwO1gSKJSqIybTiiDIM
	cmycKbbw==;
Received: from c-73-92-56-26.hsd1.ca.comcast.net ([73.92.56.26]:50822 helo=[10.0.1.116])
	by box5620.bluehost.com with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
	(Exim 4.98.2)
	(envelope-from <re@w6rz.net>)
	id 1vDiEM-00000002Bcj-3nEJ;
	Tue, 28 Oct 2025 05:51:14 -0600
Message-ID: <a53b3d74-4566-4505-9a3e-7584a8e78f2e@w6rz.net>
Date: Tue, 28 Oct 2025 04:51:13 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 00/84] 6.6.115-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20251027183438.817309828@linuxfoundation.org>
Content-Language: en-US
From: Ron Economos <re@w6rz.net>
In-Reply-To: <20251027183438.817309828@linuxfoundation.org>
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
X-Exim-ID: 1vDiEM-00000002Bcj-3nEJ
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-92-56-26.hsd1.ca.comcast.net ([10.0.1.116]) [73.92.56.26]:50822
X-Source-Auth: re@w6rz.net
X-Email-Count: 57
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfHpoX/cEbOPld3BEd4v2azl6PpSBeXjwUH5+6vDKBnC/GZVqosS+FyC2tAfXnJTiZfHiJpHUIJY2RR4nuawWHQ0PWFtVcAuDsyL5ijEE/JmMGDiWDT+f
 F6l2C9G2cvQwqD+9IL27uijgjNHluVm5J8x+GapujrcLXXACBcVwFkXEUVOnCugbXY96lAT9PNGEY4KD0KJzI6yB1ycjymCMLjo=

On 10/27/25 11:35, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.115 release.
> There are 84 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 29 Oct 2025 18:34:15 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.115-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>


