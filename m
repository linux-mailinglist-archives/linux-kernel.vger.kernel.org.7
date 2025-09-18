Return-Path: <linux-kernel+bounces-807215-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ABFC9B4A1AF
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 07:59:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 672813B29E6
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 05:59:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C33A2FE053;
	Tue,  9 Sep 2025 05:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="Ohqi5Gu6"
Received: from omta36.uswest2.a.cloudfilter.net (omta36.uswest2.a.cloudfilter.net [35.89.44.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5E93246BA5
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 05:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757397588; cv=none; b=ifrGCb67Z15efva1zk/F1jSk0ApQa1wmuJpLe9hcJYs3R5pISlVzZQBpa4gPNM84sbKLFtfd2bUq81QJ9V9zYxcIzFQu6eSU5SFMViE8RaZxomnmXUvnHLzHsfJfwWskznsfCjPg9WuSJNmyQEf1p/auLu32GHUnQ4zQmlo7b8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757397588; c=relaxed/simple;
	bh=YmDs8KmxyXMG3YsjTDETxFwM3eDOX0MzNMwKKm/L9jw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JN62fQKEV0QEeEH+WdqN5GIQBg6UJfOvoSH8DCcJ02aT+DITRLNQXKhulhh/IPGzBIs+xEj6CEjNoUTJbIWHzEtTu8+aN672tvwkIZSGTiCbf1w4y/t4cAxg4Vo6Hz8KJlUuFFU9957xSb5Cy8GW0XGhZ7038ZUCWUt2d7HjoII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=Ohqi5Gu6; arc=none smtp.client-ip=35.89.44.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-5007b.ext.cloudfilter.net ([10.0.29.167])
	by cmsmtp with ESMTPS
	id veHxuiTeSjzfwvrOLu5emS; Tue, 09 Sep 2025 05:59:45 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id vrOKu9s5IEYttvrOKu9APA; Tue, 09 Sep 2025 05:59:45 +0000
X-Authority-Analysis: v=2.4 cv=K6MiHzWI c=1 sm=1 tr=0 ts=68bfc251
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=7vwVE5O1G3EA:10 a=VwQbUJbxAAAA:8
 a=HaFmDPmJAAAA:8 a=49j0FZ7RFL9ueZfULrUA:9 a=QEXdDO2ut3YA:10
 a=nmWuMzfKamIsx3l42hEX:22 a=Wh1V8bzkS9CpCxOpQUxp:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=jMUl6ggcK5gw4XhdXiPqkShGuaZmcP2ZYY7A8pweTsg=; b=Ohqi5Gu6vACrOXmppFPYEu5qkf
	94ulsEpLYDOnFTFlSH3aJgEGDXpfudyUJ9pRAIgB0SAchPwoF0zLdpBVTxIJ8wO3ppCfRMVYV5koG
	iC5PaKJRwE6ZXDSK7Pui+1/ieM+n+8QiF/ov6KbIAkpTSumVB1a5M6672k/QAbv6Fw+P1Qfoz33MC
	XMWqd+pwV6Qj9nR0xhT7ubiSRR7eWACa6PMN42FJkxBue9tHHUqP7+6EpEI+iu10gEjiGzgNi4HIG
	O+0FaWAY/ozlP34P4emi8I9JGZ/xpZklgk0KbakmXqOirdvyEX0OznvX4XTAc4O+TCSBKuuLjzZ/m
	APePJOKQ==;
Received: from c-73-92-56-26.hsd1.ca.comcast.net ([73.92.56.26]:43982 helo=[10.0.1.116])
	by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.1)
	(envelope-from <re@w6rz.net>)
	id 1uvrOJ-00000001qAv-36Q3;
	Mon, 08 Sep 2025 23:59:43 -0600
Message-ID: <5f01d3e5-30af-4124-935f-c1ee8264faf1@w6rz.net>
Date: Mon, 8 Sep 2025 22:59:41 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 000/118] 6.6.105-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org
References: <20250908151836.822240062@linuxfoundation.org>
Content-Language: en-US
From: Ron Economos <re@w6rz.net>
In-Reply-To: <20250908151836.822240062@linuxfoundation.org>
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
X-Exim-ID: 1uvrOJ-00000001qAv-36Q3
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-92-56-26.hsd1.ca.comcast.net ([10.0.1.116]) [73.92.56.26]:43982
X-Source-Auth: re@w6rz.net
X-Email-Count: 57
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfMwh8sAoYZ3G38+vIxEkqdKBFcQA6TT+ynGvTujMPrfjf06U+hmckREzgSn6mF+h3Sk6OOYrXcJ+2iEX9ioKHEMNIzacTNwOGP538FzO1kAtT/TBk3nq
 ZhEul0vZuXEgJCKfg/nrfBDfjK2Zz/ZdD5QAPbuNKlUIr2B/2d3e3suC0+VsMfthgFcmICWd7Jq/X370hqBegRC74K4ZrxOEdcQ=

On 9/8/25 09:05, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.105 release.
> There are 118 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 10 Sep 2025 15:18:22 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.105-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>


