Return-Path: <linux-kernel+bounces-641046-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F0BFAB0C67
	for <lists+linux-kernel@lfdr.de>; Fri,  9 May 2025 09:56:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C9EE01C257B7
	for <lists+linux-kernel@lfdr.de>; Fri,  9 May 2025 07:55:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80931270EAF;
	Fri,  9 May 2025 07:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="TYeVB0Ot"
Received: from omta36.uswest2.a.cloudfilter.net (omta36.uswest2.a.cloudfilter.net [35.89.44.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC63E26FDBF
	for <linux-kernel@vger.kernel.org>; Fri,  9 May 2025 07:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746777283; cv=none; b=hLD8Qr5EwEFszydd0wnszQEF7UFOBk3PVUQ5KDZPPYg08ikf9fn6bsuuauliYYFgv1HKUZ/iTRteHS9mVfXfKYygY+2FyUA7tGwtz0W4njNFynr54EblbOZn4Cv38HZhwS+4Ha4+/bJLywlvez/S3IKqYw450Mti8wIv/Eli5m0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746777283; c=relaxed/simple;
	bh=tb4ULi36q+8ltli9vtrfLqeikDMUVSKj0HvmRveWUGE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZQyDK+ssFGLToYIpbI319M3LLtDUQ0j1/pqCkdZnPLTNawkmkLnbrRUyw76w4w46G/Re3zUHww1kzZIg8YVQC7GxkKUFzn3PBKWvlWwMM9r4626JGTTP2HFj7nnbxf8j2vz0bwKQq95jZVP8P4rsNzK7jfHBID2m/oZno0qdaqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=TYeVB0Ot; arc=none smtp.client-ip=35.89.44.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-5005a.ext.cloudfilter.net ([10.0.29.234])
	by cmsmtp with ESMTPS
	id D1Oyu479SMETlDIZ6uYAcR; Fri, 09 May 2025 07:54:40 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id DIZ5uUnAIq3CNDIZ5uaXTd; Fri, 09 May 2025 07:54:39 +0000
X-Authority-Analysis: v=2.4 cv=VpfoAP2n c=1 sm=1 tr=0 ts=681db4bf
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=7vwVE5O1G3EA:10 a=VwQbUJbxAAAA:8
 a=HaFmDPmJAAAA:8 a=49j0FZ7RFL9ueZfULrUA:9 a=QEXdDO2ut3YA:10
 a=nmWuMzfKamIsx3l42hEX:22 a=hTR6fmoedSdf3N0JiVF8:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=p17hkO0iKcT3a67cQEYs1vSQuRPWlYK1unAbrH6d8pg=; b=TYeVB0OtrjdiKqAz/DxCpjzNmv
	5Ai+6MxwWkLzYETLDMxna9/veRAZmgGueZlN1lzp7HYKjWZ2cGVW5KWMYO9uEnb5+kQUxv4DNQrDA
	5lawv2Zde7l7rM+HXdRiApZrenBOeQUuYWxXd17X4NXdHz9T5aLeUM/OxmiXj4lxJx1qUNf/inwTS
	2FPnM4PKE3Ied4sJbnOmS6IgBR5wanW5zXt4en+Gs1Ej6njUljYucYffRYZdIs8e5IFkSgZkPLaGz
	M4WGsaiT33+mKC8Coxlnhtg3bDvZ/vewsXMDYqTBJ/MGXZ+QucH3fdG5Oe2k71TYTiV3phLMV6Sp0
	/InzcVCQ==;
Received: from c-73-223-253-157.hsd1.ca.comcast.net ([73.223.253.157]:36014 helo=[10.0.1.116])
	by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.1)
	(envelope-from <re@w6rz.net>)
	id 1uDIZ4-00000002eTw-15kS;
	Fri, 09 May 2025 01:54:38 -0600
Message-ID: <8d1de745-8d0d-4762-b71b-49418d188cc5@w6rz.net>
Date: Fri, 9 May 2025 00:54:36 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.12 000/164] 6.12.28-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250507183820.781599563@linuxfoundation.org>
Content-Language: en-US
From: Ron Economos <re@w6rz.net>
In-Reply-To: <20250507183820.781599563@linuxfoundation.org>
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
X-Exim-ID: 1uDIZ4-00000002eTw-15kS
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-223-253-157.hsd1.ca.comcast.net ([10.0.1.116]) [73.223.253.157]:36014
X-Source-Auth: re@w6rz.net
X-Email-Count: 35
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfNMtE0l2nLXTwwM9QmwYh96sERVinKuWXx+mFK7vXJRFsshK5fQOXskTsE9iKCyMleTIGAXlg13S7qU65J7c0/e3Sw4zAYtdAPD4FOc/G0+rTy7uCRja
 7Afy8cPF41KvzR5YWq/qvM/lJATctHiNSuEV8NejmDDHDPCpd9OiilQFs5XDtYWKrTsHcDWxES773v6EisaecEfVQp7SmBD052k=

On 5/7/25 11:38, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.12.28 release.
> There are 164 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 09 May 2025 18:37:41 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.12.28-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.12.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>


