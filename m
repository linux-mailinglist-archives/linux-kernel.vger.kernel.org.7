Return-Path: <linux-kernel+bounces-738241-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 24E58B0B643
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 15:34:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D39418983AB
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 13:34:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03FEF214801;
	Sun, 20 Jul 2025 13:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="D3daBPK2"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0296A1EB5F8
	for <linux-kernel@vger.kernel.org>; Sun, 20 Jul 2025 13:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753018470; cv=none; b=u9ayd5H004A8GTpAS5xB1TaQ1jJS5NwXPkQgBzH+/7ubb3TkUg5EcqizMuZUXocgWvf2ZDGRHWdrwbD7JnLgZy5saUPIq3D8AlMYWRWS4m7QHYJI5cI5NVSaA6+77H0W8HmPj/73ESP3ICXDm80yGOPFmoO+8azovEkwhTwB2Ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753018470; c=relaxed/simple;
	bh=VuY0DHHFaW7kyXOA5c0q4PBG2btCCQS33OOoPi2jztQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mSSVHkuy6GFV43Aypj/1TS19MW+KIwQNZSHy3Nk/4LyWcqxceXoISjBpXq10LwHa7DF+pm2k4DfXFurFldClgtvuUGNlOgpswI+cFgqCkaJf4DR86ZjmKKnbnpmw3P+WW6uYDKtIiLjJfdlgGPfSjK8oSua7KYst+OeLt9LaPrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=D3daBPK2; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56K8QlCb020870
	for <linux-kernel@vger.kernel.org>; Sun, 20 Jul 2025 13:34:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	9aDr5oRJHrA7ID3S3AHv5io5gP+ebOQU/9zSgcDQr7A=; b=D3daBPK2WaSqDkWf
	R7U7oKm+JnN1qJL3yztiiVTrCIC+5wi7pfUCWU+yc0IzfPHXJ+G+uu8PtRyRtN4d
	TQ3FZXGujxIrDGdz+RHA9gUJAZoTd2Kc86ORcL4s/CbtgOF9kHVSyG48/H0DTePT
	eV+p0OYx8exMhrWV9794p4lc041iWeiRzcI0qIuRz0obcpzRjElHuIWXzO+ul4LW
	c40MG9XkFNqVlWwjmhio+0UV4ecdVP+qff6zGqQa3nXSx570ZTtM5vZ3/Q6ztm4B
	05qyWQVZ4MbGkkaBCVx6Y/3wVP4VwfB9QrwWItC6JxorEkVR045y/NYgz6D/scRq
	0MYkyg==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48048v28f6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sun, 20 Jul 2025 13:34:28 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-3122368d82bso4621786a91.0
        for <linux-kernel@vger.kernel.org>; Sun, 20 Jul 2025 06:34:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753018467; x=1753623267;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9aDr5oRJHrA7ID3S3AHv5io5gP+ebOQU/9zSgcDQr7A=;
        b=PPHInlxjbu/iVdoncmHomg3A0n/1hO8mjL6qNb4wjsXkJhjlYxcFMHBbwoBzcl4Zsc
         emGPw6NAIOXCdPaGlbZ3LGbqqBMAv9gZhwPtgONirVBqvtRD2s7UBcWU4nXNQ2jzcvAQ
         V148RdfFyFNPiOEBylTbGdlk+D4q1w82OTMdsGTLN8o4+n3s+lsEq6bcDKPv3h4UUP6g
         W1ri3DLz0gRO0QyIXr6jhRw0sJf9zE1kVEeBIxhexUtK8yuVQEVYm1Ha/fCMOpdZw5cM
         WVMLPJcipJfGKfs1gorUA8BS5+UFN5hG+AvdonWX0Hm2xjTKh44S/DizpnKsc5TpKDXu
         kafg==
X-Forwarded-Encrypted: i=1; AJvYcCWWZmGX4124GwASpTEllwt6spBDL48PHux/GI+q7HCHSi+kdxQv2YYwgRxBwiiWfGe6pjss+OJ9tpBFTj8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOGs3N1Y9G+cScNEFk0epznmNAoVZ4naDaovMPTDf9/bnAOzyp
	pQPs3KqJFyxoy7SPflreLRgu9t7fvQwAjdH/fBzykO1w3M8Wj9MQBkQUd0Wc7Xo1etYtCoO9Rw7
	aMhUuPOyE74YLVgf7LF9QwAtxoy00SI6f+32xDSF5GDt5l9UsmWVHVOmm5Wy7puDqZUg=
X-Gm-Gg: ASbGncvrgDRd4Jnjhn2OUDbnQ+Y67UvJUFsR3mleRFpNAnftsAyYSXZTjl7Y2kInJqU
	O3Jl7kQ8cFtSlVRWSlT6MIoc1WbitXdQ4HOlhOD4cxMRURIPhDO+FVd45eNUWqHfGf4km3olh/q
	iaCw2Yojq+ig6r9LFTsrFlKnSEvTcykDF5ElNKwlphxffmLJg04wWiNlH3WLoNZfaiSxWWCZyX/
	GWfDQ6UpA4WAyX909HcADdG4nPpF0brRsrqbZwbLHYabuc9j5RM9i/NgNfSMtSUse20qsg+hs4/
	QdNtEbSnJsGOZnOQJqez222coc2T2pimB/VrpI9LlhyNKw+YPxAfmwRrnMYAz5XOIZ2OdTH3cj8
	ojvTlfQ==
