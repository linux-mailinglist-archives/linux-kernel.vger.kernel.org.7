Return-Path: <linux-kernel+bounces-777006-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AA90B2D3FD
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 08:20:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 99F721BC61CC
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 06:20:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29DB42BE7BE;
	Wed, 20 Aug 2025 06:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ONd+zipw"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABE5623A9AD
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 06:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755670802; cv=none; b=ehhetf6jvh+SAL82XHQsZkaJivGTbuVFescBhFNlArQtbx5+Rdv46/umaWNyaKaqZkuHV4MczYtYJuqq70kfDj0XlhBHny4pCdJDekdBXDezE7dxyDLPhBma5SVGrOAAW530/nbL6Y6cIXz3XsuNNL5w+V3YQy9OhnzeJ8YVsyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755670802; c=relaxed/simple;
	bh=Il8EIAg1QfxzNI0BfdWour3oPDvc6yu7jWmA2XyppAk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F1R/RzXAxDYzWuB6+GWfivLJoqXX/DndJFiuqQtk/7DDKSfQ6bgwk9V1KipnH0LsIhx8aBMsqQjUcvYdfnoT8Ho/eEJFrG0KAhJjZ2THS/od0aanqRoZiWOs64porx9nLXyySYUQnMCDoMN9n/lbvWhQIMEcieDnXDo4ZRzOG3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ONd+zipw; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57K1pDIe031593
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 06:19:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=uNKU1Frwft226LHp/hY7w5oY
	RJNUWwbLNrcXicahC3A=; b=ONd+zipwKnNSwK9V/LODsmfaSYK6HjIXDMRmFrPI
	UCd6REa4r+K3y1w6XzKWpuun5Pxw+ghmWONHsRtHXVOCEOOlEhey/U2X6YF2YU3g
	LvsXo+KwnsiHz23ZIp87JZRTD4tHxucNssPuPH48JPl0RiPrSC7YMvACxvwOr6nD
	j24uTmbb+FFwr6Z9aisfZO5K4vGZ4VFFxmJpGXUoE5LBZoHRGCLQLl95/pIiSMZS
	QoB98yj+6Huy3BvE62fBcUuZJ61gn1rxPUwhcTIWU+LXNmQ05yw7yZ6YIB+dGae7
	0Y+AtoAvUcaYSQQfug6ZnbtW1932hHxAdrLGiFJScaoWxA==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48n52dgkwe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 06:19:59 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-76e7ef21d52so3881687b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 23:19:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755670798; x=1756275598;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uNKU1Frwft226LHp/hY7w5oYRJNUWwbLNrcXicahC3A=;
        b=YeMQQN+uQUWt5/D5c7S4QX3xXj4SxiS31pqCA/NN45rattYw9fQUnYwcgUZeU3lLwS
         T4slg2AzhPFaRKXg6Afa/Sv4xjLgEHkyXYKDb5LnfSqJIanXUCwr7XBJEPoiY+hgNwUT
         Swhyrslev3PdEGMgQM1jMiovAvszQ495tDHhbZSafjiZXwJ0CWh7msu/xKmBH5kHq9r9
         8u1+X6zCabgNy+KVd5omh/22TrR37AUdJhInY4d1KGL7MhznZshdZv7DVDagSdUJeM/c
         DTZnF3Uzn5gnDMMgJLO4mbWNizMLmla0lqTNb8LpCge5P6uZgEA/CWIR85XMgL27AU+y
         a2nQ==
X-Forwarded-Encrypted: i=1; AJvYcCU7pi/xO7GKxneG6/cZPlotU7ps/MdnyinRI0jF0sOQRyo/BfjmBUXq+C2dVbFXCZlYWFxDIIVa+46tRbY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvjQBVFS5jkiPL/tDYlf89QDPvOcCrLE+d1+rMvwdW8DF6LMuo
	Hj/uT6lrwwbN8R/2Lrimr+WXQufZe4c0pU+aqD8CstUTconmU2Fg38SbHGIpqYfla4kuYPn8G0M
	5w4i7rYuLHNzZe89xZLtQJI/Q2nLJvp+Aw3YEBEgRme+O8WX72SvPMM1EbER0Ooo5D0gW3HGVlj
	c=
