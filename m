Return-Path: <linux-kernel+bounces-721577-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 670D5AFCB25
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 14:59:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A05C3A8A5C
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 12:58:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B5092DE1ED;
	Tue,  8 Jul 2025 12:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="gks4JNK3"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5117D2DCF5A
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 12:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751979519; cv=none; b=JCUgLX0nDCJgvKqEXIki5n3AYzKxoyiUvoISnEotWfoLGaP5o+qkp4iCN/mYSaZ0513SUl6wVdBNxJOFRtrRKzttWaMIhHyfwjH9aZ2QWi2g27oa+p0ZAQLkMReAuZdZT79SURbpHBuA2nca1oyOgr8mfEr+TiA6z1Lvf6xqGQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751979519; c=relaxed/simple;
	bh=X9xJsNLRo/w3sPWkc2XRYMyZn6hmmfeGt6sJZVRGGFY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d8BjYLQXAaaP8gNJ6G4m19t81hhmev24eQgTcEI4b/jh0jaM2fDQA1egZ9+50LhPqEHGj4OBnb3p+VtZvOC8Leblc0LQYIgyNz8VWTwRNaPMZYgALrLFztdoZ/HZvcAKfUzb7GJ7tzsTO/0O2w2RqfuCcAe3KFgCi8NzIbL88NU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gks4JNK3; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 568AAT53025476
	for <linux-kernel@vger.kernel.org>; Tue, 8 Jul 2025 12:58:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	oBzyArkLyeQ1R18P8zwGvzvM/TDm2vLryo+5DG0mYeg=; b=gks4JNK3YSNajOAS
	xCne9Zv/Ld01rka4EShHEOoAHn2nDM9wZIPVZ9g/3EkzNECk+oxaXhoCTg7Ql0aS
	6tt0PnK3OhB8H36vL4OWHEML110y14HMJj6X5iOse3wSq8HRqCM/rCLXQn5d44Xv
	7PmmIltT0OCESInvJmdYGSo0Xynif7naLQH3hlt92J35Q9FoWhowO9ArBbxcNOMP
	eD0GQHrIKj3QTmK4fDnQinLGf0zWoHRJV67l0nJLSK1jXW0KciuR94YH9bEDtNIF
	8LFaKW2AKlYJTPTG0PqPLf3pIx4KrBf2KAyAWjgRKs3zgubn+toJaXWXuWukDaKs
	Nk2+4w==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47pu0wd9v1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 08 Jul 2025 12:58:37 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7cfb7ee97c5so24063085a.1
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jul 2025 05:58:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751979516; x=1752584316;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oBzyArkLyeQ1R18P8zwGvzvM/TDm2vLryo+5DG0mYeg=;
        b=USZC/a/H4D2sb0C2zEqjBTNHEDkeKRRRXHZG1xOlvCJyh9rnAAFp8ada6q7C6vxLyR
         1Z9UPJFguZBtTKNsMXgwu52gCe3GMllIXgcFB+wtBXRyYHahA3v9w/D/Qjx16SllderG
         LLm8wfCI5VpHM86IvtLGjNOPNBrhHc5I16PoJCVQ3umz2KZOEbrWiwH84G92RaRl7C2J
         EnWxDJugqa8yodhBBjreZE1RcBU44RtxnZq33gFCtzetEjE6fG6/TRPQEkn5qpm9qsoL
         VzGCf8fwi6cmO9dWE+h9Y6caQ/aw8KxSwup8gKSoXlc9GiN4DO/cKiGqWYd2gIDpIehD
         Oj2g==
X-Forwarded-Encrypted: i=1; AJvYcCVahz8AxtP2Jxgyw0QGbfp4ZKQsADlE0XE79BoA0jlfpUtp2TpJ0DQNJR/r6n7Y19jdSrK0ZtpBmWfVAW0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQCTADUTSgcemX8RVn/dbor0uXlx2IsJlt5gjDnnKXMv3K+I3Y
	HC4jA5i93EPh9lxbg242WBonBDG29bUrc+jqFl48Mc2IID3XbcYNdvCXCU2f68tqi3I8GZt4dJr
	xTOwYntLV1FCgQncu+riCLU0NBrmqGaMBUxeTPiAWrWYYREg9MnvYT9raIcHwMYITBqg=
