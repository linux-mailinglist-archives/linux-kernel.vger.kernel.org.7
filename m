Return-Path: <linux-kernel+bounces-880745-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F4DEC26773
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 18:47:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 87BB14F87CF
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 17:41:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 222AA2AF1D;
	Fri, 31 Oct 2025 17:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jgb4u2wQ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="AJ+Nz7q1"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE3837E0FF
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 17:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761932511; cv=none; b=lDO1J5xpbov4XFRDjAq+JAfQQkJQkNLyFi0NGTn/QAegyzaO3LJlafwwnM28nBPyd4oW5Ao2CMY9tS4mB5vkYS/5pE4Vo2A9oj+shlYAdMnMlTzDXknonh5bPjgbqwHRtHI10FYyhqsDvZycH2/qewUbF75aCRcCguCLLlOsp6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761932511; c=relaxed/simple;
	bh=ciegzz2PjXifYO5eYluD6OgR+cbQoK7kyx6iGWQ5tVA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZOVuTq5iSgAspxZHfIePHe7SXhzYAqsJPy/ib4tGOmPDqMHAiUXTk/cSfh5qobaTo7WwGXXzVxIXXVGFkT7i1YzAKxmBsoTcBS9DPlJFOryucjXFO63WMItFmoDuyQUGwFJGSzSflUyroIVlegP8xIj2DviCihj/Qt6Xjd88Xbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jgb4u2wQ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=AJ+Nz7q1; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59VF7A9H3210494
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 17:41:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=VxcmZzcynSgst4RcXe7R2leI
	1xanu1Y8+qSXxwbZpnA=; b=jgb4u2wQ8qyrzhZlz/p0Whn7KbNJZ2jPrbs6xJ/o
	jC7R0EPPBt0oSIUyHgA04gxpa+pi8dl37ipTdu/WjhQnI4v50fF46S1xrZYkaI0w
	yk3k4kGGC/lBOr3sDj0UIX/kzlMchuEizmx5NujP+lXtvOAjV5JVnHYNN8KVZXP2
	HRpbDwhZABWIN9nuK9jge1XDZy6gX5/lbBq2F+iJsVp90MFxfCD+2bHNiim/SBxp
	9j0AQ3FG2ZK9ZlGsQOzjMvwWQe29eCncCShGuvtjatL7VVH55jOVxSPlVw+XV3/N
	9ZlzQtSgpkU8ZGfn5ZJHf+rdbuZjyQH8xx681LYXuG6djQ==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a4yfpgdyb-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 17:41:43 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4ecfa212e61so103364501cf.1
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 10:41:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1761932502; x=1762537302; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VxcmZzcynSgst4RcXe7R2leI1xanu1Y8+qSXxwbZpnA=;
        b=AJ+Nz7q1KQT/tkWU1ws0JtU+tgcZQ/FnVFShEH4BagSRpPBQCSU8T1AblCQlA1v7hF
         VFUOJKxD/AUbRdthIAzd0QTDe/3aKt/eOHJqV2ehxr+aGQuSM/bDicKexk2FsSWoNStT
         akfJo+5Buj0yZ85F/Drm/eoiYW4J2qzJtyi3wtIIcalVEFQ+biR+axuV8jAp2qWPiXp4
         /xeiVAYcWCHDgAZRO2PpoLD0GjUJSeL754SXYSBpV8kMyqNjEZDNqnZEfr6OvWbuHBqW
         OYkI0HAznHwNC9ysugABq3KmVsMsYJm2SM4VvHsgkuUihatJAtfbcHBRfxX/B+0OBCe1
         QfYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761932502; x=1762537302;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VxcmZzcynSgst4RcXe7R2leI1xanu1Y8+qSXxwbZpnA=;
        b=s/8nrc7CB8dQhXL5GYyNPSrFiBnpl6VGeDJKqAlS/+wdoXCoREDNtTwb6NEWdwEb1V
         PelRL5K/O9OJdhrDdqj0+8KCHubl8VqaF3jX5w6MWJXrzFVB0AU0ygponN8QxpUGCuIi
         hHCtdiQSeZcfIgHY03ye8GUI4A/8AWjPm3HmsvDLaEf8VozmekAXophLAHxTt0qMpZRI
         Tgprxr74zPoSAhPIQGXpXbvFN2jYViLPzTH8bjl0DTcTG8otEPf+bUKFJU1PfuA7ldIm
         hhV8diUxSIpuh5HoIHOrSau0709I4xM4gHoEfWxZbDzJQ7N/9bxXxb0ztH47WjLuYuy2
         tRdg==
