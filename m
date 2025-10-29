Return-Path: <linux-kernel+bounces-874892-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F1995C175C9
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 00:30:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2DFA41B28319
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 23:31:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E731A36A608;
	Tue, 28 Oct 2025 23:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Ta7nZkfX";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="IVCX3kpY"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97C5F2AD32
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 23:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761694235; cv=none; b=Ktu/0KYI6SDp/00lFA2kr5GEoUqFZ3icX2kiqNYRcSi5t0FOABTVInPe5bV31Cta716lotJnfgfvPUfIOkv6k1N8I9FL6+n7hlmRa0IU2x6OW5olRDRzLLPgRGyoC6LU2In4uuzSMrnkbI0XrpHSSJbx2IwYLN1Y7+sibv/1gxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761694235; c=relaxed/simple;
	bh=QQYzuu+UNFRhwsoLlYdAVywWJIrOIBLHRRn7Jv4c5XM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cVMnzneXDvp6Ny8X59J96CrHiW8lhtW78YZyUQq1fpYMLtSxLT7vlagqoF+sTfvkjddPlC5jLQRtJ8kP5BsoZoHwfVdfog8xJ9zyAhrZxNTeXFOV8TCpiuHNdHAmRneLR667ElX8umLvXjMEjp3tofQarfMmAlrYf7gOWk5Zyi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Ta7nZkfX; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=IVCX3kpY; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59SJlYSw2503383
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 23:30:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	GrqKDmod1cw8EXiAXH/BvumVP8XpB0njFSGNTmXfBao=; b=Ta7nZkfXy4phZn6M
	Wdk8Y3Zyyfnvauwl18lhBotBpqKCBLEpAdFcIYprwmyHSM1Jn3qubwFqk/nne9QZ
	jqfekL3+odZWnPk5k6X8xUNTWkjUtko+m4DN+qYQhhVD05nkEY6xjef+Oqxogk5A
	oWZQGEzQk2qgaA4t7f2cvhmur83qP20AzKGnPw2WqFkIvgHNopGz8s+EV7m6Q6Md
	hR7XmxdVxsvKKdC+Ut4kIgpBNUD/5nuy3oGra6O0L/lxAWUh7Q7Hk1N/yKG85RyO
	udZ3n1L+LTufevgYSnG972PkxJHtU5vzav/tcn5YvbNBUJmW3OKGqPLSVIVy1j+u
	BuPQFQ==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a34a1gh44-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 23:30:32 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-340299fd99dso1513034a91.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 16:30:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1761694231; x=1762299031; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GrqKDmod1cw8EXiAXH/BvumVP8XpB0njFSGNTmXfBao=;
        b=IVCX3kpYVrBzYre809HQsDM1nfqw3McfaB3vUNPX2piTc/rOl4hzh0lbQXxzuyueC3
         Xye3D98X5PcsjjybAgn9fZ2glM4GaP0x1scdI6YFkcnVERgzRXPh2KbCEvXWRY1FogE8
         GMYL15nHhssuQfXaqepoFkdOORzAH4AxOtM7fmjiBMjw7VZOYT7D5x2f8uhMP19YLsOp
         75dxHwGlA4uqzr4PioikUtzmXi74BlsQRjG6yEpYUoqTvltSDntQ26ipZZcZ6IltqkKi
         SuizUShYPyW2oScoesD7vi/EA0bA7Q+N3DmYlSXjwdnSjgeW7h+pwsJn5BqD1G6eIoXV
         2/+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761694231; x=1762299031;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GrqKDmod1cw8EXiAXH/BvumVP8XpB0njFSGNTmXfBao=;
        b=N5F5Wo3KObdc6dFUKlEbEnAyp/TZtobzqICt/PXrAgBSzhliWhcI1aWixlh1GM8W6w
         rcGnuD6MiZ8xYh1S/368hGM59JLbzB8yTpTZN8Z789SJlltPiMIkUjoz/mUD8VmfVCrO
         PuFDpjaPmborsfE8wvQF0bIZrS3HBTiJ7d1+MsHaxR97qFae6Tfv87CshDLTEXZPuIpl
         1lEGztY2XQN1YtISggCOWFQR6FtRzseTTyBcCM2bEUt0UmHEzNtSbnLtEhu6NNLWQhUx
         /FI30NCoVB37/zxCOYBXu/prxynd/uM6PCm3W6AOiNoPz1dv0X1Y6qX1fnWqa2681GyG
         cWIg==
X-Forwarded-Encrypted: i=1; AJvYcCX0FsUA2zkk0S4qKc4or3OHe+lmiKnlFwJ3JpXD4XpHDulW1lNMtmBI37f5B16SoFfmsqVycrxRi/XL+kQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjuWltvVPO5NLjNBR753IhR4R76LrRqO58zE48tALyVbgmNzsw
	6D3QcScjbRK9F1hImina+tZ+F6GQvcwlSc2eCYF0gjK/za8HJb5AMAS43mJL5wAiFmCXDuFoL2N
	30D3cye2hKW9t121o8PV+YvGyqebR6Ex73Dx98sTLXLLunj1JwOiLaZrkHwhVGSZudxY=
