Return-Path: <linux-kernel+bounces-742394-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39AB5B0F12A
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 13:28:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 656F517782F
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 11:28:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B74872E4278;
	Wed, 23 Jul 2025 11:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Sk+5+Yf9"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EDAC279DDF
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 11:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753270073; cv=none; b=Pq7xEgUsrNhXzN8KvtP0PbvfnQS70ISRKaNPb+fbD2ny+2fFtf/SHY40ib0pPvmTH5RMj8C4ho56i9RW1e/T1o0ZIgumIF+hTlfgKAM+JuQjM/qRhW4Gs0x9h9lkc/yQWERLc+7l4BrbDJkflrNr/3PoTZcaWpdszrablXcUiqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753270073; c=relaxed/simple;
	bh=fIii8CPzLaxr+8Q5TdczIHeQub3SFOIbm0DUglnoY6g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jrxdKdX01mrjcFBkp6Lr0MHd7MCFIw+nT8dBS8SMGQf/7D82MPK7uvdmcsyEI5Cw336xEp92FubSIRbl+2Y7CRxnKIAmKYsT7QxQwk5wUCO3ogB0DrtsUAnx6nR7WCbnJe2YBsjOSunO+IqxIZabNJm7+bcyTi/x5nSjiPIIlLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Sk+5+Yf9; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56N9DBAV008077
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 11:27:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=qeCD6Fkh/pxEJMi+BNUYGUh2
	1k7BC1qEIuPfYClcWP4=; b=Sk+5+Yf9/zu8AjawB2THbFdcbUeTOntlSJqFsGcY
	zcr5uUjBMo80gum1G35qgwKVAEUtR6CeiTxwMvvxjg5FPXmoxATLNbN1roDm8bLR
	08XOFT3Ez9QlzcZ9TBXkIz3wMQuJ9LCXOP/xdrfj157ULaABdEJIx+yNDf3KGhWG
	BNgeVFknqc7sX7TkeOwhkOTR/XNS+UptLu9/eEnJh0fd/Z4E3ys5HiZ3I5szQOjt
	yevdWsEjzIbAikVIIRrpLBxI8HJ55Vl3K+3ymwkVqoQI6/M1Y9DhKj/1dzD2Z51F
	YC7jQtbKjlxazl3yP6+dt8jziOBoUb5vl2ELaLTlVO9VFw==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 482d3htytf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 11:27:50 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4aba439b4ffso132119361cf.3
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 04:27:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753270069; x=1753874869;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qeCD6Fkh/pxEJMi+BNUYGUh21k7BC1qEIuPfYClcWP4=;
        b=QdVctv2r3blmnmRu5itvcis8ZgIHOMILxWISvsTSb6Oz9Hot5uDUY4wpsvtHnGgNYK
         aHpC8ey6StUkEBTPMRle7jPyMvfoTs40FUTI6+EJDqppKTOFExNoOshhI2mjmMuwJsr1
         WsF0lwX0kvx3/HJOzvem/eg2GMFy0zH9kbJ2spR0+LvhcqZvTtr0qsT1TAHjPTZZJ1tp
         QvLkuMe29IRXbRo4d+Mm+QuQ+f7lumK1SALWgr6Qb/TkCMgVRmSR04i+XJCFGCzCDBV6
         Osq/EYsk1te8QjKJP1eDJogaRGh6JZ7aIdg9K8iD7sTHelC4st7sVTEQQ/7IAd2j8e0w
         PR/g==
X-Forwarded-Encrypted: i=1; AJvYcCUl3FMb+euzYHlSoOkXRBh4+SxVtZ+F5jr1a/SIS9pSSyxokQ7VinDb9+mTyFriUXBOyNTvpqSvZTpvY3c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2s4K8AZ3GsRWLzqjSudK0LUQbFg0HOqbjc+gJjFfeobAYARuT
	tXELaVlcPbZ+53sScKZIRFokjjkp+OUmrZK1eBLJAgsOD//FmuCu1khpeB3P22aWVHgGCm5DHs4
	VfLqaUH9lznUsNsvdFaCDW387WGWDcgdwgs6UdlTxMmFkK8seARFfi2JQcs9Xs4slmO4=
