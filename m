Return-Path: <linux-kernel+bounces-845382-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C2A67BC4A41
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 13:55:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B076519E18DD
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 11:56:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6024F2F746F;
	Wed,  8 Oct 2025 11:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="maqMwvrP"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42D6B2F4A0A
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 11:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759924548; cv=none; b=GGwS/U2JQqKehjysbrgQv2t3zjisW2OiTWbeSqgefA4i4RimPAP052H6cuthTeCa3vWBWVZ/VAuEbTpLQzorK1nxDibFkG1aqBKKpJPBKofuyOFucUlrn4lUyEg273uyz55Yy0J2pNPs6vK8oa8QkrCiKwSWrQdaVkMRhm6+sOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759924548; c=relaxed/simple;
	bh=lzKibfEwcgq9ZCr8yG0Yc2sdc7f61txnd2gsqpO1nqo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Po2EGELkf/ZKwjE3E1k+lCH3p2HNuX7TFyguYqJnv7C+tG7J82n3TAbcbgMjmaU8pQXsOB0i/XAl4YAKsQ8vHv9Md13yBm+kdeeHabVhkWg/2rxw6Kc/f24Stt3TELVPn/50V0Bc0qSKkb4NPTs0DTE3/d7WwSWT85UsSbMEZCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=maqMwvrP; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59890iB4014448
	for <linux-kernel@vger.kernel.org>; Wed, 8 Oct 2025 11:55:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	is4ONlRs15AvSM+w6vGZwSp+0+G+NrjYHHMxgCstEs0=; b=maqMwvrPXDPQLR1h
	PsZqdH+9wtzKQkon+whG0xm6+74TxTDygaIHxF+wklHOtBeTH9Vu7xmQfxjT9iuu
	W71b8z2ol1hHRssAl7Wjh5NSK3rnT/vLugyyXxVzeWlBVdP0b9rxNcouP0LR1Ahg
	3kyFjG2EDj38td6Em8/qSoJqRkYt5HqubCEAGfPI9lzPD769ANCTpdnYm1DsZr39
	FptnGDbW5u5uXMSf2CSIVbuk92Exk5k0i61EOZisO4zgkDt1vqw/HaIjxtyfcSAh
	Wt6TPthsWqBBsAWJAKDUGRf8CzbQ368lv8JZqDdxX7NQpgcE1GzSau3Hg/9uZKzT
	xnTr2w==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49mgd0p11p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 11:55:46 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-27eca7298d9so156490995ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 04:55:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759924544; x=1760529344;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=is4ONlRs15AvSM+w6vGZwSp+0+G+NrjYHHMxgCstEs0=;
        b=UyZvgLS7wS9QkyZhOwCJOd58l3bz2LFG5hbnvBKqQybG2aO7KS+E8rfRc+RQpoLN9V
         +tMytV8lY1CB7aD6IXBVMgwVotf3axJuRUIcIdcxdhw1uHYp7qsqlwJ6Ogzjllx6ORHv
         gslBBNSi6i4HygRgZU2m2J1iM+Wsl4wL1wO2ZFqFNy8mvSIMCEvGC69D8dryduUs7QE4
         X1utfxH7OhtA2s3gqPGZHbxwfJ2ACQPflCVKsaeYJ0xtCcqP3uyhIfFo0qbubnWTboPv
         SvwRCT/bMpYD/mQULwMufkqMDXPhDMUvdX6x0Q3oxx3qxlWX561mRtinSo/5DdjJKcrc
         0aZw==
X-Forwarded-Encrypted: i=1; AJvYcCWVB0rbn1gDyWrDH1VciM9TphUNQgNRN8CBRbBzMNPfHr1p7k8Wk6YjamnZGNh8do5yIXhiS93B3FySTtA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz68zFBatjJoI1xjWzA30YT/t1GkrYv9FEmk+sa7tVhurJN+q9i
	XQI194D9LDAXs4DWkw5zhOfietjJ0pavuuSn762zT+uusbca75KKLjuqZNPHpVPWWG3MaUWH0qi
	PN9Fd9ihvjfuBRzlr4ezijjpwmpGx5pK0qzoEoQc1awtx6QDs+GCjgi+9rp4HqordIltqsiIN70
	U=
X-Gm-Gg: ASbGncumQ7MtAJys0HDhbO2iCrzXFcMS/t8lRvDGoQY5NZ8YCnkPilltEG18RNnJPBB
	qG0sywx+4ErHfuQhPKl4CfqqoS5RN4H87yV+C5UTZJnrfY0sfs4X0yCAUw+D5+aH2OlxTnT+EuD
	mMS69CiMvOouAyEBtxaCdwgDO6w3ZIDkPwKP6nIgKk3fc8MxqsjMa5tbiIQ3MePJc9aRF8BJdfy
	m2ee24sH+KNV9sn3R2ETLoXkYCMswXVxVHxxm+3bWKAf5P9qtGBhokoW2QTHIGTaUnM310GmNxV
	JgJmVD8YTI3JSEPp9pk8xf+GLFfmpDZI3YZZeuTJ3fYdKx3Yan1MiG4sCeXqBYyvajexVhj5RAp
	ruBqzOinX6Lhcmffzl7fwwXNgojKRlVctBZjaxCq9qZhgVQJRQU4LRa0JF5M2XOo=
