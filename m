Return-Path: <linux-kernel+bounces-867037-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AED1AC0173A
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 15:35:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7895C18C265C
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 13:33:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CCBB31618B;
	Thu, 23 Oct 2025 13:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Isv/NH1S"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA9BD314D11
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 13:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761226029; cv=none; b=AL/50Him8lnhZhxilQk4wL2w7kj6X63nUBFc3f0V7iRWfsMjcEiIh3S7XSTfifcGh5cAzYGm569Ts0SZ68TWqPqL9G9Zhtb0lgaOb7juqOZqO1TDw9GwzFZrTkrubp+bjSMgd/yEpsQLzx9UUZ3wzr1YcYxibUiQfHNcmmxoxYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761226029; c=relaxed/simple;
	bh=g+Rv1AjpSsTCKZOwQpgnDI79Ij1e7QTYDmKCsA8cuds=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CdqCDjB1dEYGuh2iVLFo6BVzxgdXdiVXfEh7vRkl9kRmL+AtnXU89qiPUEGGoLcv/GK14VLll4LL8zvlpfXkjbsnzbLaA3ieT920YQzJp7MybTR+e8w1HLyUsAqxphpvdJVn+FaO3Nb1NFh49AUCBxTWnhVxZnjo3TA3PZvSQd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Isv/NH1S; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59N7EcR4015926
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 13:27:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=zT/v/9VMVWiK9/shfJzJr3Rj
	xsz494Ezk/EBK0cyjeg=; b=Isv/NH1SmSzG1p6Qccm7OyquMrKA9YbgTBmcbf3v
	pO+PgWznCSHvDXc07zZxcJYODtpFDsaI9pMyvoRcSx4UpqEkW+UPPjSjjbogOcAn
	nzvgxtBHK1M3wssZOnCGw/yNne1LhqvqaTTHVajZQqCjx9IW/xSCCrHlfNzd66LK
	6zBJuPyhXYKmnTECmYAraKllOLgWNPy1R6IHB9L1+HxRfHmak+/RnwduNsSCs/cv
	ec1ljypNmw2wjcuxiEAiNAMjM98uxGmHjjPDEANsN5y2O75lqwvi6Ev22M83wWyL
	X4HCCfdDkR/i+ZDiOKsKGoG9LIaA4yLtLqSx3uKgcJoqyg==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49xkpse5kj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 13:27:06 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4e8bb155690so11260571cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 06:27:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761226025; x=1761830825;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zT/v/9VMVWiK9/shfJzJr3Rjxsz494Ezk/EBK0cyjeg=;
        b=qzdYMbCFKRlPUxK0Gg0wqeEVwqhprw+8QcYuvGhePMqir0IS8ZKTkiVwcaW2yejHYu
         47uNWN0fGdUysXpIqgJ7m10XxC3Ly0OGJNST8bmeWAA/jP34PvXOk7Nh8/nPI32tjDTp
         FaF4HiaJqMfaBuLTG8oruN9k1yqBoyv2oBj0rDHSRmePAYus4eZ+MUV4BGUjtZbE8rbF
         UwjAycKWMBPCeY0ASyMDXXvzAocEYIXdoz7Qr8Dy62sxgU2YPwZZ196mA3R1vc1Xm/pO
         YEncr1f7g/Q0DGr86eE0fEUpA0zZsx6vQyw+aRhj6/ymBQz3zuIJ4ZhvwpC/zbFqWRTF
         r1wQ==
X-Forwarded-Encrypted: i=1; AJvYcCWg3OOMjLAiQ7Wz9HEf0Ch2k1LVYDYIQ6DXoeito5TFTa2XrSjC5uq8jvSAFAuF4vRzUIdM59f9AopNkEc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxODfCh/06R0EC01cGgnecT7Y5A9QCCqKAIxolRT/RSbiwTy81W
	h45m/OtFIhbzRRjcHfESQIWYZCwtnkdQ8NqXg4txMKGa66clz2tPYh3Sb5qv5t1DJT/4bB/Vly2
	tlkF4ikxYlg7P/nvmx4tpjtYSpmp7nX/v6IX6phXCM7C/ZQ5vmJJ/04pBmul75jUPc3A=
X-Gm-Gg: ASbGncvW2d5ixfK7zYnknpMRQvcYjsxgQC9VykMrjYarOgEYPV/Ar2ATWYNL4bkXY+I
	/drVwg7LfYdk9BFyddzvhgJH3Ic84/AGM4m4de23grn9a7KNabsnA08mC9IduhUJqGyh7vqV3jG
	QMIUgvYNQN/P73dzcfQnMb2H7mAIp7UaC9xySZa5bJO+oMm7ek7sUE8s/pt083xOvNtANwWuTkm
	a8IdaaC+D+Stvz8TWfilcZjykcj0p7dX37RgB25tcdvx7zW4X39mv6ATKlll0f6c3ieLQwj2jAe
	UQa6p5sukPQjM7zfWF8Bu3f9yv2P50dwedMsx0PxbG17LzUqmKo27Oeyic+P6zOSPm1rO+di7R0
	dIwtyRMkL0JratxQqgNubSiiliDr9EISbTHwXKTf60+nWwVBz7PftLeiCOFf/DwtRqcesxitPRG
	MJoGjMSXpspaKF
