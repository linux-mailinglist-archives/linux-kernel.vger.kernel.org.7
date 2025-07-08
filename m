Return-Path: <linux-kernel+bounces-720679-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 211E0AFBF2B
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 02:18:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C52041AA699A
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 00:18:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED2FF38FB9;
	Tue,  8 Jul 2025 00:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nHH0sG8E"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6B9A24B29
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 00:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751933902; cv=none; b=Moyihte84aVDjDFPx9H0TCGNgtnLxc3obhSKTNQLlVPQuDRTpwvnKSYYVAVAOg+vlJoWfXYLW4zMKJwgu2lj5hjOjoPyVACDQQ4sJ86gN+KYhCNLQfRsOJC9SZAWlzTfzb7vYy8mOvMJpLG2ndPZIc5ANjafiS/+zbEPeODsZws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751933902; c=relaxed/simple;
	bh=kFt6Oom5g+9QGUKhUH0b2chcUL/hscbZVZ8LC4C1q8I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OA5Xlvb42YFdF9a+8v+GpH3ZsLmICbnVIN5tcxCeAzeZOAMAnAs7KOyV2lm3lJEYvJI6s/xdMuy5j8xDGRwy61p4faoAGoLTtGQ+CE8zxdMT0tY9KpadgBhFcev76APy+lA0tsVfkbnif6iwPO3aIq6Oit50wfgMRJBG6QXgNtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nHH0sG8E; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 567Ji7BG026493
	for <linux-kernel@vger.kernel.org>; Tue, 8 Jul 2025 00:18:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	oaTOEkIO8yrsO0UKiWwZlqMg1M5J5KL8pwQLxI4CLgg=; b=nHH0sG8E+AXC4w4U
	T4O+a6q0EEjbnZQYFWebBAmLf1LFy5Z5grmBAUj38+fCP789t8D5bX+71ZNR6c6O
	GLAMa7KnfJMTt7SB1HVCtKMcZkAM8evugiLo9SgqYP5JUPcyDLNcn+Egu7JLPVcr
	c9hJKiCNhXIgebs3eEnBzEf/l8lpJyfuykGn8tx8AJt85i7j5zQ3DmYD5xJXoTGS
	16ndMIsTGrgYwojG+OE8FyCp6Kil7m92n/qQ36Av0+ueocIKULV+rC6qWTCg0svQ
	SNez+wSpq1uksn32XBms6yrpuna1MZ3yV5Roa5dKd8RGFg+NtwH1Jfwj+zKsisf8
	UBPw1Q==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47pv97h94e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 08 Jul 2025 00:18:18 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-234a102faa3so28105615ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jul 2025 17:18:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751933898; x=1752538698;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oaTOEkIO8yrsO0UKiWwZlqMg1M5J5KL8pwQLxI4CLgg=;
        b=b82jy6iAc0nYIAzjfRM12Bk6vQnzjn+vKnAwdefLMxu9a1fowS7q/N9JFcvXjeJRRW
         ZqDxHWgIKDisCd2vZyn4Fkt1Iz0LXBIYFVJEOCk5f8QCry+Hjzfl5uoLydZEESyPwCtU
         NuvIoCF+MVF5MBvYWGmIQl/rqcpsejcppHVN3vMVwF8yypkslsA26TlVaNYQN+v3cpPZ
         YiPzLEVzQ6hm9ft+Kr0yXk4S5/edPKo3QxQfQsb7dE7yIjnTtmvlSqg8IEyqyy+4oL6G
         b6pkCqrtt37jCSJA6yv0pFkFa3RnFp+23nVx52GUuDZpzRxXHY3UZCSA4l/RGnUsk2Kz
         XZZA==
X-Forwarded-Encrypted: i=1; AJvYcCUeqCOQ01GMMw7skw+EtKMRd91TQg9qJyQ4kgwrstgygip7wGW0Eq0TqWtd3ewRa7lguoNbKEZi++NOtkQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhIZify8omypNQ3kvDiEvXLbKV8i0UxnqZAoqfSLY9td9L2glj
	pVXn6huHcpvRcbekq+gLEjs/5RTKJcql9j+Wd3vBPEx0TbIMXJu+pp5ET//dbi5CJio8/XvroFt
	6xxATcYOG3VElBYkgq2UocCRv1zwUXFNfAERLlkUaXdRJjoVAvjGKVlqZL2G1xIHunA==
