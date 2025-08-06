Return-Path: <linux-kernel+bounces-757123-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 193A4B1BE00
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 02:46:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 21E71164B8B
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 00:46:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7874282FA;
	Wed,  6 Aug 2025 00:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Lqa7HURT"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49D5CCA5A
	for <linux-kernel@vger.kernel.org>; Wed,  6 Aug 2025 00:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754441154; cv=none; b=mNDfI9b8FyCB2ITxJPLTTN46fTLzjtJhaT/8dSmidb7t9o4mqaALyzAokgG2sXmYGbrrUrzQkN1ihh5nAiAJaiMgseYDEd4IJs6A1YBGHDYdVXlrnlt5q6pexF1MX8h7cYGLb+9PHgI/lEYvxpVe+qpWbz5OiVeWC2hJbowl/og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754441154; c=relaxed/simple;
	bh=GtJ9hkeudm0oq8iwmb8yoRxVECyeFoP9SFq1UVixiGk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NieBXZFkx+j+yEiCJh10MbxuJFJo1UP1HdR8XdnP927ZrYukLVw+ipjWZ90ycVg9lrroW0JVf776aXYcS3yIvPqpNGfEJ4qUDq9OlZYeUYnTomX5X5fkZXn2YEpstcshe8IDT2iNvHUo8wq/dY92ZUJwoJOSvuuBrco2ibcarks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Lqa7HURT; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 575I2jmv011077
	for <linux-kernel@vger.kernel.org>; Wed, 6 Aug 2025 00:45:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	0iF7VyAktj1df9uStQYVjfJ1tKq1t1jAnCoxG1j63Og=; b=Lqa7HURTFNlxNvtI
	M604CNroFqhwQv0SyDPFVLfZjZH5SG4e57qqdzE90SJ3n+r8o3a+i0lNiSs2QIYY
	JjCJRG3YpDGS7fpIKLueHnO1EXpK55ZjvyDoV01RhdhRJtXV8CriqXlLzqXOVGZP
	HLyJPLyzOA4IhSS9KQeNuOSvAJXpy9HgnVsBhPpE2Yiq6F2UXn+RlsOPrJDL3mox
	7eZQ6itChPlZUuPH1QbAsSZ66ixdbnVY+rK9KCez3GouHkPD+72jGiGa+cHtyqqk
	NhufmR9S3gGJi2LssloDK61t4Gbi5MfeZCNO+0Nsbt1lcFHwdKyZKiWBx7GMkryi
	grprMg==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48bpvyrw0m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 06 Aug 2025 00:45:52 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-23fe984fe57so69227835ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Aug 2025 17:45:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754441151; x=1755045951;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0iF7VyAktj1df9uStQYVjfJ1tKq1t1jAnCoxG1j63Og=;
        b=rX6XxZZoLLkNKLbtFFnJVoXgg9IU/CTG1l2PihQaFuu2km7UFERgkos55DD7oUlAgN
         MoADKiuK8Wb/kDVy8d0YF8nf2AZP6obOJTODfI8jWVebAIpKeNyZNT0dYzVoE+TzGsM/
         /OQIIl8iQhhosM7O7cAeL5mp5ftxXHtvWj90YTbYJGGQczgflLq+amzvfNOkiSh26wY9
         ClrwAJDjvASFc5lpaG9r1fV0MWmK5Tm9rKxXE1aMoVDJ9hk09R64dDZuOvY2id/I6RKL
         lO8IS8JsPjsQ8VEcPTSSFQ9SZHozfsVEVGFIrg27q6aBaIp8oas+yLeLoyBOUxj4HiHK
         OSFw==
X-Forwarded-Encrypted: i=1; AJvYcCV0038ZqOllyYF8bdxmo68Xu6as5kuPQBlMzcnrizLVIvQpY5PwOq0wUXDYTuRonusqz9u9GRYDqeERyD8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbVFv2vb/6U/wltp6/PU4Ez3HHCqWuDRNxPelOA7j/iW+KJmmA
	skawnaBzz6vf8+2yj9cAIHVstXgv7hbV+muuAfP+115+AvLErUpV/1ne769Gd7uwFP80o8BiZU9
	bQkP8jIH+6brCbEstz9Gk+NWxiprW6r3Wr2xfTjO6sATxhWEziG2Cs1Ty03wnVAp7YVKaW4UO0o
	CujA==
X-Gm-Gg: ASbGncuNenG0GgFY+MngTMnQFdSwO7gtRnUPPIAEgp18hvGMDrR61o1BS6sAySf7oYD
	JHe3e4q//yIBoFyeV2I87B4QyMXGgcWRk1kAjP/HK+7dcb61yNwLt1Op2v4Oa0cNYY5WPoms6oS
	EwJH6EKpcEkatzWbwN9UHtK/f12UlePX1EStIkk3U2gZrVk59cWgpqY23F9e72xGwtyKoslEfyP
	3AJ2VsF6jlsoiKuMFNCP0zJzbFe9KtIyWVdLUFAWegtqeQqj+xi0pw3qGtjPcvs8RrBn86z8J6t
	WKm+818Y37WhPqBlHEfMQ0elNGFOP7k/Duo1bfGhKs5mNSOWih6KSqcMaAGeTJfieFbUi3LnT+w
	jhBoXIugNFURPbuotyVB2Fjm0
