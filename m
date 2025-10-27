Return-Path: <linux-kernel+bounces-871689-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54389C0E176
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 14:38:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D5C03BF43E
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 13:32:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29BD51E3DE5;
	Mon, 27 Oct 2025 13:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YpQxaR9N"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 006632101AE
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 13:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761571852; cv=none; b=Mubmom0XU1cgtUl4jFO23dd4r12pex/dif0diDTrY5mWcznkrRy6VXrbDpLeFfpuW8I0ClD2HoJLsvLJg1BWXcyAURm6Ld1NhgvbYY5tzdRFVHLfK8HjNa1f0xkdBSr9jISs+zCoLLXwEVdouofy1n7YQOZ4+U730nlQsSdxMRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761571852; c=relaxed/simple;
	bh=0+NW3qoSqIVkjd8t21tsQbDlCJTokrAnzATLDXILBz4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uS/YDrSFtcenEU0TRkdzxL3MKh2EXUkBZxieb1ilcxANHqkqVw/zvg/cEA9+ssilxW58xLfFSmvgThjI0pMAa0Ffh5Q8O5aKcHg1Tj0YHhK6z1gU3groulC6OY6gGh3qtpR46GbdQyYSrh+AU+DAPiwtLR3I/LQIjClZ7jJGies=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YpQxaR9N; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59R9kPTt1503208
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 13:30:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=VuMvAMd2Yn5uPAiVWdHf+qc3
	ZLlZWtjBdo/nxvtzJAA=; b=YpQxaR9NbkuVebTOxqLZOKApJ8xkEoYp/PY3AysS
	RJuRsULcLLPC70w1zr29miA5OJze9zBxX2T53Ayx/QErjy2BFl9qK5jJmgOdRI00
	rxUbNn4VGB50UexWm3YXEE7JqQJUwlD+iK32YOlh3xexsqpJQTpQ8SJdACw/SlNU
	qFOtCSKe3p0wf6T68HNljU86vrqd0204RCMg+5EDVm/QmkHv7s83BPxGwB1UU+ek
	pmu1zlIKtXiR/icB+rltZMLYZd39pQ3kDXQe6hkpvNRQhkhfrLjX2pxBFHLzp6lC
	6kwAq72L6rmLSENFaVfgz2Jxb2+cajhz36Mi/BQzV0eT7g==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a20pnsmx2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 13:30:49 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4eb9e480c15so46461251cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 06:30:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761571849; x=1762176649;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VuMvAMd2Yn5uPAiVWdHf+qc3ZLlZWtjBdo/nxvtzJAA=;
        b=XZoAWhHUkXCoexJ6VE2ctDqLKsaTS7iLje8rlmQ6zdH7uGpgmvDpKaXjvNteUJfGGZ
         EBoPtUpdtztC4eIhjFXiDdZoF5eOxi/LLK19RAt9bVSjEOihjCh7EcPocn/0nAgZ6myc
         V7VtMWNxOP2S81bfOo1r/1j34ybCsq8DBEvlENB/xaMBrYiy7zeHryfYEKVnCU92MmaE
         W08CestnWweppKlR/YmKpNWdMJivZQBax5OXHPxNfh6nsXDb9G6Zs/graIXTAilP9qhK
         zqR5Jn6JBNhaNoqHC6AlNVCqnCMU0LBMevc0Z8ogpcDfm0XQsay35lZdELpF/J78iTRj
         v3jw==
X-Forwarded-Encrypted: i=1; AJvYcCUA5PDrABV0nOVqqxiQyti9pr9+q1RoNWtfA6O6lrRuoXbwurjcLs8p1motSCL5JkdlccvsdDS7xt8hfUc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxuWudcWKp4FeJlj1K+BUd1X4Y5wdnxMnmNxl5pSvS09ysEtDv6
	R4Ks4RCb6AVgbTkq8UZ3BaWNrvsskaDQ5k1rZ+mml8pdURvucZ35z9P9pLFDryveRBspS7cABwc
	GLzUJ+fKVGjtP1mg9KRjnzT9zD/ry+1zUV74Eka2fdaDVTxQbF+0MPJaVplaY5cAzv6U=
X-Gm-Gg: ASbGnctP9aVeIdkSVwO+5n7ti0KbTnTKUjGBL3n86iMNDW2ypE7CcW0wvqpjhoC3qGX
	qkecR5IBL5FHJq/uxyiaby5Fbfg8dVSPWn7fpJJTus8VP34t9U1dpJldF+UGyfu7HDNpZfAfqm9
	KH/s42gvJyD39xSOe9A8I311BQMQUlXTrhyur81ck1us8nrM4syZIXOHiHWozRbDhDAzSih86BF
	Wyc/AlYtWiYWsRuxyRuRLuIKOTlMnkvegOL482XjTMGCaV4gRjoqQRDzPrC4pYI8UAOMEVcpII3
	JukBwN3kgim6dGbcHyfLGKeF8lBC2otqGWuIagA7RxrhTc7G4kS/o2ThrOykwxDacGw1LNfwQX3
	1pqQdmGWHE9s8hAHatGEeZuoBmpYN0Q/RJeynm74/U/YIhYzHjRJTp5/N5O2fYkPsOBxUXabClr
	uQ0lB6pZZMHknc
