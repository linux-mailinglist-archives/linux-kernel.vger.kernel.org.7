Return-Path: <linux-kernel+bounces-751814-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B0B89B16DD9
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 10:44:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2AFCE1AA62CB
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 08:44:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40B6F2BCF6F;
	Thu, 31 Jul 2025 08:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="KCgCmUav"
Received: from omta036.useast.a.cloudfilter.net (omta036.useast.a.cloudfilter.net [44.202.169.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A7A329E10F
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 08:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753951467; cv=none; b=cpFOSTilXIxSQcD8KIxjbFSMbnss4OD5lRyj61FRFeEQ3XZRx4TBtE/7DnDVdzEzfosqxXY4d4QHFpYjO1DuWKB1tKQ0GVmDcBlP0KaAFoSMCkocvv1AIYjozrYWRFDW6U1/zpAL4ifAiB35aQvUjWT4DfotxPRrazmWl6yKaIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753951467; c=relaxed/simple;
	bh=RIWEg0ChboAYDbBcj972SroiuSksujt5ZDnWH+rnPJY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gdBU/syYmAQ8tNAo4VJ2rQ/v8MiUpwJj9IXFaeA0dR4czxuqpo83ctZc1U4cSWRBZzJWRNsMaxBVS/m+VnOSUdx2vNl25aYLvKmmYBkZZku/XcnIXIUojno8fA1Dcj+k+/Nw7PB0aBO2KfPeQVAx2wnlkqRWuxiEuwN/IwUFpvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=KCgCmUav; arc=none smtp.client-ip=44.202.169.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-6003b.ext.cloudfilter.net ([10.0.30.175])
	by cmsmtp with ESMTPS
	id hDv2upXqn1jt6hOtfuxmWa; Thu, 31 Jul 2025 08:44:19 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id hOteu0uj9CNkwhOtfufGoH; Thu, 31 Jul 2025 08:44:19 +0000
X-Authority-Analysis: v=2.4 cv=QO1oRhLL c=1 sm=1 tr=0 ts=688b2ce3
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=7vwVE5O1G3EA:10 a=VwQbUJbxAAAA:8
 a=HaFmDPmJAAAA:8 a=uL6TWLxzTrU8urRFV_wA:9 a=QEXdDO2ut3YA:10
 a=nmWuMzfKamIsx3l42hEX:22 a=Wh1V8bzkS9CpCxOpQUxp:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=4+1Enjy115Lyv+d8oy80MpBrc6fpuwPu8QVZbheXDBc=; b=KCgCmUavW+wrjiSjc57/Q/P1p/
	J4KEhBe2Dv7cICd31JsweeT+fO7jYLb1qoAVDApWODaI7O4+UFvopk5Ka9Brv5xlYihtl49q802Ki
	9L/1z+/xKSV69FvFtrKsCyvHgjqNIc72TIg7g4kEP6Q2cpSrGsreKVMuGg/hf6d9GU04ND/ECBDPi
	pLwI1UGhb+vokkik3SkHI3E70AWH89miNiGdq3Ha6qQ6IV7xeaoi83CEjVjdH/CwSTNvtElKr+aXK
	OsoOwAbWe+7PLKa7QMJNaziEUtelLoAeYBVM0LBz8THlL4SZWuemki5kkbjq5udbO6lbWFWj41P/L
	99nm09kw==;
Received: from c-73-223-253-157.hsd1.ca.comcast.net ([73.223.253.157]:51648 helo=[10.0.1.116])
	by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.1)
	(envelope-from <re@w6rz.net>)
	id 1uhOtd-00000001aNT-3xey;
	Thu, 31 Jul 2025 02:44:17 -0600
Message-ID: <af9112fd-6fda-4b86-971d-c2f596d39e65@w6rz.net>
Date: Thu, 31 Jul 2025 01:44:15 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.12 000/117] 6.12.41-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250730093233.592541778@linuxfoundation.org>
Content-Language: en-US
From: Ron Economos <re@w6rz.net>
In-Reply-To: <20250730093233.592541778@linuxfoundation.org>
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
X-Exim-ID: 1uhOtd-00000001aNT-3xey
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-223-253-157.hsd1.ca.comcast.net ([10.0.1.116]) [73.223.253.157]:51648
X-Source-Auth: re@w6rz.net
X-Email-Count: 35
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfJ2DabrAOSwTgscGKKPNgp/ysEudECajuOW7VAqf85lpyp9ZDlEte7l0q56Mu6NRXsjdfeNGliexdVRwAY2+IhkYK7YhvK8oagchpOivWIyTwKRLRWEd
 Z27ztLBBDHGGjgnZ5/VbdYpll7yCGzeYlGQMqP8ZhpU8qisVoSyvq3dEs91tEO3O2UHfaYutHX86Sqc0JvLX79Ri4j0PhjsWOjg=

On 7/30/25 02:34, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.12.41 release.
> There are 117 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 01 Aug 2025 09:32:07 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.12.41-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.12.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>


