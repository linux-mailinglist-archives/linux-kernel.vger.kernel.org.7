Return-Path: <linux-kernel+bounces-849143-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 35FD0BCF496
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 13:37:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4102B19A0AD8
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 11:38:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 850C8263F4E;
	Sat, 11 Oct 2025 11:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="JGGM1pd8"
Received: from omta34.uswest2.a.cloudfilter.net (omta34.uswest2.a.cloudfilter.net [35.89.44.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 443AA1D435F
	for <linux-kernel@vger.kernel.org>; Sat, 11 Oct 2025 11:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760182669; cv=none; b=LQ3R7z95xDd5iVT5+U1ErAKYw59WCQu50E4uUzXD8kBmcnfH4KMIeNK8ubARpivtEWU6ooxfC5blzNWVZQEO0aoQsSWhCd26zWWX82+F7coYf/tYIgs+ECJU1P4RnMj7FAoGZ1Vz/uIneQj8n6lLubi3dOhGWpVsPkP5RmK4GC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760182669; c=relaxed/simple;
	bh=bRdrc/g9qQlktXDwT+VPM6NnLYJ3NloT0R97Z/JIeik=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lSeN0kg15hTrKyk6WBIMXg9AjWOdN7hHZdF4zmgSXCkFGek3OajOlS8S01XHJXcL7TNi1ppf3n1ojvoYwvjLhYdXnZEYi63BmgM0RSxVLWdtCqlouTW1vJi9/ABnA24ZZteesxVKeu+tIpz63cOy8eCtKRzzHs7895BwoHiK5Cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=JGGM1pd8; arc=none smtp.client-ip=35.89.44.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-5006b.ext.cloudfilter.net ([10.0.29.217])
	by cmsmtp with ESMTPS
	id 7WOSvtyj0Zx2i7XuqvkoPX; Sat, 11 Oct 2025 11:37:36 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id 7Xupvt0520HUD7Xuqv91vn; Sat, 11 Oct 2025 11:37:36 +0000
X-Authority-Analysis: v=2.4 cv=TIhFS0la c=1 sm=1 tr=0 ts=68ea4180
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=7vwVE5O1G3EA:10 a=VwQbUJbxAAAA:8
 a=HaFmDPmJAAAA:8 a=VoBekJB99Y0dKvRsJJIA:9 a=QEXdDO2ut3YA:10
 a=nmWuMzfKamIsx3l42hEX:22 a=Wh1V8bzkS9CpCxOpQUxp:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=+hJibs8dQk2A3ttBHAPuQzvPEqntnziRNoKw8ZyU7BI=; b=JGGM1pd8aEdr1yyvT165feRpp1
	RZWeoWja3503gY/HpUReO+LDgYK7aqBFeuNdABOVNJT7BnGuFeEw4cmOPpLAJFRGeQ7VcyJlhcFJI
	32aCbC5WyWe/asYI8wSlIglLtequsJ+4EZiTqBorFP+jRTPiiDtZscbTAdDnj1VIRcyyMb4XhQNVy
	BpMHUKFIdnVywhj3GmF89YBvMIoj9j66aqNgDkWul/EqwS2jBg7jLh6HMR8OUIyUtsMEGn8U01Ki+
	iNtt3TfUBhFyMTAFE916o50GKOuyjVBnoeqgSjiiU5zxSXWh67eotXv87IyuwC/V9eugYF0RrG14p
	fFOxXYZg==;
Received: from c-73-92-56-26.hsd1.ca.comcast.net ([73.92.56.26]:53622 helo=[10.0.1.116])
	by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.1)
	(envelope-from <re@w6rz.net>)
	id 1v7Xup-00000000seB-0dTE;
	Sat, 11 Oct 2025 05:37:35 -0600
Message-ID: <ee159df6-ef77-486c-bf5e-5e6941d88a6f@w6rz.net>
Date: Sat, 11 Oct 2025 04:37:33 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.16 00/41] 6.16.12-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org, achill@achill.org
References: <20251010131333.420766773@linuxfoundation.org>
Content-Language: en-US
From: Ron Economos <re@w6rz.net>
In-Reply-To: <20251010131333.420766773@linuxfoundation.org>
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
X-Exim-ID: 1v7Xup-00000000seB-0dTE
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-92-56-26.hsd1.ca.comcast.net ([10.0.1.116]) [73.92.56.26]:53622
X-Source-Auth: re@w6rz.net
X-Email-Count: 35
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfDziDT48g5L8kvpfu578uejxEUVqu/GZz0jFoOtj0LYXxzxFjEzRuoaHpdUBgAcyp/AdnF85DQtjpGwniwclGP3frVU6OhozldRuXcLWrRiJoG++QQRY
 11+obEBXLhLOHLR3QAh516mDU7EoNH39UnruAO/VKHYvlSL5TEUI80Ezh4vZ0IaE7O+x9o4XXLIf1YCTv+u4g9bwoBTPSaQWokc=

On 10/10/25 06:15, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.16.12 release.
> There are 41 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sun, 12 Oct 2025 13:13:18 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.16.12-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.16.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>


