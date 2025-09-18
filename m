Return-Path: <linux-kernel+bounces-821581-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C7EC2B81ADB
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 21:48:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 81A584A4038
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 19:48:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DFBA1F5820;
	Wed, 17 Sep 2025 19:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="NDm0EghQ"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F92B21C194
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 19:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758138467; cv=none; b=njd9vgoDRUMsTskivwd12pp1JmIREOHNO9VX3vBFRKclJCjHCBxPy+6u5LOUi7mI4qG8phTj9UiBsQ1euHRYX/QqSZofkarGX0GqeBOACKRZOPhDtAdUsKc2UjGIQDjOBz0IAFutiQOmlPo5lANlmVABHZLilgsHOYg9vv4CEnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758138467; c=relaxed/simple;
	bh=bxHb+mQJcEYN1HEXR5lcohnZkE2ushFT8WvhP2W65ME=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jpvVIFG4mFjYtLRbGYsm+MNfls28Vioyw/U930hDzZNYbfOpgnxoN0hoGj1HwVXGyvvq1C37iyXkyiAODs7w0wzpAPwYAdkwI25UzWmYaeNzE+qW8cBNDtfep0nd9v4ajaa/GPALVys1j56Z2xU1R8cd5Zehfcxo3Z5PI/fLYqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NDm0EghQ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58HIaPHx017934
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 19:47:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	WkWEcJwxNtLFoKpgzSr+cNSJHkqgJIHGuI7Rcw4gfLk=; b=NDm0EghQvQiYmlTM
	k/b1FwfJRVlSWfMYbcycE2uKZ3F9dh03cwQE1ZmabIhdORq0q/hG+4hUyreI6g0r
	I/CR/toOcGCHvp1vKZXwOY078kkerWWakzkVeQ2fcQF4eM/RBamr0D8NXfNbgSgf
	FH2n81TjuGMrIsoCSU6ChO3i4Pud4JWslXuS6bVPozAmRGYayE/ES7PxBPh0GXsP
	R2gBl0c7CI2OUhtj6Ybj1CR8h9v86gHkUV6mEjIeQrHtc2sRW9NmpGVCaI2Oh4s6
	xgu5gy+s0GpSpaV8gI1Ii56IAKy2ohSh8CZhn0HMCTUuAGN6QIi+4jEc7HNZT0+G
	t9rrWQ==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4982de85gw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 19:47:44 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-b4d48818a04so101385a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 12:47:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758138463; x=1758743263;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WkWEcJwxNtLFoKpgzSr+cNSJHkqgJIHGuI7Rcw4gfLk=;
        b=QhO+mB8t867L/zVtOuj59GsuSKtrkqZykgDu7rN3b7wRGaAej5ObuLGEM2ofAUmRMR
         x3aC4YRSFSJXHWXpwES1ljprJMbtxHVr9WRwagbG7QUUj+lOPKxdDtfud7NZK4ExlpPE
         0oaq7agfB61zn0F1Nr5rKUhYXiTbOQRwPufUuIeRxAuiZ2n5LpdCCpOoNoQHlnOHEhCe
         I7bdhodua74mUWXY4OdkGr61YyYElM0Oootw1DaU0261TXiM8KYfp5BR+y/9cebSS2YW
         nSdORuJFkJcx7Xbp6u9E5QArZSM87ZgEd3P41P3LNIbkwbr6utC+p/3FJZKuxroG1Lgg
         fUHA==
X-Forwarded-Encrypted: i=1; AJvYcCXmD6Qdtfw1Ez8KNJlZjWfSwFIXZj+llTrwWXsiJSWy9YxgpJg/xN0p4ts0LEXwek/uTHYBrKo+zUw3tjM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4Czda5QBton8x6a3vt5eyycZChGQWPHGhb6UIF8nmKodJx1uC
	PnBbuVGbiu2ZKPkKYTeqVjgJEmHo4nmK2OXIa/qcMyuodzrWmfl3Q6+PvtkDwTudvb1Va1fj9Ur
	TukIytrWd0Xf/JKRkSqDBBB3vkrJJ1ynZRnz9fsuLbQHMC7H1C4j9YD3JMBt1VMHzSSc=
