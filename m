Return-Path: <linux-kernel+bounces-763171-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0621CB21153
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 18:15:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BFEE687402
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 16:08:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B06C82DCC08;
	Mon, 11 Aug 2025 16:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Vl3rd4Ji"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 825772D540D
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 16:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754928025; cv=none; b=aSz2ho0hyedIf7dNWaAYohKWcICJn+q7gfjWoMv2YZ1A0bdjrPpRcKXgmgdJrk+AlSuha4kMGMjks+0WH0HbTIdWQ+MbXFAff1q9tfeWDY4uI0j7w9zXKlvoLf8Llj2lrz2T5UqLl1NxImZuh1akOUvgQBLR5zsIv4Kv+wcV0wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754928025; c=relaxed/simple;
	bh=mmFlEJt9VDIvtYkM8ZXAOpn457dJ2h0vRLaBGmfQSE8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m5KvoxTdBzkQafK7c7pfzQywk52wj/BvjLAyAz8dey92B5EjN+6+p+u5yoscg0LmZo97IFbtqwEg0+kxv070Dw8KxCZSlVKTkuS/a86PECxFW9i+c5ktyao96+i+Iu295Q/jl8xO+JSs6tOYAwtQ3VXvsi598Fgc+qiTcD6JiKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Vl3rd4Ji; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57B9dCqF029237
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 16:00:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=Rwpl8NbvWrHTC8U0UpOFWNBP
	WQ/11HBCPomPthDpd0U=; b=Vl3rd4JiMuVNbQ1GuulTX8kB2lUtpeTiv5qI2FUf
	jpzDPc8A+welBs+nhxeakBbne3ZpE87aHWK2n9EvCX4rO5zSJoYzk8SqKz1knjUs
	Xd3bY2UWutKjCyGEabYqofEeLaS1nkYw2ZrIzkAY2ljwuJKUSe+ZS1z8NU+iC6IB
	2ldDWGhuoduTe6oVmoKFVNnZ4gybZ0tu+JnTPprfPnNvz9EJs/54bT19JGy2iaDM
	7Nvt+/PSoTUXvMp2ZoVluirO9pPS/j/E7SvY38Tqxa/PMRUYXLqY1LW0H09m2p7J
	5FMo9aQd5ualSPwpj8RkBsC0FY2+OOxiMuKRWLh/5EDj4g==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48dygmcyhb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 16:00:22 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-b4310451ae4so5711999a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 09:00:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754928021; x=1755532821;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Rwpl8NbvWrHTC8U0UpOFWNBPWQ/11HBCPomPthDpd0U=;
        b=DZ/XmvimwUeArYkllfwSZw4oIySD1KeAsfpb5qNWd6jl24ELTVsyaFgPteUi4BBfUU
         2PnxggwQ/Mw2NGySJTMa3/pm0RvMmvBJaCb1nT4VNR8VyBRxgB28og4ZlgO6ekWNoABC
         XGBntKtdPVPDrCcZjMsGjAQqGYYPG4/AK0jGJbGF7exaWmqmux9qJ1l+Vj/M9WoFSPDz
         KY2yZl0WsKEIYGk9hYuA/IJ50TZGtRYsbGok5lcdYYPR54PEh9esL9PimpgTf61qmIqD
         MtM7Rzwf11d5FR082zW350jdFyTteP6rCxnotWONVIGS9hYLwLhQFY4hEt32msRprmHD
         2QLg==
X-Forwarded-Encrypted: i=1; AJvYcCX88ME8xODlUiL2cvxQ54i2jbVTRRNuabOnPP9f2iltwLwTIfA3Sug+U9wAiUvyn4AldAh8ecgxNjo6Kqc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUlXiXERh1sJ3bIt78v7FhYNrDUw8aj0/5ixpVeoxsxZzes2ZV
	Tma25UyQ8YV77Rp5rGo6ljC3XW0m4TYuorG0q7Lk+HS1d+wdPtpGrevsysK1YIAnTsqIZ1QW90l
	QI6rPnGX99d/pK+Jg2DURRDuoJbfqXIg1lckS2OgOyByMe+J4CmRI+OrOlHmG8mqliAA=
X-Gm-Gg: ASbGnctOpperbUQz8CjpeVzybNqLHJjSQYc7KlcXgNold+6Bopw2rxgAQVb6VbCtAz/
	DPU6oAlfqR4aRXjni56bqLKY+OKYHetodKpYmk0508t5Vs2LqahWyeRlakilXV2Oz1mSVa/EiZi
	eUeG8a/xgpY0umd4n50iTApIezXTYMV6c7M8B21BSj6suY/pF5ETfz9VvifM6dMOcyn5m2ZB1Qd
	/PGssyRGoIAvGXhxH21vvS1dPQC3TiqkMkR+svKywd5PzyRrhvTRPiGlrqd9Y32v7VY2RYd1xge
	7YZi3sLeMoGNDNWZEKNIvsX8N+d28a6vRPAc0iigU1HS4Tii8UsCW6qVSS0/7lCdpLk=
