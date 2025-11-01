Return-Path: <linux-kernel+bounces-881082-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A273FC275E9
	for <lists+linux-kernel@lfdr.de>; Sat, 01 Nov 2025 03:22:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DDB7B189D8D5
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Nov 2025 02:23:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E6C2257820;
	Sat,  1 Nov 2025 02:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="kDjYuWe3";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="flUlsx8z"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDFAB254B09
	for <linux-kernel@vger.kernel.org>; Sat,  1 Nov 2025 02:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761963757; cv=none; b=GxSiwbwTjnvyhBdxxGVWPQzHtu14UXnHqP3udfEvU5nUxHs74weiCenQOVQVjK/018zDb2e6suHEuXg1r7NjvnQ9P/GMKNuw775Ky2SzIs+P5fz0nR0+kmhzYVhKDqGJuoSs02u8zTjJXRMKq00QQgzmaLpEQCkL1KmS/1VYN/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761963757; c=relaxed/simple;
	bh=hzovuXl09UCegfrjybM7I/vOQrCUkEVG/8cdpaFg8HM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NYzxmOGPmv6/lj2DMXLz15Z4oFB63GA5bqOKQ9HFCmcuEDOlYA4wzsM4RA94Nhr9ecIDbVvhvFRxIRMiqIrgS67wyBXkjEU4YeTsvMBiR52JuTpORK/oYgqRzQdxhGdRfeY+KL48EN+IN/9xxBM5Ei3iWSOnJxUNrklSgrqOjzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=kDjYuWe3; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=flUlsx8z; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A12C33r472307
	for <linux-kernel@vger.kernel.org>; Sat, 1 Nov 2025 02:22:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	+fzFhJL+3Uvu3S++Z0wtRAsQNFHBtmQqJ9Q9SbD7q1k=; b=kDjYuWe3E5PxMJQY
	p+04mlA15mvUseGKthoihAvZojW+QuSEp0V/Lf4xggm2HrXSqW97lbO7n8Eb1qkU
	pWw0C6v6aTmAa6Eau9yutfjeJddTvM4GM8HDyq14r8UWJdRBf7J9sDnndThbaERG
	HARmSKh/k/1sZqdbcGSxR77/ZSssrG2b9Ba++ioGpEctCYYJvufmZygR99VoJB5i
	Wca3hs6/a5VVBnbPBkOwYPKSI+OSbpYkPL6QmkKqq08F1RSdvCaT8VQZXCmwTh72
	Bf9cTGZTyTaYxO5T5vjJ2LjAvvXniH+oSrw9r+n6inPLtLmnnvn2SR4xh9KG/dfc
	ogxUNg==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a597780d5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sat, 01 Nov 2025 02:22:33 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-294fb13f80cso19630265ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 19:22:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1761963753; x=1762568553; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+fzFhJL+3Uvu3S++Z0wtRAsQNFHBtmQqJ9Q9SbD7q1k=;
        b=flUlsx8zo7FwarAmkuWuD1k3/QnaiZtNDOokVlhnvWrPGzyCkXS/CXLWG3qvNnrUFs
         QvTuWvXZ9WVK1i8D5ycgbZAqz40pXOb6fKLone+fnp5CUtfzyniYVL2AMW1MYj7Emfit
         ZtH7z6bAO8Q4CscDC7GeK5lO67E3zgzUs7vNLMwDYfupBMdNWalkCEbUyyX3HJ9O60TV
         tlWnIeKH63J+h+suuk6hXGMGh6L+HmRMrB7gQxEofuudJCvAnShAX9p9iu2Q/YMbt+Z5
         iD/TXnzPgLVMgQrvFK/i/zCZ4BtwOuOIWhyQaYT8VKCwuEOeRdRi6wiBBjiwvRkXCX4p
         jb2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761963753; x=1762568553;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+fzFhJL+3Uvu3S++Z0wtRAsQNFHBtmQqJ9Q9SbD7q1k=;
        b=tfNdbIvCkRENFNmdX3MmORL3NA5D2H3YozCyG8UJ1EY/y/antGUWoxDQPCllMKhn8A
         PJ0H5N5AHBO598jsgvvAqiXxEd1lOI7PGM8aUvOLXkCYd4jO+lE6Ko/2IJL7HP0WZpak
         Xm/Kh+lrW/KtjZUQ6sZri3/lpF8ie06A8DBEI2Cs9k7yvWs+LcNJXrjRmHHB0SSOWXXI
         NjO0gcgzJucP0RRjsTZCpkJyfxgKdeUr41Eo4v4C7nMQx532NrySdkZMuCEVzw/tnm+t
         dhyH14jdFjmh8lp0ApxzA7qsoLf2xvzASbddBoerIn6eavHwhvO8heTxMTm/9DGx1ufj
         pj5Q==
