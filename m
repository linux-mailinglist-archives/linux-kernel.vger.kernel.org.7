Return-Path: <linux-kernel+bounces-776343-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 94EAFB2CC35
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 20:38:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B680316FC5C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 18:38:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DA452E2295;
	Tue, 19 Aug 2025 18:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="S8Tt1NgF"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7300830E0E1
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 18:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755628682; cv=none; b=YrzoxfuIQmXW4YamOAYouyJyy8cnCO4WgdqAtzmvSSCIyJFPCQkmXqUBk2iTA/78AJW4F9pSuGuGSlQhkLgQGl6kGBbKvUXc4wgQK8VRI8w4woY6zfu/RFZqbcq5FSiO0YY6YOoMsKdTz0WQTOSOFl8NplEecMcbl42u1Ia+7nY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755628682; c=relaxed/simple;
	bh=fzu+T/ZpzSqtE+bS/ZciAkniuUnpqpoUpamP1BrgRg4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jU5uGjVWSETbzIOUy45GRSyzft39zcIW+v6pKBa0r4PyiNWX7HxFKTm02MTjIVH1LMQjGYYXZMxCYbdScoK0hRbZh+0IyXENgWoBIpph3j1NLUJ7iIqD4iIQ/ZFc1+Vo8iYzMdotty0GZBixCkTOYC965le4DVnyKmMBAT/l46Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=S8Tt1NgF; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57JHXBrP005675
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 18:38:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=FuqeBl3XXkMoRSpQWscvedo8
	vMMNpCq8+JIGH5PifRQ=; b=S8Tt1NgFWZUAxFYCkBWUVN1turDtFmfB4OuXWqVy
	Tq5bcbnSAjmB5TYv5bbb/76sJBu5DnUUuSndAPo1ADNeX4xpopW+Jb+PiyIr3yfJ
	b8WSrheObpQxIuvCAtPU7VSZfqEMm6Tc90Arpr3EtQWG2Mp9H0FqRmr0H6fnvlid
	Z0+eov7NWaMrE08ih5/JVtJJq3IPWeQrtVwCjsrw8xp5mdzbNxL/Z3AAY2sKyXVt
	OhER9JJGBVt9RS2t4Ta07CUVZhSoxzAg8dPR1vX7cZD3VEEKWqPI1zXtiEDbJqdr
	+R3HeypNnVIrWolFV+tnwpUV/jE8vSkio+yTXalrL9OL6w==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48jh079kax-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 18:38:00 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-70a9f5bb140so187975826d6.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 11:38:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755628679; x=1756233479;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FuqeBl3XXkMoRSpQWscvedo8vMMNpCq8+JIGH5PifRQ=;
        b=f1tkeTMAF+9vJlFp1bqIYIyE6UHDRCi2KWl0vI+NxOt/FrE8V4QfQM/G48mmWnWM5d
         /B4saRSAb0ZTAQkVvZxxIChqevNV0x8aTG0rQHD3F9a5Ga+dBdPERr1DAZ4Px7scddoN
         MdV/MbmIDqdWfXmf5/H4ogi4jd7ZJPID7SBrExitAninJjebUt/M6ILh3lvcvpWjTecq
         tCeWuYjFL5PZPNFLdXf45NOSRbaLU2s3JriC5A8eiJxOKIuQioRsysu6V0w1UgVT20NJ
         BGXYs4Oa9fau7vMYfaCXIa+k2cWEVrA5K0qPBRo3FUN5XEW8alQ1cYdD4291xRDuoeQn
         Hx0w==
X-Forwarded-Encrypted: i=1; AJvYcCWxvbeA/GmPiCnqaA9Dv6qrAoMO2gIIm+dc1KRXkfJp4ih+a5cWFq0rXMzgXGtn0kHeBok7pJBVRLn08LU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcZ9H5luN/uR98mxaq6kD7vwNI+eVubhu1bAEwojRhQMw0ouXw
	msR35F3Arn6YK40kgwIUaxumpm7gRw7edPW1d20iGyetYnMqwJ7La7prJclVw03zws7SSv5ZxMI
	9be/OSGlDR8S7RuDnf7y9l9WCexqan4FKj8bJiZ0eBgISzGqkXJDEQUNxfF/NSfdsoWk=
