Return-Path: <linux-kernel+bounces-743488-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 51D42B0FF3A
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 05:48:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A6601C807FE
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 03:49:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAC041DE2D7;
	Thu, 24 Jul 2025 03:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="v4panOWu"
Received: from omta038.useast.a.cloudfilter.net (omta038.useast.a.cloudfilter.net [44.202.169.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52ABF4C8F
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 03:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753328923; cv=none; b=s9rK+yrCkMir1kPHgPd8KydaBddQAuIpglVuONvFbNcBBCIEAO5AiIRxTJTSa8MfH3egz6wWZB1pbi+FXghscDPMEWdadeTtI3vrKeUdwcUYhCNsZF7hhK6I8UMgRDci1/nad00RyrqKvBPG7XP7IlZ0i6AXTeHJFnqvzpSpzow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753328923; c=relaxed/simple;
	bh=H0tBM7zoukl/CfcYJ0dSST41IE7bVr8Hub0As0Nr0po=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qnMm5SgOu67MkIVjQDcHrDC74bCxzUo2CI2fUNqR0d50vfDgA81FSJozhJJOdFC4t3YP0H6xkdlrWSy/Vp27H+uLp8kA6qJD9sjiDzHW4ym3pCkWl+3x/o9xZZDcx+HzUyiz6YYx4+6Xq2uhTjsN8HgDVHlcv+LL6z6FPJhm/O4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=v4panOWu; arc=none smtp.client-ip=44.202.169.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-5001a.ext.cloudfilter.net ([10.0.29.139])
	by cmsmtp with ESMTPS
	id emjBufmM6iuzSemwbut2e2; Thu, 24 Jul 2025 03:48:33 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id emwbudhMXNVlHemwbunQ8f; Thu, 24 Jul 2025 03:48:33 +0000
X-Authority-Analysis: v=2.4 cv=FOPQxPos c=1 sm=1 tr=0 ts=6881ad11
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=7vwVE5O1G3EA:10 a=VwQbUJbxAAAA:8
 a=HaFmDPmJAAAA:8 a=CIo_2QJ3nJB9J6BkDI8A:9 a=QEXdDO2ut3YA:10
 a=nmWuMzfKamIsx3l42hEX:22 a=Wh1V8bzkS9CpCxOpQUxp:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=jJBRnUgykqIJVCxscrZQ6+h/Jo/rwBJPqV0aq58gHM8=; b=v4panOWueFdtcZIf/A+Uyo+nmZ
	mzEA68xhXEAmX/qlr+iHeSKLeMkkN4gV8smCKqU8TUCDyk8EruZfrAxZiGF0N98dO6EFqsxpjLlDh
	tqTEXirGgyVpOy3BN9hpO7jfQ044sWLYy6NohWiVAwPCguqRl52MZ59ymQxWObC70KnvsO4A3CpUZ
	ocRuptVwr7XqrMDaMSRxoT0KEBb4U+bIMYqNFqBo+BY2rE6bclI7RHkQNUQdnTBn1ooI/u/WvScnS
	6SFfxqS0lF0O4CK26C4WuhFPvqRzHzELtNAlXxAvLlXjyiV+BqEp8CavnMeEfZZZIigzsmCb3Nr+6
	MedhpHVw==;
Received: from c-73-223-253-157.hsd1.ca.comcast.net ([73.223.253.157]:51942 helo=[10.0.1.116])
	by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.1)
	(envelope-from <re@w6rz.net>)
	id 1uemwa-00000000C9F-1KrE;
	Wed, 23 Jul 2025 21:48:32 -0600
Message-ID: <98a8b080-8948-452f-b7b1-d8b68a1755ac@w6rz.net>
Date: Wed, 23 Jul 2025 20:48:25 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 000/111] 6.6.100-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250722134333.375479548@linuxfoundation.org>
Content-Language: en-US
From: Ron Economos <re@w6rz.net>
In-Reply-To: <20250722134333.375479548@linuxfoundation.org>
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
X-Exim-ID: 1uemwa-00000000C9F-1KrE
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-223-253-157.hsd1.ca.comcast.net ([10.0.1.116]) [73.223.253.157]:51942
X-Source-Auth: re@w6rz.net
X-Email-Count: 54
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfE24+Kyi20Jl5fabFU2qivPXW6tj1SxWhgukZkCvq6TCCWj9x90fMEY3PbspHL9Myt2pB6pRgvIbhFKBtf66ENlsfXWhqXz5kdWg49u0enCY+8OimYFO
 cWcXoEgqyFrNr4SYqmVCFjBWGA7ZDNg6ksXv8ZIQM7ayof4wM//vLJ6cQFirrJvqWCOgZGlLLdDV8e4mkHv3dPCZVDBOHp804SE=

On 7/22/25 06:43, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.100 release.
> There are 111 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 24 Jul 2025 13:43:10 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.100-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>


