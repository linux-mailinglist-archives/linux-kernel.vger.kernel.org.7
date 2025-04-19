Return-Path: <linux-kernel+bounces-611366-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EAB57A940E6
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Apr 2025 03:32:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D57C1B6083E
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Apr 2025 01:32:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A96D3A1CD;
	Sat, 19 Apr 2025 01:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="4EXqeVth"
Received: from omta038.useast.a.cloudfilter.net (omta038.useast.a.cloudfilter.net [44.202.169.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBC09CA4B
	for <linux-kernel@vger.kernel.org>; Sat, 19 Apr 2025 01:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745026329; cv=none; b=N3uzHNk9/vwN2rSk90QFDDWS6hqsD6+VpVTuRFgkmGDgSQHFhfly1j3Cbis8NP3Pau6Toa1phkYOV8hwJMyaCU9KK9TBtaCs0ezlSTT4yNaa/uVwZjrmvcBFwXsr9hdDCGyKRc0fHx+AQMsoJvQvwvTVx8gNp4+CObJrmpOSZrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745026329; c=relaxed/simple;
	bh=qPjbiCSjqz8ihkJlOLWxCqKA+KpIjksKqM9Csuc6xZM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B060jr4oWv5wTFx9HzvXD0Tq4vTa7JJd00HcGDJ/5c1rzejdfWVo77YsywEWRtIzNCTelZbqp8hmbt9jn0FKbeHuFicQu7xPGRUj/yWkyIY+Pn3yAVKeuqcKh7N9BZdcc1pCPQuKdSnbJSHMgQ0+TI2OjRaaE/Sif6o6WXRPhao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=4EXqeVth; arc=none smtp.client-ip=44.202.169.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-6002a.ext.cloudfilter.net ([10.0.30.222])
	by cmsmtp with ESMTPS
	id 5UluuHnMbiuzS5x2Luu3br; Sat, 19 Apr 2025 01:30:30 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id 5x2LuZEKg1vNy5x2LuCk1j; Sat, 19 Apr 2025 01:30:29 +0000
X-Authority-Analysis: v=2.4 cv=VMQWnMPX c=1 sm=1 tr=0 ts=6802fcb5
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=7vwVE5O1G3EA:10 a=VwQbUJbxAAAA:8
 a=HaFmDPmJAAAA:8 a=49j0FZ7RFL9ueZfULrUA:9 a=QEXdDO2ut3YA:10
 a=nmWuMzfKamIsx3l42hEX:22 a=hTR6fmoedSdf3N0JiVF8:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=kl0q6hsj3AUZq15zeV3/5hNW67aXghIpkSANITAQW7I=; b=4EXqeVthJZPPEcwJXJ0rRizc/s
	yJx5PTKpzRWhJPxls77kD7C016Lgo7xJS9xIJFlMppnYyCye8vruCmTjBQqWfUcr9Cw4rkjzOcszZ
	OFRT5q6lcvaS0NbEds62Kehlp6UDd8uFbkWCDlXfojo6yufbBSA68far6xv3juurIp85piZDHldsc
	GSKGFaVpr9qvoXD1dU1hFhvvaPoV2DrGFmGBouqnXbyztnVCEXlLnAVf9uTg4NY7Gz7QD9wK7EZTh
	KV+ME5qImnss4XHwtm6qYm7ogiaEOG/WYRGDBmV4Mu9x5eJqOhW2Wyng2fyMydYQ//R2zjqWGdepf
	vP7LqWSQ==;
Received: from c-73-223-253-157.hsd1.ca.comcast.net ([73.223.253.157]:37272 helo=[10.0.1.116])
	by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.1)
	(envelope-from <re@w6rz.net>)
	id 1u5x2J-000000005zk-1LMY;
	Fri, 18 Apr 2025 19:30:27 -0600
Message-ID: <f4647dc7-2349-44cb-8576-25e41af1c9d2@w6rz.net>
Date: Fri, 18 Apr 2025 18:30:24 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.13 000/413] 6.13.12-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250418110411.049004302@linuxfoundation.org>
Content-Language: en-US
From: Ron Economos <re@w6rz.net>
In-Reply-To: <20250418110411.049004302@linuxfoundation.org>
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
X-Exim-ID: 1u5x2J-000000005zk-1LMY
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-223-253-157.hsd1.ca.comcast.net ([10.0.1.116]) [73.223.253.157]:37272
X-Source-Auth: re@w6rz.net
X-Email-Count: 35
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfEhe7V1Aagim2rUvWlsxpW5prSpJazwldu/DpFpIGBeron0WYE+Uzk/lQ9uzZ95nu+CJXJjbvWt/Q1rEZgPgIWYn42nsaOgX8yeDIyP2drIqJ37nlmwK
 GxRM+8TQIHC/3vDW3Sv4l0OZPHCLVwRNO1M6A+X3JMDsEl5vKcbqAqz1U1RGwUd5XohSIEUwEvFViWNS+kN+BNv1c0JxffGLN/w=

On 4/18/25 04:05, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.13.12 release.
> There are 413 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sun, 20 Apr 2025 11:02:49 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.13.12-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.13.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>