X-Gm-Gg: ASbGnctxf7beCqqoLksp90aD6vWo6iGbjeOIeEJxyfhvITXATpB7rVQxn+sVOzoUxKk
	TEheVF9l8/fJ57Pi2OSq2KvpprNoNcgN3qO3DGZ2Y1KIFyvgukqmszOsomHbpvWhXbrfrbhjfkv
	ALZm8Ls7jS14Afm0pFFeC+85e1d/KXF219lJ/HV4aWXcqLIp4+l4vnNa/24idnNFKwifDkazHEC
	/le6Tai1HK1yzAZHOLNDuyG8Up1akAxZxFsPGvhQ9dQmRGljv97l3DR/Cho4B/Kt3+19CYkptyG
	xHxJd+lWDkw3sezZtTtcALqnPj11nOpIH0HaHh2QP1ZhdGrq0pqlaZ/HM6gpFZBh2QTNa00VyLI
	Xk83PDjV9uzXangLsZlV1Ng5IvWhyy0RxnvkBIMecj30DSPgMQY733IgawNrXwJ8=
X-Received: by 2002:a17:90b:5251:b0:32d:e780:e9d5 with SMTP id 98e67ed59e1d1-3403a2a1f51mr879707a91.22.1761694231071;
        Tue, 28 Oct 2025 16:30:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGeIB76rxF1ewtj7bTzAAIr67errSTWtZXbxCt6onHew8LqSAagnDxJDRLYKaevbRzo6yaifg==
X-Received: by 2002:a17:90b:5251:b0:32d:e780:e9d5 with SMTP id 98e67ed59e1d1-3403a2a1f51mr879683a91.22.1761694230666;
        Tue, 28 Oct 2025 16:30:30 -0700 (PDT)
Received: from [10.71.115.47] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33fed7e7039sm13427835a91.12.2025.10.28.16.30.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Oct 2025 16:30:30 -0700 (PDT)
Message-ID: <54602e66-4692-409b-b520-2f880e0c3dd3@oss.qualcomm.com>
Date: Tue, 28 Oct 2025 16:30:28 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] soc: qcom: pmic_glink: Add charger PDR service
 path and service name to client data
To: Abel Vesa <abel.vesa@linaro.org>
Cc: andersson@kernel.org, konradybcio@kernel.org, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251027212250.3847537-1-anjelique.melendez@oss.qualcomm.com>
 <20251027212250.3847537-3-anjelique.melendez@oss.qualcomm.com>
 <5uyhz4uv7ccsj7cevimqrsoywne6f5ax5j2t4uosz6a7due4ac@3x4ouutt5nwy>
Content-Language: en-US
From: Anjelique Melendez <anjelique.melendez@oss.qualcomm.com>
In-Reply-To: <5uyhz4uv7ccsj7cevimqrsoywne6f5ax5j2t4uosz6a7due4ac@3x4ouutt5nwy>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=dbiNHHXe c=1 sm=1 tr=0 ts=69015218 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=p0WdMEafAAAA:8 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=Vmq4KKF0IuPOMTWwbvIA:9 a=QEXdDO2ut3YA:10 a=iS9zxrgQBfv6-_F4QbHw:22
 a=poXaRoVlC6wW9_mwW8W4:22 a=pHzHmUro8NiASowvMSCR:22 a=n87TN5wuljxrRezIQYnT:22
X-Proofpoint-ORIG-GUID: uc9vLh2ufoY3GA_OqWxGhhX_oS-4C1aH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI4MDE5OSBTYWx0ZWRfX/RqkKUh3EmbS
 Cl0IDTD7LjkljOR5tfx5q2IecmPzmXqcF9Y7F30QrJtfU65z2brWeAck26d0jGLDqW00MgePsmp
 RBbAt5x/G236dblL/hQwIN+KJGgpZvJTnliM/GeH0tWav8tpy+IoJN4ysqyUu8xHVz/Y2L2pFzy
 rpFVhfBeKgRyYdzi0msd0HAlHjfxniyb/InnAFv8sZWZPHadeyoMAU1rAUYVG2b8vurbftvGbt4
 yfeem718wGwWhDenK6Za1lT+JwYJ1TAah07gkKTSDQMi2OBAIYaDgccE21VhIKjEuZMCZHw8nDG
 PGQU5N0XIIz9ve3bkITagq9xT5XA9OMvheqVt1kwCk+KTMmg5w4yNdmipYy5cdnkhOvLl9gjebw
 vDickPIJg7y+W3+eGVHD60YQRcJLPA==
X-Proofpoint-GUID: uc9vLh2ufoY3GA_OqWxGhhX_oS-4C1aH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-28_09,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 lowpriorityscore=0 impostorscore=0 adultscore=0
 malwarescore=0 bulkscore=0 priorityscore=1501 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2510280199



On 10/28/2025 10:20 AM, Abel Vesa wrote:
> On 25-10-27 14:22:50, Anjelique Melendez wrote:

>> -		goto out_release_aux_devices;
>> +	if (pg->data->charger_pdr_service_name && pg->data->charger_pdr_service_path) {
>> +		service = pdr_add_lookup(pg->pdr, pg->data->charger_pdr_service_name,
>> +					 pg->data->charger_pdr_service_path);
>> +		if (IS_ERR(service)) {
>> +			ret = dev_err_probe(&pdev->dev, PTR_ERR(service),
>> +					    "failed adding pdr lookup for charger_pd\n");
>> +			goto out_release_aux_devices;
>> +		}
>>   	}
> 
> But this does nothing on Kaanapali and Glymur. Am I wrong?
> 
> Yes, you do not have a charger PD on Glymur, but you do have an ssr,
> for which you do need to register a notifier instead.
> 
> You need to be doing something like this:
> https://gitlab.com/Linaro/arm64-laptops/linux/-/commit/2cd84e303d263d8fd5de3730714a16c29cc6788b

Please take a look at this change, just applied: 
https://lore.kernel.org/all/20250919175025.2988948-1-anjelique.melendez@oss.qualcomm.com/.