X-Received: by 2002:a05:622a:4c8:b0:4e8:b88a:c6d7 with SMTP id d75a77b69052e-4e8b88aca6dmr348436061cf.17.1761571847853;
        Mon, 27 Oct 2025 06:30:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFxmrtPppf/+owHCkx0AjMgN9OBqs2zLqs2+SSWeaytTVGUaHm8qCALLSko1kZT3wz56Y32Sg==
X-Received: by 2002:a05:622a:4c8:b0:4e8:b88a:c6d7 with SMTP id d75a77b69052e-4e8b88aca6dmr348433731cf.17.1761571845947;
        Mon, 27 Oct 2025 06:30:45 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59301f7444bsm2344459e87.85.2025.10.27.06.30.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 06:30:45 -0700 (PDT)
Date: Mon, 27 Oct 2025 15:30:43 +0200
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
Subject: Re: [PATCH 10/12] dt-bindings: display/msm: dsi-phy-7nm: Add
 Kaanapali DSi PHY
Message-ID: <2pyurzgalnjwsxqw7qhfguebps45ne6iua7gvioagz554ra6ru@nhe4tnmabqp2>
References: <20251023075401.1148-1-yuanjie.yang@oss.qualcomm.com>
 <20251023080609.1212-1-yuanjie.yang@oss.qualcomm.com>
 <20251023080609.1212-5-yuanjie.yang@oss.qualcomm.com>
 <em666johhzrluo5z4t2nu5jo4yuowegaemlrursvczx2zze5o5@uakt5j22ygwm>
 <aPsYVUjyPru5FwPe@yuanjiey.ap.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aPsYVUjyPru5FwPe@yuanjiey.ap.qualcomm.com>
X-Proofpoint-GUID: yLgp09HAVjo88G5TlSNrE0R4YBqZ5x-_
X-Proofpoint-ORIG-GUID: yLgp09HAVjo88G5TlSNrE0R4YBqZ5x-_
X-Authority-Analysis: v=2.4 cv=A+xh/qWG c=1 sm=1 tr=0 ts=68ff7409 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8
 a=dXhcXtSbZMlcZ2ZPzDcA:9 a=CjuIK1q_8ugA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI3MDEyNSBTYWx0ZWRfXz1eQB5gFKK3Z
 B9WtQVS+9zkLS5EIb8zsB9vXVud/i9DtL6jHIU6Fa1Y8ZcISgch0lG9IJ+nk5RV0UFeGKI0P5dY
 kuB+CPjVFpqj41VkD6/ca4f/xsS90n/PC7v+rKxXfwsAFxbAy6bJkIJLLzu3TEm/7MHSVF7/zee
 tf+Mcra883kmLzO5XtKiSs1bAswzgcZlhv23IZLIZtzQRn4X9A3S/pKeaukZItbU3Usixuvs4Jq
 l5BM+1puDlFsr1No0f0EeZXo520Cl0wKajynN7C3mNILMPLybSyUs4knZ1rzFyAWJKCDacYFyOs
 lceHXChJ1VK6QOmmO+j77+673kpClWsxAGVz3yvgYLcAvlBIcD8x6oMx/MBFMfZa7qVI25HLwhK
 eu0K6IoIrm/bhfNzknRV0aaUtS/31g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-27_05,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 clxscore=1015 suspectscore=0
 spamscore=0 bulkscore=0 adultscore=0 impostorscore=0 phishscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510020000
 definitions=main-2510270125

On Fri, Oct 24, 2025 at 02:10:29PM +0800, yuanjiey wrote:
> On Thu, Oct 23, 2025 at 03:16:31PM +0300, Dmitry Baryshkov wrote:
> > On Thu, Oct 23, 2025 at 04:06:07PM +0800, yuanjie yang wrote:
> > > From: Yuanjie Yang <yuanjie.yang@oss.qualcomm.com>
> > 
> > In the subject: DSI, not DSi
> OK will note.
> 
>  
> > > 
> > > Add DSI PHY for Kaanapali.
> > 
> > Why?
> 
> DSI phy for Kaanapali have no significant diiference with previous version(SM8750).
> But some register change make it imcompatible with previous version(SM8750).

It's either "no significant difference" or "register change make it
incompatible". You can't say both.

> 
> I will give this reason in my next patch.
> 
> Thanks
> Yuanjie.
> 

-- 
With best wishes
Dmitry

