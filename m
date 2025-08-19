Return-Path: <linux-kernel+bounces-776341-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CBF10B2CC2E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 20:37:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B9E51C253AD
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 18:37:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1C3330F54B;
	Tue, 19 Aug 2025 18:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YzYMIuO5"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAFB530C345
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 18:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755628634; cv=none; b=TqZiyqwyySkOYkpUDagrXXL5VG1aUFRsJuFYGCapv/UgBgsAI/1Fj9RBQGKaJoSDGIDSwPR0H5oyFuZokme4wsYa5zvw2Dsqvy9po7+TsO9NHI09lCq1h1qaSPdOPUfKCGSAuQ/EIhJIF28b1m+ilRn95yb7td+HpwkDoQr8zSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755628634; c=relaxed/simple;
	bh=vrW0EmPkI4zd+cOzmIRYMTsJL+PuP37DVuXcK02yEyo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B3Yst/QUFPs/uTfN+lxTMzlegzkNYb0k7DA1o6gMZkJ6hyO8r+4iNr3+noWyJclVas3XKd8eSsdGdavhQT8fIeRZ9FMaW2P2B/mZkA24KyVVyCZ6AsXG+CsShLQ4m5nYNQRGxTMI9Q7OEg5UUjv7sZcTT7Mm8oyexvk8hglUNA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YzYMIuO5; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57JHItuI023302
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 18:37:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=8zzsSlW+vfcoetmh+aNUXt0n
	PW6Hm6tovpVdqMFTAKg=; b=YzYMIuO5P75hXFa7sLMDAQzgo14DO9mCdkXrao46
	qQJl//f/b5p7Di3PkGHO5npgEiNmOpPmqNa7WN2/KGeKJfNg55WbQK79bWbgnjEF
	lCNAkqCFPc6ZaU4gXV16IEglfmu3M+KwhxjOdlZ6pip2gRpqONewYNdkb6dHbfhl
	tPV/xGX3wlZeo+nbjHAe5OfXsOqStpWi91bE/FUrcG95z6JN8Sj46BsibsX+380R
	D/cCiILzF8vvHgNZ7zerKW/SKiiwzRSCzyf8xYyvW65X1lXJzob1YyLKy5w5Y804
	V0+gWtC9MpCS0YGw495qHGTS4cgmqUhY237FhjzkI1w5bg==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48m62vmjq8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 18:37:11 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7e88f379fafso1511598585a.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 11:37:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755628631; x=1756233431;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8zzsSlW+vfcoetmh+aNUXt0nPW6Hm6tovpVdqMFTAKg=;
        b=Y/rFwrwapOA93VCEB0JZsd8rgoKiEKXiCCh/t/kqCtJAODV+AtmCCa/h17xtNcjmnL
         bJQMo5eVAQTb+CFGC93ReA/mm6Jhva5zzQkPeAy5Xem7EOaBJW7vceOfIjjWmS/gGQql
         o4c/iOsJPr6cNSEn5N9i/lUl8aoKLAPJf+70XIcGScY9M3hYTKY5Cr/IHgfDbyg2JRK9
         yRANv/nmvSEieaA8Ez6slffhx4qgDkrt5XWrDMyphbJIhg6VsioVylxmh/4TYHMa7BJK
         1GpNTbCKzpz/0ppCUa3Mtwm3di2rPkFXg+Gvrj3kxfFv1Ik/dZDwwrenj/7+T2Cymttm
         o6oQ==
X-Forwarded-Encrypted: i=1; AJvYcCXx8F6xBJwb320go58YwenjtWlILMPSdhFThM1Fkq3bB8Rxg+5HuNIKpKdXZwMv32RsnC4XrGo4jaJJ7zg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIr7LHmnLtc5jzhfne5J/ER0LVcn+LDihAXtt9NqA3KpYEnWr4
	O79WOjtrodNKn0EZJ4mN7drzxk4mnLFb82DXo/XHzplLq6z/Hq/k9eK6h6TT+26u8tC/l3+Bvxt
	UUIhU1mBFnOlITG0PABzt7gRu0ulNKSxbJxfgYM6rKR9ZyTKMGK6+ZRAmBx+KxNSGqeU=
X-Gm-Gg: ASbGncsvIGoX8o5/sPRtRvLvAvJpfA9vOh0absWGzrZvkGrSl6cL0sWSeJRYmE+V7fC
	4uBE6rUYulArTPdaYeXlAZ/d++HnGqLGWZuZE0dmg8Y1qA0IWFFc98O334xUATMfr3emU1aSZZA
	O/WiSs7jskpR9vU7m1OcQ0leFkWeLxs1Xm/SYTAkQcqcYPMgz+C0gLoRQ62WwTBW1ypb/xTakXs
	fEwoHge00bPUpJvR9FxftjIAzJf+8Wz/2jRWd7b4YQkA3rXV6f7VdjYkZJxD6Fm0uJJkz1e/hua
	d++1pezVxI6+/xKz1QuH5c4mSEKZ541PgvSxr9rg7HzO4HLXwmS7kwH/EZCG+wTeVx4GkOIyaLB
	4CjKy7mkZrXjSsQ/9+CTnh8pILq2QwiDvDml8rJm2rpLr/y7cH5+8
