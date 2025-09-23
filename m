Return-Path: <linux-kernel+bounces-829192-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 83583B967DE
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 17:04:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E45B188320A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 15:05:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 179AD25B2FA;
	Tue, 23 Sep 2025 15:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="SpnHzFKm"
Received: from omta40.uswest2.a.cloudfilter.net (omta40.uswest2.a.cloudfilter.net [35.89.44.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 810C854774
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 15:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758639864; cv=none; b=Mql1U7Kfd3b3sH25rVjrx4iNtiVk5F9Lvf+tqKCeaa7yDoBGxZwj+kAbvZ/s6BNW2LcHE4CJd7+9KJ2s5C3ZZw79Or7pT53AyGFY3P1erWt8wB5MiDwHIJ4ps5JyreZcc9kl4QTNlnGlAZ8UthmAIS0udfXEPiShmYivvgcmhes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758639864; c=relaxed/simple;
	bh=A2fMlfWmf9LrY5OfJ+z5PbxhG/OI9UKQneYsp/dxaVc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uPdG2qRFd0pcQPsCdO/c1fHZ0PS3wWjuaPpXDKyJAOdis5gqzB/O9Uy+THT/sfSJ1oVop6HpygcniV6EO7QhvYXt5+4w5Bnxh/0dQoOuWW0Luydwnvq7cjj/Cjn9dKKrKTEql8umbrBJwrPGKcmz2LxWeaCKy6pvL2zXvWQANp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=SpnHzFKm; arc=none smtp.client-ip=35.89.44.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-5003b.ext.cloudfilter.net ([10.0.29.155])
	by cmsmtp with ESMTPS
	id 13xBvqUgMaPqL14YxvvgtT; Tue, 23 Sep 2025 15:04:16 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id 14Yxv6pDXtssb14YxvwhzR; Tue, 23 Sep 2025 15:04:15 +0000
X-Authority-Analysis: v=2.4 cv=Hb8UTjE8 c=1 sm=1 tr=0 ts=68d2b6ef
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=7vwVE5O1G3EA:10 a=VwQbUJbxAAAA:8
 a=HaFmDPmJAAAA:8 a=H2e1TcdlFpyve7uw5OEA:9 a=QEXdDO2ut3YA:10
 a=nmWuMzfKamIsx3l42hEX:22 a=Wh1V8bzkS9CpCxOpQUxp:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=jcu55gYOTbPSpKFwoC4b+viazruYUOUDXwlgJbMSJ64=; b=SpnHzFKm3m4uR/SvXpscYkcOpw
	Rq+kq/+SGIoXVJU6lXsPftf6PL9MOVyt1jaKPp447573QynMVWS3swM8Z9R6ScO1iC8WBVo7wghj+
	hZdjTy4mdVC2CbyA8EYVpiUXw8tmWLMj4J8uz6BtrSJH0EQJjZLyTIcc6KJIp1SWnl49CYojFeocf
	25EuhMRvQ341L2IEKcXU5zox+xTRgL6wolpDtTOuQu9drNGgOhKk7R18Qz0vIBNQOA3Lpeew/eTed
	/v7h5RvbZZ3+ceXYFTJKuOQEH/JnmW2pokAGz21SKo2Tx1caJ2HGYIsPGh9fe+l0kOZqWhmMOIMl/
	v270fphQ==;
Received: from c-73-92-56-26.hsd1.ca.comcast.net ([73.92.56.26]:55540 helo=[10.0.1.116])
	by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.1)
	(envelope-from <re@w6rz.net>)
	id 1v14Yw-00000000vH5-16Ds;
	Tue, 23 Sep 2025 09:04:14 -0600
Message-ID: <33be3968-797d-4e63-8dfd-c85d61f0bc20@w6rz.net>
Date: Tue, 23 Sep 2025 08:04:12 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.12 000/105] 6.12.49-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org
References: <20250922192408.913556629@linuxfoundation.org>
Content-Language: en-US
From: Ron Economos <re@w6rz.net>
In-Reply-To: <20250922192408.913556629@linuxfoundation.org>
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
X-Exim-ID: 1v14Yw-00000000vH5-16Ds
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-92-56-26.hsd1.ca.comcast.net ([10.0.1.116]) [73.92.56.26]:55540
X-Source-Auth: re@w6rz.net
X-Email-Count: 17
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfKLx9yYdaT9S0lgq4lSXiDfAVoOCo3usS1VGhDZWfWGZL/7ASwdaBTooysOJhhGdN6ZRAYrGa7rZcXmgUcXGOytYYzLqfkJa5DAlOs8qPArktXgfvG4O
 DioXd16JMQ/r/MMLfWedX+IlnebXPNx+nTdME8Zy6vMoBG9Z/lYeAmVuPHm5JMvMKisGOGS4hLHPGjlLWfcJqNFUtNaxqkkMdIc=

On 9/22/25 12:28, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.12.49 release.
> There are 105 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 24 Sep 2025 19:23:52 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.12.49-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.12.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>


