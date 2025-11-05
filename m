Return-Path: <linux-kernel+bounces-885866-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C7CA0C34136
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 07:44:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0164F4F115B
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 06:43:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9C882C11CC;
	Wed,  5 Nov 2025 06:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="bOYb6YRI";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="jptRB8De"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 462AE2C027B
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 06:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762324983; cv=none; b=IsMn7k1ox93U8pZ3az2aOV6/KL85GkwzFpkJM9cKESQ2jyJEGq6BlXCN/6Sprz4lnInNIDPzRHkhwzJHhPQSvvZmFNnsdJTaTvBLkNxCgY0MsQUIuV3xmkLUO6HhE3gL6AgarYaRqUJEiXA0nbxUNJD0jjDUuGNQDvCOBqM5Vwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762324983; c=relaxed/simple;
	bh=UZ8lKWzIInTuNEvQSGulSIDHuHRj0ZFxre0FKSLVoos=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WfeikZgHk7GCLKznPxKyA+4njgmUIFTKprarEmjQhtT/zDdTFZNfYICdrKcPiWxGpSwbKHgfMfh1pFX4+Rm/yyBJXnOkx3Amy6qJCqp7adraV3Ur2BKVAA5aygkG/dd9xXmpP6u/aK5whEXIG9iOsYwI6PScTkICrqCV2vvRURg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bOYb6YRI; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=jptRB8De; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A53s9013913777
	for <linux-kernel@vger.kernel.org>; Wed, 5 Nov 2025 06:43:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=nq89DQUCXDu/1+0vbCTDrhxB
	9KHzFo3yWxIPRMSmuSE=; b=bOYb6YRIlaKl+sYH1DhFv4rrQoTtcNpvvik7wMMu
	FYdZFWIGpPbc4NuOhOkyDwr7MlxjXIONlMYhT4Lbu/53MsGD474PGd6vAaSBPHsE
	bTQCTVua321zkxQBchS9cvdfKolU6jehRhv2LrnGy34pMV/f8ycqAInHwUXtFRrz
	16oW96ipXENInuz/75T6jE701BuskBKqxLUIWAgWwiwm0ArakGAuMYtDnsm4LbTA
	Q/CywheHFNhvMZMaxKyANQaR80z0RL4n/FKalYZ0GGaloLr3B/U3nRpyXoHyYVUu
	zqcfjQCgSNzk495bN0vioU42YO3MWvcSVsofDMA9mqGHPQ==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a7y378bju-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 06:43:00 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-b6ceeea4addso6427518a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 22:43:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762324979; x=1762929779; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nq89DQUCXDu/1+0vbCTDrhxB9KHzFo3yWxIPRMSmuSE=;
        b=jptRB8De7cmYligLs3X6mIsCGLw4ZbTCoS93Hcr2+7St+fQABqmlD0lLWRrn35Iq8+
         LULeL0Cs8E5gIpG430Y38ThzIQikKikRVVfPRK5FszIKrIqjKUL0ahjnfKkrFLGvFs7r
         8sVH46BJXu8mHbEXPz/FgAn7HQnEZ8/LyElkaj2UKo7RcsYy1D6ZqLShxsXoO3b7zTWk
         t8IDnWlYlx9OETHGHhllClyrs9jTIt5fmIL8aD/KdqbxCYMKz3+hjKLv6wcT8UvpFV97
         Dvk5yzW7e6KE07na/TGkWnx11gt9NxWP5H3YGitgMyO2kwwCYtfG6lYc77rq0H90fd8Y
         w5+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762324979; x=1762929779;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nq89DQUCXDu/1+0vbCTDrhxB9KHzFo3yWxIPRMSmuSE=;
        b=XXsXUF4K8YdCN8ar8sPPHp2AhTgwqYhi9poYLqDxkSuKA0SiY29rsQyerEhUheGJQU
         k8BDQJO3UxBauqjRyi3O3yBD80jxorHswRA4wHITZRWGBgpLSBHY46Uo3AIHWAW9p0VE
         G51T0ZC0C10bFUTqqa4SCQvD2hWjD77bsuHTmt9f8Nl2uBZVbAhfcJ10wjvQ9B9n30x4
         lsUxacnRJCN1Oip1ANE4CP7OCyTdcKYHNnmRAoY2aVTAMukmkNhZL32S1CdQycMIELnX
         JjJy3YRcg1Mxfcob541AkIdhx8ejsjWEP2p9UxxcnSwW0vAP6C4C/IpqeBiZq0SaKXoX
         x1xw==
