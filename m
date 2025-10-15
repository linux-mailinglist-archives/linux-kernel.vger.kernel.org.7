Return-Path: <linux-kernel+bounces-854309-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CCB7BDE123
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 12:47:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF212480CA2
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 10:47:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2710331A550;
	Wed, 15 Oct 2025 10:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dRWQcRDo"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7172D30CD8E
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 10:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760525243; cv=none; b=f6EJllBqLZ3GHnlAvHLFuNNl2envU2IXKbLzBKQ3NZ/mgeEsRqV8lfkeKvMbq5CFEkle97yHjGUsanPp8xTuIoXe7KLk76hqrGNxhhLhBdEVK6W8CsAnEY5kS/+JxKGk7tdt2YEcxrPOpiT4kFoajqO+iN+mqS3m4Bc82f7zAlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760525243; c=relaxed/simple;
	bh=6t2VjMzmYUpCUm4tfw2LHG2B2SP1VyCR0KGFGIZx14M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lL+08PxhpKL1P4P1i0dHhzz/5Jr1RnzxmA7sTKit75GILV0ImNwVPmr7jMMDIcjBQjiA/jHWJZNqeIqRZoP0/+zY4d/DR45AK9hSoy/RTBVFZ8mWSxh2TYUxzMvcmGI1XWyVtf5nhRv+aOZu1rBePXIRh7Khv+75p+F8gGvpYX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dRWQcRDo; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59FAV20c004288
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 10:47:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	2jyhIXaZyVu1vjZr+AhCvbj4p9RRg4EuzAX/ftNllyA=; b=dRWQcRDoUsIV+zy6
	e4UoDqN3V9QggMrNt59OUBwEgPBB7SWceFY/Lbnz+3axglGjbfNdbPr5nrQ27+J2
	LDB655Jis80SGDOvau1MfPUvxzZeLN2cviJ5fb6FsQJM4192tSGgUCVev/CaNGF6
	eHE3ZvTwD/AWGs6gzlPaXu7OVHK40VvQEsXOVDZqW4acxmBS73DEN254Ew6dvKV5
	WO1VdB5ttc+b/mlTR2qzz4PtX6OkHDwH4WcFWRz8m2ZXlK+KDOzqVxOX/j2SwcT6
	GoCo04fe5S1s/2AnuOtLr1qR2/4qXDB6woyiEiZODrk/pJJM2KWlmXqz8HYkaEqc
	stwlQw==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49qgdg3yfm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 10:47:20 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-b67e14415dfso1581881a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 03:47:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760525239; x=1761130039;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2jyhIXaZyVu1vjZr+AhCvbj4p9RRg4EuzAX/ftNllyA=;
        b=JsvXgcE5W9DQx32Dc6/bBvP45cet//Jvqy20NFWV8ajVuvTzdVm23zegmw6fIhq5tH
         g+jRzxVwMF2NOhHK2aHQFJR4UYnCPC2z44Fj85LmJWKz3j4Rmq+zqwuPrEm5bmFi9b0N
         fgBfTcWc4L6t9aYpOh3puXVFMhg3gq/yhhOIx4Man1dxfjP6F/yAST00IDtQLFUjrbFI
         9Ha5iqSx+pGV2NV5325Gs4CXVm+n7Hj+niz7HWrrsnPHzn5v4UoKkLaEa2iOzPQWpjwC
         K+WP85t97JDNlznVVVSPfKrfKmB1r+dpkb6usRHS36L+UoAa3Ox+fGfl6ytoaTfuFUK+
         wfmA==
X-Forwarded-Encrypted: i=1; AJvYcCXmSlgV1m/eVr4UeqYi6vvmV5O8nFurZH892oRwjQ8sPt/RZZdgQKlf9aSrhUNJDWP2EEQkqm1exWXdOPA=@vger.kernel.org
X-Gm-Message-State: AOJu0YweHkdHTXYhoqR1jw8Qw9UAHjtQ5wJQm8mQhhut4nY0RI7sNf2X
	SEIYUAlcpYKYsYMQWJzUoPbKv4Lh5c1MB5WaOJUK1mBxafc7TWyNAV0Ska0KvQXv6xDwGdoFbbQ
	ms2dpNm+X2gPDg2HBdjWd+fhiWTovc3vaqahzUvxFf2PrNGdivGdmkGu1rFvKr7CXVn2VH4Gs5h
	g=
