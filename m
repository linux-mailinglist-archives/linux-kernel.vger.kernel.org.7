Return-Path: <linux-kernel+bounces-899485-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21E5FC57F31
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 15:30:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D152F3AE52A
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 14:18:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76479284884;
	Thu, 13 Nov 2025 14:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="fsyT2DR9";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="fHFYuCyT"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0867E2727E3
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 14:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763043518; cv=none; b=T+VrqL8lIQI7wTgfIC4PA2RP3GYAs/rnyAJj6IwOYPbdqC1/m5I/Zp4VvlmXNOrszSaZwI4CeX4UZcgNJk1HdXRsH5T2leI4m7oTJyi53+QeyPqJzcopOyhw3I8++WKyfrHpNN+/G3HlqhMyIdVm107OpUOd8Q2o51I925dmWZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763043518; c=relaxed/simple;
	bh=YPiMjVGtnmzVmhP2MBtXj02fTkYPYr7pqgd1RZjfN3Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YBYkjMtqgysLByZCrq0MCwoUAvkynFekgttSbsZfrCtS6TOLy5nVFJg10YS8Mp5ONhCFz8d5Mbjf6WljDRz24kNnQwxqjd9ZRBnrZb5ovwSgPbM56V2SKactaAr5wfhoOcZR1oI+m6MT8e31I2/6pjbbYywrqfQcld5SR/TQjHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fsyT2DR9; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=fHFYuCyT; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AD8v3Dh2993478
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 14:18:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=PYfAGt7xLkn4IooIS/dHIQut
	IGT7n93ycU/0f7jdrwk=; b=fsyT2DR9Z6EGpz7UZwYGX+c/PHOi6PG2tCSSe10e
	j0QKJHQtqWK5K2o+m5nj2y2v4wYkYHoLmMo5PJGWt6cX8cMxwQq1em76Pw7v9er+
	J68o4gDGAOCcXxa/3ODHDXci1zLYFJC2mGYOFJvR46qPpeAuoYU3G1MpRpM9cnZR
	oRGwhI3J9WINQuuVJbx7SxT6Q6Jz/gV3/pMpVocFX55Vng9Npno7AJVjplk/jfyU
	Uj8aisMlrZWXj6+IeSWDq8kAyaJObuWWDNjp8kWG4ArlB6erAduP8b2MSGJPqjM7
	Zj80xLF9gpbpVReuCCvxNqGeyn9WBaZm7Q2v4B5Aj4tg2g==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ad47jjgx3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 14:18:35 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-29809acd049so11505965ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 06:18:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1763043515; x=1763648315; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PYfAGt7xLkn4IooIS/dHIQutIGT7n93ycU/0f7jdrwk=;
        b=fHFYuCyTCxRP2paq5NpShMNdHpNYheqXhDwMSRMhaWcJSlTpY+pLLriU0YS353wbXQ
         ooK0L+hdUHfwUXrFJ7UOpijvLzqPNZG1zUzQ6EGTVNa7Z445q5XFhW8fT1eLtuyGrj0I
         471ulT7lATNStZrV2aziqFl/eJIYNSlZ3nf+8y0Dci3VM5RU6n4zPhXQa1v30FzOk88K
         PvSjoDTLjotSWTLsl0VKdLosOCqJ/cUop8ddJ37lq3HlyRDttX76yawqICE4taoXhe1w
         ErcPIVfEAn6Tl6wQg0rv+fFeB5n8Pd/Lk5Vtu9wjQCbPJpvSne8z5XV3Y0EgqkTOU0+g
         Yb3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763043515; x=1763648315;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PYfAGt7xLkn4IooIS/dHIQutIGT7n93ycU/0f7jdrwk=;
        b=DDLslogNz53OQN8zTzWkjIzmJ6w7CsfYprbs7aPulj0rpCj9zRuT5fzeQ5hSyVzL6O
         gD3DnPeayuSuljzyO90NyJCNnPePlGAneDyZkMiHB8vyC2aialfho/yK9WUP88iS5GMb
         XGloLxQF3EPgBn9yUHRoElw/phZynZt2NHjzVpXDnbfxQDscQmocmhXIvE9q8nlP3asW
         AYSETbDnCEUKnSjAPdIqPyMMLaq2iytoiQzZ3vdWcQMv4tXGKdwSx6tbPt2p8qhpMAG9
         6ay6pqFqrBW9NdnwLXf7RC2Eu8dWA5HPIW4lC+YvhdByJ6O4RImroZWOjRujG2un7p/M
         9g8Q==
