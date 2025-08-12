Return-Path: <linux-kernel+bounces-764258-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B5E6B2208F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 10:19:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EAE13423938
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 08:19:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A97A42E11A6;
	Tue, 12 Aug 2025 08:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ezgowA1E"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AA2214A60F
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 08:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754986763; cv=none; b=sSyoYAk5619IYnH+CRQC/1djOREgNL+JTfwYioJ4LOTuBgu2ZDcyWMjKhEl8aDEGWCByT2f8TOlTXgkUyhTjzp2emxMhkKXDAmcwSsZXTFdj1WZCAiSFfMFWYo5bsQfQlgWoG6gAErnb3shb3LCGcJkLKi9sfz6KWFTeBPSHF1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754986763; c=relaxed/simple;
	bh=Q9QXSmcQk7wiCYlKK6+sUB3ZaThL+9sYBmMDwHt3Hjw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FcEDq0sxIe47qzjxx3epje6zXyHkHJHd96d4192jo4ebQEt3nx7Lknvhkw+oR8+plyENe3WxF+aM1c74oSZDHFvT1nVffSoW5Tpdr+G7Spwgz2O7ELzShT15eeRDxgQJS+VgZmEclJ1alpt6fj3LF0oywKqez+lIfXDl4OjZL8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ezgowA1E; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57C4Zepb013076
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 08:19:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Q9QXSmcQk7wiCYlKK6+sUB3ZaThL+9sYBmMDwHt3Hjw=; b=ezgowA1EbOUDJffI
	bn3nOy6A8tGNpwREDt9jRMaC0mnVUXTda4NpvPAydJd1LgMMRjKbQqKBIqmz/Oqn
	Tl5w1w16g19eIgJiHIuvLJjHa0Oz9B6jC6vjFsdUVZN9woZfXa9s3dp+EYd116Dd
	8YySwdbjtjmlZ7qQZ1VG5iCTNORZX6hQBRMkVtrtspu1OEq6Ounfu1aPMmMwm29i
	3rvFGlhuo6rbcoRBFVlOJ8Eq2Fl0oqZn/jrcSFdcRtB3+LX5wMpefISAJ0L1LY+v
	GREiFwJdv3urjq0tg/R40lghQQ8FZpEL2I4SmR18rC+5dIa1mflTTPNNmToE0ufw
	xG+4ag==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48dupmqgey-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 08:19:20 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-76bf7375f8dso4765204b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 01:19:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754986759; x=1755591559;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q9QXSmcQk7wiCYlKK6+sUB3ZaThL+9sYBmMDwHt3Hjw=;
        b=rZbThQbk161GraoimPTQQMZMs5BbJAxnGugoN7Ah8pdwrYK/UZSL7MsMJnBve+giEo
         H9kl3ux1GI7QYUEb7Ib1Ba+CahQxM++ZeWNS7kQ+qhl/eguX+bkx3EMmtTYsw30ojXWV
         moUa1RflImDvYeKHleJzxyvb0h0zW3tXvYQaPoEuLrd1BwNv6ZI2guyNjaBRZU1mJiHx
         adz32m03W86uICQ/iMoXEXnJ8mZkasyIpe3TP9y4hYXZ0oxLXgtHtsWjzggxJ8kcBdke
         gaj99SSdcFaI8oIndSI0mh1GdcHRekXawEni2qo33k1MByI5Dhmm9Tf3Ulh2C65svuua
         hSUw==
X-Forwarded-Encrypted: i=1; AJvYcCUIZBex+kCW61gpFy50dh40dFhM+4td2piQWLN86Rj1LoY2ZkqglS+gux87PK3gQGJ8fh7C4iODNbm43r0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxncuFHU25WWZ/4nsMJ8J/ymQUoXiKFnDEoHHPbbKB9lnh/Cmj1
	AqpNwbTntGUblja0b201W5PFIw9HfPkCD55zpVu/NxhABS+aZht1RKBL1fXfDVbX3RJep49YQZo
	w1ztunkys2U3ejpnGaLsTypn0lJ3J0ZI7nU+nJO7i4zQJc+EWYV7qh1t2fIXdm6tKnOkwhQRgDT
	lhX+N2
X-Gm-Gg: ASbGncvyfwQL1bhpTGpdGVuYv8Jx7/Y4bmTOALZZ/izeqYh7HdwpeLGP/Ff4+PDljET
	Y/1Cqt+7cgToVdorwPAB0eOWdps+8yZZOHzgkootUNp73yUV2ytS8oI3RVl8y+TuQPA6eeDpzlz
	6S8/aLvmS9D8ybGmDOD/2vZ3R3KNVuHYN2rCDRoFUpjlDomgcOrt4XqGae+nMKFDrc5ju8hr1Mh
	m9Cp/aR0NiNunSdppxjGFNuun0OqXskZGn3UQbQhcFDCV+0hUWz7zPa8klr7tfjQxWkruT0v1L5
	tp6E2jK8kKyF3eTSbyYGuBIi4LZNz17iVYLNoaQWjehQ9StQOHs75a/dOgG7m5B5bCZPNVuRoqq
	wS2SuccKCSMJOPEZEv7jUaqVjK5Kz6c4a
