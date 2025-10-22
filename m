Return-Path: <linux-kernel+bounces-864243-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id A18C0BFA427
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 08:37:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 23FDA34A963
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 06:37:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 149102EFD98;
	Wed, 22 Oct 2025 06:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="CB0sWIT4"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D79732ED167
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 06:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761115033; cv=none; b=qWsEaQGOSmFKwah4X8VSksXrsi62wDVuTxe8c/0uqQvSGmoROheUe4xi7aPfeBbPr1Jwmi6bUU7yDnTu2pTXtWi+0AIaF0UWq+JlU1N80MsTCFrPf1eBLc7YfL+uNF0twuHLjVsb0APK1KX2Fn3+3bPAn1ToGM15OUMZC+nCgmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761115033; c=relaxed/simple;
	bh=iJ1uktF/2GWrsG1i/Ztq1ODfIsEIJ8TPn2k68folgJo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QVwnOX1GfPfMEB8utCs/UYZ+V4aY0/LVvqbdX0AjfqyRgLfwP3/wpWbeczsN/AqkFjCecqZeN7tp0GcUHknKKSDH+UVz9bjxzqKcUAlu6DN9PZwvhwe9ZnTX9uaAxwAHStWGzdhusu03VYWsK8xEdu7cypw6n8WbZE2gKNlhA6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=CB0sWIT4; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59LNFqrl003559
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 06:37:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	phYYPHpmFAc5t3rQjDklKkr3KZqV3jpdRFmpgMO7EiE=; b=CB0sWIT4dGesmZr3
	VblF5Nyh4oTrrS85MkDKXBLlVOZT8m8BGZex3n2lQH3w+gJXz458mxwFRbzOY/53
	WzwqV+5w+dzTdQLKDzJiq1mOJ74gzKfmFfbkK3Ttk4AswoUFcQ4cOkNifAuyL0Sr
	eXkp7IFg40NRMMryJDYBWKxd839bW4UPkBdRVez2X6iMDF52X6RU8ccO1K/d1sgb
	Y+yFIRi8+dia5KJdpBG7yyT0bkriEabFzVWLuggTRIJQhe+cLsUGYVQmplePgpNs
	eghiIiARZ1kr++uLXOPUd4fzZgKS//IntqCYJtWhDkTiZ+BnzF2TW8woDddJIhDF
	oLbPQA==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49xkps91pj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 06:37:10 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-7810912fc31so6137873b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 23:37:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761115030; x=1761719830;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=phYYPHpmFAc5t3rQjDklKkr3KZqV3jpdRFmpgMO7EiE=;
        b=tpIbgjYVVMHzEORVey7OCORR4NOtDpG2PCkGHr4AVq7aXfRLz11kO6BZkRc+kZHb63
         rBmHgP1d4w8guazKfIQtOLmYuW0VViGMGQutgDE7oCnJHkB/7kDVWMJdeaqPDpEKYj0k
         KYY6hY8cDKeXeYqfukyHuv02ExZs1dk33BO4JTTfxzXp7cNnWuGiXYRMgUmdHwsFAZ2N
         GfKeI8gbz5wa6Uf02Ixxnl1YZiksejVa4b+SWUqueMDWmbWNPWDaJaRhM/Kil18CfKcl
         ZyFJgsMT20GigNsW5IXOzAZKMIHpzrSDkPazaA1ptoFi6mjOD+JfWDmg0f4wAyyEOCMA
         Oexg==
X-Forwarded-Encrypted: i=1; AJvYcCXAm5Zpob0KfNlOQvvj7fOkVd1Ib0JNfbUcyXovRDSimkyCxE3G12j+eyZ99u1s1O2X1upj/FuClBMSivo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcCp1rxBc0fGVAPLg+9w16IWZT5V5Bvfe+h3OrBsQGC+f9GVKx
	iEmhdc/8jOXgoIDHkswvuzlYlSgpKkDsMwOtuvmvLEUEofT5K/zYk7oxrbM8DVcpRYkZYCDa9sO
	8I1B/laen6MK7FLJPjIC1wXUg22TBRaRKaW+N6gazT5sOOwR+NRfWhuPa7D/zc5V76KA=
X-Gm-Gg: ASbGnctGLd0L4ZFJRecpoiaarFemqO//s1TtCNlqSA2/ZNHsyY7L4YknoUHCIFvrLeI
	PqkXGFdlOSMl8gGNT/JdgDTOraEFA09nSm8wO4xaWBt2h4Nu0Woac792ecGD6LAh5tftF/Xdwjm
	8YDMdAnZRNgFL4iGVhZtso2u3cS+airc5REAj2/3DTKscd65it8d8tcNjr9DtvuKkvgWs23In4r
	UD+w+BLVN1Hhr+lczVNqZ09DLbBQGpTl3uWDxIZAgKfO/OOwTUfqHey7nlq+kDOBUMA6MRwQD/e
	4BzbDtffz5iWTTJ4d0SZqOLvrMrYE8iU0p9CxAho7pYnT16+hXyG1Sn/xW0GPEWDgJV+iBZDXZ5
	zRRSpP1sDLgc1bw32czZctsbb/gA=