X-Received: by 2002:a05:6214:2526:b0:709:90d2:4628 with SMTP id 6a1803df08f44-70d76f92bf6mr680786d6.19.1755628630654;
        Tue, 19 Aug 2025 11:37:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE/9Jbw5k2A7/yG7vgxGLA4vjWJwQp0tKe2YMtTmRKt/1P68C9GEw3yPXUBXiX/mkaJHk3uRA==
X-Received: by 2002:a05:6214:2526:b0:709:90d2:4628 with SMTP id 6a1803df08f44-70d76f92bf6mr680246d6.19.1755628629913;
        Tue, 19 Aug 2025 11:37:09 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55cef3ccd7asm2257069e87.82.2025.08.19.11.37.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 11:37:09 -0700 (PDT)
Date: Tue, 19 Aug 2025 21:37:06 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Stephan Gerhold <stephan.gerhold@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Sibi Sankar <quic_sibis@quicinc.com>, Abel Vesa <abel.vesa@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Konrad Dybcio <konradybcio@kernel.org>
Subject: Re: [PATCH 1/3] remoteproc: qcom_q6v5: Avoid disabling handover IRQ
 twice
Message-ID: <lf37hp2tkiv5xmhc3jrm2rulzureegrixxzptlffvscxbg3yhz@3r7bsvtuehjb>
References: <20250819-rproc-qcom-q6v5-fixes-v1-0-de92198f23c7@linaro.org>
 <20250819-rproc-qcom-q6v5-fixes-v1-1-de92198f23c7@linaro.org>
 <czaabkgp3aerp7fntqnpwgilipnum5vmdwwrkem5mugcs7vvd3@q2mwq6ijfbmt>
 <aKSQTc5u5AePWVwj@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aKSQTc5u5AePWVwj@linaro.org>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE4MDEzOSBTYWx0ZWRfX6Huw/XGjVCYe
 KjGYuRvqSBRYR2W9uLNqpr7peL01lwHOmMRD0tA/JQrr9V6APC6s173hRd0O+PXQI7X78sGDeh2
 fL+AjlYmveP1rbSwDwT3U3WEhZEhli2qPyOilL5NkwhEfRFn7WwjeaVfzhrNglrkyM1FEc9Ttq/
 JP2sHw6FIhgNHnOqKVt3KXiaYfm3ol92qYJpLNxiQ86oCAIUIFYHX1m2HlTHad0E6xU87yjyAzG
 N/A+J38ylP7HVfR2bZw13poJGEGFq1r6PpPoVB11n3iIV2cC0YdvcYYwz2/6MxnJTWE4kPXKV8R
 1fUCVDXonlI+QuoyF284/FhpeX9MkgiENA2yj2OTNUvH8y/6qjLFf4RHnWU7DDGCSiotOZurUQa
 XSyoMXMH
X-Proofpoint-GUID: TgL6hhyTy6pJnIupNqQAop-LA9t5Fvks
X-Authority-Analysis: v=2.4 cv=A4tsP7WG c=1 sm=1 tr=0 ts=68a4c457 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=512bcEdpdAFZAVaU8m8A:9 a=CjuIK1q_8ugA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-ORIG-GUID: TgL6hhyTy6pJnIupNqQAop-LA9t5Fvks
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-19_02,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 adultscore=0 malwarescore=0 bulkscore=0
 spamscore=0 impostorscore=0 priorityscore=1501 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508180139

On Tue, Aug 19, 2025 at 04:55:09PM +0200, Stephan Gerhold wrote:
> On Tue, Aug 19, 2025 at 02:44:26PM +0300, Dmitry Baryshkov wrote:
> > On Tue, Aug 19, 2025 at 01:08:02PM +0200, Stephan Gerhold wrote:
> > > enable_irq() and disable_irq() are reference counted, so we must make sure
> > > that each enable_irq() is always paired with a single disable_irq(). If we
> > > call disable_irq() twice followed by just a single enable_irq(), the IRQ
> > > will remain disabled forever.
> > > 
> > > For the error handling path in qcom_q6v5_wait_for_start(), disable_irq()
> > > will end up being called twice, because disable_irq() also happens in
> > > qcom_q6v5_unprepare() when rolling back the call to qcom_q6v5_prepare().
> > > 
> > > Fix this by dropping disable_irq() in qcom_q6v5_wait_for_start(). Since
> > > qcom_q6v5_prepare() is the function that calls enable_irq(), it makes more
> > > sense to have the rollback handled always by qcom_q6v5_unprepare().
> > > 
> > > Fixes: 3b415c8fb263 ("remoteproc: q6v5: Extract common resource handling")
> > 
> > Didn't earlier versions also have the same behaviour?
> > 
> 
> I don't think so. The "extracted common resource handling" came from
> qcom_q6v5_pil.c, but q6v5_start() just had most of this code inline in a
> single function [1]. The handling of enable_irq()/disable_irq() through
> the goto labels looks correct there.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

