Return-Path: <linux-kernel+bounces-865603-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A1C3BFD888
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 19:20:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B495B4FB5F6
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 17:20:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81D2B28EA72;
	Wed, 22 Oct 2025 17:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Thifikf3"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BB6F27FB35
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 17:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761153600; cv=none; b=N++Ew4UBjAKr1d8yl+NSJuP53+NR7n7cIzylHHW/gk4Btb14Y+qJKrAScoRj8NkJLbA52LxQvX+/vFR1LOACLc2atbSmDIftbB97VwH9L9zpNC9TEjKr1F68GnBOXTtpl0oeTuzTxTi/3GfLDJV++HZ//22zMmgcK+YynCYxDgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761153600; c=relaxed/simple;
	bh=p5nAGxvrAUP5cnUmvYosqNhypEEgsoHxE6IFoeIxcbM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a2p5zKzlxGsRzHvtdFpZUEXSGwRqeNclNiB5DC5WorUVCjqwRHtRMmvZLsgASNG7H+px3nJ94mt8aoE9kels9O04JjmneeRvu8t8aWkfkzWQuzy//STzS/heP4M1u8U+D9GWIavTPGrvyNCGwrbFnTkGNJaH3P8kptKP4d9ZBkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Thifikf3; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59MBor0g025592
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 17:19:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	SUfkHbNbJjInMBUp59+fC5w+6y+9d0fh7BrDW/sPOT4=; b=Thifikf3LnJuWReu
	Oms09SqNSFn85KENiEgeyFlT7i/h4ffoZl8TTyenEG3/svCbOpuyoAcFS/Z7WjrC
	XkzihHx2j73/oxs/t229GgqgJvRtUsRk7dzOYPrdLcDm2WiwYGxrvNTynD26Mm00
	zOQp3mozMppiiz9p7Oxjy5gDk7fRMY2bra7mwUIoelplbkghJ/okSXMdvDirHh99
	+5bDJqa9yT4ZAkcSHuwVobSMpOSHUvei7uhwXTyxpLZpwyF/vUAXCAdK3+H04A08
	gS5yh0qG1CWv3uO+wcoPY5wMvdjZpR1wwV6dCC/Zks8brZoTLPJPudRK8RixwMbt
	AfHO4A==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49v1w85j1u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 17:19:57 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-87c19c8393dso24041046d6.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 10:19:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761153596; x=1761758396;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SUfkHbNbJjInMBUp59+fC5w+6y+9d0fh7BrDW/sPOT4=;
        b=QuXX7BF4zWF17QKOGFk2jj11WYWB1PGP+E+WqKdlyrm1HtHoa/8D+SiT+ag4vLLCKb
         opj+EZ1pqpoSPJ1Wz2+mw/Lga0Xq5eL2CxuxUxIZRDLyStxoRwfxMhq/iGCoy8nX2H37
         AoY5jqPZ1E58XGW1xVjUuZvXQ0+TANivIfJkwYF9/zoFSGwX1KM28i/XkuZ+Dldd8SJQ
         LzppCopKlFhr2JvSlf7mNwfNIbQJW8OfjO99FUOs8LxssWlM/EhyQeGvUYL71zpVXYUk
         9aWg/PoZMCcTuyCnRtieXNC7KwwPVKqbDqh0EB1YMR8oNQRNY/8hmCTed9PRbK+A3ZHS
         4XHg==
X-Forwarded-Encrypted: i=1; AJvYcCWgaG5HsfxFkZTftojq3MYYX7AZIccIbHkV/NijnChxelN71yaS3nch1Gs0GmDGtiixfamsPcDFs2W6LZE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWJPFjSlETcxHLvhPlsExLrxh0sdC3ruBeD4580c0MnqoxEjIn
	NTfssq6xVews+hxJnNpFv3vrQgve5xD9gU3vaFmhC1fvvVYnn1HUeeyf3iV7FVyiO6UgIpB2l1t
	15VXOy7TmZ6wjqUN5WdF4xX/RQ0OP3TVVTHs+P3kzhiMdUUu8uoyktuVanGiF7JHruMw=
