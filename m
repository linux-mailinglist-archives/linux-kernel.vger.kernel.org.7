Return-Path: <linux-kernel+bounces-895708-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D90A9C4EBDD
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 16:17:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EC46E4ED113
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 15:11:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B99B35BDC9;
	Tue, 11 Nov 2025 15:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="B8DeNhzL";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dAzojFK5"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FF9B219E8
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 15:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762873864; cv=none; b=fcRWNLAUX8Rt3Own8y86vj0tBX4c9UkM9CRr94UhM+hUs+hZI5btFUxv2ojKCJwwx07VsNermPiBcPBdlcsSTxHiwnnMU1IZJ4IFz/DzAQF8wcmXUcDXSLMWy1mdK6dhg/LEcBUhqiK7cmPoDPr/5hmqfFv8OAglZMssV3vX7PE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762873864; c=relaxed/simple;
	bh=TjShl+IbqX53wJVlpQ2cBl4pqeuDhsZG859FJQZqCyU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hv6MFq3lgPqP6MOyw5htEtpexdS/6N4+8sLzeLoFZaocJRFQFHynyI4xz5IlqGxHAV9AUydUQx89dmkK2kboWDDAE4P6+9iw7WMl2K0ZfDl20nWvoVmd2CMlk5Nn3/JGBXhpNcPQzZUXe7qQxA7fkuVF97JdLPgpLgFrfRWXIpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=B8DeNhzL; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=dAzojFK5; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5ABCm9MZ2540374
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 15:11:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	NtWhBlV0ZGLBZySq8b2IGhCN1uzwyRzojwI9hN8eLNE=; b=B8DeNhzLRR4TLQlS
	pZkxFgPSE1kjPcDSeJ9xSSRkLax9QEp6yF2Ok3OwcqMUb0IE26fRyynC/Pp7e8bK
	Di0clgLVs7MBd5qpGyS3GGOvf+AIu0n/sipEjXvrln1ffkrSvdAr3mf9Du7irGNv
	9npTC7Ny1z46A/KndkWekKGI4jbgPzAOSL1MZxsxjvpgsBGNd86phFC7qMemy02O
	dfESceNQtYVskKYvJp23sRRCJXuPp/T5KCjHbXGXwfhxQZ9qmHyM2RJDxGAMF9/S
	EHtbw3ONpIu5M3IHIRUwizcwgcF2zdoxTrHSbOEXTV/pCvscZ5IScHKKk1eEsc7t
	bpyPZQ==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ac5fggcvd-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 15:11:01 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-ba4c6ac8406so3492909a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 07:11:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762873861; x=1763478661; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NtWhBlV0ZGLBZySq8b2IGhCN1uzwyRzojwI9hN8eLNE=;
        b=dAzojFK5OSdY1GXdRP24z8sV/RzCnq7QqUfIiJ09K99yrNy/j7wE/pv1si/EbdIENv
         3FNmdTf3F2hmMZIeTDKhh5pIdLomRPD7NY5cvtsz40Qa+4NYDsccjhFNKKGngIlnhf1C
         3k9CZgoS/Xife7QCxoeaO/NkhcDPEVSzHQc1dH8Uf+7lYiawf3FDl2r21V9IbSM76Akr
         GupSI1MAOZHflvVoy4y3tl33APzZYuCwJ8hQpjA1QZT8FVBZlNDEiyzU4BtX7sHxSlQR
         m56Jp82F7BgVsAH2Jk99n08ifZBD/VVo4GursHAMgBOxFBuEcUxoDOYn218BGPpPrRJp
         XGNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762873861; x=1763478661;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NtWhBlV0ZGLBZySq8b2IGhCN1uzwyRzojwI9hN8eLNE=;
        b=RL4KjDszL0pVAtJqc3KfqU+T3XRS9aVE5173g6TmUhI1mec1oxlAQXjYrJpq01HEA5
         6dHEPKjLDXMrBuBPfAfXpaZjOEigA3xyB7Fe2MIiENOsI0E9UEf6xBi3NSDJFBa0Ljpc
         YeZdt+PEj3nmCYm03cMXBwuNYsPu4yXXsgDjAoKdl0BRZ9oyTXjvBX7HGYOKS/Vjd1pU
         2bXpYuprux4UlPwpIEUieAbax/5e6xlr10stzJ+xst9Rfu/kWejjvqdWA5Vo71eRYIHK
         MIRQflgWMgbaIWkme90dArJfLguKZZZ1QL+BBVoi4Ou25wELCWAED555EaSG2zC+JYKL
         tZLQ==
X-Forwarded-Encrypted: i=1; AJvYcCXhZyK2gzXgHKTU8oyCkRXdova+e0cUhktmSww7ExKwiOwfUnIk8I7+6odAJTAGVCKq3zqBS+XFWjE6XS4=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywligev5fdKHkMAQ+rmi6eiltiknIrKu2/z4U1dxHsti68FH7Lc
	U4P7i+Rkj3XpeGVfdOkCyJ5ulOxnd1ufC7uVJQZqB1ksA+2yvVfQ9LqYExTu7XpykjxGyNu5697
	ZCUW0l9zg1q4BTaxVrvM26VvGwnrp4p+Qx/YQ3mFGDukplBndjqvH2tJm83Dcwju8/fM=