X-Forwarded-Encrypted: i=1; AJvYcCUbJ/NcpmGCtS1l/jRhVE3RwZbwQ0zk5dZUQFtLbPwRZT4IH/zPOibRKIby50wi4QyFiGZfDnfg5NkU0Vg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIRCGYHs1B8XU6g5tm1/tuL9lw+LvoRZO8TZqZOhQgL9h0/eba
	uFX/WsA8WUV2gYbmf9iZMVjPoF/r0qG6sntolP2msHq5BC1fGM3mQNGDctgawQHYZGz8mjhfSBu
	XJvkyKhf5LaOaEuS3Er4zkPfg2ihwI3yLCIFDQ+XIb3zIryp5pJEOke2UY85wUJkcUGw=
X-Gm-Gg: ASbGncseXfn4ZtGqbPWd/1PelkMWIsHJDbFmIieBz1/LlUzRTL4GjmjugrDJJFRMw/W
	bpqDhFOuX5l9Yc7C4PGZDBt9ylfyh7x7X5UcF1uJoCGQN9tk1v+d65pJoUdGDCcKjLeqoku24E/
	S+buxxHo824Y/4RrU3mByBMJTq84pANS13a8L6HSG8H85N2fensQ90ZbdU3/tTiyuEbaCHW2H1M
	x//qjta0VGzAvIY03E0hlrYPOvSOR1sRnXaUjZXfJ5PIKJroMK9kKFBEqovbXC7YMC7NqRaWXdY
	ZFwdSuR8WBqyyJSyHPtR8A1wcrMDnaq9yWjxMyss4n/K4jP9p3qryfE3DAFHp7Jgtgh5FUe8WZ7
	334DnvWvefGxYohlAlv1At8dqMA==
X-Received: by 2002:a17:903:1c7:b0:267:f7bc:673c with SMTP id d9443c01a7336-2984edccae7mr85923145ad.44.1763043514533;
        Thu, 13 Nov 2025 06:18:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGJyQhQCidxyHZGx2ofEawlrPhEHp8JTQarlTsdV8cD9Z81y5uxOIWAhSZjP2GH3r0u2/kFpQ==
X-Received: by 2002:a17:903:1c7:b0:267:f7bc:673c with SMTP id d9443c01a7336-2984edccae7mr85922725ad.44.1763043513787;
        Thu, 13 Nov 2025 06:18:33 -0800 (PST)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2985c245f74sm27334445ad.39.2025.11.13.06.18.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Nov 2025 06:18:33 -0800 (PST)
Date: Thu, 13 Nov 2025 19:48:26 +0530
From: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
To: Stephan Gerhold <stephan.gerhold@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 04/14] firmware: qcom_scm: Introduce PAS context
 initialization helper function
Message-ID: <20251113141826.qvjz4ozlnvx3ucw6@hu-mojha-hyd.qualcomm.com>
References: <20251113-kvm-rproc-v7-v7-0-df4910b7c20a@oss.qualcomm.com>
 <20251113-kvm-rproc-v7-v7-4-df4910b7c20a@oss.qualcomm.com>
 <aRXHlL49sSGML__G@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aRXHlL49sSGML__G@linaro.org>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEzMDEwOSBTYWx0ZWRfX7umwMi+zJCy/
 wMiFxx0Kmeo/HJeRX/TR+ZiFoVQ/X+6xHx/rpP49GuawK6J6xkgu51kI5rataO/z9MifAQrlY9q
 3Yo/w2YfwUK0Yzrn1FGA43bcKOOWeLRmaH2bhs0ZP9rF74eODaRxXpqGaaB+7zt2h7k0k4aqg+Z
 JHtAHE0bViif//vj914LL1FI0OhJzJf40QfnIkFUp80cpt2O0y5JVtw5Qq7SWHk1u1oaElAIYR9
 aQtei+Tb21GjQ4D83+DitojPJ5Lq4DCZH6M/l8+Bi446Km2WhG66uh96mLt6WCHp7uKpae1n7SM
 Xkx9+W3bvBaEz7F3b7v8NbcMHB1dtoODCWEdf4DKVKHoJTiE++khnrEOUVJcBJvTLszPGftajcI
 AjcfOWrgmOYsf4n6SAUESxrvD01lig==