X-Gm-Gg: ASbGncsmI72V0gPR0KxNSpKxY/Eaz2wk4+cv2bCJ5Q0EaYcRWUGlvomCIelfZEUyJaQ
	x3FJLdOw/F9Ofm/DMoAay8qqcx8Q3O7MgTCEx+2szOIgSXw2oNXekRN7rk1AX2zLG8fy+Bjy0Z/
	wiyy2weTjNByLbR97fFBpdeCvy9TcDV5Qdr8cBL1/2UD7Qd+w7iZZLpHwk4AKtY/iYWaNJvyR8T
	FYuQ3rLgQxjCuXZzOvbCqv0yB12nRFtyu/m0w6ZU0B6tVa7fFDC4uZOrrMxKBdBYsmbbDh9WYyt
	jaKodvs28oxute+5DjT3Bfl+aQwd5myileutnTo3DA8bPtsJycvcw9P4Fvue1qpYR0wusYGiiwb
	QqqcVEt8PE2nQVuX9eE4G/4POUHKgrNsS50OQuHGMgoGxTxnpUzHe
X-Received: by 2002:a05:6214:d88:b0:6fd:8fc:e2fa with SMTP id 6a1803df08f44-7070081a06bmr31455976d6.32.1753270069190;
        Wed, 23 Jul 2025 04:27:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGBXp+ymaI+ImLJaZLkIyrsa+QANloK+ouHSdgzPt73MW0q7/7Z+0I4TmrLTAxziK4A4WlcRw==
X-Received: by 2002:a05:6214:d88:b0:6fd:8fc:e2fa with SMTP id 6a1803df08f44-7070081a06bmr31455526d6.32.1753270068654;
        Wed, 23 Jul 2025 04:27:48 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55a31a9b1bdsm2282861e87.19.2025.07.23.04.27.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 04:27:47 -0700 (PDT)
Date: Wed, 23 Jul 2025 14:27:46 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: yuanjie yang <yuanjie.yang@oss.qualcomm.com>
Cc: andersson@kernel.org, linus.walleij@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@oss.qualcomm.com,
        quic_tingweiz@quicinc.com, quic_yuanjiey@quicinc.com
Subject: Re: [PATCH v2] pinctrl: qcom: Fix logic error when TLMM reg-names
 property is missing
Message-ID: <nqujsfdojllp74ykhskftdgj6kcvje726av2bgu5xqymiwvzl3@mw2cqji4qzqc>
References: <20250723075024.4604-1-yuanjie.yang@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250723075024.4604-1-yuanjie.yang@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=G8UcE8k5 c=1 sm=1 tr=0 ts=6880c736 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=QEazjGFzAr2dnAQsEO0A:9
 a=CjuIK1q_8ugA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIzMDA5NyBTYWx0ZWRfXzXDsuZjQ+LUD
 NYzFC8cJi30HIs/hcdRfy51tdHDegBy8rS3eMWBPSZ/8LEXFjD00WCCyCLyt1H/jd92ZijP641S
 qO73oHnzxSPkosCPzn7p7syEPPbmaAcZMmZO7GZ0DnWzBT/+8NuAlOOIZKn9U3inAHpPCK2BKQX
 fnbYD/13wDk8S5yNExEi6z6VsKFK6WTIMhedIHr6lnlUHPbfPjO7KSZRaPL72iLNvruQjfqW/JA
 AIsyAiglecAJCbL3+lhoF+6SmtKUZoZw6dUt2GHoel0oyXb8bzZrUHEZ9XFiS7VfqIAUOgy0zl4
 f8OWudssNU4LIEy9OIFixqVsfHw6JtujYF9wzqWIW3mLy7Wd2HoBNdNKqcdFgksIcC/ZSIhb/Pm
 VRVBNYhgTvKLorbY4o15n6l2jhhLsz3rRJPhPDAUOr7xlLlAZda03n7cZnpNHF/6rpYcELq+