X-Received: by 2002:a17:903:120f:b0:240:8369:9b9d with SMTP id d9443c01a7336-242a0a90da9mr9569545ad.9.1754441150822;
        Tue, 05 Aug 2025 17:45:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHvEEsM420ujNnosuNHEbFJFINBlZS10U2Hkuy33LauXmSRAro+5w56Hd5w+DB2dVJIMtSXIQ==
X-Received: by 2002:a17:903:120f:b0:240:8369:9b9d with SMTP id d9443c01a7336-242a0a90da9mr9569215ad.9.1754441150382;
        Tue, 05 Aug 2025 17:45:50 -0700 (PDT)
Received: from [10.133.33.195] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31f63f0ba97sm18047477a91.29.2025.08.05.17.45.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Aug 2025 17:45:50 -0700 (PDT)
Message-ID: <d7960d95-d076-4c0d-929c-421480f330d4@oss.qualcomm.com>
Date: Wed, 6 Aug 2025 08:45:44 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 04/10] coresight: tmc: add create/delete functions for
 etr_buf_node
To: Mike Leach <mike.leach@linaro.org>, Jie Gan <jie.gan@oss.qualcomm.com>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>,
        James Clark <james.clark@linaro.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Tingwei Zhang <tingwei.zhang@oss.qualcomm.com>,
        Jinlong Mao <jinlong.mao@oss.qualcomm.com>, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org
References: <20250725100806.1157-1-jie.gan@oss.qualcomm.com>
 <20250725100806.1157-5-jie.gan@oss.qualcomm.com>
 <CAJ9a7VgOTfDHG+nrEUQ5+fxrcCd+ZaWWnxt_F8kavbHP38QCVw@mail.gmail.com>
Content-Language: en-US
From: Jie Gan <jie.gan@oss.qualcomm.com>
In-Reply-To: <CAJ9a7VgOTfDHG+nrEUQ5+fxrcCd+ZaWWnxt_F8kavbHP38QCVw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: MRh5zIrwWgvyQ8lUWHvPzcfPQhnTqQ6s
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA2MDAwMyBTYWx0ZWRfX9TkFR78jKvqI
 MWA4REs0UFH+qX6a8ZOlrtHMOWW0EOxzESpgVkeRWtmFAt2ARqCwsym2MgnkLIGmjIKaEk9cfhN
 Hj0EW1DdcYFfVHkx9VCVZ1R8A7BYfYvGnyJvGVZwLtlRGSiVsQvHX3tPef68/ZjdkqwSfp6mwOJ
 40SmEAZWkkufSc/uesQVlDIQ8+++PznpYBrLKYAw/E80xAl82H687VExGIiYnI7s+yZeu1xwWC6
 FIJRRjyeCpfS2VuAReXRzm7mCaO1A/oAGLpwz4EVVaUP1y9glb+CRYXbK/L0/uHU4GDJ++QGRi7
 MOrC5HXV6J2tzumlUA5XHm+LaWrqIcyLFk6DDBD+DsQ8jSeZS9eypyPkaffe2Is1Hyyf5JNTZ24
 /tiUanObzHUslI1k8Gi7SXR9XDGm69kNMSqkEO/ScQqi80426yGMXBevnw65YPkjPjCZSAxU
X-Proofpoint-ORIG-GUID: MRh5zIrwWgvyQ8lUWHvPzcfPQhnTqQ6s
X-Authority-Analysis: v=2.4 cv=NsLRc9dJ c=1 sm=1 tr=0 ts=6892a5c0 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=_2nvVlcBbLE0w9leeUgA:9
 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-05_05,2025-08-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 spamscore=0 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 bulkscore=0 mlxscore=0 suspectscore=0 clxscore=1015
 malwarescore=0 mlxlogscore=999 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2507300000
 definitions=main-2508060003



