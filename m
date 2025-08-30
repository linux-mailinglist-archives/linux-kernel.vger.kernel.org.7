Return-Path: <linux-kernel+bounces-792581-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B1B2B3C615
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 02:17:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB0521892C8D
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 00:18:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9735C46447;
	Sat, 30 Aug 2025 00:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DDF6OqD6"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C1F078F26
	for <linux-kernel@vger.kernel.org>; Sat, 30 Aug 2025 00:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756513065; cv=none; b=bpDVX1+nNhHADhTxc68QVMKL1WK3orKYtbS/jIFxTaf+fMJ94Fj7kw+t1qXNyJ2IiWn3dqTWMU/7x0PAKfxKgFFti2I5DDGdgA5W0tBUKe7zIGan+MLK6NWZvmIQfsXwi3xlCEY4BK80p2Fsna9RqQyLBJFZXE1Zkz5gi+MjGSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756513065; c=relaxed/simple;
	bh=z680PBSmglhmsZvf5jSNQdE0L4q1DSTf2d5oaXXykY8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gVrrogq/xZDU7WJVWg+NMWg0g1SXFZnluGPJzqKWO5uRIrqXPUD1FtIgN/2CoXYwhbvm1F08mgVqWTvJIkn0DZ9JyfXWNm5ivVyHLO3Hh4sYzatvXDkKzau1nwVFsidB7Q2WxiHheCHm77VObFFQVg3Qijo3m6c8w9tp7Z+HByY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DDF6OqD6; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57U00DT6019310
	for <linux-kernel@vger.kernel.org>; Sat, 30 Aug 2025 00:17:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=ueFZ451Bf6LufCZEO1QlwV0P
	A8vLmIWNBrWd/BzxeMM=; b=DDF6OqD6ySuw2qxMojAr++DtA9RqJUIJ9OpOWm/r
	/8+0qKiUU1wqAKHv576BHhFYcP8pDDAL752B4RwmzFbQTR4Ks+F4eALGz/81htHd
	hJuprOKEDjj3MS6UlrFRxJaavdhmOk1EuG/4FJaW8100fpPKt8Ucm9gu2Eqb2A2D
	eAMwCvZRx7k9nWfwlNpmCu8Rkj7URcJ2CPzgym28MtQ3cgMxQ7neSXxz+X/E4Bsc
	nEOFWlr+zGBfCtgm9AfGrv2WOcAfUY4yzGmLReUPYDAmhnYmhLIJ6ugWVLf7QqeK
	RYGUo4rWmxzpcxddgXZnbG+SogsJW34DQ55QJIC3xaFy5A==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48q5umn9ye-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sat, 30 Aug 2025 00:17:43 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4b2dab82f70so75462281cf.3
        for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 17:17:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756513061; x=1757117861;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ueFZ451Bf6LufCZEO1QlwV0PA8vLmIWNBrWd/BzxeMM=;
        b=OdyKmCxbGkVjOArnRJs+QKkrQSR0B9YeOdTaFB1WUTHJpAaNkED5Os404Ye6kGj25L
         goomj+JqGcAh8D92Crkv2xAd5pKngATDkEiRm9+BA1HKxICmrBAWUn18z3WjBUApmBdb
         BTEG1fLnEdDETSL0zN25FDcSqHIU/bmYvNoIsnZtMUkFRma8oamlI337tShHmmWEJRqm
         Ke6TimhZ0oQSXY6PwZcBAXEOaKmXkzDRLN8qLq9BwKppbndrPeQVKPe9ILFdy4n+mV04
         6LKzgCqxqT5OdaSprWPYq2+LdXsOzT0cGTiL4O7CV3sGismqk1Rc7ZD9hNger/w5Hgkw
         +XEg==
X-Forwarded-Encrypted: i=1; AJvYcCXvN3SRswwhS/9xy8aiMx5AFFSVl3hx+6YN9PWBi5flJCB3lRbz0yMUXnyMYvvMtzgvhdFAzjqz1liThHw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNxS0Kyk34vCGy496f7rNX6cF4W+BJU9nYLyVsMIEaCAusvdRn
	kZldJ6sOTrWA3Jvk3C60kS7cYsVuazVEajewEvVpwxkTayWbGyQdCucgiDFXGKXolzULG2GLbGH
	COhNjglE+U6LHKEDftS4bdtM0N1jSTHrlC4LiAjh3B8nInIz4TneRGKUyACUVX60nw2g=
X-Gm-Gg: ASbGncuSg037Ih/6adXlxYm7z1d3yBgWtr3knlXKub2y+3D7YPTFNfUnyopqJ3Qc7jf
	grnFiMe1qx4CuJKDaa5+RI37QBBHWuLrT5iGJevhNFGbkJt4iV7QTvyXlDJ6iqQOfEYIu1MjXew
	PvxfpRSgbPLjf/1+hBvRKovJyzKSQscVn/szKQOMmSOg2olJZolHoQ2xNSP6Dn2LVisw46drcDa
	CKCK0prgxzcIuPo2mv9J6QsgDpi+GPZadY0o8y+MWjm0uVtJT/t3+OE/5sxMqOPYrPm5m9162/+
	RlBG7/u1RnZX/0pXd6ZPhIXQB9VSImVp+dw7PmwQ9iMay3xXU+dzaN9aeixKvBcn2e+tSGe9QH2
	vDyxUB3/zI1n1VBGWg5YqDyEdxO96eQ8t5KlJusvuoAibnwJZAWiK
