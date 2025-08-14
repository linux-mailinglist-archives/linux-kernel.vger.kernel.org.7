Return-Path: <linux-kernel+bounces-768410-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F88FB260CE
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 11:26:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E23C6173617
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 09:24:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70EF11F4C87;
	Thu, 14 Aug 2025 09:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="XVki3B+K"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 554842EA14B
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 09:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755163433; cv=none; b=DOO2benOhJXOqDmegiCy7lIgbB7dWA16Jz95Twx0/NDf0+8wQG/n/plJ9SoXB/tU/6Q5ChBxDHj3486fgTrSKq1uTQVOtIHUPyER50K755BpjMrfoTq6gPbtMRhFVkkI0LypGohBdVnEcqc8RQT6sHmuBD2Kg4eR5J11IlNGOjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755163433; c=relaxed/simple;
	bh=Ej025DDeNf3Cgctpj8ZQbWDyl9ppZqFWLjssNKcysLA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gwu86+mTMOaT+KDfdLAt8II1hkaZ8bjW6J7BzbnJ2qXpLliBF66q2jeDm2pSRBiThYJvBUqTlsp5zxUoX+W5RHM4VCZPTZ5JMltZoQ9r0bvI2XJbBsDJWMHh3uvqaGOjonm9FNXhQW+8TzEMnqwuHAE6Qoj9SeTi0K77BBci5Wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XVki3B+K; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57E9Cru3012236
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 09:23:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Rr8nJMfQPfH5v6BDXEA9yngasaki1qlI6+ZUchKQ1BU=; b=XVki3B+KzUIq1NxD
	+a3auLWmpQJUUl88yWV9KbFruKeA16xcU2n9N73EeExsQr2iz7EoVYBZuuLA0KhP
	JI3RujXwl58kln+zzuBB9PtU3AHLxNOcMTTp1wD0iim/iQmpS9t+xWxt79F4M/Lb
	9S0vR4yWwuqS52/9FkxBsEBGEZdsWiNdbtrSnRFQzwBEdpITlkEXaS58niLu6P13
	K5N+k6BPK/4QHwHDLONHUU5VLaEcgEo3bFlYBq3Bt3idxIKnIi943E6YMgxog5I8
	aldTwaVcXPLBeuo/ykJQsJltZYbBBzZk07dJgZHgXsg4VXzxlVDuyxHbjoo4eBcU
	zAC+qg==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48eqhxd9m7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 09:23:51 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4b109c6bf1dso1879291cf.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 02:23:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755163430; x=1755768230;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Rr8nJMfQPfH5v6BDXEA9yngasaki1qlI6+ZUchKQ1BU=;
        b=qGJ/8CbGMeWgS+LOF0xliTIM3Kyxl7WYUSFBN6g6BgWESHly3WSBKv+SplbQN64eBr
         2Uf1zkOnWKRafio8gCA32zhtceXmQ00LuarlZg3vYDfghGtp62kXw5Cs6P4dgU0iCzet
         SoQmXeuq8SYJxgA/8OCsuXzhgBzO5JWD8lKpNUxflWpqGQBXIKqs6AJooD6XFnt7iiHQ
         LRkBxeMyz1e2kNn7Xs7GMssOh569Axzl0334p9eoxtFy2TBIXVUdqH6h0+qz7wMm46az
         yPnUR+IcE6QddNoRnsUmawXu0AcnixSc3D/zNGSf9KDHTAOQTmfdN/OSbJsfByc3UlQI
         a+5A==
X-Forwarded-Encrypted: i=1; AJvYcCUwSzfvVt0cWSHg6IlhI7oMbrFdlJEuAhTNsRdBlVMAcZs09GjMhIMqEqsKK2n7nEuVCz1DPEEwkOe5li8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1r/y9LNmlvGdP5uYgSQibpm6uQiRaDHUAOWEb51fo5OImNw2+
	ZG118/hE+gWjvYXclbtwx9Whrx9ip+pIzcI5hOY8gm78AIf3R8O+VVjJF2xyIrDVVRf4qjNkyIw
	1YjZQ6M7nCX7sOEPVr2JLuIxSo1xtWmIK7LMI3WZvC+OmFga1llsKCfSxjqLU4LxerNCng/3arT
	8=
X-Gm-Gg: ASbGncsS6iwsN4qglG41lVOVHH7NiwtFqOHpH4yZoZXcdPhhasZY9M0Qd7sWShUm8ep
	gwAwS62i1MXpPmkQj4wjyTRuzMaZnIA+OLsG0PNrMIOenbUC78DDPJhmeTRz6K2XyH/a6gQWvxf
	jNVvmUyjAuyNlg75asrGwS5/Xkh/HIedfVYteIboZ0vQuN23N+wnfg8Cgp1gPvGiqTMisth7cW7
	5H4FcTptpNUBjWVKM1EuomUh5DoAhVXIgjsoTH0pCFBlk1ioHijnItCc/pEFeItAu2Z05UyeHdY
	d0UEI4egAdjbzOg9NOWZ+P0GtenTHTSvHC2YU3k4tFd04MXbN2b88iRjo7RjTe8qSzFcVNVFsQC
	sTyuZiTNpvq1BAhRs9w==
