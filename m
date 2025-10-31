Return-Path: <linux-kernel+bounces-879379-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B80D0C22FAB
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 03:23:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9EB523A782F
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 02:22:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F60127702D;
	Fri, 31 Oct 2025 02:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="MTKCRy3C";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="PfZeAdov"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA675274671
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 02:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761877332; cv=none; b=uHg7qXBF80RXTMIGhdRNAWQX+88V2tAFa6aNkVT9SEqfuicrtjV+psfQeaJ/0u2ePcj+sAOI3jcYLxOjcKcu90EW0TpbxtB3Ojpb7iik27BGRbt/WoXZEGMQgqAdM7maU8129odf1mZPXilCGCL6TaHL650ItwCk2fbyME6dEJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761877332; c=relaxed/simple;
	bh=GDH8b2/gQBMRAEIq8JShRRNhVZCWvHt8kDM4sifpUmc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IF+ZoirCDC9GAQLF6NA5F0jZ140lb0eh9OV9M2HE8WzS/rP7ue+f8z5ET8djnU7TiSMcdwXRNEAyCWSAKDSRvDHQK32gjyc7RM+M1nH3N29HsYGFRpSkdU+sjtIM1AJ9hq8j2KOmR0aMA/0iD+eis8DKrefc8rMOHPXyNHqfi44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=MTKCRy3C; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=PfZeAdov; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59V17tsG1512264
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 02:22:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=3c1obq8ZZLIS5GwXPjQ6YRMj
	wgPZ1GO2NkBLtaKSH38=; b=MTKCRy3C00PEmbbajCqM9XMRIvF2EC05LSoBw22u
	eBnXU0FrabPR3cpF6hGOD6gYTkAwQbQVRIRA6vDvQseAOEqQuepSKlej9SmCLIWq
	e2NEU7cTHtO9Q1fTh7ttZfb9Fr0+nZFQAGnMg7PaGSB1VdO1iN+t6iQKJlSe+R94
	VSVsxtVahIg6dFuwWyYJGPhBbt1hEkkAVkLluopHS+5Up4/vmjaFPxTaBDGcnz8G
	nqe0iX16qBTXFM6298vQqSNWwAfaIx0u4tgbi6k/FhbIh+/VXiEWoaTvtIJQHbaZ
	yKkQDWtjrB9O+FKhanWMBct4H+tbv2+pjILWPSVoFDgW8Q==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a4k69g53a-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 02:22:07 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4e892f776d0so75542651cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 19:22:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1761877327; x=1762482127; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3c1obq8ZZLIS5GwXPjQ6YRMjwgPZ1GO2NkBLtaKSH38=;
        b=PfZeAdovsrZ7x1/ual/vn4flHF6k6GItvODUrNXxysL52FblgD2aFVdLx5aJrU57mX
         DO03I++W5EVYiTzhOEOi0AwcUQ44SVhe6MOmt8OmZr5K4KCT7yhXdb08MWKGzyOQHX2c
         JY9nz3H/15Ady8gnQuFrzUIT+340EewlliOuY0YxlDlGpHOCfF1HZVN+6q80PBrnOZnG
         1OyBHEnhyPvhvThZNDG+5r2aIffOeswtmcQB9lBApA9ZPqeL39HX9/BsV64BDByYUe7B
         MtVEGhiTQ50LXZmJ3gJpLuHihdzwG+qlnUq68RJLI5O+NjtwMRod5qXxe8cA07PCZBEr
         A6FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761877327; x=1762482127;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3c1obq8ZZLIS5GwXPjQ6YRMjwgPZ1GO2NkBLtaKSH38=;
        b=ZNBLO6DbFcTi342npd7jwGgF6ZzRA7h0QgxFjPBdhh70ZArC3AGLvkeLGSSN4qM1d6
         e2f/xe4NENFlSIvMH50gWmC8myHX8IUK1jllNneNvIuwILHuD5HljclCzLF0azwZ5XLr
         vW8BeX8Tdl0OyWsDst7jJNJZ+xILUPaxD5CEbVBiiCoVXSYcE1yLVrArwU4BZOl4QU/7
         Q1jL3LPq3++VUyo4+NNkf5YP9VuUxl3grUav3rmzMibeWIol6tHWvIa8Mswqnv5KUCh2
         lXFViucV1VPVSyYAgllYyNnNQL322pATw9hV2TBCjZ8tPUi8ZnLr+fmf1nBYflj4KK+6
         NzdA==