X-Received: by 2002:ac8:5745:0:b0:4b3:1a10:5559 with SMTP id d75a77b69052e-4b31d80c48fmr6085061cf.7.1756513061622;
        Fri, 29 Aug 2025 17:17:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGJl/Af5VmCiY5OsG78su9IRmyWK/uConNdwyypxlbySz2t7lQqsItTw5Ci2wZDJjq+Xi6WYQ==
X-Received: by 2002:ac8:5745:0:b0:4b3:1a10:5559 with SMTP id d75a77b69052e-4b31d80c48fmr6084771cf.7.1756513061108;
        Fri, 29 Aug 2025 17:17:41 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-336c2c5f1c7sm3531131fa.45.2025.08.29.17.17.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Aug 2025 17:17:39 -0700 (PDT)
Date: Sat, 30 Aug 2025 03:17:37 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Taniya Das <taniya.das@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Ajit Pandey <quic_ajipan@quicinc.com>,
        Imran Shaik <quic_imrashai@quicinc.com>,
        Jagadeesh Kona <quic_jkona@quicinc.com>, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v2 1/3] clk: qcom: branch: Extend invert logic for
 branch2 mem clocks
Message-ID: <ecnfaig4uqlgvvhcadh6pofe7vmlx274gtaabmop6w4gggtjkw@ry3pudcp3hx4>
References: <20250829-sm8750-videocc-v2-v2-0-4517a5300e41@oss.qualcomm.com>
 <20250829-sm8750-videocc-v2-v2-1-4517a5300e41@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250829-sm8750-videocc-v2-v2-1-4517a5300e41@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=VtIjA/2n c=1 sm=1 tr=0 ts=68b24327 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=IOa5V0MNBbNQbul7L28A:9 a=CjuIK1q_8ugA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAzMiBTYWx0ZWRfX2sQCOmMwkiCe
 VFSsdHXLUwFJ9wmwTSBqPqKIMBxQ21AzdmV6ASaC2rq8+SVduK7h5AAaX/fbK0+K2vRRbSAgfQz
 hfokRY++jKN2xfUl1F9CUoEA2VeW+mMdv6AZf1FrS6kLjdAFIi/Iu9GNwCw29e0qu3jKiPUPO4B
 xKjazcPnu29pMu6nmDfv0JBAcTScAq8/P0uksoCio65/eBckN/1MQF3sT2xIVLxtfNuILUM+nPg
 U7cW3w1+7U+/WhRMh8SbBgdnrWrAQxor/za0jRldbHSly2zGUicj3jfeqe8ePC9MuLY9oZK4GGs
 azh/mD9eMDSCYC9Zk9IGjpsFMmXgH+8Gm/30SzDkQpyh7+b1uj3mYZ5aGqhwO2gifzJBrtp7y8y
 9RZKi3/P
X-Proofpoint-GUID: ry61YJquS7Q33Z7ZQZgfl_aLqwZ1oUFh
X-Proofpoint-ORIG-GUID: ry61YJquS7Q33Z7ZQZgfl_aLqwZ1oUFh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-29_07,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 priorityscore=1501 impostorscore=0 bulkscore=0
 suspectscore=0 malwarescore=0 adultscore=0 spamscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508230032

On Fri, Aug 29, 2025 at 03:45:17PM +0530, Taniya Das wrote:
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

Please check that your lines are properly indented.

>  
>  	ret = regmap_read_poll_timeout(branch.clkr.regmap, mem_br->mem_ack_reg,
>  				       val, val & mem_br->mem_enable_ack_mask, 0, 200);
> @@ -159,7 +163,11 @@ static void clk_branch2_mem_disable(struct clk_hw *hw)
>  {
>  	struct clk_mem_branch *mem_br = to_clk_mem_branch(hw);
>  
> -	regmap_update_bits(mem_br->branch.clkr.regmap, mem_br->mem_enable_reg,
> +	if (mem_br->mem_enable_invert)
> +		regmap_update_bits(mem_br->branch.clkr.regmap, mem_br->mem_enable_reg,
> +			   mem_br->mem_enable_mask, mem_br->mem_enable_mask);

This creates assymmetry. The drivers uses mem_enable_mask in one case
and mem_enable_ack_mask in another.

> +	else
> +		regmap_update_bits(mem_br->branch.clkr.regmap, mem_br->mem_enable_reg,
>  			   mem_br->mem_enable_ack_mask, 0);

And here.

>  
>  	return clk_branch2_disable(hw);
> diff --git a/drivers/clk/qcom/clk-branch.h b/drivers/clk/qcom/clk-branch.h
> index 292756435f53648640717734af198442a315272e..6bc2ba2b5350554005b7f0c84f933580b7582fc7 100644
> --- a/drivers/clk/qcom/clk-branch.h
> +++ b/drivers/clk/qcom/clk-branch.h
> @@ -44,6 +44,8 @@ struct clk_branch {
>   * @mem_enable_reg: branch clock memory gating register
>   * @mem_ack_reg: branch clock memory ack register
>   * @mem_enable_ack_mask: branch clock memory enable and ack field in @mem_ack_reg
> + * @mem_enable_mask: branch clock memory enable mask
> + * @mem_enable_invert: branch clock memory enable and disable has invert logic
>   * @branch: branch clock gating handle
>   *
>   * Clock which can gate its memories.
> @@ -52,6 +54,8 @@ struct clk_mem_branch {
>  	u32	mem_enable_reg;
>  	u32	mem_ack_reg;
>  	u32	mem_enable_ack_mask;
> +	u32	mem_enable_mask;
> +	bool	mem_enable_invert;
>  	struct clk_branch branch;
>  };
>  
> 
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry

