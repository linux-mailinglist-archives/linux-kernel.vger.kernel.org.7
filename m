Return-Path: <linux-kernel+bounces-854312-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39D88BDE145
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 12:50:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB1E1480E67
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 10:50:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3EBD31A573;
	Wed, 15 Oct 2025 10:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="CNO8yCUz"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C64E72BCF7F
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 10:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760525403; cv=none; b=fbzJElITW/XFPYeDvPyswg1XJ+m5nPL3QofFa8TpRZ/viMDzfROw3Q+VusRNBNnG1fyYakv/L9RljL5giZ8dVMau0oVZeSrpjARv+jH3Ry605Paj1JkGsHixpGbK19WElwnktoLQv6S7D5OlJDGHwL4AdQjsn3Cddk0KirSj2UU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760525403; c=relaxed/simple;
	bh=Hx93Wgign7RSXIZo3cjvp4Gt4ieYFePmA4uY3hkd+ww=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O8+eQtkbiNFH3DIT1UdISjT4r+08+bkmN5576RFKzvwr2rMvkogbc4Hn4U+f03rriRfCHD7xErFcg/6b4EPiIuz+AL5hvgOLRKIXEzhpT8fSRS1ZkZoJ9+ktwQGKozy2iuVGMeHSoxk6yRx3t+hMtNVFadQWR6Zd7T9KxF2JSqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=CNO8yCUz; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59F2sAxO009192
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 10:50:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	MNOL1mDXjuJoXB7sRKlJwzRGYo1qn26ZWmE/m3MrxZs=; b=CNO8yCUzx3I5q1q2
	VxwaQZtWJxMAtdsf3zXS1vlxkZl7aLUUH5X5WUTYAAuTFE1VE8zpPNhLTTiFEDjF
	RCmvTWMuQnlcxTzWnZ9vrQgP9+OWHUEWNnvJSoorj2s+QxC3G4wW8pPF5kOfQ338
	E7eAfar+WVE56Ov9DD957fuw+Pp6Chuttk5svY8amFF/7/Hs/FkhCg2GhJDlHEtY
	dbr+6DMd3k7kreaTmWgkDYeLeYsRHenCN7NscdVbgeKwvzSGbo9A9eQ7pEI5s5/t
	ZxmHfXj8af5/x3j2+B2DCnJkNXHfRP7HWaFBklWgnwO64Qisl1s2E48MHRDLaOJu
	zOpsvA==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49qg0c41v6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 10:50:01 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-b552f91033cso13780891a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 03:50:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760525400; x=1761130200;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MNOL1mDXjuJoXB7sRKlJwzRGYo1qn26ZWmE/m3MrxZs=;
        b=X+e3TPnz/jr1/FBosy89B6EW32mSTFygwT7CoQ/jJmKOL3mbrxfVyebsDiZY/R4JuI
         8gzTYOkCTGFyjsD3p9/lV3yMzErvYAfCCM8j7wjs2FCukc+In1/1uS1WB5BYhp8UpjW1
         4xmrIME4e8HoDrVK2DR52RrWzKLUqNmWtS4+iF2hz9dC76hNe8K6zplu1IRGUWiKyazR
         NHGfaHZS/sZIObuN1GQ/wlv7tb3K6ujZFlkI32BvmR2HY7SGV06u+7GexGDoOhPo+M4c
         jNbMuMtHA0iAyF/9wNJRCPfgO7dBrsztsPOIfCSBJfNg6gUaDo88WXBVnqS8NjVgSGFN
         h/yQ==
X-Forwarded-Encrypted: i=1; AJvYcCUh08QSaHM9CsvcbZQe0pt6X3ltLwctceje1GhmY+fOrB1mDT91N4zfJxoQq1lKwZGc4+sEfc4rVdV70NM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yye6233wCI0HxnwjPSkA8k091P2pagOn+lWnkuu0glJCq6wbRwi
	JbY62VxQZeOyWokKyfcFmYMIXHVPq7T97HcvVqNlclfKZXCJlTEdC7+GgGav/PTnVeYbXW8NQA6
	a1wdJNRwmlTcGEcjyb5OJLnGifv3CYOw0Eh8Q4QDMY+ztY/zSQZitZwp9qUXgBPajCtE=
