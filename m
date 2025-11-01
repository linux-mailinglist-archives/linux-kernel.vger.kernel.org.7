Return-Path: <linux-kernel+bounces-881243-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E05E4C27CEF
	for <lists+linux-kernel@lfdr.de>; Sat, 01 Nov 2025 12:45:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A63A93B5406
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Nov 2025 11:45:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D12E21171B;
	Sat,  1 Nov 2025 11:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="ci4zAz7Z"
Received: from omta036.useast.a.cloudfilter.net (omta036.useast.a.cloudfilter.net [44.202.169.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB5992566
	for <linux-kernel@vger.kernel.org>; Sat,  1 Nov 2025 11:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761997552; cv=none; b=erL+IYaUkr7JUhCK4RQFWcTW2Ye2iTokTBRXSykzj8mJ8BN+4muZLcRJMPXUnUIeyjsoRBiDYb6mMErEOuFehzBcJN+BbzWn6anp0HOiNACpOMKZ6qdKwqwaTtZWoU1EHte31iWLEw/sBs/ss6Sc42xxgVM4THDzsb2aph7u3Us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761997552; c=relaxed/simple;
	bh=b98YG2u4c67D8lt+t7WSsPm0VBCwyx2vNUfbeLXKZPs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X49dR0Wc7JxK45X6Uyo2mgC0xYeO8SB7IwCNkuwLDv4fEqMw3wRwsCPzoY4EX1qLANr0I8QTW6jJFsKbthWSaMfeF0lya0qLmS6P/6vQak5vxHPW+SCW9Cu7RCUjarrrk9l/DAA1Ut2qr8KzHGQdzURmFUW9quhetwIMkixWBAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=ci4zAz7Z; arc=none smtp.client-ip=44.202.169.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-6003b.ext.cloudfilter.net ([10.0.30.175])
	by cmsmtp with ESMTPS
	id F8ARv9GGEKXDJFA1lvHhto; Sat, 01 Nov 2025 11:44:13 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id FA1kvzSpSE0qRFA1lv72iC; Sat, 01 Nov 2025 11:44:13 +0000
X-Authority-Analysis: v=2.4 cv=Q+3S452a c=1 sm=1 tr=0 ts=6905f28d
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=7vwVE5O1G3EA:10 a=VwQbUJbxAAAA:8
 a=HaFmDPmJAAAA:8 a=HZNXMTzG_uFtYxrW7YgA:9 a=QEXdDO2ut3YA:10
 a=nmWuMzfKamIsx3l42hEX:22 a=Wh1V8bzkS9CpCxOpQUxp:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=x3MpQrRceOub48PqcqF0GyipDwviv2FlKXxI/zY3gYc=; b=ci4zAz7ZJoC4MnKP7Ot6Ye79SE
	GzEAPsWjFZT0mGtC/Y7ahx6NUo2qccq7wyjxl8TuNY7Ec0OMAfGbRn7M0GCOibHhHeU65RybFR2xG
	DeoC4b/T72UaKQW+bpKZRBd0Xb1Ar6TdcS0fHG6IrvkPIpv03hIXQ1mpmWw6jqPwsuI4QJA4xliQW
	aTvxFJg7qY7OHzBM0PzllKEHYxsLpZWCZDhZQyV+AmxUZDHIMo0bqEAJNJMQFxIAqAVCgm6ovimKB
	xZGVOpL9hFEqppJssen83hpp2PASOb598oWGw1BVDp34NWWnyJGNFOegAeMN2GDTsZhpXsZ40c1yv
	6efGRJvA==;
Received: from c-73-92-56-26.hsd1.ca.comcast.net ([73.92.56.26]:47480 helo=[10.0.1.116])
	by box5620.bluehost.com with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
	(Exim 4.98.2)
	(envelope-from <re@w6rz.net>)
	id 1vFA1k-00000003cas-2rth;
	Sat, 01 Nov 2025 05:44:12 -0600
Message-ID: <4e1cdda1-a56b-4129-985b-7f23db0c490f@w6rz.net>
Date: Sat, 1 Nov 2025 04:44:11 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.12 00/40] 6.12.57-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20251031140043.939381518@linuxfoundation.org>
Content-Language: en-US
From: Ron Economos <re@w6rz.net>
In-Reply-To: <20251031140043.939381518@linuxfoundation.org>
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
X-Exim-ID: 1vFA1k-00000003cas-2rth
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-92-56-26.hsd1.ca.comcast.net ([10.0.1.116]) [73.92.56.26]:47480
X-Source-Auth: re@w6rz.net
X-Email-Count: 37
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfGRA95an6Mg4o0mWNjlo+KE17hHsfEAXUoqpa+nEoKTuzY734w6Qc7SvbQxITze1/EQIl4YjGS7HEluCR7zv0ekeEdSGILBxKeY0qEBB4N+Ti/O+4Wip
 5FVqxAunmuIC1zO34R0TC32Wp7AWCrArgbKECtKYxJKm/WalTo4FcgXwSWb65POigm3wWu0D/U6gASHqlXugMHVbSKa9FoEh81Q=

On 10/31/25 07:00, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.12.57 release.
> There are 40 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sun, 02 Nov 2025 14:00:34 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.12.57-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.12.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>