X-Received: by 2002:a05:6a20:258d:b0:21a:eabb:ab93 with SMTP id adf61e73a8af0-2409a895f7amr3711441637.6.1754986759508;
        Tue, 12 Aug 2025 01:19:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHEO10xU9ZfSLkw9mApIC6RN/5DfAeAo3uPA3QI869bvJmzxE2pfjh+sEvtPpS8AVW8pX0riA==
X-Received: by 2002:a05:6a20:258d:b0:21a:eabb:ab93 with SMTP id adf61e73a8af0-2409a895f7amr3711410637.6.1754986759024;
        Tue, 12 Aug 2025 01:19:19 -0700 (PDT)
Received: from [10.133.33.10] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bcce8fa10sm28728852b3a.52.2025.08.12.01.19.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Aug 2025 01:19:18 -0700 (PDT)
Message-ID: <85dc8b0e-bf0b-44c7-9ef8-cce460fd1d22@oss.qualcomm.com>
Date: Tue, 12 Aug 2025 16:19:15 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] coresight-etm4x: Conditionally access register
 TRCEXTINSELR
To: James Clark <james.clark@linaro.org>
Cc: kernel@oss.qualcomm.com, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach
 <mike.leach@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
References: <20250811-trcextinselr_issue-v1-1-ed78f3215502@oss.qualcomm.com>
 <de68756d-7ef4-484f-8eb0-26a88ed41cad@linaro.org>
Content-Language: en-US
From: yuanfang zhang <yuanfang.zhang@oss.qualcomm.com>
In-Reply-To: <de68756d-7ef4-484f-8eb0-26a88ed41cad@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=bY5rUPPB c=1 sm=1 tr=0 ts=689af908 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=bRSsP4KCScyoyIGQGosA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-GUID: x3FZZMzR9FlOq3Qpixeee1N-DLu1B-JJ
X-Proofpoint-ORIG-GUID: x3FZZMzR9FlOq3Qpixeee1N-DLu1B-JJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA5MDAwMCBTYWx0ZWRfX3tEB9cy26EBb
 e1Wkm3zVu8agSPKCvtbogUv5kw/qJ+1SH8fR1VRvDL5y9xkgiVmWyljiqHpud4Ymwe/3jq+EkT3
 6N4g1Gv2AvAEXLzABuDuUPI5m2v4mop+10ukcUHjJK4WSIpaDGK4gYjDd/i4Xl/9QXGzDgzu1id
 bHK0wDy/DMROSamL/xJXl5aaZL1ZeOL+AQXGqlZmsKhwRALeUlnfFCOv86H854oRQcqOtpeHBZ7
 FRPWBz5hcc5QXnPb4RnghQpF9NmZb85LyqFZMkjiVunST89vzptgneSQmHDl799hKMRb124CAEo
 NBD2ZAnIISnAGqbfR5YMs5O45pEK24V1IbprtnUEUGwemaFzvHk8ibEF/Re8P+yv0WyS9R4crDu
 mFNC7tZG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-12_04,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 bulkscore=0 impostorscore=0 priorityscore=1501
 spamscore=0 clxscore=1015 phishscore=0 adultscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508090000


