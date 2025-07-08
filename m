Return-Path: <linux-kernel+bounces-721840-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 342FEAFCE7F
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 17:03:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D3B367B0653
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 15:02:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F7272DEA78;
	Tue,  8 Jul 2025 15:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="SyK8adhb"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75AD11E521B
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 15:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751987001; cv=none; b=UF5VWpC62C3UT5ZtyZaP4Bgs3oLU5HaASm1kycLVDGcL55BGhHQWaKl76us5ll5CMkjFbyp5YMIvDwKuOD9xpdQf1IfjSwEFCcGyWEMl0CijnGJkvJ/9MgzJMTyeQJDwDPoTRrl0x1R1aKqYNqL8bnA9pcv2YWnIDnNKSVNtw3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751987001; c=relaxed/simple;
	bh=XUUljEPgNxcmjyL6d3HVbUXtV0Gu4cHRa/Ie98N4Xl8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SUSXeYLk2n2QPCABkWAokmJF4c/MwIpL7Sf0sMZjYLDY6v5P6owGtHEfUECXizsGPoQUxuhnlqs4JoeFmX/em0GVy84+iUhgVRC9bPbCBjU73Lh3MWdZr4QsrHV8MysfWCTDZ65JntSRqdgmwBMGvLjB3KSJJkW7z0qtIF0/KYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=SyK8adhb; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 568DJ0OB026957;
	Tue, 8 Jul 2025 15:03:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=izftfL
	/oTXfqxe+Y0dEjMOpPPecFJ6ha2DXsx4ntAck=; b=SyK8adhbBw4TwQNWARBthq
	kx8Tgz2fgeOZa8YomdsJ8NBUYwRXUId4b6TjMRpbA5G7S9hbfaq4Apqkwk+fIRlZ
	VDIQdL3KQVr3+24KL1xFrbmz3ss0xZoKLaBLyU34WGjepmrOhUttmI5SOLcPZQMl
	LYSYVvZI6VYm+l68o6B6OScZoefwY6Qgc1KwOOGhgR5DY2N3GSeNFrlCavFY0zVc
	3ZT7cjf4ZfR7O5Bc5+EEsFHc17q8laWlyJzQeJG+oGi19G9Nu7lAYv3VOEU6KaEO
	rrHUqBKF2gyVpfk5qXxjfulxnoJizv6bJU2Xk60jgI14sP9P917KwHVlJzcxNI9A
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47pur70nj9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 08 Jul 2025 15:03:08 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 568C2f57013583;
	Tue, 8 Jul 2025 15:03:07 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 47qgkku98w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 08 Jul 2025 15:03:06 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 568F30Ka1245802
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 8 Jul 2025 15:03:00 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 181965805E;
	Tue,  8 Jul 2025 15:03:06 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E60F758056;
	Tue,  8 Jul 2025 15:03:05 +0000 (GMT)
Received: from [9.61.33.195] (unknown [9.61.33.195])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  8 Jul 2025 15:03:05 +0000 (GMT)
Message-ID: <6e6b8559-fc16-4894-95c8-35669def48e2@linux.ibm.com>
Date: Tue, 8 Jul 2025 10:03:03 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fsi: master-ast-cf: Use
 of_reserved_mem_region_to_resource for "memory-region"
To: "Rob Herring (Arm)" <robh@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-fsi@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Ninad Palsule <ninad@linux.ibm.com>
References: <20250703183439.2073555-1-robh@kernel.org>
Content-Language: en-US
From: Eddie James <eajames@linux.ibm.com>
In-Reply-To: <20250703183439.2073555-1-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA4MDEyNCBTYWx0ZWRfX/ZDt5x7iqUbx R4hTpGttxe8wFjS3p6Y+yJhTyDDxWbSRmxugjVmG/CqCsoeJRQfUC94UZX91MuXtEggHNwYsA7l xg1ZmBD+N/SxGlIiyfin8GsRIQW/ausIZlDl7QHA7DJgyUAf1bkM/e9x7DrQXFaZ3XfKCofRRMk
 QRr7hdvPdFTd9oxrmDCzsxwX232N7aVLc0RKTXDu7YWVk1mPFnd8Rbz7aNg8ZAPwbnr/VmA33jn 9fUBAyBrPPnmpH6uQvUgaw5bePi0FijotHsIlL9hre/gTz/pM1Ts/ixFQqweLfhq1TZQAKOjRAY 4dwWFmKn8SlPkOvgLUfIJqg0DjqH/r9i7/TOBxRd0R/KYVDDh8lOrGc0NjYhW8bmAapxkaNYYsI
 TDd4oLnIiY2gOL1+8m5lHFumbCuDdZoXCGk4+vx3DP7dN9wTsq86rWoXM7BD0MPwxTlUBt96
X-Proofpoint-GUID: QnN4y2PNEEFVow56lY02Yh20NDpwwJTx
X-Proofpoint-ORIG-GUID: QnN4y2PNEEFVow56lY02Yh20NDpwwJTx
X-Authority-Analysis: v=2.4 cv=W/M4VQWk c=1 sm=1 tr=0 ts=686d332c cx=c_pps a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8 a=W5veIoyndjp2xtm7xIYA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-08_04,2025-07-07_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 mlxscore=0 priorityscore=1501 adultscore=0 clxscore=1011 suspectscore=0
 spamscore=0 lowpriorityscore=0 mlxlogscore=999 bulkscore=0 impostorscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507080124


On 7/3/25 13:34, Rob Herring (Arm) wrote:
> Use the newly added of_reserved_mem_region_to_resource() function to
> handle "memory-region" properties.


Reviewed-by: Eddie James <eajames@linux.ibm.com>

Thanks Rob.


>
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> ---
>   drivers/fsi/fsi-master-ast-cf.c | 11 ++---------
>   1 file changed, 2 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/fsi/fsi-master-ast-cf.c b/drivers/fsi/fsi-master-ast-cf.c
> index 9f2fd444ceb6..e67d7cd30fca 100644
> --- a/drivers/fsi/fsi-master-ast-cf.c
> +++ b/drivers/fsi/fsi-master-ast-cf.c
> @@ -13,13 +13,13 @@
>   #include <linux/irqflags.h>
>   #include <linux/module.h>
>   #include <linux/of.h>
> +#include <linux/of_reserved_mem.h>
>   #include <linux/platform_device.h>
>   #include <linux/slab.h>
>   #include <linux/regmap.h>
>   #include <linux/firmware.h>
>   #include <linux/gpio/aspeed.h>
>   #include <linux/mfd/syscon.h>
> -#include <linux/of_address.h>
>   #include <linux/genalloc.h>
>   
>   #include "fsi-master.h"
> @@ -1285,14 +1285,7 @@ static int fsi_master_acf_probe(struct platform_device *pdev)
>   	master->gpio_mux = gpio;
>   
>   	/* Grab the reserved memory region (use DMA API instead ?) */
> -	np = of_parse_phandle(mnode, "memory-region", 0);
> -	if (!np) {
> -		dev_err(&pdev->dev, "Didn't find reserved memory\n");
> -		rc = -EINVAL;
> -		goto err_free;
> -	}
> -	rc = of_address_to_resource(np, 0, &res);
> -	of_node_put(np);
> +	rc = of_reserved_mem_region_to_resource(mnode, 0, &res);
>   	if (rc) {
>   		dev_err(&pdev->dev, "Couldn't address to resource for reserved memory\n");
>   		rc = -ENOMEM;

