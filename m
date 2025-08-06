Return-Path: <linux-kernel+bounces-757774-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A4B6BB1C67A
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 14:57:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B168656503E
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 12:57:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA3FE28BA82;
	Wed,  6 Aug 2025 12:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Z/xSjPjv"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A5741C8633
	for <linux-kernel@vger.kernel.org>; Wed,  6 Aug 2025 12:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754485011; cv=none; b=DZ7ZnHLKxxuO4cFehBr/WbqZulA/6w2n4GJ4QozX9wgeGOT+aCLyIykv97pVgvTuSjqMNcgcQYhFhdTH4jPg0u0HENzMXp1UO3BS2SDcKSEit0+WX5UfbRP1alFKPeW37DjY2dc32fIrh1OCl50xKo+lZ47UP9/lw8HaESns2zI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754485011; c=relaxed/simple;
	bh=F3XHAgV/g9t9Pe4DihqURvItO9b3hVigjb6udFTYxTE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kR97q8uNkgKj3wYsF/jS2TNm2AkySAJbsXUd+atsVJVWNi2tU1xwikFW/QUxbsHuNnbjdXNU3XE85WSBzXPOinYrgODjN8lRA4cN64LdwJcW/V+R3cd2FMmvWz104H0hIuO5ZcW661TrFxamcNspC11O3LM3ZGuZcAyOuI1/IHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Z/xSjPjv; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5766F2lq013679
	for <linux-kernel@vger.kernel.org>; Wed, 6 Aug 2025 12:56:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	RegKPJzk3RnagfrkfnZuONX0t7ULdD8AHnZvaN8Nsuo=; b=Z/xSjPjvslBXRNWr
	UEpX/VOoqncvDHYoUTIcf2DyUIwIAWvmZXLNmJGnKZQpqw8WW+tKl7Qb5vlkut5W
	6unRVwBVXQbijrgLvf5uE6ctmNqjj4yQ6U20bdQx5Uppv94Xd6HfMOFnyt2ZFjXj
	nRPPNWsjq61r7Gy2Z/bc64BZpk8GsrBJ4XtCn4EbshvSyLHF95ZvGExbu64oviYX
	zkUEcPpspmXsU1oKTeC7fNfZ4300cASp4ibJVacrBdkuouTenJorZT/lVrDUZ9yj
	yhgjvELYml2UTYqGcnsQ2qdKEPh3JK9cDDZm4eIR6E3OKIFj61RcCdok3NrDioe0
	8N6AAw==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48bpyctnv1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 06 Aug 2025 12:56:47 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-7092ca7dae0so15449296d6.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Aug 2025 05:56:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754485006; x=1755089806;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RegKPJzk3RnagfrkfnZuONX0t7ULdD8AHnZvaN8Nsuo=;
        b=T062vqsoTPpfEIdbvbitBihAtnA7N5qv/wJtM8jxqiKJlMm6t2XZs6YZV+5oTIxbXe
         AzMh/Cp8qmaRlJ/w2FZqcTntrIgTw89qdaT9V0/5jFkqFpmAIyvF+2uN5kPEUj5pcv8/
         pXu2kXO6KbBlWpgcZsqqJQQIB7ddXg7CeFdC9rLczrWnJCZuUnQZaKKUGPjyq1UgodXV
         98mwhn3xuSu8rrONQLRPPgMJMMmopwy0EZdhRWKsnz3udZWg67hkqXW4SqIi/MUbiJAq
         PDF0Xo+aeQeDEHBoYiJ5y2bKYU9LLIBM6Ocn9pNixts2bhkKw5RXj+mun9ChxYobuwZf
         jPOw==
X-Forwarded-Encrypted: i=1; AJvYcCWOPlreGX7IIVma2JHY/4kH3+zzmf9cuRgBVvkctvQdHcSLUF6iS6dAjeaHLYUi2V23X6lOOVzOUKydLgE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5iq3uHCBZwTcmHbHb6I6YaKKA/wZ+HTtf5Rw9B0MdPaypX7bu
	PPJ2mEBPQnvMFnep6sehYTF4e4oBvr/dta7ylW77uSTT8dX0ReinFCxCIM5H+Z6tPATBpVcf5Se
	qB36IThnbZV2w2qEQAt0nVTBH2OmV187EWzOqsW7OIMJmcnID2ZkvHD0jbbYvlaXCXt4=
X-Gm-Gg: ASbGncsUjArxA6dKW5U+vPiYOJaPMaDg7VD8bbqBQd2Ru8Bq94TYKkOzocmTQCsACRP
	rbOoOU3HV3L1Wf0dYpTHUt5JGc4ON0YWPeOSpOw90JZQvlhcPClfkjE3LGj5iuNwnPjXkcvoUGc
	NTXthHegk68Tl8VRZ89z7K1ZI0ptV8yRcDG3ZGR7YUU9IHDXTh9NQHTlQEDn5EHvuH4rK5V8wBE
	wPLFHqYjzzMno3VBlLDxWPJKKGaqItpg0cd8sRcSNHSVG3zmD0TkEVItfzOOKVyXDneT7K4Ab5H
	M0o9RV3ItZjzPrlDSnUQztRIejPMq89NQHaXqz6lo/wBq8CiT4otkYA/rZIuExmOlKfPH4W4hBc
	zTujknNWVACKVXLaRzA==
