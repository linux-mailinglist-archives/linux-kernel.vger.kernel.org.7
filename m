Return-Path: <linux-kernel+bounces-893271-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3031FC46F4E
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 14:39:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2820D18853FC
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 13:39:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A6BC3126BE;
	Mon, 10 Nov 2025 13:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nu/5d/oG";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ARSHBck3"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88FDA1DE8B5
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 13:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762781765; cv=none; b=Muz9inLmHcf0ikr6hqrhy5f+AgKMxUPzCFAXVfop2++ES/Npl8XPTwL29azG9XolZeyld0WljGnVZ1Lu6uejA30jS7AuuWoVYErqsn/Ywf1o2KHm6Df+kkqZ55PLH+biFGMEq+0svX0QPqUMCedPjEfRDuVz5neA/u2t1lVAkj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762781765; c=relaxed/simple;
	bh=QS9cmXQXKGnwoD3mp+GBzdPacfCPhiiv6IvqF7RF8mw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Em8MDyOR4B0/SrnfoKuFPFR9+2O+apaVkV2fveRHMBsUn+0lGr9p8/jSTZ3Y5aQH5LNwIF4i6ElL22Xh9ELBnTMX3APSd6PET6VTaY9YlBtM9sXvomlkH4eofvhH3HUF9WrHhfvcO51zq5xMMfnHx2nLrKGGqnokfrWhQ/FKXWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nu/5d/oG; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ARSHBck3; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AA9EhVl2992285
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 13:36:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=awc78OrtB3yTTjJ3NNR0OiAT
	MRveR6javZmhFpqenTE=; b=nu/5d/oGWTBNWdterKNkxMYu1n7CXAIf05HSkfEx
	ZLEz3kkLla/FdmoMAwmdlgPTDsOyMudJ5Ku1TkmlZGm6ySqR4bLqueSolciCEZee
	VJvY0uu3kZ8mVCh3kzQjn9bOdfGFj459ZprPA6FY6C3B1QG4Os0aPn246S+UBJjA
	eG64P7mpmzSKlXBtq/TD8pJB115bC3lvlsrUYMMvz41QJJmj0OK+G9PhY83wFTTm
	9GAY11HGbTZ/t7cq4AeDn7kboJgJqh40XStRlKR6DNfG09Iparb2swr0zrbxO/pQ
	s+U4VYUxk7UanBCg3SzfJdgLJJVs3EYaMlPKvXuv8vmZbg==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4abd88rr1y-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 13:36:01 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4ed6466f2baso86215251cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 05:36:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762781761; x=1763386561; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=awc78OrtB3yTTjJ3NNR0OiATMRveR6javZmhFpqenTE=;
        b=ARSHBck3OyNww1BNTQi5OFaKjR7Bd3N7qA7yN1ZAXY7Ee+xyfz1aCzL1Z/Aw/BQfZK
         8srg5xfVLRFymebwQW6HZzgd9oU2YzN5ondC0S9gjMI8vJ1ajX0dx/8ejRqoQxKQ84hD
         jR8JwiDuyQldlglyGvqrfBjnG5utwiKyn1Unx0RMDxtfWw8aUXsIbxh6YgQ4XAI+jKwg
         spN//zTlorbAlpDTKE11hurLafInN9jEdn1bTi6WYhC1anW/+Ai4G00DmPoXrEE0SdKB
         7F9n1I/dbJCjgIX/OIylo550BNw7Dy38tE09fdvkdmLNWyRI/imKL92EAkKBiQXoB9cN
         XgLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762781761; x=1763386561;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=awc78OrtB3yTTjJ3NNR0OiATMRveR6javZmhFpqenTE=;
        b=jGsYM0oo070ZBIC6kPqX2N/GP5FIUxRziTs1Rwo6T3aYrBGXlFhMLcQXoGtbDNH2my
         bIiwhR5sA36SysPpk/9IRnatgmOGLIDOJmZn132q7GAHeHBCtngf//ViodKMG+lB1Rf7
         o0W2ihO4iw2fWmhCi1ov/Nie/YvaGWc4DDnrgUTs48pW4AUpEfleAqwqLG6cW1ffdikf
         bsm0uWImEdGjQGgVsCot63LivhiXEF+Epc4lZuxFvqoaOCwid1wfr1BrHJZMSMCtH9ka
         OQhJhHiugOIHDT8v4A4jKrFQ0yn+IA9ca4BNqfXdZdC6kns5eq6d/hWtGhsLcUd/ckDW
         jh0A==
