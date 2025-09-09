Return-Path: <linux-kernel+bounces-807198-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ECA3B4A176
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 07:47:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 358B34E2200
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 05:47:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DB472F8BC5;
	Tue,  9 Sep 2025 05:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="nOWvEa0n"
Received: from omta36.uswest2.a.cloudfilter.net (omta36.uswest2.a.cloudfilter.net [35.89.44.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C6F42EBDF0
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 05:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757396837; cv=none; b=dLZ3WK60zrBmitgTf+M4X2wNV24g0oWSDWDiGhnlZzUBZ9RnnaV8llM2wcu+zHanfdl6hP6uPpv9tzMV07RJVJQPF6Q6s7DAGBp1Pf/qLPGsb1nOgkHKYTs8QlyQ8JaY1ndNHS7fhYSnCfpHFhl1uKJ+nKh1znpikcCBMN6esA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757396837; c=relaxed/simple;
	bh=pNFLJBWaBI/4oOG7dhwpGC6SsZk9hVfRXeYkyZRJWhk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LS4zFz47bEekWulJirKLFCRcz/Gq6mMpDCIjaUJG2bN1F5o9Bx/IBNNRPkcE4yeQFfZmulPARmPH2UF4vtf3SMCG1tDT9+Ou25aCwyAeobQR3Q/ngZkrin1ICp1b9UgBPq2urYIJZ2QhhsCkb5ms+8MGWDCIkmd3jbEU+ioEMe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=nOWvEa0n; arc=none smtp.client-ip=35.89.44.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-6004b.ext.cloudfilter.net ([10.0.30.210])
	by cmsmtp with ESMTPS
	id vqCRulRbojzfwvrCEu5aKY; Tue, 09 Sep 2025 05:47:14 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id vrCDux2tlrez1vrCDuG63P; Tue, 09 Sep 2025 05:47:13 +0000
X-Authority-Analysis: v=2.4 cv=F65XdrhN c=1 sm=1 tr=0 ts=68bfbf61
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
	bh=ftbTpB0QAGd6IXrwbd+wdafHWdUigT/c1X1z9SsHSFQ=; b=nOWvEa0nmGoB43DuqXYy0xRSKC
	Gf1l6+nJARY0FE6Xj52zWE/e840mvLgKfgS7URxEQ4UrCMUlDHlHktvtUrBcbOLQY7YnQpkivv4p2
	8vfgnzRKdXesJFgJqfaeHvm38GY+nJFV9iN2HFFgSM05flh4BmUCWbSL1r+B0oxl3/Nlr3rw+CETi
	LcJXwwVL/gxLYlIgJOAWmtd22ObC64yqkouk3ULZSQuRYBzxg+WK5jblCvVfgLQ3iGJrLC+J2SLWy
	ocPOVKA4aTs4k6/WyTDPk9vzHkW/t+SN3IAakmhvB+O/SFSz+WxIpy1EyhLcn0F0vBGp+aUfkI7db
	WY/byp6w==;
Received: from c-73-92-56-26.hsd1.ca.comcast.net ([73.92.56.26]:44608 helo=[10.0.1.116])
	by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.1)
	(envelope-from <re@w6rz.net>)
	id 1uvrCC-00000001kTV-1MGZ;
	Mon, 08 Sep 2025 23:47:12 -0600
Message-ID: <57940525-7e4e-4f65-92d0-19d8ae244ba1@w6rz.net>
Date: Mon, 8 Sep 2025 22:47:10 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.16 000/183] 6.16.6-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org
References: <20250907195615.802693401@linuxfoundation.org>
Content-Language: en-US
From: Ron Economos <re@w6rz.net>
In-Reply-To: <20250907195615.802693401@linuxfoundation.org>
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
X-Exim-ID: 1uvrCC-00000001kTV-1MGZ
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-92-56-26.hsd1.ca.comcast.net ([10.0.1.116]) [73.92.56.26]:44608
X-Source-Auth: re@w6rz.net
X-Email-Count: 17
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfGYulynHciaREifRP4udOz8OkLRiNhrWA4NfkBL+p/dui7Q/OxnVnU96kzSj5AzrOpliIh4STiK0SzcTpb1fXriJ+6mQo7iuRVZahmjXP7lO0nnh5MHP
 sG95zO+IGXsBibgnI25GELOiJqehRHTxDFOgV76WgRBW/5m1oE+/RpjxyyFXcWW6+zTZd41GMnrPQ/oGbHGUxMQQpa5wjdgNhQM=

On 9/7/25 12:57, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.16.6 release.
> There are 183 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Tue, 09 Sep 2025 19:55:53 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.16.6-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.16.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>


