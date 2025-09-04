Return-Path: <linux-kernel+bounces-799636-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9F2EB42E5F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 02:48:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 75648546BF2
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 00:48:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AD393BBF2;
	Thu,  4 Sep 2025 00:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="LM9zTdKb"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A807288D6
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 00:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756946887; cv=none; b=dr+0kIR7fvJcU8KEXqTY2hECeB4cvhLX9t77zYLQv/8awE+yLSeeTL+qmnhUuhWUZepFlpT8Njt7kbHhRUqDI7oHc9+mJfwwTTe3mmygK4pdPOzWud8IMcGEotkhFHvOOilcgHKUrCuOMseOmtd0Y281CRU9GJJsECana6ou1hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756946887; c=relaxed/simple;
	bh=BZFnYqIYnYRUuOmS6pUYWVjxM+pjh2uog5aaF9XntgY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pxD3uIMdwvAqxIQzjpZYqOfUDWNu/WUlPdacc9RtJo5eMs3Bo2sc35wxJAnAxddkFs3NXwFjRdmL/kZIWFstJ6V49H8cBkukSZPigqgxkRHdwMydUnfW5SqpqyMQ4V7kR4VcJdLmweng5imW0/9Ytc3aNOsB5iQaFRbbw39N/eY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=LM9zTdKb; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 583Dwrtp020914
	for <linux-kernel@vger.kernel.org>; Thu, 4 Sep 2025 00:48:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	17s2MHhHmT5kNo+75PHQcfHsB0zgEcKrR7cg9CRVNlE=; b=LM9zTdKbue5Z6EDq
	tG/ztLKWWIwSlbttSMR8hW1e9f/LH2aBDqhmoXhV/T3Qtjb3PyXZNCHBmb50Wh6Y
	+4wwqerrTc/ReU701qKExxk+W90R4P+R6pKAOahRJObsmGsAKj+4XO6caspCKKB0
	7E2/rMltGZMcIlfTMYO/bijQfj/WfWIffKHGwt/kPBWLvuaQCYA4siZapL2B+ena
	eUnTUL2g+WtYLrwggiA0ER4sOHWVOreWXuho87UqELBqdZyvg7FKFxuZMHT3Uc7b
	BY1P61lAChDTd6C23/9Q6aZRpER5nuSecO5s4rtDdzxagdXzKREra1wNDr+a7o4X
	dPSuAQ==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48ut2fnhy2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 00:48:05 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-24b2336e513so6740745ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 17:48:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756946884; x=1757551684;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=17s2MHhHmT5kNo+75PHQcfHsB0zgEcKrR7cg9CRVNlE=;
        b=eDrtnpOJ2IiwL885XFX6NFEswr7ergIROr3pDuNXHxOkKZlmyVFtjg2w88ujBthBpE
         tRNdn7Zy0+PHEkme3E3y5uSwyGZpIAPNphMqYlblGiv0lVCw7AGKWGyp1zEq8DjKkhUW
         G8fhys6g5V2SBKwDfEaQvzOaCcD3Lpwn+imgaZjicaSHQK9EkecrrovnYWupxXbQF1oX
         XSkVzXJNBt5S0ZgLgDbkRAWxy/v7+JFr2yO5rkVCkxXzKP+x7vdl/etDNM3Hnxq+l2ms
         yViTqpMdweHaigNmeqoh2jvDx+y90QBcjlbSrSI8knGB+aQI71CxHwQeEzwomjJphuqU
         hGOQ==
X-Forwarded-Encrypted: i=1; AJvYcCXtMSAxNHhWKM1rOQZzjsEwLKLldPH7YChPJ75DUDe7zVRqY4QDqjIGhzFu3nc2cYfmLJeoVDYHUjmnUxQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnpOkOvjeOOeZ4uL3be44+2B3o/I1m5q2fy3f3OCjHJbi2to8x
	SV5SCKZyCfyCwTAk4m+oxPHIjZQc/2BjbhosfZ64OqxG0kRD7SjfKdzlCli9QBMdqnwI4FG6x4J
	eEIbyKr5DtDruwsIonnL4+oAIMjJ9RS3ETNntccKGvim0zqq2WJ9MBD1RbCcxidjUAH0=
X-Gm-Gg: ASbGncvDU3ew8X9I2cBCmGdrbe/qgA1vOj5TbGaPE5fr5Oz2TkgvY59ycR73fR3ZKzR
	9SYf7aWtqhga59BHMG/SLpYCiO6vxw3OOPy+Xv5jYAq2DN95yCfjRueCUn/0FgDyG1j05p7u5IG
	yNJUGUNwgkB9pkuc3M6Zo9uGDRATXOoovOTrHPuONvloLE0ZqzIvsgHdVDTMBnV0zwSnv6Zx5dQ
	P493m+OP8TwRw5t9QtVUvjUZe9vJ5uTjrrMhZPXgGBcJ8G8iwcLh/Y/2EL1S1VTdOl3Qic3oF3k
	33YByC+nSOx5J0bLm04tX7CTwzjXu/HDjMP1S9JImDQT9Aqwrq3/lL1o6a9GghZXG3CPFQeu2b0
	EgFplzPzE1tPDpdH1rrIekrW/VEpc
X-Received: by 2002:a17:903:388c:b0:249:33db:34b with SMTP id d9443c01a7336-24944b3fa5amr207542385ad.42.1756946884317;
        Wed, 03 Sep 2025 17:48:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHxb9Q6ymf/7LlpnATnajz4oPJxLQ/auiRISza8RTn4ZuddVk1oudIFgSFwT0ws67aSUTyLJg==
