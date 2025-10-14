Return-Path: <linux-kernel+bounces-852373-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38606BD8CAB
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 12:43:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E527E3E2A67
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 10:43:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC2972F90DB;
	Tue, 14 Oct 2025 10:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="AVpJFSV9"
Received: from omta036.useast.a.cloudfilter.net (omta036.useast.a.cloudfilter.net [44.202.169.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B9BA2D24A6
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 10:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760438595; cv=none; b=dRz9+uiwGMfLHS7TuMF+Udw7BnoWm2mR5UXsiCrkhFSDiabGznZsBtdHxphKcztj/KjpbmnhENKJ1gTVNPZKWEVQd2JqEWl5V7Ol/S8eqX9nFQaRcbwkcwldDH5nhuBaLUn2GTnAvxjihhGt6u+uNrTSkY8TErBafRaimHfSvbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760438595; c=relaxed/simple;
	bh=X4ArcTDo3QAYeumeDhzl72JVM2zKvNb2aGAWhmdQPEY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jJsWJGOkyEHQX/08fhc2K5pKXnhN5oXaJ4LAHyP6mdxCvA6OCOj9I4ZaxR5zC73rIlY9KXUskltmK4cs4l6Ysl+NbCRQx76sRz+0uYL5QK/4YIfWnHD1o3jPWHXbWr+eMraTLDvMrkUNr3DU+z71a28wLQf6IODPVdUxxzThI0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=AVpJFSV9; arc=none smtp.client-ip=44.202.169.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-6007b.ext.cloudfilter.net ([10.0.30.166])
	by cmsmtp with ESMTPS
	id 8Q7GvTOtOKXDJ8cUovL5fT; Tue, 14 Oct 2025 10:43:11 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id 8cUnvID6Mp0Hq8cUnvVmgD; Tue, 14 Oct 2025 10:43:09 +0000
X-Authority-Analysis: v=2.4 cv=H/nbw/Yi c=1 sm=1 tr=0 ts=68ee293e
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=7vwVE5O1G3EA:10 a=VwQbUJbxAAAA:8
 a=HaFmDPmJAAAA:8 a=P_cPeGO1By8CqGh9tkgA:9 a=QEXdDO2ut3YA:10
 a=nmWuMzfKamIsx3l42hEX:22 a=Wh1V8bzkS9CpCxOpQUxp:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Mzvb5/3ibAocfTL9NzSwx16avhcPrus7YfJ+qL05wiA=; b=AVpJFSV925Lnx3RjzODQ6OXeb9
	za53Uz/bRwYHSV0itT+BxlknY04zF9iLJGw4nw14NTj+2wcHeM2QLyYHoi1eoBCSyY7o5rS3Ly8Uv
	ZSKhAJYyB8T2lM4TUl18xfYZymdWAONF3t4P+NLNxOK4k7BEGMC2QSEqMKcW8PVOfr/57qQ6dmhtm
	eYdtPLZvQbpbZMbRMMwHGoKVwqrpv147MaK0Ko6KcIMELyXt+Fhu2QPK70e7TmRY7O0ehy+yTI2f2
	aOAU4hCF2pjNZlqMsmfQ0s8eet8Kve3TGdrJJwOleUIyiRiXV2Ng6nevFymmf9d/441o4z5awmLye
	25i6St3A==;
Received: from c-73-92-56-26.hsd1.ca.comcast.net ([73.92.56.26]:58134 helo=[10.0.1.116])
	by box5620.bluehost.com with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
	(Exim 4.98.2)
	(envelope-from <re@w6rz.net>)
	id 1v8cUn-00000000WN7-0IXg;
	Tue, 14 Oct 2025 04:43:08 -0600
Message-ID: <c779f34f-e2c3-4b26-ba7e-cf8d5479689e@w6rz.net>
Date: Tue, 14 Oct 2025 03:43:06 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.17 000/563] 6.17.3-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org, achill@achill.org
References: <20251013144411.274874080@linuxfoundation.org>
Content-Language: en-US
From: Ron Economos <re@w6rz.net>
In-Reply-To: <20251013144411.274874080@linuxfoundation.org>
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
X-Exim-ID: 1v8cUn-00000000WN7-0IXg
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-92-56-26.hsd1.ca.comcast.net ([10.0.1.116]) [73.92.56.26]:58134
X-Source-Auth: re@w6rz.net
X-Email-Count: 16
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfLEo3GmQ8BkkjjQx3j9/hFBTx9EnA+lzZF3OmRqcqADtwsxIYsMFPYTVuepY6mKffFlEPmjLb1knYI3r0H/GRNV6xmizm3p7WktA1xU1thgmc7WVdSNt
 +5pRpxnKrs3Z889X6r0e10b2Eo+wUJMi7/N+21dDUPPeVRrvN4zBCN3ZGq5dVtoWDcG4BnJ/22PzN4QsI24IC0yBaMCQQL04nfI=

On 10/13/25 07:37, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.17.3 release.
> There are 563 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 15 Oct 2025 14:42:41 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.17.3-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.17.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>


