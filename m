Return-Path: <linux-kernel+bounces-821582-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 73959B81AE1
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 21:48:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 277674A40A7
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 19:48:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49B18261B97;
	Wed, 17 Sep 2025 19:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GpD6o0Yw"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24C8418D656
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 19:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758138493; cv=none; b=atedDBAZ29f8GT99qfiBT4ddFe14xbEoVktoSbBV6s0CT4UuxSnkBRShYoFh+Z7eswUd6SDizPo0sHaTOcjTmq/E6WRI1zl24eGfK8Wsk9l8MPPnZzLcAtlDIxN2rCVIehTAZqjLjED6Aiyks8xiLCGFAa0rG4bFiQpFTzHDZqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758138493; c=relaxed/simple;
	bh=gc4XDbpi/SHiw+dIuM7XRaag8prdni7GHABTYWIpL6w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oegCOotCNWfbuDRTnCev9Gx0znkVRPoMcwV7+8fX//HDbak/LbH4yN2W+KmD3hpLnCn5T0Ncs29jdTuiJN6EL8RG1qzq/PLs3Tq0nj1hqmZh8hJVY9Y/ZUt+eJkD6rOLyVhL9JrIzDOaQZCEvfRIyWA+jZiFVOC21Z4giOsX5QA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GpD6o0Yw; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58HGJ4d7026798
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 19:48:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	jGYCeRo2Nm2iHZbBrOloUMVIcfNZlQpAwgAkvYACT7Q=; b=GpD6o0YwTSxSy0Kp
	04CweAao7LR1ZHrx1wCp8sY5Upn/Pzu3m8eb59eHCO0wr16aN+J5Fzvw/1yJNn5z
	sttNHbvb8I39/pBW1nbVJ4ymqDFODZIhD7wL7Kq9WStjHIHYcNtU4fJRsKm+62Vs
	H9LVkhTmZc8JzRsMT5Hu1k+J/qjmQKsLfnSvKsflWug0TP7r8DFnYGKwQcK+Va8r
	TJtfNcm8wuNVEtlJuPzjj/wO+m7F2AUCaOFXHXmYogr36Mvpb7jlPMRIazSdFqM/
	jYNja76a7NWsTxxhO0cnlJ8iQMo6B65f3qFaWjQHxJZ4SrOK/Y9/5ijPTMmL39zi
	Uh/gmg==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 497fxt3pns-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 19:48:11 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-32e0b001505so123141a91.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 12:48:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758138491; x=1758743291;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jGYCeRo2Nm2iHZbBrOloUMVIcfNZlQpAwgAkvYACT7Q=;
        b=nBaeAb6ty6Pt1DFN9u00AambnorVf+QhJshvF44SDTBBuwKmmWsiYuAS0oio9FwxT/
         MVqoe3AXmDCzRzZ8TSrrGOXsAw+m3OwBNlUwTIYAh6SQMzIuH2x62Y2CfAZjBqfja6/A
         7FTGCb0zg+QDgmKb0Fy1kj3/fV2BDcZ4Th635R4+x2vyG9A38FdQ1VVU+JbvEnNeVDAU
         UYsNhNntqSgSNy2PL2h96Uvcj7aqhMk4I+7tA7oTe/iSHGgd0Q/tvBzKIdAPUIPqssrr
         t4hViMK3HLJtY+XwgJTehHV9coSa8GGqPGWPhx00DpmMIUKIzITAgGS9Y0wUxvpASZVn
         OxqA==
X-Forwarded-Encrypted: i=1; AJvYcCU02Noriss1nAvZWOrEIGOH3k5miMH1HOM5KlBf7/gMdwK79eb/Ks2nw7PBV+3DM/t2CB0PQmMuUBDJrdY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyM8O3BkWxl547JHXsVrYVtS9BS/5VZasRoomASNATngic0CK4Z
	jFYtNTSZ9PMUYozzt8sQsmqKQ4OwUkhk+vnyJ1W9GunVg+X1BEn4ZJqC3KFHiQ12fLIjfLTCHYq
	DHoKKuOwczU/7MR2/VR+HwrDeRRik4uR1VCzRjsOd/UO65lhw9Irf8n2ZzaoT4k0+MdQ=
X-Gm-Gg: ASbGncvVpidI876nhOiwba2IofKcFUlpZY/iX+bWVKHCfjwP8SiBNxAdMaJUBMi22W/
	XUTUJiH4DZNsJbR5iTSEj1X/PDk9xYY1vCjjw0pOdBPvXq8w76NU2GDIwGWE96u+iUfUwDJEDgf
	KWMFUEkY4iIn0TQGCiwAwcO2K1QZGJl2Xux4N3CW0TVqneYIl5QQwEWqaqyo+1DZLBRLVHhmkey
	5liZsJXYJjrJX2VnjVsnCJqMBIgaMdsr7GBlYzeUpJIW+l7K4fQvi3WK82n74j/dHkNO3nxoJcu
	THHnVYNVjhKI8jqW819vwe2rovNfYy7DLsNCSv6cNX1k+ebF5rCBWWSKdLe36MdUDUDCZrc=
X-Received: by 2002:a17:90b:1f84:b0:32e:64ca:e84e with SMTP id 98e67ed59e1d1-32ee3ef7071mr4546607a91.15.1758138490208;
        Wed, 17 Sep 2025 12:48:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFNUj9iiTkIiBdyuwHV1qhUP3oLhWgJBvCsq76MF3fHoniGNQ6FCUfXLye/WwI6WYVKAKakdA==
