Return-Path: <linux-kernel+bounces-866508-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 75AF0BFFF3A
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 10:36:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 461344E22EE
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 08:36:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4D69301484;
	Thu, 23 Oct 2025 08:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="BOKFdwmp"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C742301467
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 08:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761208551; cv=none; b=OnPp9A2zXlLjdWaWmwQJPhh9mydUbFlfRF9iPoaFjcyPU5hqvRaVH5Zofhe8dcjtcaKRDBK2pSxfzZ+HzmMTlYz3QhVBY5yea3qbXuX5tfnVOBtA7wWiT+qjN7rcsR1BmhphrSs5i/rDd/JYMyDJ0bQ1QMwvTOhwkb3hf0uL21Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761208551; c=relaxed/simple;
	bh=bATtxhSNgCWutO+HMe3FhbdCaGba0VkesZ+LNFJHZAo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nKQREtbyZG9GzZN5sbKUGIg4xae8MFGRFtFlb6JdBJ8tgk+mJF5+8h/hvLevDUf4cfGf9C/nLfUO3O+eWnheN/3Aos5oSTPpaAN14vlp/1bFF97Mv6W8L/ej2oXFDH+Vw7QkjGthQERXz4zPDdizZeA5BQejo6G7st5gIktrrSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BOKFdwmp; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59N776cA014615
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 08:35:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	LCyk7hNB1J09n2mOoRdLCnMNhi+K220v852ILW4KCJc=; b=BOKFdwmpp2fVKu0l
	N0CmXfulyJdI/eBBugnP65Gtnd/NMfWQx+FMoT87VuMvnfNddIaGbkj2UrPqX+w8
	b78a82RgO+0sZUR+lHkuNygiZyR8cVccxIozJDPDsoSS+kkl/sxFZA0/8wBWoMBp
	2eXGY2o0e55SqetS+ih6PJCQ4AHNwhIV3Z5uOpOiLOdMmysD/JG8IgQXZOeQfcYQ
	5DKtOVsP8wbVOzAprlZovoHlOdvYd9+PQ6d1+De3rRJNwYKLGBieVnQzR8UBUaID
	FY/+7tdQ8CWR6SbLh0dpH41Hb1OcppsNb72tjWKoxtE7z+40f5hf+baWTih18qHx
	0KvvUA==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49xhe0njcw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 08:35:48 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-28a5b8b12bbso16900775ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 01:35:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761208546; x=1761813346;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LCyk7hNB1J09n2mOoRdLCnMNhi+K220v852ILW4KCJc=;
        b=lCkOFiSRE3gVg530AW0jKuvAkLnaXhTuW5Bu7kkvVoGm4xLjMN/xLdbNCK+Y1+yz88
         4/cDep7vZr71SEAgqnRQnHbNlRqyhc73ibg/ITielom+7x6RsAV/k0MD8rLSdR/+f625
         2x+oAyu0mJTkrqqLaCjvCL2EyWFnaTzeFdDRycb2fFPutjT4ERwXbfTtRvkdkXZ5zTFP
         91fc0yG5wEY2KL+bfUHlxFWzg7tZ2pD3FV2RIukRv4HMroQ/SVRcmiTFRL0LqwLIhIbX
         DKGSO8bZh9eO+7lTCr6Uica6hlqtxrqbxmNOeryYY2pr5F5NfCBpNpR65lZgkCFlmXDA
         MCSQ==
X-Forwarded-Encrypted: i=1; AJvYcCWN+kERCdHjqChAcuWkdqTIv1Ua7DQoW4g53lIS2MkBfDp508GVMyoK6avgMXq9HrMN4HArC+zH+LEVzho=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLxAlmKl5rxZgY+N1ANqBnmYKuysWjU2PcbWLqYMsltB5HRob/
	qlAzlThQFMHhrQRZ0gYPQysnJnYPLoKzrCK4whCgUUSTuSh7Ec3e9rA5Sw/x+Nk1aKqg5i2dGRP
	9FeyQVPWL4bWCpBpMJM+bEtuhaDVK5M3wcb+3AJWWorinlfLuR6OLVrlBw+X6A7CwDSY=
X-Gm-Gg: ASbGncu71zIlSMDEXz6J+IrFfxs1hyPmtmdIjWGuaAE65B3bcvQ0rSaOEm9jiGiAS+n
	Z4WSwJN2PexlXtX+EkxhFvWVZ5yZ/2uyndreEyRgMc0lW45sVhm7NgLcotH3DXtM/9Vcs6rEn4c
	jR6l5stJNe8hO1QJR7NdPJhivjAOtapwzZOi92x/LZ5slZUYJblsdIq54X0S37rplxsKQTJUEP7
	4YuqoyAc8y43GpHvXlmm/xQBXMUpNfi/6hDv4nUeYrrQLYHD1+h3/TCjIBlIb6yR1pnKNPVmvHc
	oaFe83DDxpg3JNPlOQKD7ddAr1jtXdkitYQzFMrA7z7glkoP2n/hNrwXX1iIFJy9rXSw8EQpTQL
	3+/eu/NOmc+rfG8wbPrZV224g2VEZLRs=
