Return-Path: <linux-kernel+bounces-785223-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F3E4EB347C3
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 18:41:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D42441B2532C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 16:41:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD66A2F361C;
	Mon, 25 Aug 2025 16:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="akle5lkg"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C313130102A
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 16:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756140076; cv=none; b=fg3vJnxFWQDDLRNlwdda+s1cm2pv7kdS+178nUqzHxlEJ1Qz6p5HpCEYmXRP5RJwKQOBSalcaMNs6xcR7m/4WZH+5nXvP3FpW2HkyYNKS7Luw2sCvb6chb2wyUAk+H/LmhqkzJKYRQJpOCQiTfyRZy+OfHTMi2rC2qJ1FhWn0lM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756140076; c=relaxed/simple;
	bh=A+G8jnfgD2STlnRv2PWK1wsGbR5P93Q/wI0sDAxrh+M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tzS1ptu9MJuCG53EAT0PPID2vyIEnAYhILXiB8NjmLNJt/Kuf6z/1GusXlUBUxED5PzUdWLYVwqtDXLnW4gf0bS0rGS6xpaoFNWI9u55YzlPx0CxvI3hEZjHep85mqQOu3sXLc56xLMuucAl32+A8s6xyFiolfMH6ZYprx4yg10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=akle5lkg; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57PG812i028616
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 16:41:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=SUGCf9gEHaW+/RTV5UaZ+1IU
	xig0tsOVObr1R4RU2Ng=; b=akle5lkgTZUlRBiVnK9XxhwYCRubrlWxOlrEJ/mX
	OQ7/6CcPvMNaMI8YTkJ1CqXLfPgt3IPndshefkiw9uwn0ziYaYT+SldvtDd1cOUA
	9pacxNvbwstkKzSOynEBlLVXVCUH3U+XPhWYY3IKpWd7Isib7f/ns20AXDMlGjt4
	hyS2+6Eb5Xjm+9NwLXWTPxEObQO6nmyoyRiCQKjJhFhiNvkpwLAlYlCe/vDDi8Wx
	xzB3EJuUMRo1TvUah+6iIetAHIn5CqcwTlli/mdFlJaRrOG5hFhc+ddZZ4jxdfcA
	srQsgiZ35HgnYat8bQL6GUuR+yR2QOS4JNdbgbLRKnDY7A==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48q5wdwq2d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 16:41:12 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4b295536c25so86952791cf.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 09:41:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756140072; x=1756744872;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SUGCf9gEHaW+/RTV5UaZ+1IUxig0tsOVObr1R4RU2Ng=;
        b=BhMwTAgtd+LT7VrjqkZA4nZiPJqss0MWjf5GHiAgTut+61L6nWjWLrKIxfyGAnbBGU
         hPgs/kNoTsc7kZ8x3bdD9xsoveDDQwc2ruc/wNdDotnyNCS4dGEnEZOPx+/4mRolXV7e
         meSOL8nSBNr6qOEMefKoqrkLT9b0MMvy4x6x3yLdaQGiVlKuYnlbLJOvK6WXrGhXhgpR
         WJRgC11MMecPFhLDEDKz3qRpkWCdto6pP53UNBVb4O6ayXvIQJk9vvMasVGZfhHCVfOd
         VtaADiUc+fGAyBc9wNuBma62ZYeIInx+A8m/pCd99MnZHk03jYumjFq4M9NUl4DWwzEQ
         qV1Q==
X-Forwarded-Encrypted: i=1; AJvYcCWvZkdRn/8VB0Ee+uQnrDAygepE8A5aY/FhcUpQl5FGwDQAVXZ78Hkm7MkrQZ0OOKn/mNmhxoy90mbVMBw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSK7fbjewGRAGOP1bQpTrqJ68lu1fXFofS4rhSSxNk2BFuqaEh
	ZSCdi6iG8Jjjdax8p3T1SIXSxrETSQlsREGfsRfX4l2Gg+F7Yry0TVZsSyq2MuwRs82bUBSSS8Y
	T072x9Lhz1U3h324bos7LtfOpxscF4UtBHD2KlM4i9h/gaQeooK6cShuzi2q9fyMc3Ec=
X-Gm-Gg: ASbGnctXibHZVHLc267bxqqZfeceHR/ydBoFkN/rUkPr1Mw5OkSizONIbWK4QTvS8sX
	fdbbnY0BLFlXlhEify+R2qQpFSFLLj15PlujZ+AGb2ifXpyBHrTVp4c81Sz6Es3EsMwvu5bS5dX
	srj11udP1LdB5mMsqFVSZ8nmTvWrsb85r22iFGn3yntcYj2Zdb9iFvfkjzCjMz/ayWO/Kr/kl+J
	+YOmd1gYS7KCbqmTM0FrNwBuGdNhkkl4vbFwn7QrT9z8Xy/febGxO/RWsN8Nwq+nXLggB7Gg5pB
	GAHoWT9qFfp44/IG5qcET15IPNdrrVgBptvF1w8A9Xy7OEVX2Op+c1VjxH9k/rSAOW1qf2qJs2n
	m96SXTQqEib1HV5+k9Z8uRWfm1ubaRdeA77O0HK8S8VUkW91iC8lB