X-Proofpoint-GUID: HR-if21hE_LMNDXnLkAjnG9AD_OeU3Yv
X-Authority-Analysis: v=2.4 cv=A5Fh/qWG c=1 sm=1 tr=0 ts=6915e8bb cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=kj9zAlcOel0A:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=uguQWuAc9R0SQO7IgggA:9
 a=CjuIK1q_8ugA:10 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-ORIG-GUID: HR-if21hE_LMNDXnLkAjnG9AD_OeU3Yv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-13_02,2025-11-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 clxscore=1015 spamscore=0 phishscore=0
 adultscore=0 impostorscore=0 lowpriorityscore=0 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511130109

On Thu, Nov 13, 2025 at 12:57:08PM +0100, Stephan Gerhold wrote:
> On Thu, Nov 13, 2025 at 04:05:54PM +0530, Mukesh Ojha wrote:
> > When the Peripheral Authentication Service (PAS) method runs on a SoC
> > where Linux operates at EL2 (i.e., without the Gunyah hypervisor), the
> > reset sequences are handled by TrustZone. In such cases, Linux must
> > perform additional steps before invoking PAS SMC calls, such as creating
> > a SHM bridge. Therefore, PAS SMC calls require awareness and handling of
> > these additional steps when Linux runs at EL2.
> > 
> > To support this, there is a need for a data structure that can be
> > initialized prior to invoking any SMC or MDT functions. This structure
> > allows those functions to determine whether they are operating in the
> > presence or absence of the Gunyah hypervisor and behave accordingly.
> > 
> > Currently, remoteproc and non-remoteproc subsystems use different
> > variants of the MDT loader helper API, primarily due to differences in
> > metadata context handling. Remoteproc subsystems retain the metadata
> > context until authentication and reset are completed, while
> > non-remoteproc subsystems (e.g., video, graphics, IPA, etc.) do not
> > retain the metadata context and can free it within the
> > qcom_scm_pas_init() call by passing a NULL context parameter and due to
> > these differences, it is not possible to extend metadata context
> > handling to support remoteproc and non remoteproc subsystem use PAS
> > operations, when Linux operates at EL2.
> > 
> > Add PAS context data structure and initialization helper function.
> > 
> > Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
> > ---
> >  drivers/firmware/qcom/qcom_scm.c       | 32 ++++++++++++++++++++++++++++++++
> >  include/linux/firmware/qcom/qcom_scm.h | 12 ++++++++++++
> >  2 files changed, 44 insertions(+)
> > 
> > diff --git a/drivers/firmware/qcom/qcom_scm.c b/drivers/firmware/qcom/qcom_scm.c
> > index 0a0c48fca7cf..e4eb7f3ab7a5 100644
> > --- a/drivers/firmware/qcom/qcom_scm.c
> > +++ b/drivers/firmware/qcom/qcom_scm.c
> > @@ -558,6 +558,38 @@ static void qcom_scm_set_download_mode(u32 dload_mode)
> >  		dev_err(__scm->dev, "failed to set download mode: %d\n", ret);
> >  }
> >  
> > +/**
> > + * devm_qcom_scm_pas_context_init() - Initialize peripheral authentication service
> > + *				      context for a given peripheral
> > + *
> > + * PAS context is device-resource managed, so the caller does not need
> > + * to worry about freeing the context memory.
> > + *
> > + * @dev:	  PAS firmware device
> > + * @pas_id:	  peripheral authentication service id
> > + * @mem_phys:	  Subsystem reserve memory start address
> > + * @mem_size:	  Subsystem reserve memory size
> > + *
> > + * Upon successful, returns the PAS context or ERR_PTR() of the error otherwise.
> > + */
> > +void *devm_qcom_scm_pas_context_init(struct device *dev, u32 pas_id, phys_addr_t mem_phys,
> 
> Why does this return void* rather than struct qcom_scm_pas_context *?

I kept it similar to align with other devm_* api, however, I can change it to
struct qcom_scm_pas_context if it looks more reasonable.

> 
> > +				     size_t mem_size)
> > +{
> > +	struct qcom_scm_pas_context *ctx;
> > +
> > +	ctx = devm_kzalloc(dev, sizeof(*ctx), GFP_KERNEL);
> > +	if (!ctx)
> > +		return ERR_PTR(-ENOMEM);
> > +
> > +	ctx->dev = dev;
> > +	ctx->pas_id = pas_id;
> > +	ctx->mem_phys = mem_phys;
> > +	ctx->mem_size = mem_size;
> > +
> > +	return ctx;
> > +}
> > +EXPORT_SYMBOL_GPL(devm_qcom_scm_pas_context_init);
> 
> Thanks,
> Stephan

-- 
-Mukesh Ojha