X-Forwarded-Encrypted: i=1; AJvYcCWoZUOJKh9FDg95md8bJRRsKkgy1m1rSOEDNenwtGWyxOFmmkMUv/SuqFjl5UNFbnzV72m0zm9l2etk2WY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2GQxkLnP/0DiwYjK79LUOtIp03efZT8o0z6Z1dNvSvdmaOaVf
	AfE4I3qkQTRzDV3udIwWxk0/Q/riv8RV+X0IrHxX/WImUccnRGlgx1mETP9TQp9F45O7OT9GNzB
	lnG73RRAJG/JJwCOefSrtFp5g+/eD3oGX69wMosL84l301I5KfbaVm6Zerdh+GcESVy8=
X-Gm-Gg: ASbGncv/fPQZRIAuH/dSnRbAEfONmVmiqTqSM6wtcfFp93dl1QVD8PETXW59RuvyCd8
	F6zc5F3tcQnkqS1esL8fd2QDYmQFeXjvirzv3+THP4nBN3Q7tGN7A5nTJlO9x4O44f/d3c6rFno
	tBmLxkPnJzs2fxSmmrwpW7QxYhxL35oueGNgFvI2mu6T0wxAV0u1LHgNMvud2ZGIIb2i3Dmm9F2
	Vpm7mHza/gyv3RnsuEIaHQ5XUvTU1kVyWdxF4xaUJeAa+RVgq5pXSMU0s9CVMOMqxr5fmiEL9dS
	ke3SNNFZKmrzJ2RWSHrzAVw9HqHSble8o4jBKwU84PQYJZfOq//9bKApHcEMuXmyRyi414AwDoC
	HiraEH6nyrSttBycdyweldiyo1len
X-Received: by 2002:a17:903:32c8:b0:28e:a70f:e879 with SMTP id d9443c01a7336-2951a36c289mr75158815ad.1.1761963752764;
        Fri, 31 Oct 2025 19:22:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFFUiF/HLz3e8/wxlMR4xO/m8PHeeUetXS05SpOZmGYy4MAPBOyjnwW/3n3pyCiYVCcUJbkvw==
X-Received: by 2002:a17:903:32c8:b0:28e:a70f:e879 with SMTP id d9443c01a7336-2951a36c289mr75158515ad.1.1761963752177;
        Fri, 31 Oct 2025 19:22:32 -0700 (PDT)
Received: from [10.216.5.37] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2952696ecf1sm38296405ad.64.2025.10.31.19.22.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Oct 2025 19:22:31 -0700 (PDT)
Message-ID: <28e2020c-8622-4bc3-aa5f-516a7d2abdb1@oss.qualcomm.com>
Date: Sat, 1 Nov 2025 07:52:24 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] spmi: spmi-pmic-arb: add support for PMIC arbiter
 v8
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        David Collins <david.collins@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, aiqun.yu@oss.qualcomm.com,
        kamal.wadhwa@oss.qualcomm.com, jingyi.wang@oss.qualcomm.com