X-Gm-Gg: ASbGncsIfB7b3m6XDcVYpyJEcx0c5dXjmZHJqacG7FVcBfzGnQVvWY36qkKfhYI8DMV
	s3TjtOcnFggeJxZl87lJAaf5DT9ffyEeCKvOIsx6JY7f9kEz+UmrzbMZ5xKLNSc4tXunmV49Sme
	tVDtRwj+wJHUrbQJQ//fWC9yoMNm2L1AnEzRWt3A5PEpeEMGH6F1Ix/R8Oj9pAUp5UdFGJjw8yG
	GX68OKviSHn6TfNCC6yc/iHSna7scegwhRgYUUqc8GG8WpXK3FBLO5VTeMNkxHHkT71pxpEv/8Z
	WbR2EqPZl/4v14rCU8fOQSk81Yh6R/kdIYP0vprFnn7q5sMUAm3+dD3xmU7m22C3ic3mulG73d5
	lZQU=
X-Received: by 2002:a05:620a:31a1:b0:7d5:d01f:602 with SMTP id af79cd13be357-7d5ddca58dcmr862222885a.14.1751979515780;
        Tue, 08 Jul 2025 05:58:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEOk1IWR6Dn6J7aqoS/O9lQAE2QdoBK6t1pNzfRDs42+DnDytk6BXjQsEkoWsK/g6hiFtoIbw==
X-Received: by 2002:a05:620a:31a1:b0:7d5:d01f:602 with SMTP id af79cd13be357-7d5ddca58dcmr862219585a.14.1751979515103;
        Tue, 08 Jul 2025 05:58:35 -0700 (PDT)
Received: from [192.168.143.225] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae411a5429esm661638166b.16.2025.07.08.05.58.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Jul 2025 05:58:34 -0700 (PDT)
Message-ID: <5e31281c-552c-4268-933c-e130d7d5a7d0@oss.qualcomm.com>
Date: Tue, 8 Jul 2025 14:58:32 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/2] arm64: dts: qcom: qcs615: Enable TSENS support for
 QCS615 SoC
To: Gaurav Kohli <quic_gkohli@quicinc.com>, amitk@kernel.org,
        daniel.lezcano@linaro.org, rui.zhang@intel.com, lukasz.luba@arm.com,
        robh@kernel.org, krzk+dt@kernel.org, andersson@kernel.org,
        konradybcio@kernel.org
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, quic_manafm@quicinc.com
References: <20250702082311.4123461-1-quic_gkohli@quicinc.com>
 <20250702082311.4123461-3-quic_gkohli@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250702082311.4123461-3-quic_gkohli@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: xxd8wREQVu6mLgsKMeOFo0myShiK87Na
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA4MDEwOCBTYWx0ZWRfX7YLR3zhvbWC8
 F76UucU28MOyuuyyWiyFMekvu9zMQGA9qathedLeNjT3xQ0l+RMf5LnJ42TjrVJTSN6BVUb8tRi
 7ySDEWF6tdYrup5ly1Q+V6oLyJxeLRjevpiMmCMYB+CDH2ykDkr1Ee+oHEiHnNROP9yQhZQpGZd
 mzbKbLlspQuEq1t7mr56pqu7YJZ7XaFa1DHtV/juBqglI6h9YFi2r535xbHrTcqnKQNBbMNiS94
 IVY5OP6Zz10+SDjAY4A2wuIyqVWLJfD6CS0zGcb7EC8a4svrg0tMkBD6+DRsk0XFiiL19zDw/hd
 jA5bbuLRJLutMnHt3LcS0m4nhCUztCH1vzZ1jsgDCFweU03rXTWDOGMur5DbdJCSlbi7UvL/NCB
 YHTMgK0fIB5kM06UVlfx9ugIK1th0J6wREoTFmk2TBk4exng4CRbApV138MKC/c2UJY83wb0
X-Authority-Analysis: v=2.4 cv=Rd2QC0tv c=1 sm=1 tr=0 ts=686d15fd cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=GSS0VzHe2Y3C4L18hMQA:9 a=QEXdDO2ut3YA:10 a=ttxTGWTNN9wA:10
 a=PEH46H7Ffwr30OY-TuGO:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: xxd8wREQVu6mLgsKMeOFo0myShiK87Na
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-08_03,2025-07-07_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 suspectscore=0 mlxscore=0 malwarescore=0 lowpriorityscore=0
 mlxlogscore=775 impostorscore=0 spamscore=0 phishscore=0 priorityscore=1501
 adultscore=0 clxscore=1015 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507080108

On 7/2/25 10:23 AM, Gaurav Kohli wrote:
> Add TSENS and thermal devicetree node for QCS615 SoC.
> 
> Signed-off-by: Gaurav Kohli <quic_gkohli@quicinc.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