X-Received: by 2002:a05:6a00:1493:b0:77f:3149:3723 with SMTP id d2e1a72fcca58-7a220d3464dmr24153365b3a.29.1761115029935;
        Tue, 21 Oct 2025 23:37:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG7vtPwGZMKsrymbcxu9zzkrZlyJC25po4kInazwlIOlZKWVgmxbQJbd5FeFHB1tY35PDWVlA==
X-Received: by 2002:a05:6a00:1493:b0:77f:3149:3723 with SMTP id d2e1a72fcca58-7a220d3464dmr24153330b3a.29.1761115029486;
        Tue, 21 Oct 2025 23:37:09 -0700 (PDT)
Received: from [10.217.217.147] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a26c3026aesm74721b3a.24.2025.10.21.23.37.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Oct 2025 23:37:09 -0700 (PDT)
Message-ID: <d453ddaf-aa44-4125-b86a-4a51f2c23ac5@oss.qualcomm.com>
Date: Wed, 22 Oct 2025 12:07:04 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] clk: qcom: camcc-sm7150: Fix PLL config of PLL2
To: Luca Weiss <luca.weiss@fairphone.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd
 <sboyd@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Danila Tikhonov <danila@jiaxyga.com>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20251021-agera-pll-fixups-v1-0-8c1d8aff4afc@fairphone.com>
 <20251021-agera-pll-fixups-v1-2-8c1d8aff4afc@fairphone.com>
Content-Language: en-US
From: Taniya Das <taniya.das@oss.qualcomm.com>
In-Reply-To: <20251021-agera-pll-fixups-v1-2-8c1d8aff4afc@fairphone.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDIxMDE5MCBTYWx0ZWRfX4udGhzqoEncu
 NWuQ2EJ3Cp2yFHt15ouZTmS3kuHsflFuK1hxH8LhlQFoOcTa40QI2XHRfuyNn+trE+wesUBGW2r
 ZPXAayvxS4uuG+4TPUNMVB53pTsbDLM6o0jHWvt0nxp5lfu1WjmkY+QANq5RsGPOgp+cWcPbepg
 xtAt50wOzadTP+VKIX3fL1FZKkLrEWsAgGh77RMLrF4mPZpr7zeURq05Ym+tT9K8Bw4n7BNPjyW
 IOp0jAZX2mRKJ9v1zUyz5WAsRD9qKc2lHh74/wiv063BgT+aLbD35T3kmTGLRiaycMS4Ag+l59M
 R+Pa+jY9UX60p5fHu7fL5xTCWo8spisBqD3/ZrK3p8+FAp97syuQAeLZcADnNNAeqvLYPj+ELty
 jdEBOboFW0u5Q91xxIubFaJCCJnjBQ==
X-Authority-Analysis: v=2.4 cv=FbM6BZ+6 c=1 sm=1 tr=0 ts=68f87b96 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=6H0WHjuAAAAA:8 a=rHO35cIvbrFS-cT-sPwA:9 a=QEXdDO2ut3YA:10
 a=2VI0MkxyNR6bbpdq8BZq:22 a=Soq9LBFxuPC4vsCAQt-j:22
X-Proofpoint-GUID: wvg5A4pLTYSl1Zsm7NKUHSncyrY2csU2
X-Proofpoint-ORIG-GUID: wvg5A4pLTYSl1Zsm7NKUHSncyrY2csU2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_02,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 bulkscore=0 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 spamscore=0 impostorscore=0 clxscore=1015 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510210190



On 10/21/2025 11:38 PM, Luca Weiss wrote:
> The 'Agera' PLLs (with clk_agera_pll_configure) do not take some of the
> parameters that are provided in the vendor driver. Instead the upstream
> configuration should provide the final user_ctl value that is written to
> the USER_CTL register.
> 
> Fix the config so that the PLL is configured correctly.
> 
> Fixes: 9f0532da4226 ("clk: qcom: Add Camera Clock Controller driver for SM7150")
> Suggested-by: Taniya Das <taniya.das@oss.qualcomm.com>
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> ---
>  drivers/clk/qcom/camcc-sm7150.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/drivers/clk/qcom/camcc-sm7150.c b/drivers/clk/qcom/camcc-sm7150.c
> index 4a3baf5d8e85..590548cac45b 100644
> --- a/drivers/clk/qcom/camcc-sm7150.c
> +++ b/drivers/clk/qcom/camcc-sm7150.c
> @@ -139,13 +139,9 @@ static struct clk_fixed_factor camcc_pll1_out_even = {
>  /* 1920MHz configuration */
>  static const struct alpha_pll_config camcc_pll2_config = {
>  	.l = 0x64,
> -	.post_div_val = 0x3 << 8,
> -	.post_div_mask = 0x3 << 8,
> -	.early_output_mask = BIT(3),
> -	.aux_output_mask = BIT(1),
> -	.main_output_mask = BIT(0),
>  	.config_ctl_hi_val = 0x400003d6,
>  	.config_ctl_val = 0x20000954,
> +	.user_ctl_val = 0x0000030b,
>  };
>  
>  static struct clk_alpha_pll camcc_pll2 = {
> 

Reviewed-by: Taniya Das <taniya.das@oss.qualcomm.com>

-- 
Thanks,
Taniya Das