X-Received: by 2002:ac8:580b:0:b0:475:1c59:1748 with SMTP id d75a77b69052e-4b10ab40660mr16148791cf.11.1755163430117;
        Thu, 14 Aug 2025 02:23:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEEmqdtGcjWlowhifxBpEnAQnNU5How2ZYW9ypeoFFwgzTxDN1AK/KzEpZK/3H7HMSaNxTjIQ==
X-Received: by 2002:ac8:580b:0:b0:475:1c59:1748 with SMTP id d75a77b69052e-4b10ab40660mr16148641cf.11.1755163429567;
        Thu, 14 Aug 2025 02:23:49 -0700 (PDT)
Received: from [192.168.43.16] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a07670bsm2574670766b.8.2025.08.14.02.23.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Aug 2025 02:23:49 -0700 (PDT)
Message-ID: <5fd77c1c-ffb3-4413-929a-36437b170591@oss.qualcomm.com>
Date: Thu, 14 Aug 2025 11:23:47 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] soc: qcom: ubwc: use no-uwbc config for MSM8917
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Rob Clark <robin.clark@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <20250814-more-ubwc-v1-0-d520f298220d@oss.qualcomm.com>
 <20250814-more-ubwc-v1-1-d520f298220d@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250814-more-ubwc-v1-1-d520f298220d@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODEwMDA1NyBTYWx0ZWRfX4lm50cnWwdQJ
 OaUmkz6abDajbz3ekZRVq9oCZjzrEBZ8aRHht/L1KEQKIbdul7OC3w3xnJkEOLDIZvdUs7YVPsv
 rPqgAxnaEcDtqyhe65aKmqP1ZLkavGID2F2oTF/FD5/Jxs03dGqCPb4kOUbyrR3p4oLgLQL2/3n
 wjTxCbykuCfZWSQso7m7zOvkrII5Hb8BX5XYzBHogRUTSQu83N1Tu+NfN1SDmYjkFIqcDuOjSKf
 pHSYQkNH5h59XDbOP3bFLXIy8Akdgd2Ybzid5gA575iZnpmbS30TpWLLfbUSfU7EnE1/xhX7x6b
 E8izg5tFqUSjOcNe40Kn2Gkt6w7Zn6LtbpJOO5x1yjn6OhChPCFdzaQXKVtP2/O90oBr+m4bVI7
 NFj/NAAR
X-Proofpoint-GUID: Y5Xx_zRqB5ON5Cbx9pHKPEgO4daRE6R-
X-Authority-Analysis: v=2.4 cv=aYNhnQot c=1 sm=1 tr=0 ts=689dab27 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=Oh2cFVv5AAAA:8 a=EUspDBNiAAAA:8
 a=GOBAdVRHtaGIiaGvnzsA:9 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
 a=7KeoIwV6GZqOttXkcoxL:22
X-Proofpoint-ORIG-GUID: Y5Xx_zRqB5ON5Cbx9pHKPEgO4daRE6R-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-13_02,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 priorityscore=1501 suspectscore=0 phishscore=0
 impostorscore=0 bulkscore=0 malwarescore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508100057

On 8/14/25 9:22 AM, Dmitry Baryshkov wrote:
> MSM8917 has MDSS 1.15 and Adreno 308, neither of which support UBWC.
> Change UBWC configuration to point out that UBWC is not supported on
> this platform.
> 
> Fixes: 1924272b9ce1 ("soc: qcom: Add UBWC config provider")
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---
>  drivers/soc/qcom/ubwc_config.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/soc/qcom/ubwc_config.c b/drivers/soc/qcom/ubwc_config.c
> index 1490a7f63767bba176e8e2e76891d7d2c424bb7f..5113c2902bf2ba3711bb14b35bbbb8a2b49b8cfe 100644
> --- a/drivers/soc/qcom/ubwc_config.c
> +++ b/drivers/soc/qcom/ubwc_config.c
> @@ -225,7 +225,7 @@ static const struct of_device_id qcom_ubwc_configs[] __maybe_unused = {
>  	{ .compatible = "qcom,apq8096", .data = &msm8998_data },
>  	{ .compatible = "qcom,msm8226", .data = &no_ubwc_data },
>  	{ .compatible = "qcom,msm8916", .data = &no_ubwc_data },
> -	{ .compatible = "qcom,msm8917", .data = &msm8937_data },
> +	{ .compatible = "qcom,msm8917", .data = &no_ubwc_data },

https://android.googlesource.com/kernel/msm/+/android-7.1.0_r0.2/arch/arm/boot/dts/qcom/msm8917-mdss.dtsi#93

&mdss_rotator {
	/delete-property/ qcom,mdss-has-ubwc;
};

argh! thanks for catching that

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