X-Received: by 2002:a05:6214:b63:b0:707:4dcc:4f56 with SMTP id 6a1803df08f44-709796abd94mr18721966d6.8.1754485005874;
        Wed, 06 Aug 2025 05:56:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFfR9Z4zfNZbubypCaNT4t6gxrEqBn7cwk8E5n1N8Nu8bR7i9WrLvmOe8gMbV59slrbJZLEPw==
X-Received: by 2002:a05:6214:b63:b0:707:4dcc:4f56 with SMTP id 6a1803df08f44-709796abd94mr18721716d6.8.1754485005351;
        Wed, 06 Aug 2025 05:56:45 -0700 (PDT)
Received: from [192.168.43.16] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-615a8f2d554sm10031187a12.27.2025.08.06.05.56.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Aug 2025 05:56:44 -0700 (PDT)
Message-ID: <c62c2744-0d07-4fe8-8d2a-febc5fa8720a@oss.qualcomm.com>
Date: Wed, 6 Aug 2025 14:56:43 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] ufs: ufs-qcom: Align programming sequence of Shared
 ICE for UFS controller v5
To: Manivannan Sadhasivam <mani@kernel.org>,
        Palash Kambar <quic_pkambar@quicinc.com>
Cc: James.Bottomley@hansenpartnership.com, martin.petersen@oracle.com,
        linux-arm-msm@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_nitirawa@quicinc.com
References: <20250806063409.21206-1-quic_pkambar@quicinc.com>
 <ucr4imzntw6ghcvpeioprmva7gxrqnkphjirjppnqgdpq5ghss@y5nwjzzpvluj>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <ucr4imzntw6ghcvpeioprmva7gxrqnkphjirjppnqgdpq5ghss@y5nwjzzpvluj>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: iyLcevKr9dU_JdNgWcq8OsR6DKEEUzwl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA2MDAwOCBTYWx0ZWRfX2nG5kQjUGw+h
 RkEfFneps0Gy/VhUGf84lsrwZr2QQA0gYERowRwYEVJXb3Or6GgffYiKDuz3wZRDMIEO9POVhmG
 y74+tU19DpXd5fVw5rGO3xckp+dFmqZcHxr2IrW4ae2ERfn2CjpLNKQfNvc9w+N1i3kC+xxWtwW
 cbs0D4nXcy+jj2badRjeWV9PyokFKbTpgaj6hYVWYl9EvlWwIKiqa8cjZfEJOsdsE//IFtoepax
 zlgjrXn2wTl4Kwggb2ciE2nCvER09tTzpaGov5XzMYiFW/uQ+mzq69hjFEXF4OiKaYjR7gjmPGs
 b9qWxvIgnbPX3kyYbSTz29ruGgo0Bd20fpZTYUeMmvfIGcoMGJK1JBSY0mHXSs+f0yo2JEon/qO
 L/67sxHo
X-Authority-Analysis: v=2.4 cv=JIo7s9Kb c=1 sm=1 tr=0 ts=6893510f cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=COk6AnOGAAAA:8 a=CykVZ_nljMR9ycAI1QEA:9
 a=QEXdDO2ut3YA:10 a=iYH6xdkBrDN1Jqds4HTS:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: iyLcevKr9dU_JdNgWcq8OsR6DKEEUzwl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-06_03,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 clxscore=1015 impostorscore=0 suspectscore=0
 bulkscore=0 malwarescore=0 phishscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508060008

On 8/6/25 1:14 PM, Manivannan Sadhasivam wrote:
> On Wed, Aug 06, 2025 at 12:04:09PM GMT, Palash Kambar wrote:
>> Disable of AES core in Shared ICE is not supported during power
>> collapse for UFS Host Controller V5.0.
>>
>> Hence follow below steps to reset the ICE upon exiting power collapse
>> and align with Hw programming guide.
>>
>> a. Write 0x18 to UFS_MEM_ICE_CFG
>> b. Write 0x0 to UFS_MEM_ICE_CFG
>>
>> Signed-off-by: Palash Kambar <quic_pkambar@quicinc.com>
>> ---

[...]

> 
>> +		ufshcd_readl(hba, UFS_MEM_ICE);
>> +		ufshcd_writel(hba, 0x0, UFS_MEM_ICE);
>> +		ufshcd_readl(hba, UFS_MEM_ICE);
> 
> Why do you need readl()? Writes to device memory won't get reordered.

I'm not sure if we need a delay between them, otherwise they'll happen
within a couple cycles of each other which may not be enough since this
is a synchronous reset and the clock period is 20-50ns when running at
XO (19.2 / 38.4 MHz) rate

Konrad