References: <20251024-pmic_arb_v8-v3-0-cad8d6a2cbc0@oss.qualcomm.com>
 <20251024-pmic_arb_v8-v3-3-cad8d6a2cbc0@oss.qualcomm.com>
 <35ae8415-9308-4cbc-b14e-c3cdc0a2318a@oss.qualcomm.com>
Content-Language: en-US
From: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
In-Reply-To: <35ae8415-9308-4cbc-b14e-c3cdc0a2318a@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: JRc0hM5lnsV_vcxXyZmDSE7kROeuT6u3
X-Proofpoint-ORIG-GUID: JRc0hM5lnsV_vcxXyZmDSE7kROeuT6u3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTAxMDAxOSBTYWx0ZWRfXxRjJU0D0fb0z
 8wQJZ1ngkaeFZAoq4GAxhQcVRItqfRI05rTQb/Tuobc+/A1E0l7xBfgtlnRbqHKgZu4ZaPHTIgB
 Lmz99BIravG73Ot16FhljJn9ziEz9/qvUNGzzNnYQIpETtdjLrK5OdnaXqVuJonpDyglbpYOW0q
 8n9PxX9qWB/H2ieHD7VYhwjfpJlUou/CZFf3TJXc6PbESywKfdo2aZw3Mwl+aSfJwNUV7iVuFbI
 u/aOx+9wxXxQMaec89VCKVK8bdoOm9uZ5KQh3KH7/g4+S6PbCzGQrsbDiGSh9Kfdw6BaB9/3iUA
 xCuQ5tcXwpF1wbk9474gN93BODVQZdVj8ElfH8nK3weaKS5RCjJiFl9F9aOPK2C2L3L6pBl6uBB
 veJL08/gjqIpfQPJSzW03EJ1JHIiPg==
X-Authority-Analysis: v=2.4 cv=WcABqkhX c=1 sm=1 tr=0 ts=69056eea cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=Zg4tzvKK5du_it1U9AQA:9
 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-31_08,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 adultscore=0 priorityscore=1501
 impostorscore=0 spamscore=0 malwarescore=0 clxscore=1015 suspectscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511010019

Hi Konrad,