On 8/11/2025 6:25 PM, James Clark wrote:
>
>
> On 11/08/2025 10:57 am, Yuanfang Zhang wrote:
>> The TRCEXTINSELR is only implemented if TRCIDR5.NUMEXTINSEL > 0.
>> To avoid invalid accesses, introduce a check on numextinsel
>> (derived from TRCIDR5[11:9]) before reading or writing to this register.
>>
>
> Looks like this should have a fixes: tag.
updated in next patch.
>
>> Signed-off-by: Yuanfang Zhang <yuanfang.zhang@oss.qualcomm.com>
>> ---
>>   drivers/hwtracing/coresight/coresight-etm4x-core.c | 11 ++++++++---
>>   drivers/hwtracing/coresight/coresight-etm4x.h      |  2 ++
>>   2 files changed, 10 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
>> index 42e5d37403addc6ec81f2e3184522d67d1677c04..8a9c4caceff0165e4fce7ac4250f3e16ccc1d34e 100644
>> --- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
>> +++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
>> @@ -528,7 +528,8 @@ static int etm4_enable_hw(struct etmv4_drvdata *drvdata)
>>           etm4x_relaxed_write32(csa, config->seq_rst, TRCSEQRSTEVR);
>>           etm4x_relaxed_write32(csa, config->seq_state, TRCSEQSTR);
>>       }
>> -    etm4x_relaxed_write32(csa, config->ext_inp, TRCEXTINSELR);
>> +    if (drvdata->numextinsel)
>> +        etm4x_relaxed_write32(csa, config->ext_inp, TRCEXTINSELR);
>>       for (i = 0; i < drvdata->nr_cntr; i++) {
>>           etm4x_relaxed_write32(csa, config->cntrldvr[i], TRCCNTRLDVRn(i));
>>           etm4x_relaxed_write32(csa, config->cntr_ctrl[i], TRCCNTCTLRn(i));
>> @@ -1423,6 +1424,7 @@ static void etm4_init_arch_data(void *info)
>>       etmidr5 = etm4x_relaxed_read32(csa, TRCIDR5);
>>       /* NUMEXTIN, bits[8:0] number of external inputs implemented */
>>       drvdata->nr_ext_inp = FIELD_GET(TRCIDR5_NUMEXTIN_MASK, etmidr5);
>> +    drvdata->numextinsel = FIELD_GET(TRCIDR5_NUMEXTINSEL_MASK, etmidr5);
>>       /* TRACEIDSIZE, bits[21:16] indicates the trace ID width */
>>       drvdata->trcid_size = FIELD_GET(TRCIDR5_TRACEIDSIZE_MASK, etmidr5);
>>       /* ATBTRIG, bit[22] implementation can support ATB triggers? */
>> @@ -1852,7 +1854,9 @@ static int __etm4_cpu_save(struct etmv4_drvdata *drvdata)
>>           state->trcseqrstevr = etm4x_read32(csa, TRCSEQRSTEVR);
>>           state->trcseqstr = etm4x_read32(csa, TRCSEQSTR);
>>       }
>> -    state->trcextinselr = etm4x_read32(csa, TRCEXTINSELR);
>> +
>> +    if (drvdata->nrseqstate)
>
> Shouldn't this be "if (drvdata->numextinsel)"? Or it needs a comment saying why it's different to the others.
typo, will correct in next patch.
>
> Otherwise looks ok.
>
>> +        state->trcextinselr = etm4x_read32(csa, TRCEXTINSELR);
>>         for (i = 0; i < drvdata->nr_cntr; i++) {
>>           state->trccntrldvr[i] = etm4x_read32(csa, TRCCNTRLDVRn(i));
>> @@ -1984,7 +1988,8 @@ static void __etm4_cpu_restore(struct etmv4_drvdata *drvdata)
>>           etm4x_relaxed_write32(csa, state->trcseqrstevr, TRCSEQRSTEVR);
>>           etm4x_relaxed_write32(csa, state->trcseqstr, TRCSEQSTR);
>>       }
>> -    etm4x_relaxed_write32(csa, state->trcextinselr, TRCEXTINSELR);
>> +    if (drvdata->numextinsel)
>> +        etm4x_relaxed_write32(csa, state->trcextinselr, TRCEXTINSELR);
>>         for (i = 0; i < drvdata->nr_cntr; i++) {
>>           etm4x_relaxed_write32(csa, state->trccntrldvr[i], TRCCNTRLDVRn(i));
>> diff --git a/drivers/hwtracing/coresight/coresight-etm4x.h b/drivers/hwtracing/coresight/coresight-etm4x.h
>> index ac649515054d905fa365203bd35f1d839b03292f..823914fefa90a36a328b652b0dc3828b9bddd990 100644
>> --- a/drivers/hwtracing/coresight/coresight-etm4x.h
>> +++ b/drivers/hwtracing/coresight/coresight-etm4x.h
>> @@ -162,6 +162,7 @@
>>   #define TRCIDR4_NUMVMIDC_MASK            GENMASK(31, 28)
>>     #define TRCIDR5_NUMEXTIN_MASK            GENMASK(8, 0)
>> +#define TRCIDR5_NUMEXTINSEL_MASK               GENMASK(11, 9)
>>   #define TRCIDR5_TRACEIDSIZE_MASK        GENMASK(21, 16)
>>   #define TRCIDR5_ATBTRIG                BIT(22)
>>   #define TRCIDR5_LPOVERRIDE            BIT(23)
>> @@ -999,6 +1000,7 @@ struct etmv4_drvdata {
>>       u8                nr_cntr;
>>       u8                nr_ext_inp;
>>       u8                numcidc;
>> +    u8                numextinsel;
>>       u8                numvmidc;
>>       u8                nrseqstate;
>>       u8                nr_event;
>>
>> ---
>> base-commit: 8f5ae30d69d7543eee0d70083daf4de8fe15d585
>> change-id: 20250811-trcextinselr_issue-f267afa0e5ed
>>
>> Best regards,
>