X-Gm-Gg: ASbGnctZlLCBKt0tbISSo2lwZxpLzcacwntGfoGwhlz5JO3LWfQyzyg0YJ0tpIsS1RK
	b0S3V40amZzlPfpASIvxaDoPTOe4mKKjgaswbCYmisskS0BVK8QrsWh4SXAEHi3Y6tloaYHV1A3
	13qvtIuosoSaxfE3lZ28HaX/YxWgcdAvssl/Gwbnz85/Bkk4iR1PTyp/GaKWi/gMFnpufdT2uPb
	yPLpbDRA288wO1816pf9UVfs0UyZy+AJ6Mmyny6LxDT5Gc8vpjWcb4w1CBSqDKVKH/vuBrThhRh
	ENATKX0bxf37UGWBmJJ397phea8OIz9Qaj8JBI2gJ7Q3HXMWAftWURGv4jXHAA7B1O4vT6hLX6c
	a+cS3YxY0T7zNCw7CFPHV
X-Received: by 2002:a17:903:244c:b0:234:d679:72e3 with SMTP id d9443c01a7336-23dd1d80da1mr8271115ad.42.1751933897820;
        Mon, 07 Jul 2025 17:18:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFMM+Gbo9/WjlZPVlIIUZQ4YQst2yhj+gXkh09Rr5WiqbDyV2/LPR3+ycOzSMRJJQfm2+cqXA==
X-Received: by 2002:a17:903:244c:b0:234:d679:72e3 with SMTP id d9443c01a7336-23dd1d80da1mr8270825ad.42.1751933897349;
        Mon, 07 Jul 2025 17:18:17 -0700 (PDT)
Received: from [192.168.0.74] (n1-41-240-65.bla22.nsw.optusnet.com.au. [1.41.240.65])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23c8457e4d2sm103006315ad.148.2025.07.07.17.18.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Jul 2025 17:18:13 -0700 (PDT)
Message-ID: <07cd8098-2d2e-4f90-96c0-64f8547e291f@oss.qualcomm.com>
Date: Tue, 8 Jul 2025 10:18:02 +1000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 08/12] firmware: qcom: tzmem: export shm_bridge
 create/delete
To: Kuldeep Singh <quic_kuldsing@quicinc.com>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Sumit Garg <sumit.garg@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Apurupa Pattapu <quic_apurupa@quicinc.com>,
        Kees Cook <kees@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Harshal Dev <quic_hdev@quicinc.com>, linux-arm-msm@vger.kernel.org,
        op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linaro-mm-sig@lists.linaro.org, linux-doc@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>
References: <20250526-qcom-tee-using-tee-ss-without-mem-obj-v5-0-024e3221b0b9@oss.qualcomm.com>
 <20250526-qcom-tee-using-tee-ss-without-mem-obj-v5-8-024e3221b0b9@oss.qualcomm.com>
 <2455f20c-130c-4f27-9cf4-6411e485b845@quicinc.com>
Content-Language: en-US
From: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
In-Reply-To: <2455f20c-130c-4f27-9cf4-6411e485b845@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=FrUF/3rq c=1 sm=1 tr=0 ts=686c63ca cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=hi51d+lTLNy/RbqRqnOomQ==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=pz6wV3uveH3Zlr5Ofa0A:9 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA4MDAwMSBTYWx0ZWRfX/WzWVay7MXnu
 C49Zt1i2MWNK5gKAib/UH9O0Be6KD/lZrXdd2NXeRH8mo53u4/eA+r5/Cv7GiG52Gjg/7b96t7T
 wJvZvVE+wBjx+6tdKIJSisHb5HOG9Ip4otGG5n/JlBrf3t1s5xCBf5Sh1pJxQdUPk8krmBFpVNo
 EDkrNpiHPNgwlleH54aF3H9JGU6iEwCLmLX2oLhZTNvlGk9NHWAxxFuyiBHEXpORm1shGuzkKZh
 vn9ctPoKBYw7HRb9wZetrDVvEfV1hyupYNHO1Iq7LnnGWSgUyPEYLwusMPH4C7z6U4zaS6800XJ
 J1ezF0ExBsik9NTRCx50VkWkgwXQe04vSnkKnkqpXXMjrqCRjc1ieMfmHXk2ateP+1riohE51vj
 tC23ZQMTiHwaL8R31reEIQLaDb/x9bru6jfBZxvCo3eDsYzeIDj+SfBtqmCESZiWn5jeMnG0