X-Proofpoint-GUID: ats5tKFgKHSA2oA09170oNQfLDa395Vb
X-Proofpoint-ORIG-GUID: ats5tKFgKHSA2oA09170oNQfLDa395Vb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-23_02,2025-07-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 mlxscore=0 suspectscore=0 priorityscore=1501 clxscore=1015
 bulkscore=0 impostorscore=0 phishscore=0 spamscore=0 lowpriorityscore=0
 mlxlogscore=999 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507230097

On Wed, Jul 23, 2025 at 03:50:24PM +0800, yuanjie yang wrote:
> From: Yuanjie Yang <yuanjie.yang@oss.qualcomm.com>
> 
> Some Qualcomm platforms, such as sm8750.dtsi, define a single TLMM
> region without the reg-names property. This is a valid and expected
> configuration. However, the current code incorrectly treats the absence
> of reg-names as an error, resulting in unintended behavior.
> 
> Refactor the logic to handle both cases correctly:
> If only the gpio parameter is provided, default to TLMM region 0.
> If both gpio and name are provided, compare the reg-names entries in the
> TLMM node with the given name to select the appropriate region.
> 
> Fixes: 56ffb63749f4 ("pinctrl: qcom: add multi TLMM region option parameter")
> 
> Signed-off-by: Yuanjie Yang <yuanjie.yang@oss.qualcomm.com>
> 
> ---
> - optimize commit message
> - optimize code structure and fix kfree issue
> - rebase on tag: next-20250723
> - Link to v1: https://lore.kernel.org/all/20250722054446.3432-1-yuanjie.yang@oss.qualcomm.com/
> 
> ---
>  drivers/pinctrl/qcom/tlmm-test.c | 22 +++++++++++-----------
>  1 file changed, 11 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/pinctrl/qcom/tlmm-test.c b/drivers/pinctrl/qcom/tlmm-test.c
> index 7d7fff538755..e41fe7e76c80 100644
> --- a/drivers/pinctrl/qcom/tlmm-test.c
> +++ b/drivers/pinctrl/qcom/tlmm-test.c
> @@ -581,10 +581,13 @@ static int tlmm_reg_base(struct device_node *tlmm, struct resource *res)
>  	int ret;
>  	int i;
>  
> +	if (!strcmp(tlmm_reg_name, "default_region"))
> +		return of_address_to_resource(tlmm, 0, res);
> +
>  	count = of_property_count_strings(tlmm, "reg-names");
>  	if (count <= 0) {
>  		pr_err("failed to find tlmm reg name\n");
> -		return count;
> +		return -EINVAL;

Why? It's better to propagate the error instead of reinventing it.

>  	}
>  
>  	reg_names = kcalloc(count, sizeof(char *), GFP_KERNEL);
> @@ -597,19 +600,16 @@ static int tlmm_reg_base(struct device_node *tlmm, struct resource *res)
>  		return -EINVAL;
>  	}
>  
> -	if (!strcmp(tlmm_reg_name, "default_region")) {
> -		ret = of_address_to_resource(tlmm, 0, res);
> -	} else {
> -		for (i = 0; i < count; i++) {
> -			if (!strcmp(reg_names[i], tlmm_reg_name)) {
> -				ret = of_address_to_resource(tlmm, i, res);
> -				break;
> -			}
> +	for (i = 0; i < count; i++) {
> +		if (!strcmp(reg_names[i], tlmm_reg_name)) {
> +			ret = of_address_to_resource(tlmm, i, res);
> +			break;
>  		}
> -		if (i == count)
> -			ret = -EINVAL;
>  	}
>  
> +	if (i == count)
> +		ret = -EINVAL;
> +
>  	kfree(reg_names);
>  
>  	return ret;
> 
> base-commit: a933d3dc1968fcfb0ab72879ec304b1971ed1b9a
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry

