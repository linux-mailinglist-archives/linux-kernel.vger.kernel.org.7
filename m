Return-Path: <linux-kernel+bounces-886102-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 53773C34B7E
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 10:14:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 640B41887D99
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 09:13:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28C212FB619;
	Wed,  5 Nov 2025 09:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YltbPON3";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="IejCqM7+"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6050B2FB0B5
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 09:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762333936; cv=none; b=I13zDlf7RxBm8HS6JXXhUutZrxikevWiMN4TWsprozDiGxCpDJnRK7ew7WLyfkbbUFfZKS86ReuZV88TavrvDYUfujJJM0bqBi0QjY7pf2g246UMf/klJDLSXg1BBPqi2Abc4Vxs2zqBwqNY/fmup6QAvXy0s8KDjl+d0fTE0PM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762333936; c=relaxed/simple;
	bh=rhJnISfruwgCtMzDAp2gVfMmqk8wOwH4w/JXlP7TUAg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f7WZVxrXbp8qfpm5CuRHY3p8Hl/LZekgsn4rMoBsvAA+UCt14pqGz/i1Sq4RKxWDf9xR4YuJhQBDVz+wR6gu2VF0odl3hYeV1C9cjMH5p+Vr6AbQUQXCQsHYO7oyKYjjM5bfjQMukPpArSeZttf1uaOoZ6hP3Qf330CvZ6fkQEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YltbPON3; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=IejCqM7+; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A58K3XC3164678
	for <linux-kernel@vger.kernel.org>; Wed, 5 Nov 2025 09:12:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Z+6KNSa/c84U6Pn9MoZGbo7B95YVHxLE9mFgR/bY4NE=; b=YltbPON3Kb5XGvfB
	AGfZh7VVPxBzKSx9NquvfafRy7kuzVRXWu0MAHYXLNazg7kAnE8MHJzpj7Wjv0yt
	lgJ0diI5FVyzvJch2XxqtzCJftkY2tQDBjnctzNLepvQZVWnivMcDx7nUdeFvb70
	bedjeeHi65EhOBE3Ek/hQru+qrpe95TcXQeN9LN9x2DDPDfYe++Kd4hBK9AFZnuP
	5qPsJUG++c4KtGgTE2Hc04blCojlNUHGEkN+85LzOLB5O5sc6vN01QumcYgcP9uq
	V9pgYmNYg720QDg58Ogd2S+Emy4c8X/RFKgmyejkpb/ENWqLUJZFT4MDOrPH8Qn0
	gojqHQ==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a7ketk1qf-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 09:12:12 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-8b22253132cso24593285a.3
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 01:12:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762333931; x=1762938731; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Z+6KNSa/c84U6Pn9MoZGbo7B95YVHxLE9mFgR/bY4NE=;
        b=IejCqM7+oxC3TO/ySi0+13z26VXc9WOdhvM2KVrdpbIezQxl2wxwuXDlBaMQJCtoMt
         2BnOKFAgGKSkdlqRUWCBmFF1l4KSZjJX4+6x5SZWnyUVHqPptXf2NlZVdzKQSNIm9ARy
         pqpAUrul8QYX8z+m4LGp+5p/MuFLhhk6MLE6GDk+Vz5br1FpKeK0XbTp3A5U+19s+PZA
         jrhRaQpCUay+TssRzZBetn322fGZjltgsp6UZ2ns5NEQSIbPy2E7n6PF1hHvK1HapLy7
         MeJL/Lj5A8KHZGJU5WOPZM6M0qWRGVgCxLJvLygaXWKa6XJHhuzoSf+m9b6z8wU3NG9k
         /hdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762333931; x=1762938731;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z+6KNSa/c84U6Pn9MoZGbo7B95YVHxLE9mFgR/bY4NE=;
        b=XyUczplRRwQPP2xHzJ26rx9mFJgTzcBU0L98msz3urzVQ+Y35y9OOR1Ra1BCm+zRiV
         fKUQgZLlw5P8NgU2kPhPBR4xWy5fjKrfmzBFcpjMXljlP85PZfUMbdzsP7nWcbf5U9u+
         h2Z8p7A1C1Ct3qxS0oCgJRx439wYp96cctNc+IGbV40hUOHy7yDOcUbRuzD/dMpcU3Et
         o+CxV+2xyHrHpBwjKcbGPD+pLPuBCPjJXCyAQMDQyjBYDpDaBPnOoRLhdUD6XR6rRJqD
         6SFFKy/5KZkNHYSvJB6Mz9FQOdFI6mGgMlmHA814L7/2x0cCr3MdKmgJiMGNFfg/hJG4
         MfFw==
