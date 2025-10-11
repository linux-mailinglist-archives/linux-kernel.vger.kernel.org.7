Return-Path: <linux-kernel+bounces-849147-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B7630BCF4B0
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 13:51:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B3D041881DFE
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 11:51:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DBCA254AFF;
	Sat, 11 Oct 2025 11:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="wUE0kZVg"
Received: from omta34.uswest2.a.cloudfilter.net (omta34.uswest2.a.cloudfilter.net [35.89.44.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86B82C8F0
	for <linux-kernel@vger.kernel.org>; Sat, 11 Oct 2025 11:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760183463; cv=none; b=WPt4RZrgCOin+oMFlVpgsQGyP4Inh1yP+7YNzV4x00NrjePF1RxqtiEbH+dBNGD6nuL4s9oLPXsuNPB9xRIHzQb0lJfUpI/vTsxJS0nNyo4ZjhWKVlrKvu3HdCsOZX3F28y2qRFqoO/t214fEwZKIMQtiktUUFyNGyHCnyoGZCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760183463; c=relaxed/simple;
	bh=098OeeX4IliHr82oSjeqB/JsXmrpro30R5/KPLzVS+s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DX8tu+98rXAJYP4xjTrYW3X0G9YoMrXsiFkf8965mhNhxzlfk6BFu6u3jTY/lvc7E0MAPi8KHB3XiGNrxX81WSAgTvq6nSwbBqp98eXZLFEB93gEvsFFsl0Z5VeLU2eUSESUqlxil5slta2LsF/W/zoRSS6SL2U01v5U3wqunYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=wUE0kZVg; arc=none smtp.client-ip=35.89.44.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-5004b.ext.cloudfilter.net ([10.0.29.208])
	by cmsmtp with ESMTPS
	id 7HPPvpnKwZx2i7Y7lvku40; Sat, 11 Oct 2025 11:50:57 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id 7Y7kv6qInBc9y7Y7kvUN3z; Sat, 11 Oct 2025 11:50:56 +0000
X-Authority-Analysis: v=2.4 cv=ZcMdNtVA c=1 sm=1 tr=0 ts=68ea44a0
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=7vwVE5O1G3EA:10 a=VwQbUJbxAAAA:8
 a=HaFmDPmJAAAA:8 a=Q0YZzimFZhAAkqj1izUA:9 a=QEXdDO2ut3YA:10
 a=nmWuMzfKamIsx3l42hEX:22 a=Wh1V8bzkS9CpCxOpQUxp:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=GZytbWVs2HsAKfU8QUWZlmG2txeze7+PeqMAOU1sZvY=; b=wUE0kZVgVb+y8LNvKTVqX4HEhp
	O7zs+umu67bhb8+WTtTFlI9mnhWYst/wugcZDlaoocJ7WlEvB5lsUMCRG8mMy8nQ6+B6U1p1kzFRN
	AXnIV+b0pEWcCqqWYrk6507RSUXtPfFd/qOEgcfj1VJqfgvm0VftpoEwYZDLBoU3ri8yS7FZw8id+
	btTsY1FzF9XeUcoASY3Gz/kDwoYgmDRMM8r5U1JfWY00FDzl96y+aJO+w7NBrncbwSSxGHo8gbNzZ
	cBxpiwNzcgPcJ5qG4eeCCCXXYyvaI8QKZvCR2KAGU4SrG5giLSKUwEynOAuNYA8NAzC7tyic1WBfT
	g6FdsaVA==;
Received: from c-73-92-56-26.hsd1.ca.comcast.net ([73.92.56.26]:33184 helo=[10.0.1.116])
	by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.1)
	(envelope-from <re@w6rz.net>)
	id 1v7Y7j-00000000yPi-2GR7;
	Sat, 11 Oct 2025 05:50:55 -0600
Message-ID: <9d3697fc-be1a-48c6-970c-b4ce304f23ea@w6rz.net>
Date: Sat, 11 Oct 2025 04:50:53 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 00/28] 6.6.111-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org, achill@achill.org
References: <20251010131330.355311487@linuxfoundation.org>
Content-Language: en-US
From: Ron Economos <re@w6rz.net>
In-Reply-To: <20251010131330.355311487@linuxfoundation.org>
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
X-Exim-ID: 1v7Y7j-00000000yPi-2GR7
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-92-56-26.hsd1.ca.comcast.net ([10.0.1.116]) [73.92.56.26]:33184
X-Source-Auth: re@w6rz.net
X-Email-Count: 73
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfGuD4MusOe3vkfdEpoIWhdp96SZ12jMAQS5jaQT7GSN4QQgHSyUrwy6A9eyya8zHiXjE++BpO+6914tnncD9XbHHYvKvlQoyAFvQbQVDVtrL980X7IIx
 9AJVPq+i7FcY/vioAwHEaEJWGsF4xzN3bvF2eMefH16Q7EotdFbIO48pQ2oegGExjVbDqpcoe81ZVFB2eilESLTr001K19+Tb3Y=

On 10/10/25 06:16, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.111 release.
> There are 28 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sun, 12 Oct 2025 13:13:18 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.111-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>


