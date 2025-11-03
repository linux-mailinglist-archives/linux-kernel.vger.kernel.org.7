Return-Path: <linux-kernel+bounces-883501-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2401C2D9D1
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 19:13:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 619353B8AE5
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 18:12:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65CEA314D25;
	Mon,  3 Nov 2025 18:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="S9fiLhb6"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 263F817A309
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 18:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762193556; cv=none; b=ebPEvtcjr2tN7kp7XAEk9EBNvgGAIDlx3murD/h+q6z2PEc2LEEo3SlXq7kf5ETP0E3rZI+DLszOImTkb42GLWbz4HNAUowFbn7ze9xEWdlbiXWL4eaOsjxOPekFL4jbHJnG7HAjUh6OyS2inCQlai0NbyqLWJVL0wKjdIh+HUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762193556; c=relaxed/simple;
	bh=RrEPeI9IoX4cpr4X8PabDKZ8aceTWPLs5YVZ9FX/Uc4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Dev/C6rjikGf7VrypiT3JTNxQ4KHan3DCa3xMjTTxAotudro3ODamRTnC8OI6oEDARje2ETNlnA4zZeFXCCf0yMyIlFAw6rdpZOAEvZV1Nt75R9Spskr4PI/VK4TLENqClZoqxAfbtR3CV4z/uQA6T6Y8N/lDmLliCR7SJ7m2y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=S9fiLhb6; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5A3EfXnD013046;
	Mon, 3 Nov 2025 18:12:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=aV0W83
	3xXLtn8mocQ6UKoaSRW5kTrXZu+V6GeQZCP4o=; b=S9fiLhb6dCBR6chdWYNLKF
	FdtWO+PTOZ1jPvNrn1oWm49fy+6p5JdrzDGRCP2bhhxNcSMrkBZCoow7uqGLyPhK
	vcsjh5ap4eu9/IJ8cDlpWC6TBr1bULEnPKMmYPQROmMycsgsMdO+Dz+dmG0XCi0m
	ozyB/o6/Uk1HWEsLThl3HjrUtXzDZ+OedkDPulTo3f80dT2MUXI/v0nquq+xHyrv
	6o+aDItz8BMdVRodHh5uvIiaTP78SrqeIvYqTaK//tlTd+oruiOeaMj4tJ261Sdy
	yuBuavap42jHnWAHbIiBSDQcWbeQzELWgY9CWoLJhWrWdqYc+SSP0W8EgJagQ45Q
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a58mkr2a3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Nov 2025 18:12:25 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5A3H6tPt027375;
	Mon, 3 Nov 2025 18:12:24 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4a5vwy78uy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Nov 2025 18:12:24 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5A3ICOUg10617448
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 3 Nov 2025 18:12:24 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F1D8C5805A;
	Mon,  3 Nov 2025 18:12:23 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A786958054;
	Mon,  3 Nov 2025 18:12:23 +0000 (GMT)
Received: from [9.61.98.95] (unknown [9.61.98.95])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  3 Nov 2025 18:12:23 +0000 (GMT)
Message-ID: <2c522376-2a3b-44bf-b936-f0aeb70a376d@linux.ibm.com>
Date: Mon, 3 Nov 2025 12:12:23 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fsi: master-hub: Fix of_node leak in probe error path
To: Haotian Zhang <vulab@iscas.ac.cn>, Ninad Palsule <ninad@linux.ibm.com>,
        gregkh@linuxfoundation.org
Cc: linux-fsi@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20251030095534.770-1-vulab@iscas.ac.cn>
Content-Language: en-US
From: Eddie James <eajames@linux.ibm.com>
In-Reply-To: <20251030095534.770-1-vulab@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: p4wi3x0ObDmgSxy9M8r7Amy7nGTvv09Y
X-Proofpoint-GUID: p4wi3x0ObDmgSxy9M8r7Amy7nGTvv09Y
X-Authority-Analysis: v=2.4 cv=SqidKfO0 c=1 sm=1 tr=0 ts=6908f089 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VnNF1IyMAAAA:8 a=H3Yl5Fb59XilEcTE980A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTAxMDAwOSBTYWx0ZWRfXwBJIRkgv4eAR
 3wBZzAwXBTqe1fL8c+IPJeWoez5qBCW9t13JmDuOW9B3CfyZEq7BsHlxjFzdi2javqvtu33dOOs
 iz4R962Ptdw/n6ChAVHWlfiX0pA5Fke1q5zeCQqr/rQwqdv1ahjUp538vsvYrheL4tMVBnnnsJK
 RCT3/Tn3w0+JrS8JXYeqLNpF/EzR63DenRWV6laNcM1aOBWwo36P58sHgkjTt4yX+Qom1RS4zsY
 k9ffjghss7pzYkKuwsvkKpUGj0OsZwghXSPHAn28xuHXDk96Wz98t86cInX15hDpQ2SI5wQ4DA1
 y38jhhctybFxEyOm9oCSxKKx9FanpCxJ7fWhHM/BVUTNoi5Ro8iyX9Nz0FEDLkpAxoDKK2B+FIc
 BplwwUTmPI61eZY/QEHXL5viCPJiVg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-03_03,2025-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1011 impostorscore=0 adultscore=0 lowpriorityscore=0
 malwarescore=0 spamscore=0 priorityscore=1501 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511010009


On 10/30/25 4:55 AM, Haotian Zhang wrote:
> If the call to fsi_master_register() fails, the function exits
> without releasing the of_node reference previously acquired via
> of_node_get(). This results in an of_node reference count leak.
>
> Add a call to of_node_put() under a new label to ensure the
> reference is correctly released before the function returns.


Reviewed-by: Eddie James <eajames@linux.ibm.com>


>
> Fixes: f6a2f8eb73f0 ("fsi: Match fsi slaves and engines to available dt nodes")
> Signed-off-by: Haotian Zhang <vulab@iscas.ac.cn>
> ---
>   drivers/fsi/fsi-master-hub.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/fsi/fsi-master-hub.c b/drivers/fsi/fsi-master-hub.c
> index 6568fed7db3c..e259ed1c17e0 100644
> --- a/drivers/fsi/fsi-master-hub.c
> +++ b/drivers/fsi/fsi-master-hub.c
> @@ -241,7 +241,7 @@ static int hub_master_probe(struct device *dev)
>   
>   	rc = fsi_master_register(&hub->master);
>   	if (rc)
> -		goto err_release;
> +		goto err_free_node;
>   
>   	/* At this point, fsi_master_register performs the device_initialize(),
>   	 * and holds the sole reference on master.dev. This means the device
> @@ -253,6 +253,8 @@ static int hub_master_probe(struct device *dev)
>   	get_device(&hub->master.dev);
>   	return 0;
>   
> +err_free_node:
> +	of_node_put(hub->master.dev.of_node);
>   err_release:
>   	fsi_slave_release_range(fsi_dev->slave, FSI_HUB_LINK_OFFSET,
>   			FSI_HUB_LINK_SIZE * links);

