Return-Path: <linux-kernel+bounces-741724-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 54AD0B0E843
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 03:45:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C8331CC0C3B
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 01:45:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C1AE8C11;
	Wed, 23 Jul 2025 01:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="U8reSJPu"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B841218D656
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 01:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753235105; cv=none; b=llkl9W2Napj9MJfujFJQRSkY0Qkn9YawVWBzvjDeDpcYwDsvepRJr4N1hJ6hx/eJf+YKwRlCc+zS+/hBvAiPaXt5NZlipc91YZyJJhjdIZ9RF2YZdyDMtk2WON14F1bwKpup4OvXVwRdpYPnkCsGMR458SsdRytJ6zKaDCJyxwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753235105; c=relaxed/simple;
	bh=3ztNa+nnZDU9kypJZTOpJDy40wJdJViL+3PibACBSRg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gmgV52kPzu1akOnN7ZYNWtkUq9odBbfhcJ92/C5az7Rr8KBiAfIggTJSWi8i0BI8bpY9KqvWPR6HllcYuVQ8eq+WBoieTmBk7A+m7x9ZNOd8EMvYXwvVEQdDXFqpMkV1zsjaDmQc51z1FtRbP1t+OoenWxlavDjaeYZnSSkk9Ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=U8reSJPu; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56MMNvlf019487
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 01:45:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=p3rO97HBhCdBQ6/aphwKARQR
	J+eX+b09ZhEfv7a22fg=; b=U8reSJPu9fdS+diAroUyYqmwZflsJqvWnZ58aHdp
	3hSZBqJmhEOcIohUhoBBhPdf0RNHmDegeRsoF9zTO88ay+zNWPsg+q0smheQOX0Y
	n/JIBrZGoDC2dvSUrFbrOICSJorggV+fQa41JlW/QenR2X8YWCCGIFopbQnZke4A
	t8DpgsAT4KM6c02U91RPPvOkoeYpGBER8ZjfbwjqEtU79R6OjEGrXuJxO4/nxiHJ
	4Nqp4fd9H6FoHhJjV1zJDs3p/42+zBj+JiCCq+l/q30NN6GVmICqUbJfsVM4L8cz
	CfPkrQpNOQCAJFijClkjq9ju8KDyV9ezivYHNBMp09c39A==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 481qh6nna2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 01:45:02 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-75ab147e0f7so3335278b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 18:45:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753235101; x=1753839901;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p3rO97HBhCdBQ6/aphwKARQRJ+eX+b09ZhEfv7a22fg=;
        b=XT1s3wylXMIrb8LExkeO/zbz51NPLSSUqOa7gu1Pil9KcriRfiZG54cCARScexJruP
         3UW3G6prHec9G4pk0WuTSUct/75/nLK5OmzOHhJ8ZfSpOAVEDn6KH763HC+PfcXbJIdh
         9BqraXI6LVsbW+dtJye7u2HKszG6cgtzmOyCF7IYIoO0kJztpCj2suH6SD/qOjKDSaTM
         JqcPwqH8CVIjoQgoN0VTV5AHHN37FJufQXNOaR2u5+ylUTNSzHa9REgUxAO6DHsvpCBS
         iuz5fhGZmBo++Qr2p2uEoTCfaugGJIgWtJeQrclZLAhVpSSBlFahUNhmE/hdrYV36UBi
         hIOw==
X-Forwarded-Encrypted: i=1; AJvYcCU1WhGtL0LwTDxJaxwPBQFH328GDO/So8eeqL1Z0fTQY3+pWNFnuci6V9cg0zMWHe9jd1qerwXaJfHAiZ4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyuA6spYw5qpuz1WFZAr6l9wJcTQ+4mDargxEDXHW6pRbWAFNYA
	f8WpiRkOlJYtc1jZzALRNZ2Uw8nAGp+iqb40l3KKv1vEmtjfHbIieEeHCK8EYKfqHgITmSC7QNp
	Cdwf7fkUi8nSVw9Mk8WJbXBKcz07aXSUELsaRal3xkR5g4o5XEj5+DplRuvl5trbuMeghqvO66a
	A=
