Return-Path: <linux-kernel+bounces-822820-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BA530B84BD5
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 15:07:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4AA8E5423C0
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 13:07:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17A9E308F1E;
	Thu, 18 Sep 2025 13:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="MgZi47er"
Received: from omta036.useast.a.cloudfilter.net (omta036.useast.a.cloudfilter.net [44.202.169.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38529308F08
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 13:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758200822; cv=none; b=sctqZz7LZBAHG07Ar0EADykKAB4qtnXxk10uB2bexLWtKloO6MtYjruHMuI0im8Z8AJq4pjt5wnaneVXxCHcmr0T5vsjBDj01j+OQXQCBTty6DM9FLCUFwEg4C8ciNOe5qWDuR2mxMZWjmgC87pH8pasZoLzM4+y1vq4r13f3ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758200822; c=relaxed/simple;
	bh=KcmqPwBjgLkSsRbxfnZNnepU7CTAr1FybpG3hRWqMKk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m6Fzonl0WPR78tUzQNyF92ZFaqAmMMKTq2Trhk0AWKjmVrE1yT32BjVicMB3YuYFGZumoTxyeBvyKLwzSRu9TDnpRu1DwYocxODMC7H+OQDEvQymCZdMGMR6smTyPakoCrSwBv5B2ar1YVnKolCFZ9v2BfrmZ1W/XE2jh9FTEBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=MgZi47er; arc=none smtp.client-ip=44.202.169.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-6006b.ext.cloudfilter.net ([10.0.30.211])
	by cmsmtp with ESMTPS
	id z9L2uA4ktKXDJzELjuPW1v; Thu, 18 Sep 2025 13:06:59 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id zELiunZcEHFqJzELiuE1XU; Thu, 18 Sep 2025 13:06:58 +0000
X-Authority-Analysis: v=2.4 cv=bbprUPPB c=1 sm=1 tr=0 ts=68cc03f2
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=7vwVE5O1G3EA:10 a=VwQbUJbxAAAA:8
 a=HaFmDPmJAAAA:8 a=49j0FZ7RFL9ueZfULrUA:9 a=QEXdDO2ut3YA:10
 a=nmWuMzfKamIsx3l42hEX:22 a=Wh1V8bzkS9CpCxOpQUxp:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=xNs7/8oyUBGKxMI5SUf4zNPR4nghxJm5nsNHGNXlGaQ=; b=MgZi47er0oddL/gLkLUPMV7CMd
	OlPyXqiNKTTOB4enayns9/Nezf9JM/SU62/P+muzz+I+OalKvxM0dXQXVvitoQT1jVcAcivGyuBbh
	BYFIQ2/UTfvuQA+kitL9eh34VW4LaPrbxnXcBPNL+fak/4+sPIRW+KHGLbaCPt47snfELVkOIF0w/
	VI95Fv9lIssQuCBBTIxtfRRnEv4oiXeMdY8nZL/XnYwo7qB6dC5kMB8ivqib/U14m43zb6C4A3kKm
	Avw83wFc1V6r3dQj/rMmzE0AmR7RbuAKXFsRE8mqbl7V7XypgrfWurok/KZ1ABCQ4R1iI4VmU1eF0
	nkLRlLYg==;
Received: from c-73-92-56-26.hsd1.ca.comcast.net ([73.92.56.26]:57200 helo=[10.0.1.116])
	by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.1)
	(envelope-from <re@w6rz.net>)
	id 1uzELh-00000004Jpx-2wNS;
	Thu, 18 Sep 2025 07:06:57 -0600
Message-ID: <d56c00b0-b3d9-4c10-8ca9-5f2c29e0d6eb@w6rz.net>
Date: Thu, 18 Sep 2025 06:06:55 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1 00/78] 6.1.153-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org
References: <20250917123329.576087662@linuxfoundation.org>
Content-Language: en-US
From: Ron Economos <re@w6rz.net>
In-Reply-To: <20250917123329.576087662@linuxfoundation.org>
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
X-Exim-ID: 1uzELh-00000004Jpx-2wNS
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-92-56-26.hsd1.ca.comcast.net ([10.0.1.116]) [73.92.56.26]:57200
X-Source-Auth: re@w6rz.net
X-Email-Count: 17
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfKzsyXh6lJNSfUhA9QM4SRQ9VgaHW7ejlcreM+2YBhASxC0XwfyM2VUG1l77iSS0+d9dxGhQ1U8epMs+3jTarkloOgzavWY2Y5HyudEunq91EWpFo4Ck
 jWGsBd4/zL0zy1X4UyiYlPFMnhD0/ek7ift5im0pW0/P3BPL4Qv3vnSjXxGa74MfZ+EY1TotKOcjJoF+5NIwptLrylLm0vlI86E=

On 9/17/25 05:34, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.153 release.
> There are 78 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 19 Sep 2025 12:32:53 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.153-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>


