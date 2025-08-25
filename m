Return-Path: <linux-kernel+bounces-785610-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E7BCB34E7B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 23:55:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F71D5E595E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 21:55:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35BAA29D29B;
	Mon, 25 Aug 2025 21:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="bnEXUW47"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DFAE23C4E3
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 21:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756158945; cv=none; b=hpIgD2viMvb7QrYQRzNpZZpkocqK2hEEl+YvoJXolA0/nyxwmDuVyh7O43xgsmGo2oaYQiSyEa8yQoF+bykRXjY9OQhzfX73LKMOpaGqdgVMgdDT2klF4XHTj6yXMUXaH/mX6VG6kG4A8R9h0b2rS+T5e95AeMyhlfubSmzFwlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756158945; c=relaxed/simple;
	bh=NXFEpNyEVttMDMgHEZeZ2cvskfO/A0LFfXyq/AemQgw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uRBGJOuSE7HE/VUMn5r2EcuegD19w61nn7ZazhY5nPTOJOEfqmHOPEq7i3yEaUNDxiTDwuEQerUMosWCeXireZxyp+RoinjhHTovElUczvU0VJrlIgSRHPSxmHkiQv6VASS8No7VMCrb7wvvTCjnUGH9zeObw4j/K3yC2EKiwoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bnEXUW47; arc=none smtp.client-ip=205.220.180.131
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57PFnNPd028623
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 21:55:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=cUqE7qCCjIfKy84Rr0H8Cz13
	kHS6QOxmkyR9AlwzF6w=; b=bnEXUW47jL0w7zec4aFNHejepHoQkNSHY7DZ9tek
	bzcbuSbguIBNE7yvx29VLJVkjPMI8RM6ndrvUJ5lAoxPtjANKfkoQCICsLcGFJUB
	5VW/vG1q1VKUjxcDaKk6vamrDriNQSXWRFb0Ws7IroTvrnttx4bKg4fUWCbr5ycA
	md3x9uy/CZLIQ/m44pVbLbAATU+vi8VwcaaYe7B3SB87xvnfRAzksN596wEqNWb4
	6y6tgUoXlR/L5KDO4G7xuDKVN0FUBTWdgJhKASYYS/uOuTWAvXVFPOmgOLXe7IJI
	uk9x0c1Zi/xpjBjVHkZNdfGTxFtNlu56KQVc6GU3nHv7Bg==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48q615egeg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 21:55:43 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4b109bccebaso140604461cf.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 14:55:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756158942; x=1756763742;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cUqE7qCCjIfKy84Rr0H8Cz13kHS6QOxmkyR9AlwzF6w=;
        b=oRibj6DnIpEJ0WZRqSxn9AVkWuDnWke/HsZWweeB1HkfiUx1OQDzYCEwX+odblqkAZ
         zLPA/5nW5L+MfqqUZE70RVFy7FFUWTQQa1BR33apKcSV8/WcxzfsrBeYxXf7Kuy5vhbf
         faW2Rw/RTMHHIs8aS4m7IPv/1ihHkFKz3KlfQQq93RWi1ERXYGhatvF8J+6DCUGl6iJi
         Zc4gPtQxxglK9gc+GFZ1p6vSYoVDTzbWEQjbg6Jm9zY9dOnuKCHgcKuPTk7Ve+kDY7DS
         LbTCnZiGlWOH9/bEuS34RIjgrwthx02EpkCp/M31GSxZ51ehwERrSQT9u63lN5LHwjje
         P3Aw==
X-Forwarded-Encrypted: i=1; AJvYcCXEqDxbkB8M1q3hstAkBqn4G6pOSuivIbtquU5r/oAoumRRvijrKjkWpL/7ZyzTLPl8gnCPiQNuRSNYnfA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzx0k58ia57wvogVU+CKALGuKWjcfyVDx/ElHR7ea0NwQlimIzf
	05chlK/4l1wJD8mg9n+gK2TMPRMrEFZaz2+GSS7THvx7cmaSx4xP4rbqqNBCVRw+1KSo9aKVCa3
	2g3rqEJdoWhWhY8RUeq9mcLs3gexNYw3UUft+CSv9UX9r4x75M4ElBQQnw7H8QKm1z7M=