X-Gm-Gg: ASbGncsHx4cZ/jkf6/HbuOTJbthZH4Nx2lwuJxd4dsgncWbJI6kVKlj21fEiouNxjg/
	xT4kLNCLO692o8+HLhuhVbBr7kkRGJT9JGDtsoiRCFH0kVampaFxAb+lELlg9Nc9vx+OSn3AIBT
	QAdbZwrsFsjnxLLGTxMIvRxQ/OYP1AorSsOnJLaIuiIfanws+5LlpAegzTys8xS2DNXrs4TCjNH
	jn3SvSdLFLu7krpkY/5fQTzuMmlg32xK5JmKX/GLHciRp5aZWSBR4SbqfYyXieGTDlrHHuiLhyD
	EprJgzu2fbvsF4CewlXU2JoICMq0lgj8atQFeMuSDgx8X+TIjFlkstgirfWOxvc+kXorNttJ9vC
	tvcHy78ybUrbOyLpX1aw=
X-Received: by 2002:a05:6a00:2d26:b0:73e:2d7a:8fc0 with SMTP id d2e1a72fcca58-76034c0539amr1838059b3a.1.1753235100940;
        Tue, 22 Jul 2025 18:45:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGYQ1opZLOzPDGCAqEFY0P6TdbH57aOMcPK7+KLJXkJPeeEaYYghA2ozga4amB/i8nGEl0oEQ==
X-Received: by 2002:a05:6a00:2d26:b0:73e:2d7a:8fc0 with SMTP id d2e1a72fcca58-76034c0539amr1838035b3a.1.1753235100444;
        Tue, 22 Jul 2025 18:45:00 -0700 (PDT)
