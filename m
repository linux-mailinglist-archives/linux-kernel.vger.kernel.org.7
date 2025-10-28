Return-Path: <linux-kernel+bounces-873674-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D109C14677
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 12:39:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F2D01AA47DF
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 11:39:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43BBE30170C;
	Tue, 28 Oct 2025 11:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="Rk2CpKYz"
Received: from omta34.uswest2.a.cloudfilter.net (omta34.uswest2.a.cloudfilter.net [35.89.44.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 701F33064AF
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 11:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761651543; cv=none; b=o1mHS6GedCIT21YciEVg97LSQFkMvazpZNDIYN+df6KGR5ZQFh8hadjNWlwBcMGsYqOWR67Iw2h7PBf8/T0hLT1x0hDhY/GlzryrTrzk0vONdxfbyrRq1+Nrvh2Uar5hk50RLr1IfGvbdk5E0JPqqgfdaDP5hfRAc17UAVruejA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761651543; c=relaxed/simple;
	bh=rpLqt9UsHmltqaEBNayDznM1Px1cTWllO7xKvAgJ+8U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ljvOuBmmcz+lrqavb+JXAhIHnJEUHhb5aAJcY/qQKy/kMgolIdbzRwHhMWQHrEEgPU1RI67qvX/r81vixitv8T8zPbb1HTEbipLtOilBa6eEWLIPxsQQrK+iYbk9BUSuWGsqDmMt0+JTkjux+Z5Xmf6oTp6/iY4LuOvWOdm+mG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=Rk2CpKYz; arc=none smtp.client-ip=35.89.44.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-6007b.ext.cloudfilter.net ([10.0.30.166])
	by cmsmtp with ESMTPS
	id DcNlvFvaBZx2iDi2XvRa9h; Tue, 28 Oct 2025 11:39:01 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id Di1wv153aji5HDi1wv3ZWm; Tue, 28 Oct 2025 11:38:24 +0000
X-Authority-Analysis: v=2.4 cv=P6s6hjAu c=1 sm=1 tr=0 ts=6900ab54
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=7vwVE5O1G3EA:10 a=VwQbUJbxAAAA:8
 a=HaFmDPmJAAAA:8 a=IZuGi3YAW1ZzDR9SpYUA:9 a=QEXdDO2ut3YA:10
 a=nmWuMzfKamIsx3l42hEX:22 a=Wh1V8bzkS9CpCxOpQUxp:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=BctKdvEpl2pnS64HXHQ3XZXJPmaYErjxNGWJD9a9vbI=; b=Rk2CpKYzJNk+Ak4kbzlGt36Pyy
	qDvwp6VhGKVDNjKcIlhYvVxJzRSiNjohamvGLoyz57BFFyvOCtkxLCZ+0sI/xtoZGzOJftG2axnj+
	4hAImjGaQIwKQ2EKioe20xkMYXJSiS53H06uRZIIgHjMDM62FUe4M5DRoj8Lfh2QyCoJTA/LqZ+gI
	ymX0gUuTX3pzp0PlUxGqLbn+eDr1iOySYwMYfOeAM6Wj+0eshOqNs/ANy76GapuHN2hF2VF4Ip7ni
	QK0T3nDSNVjX51iK7wZuDfeP4ClOZQ5exkicRpyN01u8fmKBCV9Awrc8m9AIaUJY88CPLNDc62LLB
	BNC7mGxA==;
Received: from c-73-92-56-26.hsd1.ca.comcast.net ([73.92.56.26]:52060 helo=[10.0.1.116])
	by box5620.bluehost.com with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
	(Exim 4.98.2)
	(envelope-from <re@w6rz.net>)
	id 1vDi1v-0000000267y-3dTl;
	Tue, 28 Oct 2025 05:38:23 -0600
Message-ID: <7290bcbd-5e41-4216-bab1-0e46be62e813@w6rz.net>
Date: Tue, 28 Oct 2025 04:38:21 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.17 000/184] 6.17.6-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20251027183514.934710872@linuxfoundation.org>
Content-Language: en-US
From: Ron Economos <re@w6rz.net>
In-Reply-To: <20251027183514.934710872@linuxfoundation.org>
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
X-Exim-ID: 1vDi1v-0000000267y-3dTl
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-92-56-26.hsd1.ca.comcast.net ([10.0.1.116]) [73.92.56.26]:52060
X-Source-Auth: re@w6rz.net
X-Email-Count: 17
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfOMbMMOAH4vwG73EN65mUNT6MQNwXBGABy+hu3kfrGi2U40+5ib+sWaaDmz58pi7T5hwdAUKt5VoE9IuLr/+V+Si+zWz4EJBzG1OizV03uocoty1xGwZ
 paPMTH4bQrZGlbk3Nk61t5XdYoIU6JI7gVyxfbpT2Ip6tm0dS6klmyb3r7WviRbdOjypYQuubRFeb4uqOq0HNaE+CaXK5gxJEwk=

On 10/27/25 11:34, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.17.6 release.
> There are 184 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 29 Oct 2025 18:34:15 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.17.6-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.17.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>


