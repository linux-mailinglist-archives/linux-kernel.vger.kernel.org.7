Return-Path: <linux-kernel+bounces-796003-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ADE4B3FAB3
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 11:36:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BBCF416246C
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 09:36:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7378F2EBB81;
	Tue,  2 Sep 2025 09:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="RoCTbPlW"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45C232EB5CF
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 09:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756805772; cv=none; b=GCsAe/9FBrX56Ixhqg5EksyGtIYdT/iPaYHd6dqNbd8Pfum75sra4orCfveJAQHCEhwrlsP0PuvHc6W9ecp3FzDVT/FsQLIm1aHgrjHlbseiKIa1AsVOHtrg33J2Ii43gd65kn8yWZAxDo116OiCwAN3Iv+Om+mqu+bOx+ZWAUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756805772; c=relaxed/simple;
	bh=T+ush01pThxveIf0yG0grCHC7b6l5Pu8d/79tGLvJb4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SjWyuOKYtN3qWN+fN8v4aSWNRKjBwbMkshWRoQ8ETUNcuq1/ZTN3nTK3Ie5Q84vYvFOWOEFa8P58gZQos3Sm5n8ktcyPktKz7CCPZdCLc4rFTpg9NEM0TvbI7phtnI/NsqMJu2Z/nNeBB1vQX5cN1yaieEjsGjQVcCCz47M1R9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RoCTbPlW; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5822SGqa030247
	for <linux-kernel@vger.kernel.org>; Tue, 2 Sep 2025 09:36:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	tl/lcg8Vvutgd2X0nRCKCHGLUZWnWVuMPA89h352iRk=; b=RoCTbPlWxVKYakv6
	KKQaoyQRyVVuJWhXkduNvIRHO93U2I6kCQ5uw1pDJitUJCocwKELR6i+8TlT3SiU
	jc+ePAQ61Y04brd7oqfkT9x69OQ7IHUi7FE/F9+uyhCfjqYLH5r0JZgaAoyTXAhY
	dQj3LCNPECR+qkzrXxU/YqVSpCRekgtEn0v4dXi4fEwJEkkP3hhgheFjyznOAnrg
	PlyPhf4USp9muDHJBif6yHt7WMCqvgLSGeTOYT78IQghhp3pluCf3uJT+O6g5C+0
	8V1CDxLeOsKFQ+PdCRJL3h9wVD0rJ0lXq3F0d0sPpwv48sWhRYfvrrW/Y6Msu+55
	njEhbQ==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48w8wy34m9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 09:36:10 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4b33d08f681so3624731cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 02:36:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756805769; x=1757410569;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tl/lcg8Vvutgd2X0nRCKCHGLUZWnWVuMPA89h352iRk=;
        b=EVlD88eLBlM0J/6aTvvqm7T4FBs4S3Zq5UIwsjqmzPnV5FMen5BA6+U6HQAonjOLc/
         mLibgYMmquV3OAulKkdc3qNmeeaHldqsYANRReCvZRGSE+jinrXQb9I8DAWidT/sVl1o
         DAod5ECBCYuMNU6ot98dDlAsf6YhfwSQeUyXFbLFs5Y0qsAydF/azPw1VJh1ePDwrqVY
         UuB+UwLwLZEH5uexvNz/0Ecl8uj6voMUVWwNjeNSWhvPhlXjxUEnpcpqJdlGQmPkZW8X
         9HqdzPOEhbXgoHFZE+VPWCLyyFXBghYlItl47WzVH2yxlFZs7xSEDhe8WGqnk3vwvtvG
         lO/w==
X-Forwarded-Encrypted: i=1; AJvYcCXZ7+htBlFRkQiXmYdo66rkJlZzdRr3fDsVV5xXZXEjWEcuHg341S1EPIe8aMAGl1Hj71TKoO381BsLFMU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpS9L9tEaYScgmXOgAootS/DoObGlF6x0YGRum/ixbrd5aBd/t
	kixA/e9X5nYaUZD530CYc1ppSJzqboTvSwBscU2DF1Z6J/QIMvSShmaOqUETGhfAC+PtkF9QubU
	0BhESo4NdrcBYZ4Wk5Iv58HzSoNX9SUfI32G2iBGhpiAzNIOPKFCNL/i203ARHEJXQUM=
X-Gm-Gg: ASbGncvxdhd2V/l0e7m0NP4VdsybvpwqnlXB040QyR3eenj53dI+RLGCP2cUQBrMFLt
	axlFn01GIeF0RStxbfbWDn4VNkaRj7qGe5J/wopKu5RNq9NoSdp+5qNHMTJyHWoFVtxSB143mGF
	5YTcNaVUwQNIfoLZumPFNWFNtqtLO6nDDBVTzhsh6KQV+mD9meShXiGlZWMuuopH0mSktssyu03
	LU+otgnjxGiM4/1BMO8QwgBlFATTY+129IEpX4lAF2CsDne7wZqhOKIZpSQTQhD/gMzDOGwpS/t
	1agG0kKlNxqx8mILhrEGQvbzw/GaktrvCTbgAEQE+QLsYO51hir6Cak76Y1cErmp9Bs8olNI3s4
	bsspw+WNBTRBWoJZMmOGzBA==
