Return-Path: <linux-kernel+bounces-727555-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 99343B01BF9
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 14:27:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 815611C28461
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 12:27:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A64629A322;
	Fri, 11 Jul 2025 12:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="BM13EVbj"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BAAA2980AC
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 12:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752236839; cv=none; b=hIyh1MyceIgc7vIyw5hQyZKtioJpYG6ZDXrXFU+zkmLWAdSMRkeUooQddUjbMrF8TQnVHP9XOQTfUDrf9QW/gj2r6MpKvApTpILshMjymANKqcoDfH8I5SZU9Mu+3EV2NaXs5UOiVfzbhVL3gzo2vqtoZMqouolBCusZ28PODNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752236839; c=relaxed/simple;
	bh=eF9OHglEooMPRkT+RzzUrKW3/CQXaTm6Xts5c9lE7eQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Dn9UcqYNIEE3tumNgZ3M/QB+Qb5CyORdjx4C5+XtxD2YOzSaLiFlz/FD7hhg9b3uzbmu1QSzxyWIYem9nevNpBEmrqWBLQoY/O5QvyzvDYJsghVSAnF6pAJQWHRAcKCUR19mjZJm14vQ9CxvoZGkLUsHXry0XPyF/25tFlie9Ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BM13EVbj; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56BAUOvP016277
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 12:27:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	vtZNijnRp1w5BVwcDMHaMUT6uupwS+ihEdb3Rm1l184=; b=BM13EVbjL2HXLpd0
	xEF8zYMCiAcdsd4xLg6veMfZ51PcSCe9qy602k9N1r2P1ww9GwxL2la649S+VCXj
	9pvFQrGO2Rj2WgPCTxknywHA/fseKnehgezNubHY+nhJh6v2Ouc17sUBjAaY/65a
	qVh9egMeXNkbnIA4hCgd5dDvx5yo455N7E8tTShZmUWb9eYScR0W+8JjGV0jfoMV
	gvn9pBHd9ZLIxJc1iyPxVsCPiANud+b7PAVZA9gmJ+uxGlLJJToxOA+qJTqv24By
	o4q3ZN/DaLrAT07swEit1+O6e8Xb1cBxge3e3JdRZ6OhPH9SfJZ4wY6HTg14qtQK
	XuS66w==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47t83u4v0r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 12:27:17 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7dfd0470485so15946385a.1
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 05:27:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752236835; x=1752841635;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vtZNijnRp1w5BVwcDMHaMUT6uupwS+ihEdb3Rm1l184=;
        b=n9ypnFAJLLYL5QFXEGhnv0pGGZ+OAd0L3Z1IQK8J181/EHjFtitds6QvtxbtfYnng6
         hydsp2FoY/TwD8baT2A++iHzk9um1cUTtTvyde3/TvlsVGxc7Aru5n4ynxZvSHAVtKfw
         5nHbXCK0XZLFxJQshFgov+0eoMv1UK7XqjQS2ODYu2c0qZvjS6bU3u45xRyAnqq9LXOT
         emwKRLgRs86gOZBmrasTxDhTZphF5m3UYEAC9wDplj5aDkKs8BbH9xhDkglfh+HGwlvd
         DnyP2hlpGvux0tlV1E20fTTffK1DIn5Q2qs0vZl6+lMJp0YSAq0XgeOMEGEMuitO4OIu
         9LMg==
X-Forwarded-Encrypted: i=1; AJvYcCVPyxrokVyASB/knzD6oEw/+Fndoh2tcIdVVhmo9KflOMk0qVAn41xKz1aeJPJDCHDS6aOxEixA5axcS9c=@vger.kernel.org
X-Gm-Message-State: AOJu0YycCj/ST947gME/LrqRmPYEkbrwviPliSBgOfM5dn/Bv+j3slo+
	Ndg3pNp1YD+geVdyWKP0L3EJk76kqyrzb2HObtUA7nwy7+B9EzYl/duRD4UoxUt9xDeG7d6Xz/J
	wU+4PzkqGmTASyGpmluEFZc58u3U/dXKBa3XTvxrCQKRQwN+6jUjk74/5G/gCcqGI8QY=
X-Gm-Gg: ASbGncvxeHuDBb2d4fQwRHo810hOYw28nyxtwuIh2RkI/iJvd5TtF1ogfcK4zD5Nuz+
	0dkHN2O3dNL2GwV4lfjALCF6Td9w98YVtJ4UE4O4XapOow3igMYNbELsSA2pmzp7qM9MsIjQhus
	fpl0jbPCqzq2r4wioc7yRfn1H2InH209/pMCxLUhwh57fOR5C/amWEHyvTkaLJEH3vXuCtjkWAQ
	VQOzaIoC9dS/Ozh1g1qS6ZfUkeTWai+kd8cDSOhMkhBy/DfVoaDGA3iczuqXhf9KxuCJ1T665iC
	B1FDX6a2qyULAvFG/4JCZs74iGQOBCBBSRehavv66/6lKgtHQlXvcChST7mEEetCW0eyur16IIs
	kT6QEawKS2UaDk9yYvgas
