Return-Path: <linux-kernel+bounces-875658-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E97AC19847
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 10:57:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0B984354DA7
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 09:57:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 747382F6596;
	Wed, 29 Oct 2025 09:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Lur2C1j9";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="BRE1VAqr"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F45F324B39
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 09:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761731824; cv=none; b=WXYa7azu9fjdWvQoy+C2E9Y6h5KVXT9KHEggxFHDnLkdFBRU6fer+E/+z9GKytcEfRSSteiUYuZiLfltli9URtInuDKppA6djlWkWtgnCqRvlXjg0GPVdTv0iP+tLv49fu8hIPMNBDOVo2XBqUjfKa/24HOxjUAXQLvxdcOufhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761731824; c=relaxed/simple;
	bh=zFO1aO6erZNCnEKZzjaSx9KENRHEVHys2N7NvVHVqU0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N8Y6/FWSaPOJMyfJx/jMbYarMQ/PWoS75/pa+6j9oT5TbO44hgPuODE0zAg3uOE1ZJo/CA6TO0IAKvhqejlsd+H13Tq6MGnHQLD19Flj/Y3h/eGPRyNPJqGj5CTS3X7LMDm5HIBGU8fXxPvwX/OA95jyT44n/RmGA27gECpY3SY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Lur2C1j9; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=BRE1VAqr; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59T4uuo53692185
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 09:57:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	zFO1aO6erZNCnEKZzjaSx9KENRHEVHys2N7NvVHVqU0=; b=Lur2C1j9P4kQAIWc
	RIPkHpoXkMQTAQoFe35/Kc14UqtPdJwEujwSXqLhICI0Untl3AcsEx7ukXLRF2v9
	YIZ2Dvleki1Vly9dRGLzYg9HokZ6xmF6BaKLC8YHXrX1qXoE6OH9PvFWyTIAVR3L
	ng+TDBSt8gCAPo2b5H4bxPzk8M9h0FLaLUrnvNGEUy1QPjitMqwbamd+tixQduPP
	D6IISulQIZV3Ypg1/GM+J/6O6cmMLqV7Z79xhRMex+7UBNY818e732yUpEg/pv9X
	MoPkgO5O21xU8LGqOVmY9317j+Dm4PLTf4DOpIqOAoOPsloJ41X0CHMb0+1nftAC
	xBIzYg==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a34a2j326-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 09:57:01 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-87ff7511178so6432206d6.2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 02:57:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1761731821; x=1762336621; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zFO1aO6erZNCnEKZzjaSx9KENRHEVHys2N7NvVHVqU0=;
        b=BRE1VAqrmcJfUNnsx4N9QkGiJnQpXWuCw/2Ns3M3bxO9fDqOr4qfLazTknh5Es3+2m
         29AjCsYOuemdEaHFAjcQzVy/KPMBeHLAdNGqJMLsV9VZADyyVUnPp/B4YSfK9OMTpEFO
         GnLiZ8vgDDjUxDCmUCU+yiXWmYrz/Yk4jKSCI4yx+VkPPpdpPaLlDiJ79DePMJVjdKCQ
         7y+8gibcm3BZ4FYIM2gEAV1MpWdgm7ANHshBZkeDMb7+GtsrxFqg+asg8AnEBuWYTRSe
         yvpBjsMTg+LO2swd2N4iBRFyJHgU+kkT3u1QSoD9fJ3vtWbY1MvSzpyksVSBa5xavu4g
         Nxvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761731821; x=1762336621;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zFO1aO6erZNCnEKZzjaSx9KENRHEVHys2N7NvVHVqU0=;
        b=L/u0KhHSPqBd8Dshj2T/Y9+y2r3TTm8CE9QZ4rFTW9KE1FYolKXJxV9cBRQtWUcH9L
         IEK2jE/0anCYUrjbJ6WN9I2hEEzHe7BTmiYwIs0zpKKSL3ldUp3HhTV3SBBLESVPU3T6
         h1PwRQ0Jg+sVvbmfSKOeEWDkBj/taX6AzjwIU9/kzoCw/O+lNnC2iX1+8Wvo8Km72KEm
         9lLkhMY03oDPg8GBraAypCRZNdkTifC4Wm8pmTn0rp1PzzwfWlK6NVNX3r7epfd5hDWw
         LFe2/0mHYTAMxND8YqNmUFZi+4bml1cFw2VCyAi/L2yccsQPmbhB5JmpDrQS54evhA72
         wU9A==