Received: from yuanjiey.ap.qualcomm.com (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-759c89d3190sm8382145b3a.39.2025.07.22.18.44.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jul 2025 18:45:00 -0700 (PDT)
Date: Wed, 23 Jul 2025 09:44:54 +0800
From: yuanjiey <yuanjie.yang@oss.qualcomm.com>
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: andersson@kernel.org, linus.walleij@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@oss.qualcomm.com,
        quic_tingweiz@quicinc.com, quic_yuanjiey@quicinc.com
Subject: Re: [PATCH] pinctrl: qcom: Fix logic error when TLMM reg-names
 property is missing
Message-ID: <aIA+lmqOMRtXTvsl@yuanjiey.ap.qualcomm.com>
References: <20250722054446.3432-1-yuanjie.yang@oss.qualcomm.com>
 <ximweq3tsedvocc2k2agl7gmckcvttsyiwcer4wjfenni7t62b@7bkvchfxm6a2>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ximweq3tsedvocc2k2agl7gmckcvttsyiwcer4wjfenni7t62b@7bkvchfxm6a2>
X-Authority-Analysis: v=2.4 cv=CZ4I5Krl c=1 sm=1 tr=0 ts=68803e9e cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=FHDt430NQJi3ZYAAoaoA:9
 a=CjuIK1q_8ugA:10 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-ORIG-GUID: rusyu2ZCOU6FSYEj5QKHeg8GnbyvbEh1
X-Proofpoint-GUID: rusyu2ZCOU6FSYEj5QKHeg8GnbyvbEh1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIzMDAxMyBTYWx0ZWRfX/ogdQmuA247I
 fS5majFBCCMO9y7ybX8oBaMzN5O/BCOjx4fVZt5aarl6rxJ6HlQUI/5MtbEkA2oVdDdcsBWAU4m
 ndceayMDEeDBgpRcuyVAKXTt750yA8D0tLePXV9NTSwvxkGBlB4Hduis31f7bhiw1Jz2teB2wZL
 PZh1+SPVmvUHXF5LkUxQ74hK+UJs0oJJxwkOENFXAxcTE/6Bze0UEHIQATUM0Er3Dg+dph914Fc
 aEumQOWveIzlGYN0Jo/d7Dn4Usm6r2TSfdWT+SJ/1lGOFSn8AXSOMj+L6Gpz6PxdwFR8g53PQYG
 HSjO7JyBGioI7K1Oz6dlL6QktagKAs6gybphidI2LHwRhSJPq3wNdgJWM2X6G6l34rutn5OGvhw
 YkhDvZaAL/utgOOyNC7cOc4RAl/M2XHnE1pA1IU0d2DYSJja3acDuunoQ8KDCZk2nH1LK6fB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-22_04,2025-07-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 mlxlogscore=999 impostorscore=0
 clxscore=1015 mlxscore=0 lowpriorityscore=0 phishscore=0 adultscore=0
 bulkscore=0 spamscore=0 malwarescore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507230013

On Tue, Jul 22, 2025 at 09:38:51AM +0300, Dmitry Baryshkov wrote:
> On Tue, Jul 22, 2025 at 01:44:46PM +0800, yuanjie yang wrote:
> > From: Yuanjie Yang <yuanjie.yang@oss.qualcomm.com>
> > 
> > Some Qualcomm platforms, such as sm8750.dtsi, define a single TLMM
> > region without the reg-names property. This is a valid and expected
> > configuration. However, the current code incorrectly treats the absence
> > of reg-names as an error, resulting in unintended behavior.
> > 
> > Refactoring the logic to handle both cases correctly:
> 
> s/Refactoring/Refactor/g

will update.
 
> > If only the gpio parameter is provided, default to TLMM region 0.
> > If both gpio and name are provided, compare the reg-names entries in the
> > TLMM node with the given name to select the appropriate region.
> > 
> > This ensures proper handling of platforms with either single or multiple
> > TLMM regions.
> 
> Drop this sentence.
will update.

> > 
> > Fixes: 56ffb63749f4 ("pinctrl: qcom: add multi TLMM region option parameter")
> > 
> > Signed-off-by: Yuanjie Yang <yuanjie.yang@oss.qualcomm.com>
> 
> No empty lines between the tags.
will update.

> > ---
> >  drivers/pinctrl/qcom/tlmm-test.c | 32 ++++++++++++++++----------------
> >  1 file changed, 16 insertions(+), 16 deletions(-)
> > 
> > diff --git a/drivers/pinctrl/qcom/tlmm-test.c b/drivers/pinctrl/qcom/tlmm-test.c
> > index 7d7fff538755..6de8cf23f9f0 100644
> > --- a/drivers/pinctrl/qcom/tlmm-test.c
> > +++ b/drivers/pinctrl/qcom/tlmm-test.c
> > @@ -581,25 +581,25 @@ static int tlmm_reg_base(struct device_node *tlmm, struct resource *res)
> >  	int ret;
> >  	int i;
> >  
> > -	count = of_property_count_strings(tlmm, "reg-names");
> > -	if (count <= 0) {
> > -		pr_err("failed to find tlmm reg name\n");
> > -		return count;
> > -	}
> > -
> > -	reg_names = kcalloc(count, sizeof(char *), GFP_KERNEL);
> > -	if (!reg_names)
> > -		return -ENOMEM;
> > -
> > -	ret = of_property_read_string_array(tlmm, "reg-names", reg_names, count);
> > -	if (ret != count) {
> > -		kfree(reg_names);
> > -		return -EINVAL;
> > -	}
> > -
> >  	if (!strcmp(tlmm_reg_name, "default_region")) {
> >  		ret = of_address_to_resource(tlmm, 0, res);
> 
> return here and remove braces around the else clause. It's strange that
> you didn't get the warning about calling kfree on the uninitialized
> variable.
Thanks, will remove braces and fix kfree issue.

> >  	} else {
> > +		count = of_property_count_strings(tlmm, "reg-names");
> > +		if (count <= 0) {
> > +			pr_err("failed to find tlmm reg name\n");
> > +			return -EINVAL;
> > +		}
> > +
> > +		reg_names = kcalloc(count, sizeof(char *), GFP_KERNEL);
> > +		if (!reg_names)
> > +			return -ENOMEM;
> > +
> > +		ret = of_property_read_string_array(tlmm, "reg-names", reg_names, count);
> > +		if (ret != count) {
> > +			kfree(reg_names);
> > +			return -EINVAL;
> > +		}
> > +
> >  		for (i = 0; i < count; i++) {
> >  			if (!strcmp(reg_names[i], tlmm_reg_name)) {
> >  				ret = of_address_to_resource(tlmm, i, res);
> > 
> > base-commit: d086c886ceb9f59dea6c3a9dae7eb89e780a20c9
> > -- 
> > 2.34.1
> > 
> 
> -- 
> With best wishes
> Dmitry

Thanks,
Yuanjie