X-Forwarded-Encrypted: i=1; AJvYcCXIA5avrYDYP2jSDVLfPZnOLIXnesF5ZKJzxV7h8gOtQrU8e8d6YMpgJlvLzdsijgw6BKk+oszer678EDM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyi3NE564pVmzbf8xkrVr66U/NKh3/L+P/9cqmwNf1bFwydt8L0
	VyBwvJW8lp9l+T0G+4ldGUTIqygjjYQNNuFWtW7Hd9872shT1doUcKVELOXaHU+bjPKoqxPOgwr
	Gor5iRU+3nx0LoIardaNVkHaH7/h7hE3LH0wlLWLeuu48dGyeAqrHL82JJZAjGyLmkqM=
X-Gm-Gg: ASbGncvrZUB1pp71X/E+t3wCn7Q1PiMEkGC3y8H/S+EfWrBFtQK6z8lvrdRyUocarvX
	Vh57v9c31psVNLyECPuz+Bawc0/kPc5YGw9/cRd3+kZrZsVFAQRqfCVJPIfHVTjaFNlKwOmx7lH
	GYH5wxq8ICd8VyQdiPgGerKFGL7v6n1sfIMY35rxn/78POWSV84evHyXEXyB/v1HYEifXhektHP
	870kCO2Q86yR5dVbiWfQkNSNLc+01wfCLc/eyBYGyBnpeHdfqTf4jNnYx2eb9GyZ6GTeFh1lDEv
	A4QCxA1JeJu9E6ku1Kv8NiosUoovGQIjkltrVt+WNxy5SAI6mjP/vHehVJACqLI9ugSIK8mBkxV
	PbWduNNqv5MEFbUwXMLlPwfrH6fVIlBvJcvVGVDJDtUtUB1fMPKO9Gs9ln/fB
X-Received: by 2002:a05:622a:44c:b0:4ed:2715:611d with SMTP id d75a77b69052e-4ed31076fc4mr20775621cf.65.1761877327116;
        Thu, 30 Oct 2025 19:22:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGarE31FcqziYFgtP5AQeoEmQTIs0pBD7iyBHmNixxePHSIEujlFrVA2g4rLiwQlMH6ljRAYw==
X-Received: by 2002:a05:622a:44c:b0:4ed:2715:611d with SMTP id d75a77b69052e-4ed31076fc4mr20775461cf.65.1761877326654;
        Thu, 30 Oct 2025 19:22:06 -0700 (PDT)
Received: from yuanjiey.ap.qualcomm.com (Global_NAT1_IAD_FW.qualcomm.com. [129.46.232.65])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8ac03a75453sm23545385a.51.2025.10.30.19.21.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 19:22:06 -0700 (PDT)
Date: Fri, 31 Oct 2025 10:21:54 +0800
From: yuanjiey <yuanjie.yang@oss.qualcomm.com>
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: robin.clark@oss.qualcomm.com, lumag@kernel.org, abhinav.kumar@linux.dev,
        sean@poorly.run, marijn.suijten@somainline.org, airlied@gmail.com,
        simona@ffwll.ch, maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, quic_mkrishn@quicinc.com, jonathan@marek.ca,
        quic_khsieh@quicinc.com, neil.armstrong@linaro.org,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, tingwei.zhang@oss.qualcomm.com,
        aiqun.yu@oss.qualcomm.com, yongxing.mou@oss.qualcomm.com