X-Gm-Gg: ASbGnculJrWZdCs5rExWQQ8ifabU6BGrEfanlcMtASf2O+pKFEoNdPfjEl6yNNstSlP
	OAadV3+VPLbf93fWqNd57gBIvVdMEkwI3nVaHNjA0WszzSLVSfKJSvFuZ2SoK4W4WvQ6L2hOR/1
	S1kPIM7Te58HC8Hg3ie09FCcI0nz36cy/s0eWilIacOAaWHl26tskGjkCQKYFVIFzkOfBD62ZtJ
	l7FfhqIma2fex4SYOuP0Zp7u/E9LsR6szxgUwJvMBhLJAM+Pff+vaeBu0K34wnH4e6RlzQUP1NJ
	sChF6JOc/HWxc4uU+D2Rr4wMBVVPa213gARjD7QUZbn8ZYkXQPupXPMfdzPiqZnLYLawWJVIFmi
	o9dc4vWRnKKfV+QlCzZhPLDvrWx09aiNIgW+9bt6kd2hrm+m31SpN
X-Received: by 2002:ac8:7e8e:0:b0:4af:1bfb:1658 with SMTP id d75a77b69052e-4b2aaa196b0mr152453111cf.12.1756158942090;
        Mon, 25 Aug 2025 14:55:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHFoMD3lKyx/+uaoF6/Udx3va33ITgDznogbeIupv27fT8xR/EpMcyEGrE5fvEV0eWAe2Y/LQ==
X-Received: by 2002:ac8:7e8e:0:b0:4af:1bfb:1658 with SMTP id d75a77b69052e-4b2aaa196b0mr152452801cf.12.1756158941479;
        Mon, 25 Aug 2025 14:55:41 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55f35c8bacasm1855198e87.97.2025.08.25.14.55.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 14:55:40 -0700 (PDT)
Date: Tue, 26 Aug 2025 00:55:38 +0300
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
Subject: Re: [PATCH v3 22/38] drm/msm/dp: Always program
 MST_FIFO_CONSTANT_FILL for MST use cases
Message-ID: <s5a6fpyqg5nybnnbrv7wwjvrsj44tr4cihcojkcfwmz5dc4r5m@rioxbgxvwayn>
References: <20250825-msm-dp-mst-v3-0-01faacfcdedd@oss.qualcomm.com>
 <20250825-msm-dp-mst-v3-22-01faacfcdedd@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250825-msm-dp-mst-v3-22-01faacfcdedd@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAzNCBTYWx0ZWRfX5kqc3t6h5VUO
 9hUcAl7J1au3jWvxvws6YYQRbMBDrhhKZFnel5BSOxLddQ536BDbgNR776rR+NHyonENDdh5nlu
 QsJD/lpXMqaTMOhXabJ2Big4A5wHnZsmNsrp0uZrJBv3kt4PbF9ucBWcV5LjgZmGBuNVGi6a98c
 7vi53HfhA3HnwjBn9UaSrLle6emvU/mAvCEtmR8RRlqriERsae8bsyX4Ac8iryyXJxO2FKM2d93
 CBoznQ5Ft7ERB/iICwo93dcz/bokxCpN1PpRQ0UR1knwO4VTYfqq6MHgQlrx1LqFvskDUkSiEJ5
 yh5waLkR2i5iCCVjJOL7GFd51MRFabi19POF+2w5zcAjm2V7vCYhQq/hQjE3Z1pXDbHU/GFme5S
 u56yn5lm
X-Proofpoint-GUID: xfHHIK3-jE2uXSp9AF9aaecCJJRfz1B-
X-Authority-Analysis: v=2.4 cv=K+AiHzWI c=1 sm=1 tr=0 ts=68acdbdf cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=1UWbhTYU8iixJmD3m_gA:9
 a=CjuIK1q_8ugA:10 a=a_PwQJl-kcHnX1M80qC6:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: xfHHIK3-jE2uXSp9AF9aaecCJJRfz1B-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-25_10,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 bulkscore=0 clxscore=1015 adultscore=0
 impostorscore=0 priorityscore=1501 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508230034

On Mon, Aug 25, 2025 at 10:16:08PM +0800, Yongxing Mou wrote:
> From: Abhinav Kumar <quic_abhinavk@quicinc.com>
> 
> As per the hardware programming guide, MST_FIFO_CONSTANT_FILL must
> always be programmed when operating in MST mode. This patch ensures
> the register is configured accordingly.
> 
> Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
> Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
> ---
>  drivers/gpu/drm/msm/dp/dp_ctrl.c  |  2 ++
>  drivers/gpu/drm/msm/dp/dp_panel.c | 12 ++++++++++++
>  drivers/gpu/drm/msm/dp/dp_panel.h |  2 ++
>  3 files changed, 16 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

