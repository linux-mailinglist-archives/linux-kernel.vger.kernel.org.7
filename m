Return-Path: <linux-kernel+bounces-832413-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C3AB0B9F422
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 14:33:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E3C23AA754
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 12:33:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A7AD15E5BB;
	Thu, 25 Sep 2025 12:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="LXBOKK4l"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A30B230275B
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 12:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758803423; cv=none; b=c80TAVCCzqb/IDwNq1UUMjJwoBed9owbe1x29amG6quHHg7YV8F0b59RS0X8oVnrzQDDpGQ2/ky5IcGjy2vJJCW26m07+nVw/FSPTS397VMxdOqqv5Lqd/nAWDS4lnZ9b24zHeuZBwRblsGZA/B2MA+RHUewk470A1bAdaQYjzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758803423; c=relaxed/simple;
	bh=R4M5M2ZmY8QaDCzPxbnLSp+trikKIHyJO3YsILvnS0A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WNAYuZnh2A3RI466CCSapJiNGdu4QYw+5Ob8U8NuNdwwBGsnYHBpLtifVqpgoDWeHzv75gC+CSbjiuldvY4R2siqvkUqrhu9glH/oGP/7QhFfqONE4bYbY6IJcQEGUrZi4K5hVf88lMqVqVEXqXZjKvf0pHCcOzTOxVKEwaTCd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=LXBOKK4l; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58P9q3vr025366
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 12:30:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	amZgcpccGdLC5wwiHqTQ+/EdBT17Aozy3dL4P9t6E1g=; b=LXBOKK4lW71Ysdnz
	q69RaiLAMMEVeCay1OW3BYJO9kK62CVPaheOhHIDrba7zJ6CZD1G4YHVueUuSuB3
	mBn1w4Rp46hd2I+dV7n5du4OnicpKJaUpOCySM5VZKqy/xIL74tTdHHNkPvOFy27
	5PzgubvvYI1YfxwfpiBAqfh1dxR90bmeWEwBkWda7dakCEWcPioH2sPgaC5Vkls1
	oFbkcPCd0QptKNhkQXWzceiId1Br2Cs88QORTpNjA2axVhg+eZPZWj1pCBA3beG1
	MHkXX0h01MiCdOEOCByUVy9fbRDsaP/zz8joXeYL2bVYsIPO7116bnXkLnJ9Vo3o
	/LtSTA==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 499hyf0ctb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 12:30:21 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4c39b8cb20fso3188181cf.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 05:30:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758803419; x=1759408219;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=amZgcpccGdLC5wwiHqTQ+/EdBT17Aozy3dL4P9t6E1g=;
        b=bOxGfOoMHrZP63P4NdPTJOsMseDXTwjGIZZKEpwsLNaZum8pKH5oTnWUxMG8aEnEuT
         viPU8opQ/9HxUqcYs+JO+8rf+8rYrAUoJCjEr+lfoVGchRqQlinFSUx4f/ftjWIVrIL8
         KR2pIEdGoVcQ/tHo3qxGf4u/wN2jL00zEyZD2vQs4tk5VCHwg54pHnH4JVYH1bpI8B7V
         piRr1mzQ8jU3KmVMkUjzxsclfZG1mQP2zUd6MlmlC9f5G6Q79octhPed9ghRNW8Vc4kV
         CYrnEF317XsXa/ovARWRrg/NDBUebRrL65mvGmsPg+IfC+BtjxGJz3CLdwFDPIlqzbSR
         +Yag==
X-Forwarded-Encrypted: i=1; AJvYcCWT0PqU7QI6ZGZLNJCglOJ1hJLBcLCyjoW5hAkj+4ijST+233tPruw4YlROHXO0/IQk4Z68xHbKtk1hQ8o=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWRLeDfZsAvLEPqJjJ134iely7HbYF6/t2XbL0JdPrJw6EJpBt
	Hkw45jw/AHXCSYezP25RgEf/EVNqhNPEy2Wg5trRVBZP8XWO5DWPbP2d8IlM7ALq5YsVzC0gN+c
	XB6B/22ASBJ8G+xGwsmVUaBlrpjCk8LFjtHOiwqlPEZUkfwHyg+XcOeb71MC4P8adf4Q=
