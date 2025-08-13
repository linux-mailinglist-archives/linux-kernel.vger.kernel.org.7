Return-Path: <linux-kernel+bounces-767505-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBF16B2555C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 23:29:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9FC6B17BD5F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 21:26:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63AD52F90DF;
	Wed, 13 Aug 2025 21:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="Sz+THJc8"
Received: from omta036.useast.a.cloudfilter.net (omta036.useast.a.cloudfilter.net [44.202.169.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F5432DE216
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 21:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755120381; cv=none; b=k8EAdqNERY+tUVwhbQgNhKlZUVLuubn9X5rERljJQBx8IWyLi430OcC33Dagvf3iZS5hUwidJiUppkyPXDz6wrcG0tB13IB8dEtFT21/mKtBI3d50EJSND/K3Gu44ra+BhDjgNaYhlc8zNRhX0791dSYNF7q0UYtbiK0aKfNzM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755120381; c=relaxed/simple;
	bh=CUuTpfuHCB+eRG1AWBHWojLhG8qGdVAxW2UOnezOloQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DfdkKpNO+rpsSZaqGMZoyyygwxkqU7Unaq+ufK6rW9QT/anXjpqM4QF+GdcJP5SP1QWAqc+3DpwZ5lQYhaT8oDfIAQKLhICYwKGDttDA1x2BbNvb9czYbKuNf/O0yNiwXWbJMkPrmNZ9Lfct5aGNYzyhxMn/xKa4XFDanSEzhQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=Sz+THJc8; arc=none smtp.client-ip=44.202.169.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-5002b.ext.cloudfilter.net ([10.0.29.226])
	by cmsmtp with ESMTPS
	id mHWFulpUj1jt6mIz6unNNr; Wed, 13 Aug 2025 21:26:12 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id mIz5uCDBVrnsYmIz6uTehh; Wed, 13 Aug 2025 21:26:12 +0000
X-Authority-Analysis: v=2.4 cv=OLkn3TaB c=1 sm=1 tr=0 ts=689d02f4
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=7vwVE5O1G3EA:10 a=VwQbUJbxAAAA:8
 a=HaFmDPmJAAAA:8 a=WC0afu9dXWEslweZtVsA:9 a=QEXdDO2ut3YA:10
 a=nmWuMzfKamIsx3l42hEX:22 a=Wh1V8bzkS9CpCxOpQUxp:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=bmS8nLb6K65KjptA10Fee2ArgRXSQ4M8a50W6jTXG6E=; b=Sz+THJc8oVA+tU56Fki/E8NqEE
	seW3RuK7K3r/NRpb7/oNhbji8Qs+4+68dCmSgnS7pRNSCk0B/k4xXwYYhZ+9zNBHDb2OBPymxToFN
	5Nx1YvKp76LPaH6T7fJfCqS1eHj8dQqeA4SBo/sJchwCl7KbOgfh/21X1AiNbk0mAFMLFqc+9z6uc
	YCu7O4YTop7gZhOJtVyAcM4sK4sclEGIhNvDjZs/7hZBQiwAVJvHhQRqO0buQzgN60mT+uK2V3VoK
	CusfcdFap2ejFplcVR8uZnjyt5FHLjwpXhXuIWjzbO/fPpZ72vcE4pPiLmAmEWRn7clFADKd2kiAJ
	cKljbliQ==;
Received: from c-73-223-253-157.hsd1.ca.comcast.net ([73.223.253.157]:53242 helo=[10.0.1.116])
	by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.1)
	(envelope-from <re@w6rz.net>)
	id 1umIz2-00000001qyg-2xfI;
	Wed, 13 Aug 2025 15:26:08 -0600
Message-ID: <98aa5eec-53b1-4efd-b142-f7b185df566f@w6rz.net>
Date: Wed, 13 Aug 2025 14:26:05 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.16 000/627] 6.16.1-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org
References: <20250812173419.303046420@linuxfoundation.org>
Content-Language: en-US
From: Ron Economos <re@w6rz.net>
In-Reply-To: <20250812173419.303046420@linuxfoundation.org>
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
X-Exim-ID: 1umIz2-00000001qyg-2xfI
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-223-253-157.hsd1.ca.comcast.net ([10.0.1.116]) [73.223.253.157]:53242
X-Source-Auth: re@w6rz.net
X-Email-Count: 17
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfKaverW/x51JoI37MTApVtxumKLGO6FBASfxinWy31PvjG/SnRiBLY3joSCOPkPxvvbUwMMBqjEHJWZ8V5jN8NSCHOcQDXFVhPVq+kBMeGnsQUARnLHW
 iplbebpeZj2iAgKP2BzhidacIj9dA1HiHXu0elMVEUUSi/eC9Z+13ZfpNfooFfl8lo2gYAQfgeQzphnQ5sIlDKwh2Hkt9ArRb2Y=

On 8/12/25 10:24, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.16.1 release.
> There are 627 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 14 Aug 2025 17:32:40 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.16.1-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.16.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>