X-Gm-Gg: ASbGncsLrSsUFupU0qJlFumg6Xa0DRfpXDnP27T3iEp9+wIfxUakKPTb4mvuhcVgbDO
	8dLo3r7K9N93NgHvgmfaFXI9HtD6qsMKg/H1Fx5sk3muF1Sidd/jSboZ2c+RcirQRdxBcyPzbKk
	wTNxgC9A+GmYWcN54fsdeXOs4DrKp20yemT7GBcNBtKiu3fdYkqzYiV9EpQILaxka37sEJrY7NH
	IpT6/O9W5ZrTmlI17xfTJhK0z4HMofN0TAwDRx9x5RUAXTrCmt+q0rUOS4sEoBs9vjd6rzzxDQ0
	tMtxvQxB6bQWaOh8/aNxzHPXIiGEwjyFDprvNQIb8bHhZbGGOkpiDPTYbiYd3BOLy7o=
X-Received: by 2002:a05:6a00:1989:b0:76b:d8f7:d30b with SMTP id d2e1a72fcca58-76e8dbaa401mr1993145b3a.10.1755670797780;
        Tue, 19 Aug 2025 23:19:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFVWVmutWphmCS82Rcwj2tmZT39j3z+E7I3LxdsVVCYqR8vLEcV2M7wRqe6Vip/Yxu0WHvoGQ==
X-Received: by 2002:a05:6a00:1989:b0:76b:d8f7:d30b with SMTP id d2e1a72fcca58-76e8dbaa401mr1993117b3a.10.1755670797336;
        Tue, 19 Aug 2025 23:19:57 -0700 (PDT)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76e7d4fd29fsm4335862b3a.72.2025.08.19.23.19.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 23:19:57 -0700 (PDT)
Date: Wed, 20 Aug 2025 11:49:50 +0530
From: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
To: Pavan Kondeti <pavan.kondeti@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Vikash Garodia <quic_vgarodia@quicinc.com>,
        Dikshita Agarwal <quic_dikshita@quicinc.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-media@vger.kernel.org, linux-remoteproc@vger.kernel.org
Subject: Re: [PATCH v2 01/11] firmware: qcom_scm: Introduce PAS context
 initialization helper
Message-ID: <20250820061950.lqsuoj7u7se75mmj@hu-mojha-hyd.qualcomm.com>
Mail-Followup-To: Pavan Kondeti <pavan.kondeti@oss.qualcomm.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Vikash Garodia <quic_vgarodia@quicinc.com>,
	Dikshita Agarwal <quic_dikshita@quicinc.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	Abhinav Kumar <abhinav.kumar@linux.dev>,
	Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	linux-media@vger.kernel.org, linux-remoteproc@vger.kernel.org
References: <20250819165447.4149674-1-mukesh.ojha@oss.qualcomm.com>
 <20250819165447.4149674-2-mukesh.ojha@oss.qualcomm.com>
 <3b74157a-3f2a-4533-acf6-7cab8154709c@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3b74157a-3f2a-4533-acf6-7cab8154709c@quicinc.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIwMDAxMyBTYWx0ZWRfX1hicVrFuPQPF
 OIKnFl4m5v5+lOmxzMpIbvrbnJjM+WPgCk73+y0kHX1/QCvIasECvPmQfsQTjyiuJ5coKG/fc6p
 /iESWHQfQk6Z8N+Jn764xCy/34NDOI7QssLlcNLfsjzXeAe62NDFHDScVWlaHcpCbbfKlHZpOUv
 mrMIL9vY8ouy7bTcw5x4tdiFL3DqW2nVvDFX1IV7wcmjPrNU/SsdAwYLLBRbwkuA1h7rl5XdTvk
 ackmvCKwAxyYeLKszVWUuv/O/DsvS/FCKIdkxGiqaMj582WqfpZJTqXjNkcioWw7MBOT/lV34vb
 LqaGnBTKpqwTVA2DplMXvzxZxKbZei+0Unp6WXWqaqxAZ3ce/6F2fuLZRuz/IGDGjXTfVMk4qG+
 4HgXj4E6eQLc9f6kbw3fMHaBNCXAoA==
X-Proofpoint-ORIG-GUID: Jssy335O7W1jGbqKL7c8D5H5db7xhEEP
X-Proofpoint-GUID: Jssy335O7W1jGbqKL7c8D5H5db7xhEEP
X-Authority-Analysis: v=2.4 cv=SoXJKPO0 c=1 sm=1 tr=0 ts=68a5690f cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=kj9zAlcOel0A:10 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=c7pJEiSHkIStB_RkOCEA:9
 a=CjuIK1q_8ugA:10 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-20_02,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 adultscore=0 lowpriorityscore=0 bulkscore=0
 priorityscore=1501 suspectscore=0 malwarescore=0 phishscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2508110000 definitions=main-2508200013