X-Received: by 2002:a17:903:388c:b0:249:33db:34b with SMTP id d9443c01a7336-24944b3fa5amr207541965ad.42.1756946883807;
        Wed, 03 Sep 2025 17:48:03 -0700 (PDT)
Received: from [10.133.33.16] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24c9304b790sm29195915ad.67.2025.09.03.17.47.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Sep 2025 17:48:03 -0700 (PDT)
Message-ID: <2b36c742-f517-4685-950c-696a34bc9c1e@oss.qualcomm.com>
Date: Thu, 4 Sep 2025 08:47:57 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/3] coresight: tpdm: add static tpdm support
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach
 <mike.leach@linaro.org>,
        James Clark <james.clark@linaro.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Tingwei Zhang <tingwei.zhang@oss.qualcomm.com>,
        Mao Jinlong <jinlmao.mao@oss.qualcomm.com>,
        Tao Zhang <quic_taozha@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20250822103008.1029-1-jie.gan@oss.qualcomm.com>
 <20250822103008.1029-3-jie.gan@oss.qualcomm.com>
 <4a28c9ea-fe71-44de-ada9-eda3111eff9e@oss.qualcomm.com>
Content-Language: en-US
From: Jie Gan <jie.gan@oss.qualcomm.com>
In-Reply-To: <4a28c9ea-fe71-44de-ada9-eda3111eff9e@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAzOCBTYWx0ZWRfX9G5I8hY7oUiF
 kCw7UaZ7EnE0uD53TaXGTeLAcrN6c10wZeaSnfnK4s581pjl6E8nGKnOMy7vLeqhT4VjXikDIzZ
 Dy6aovgTxjT+u8eopywQ0Flnm/3SBfyIvJkuCGCHml7SbNxgehG5nWXajCT0HsLFoByF4HKH1wa
 Zs5/yml0Lwnvw/ycvKR4FTbGB0HKPKmnoV7YxWKk6oQ6ps+3V6bQY0nHF+SeofMXIONyRs+iTQ9
 mjtO6y4YxmYipIu1zXA/wwjD/kjEth/+DVS5KxqM4I8wzQgLPfaCK45K60CHC4vUlygshD5O6BJ
 PfhLTnm2TIJCcaLj5P8Wrl6EnWenV3yyX4CSB8PA3cF+JwzcoZDHPJtuyylNTAnNW/z+48RQXuJ
 69IZj2Ld
X-Proofpoint-ORIG-GUID: IKUVXZfOSbGq0A7iGNxTAFN68ZFSvh4O
X-Proofpoint-GUID: IKUVXZfOSbGq0A7iGNxTAFN68ZFSvh4O
X-Authority-Analysis: v=2.4 cv=U7iSDfru c=1 sm=1 tr=0 ts=68b8e1c5 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=Uvk-ifDgNjwOAWHDOfAA:9
 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-03_11,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 clxscore=1015 impostorscore=0 suspectscore=0
 malwarescore=0 priorityscore=1501 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508300038



On 9/3/2025 7:06 PM, Konrad Dybcio wrote:
> On 8/22/25 12:30 PM, Jie Gan wrote:
>> The static TPDM function as a dummy source, however, it is essential
>> to enable the port connected to the TPDA and configure the element size.
>> Without this, the TPDA cannot correctly receive trace data from the
>> static TPDM. Since the static TPDM does not require MMIO mapping to
>> access its registers, a clock controller is not mandatory for its
>> operation.
>>
>> Signed-off-by: Jie Gan <jie.gan@oss.qualcomm.com>
>> ---
>>   drivers/hwtracing/coresight/coresight-tpda.c |   9 ++
>>   drivers/hwtracing/coresight/coresight-tpdm.c | 148 ++++++++++++++-----
>>   drivers/hwtracing/coresight/coresight-tpdm.h |   8 +
>>   3 files changed, 131 insertions(+), 34 deletions(-)
>>
>> diff --git a/drivers/hwtracing/coresight/coresight-tpda.c b/drivers/hwtracing/coresight/coresight-tpda.c
>> index 333b3cb23685..4e93fa5bace4 100644
>> --- a/drivers/hwtracing/coresight/coresight-tpda.c
>> +++ b/drivers/hwtracing/coresight/coresight-tpda.c
>> @@ -68,6 +68,15 @@ static int tpdm_read_element_size(struct tpda_drvdata *drvdata,
>>   	int rc = -EINVAL;
>>   	struct tpdm_drvdata *tpdm_data = dev_get_drvdata(csdev->dev.parent);
>>   
>> +	if (coresight_is_static_tpdm(csdev)) {
>> +		rc = fwnode_property_read_u32(dev_fwnode(csdev->dev.parent),
>> +					      "qcom,dsb-element-bits", &drvdata->dsb_esize);
>> +		rc &= fwnode_property_read_u32(dev_fwnode(csdev->dev.parent),
>> +					       "qcom,cmb-element-bits", &drvdata->cmb_esize);
> 
> This allows either pass/pass or fail/pass combinations to succeed
> - is this intended?

Yes. For static TPDM, we cannot read related registers to confirm which 
types it supported, just depend on the element-bits property which 
defined in DT.

So we treat either pass/pass or fail/pass(pass/fail) as succeed.

Thanks,
Jie

> 
> Konrad


