Return-Path: <linux-kernel+bounces-813511-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C83A8B54680
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 11:07:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B72F3AA7F2
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 09:07:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30723276054;
	Fri, 12 Sep 2025 09:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="oo25e5AD"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4887425785D
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 09:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757668033; cv=none; b=VnWdfIBLoy5F9NGXiRKMwbVMpuPE/uGX2NI4d24+o6BhtwUnRsHqos/UQaxe6/xDp3kKQnCoCH2s5c05QLVcGmvsiwr/jFpjx3mJtcbm0hejsA7GQhoRvOKTMFb61qskcC74Vk0ALlLCDJW4i8CPOa68wEoswvAzrNnvYruDWVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757668033; c=relaxed/simple;
	bh=85yDsO8PhF20FmLqZR24JT8g+CrSKrf8uqrfaiGpSvM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HWd9X2aKuZC3u7ZQY11mBSsCRlst8rU4R6POXftTVW5N1BdLj18bLFoye+4yzjA3WkljIK4Of5mBNmMbr311wDvOLN/HPgVlAAqCAC/OPdTZgKWBuTyf6YJABzQFiUXJXikbBttXyTCHRilQEN9iXOe5GAl1Q5n4Eo+pAXTGyeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=oo25e5AD; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58C7RwOf027099
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 09:07:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	MSIJ/GXsYbLk4enedNLeg4cq/kc6q5Jb3qPzapXhYfw=; b=oo25e5ADt1MTZrNZ
	Ulp4yctIfu3d8hesMpKqHrq4uBX/JihDQu8a+eDlFKzluC9NVuvCiy0Yd4Q2misi
	cT6lMuQKqN5Q6RtVzpdDPgdpSGmJVx8lDDWlWJIaNDIZqQ4DEztIz318qkmhdq1w
	fg01S3bJR8gkTeRVHNFCkrszgEYzOdcsEH89yvdU31tFd2hHJLlEYaLjNUaQxoA5
	SSrbx5D8ubFAht5RyQJk3xgT5pa4D+tiaBpNVVs+SKZmIR7vZfPxCM848R1GPJ4m
	G8t90H/CQ3BwbPLqOyYxbYxe0TyFAShJw8Q9N/XZ9a4W1ONclvEjxPhiySGSYip/
	iIZJrA==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 493f6h5xjx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 09:07:11 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4b600d0a59bso5740151cf.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 02:07:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757668030; x=1758272830;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MSIJ/GXsYbLk4enedNLeg4cq/kc6q5Jb3qPzapXhYfw=;
        b=CIZiIedNeU1ZA12Hwzjp0hsQx6xKPBZgFRJpZvGLoU0uRX4y9BLiQTjFWWQTrutBFz
         a9WVgSs+VaSrupI2n3Zd7AVqLefsSPmQo/jJ2YaO6Xec95u42/tdKs+D8Z078Fd1Da9s
         XPQzLGuH6hH+CcnsCuuzl6Mz8HdnZ4FJwgJcDTc6gcpwty/6Kcv87B4ONBcygKrn4dHT
         5r03qct5U8PhHNLQ5yV+DLkVLy0fO22tAcvnNveXXpWo2GMes9VS1N5x7LKbiyUqtxMo
         fvI6mQjA8T6XFdFP1Vwj7GyB8CAZNeC8htfH9GCegpHNH/VHfg5HmsqTr8SoY1dY87iI
         nL0Q==
X-Forwarded-Encrypted: i=1; AJvYcCXBIoatR0B+KkukyetXGswbBx5CTe5YHxhezOcyEqT0z5njylUXph3YAuY1vdZ3NnUlRnjJHQyMa1I92C0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw42ZEvG7JT/POPcOBaD6s/NuNEhQTRLf/wNGrset12Yl4Z9gV9
	PTZegeL2/cF52K0I65zYViVedXXKJPkodEuV7hJfzEHVQieQMRPEcfgbhsrRLucL6vCOlUcrHcn
	fxktmzn/FldkHmEIS/G2mToY69p1cHGiNGq+tcuo2Lra+4FWLAJfgXQ0/M75dccR+5A8=
