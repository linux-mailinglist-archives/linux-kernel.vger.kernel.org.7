Return-Path: <linux-kernel+bounces-845901-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F3F3BC6720
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 21:15:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 408F74041E5
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 19:15:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEA781799F;
	Wed,  8 Oct 2025 19:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GlxKPARb"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAD331E50E
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 19:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759950924; cv=none; b=NwQR27Z+xTlosvV9BCxAvI7pF4yLpEShld+1C7Oa4NzxhsZJNyVXPlGZj69TYB21FOG1pCI7GWMgebaB2/hHNylAFRiWhK5tkIlhbT87AutpacN5vV/jCLyHGBN/E+tPDY8YViXihe6onS4AxGypofzZTcIt1Z6XDeiqqefWFug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759950924; c=relaxed/simple;
	bh=hyslDlshQM6LDluVpR6VxhY8TVKC1YHa3wlo89Z5Vrc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tdc2Vn9hEJon8xADdD+ppyFtGT/OK4Oab0r47WWr5rvW63zQ+1rwmMuyQL/kRAWeJSLemiNcY3P+zAeQhJkzV2l8kbkK2Q2+O/v+Sg5oemBTyIWW9frlkEZV3NS5dDMbwM6zSF07TO6/Nu5mpuQDF8+eKjgxerTRrXaFfBqSnaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GlxKPARb; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 598I5G0u027606
	for <linux-kernel@vger.kernel.org>; Wed, 8 Oct 2025 19:15:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=rClisPK/TxSFKRv6Q0Cr14NR
	DtDvjkB0ari9poTtf4Y=; b=GlxKPARb3V0hqEX43/6dhucPy/J1pg+m0mq1lMrT
	2VIHUhUqwNaW/dCXlaNtKhxK2ylNmm4i+/hHcaixnhEFF3MFmmjnZSRlt8iCvb3Y
	BUUF8eoa2d5fmi5v3SRiJ/l1rTI629uV4I9cCwxVzh5ltLV7pmlYj5xTlnOOGySU
	Nj4iGWOr3Dg/dxLhTYhEY8MXywGgT/6LiCiFFd42oQy2XRhOFo/++iJpdcIoRCNs
	zMtXWMFC/ESUrDz3s0vZ8WQdIk65xY65ssCWWHi5Qb9Px1yOXCmxUWuUYYScT/FX
	konUeWFoR9ryzrcRqg0iBd4Lz/sFy5AFRZ9o64BiRBkYGQ==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49nv4nrbms-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 19:15:21 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4de53348322so8691761cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 12:15:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759950920; x=1760555720;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rClisPK/TxSFKRv6Q0Cr14NRDtDvjkB0ari9poTtf4Y=;
        b=b2RgPf5dNRDYtOEPXz6CLc4HhBjNSa4r/9ipa/2qIPhmjt8RuBBPG8U6G+L8C1nIji
         r9H23CZAM9H//NH4YBsCiCZg3F7gITPsb/J2xH4z3xsM8+mjeRC6EQgYfcGT1ccfwllN
         H7VKQhZBfhscGV/Ga9mZ1+9oHYFfzdDnLTT+81NkWhKXNS4ZrijEbI5HjEz4qyCc+cjc
         mKy7TSlv4SX17UMf7QSmyP0Q3c8RbiZYAM7IbBxGRfVTLk0LYUEeK1/luov8UNMwZJ3L
         vem8R7US5+mYIqWFmVFIRSoyUOUMb7tp+RvPJH4+3FrVZidhCi0nV2eahlfG/I8jeaJs
         safw==
X-Forwarded-Encrypted: i=1; AJvYcCWWI/MHapkOKhFsbt1OUmiWa4ZWE4OiXadgfvCVr/HYUsEFC8QaxwLCmBYPQ4hKTrP3O/Nr2T86EDVRcAE=@vger.kernel.org
X-Gm-Message-State: AOJu0YziWwT38IuchnV1ierItcuSuRs4mndiU6enihPHg69brAKzVsF1
	Nk4a+Bk8CAX7yvLApK8kbAbGRFcQcs3gOJ3wG5dN3B9RBYUw7iOKIIdaSRGjBbZXMALRsZQNu7F
	mxRBejUKvPfPCm9kU8wOnyFFpMZwOp8pXWylme9cP5hz8SUgyOnIerfhIvZgstzKxI9c=
