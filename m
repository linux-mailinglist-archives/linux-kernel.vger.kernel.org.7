Return-Path: <linux-kernel+bounces-842168-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 23F48BB9217
	for <lists+linux-kernel@lfdr.de>; Sat, 04 Oct 2025 23:26:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 82DC7343857
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Oct 2025 21:26:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF11925A322;
	Sat,  4 Oct 2025 21:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="hDty0oJ2"
Received: from omta040.useast.a.cloudfilter.net (omta040.useast.a.cloudfilter.net [44.202.169.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 096812376FC
	for <linux-kernel@vger.kernel.org>; Sat,  4 Oct 2025 21:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759613202; cv=none; b=XCE/C1RYMV/x64vkEfSHdRcfl/I1FT/VgXDQeQeV7mDtfTAWYxt6UC+ZI1orl3DcL0YnAfgJ9VOW7+5HbzUJr32eY8mLjA2rTCmZYqKkzFxSXgWBnLJr5ZqP8jcUi5tfJdacxc5WZBemzvH4ZY04SisXhV5xeVgpDW/j/dVzV9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759613202; c=relaxed/simple;
	bh=e2wD2ikAOe+zXtBBFB/FPdUMpWvh5cXaU+8tk0mSf94=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EbAw1QanjWTBkKruD3Ck3OLOdTYwquIKnBNYbOVjzNP7FRi1mcE+ayx2/cJQu4ZyN4GYOm8CIrcdRbVGfTCBMnTF3LvHZG4UYAqGoYE7NWyr8+d51tMnT9PX4yMSHcRYtuX0V89no+r+2RuvG13DKTa6Dkwf19QpgnTafhckHTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=hDty0oJ2; arc=none smtp.client-ip=44.202.169.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-6006b.ext.cloudfilter.net ([10.0.30.211])
	by cmsmtp with ESMTPS
	id 51OkvuOJ4v72459m3vbKq5; Sat, 04 Oct 2025 21:26:39 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id 59m2vhgpyMem559m2vK5dy; Sat, 04 Oct 2025 21:26:38 +0000
X-Authority-Analysis: v=2.4 cv=bZtrUPPB c=1 sm=1 tr=0 ts=68e1910e
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=7vwVE5O1G3EA:10 a=VwQbUJbxAAAA:8
 a=HaFmDPmJAAAA:8 a=49j0FZ7RFL9ueZfULrUA:9 a=QEXdDO2ut3YA:10
 a=nmWuMzfKamIsx3l42hEX:22 a=Wh1V8bzkS9CpCxOpQUxp:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Gu/IEEQoIE+PeNW4CA5QWJkDkerh9uj+nJMMoieItZY=; b=hDty0oJ2VdqQ9sDjasNZr7QHnM
	JBpOYfH05X9hJ96dVY7gnjAI1FZPFFaYHDRenGv34LieuUbkhbg4l36bXJ8TqLcQIXYYy+KIXditz
	M1+iKRf9+TQQfmoAJC+W3oudty6FYzAfLr1cnq1blSJ+YYEl0QxOLvkRn1xT6w+rraH8tEpBV2IRT
	MFe8gDN4108hkgO/Yct7LnfPZsChtN/VIgMN8KCw/8AbDr//CDnx4c0NZOZUHN21yPI8EBPMLWdOv
	WUL94B7XxK4ei4W2yzYJMb8p97eL9QZFVwfWanwBt/6YAPH3Si+o3g3ralNbwBp7k1M1BhJk7pjHJ
	6a+Wh7Eg==;
Received: from c-73-92-56-26.hsd1.ca.comcast.net ([73.92.56.26]:42144 helo=[10.0.1.116])
	by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.1)
	(envelope-from <re@w6rz.net>)
	id 1v59m1-00000003sA1-2UL5;
	Sat, 04 Oct 2025 15:26:37 -0600
Message-ID: <531377be-7328-4182-a63d-381eb5f7cd15@w6rz.net>
Date: Sat, 4 Oct 2025 14:26:35 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 0/7] 6.6.110-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org, achill@achill.org
References: <20251003160331.487313415@linuxfoundation.org>
Content-Language: en-US
From: Ron Economos <re@w6rz.net>
In-Reply-To: <20251003160331.487313415@linuxfoundation.org>
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
X-Exim-ID: 1v59m1-00000003sA1-2UL5
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-92-56-26.hsd1.ca.comcast.net ([10.0.1.116]) [73.92.56.26]:42144
X-Source-Auth: re@w6rz.net
X-Email-Count: 73
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfAIhEpJllqaJzj8VudY6UNFgLL61cMYAd8ShRrW4O05aPnINt2MNjXRwl7e/iSSW2Mib8fNIdO1GhBymL+wEkTirQwMDjVTLogh5KTyYmZkaRNW+6Xvv
 JPUX4WcIeuxBBGoG4V0ttPf6WjHXTz+9a7h3NCuDf6cYbFIarR2aMbYsP15iZjNTH0rciIKJpfkMzDx9t6W3k2ia6fy22SD136w=

On 10/3/25 09:06, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.110 release.
> There are 7 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sun, 05 Oct 2025 16:02:25 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.110-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>


