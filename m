Return-Path: <linux-kernel+bounces-767548-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E546B255C4
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 23:44:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C97F1B600F7
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 21:42:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 729FE309DB7;
	Wed, 13 Aug 2025 21:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="an0ghj6e"
Received: from omta034.useast.a.cloudfilter.net (omta034.useast.a.cloudfilter.net [44.202.169.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6153B1DA61B
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 21:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755121370; cv=none; b=Uc8jZHPaRs3ulyKYl8L0ELtu39f/9XeJ2ChgcFahYzqUKb0OgYC4iwPnyhmuNkodWR/8jmZ0p03JyWRsQKH1Vhv3cA29LSmuxK11l/svZDHPyHzje7FX18sJdf/md/9iBLntOwb/k5O4P+Ez6Lra46KexmWYKnuv2zuTWLJz5hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755121370; c=relaxed/simple;
	bh=RfbEu1S5VlAKyTJtB9cdwTIqJVPcs/984wHpUxeOi/Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YbhNSHJd/UPbRWZBHKZg9j5MkNx51t48gyJEmcHlFBcOaDY4EnmNlnIY87LSx8FtKzTMozkRT26VSkkE/K18B+qZAbjNWR/T+3fg5vru5tLEnO/7KlkLQMtAE2vpFVyrfwBLEi4cwQTRMgOS8XjIkCvwQllKaN9A9iDgJQCVgoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=an0ghj6e; arc=none smtp.client-ip=44.202.169.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-6004b.ext.cloudfilter.net ([10.0.30.210])
	by cmsmtp with ESMTPS
	id mA9Fuq7gXcOgkmJF9uceLq; Wed, 13 Aug 2025 21:42:47 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id mJF8ujzDCwYTkmJF8ub1hA; Wed, 13 Aug 2025 21:42:46 +0000
X-Authority-Analysis: v=2.4 cv=fYCty1QF c=1 sm=1 tr=0 ts=689d06d7
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=7vwVE5O1G3EA:10 a=VwQbUJbxAAAA:8
 a=HaFmDPmJAAAA:8 a=aHXbAQ7li1hnrysWXWcA:9 a=QEXdDO2ut3YA:10
 a=nmWuMzfKamIsx3l42hEX:22 a=Wh1V8bzkS9CpCxOpQUxp:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=c9aJeW6YrzXpNnexgXqHFdglcRnHTJkzDF0HfgTpJcc=; b=an0ghj6e+l+Zzgb7XOL/sPRCCm
	bYik69S0w1kR1rYbdaU78sTDYy3JHocLrGbtDS++hgavUShCwgH7Bc8Y3i8FHwwSalzNIct5XCLCK
	aWyieuRTINRX+gWCRa954UMxHbxFIfsDsEeEOXSRG1Ie4s2j0FRvZWt/TU/hafrr2oaNhxq9Itoef
	XlZWOy5NbVhX1E8r58qINh2mAMNEqeJM+T7NEaTU6lXTL6ZnBSNhC0wSMJN87vqAZk7W0prfqBmZe
	ici3+ZIopB25HCVKnvulTgfJfTOkLt8DNBxiqT1gWPHbxkBzdsHo85yOa7Wm5psggazKGiu2n7aVs
	Ofcepjsw==;
Received: from c-73-223-253-157.hsd1.ca.comcast.net ([73.223.253.157]:49402 helo=[10.0.1.116])
	by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.1)
	(envelope-from <re@w6rz.net>)
	id 1umJF7-00000001xuF-1pCt;
	Wed, 13 Aug 2025 15:42:45 -0600
Message-ID: <c0deea93-0c85-4bef-af36-763f60648c6d@w6rz.net>
Date: Wed, 13 Aug 2025 14:42:43 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.12 000/369] 6.12.42-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org
References: <20250812173014.736537091@linuxfoundation.org>
Content-Language: en-US
From: Ron Economos <re@w6rz.net>
In-Reply-To: <20250812173014.736537091@linuxfoundation.org>
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
X-Exim-ID: 1umJF7-00000001xuF-1pCt
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-223-253-157.hsd1.ca.comcast.net ([10.0.1.116]) [73.223.253.157]:49402
X-Source-Auth: re@w6rz.net
X-Email-Count: 57
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfOHbgIakp0wie1bfoYRnkswtnHZ+ADkptEKNTK/dgSy9Kl+yHfzX2TXg9UBhCNe83+fsGNrRRYgH3t0Dp8CkVfwgNx/rAZuPLmj77/5mUDZzVKu7oeCv
 WDW+i7/oGv2Wr1Gk61iMYfIphmgFPIW72kN9ACmYgOedU+sy6yCGnG9DCeeqo+MWSIo8Pyer3+tmzoS39KqN1NNfx4SKL45si5c=

On 8/12/25 10:24, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.12.42 release.
> There are 369 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 14 Aug 2025 17:27:11 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.12.42-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.12.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>