X-Gm-Gg: ASbGncubYV1cVvAWND2Ge1EElLmtw1kskY3TlvjtSbsqGma+q0u9l8dGAdzpkS9qFF9
	BWAes4QfUN4ytrX2gX5875l1M/8sLWzmFGpeYcgmrSxKSAFCa3st9IcrGBRtqmqyTRhn0snN07S
	PsoFzOWhA/1/xpecpoY4Au+UMcMllZSelFgkmIXZKLvoKih3HizNMms5NMAOkTmyLmTgbt7+34c
	6fAsxNdp/5vCIauHqpyv/HFx9ANbhTq15jTcskiGszxLsDCyjSLFdRDLWCdW6e31uyrIlKcngbv
	/P/3N3+lZ0Vd40XdUQt80YwCwUQOdDA4izrnAJhKuWCBKW7bTON/Q+M7DDUX0R+5Ym6PXM0=
X-Received: by 2002:a17:90b:5788:b0:32d:dffc:7ad6 with SMTP id 98e67ed59e1d1-32ee3f8c588mr4286889a91.33.1758138463145;
        Wed, 17 Sep 2025 12:47:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFjiteAoD9cK/bN/ETaRodNHrRIWIEDt3HvpK3XaXv5ZIiOHuqKosTaZcxNGnpqJN5t22Zbpg==
X-Received: by 2002:a17:90b:5788:b0:32d:dffc:7ad6 with SMTP id 98e67ed59e1d1-32ee3f8c588mr4286845a91.33.1758138462681;
        Wed, 17 Sep 2025 12:47:42 -0700 (PDT)
Received: from [10.216.40.15] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77cfc24b4f6sm215021b3a.37.2025.09.17.12.47.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Sep 2025 12:47:42 -0700 (PDT)
Message-ID: <f420c40f-f2a5-4b64-8e89-dfc6db042edc@oss.qualcomm.com>
Date: Thu, 18 Sep 2025 01:17:30 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V7 4/5] iio: adc: Add support for QCOM PMIC5 Gen3 ADC
To: Jonathan Cameron <jic23@kernel.org>
Cc: robh@kernel.org, krzysztof.kozlowski@linaro.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, agross@kernel.org, andersson@kernel.org,
        lumag@kernel.org, dmitry.baryshkov@oss.qualcomm.com,
        konradybcio@kernel.org, daniel.lezcano@linaro.org, sboyd@kernel.org,
        amitk@kernel.org, thara.gopinath@gmail.com, lee@kernel.org,
        rafael@kernel.org, subbaraman.narayanamurthy@oss.qualcomm.com,
        david.collins@oss.qualcomm.com, anjelique.melendez@oss.qualcomm.com,
        kamal.wadhwa@oss.qualcomm.com, rui.zhang@intel.com,
        lukasz.luba@arm.com, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        cros-qcom-dts-watchers@chromium.org, quic_kotarake@quicinc.com,
        neil.armstrong@linaro.org, stephan.gerhold@linaro.org
References: <20250826083657.4005727-1-jishnu.prakash@oss.qualcomm.com>
 <20250826083657.4005727-5-jishnu.prakash@oss.qualcomm.com>
 <20250830184233.7ddf6ae8@jic23-huawei>
Content-Language: en-US
From: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
In-Reply-To: <20250830184233.7ddf6ae8@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=YfO95xRf c=1 sm=1 tr=0 ts=68cb1060 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=UEldCo81gXLG25mkEUsA:9
 a=QEXdDO2ut3YA:10 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-GUID: yvqCjcS2efuXyDqPnGFQSkhuJictJBUG