X-Received: by 2002:ac8:5905:0:b0:4b2:8ac4:ef56 with SMTP id d75a77b69052e-4b2aab43ab8mr130527821cf.77.1756140071858;
        Mon, 25 Aug 2025 09:41:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHoqs6K3ZpqTkzcj7pYumPFvNMUPXYlClvXN3ij8BDNr9VUaeeMGuXTmsI96ga3TCHPX3H3WA==
X-Received: by 2002:ac8:5905:0:b0:4b2:8ac4:ef56 with SMTP id d75a77b69052e-4b2aab43ab8mr130527481cf.77.1756140071290;
        Mon, 25 Aug 2025 09:41:11 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55f35c0221dsm1672404e87.7.2025.08.25.09.41.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 09:41:10 -0700 (PDT)
Date: Mon, 25 Aug 2025 19:41:08 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 01/38] drm/msm/dp: remove cached drm_edid from panel
Message-ID: <otmy4kttxflsxkvacwdsqynck4nqeww7jsxaq2xwjtlooxnhvx@gmpezdliskck>
References: <20250825-msm-dp-mst-v3-0-01faacfcdedd@oss.qualcomm.com>
 <20250825-msm-dp-mst-v3-1-01faacfcdedd@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250825-msm-dp-mst-v3-1-01faacfcdedd@oss.qualcomm.com>
X-Proofpoint-GUID: 8oUqvKpiuyZRLu9W8UbfqjXyTHU6jLid
X-Proofpoint-ORIG-GUID: 8oUqvKpiuyZRLu9W8UbfqjXyTHU6jLid
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAzMyBTYWx0ZWRfXw5ls+zXGCnvN
 ZzPoXD6Xr1vpDygnvkyQSobJWmWYpf+c5bMaWpSz0h487Sh7oCOgOzeKDGicxLPe5T4hKoN3l1H
 yVUGFUjfzI/G1seumCEHLJAWDjwTPcHGB9Pfl8NEpheRPrfVYA45tyXYKUYYZzvRgd9P/2S6/hr
 75WJafdMl9bpFYgv44pM+wYAP02vbrjSPxFRXUowa/5/CkERBFLIRxxbjoVcG3al3+shRx+droW
 UFn7exKSu+1r+kHqXuKtHoEq4mm2flhuO/KTUI/1hCclBUTFxru0t562IdAeHEiBgBF//SCSbtD
 GpnbRvjKsSbL1LaEEMmHHgcrrJFaCNqFmkiJDiNWGekw4l7tE69ViRCzn9AbuRCzBuHN0yz1tIl
 PeN9zqOZ
X-Authority-Analysis: v=2.4 cv=BJazrEQG c=1 sm=1 tr=0 ts=68ac9228 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=Xi5Nwd9LVAJm5hmD8FAA:9 a=CjuIK1q_8ugA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-25_08,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 priorityscore=1501 clxscore=1015 impostorscore=0
 bulkscore=0 phishscore=0 suspectscore=0 spamscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508230033

On Mon, Aug 25, 2025 at 10:15:47PM +0800, Yongxing Mou wrote:
> The cached drm_edid in msm_dp_panel was redundant and led to unnecessary
> state management complexity. This change removes the drm_edid member from

Please see Documentation/process/submitting-patches.rst on how to write
commit messages. Please use imperative language instead of describing
the changes.

THe patch LGTM.

> the panel structure and refactors related functions to use locally read
> EDID data instead.
> 
> - Replaces msm_dp_panel_read_sink_caps() with msm_dp_panel_read_link_caps()
> - Updates msm_dp_panel_handle_sink_request() to accept drm_edid as input
> - Removes msm_dp_panel_get_modes() and drm_edid caching logic
> - Cleans up unused drm_edid_free() calls
> 
> This simplifies EDID handling and avoids stale data issues.
> 
> Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
> ---
>  drivers/gpu/drm/msm/dp/dp_display.c | 28 +++++++++++++++-------
>  drivers/gpu/drm/msm/dp/dp_panel.c   | 47 ++++---------------------------------
>  drivers/gpu/drm/msm/dp/dp_panel.h   |  9 +++----
>  3 files changed, 26 insertions(+), 58 deletions(-)
> 

-- 
With best wishes
Dmitry