X-Received: by 2002:a17:90b:1b43:b0:32e:18f2:7a59 with SMTP id 98e67ed59e1d1-33b5116251cmr4321792a91.11.1759924544301;
        Wed, 08 Oct 2025 04:55:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH8dAKsyBbZvrsJrjiadHYFmwWdD8uXe/duyov4znxSNrQv9BCH4o3QlpUkcce67iM88n/91g==
X-Received: by 2002:a17:90b:1b43:b0:32e:18f2:7a59 with SMTP id 98e67ed59e1d1-33b5116251cmr4321743a91.11.1759924543785;
        Wed, 08 Oct 2025 04:55:43 -0700 (PDT)
Received: from [10.79.195.127] (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33b510e919esm3186243a91.5.2025.10.08.04.55.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Oct 2025 04:55:43 -0700 (PDT)
Message-ID: <064d2a33-22e7-446e-9831-a390510698cc@oss.qualcomm.com>
Date: Wed, 8 Oct 2025 17:25:39 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 18/24] arm64: dts: qcom: glymur: Add PMIC glink node
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>
References: <20250925-v3_glymur_introduction-v1-0-24b601bbecc0@oss.qualcomm.com>
 <20250925-v3_glymur_introduction-v1-18-24b601bbecc0@oss.qualcomm.com>
 <09b2ee28-ee2b-46a8-b273-110fb0b4d8a7@oss.qualcomm.com>
Content-Language: en-US
From: Pankaj Patil <pankaj.patil@oss.qualcomm.com>
In-Reply-To: <09b2ee28-ee2b-46a8-b273-110fb0b4d8a7@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: SB00DLVmwqZL6i7HBvLXC65H88BHt1d0
X-Authority-Analysis: v=2.4 cv=T8aBjvKQ c=1 sm=1 tr=0 ts=68e65142 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=rqt88i4GeKtY4LEx51oA:9 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-ORIG-GUID: SB00DLVmwqZL6i7HBvLXC65H88BHt1d0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA2MDEyMyBTYWx0ZWRfXyT806CFzmO4k
 qMTSzBRWZg9ICUdTkLafAYpxCHNcdJh/eNE8HLiQDKTjegVH4Q3HSXEHcOXoAcmiSovqtef5lAC
 6y8wfWMuz64W6Oq3q/cY5HqTMokPPoaPrAOfViF+HV0nQpyt261MVeO7FJm14xK4mHgT2gggSxZ
 9VBei6AiqPdVZqf9jcwtp1ToZF19cWjaB5+4kzBnn+fEWyi8zDp6e480rwRkpGdeH4ihk29LKdW
 8OdYa6WrnLBbHCrMPKIvvKzuyvUNJafxMBp9iF4tFHU1RrLCJsEl5iKvH9Q6G0yiFnAwJngHjrc
 5N0XmWiM6tk8EhDFFG9mF5aTOJ9N6sgO7W/bfwuC2T4bVjXgDzaEzlw5aP4SwiYXJoq/GMR6su9
 FFsXZbVumcpU+wXugOC+maPT6ny90w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-08_03,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 phishscore=0 clxscore=1015 priorityscore=1501
 impostorscore=0 lowpriorityscore=0 suspectscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2510060123

On 9/25/2025 4:02 PM, Konrad Dybcio wrote:
> On 9/25/25 8:32 AM, Pankaj Patil wrote:
>> From: Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>
>>
>> Add the pmic glink node with connectors.
>>
>> Signed-off-by: Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>
>> Signed-off-by: Pankaj Patil <pankaj.patil@oss.qualcomm.com>
>> ---
>>  arch/arm64/boot/dts/qcom/glymur-crd.dts | 28 ++++++++++++++++++++++++++++
>>  1 file changed, 28 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/glymur-crd.dts b/arch/arm64/boot/dts/qcom/glymur-crd.dts
>> index b04c0ed28468620673237fffb4013adacc7ef7ba..3f94bdf8b3ccfdff182005d67b8b3f84f956a430 100644
>> --- a/arch/arm64/boot/dts/qcom/glymur-crd.dts
>> +++ b/arch/arm64/boot/dts/qcom/glymur-crd.dts
>> @@ -79,6 +79,34 @@ key-volume-up {
>>  			wakeup-source;
>>  		};
>>  	};
>> +
>> +	pmic-glink {
>> +		compatible = "qcom,sm8550-pmic-glink",
> You *must* include a glymur compatible
>
>> +			     "qcom,pmic-glink";
> Are you sure this is still compatible with 8550 after this
> series landed?
>
> https://lore.kernel.org/linux-arm-msm/20250917-qcom_battmgr_update-v5-0-270ade9ffe13@oss.qualcomm.com/
>
> Konrad

I'll check and add a glymur compatible in next revision