X-Forwarded-Encrypted: i=1; AJvYcCWl8J6LxLvvBhvxXn/YOEGVTNUmwfZMHJFwd7Pw+xJ47uygIAHR6rGDdOmGgo1HYA7NgB4fAb0xh2CBbzQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZAhDdz1jegIlVl2jIgGmhJaisIK6yH8pb8ppuSIYKXyi2Lps7
	98NDcpF90LOykd77j9PFOHpAsM5gU8kY5zoauGa9CaC+WEkkA5BLcA+IJJRXT2yD1UmpoiFJBB1
	WZgKTy7SsWdjmbNSbQw/8q2jLppBgd6Df1K5QSRguLSUOYLK4D2GO9/lS4BjDjagTFRQ=
X-Gm-Gg: ASbGncs4HX34bNS5/lVwj7Mnb7TZ5g4UBXM8YawncLZiXHLcArjAOhF3pu6PtfAOywJ
	v16iuXTJOL+HVpqNOCMObaFVPgmmRLDM5Y2/oIwbNucqEJG5xIJyk3HOJ6WZSRUiTfQwzaZeWEK
	YdiKLSaSyihgItpxbSa+ivEtg2AKpKG0d4huqxM3Ujm3O3/X4p9nIAIlj+9XHAAxF9hzYHPvXtt
	ZWPKR5F01bHGiKRjZgB1rHlbWw0nwvvsQBYy/e70AzWzPVCN+TBewIgaeI9NG9JABeQB4mcrG10
	5KVTbvGDgenCV7V5ylB/iY5aJQ+61pkhpxo7dAk1CmDELvZJGpxSust6eQhKtB2MuPDQfiB+6RI
	w+ILPvisYwpKghgl+QgUuYAFacPXnan3eQdcBrUVBZOsJqC2nQeS4pVPsoAQ2Mur1gZWNZkb5pA
	buD/6Esl1m3c1W
X-Received: by 2002:a05:622a:1a97:b0:4e8:b2df:fe1f with SMTP id d75a77b69052e-4eda4edad2fmr84130951cf.28.1762781760692;
        Mon, 10 Nov 2025 05:36:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHXJ5BT/q7g/MBAV87Zw3lOF0GB6xqxQQW1RPh+OIbihbzKHhzyxU1QwSdJdQsAkfFK4qJhZw==
X-Received: by 2002:a05:622a:1a97:b0:4e8:b2df:fe1f with SMTP id d75a77b69052e-4eda4edad2fmr84130551cf.28.1762781760095;
        Mon, 10 Nov 2025 05:36:00 -0800 (PST)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5944a024f49sm4049881e87.42.2025.11.10.05.35.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 05:35:59 -0800 (PST)
Date: Mon, 10 Nov 2025 15:35:57 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>
Cc: Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@kernel.org>,
        Stefan Schmidt <stefan.schmidt@linaro.org>,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Val Packett <val@packett.cool>
Subject: Re: [PATCH v3] media: iris: Refine internal buffer reconfiguration
 logic for resolution change
Message-ID: <l2djrmw5i7dfvlrqyn3a5yrohbtpxr72xwwrgojvsfwo7w4feb@254rjgan2fyz>
References: <20251105-iris-seek-fix-v3-1-279debaba37a@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251105-iris-seek-fix-v3-1-279debaba37a@oss.qualcomm.com>
X-Proofpoint-GUID: hEIcVTfsGA0bN-7q0U7qrMOkyvNKFW1A
X-Authority-Analysis: v=2.4 cv=PL4COPqC c=1 sm=1 tr=0 ts=6911ea41 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=e5mUnYsNAAAA:8 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=K7FOPutcZWfKzoRN3qAA:9
 a=CjuIK1q_8ugA:10 a=a_PwQJl-kcHnX1M80qC6:22 a=Vxmtnl_E_bksehYqCbjh:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEwMDExOCBTYWx0ZWRfX4foPVYDqC+qf
 AyPoUIfwG9rtCx5MDnvS+1i8spNtjv/9sONjOTyRCWhhEbNUKrT3GOtpqOjNzstqrtBr1ND1cSQ
 p1CGAhbp+oxh6XUi4SjTfi0Fd4dEOlk6z9nVN6u91pXITFQlTC0NMTC3dXe0MwAlG16bXpdBKoq
 UaZyenF0qVPm2N9sZTTTKSkKPvM4wyYVDHotFgZtmh1TdS+XVHWWG025i2rsHaQ8R9ayTtKtSIM
 LST9P78U31IR3v8LTr2Vc2OEud+Y8FWMkE2qwVHDbR/XbCLFTdHZmFhIGwLalw1kUXtyuTAOoMo
 tpYkgp+Xyr7LWJFCeXrqZ8aNqNEjD2QDMm01cL9icW7CQDDUUah5525SYMWYVcuzwPdADqxLn/R
 6FCJp30iqO7CuWFovugpPacB+T0dTw==