X-Received: by 2002:a17:902:dac2:b0:269:8f2e:e38 with SMTP id d9443c01a7336-290c9cf97b1mr286140405ad.6.1761208545691;
        Thu, 23 Oct 2025 01:35:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGfmtH7W7Rcd+PsGcEWkEwyiE1ex2CnHHoTYcplW882/icjOQlxkppW8FqSKUpD2rm3Jy5Mxg==
X-Received: by 2002:a17:902:dac2:b0:269:8f2e:e38 with SMTP id d9443c01a7336-290c9cf97b1mr286140165ad.6.1761208545219;
        Thu, 23 Oct 2025 01:35:45 -0700 (PDT)
Received: from [10.204.86.125] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2946de1a6e3sm15703915ad.52.2025.10.23.01.35.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Oct 2025 01:35:44 -0700 (PDT)
Message-ID: <b3e905af-639a-4390-8fb7-50a947bf4fcf@oss.qualcomm.com>
Date: Thu, 23 Oct 2025 14:05:39 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] misc: fastrpc: Add support for new DSP IOVA
 formatting
To: Krzysztof Kozlowski <krzk@kernel.org>, kpallavi@qti.qualcomm.com,
        srini@kernel.org, amahesh@qti.qualcomm.com, arnd@arndb.de,
        gregkh@linuxfoundation.org
Cc: quic_bkumar@quicinc.com, ekansh.gupta@oss.qualcomm.com,
        linux-kernel@vger.kernel.org, quic_chennak@quicinc.com,
        dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        jingyi.wang@oss.qualcomm.com, aiqun.yu@oss.qualcomm.com,
        ktadakam@qti.qualcomm.com
References: <20251015045702.3022060-1-kumari.pallavi@oss.qualcomm.com>
 <20251015045702.3022060-3-kumari.pallavi@oss.qualcomm.com>
 <14213195-29fa-48d9-8fc4-ccdc9b6f7ecc@kernel.org>
Content-Language: en-US
From: Kumari Pallavi <kumari.pallavi@oss.qualcomm.com>
In-Reply-To: <14213195-29fa-48d9-8fc4-ccdc9b6f7ecc@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDIxMDE2NyBTYWx0ZWRfXyAcq/JcvlxoH
 PhXCFJbsS/wc49MtTTrwUPHXZuAkiYxDo/rxdY66mIu36ucSa1+Or3xQ85c99Lgrrra3NaFYsxR
 KpJE1WaPs8MU6He3nWEtNTuPVMRpF3FgZSDnUGz/rYsn9Gs4dV7ZoRXastGWxXLJCYlS89izmUv
 Cwn7KgMLu1zcKFM+ELEGPjAlfrXtZ/8PmlodJ/STGd1U6K6MHnf6FzcoHA8JxHoBXpTGo6W6RhU
 V7+hPDUAiL19y4dh71vwEyrBL5Y8Ab5218E/S9y68unFNRDxt++viEG3KNzEZydK5hoBIPfu1Xj
 cqkvbJhivE1psFr7Mj/9+BcHfO3TlfRuORWUhvFF2dkbuKkN3cPem2mt9CBvBLmm7FXVibHTSju
 nq9fmc5SotldDk61UqoCXTGpcBSt7g==
X-Proofpoint-ORIG-GUID: mjXtCGfljet5ifwYMkv7HBsDfZ-UVw5n
X-Authority-Analysis: v=2.4 cv=WYUBqkhX c=1 sm=1 tr=0 ts=68f9e8e4 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=TfANz5PKPoX1PYxfYcwA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-GUID: mjXtCGfljet5ifwYMkv7HBsDfZ-UVw5n
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_08,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 bulkscore=0 impostorscore=0 spamscore=0
 priorityscore=1501 clxscore=1015 malwarescore=0 lowpriorityscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510020000
 definitions=main-2510210167



On 10/18/2025 10:54 PM, Krzysztof Kozlowski wrote:
> On 15/10/2025 06:57, Kumari Pallavi wrote:
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
> 
> This is really odd way of doing things. You want to check machine, not
> some node. Use proper API for that.
> 
> OTOH, I don't understand why you are checking machine in the first
> place. If your device is different, then please follow writing bindings
> - it explains exactly this case here.
> 

On the Kaanapali SoC, enabling ADSP and CDSP functionality requires new 
DSP IOVA formatting and hardware-specific configuration. Going forward, 
SoC will support the updated IOVA format.
To handle this, we referred to the implementation in
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/drivers/soc/qcom/qcom_pd_mapper.c, 
which aligns well with the requirements and serves as a suitable 
reference for our use case.
If there are alternative approaches or suggestions for handling this 
more effectively, we’re happy to discuss and consider them.

>> +	of_node_put(root);
>> +	if (!match || !match->data) {
>> +		 soc_data = &default_soc_data;
>> +		 dev_dbg(rdev, "no compatible SoC found at root node\n");
>> +	} else {
>> +		 soc_data = match->data;
>> +	}
>>   
> 
> 
> Best regards,
> Krzysztof


Thanks,
Pallavi

