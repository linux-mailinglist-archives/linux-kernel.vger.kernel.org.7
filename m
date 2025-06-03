Return-Path: <linux-kernel+bounces-671420-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 029A2ACC133
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jun 2025 09:29:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7445C3A397C
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jun 2025 07:29:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41F962690EB;
	Tue,  3 Jun 2025 07:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="HBhydYIo"
Received: from omta038.useast.a.cloudfilter.net (omta038.useast.a.cloudfilter.net [44.202.169.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 836422690C0
	for <linux-kernel@vger.kernel.org>; Tue,  3 Jun 2025 07:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748935773; cv=none; b=LvcnIQ+FiENouZ36k4N8Dzx+wcMfjTkKkR2QSTrzKFoTFExFg+TWEfODgj1yHXtRpj1BYpndPvXWScWrJG3SRmR0DGaVRTFyImNU9egJMovtKZIrd5Es5BHT2kSNx/nvJkYT9aegtUWRYubMvuHV198pNcYCRJIE74bFn7jeFg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748935773; c=relaxed/simple;
	bh=fawNGwVI7peAgzx0RRD6SH/D87hmTLCN+ivXyIICGz0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PNJ/lowFOvDfHtzs/jy62C5dQKSGzbolLLbmRR5Yx3fvtVBUTYB4WeB/9d34ntlmsy0pk23Wf6FHiqhWL46wLKubL2WxpYAjvEb0K3ZsxB0q1INcDtC6rTV1I7CDAR1hethLZciiEmQX23aoBdYT06bt3hlD58ihfnCpxILQo20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=HBhydYIo; arc=none smtp.client-ip=44.202.169.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-5003a.ext.cloudfilter.net ([10.0.29.159])
	by cmsmtp with ESMTPS
	id MF4euvTeviuzSMM5SutiBx; Tue, 03 Jun 2025 07:29:30 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id MM5Ru6tGsrsgDMM5RuTTeb; Tue, 03 Jun 2025 07:29:29 +0000
X-Authority-Analysis: v=2.4 cv=TNGOSEla c=1 sm=1 tr=0 ts=683ea459
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=7vwVE5O1G3EA:10 a=VwQbUJbxAAAA:8
 a=HaFmDPmJAAAA:8 a=49j0FZ7RFL9ueZfULrUA:9 a=QEXdDO2ut3YA:10
 a=nmWuMzfKamIsx3l42hEX:22 a=Wh1V8bzkS9CpCxOpQUxp:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Uo1lxvPXbX92Ozqf61VE1ZZlqJlUMrlMV7J+xXhz9KI=; b=HBhydYIoDzbhVtvhWHvI9MKckj
	h8/3M4cUlw3gWj+0wqdZy1StfDFtxIQlMlWlI/o60bNXEZLM1usMu2GMUnTd7DLqIB4VjnCELBMCm
	zZ0Da3I5eyPHzL1OZuOn9X2tLpsGz3S4aRYCy87OMyyT0pd2CBptoYi4yvKyaWwM+/f9LxFdwhhkf
	Q2uBa2pJHi9WKwHZFP+E7pob7kUpe/Kh09S/zqfbV9xjjVu8snhQO+QAb+K9m4ObhUE8ItbGAAVge
	zE7tuLhOJUfHKjZtqno/ma/0NApZ53ZnDlybFcDuUXn0AfoH2tWJMzst2Ts95SqL85L/vwgPmH7uk
	Go43derg==;
Received: from c-73-223-253-157.hsd1.ca.comcast.net ([73.223.253.157]:56550 helo=[10.0.1.116])
	by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.1)
	(envelope-from <re@w6rz.net>)
	id 1uMM5P-00000002RJ2-1bYu;
	Tue, 03 Jun 2025 01:29:27 -0600
Message-ID: <9e3bb9dc-9459-445f-b64e-514128c7b35e@w6rz.net>
Date: Tue, 3 Jun 2025 00:29:24 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.14 00/73] 6.14.10-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250602134241.673490006@linuxfoundation.org>
Content-Language: en-US
From: Ron Economos <re@w6rz.net>
In-Reply-To: <20250602134241.673490006@linuxfoundation.org>
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
X-Exim-ID: 1uMM5P-00000002RJ2-1bYu
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-223-253-157.hsd1.ca.comcast.net ([10.0.1.116]) [73.223.253.157]:56550
X-Source-Auth: re@w6rz.net
X-Email-Count: 54
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfAqaNf3Gg/oEJava2DshEESenWqmrlKO9TM7nj8YVRSfHvQnp7UFeoUNxONUxFNVIyB/5cTInVjYZk7F1FjCzvNstYqdLreHgDqknrObB1/BaJL1ANJW
 eZJPVtCAWMMV0XRL1wX67bLTFHkLyOKteJUOIslpg0VZJJUXBSWof2yHwQoAceIJ02AiSScpX4Up5k1NN11mBp5u2/v3gHIl26Q=

On 6/2/25 06:46, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.14.10 release.
> There are 73 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 04 Jun 2025 13:42:20 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.14.10-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.14.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>


