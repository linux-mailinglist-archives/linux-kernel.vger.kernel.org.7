Return-Path: <linux-kernel+bounces-725625-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B855B001A5
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 14:26:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D4BD3A87FD
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 12:25:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 672ED253F03;
	Thu, 10 Jul 2025 12:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="dsZfvv9D"
Received: from omta40.uswest2.a.cloudfilter.net (omta40.uswest2.a.cloudfilter.net [35.89.44.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D55624DD0E
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 12:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752150362; cv=none; b=ah1+uiFRQRhtkk70yGp27JC88UTkixBFYblIGGUCkyjMYIYvwvRYB312ZT2UO7yavzKCtVk8+8GpCykv1i3vl/5XYwIf8MLwAaSqrOy0N1JjF0ds7lGdDHNAR0YDcyaYgPx+ksyf44Vg38Xg2qkHbaH0ZBbTSkzVwvlI8Pm0WlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752150362; c=relaxed/simple;
	bh=xVdCdYf47JX/2Jed0gnOSC1jseqtlzZ9S+TrhW2IHcQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=detHPO+0PLDE0X1LUO1mYreE5KpUadr31+jl+hLEbkkueQMCqYvmWQLFmRmqKwGoBk6st5ifE7P2gW/B3rcz2Vsv7vCYiFNUWFIwnjHd0ISXpROsGaqtvC3iAdqiiBRvwxR1VfwzhZVyp97SriRWrWe2ls9w7OWmWF0k4UpZCRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=dsZfvv9D; arc=none smtp.client-ip=35.89.44.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-6006a.ext.cloudfilter.net ([10.0.30.182])
	by cmsmtp with ESMTPS
	id ZcJiuRQV8f1UXZqLYuHuVV; Thu, 10 Jul 2025 12:25:52 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id ZqLXu24gHIj58ZqLYuD2sh; Thu, 10 Jul 2025 12:25:52 +0000
X-Authority-Analysis: v=2.4 cv=SZzxdORu c=1 sm=1 tr=0 ts=686fb150
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=7vwVE5O1G3EA:10 a=h0uksLzaAAAA:8
 a=HaFmDPmJAAAA:8 a=GF-RUcCtsk5XG7IKrCkA:9 a=QEXdDO2ut3YA:10
 a=MSi_79tMYmZZG2gvAgS0:22 a=nmWuMzfKamIsx3l42hEX:22 a=Wh1V8bzkS9CpCxOpQUxp:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=/EmhaQofK3G5RuwmtT2ZTkTGiMdxnAebPcNinPkshuc=; b=dsZfvv9DsCZ0cLphiEKGotRIgO
	knyc3vtz0X6m8X8wA2lV5seag92PCqibQstlF8kYw5RjtY3PvYaFiTRSmDJrkCONQbxTW+nhL5G8l
	qnPDIxqn6/34uUF0VAnbuGeQ6huII/XZPlrSTPTP5Mxl4EXMD5817ABLODnW5Jh3t1ekapevxDKwJ
	dlVhyaiRHNLK9PzHwTxYOl8va0MUhJ3QLzJ5mBZPNmY790Wn1rkwtrzeQyDPlrr8Wf5KY/5dRkMRJ
	BzDUrC0JEAEQbmnKoS9YTBEfokAuz5ARRCDAaPQYPESUWob9a7ce7lIP+TwBHgYHDj7XOUzfL5mS2
	dMWMeN3A==;
Received: from c-73-223-253-157.hsd1.ca.comcast.net ([73.223.253.157]:39722 helo=[10.0.1.116])
	by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.1)
	(envelope-from <re@w6rz.net>)
	id 1uZqLV-00000001iV4-2pER;
	Thu, 10 Jul 2025 06:25:49 -0600
Message-ID: <5cc4fdb6-9a4c-4937-9878-7fcd3d3f0a05@w6rz.net>
Date: Thu, 10 Jul 2025 05:25:43 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] riscv: Stop considering R_RISCV_NONE as bad relocations
To: Alexandre Ghiti <alexghiti@rivosinc.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexandre Ghiti <alex@ghiti.fr>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20250710-dev-alex-riscv_none_bad_relocs_v1-v1-1-758f2fcc6e75@rivosinc.com>
Content-Language: en-US
From: Ron Economos <re@w6rz.net>
In-Reply-To: <20250710-dev-alex-riscv_none_bad_relocs_v1-v1-1-758f2fcc6e75@rivosinc.com>
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
X-Exim-ID: 1uZqLV-00000001iV4-2pER
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-223-253-157.hsd1.ca.comcast.net ([10.0.1.116]) [73.223.253.157]:39722
X-Source-Auth: re@w6rz.net
X-Email-Count: 1
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfIqC2F9mDySzp4MgGKDZvtXFSD2K6v1FIA33FrwnVXZr9Gi6j5BwaU8LWaxdVl54Z+KGlMqcAc9pKCyCQazJ3wk+meU+ORs6Ji8Y30cIZwc/8Af4pKmW
 IQB5Zm0AkClXja08pJrzcs8Vz1nhCS9+yg3i3oXHC3KqkZ9ooUg9CGxGoKiUpgbL0vTWQlaDXjuxeXBNXxNsIKOVkkLtzGsV5rU=

On 7/10/25 01:34, Alexandre Ghiti wrote:
> Even though those relocations should not be present in the final
> vmlinux, there are a lot of them. And since those relocations are
> considered "bad", they flood the compilation output which may hide some
> legitimate bad relocations.
>
> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> ---
>   arch/riscv/tools/relocs_check.sh | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/arch/riscv/tools/relocs_check.sh b/arch/riscv/tools/relocs_check.sh
> index baeb2e7b2290558d696afbc5429d6a3c69ae49e1..742993e6a8cba72c657dd2f8f5dabc4c415e84bd 100755
> --- a/arch/riscv/tools/relocs_check.sh
> +++ b/arch/riscv/tools/relocs_check.sh
> @@ -14,7 +14,9 @@ bad_relocs=$(
>   ${srctree}/scripts/relocs_check.sh "$@" |
>   	# These relocations are okay
>   	#	R_RISCV_RELATIVE
> -	grep -F -w -v 'R_RISCV_RELATIVE'
> +	#	R_RISCV_NONE
> +	grep -F -w -v 'R_RISCV_RELATIVE
> +R_RISCV_NONE'
>   )
>   
>   if [ -z "$bad_relocs" ]; then
>
> ---
> base-commit: d7b8f8e20813f0179d8ef519541a3527e7661d3a
> change-id: 20250710-dev-alex-riscv_none_bad_relocs_v1-ba6048681836
>
> Best regards,

Works good.

Tested-by: Ron Economos <re@w6rz.net>