X-Gm-Gg: ASbGncv2PDWKdQP81837cHBUD2tLb1eg1pIVA4hkZOGIT4Z92StwpMb5VFUBF2qkgVz
	O0Q4G9s4SU3HzG35n5pH2sPueCQcHuGXlEWm6pjKiBq2GAPXCn3bjD5mviwC8Pg4ZWRKg2dwSZa
	Pnk1wxMsMEnzsZ8jphObEvVN3MuihfRpfxLhYKW76Ym05WObk6k29yBHgkPnJ1A3imH7U1Ldobh
	JVGG6oiFJPlGf9E8OWJarEKC7vNGeEuPggTMRHt9fgqbBJsSzbgltmfNAcoaJYTnCkLteL2qK4u
	PLlOjpG0WqORJgv7oGCPfd5WnPMeOibSDMGHF3E4iWvejSWfp8spQ29gAlsUfNv1BKjlELdwpxR
	X1882k5QtzDxzR0D1peVn0g==
X-Received: by 2002:a17:90b:5710:b0:340:a5b2:c30b with SMTP id 98e67ed59e1d1-3436cb21a6dmr19109666a91.9.1762873860804;
        Tue, 11 Nov 2025 07:11:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGNf3T6rQRdI+ynvsyLg96H/Cq6hXZuZujE80OuxKOe522yI9DUPjy3z+RAOvPojmWw+JmU6g==
X-Received: by 2002:a17:90b:5710:b0:340:a5b2:c30b with SMTP id 98e67ed59e1d1-3436cb21a6dmr19109605a91.9.1762873860285;
        Tue, 11 Nov 2025 07:11:00 -0800 (PST)
Received: from [10.206.103.12] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3434c344838sm14745324a91.15.2025.11.11.07.10.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Nov 2025 07:10:59 -0800 (PST)
Message-ID: <65714302-3b71-4a15-8647-ad707e056302@oss.qualcomm.com>
Date: Tue, 11 Nov 2025 20:40:52 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/6] drm/msm/a6xx: Add support for Adreno 612
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Jessica Zhang <jesszhan0024@gmail.com>,
        Dan Carpenter <dan.carpenter@linaro.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Jie Zhang <quic_jiezh@quicinc.com>
References: <20251107-qcs615-spin-2-v2-0-a2d7c4fbf6e6@oss.qualcomm.com>
 <20251107-qcs615-spin-2-v2-1-a2d7c4fbf6e6@oss.qualcomm.com>
 <abf79d96-72c2-453b-aa2d-0626be584baa@oss.qualcomm.com>
Content-Language: en-US
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
In-Reply-To: <abf79d96-72c2-453b-aa2d-0626be584baa@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: 4BAURRA9BLJufjHDH2ptSHmhaNeFsxbb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTExMDEyMiBTYWx0ZWRfX6YYkvKhx8UA5
 OUMZdUZanItFC9V1wPwb+9oqh+WQpyaCwLLfjKkOuVrmx7LPEo9EC8hvUfyxYGMOI6ETk4cQYBF
 7n4rcRYSIaKgJ5FS0GNd2dlD/1fANukD55tiq1ly4gEHoi+Kgfhm9aI88zqnJLu94hwy/MrL8Jv
 ewjrgjLwr2JFw529k814jnj6tLRHLRGb5fTg/nnjwlU3N37FfJzGSaaKh5e9OnaGPpYAEZCAebW
 yNRJcfVCgd4rrsbepEHgrO8Ki7oBQvPvNavpswx2xE6Huu5487Fnsx+r5/nNFcXftC0E8I2zuCi
 f/O+hIE5UuuLfh/GobbsZapCqiLFpdeQNdS3+I0pNFma7zwvTWfWbNMkyztruA4AlR/1Vz+ci6e
 z2X+smA+bhi6joOGtMI+/KWgy6W8lQ==
X-Authority-Analysis: v=2.4 cv=B5u0EetM c=1 sm=1 tr=0 ts=69135205 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=qJyp-pYZgGMIYD5dL0UA:9 a=QEXdDO2ut3YA:10 a=x9snwWr2DeNwDh03kgHS:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: 4BAURRA9BLJufjHDH2ptSHmhaNeFsxbb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-11_02,2025-11-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 suspectscore=0 lowpriorityscore=0
 clxscore=1015 bulkscore=0 spamscore=0 impostorscore=0 malwarescore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511110122

On 11/7/2025 2:28 PM, Konrad Dybcio wrote:
> On 11/6/25 9:50 PM, Akhil P Oommen wrote:
>> From: Jie Zhang <quic_jiezh@quicinc.com>
>>
>> Add support for Adreno 612 GPU found in SM6150/QCS615 chipsets.
>> A612 falls under ADRENO_6XX_GEN1 family and is a cut down version
>> of A615 GPU.
>>
>> A612 has a new IP called Reduced Graphics Management Unit or RGMU
>> which is a small state machine which helps to toggle GX GDSC
>> (connected to CX rail) to implement IFPC feature. It doesn't support
>> any other features of a full fledged GMU like clock control, resource
>> voting to rpmh etc. So we need linux clock driver support like other
>> gmu-wrapper implementations to control gpu core clock and gpu GX gdsc.
>> This patch skips RGMU core initialization and act more like a
>> gmu-wrapper case.
>>
>> Signed-off-by: Jie Zhang <quic_jiezh@quicinc.com>
>> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
>> ---
> 
> [...]
> 
>>  	/* Enable fault detection */
>> -	if (adreno_is_a730(adreno_gpu) ||
>> +	if (adreno_is_a612(adreno_gpu) ||
>> +	    adreno_is_a730(adreno_gpu) ||
>>  	    adreno_is_a740_family(adreno_gpu))
>>  		gpu_write(gpu, REG_A6XX_RBBM_INTERFACE_HANG_INT_CNTL, (1 << 30) | 0xcfffff);
> 
> Downstream sets this to 0x3fffff, but IDK if having a timeout too
> large is an issue

I reviewed this. It should be 0xcfffff. It looks like the latest tip of
kgsl has an incorrect value for a612 gpu.

-Akhil

> 
> Konrad