X-Forwarded-Encrypted: i=1; AJvYcCXvTIKdlB1WVBx68GSHv6B/yJqXC6Ayd814FfLLQvjFlI315OhuTNHiWSVWUs76/Jgh5NS7to2c7ye0RP4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxoQNCalh9P0Ib9ukbnledvUcn4yeLqjhZ2kCZhPzLYYsQwB11E
	KNYRsnBNXnPH9lCJQGrb7G2+trsLsqg6eeysQ1vovlGXv4J05Xt3La7zICzBIABFz/tQ+Q1biPh
	URyDKWEAzOzxwcdz2UpuAbYjQkSDXmusLKKfPb0R9A2xfANwB+9Y1txNzickif9eckkU=
X-Gm-Gg: ASbGncshAVPnMSAGfQn6vwbZ/W2LlS5MuhVRZw+0P8LGDKm7KtaxnuEIFcJL7dljok4
	YjlkRNQ5/IZwDRKcPi5w1nB4bJJqUyjvB0Tiezh88wtqJ17FlYDhjFd4l2buimzJhnohmo+I+Zi
	UsRQl0JgOEOLkk0jodRcANB0/5rCkwSIsfnFt6xQ+Mp8Gz1CF3FeBSE/DiFTIWP9VNA+Huu/JRV
	Ld7zG+eTSbkBz2Th1USLVqUy7OPLQjgLn0ajMFJvevYMhsMzWrSLwYZFFQvGrHR/QSLNGaynPTU
	ypVL9uaZKYUicHb2F3nOhnFbmkH5zFJJsuwZXWezpOnLYMfmCKlvFgcgaAazqpr5o/CR13XLHki
	ryfDSzomowYxklIbwmXDJz5glKg==
X-Received: by 2002:a05:6a20:4313:b0:341:2fea:6b5 with SMTP id adf61e73a8af0-34f83b1c031mr2987578637.20.1762324979218;
        Tue, 04 Nov 2025 22:42:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGoQyYyFGTve5SA+Qgr5cO14BdLR7ffiUWGwJzX7Tsya0oH95BQSrMh+zSTJlO2QCSGsxsnRw==
X-Received: by 2002:a05:6a20:4313:b0:341:2fea:6b5 with SMTP id adf61e73a8af0-34f83b1c031mr2987525637.20.1762324978520;
        Tue, 04 Nov 2025 22:42:58 -0800 (PST)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ba1f98fb670sm4377296a12.38.2025.11.04.22.42.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 22:42:58 -0800 (PST)
Date: Wed, 5 Nov 2025 12:12:52 +0530
From: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 05/14] remoteproc: pas: Replace metadata context with
 PAS context structure
Message-ID: <20251105064252.qxqkno4xqwfrhmlf@hu-mojha-hyd.qualcomm.com>
References: <20251104-kvm_rproc_v6-v6-0-7017b0adc24e@oss.qualcomm.com>
 <20251104-kvm_rproc_v6-v6-5-7017b0adc24e@oss.qualcomm.com>
 <fc8beead-566d-463b-aebe-407429adf156@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fc8beead-566d-463b-aebe-407429adf156@oss.qualcomm.com>
X-Proofpoint-GUID: z8PJqKVEF25RgAh9j43mgf-0-U4qZK2y
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA1MDA0NyBTYWx0ZWRfXwO3bE5VLnER6
 iACYzuTK9ST5Dj46FMchMBE7V4g0l/GORElNJiKz+yjE0YDj5UTlBt53ucKgjrC/dC5jm20PWrx
 KCUYREBHTHxGJravJF2feMph9iVhsmTaHqCNqdyPcIecgdgwf7VE+atvWdpOO+iO/55ldRgPHVN
 TS1oZ5E8YEV3AmvnWV4i5rmc5A0opYSZxldoNrUXBIHyRJ/4ylx3f5aIPEZ7Yy1wd6C7Lni61zy
 9j3A0iLHmuilgpTIy6Y2pSCwV/D5+1Snh3gaTzQNDbZdHGBVNRC+pTydPDaGt3fwIwvyfXcRe75
 svSA6k68zyP/1SS41a55+vV+Dr3UQSgjoHzTh6ljXvtG9DFAhlDaZl5wwiHH4r15+79KrV+aVuk
 whuY9Bl399ssPL9Shfa8fPu72CF+4w==