X-Received: by 2002:a05:620a:280f:b0:7d0:aafd:fb7a with SMTP id af79cd13be357-7de9784c3e7mr121623085a.4.1752236834669;
        Fri, 11 Jul 2025 05:27:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHOEjFy6nozXjUM7q17Sb+shXEs+/L0eK/zLANGZuXGxAeetPAnbYDbefoGTuUvQLgTLGjhmw==
X-Received: by 2002:a05:620a:280f:b0:7d0:aafd:fb7a with SMTP id af79cd13be357-7de9784c3e7mr121620885a.4.1752236834194;
        Fri, 11 Jul 2025 05:27:14 -0700 (PDT)
Received: from [192.168.143.225] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae6e826469asm285169666b.85.2025.07.11.05.27.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Jul 2025 05:27:13 -0700 (PDT)
Message-ID: <82482857-2bdd-4739-9c27-ec3143c68a09@oss.qualcomm.com>
Date: Fri, 11 Jul 2025 14:27:11 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] phy: qualcomm: phy-qcom-eusb2-repeater: Add
 support for PMIV0104
To: Luca Weiss <luca.weiss@fairphone.com>, Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, Abel Vesa <abel.vesa@linaro.org>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>
References: <20250709-sm7635-eusb-repeater-v2-0-b6eff075c097@fairphone.com>
 <20250709-sm7635-eusb-repeater-v2-4-b6eff075c097@fairphone.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250709-sm7635-eusb-repeater-v2-4-b6eff075c097@fairphone.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: x5ff4DMEyi8rH0VsEQv_hR_k5C0UjaEs
X-Authority-Analysis: v=2.4 cv=OotPyz/t c=1 sm=1 tr=0 ts=68710325 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=KKAkSRfTAAAA:8 a=6H0WHjuAAAAA:8
 a=9PpJxbGV6q8lFR2oJlIA:9 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
 a=cvBusfyB2V15izCimMoJ:22 a=Soq9LBFxuPC4vsCAQt-j:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzExMDA4OCBTYWx0ZWRfX8BMRLUHlcUsw
 ++7aLrReB+L/TA/tvm4/JEDsZeXt3qft9T0tdy3pi3wGHiT+K8ZtC83PNJ/s+Jtr7ibFMfaXpeQ
 RJkR4YcQa2AZP33+xZqizLs0lTuxqFBN/Sn/dCve/sPO3ETCyqoRvJiRXgNS4hjlGoRQ6wtQ0Em
 fMqTvqzbaRGjE+vKy7aQa4oLkjsESyF3IwV6xcEHwWPFTwHVkxpDwJoH6/l1TaLhKHfAfHRZVC5
 pEpU3fGFvDfuMUE+QZA/nzghivp1x6I57lwlVfax6o5mXrSsFsUMGUbo+aMx397iPrYMiQy85pk
 fZ8BK8e2x37f376Of9LB7D4djQaYx2CVr8CgexH/aeOukb9C09MiShJt6yKIKTcdzWJNTmHtKPC
 nvjvcTkEgl+bO+hZN5W79E+SspD0bLIrdXzaw/bByjLRuqATTRB/jrTLymmpJlmrTyBfSwdq
X-Proofpoint-GUID: x5ff4DMEyi8rH0VsEQv_hR_k5C0UjaEs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-11_03,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 mlxscore=0 adultscore=0 spamscore=0
 malwarescore=0 mlxlogscore=999 clxscore=1015 suspectscore=0 bulkscore=0
 lowpriorityscore=0 phishscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507110088

On 7/9/25 4:55 PM, Luca Weiss wrote:
> Add support for the eUSB2 repeater found on the PMIV0104. There is no
> default init table for this PMIC, just the board-specific tuning
> parameters are used on top of the default tuning values.
> 
> Reviewed-by: Abel Vesa <abel.vesa@linaro.org>
> Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> ---
>  drivers/phy/qualcomm/phy-qcom-eusb2-repeater.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/phy/qualcomm/phy-qcom-eusb2-repeater.c b/drivers/phy/qualcomm/phy-qcom-eusb2-repeater.c
> index 61594739e5b12706775622e1f76af6ad5d2d29bf..3d4cdc4c18becd8efd5015e698b836ad4d7cf18c 100644
> --- a/drivers/phy/qualcomm/phy-qcom-eusb2-repeater.c
> +++ b/drivers/phy/qualcomm/phy-qcom-eusb2-repeater.c
> @@ -82,6 +82,14 @@ static const struct eusb2_repeater_cfg pm8550b_eusb2_cfg = {
>  	.num_vregs	= ARRAY_SIZE(pm8550b_vreg_l),
>  };
>  
> +static const struct eusb2_repeater_cfg pmiv0104_eusb2_cfg = {
> +	/* No PMIC-specific init sequence, only board level tuning via DT */
> +	.init_tbl	= (struct eusb2_repeater_init_tbl_reg[]) {},
> +	.init_tbl_num	= 0,

NULL / omitted fields would be fine too fwiw

Konrad