X-Proofpoint-ORIG-GUID: hEIcVTfsGA0bN-7q0U7qrMOkyvNKFW1A
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-10_05,2025-11-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 malwarescore=0 phishscore=0 priorityscore=1501
 lowpriorityscore=0 clxscore=1015 adultscore=0 bulkscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511100118

On Wed, Nov 05, 2025 at 11:17:37AM +0530, Dikshita Agarwal wrote:
> Improve the condition used to determine when input internal buffers need
> to be reconfigured during streamon on the capture port. Previously, the
> check relied on the INPUT_PAUSE sub-state, which was also being set
> during seek operations. This led to input buffers being queued multiple
> times to the firmware, causing session errors due to duplicate buffer
> submissions.
> 
> This change introduces a more accurate check using the FIRST_IPSC and
> DRC sub-states to ensure that input buffer reconfiguration is triggered
> only during resolution change scenarios, such as streamoff/on on the
> capture port. This avoids duplicate buffer queuing during seek
> operations.
> 
> Fixes: c1f8b2cc72ec ("media: iris: handle streamoff/on from client in dynamic resolution change")
> Cc: stable@vger.kernel.org
> Reported-by: Val Packett <val@packett.cool>
> Closes: https://gitlab.freedesktop.org/gstreamer/gstreamer/-/issues/4700
> Signed-off-by: Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>
> ---
> Changes in v3:
> - Fixed the compilation issue
> - Added stable@vger.kernel.org in Cc
> - Link to v2: https://lore.kernel.org/r/20251104-iris-seek-fix-v2-1-c9dace39b43d@oss.qualcomm.com
> 
> Changes in v2:
> - Removed spurious space and addressed other comments (Nicolas)
> - Remove the unnecessary initializations (Self) 
> - Link to v1: https://lore.kernel.org/r/20251103-iris-seek-fix-v1-1-6db5f5e17722@oss.qualcomm.com
> ---
>  drivers/media/platform/qcom/iris/iris_common.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/media/platform/qcom/iris/iris_common.c b/drivers/media/platform/qcom/iris/iris_common.c
> index 9fc663bdaf3fc989fe1273b4d4280a87f68de85d..7f1c7fe144f707accc2e3da65ce37cd6d9dfeaff 100644
> --- a/drivers/media/platform/qcom/iris/iris_common.c
> +++ b/drivers/media/platform/qcom/iris/iris_common.c
> @@ -91,12 +91,14 @@ int iris_process_streamon_input(struct iris_inst *inst)
>  int iris_process_streamon_output(struct iris_inst *inst)
>  {
>  	const struct iris_hfi_command_ops *hfi_ops = inst->core->hfi_ops;
> -	bool drain_active = false, drc_active = false;
>  	enum iris_inst_sub_state clear_sub_state = 0;
> +	bool drain_active, drc_active, first_ipsc;
>  	int ret = 0;
>  
>  	iris_scale_power(inst);
>  
> +	first_ipsc = inst->sub_state & IRIS_INST_SUB_FIRST_IPSC;
> +
>  	drain_active = inst->sub_state & IRIS_INST_SUB_DRAIN &&
>  		inst->sub_state & IRIS_INST_SUB_DRAIN_LAST;
>  
> @@ -108,7 +110,8 @@ int iris_process_streamon_output(struct iris_inst *inst)
>  	else if (drain_active)
>  		clear_sub_state = IRIS_INST_SUB_DRAIN | IRIS_INST_SUB_DRAIN_LAST;
>  
> -	if (inst->domain == DECODER && inst->sub_state & IRIS_INST_SUB_INPUT_PAUSE) {
> +	/* Input internal buffer reconfiguration required in case of resolution change */
> +	if (first_ipsc || drc_active) {

Another question: can this now result in PIPE being sent for the ENCODER
instance?

>  		ret = iris_alloc_and_queue_input_int_bufs(inst);
>  		if (ret)
>  			return ret;
> 
> ---
> base-commit: 163917839c0eea3bdfe3620f27f617a55fd76302
> change-id: 20251103-iris-seek-fix-7a25af22fa52
> 
> Best regards,
> -- 
> Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>
> 

-- 
With best wishes
Dmitry