X-Gm-Gg: ASbGnctxa1fg21MVTcYpQTauHntUBe3aRLaW0JIWAw0DlB8njxigOzRMT3LWEGHkJAA
	nWzL1sE7AKSZ6VRdxX/nAgIkSdsHpIlGjGqqKpQnYoWyb+7XsLYBtLFeZkyO0W1svYVbanNu0ZC
	VxxLgEH7JnBma7v0Yb+b/gImwNdmVy+1uUwUlI8VJ1S7uLJ0btpd7vZQfydt0rIT+V7rc1EPCxt
	EDgjbSQwePpkU4KEFAvlsde9nmoQTWOTQsu8rg4ICS5fruwhh1gb/G77zmA/oWZwmV+0vN7sHgm
	icp8tzoPXTUL0I9NsSNQofq5Q5RJ6E17RdMpkbmtZ5Upc2JWnvjDe90mPiSeAq3Myp91fU5bVdm
	nB/ErX2ZwV0ovMc88CujS4Q==
X-Received: by 2002:ac8:5f0a:0:b0:4d8:2245:e23f with SMTP id d75a77b69052e-4da4b61615dmr29844571cf.10.1758803419277;
        Thu, 25 Sep 2025 05:30:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH6euFUgVfoOSGViTvXNdmeEkohF6qNoOdRCv/QUVcIdRorA7aKF9PTXogf6x9XlmUrcxL0YQ==
X-Received: by 2002:ac8:5f0a:0:b0:4d8:2245:e23f with SMTP id d75a77b69052e-4da4b61615dmr29843321cf.10.1758803417562;
        Thu, 25 Sep 2025 05:30:17 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-634a3629a29sm1149714a12.7.2025.09.25.05.30.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Sep 2025 05:30:17 -0700 (PDT)
Message-ID: <bff00962-f417-4e6e-8c59-614870bd3a7d@oss.qualcomm.com>
Date: Thu, 25 Sep 2025 14:30:14 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 17/20] arm64: dts: qcom: kaanapali: Add support for audio
To: Jingyi Wang <jingyi.wang@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, aiqun.yu@oss.qualcomm.com,
        tingwei.zhang@oss.qualcomm.com, trilok.soni@oss.qualcomm.com,
        yijie.yang@oss.qualcomm.com,
        Prasad Kumpatla <prasad.kumpatla@oss.qualcomm.com>
References: <20250924-knp-dts-v1-0-3fdbc4b9e1b1@oss.qualcomm.com>
 <20250924-knp-dts-v1-17-3fdbc4b9e1b1@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250924-knp-dts-v1-17-3fdbc4b9e1b1@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: xM1ipkeXkQHf2P2oFEQ6qohqm8ZLcJ4I
X-Authority-Analysis: v=2.4 cv=YMOfyQGx c=1 sm=1 tr=0 ts=68d535dd cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=_ouoMj-Ftme1J9xZixYA:9
 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAwNCBTYWx0ZWRfX94zfEM8GhRnu
 2gYyUDKqPr9ea+lIHeQIk1Ii/jbQqaAMxIjDaOp5itLnsCLOFl0zubpEwllNkFtPgs1mZe5s6/3
 ke9bZIwCOGddHa4qdwqtlW6xD7ciQ+wBxD+2KRe+l8kLb+LfDlt6K3oGnHT/7pk0vv2Xho/roFY
 KhwMvhZeGgDSOXKdd78tV5XZkDzbbbGYkHXqq9ZMDIKBKiDs+RRW1H5BXB61XIpwWyLjvhYB+6i
 fh+6J+6nfbBjhPVp53ScvivWHi2+12CxZJCB3mWzYKTr4sYYiv4p9ZOH8PVm4luA9QpAh9zI09R
 7L6KlDuJGFxWYTS6ZYfpOtdBQACqpUq2RhabLg6EBJphBkKkNXEmwCUK56X3K2EJjL2D2kaVrKV
 RmY9wPwF
X-Proofpoint-ORIG-GUID: xM1ipkeXkQHf2P2oFEQ6qohqm8ZLcJ4I
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-25_01,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 adultscore=0 priorityscore=1501 spamscore=0
 clxscore=1015 suspectscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509200004

On 9/25/25 2:17 AM, Jingyi Wang wrote:
> From: Prasad Kumpatla <prasad.kumpatla@oss.qualcomm.com>
> 
> Introduce audio support for Kaanapali SoC by adding LPASS macro codecs,
> TLMM pin controller and SoundWire controller with similar hardware
> implementation to SM8750 platform. Also add GPR (Generic Pack Router) node
> along with support for APM (Audio Process Manager) and PRM
> (Proxy Resource Manager) audio services.
> 
> Signed-off-by: Prasad Kumpatla <prasad.kumpatla@oss.qualcomm.com>
> Signed-off-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