X-Gm-Gg: ASbGncu4wTDHVillIuLZix6QFXSB+LLZgea/mhHQ0FkHstz1tJlSRfEq9mF2XaGt37Y
	9HzZjuJ3m6UErqwENI/50nrBXZ5ahz0GED64xxTI5K3OiaAGa1r5fcP3lpBtf6ReqhakEvIErlS
	oxrMrGoJUOu/Et3JvqA636lIBBlpdH2Idt5OakdsWjtGv68oTY+m21ri7ncspDRNiC5/nn5UNEq
	/Fow4WscJv+IPvTtCI6qPAzQ0/S97ro9uwCVeiPmgSwTPVgN9S8+DmnaxyIo3hEgAz1Kf/VuDDs
	gh0T5koUn1OuR+Lxkn/B5crZRLMFHbRl/KW362XAbheGDfmDnIeZGPhV1WclvgBw+PlQoOc5xBL
	FkXPcPt4Gj5X2z5baKnpzx0TZdvPfGCuRu9qLMWEoQgIsxB/Ux06zP60xVg==
X-Received: by 2002:a05:622a:2617:b0:4dd:2916:7980 with SMTP id d75a77b69052e-4e6eacdac81mr73922141cf.2.1759950920147;
        Wed, 08 Oct 2025 12:15:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE4rMJuDQ11cU0fEePDen159WkUOlwxGWhLHakggUGwUJweQQyEA6jLWCQf2NLDMt7yQE0LfA==
X-Received: by 2002:a05:622a:2617:b0:4dd:2916:7980 with SMTP id d75a77b69052e-4e6eacdac81mr73921421cf.2.1759950919569;
        Wed, 08 Oct 2025 12:15:19 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5907adaaf59sm266158e87.85.2025.10.08.12.15.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Oct 2025 12:15:18 -0700 (PDT)
Date: Wed, 8 Oct 2025 22:15:15 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/8] media: iris: remove duplicateion between generic
 gen2 data and qcs8300
Message-ID: <aqoeloznoaggj7wge4wzajtinff6zjxp4hgqq2jqyt7ah5xggv@5gmn5qcgk2ko>
References: <20251008-iris-sc7280-v1-0-def050ba5e1f@oss.qualcomm.com>
 <20251008-iris-sc7280-v1-5-def050ba5e1f@oss.qualcomm.com>
 <e335be9f-641e-4835-8b9f-69398b131b7a@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e335be9f-641e-4835-8b9f-69398b131b7a@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: u-QM__w9xQ8lO54Iq4LgvQo6fwWm4dPL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA4MDEyMSBTYWx0ZWRfXz2fk8YkRp826
 ePOox3JrcudSGtABcVGUSq9p0QyQpiIBLQSl0/ohjrYg5h6zsF2OV3CoMwBhgpXgqhLpPIhBs8V
 saqoUbdO6Md7j1R8H+CHC9+nw0Amy0hTrG3Y8dN5a5iKKqb8Ofu37DJZYXHtnZ6fHtO54PEEh19
 pN24+xRqSrio6se91DCY9OdLPQJujzJVep4ItdC2Oy0BSNgHnkPww3hEr/H4DkFrkChVYWu/+X6
 jWgk9hULzxe4skhgIx7yzFM/3yLv73YyMhpfD7TC7RIJDMWzjzwMfDyHt/iWg+RGvccUqVTYDqM
 qamPAI5PtcejlUg7Tdc0xgUCGgfUMDp/NVnsQMixYjxkbXsdr1t/j8ugQ+LFGgNG6DTfoQvrX8r
 tY6uoQt5N4OMW51V2MUtyA59Rhqf1A==
