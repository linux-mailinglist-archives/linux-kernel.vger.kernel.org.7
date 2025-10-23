Return-Path: <linux-kernel+bounces-866108-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B4809BFEE53
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 04:14:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6EDFE4E692E
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 02:14:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36D881EBFF7;
	Thu, 23 Oct 2025 02:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="G5rYdFIO"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF29D1E3DDB
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 02:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761185675; cv=none; b=bqCjLdTQbzWlkOtIAuH0oJQvbW600cc+2nc4S+CisubkGXBIPCUbgpBnMFFWs9gkg/tvu5q4sQ3cRmu30Gq4WBvJD4FzATKZnh0PFAAlcqUGAyULPe33ZlWX766w3SlpSJLOCN7l7LmLOuT9jvg0BtbYx3v0EFzGsMlmzJxnsEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761185675; c=relaxed/simple;
	bh=Crvu/VnJZCIRTR9Xt76dOjc21V0vgegrmIOOALewBSg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mO+S8wOIZjI2dhLI61eijQGhJtXsD2cNTxhsWomCko+GmVaQ6e2VRUkBSx+q7A7vmL9LLXqb/JHOgEDFCjL/WYvm4Z8Q7v/FujBz6OTISswQmm1HWEnLhegIj55O/e8Vgk5yzmaOZsK64bLsTWelase3onVxz2dYZyiVD8/AV2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=G5rYdFIO; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59MIetPJ006687
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 02:14:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ju/EYHotMPeYkqqdMnrAWkTzONxAZN8mNt5RuG+Xxew=; b=G5rYdFIOY+LqeBPz
	XaEBaugn1UjYX2utwJyOP2GaGV/bBPbELMl5LID5QdbsFrzhZWEjiXVq6dv9O5Yx
	D8C7zIz5jf4SJ9P+odnj3nsPNBSk0Q46Qw3foqeY9eCz8rVgCS3qoi45mxRleiN+
	S4jBUyQPXfzqwfCoy2Olwhd1FF1sdZChChTintQ2liOW0Kqfsl38VeAOt+WIyHmB
	ioa25gZYMM1uL8d35Rd183zyWpjIVwsrDZYPImGszPHI2HQGkleJ0seQEb75VqWH
	A8Fx6/EQeFHTBTBZmapH1nIYT+sBVNBkQD8R+JfGHwagkZ/ZanYG8xpl4fa7P8vG
	yPB+4A==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49v27j6kk2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 02:14:30 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-32eb18b5659so238995a91.2
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 19:14:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761185669; x=1761790469;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ju/EYHotMPeYkqqdMnrAWkTzONxAZN8mNt5RuG+Xxew=;
        b=AuSgl4t3QxdxJNOM6GtGW+I+/CcUX6ILFwbjBoVX6yQ50ce+ywCyrSyiUlteGWrLYe
         8nskZxCVUW9VAACFTH6C9jquAdobyQVEYa/uHc/JiNjgcuh5GmwdVz5LuLXxOPoxdpnZ
         DY4HD1ZimxBxF6uRR9yEAR0f3DV1q724/ZOJ6cuLtEwdQCS4rEPLGjnCNMAio3oobwKJ
         3Ifq1qqqQDbzxXeawoP3rdyxVHI+UUJkv0Gine4s0HB192mlef6h3uhue5cxZK9OoppH
         bWHBe8Tz01AaMjnpChvXi9kUlWB/IQBC155pxoRFEoTvP8staO9HbdSP2tZsEDPnvkh9
         1KKw==
X-Forwarded-Encrypted: i=1; AJvYcCVsW0DCl/1yDOMyDD8ENEpl0CAc/RHLj5oD6ImzaLihBd265q9gl+2O2pySbD14PeLaWkbLL2r4w7EVHsQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzS6wfar309MszQ/Im1QKGxju5uJ/Iz2loNUnElgXqkffQT+y07
	OSs/W6t+zqimMaVST48fLk1VBKCPfN/3/7TxV0Tpdh1SetABViFGAO1On+LBj9haeMk7gso5jy2
	flxzMiUI3Q+xv3GGs9/guuHJYEjSOIaFJa7bJp5EXOwHa5qbdIsUGofiVwFuW+9LMvYY=
X-Gm-Gg: ASbGncubMpPa9uxCq9axbe6Ru/LCrlhZyjjfUBB0w5NxSSbdny5Eebt4LCsUHG/zvdC
	ey46GZXKqgEEeR+PAiPf9gcr9TXUtNTVWDIRMHCU9BeRBR1W36d+mfqbKltvr8RAlUcn6Rj0Hwk
	VZO49p0r1HaBu4R+1zuXBp8DuMtbNDJzJKhS41qlE8RwoX1iUblwxgQVFfb3xYOGknsgteXf9jr
	vAsx+oBlBWHPIxOS07X+RLl5jAY/2q1nMrWUYfYayS7rDcL5UH3b8BLDwRvqSTcdDHJ9bFCvYYw
	uObalWIDfaI18yMwUmmJZBK0o/EaC5btF6rhoDYF09k0Ifb4D7zrqEOVH3H8U4e/cjyhNk3fteH
	Sw1iHVtg9hFTTcGK7cLXdE1e7P7eMuWeGQqcpP7gbfwNq5N4Ed2lzHLxjXQpcoz3j/Pxkng==
