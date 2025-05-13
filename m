Return-Path: <linux-kernel+bounces-645651-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E1664AB50F0
	for <lists+linux-kernel@lfdr.de>; Tue, 13 May 2025 12:06:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 952F81888E0D
	for <lists+linux-kernel@lfdr.de>; Tue, 13 May 2025 10:06:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD44524468D;
	Tue, 13 May 2025 10:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="bEisa3rH"
Received: from omta040.useast.a.cloudfilter.net (omta040.useast.a.cloudfilter.net [44.202.169.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCE0E242927
	for <linux-kernel@vger.kernel.org>; Tue, 13 May 2025 10:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747130648; cv=none; b=uFlq4Cz5t8vraKQU7u2+equNyrY4d9KglNZDLVIMbgQufeSHvJDytRGnMXdHW+mlILUCcuarfIMHkGmonFsWThCZJ5a2DNnkY4kRub0eelz4xk5hl98J4X6b41r52OB+Swn/4JWqXoU5tH512B6SVTva/1Myk3nuexKR5YJsAv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747130648; c=relaxed/simple;
	bh=IIpZ5lfhw0pOVldA08LdaSxH69X3tGjvb0komDGNPS4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G3UQMZ6sI/oyN4rNcyr55r/nBv6DM6Qn20acLLwrzfvBiFQUqPixoqY3U0Og095a2KpoObIkGICKG9D3sFaB5KxOAsrVRGJddvOp0rphnuQBP3cCW2cM+t8BvHK4CT4pDo8UvVoL9ohIos4ExtJEoRDvY8acgIchMaUKxH9/Tgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=bEisa3rH; arc=none smtp.client-ip=44.202.169.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-6001a.ext.cloudfilter.net ([10.0.30.140])
	by cmsmtp with ESMTPS
	id Ed40uEHohVkcREmUWuTzR6; Tue, 13 May 2025 10:04:04 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id EmUWuSatBgFaXEmUWufcFM; Tue, 13 May 2025 10:04:04 +0000
X-Authority-Analysis: v=2.4 cv=DbzcqetW c=1 sm=1 tr=0 ts=68231914
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=7vwVE5O1G3EA:10 a=VwQbUJbxAAAA:8
 a=HaFmDPmJAAAA:8 a=49j0FZ7RFL9ueZfULrUA:9 a=QEXdDO2ut3YA:10
 a=nmWuMzfKamIsx3l42hEX:22 a=hTR6fmoedSdf3N0JiVF8:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=57/Dn3UwCL986hqzQzEvM5a9oL+PnKM878ZIy7xd7jA=; b=bEisa3rH8VX1ynxwkZ0Nq7tDmk
	9rGV1qkwLFOE9FB+UhTqa2d/6fNiwvpS99XUZo94wBX0zzaJ34FoJQOCeDZYoH2cSX+zBELUBT2YJ
	MK5g3HrH9xOyQmeeHqkJMJOtbTY9t5HFDgn83ljveUYFRFIPHKxZndsB4Z2QXGHcyge/F/jsYEuw8
	RjLvvq+Ebllo3YoqIS22EeVOph7lgMwarmixl8Ea1mwwvgR/FL9fM9mcGk9dWy1PwPJCyb+oATYUC
	iGuVcSywT6Qw7RHuM+cl6eZ8BxTW8vSeS0vCTQlpNAACo4K2mRc9Z1BRRmEBXeaU4Pu9qrNOdGpp4
	JvlRnuxg==;
Received: from c-73-223-253-157.hsd1.ca.comcast.net ([73.223.253.157]:54846 helo=[10.0.1.116])
	by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.1)
	(envelope-from <re@w6rz.net>)
	id 1uEmUU-00000003PIk-3xBm;
	Tue, 13 May 2025 04:04:02 -0600
Message-ID: <12a7e641-8672-405c-b609-472a7627a374@w6rz.net>
Date: Tue, 13 May 2025 03:04:00 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1 00/92] 6.1.139-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250512172023.126467649@linuxfoundation.org>
Content-Language: en-US
From: Ron Economos <re@w6rz.net>
In-Reply-To: <20250512172023.126467649@linuxfoundation.org>
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
X-Exim-ID: 1uEmUU-00000003PIk-3xBm
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-223-253-157.hsd1.ca.comcast.net ([10.0.1.116]) [73.223.253.157]:54846
X-Source-Auth: re@w6rz.net
X-Email-Count: 16
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfNN5ra73r8xSK+u8C+7NgHjT3IXKTVmv4siojeKbg7AE7PjSRwSSYyKlZQSldmSWTXiLJ11gkfa8uxBacPmPGyxL9AVgTexNfgaUuM3BQeVqa6PnN7sZ
 jVKYCWRWNRgLDO3j8AuXVhzQiabI7qKkEPhmzLj47GVX51IvjO0iG/IaavbUMHhrOSw4Iu6fVz7q+Bqh/KCqisOeIIUAMvpYmnY=

On 5/12/25 10:44, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.139 release.
> There are 92 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 14 May 2025 17:19:58 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.139-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>