X-Forwarded-Encrypted: i=1; AJvYcCW3V2y1Hw2Xtd4umHD2OOv9YbQtt+bkd6hxcgtmIS9HfpeOKWWZX58UX0vLUch4RBJIPZlqM/qM0QHjcUU=@vger.kernel.org
X-Gm-Message-State: AOJu0YypZinEfjh2V+4/y+wJJsgdpS9jTcpWJLrz/efPpN6kXlYv2qWI
	4FHmr/tfs/YPwC7fYmHnlM6q4cJdJfWUKfcxV7nr7EgKAomq2848Gmz24ius8p5HeBXGFE0y9kY
	APcT0Ra6B+NMn0zhrZsZlwAI1Ut+Z7573pMayk/kzN7JJDeUb+qxn8aucV1XubzDmfp0=
X-Gm-Gg: ASbGncsTqzEyndqU3LouO1qfYyr81DOcjrFeJVbQ5v0fZU8HM4Qmd7VJ4OYr5IxC3jI
	YZgEQunEUxcj8FBVc32JSMaPabFn3E1u4q182WO1bkYLcteUA0mf4xADv1O+DmWDmJ04TPA2rC9
	ULIIXbj3+/yNOb1/xb0RubtZVwi2+DdOqpfCRP5IfjbiErItJt0TN5WHJsVoEvEpKllPhGRnZ1I
	LBUrhCBGEYghV+89c1gIrCSbOc7XBfiuh0lusEmQu5E1D/ISC3QmRApbbRn6DRAyVhctw75BVuL
	JMXSGoUZECy4vzCQf50Xxfx8B3y478n8f5lZxwvU8pT4KinYwKotuXaXIcu+sT24g45i1Z5wTe7
	HD3GptP+v6oZRPtoKkJ9HI5GUG/gKsIUxrSdkYxiE2iLy95GBwkviDq7a
X-Received: by 2002:a05:620a:4416:b0:8a1:a5c5:ef18 with SMTP id af79cd13be357-8b220b1d713mr213872385a.7.1762333931444;
        Wed, 05 Nov 2025 01:12:11 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEGJ9wkyXw8sJ2xb7871IJGD1FzGWrKC1uMfjebX8VCApHvBSwyXgL4BOJndaBNFQvahb8afg==
X-Received: by 2002:a05:620a:4416:b0:8a1:a5c5:ef18 with SMTP id af79cd13be357-8b220b1d713mr213871085a.7.1762333930898;
        Wed, 05 Nov 2025 01:12:10 -0800 (PST)
Received: from [192.168.119.202] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b72406568a2sm430577166b.73.2025.11.05.01.12.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Nov 2025 01:12:10 -0800 (PST)
Message-ID: <cb1ced66-8190-4462-99cf-72ec51da6536@oss.qualcomm.com>
Date: Wed, 5 Nov 2025 10:12:08 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/1] cpufreq: qcom-nvmem: add compatible fallback for
 ipq806x for no SMEM
To: Krzysztof Kozlowski <krzk@kernel.org>,
        Christian Marangi <ansuelsmth@gmail.com>,
        Ilia Lin <ilia.lin@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
References: <20251104140635.25965-1-ansuelsmth@gmail.com>
 <20251104140635.25965-2-ansuelsmth@gmail.com>
 <d3f2810f-7361-4a23-adb3-32a73ad50519@kernel.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <d3f2810f-7361-4a23-adb3-32a73ad50519@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA1MDA2OCBTYWx0ZWRfXzCdodtNVSCgS
 KGo1qb2SUbZ9vOIeyVfcYqXkbAlFj+dffWn30gk8LQ9de0/5EsPr52yQZP2WCAF4TUypDPYDAtb
 9Ska8k6pANN3A1c2R/cpkov015HLyVOVgfhfnAr/t2MxWdvB1ko338g9jAl3jR75koLUSPkHcUp
 yumRwRXRnq76aXMqkjLGD5wBzi16f3IpfuSl1rGCBDp8eQBUEaZJfg8Zal1h6nRRbeihFh4KFdx
 mDxmpsYeIrNluRg4ojE1MwEbNd1pCSZvDSWgs/2zFSoyaGoT7ovM1GbQiEUyvnrEiozWIiwXiYA
 ziIL73mWGIq9eieGhPctIIPgZuvVq/dH7jo+PAipE8j2t6Y9gZ/KH80n0sSQ9eLrXwGmqfDY1vi
 eWWvmHmGFvIbeW04UOrCUAmS0/j/KQ==
