Return-Path: <linux-kernel+bounces-864722-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 76EF4BFB682
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 12:29:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0218D3A5363
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 10:29:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 247DB30506E;
	Wed, 22 Oct 2025 10:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="y3QI+7ST"
Received: from omta34.uswest2.a.cloudfilter.net (omta34.uswest2.a.cloudfilter.net [35.89.44.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96B3127F75C
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 10:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761128968; cv=none; b=E2j+DkAWmVtTmCg3R0ItTwKfUp4EPr1cToS9FWkkGkH/bdgCrL0ii9rHa4B5kzR1p5tPPTQq8pVyKGKFqKC/ZlWRqcfq2eZVgi5qGk8vc3yQuzDJlpAO0ic5PHNgeJdteLXA/Y0jpcdXAy9LaGeEQsRYTwk6p68av8RG5+Lg4WE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761128968; c=relaxed/simple;
	bh=Zimn/1Fq84om2vqJsWEkiigEFXiZgionMvk2QSRsJnc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AAJ43X7r5csfuL7eGYTC8N7w7G8iBcEbQber4dtiOyfij6uPzC7TaWQTP8JxKiF3sob81vKfspd1XaJ3frmRnevAMk3WUiG7jrNf1nRsh3nP9SHMuELC4I3N/h7eNhK0F9OTjDqlY2zUkfuICA5y7KJQuITjCMHW/+XaMZMKQu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=y3QI+7ST; arc=none smtp.client-ip=35.89.44.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-5003b.ext.cloudfilter.net ([10.0.29.155])
	by cmsmtp with ESMTPS
	id BP52vpqeQZx2iBW5nve458; Wed, 22 Oct 2025 10:29:19 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id BW5jvT3MZtssbBW5jvb7d0; Wed, 22 Oct 2025 10:29:15 +0000
X-Authority-Analysis: v=2.4 cv=Hb8UTjE8 c=1 sm=1 tr=0 ts=68f8b1fe
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=7vwVE5O1G3EA:10 a=VwQbUJbxAAAA:8
 a=HaFmDPmJAAAA:8 a=49j0FZ7RFL9ueZfULrUA:9 a=QEXdDO2ut3YA:10
 a=nmWuMzfKamIsx3l42hEX:22 a=Wh1V8bzkS9CpCxOpQUxp:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=6ZOJAY3MKdpOLhjm1I4FmgYvdhlyJ6vz+M1+6V5uxms=; b=y3QI+7STsfiIAdFSrBpMbQE1B7
	KZNEN+X9+a9mrxiT8PFz2S+sI3tURcYTZwWR6yuEFtYm2a8dO0pY6+Ck43JHahMLe2pNN9TS4nV3t
	u5F31/WsjcbCm+P4Liw+jnKfAp1pArqLh7za0MHwdPxJFtZa67ntCtIDHq56fop2cIIcTHDQB8V1K
	xgaeKlzPsFMfDQIJTMk1zSxtZ+m2PW4d5sz8R+VrWbD7RD+4uJZVPhBCgEA76++tyGZC9ep8RpZF/
	ZEr6xu1F5E8FihSuPhWMei5GDA49Zt6WqW7Tj7jxjaMpXacHPOme59YJ2/fA780ENSZylhjfO0DTU
	rvQDYylQ==;
Received: from c-73-92-56-26.hsd1.ca.comcast.net ([73.92.56.26]:55486 helo=[10.0.1.116])
	by box5620.bluehost.com with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
	(Exim 4.98.2)
	(envelope-from <re@w6rz.net>)
	id 1vBW5j-00000000kMb-0bOh;
	Wed, 22 Oct 2025 04:29:15 -0600
Message-ID: <cbc91031-eddd-410c-aaa2-6d13b3f5afe0@w6rz.net>
Date: Wed, 22 Oct 2025 03:29:13 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.17 000/160] 6.17.5-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org, achill@achill.org
References: <20251022053328.623411246@linuxfoundation.org>
Content-Language: en-US
From: Ron Economos <re@w6rz.net>
In-Reply-To: <20251022053328.623411246@linuxfoundation.org>
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
X-Exim-ID: 1vBW5j-00000000kMb-0bOh
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-92-56-26.hsd1.ca.comcast.net ([10.0.1.116]) [73.92.56.26]:55486
X-Source-Auth: re@w6rz.net
X-Email-Count: 16
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfLTgewU4xRMfeCpIywxGrIq00BDvLtqILJOyKOz2VftIUa/JlMCKeEaG/YYBSLdljiOQzaDfwbjm/X4WBISdr4iy81LJJjte3yU373opZB2MXTwi8hQQ
 Sgugx94Jwz/WDGkROAUg1w2SCnX2Jy5fIFkdi1nGqxQyCwH32p4bwrRz4I2Dw7LglBIIFwwL50UEsxdzjXHO7JBw5/qNowJ2OK8=

On 10/21/25 22:34, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.17.5 release.
> There are 160 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 24 Oct 2025 05:33:10 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.17.5-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.17.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>