X-Proofpoint-ORIG-GUID: yvqCjcS2efuXyDqPnGFQSkhuJictJBUG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE3MDE4MiBTYWx0ZWRfXyZ9SbfUqoE6K
 f0yZHsTvyjJK4Jw1/WbLzDa3uToDT4He7XLzrXyGpDYjsx/o7dbWex3lo34yHrTbVzfvVoCoqVd
 I8GP2mA8kiuX5t/58wwplWm6X0/VP9a06r2rILczIwx10U4nyxVDNhionvt+7CvOvknULmTol2i
 sCzD6zRh1t17GhF2IvqRgqIwZpb5atM3lY3XtUJou9Ox4bgTUqJLitKx//nUjCT/xiBnxrw7yL7
 MBw1DTewU1YSYTgdY5azZCCQ2wKVgVJytfwrxFEJ3yz6C6BJGMhpWmPENaycV6ilc5AJJSAx0mK
 Wax/MJeJbBn5o9RiT3I8bCpwykHsxtyvJQ+tIMEfe3zwhoaUeJw7/cF1xT9kRtxwkFazBb07Ef/
 7NbLBUMX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-17_01,2025-09-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 suspectscore=0 clxscore=1015 priorityscore=1501
 spamscore=0 phishscore=0 malwarescore=0 bulkscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509170182

Hi Jonathan,

On 8/30/2025 11:12 PM, Jonathan Cameron wrote:
> On Tue, 26 Aug 2025 14:06:56 +0530
> Jishnu Prakash <jishnu.prakash@oss.qualcomm.com> wrote:
> 
>> The ADC architecture on PMIC5 Gen3 is similar to that on PMIC5 Gen2,
>> with all SW communication to ADC going through PMK8550 which
>> communicates with other PMICs through PBS.
>>
>> One major difference is that the register interface used here is that
>> of an SDAM (Shared Direct Access Memory) peripheral present on PMK8550.
>> There may be more than one SDAM used for ADC5 Gen3 and each has eight
>> channels, which may be used for either immediate reads (same functionality
>> as previous PMIC5 and PMIC5 Gen2 ADC peripherals) or recurring measurements
>> (same as ADC_TM functionality).
>>
>> By convention, we reserve the first channel of the first SDAM for all
>> immediate reads and use the remaining channels across all SDAMs for
>> ADC_TM monitoring functionality.
>>
>> Add support for PMIC5 Gen3 ADC driver for immediate read functionality.
>> ADC_TM is implemented as an auxiliary thermal driver under this ADC
>> driver.
>>
>> Signed-off-by: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
> 
> Hi Jishnu,
> 
> A few additional comments from a fresh read through.
> 
> Thanks,
> 
> Jonathan
> 

....

>> +
>> +static int adc5_gen3_get_fw_channel_data(struct adc5_chip *adc,
>> +					 struct adc5_channel_prop *prop,
>> +					 struct fwnode_handle *fwnode)
>> +{
>> +	const char *name = fwnode_get_name(fwnode);
>> +	const struct adc5_data *data = adc->data;
>> +	u32 chan, value, varr[2], sid = 0;
> 
> Why initialize sid?

I think this is not needed, I'll remove it.
I'll also address all your other comments in the next patch series.

Thanks,
Jishnu

> 
>> +	struct device *dev = adc->dev;
>> +	const char *channel_name;
>> +	int ret;
>> +
>> +	ret = fwnode_property_read_u32(fwnode, "reg", &chan);
>> +	if (ret < 0)
>> +		return dev_err_probe(dev, ret, "invalid channel number %s\n",
>> +				     name);
>> +
>> +	/*
>> +	 * Value read from "reg" is virtual channel number
>> +	 * virtual channel number = sid << 8 | channel number
>> +	 */
>> +	sid = FIELD_GET(ADC5_GEN3_VIRTUAL_SID_MASK, chan);
>> +	chan = FIELD_GET(ADC5_GEN3_CHANNEL_MASK, chan);
> 
>> +	return 0;
>> +}
> 


