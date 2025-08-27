Return-Path: <linux-kernel+bounces-787968-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BDD0B37E3D
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 10:59:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5151F7A7EFC
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 08:58:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1DDA340DAC;
	Wed, 27 Aug 2025 08:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="D3oB+seA"
Received: from omta038.useast.a.cloudfilter.net (omta038.useast.a.cloudfilter.net [44.202.169.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F981340DA4
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 08:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756285183; cv=none; b=NtArp66e4Klb/Ne8JWAS+wGl+l3dl2qUyx4wgo6qA/BSs1TbSkEElfOl60vh7Aj/C9qseN905jiSW68k4d/GG3uU0fULWbw42LYleIa1AL+ORTpSDToIIj6mUXnds+UGJmlevEMyT1B2k1OXrCzZEBS69XQP8XBmAuWwDt4INKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756285183; c=relaxed/simple;
	bh=e+VoK9+9ktkhtiSHmZtvrsusXYvPcQRzEfCAaq7ZjnA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Zat8jAeoAv5FnwmQEESxLvE6Td+vCydnSAeWex8tsQxGYqwBWR9G4e8yarmJ9bX444D63hgbceEJU529rUcCIDrpNNZGoOb/uBpXIQUMfLRDdfLVuxgbBLPGTArQ6RKSyKmTW2K9dskON6OEo0FS/yeIiVclw5S3Ysn9uYH3l2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=D3oB+seA; arc=none smtp.client-ip=44.202.169.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-5005b.ext.cloudfilter.net ([10.0.29.189])
	by cmsmtp with ESMTPS
	id r62Bu8ZzuA1smrC0Ju68DQ; Wed, 27 Aug 2025 08:59:39 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id rC0IuOuDXb6dmrC0IuTtx8; Wed, 27 Aug 2025 08:59:38 +0000
X-Authority-Analysis: v=2.4 cv=bs9MBFai c=1 sm=1 tr=0 ts=68aec8fa
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=7vwVE5O1G3EA:10 a=VwQbUJbxAAAA:8
 a=HaFmDPmJAAAA:8 a=Hjfe3DhCYvkSn7QD38gA:9 a=QEXdDO2ut3YA:10
 a=nmWuMzfKamIsx3l42hEX:22 a=Wh1V8bzkS9CpCxOpQUxp:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=VOG3LYKgZCMMo+MNkUGKaiRiVRBi5+p1mFmH9vWfY6k=; b=D3oB+seATMeIynAFejlT0dNFkP
	7J3AFKy6noMCCpGqOGkZyj3IUAvXxNoVq+CnAjsfJc/1yBSGEGnGv9cEWFwyuMmj88J4xhlJK+yMs
	0EMZwAFvWr15dFWHVF/rtB+Iwp9RKYpwNQKgIY5tFQrjGpoQhgcNe2wyOzwGi4LfVVucpE6Tdfj1s
	TU9PTB9NN3W2EVycXQmijoCexs3U3wPE+PZriKKSAsstBPiw8erUs2igNpIHeFd8cICta3nfl7b2Z
	xH9u2EchuVC01aFZ7MHh/qTNUcXKRlfSY1uCTZz+0vhMWf1kCtUUKDLwwXvLJ5vexQk2khoLG1BC5
	jaNR9TQg==;
Received: from c-73-223-253-157.hsd1.ca.comcast.net ([73.223.253.157]:57290 helo=[10.0.1.116])
	by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.1)
	(envelope-from <re@w6rz.net>)
	id 1urC0H-0000000473b-2Tat;
	Wed, 27 Aug 2025 02:59:37 -0600
Message-ID: <d3486309-6615-4754-8944-13e48067d052@w6rz.net>
Date: Wed, 27 Aug 2025 01:59:35 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.16 000/457] 6.16.4-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org
References: <20250826110937.289866482@linuxfoundation.org>
Content-Language: en-US
From: Ron Economos <re@w6rz.net>
In-Reply-To: <20250826110937.289866482@linuxfoundation.org>
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
X-Exim-ID: 1urC0H-0000000473b-2Tat
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-223-253-157.hsd1.ca.comcast.net ([10.0.1.116]) [73.223.253.157]:57290
X-Source-Auth: re@w6rz.net
X-Email-Count: 17
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfBlNOmEPXfjvoiWKGtFcX9jqu5xMN04WGDoH0ZHSdpbAzCERduY6qE8bVVB26yUwNKSPuHq9n2HbvvjTjgRfMD9dlrUV5/saffCmmHQDwH+vijJEkkbT
 2oSQ9LrDy83RxUq4I1seuoM+fxzto/XUT6UbSW6a7BThyjhzgWNzekIe5El1ZN0ee4M6YZWll58nMcSdyz3BJ/oFT+gdR26R94M=

On 8/26/25 04:04, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.16.4 release.
> There are 457 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 28 Aug 2025 11:08:27 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.16.4-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.16.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>


