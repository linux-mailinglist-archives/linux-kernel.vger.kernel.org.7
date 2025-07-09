Return-Path: <linux-kernel+bounces-723281-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C58CAFE562
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 12:14:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A7745612E7
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 10:10:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47921289E21;
	Wed,  9 Jul 2025 10:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="ldmJQjxQ"
Received: from omta36.uswest2.a.cloudfilter.net (omta36.uswest2.a.cloudfilter.net [35.89.44.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39F6528936F
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 10:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752055765; cv=none; b=m5K56iDfOroqsEahH0BI7TGAUbmLxukW2UFcKdzKGsFSuz7ZNqhf/48lzAYfM13LwWqsX3ZN/tEYNf1YlrR0LF1SWGUedV1LKbmmbT0tJc/ocUM0IeXtqrqHMsT3R9GDqJNcusr1EYyQbTj9RVINTOvKVgzArMavRed0sRHc+os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752055765; c=relaxed/simple;
	bh=bL1QCulMurf6j0Kf9zlvvDZRmItbDJtZO/4OUhKdWAQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CLXyDlBqZQ3NX5GAnyhhpeTC4r/iHl6pOcwlzdWSq3/1QvetwTeEk0u8d/HYqdAVYzVkm5A73knY0CjwC0Z+5zkuGWIFMKqByhbeA/mGkZ9wQPY6Q7es7NAy2svGlxOjgBEtIcQnB8xeXjLs2ksC6Wk8pXQZDoBq61YTOQfY/i4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=ldmJQjxQ; arc=none smtp.client-ip=35.89.44.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-6006a.ext.cloudfilter.net ([10.0.30.182])
	by cmsmtp with ESMTPS
	id ZMhiudnhSMETlZRjuuhSix; Wed, 09 Jul 2025 10:09:22 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id ZRjuu6zRs6FUDZRjuuWSDH; Wed, 09 Jul 2025 10:09:22 +0000
X-Authority-Analysis: v=2.4 cv=UsdlNfwB c=1 sm=1 tr=0 ts=686e3fd2
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=7vwVE5O1G3EA:10 a=VwQbUJbxAAAA:8
 a=HaFmDPmJAAAA:8 a=49j0FZ7RFL9ueZfULrUA:9 a=QEXdDO2ut3YA:10
 a=nmWuMzfKamIsx3l42hEX:22 a=Wh1V8bzkS9CpCxOpQUxp:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=yE26g0Vn26Q0To6AtuuF8z05zOs4rpxeOht1Xqw5dRo=; b=ldmJQjxQmJsj6cqTBTSU+x1MvV
	MyHjhgOl4AKKlqZ404PLmapqzcn1P7gTNzbwcfXS8OquEcpUQhyYBcSyIzH6GG1YWp7CmKIwAKN5O
	08iWYfbDnyKZ7osVcTXv9gV3lrD2w2UqrsgQhbLWEyHo77+uTF0fwSZ+F8pIGWuONkBK3IRrNPYFr
	FDOE4bCNPpT3qLWmQf4V55Vf9lcjX1N2BEtNXF4OqmtU85vkXPwXPVpRXr8hBAlPflshJlFCtjuzF
	3izA9kWXdvrxlJu0UNcB6mlFuqYWRnrh+RWMwyZRu/Zrk9kdECVFeMQg3iRvxUP+lRgLrUIAJOiZg
	izGoWziA==;
Received: from c-73-223-253-157.hsd1.ca.comcast.net ([73.223.253.157]:40366 helo=[10.0.1.116])
	by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.1)
	(envelope-from <re@w6rz.net>)
	id 1uZRjr-00000003Ve1-2vVh;
	Wed, 09 Jul 2025 04:09:19 -0600
Message-ID: <09db343f-e4c6-41cb-b39a-b556bcafbc39@w6rz.net>
Date: Wed, 9 Jul 2025 03:09:10 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.15 000/149] 5.15.187-rc3 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250708183250.808640526@linuxfoundation.org>
Content-Language: en-US
From: Ron Economos <re@w6rz.net>
In-Reply-To: <20250708183250.808640526@linuxfoundation.org>
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
X-Exim-ID: 1uZRjr-00000003Ve1-2vVh
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-223-253-157.hsd1.ca.comcast.net ([10.0.1.116]) [73.223.253.157]:40366
X-Source-Auth: re@w6rz.net
X-Email-Count: 16
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfN9iYPOaHlujgr1jJBIL2wyjIoYvFw1SJBSLPNGoHpeYJGknNVPHV3ZDmLUJ7kXq7bJ+FzUKg2u4Jovw9gsRAGUpzgilm75ev7EiRr0plIjU/08bJMN3
 1Nhn8xbrI1EYoPgXeu3bcfsZ4VOWgl4AXIyjlwwfptq7HGa2cNdQ7ILTaDswv/siQ7GBDm+9teUCO9K7z88F6JouCP+OEZfHxwA=

On 7/8/25 11:33, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.187 release.
> There are 149 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 10 Jul 2025 18:32:32 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.187-rc3.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>