X-Gm-Gg: ASbGncvbOumSeBZJKyxcDo+WQnA1p7GPqksIoBYySQ2E/grqYtR2IfwVMtdrAp+QMMY
	olqtaC4tb+eHV0FHghfMNNyFobZSO1fP5qT7bmlCmIcfhZA+lbh+HHB/wsYm782ICv5cHy+dupc
	KwGRCNR7iaYZXVl5iPZfqV8mPeU6eMbICs5h21ph6VDYYRm7mUOsSIuNa0mdv1D/7sR9f93/GL4
	rQq03j58IWEYhpwx+Kca3cYE1a7FJK5MPvsrSeT5QuRlKun6UVlOY8Tv7PngHxLHgWy4M/E/3BC
	9pjqWJU1hI9T4pfaoAJ1b5mEofuSNKGe8NTiKKjMn/d16zemWThXSBuL6dE+wMWGjh4Zhtd0
X-Received: by 2002:a05:6a20:2595:b0:2c6:85b9:1e0d with SMTP id adf61e73a8af0-32da8138fb8mr36423194637.21.1760525400140;
        Wed, 15 Oct 2025 03:50:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHCkvgwYwtp+G1Fo5ZZlGjsfYndNgAhiGmdAmlQNBGcdbkCj9GHS3/hxCWXELKdQdDs4BpuuQ==
X-Received: by 2002:a05:6a20:2595:b0:2c6:85b9:1e0d with SMTP id adf61e73a8af0-32da8138fb8mr36423159637.21.1760525399659;
        Wed, 15 Oct 2025 03:49:59 -0700 (PDT)
Received: from [10.206.107.23] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33b529f51b5sm9844853a91.7.2025.10.15.03.49.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Oct 2025 03:49:59 -0700 (PDT)
Message-ID: <295fa681-2977-4ab7-b543-a3515b3010be@oss.qualcomm.com>
Date: Wed, 15 Oct 2025 16:19:52 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] misc: fastrpc: Rename phys to dma_addr for clarity
To: Arnd Bergmann <arnd@arndb.de>, kpallavi@qti.qualcomm.com,
        Srinivas Kandagatla <srini@kernel.org>,
        Amol Maheshwari <amahesh@qti.qualcomm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: quic_bkumar@quicinc.com, ekansh.gupta@oss.qualcomm.com,
        linux-kernel@vger.kernel.org, quic_chennak@quicinc.com,
        dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        Jingyi Wang <jingyi.wang@oss.qualcomm.com>, aiqun.yu@oss.qualcomm.com,
        ktadakam@qti.qualcomm.com
References: <20251015045702.3022060-1-kumari.pallavi@oss.qualcomm.com>
 <20251015045702.3022060-2-kumari.pallavi@oss.qualcomm.com>
 <2e571b41-0006-4a37-9e3b-d333bf5eb7ed@app.fastmail.com>
Content-Language: en-US
From: Kumari Pallavi <kumari.pallavi@oss.qualcomm.com>
In-Reply-To: <2e571b41-0006-4a37-9e3b-d333bf5eb7ed@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: FO74B9UoR5msyYBNHyewdKus7fo4NzM0
X-Proofpoint-ORIG-GUID: FO74B9UoR5msyYBNHyewdKus7fo4NzM0
X-Authority-Analysis: v=2.4 cv=eaIwvrEH c=1 sm=1 tr=0 ts=68ef7c59 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=YTqRmuibImJoxezxnT0A:9 a=QEXdDO2ut3YA:10
 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAyMiBTYWx0ZWRfXwV8FK0W27+eq
 WJoA0TxtP1903Z8KG+Y9pyDWu1v4urCcPnTDbeBxxvquSOD4UDgAJxVJ3aVWxdMX76kvNbtN3VI
 eCiR0krLght7l03UbRZCsvt5apIXDChxnUgDpADZokLh1rbmX6QJxVDmGONA9u7VCvVwAwkUbTc
 Dg0RWpMt7OXuV3+H3y1+qNSDJClCsZpwTMDnNCkfschjnsDswd1gUpWw8FlNTQioto2xffmwCIu
 OOsRq6ydOga/hKpIWXbLsOl1sghgwSwkPghx2kPKvWBjCthb+Zuq7PkOOmq7AIUN3f7mJu8IVDg
 yRCBxTjKh6Eb0mZLLnijZEbR9f3jiVXU87VeFquqHO96bV6m+zUpk8Ww3ioIhfKPp0XnzDJXN8y
 1hBbDjgEodx0sWwhK2Dn+csR3rKJsA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-15_04,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 spamscore=0 impostorscore=0 phishscore=0
 adultscore=0 lowpriorityscore=0 clxscore=1015 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510110022



