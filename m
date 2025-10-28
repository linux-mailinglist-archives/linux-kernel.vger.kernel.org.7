Return-Path: <linux-kernel+bounces-874752-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 763E7C17051
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 22:33:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E0E3618961EC
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 21:30:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A93213587CE;
	Tue, 28 Oct 2025 21:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="lBP3t+ws";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LLGqrvpd"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC7B73587A7
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 21:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761686771; cv=none; b=M9laCOGkXMO59drD3IucyfybCmC0mPFEtqLiY8Haafc6VTJIPmIBeeJaEpc7MCkDR8jThUipiVxPETeML/jz0R3EoI5ilIatl1Pwm9IVmtW0U4Sq4SgUNh6F/w5WNR+PSm1ZRh6pI1FEXOf4qDdmA2wDZD7/0aRuBMMGLdcDRhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761686771; c=relaxed/simple;
	bh=4hP7mUp6562MvODeJZ1YTDO+MZGFQF3RLB2pH0RdnJc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ke0MsieHK35s4HCAH+z7FD+KChoJ7kINn39U7jLrkTk0XORtg49oQP/kG2agv5qHX+O6l2+M96KEMbolw3OMVLpj1BLLpCitQT/5IaUxHJB+m6eMX1hIgeDLV9H5PDeZFX4V7KWlFdHd8YuG9PyQtutD5xQlPN6iD7oJak+yFPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=lBP3t+ws; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=LLGqrvpd; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59SJllDm2525735
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 21:26:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=8ES5R4cKZbm2579FN/u91MD4
	liydQdt6c70evP352k8=; b=lBP3t+ws3HVpujM9Jh9orpxkun/mQgDlaSEi6xnH
	Ptw3GP8dO5uIgRkyg2ghxRhYkHlxS2Sv51+0/xBRPZsXmirXw///p4aFP5RVOXrh
	Jh2awRbjsnZQxgLeptxBVDEqhnJAGd3czALa137sA1zSAeFyDNKHkV9stX7lxyZe
	mD57fYcAlvQoP8eKW40mE1DoFk2ypVnn4ZPz3Mq5YEizu1fu9Qs2JM+GKC80Ye2V
	DvZ/DXRIrXk4R0zu/ExqS66kHa003dfXw8VIDL7rV/2TbRp3peyQg65C9i4d9OqG
	dXKX2GVpDILSZLlghT8E1lPmUIvfmLPBPXn6b9la9wd0hg==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a34a3r7vb-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 21:26:09 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4eb9bcc1105so10742441cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 14:26:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1761686768; x=1762291568; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8ES5R4cKZbm2579FN/u91MD4liydQdt6c70evP352k8=;
        b=LLGqrvpdeXeM9L/dF/6e+rpLbM0wf2/a1Wkz2+TrHLyM7zf3puOFl3nFe0xYHj8LPY
         +VQwvUzYt47GNWD9d3HK/wtvAILMir5IAfLuw44bsFIaLD/iDuTJ2RNBLS8WONV6l+Qq
         xvLYzDdZrwHbOcFlWzMyzDwzj2PZDCBoXzr4vu4wMzd3Pp58uuoo3tTwvHqQs8jc+pbt
         0cue45BBckA+lAPrE0goErSG/KuxZ2T2SzCT3U8mxj4GWhZLXOD1ffB8JM3i2TdXx6EK
         C4hqhHtNiDDNASLzAxlrLyMznbHZHwts8WrFLYOesfgh9p7yvHHwruOUzUm2Z8wJlmjo
         aT9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761686768; x=1762291568;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8ES5R4cKZbm2579FN/u91MD4liydQdt6c70evP352k8=;
        b=XEytiOtyoK8iQS/QKLec1R88ty/p1+TpTFY5ZTY01M7EmBL/d05iQWHjfVK6Im4o4c
         14i3r3NseFwQsd5UIvbXvQLvFbZ5A578fL/kxYsdrtYwqEM140JnYJ2KLLIqa0vlJj6o
         Ae8Sh+5i8FuUpxxeYrotvIZT24T/wxjA7KFvB0wAULBjPGPV38Y0FuKzSWX9CAhQqc99
         cmuQx88cx/LPJhm/RJlju7cXPT6zBLmv7J8Hg4Y0wPGdkrR3pbS+AI1dmnBEyb2NzBP3
         iyNatgyW6oDXKCmGn25JW+WVp4BfbQ/Efaop8POrWRTfVk1t6z41K5+cO1qYaOCzQnii
         OmAA==
X-Forwarded-Encrypted: i=1; AJvYcCUKFYWBplze1tpjizzjYy3qxHykNsgRcgKQfSXoqy35oPy1qTRw2pgA6JhoEbkwmbzUhAGeCixX4hJk/s8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzvvne8uznOIqW0dgKQK35acG8mNNlm/R03tNG4cNXvbj7mB92x
	oQbqAp4D5qcOZN/cXbt1ceKaVD4f6MAzG4zk61FbmZDNH4bi4p3WM3Q3q0XYxnTDRxfrN0Bp4xr
	qnenXhKl4FkeM/YQU/lc6naXltYdmojz6ScmIjzdu6JNJkBcQT+kAwK0dlm3H+MuwSTE=
