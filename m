Return-Path: <linux-kernel+bounces-899458-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47CD5C57EE3
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 15:26:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24CB94A42BB
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 13:55:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B08B223ABAA;
	Thu, 13 Nov 2025 13:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="J+LpV72S";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="RCQrYTYs"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D8AA2356D9
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 13:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763042135; cv=none; b=BoHb/h6xcjgwT88xHtseMU75GCSM6MAgmqBTmQLrb1/ou0N7oKRJTCEmjsUFXVra8mX8wmLOdFK9Qgd1y2XtHJAhB2fU6+s+IEgpdYNZn4+8UTmi419J+HN7Wl/RpZRcWq4Lry4Wc57ZANZO9h4lodniF9Aon51t1j1gx82MlnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763042135; c=relaxed/simple;
	bh=BWyO42d1hYYLVvQCQ4tlS39gf3pek+5rN+OLpq5Jr90=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g0gxqM2gGOxCCYQAP7QDlHdkjrTp3On5raAVXQu8desigGDhkNnCe7TmWG/cv/GdzaJ7L4przXnHJP9vN5QyZb1dGWSuhqwcbsmJckKE60BnML/MGb+xGwwHo4XrPRBGzrbAzOoFP9qn8LJY0zk1SUnPizU//P80kzg3NH0FZXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=J+LpV72S; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=RCQrYTYs; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5ADBLrZN174813
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 13:55:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	PYq90gPok05Ftan3q4LlS4ySOfx7eLDR6jvQPaWFLaI=; b=J+LpV72SJATiLwN1
	sdxH62ruSbqsh8Ic+tb9+6OSbVfKojMtQ9Hy5e3qylgM3nE8Foxy+CMV7PJpRfl1
	9g469/SlTULJgYFUJ4FXrskSFLr/XCjU2JraFCHDLP+TGY0iYzHgS3LRBvGEEWAr
	ZegyHa0zEhrMAw2K6xm/0oiTYFw7++RJodiCPb7V6hWkfD8qF/zbEDCeT2xAHJNE
	Vpp530YmDV4Q/TXy1oR6ixQ6necnTQFHqsueeVhAJM4BgEIwZz+SHQhaiPEOeJIn
	MVOnfZuQF7iifHbRAVX9Cy8RdR+57iBBe+PrcffE4p6GZFYo3BmKYmkX1r7z5zi4
	P5JNXw==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4aded1recb-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 13:55:33 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-297f8a2ba9eso21420955ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 05:55:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1763042133; x=1763646933; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PYq90gPok05Ftan3q4LlS4ySOfx7eLDR6jvQPaWFLaI=;
        b=RCQrYTYsxZpD7gJp/9oVQQUq8g4cwqcxuRjNbWPpkYMupv8goAxjwv6fgXO6OhFSOS
         Fv+oJ5Ey3L/NYeZKgm4PLVshEoPfb+NIFNUOSxj7onyYSwB+9RduFA1b/GddH1gj1HIv
         7qfupg2dfPJ/QiCqeTGd/z+DHNguaP6UnKNvUcUia+v0umaqKE58IKZx9ZdISoWKno8+
         g1zZ9xDJ6iV81t3vA2cCPieGtsq+pSLSUCyOhXU4/3jn3pP+urRRIuQznDFcCrOWTa9O
         mR9Xh1LByH4UqgoB5BAGVUvFhe7J7m40MvpgrIWIrw/FyskxfitDNl6OxdYLhShIJE6v
         5H+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763042133; x=1763646933;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PYq90gPok05Ftan3q4LlS4ySOfx7eLDR6jvQPaWFLaI=;
        b=nWoBiqdsM+w2sHG1+VrJR2Bcuq/88TOk2lCKSlpowMWJY63TekhDyixn5C5CmI58G4
         DRt9mFEyCaSmZFGS2ZDc6Rm0+PNp3NNZhv8dOlZ8/Yq0v23ZYDuQ2CS5o8EKP2aWh17z
         YpfPoljkPR3znLsk84BjCPKYt1aF+v7wbhNpUie5Kr+I/OysWyc5ku7UrdSQnqREeQiS
         oxA5oaX3Ov18ME1QpzkmUoONjWFg+M1vq1kosYUPpWMRhtSGRraa+OGXoGOIh0ElgP43
         ZUmuzrRXcA5igpta+1/6B5csIJ2VnvxBtST5AIinq9WAsj3mlzOiDbRPSe+YXeHCrNI2
         7wsw==
X-Forwarded-Encrypted: i=1; AJvYcCUUCf3NHOsaPenTsgHY9JEhwe8N3GfPulY93lFuY+s2M9xa0CuYY1NlsAFiJgESzKQjsp+gvfakVwibRPc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5ouTdTsO2crrDZbciRHiEdl7QiZFvlnIB32CwEK9l3VWyL74i
	r/zOT3WvNiucUzTDdNUN55mW4Dzo4P0eaLf8nSohwQxtiyk9hfkRQ+hG7ERSO69S+sXycZ66Qi6
	bkjfcmpSaM6GM0xZi9/W7SouiOWx0MrhY0q1YCAY3PvsSTfAGdxJcBJbiVZsVsc60g94=
X-Gm-Gg: ASbGncuVHLT14HbFEdiJA1coKyiESABxpscsrmVv71At4yksEDlw5ZPaT3NRELY6W83
	9mn4AU14MA1tInOhWmoMwFtTR7HEjIo7EyprV1+4+0OxGnx2owsus/X3vPAuno2YzrsDw6TeDl1
	LFjF/eZjfxfSn7No+vv2qhWFsVP+WKiFq02DsLjXMbrgh69yicSoYh+AGsZnnOXYhaef+lxMwtr
	i8oMxhVUpaSWIQXG23Ke1J/d4xE4wki3tEgJrVyq2Gxkozjn0UeVhreK1pFpM7CdPiz0+wciIbG
	HNd3Swl6QxJxg+nb8DTyowa/cG+TJfugQ4TjLfSZa30Ed0n6Owor5156zUyWBcJyNVRycKenXwd
	kgxY5njZXOylnJPLdgXG2y0HL9z0/
