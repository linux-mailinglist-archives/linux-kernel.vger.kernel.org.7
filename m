Return-Path: <linux-kernel+bounces-770996-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B85AB2815C
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 16:14:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8F74AA6635
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 14:12:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C9621DF755;
	Fri, 15 Aug 2025 14:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aruba.it header.i=@aruba.it header.b="g7qGIiuG"
Received: from smtpcmd01-sp1.aruba.it (smtpcmd01-sp1.aruba.it [62.149.158.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AF2E1C8631
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 14:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.149.158.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755267143; cv=none; b=Jr9iaBR1wcyLlfwCFjoSsBY75DTfB7GIquaSb7iTwAMXGyZE90DQ4UYtKvzWkxmYHPNQJU6GBA63bBlP8ViL9+0QkPK3Kx8R7IUKqdT2T2KxvoSmjBXYKB9A3OpQl+lCNPtHvnRfVMpxHrjQJbBFBPHZyeRX1N5bT65fNNU8yuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755267143; c=relaxed/simple;
	bh=/SRAWWfo1tFUvc96oZbisYlD8RD1fIU791Ewy2BEcFI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IzTylkFhlfgPYfpTsaFfH+Ov2miSQr0S69IakGGKanpuKvP0mvSyiRqeBaG0tPXcFlqtWIKP1KIGVPmE0A3kf4U+FVDXst9zwB2m+DoiCSMOC1qhbau1LqnMGKWMTbDQZZZfq/bFKwowHLh3h/l1gskBRuJe80RyXWaQIsShLoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enneenne.com; spf=pass smtp.mailfrom=enneenne.com; dkim=pass (2048-bit key) header.d=aruba.it header.i=@aruba.it header.b=g7qGIiuG; arc=none smtp.client-ip=62.149.158.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enneenne.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=enneenne.com
Received: from [192.168.0.184] ([5.90.63.22])
	by Aruba SMTP with ESMTPSA
	id mv7Duh4xczKH1mv7Eu4ouU; Fri, 15 Aug 2025 16:09:08 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
	t=1755266949; bh=/SRAWWfo1tFUvc96oZbisYlD8RD1fIU791Ewy2BEcFI=;
	h=Date:MIME-Version:Subject:To:From:Content-Type;
	b=g7qGIiuGu4Q35fgHsHQQdvKw2QHeWSOpYdmn+Jev3ZvAuLi2waqGsHq0CbCyzIcbH
	 8XcErJLdvuzIdjCf8aN1qS98i1kqsQTy2hp9kmZT5m7Pcig8Q4xDXYMaAM2v6q6SoU
	 MnqJ8FNL4P+bGBOJUx/wXdqyqIZKLagd8Z95kA2udugWQlwN+8srBUXBcoA6TAijJJ
	 CeE4r1OBAHFfq6giod9wZ4v/ZbAhzeI67P3314EoGrAr+QuPD61a7UxezrsYl+QNfb
	 3MLai/AfVMrFRf0s50OdQ6OcI4Ccs8JkcH7uDpeSRKp602tOVNbhIelxERm/+N4+fU
	 9kgR3fy5kzPYA==
Message-ID: <c226c97b-e42b-4ef8-9cc9-56299f0b37c3@enneenne.com>
Date: Fri, 15 Aug 2025 16:09:07 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Documentation: sysfs-pps: Fix `Description:`s
To: =?UTF-8?B?QmVuY2UgQ3PDs2vDoXM=?= <csokas.bence@prolan.hu>
Cc: linux-kernel@vger.kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20250815-b4-sysfs-pps-doc-v1-1-61d315eafbca@prolan.hu>
From: Rodolfo Giometti <giometti@enneenne.com>
Content-Language: en-US
In-Reply-To: <20250815-b4-sysfs-pps-doc-v1-1-61d315eafbca@prolan.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfNLajY7Tp133L2BHjs9KbFTBAhWZOdpkbZ16A0Eb8czp02UfCTJRr9v+ROICZ8cWr1NcAgg5t3V0jRKHHOeRdRoHHIW5/QihHMKpGYCHjDv3xpR8CgG3
 0PbgMZY8xCF4pv6vryGcjF0cPKs/p48YdpBCjVEFOhhtTJCIWHvByd3jkXhyEKIxrUg2WdgoQfis9YVa9tNlwGNDkT0vnnER2OG9j+4bfgQ9Pbi4tBP45l9/
 KuVLtEg1MQaZt29cJQX8/yXbg6Y8rxjANas4QDIAsac=

On 15/08/25 15:58, Bence Csókás wrote:
> It is unnecessary to duplicate `What:` content in the description. It
> makes it harder to both read and maintain.
> 
> Also, the uapi header no longer lives at `linux/include/linux/pps.h`.
> 
> Signed-off-by: Bence Csókás <csokas.bence@prolan.hu>

Acked-by: Rodolfo Giometti <giometti@enneenne.com>

> ---
>   Documentation/ABI/testing/sysfs-pps     | 29 ++++++++++++-----------------
>   Documentation/ABI/testing/sysfs-pps-gen |  2 +-
>   2 files changed, 13 insertions(+), 18 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-pps b/Documentation/ABI/testing/sysfs-pps
> index 25028c7bc37d8e50a2d4b53d954a2a0628c4a582..b8034ead5ae530c99fcfd280f295057823a3d613 100644
> --- a/Documentation/ABI/testing/sysfs-pps
> +++ b/Documentation/ABI/testing/sysfs-pps
> @@ -10,16 +10,16 @@ What:		/sys/class/pps/ppsX/
>   Date:		February 2008
>   Contact:	Rodolfo Giometti <giometti@linux.it>
>   Description:
> -		The /sys/class/pps/ppsX/ directory is related to X-th
> -		PPS source into the system. Each directory will
> -		contain files to manage and control its PPS source.
> +		This directory represents the X-th PPS source in the system.
> +		Each directory will contain files to manage and control its
> +		PPS source.
>   
>   What:		/sys/class/pps/ppsX/assert
>   Date:		February 2008
>   Contact:	Rodolfo Giometti <giometti@linux.it>
>   Description:
> -		The /sys/class/pps/ppsX/assert file reports the assert events
> -		and the assert sequence number of the X-th source in the form:
> +		This file reports the assert events and the assert sequence
> +		number in the form:
>   
>   			<secs>.<nsec>#<sequence>
>   
> @@ -30,8 +30,8 @@ What:		/sys/class/pps/ppsX/clear
>   Date:		February 2008
>   Contact:	Rodolfo Giometti <giometti@linux.it>
>   Description:
> -		The /sys/class/pps/ppsX/clear file reports the clear events
> -		and the clear sequence number of the X-th source in the form:
> +		This file reports the clear events and the clear sequence
> +		number in the form:
>   
>   			<secs>.<nsec>#<sequence>
>   
> @@ -42,32 +42,27 @@ What:		/sys/class/pps/ppsX/mode
>   Date:		February 2008
>   Contact:	Rodolfo Giometti <giometti@linux.it>
>   Description:
> -		The /sys/class/pps/ppsX/mode file reports the functioning
> -		mode of the X-th source in hexadecimal encoding.
> +		This file reports the mode bits in hexadecimal encoding.
>   
> -		Please, refer to linux/include/linux/pps.h for further
> -		info.
> +		Please refer to <linux/pps.h> for further info.
>   
>   What:		/sys/class/pps/ppsX/echo
>   Date:		February 2008
>   Contact:	Rodolfo Giometti <giometti@linux.it>
>   Description:
> -		The /sys/class/pps/ppsX/echo file reports if the X-th does
> -		or does not support an "echo" function.
> +		Whether this source supports an "echo" function.
>   
>   What:		/sys/class/pps/ppsX/name
>   Date:		February 2008
>   Contact:	Rodolfo Giometti <giometti@linux.it>
>   Description:
> -		The /sys/class/pps/ppsX/name file reports the name of the
> -		X-th source.
> +		The name of the PPS source.
>   
>   What:		/sys/class/pps/ppsX/path
>   Date:		February 2008
>   Contact:	Rodolfo Giometti <giometti@linux.it>
>   Description:
> -		The /sys/class/pps/ppsX/path file reports the path name of
> -		the device connected with the X-th source.
> +		The path name of the device connected to this source.
>   
>   		If the source is not connected with any device the content
>   		of this file is empty.
> diff --git a/Documentation/ABI/testing/sysfs-pps-gen b/Documentation/ABI/testing/sysfs-pps-gen
> index 2519207b88fdffdc404238409cb03d0112ce1958..c36bac37a883f1d702ff97e63603d4df7e24de83 100644
> --- a/Documentation/ABI/testing/sysfs-pps-gen
> +++ b/Documentation/ABI/testing/sysfs-pps-gen
> @@ -12,7 +12,7 @@ Date:		February 2025
>   KernelVersion:  6.13
>   Contact:	Rodolfo Giometti <giometti@enneenne.com>
>   Description:
> -		The /sys/class/pps-gen/pps-genX/ directory is related to X-th
> +		This directory represents the X-th
>   		PPS generator in the system. Each directory contain files to
>   		manage and control its PPS generator.
>   
> 
> ---
> base-commit: 88250d40ed59d2b3c2dff788e9065caa7eb4dba0
> change-id: 20250815-b4-sysfs-pps-doc-270e54da51b4
> 
> Best regards,


-- 
GNU/Linux Solutions                  e-mail: giometti@enneenne.com
Linux Device Driver                          giometti@linux.it
Embedded Systems                     phone:  +39 349 2432127
UNIX programming