X-Forwarded-Encrypted: i=1; AJvYcCXV03/skXNp/EioxYxHaH0QdroN3Zv5alWNDzTmnFiEzKjRFi2IJEbIaw03jEaZ5wPGv8i8X1m5XyMcMV4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmWwqQ8Wfb7HmrHynSmFLStZ2kgf4aSNJROw7MjTt5rUkvbepl
	qCaglUWkUPW/5FWjIVpQQRcVQmjm6Jv0ReQzDRLys6O2uhzLvzlOWHw/P4VRHzKgKdyTZ2Ktvw1
	3HIEqL3+OIVY87RiQIeOc+5Pp4Qd5uDhspZdN1AbAGZRKPQENSDPafQjFsjXFkcVsosJF4J4H7k
	s=
X-Gm-Gg: ASbGncuz/3WeexfrLoQLAEP3ULPoWPE0BEYAf45DDe7WTAzWhV0uKq94a5+CzLMz+Xs
	P6OwzQq+JgbLd6zJioQbJDSkGfQra9yctnyo2QaCI+MiyaglKHHCXT2vv8UUr1eqAs2abdpz3mi
	5egpfToihFnVKhrOE9w5jbuOmHrJ4DSuRrkVcxL/2lbpkQf+uB1JKUlyq0Dkdt6A3dGI6Hhufwx
	uCLNNMkjNBvBYNHrfcuFl5brFeKJV/r7lrPdp7q7rM5497xQGYWwZ+4Zp9G+UJYtN8tslN6wemV
	M+KY1B3isixHxNL+RNf3BIp0lUNE6M3x1sf8JgSmpP+XUgCQ449KMfn5vUZzCd82w79lf76g5d7
	1PHxlcfOlqRC0epIdMbkpMBdDVgmqYNFh3p5ApEmZDDQ2lkBceb2UhXOd
X-Received: by 2002:ad4:5d67:0:b0:77a:fa17:551d with SMTP id 6a1803df08f44-88009bcea29mr18956696d6.4.1761731820568;
        Wed, 29 Oct 2025 02:57:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGCsBaGyKgmNCMDA4NCSIxtCQwj0AhQLLLMTnXbsb+Ii7K3dCO7DOjvpVRwoUPvaYD2FU0OQw==
X-Received: by 2002:ad4:5d67:0:b0:77a:fa17:551d with SMTP id 6a1803df08f44-88009bcea29mr18956596d6.4.1761731820120;
        Wed, 29 Oct 2025 02:57:00 -0700 (PDT)
Received: from [192.168.119.202] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-63e7efb9739sm11517523a12.29.2025.10.29.02.56.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Oct 2025 02:56:59 -0700 (PDT)
Message-ID: <abaa9d52-6e82-4beb-b7be-fab0496338ae@oss.qualcomm.com>
Date: Wed, 29 Oct 2025 10:56:58 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] clk: qcom: gcc-x1e80100: Enable runtime PM
To: Val Packett <val@packett.cool>, Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20251012230822.16825-1-val@packett.cool>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20251012230822.16825-1-val@packett.cool>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 8HJj1MlEqtbkgL3kPiRx7UGhdWyV61dA
X-Proofpoint-ORIG-GUID: 8HJj1MlEqtbkgL3kPiRx7UGhdWyV61dA
X-Authority-Analysis: v=2.4 cv=PcvyRyhd c=1 sm=1 tr=0 ts=6901e4ed cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Em0PNhu3BUuMovijCD8A:9 a=QEXdDO2ut3YA:10
 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI5MDA3NCBTYWx0ZWRfX/uXaY4nVkSHy
 0qnkORZnESgYe7o3icYbfQYmd3UBhJ6roiOB+Fm9SoYSgUAEYi4Dac+CYinhRuUHqWa8uszDP0Q
 YSgdES7IQyGRh98LKJfiCWBp/iXTjPchcawp/zmNJdDfsoYGl1MomeWslH03ibzgMJv0v3Q0BlS
 cvFkopJiPjYUzXkk35auEEpPw0PWvGMRA/wbCqLNV8k626ocgt7MOwAWc0VF12aNyi1/qHx4P1t
 wxWTuTeA6LzB7u7k/FtR2F+fobyHCHUhStsV56bTZHvDbxFHGYDf8WT3tpHAbjhaMBmnnri5UzP
 7n5valiOvlN4+J/WRBRu2NqHBxQ6rk9h+xSVktuDDuUiRncX9OidQps9o/HvlH03TqzgBfcOSdd
 BnFrH7r4rlBTfXQTNgUnEehd7K33Og==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-29_04,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 spamscore=0 adultscore=0 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 suspectscore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2510290074

On 10/13/25 1:06 AM, Val Packett wrote:
> Enable the main clock controller driver to participate in runtime
> power management.

The commit message does not explain whether there's any observable
benefits to this change

> Signed-off-by: Val Packett <val@packett.cool>
> ---
> Seems like this would be one of the prerequisites for actually reaching
> deeper power states.. I've been running with this patch on a Dell
> Latitude 7455 for quite a while, did not see any harm for sure.

"seems like" is vague.. is there any change in behavior that suggests
this really makes a difference?

Konrad