X-Received: by 2002:a17:90a:ec8b:b0:335:2934:e217 with SMTP id 98e67ed59e1d1-33bcf86c0a9mr29898664a91.10.1761185668846;
        Wed, 22 Oct 2025 19:14:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEZMHBmfhd1lGJWsQDMeedq9yoSpiYR/IqvWq9XnG7U9WPCzMjAvdOHLzKmgoGRxTVBhDNVWw==
X-Received: by 2002:a17:90a:ec8b:b0:335:2934:e217 with SMTP id 98e67ed59e1d1-33bcf86c0a9mr29898640a91.10.1761185668358;
        Wed, 22 Oct 2025 19:14:28 -0700 (PDT)
Received: from [10.133.33.160] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33fb01724a5sm618529a91.15.2025.10.22.19.14.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Oct 2025 19:14:28 -0700 (PDT)
Message-ID: <ca17c522-134c-4481-a92a-dee0b90f8f97@oss.qualcomm.com>
Date: Thu, 23 Oct 2025 10:14:22 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] soc: qcom: smp2p: Add support for smp2p v2
To: Bjorn Andersson <andersson@kernel.org>
Cc: Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Chris Lew <chris.lew@oss.qualcomm.com>
References: <20250923-smp2p-v1-0-2c045af73dac@oss.qualcomm.com>
 <20250923-smp2p-v1-2-2c045af73dac@oss.qualcomm.com>
 <76gekllxr5meizr7wbvxjibdncdw7kp2q4zjjxtmdtfnwt4owc@dum7e77j4bie>
Content-Language: en-US
From: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
In-Reply-To: <76gekllxr5meizr7wbvxjibdncdw7kp2q4zjjxtmdtfnwt4owc@dum7e77j4bie>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAxOCBTYWx0ZWRfX7KdvoGLELiC3
 ZeQExd7YqQnL9EFc0G5IA/vFz06YxrHR+6ycMAaSDlHFIOVD98x8dqW6saah5qXpD7tcxjBBF7T
 8ddeiWIvNR1ECGn/Q3msR3CEMdLk+rB8IqAFgTbb4rRuAOkMD424lPaE1vgf7zjckDoH0nlLPHO
 uejmpL3ogXjlGTycc0brPScX3HffEriseQqigPHEmXfcJwF6m8/ct/IZnmO12HZZkUqMinDA3P9
 5XBbVCE3YSwpAUpKRJ2u1Rpksd2Wm/vKnLn/P0p9T1fkm+PdbR1emsnBUefdUXmpbF0nWd3aoDy
 9kgQgg5Ds/Bf2LyuPbLaefg6xqoC7NOSXQZtYe6t6gFt2edcWtGplBR+La+lCUVCwCnHG7kHw7T
 wlGYdlpMfJcVWrc53RwAOV6pvxmSBA==
X-Authority-Analysis: v=2.4 cv=G4UR0tk5 c=1 sm=1 tr=0 ts=68f98f86 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=psBAKaDzHMd9wCF3-JcA:9 a=0bXxn9q0MV6snEgNplNhOjQmxlI=:19
 a=QEXdDO2ut3YA:10 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-GUID: IVElP7RadDdjLkYb2OUpSFTZONIxGTmK
X-Proofpoint-ORIG-GUID: IVElP7RadDdjLkYb2OUpSFTZONIxGTmK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_08,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 malwarescore=0 bulkscore=0
 priorityscore=1501 spamscore=0 suspectscore=0 adultscore=0 clxscore=1015
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510020000
 definitions=main-2510180018



On 10/23/2025 6:19 AM, Bjorn Andersson wrote:
> On Tue, Sep 23, 2025 at 09:18:43PM -0700, Jingyi Wang wrote:
>> From: Chris Lew <chris.lew@oss.qualcomm.com>
>>
>> Some remoteproc need smp2p v2 support, mirror the version written by the
>> remote if the remote supports v2. This is needed if the remote does not
>> have backwards compatibility with v1. And reset entry last value on SSR for
>> smp2p v2.
>>
>> Signed-off-by: Chris Lew <chris.lew@oss.qualcomm.com>
>> Co-developed-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
>> Signed-off-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
> 
> Please confirm that you really co-developed (pair programming) this
> patch with Chris.
> 
> Isn't this a patch from Chris, that you're "forwarding", i.e. both
> Signed-off-by should be there, but the Co-developed-by shouldn't.
> 

