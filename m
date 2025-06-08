Return-Path: <linux-kernel+bounces-676786-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70ABFAD110B
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Jun 2025 07:40:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C7303AD250
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Jun 2025 05:40:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3959B1DB551;
	Sun,  8 Jun 2025 05:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="cKjYCzzc"
Received: from omta36.uswest2.a.cloudfilter.net (omta36.uswest2.a.cloudfilter.net [35.89.44.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AFE117E
	for <linux-kernel@vger.kernel.org>; Sun,  8 Jun 2025 05:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749361230; cv=none; b=RtWxgzZC/WfV4e2S43Tv8a9Kh5zAUJ63bQCJvrCivo+HZhtx8o7av87Zye4622jvb83YwiDtgVq9xmPPqixu7g7su9OBf48zidhuBo/ROxthrTfpyIYR4A7H8/rv/MB9sDv4yDqi56quKcz/CEC4iBY4X0WUkMXHFQ9kqDU4B3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749361230; c=relaxed/simple;
	bh=g5L7M65BVtn6YUhYH8zVe1Gt0I7xl3TF0fkn8aNJ57A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lnf933pt/gX1FGHdCPpENp/1SKYFOYDzVwdpLnrmt3qtIKqcUDf5GTiBYo1YnDpyQY9Vtiy8VzSDeNs3K3Nk7HvykNxzncCGya8fPOcwuO9gbtb0V7FGlYDgpcHq5IiuYjlepKQN/fj/+LjrpnghxROOVhWAX0HbGKiMHCwrO/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=cKjYCzzc; arc=none smtp.client-ip=35.89.44.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-6007a.ext.cloudfilter.net ([10.0.30.247])
	by cmsmtp with ESMTPS
	id O88ZuMmp1METlO8k8ubTfT; Sun, 08 Jun 2025 05:38:52 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id O8k7uWqr13IrfO8k7uF15f; Sun, 08 Jun 2025 05:38:52 +0000
X-Authority-Analysis: v=2.4 cv=PL4J++qC c=1 sm=1 tr=0 ts=684521ec
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=7vwVE5O1G3EA:10 a=VwQbUJbxAAAA:8
 a=HaFmDPmJAAAA:8 a=49j0FZ7RFL9ueZfULrUA:9 a=QEXdDO2ut3YA:10
 a=nmWuMzfKamIsx3l42hEX:22 a=Wh1V8bzkS9CpCxOpQUxp:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=kqdGiCBDTTx+KZJH3p+L4dXqH7I3Kl2/Mynql0kVhC4=; b=cKjYCzzcdr74e1+jSKshQj9cQ8
	9bGjN4JlmzUdN6BGcS0WKrB4sf8oh2BMtF+/bFbY82XYYdjb8rpYgMmd/Gfy0nwuNNmmGy8IseJf2
	iebbXBY2MX7yvMAxd+DH6W/CYMsTzcVysnk9349Wj/VHwjNPpDU1HVproACbd5UaU/D0rLeaxTIhq
	Bgn8myflwi5ojuVkqnipul4Pt0jJdPGzu9zOmqwuW8tMq+M64Ey/AMrnamm/UOVxERXG6u3/sxAFw
	HCaEwZOFvPHAZp1o6ejtPo2Q8FQVmUM8E8P6xyQpKBK8jZCc3q50LS/UVxX1FcOpF+KMy6YxyEZ3h
	StHp6m0w==;
Received: from c-73-223-253-157.hsd1.ca.comcast.net ([73.223.253.157]:37640 helo=[10.0.1.116])
	by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.1)
	(envelope-from <re@w6rz.net>)
	id 1uO8k5-00000003PTj-31xB;
	Sat, 07 Jun 2025 23:38:49 -0600
Message-ID: <c3f5e55a-353b-4802-9420-25b5ee48f625@w6rz.net>
Date: Sat, 7 Jun 2025 22:38:46 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.15 00/34] 6.15.2-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250607100719.711372213@linuxfoundation.org>
Content-Language: en-US
From: Ron Economos <re@w6rz.net>
In-Reply-To: <20250607100719.711372213@linuxfoundation.org>
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
X-Exim-ID: 1uO8k5-00000003PTj-31xB
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-223-253-157.hsd1.ca.comcast.net ([10.0.1.116]) [73.223.253.157]:37640
X-Source-Auth: re@w6rz.net
X-Email-Count: 16
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfHDsmfeT4d/lxUpn3BCxSqRB6XDThapstL8ahgTnFi1Wuw/F4cI7SEApUnDfmaF7Loobz2yw9EYO5087EKTkVnYYoJuu24rZw0OI4IMFujVnPXI+sZjb
 XmmDuG58fjMaOXhIrz86EmXnJj8fXVPSSMCjCo5PsBJ2ljdR5RZaycHSF0yoDYUdaomS9r7wrTqtyru1kyT9CBqB3+nImBq/kTg=

On 6/7/25 03:07, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.15.2 release.
> There are 34 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Mon, 09 Jun 2025 10:07:05 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.15.2-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.15.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>