On 10/27/2025 5:47 PM, Konrad Dybcio wrote:
> On 10/24/25 11:33 AM, Jishnu Prakash wrote:
>> From: David Collins <david.collins@oss.qualcomm.com>
>>
>> PMIC arbiter v8 supports up to 4 SPMI buses and up to 8192 PMIC
>> peripherals.  Its register map differs from v7 as several fields
>> increased in size. Add support for PMIC arbiter version 8.
>>
>> Signed-off-by: David Collins <david.collins@oss.qualcomm.com>
>> Signed-off-by: Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>
>> Signed-off-by: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
>> ---
>>  drivers/spmi/spmi-pmic-arb.c | 324 +++++++++++++++++++++++++++++++++++++++----
>>  1 file changed, 294 insertions(+), 30 deletions(-)
>>
>> diff --git a/drivers/spmi/spmi-pmic-arb.c b/drivers/spmi/spmi-pmic-arb.c
>> index 91581974ef84..612736973e4b 100644
>> --- a/drivers/spmi/spmi-pmic-arb.c
>> +++ b/drivers/spmi/spmi-pmic-arb.c
>> @@ -3,6 +3,7 @@
>>   * Copyright (c) 2012-2015, 2017, 2021, The Linux Foundation. All rights reserved.
>>   */
>>  #include <linux/bitmap.h>
>> +#include <linux/bitfield.h>
> 
> bit'f'ield < bit'm'ap
> 
> [...]
> 
>>  #define spec_to_hwirq(slave_id, periph_id, irq_id, apid) \
>> -	((((slave_id) & 0xF)   << 28) | \
>> -	(((periph_id) & 0xFF)  << 20) | \
>> -	(((irq_id)    & 0x7)   << 16) | \
>> -	(((apid)      & 0x3FF) << 0))
>> +	(FIELD_PREP(GENMASK(28, 24), (slave_id))  | \
>> +	FIELD_PREP(GENMASK(23, 16), (periph_id)) | \
>> +	FIELD_PREP(GENMASK(15, 13), (irq_id))    | \
>> +	FIELD_PREP(GENMASK(12, 0),  (apid)))
> 
> I think this could be further improved by:
> 
> #define SOMETHING_SLAVE_ID_SOMETHING	GENMASK(28, 24)
> 
> and then below:
> 
> [...]
> 
>> -	if (intspec[0] > 0xF || intspec[1] > 0xFF || intspec[2] > 0x7)
>> +	if (intspec[0] > 0x1F || intspec[1] > 0xFF || intspec[2] > 0x7)
>>  		return -EINVAL;
> 
> we can use FIELD_MAX(SOMETHING...)
> 
> [...]
> 
>> +static int pmic_arb_get_core_resources_v8(struct platform_device *pdev,
>> +					  void __iomem *core)
>> +{
>> +	struct spmi_pmic_arb *pmic_arb = platform_get_drvdata(pdev);
>> +
>> +	pmic_arb->apid_map = devm_platform_ioremap_resource_byname(pdev,
>> +								   "chnl_map");
> 
> Feel free to unwrap this line

I'll make all the changes you have suggested above in the next series.

> 
>> +	if (IS_ERR(pmic_arb->apid_map))
>> +		return PTR_ERR(pmic_arb->apid_map);
>> +
>> +	pmic_arb->core = core;
>> +
>> +	pmic_arb->max_periphs = PMIC_ARB_MAX_PERIPHS_V8;
>> +
>> +	return pmic_arb_get_obsrvr_chnls_v2(pdev);
>> +}
>> +
>> +static int pmic_arb_get_bus_resources_v8(struct platform_device *pdev,
>> +					 struct device_node *node,
>> +					 struct spmi_pmic_arb_bus *bus)
>> +{
>> +	int index;
>> +
>> +	index = of_property_match_string(node, "reg-names", "chnl_owner");
>> +	if (index < 0) {
>> +		dev_err(&pdev->dev, "chnl_owner reg region missing\n");
>> +		return -EINVAL;
>> +	}
>> +
>> +	bus->apid_owner = devm_of_iomap(&pdev->dev, node, index, NULL);
>> +
>> +	return PTR_ERR_OR_ZERO(bus->apid_owner);
> 
> Is this any different chan using devm_platform_ioremap_resource_byname()
> like you did above?

devm_platform_ioremap_resource_byname() would work for mapping resources
directly under the main device node, like"chnl_map" , but in this case, the
resource "chnl_owner" is under a child node of the the main node, so we
need to use devm_of_iomap() here.

> 
> 
>> +}
>> +
>> +static int pmic_arb_read_apid_map_v8(struct spmi_pmic_arb_bus *bus)
>> +{
>> +	struct spmi_pmic_arb *pmic_arb = bus->pmic_arb;
>> +	struct apid_data *apidd;
>> +	struct apid_data *prev_apidd;
>> +	u16 i, apid, ppid, apid_max;
>> +	bool valid, is_irq_ee;
>> +	u32 regval, offset;
>> +
>> +	/*
>> +	 * In order to allow multiple EEs to write to a single PPID in arbiter
>> +	 * version 8, there can be more than one APID mapped to each PPID.  The
>> +	 * owner field for each of these mappings specifies the EE which is
>> +	 * allowed to write to the APID.  The owner of the last (highest) APID
>> +	 * which has the IRQ owner bit set for a given PPID will receive
>> +	 * interrupts from the PPID.
>> +	 *
>> +	 * In arbiter version 8, the APID numbering space is divided between
>> +	 * the SPMI buses according to this mapping:
>> +	 * APID = 0     to N-1       --> bus 0
>> +	 * APID = N     to N+M-1     --> bus 1
>> +	 * APID = N+M   to N+M+P-1   --> bus 2
>> +	 * APID = N+M+P to N+M+P+Q-1 --> bus 3
>> +	 * where N = number of APIDs supported by bus 0
>> +	 *       M = number of APIDs supported by bus 1
>> +	 *       P = number of APIDs supported by bus 2
>> +	 *       Q = number of APIDs supported by bus 3
>> +	 */
>> +	apidd = &bus->apid_data[bus->base_apid];
>> +	apid_max = bus->base_apid + bus->apid_count;
>> +	for (i = bus->base_apid; i < apid_max; i++, apidd++) {
>> +		offset = pmic_arb->ver_ops->apid_map_offset(i);
>> +		regval = readl_relaxed(pmic_arb->apid_map + offset);
>> +		if (!regval)
>> +			continue;
>> +		ppid = regval & PMIC_ARB_V8_PPID_MASK;
>> +		is_irq_ee = PMIC_ARB_V8_CHAN_IS_IRQ_OWNER(regval);
> 
> [...]
> 
> 
> If you parametrize the masks, the diff against pmic_arb_read_apid_map_v5
> is 3 lines of code instead

Are you suggesting we should try to have a common helper function for v5/v7
and v8, which does the bulk of these actions and can be given different
input arguments to distinguish the versions?

There is at least one more difference which I don't think we can easily
accommodate with parameters:

In pmic_arb_read_apid_map_v5(), we have:
regval = readl_relaxed(pmic_arb->core + offset);

In pmic_arb_read_apid_map_v8(), we have:
regval = readl_relaxed(pmic_arb->apid_map + offset);


But in any case, we would have to add `if` checks to distinguish arbiter
versions to use a helper function. This itself might not be a good idea as it
would break the abstraction already implemented in the probe, by having
PMIC version checking happen only in the probe, to select the correct set
of ver_ops functions for a particular version.


> 
> 
>> +
>> +	return 0;
>> +}
>> +
>> +static int pmic_arb_init_apid_v8(struct spmi_pmic_arb_bus *bus, int index)
>> +{
>> +	struct spmi_pmic_arb *pmic_arb = bus->pmic_arb;
>> +	int ret, i;
>> +
>> +	if (index < 0 || index >= PMIC_ARB_MAX_BUSES_V8) {
>> +		dev_err(&bus->spmic->dev, "Unsupported bus index %d detected\n",
>> +			index);
>> +		return -EINVAL;
>> +	}
>> +
>> +	bus->base_apid = 0;
>> +	bus->apid_count = 0;
>> +	for (i = 0; i <= index; i++) {
>> +		bus->base_apid += bus->apid_count;
>> +		bus->apid_count = readl_relaxed(pmic_arb->core + PMIC_ARB_FEATURES + i * 4) &
>> +						PMIC_ARB_FEATURES_V8_PERIPH_MASK;
> 
> You can almost replace pmic_arb_init_apid_v7 with this impl

They are not exactly the same - v7 arbiter supports at most 2 buses,
so pmic_arb_init_apid_v7 needs to restrict the max value of index to 2.

Here too, using a common helper function would require us to add more
`if` checks for the version, which leads to the same kind of issue as above.


> 
> [...]
> 
>> +static void __iomem *
>> +pmic_arb_apid_owner_v8(struct spmi_pmic_arb_bus *bus, u16 n)
>> +{
>> +	return bus->apid_owner + 0x4 * (n - bus->base_apid);
>> +}
> 
> This is identical to pmic_arb_apid_owner_v7

This is not exactly right, pmic_arb_apid_owner_v7 uses bus->cnfg
and pmic_arb_apid_owner_v8 uses bus->apid_owner at the same place.
They are both already single line functions, would it really help
to try to simplify them further?

Thanks,
Jishnu

> 
> Konrad


