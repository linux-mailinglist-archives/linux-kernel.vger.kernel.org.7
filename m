Return-Path: <linux-kernel+bounces-721842-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEBB8AFCE84
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 17:05:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16F4C3A6A81
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 15:05:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2C5A2DAFC1;
	Tue,  8 Jul 2025 15:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="SDHlSuWa"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C0621A288
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 15:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751987123; cv=none; b=FByH7/ub+MBbCYzobGaZ1KtY/Bzaz5Oycv/x4yduosKHb7PIbXlqCJzPyebPTiwkSrd9GfXTnkPYaEXPxS5fjOhqvndNIQG1q97Hl6ktLrTzt8y1gZjCyoSXs9me/9u19uOyOQCpcTpBHt9RbCf57SQW5DqD5MLnFeKqhpaxijE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751987123; c=relaxed/simple;
	bh=LVGpOA1AlOfdfG+4yb7mp9YPnXmLH7nquNwJ8SPuEGc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fFRX33aAMqNPLtRp1kq9I+5urqjm+MwofMvjn5JG7zK1fuxbFkxqJ8Fs6PshTqX58RXZYryy08ZPegdxnfJuBxJdocCbkT2OH1HzJJFsdKiza5DAiLzwp5NxTBvSEkA9Tbhlb+6G7zchtuOJ5GORhIlXiXN9bWqnTo+Ousr9rCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=SDHlSuWa; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 568Ec0oq025387;
	Tue, 8 Jul 2025 15:05:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=2q+LOA
	6JI9ZB1VZSG9Mm/LOXT6Ndp6613RTVPc4LIFw=; b=SDHlSuWajIJNaXYffOR9wN
	ZUqiMr+llWmt00XKszeOh0WB79FqiT2d+OV+TgnN/HU5XKvRnY051XkuGltONDsv
	uW/Js5uQPxJa7dIKa+MesuFh26TDv1qfx3mTW9v+412IUHI+D2rL9sCbOaxXv8D2
	4BsialFxI+zKbLkr6i1tLMKkTt5iYPVq1MrGS4nOZuwk2N+P/IJDF+IcXN3uarGN
	5fRKmfp1Vsv9bC3V4Zc/cwqZWl2CLCZTSO1foLA8RdR1yGDifDo1VfLbwkvYb+Ir
	yi+o0e2aOYWKiiQTFel6s7ZryYF1q3T2X5/NGAm047dkUupbWsPEpN64NdiFb7UA
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47ptjr04y4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 08 Jul 2025 15:05:16 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 568CCk9x013562;
	Tue, 8 Jul 2025 15:05:15 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 47qgkku9k9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 08 Jul 2025 15:05:15 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 568F5Eh929688098
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 8 Jul 2025 15:05:14 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4576158065;
	Tue,  8 Jul 2025 15:05:14 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1DE0658063;
	Tue,  8 Jul 2025 15:05:14 +0000 (GMT)
Received: from [9.61.33.195] (unknown [9.61.33.195])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  8 Jul 2025 15:05:14 +0000 (GMT)
Message-ID: <36700745-a406-43ea-b623-f7033e33deb5@linux.ibm.com>
Date: Tue, 8 Jul 2025 10:05:08 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] fsi: make fsi_bus_type constant
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc: Ninad Palsule <ninad@linux.ibm.com>, linux-fsi@lists.ozlabs.org
References: <2025070100-overblown-busily-a04b@gregkh>
Content-Language: en-US
From: Eddie James <eajames@linux.ibm.com>
In-Reply-To: <2025070100-overblown-busily-a04b@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=GL8IEvNK c=1 sm=1 tr=0 ts=686d33ac cx=c_pps a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=VnNF1IyMAAAA:8 a=voM4FWlXAAAA:8 a=ag1SF4gXAAAA:8 a=zBfx4fC51ErqrqZicDoA:9
 a=QEXdDO2ut3YA:10 a=IC2XNlieTeVoXbcui8wp:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-Proofpoint-ORIG-GUID: nkxnG2WeZVDqX7a-Tz4Uj7UZpllGqux2
X-Proofpoint-GUID: nkxnG2WeZVDqX7a-Tz4Uj7UZpllGqux2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA4MDEyNCBTYWx0ZWRfX0ELS8OGLxwb8 pxqqlJk0vIAkiRMbQIot5zi9hWMoSwj8XYFyIqo3K5LvENy48tgqcmXo0PYVZY5fO/rXUNjzeHJ aK/rub2URZrHV4Non4JpCLyjExgdYjgL2FxBghgGxYY3kBy4g88AvJnLvdl9mPjETawAmIqipsg
 +O4kzvrrlQVdIlA4GiQtd9mfdHZ6Wq9uzOmf13ybg7TVPvicZx9AeOyfNreU/rdlTPXn+FKbJj2 1n4JzVorPWzD/rozchd61oh9EjHN0zgC/J2nncegxS8+j7UOeDY8Ho4W/PN1ePxuAnFSFQAW+hT l4Xr/C7rPDaQvv/Nz8jsVsoCP+8JthawwOzZdHP692CUHj+tpIo97YN2ejEtEgbBBdLl2wYWvGK
 P5PC++BAhzQrBg4QoNmTpiQ/V2DhOjfZXeN0kzQfDwEFpDmF+BG8pMaoe3sMNxioFsVQRr9B
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-08_04,2025-07-07_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 clxscore=1011 impostorscore=0 suspectscore=0 bulkscore=0 adultscore=0
 priorityscore=1501 mlxscore=0 spamscore=0 mlxlogscore=999
 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507080124


On 7/1/25 07:07, Greg Kroah-Hartman wrote:
> Now that the driver core can properly handle constant struct bus_type,
> move the fsi_bus_type variable to be a constant structure as well,
> placing it into read-only memory which can not be modified at runtime.


Reviewed-by: Eddie James <eajames@linux.ibm.com>


Thanks Greg.


>
> Cc: Eddie James <eajames@linux.ibm.com>
> Cc: Ninad Palsule <ninad@linux.ibm.com>
> Cc: linux-fsi@lists.ozlabs.org
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
> v2: fix up subject line to be correct
>
>   drivers/fsi/fsi-core.c | 2 +-
>   include/linux/fsi.h    | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/fsi/fsi-core.c b/drivers/fsi/fsi-core.c
> index 50e8736039fe..ee39d1699387 100644
> --- a/drivers/fsi/fsi-core.c
> +++ b/drivers/fsi/fsi-core.c
> @@ -1404,7 +1404,7 @@ void fsi_driver_unregister(struct fsi_driver *fsi_drv)
>   }
>   EXPORT_SYMBOL_GPL(fsi_driver_unregister);
>   
> -struct bus_type fsi_bus_type = {
> +const struct bus_type fsi_bus_type = {
>   	.name		= "fsi",
>   	.match		= fsi_bus_match,
>   };
> diff --git a/include/linux/fsi.h b/include/linux/fsi.h
> index 8c5eef808788..adea1b432f2d 100644
> --- a/include/linux/fsi.h
> +++ b/include/linux/fsi.h
> @@ -68,7 +68,7 @@ extern int fsi_slave_read(struct fsi_slave *slave, uint32_t addr,
>   extern int fsi_slave_write(struct fsi_slave *slave, uint32_t addr,
>   		const void *val, size_t size);
>   
> -extern struct bus_type fsi_bus_type;
> +extern const struct bus_type fsi_bus_type;
>   extern const struct device_type fsi_cdev_type;
>   
>   enum fsi_dev_type {