X-Received: by 2002:a17:90b:5385:b0:312:e51c:af67 with SMTP id 98e67ed59e1d1-31c9f3ef43cmr21544690a91.1.1753018467342;
        Sun, 20 Jul 2025 06:34:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHP33IoISya8Q5bWiUZ17jVGNmc0QJE6AZXbO2//c50jlsBWR9t1ni8wZiqCl3Fzwxo7OxIuQ==
X-Received: by 2002:a17:90b:5385:b0:312:e51c:af67 with SMTP id 98e67ed59e1d1-31c9f3ef43cmr21544666a91.1.1753018466935;
        Sun, 20 Jul 2025 06:34:26 -0700 (PDT)
Received: from [192.168.0.168] ([49.43.231.217])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31cc3e5bec9sm4357251a91.15.2025.07.20.06.34.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 20 Jul 2025 06:34:26 -0700 (PDT)
Message-ID: <0c17d5f2-acbd-49e9-a1ff-ffac70a8c921@oss.qualcomm.com>
Date: Sun, 20 Jul 2025 19:04:21 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] interconnect: qcom: add glymur interconnect provider
 driver
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Pankaj Patil <pankaj.patil@oss.qualcomm.com>, djakov@kernel.org,
        lumag@kernel.org, a39.skl@gmail.com, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org, quic_rjendra@quicinc.com
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250716151535.4054172-1-pankaj.patil@oss.qualcomm.com>
 <20250716151535.4054172-3-pankaj.patil@oss.qualcomm.com>
 <37932b96-fc4d-4321-8986-8f975b0c1350@oss.qualcomm.com>
Content-Language: en-US
From: Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>
In-Reply-To: <37932b96-fc4d-4321-8986-8f975b0c1350@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: kohSqvhG9G-2qEzV4QHKSKKZlEHhr38z
X-Authority-Analysis: v=2.4 cv=SYL3duRu c=1 sm=1 tr=0 ts=687cf064 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=zhpjAwSWsGC/MCksz6s7dw==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=b4-VgOCz04Za3pMyX7UA:9
 a=QEXdDO2ut3YA:10 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIwMDEzMSBTYWx0ZWRfX5CGwqoWQ2Fd0
 yUgqdU/19ljzReS+YKczzFlbsDTYL20N7oGuRnFplQ23OwzqZx0u4Joi97haE8/CseiIEtp1Vud
 a6wnhxbmue5VTPH+62SnuctrsiX3bmJJMf/KTJVcTivRjT15FOHvdoFw+A/Zm6nzYMc7Mp08Hyq
 O3Z2yolIfVkfUhvDRSDZ3PqP1YaKcnYQYsMGL0+MaCIcAbrelMsJtCUSJbHYvJVjLOQUYFhoOLH
 KdzkS2fySuZpcn3BqtrHQsbxDwnVIjWceALEhWdCvv+XPOpik4iIX2Vq4SBRnVlf5S5j9BWD9UG
 igZ3e5fzvwsMDheWdQRtBxFR08ZMl/3JD+je5uV5miBusEEMSXWBUX0IyswmDb7XuuhnA3yaRhR
 QRlX9AwykFq2tbfNSr7Cb4CM5xXbdfmo3ISg/OT7OAXm7k9C17ngUEgdgHd3s9r1NHHhHEf3
X-Proofpoint-ORIG-GUID: kohSqvhG9G-2qEzV4QHKSKKZlEHhr38z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-20_01,2025-07-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 mlxscore=0 bulkscore=0 mlxlogscore=999
 lowpriorityscore=0 phishscore=0 malwarescore=0 spamscore=0 clxscore=1015
 priorityscore=1501 adultscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507200131



On 7/18/2025 2:03 AM, Konrad Dybcio wrote:
> On 7/16/25 5:15 PM, Pankaj Patil wrote:
>> From: Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>
>>
>> Add driver for the Qualcomm interconnect buses found in glymur
>> based platforms. The topology consists of several NoCs that are
>> controlled by a remote processor that collects the aggregated
>> bandwidth for each master-slave pairs.
>>
>> Signed-off-by: Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>
>> Signed-off-by: Pankaj Patil <pankaj.patil@oss.qualcomm.com>
>> ---
> 
> [...]
> 
>> +static const struct of_device_id qnoc_of_match[] = {
>> +	{ .compatible = "qcom,glymur-aggre1-noc",
>> +	  .data = &glymur_aggre1_noc},
>> +	{ .compatible = "qcom,glymur-aggre2-noc",
> 
> Please unwrap these lines, i.e.:
> 
> { .compatible = "qcom,glymur-aggre2-noc", .data = &glymur_aggre2_noc },
> 
> I'd also request you work with the author to provide the ICC QoS settings
> for this platform (which would be good to see as part of the introductory
> commit).
> 
> Konrad

Sure, will post next revision by implementing the suggestion and QoS support.

Thanks,
Raviteja

