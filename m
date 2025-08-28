Return-Path: <linux-kernel+bounces-790848-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A549B3AE4A
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 01:12:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C22D8A03C86
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 23:11:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 969B82D8DD4;
	Thu, 28 Aug 2025 23:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="d43CzfJk"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AC5B2C3770
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 23:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756422687; cv=none; b=DICVm9fv3zeL+SO8OQrAB57bd4Z5ZbsxNh9i/opwvrEGTB3xf/fh6CkM7OQPliIkvGlh3qCfMt10+gJNEM6egt6pm2HEsPSafYPD6HjaLRdywRkoRii/ahhfQp+RLBMX0wRNq0UiRv1MFr8YfE7zmuiBSBeIXa+l4rqbR+vB000=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756422687; c=relaxed/simple;
	bh=1j4WdwrHnByDSgy1mNxjpBE/DzKlTCKPkMm+zi6X0Fo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D0D8AhfXeC4ft12HzQQ0+NfiBD1dC5anmc0D/f8PpgnXVCMutK/K3EPfFVFobbPj6/r5gnKxNQA8Y1/Vk7xCMxfGMorTSZAgIOrbvUf63SU084BbjAao0KzYtUZnqTAW7kRRg/dCncFEfiQ8dlfuUsvBw/ZbA90zko4owWO97jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=d43CzfJk; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57SLWnsn006225
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 23:11:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=CcwPb98D2xg5sUyCBoeco6KS
	Je0ON7jV0q8gk3wftUg=; b=d43CzfJkVtNCcnXvTigbg9V2wZhs9tPvt3pGpY48
	UMtN7J9Z3LNjTXjydLSp1gFM3mmRW+FKQverrMHoObEWbtNKOvpPVszoUy5kwjnE
	lj+5+S4hExYK8MW+4ruwCCFZ5j6rwtDoIYG6zNKtleyYQuNot14ymqJexK20uWqw
	x3jJt1zKSPb9tHFJMl0Ss2O0/KZ59UAiw8mwK8Ax52G9Me0Tigz4ERp/IKiJsrWW
	RowNZtFJeEf1klzJSd9G+DJtizvZ+VxTpdrD5/Z7v975jxRM9zQjyioumPbd7tq7
	QQlofmvZrRGQbzU2a0hX11We+jnezP+nFvJDwGXCgwgjeA==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48q5umj65r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 23:11:25 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-70a9f562165so42419856d6.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 16:11:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756422684; x=1757027484;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CcwPb98D2xg5sUyCBoeco6KSJe0ON7jV0q8gk3wftUg=;
        b=nMWC2Z1AzEbyY6YGmzoaTr0MYhKrHmDZyxbLkumsZsH9hM8FNMQSzuiFJLYzQ3XYrv
         +8ZdKoFtOVwOhdhn5iJUdQJMvgS9gYo/a03zM5Qw5nrOa1yZIAVsQ2WgoidfQ2wku5Nr
         y8q8W35LF4zLq8QWc3q8qIK0E4On68zj7mjCoUJiQi2wvc50QOiMROIyfHWvfWyeCLdQ
         o8kDUBgXWsXZIkyoir1kZSIZLj1KWdmvfamybYC2gW+cC7BPbsonjb1zUnt7KVD3oR1S
         4qz530syDoxudDUMnA0975+JiOD7Hftw/3iq3snRlgeL86dlOym1ENusH/+YNWhNMW85
         QlBQ==
X-Forwarded-Encrypted: i=1; AJvYcCVG8wrz4R7TpQrRfjKNVSqfNn8N1JL5eQUqPqg0BBrc/E9XubZ9nUEkNtNna70ll0FZ6kTiqWaSdxe6yNs=@vger.kernel.org
X-Gm-Message-State: AOJu0YytLSEstuWrOgyIP+L4mGdNnayew5G+yuu2f8XaBAjCp2ZxGuxj
	RUyIBAi7KD8TpEmbFwgKtjWH3Q+5EAv/31UW+6rTV67HrdTZUpj0sNpb8w38Bh3qbATFTxQFHP+
	RTGx3lMofyynry7WDW0SvMF37etcTp2xxSX23exKf3U4UqNc0GI9MKZOzHo9JUWFc2Zk=