X-Gm-Gg: ASbGnctSelu1Fo7PD+pTBbwVY6ivRx1N2FEfJHCin5Q7pReXl0IaIztCOqPRqGGUA+T
	MFKFaNIYGNRh6tVY3HGiHnJlqRcgFt2gLwK82Hhhd3CTPFOooHWp08fI3aptNbjMs2AgIAyQk+B
	/2LXZetkA2VG0Z1oqdlBjKX/mjCZiiVEjzdyrfwGit4oSNZhk7EYwDJHR/YcP6CGyJs3YTAbizW
	D/aY8vyracdFrOEP2ScAI5dFW+NSeMnslWaAVbnQ429xBD+nBz+dxC9TBTNGzdUwYFS68zwa3sH
	Qt7QvpD9BbiLkDHPMTFoXfiYWsjeBdXVp1l74FwnKclkq3lv8HWr+DpCCmi2e5AdokRFGfcgjcP
	bzOVEPlxMpiv4ljPB5wCXaJEwPRJLtd8YqJ5klKPoIFr/uwO9GCo6o5kp
X-Received: by 2002:ac8:7c49:0:b0:4b5:f521:30f7 with SMTP id d75a77b69052e-4ea116abda8mr69679871cf.4.1761153596309;
        Wed, 22 Oct 2025 10:19:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFoDqiu6KupAbR/QDMwKjaiqJhOG1EKNGUxTwxB/cS9oa2UhBHiyfq+I4SkjnmLz6AmKkPWeQ==
X-Received: by 2002:ac8:7c49:0:b0:4b5:f521:30f7 with SMTP id d75a77b69052e-4ea116abda8mr69679481cf.4.1761153595715;
        Wed, 22 Oct 2025 10:19:55 -0700 (PDT)
Received: from [192.168.119.202] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b65eb526490sm1376226466b.65.2025.10.22.10.19.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Oct 2025 10:19:55 -0700 (PDT)
Message-ID: <6235f1f0-6ae7-43b5-a881-d5bb7d8bb8b4@oss.qualcomm.com>
Date: Wed, 22 Oct 2025 19:19:52 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] dts: qcom: qcs615-ride: Enable ice ufs and emmc
To: Abhinaba Rakshit <abhinaba.rakshit@oss.qualcomm.com>,
        Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>
Cc: linux-arm-msm@vger.kernel.org, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org
References: <20251009-add-separate-ice-ufs-and-emmc-device-nodes-for-qcs615-platform-v1-0-2a34d8d03c72@oss.qualcomm.com>
 <20251009-add-separate-ice-ufs-and-emmc-device-nodes-for-qcs615-platform-v1-5-2a34d8d03c72@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20251009-add-separate-ice-ufs-and-emmc-device-nodes-for-qcs615-platform-v1-5-2a34d8d03c72@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAxNSBTYWx0ZWRfX+FkgSMAqYYAB
 oBRbwktmkOIi59YzSFusQqJPoq2TNhY+rTCda7iVQYc5GJoFO71iXF7bMZpbREA2FhGyRlC1fdD
 5ZhSQ6hRFV3/xilbVpdFg4LoYJ2xqAbVuxx4v7aXBea2Ja7VJCui/qNZeHJsHfeCDkI5P2mMgYh
 T+jB/vp0dumLskge00wzTeuQn7LFmFdG0ivzOWP0+COwcLRX01rgKBpKTvX1pruAFx6QiTeEEsT
 xLmkRPZP81dzPBfYaLgF3eWMKtRKNP+aRwphMen+rj8KeP77qyGwyBnUJ78AaJbPAvtIdknHbVx
 xo3nXsVdLPKKsJitBXrmthA4G8YNLmCrrFzDaVduB/uYCmiu9Y9dAzprS0T/wxiU5V+WvPl6ctS
 uGBME2RwDXMdanRsJxg/6rm4FNLhkA==
X-Authority-Analysis: v=2.4 cv=bNUb4f+Z c=1 sm=1 tr=0 ts=68f9123d cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=67M-hd6uxsQcvR6J9HkA:9 a=QEXdDO2ut3YA:10
 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-GUID: x4k2lN6ZFBZmKkso9MQIAJsuHn4I8JLx
X-Proofpoint-ORIG-GUID: x4k2lN6ZFBZmKkso9MQIAJsuHn4I8JLx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_07,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 malwarescore=0 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 suspectscore=0 adultscore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180015

On 10/9/25 8:18 AM, Abhinaba Rakshit wrote:
> Enable ICE UFS and eMMC for QCS615-ride platform.
> 
> Signed-off-by: Abhinaba Rakshit <abhinaba.rakshit@oss.qualcomm.com>
> ---

Is there a reason to disable them in the first place?

Konrad 