X-Forwarded-Encrypted: i=1; AJvYcCUKjdqglB+yu61iasCmNNg5UF5Yes2Zg1DEZXHA8DeDFR3BDCibuQoVhg21P/3eHIQeOinmjEbY5yEUDhc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzsduet1nuIw4i0KuueOKNdysPnsKfQ1DOz+2/DxQ4tVK8Q52rZ
	guon3renVJiTkoMFHKj6RhbSM23wD1YQLDb40PIyYk5hwg/sfWid0jZgrpOVoFedNbJC4/iSsZ9
	4K9dk2APSw23CEku9vsRdRQDM30zaLoXaeLBAXe2kOv6RJwIFOTjofabAd9EWsIc0ytglpb+0K6
	c=
X-Gm-Gg: ASbGnct1eJ1yC+4Bl4siIbCQw8MZRMmYSi9u/MmE6hn2rqe+2pnilefUVXbZtOlRu8Y
	gRr8LzYWQblBdVZNXXLndVY5CAwezeTUnoR7kSrHtFTDvyOpI4hpXN91FJVJpdZdBAGgqOooEKl
	U2RD83nJAtaBJOZPPti2QOQ2tPJPKNOPTamz972ZbWRUbMJ0uy3xbGajYmVn0opqgMIHqhGnw4l
	XJa3Z/49xeUt2v/nJOWO7XjGeLdImLfIWNZhdLtrSB9jJ+9j/6Osg6Zda4Fm3MkrsEMAXMcUpkw
	aIdpEwyS2y5SX+VIgmtyjsuAxNUsUB4COAT721XCo3CSwzlYJY6cNglr+DskrYL/hfk5WSJ6JfK
	XIEwDj9QYN1NYaSK1VG7XByj2XMm7VbqoYG9Bq8DUujG6ZWT2OAb4zIGOXYCRa6XJZwcUNLwbQJ
	A9zaPShBzRkMwn
X-Received: by 2002:a05:622a:d17:b0:4ed:21d8:2cb5 with SMTP id d75a77b69052e-4ed21d82e33mr87278701cf.0.1761932502260;
        Fri, 31 Oct 2025 10:41:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF52XCb5YnBlyr6nx3UabwoWlqzwYIQndJlneAcj5eO+eZNaiaeosWcRCR9H5Jmo/0rPR9lpA==
X-Received: by 2002:a05:622a:d17:b0:4ed:21d8:2cb5 with SMTP id d75a77b69052e-4ed21d82e33mr87278221cf.0.1761932501724;
        Fri, 31 Oct 2025 10:41:41 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5941f39d162sm633076e87.37.2025.10.31.10.41.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 10:41:39 -0700 (PDT)
Date: Fri, 31 Oct 2025 19:41:37 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: yuanjiey <yuanjie.yang@oss.qualcomm.com>
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
Subject: Re: [PATCH 03/12] drm/msm/dpu: Compatible with Kaanapali interrupt
 register
