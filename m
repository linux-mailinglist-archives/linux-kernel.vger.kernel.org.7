Return-Path: <linux-kernel+bounces-796343-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07B45B3FF30
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 14:08:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84915165D5C
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 12:04:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CE913019C4;
	Tue,  2 Sep 2025 11:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="aFxpIqZY"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A98D2FD1A7
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 11:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756814279; cv=none; b=SYFCzC5BVxG0WmGX2FmBzxAV6z9z4XeifeJUq2kFmlgwsd/B99FzZgYvRP7weFooHs3wqx045aRtnMCEBrUgLX8IeSj9S6NqT8ZFJRmP/ZzES+QFyJBmd1EppwOiLF8nmyOQUCq3yxiLpLS92fRtUpFSHLdscqOEEn1jaZQKILE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756814279; c=relaxed/simple;
	bh=TzemwMGClTnkqT7pUTCqqSTRsqocfb+tRl/whEuV/pc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d1b/kZhWRA2e23n4Ptv7t7/RwXBLxUX1yPZHhuJVeCXb8R5772ZEMVKxY3FpIecFyXGdj05vd+lN5tctjYil3Ku53nfKSw+5dF701vMJZ1TD+XmgQHoSLK77Snu/G02TBgc2S0DNoo81fm8aHvOmroDa7V4Lj12836vchYCT2xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=aFxpIqZY; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 582AlIJq012350
	for <linux-kernel@vger.kernel.org>; Tue, 2 Sep 2025 11:57:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	MazPpVuDeJMNCKtDs4XLR9LyNM/u+un8EIv85mq9gjA=; b=aFxpIqZYns8dw0mY
	Bg0vH/Cvn2DW9068Uye4ozH+kmt/vDQYsux3Ao7TlcanvC6hiVVkHeUma97RH1z4
	qJSapKjmZCVUr7HHi29eVqj9olAZC7oG9CsDqkfegL5yO1XWzyobTyUnFSKNkJeg
	gfP1TaxVTCw9E4rvdqrpWY61ug4HoI/HA6y4QKgX8euSWL3uJiNGybny3CCfz2Cq
	2rUVAF1/POrCCoJfifnO3IKv92NMzQVUbkJIXU7g4wZ3X/K7QqtANEYALS/zfQ+w
	tr8sHZ2dh+E/F3OsVvlV0TlQD3z9eKyz8Kyz32h4Ke0ONFyIurf5bqO8NIUYCaoT
	fo6KOA==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48ut2ffjgw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 11:57:57 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4b3037bd983so28914911cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 04:57:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756814276; x=1757419076;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MazPpVuDeJMNCKtDs4XLR9LyNM/u+un8EIv85mq9gjA=;
        b=Ht0pSXauXz0LuUnybBIf0ZNoDX4B5BOTLceE7B/twOCN9sucU3QTaDC5VRb832pzeN
         XDbAhwJ47390Buk97XHIONHAanaCoH3wIsQ9SNx9XBytEP36B8XKovYJaNmzfb2gAIj0
         eKncid/OxjK0hKU+Av/gij9qkpY4DNFzmGKNXHBgKu9qWCpuo4qepC9CfJaets+Nx5qP
         BJCnTWRiTRor1aPuYN4AZ4Y5FfdM7mxKdz8gnn5Crg0eUm1lnHJDf6zQXDUW09mt0mbh
         IHHiyHWs8MlqgcJL2VvqVi3w0JxRRUlVhzMutXnDIclCsclTvmFvthGQtYBrDN9f3FcE
         0TsQ==
X-Forwarded-Encrypted: i=1; AJvYcCU2uGscIyNr5HU8pDMLHREqOanPZGc06qlsTZaDj2f1y1dpnfFAsCzh+TXt5gXbxzgdgXEaJjAcEDGor6k=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWyzyOjCD7fj+o4s1eGgK/5Mu7U2tQzMkfdRmlqI/liZZnH5be
	Dd8PutRu2E8jI5Tg3bfbcJxI2cnN9WdhTo6bBCzoRzqxpeOkpy5MmZ09oMjIhPMtNn0SZNYJFHA
	4Tr9ohdSHT7TxIJr1BFmXXqYSc/SEhGVS8kjukMX1I4UFlGkdjIbzf3kmY7BNiBkatkI=
X-Gm-Gg: ASbGnctFl1lIuftlsTcxaCRlPBeyJHhkj4TCGCojCwiHX2HBVTrIDSD9KZb9mYQqH+R
	vp7a1stGXcOxM02Gvxesag3Dav34636bVGkOOnAl9XepkkDUdRASFeVjambR6RHRjCxUf1r9k0E
	OWhjZE7uHCxyMm6abTY3oEUFEmrqJ/WedcME7rknsX/WrbQxXUWuepdRD150yVesIsmq7dt4GHs
	MJwEQL2/64fD9PK2v8f6lJlzQ3XWMGRCV0TQu1myWV0ue03EJm50ELt9fyJYYYcWn10fNJ7Iz+M
	hC+nYPukH+PLFPMws9H1DeU7WjasmghkA13H59tRogka3y8GTAli2Le3ijmbOP7xgJiMf2a2KFa
	Si9lJRQ02UiOhX5YgHyKRFQ==