Subject: Re: [PATCH 07/12] drm/panel: Set sufficient voltage for panel nt37801
Message-ID: <aQQdQoCLeKhYtY7W@yuanjiey.ap.qualcomm.com>
References: <20251023075401.1148-1-yuanjie.yang@oss.qualcomm.com>
 <20251023080609.1212-1-yuanjie.yang@oss.qualcomm.com>
 <20251023080609.1212-2-yuanjie.yang@oss.qualcomm.com>
 <zxofh6bwee3vjjlntlfqy7yg2iu2mipjvl7s5bcm6gbh233cjq@nuicjojawd2d>
 <aPsWEhM7i+gDjXE0@yuanjiey.ap.qualcomm.com>
 <4bnvh2ydtrmejknzpsxoalxoyjpq5g5cjbrico5ezbek24r52s@u5zy6ekh6lps>
 <aQF0zzUpLeUu4lrC@yuanjiey.ap.qualcomm.com>
 <5hftxsuqz745mxxk2hjpwfxwrm73p2l3dxn2mb2uqb2c44fd2w@l5xvadj7gvvg>
 <aQLInjBCbeNJVanK@yuanjiey.ap.qualcomm.com>
 <r3sbg5r5pesrfrave7l6nx4ws62eogfn7m4f5c3ur2a6xkhsss@f5vfre2hd2cr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <r3sbg5r5pesrfrave7l6nx4ws62eogfn7m4f5c3ur2a6xkhsss@f5vfre2hd2cr>
X-Proofpoint-ORIG-GUID: woCzBC8mCkP1GUWySxEn1xmaBrGaF5Uq
X-Proofpoint-GUID: woCzBC8mCkP1GUWySxEn1xmaBrGaF5Uq
X-Authority-Analysis: v=2.4 cv=OYaVzxTY c=1 sm=1 tr=0 ts=69041d50 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=kj9zAlcOel0A:10 a=x6icFKpwvdMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=e5mUnYsNAAAA:8 a=EUspDBNiAAAA:8
 a=hV_kQwtX5ugguncQdNAA:9 a=CjuIK1q_8ugA:10 a=dawVfQjAaf238kedN5IG:22
 a=Vxmtnl_E_bksehYqCbjh:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDMxMDAxOSBTYWx0ZWRfXyz0zKkKv7fHM
 2RKMM+5h8lyG1Wck8yqzRI2ipOoiKW7PLlkhL4vKZRt2Zj8ZhthQH6X4Ft6PaLLwOfTbjpH4V0w
 XuWPOZLQOrjXCXmnDO2aXmi0bXiYOvO5Xcv5VXgPWuFlsk8TnZdWBGfwBvNGIsS7XFI4uCuJi9I
 SgRexS5baKZUtDzyfXO/1/FIJ8ucG9KZPnQIElem75Vv4XQhFvtQVhxuR/FUIkMiZUOhjZ6pUwl
 5uUlIAW/dG16Kp+t2Ry5MudVMkFwtF+mzECunJQSnOR60WsPnmrvuxVD+YUl3ujgeXht5BG6p4P
 feOvdzTFmwE90QWd8WQEC0t1fJEm13FPTWcIPoJVU1b/BAe5lZ1sce68wijxRM/5H6kMDYvNiTd
 ZJ7JR1Jyqw14bu5P0YmbkrTmVLpCpA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-30_08,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 clxscore=1015 bulkscore=0 priorityscore=1501
 lowpriorityscore=0 suspectscore=0 malwarescore=0 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2510310019