X-Received: by 2002:a17:902:d583:b0:295:592e:7633 with SMTP id d9443c01a7336-2984eda9ademr94497455ad.29.1763042131812;
        Thu, 13 Nov 2025 05:55:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHT1ffqRPXlTOuOE+KE3Wz2kdPEseeGi4tLYYplf2iHM7EojlOZXfQ+bTEJ192e9zzGd1U2mQ==
X-Received: by 2002:a17:902:d583:b0:295:592e:7633 with SMTP id d9443c01a7336-2984eda9ademr94496775ad.29.1763042131113;
        Thu, 13 Nov 2025 05:55:31 -0800 (PST)
Received: from [192.168.1.5] ([106.212.255.55])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2985c245fa1sm26803425ad.36.2025.11.13.05.55.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Nov 2025 05:55:30 -0800 (PST)
Message-ID: <1db3d7f5-0cdf-449c-bbc3-dc40c89ab27f@oss.qualcomm.com>
Date: Thu, 13 Nov 2025 19:25:22 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v18 0/5] iommu/arm-smmu: introduction of ACTLR
 implementation for Qualcomm SoCs
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>,
        Enric Balletbo i Serra <eballetb@redhat.com>
Cc: robdclark@gmail.com, will@kernel.org, robin.murphy@arm.com,
        joro@8bytes.org, jgg@ziepe.ca, jsnitsel@redhat.com, robh@kernel.org,
        krzysztof.kozlowski@linaro.org, quic_c_gdjako@quicinc.com,
        dmitry.baryshkov@linaro.org, iommu@lists.linux.dev,
        linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Maxime Ripard <mripard@kernel.org>,
        Eric Chanudet <echanude@redhat.com>
References: <20241212151402.159102-1-quic_bibekkum@quicinc.com>
 <CALE0LRupg93WsBVc62Lqt-T9qmK5MdEYoScxyP7=ttKJYXAsUA@mail.gmail.com>
 <33826089-54b5-47bc-8a5b-6004c7a276b8@oss.qualcomm.com>
 <5a1aaf4a-c5d5-42e1-9044-d12a6c231904@oss.qualcomm.com>
Content-Language: en-US
From: Charan Teja Kalla <charan.kalla@oss.qualcomm.com>
In-Reply-To: <5a1aaf4a-c5d5-42e1-9044-d12a6c231904@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 8tDJhcQLvdcbI6ujITfRM3ySvakFx32b
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEzMDEwNiBTYWx0ZWRfX3gIOa3ytoRyp
 6DBFCMGNAr0cHDB3oUA18DMxdVLxs9pB5gVXdQQcFRSnGDzEvF1CVGA546nRCPYCWKw0yeFxu9k
 0GB/qKPSAHv0GbBB+8X4mGxLd6pb9tdhg+U8ePGz3EiIWrTH/f99WnvJn+rdS/0++w5cKXE+XTB
 OdlzaA0n66/2Em4MPJdH4mmRBlMhP1JNAUamqZA0mKcTORVMd/S9UuMsxcEZDhXB3Ws80InQ4E+
 Bkxog+aHqwj3PBv7cQUvTJKxfc+cL3BsgmUbzd6zee2Vl/MbvGyqssL45eZ9qg1qXqqJrwJxMtc
 ziChIFR7k7tquiCol++l6jY2WEgUlw4t8D5VMI/jmX0WlOXVbteNIly7C/+uD0CanXwERtQPPyE
 uqZfzCqUUJjmb7ZqqHPXQZtfTlg5mw==
X-Authority-Analysis: v=2.4 cv=StudKfO0 c=1 sm=1 tr=0 ts=6915e355 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=pJoDNl42m32kJ7anCML+mQ==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=UTFmerWDhw6whTtWHmAA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-GUID: 8tDJhcQLvdcbI6ujITfRM3ySvakFx32b
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-13_02,2025-11-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 phishscore=0 lowpriorityscore=0 clxscore=1015 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511130106



On 11/12/2025 7:04 PM, Konrad Dybcio wrote:
>> Hi Eric,
>>
>> If a device has multiple SIDs, all serving the same functionality and grouped under the same "iommus" field, for example:
>>
>> iommus = <&apps_smmu, 0x2141, 0x0>,
>>           <&apps_smmu, 0x25c1, 0x0>,
>>           <&apps_smmu, 0x2161, 0x0>;
>>
>> In this case, all the SIDs will be associated with the same context bank. Even if the three SIDs have different ACTLR settings, since SMMU_CB_ACTLR is per CB setting, all SIDs attached to that bank will share the same ACTLR configuration. This is why we designed it to be "per device / per compatible".
> Does that suggest the settings may be slightly suboptimal?
> 
Or it is limitation to use the ACTLR?

> There's some work being done to allow more granular association of
> the passed SIDs:
> 
> https://lore.kernel.org/linux-arm-msm/20250928171718.436440-1-
> charan.kalla@oss.qualcomm.com/
Sorry, I am unable to link this limitation for actlr setting with the
work. Can you elaborate please?

IIUC, unless the SIDs are totally separated per actlr settings and
attached to CB(which are limited), this can't be achieved...but may be a
question here to check is it really a __valid__ to associate a different
actlr settings SID to use the same CB?


