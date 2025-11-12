Return-Path: <linux-kernel+bounces-896963-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 54029C51A5A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 11:28:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 40C854ED941
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 10:23:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17C952F0696;
	Wed, 12 Nov 2025 10:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="A3D2P2Im";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="WpNVcgUL"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ABD02C0283
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 10:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762942973; cv=none; b=dX6yf0lRg77KIqd4Exi7FYuvb/8xhTGvI70R4L5ioHoo+xENrPK0n2CR83v5+hwwZSCkH/xEKlEepXFjhTESDSgdfI5flBKqtWyj1rXHrIOXFzL45uUw5m5gSd4XI4omQ+gCFj4ol7fqOr3xTgUkUpwfxcmSb0nqT5mgbjoJX5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762942973; c=relaxed/simple;
	bh=dkOkT9HWZuMRwVOPFG80dYooCAaGN2chaqeXAY7vEXU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=om3Uvc4un225/02BynGs1orZegU5DIkBvYzAJ0yDM6zp5qzYEa3Ka3G97f9aiq99KExAKKncS+hWNRGVstCBgGNkOUz+RgfPjfpqUXnuFw5cgurtFH7DylzWi9SrEkCNcWHfv1BBpGfiWQYj0mmkfe+LlUP3fNgbtvEpH/4dfeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=A3D2P2Im; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=WpNVcgUL; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AC43JkI3060103
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 10:22:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	5rwAyU0aPBERjod7wgKA1iXuGw5l4SeREMu619RQNrI=; b=A3D2P2ImD5qeuGzo
	jpBbHoHhTWoTnBAVC6dE7Q74dffCYK3d80Avh5EWOL9OPMibphll25jw/a+c2fLK
	C5Xv6OpsbOgjUViRvORZ+CEajalz9Rufz8i3y5mJ2xlMsqWP4CYR0jS6FfxV65Z5
	d867ln9H65q5ZU2XS8q/+NvwyDNLhI9aTeuQXWh7xnlDZOaHMasR3hzUsIAjzWVE
	evSA5abf0Rm28Ey5jE+QIs1WuH5Y0eqCeH35kW5hDrm/kkpjf/WzOU/kUnT+0InI
	kNXy1SsstRtaRY8vrTCrNCkHCRaxLqzO05nSOfn6qD8vBhrVoyDKg2u63Tt/Z4Th
	9sFYBQ==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ac988jr0b-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 10:22:50 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4edaa289e0dso2531871cf.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 02:22:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762942970; x=1763547770; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5rwAyU0aPBERjod7wgKA1iXuGw5l4SeREMu619RQNrI=;
        b=WpNVcgULTtW/6vsvJhBUUJmaEai0/fPfsn2K9hmD95FB4oYBfhFITDDCF1fYoew3rP
         dvjg6/Nmr4YFdD74zerD5Joo6AHFTNpbsXf2M1OSnYtzFyEMLSST9BGG8xDTR6jLYUTE
         TrJnATylRFK8kj2G148L9ZyEBnKehXaD0Kp/ma0nJ6XTLLUBQ7IpPPc2UBV8vNqYEKY4
         eOOmr5ePeeG311YWIunom5lu2pUXD6qwsqifc9XfaVto5YiuFAqJT7E9sSLTp4O6qozM
         34w5jozkzQWxyBBRH1Bzv6y2zDeDc/c2QkM+YSFPl8oCaq9VM/tLPqKs4dRzrVNz4Gfr
         kEIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762942970; x=1763547770;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5rwAyU0aPBERjod7wgKA1iXuGw5l4SeREMu619RQNrI=;
        b=gTJPj97snhXomYH6qwh5MPyZroymB/R91B2kRs26+9BOUB09ghVbp7DDeh1qiNL2d+
         ga5BCu/JCQS1+BQ7wBRZStdkukKsIPbyqW2JBwcC+muKss8psOttcdJbTpMomvXrZdkB
         NIpWjRarofirb2y0sh+O2c8Wye9kufyrV+WaGgohN3LIbAV7FgICBcvRL3wK188egV70
         nbTmqueSwMh+jzswh+nKltgHqszks90/ymL3jD3EdvhifsA/zxcUmjAIp1efQyAOgRtA
         cmhTmTWk0SB5efQJn3R901evoWNcTh8Wvl8gXfycwPp3K8zE6X+rsDRBtJ5nUDpibDtg
         3BZQ==
X-Forwarded-Encrypted: i=1; AJvYcCXaJqJBqjmI+nYXku8wcskru671Zh3QONDmPbkzt3jNMkKNQJMrDhEUr8YoU55Gq2guzZwDI1guXMBqOm4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqhZdKG+CLOZgOfDjvgiAKAwvc+zVEhr4FBpfTb6OmybAzgewl
	2mmXBjuxKdaH/5+oMcTtG5KP20lXxijo+bAMpaI3mlqsqWYUJ6nuEW1AYVG6ZG2bZ9Z9drdNKXr
	KZi8zLPMAs7YO34mxl8F5sBPPt+efOeCbuzoOeMgwJ2Up18V/J7RoRZem9TdbFPJr2/s=