On Thu, Oct 30, 2025 at 07:57:46PM +0200, Dmitry Baryshkov wrote:
> On Thu, Oct 30, 2025 at 10:08:30AM +0800, yuanjiey wrote:
> > On Wed, Oct 29, 2025 at 02:20:13PM +0200, Dmitry Baryshkov wrote:
> > > On Wed, Oct 29, 2025 at 09:58:39AM +0800, yuanjiey wrote:
> > > > On Mon, Oct 27, 2025 at 02:22:04PM +0200, Dmitry Baryshkov wrote:
> > > > > On Fri, Oct 24, 2025 at 02:00:50PM +0800, yuanjiey wrote:
> > > > > > On Thu, Oct 23, 2025 at 03:14:38PM +0300, Dmitry Baryshkov wrote:
> > > > > > > On Thu, Oct 23, 2025 at 04:06:04PM +0800, yuanjie yang wrote:
> > > > > > > > From: Yuanjie Yang <yuanjie.yang@oss.qualcomm.com>
> > > > > > > > 
> > > > > > > > The NT37801 Sepc V1.0 chapter "5.7.1 Power On Sequence" states
> > > > > > > > VDDI=1.65V~1.95V, so set sufficient voltage for panel nt37801.
> > > > > > > > 
> > > > > > > > Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
> > > > > > > > Signed-off-by: Yuanjie Yang <yuanjie.yang@oss.qualcomm.com>
> > > > > > > > ---
> > > > > > > >  drivers/gpu/drm/panel/panel-novatek-nt37801.c | 5 +++++
> > > > > > > >  1 file changed, 5 insertions(+)
> > > > > > > > 
> > > > > > > > diff --git a/drivers/gpu/drm/panel/panel-novatek-nt37801.c b/drivers/gpu/drm/panel/panel-novatek-nt37801.c
> > > > > > > > index d6a37d7e0cc6..7eda16e0c1f9 100644
> > > > > > > > --- a/drivers/gpu/drm/panel/panel-novatek-nt37801.c
> > > > > > > > +++ b/drivers/gpu/drm/panel/panel-novatek-nt37801.c
> > > > > > > > @@ -267,6 +267,11 @@ static int novatek_nt37801_probe(struct mipi_dsi_device *dsi)
> > > > > > > >  	if (ret < 0)
> > > > > > > >  		return ret;
> > > > > > > >  
> > > > > > > > +	ret = regulator_set_voltage(ctx->supplies[0].consumer,
> > > > > > > > +				    1650000, 1950000);
> > > > > > > 
> > > > > > > This should be done in the DT. Limit the voltage per the user.
> > > > > > Two reason:
> > > > > > 1.
> > > > > > I see https://patchwork.freedesktop.org/patch/354612/
> > > > > > 
> > > > > > panel panel-novatek-nt35510.c also use regulator_set_voltage set right voltage,
> > > > > > so I do the same work.
> > > > > 
> > > > > Please look for the majority rather than the exceptions. Out of all
> > > > > panel drivers only two set the voltage directly.
> > > > > 
> > > > > > 
> > > > > > 2.     Kaanapali vddio regulator:
> > > > > > 
> > > > > > 		vreg_l12b_1p8: ldo12 {
> > > > > > 			regulator-name = "vreg_l12b_1p8";
> > > > > > 			regulator-min-microvolt = <1200000>;
> > > > > > 			regulator-max-microvolt = <1800000>;
> > > > > > 
> > > > > > 	Voltage is from 1.2~.1.8 V , So I can not set it 1.65~1.95 V from DT(1.95V is beyond the allowed range).
> > > > > > 	So I use regulator_set_voltage to set voltage, and regulator_set_voltage will choose the appropriate voltage.
> > > > > 
> > > > > DT has to list the voltage values that work for the devices on that
> > > > > particular platform. So, ldo12 should be listing 1.64 - 1.8 V.
> > > > get it. I check downstream DT,
> > > >   dosnstream DT:
> > > >    regulator-min-microvolt = <1800000>;
> > > >    regulator-max-microvolt = <1800000>;
> > > > 
> > > >   I test 1.8V works, So I will add 1.8V in next patch, do you think it is ok?
> > > 
> > > What does panel's datasheet say?
> > 
> > The NT37801 Sepc V1.0 chapter "5.7.1 Power On Sequence" states 
> > VDDI=1.65V~1.95V.
> > 
> > So I should follow datasheet to set DT ldo12: 1.64 - 1.8V ?
> 
> If the panel declares minimum voltage to 1.65 V, why are you declaring
> 1.64 V as the mimimal voltage for the rail?

Corrcet here:

DT ldo12 will be  1.65 - 1.8V

Thanks,
Yuanjie

 
> > 
> > if you think it is ture, I will fix it in next patch.
> -- 
> With best wishes
> Dmitry