X-Gm-Gg: ASbGncuwm4M1Z6KAbB1j4UkTq7q4Vyvi+TtcvFArJM/241b5t34iya/dpQdJpsOrM/y
	qi7HhZy727wIKCDxn6+GNWyyrO85IeEUDzqs9L0QgUlKdO7WvgbL7lx61ZCBrusAuQV+G864DFB
	nAEhi/fAOMNhId4/pdQ8qeM2fg9hFnH5VOlRraYntXNcfdBPQ80xylPPXqBkTzK9/gpPyxwCoHf
	LTajj38/5fWLgiVevSmoObNWFJHIJG+rZNa4nHQz7GMvXWUa3v0cLzVB6bmHTm3yA1q6BDNv/42
	EHDsAxo5kBzi1mWWWPIB7mmKHO9NbILlJYhU56jbMwxAvBdPEpa7T2jp5h62B+U81Jlz/HuThVw
	3zYxDQxlK2t6WavB3RxqqvDOFczei3RH5p0pPmALmFDwlPQAIow87
X-Received: by 2002:a05:6214:485:b0:707:62c5:975b with SMTP id 6a1803df08f44-70d76f8b608mr442506d6.15.1755628679326;
        Tue, 19 Aug 2025 11:37:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHLtaEbQxqekbslnXL5QEBDgG7J4g/ZfzsWbUQYRkJowuQhIsbV+V8+PDEmGQipEuEBgC213g==
X-Received: by 2002:a05:6214:485:b0:707:62c5:975b with SMTP id 6a1803df08f44-70d76f8b608mr442106d6.15.1755628678559;
        Tue, 19 Aug 2025 11:37:58 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55cef473889sm2167995e87.167.2025.08.19.11.37.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 11:37:56 -0700 (PDT)
Date: Tue, 19 Aug 2025 21:37:53 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Qianfeng Rong <rongqianfeng@vivo.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        "open list:ARM/QUALCOMM MAILING LIST" <linux-arm-msm@vger.kernel.org>,
        "open list:PIN CONTROL SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/4] pinctrl: qcom: sc8180x: use kcalloc() instead of
 kzalloc()
Message-ID: <ezuwnxx3djye23x57vnlnvujauiefcjd5sh7yyodd7kcldfqhi@ya5kyvdftwn6>
References: <20250819143935.372084-1-rongqianfeng@vivo.com>
 <20250819143935.372084-4-rongqianfeng@vivo.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250819143935.372084-4-rongqianfeng@vivo.com>
X-Proofpoint-ORIG-GUID: gbHqYAgycOlrCYVQfgsGvJLk64o_yWxN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE2MDAyMCBTYWx0ZWRfX/PRAv3KbSOcb
 nasJhGxlJJcaHJNVUkI1SYaSq1x37lJMeBlLrZ5/n/OF8GkZPNzIv8LDU/UJd6kjLQmcby/T51B
 Ym6yb8er3SUzH33v848gW5/jheOQL/vCaFb3XlKXIeNPdAMBASKqQl1A6oh8wChCYQV5tFDRN30
 eEcnKAMeGxRKL0GTkk7rlvauQaV3Xqxj/TcbsKo8gY0GJmVLNFbV33wCSDp1OMX291au3K4Wlcl
 PsAzmHkMULtDYP9e/t0tdLfID6J4ZDVB14HxkM3mbVwd0fdXhE3FgsUpMoOeg5SMMRsmD1zusrF
 qK7IqM99xF0ZHG1jaz0GwjbWofbGxJeDkl5I9eyDXqY5NT+laG4jQByUBEtMs2nAFFQtgoaClMC
 lW3Ioa1C
X-Authority-Analysis: v=2.4 cv=a+Mw9VSF c=1 sm=1 tr=0 ts=68a4c488 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=1WtWmnkvAAAA:8 a=EUspDBNiAAAA:8 a=fkPgAY4U1MdPopZYpRkA:9
 a=CjuIK1q_8ugA:10 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-GUID: gbHqYAgycOlrCYVQfgsGvJLk64o_yWxN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-19_02,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 suspectscore=0 impostorscore=0 phishscore=0
 adultscore=0 priorityscore=1501 clxscore=1015 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508160020

On Tue, Aug 19, 2025 at 10:39:34PM +0800, Qianfeng Rong wrote:
> Use devm_kcalloc() in sc8180x_pinctrl_add_tile_resources() to gain built-in
> overflow protection, making memory allocation safer when calculating
> allocation size compared to explicit multiplication.
> 
> Signed-off-by: Qianfeng Rong <rongqianfeng@vivo.com>
> ---
>  drivers/pinctrl/qcom/pinctrl-sc8180x.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

