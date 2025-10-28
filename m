Return-Path: <linux-kernel+bounces-873684-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03C38C146EA
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 12:45:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9B1E563072
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 11:45:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D56A330BB91;
	Tue, 28 Oct 2025 11:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="mjLS4cLf"
Received: from omta036.useast.a.cloudfilter.net (omta036.useast.a.cloudfilter.net [44.202.169.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EDB830ACE8
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 11:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761651921; cv=none; b=RTD4Tb3FhccfbcKQTSKcQwNq2ubvX6psd51NgzDfzLyu/C61gPgOj+na6ujH91DzEXokeqN60sahfHypEgEjDtfCwBDj5fkEsSKcjPqeTBe/Sv2MswJAL3aIsbayev9Kz4cJ34Ou3z0LYgMtKPrJt9wuhRTyAE33Str90XWSsr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761651921; c=relaxed/simple;
	bh=507v8C2GmUlPkZpOaiaiLd9c3gm25H9+o3MeYv/qsVw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cPqcUsc7QZ7n8uJ+vAG2BBJi2R343hq7we7DxxG0wLwlyXtPdtezbJJADKTo5RzcYLRkORmfN2QJv4dK04Sda+IzBstzBhBzhIW2YPlsuKtLQ6rtclNrymGVcsHaqTwJuTXd+dVUwcMfRqvo9W+nBFVxLqXUVL1b+juhhnM82IM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=mjLS4cLf; arc=none smtp.client-ip=44.202.169.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-6001b.ext.cloudfilter.net ([10.0.30.143])
	by cmsmtp with ESMTPS
	id DXbSvhvU0KXDJDi8cvZ75F; Tue, 28 Oct 2025 11:45:18 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id Di7ovoNYX9m9eDi7ovH4NM; Tue, 28 Oct 2025 11:44:29 +0000
X-Authority-Analysis: v=2.4 cv=eMQTjGp1 c=1 sm=1 tr=0 ts=6900acce
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=7vwVE5O1G3EA:10 a=VwQbUJbxAAAA:8
 a=HaFmDPmJAAAA:8 a=NZv-JJVNZ7gp_QotK4QA:9 a=QEXdDO2ut3YA:10
 a=nmWuMzfKamIsx3l42hEX:22 a=Wh1V8bzkS9CpCxOpQUxp:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=cOEVvaq+M0i5m1ZhWipqRZIIhWrGmgLqabOSofwdeqc=; b=mjLS4cLfo/sE8u0c35BikBjZXH
	CwL0TpOr037Zjnebv/KBD3tm8RNkZbhNn338X1PAKlSHtZs7oK8fKKHketQBrdwMpxj382ejA25dw
	81PAjsnVf88EEODcdCbfJM4R3vw/6vep6U9OKpsr0sn87Q9YWvXSRbp9iYWZan7c21fRXhkNYHo1F
	OjMX8jN9ttLrZEjGacAnzIuPxpprP0Qgo+W/tIFOYlILd5oL6urZi4mEOVFRpL+EEKV1q7fIuhx9w
	wLFalQ65fGVGE+6kE28NWQysYYp2X/9qBbILnzfClCEG2idsYsEQAqZE3SY8q79krebSCgedv15Nh
	uTirUNTw==;
Received: from c-73-92-56-26.hsd1.ca.comcast.net ([73.92.56.26]:42574 helo=[10.0.1.116])
	by box5620.bluehost.com with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
	(Exim 4.98.2)
	(envelope-from <re@w6rz.net>)
	id 1vDi7o-000000029f5-1YAm;
	Tue, 28 Oct 2025 05:44:28 -0600
Message-ID: <998417df-0bb0-4a04-89f5-ba664c14c305@w6rz.net>
Date: Tue, 28 Oct 2025 04:44:26 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.12 000/117] 6.12.56-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20251027183453.919157109@linuxfoundation.org>
Content-Language: en-US
From: Ron Economos <re@w6rz.net>
In-Reply-To: <20251027183453.919157109@linuxfoundation.org>
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
X-Exim-ID: 1vDi7o-000000029f5-1YAm
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-92-56-26.hsd1.ca.comcast.net ([10.0.1.116]) [73.92.56.26]:42574
X-Source-Auth: re@w6rz.net
X-Email-Count: 37
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfLcjSPAl1/2YGjWTevDwH6ikbtIaDZu9XXS2Vi/tJ/qjY+CEeijNxrq+vDdeCuzQuysfQfdRnY8/2vuSy5klq9CsrnmwzC1bgA0JSgUKE2lJktQujqxT
 weXn3a6uzWMjWyCwRvfpzA2D6PvbIVuREw584F4uK8bNqi0wD0AHi6pkz166h0IuH2pBmuz2NdrrB/baQm4TGX/LelPZq2JaH4Q=

On 10/27/25 11:35, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.12.56 release.
> There are 117 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 29 Oct 2025 18:34:15 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.12.56-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.12.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>