X-Gm-Gg: ASbGnctwTxyB/7pArLUVfpmzhTmnkdQYOAfbHqLkz/obiK20RW6iabQvjaUi+rrkYoF
	JXytpB13R3TKkrkihv3s72Q+vgFqOa9uzebb4OUsIuBHwyJ2hja+PNxl/o6ZO0hQ6i2bNydTolR
	4T7lS89nPwCDlkdzWjJUv3iCUTBzeFXI/dz7VdbTNGQl1OdIME3+p05v9mkXdHyxsnr/b+dj42O
	yk3ALltM6FqS0x2DGUMCrt8XnAnxWm/el2w7wXdxOb4RtVKmLyn8h/FK+7qmvznsoELoHVzuIJt
	RlkNHxwTvoMZPWYKDP7kKzqhPigSfjiy0671P6zzf1LK2rH37P+1jHxTvTbw9LwhvkvbVXJq1Mi
	FF8//OccbxWBxmGimbMijMjF52NXngM8xn2RO+Uur6QdAssrl0uXP
X-Received: by 2002:a05:622a:5793:b0:4b3:4d9:1a20 with SMTP id d75a77b69052e-4b304d91c8fmr37454741cf.46.1756422684216;
        Thu, 28 Aug 2025 16:11:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGhgdun2fn1jFqmiQbfyBvO+zPjYV9lB5FdqpEXRjyP1PtkoydoYjW2c/bS7zgz7W252CkZPg==
X-Received: by 2002:a05:622a:5793:b0:4b3:4d9:1a20 with SMTP id d75a77b69052e-4b304d91c8fmr37454411cf.46.1756422683667;
        Thu, 28 Aug 2025 16:11:23 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-336b4613c10sm1461051fa.1.2025.08.28.16.11.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Aug 2025 16:11:21 -0700 (PDT)
Date: Fri, 29 Aug 2025 02:11:18 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org,
        Dan Carpenter <dan.carpenter@linaro.org>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drm/msm: Drop unneeded NULL check
Message-ID: <l5t72pobsea2mcsulxsomrqpbeezj22vdtp7gqg6zjlqwzkjgk@p624paf4vhn3>
References: <20250717151202.7987-1-robin.clark@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250717151202.7987-1-robin.clark@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=VtIjA/2n c=1 sm=1 tr=0 ts=68b0e21d cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=-2mmMjQWwNZ6YRhNbUMA:9
 a=CjuIK1q_8ugA:10 a=pJ04lnu7RYOZP9TFuWaZ:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAzMiBTYWx0ZWRfX5JhAQ9oAFiOd
 OLf1lRD6jQ29cOrfcknB1S+E19I3iBO3b64U5HamIBOIwKIXXIKkEgbvySRMsF6oDjnuArIDYwk
 6BZ2r/D/TjTCPfkUyqH+Q4Wjh07OwdRNEVdlTM3DxOZ341DajkirJuJ28GVmZlnwtHXJK10zx+X
 Si/Aw3Vz4xQ4h+BCizB+XX0BgJXogTLQVdnV0oQmHOmJgG7/pUNABXYQ+XX6XtTCDujjitwVG2u
 cTxvkcToeiBH6BpBNpU38ssZ0eb/slgH57r/3mq7WPCZFvHcTvEdDJ3/5VFK/ayj9RR0IkC37t8
 Yyfk1p4Rn0q6wkHe7qMNotC8gM40MoIIVyksUJMgBX6+DkwG1xaapDzIgFB4KctxPbMstNJRTAg
 pLownqoC
X-Proofpoint-GUID: BBXE7DZ8wRDQPrGL59IX61MP7PjVKDXE
X-Proofpoint-ORIG-GUID: BBXE7DZ8wRDQPrGL59IX61MP7PjVKDXE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-28_04,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 priorityscore=1501 impostorscore=0 bulkscore=0
 suspectscore=0 malwarescore=0 adultscore=0 spamscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508230032

On Thu, Jul 17, 2025 at 08:12:01AM -0700, Rob Clark wrote:
> This is always set in msm_gpu_init(), and can never be NULL.
> 
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
> ---
>  drivers/gpu/drm/msm/msm_iommu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