X-Gm-Gg: ASbGncs3gPqWcBU3QG2cACmjDlsnCh250IbGk0Q04zaiiGzEjs1uXb3FAk3FFCu8D8e
	ejjeI0Hz+T3zHu9Di0kvCI7LJSPMNhC2Kx0Z0YeEc3cLVQHQ/R9wdUGQCFMCWwzZv4DsnHnY8k9
	DHxnEzS2nQ/lQv5Le0fY/SjiyFFE0MEOZSE8XXpIZ6eDVAY60oYhNEBMrPSUivg804f+zt6R9g3
	R62Niug/qbOGOwrJe6cTB6uSMoQdcBEPxGSsvK4f5hVS7OMAScdmUWKxz0Z7jpqLzuEmauuUxsv
	lt5wQj9GQ84OcrU5M9GxfEex7lmDCopDNKqnjzSYQp5A4EpVtAn/p3D+NSDS7NbqVmz9XYYw0Rm
	y0ijdhXHmJ338/eERyvZxc3kperyfAq+EwDPtnKDgEr26a1VHoZ8fGQHNwtWiKWfxJQhvaOeuQ6
	DebF1Vj6D5hiJe
X-Received: by 2002:ac8:5d08:0:b0:4eb:a2ec:6e3e with SMTP id d75a77b69052e-4ed08a38b90mr56468171cf.28.1761686768006;
        Tue, 28 Oct 2025 14:26:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHWUsXJar9zGCJLVEydJueQvaPH5F/340n2td2aCFEB4n8xD3QLcbXS00cSHPhDL3ce1u5lAg==
X-Received: by 2002:ac8:5d08:0:b0:4eb:a2ec:6e3e with SMTP id d75a77b69052e-4ed08a38b90mr56467891cf.28.1761686767566;
        Tue, 28 Oct 2025 14:26:07 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59309eedf50sm1607060e87.69.2025.10.28.14.26.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Oct 2025 14:26:05 -0700 (PDT)
Date: Tue, 28 Oct 2025 23:26:03 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Vladimir Lypak <vladimir.lypak@gmail.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Kalyan Thota <quic_kalyant@quicinc.com>,
        Vinod Polimera <quic_vpolimer@quicinc.com>,
        Konrad Dybcio <konradybcio@kernel.org>,
        =?utf-8?B?QmFybmFiw6FzIEN6w6ltw6Fu?= <barnabas.czeman@mainlining.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/6] drm/msm/dpu: Fix pixel extension sub-sampling
Message-ID: <3eqazsv2f2or4l2xkyqetddxmfqmrejlskafgtvbnkfqoutv7y@cjnvezhfwloj>
References: <20251017-b4-dpu-fixes-v1-0-40ce5993eeb6@gmail.com>
 <20251017-b4-dpu-fixes-v1-4-40ce5993eeb6@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251017-b4-dpu-fixes-v1-4-40ce5993eeb6@gmail.com>
X-Proofpoint-ORIG-GUID: hin43DYgNQ9akQIY-Kg3wtHtPA3a7KIm
X-Authority-Analysis: v=2.4 cv=HM3O14tv c=1 sm=1 tr=0 ts=690134f1 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=Y3eLQpR3wbTgfGwADiYA:9 a=CjuIK1q_8ugA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI4MDE4MCBTYWx0ZWRfX8p6t6bTUd4SS
 2oy+aZyNG+RGLXuIAig92keTRzRTZblTWcUEgn+ZrLstoBuote0dXjsykuIx8M8kVwqDBTc9T2B
 iGpggcxFiaR54QYBcsibJ0/Zivxy1HI6WLu+I/2h9SRoIHI3dDRR8PlKIq5EWc2DPgEI5pFuCiX
 3aidGlrkvptqcwpc+hWT3AvcXTISTt/7Gm/TSaPAyIoZOWwUXefG4WOST4k1eogYKjb/3o1e1O4
 0x+n9lv383dDAqQw0CMjIJ38MzF2uytmgfj0Wln54dmcupPnF4ndgHmd87O2YWlseKfJKBF6FNX
 A4pFYrWXr5OLPSJtJEJDhBFIAnvu4EvoKkPeNeeU++FVD40eNjAXNNgyKIOLjOjGQJacEtoUTYG
 yEzUq8TMaSuOibRhS/5RIjNTl7g2xA==
X-Proofpoint-GUID: hin43DYgNQ9akQIY-Kg3wtHtPA3a7KIm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-28_08,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 malwarescore=0 adultscore=0 phishscore=0
 spamscore=0 lowpriorityscore=0 impostorscore=0 clxscore=1015 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2510280180

On Fri, Oct 17, 2025 at 07:58:38PM +0000, Vladimir Lypak wrote:
> In _dpu_plane_setup_pixel_ext function instead of dividing just chroma
> source resolution once (component 1 and 2), second component is divided
> once more because src_w and src_h variable is reused between iterations.
> Third component receives wrong source resolution too (from component 2).
> To fix this introduce temporary variables for each iteration.
> 
> Fixes: dabfdd89eaa9 ("drm/msm/disp/dpu1: add inline rotation support for sc7280")
> Signed-off-by: Vladimir Lypak <vladimir.lypak@gmail.com>
> ---
>  drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