X-Proofpoint-GUID: u-QM__w9xQ8lO54Iq4LgvQo6fwWm4dPL
X-Authority-Analysis: v=2.4 cv=b6a/I9Gx c=1 sm=1 tr=0 ts=68e6b849 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=EUspDBNiAAAA:8 a=HR2MuO_p39cwD0E3uXEA:9 a=CjuIK1q_8ugA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-08_05,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 suspectscore=0 lowpriorityscore=0 adultscore=0 phishscore=0
 clxscore=1015 spamscore=0 impostorscore=0 malwarescore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510080121

On Wed, Oct 08, 2025 at 10:07:47AM +0200, Konrad Dybcio wrote:
> On 10/8/25 6:33 AM, Dmitry Baryshkov wrote:
> > Now as we have removed PIPE value from inst_fw_caps_dec there should be
> > no difference between inst_fw_caps of QCS8300 and SM8550+. Drop the
> > QCS8300-specific tables and use generic one instead.
> > 
> > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> > ---
> 
> [...]
> 
> > +static struct platform_inst_caps platform_inst_cap_qcs8300 = {
> > +	.min_frame_width = 96,
> > +	.max_frame_width = 4096,
> > +	.min_frame_height = 96,
> > +	.max_frame_height = 4096,
> > +	.max_mbpf = (4096 * 2176) / 256,
> > +	.mb_cycles_vpp = 200,
> > +	.mb_cycles_fw = 326389,
> > +	.mb_cycles_fw_vpp = 44156,
> > +	.num_comv = 0,
> > +	.max_frame_rate = MAXIMUM_FPS,
> > +	.max_operating_rate = MAXIMUM_FPS,
> > +};
> > +
> >  const struct iris_platform_data qcs8300_data = {
> >  	.get_instance = iris_hfi_gen2_get_instance,
> >  	.init_hfi_command_ops = iris_hfi_gen2_command_ops_init,
> > @@ -1022,10 +1030,10 @@ const struct iris_platform_data qcs8300_data = {
> >  	.fwname = "qcom/vpu/vpu30_p4_s6.mbn",
> >  	.pas_id = IRIS_PAS_ID,
> >  	.inst_caps = &platform_inst_cap_qcs8300,
> > -	.inst_fw_caps_dec = inst_fw_cap_qcs8300_dec,
> > -	.inst_fw_caps_dec_size = ARRAY_SIZE(inst_fw_cap_qcs8300_dec),
> > -	.inst_fw_caps_enc = inst_fw_cap_qcs8300_enc,
> > -	.inst_fw_caps_enc_size = ARRAY_SIZE(inst_fw_cap_qcs8300_enc),
> > +	.inst_fw_caps_dec = inst_fw_cap_sm8550_dec,
> > +	.inst_fw_caps_dec_size = ARRAY_SIZE(inst_fw_cap_sm8550_dec),
> > +	.inst_fw_caps_enc = inst_fw_cap_sm8550_enc,
> > +	.inst_fw_caps_enc_size = ARRAY_SIZE(inst_fw_cap_sm8550_enc),
> 
> 8550 enc data has a .set() under a number of caps (was qcs8300 tested?)

Welcome to a non-conflict merge issue. Commit d22037f3fd33 ("media:
iris: Set platform capabilities to firmware for encoder video device")
added .set callbacks, while commit 6bdfa3f947a7 ("media: iris: Add
platform-specific capabilities for encoder video device") extended
QCS8300 config. Nobody noticed that the second file should also be
updated, which is yet another reason for merging those two structures.

> and also additionally defines:
> 
>  * INPUT_BUF_HOST_MAX_COUNT
>  * OUTPUT_BUF_HOST_MAX_COUNT

Good question. I hope the defaults should be fine...

> 
> values of which should probably be cross-checked (they say "DEFAULT"
> so it's probably OK, but just so you know)
> 
> dec is 1 : 1
> 
> Konrad

-- 
With best wishes
Dmitry