Message-ID: <s3j6zlsoy5jdv5cj2x6bndtaxkdhiqam2rzwl4uxqlys3ojkjo@yvoktj7x5mok>
References: <20251023075401.1148-1-yuanjie.yang@oss.qualcomm.com>
 <20251023075401.1148-4-yuanjie.yang@oss.qualcomm.com>
 <nfekr4vi34ftxzyyf5xv4tsb5cr3tokiyfkerypqjf26dos3uq@42wcn6ji7nnb>
 <aPrre+WXogSZIE7L@yuanjiey.ap.qualcomm.com>
 <st53uwtdow2rl6bvmfitro2dmodxtzfnhyzon4xeeetkkwekxh@ewlzkelq25wm>
 <aQGAvLFkH80Id3p3@yuanjiey.ap.qualcomm.com>
 <br3aukcmx3p2mtowqglcuf77s5xfnfv3eisjexabxhjzigkjno@wk7sqptjn43a>
 <aQQkB6Ma2z3c6iyh@yuanjiey.ap.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aQQkB6Ma2z3c6iyh@yuanjiey.ap.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDMxMDE1OCBTYWx0ZWRfX8Mo04ewv+eVT
 334QX8GTfisTqxrjn3fGRDBhtf8pT7dujMothwVzKpGrr3PrimrYY1E6nufb+a39YYthMZwtSs5
 7ER9oLOPJ2K0Zh3UMdZH1GiHV7r3hspWdJ6bP3uZLfsuoWoYpRJknbchon09XLz0jcX4886+LE2
 4O+INxD9JNXYvheAnXYGGRfnpe5ikzjpewNFE1jMXM096eiDudvt3jv1hdpZ7xtEkiJVB2iOosb
 tBNwAURd452h31+MOXqs5dEDy8D1NqYjJxZ5euGWDOxRjjhiJXgLOE+JaGetAouh7AaHi+Su6TB
 kU+FKU/YHD2C/zykEzmImkdjQe9v2UVvynTMumxLxlqXLuV0l+XdcnEgzt+a2Suge+buddkwrkk
 g6DCxMqtto8BHTbMKg8O2AzaOPoP7w==
X-Authority-Analysis: v=2.4 cv=V5NwEOni c=1 sm=1 tr=0 ts=6904f4d7 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=chW72Tx8-oYo0CBprPIA:9 a=CjuIK1q_8ugA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-GUID: 7Aa94XKLJZAsxNTKr0kRbCmDd14z6rIT
X-Proofpoint-ORIG-GUID: 7Aa94XKLJZAsxNTKr0kRbCmDd14z6rIT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-31_05,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 clxscore=1015 adultscore=0 bulkscore=0
 malwarescore=0 lowpriorityscore=0 impostorscore=0 suspectscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2510310158

On Fri, Oct 31, 2025 at 10:50:47AM +0800, yuanjiey wrote:
> On Thu, Oct 30, 2025 at 08:02:13PM +0200, Dmitry Baryshkov wrote:
> > On Wed, Oct 29, 2025 at 10:49:32AM +0800, yuanjiey wrote:
> > > On Mon, Oct 27, 2025 at 03:21:33PM +0200, Dmitry Baryshkov wrote:
> > > > On Fri, Oct 24, 2025 at 10:59:07AM +0800, yuanjiey wrote:
> > > > > On Thu, Oct 23, 2025 at 02:59:12PM +0300, Dmitry Baryshkov wrote:
> > > > > > On Thu, Oct 23, 2025 at 03:53:52PM +0800, yuanjie yang wrote:
> > > > > > > From: Yuanjie Yang <yuanjie.yang@oss.qualcomm.com>
> > > > > > > 
> > > > > > > DPU version 13 introduces changes to the interrupt register
> > > > > > > layout. Update the driver to support these modifications for
> > > > > > > proper interrupt handling.
> > > > > > 
> > > > > > So... Previous patch enabled support for the platform and it has been
> > > > > > using wrong registers for interrupts? I think that's broken.
> > > > > 
> > > > > I want to express DPU 13 has different INTF register address, so need to add new
> > > > > interrupt array to let DPU 13 interrupt work fine. Maybe I should optimize my commit msg.
> > > > 
> > > > Make sure that patches are structured logically. You can not enable
> > > > support for the hardware if the interrupts are not (yet) handled.
> > > 
> > > Kaanapali Dpu interrupts: 
> > > INTR_IDX_VSYNC,
> > > INTR_IDX_PINGPONG,
> > > INTR_IDX_UNDERRUN,
> > > INTR_IDX_CTL_START,
> > > INTR_IDX_RDPTR,
> > > INTR_IDX_WB_DONE,
> > > 
> > > are handled by irq handler, so here enable dpu_intr_set_13xx. 
> > 
> > You have enabled DPU 13 in the previous commit. And only now you are
> > adding support for interrupt registers on DPU 13.x. No, that's not good.
> 
> OK, I think I should merge this patch into the DPU 13 enablement patch. 

No, just change the order of the patches: first you add necessary driver
bits, then you add catalog entry.

> 
> Thanks,
> Yuanjie
>  
> > -- 
> > With best wishes
> > Dmitry

-- 
With best wishes
Dmitry