X-Received: by 2002:ac8:7e89:0:b0:4b1:1e8c:13af with SMTP id d75a77b69052e-4b313b8c812mr90242821cf.0.1756805768977;
        Tue, 02 Sep 2025 02:36:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFl44Pco1b/qvJrJe/DJPXSQCR9wDNYF6uLVy6zduo7vkFZyrpgXm2kKC7QlUx4jo7DSH1DkA==
X-Received: by 2002:ac8:7e89:0:b0:4b1:1e8c:13af with SMTP id d75a77b69052e-4b313b8c812mr90242631cf.0.1756805768360;
        Tue, 02 Sep 2025 02:36:08 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b0421939da1sm527037866b.27.2025.09.02.02.36.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Sep 2025 02:36:07 -0700 (PDT)
Message-ID: <f9d6106a-d59a-4565-bc80-fa7816a1d6ac@oss.qualcomm.com>
Date: Tue, 2 Sep 2025 11:36:06 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 2/2] phy: qcom-qmp-ufs: Add regulator loads for SM8550
 and SM8750
To: Nitin Rawat <quic_nitirawa@quicinc.com>, vkoul@kernel.org,
        kishon@kernel.org, mani@kernel.org, dmitry.baryshkov@oss.qualcomm.com,
        andersson@kernel.org, konradybcio@kernel.org
Cc: linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20250818124110.8136-1-quic_nitirawa@quicinc.com>
 <20250818124110.8136-3-quic_nitirawa@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250818124110.8136-3-quic_nitirawa@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=Ycq95xRf c=1 sm=1 tr=0 ts=68b6ba8a cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=FoF8l4-XPnHLV7uwFA0A:9
 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: K03AZTrh6HPil66WGNZD3ZnNbfZ6VNoW
X-Proofpoint-ORIG-GUID: K03AZTrh6HPil66WGNZD3ZnNbfZ6VNoW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTAxMDEwMSBTYWx0ZWRfX8ju0mU6iIt74
 e/f3beTuRgPptzF7VlxrY9+SayP6WkcfWF0sn7hs10gfT6t8U3ui2YCbSsVDwG/UXXBF8iUggWI
 c/+z0sKhhOSSZ2kli0OGrcGlJXHCloCaLtYLFK44DxAECdYGZLo49Lt9M9RML4h9KBEkH2d/ER8
 DmPY/0gXGBBCcyYvvOXmdXpOhxJK5kHWS84/u9iFyvQGVRQt5JNnEDdUz7rRmmyOfoG8v2dA6bb
 dOjHbFkLSljZjvmNZHk17yEfl8L+iN06Zp3LzgV2shcv7qvlQewaXWuW0u+It1gTm1/0Fwa6IZv
 pUGsBSeS1Df3+QCZgpInPvY8sGkF79mb+muXzrlFQp3ea6hSNhDyPGPtRhJfg9SxyvePaRkUZyj
 74XqE6h7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-02_03,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 adultscore=0 phishscore=0 malwarescore=0
 bulkscore=0 suspectscore=0 impostorscore=0 spamscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509010101

On 8/18/25 2:41 PM, Nitin Rawat wrote:
> Add regulator load configuration for SM8550 and SM8750 UFS PHY.
> This ensure proper regulator load management and mode selection for
> optimal power efficiency on these SoC platforms where regulators may
> be shared with other IP blocks.
> 
> The load requirements are:
> 
> - SM8550: vdda-phy=205000uA, vdda-pll=17500uA
> - SM8750: vdda-phy=213000uA, vdda-pll=18300uA
> 
> Signed-off-by: Nitin Rawat <quic_nitirawa@quicinc.com>
> ---
>  drivers/phy/qualcomm/phy-qcom-qmp-ufs.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c b/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c
> index f7a4a8334026..50875d9609f6 100644
> --- a/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c
> +++ b/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c
> @@ -1172,6 +1172,17 @@ static const char * const qmp_phy_vreg_l[] = {
>  	"vdda-phy", "vdda-pll",
>  };
> 
> +/* Regulator load arrays for specific configurations */
> +static const int sm8650_vreg_load_ua[] = {
> +	205000, /* vdda-phy */
> +	17500,  /* vdda-pll */

Is one really supposed to be 10x higher? I mean, it may be, but
it looks odd..

Konrad

