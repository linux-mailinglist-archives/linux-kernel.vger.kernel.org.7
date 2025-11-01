Return-Path: <linux-kernel+bounces-881247-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 98E03C27D0D
	for <lists+linux-kernel@lfdr.de>; Sat, 01 Nov 2025 12:51:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7DD434E541A
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Nov 2025 11:51:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B7582F3C2A;
	Sat,  1 Nov 2025 11:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="EyyW/oVk"
Received: from omta40.uswest2.a.cloudfilter.net (omta40.uswest2.a.cloudfilter.net [35.89.44.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75BA1C8F0
	for <linux-kernel@vger.kernel.org>; Sat,  1 Nov 2025 11:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761997884; cv=none; b=dW8HK2iINvnr48xjYZ1I0utWwmIK/1nAxIZyc7/avPnvib773WE2PSTmiETjEOvoNlfAJLtOeWlyKxtpvQ+SI1zxqRbfbN3Wb4ufYvTqM6PjtnF5fjHjKZw5ryNkpWOeQRMFPRhA2Z2FB7IFx5HhRxva7yW2PwSFGABOKCR0KS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761997884; c=relaxed/simple;
	bh=HW6GKR/sJBCgYQzAZcNaDMPkzyWXK3HQJa6tAhMCYk0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ereDLFWj0xjxpTTi34jfucTgNXqoMjIJ8wWhPHTCfUpXuPbLk/uNT0qdusw853MfTZIj4Zf/Sz2GXN87xStPxpcyGqNsS3D5WWln1qAqezWQSEurp8gY0KzLun9MiGtjZDM6xiok18c4mW9o0d5uMFpsV0VzDDvVxGbxLWF4bVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=EyyW/oVk; arc=none smtp.client-ip=35.89.44.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-5003b.ext.cloudfilter.net ([10.0.29.155])
	by cmsmtp with ESMTPS
	id F3rGvJtE7aPqLFA8aveEgM; Sat, 01 Nov 2025 11:51:16 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id FA8avZ6aiuWNOFA8avz8ES; Sat, 01 Nov 2025 11:51:16 +0000
X-Authority-Analysis: v=2.4 cv=N+gpF39B c=1 sm=1 tr=0 ts=6905f434
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
	bh=blHPvg7TAE9OMAOrnuHX0jgx12qoh8iwCrfCCxr1ABs=; b=EyyW/oVkneRD6RZtuFgQHL1/52
	5QZeG9a+xzmZgfuPAg4nFJ0gfTwMgsze9Y2GxU076s8OAAAb2FEieolQj/XFwzp+X3N74i/CjKKgA
	24DQolZZAxuejyws8z0N549n1b9mgv2fxPjll/6KUBIUYogf1cVWnB7ynNeal6hn5t/eZQGPov2bX
	rqZFuaVgBp0PE59zhYuZ/Z0Rv8oc7Gj7zjjz5MJhZy88wr+CDTnIR6+6Cc+5kVprINPN6d6Yd5XW1
	/0v+uIY1CGq+zRkJeIWEmogQk95gBv+4WDhQYb9dXgjCjSE4eiLzjHbPTvuTv0AKHAd8zO5L11Bfb
	JMqV1qgA==;
Received: from c-73-92-56-26.hsd1.ca.comcast.net ([73.92.56.26]:57776 helo=[10.0.1.116])
	by box5620.bluehost.com with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
	(Exim 4.98.2)
	(envelope-from <re@w6rz.net>)
	id 1vFA8Z-00000003gAX-3Jdz;
	Sat, 01 Nov 2025 05:51:15 -0600
Message-ID: <d4c9ab6b-edcb-4e6b-a193-e7a9164ff16b@w6rz.net>
Date: Sat, 1 Nov 2025 04:51:14 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 00/32] 6.6.116-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20251031140042.387255981@linuxfoundation.org>
Content-Language: en-US
From: Ron Economos <re@w6rz.net>
In-Reply-To: <20251031140042.387255981@linuxfoundation.org>
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
X-Exim-ID: 1vFA8Z-00000003gAX-3Jdz
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-92-56-26.hsd1.ca.comcast.net ([10.0.1.116]) [73.92.56.26]:57776
X-Source-Auth: re@w6rz.net
X-Email-Count: 57
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfOt4Z8XtxgbfmIK6Ii8g9PDEYWpD3iV9Q6BdkCDDPc64zNXWr/o0GXh5YAavm+oVKF4z1k6820anLsXwMpBqH2FlcvD0ZGkH8FTcJJo9AwyLuehlIa3p
 tMLgGGuBjO95CcNr4XG3cjiAqJIVeCD+JOPY+brKp9JNzFA6WioHB39Gs4nTumEfoFI4px2MYT5T5cSTMXgQg+W6A43HBZ/bDe0=

On 10/31/25 07:00, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.116 release.
> There are 32 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sun, 02 Nov 2025 14:00:34 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.116-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>