On Tue, Aug 19, 2025 at 10:47:45PM +0530, Pavan Kondeti wrote:
> On Tue, Aug 19, 2025 at 10:24:36PM +0530, Mukesh Ojha wrote:
> > Currently, remoteproc and non-remoteproc subsystems use different
> > variants of the MDT loader helper API, primarily due to the handling of
> > the metadata context. Remoteproc subsystems retain this context until
> > authentication and reset, while non-remoteproc subsystems (e.g., video,
> > graphics) do not require it.
> > 
> > Unify the metadata loading process for both remoteproc and
> > non-remoteproc subsystems by introducing a dedicated PAS context
> > initialization function.
> > 
> > By introducing qcom_scm_pas_ctx_init(), we can standardize the API usage
> > across subsystems and reduce the number of parameters passed to MDT
> > loader functions, improving code clarity and maintainability.
> > 
> > Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
> > ---
> >  drivers/firmware/qcom/qcom_scm.c       | 26 ++++++++++++++++++++++++++
> >  include/linux/firmware/qcom/qcom_scm.h | 11 +++++++++++
> >  2 files changed, 37 insertions(+)
> > 
> > diff --git a/drivers/firmware/qcom/qcom_scm.c b/drivers/firmware/qcom/qcom_scm.c
> > index 96d5cf40a74c..33187d4f4aef 100644
> > --- a/drivers/firmware/qcom/qcom_scm.c
> > +++ b/drivers/firmware/qcom/qcom_scm.c
> > @@ -558,6 +558,32 @@ static void qcom_scm_set_download_mode(u32 dload_mode)
> >  		dev_err(__scm->dev, "failed to set download mode: %d\n", ret);
> >  }
> >  
> > +void *qcom_scm_pas_ctx_init(struct device *dev, u32 peripheral, phys_addr_t mem_phys,
> > +			    size_t mem_size, bool save_mdt_ctx)
> 
> Since we export this for other drivers/module, consider adding kerneldoc
> comments.
> 

Sure.

> > +{
> > +	struct qcom_scm_pas_ctx *ctx;
> > +
> > +	ctx = devm_kzalloc(dev, sizeof(*ctx), GFP_KERNEL);
> > +	if (!ctx)
> > +		return NULL;
> > +
> > +	ctx->dev = dev;
> > +	ctx->peripheral = peripheral;
> > +	ctx->mem_phys = mem_phys;
> > +	ctx->mem_size = mem_size;
> > +	ctx->save_mdt_ctx = save_mdt_ctx;
> > +	ctx->metadata = NULL;
> 
> This seems unnecessary.

Yes, it is redundant.

> > +
> > +	if (save_mdt_ctx) {
> > +		ctx->metadata = devm_kzalloc(dev, sizeof(*ctx->metadata), GFP_KERNEL);
> > +		if (!ctx->metadata)
> > +			return NULL;
> 
> Do we really need to pass this burden to the caller to pass save_mdt_ctx
> as true/false? What happens if we always keep metadata in qcom_scm_pas_ctx struct
> and let clients use it if needed.
> 

Do not wanted to be aggressive like changing every driver which uses
qcom_mdt_load(), Hence, taken this safe approach of adapting the current
way.

Obviously, it is the one approach where I was looking to unify API's
across remoteproc or non-remoteproc subsystems and that's why I have
put comment in the 2/11 if we feel fine to do it for other drivers too.

> > +	}
> > +
> > +	return ctx;
> > +}
> > +EXPORT_SYMBOL_GPL(qcom_scm_pas_ctx_init);
> 
> Is there an equivalant ctx_destroy() function? It would be confusing for
> drivers to call this in their probe and not doing anything upon error or
> in their bus::remove callbacks. I don't know if we really want to
> convert the whole function under devres or just provide a destroy
> callback.
> 

I dont disagree., will wait for some more comments.

> > +
> >  /**
> >   * qcom_scm_pas_init_image() - Initialize peripheral authentication service
> >   *			       state machine for a given peripheral, using the
> > diff --git a/include/linux/firmware/qcom/qcom_scm.h b/include/linux/firmware/qcom/qcom_scm.h
> > index a55ca771286b..b7eb206561a9 100644
> > --- a/include/linux/firmware/qcom/qcom_scm.h
> > +++ b/include/linux/firmware/qcom/qcom_scm.h
> > @@ -72,6 +72,17 @@ struct qcom_scm_pas_metadata {
> >  	ssize_t size;
> >  };
> >  
> > +struct qcom_scm_pas_ctx {
> > +	struct device *dev;
> > +	u32 peripheral;
> > +	phys_addr_t mem_phys;
> > +	size_t mem_size;
> > +	struct qcom_scm_pas_metadata *metadata;
> > +	bool save_mdt_ctx;
> 
> As mentioned above, can we just include qcom_scm_pas_metadata struct all
> the time?
> 
> Thanks,
> Pavan

-- 
-Mukesh Ojha