X-Received: by 2002:a05:622a:612:b0:4ab:80f9:f992 with SMTP id d75a77b69052e-4b313f9850bmr102404781cf.12.1756814275881;
        Tue, 02 Sep 2025 04:57:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFLJ+ddzSRzqFRRND4j25pKq0rRljPojUEf5sN7VqVHHPTlbG/zvZUEWarcEaPDNy+4ghfnrQ==
X-Received: by 2002:a05:622a:612:b0:4ab:80f9:f992 with SMTP id d75a77b69052e-4b313f9850bmr102404371cf.12.1756814275344;
        Tue, 02 Sep 2025 04:57:55 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b02d8812161sm813251266b.73.2025.09.02.04.57.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Sep 2025 04:57:54 -0700 (PDT)
Message-ID: <484eccde-bcab-42f8-bf6f-b370fc777626@oss.qualcomm.com>
Date: Tue, 2 Sep 2025 13:57:52 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] clk: qcom: branch: Extend invert logic for branch2
 mem clocks
To: Taniya Das <taniya.das@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd
 <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: Ajit Pandey <quic_ajipan@quicinc.com>,
        Imran Shaik <quic_imrashai@quicinc.com>,
        Jagadeesh Kona <quic_jkona@quicinc.com>, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20250829-sm8750-videocc-v2-v2-0-4517a5300e41@oss.qualcomm.com>
 <20250829-sm8750-videocc-v2-v2-1-4517a5300e41@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250829-sm8750-videocc-v2-v2-1-4517a5300e41@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAzOCBTYWx0ZWRfX6Yj4xdiqOUYn
 sRFWwAt2YRC1yCdSgumI9LrIx5ILbwnt5J03uDguSu4ofp8CHiSmdKlaM7nPxtkJi/9VnhU2luv
 l/LIPRiXqh1XqH4j4i71TbPNuz6ZJL137KN9INfKx+05q+F/akiF49zA2GW+oiez5Mk9JTo6p/A
 nAt8521cImbfCzBoZuA3VHm2KnGvitjAym8r+nu5WgrnauS0TmteDLNpbMXPCG2UK+bS8BYPvij
 7i6YU2puDBFkYLV9X/l4TZ7zrDgOHiZ4YAORXnJJlp8/UzzUawu5IR88NdHvV16QkUAwy5qpubd
 +V6z+JVoPVbORHQNt/wETUpN0xWu/HM4YYlsz9RW8V66jw08Vj3pmSBg8PekF/QgginQ9xlSrrE
 36cQuuE5
X-Proofpoint-ORIG-GUID: -KNEdHprjeRwzsjUklXglMJjYkeySOkd
X-Proofpoint-GUID: -KNEdHprjeRwzsjUklXglMJjYkeySOkd
X-Authority-Analysis: v=2.4 cv=U7iSDfru c=1 sm=1 tr=0 ts=68b6dbc5 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=Uv4cyzw5Fqc3vRoc6LAA:9
 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-02_04,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 clxscore=1015 impostorscore=0 suspectscore=0
 malwarescore=0 priorityscore=1501 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508300038

On 8/29/25 12:15 PM, Taniya Das wrote:
> Some clock branches require inverted logic for memory gating, where
> disabling the memory involves setting a bit and enabling it involves
> clearing the same bit. This behavior differs from the standard approach
> memory branch clocks ops where enabling typically sets the bit.
> 
> Introducing the mem_enable_invert to allow conditional handling of
> these sequences of the inverted control logic for memory operations
> required on those memory clock branches.
> 
> Signed-off-by: Taniya Das <taniya.das@oss.qualcomm.com>
> ---
>  drivers/clk/qcom/clk-branch.c | 14 +++++++++++---
>  drivers/clk/qcom/clk-branch.h |  4 ++++
>  2 files changed, 15 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/clk/qcom/clk-branch.c b/drivers/clk/qcom/clk-branch.c
> index 0f10090d4ae681babbdbbb1b6c68ffe77af7a784..90da1c94b4736f65c87aec92303d511c4aa9a173 100644
> --- a/drivers/clk/qcom/clk-branch.c
> +++ b/drivers/clk/qcom/clk-branch.c
> @@ -142,8 +142,12 @@ static int clk_branch2_mem_enable(struct clk_hw *hw)
>  	u32 val;
>  	int ret;
>  
> -	regmap_update_bits(branch.clkr.regmap, mem_br->mem_enable_reg,
> -			   mem_br->mem_enable_ack_mask, mem_br->mem_enable_ack_mask);
> +	if (mem_br->mem_enable_invert)
> +		regmap_update_bits(branch.clkr.regmap, mem_br->mem_enable_reg,
> +				  mem_br->mem_enable_mask, 0);
> +	else
> +		regmap_update_bits(branch.clkr.regmap, mem_br->mem_enable_reg,
> +				  mem_br->mem_enable_ack_mask, mem_br->mem_enable_ack_mask);

regmap_assign_bits() is your friend

Konrad

