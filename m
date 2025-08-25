Return-Path: <linux-kernel+bounces-785578-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 134B7B34DF0
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 23:25:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF490242B70
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 21:25:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55E8029ACC5;
	Mon, 25 Aug 2025 21:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nnqMBaHh"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BD1D298CA7
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 21:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756157118; cv=none; b=EgzB5Hwhn8giGIvlUzlDKHF8QNQxnRwoq/Fv0AHWJz+2n/iFm//5TW5rtnM8B+kMqt+TPG6mUBeXuHd5+YPGdtcehQsQ/0sJX0d7pB2gu1apjfYcYEFRQgcriMX4ZCxLSq/A6g1l77NcXlDA3cWkCKCllz4C0p3HGYEyaPraHGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756157118; c=relaxed/simple;
	bh=5r4MZoj0Y5JzU2+2IPZhkOGCJXBlDRhkwuEZBX4Z+xQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Of6rfwwFmTUhA5cmLaIgs2GNAjhKAyeZgmiHy0dSKFb6ly08c5WZqPTxuEeB7oP9SuyrfwyNbqKgZTB6RaDeV5eUwEaJlljvc5ZkKJRrRJNt10+5a9OT0d0pEaO1/onlz2yanJ+j6hYld4dmds4orALxSrF3btVijFZ7eNB/mzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nnqMBaHh; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57PI8Idj027134
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 21:25:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=QkdYyByc4qu2z3KivFhAjolM
	bNa7uS7Ln2Vatot7HuI=; b=nnqMBaHhCoIZuQmlmcrujNwKLGlo9GshRQFAxeNU
	4vylH8cKvMtUWWFI1ddEmpSMjNhpINqsN+TsNR8ucOVrKo43CbeGn54aUHeutiWI
	4xuMTNz649EhZ83SyTtXrFykuoVEu++gmwvUEHqpZFDItF9PTbze4yDk4q7PY1Qh
	qDa51+eGeeObAmirYJx2fqGDc6eIdY8yyhy02nhS81vpj4513NPF2jrXrqSOIgh6
	AhNAISH+3NI7ZzGdYWXGS1DQAseOC3f6oHhbaez/KJ/RTpx+6/kcgCDdgY38Pc6z
	oAz856XtwAsgxMKqkvl9mKU9CBxrGnnAV3r/Ft7jT5qmAg==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48q5wdxcxr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 21:25:15 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-70d9a65c324so75414276d6.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 14:25:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756157114; x=1756761914;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QkdYyByc4qu2z3KivFhAjolMbNa7uS7Ln2Vatot7HuI=;
        b=Aa4Y/ZzobgrVOPekpTDW8rdVmIzXiKlZz/TrbmDfGvigI9cHdKd1zn2J/N5Fr1cFRc
         WCgyQI36FNPlvLu2nqIrQNQE7Un/lmzp+mC7gauWhF9KdhQBaWyOWpdcSdoYZaaGylcm
         BZMnRdDIx9TtTRFRXiclmQ9z6J/zDADhdEY40TX5TN4BQrLxy4mEuJlcw7gwRyrbZuQH
         KeOlSTjbNPf5JBbQthpy82+S4sEJMr7iImGO/pLgjiI9QpPw0Wm+U1eFPwyoi5aNI/wO
         CFkkPr1juGZIYDtvwq6t89NNJaDs7o4y8k2hhCLGMKBAcbvXcguvTHFBvSUBtvMNyKMi
         8xQw==
X-Forwarded-Encrypted: i=1; AJvYcCWrHLj+noiZ6HI1rOG9LJCMOsWzSWNQwRSi3iFv8pwi7eSS6YkemrdJgcluwUjEdytOCkZjY02PDP3eX1w=@vger.kernel.org
X-Gm-Message-State: AOJu0YyuwNkiZY6ItnthtIK3ik3tdnHZyJDXO2ANWfW8AFc9wUEfSlcn
	a7HO8ddExkRhY6UA6jrZWqGJFiM+z7EvVQacydzkZ+alwBvcbtdnWqWtja0X+tkM1hVW1EMs3GZ
	xdHiq32h7Rmq8MlZrU7LlxuvS0AWG0AUi5mJ/SlUzlO3v8mMGBCiKmxpAToB4fQpA/Iw=
X-Gm-Gg: ASbGncuWpE+nBQSadevl01w3A8LaObWbN7oyCSPh9rMgnVtNmrYAjSc4rIyLA3x2EZy
	BXZZEhiKjaCkoid38zkPGQDCLwjdE68Wm96gfKWO5t6ozfFDkfoaHnKd7ReMtXXVVKuZQvv4IdJ
	T5C6eRsBuuGZICRp2Xy5gsADm/YIrs4PesEzUTzYX1JGEDrBcRktddYuLTu/J0jdj1Vo0j/wMks
	LGPLGf+hl3n84ojSiUYDL7HI1gWXemM8C6/x96WAqZJ2js3H58CRltX/+UZDf8eCxQtABSQNp7U
	tbBD2Oe/RxnL7Rs82/S2qHFSH0gFi5JUPwYCFKDcdaepspENeUVFO7JuJdjHE3AQ1+P1SW8zVPn
	x4DnLyM0Lga1uk5VWcj0ysvLiMe9qVO9Xfby9nOj3rKNTHTZhq4O9