X-Gm-Gg: ASbGncu+IoPAcgbuxPxTZxpO6vAqytpuFWFLZrewHn4JFN3P+1QCB6j/ohob+CUWQTS
	xzCferDsohzJ0MHQQuzE0CY1Ekoig4zUIzODn8E562GPmq7yInSRlLPHjNWvDGfXHNtm9gYGMDx
	BIJf5qOCfkRsqhcfQr/WsOpd/aIWyE6vJ5r9IoqfweB+ETrWUdbptU1iJhjzPyZS4lkQ1Tb1HI6
	N9W9KvjSzJ+BacGxEf1GfWpOyffLrfO0rI7QK7TfjKuiEXjhHHdoC1DVZLnsuBrwzlLRHMUxo04
	+kyHU+YCcTUI0dD5a8VFhQ0gaYsXJ1kLGFmwZhiHE+RKkPM1Ah/t56CQBE3LOay+Fu5/Txpp
X-Received: by 2002:a05:6a21:7794:b0:334:912f:acfa with SMTP id adf61e73a8af0-334912fcd16mr632547637.56.1760525239414;
        Wed, 15 Oct 2025 03:47:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEIEMUhmvkmMQ7AQcHeMmduK0Dz02ZbHlXUBpApGcjOnAKPUnyrSve/YQwVmvSweGwvIVOo0Q==
X-Received: by 2002:a05:6a21:7794:b0:334:912f:acfa with SMTP id adf61e73a8af0-334912fcd16mr632512637.56.1760525238884;
        Wed, 15 Oct 2025 03:47:18 -0700 (PDT)
Received: from [10.206.107.23] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33b52937898sm12711791a91.1.2025.10.15.03.47.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Oct 2025 03:47:18 -0700 (PDT)
Message-ID: <9e59d1dc-5805-4cd2-9a65-f3f0f45526d0@oss.qualcomm.com>
Date: Wed, 15 Oct 2025 16:17:09 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] misc: fastrpc: Add support for new DSP IOVA
 formatting
To: Srinivas Kandagatla <srini@kernel.org>, kpallavi@qti.qualcomm.com,
        amahesh@qti.qualcomm.com, arnd@arndb.de, gregkh@linuxfoundation.org
Cc: quic_bkumar@quicinc.com, ekansh.gupta@oss.qualcomm.com,
        linux-kernel@vger.kernel.org, quic_chennak@quicinc.com,
        dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        jingyi.wang@oss.qualcomm.com, aiqun.yu@oss.qualcomm.com,
        ktadakam@qti.qualcomm.com
References: <20251015045702.3022060-1-kumari.pallavi@oss.qualcomm.com>
 <20251015045702.3022060-3-kumari.pallavi@oss.qualcomm.com>
 <75433294-4c47-4f4f-9de2-ee29af01f021@kernel.org>
Content-Language: en-US
From: Kumari Pallavi <kumari.pallavi@oss.qualcomm.com>
In-Reply-To: <75433294-4c47-4f4f-9de2-ee29af01f021@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAyNSBTYWx0ZWRfX0dx+8bB3PcpL
 w1HNmKA7t04ojRalT4ZKuaSYN2i8Yekqnp7Qdy1eMWSq5sUzRLB3IEqMfMZOEaGMol24CJGBD4N
 /7ER+O23fze/nwn+9No5Hi1v0MdmfSrUIgWoJvqDIJiXyssT1a9nP9JPUiPibp5b7WT6hA1pLAQ
 KVG773Vcch76J3attvrjk2LR8vZ7+hIZGfz+beYxMdfVScJ1Ra+kkwo5qDdcmPGdCLhW4Rundsp
 uaoQiaEOejVUB/4dtFbThG53ZT8D443Ijyp+RoKfCUGtzGqrjDB8yxO2GpuCKKj6Df8+js7g7RI
 Pr+knKcoSnFm+TAh0nKwhvXqzfhN+yaAT6PfEpguQlOzgNfyTR3V2fsEmhcDLWtX4M0SYWbJVk4
 qS4i3ybpo79bnXguMqaENGPYZ3udPA==
X-Proofpoint-GUID: am9TbhBIEylb1o8hl2i4Es0nUI_UCXaN
X-Proofpoint-ORIG-GUID: am9TbhBIEylb1o8hl2i4Es0nUI_UCXaN
X-Authority-Analysis: v=2.4 cv=J4ynLQnS c=1 sm=1 tr=0 ts=68ef7bb8 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=O6bt6N2DZ8TKcyxEHvQA:9 a=QEXdDO2ut3YA:10
 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-15_04,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 adultscore=0
 bulkscore=0 suspectscore=0 clxscore=1015 phishscore=0 spamscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510020000
 definitions=main-2510110025



On 10/15/2025 2:22 PM, Srinivas Kandagatla wrote:
> 
> 
> On 10/15/25 5:57 AM, Kumari Pallavi wrote:
>> Implement the new IOVA formatting required by the DSP architecture change
>> on Kaanapali SoC. Place the SID for DSP DMA transactions at bit 56 in the
>> physical address. This placement is necessary for the DSPs to correctly
>> identify streams and operate as intended.
>> To address this, set SID position to bit 56 based on SoC-specific compatible
>> string from the root node within the physical address; otherwise, default to
>> legacy 32-bit placement.
>> This change ensures consistent SID placement across DSPs.
>>
>> Signed-off-by: Kumari Pallavi <kumari.pallavi@oss.qualcomm.com>
>> ---
>>   drivers/misc/fastrpc.c | 59 +++++++++++++++++++++++++++++++++++++-----
>>   1 file changed, 52 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
>> index 975be54a2491..1a5d620b23f2 100644
>> --- a/drivers/misc/fastrpc.c
>> +++ b/drivers/misc/fastrpc.c
>> @@ -33,7 +33,6 @@
>>   #define FASTRPC_ALIGN		128
>>   #define FASTRPC_MAX_FDLIST	16
>>   #define FASTRPC_MAX_CRCLIST	64
>> -#define FASTRPC_PHYS(p)	((p) & 0xffffffff)
>>   #define FASTRPC_CTX_MAX (256)
>>   #define FASTRPC_INIT_HANDLE	1
>>   #define FASTRPC_DSP_UTILITIES_HANDLE	2
>> @@ -105,6 +104,15 @@
>>   
>>   #define miscdev_to_fdevice(d) container_of(d, struct fastrpc_device, miscdev)
>>   
>> +/* Extract smmu pa from consolidated iova */
>> +#define IPA_TO_DMA_ADDR(iova, sid_pos) (iova & ((1ULL << sid_pos) - 1ULL))
>> +/*
>> + * Prepare the consolidated iova to send to dsp by prepending the sid
>> + * to smmu pa at the appropriate position
>> + */
>> +#define IOVA_FROM_SID_PA(sid, phys, sid_pos) \
>> +       (phys += sid << sid_pos)
>> +
>>   struct fastrpc_phy_page {
>>   	u64 addr;		/* physical address */
>>   	u64 size;		/* size of contiguous region */
>> @@ -257,6 +265,10 @@ struct fastrpc_session_ctx {
>>   	bool valid;
>>   };
>>   
>> +struct fastrpc_soc_data {
>> +	u32 sid_pos;
>> +};
>> +
>>   struct fastrpc_channel_ctx {
>>   	int domain_id;
>>   	int sesscount;
>> @@ -278,6 +290,7 @@ struct fastrpc_channel_ctx {
>>   	bool secure;
>>   	bool unsigned_support;
>>   	u64 dma_mask;
>> +	const struct fastrpc_soc_data *soc_data;
>>   };
>>   
>>   struct fastrpc_device {
>> @@ -387,7 +400,7 @@ static int fastrpc_map_lookup(struct fastrpc_user *fl, int fd,
>>   static void fastrpc_buf_free(struct fastrpc_buf *buf)
>>   {
>>   	dma_free_coherent(buf->dev, buf->size, buf->virt,
>> -			  FASTRPC_PHYS(buf->dma_addr));
>> +			  IPA_TO_DMA_ADDR(buf->dma_addr, buf->fl->cctx->soc_data->sid_pos));
>>   	kfree(buf);
>>   }
>>   
>> @@ -437,8 +450,7 @@ static int fastrpc_buf_alloc(struct fastrpc_user *fl, struct device *dev,
>>   	buf = *obuf;
>>   
>>   	if (fl->sctx && fl->sctx->sid)
>> -		buf->dma_addr += ((u64)fl->sctx->sid << 32);
>> -
>> +		IOVA_FROM_SID_PA((u64)fl->sctx->sid, buf->dma_addr, fl->cctx->soc_data->sid_pos);
> 
> deleted an empty line for no reason.
> 

Ack.

>>   	return 0;
>>   }
>>   
>> @@ -682,7 +694,8 @@ static int fastrpc_dma_buf_attach(struct dma_buf *dmabuf,
>>   		return -ENOMEM;
>>   
>>   	ret = dma_get_sgtable(buffer->dev, &a->sgt, buffer->virt,
>> -			      FASTRPC_PHYS(buffer->dma_addr), buffer->size);
>> +			      IPA_TO_DMA_ADDR(buffer->dma_addr, buffer->fl->cctx->soc_data->sid_pos),
>> +			      buffer->size);
>>   	if (ret < 0) {
>>   		dev_err(buffer->dev, "failed to get scatterlist from DMA API\n");
>>   		kfree(a);
>> @@ -731,7 +744,8 @@ static int fastrpc_mmap(struct dma_buf *dmabuf,
>>   	dma_resv_assert_held(dmabuf->resv);
>>   
>>   	return dma_mmap_coherent(buf->dev, vma, buf->virt,
>> -				 FASTRPC_PHYS(buf->dma_addr), size);
>> +				 IPA_TO_DMA_ADDR(buf->dma_addr,
>> +				 buf->fl->cctx->soc_data->sid_pos), size);
>>   }
>>   
>>   static const struct dma_buf_ops fastrpc_dma_buf_ops = {
>> @@ -786,7 +800,8 @@ static int fastrpc_map_attach(struct fastrpc_user *fl, int fd,
>>   		map->dma_addr = sg_phys(map->table->sgl);
>>   	} else {
>>   		map->dma_addr = sg_dma_address(map->table->sgl);
>> -		map->dma_addr += ((u64)fl->sctx->sid << 32);
>> +		IOVA_FROM_SID_PA((u64)fl->sctx->sid,
>> +				 map->dma_addr, fl->cctx->soc_data->sid_pos);
>>   	}
>>   	for_each_sg(map->table->sgl, sgl, map->table->nents,
>>   		sgl_index)
>> @@ -2283,6 +2298,19 @@ static int fastrpc_get_domain_id(const char *domain)
>>   	return -EINVAL;
>>   }
>>   
>> +static const struct fastrpc_soc_data kaanapali_soc_data = {
>> +	.sid_pos = 56,
>> +};
>> +
>> +static const struct fastrpc_soc_data default_soc_data = {
>> +	.sid_pos = 32,
>> +};
>> +
>> +static const struct of_device_id qcom_soc_match_table[] = {
>> +	{ .compatible = "qcom,kaanapali", .data = &kaanapali_soc_data },
>> +	{ },
>> +};
>> +
>>   static int fastrpc_rpmsg_probe(struct rpmsg_device *rpdev)
>>   {
>>   	struct device *rdev = &rpdev->dev;
>> @@ -2291,6 +2319,22 @@ static int fastrpc_rpmsg_probe(struct rpmsg_device *rpdev)
>>   	const char *domain;
>>   	bool secure_dsp;
>>   	unsigned int vmids[FASTRPC_MAX_VMIDS];
>> +	struct device_node *root;
>> +	const struct of_device_id *match;
>> +	const struct fastrpc_soc_data *soc_data = NULL;
>> +
>> +	root = of_find_node_by_path("/");
>> +	if (!root)
>> +		return -ENODEV;
>> +
>> +	match = of_match_node(qcom_soc_match_table, root);
>> +	of_node_put(root);
>> +	if (!match || !match->data) {
>> +		 soc_data = &default_soc_data;
>> +		 dev_dbg(rdev, "no compatible SoC found at root node\n");
>> +	} else {
>> +		 soc_data = match->data;
>> +	}
>>   
> 
> I think you will be better off moving this to below helper function,
> this will simplify the code to:
> 
> soc_data = of_machine_get_match_data(qcom_soc_match_table);
> if (!soc_data)
> 	soc_data = &default_soc_data;
> 
> ------------------------>cut<-----------------
> Author: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
> Date:   Sat Oct 4 15:09:46 2025 +0100
> 
>      of: base: add of_machine_get_match_data helper function
> 
>      There are atleast 3 instances of this code in drivers, add a helper
>      function of_machine_get_match_data to avoid code duplication and better
>      error handling.
> 
>      Signed-off-by: Srinivas Kandagatla
> <srinivas.kandagatla@oss.qualcomm.com>
> 
> diff --git a/drivers/of/base.c b/drivers/of/base.c
> index 7043acd971a0..ac4b965f06b6 100644
> --- a/drivers/of/base.c
> +++ b/drivers/of/base.c
> @@ -434,6 +434,32 @@ bool of_machine_compatible_match(const char *const
> *compats)
>   }
>   EXPORT_SYMBOL(of_machine_compatible_match);
> 
> +/**
> + * of_machine_get_match_data - Test root of device tree against a
> compatible array
> + * and return data associated with match.
> + * @compats: NULL terminated array of compatible strings to look for in
> root node's compatible property.
> + *
> + * Returns match data if the root node has any of the given compatible
> values in its or NULL if
> + * compatible property nodes not match with compats.
> + */
> +const void *of_machine_get_match_data(const char *const *compats)
> +{
> +       const struct of_device_id *match = NULL;
> +       struct device_node *root;
> +
> +       root = of_find_node_by_path("/");
> +       if (root) {
> +               match = of_match_node(compats, root);
> +               of_node_put(root);
> +       }
> +
> +       if (!match)
> +               return NULL;
> +
> +       return match->data;
> +}
> +EXPORT_SYMBOL(of_machine_get_match_data);
> +
>   static bool __of_device_is_status(const struct device_node *device,
>                                    const char * const*strings)
>   {
> diff --git a/include/linux/of.h b/include/linux/of.h
> index a62154aeda1b..4d6792abf5f7 100644
> --- a/include/linux/of.h
> +++ b/include/linux/of.h
> @@ -407,6 +407,7 @@ extern int of_alias_get_id(const struct device_node
> *np, const char *stem);
>   extern int of_alias_get_highest_id(const char *stem);
> 
>   bool of_machine_compatible_match(const char *const *compats);
> +void *of_machine_get_match_data(const char *const *compats);
> 
>   /**
>    * of_machine_is_compatible - Test root of device tree for a given
> compatible value
> 
> ------------------------>cut<-----------------
> 

Ack.

>>   	err = of_property_read_string(rdev->of_node, "label", &domain);
>>   	if (err) {
>> @@ -2343,6 +2387,7 @@ static int fastrpc_rpmsg_probe(struct rpmsg_device *rpdev)
>>   
>>   	secure_dsp = !(of_property_read_bool(rdev->of_node, "qcom,non-secure-domain"));
>>   	data->secure = secure_dsp;
>> +	data->soc_data = soc_data;
>>   
>>   	switch (domain_id) {
>>   	case ADSP_DOMAIN_ID:
> 