X-Gm-Gg: ASbGncs49cs8cshva40RxGwGP4wpQHX0jSWQBeQgEbQGjWnccSdzPaW3VNpuIw1NQ5t
	olE0f5EliA5qTF4UYBtNrJrM6FFOEe73mWKGtpG2nidvEhcnGWYc/88R52ME1HDKed1hmkqyhP8
	DnrE7qucPIOVS1L52b4Y2HRwX4PUguSyJBOMprn2H0vbKwwF5C6vUkQ5033/sONqoXzS8iINFMn
	oe1MvviarNNXNfkD3U7eNytzDCsYT9tRFpvlznTbGkk3JeEsZ49n7HIZjghyss9YuQOAcUvs9dZ
	jzpa5RJ+dCn0074ncj0MFv+nCboW0muivC4WvEHuzAvloY/gOVeeZJfLWmTQpYiaJ0WJKNFZEKo
	N7dO71IiHnHLrSctliqNdhg==
X-Received: by 2002:a05:622a:64c:b0:4b5:e391:e3e0 with SMTP id d75a77b69052e-4b77ce6a03cmr18051581cf.0.1757668029665;
        Fri, 12 Sep 2025 02:07:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEUlEyLOQxs7qQFthKUmU6uZH1I619WfXQPTiZx9iYgqYQClCzdepqH2oOylA6OLbhb4mLEBA==
X-Received: by 2002:a05:622a:64c:b0:4b5:e391:e3e0 with SMTP id d75a77b69052e-4b77ce6a03cmr18051351cf.0.1757668029200;
        Fri, 12 Sep 2025 02:07:09 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b07b30da310sm324952366b.20.2025.09.12.02.07.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Sep 2025 02:07:08 -0700 (PDT)
Message-ID: <51131b61-99cf-467f-b7dd-ea04c0028006@oss.qualcomm.com>
Date: Fri, 12 Sep 2025 11:07:06 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 2/2] arm64: dts: qcom: qcs6490: Introduce Radxa Dragon
 Q6A
To: Krzysztof Kozlowski <krzk@kernel.org>, Xilin Wu <sophon@radxa.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
        Ram Kumar Dwivedi <quic_rdwivedi@quicinc.com>
References: <20250912-radxa-dragon-q6a-v1-0-8ccdbf9cd19b@radxa.com>
 <20250912-radxa-dragon-q6a-v1-2-8ccdbf9cd19b@radxa.com>
 <156176d8-9b5c-49e4-9c17-c201255f50d4@kernel.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <156176d8-9b5c-49e4-9c17-c201255f50d4@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: iLTQZaC2EDAk-dgHCzNeUaj3L8YCl9hF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTEwMDE3NyBTYWx0ZWRfX30fzDiqjwPfG
 9UB51hUKkRMTw8qAT5puImofQgS3wRUI7rfhU0TlLiiNX4vrpR5TWb7cGoATH8ZCWJAc1mx7ZLm
 0cJNqqqiJgjjZSQ1aNbRMburw1Qn58MHx1Ce0wOwzJZib1uiLSpxYKfOTY3wlgV0hIVhHDMrltT
 kMaTaQOVTEGvJ0UvpBNIgYBbPaAyF5NUUThJvTD0yeJ8Lxvw3UuFMWKf8o72gYxODbFSFF6AW5c
 9ATZnRuIPlhMt1N2VqLc0xa4PPurIatrGD+C9WmyfdYyfbMbtu8QYCcWoJYZAflIrwFvSqslahD
 nQmB/qCX96uUGzXW/nGQkuMIZAgWcQt+f4eYTS/tX5BgzeTzT4qyBeAxbU+CK67gozayeH72He8
 kWHmNr2q
X-Authority-Analysis: v=2.4 cv=WPB/XmsR c=1 sm=1 tr=0 ts=68c3e2bf cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=KkcfRuYvw7IKyLBQNsQA:9
 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-GUID: iLTQZaC2EDAk-dgHCzNeUaj3L8YCl9hF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-12_03,2025-09-11_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 clxscore=1015 priorityscore=1501 adultscore=0
 bulkscore=0 phishscore=0 suspectscore=0 malwarescore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509100177

On 9/12/25 10:15 AM, Krzysztof Kozlowski wrote:
> On 12/09/2025 10:03, Xilin Wu wrote:
>> Radxa Dragon Q6A is a single board computer, based on the Qualcomm
>> QCS6490 platform.
>>
>> This is currently posted as RFC. More details are in the cover letter.
> 
> Please drop this sentence. If this is applied, then commit would be just
> misleading.

(you can include this kinds of comments under the --- line, so that
they won't be part of git log)

Konrad


