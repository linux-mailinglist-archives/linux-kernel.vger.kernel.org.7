Return-Path: <linux-kernel+bounces-750034-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 59959B15620
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 01:46:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C2BF018A53CD
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 23:47:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38BD82586E0;
	Tue, 29 Jul 2025 23:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="H3bO8CEK"
Received: from omta36.uswest2.a.cloudfilter.net (omta36.uswest2.a.cloudfilter.net [35.89.44.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A02531B425C
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 23:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753832805; cv=none; b=oqwKbRKifTWQQKuidfy8NYXxtEShuhfDTR5fUb210gXXfmYl5uK2XTiu1eq3N9frzvVvzL4Ma5PBsHHhixGmVPbaMpcRh2MMZT02rR1SN7G5aRaKRV0sWoaOMBZvCfbG2ZRFpIou2y+7mYZTmnXdNrn2fGQ02FjJUkQ6y2OexQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753832805; c=relaxed/simple;
	bh=mTj2wbl+I3PGEq8G8O7TyLPSsDYFsFAB1OylGeG/daU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E77riw8qDiZktENDv7xl0X/CsSWkSUESlYHSOVL+AfqbV+EukI4EB1FQ5UlXrBpTyU7rvV3g40w5ZmWRB3KUCjgBbFJl6XpnXr9/ciN1x5/GaPfHrLpyw6Scj24eT3hg1FnghvFmlwiUfEbAszxGfqNdOVR9axj0vUWvcommS88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=H3bO8CEK; arc=none smtp.client-ip=35.89.44.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Received: from eig-obgw-6009a.ext.cloudfilter.net ([10.0.30.184])
	by cmsmtp with ESMTPS
	id gsHyusTqjJLhFgu1luCvNY; Tue, 29 Jul 2025 23:46:37 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id gu1kuWjCYBuAYgu1kum49C; Tue, 29 Jul 2025 23:46:36 +0000
X-Authority-Analysis: v=2.4 cv=PKsJ++qC c=1 sm=1 tr=0 ts=68895d5c
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=elAakMZAzsQyfqpwiXQzJA==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=7T7KSl7uo7wA:10 a=VwQbUJbxAAAA:8
 a=LkGgtk_mD-K1Z87GI3QA:9 a=QEXdDO2ut3YA:10 a=81G-pNLuioy3FeR5hyPK:22
 a=xYX6OU9JNrHFPr8prv8u:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Xa3fIpZmUcAzIG0aJulrboKDmbvZ9/HdC6HeG/dtPPk=; b=H3bO8CEKpmnQkgqTYgjPXY6YNS
	PvDPAbn/W70FrfwLmpEvnwTjQuhmY2N52xlZwnQrTUF/MOgUba6UC6TG2KZlnlTbOCfo+YpiIAV27
	PD1WJ6peo81HQhF/orArXsjVuDYnXQPgsD35vSP9KyiLtZCgi/gK35WWRB/ryw2wnrNVDZyjrNNbm
	U+akj7or7XKoC57LtIfARHNMutljOftB89krDrDniGkHWK/2AcIaUXiitBjZM3xW0BleB2ZkBMv3C
	qVg/17SxpLq6gVYJ9/sBKOPy3ERyJ4HOvn8e5rnjXVMqrg2zHgFdqsWufT0fDlPCCdnD8niuy9Oxf
	rkMK/rnw==;
Received: from [177.238.16.239] (port=34252 helo=[192.168.0.21])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.1)
	(envelope-from <gustavo@embeddedor.com>)
	id 1ugu1j-00000003Ovq-40VR;
	Tue, 29 Jul 2025 18:46:36 -0500
Message-ID: <93ffea26-ab8e-4fc6-9aa9-9850a34d08d7@embeddedor.com>
Date: Tue, 29 Jul 2025 17:46:30 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fortify: Fix incorrect reporting of read buffer size
To: Kees Cook <kees@kernel.org>, linux-hardening@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
References: <20250729231817.work.023-kees@kernel.org>
Content-Language: en-US
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20250729231817.work.023-kees@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 177.238.16.239
X-Source-L: No
X-Exim-ID: 1ugu1j-00000003Ovq-40VR
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.0.21]) [177.238.16.239]:34252
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 1
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfO/b0zsH4uP9eRvlBj4QHDG+tBhHIsPiyILBMaolTLKDPkWkdYjI18/vmbAqjv1mKHAdSpU5ZTx3sjaLuSBPreqtGGR1D8eW4id6FqWcuMd2xhKUA9Ne
 F7zs+gK64P9dUWCmd9k33+6NvL84uHwGzISGtGbrCxREb5Woi0/8t9hDSytW9ozy2ymMKaAugEfshrxG3WCAQKi1W5mVZ6ZOsVcxXUpMRy3OO/rYR/0wOTdP



On 29/07/25 17:18, Kees Cook wrote:
> When FORTIFY_SOURCE reports about a run-time buffer overread, the wrong
> buffer size was being shown in the error message. (The bounds checking
> was correct.)
> 
> Fixes: 3d965b33e40d ("fortify: Improve buffer overflow reporting")
> Signed-off-by: Kees Cook <kees@kernel.org>

Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks!
-Gustavo

> ---
> Cc: <linux-hardening@vger.kernel.org>
> ---
>   include/linux/fortify-string.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/fortify-string.h b/include/linux/fortify-string.h
> index e4ce1cae03bf..b3b53f8c1b28 100644
> --- a/include/linux/fortify-string.h
> +++ b/include/linux/fortify-string.h
> @@ -596,7 +596,7 @@ __FORTIFY_INLINE bool fortify_memcpy_chk(__kernel_size_t size,
>   	if (p_size != SIZE_MAX && p_size < size)
>   		fortify_panic(func, FORTIFY_WRITE, p_size, size, true);
>   	else if (q_size != SIZE_MAX && q_size < size)
> -		fortify_panic(func, FORTIFY_READ, p_size, size, true);
> +		fortify_panic(func, FORTIFY_READ, q_size, size, true);
>   
>   	/*
>   	 * Warn when writing beyond destination field size.