X-Received: by 2002:a17:90b:1f84:b0:32e:64ca:e84e with SMTP id 98e67ed59e1d1-32ee3ef7071mr4546578a91.15.1758138489768;
        Wed, 17 Sep 2025 12:48:09 -0700 (PDT)
Received: from [10.216.40.15] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77cfec3f454sm199284b3a.75.2025.09.17.12.47.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Sep 2025 12:48:09 -0700 (PDT)
Message-ID: <47f7a917-3bb6-4331-8813-49f6646333e5@oss.qualcomm.com>
Date: Thu, 18 Sep 2025 01:17:58 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V7 5/5] thermal: qcom: add support for PMIC5 Gen3 ADC
 thermal monitoring
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
 <20250826083657.4005727-6-jishnu.prakash@oss.qualcomm.com>
 <20250830185809.5bc010cb@jic23-huawei>
Content-Language: en-US
From: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
In-Reply-To: <20250830185809.5bc010cb@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: wP04h9CBPp_i6XIUOk7PuVAsmqIoHBaW
X-Authority-Analysis: v=2.4 cv=bIMWIO+Z c=1 sm=1 tr=0 ts=68cb107b cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=-qQjPGFekNv0xv3-IhUA:9
 a=QEXdDO2ut3YA:10 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwMiBTYWx0ZWRfX3FIPBL5yQxE+
 y5CyW0kC2Jb3lzx1OYa+W09bQEUuVeMcq4poDERByDJcy/YXIBM59Q5eZAvma9Z0LujT89bYzyr
 aef9munB+Rz8Xch3ZZg+/CefFu6/HkKHNSnZDkV96LH7QDw0MmSaaHV5aRf+pPS0aD6KLOMdAVI
 C8rhAghken7IBSGv0qfXPoqZT7ThvtjnXMFPdDmkssfT1Jl6dm9gvAbDX6AeINMWWXfSWVpPKAi
 IQZOdPQagqcgQZNR2IVWPcoeEIsh4iBDbd7jTuZTA87bL/nZfZVQasX5SFqb18OQLdcjSXzy+gQ
 AnA8UAOFYpTTwtI+jCd3A2fOggPlX0TpLatAAj0QYH48N4quJ4FMNOm6Xix500Snw+wcxNoSPJq
 m7cIS7+J
X-Proofpoint-ORIG-GUID: wP04h9CBPp_i6XIUOk7PuVAsmqIoHBaW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-17_01,2025-09-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 malwarescore=0 adultscore=0 priorityscore=1501
 suspectscore=0 spamscore=0 bulkscore=0 phishscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509160202

Hi Jonathan,

On 8/30/2025 11:28 PM, Jonathan Cameron wrote:
> On Tue, 26 Aug 2025 14:06:57 +0530
> Jishnu Prakash <jishnu.prakash@oss.qualcomm.com> wrote:
> 
>> Add support for ADC_TM part of PMIC5 Gen3.
>>
>> This is an auxiliary driver under the Gen3 ADC driver, which implements the
>> threshold setting and interrupt generating functionalities of QCOM ADC_TM
>> drivers, used to support thermal trip points.
>>
>> Signed-off-by: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
> Hi Jishnu,
> 
> A few comment inline from a fresh read
> 
> Jonathan
> 
> 

...

>> +
>> +	adc_tm5->dev = dev;
>> +	adc_tm5->dev_data = aux_dev_wrapper->dev_data;
>> +	adc_tm5->nchannels = aux_dev_wrapper->n_tm_channels;
>> +	adc_tm5->chan_props = devm_kcalloc(dev, aux_dev_wrapper->n_tm_channels,
>> +					   sizeof(*adc_tm5->chan_props), GFP_KERNEL);
>> +	if (!adc_tm5->chan_props)
>> +		return -ENOMEM;
>> +
>> +	for (i = 0; i < adc_tm5->nchannels; i++) {
>> +		adc_tm5->chan_props[i].common_props = aux_dev_wrapper->tm_props[i];
>> +		adc_tm5->chan_props[i].timer = MEAS_INT_1S;
>> +		adc_tm5->chan_props[i].sdam_index = (i + 1) / 8;
>> +		adc_tm5->chan_props[i].tm_chan_index = (i + 1) % 8;
>> +		adc_tm5->chan_props[i].chip = adc_tm5;
>> +	}
>> +
>> +	ret = devm_add_action_or_reset(dev, adc5_gen3_disable, adc_tm5);
> 
> I'd normally expect a pairing of a devm action with whatever it is undoing.
> If not add a comment for why that isn't the case here.

This is meant to disable all ADC_TM channels in case of a probe failure.

But thinking more on it, ADC_TM channels could be enabled only by the thermal
framework calling the .set_trip function and that could happen only after
this line at the end of the probe, for thermal framework registration:

        return adc_tm5_register_tzd(adc_tm5);

So I think it makes more sense to move this call to near the end of the probe
and to make it devm_add_action() instead of devm_add_action_or_reset(). I'll
also add a comment mentioning what it does.

I'll also address all your other comments in the next patch series.

Thanks,
Jishnu

> 
>> +	if (ret)
>> +		return ret;
>> +
>> +	INIT_WORK(&adc_tm5->tm_handler_work, tm_handler_work);
> 
>> +}
>> +
>> +static const struct auxiliary_device_id adctm5_auxiliary_id_table[] = {
>> +	{ .name = "qcom_spmi_adc5_gen3.adc5_tm_gen3", },
>> +	{}
> 
> For IIO drivers I'm trying to slowly standardize some formatting choices.
> For these I picked (for no particular reason)
> 	{ }
> 
>> +};


