Return-Path: <linux-kernel+bounces-627954-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EF442AA56BD
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Apr 2025 23:25:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E83A1C2379E
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Apr 2025 21:25:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29A332C377F;
	Wed, 30 Apr 2025 21:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="eNKN4vIe"
Received: from omta38.uswest2.a.cloudfilter.net (omta38.uswest2.a.cloudfilter.net [35.89.44.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F6322C1E21
	for <linux-kernel@vger.kernel.org>; Wed, 30 Apr 2025 21:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746048123; cv=none; b=mQyup4ChR4yCIAiToi555T+U4UVTLtLYKpJlK05zr+RkuLscI3kChJ/O4nF1Og8PTNpUn3eCFhgKLc6WtIX3GngYL9sldd+E6LJRFgEDcuAQ7dHxbOlcnDAlo7Z/cM/MrukYGAC6CjqLnXQYGo+O+hr9wiLKrwBqslfwPpy/MZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746048123; c=relaxed/simple;
	bh=ggk7MT9GbwIM9Dqn2EHuGngwdbitOxrv0dj0Wh8WMGg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s50LbO+EYVwDCOUqyZt4ZP/RZoIGXphtrtpzef6W8iGcgxnnQismZaRbXkItpVICiYWRLFyaNNp2h8C+00sRcVdrAYfQ/D5d/NqfgA+UmoZ3b3gOHAML9+vc1qhcFlex7t0JJLi3xtn28QCgtxzn+LtWW+OTgViWrlgw1ti0Aq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=eNKN4vIe; arc=none smtp.client-ip=35.89.44.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-6010a.ext.cloudfilter.net ([10.0.30.248])
	by cmsmtp with ESMTPS
	id ADDIugevYAfjwAEsSu6GQU; Wed, 30 Apr 2025 21:22:00 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id AEsSuUET7tPfAAEsSuIaYF; Wed, 30 Apr 2025 21:22:00 +0000
X-Authority-Analysis: v=2.4 cv=RJy1HZi+ c=1 sm=1 tr=0 ts=68129478
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=7vwVE5O1G3EA:10 a=VwQbUJbxAAAA:8
 a=HaFmDPmJAAAA:8 a=X_drXzbwcQU-ujxrCA4A:9 a=QEXdDO2ut3YA:10
 a=nmWuMzfKamIsx3l42hEX:22 a=hTR6fmoedSdf3N0JiVF8:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=1IPnMfGp2/0IsT7dNFlU3dqkmzJ7tISbUOL75eLtcNY=; b=eNKN4vIeHstTE8Nw4PXxlZ/xz3
	uiiJbvtS2cripnSWPRGw0QaPmF6LDckS++8AD1u0SDSCB3HnrGp37MG4iwi/ei0dYot+XoBqKqwUK
	BLS8nHyYkKO/wcHimRr6HKLwsvYPzeQaoPeTDSyDpGT68u/nD/q23DlHAuhq+CO07H9NaBfQxb+v8
	WktkOLh5S/3fWzSOn0dyqDTyQbzqk07UfPLPW6JgpxchWmtAmxK5OXCyBPsEfLfwkcb/Q8ezAp8U5
	8+SMSh5nw6L/0ii2yBST8RWH+s3kbk7BQC6+KGwF8G1Rn1C7295sGWhYgLXwHRXTopz+ffJ6jw6y0
	wl2Pd3uA==;
Received: from c-73-223-253-157.hsd1.ca.comcast.net ([73.223.253.157]:59904 helo=[10.0.1.116])
	by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.1)
	(envelope-from <re@w6rz.net>)
	id 1uAEsQ-00000000ZUn-1ugu;
	Wed, 30 Apr 2025 15:21:58 -0600
Message-ID: <77815016-c513-4f7d-8af9-07cf263df16b@w6rz.net>
Date: Wed, 30 Apr 2025 14:21:54 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1 000/167] 6.1.136-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250429161051.743239894@linuxfoundation.org>
Content-Language: en-US
From: Ron Economos <re@w6rz.net>
In-Reply-To: <20250429161051.743239894@linuxfoundation.org>
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
X-Exim-ID: 1uAEsQ-00000000ZUn-1ugu
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-223-253-157.hsd1.ca.comcast.net ([10.0.1.116]) [73.223.253.157]:59904
X-Source-Auth: re@w6rz.net
X-Email-Count: 73
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfCwf6KS+U2d6VQhEOF4ce5MzbqhoZtTDiX7/la9ZynYljj9ZJtnm9aj2lULfsfq0fCqYMXh/FuZt0ulC1GEcQZIyRM+O5C7dYE8Nv19NFYKdeKB8BesU
 rfGMe0RcimSLEzCjbAzZ1mTo7+qqizF3dcDSHVlq2u7tsZi7nfVL7mcUYXxAYHmnKRElDB21I2TTXuNm8t3ECDhsmouSU86tEmY=

On 4/29/25 09:41, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.136 release.
> There are 167 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 01 May 2025 16:10:15 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.136-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>