I remembered I did some minor updated, will delete that in next version.

Thanks,
Jingyi

>> ---
>>  drivers/soc/qcom/smp2p.c | 35 ++++++++++++++++++++++++++++++++---
>>  1 file changed, 32 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/soc/qcom/smp2p.c b/drivers/soc/qcom/smp2p.c
>> index e2cfd9ec8875..5ea64a83c678 100644
>> --- a/drivers/soc/qcom/smp2p.c
>> +++ b/drivers/soc/qcom/smp2p.c
>> @@ -48,10 +48,13 @@
>>  #define SMP2P_MAGIC 0x504d5324
>>  #define SMP2P_ALL_FEATURES	SMP2P_FEATURE_SSR_ACK
>>  
>> +#define SMP2P_VERSION_1 1
>> +#define SMP2P_VERSION_2 2
> 
> #define ONE 1
> #define TWO 2
> 
> #define PLEASE_DONT true
> 
>> +
>>  /**
>>   * struct smp2p_smem_item - in memory communication structure
>>   * @magic:		magic number
>> - * @version:		version - must be 1
>> + * @version:		version
>>   * @features:		features flag - currently unused
>>   * @local_pid:		processor id of sending end
>>   * @remote_pid:		processor id of receiving end
>> @@ -180,14 +183,23 @@ static void qcom_smp2p_kick(struct qcom_smp2p *smp2p)
>>  static bool qcom_smp2p_check_ssr(struct qcom_smp2p *smp2p)
>>  {
>>  	struct smp2p_smem_item *in = smp2p->in;
>> +	struct smp2p_entry *entry;
>>  	bool restart;
>>  
>>  	if (!smp2p->ssr_ack_enabled)
>>  		return false;
>>  
>>  	restart = in->flags & BIT(SMP2P_FLAGS_RESTART_DONE_BIT);
>> +	restart = restart != smp2p->ssr_ack;
>> +	if (restart && in->version > SMP2P_VERSION_1) {
>> +		list_for_each_entry(entry, &smp2p->inbound, node) {
>> +			if (!entry->value)
>> +				continue;
>> +			entry->last_value = 0;
>> +		}
>> +	}
>>  
>> -	return restart != smp2p->ssr_ack;
>> +	return restart;
>>  }
>>  
>>  static void qcom_smp2p_do_ssr_ack(struct qcom_smp2p *smp2p)
>> @@ -222,6 +234,20 @@ static void qcom_smp2p_negotiate(struct qcom_smp2p *smp2p)
>>  	}
>>  }
>>  
>> +static int qcom_smp2p_in_version(struct qcom_smp2p *smp2p)
>> +{
>> +	unsigned int smem_id = smp2p->smem_items[SMP2P_INBOUND];
>> +	unsigned int pid = smp2p->remote_pid;
>> +	struct smp2p_smem_item *in;
>> +	size_t size;
>> +
>> +	in = qcom_smem_get(pid, smem_id, &size);
>> +	if (IS_ERR(in))
>> +		return 0;
>> +
>> +	return in->version;
>> +}
>> +
>>  static void qcom_smp2p_start_in(struct qcom_smp2p *smp2p)
>>  {
>>  	unsigned int smem_id = smp2p->smem_items[SMP2P_INBOUND];
>> @@ -516,6 +542,7 @@ static int qcom_smp2p_alloc_outbound_item(struct qcom_smp2p *smp2p)
>>  	struct smp2p_smem_item *out;
>>  	unsigned smem_id = smp2p->smem_items[SMP2P_OUTBOUND];
>>  	unsigned pid = smp2p->remote_pid;
>> +	u8 in_version;
>>  	int ret;
>>  
>>  	ret = qcom_smem_alloc(pid, smem_id, sizeof(*out));
>> @@ -537,12 +564,14 @@ static int qcom_smp2p_alloc_outbound_item(struct qcom_smp2p *smp2p)
>>  	out->valid_entries = 0;
>>  	out->features = SMP2P_ALL_FEATURES;
>>  
>> +	in_version = qcom_smp2p_in_version(smp2p);
>> +
>>  	/*
>>  	 * Make sure the rest of the header is written before we validate the
>>  	 * item by writing a valid version number.
>>  	 */
>>  	wmb();
>> -	out->version = 1;
>> +	out->version = (in_version) ? in_version : 1;
> 
> Doesn't this imply that if the remoteproc advertises support for version
> 3, then we suddenly also support version 3?
> 
> 
> I don't remember if we've talked about how version handling should work
> in this driver, but we should certainly define and document that in the
> comment at the top of this driver.
> 
> Regards,
> Bjorn
> 
>>  
>>  	qcom_smp2p_kick(smp2p);
>>  
>>
>> -- 
>> 2.25.1
>>