X-Received: by 2002:a05:6a20:7287:b0:23f:f99d:462b with SMTP id adf61e73a8af0-240551e874emr20671275637.41.1754928021234;
        Mon, 11 Aug 2025 09:00:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHGAtyjbitWbIUi5XpTAPbyaZ3A4sWY7sxO1y6tLsTdKONGIygeMTfR0M2u79UtjmF8pMWXwQ==
X-Received: by 2002:a05:6a20:7287:b0:23f:f99d:462b with SMTP id adf61e73a8af0-240551e874emr20671159637.41.1754928020419;
        Mon, 11 Aug 2025 09:00:20 -0700 (PDT)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76c672dc678sm5739477b3a.75.2025.08.11.09.00.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 09:00:20 -0700 (PDT)
Date: Mon, 11 Aug 2025 21:30:15 +0530
From: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] remoteproc: qcom: Update MAX_NUM_OF_SS to 30
Message-ID: <20250811160015.wmlcmln3sxje3vjh@hu-mojha-hyd.qualcomm.com>
Mail-Followup-To: Bjorn Andersson <andersson@kernel.org>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
	linux-kernel@vger.kernel.org
References: <20250808164417.4105659-1-mukesh.ojha@oss.qualcomm.com>
 <obqkobpnuccfsqvytoltspw5wh27zyhyankt6dju2u32y73odj@3gzhuicheqd7>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <obqkobpnuccfsqvytoltspw5wh27zyhyankt6dju2u32y73odj@3gzhuicheqd7>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA5MDAzNSBTYWx0ZWRfXwr+JI1ybQn0W
 QwXn2V2NSkMDm0yn18ffG3ttSzX1QXyRE7gnAviog6kcT1cFJwbnq2hRyE7M3HlDS74qNGknFGj
 KaG1+YpAugM+F/oxFJcvIh6C6rMfYPYfmS06hJfyQDEEN4vTsaZ4cR9yQjLZMJxO7OPUAxBs9lK
 8kW7AJWO8QcOrOGY/desdpmR9uoxboDK7497gGoQ5dZeK0dUzyWRKmKjSaIoLlBxOXgCVic9Zt5
 0GeivxOzWvZF1mZ3t20Gc6NKSZh1GRo+mXdKcCnDPJ6mly4WQQKgmws7nWKKUPb3/6iucXOa1El
 kB3pjorBhKcmxhaC2AI+yT3U/i7VaoypK3FU0YmfGGC4NUu5NknQPO6pMWnBj2XwcJTBEp+GOPY
 HjRpF2tG
X-Authority-Analysis: v=2.4 cv=FvMF/3rq c=1 sm=1 tr=0 ts=689a1396 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=kj9zAlcOel0A:10 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=uX29DGtN9997D0eWwb8A:9
 a=CjuIK1q_8ugA:10 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-GUID: Wfj0leh314PBE6dNn4Hec6h4pDF1pUei
X-Proofpoint-ORIG-GUID: Wfj0leh314PBE6dNn4Hec6h4pDF1pUei
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-11_03,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 bulkscore=0 suspectscore=0 phishscore=0
 clxscore=1015 impostorscore=0 spamscore=0 adultscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508090035

On Mon, Aug 11, 2025 at 09:49:08AM -0500, Bjorn Andersson wrote:
> On Fri, Aug 08, 2025 at 10:14:17PM +0530, Mukesh Ojha wrote:
> > In the latest firmware for Qualcomm SoCs, the value of MAX_NUM_OF_SS has
> > been increased to 30 to accumulate more subsystems.
> > 
> > Let's update so that we should not get array out of bound error when we
> > test minidump on these SoCs.
> > 
> 
> But this number is used to size the minidump_global_toc struct, which is
> used to describe the content of the smem item - and this item didn't
> grow on old platforms.
> 
> Doesn't this imply that on older platforms you've now told Linux (and
> your debugger) that it's fine to write beyond the smem item?
> 
> 
> It seems to me that it would be appropriate to check the returned size
> of the qcom_smem_get() call - in particular if the size of the item
> isn't fixed.

Yes, you are right., do you think it should a fix (cc stable) ?

-Mukesh
> 
> Regards,
> Bjorn
> 
> > Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
> > ---
> >  drivers/remoteproc/qcom_common.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/remoteproc/qcom_common.c b/drivers/remoteproc/qcom_common.c
> > index 8c8688f99f0a..dbe3bf852585 100644
> > --- a/drivers/remoteproc/qcom_common.c
> > +++ b/drivers/remoteproc/qcom_common.c
> > @@ -28,7 +28,7 @@
> >  #define to_ssr_subdev(d) container_of(d, struct qcom_rproc_ssr, subdev)
> >  #define to_pdm_subdev(d) container_of(d, struct qcom_rproc_pdm, subdev)
> >  
> > -#define MAX_NUM_OF_SS           10
> > +#define MAX_NUM_OF_SS           30
> >  #define MAX_REGION_NAME_LENGTH  16
> >  #define SBL_MINIDUMP_SMEM_ID	602
> >  #define MINIDUMP_REGION_VALID		('V' << 24 | 'A' << 16 | 'L' << 8 | 'I' << 0)
> > -- 
> > 2.50.1
> > 

-- 
-Mukesh Ojha