X-Received: by 2002:a05:622a:1923:b0:4e8:9ade:108c with SMTP id d75a77b69052e-4e89d2aa827mr271838111cf.34.1761226024531;
        Thu, 23 Oct 2025 06:27:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGANmpmamIIGJzojFfD9uGQMnLDoNMf499KeF+uSksNrzxNT9z5RsW0fShxZyAoOgvuNuO8rg==
X-Received: by 2002:a05:622a:1923:b0:4e8:9ade:108c with SMTP id d75a77b69052e-4e89d2aa827mr271837751cf.34.1761226023947;
        Thu, 23 Oct 2025 06:27:03 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-378d67dc6f5sm4594971fa.44.2025.10.23.06.27.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 06:27:02 -0700 (PDT)
Date: Thu, 23 Oct 2025 16:27:00 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>
Cc: Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 3/6] media: iris: stop encoding PIPE value into fw_caps
Message-ID: <pcbpoilqcqgidtbnji5ntzdqrk453msfmoccs5ntlustiqdomx@ekatz52c4f2u>
References: <20251019-iris-sc7280-v4-0-ee6dcee6e741@oss.qualcomm.com>
 <20251019-iris-sc7280-v4-3-ee6dcee6e741@oss.qualcomm.com>
 <8c75296f-2cd7-b0cb-f7ae-d433d2834bdd@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8c75296f-2cd7-b0cb-f7ae-d433d2834bdd@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDIxMDE5MCBTYWx0ZWRfX/MFHFMXQHiYp
 pMr52wBhRZxXi7ebu+0m0tuNE3YcEnuRPUHQ7B4Uedx7yHwcydfOPxeL02Lp5pO/0KK07yo5rfz
 6wvhwt8ELX2T3NJ7fy0TA3ghJFjPdoZV1qbvGOcJJwAbR+uSyPi0nM8yXCEsW/ua7bSjoYjoTJQ
 EHfrhAoZ19nNvUPsgVRvjOLHJCUWDgouZwgI21AUTtDF0l0S4u8XmF9Blx9PziUQq3pOu2JTV0t
 FvxbIsTRIi+852J13zbGi/lbFMG9fUCJLARdk45gnUzqhg0vmztW/wCFse/oZXkMooVXq/h7RY+
 j69MwVR7+ZV9gN+BtYu0DSwyQdmxLVlRsYZcLAa5gm7Hw255zq5maa2GyohC9vG6Mj6481tVTdM
 Wp5OxO/eLPgtS6bqQXGrxfuA+GYf/A==
X-Authority-Analysis: v=2.4 cv=FbM6BZ+6 c=1 sm=1 tr=0 ts=68fa2d2a cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8
 a=q52pqm9MKi6dhOjivlsA:9 a=CjuIK1q_8ugA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-GUID: JNYiAUJ4hDvrc-lAOl_ZarfsYUudDSNe
X-Proofpoint-ORIG-GUID: JNYiAUJ4hDvrc-lAOl_ZarfsYUudDSNe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-23_01,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 bulkscore=0 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 spamscore=0 impostorscore=0 clxscore=1015 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510210190

On Thu, Oct 23, 2025 at 02:20:36PM +0530, Dikshita Agarwal wrote:
> 
> 
> On 10/19/2025 1:26 PM, Dmitry Baryshkov wrote:
> > The value of the PIPE property depends on the number of pipes available
> > on the platform and is frequently the only difference between several
> > fw_caps. In order to reduce duplciation, use num_vpp_pipe from the
> > iris_platform_data rather than hardcoding the value into the fw_cap.
> > 
> > Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> > ---
> >  drivers/media/platform/qcom/iris/iris_ctrls.c            | 16 +++++++++++++---
> >  drivers/media/platform/qcom/iris/iris_platform_gen2.c    |  3 +--
> >  drivers/media/platform/qcom/iris/iris_platform_qcs8300.h |  3 +--
> >  drivers/media/platform/qcom/iris/iris_platform_sm8250.c  |  3 +--
> >  4 files changed, 16 insertions(+), 9 deletions(-)
> > diff --git a/drivers/media/platform/qcom/iris/iris_platform_gen2.c b/drivers/media/platform/qcom/iris/iris_platform_gen2.c
> > index b444e816355624bca8248cce9da7adcd7caf6c5b..03ce5c259c8491ae6882128795d18569baea6241 100644
> > --- a/drivers/media/platform/qcom/iris/iris_platform_gen2.c
> > +++ b/drivers/media/platform/qcom/iris/iris_platform_gen2.c
> > @@ -161,9 +161,8 @@ static const struct platform_inst_fw_cap inst_fw_cap_sm8550_dec[] = {
> >  	{
> >  		.cap_id = PIPE,
> >  		.min = PIPE_1,
> 
> Do we still need min here?

No, it should be dropped. I'll do it in the next revision.

-- 
With best wishes
Dmitry

