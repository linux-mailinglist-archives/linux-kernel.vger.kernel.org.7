Return-Path: <linux-kernel+bounces-873035-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E6EEC12E1A
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 05:51:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 111324E15E0
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 04:51:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C2E92877D4;
	Tue, 28 Oct 2025 04:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="X1HAw4Xa"
Received: from omta34.uswest2.a.cloudfilter.net (omta34.uswest2.a.cloudfilter.net [35.89.44.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E4C5273D9A
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 04:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761627101; cv=none; b=THpb0GADrxBzzP1j8U92NvqsVRuZsfosw+eGCzKfvuAB+if6whWr3nkGHcFy2MIMnC2lLzYWua5Lsw+hmwGMzSv0sxfehmJjFLE23TIIQPp5cV3wBzEpE3yaUz0MMnwRwakijtqEyPm5hb+t2t+BXM0bOoJOJvIvXv7E4cQjtSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761627101; c=relaxed/simple;
	bh=HczQKsoTq9bG91ZgMaU1ONGlCVa9s98TDf0X1YkuKFI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iO2Lgtby/cV9nR1DoznOOpiUHGHgJwuzp0iB1aHogzRwDo2SzkmWoCo/ln/l3uz4MrZELLKEL+SzNlFfV952e99e4iYu1ZhicMPfq9ch3zFDAg55Q6RH5fn28qGFk74te/XGBxUs+q8VVYp28nuIrx224dK6y4GCAMVhloPcEE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=X1HAw4Xa; arc=none smtp.client-ip=35.89.44.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-5007b.ext.cloudfilter.net ([10.0.29.167])
	by cmsmtp with ESMTPS
	id DZwKvFW5CZx2iDbekvPBw9; Tue, 28 Oct 2025 04:50:03 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id DbeivPLIpFPddDbejvSJBb; Tue, 28 Oct 2025 04:50:01 +0000
X-Authority-Analysis: v=2.4 cv=OphPyz/t c=1 sm=1 tr=0 ts=69004b7a
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=7vwVE5O1G3EA:10 a=VwQbUJbxAAAA:8
 a=LJ9ngj4a5Ur-kbwn2PoA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=Wh1V8bzkS9CpCxOpQUxp:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=xGFJqws/sjdhw2gBoS/JsBvsWK0Eluys8JTz/11lTe4=; b=X1HAw4XaeTnhac8AWa4eQoKBcU
	oYjr29lBFN5f2kOAskUOq7q8MWAqUftHyfF8mHJ7v3pDp9Vp8sf98tZ2AHhM6QHUobeET2EZ+ztPb
	8rZPSt54K7bAz+d7S5svpFpLE8d19VD/A+EDp0uhyeH65Kp91FMI5+Bdcfx9r6ngginnGWcEwnvFh
	3MDNoRIMF6xh7C3RePK7pKKz0+H396Uro6u9fUb7+htK4k5tKa/EAlYmIrxH/nAPsXFiZhmQ0fLAY
	SjQtPuwZihY0xhjWBSNG/+xhvfc+MybFx2hj00Dl7ok638U2Elsuyn02ccQVUfwyn23RK7akhISoQ
	XEWLrk8g==;
Received: from c-73-92-56-26.hsd1.ca.comcast.net ([73.92.56.26]:53180 helo=[10.0.1.116])
	by box5620.bluehost.com with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
	(Exim 4.98.2)
	(envelope-from <re@w6rz.net>)
	id 1vDbei-00000003rHk-2MEQ;
	Mon, 27 Oct 2025 22:50:00 -0600
Message-ID: <d61b75c9-a6a1-452c-a2be-34959d354739@w6rz.net>
Date: Mon, 27 Oct 2025 21:49:59 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.15 000/123] 5.15.196-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20251027183446.381986645@linuxfoundation.org>
Content-Language: en-US
From: Ron Economos <re@w6rz.net>
In-Reply-To: <20251027183446.381986645@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - box5620.bluehost.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - w6rz.net
X-BWhitelist: no
X-Source-IP: 73.92.56.26
X-Source-L: No
X-Exim-ID: 1vDbei-00000003rHk-2MEQ
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-92-56-26.hsd1.ca.comcast.net ([10.0.1.116]) [73.92.56.26]:53180
X-Source-Auth: re@w6rz.net
X-Email-Count: 17
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfDkSEQiS2RJB8Ux+6bhu8V8BiU9jYcKBmby1rkTb8WCvG4s3e0zGUru2NfTiiFimYLwWb6GB2mdiIpwjc+Uq4YJkpXBt8k/MQnXsS1Seu0nd5X0VGkL3
 Tm5pqdo3JXme3oA4J5WkeFJuau6jIefKFRGStzFxGvfV9sWOh3CJDdmelbLSm7mPCp+xJcJGcuY0JviJC3S9YCo5+PR0k+LpBq4=

On 10/27/25 11:34, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.196 release.
> There are 123 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 29 Oct 2025 18:34:15 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.196-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

The RISC-V build fails with:

arch/riscv/kernel/cpu.c: In function 'riscv_of_processor_hartid':
arch/riscv/kernel/cpu.c:24:33: error: implicit declaration of function 
'of_get_cpu_hwid'; did you mean 'of_get_cpu_node'? 
[-Werror=implicit-function-declaration]
    24 |         *hart = (unsigned long) of_get_cpu_hwid(node, 0);
       |                                 ^~~~~~~~~~~~~~~
       |                                 of_get_cpu_node
cc1: some warnings being treated as errors

The function of_get_cpu_hwid() doesn't exist in Linux 5.15.x. It was 
introduced in 5.16-rc1. The following patches should be reverted:

87b94f8227b3b654ea6e7670cefb32dab0e570ed RISC-V: Don't fail in 
riscv_of_parent_hartid() for disabled HARTs

568d34c6aafa066bbdb5e7b6aed9c492d81964e8 RISC-V: Don't print details of 
CPUs disabled in DT

And the stable-dep-of patches for the above should also be reverted 
since they cause warnings:

989694ece94da2bbae6c6f3f044994302f923cc8 riscv: cpu: Add 64bit hartid 
support on RV64

8c2544fd913bb7b29ee3af79e0b302036689fe7a RISC-V: Minimal parser for 
"riscv, isa" strings

e0cc917db8fb7b4881ad3e8feb76cefa06f04fe6 RISC-V: Correctly print 
supported extensions

c616540d6b67830bb4345130e8fa3d8e217249a0 iscv: Use of_get_cpu_hwid()