On 8/5/2025 6:27 PM, Mike Leach wrote:
> Hi,
> 
> On Fri, 25 Jul 2025 at 11:08, Jie Gan <jie.gan@oss.qualcomm.com> wrote:
>>
>> Create and insert or remove the etr_buf_node to/from the etr_buf_list.
>>
>> Signed-off-by: Jie Gan <jie.gan@oss.qualcomm.com>
>> ---
>>   .../hwtracing/coresight/coresight-tmc-etr.c   | 65 +++++++++++++++++++
>>   drivers/hwtracing/coresight/coresight-tmc.h   |  2 +
>>   2 files changed, 67 insertions(+)
>>
>> diff --git a/drivers/hwtracing/coresight/coresight-tmc-etr.c b/drivers/hwtracing/coresight/coresight-tmc-etr.c
>> index b07fcdb3fe1a..e8ecb3e087ab 100644
>> --- a/drivers/hwtracing/coresight/coresight-tmc-etr.c
>> +++ b/drivers/hwtracing/coresight/coresight-tmc-etr.c
>> @@ -1909,6 +1909,71 @@ const struct coresight_ops tmc_etr_cs_ops = {
>>          .panic_ops      = &tmc_etr_sync_ops,
>>   };
>>
>> +/**
>> + * tmc_clean_etr_buf_list - clean the etr_buf_list.
>> + * @drvdata:   driver data of the TMC device.
>> + *
>> + * Remove the allocated node from the list and free the extra buffer.
>> + */
>> +void tmc_clean_etr_buf_list(struct tmc_drvdata *drvdata)
>> +{
>> +       struct etr_buf_node *nd, *next;
>> +
>> +       list_for_each_entry_safe(nd, next, &drvdata->etr_buf_list, node) {
>> +               if (nd->sysfs_buf == drvdata->sysfs_buf) {
>> +                       list_del(&nd->node);
>> +                       kfree(nd);
>> +               } else {
>> +                       /* Free allocated buffers which are not utilized by ETR */
>> +                       list_del(&nd->node);
>> +                       tmc_free_etr_buf(nd->sysfs_buf);
>> +                       nd->sysfs_buf = NULL;
>> +                       kfree(nd);
>> +               }
>> +       }
>> +}
>> +EXPORT_SYMBOL_GPL(tmc_clean_etr_buf_list);
>> +
>> +/**
>> + * tmc_create_etr_buf_node - create a node to store the alloc_buf and
>> + * insert the node to the etr_buf_list. Create a new buffer if the
>> + * alloc_buf is NULL.
>> + * @drvdata:   driver data of the TMC device.
>> + * @alloc_buf: the buffer that is inserted to the list.
>> + *
>> + * Return 0 upon success and return the error number if fail.
>> + */
>> +int tmc_create_etr_buf_node(struct tmc_drvdata *drvdata, struct etr_buf *alloc_buf)
> 
> This list handle function pair look a little asymmetric. Is it not
> possible to change this to tmc_create_etr_buf_list(struct tmc_drvdata
> *drvdata, int num_nodes)
> so that one function creates all the nodes, and another destroys them.
> 
> In the logic that decides between using multi buffer or single buffer
> you can then use  a construct such as:
> 
> if (single_buffer)
>        drvdata->sysfs_buf = <alloc sysfs buffer>
> else {
>       tmc_create_etr_buf_list(drvdata, 2);
>       <switch in avail buffer to drvdata->sysfs_buf
> }

The lsit handle function pair definitely looks a little bit asymmetric. 
I will consider the suggestion in next version.

Thanks,
Jie

> 
>> +{
>> +       struct etr_buf_node *sysfs_buf_node;
>> +       struct etr_buf *sysfs_buf;
>> +
>> +       if (!alloc_buf) {
>> +               sysfs_buf = tmc_alloc_etr_buf(drvdata, drvdata->size, 0, cpu_to_node(0), NULL);
>> +               if (IS_ERR(sysfs_buf))
>> +                       return PTR_ERR(sysfs_buf);
>> +       } else
>> +               sysfs_buf = alloc_buf;
>> +
>> +       sysfs_buf_node = kzalloc(sizeof(struct etr_buf_node), GFP_KERNEL);
>> +       if (IS_ERR(sysfs_buf_node)) {
>> +               if (!alloc_buf)
>> +                       tmc_free_etr_buf(sysfs_buf);
>> +               return PTR_ERR(sysfs_buf_node);
>> +       }
>> +
>> +       sysfs_buf_node->sysfs_buf = sysfs_buf;
>> +       sysfs_buf_node->reading = false;
>> +       if (!alloc_buf)
>> +               sysfs_buf_node->is_free = true;
>> +       else
>> +               sysfs_buf_node->is_free = false;
>> +       list_add(&sysfs_buf_node->node, &drvdata->etr_buf_list);
>> +
>> +       return 0;
>> +}
>> +EXPORT_SYMBOL_GPL(tmc_create_etr_buf_node);
>> +
>>   int tmc_read_prepare_etr(struct tmc_drvdata *drvdata)
>>   {
>>          int ret = 0;
>> diff --git a/drivers/hwtracing/coresight/coresight-tmc.h b/drivers/hwtracing/coresight/coresight-tmc.h
>> index 52ee5f8efe8c..3cb8ba9f88f5 100644
>> --- a/drivers/hwtracing/coresight/coresight-tmc.h
>> +++ b/drivers/hwtracing/coresight/coresight-tmc.h
>> @@ -461,5 +461,7 @@ void tmc_etr_remove_catu_ops(void);
>>   struct etr_buf *tmc_etr_get_buffer(struct coresight_device *csdev,
>>                                     enum cs_mode mode, void *data);
>>   extern const struct attribute_group coresight_etr_group;
>> +void tmc_clean_etr_buf_list(struct tmc_drvdata *drvdata);
>> +int tmc_create_etr_buf_node(struct tmc_drvdata *drvdata, struct etr_buf *alloc_buf);
>>
>>   #endif
>> --
>> 2.34.1
>>
> 
> Regards
> 
> Mike


