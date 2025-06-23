Return-Path: <linux-kernel+bounces-699142-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 667CEAE4E58
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jun 2025 22:46:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C56A3A7389
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jun 2025 20:46:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E452F1E51E1;
	Mon, 23 Jun 2025 20:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="SZy/nLP/"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2E7F450FE;
	Mon, 23 Jun 2025 20:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750711589; cv=none; b=WodmqSos63PMhhR/7SONYXPVaqUXq7Abt7Q8YPfAlOQXskYJ2fJ9q0sDHomzuYvAZ2u9z/QWM/gfzztucRnGCHivcWkV7FX1BbGgWWziRzN7DtlufGnY/iokW7GLENR2BDKSfc34SahW5tnr9DuZqmK+xy5Sg+TzTZJLhDOjjlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750711589; c=relaxed/simple;
	bh=VdnbWeqI8Ap67iCrQCAySa8md3YMTF7BkfXz/DYRji8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oTOB9NcJ7IJlTS/IM1sVQTkRKqDSeI/ydAd/FG1NHekyjzzHHaNSEPh9b7NLL9RYlmi6Q9NfssyTA7qhapRQZdaeDo17b/XxaW+5TaZ+aUPinQ0NvKFw16YoUihzCrAUKnTV3KfOUMS+P1PI4O+BkE85owzIurHFjr7318ssjYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=SZy/nLP/; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description;
	bh=fqTupFHdWOP7XknPjNhQ1+otLO26YLnn5ZSEsxhj8Do=; b=SZy/nLP/3c+QnF2BTKRl/kNQxj
	AvTwWK7ITnnOpj9kUWgxUlM079YiCqRv0XrRCWrbvBJD5o+xeJHfeGBxMjmGCMo5Q9PL2GlbGG1Q0
	tyK3+41KZT/bFOsIW7hZMPLaFHzdHZlEfm8Y/N/APALXsPWLteRNWbKKDXl0KeGw4XRqdyl5hGbhb
	Uft+5d1Cn7kgwT7dcOiafFVnKG8KIOukX+wiqgbPtU6v6oHcJoRZVn2DNKyRuoei2Tgadhp9YyK1I
	hz3maER1osGsNiIUlG6+mCtitDdFDjwIH1BvYjrLeIBXOTb10S6jhTuBoag+fnD+HZgOFi1co54Lt
	0Df6ep5w==;
Received: from [50.53.25.54] (helo=[192.168.254.17])
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uTo3Y-00000004ZHA-0h2U;
	Mon, 23 Jun 2025 20:46:20 +0000
Message-ID: <ff61ff8e-d20c-444e-988f-6d97a197e070@infradead.org>
Date: Mon, 23 Jun 2025 13:46:17 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] nvme: Fix typo in status code constant for self-test
 in progress
To: Alok Tiwari <alok.a.tiwari@oracle.com>, linux-nvme@lists.infradead.org,
 kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
 kch@nvidia.com, nilay@linux.ibm.com, corbet@lwn.net
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250623064036.4187788-2-alok.a.tiwari@oracle.com>
 <20250623064036.4187788-5-alok.a.tiwari@oracle.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20250623064036.4187788-5-alok.a.tiwari@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 6/22/25 11:40 PM, Alok Tiwari wrote:
> Corrected a typo error in the NVMe status code constant from
> NVME_SC_SELT_TEST_IN_PROGRESS to NVME_SC_SELF_TEST_IN_PROGRESS to
> accurately reflect its meaning.
> 
> Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
>  drivers/nvme/host/constants.c | 4 ++--
>  include/linux/nvme.h          | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/nvme/host/constants.c b/drivers/nvme/host/constants.c
> index 1a0058be58210..dc90df9e13a21 100644
> --- a/drivers/nvme/host/constants.c
> +++ b/drivers/nvme/host/constants.c
> @@ -133,7 +133,7 @@ static const char * const nvme_statuses[] = {
>  	[NVME_SC_NS_NOT_ATTACHED] = "Namespace Not Attached",
>  	[NVME_SC_THIN_PROV_NOT_SUPP] = "Thin Provisioning Not Supported",
>  	[NVME_SC_CTRL_LIST_INVALID] = "Controller List Invalid",
> -	[NVME_SC_SELT_TEST_IN_PROGRESS] = "Device Self-test In Progress",
> +	[NVME_SC_SELF_TEST_IN_PROGRESS] = "Device Self-test In Progress",
>  	[NVME_SC_BP_WRITE_PROHIBITED] = "Boot Partition Write Prohibited",
>  	[NVME_SC_CTRL_ID_INVALID] = "Invalid Controller Identifier",
>  	[NVME_SC_SEC_CTRL_STATE_INVALID] = "Invalid Secondary Controller State",
> @@ -145,7 +145,7 @@ static const char * const nvme_statuses[] = {
>  	[NVME_SC_BAD_ATTRIBUTES] = "Conflicting Attributes",
>  	[NVME_SC_INVALID_PI] = "Invalid Protection Information",
>  	[NVME_SC_READ_ONLY] = "Attempted Write to Read Only Range",
> -	[NVME_SC_CMD_SIZE_LIM_EXCEEDED	] = "Command Size Limits Exceeded",
> +	[NVME_SC_CMD_SIZE_LIM_EXCEEDED] = "Command Size Limits Exceeded",
>  	[NVME_SC_ZONE_BOUNDARY_ERROR] = "Zoned Boundary Error",
>  	[NVME_SC_ZONE_FULL] = "Zone Is Full",
>  	[NVME_SC_ZONE_READ_ONLY] = "Zone Is Read Only",
> diff --git a/include/linux/nvme.h b/include/linux/nvme.h
> index b65a1b9f2116c..655d194f8e722 100644
> --- a/include/linux/nvme.h
> +++ b/include/linux/nvme.h
> @@ -2155,7 +2155,7 @@ enum {
>  	NVME_SC_NS_NOT_ATTACHED		= 0x11a,
>  	NVME_SC_THIN_PROV_NOT_SUPP	= 0x11b,
>  	NVME_SC_CTRL_LIST_INVALID	= 0x11c,
> -	NVME_SC_SELT_TEST_IN_PROGRESS	= 0x11d,
> +	NVME_SC_SELF_TEST_IN_PROGRESS	= 0x11d,
>  	NVME_SC_BP_WRITE_PROHIBITED	= 0x11e,
>  	NVME_SC_CTRL_ID_INVALID		= 0x11f,
>  	NVME_SC_SEC_CTRL_STATE_INVALID	= 0x120,

-- 
~Randy

