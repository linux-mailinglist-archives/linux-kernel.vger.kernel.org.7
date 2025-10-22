Return-Path: <linux-kernel+bounces-864744-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40A78BFB70C
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 12:43:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E23BE467415
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 10:43:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0051A319879;
	Wed, 22 Oct 2025 10:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="o5j7WoI0"
Received: from omta38.uswest2.a.cloudfilter.net (omta38.uswest2.a.cloudfilter.net [35.89.44.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CDB921FF4D
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 10:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761129803; cv=none; b=fANlcB/7Lwk+5H4nRAu1RRyvoFYn5LaPsP0jKZ3v6Vv5/WitC6/FO8Fhp2QMqvsJ7BlCwHhUhb4+VgYLHMrKfRIjWJhZzrZUKFZaG819poZydKb4UToSWF78P799h4OZfVOPu+ukn2ZCDjojkhU5t+gZPQXhMtQ/RmPh2nBLEOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761129803; c=relaxed/simple;
	bh=JZ4P+wYE8YZdEKQsH+NfoSABTfJNMWLi6rL0+6dUT14=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pXaVmfe45pPbjfFOD4cPPSMAbrRkc4iOibBy0mu9VOFDxK/9o+q3hWUH0hs7TZvWv+blVVKQUG2NP4zHgTmy6es0qefEARVyTjDaxY6ehkxkbqojkCGxNU47qv655iDProWOkdY13uh4qynRzcbI0dzT1UX6ZSb8MsfIlTmVQAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=o5j7WoI0; arc=none smtp.client-ip=35.89.44.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-5005b.ext.cloudfilter.net ([10.0.29.189])
	by cmsmtp with ESMTPS
	id BHQqvPT9HeNqiBWJNvkgjt; Wed, 22 Oct 2025 10:43:21 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id BWJEvVXiNfjrXBWJEvwoSZ; Wed, 22 Oct 2025 10:43:12 +0000
X-Authority-Analysis: v=2.4 cv=ItcecK/g c=1 sm=1 tr=0 ts=68f8b549
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=7vwVE5O1G3EA:10 a=VwQbUJbxAAAA:8
 a=HaFmDPmJAAAA:8 a=fB1EUuAJHaHnRYsFKpoA:9 a=QEXdDO2ut3YA:10
 a=nmWuMzfKamIsx3l42hEX:22 a=Wh1V8bzkS9CpCxOpQUxp:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=dlFZvav2JxkX6DXRhpjf71y+Kb2+lLpOvXc+C6RSZuM=; b=o5j7WoI0NEjXbsiqdG1K/WaJDC
	If7ZMcgxhUox+4mEypQsuOIewqHPfhyHqKOaZ8DvoeGk+LjNhS5kIxIVpsNzSIYXvAaYo64AUEzzl
	gQYbE4AuEfYlNDcnoqT/3Y64UmkNuwgz7Iqnt5ieLq8MVtIFi7h7qvI7xJ4NTxBwo/1+YtuB4Hhu+
	ukA1ZVQ2zJYmnWNUAZeTLXBh9MF3EiPqGr/S1rgBE0goMjLEGlr8CUCmFGSdK7ICDo3VHGtgJi7pI
	r3U0uCHDJQUDtM1je3ZIQ/ygbeyzTaj0GhARsUXkSsW6x51g9ZcqfUmO0++xrIFf7rFDQoOZxLH5n
	8SqSO2iA==;
Received: from c-73-92-56-26.hsd1.ca.comcast.net ([73.92.56.26]:49900 helo=[10.0.1.116])
	by box5620.bluehost.com with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
	(Exim 4.98.2)
	(envelope-from <re@w6rz.net>)
	id 1vBWJD-00000000q4O-2xIr;
	Wed, 22 Oct 2025 04:43:11 -0600
Message-ID: <8e8997f8-f266-4237-9325-3ae602f4304c@w6rz.net>
Date: Wed, 22 Oct 2025 03:43:00 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 000/105] 6.6.114-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org, achill@achill.org
References: <20251021195021.492915002@linuxfoundation.org>
Content-Language: en-US
From: Ron Economos <re@w6rz.net>
In-Reply-To: <20251021195021.492915002@linuxfoundation.org>
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
X-Exim-ID: 1vBWJD-00000000q4O-2xIr
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-92-56-26.hsd1.ca.comcast.net ([10.0.1.116]) [73.92.56.26]:49900
X-Source-Auth: re@w6rz.net
X-Email-Count: 54
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfDcN4UP7pxitbyIdTG7SrxR70AMH4LipjE/HnYB8nDVWLIqoCeX0XCuWJYpb5QBQ/ks0c5mbCs7S823BdRBituYO/whzkeOvw3+aA1z0raYnPsnd4cbn
 Pb9FeaG1shqeea3Ffbpg8SkVyuA+QwxNTjCy0uypcbQkAphZfjdLJJdmvFtNbBC236Dnva7Te13peISs5D7kadLN0qSNBSybaIM=

On 10/21/25 12:50, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.114 release.
> There are 105 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 23 Oct 2025 19:49:51 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.114-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>