X-Proofpoint-ORIG-GUID: z8PJqKVEF25RgAh9j43mgf-0-U4qZK2y
X-Authority-Analysis: v=2.4 cv=Ev3fbCcA c=1 sm=1 tr=0 ts=690af1f4 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=kj9zAlcOel0A:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=gAF1yXKuUJ3Ueu62ksEA:9
 a=CjuIK1q_8ugA:10 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-05_03,2025-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 priorityscore=1501 bulkscore=0 suspectscore=0
 adultscore=0 malwarescore=0 lowpriorityscore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511050047

On Tue, Nov 04, 2025 at 06:33:49PM +0100, Konrad Dybcio wrote:
> On 11/4/25 8:35 AM, Mukesh Ojha wrote:
> > As a superset of the existing metadata context, the PAS context
> > structure enables both remoteproc and non-remoteproc subsystems to
> > better support scenarios where the SoC runs with or without the Gunyah
> > hypervisor. To reflect this, relevant SCM and metadata functions are
> > updated to incorporate PAS context awareness.
> > 
> > Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
> > ---
> >  drivers/firmware/qcom/qcom_scm.c       | 25 +++++++++++++---------
> >  drivers/remoteproc/qcom_q6v5_pas.c     | 38 ++++++++++++++++++++++++----------
> >  drivers/soc/qcom/mdt_loader.c          |  4 ++--
> >  include/linux/firmware/qcom/qcom_scm.h |  4 ++--
> >  include/linux/soc/qcom/mdt_loader.h    |  6 +++---
> >  5 files changed, 49 insertions(+), 28 deletions(-)
> > 
> > diff --git a/drivers/firmware/qcom/qcom_scm.c b/drivers/firmware/qcom/qcom_scm.c
> > index 5a525dbd0a2e..9cdd152da592 100644
> > --- a/drivers/firmware/qcom/qcom_scm.c
> > +++ b/drivers/firmware/qcom/qcom_scm.c
> > @@ -603,7 +603,7 @@ EXPORT_SYMBOL_GPL(devm_qcom_scm_pas_context_init);
> >   *		and optional blob of data used for authenticating the metadata
> >   *		and the rest of the firmware
> >   * @size:	size of the metadata
> > - * @ctx:	optional metadata context
> > + * @ctx:	optional pas context
> >   *
> >   * Return: 0 on success.
> >   *
> > @@ -612,8 +612,9 @@ EXPORT_SYMBOL_GPL(devm_qcom_scm_pas_context_init);
> >   * qcom_scm_pas_metadata_release() by the caller.
> >   */
> >  int qcom_scm_pas_init_image(u32 pas_id, const void *metadata, size_t size,
> > -			    struct qcom_scm_pas_metadata *ctx)
> > +			    struct qcom_scm_pas_context *ctx)
> >  {
> > +	struct qcom_scm_pas_metadata *mdt_ctx;
> 
> This is never initialized
> 
> >  	dma_addr_t mdata_phys;
> >  	void *mdata_buf;
> >  	int ret;
> > @@ -665,9 +666,10 @@ int qcom_scm_pas_init_image(u32 pas_id, const void *metadata, size_t size,
> >  	if (ret < 0 || !ctx) {
> >  		dma_free_coherent(__scm->dev, size, mdata_buf, mdata_phys);
> >  	} else if (ctx) {
> > -		ctx->ptr = mdata_buf;
> > -		ctx->phys = mdata_phys;
> > -		ctx->size = size;
> > +		mdt_ctx = ctx->metadata;
> > +		mdt_ctx->ptr = mdata_buf;
> > +		mdt_ctx->phys = mdata_phys;
> > +		mdt_ctx->size = size;
> 
> So this will always cause stack corruption
> 
> >  	}
> >  
> >  	return ret ? : res.result[0];
> > @@ -676,16 +678,19 @@ EXPORT_SYMBOL_GPL(qcom_scm_pas_init_image);
> >  
> >  /**
> >   * qcom_scm_pas_metadata_release() - release metadata context
> > - * @ctx:	metadata context
> > + * @ctx:	pas context
> >   */
> > -void qcom_scm_pas_metadata_release(struct qcom_scm_pas_metadata *ctx)
> > +void qcom_scm_pas_metadata_release(struct qcom_scm_pas_context *ctx)
> >  {
> > -	if (!ctx->ptr)
> > +	struct qcom_scm_pas_metadata *mdt_ctx;
> 
> Is the existence of this struct any useful after you introduced
> pas_context?

Yes, it is still useful, mdt_ctx is only relevant for remoteproc based
subsystem like adsp, cdsp, modem while they are not required for video,
ipa, gpu etc. but the superset which is pas_context is needed by
whosoever need to support secure PAS method Linux at EL2.

> 
> Konrad

-- 
-Mukesh Ojha