X-Gm-Gg: ASbGnctO2grVDusjtF9Rgjb5XMC53F873uhOjWCK/JfQegsRS10A5n0Z+QI6GTRtvV6
	DUiC6MNEtCLtOVlVHQORGwgyvjPj+l0ZsKZ5QWtOoG5CxLVR5/R45W9XrA0DRAExmjOWXijit5u
	P0pp+Bjknn4VJLJRs+p+BoRtirTT6FBkVNgr94kjPAQLxCwwEglEX72/XrYaZwGgXImRHSG2uQd
	4AvdQdcmjcK6hDWR1wbswLhHNbdVld39RBobsaM9YTNrOIJ8fZJ4gsaDKJP/sMGy2caH6dOkyjq
	yXDZATfFlj+v89cOWRevMCVObVzewGXOR43uPfV0Co07MX6iYvxL+sMkjE5rv9hih6fHM0Jyg26
	BugSuV1NwDJsrCcrxzWHL5AMQlYj1i9Mc6JHDce6rdFuL49e53KaM7XWH
X-Received: by 2002:a05:622a:d0:b0:4ec:f53b:418e with SMTP id d75a77b69052e-4eddbc6bc3dmr20363071cf.2.1762942969395;
        Wed, 12 Nov 2025 02:22:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGebY4K7Namd6glwHLtMAZE0lf4hL9guGKfOfliFjM5eEuz55Nipc9SN3o1JFfip8JTUrox/Q==
X-Received: by 2002:a05:622a:d0:b0:4ec:f53b:418e with SMTP id d75a77b69052e-4eddbc6bc3dmr20362721cf.2.1762942968808;
        Wed, 12 Nov 2025 02:22:48 -0800 (PST)
Received: from [192.168.119.202] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6411f862bd0sm15744925a12.26.2025.11.12.02.22.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Nov 2025 02:22:48 -0800 (PST)
Message-ID: <28d62905-c191-4c3a-995e-a4146ffce619@oss.qualcomm.com>
Date: Wed, 12 Nov 2025 11:22:44 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/21] drm/msm/adreno: Move adreno_gpu_func to
 catalogue
To: Akhil P Oommen <akhilpo@oss.qualcomm.com>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Sean Paul <sean@poorly.run>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar
 <abhinav.kumar@linux.dev>,
        Jessica Zhang <jesszhan0024@gmail.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Jonathan Marek <jonathan@marek.ca>,
        Jordan Crouse
 <jordan@cosmicpenguin.net>,
        Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Connor Abbott <cwabbott0@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        devicetree@vger.kernel.org
References: <20251110-kaana-gpu-support-v2-0-bef18acd5e94@oss.qualcomm.com>
 <20251110-kaana-gpu-support-v2-5-bef18acd5e94@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20251110-kaana-gpu-support-v2-5-bef18acd5e94@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: WyhUK6HJJBKmzqMx88ICelw2Y5KKPf-v
X-Authority-Analysis: v=2.4 cv=eO4eTXp1 c=1 sm=1 tr=0 ts=69145ffa cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=p7PcLuspDTVbkQel-sEA:9
 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEyMDA4MyBTYWx0ZWRfX/V+aUkZz9YfH
 7tYk0+AGIQN9MEnUZSYrmDumlz/d8d0AjpFgNVltXC0Q/rXyyM33stjwOJFtl8bb116XpCZoGpu
 Fb7UUVTc42Xl/GAcRBdkwmn3MoCXOuFL21J3Vm2EKzWL/meZnHNMWRUV7RFFpgZtsaDipmLtE22
 g2k0KufamN5bD90SEMJtj22Q7hYF7FOAvpc+NcfHHr9HLdqRMqlfs4NOGfL9n3aHRWfsd/4MmCz
 oxr7YCpGIObU+vFihxgo9LZh5UE09Di0avYatWOl0cHYWzbTJsUc7QdgbNvh+o437M0chiVyHwO
 opO5BUKjdx1sGF8WG0FdwZaQWbWLsx/IpeHP3QCBhvMxqhqSpDLRVY0TjOtmufU7yOzMrJbjn5T
 tw3WKAikVKfVsAugLCkT/R/S/VH2fA==
X-Proofpoint-ORIG-GUID: WyhUK6HJJBKmzqMx88ICelw2Y5KKPf-v
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-12_03,2025-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 priorityscore=1501 clxscore=1015 malwarescore=0
 impostorscore=0 adultscore=0 lowpriorityscore=0 suspectscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511120083

On 11/10/25 5:37 PM, Akhil P Oommen wrote:
> In A6x family (which is a pretty big one), there are separate
> adreno_func definitions for each sub-generations. To streamline the
> identification of the correct struct for a gpu, move it to the
> catalogue and move the gpu_init routine to struct adreno_gpu_funcs.
> 
> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
> ---

[...]


> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_catalog.c b/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
> index 44df6410bce1..9007a0e82a59 100644
> --- a/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
> +++ b/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
> @@ -683,7 +683,7 @@ static const struct adreno_info a6xx_gpus[] = {

Somewhere among this diff, a619_holi needs to have gmu_wrapper funcs
instead

Konrad