X-Proofpoint-GUID: 5P5p7MFQeMtIrquK1kJzyalj0LtzoHp4
X-Proofpoint-ORIG-GUID: 5P5p7MFQeMtIrquK1kJzyalj0LtzoHp4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-07_06,2025-07-07_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 clxscore=1015 mlxscore=0 spamscore=0
 priorityscore=1501 bulkscore=0 lowpriorityscore=0 phishscore=0 malwarescore=0
 adultscore=0 mlxlogscore=999 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507080001

Hi Kuldeep,

On 7/1/2025 9:47 PM, Kuldeep Singh wrote:
> 
> On 5/27/2025 12:26 PM, Amirreza Zarrabi wrote:
>> Anyone with access to contiguous physical memory should be able to
>> share memory with QTEE using shm_bridge.
>>
>> Tested-by: Neil Armstrong <neil.armstrong@linaro.org>
>> Signed-off-by: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
>> ---
>>  drivers/firmware/qcom/qcom_tzmem.c       | 57 +++++++++++++++++++++++++-------
>>  include/linux/firmware/qcom/qcom_tzmem.h | 15 +++++++++
>>  2 files changed, 60 insertions(+), 12 deletions(-)
>>
>> diff --git a/drivers/firmware/qcom/qcom_tzmem.c b/drivers/firmware/qcom/qcom_tzmem.c
>> index 4fe333fd2f07..e9e4f06924ae 100644
>> --- a/drivers/firmware/qcom/qcom_tzmem.c
>> +++ b/drivers/firmware/qcom/qcom_tzmem.c
>> @@ -108,25 +108,61 @@ static int qcom_tzmem_init(void)
>>  	return 0;
>>  }
>>  
>> -static int qcom_tzmem_init_area(struct qcom_tzmem_area *area)
>> +/**
>> + * qcom_tzmem_shm_bridge_create() - Create a SHM bridge.
>> + * @paddr: Physical address of the memory to share.
>> + * @size: Size of the memory to share.
>> + * @handle: Handle to the SHM bridge.
>> + *
>> + * On platforms that support SHM bridge, this function creates a SHM bridge
>> + * for the given memory region with QTEE. The handle returned by this function
>> + * must be passed to qcom_tzmem_shm_bridge_delete() to free the SHM bridge.
>> + *
>> + * Return: On success, returns 0; on failure, returns < 0.
>> + */
>> +int qcom_tzmem_shm_bridge_create(phys_addr_t paddr, size_t size, u64 *handle)
>>  {
>>  	u64 pfn_and_ns_perm, ipfn_and_s_perm, size_and_flags;
>> -	int ret;
>>  
>>  	if (!qcom_tzmem_using_shm_bridge)
>>  		return 0;
>>  
>> -	pfn_and_ns_perm = (u64)area->paddr | QCOM_SCM_PERM_RW;
>> -	ipfn_and_s_perm = (u64)area->paddr | QCOM_SCM_PERM_RW;
>> -	size_and_flags = area->size | (1 << QCOM_SHM_BRIDGE_NUM_VM_SHIFT);
>> +	pfn_and_ns_perm = paddr | QCOM_SCM_PERM_RW;
>> +	ipfn_and_s_perm = paddr | QCOM_SCM_PERM_RW;
>> +	size_and_flags = size | (1 << QCOM_SHM_BRIDGE_NUM_VM_SHIFT);
>> +	if (qcom_scm_shm_bridge_create(pfn_and_ns_perm, ipfn_and_s_perm,
>> +				       size_and_flags, QCOM_SCM_VMID_HLOS,
>> +				       handle))
> 
> Can we add a debug log here to ease debugging in future?
> Something like this can also work.
> 
> pr_err("Shm bridge creation failed, ret: %d, NS PA|Perm: 0x%llx,
> size|flags: 0x%llx\n", ret, pfn_and_ns_perm_flags, size_and_flags);
> 

Sure.

Regards,
Amir

>> +		return -EINVAL;
>> +
>> +	return 0;
>> +}
>> +EXPORT_SYMBOL_GPL(qcom_tzmem_shm_bridge_create);
> 