X-Proofpoint-GUID: wLFMLNXNimyua7vnrCQxwTxlle6Cl_GA
X-Authority-Analysis: v=2.4 cv=IdSKmGqa c=1 sm=1 tr=0 ts=690b14ec cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8
 a=6tCzVfzfn33JckLbtDwA:9 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-ORIG-GUID: wLFMLNXNimyua7vnrCQxwTxlle6Cl_GA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-05_03,2025-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 clxscore=1015 adultscore=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 impostorscore=0 suspectscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511050068

On 11/5/25 9:05 AM, Krzysztof Kozlowski wrote:
> On 04/11/2025 15:06, Christian Marangi wrote:
>> On some IPQ806x SoC SMEM might be not initialized by SBL. This is the
>> case for some Google devices (the OnHub family) that can't make use of
>> SMEM to detect the SoC ID.
>>
>> To handle these specific case, check if the SMEM is not initialized (by
>> checking if the qcom_smem_get_soc_id returns -ENODEV) and fallback to
>> OF machine compatible checking to identify the SoC variant.
>>
>> Suggested-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
>> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
>> ---
>>  drivers/cpufreq/qcom-cpufreq-nvmem.c | 35 ++++++++++++++++++++++++++--
>>  1 file changed, 33 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/cpufreq/qcom-cpufreq-nvmem.c b/drivers/cpufreq/qcom-cpufreq-nvmem.c
>> index 3a8ed723a23e..17c79955ff2f 100644
>> --- a/drivers/cpufreq/qcom-cpufreq-nvmem.c
>> +++ b/drivers/cpufreq/qcom-cpufreq-nvmem.c
>> @@ -252,13 +252,22 @@ static int qcom_cpufreq_krait_name_version(struct device *cpu_dev,
>>  	return ret;
>>  }
>>  
>> +static const struct of_device_id qcom_cpufreq_ipq806x_match_list[] = {
>> +	{ .compatible = "qcom,ipq8062", .data = (const void *)QCOM_ID_IPQ8062 },
>> +	{ .compatible = "qcom,ipq8064", .data = (const void *)QCOM_ID_IPQ8064 },
>> +	{ .compatible = "qcom,ipq8065", .data = (const void *)QCOM_ID_IPQ8065 },
>> +	{ .compatible = "qcom,ipq8066", .data = (const void *)QCOM_ID_IPQ8066 },
>> +	{ .compatible = "qcom,ipq8068", .data = (const void *)QCOM_ID_IPQ8068 },
>> +	{ .compatible = "qcom,ipq8069", .data = (const void *)QCOM_ID_IPQ8069 },
>> +};
>> +
>>  static int qcom_cpufreq_ipq8064_name_version(struct device *cpu_dev,
>>  					     struct nvmem_cell *speedbin_nvmem,
>>  					     char **pvs_name,
>>  					     struct qcom_cpufreq_drv *drv)
>>  {
>> +	int msm_id = -1, ret = 0;
>>  	int speed = 0, pvs = 0;
>> -	int msm_id, ret = 0;
>>  	u8 *speedbin;
>>  	size_t len;
>>  
>> @@ -275,8 +284,30 @@ static int qcom_cpufreq_ipq8064_name_version(struct device *cpu_dev,
>>  	get_krait_bin_format_a(cpu_dev, &speed, &pvs, speedbin);
>>  
>>  	ret = qcom_smem_get_soc_id(&msm_id);
>> -	if (ret)
>> +	if (ret == -ENODEV) {
>> +		const struct of_device_id *match;
>> +		struct device_node *root;
>> +
>> +		root = of_find_node_by_path("/");
>> +		if (!root) {
>> +			ret = -ENODEV;
>> +			goto exit;
>> +		}
>> +
>> +		/* Fallback to compatible match with no SMEM initialized */
>> +		match = of_match_node(qcom_cpufreq_ipq806x_match_list, root);
> 
> Aren't you re-implementing matching machine? Or actually - the socinfo
> driver? You are doing the matching of compatible into SOC ID second
> time. Just do it once - via socinfo driver.

The issue here is that if SMEM is absent, the socinfo driver can
not function and this is a contained workaround

Konrad

