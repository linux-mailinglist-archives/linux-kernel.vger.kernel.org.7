Return-Path: <linux-kernel+bounces-895513-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id BF9AEC4E22E
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 14:35:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 70C704E2EF4
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 13:35:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90FC233ADBD;
	Tue, 11 Nov 2025 13:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="Z6tn8a24"
Received: from omta036.useast.a.cloudfilter.net (omta036.useast.a.cloudfilter.net [44.202.169.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8B1C33ADB8
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 13:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762868136; cv=none; b=H6NHNzgr60T+YubYR1So75uw46dr4W9Jiq9H+fSTNxWNeGAlmEdaaEl+PwHri1UEwBEDXfi4ODuJt4R76fRdscJZy/ZtvPc+vBVyQJ3bBgR0jFBZmJSib5bJNzpE9vcKIfnbWYTLQQf22z44r2d7TnkRCNl9XKtfzcuY/myxTRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762868136; c=relaxed/simple;
	bh=z3ZXIvYXjsVZ1cD1nGTaG3KtjR212/GOPRxgC4R+gjA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SgCVcLPRMxjmcdCjP9ez5TP1o4U4YEr/adKpKXSyhD0VfGyU9wXZA2uqNElIQ9l7JHNcCJv27dzR0wvYIDozIYy1Z86EwizTaetQ8IXo56ylI1IijiBAkwIj2i1u/iTPlNshxI9bl3AAa8Q9gxj04fU8rqbw+UZevYwoYsTNHeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=Z6tn8a24; arc=none smtp.client-ip=44.202.169.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-6002b.ext.cloudfilter.net ([10.0.30.203])
	by cmsmtp with ESMTPS
	id IjLevOTBOKXDJIoWyvW0sH; Tue, 11 Nov 2025 13:35:32 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id IoWyvYmMK74Z0IoWyveuAn; Tue, 11 Nov 2025 13:35:32 +0000
X-Authority-Analysis: v=2.4 cv=BuidwZX5 c=1 sm=1 tr=0 ts=69133ba4
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=7vwVE5O1G3EA:10 a=VwQbUJbxAAAA:8
 a=HaFmDPmJAAAA:8 a=RevD4IuIZOIosi7Z3eEA:9 a=QEXdDO2ut3YA:10
 a=nmWuMzfKamIsx3l42hEX:22 a=Wh1V8bzkS9CpCxOpQUxp:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=lbR3b93pZJ23GTDhYqz9VgVXdiNorbDVnSQIsSbsXBw=; b=Z6tn8a24re9S72cM8gmbYrfsV3
	iFti/DNsI1OJkOaCuRuiWQ2Nyj97U4sMSqNGZ/rUMxmdywC6DxUr83wfQORBIVTs9PrSWqgP0n/c0
	OoftoXYS3HgoQPf2s7seJDlkQXsIRV2TEMtXvJc3muPae3OKkx1NcXvNFs6oO/+e+bwe5hVCcEtEr
	cdeeTeVTuS3/dsmUw5h149ckTEbywovW6NqZuBd+1Ug8t6J7flvahipsfpCj/h8SlmFm6SaImq2n9
	xd8rlzEGcJnc6OkgT94dyXJYB31NnEaPTzcYcDyRki4q0m4Zkl74TmZPX7Jcvb/N95S0UJqzxc+Kl
	td7aGZHQ==;
Received: from c-73-92-56-26.hsd1.ca.comcast.net ([73.92.56.26]:40038 helo=[10.0.1.116])
	by box5620.bluehost.com with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
	(Exim 4.98.2)
	(envelope-from <re@w6rz.net>)
	id 1vIoWx-00000002Kut-3fZy;
	Tue, 11 Nov 2025 06:35:31 -0700
Message-ID: <8b790183-00cd-4dda-82a9-0988eda9e6d4@w6rz.net>
Date: Tue, 11 Nov 2025 05:35:30 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.12 000/562] 6.12.58-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20251111012348.571643096@linuxfoundation.org>
Content-Language: en-US
From: Ron Economos <re@w6rz.net>
In-Reply-To: <20251111012348.571643096@linuxfoundation.org>
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
X-Exim-ID: 1vIoWx-00000002Kut-3fZy
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-92-56-26.hsd1.ca.comcast.net ([10.0.1.116]) [73.92.56.26]:40038
X-Source-Auth: re@w6rz.net
X-Email-Count: 37
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfBo489tv5oaWDUf6ZShzHMJyqDR37sPdcYNhJqd939PQIeaxk5cKy40vewEbPWbP7ETjj2StfBS0XrOcvt0pvHHff71kPbaiYL0O+edg4EhJ+5TVGksf
 nTkGpJ4BKQj5EoyDI8BOnXFGJju695/Zyq0l56tcv2wfXtmgNURto7AVBhP/jkImVLVR4SslOrZPdX3mQLfah2BA3+9Hr5KgxtY=

On 11/10/25 17:24, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.12.58 release.
> There are 562 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 13 Nov 2025 01:22:51 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.12.58-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.12.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>