On 10/15/2025 12:50 PM, Arnd Bergmann wrote:
> On Wed, Oct 15, 2025, at 06:57, Kumari Pallavi wrote:
>> Update all references of buf->phys and map->phys to buf->dma_addr and
>> map->dma_addr to accurately represent that these fields store DMA
>> addresses, not physical addresses. This change improves code clarity
>> and aligns with kernel conventions for dma_addr_t usage.
>>
>> Signed-off-by: Kumari Pallavi <kumari.pallavi@oss.qualcomm.com>
> 
> Thanks for the update!
> 
>>   				&src_perms, &perm, 1);
>>   			if (err) {
>> -				dev_err(map->fl->sctx->dev, "Failed to assign memory phys 0x%llx
>> size 0x%llx err %d\n",
>> -						map->phys, map->len, err);
>> +				dev_err(map->fl->sctx->dev, "Failed to assign memory dma_addr
>> 0x%llx size 0x%llx err %d\n",
>> +						map->dma_addr, map->len, err);
>>   				return;
> 
> Note that using %llx is not a portable way to print a dma_addr_t,
> you should use %pad instead even if your method works on all
> arm64 configurations.
> 
> %pad requires passing the dma_addr_t variable by reference though.
> 

Ack.

>> @@ -783,10 +783,10 @@ static int fastrpc_map_attach(struct fastrpc_user
>> *fl, int fd,
>>   	map->table = table;
>>
>>   	if (attr & FASTRPC_ATTR_SECUREMAP) {
>> -		map->phys = sg_phys(map->table->sgl);
>> +		map->dma_addr = sg_phys(map->table->sgl);
>>   	} else {
> 
> This is technically still wrong, because sg_phys() returns
> a phys_addr_t that is only the same as the dma_addr_t value
> if there is no iommu or dma offset.
> 

Based on historical behavior, when the FASTRPC_ATTR_SECUREMAP flag is 
set, S2 mapping expects a physical address to be passed to the 
qcom_scm_assign_mem() API.
reference- 
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/drivers/misc/fastrpc.c?id=e90d911906196bf987492c94e38f10ca611dfd7b

> At the minimum, this requires a comment explaining what you
> are doing here, and I would add a '(dma_addr_t)' cast as
> well.
> 

To ensure clarity, i will add the comment. Adding '(dma_addr_t)' cast
result in incorrect behavior due to potential offsets.

> If possible, use sg_dma_address() instead of sg_phys() for
> portability if they produce the same bit value.
> 
>> @@ -813,10 +813,10 @@ static int fastrpc_map_attach(struct fastrpc_user
>> *fl, int fd,
>>   		dst_perms[1].vmid = fl->cctx->vmperms[0].vmid;
>>   		dst_perms[1].perm = QCOM_SCM_PERM_RWX;
>>   		map->attr = attr;
>> -		err = qcom_scm_assign_mem(map->phys, (u64)map->len, &src_perms,
>> dst_perms, 2);
>> +		err = qcom_scm_assign_mem(map->dma_addr, (u64)map->len, &src_perms,
> 
> This one has the reverse problem, as qcom_scm_assign_mem() takes
> a phys_addr_t instead of a dma_addr_t, again relying on the
> absence of an iommu.
> 
>> dst_perms, 2);
>>   		if (err) {
>> -			dev_err(sess->dev, "Failed to assign memory with phys 0x%llx size
>> 0x%llx err %d\n",
>> -					map->phys, map->len, err);
>> +			dev_err(sess->dev, "Failed to assign memory with dma_addr 0x%llx
>> size 0x%llx err %d\n",
>> +					map->dma_addr, map->len, err);
>>   			goto map_err;
> 
> %pad
> 

Ack

>>   		}
>>   	}
>> @@ -1007,7 +1007,7 @@ static int fastrpc_get_args(u32 kernel, struct
>> fastrpc_invoke_ctx *ctx)
>>   			struct vm_area_struct *vma = NULL;
>>
>>   			rpra[i].buf.pv = (u64) ctx->args[i].ptr;
>> -			pages[i].addr = ctx->maps[i]->phys;
>> +			pages[i].addr = ctx->maps[i]->dma_addr;
>>
> 
> pages[i].addr is declared as
> 
>        "u64 addr;               /* physical address */"
> 
> I guess the other side of this is the same CPU in a different
> exception level instead of an external device, right? This
> could also use a clarification.
> 

Ack

>          Arnd


