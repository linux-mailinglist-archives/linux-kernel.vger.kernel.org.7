Return-Path: <linux-kernel+bounces-873714-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7740EC147F5
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 13:01:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 49A8A4FFF72
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 12:00:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2899A31619C;
	Tue, 28 Oct 2025 11:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="oiqsT0q/"
Received: from omta40.uswest2.a.cloudfilter.net (omta40.uswest2.a.cloudfilter.net [35.89.44.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76D3C314D19
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 11:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761652796; cv=none; b=iGiLNIfhk9Us+xrw7nJXXvGvIjMlGb7UtMRNrtFBa4T2qvrfQpqlMv6KZB/qm+GLC5dvrxpQlaXKR2+FCqgRuvDyrBaYVECzoqUnAhoTNk6uYwGk+Q6KtMdzcplg73QHIryZCri5B3htuig1Rw+Sz0sWwKwcLTsinoiEBb2nqk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761652796; c=relaxed/simple;
	bh=V3Wwwzc9OvQSBcoohec1QVAUKsVR7MlPxbYb8/I3uEI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bThRlKUYkwCsAWw14mozv66pS1udTM5DNCjQAPdoFQuKRC03TqZ2L5VfsnDQTeJlU8KQp4ubrGoV7McXRATTRlBjvGWe8ZUSLP+Hgg++svfjOpbccxkew8oqg8Mpv3AXj7rXF+uYEH5Y4SMINsT4sfsHnMWLX1mQ9twWORotiso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=oiqsT0q/; arc=none smtp.client-ip=35.89.44.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-5004b.ext.cloudfilter.net ([10.0.29.208])
	by cmsmtp with ESMTPS
	id DdDZvyisraPqLDiMjvvMKu; Tue, 28 Oct 2025 11:59:54 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id DiMRv0ZWBHwAIDiMRv9ExZ; Tue, 28 Oct 2025 11:59:35 +0000
X-Authority-Analysis: v=2.4 cv=LbQ86ifi c=1 sm=1 tr=0 ts=6900b039
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=7vwVE5O1G3EA:10 a=VwQbUJbxAAAA:8
 a=HaFmDPmJAAAA:8 a=IZuGi3YAW1ZzDR9SpYUA:9 a=QEXdDO2ut3YA:10
 a=nmWuMzfKamIsx3l42hEX:22 a=Wh1V8bzkS9CpCxOpQUxp:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=IgyVbcgswd8Gzq5Qaxiho7nDwrU3LRcLk4xl7W0Mt8c=; b=oiqsT0q/sVoItqv1CKZIdkTN/7
	+ZvUxM2BbTov3gtpsh8FtktZoSjoLgpC4VEGpE8jXIwwix5Xw5oQg7XNRcbHxEeUzLF9lPLIXTWlL
	yaHac+wjEgfGP7IveWPbvnlP7ljyaNVe4GT8NylW2dKR66/0TxRNlic8kGbbmM5YsNOXcSMHSJ7dx
	BtWgFI78f0QnyPdeJem9OfjC717uZPA92E//kPBMzYVDR+b695T1lCafgd4ZcCLsOn6cvT+uqapKe
	/IBJ6VOYtG3qti9K0dgYHumzJO7eE8cqghi5lbfpXsiXA+HQUIxWuLM7Ws63wzGAxq57LxNC+wuLb
	2JxGf/yQ==;
Received: from c-73-92-56-26.hsd1.ca.comcast.net ([73.92.56.26]:40436 helo=[10.0.1.116])
	by box5620.bluehost.com with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
	(Exim 4.98.2)
	(envelope-from <re@w6rz.net>)
	id 1vDiMQ-00000002Flm-3cl1;
	Tue, 28 Oct 2025 05:59:34 -0600
Message-ID: <98586f40-96c2-47d5-b073-446f42af28b3@w6rz.net>
Date: Tue, 28 Oct 2025 04:59:33 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1 000/157] 6.1.158-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20251027183501.227243846@linuxfoundation.org>
Content-Language: en-US
From: Ron Economos <re@w6rz.net>
In-Reply-To: <20251027183501.227243846@linuxfoundation.org>
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
X-Exim-ID: 1vDiMQ-00000002Flm-3cl1
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-92-56-26.hsd1.ca.comcast.net ([10.0.1.116]) [73.92.56.26]:40436
X-Source-Auth: re@w6rz.net
X-Email-Count: 77
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfMUA7R4vOBrQGkXLElNbSvg98QPY6iqb3FpfU14Cygnh1g2JCPHxJa6+8Uso9vNET2xtOCfr1q+Ztci9m6DvI0qaEsIR/vnz/jWMlZUG/NC2np7cXKL/
 1WaOr37PBbxP2KYgnaLJUbVK/Y1ICNzx3j4vNN4dlAa67U9X4JK+lOZtzzcAF3pDXFZbhtViP1tQO40+lQ+JOHSMeT5+OS+HxR4=

On 10/27/25 11:34, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.158 release.
> There are 157 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 29 Oct 2025 18:34:15 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.158-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>