X-Received: by 2002:a05:6214:5194:b0:70d:bdd2:7cbd with SMTP id 6a1803df08f44-70dbdd285e5mr57898416d6.43.1756157114367;
        Mon, 25 Aug 2025 14:25:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHq2rEu+6ixuxBMxYQ8u/Pd+yFWmby54+NU+NTEPnzzeO9/1ZQ/Y0I6iBmqPcH1qtql2z3huA==
X-Received: by 2002:a05:6214:5194:b0:70d:bdd2:7cbd with SMTP id 6a1803df08f44-70dbdd285e5mr57898016d6.43.1756157113775;
        Mon, 25 Aug 2025 14:25:13 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55f35ca730bsm1836015e87.148.2025.08.25.14.25.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 14:25:12 -0700 (PDT)
Date: Tue, 26 Aug 2025 00:25:10 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Abhinav Kumar <quic_abhinavk@quicinc.com>
Subject: Re: [PATCH v3 19/38] drm/msm/dp: no need to update tu calculation
 for mst
Message-ID: <c3e7aemrnvf57rupfegdetprztvrjyn3setvh7xorehm3wtxjn@mm5brbolt4zg>
References: <20250825-msm-dp-mst-v3-0-01faacfcdedd@oss.qualcomm.com>
 <20250825-msm-dp-mst-v3-19-01faacfcdedd@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250825-msm-dp-mst-v3-19-01faacfcdedd@oss.qualcomm.com>
X-Proofpoint-GUID: vXfupObA1GghJzWTwHvRWBR3_3jdcJzO
X-Proofpoint-ORIG-GUID: vXfupObA1GghJzWTwHvRWBR3_3jdcJzO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAzMyBTYWx0ZWRfX6e97zbkBsHvJ
 RaKsjrL4Kxq7VNPkBw1LG7tbsCoLQH3EFITJjdK19V5hX6iGt0pguSjI8GWAupqlU7N8oZcbnAS
 Wro0VcJjAvsFJUTnJf7xy/4uKhPToE1vzjbn5WUKoywCLwDZ3N9a1fbpIsl5T0/PwTKu+aabpU7
 QVt7vZRD/l8mRi/efkJHU1aOufYhQiocSIc5nOREmHuptrQ2/UMXnTM36r7a3Ug7UIZ4OBCB/Mu
 BN6Wf7VNPzo/Y77W69N8Nqp6bhqiXrrgRAUaYeBSSFT/jwtT0fSWwL8I2aAEBdFQSClWlirV254
 jzbhMXT8z5U2FuW1c0ckDCOCEvZTYEeAQLTxVJG7a4nFZFuKKSqFloX/spYD08r5bhYG63qyKdj
 kemZpwFu
X-Authority-Analysis: v=2.4 cv=BJazrEQG c=1 sm=1 tr=0 ts=68acd4bb cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=rNJhjsDl-Jf4-vzM-zAA:9
 a=CjuIK1q_8ugA:10 a=1HOtulTD9v-eNWfpl4qZ:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-25_10,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 priorityscore=1501 clxscore=1015 impostorscore=0
 bulkscore=0 phishscore=0 suspectscore=0 spamscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508230033

On Mon, Aug 25, 2025 at 10:16:05PM +0800, Yongxing Mou wrote:
> From: Abhinav Kumar <quic_abhinavk@quicinc.com>
> 
> DP stream is transmitted in transfer units only for SST
> case there is no need to calculate and program TU parameters

comma before 'there'.

> for MST case. Skip the TU programming for MST cases.
> 
> Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
> Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
> ---
>  drivers/gpu/drm/msm/dp/dp_ctrl.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.c b/drivers/gpu/drm/msm/dp/dp_ctrl.c
> index d562377a8d2846099bf0f8757128978a162745c3..c313a3b4853a1571c43a9f3c9e981fbc22d51d55 100644
> --- a/drivers/gpu/drm/msm/dp/dp_ctrl.c
> +++ b/drivers/gpu/drm/msm/dp/dp_ctrl.c
> @@ -2685,7 +2685,8 @@ int msm_dp_ctrl_on_stream(struct msm_dp_ctrl *msm_dp_ctrl, struct msm_dp_panel *
>  
>  	msm_dp_panel_clear_dsc_dto(msm_dp_panel);
>  
> -	msm_dp_ctrl_setup_tr_unit(ctrl);
> +	if (!ctrl->mst_active)
> +		msm_dp_ctrl_setup_tr_unit(ctrl);
>  
>  	msm_dp_write_link(ctrl, REG_DP_STATE_CTRL, DP_STATE_CTRL_SEND_VIDEO);
>  
> 
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry

