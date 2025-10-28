Return-Path: <linux-kernel+bounces-874756-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BD26C17088
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 22:35:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A733189159A
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 21:31:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA95B350D4C;
	Tue, 28 Oct 2025 21:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="d76T49Lb";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="eHSLx5yc"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7143D350D7A
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 21:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761686833; cv=none; b=fb/d9BZHhq0s0yDAYIcaDbSzJpE0z6/HlZtF2kEoKLhAEBxVRwp/kYoeQTqyZr659CbZXLPGUahZUDA6QOu1OWPeOvHeCCA0nyLCHuw5KzY74QJ6siC9WUiWznSg6HX3WB4fPfUELucCnKOoCK8DNp6oX1nfAH4eZY/K/A27Z68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761686833; c=relaxed/simple;
	bh=p1DTnB/Qq1JuQuJ0RZYh9WyxTwwLG4s8EMgB71qlhYI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ene4fE6oENJPn8opWZK9KHJfT4UlSDtL7rHodCQ6Seu2I7UM2lViou7jqcuUzfZmdUoOeg6eMpj3VIs50qYnFbRBlHQPgIx0uxOKLl9QGzYEfZDNwBnT4bnZFIylfpO2r4kwuqjcuXlIdvZBZj6u/BQwV6Uo/qUlwnieBdP0yR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=d76T49Lb; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=eHSLx5yc; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59SJlxrg2623272
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 21:27:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=DdP5TbkC149GA0FALd9E/e3/
	ojBpNA/aYkFJbl++16A=; b=d76T49LbrMTmJhm9EVksq+X3aJ8sP19kIwpRgBbk
	BB0EtVFUF1z0BGTOsp5l0S4eMyBwJ/IHUxuqAMrxyyzuy5eKrIT6FAgLuf6PGaDm
	uL82HuKSZnhWArjRbvU9OSaBUpAFs/5hn1smQ4tVEbdXeeo3/cu4tFjkOC1AlfpC
	coIehlmHJ45V/xeR8upzSgKrn3nrvDUx29oYfDLRxJCrBtq+8uZdqiC5JD1RSrcX
	XiPttyFU/hIQurwPgePCEXZcHbDOIpNW0iri56JwHAyj+dx58ZdyDI+Q0IC5K4qZ
	zrrgT6GQihp4y51FBoBtE4SwfSFnOuaNcEJHEm4QiNu45A==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a34a107kg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 21:27:09 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4ecf8faf8bdso136227291cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 14:27:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1761686828; x=1762291628; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DdP5TbkC149GA0FALd9E/e3/ojBpNA/aYkFJbl++16A=;
        b=eHSLx5ycYQtZCmn04pfRrr4fLYuvmi2vVLSpnmTu3+zrrF8HvkDfI/x8ekl6+gjF7r
         RTMxcZPcQCDk7vSO0OPMOWkeMYpaeb+CN9wtK1895WvZN9ryiUa6HICAJfQtSfIccjII
         6G/xpGYMOBA/35l4lPigeW3EB0blisdJXlxksTIlpLuqiG0UCzRxL9nwO+tyeJN5tGbr
         +9x4jloH0cBOeYds/v5AsME3ctIiDQ2aNnhXldTj8f/1nCxXOVEUj3inK2KF1SUEI+cY
         R1O7s/QzpsWg2C1LzqEhDdMf90ICq5fjQnDzzfEr/qRbrTWMf6tzuNOaRzaTt6qHIF4y
         Q10g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761686828; x=1762291628;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DdP5TbkC149GA0FALd9E/e3/ojBpNA/aYkFJbl++16A=;
        b=Z4vGJlI9pk8KYO8zdN0W5bJhTGNKqLqXvZZs6aj9zAyUA/CXNDXSQdUCnNjNkoHCwB
         gICVW/8bWSwtowXMyRUGFdBabzWkb3kzowLz2gO55ndvNmwhnREkRtUC9bzWPyXtwi6b
         2BdKWb7cRbFquEtVj4tRbgK6ixhoFG9SVE7oaJcIt30hU7MhMzSBa/0/+qMgtyQh8t28
         0+rlScua5VT7OJk2dQF3HuZN1qTxZjg4unI55wReZe4ONMGdD1JEbiWaYlEgLuBs3osE
         4oNjx0kHsTvpZ4anz4CTHY0aC3+TwpFD7S5y6vFPwkl0Z8sPtXgO+DxkD0lm+mTGiA8D
         jDyA==
X-Forwarded-Encrypted: i=1; AJvYcCXwuPdhugborbijVCfaMcpfR9vekfJlgl5FV+/HbUP1exb34u0wF4cjkcMCKkt6zt4YvUlmXeGDJ8pY5UI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQlwcB+dYdEMQY6eo0WPUI7pcX6cEpo6sNKvenw9pFR+uaZ7cf
	Tu/C+ZM519JRuOsHM3QRZIv57HBALplKAXJIQRsLtlwvGeBDF2WI+zedOtXqFTXx0DN9GZ4VdFY
	Z0ebEgkcisudsKteF9bq5nwF+QeE7seROMn9fh2MU2eh6c9K2PLPLazt6S/07OWUcikE=
X-Gm-Gg: ASbGnct/sq8u3LqpW+18zd19u0MnUzRkRaGNLJILXMlJC6iwu8dfN5cpN3X6CuuEdPJ
	HvieRssBRtx3eh4QvtH/84VaaSBSRiex2i7zyjYxKUpvPTF4tNZb/h+Uav7PGNWqYkWKoDXPLwN
	10B2ZQA1KMNcZTKyaOmhXMnncTQyFKUBLQK+QTnTVun5BD1Q1WnyPrbp3jZdAk/XdvbH20CV+nX
	S282jhU1CV4777bdTQaVvFevIwjfi/UYLZC4VjW+1+nz+GOAjvZ9MgueXKTmDYYwiImG6XYKUEN
	fMa1ZusH4eo/re4x3vBjpZVnGpjzWETx07LzbjKkaGF8Z/vEzAGWupqwhTLcEvotC+SVecvBAJj
	eGJu/lWJWhzWOJlk76sN9y7MSP0/I7KfLIO2JxHUSmrUc7OCfEU4mfOUYcbyWOSrq+LfGsG7Tzb
	+YjyTgUXEY5k7W
X-Received: by 2002:ac8:5e13:0:b0:4b3:3b2:2b4b with SMTP id d75a77b69052e-4ed15a23867mr9720671cf.0.1761686828546;
        Tue, 28 Oct 2025 14:27:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFdxR98KH4P1HlcjcBcumSx72Dky53bKX5MRwlk/e4bOdqpkMOYKmt8VJoGyRxf3ikIXyDRIA==
X-Received: by 2002:ac8:5e13:0:b0:4b3:3b2:2b4b with SMTP id d75a77b69052e-4ed15a23867mr9720451cf.0.1761686828124;
        Tue, 28 Oct 2025 14:27:08 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59301f41c3csm3332734e87.15.2025.10.28.14.27.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Oct 2025 14:27:07 -0700 (PDT)
Date: Tue, 28 Oct 2025 23:27:05 +0200
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
Subject: Re: [PATCH 6/6] drm/msm/dpu: Disable broken YUV on QSEED2 hardware
Message-ID: <jbf52sfh7vpefhla3vonerfu7jyvja3erlpf6qgq6pa4htxtrp@7qxlchr2phyc>
References: <20251017-b4-dpu-fixes-v1-0-40ce5993eeb6@gmail.com>
 <20251018-b4-dpu-fixes-v1-6-1852278064d0@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251018-b4-dpu-fixes-v1-6-1852278064d0@gmail.com>
X-Proofpoint-GUID: Rz-uu5n8HQUuD97DbER7IxFLNpNcwSSt
X-Proofpoint-ORIG-GUID: Rz-uu5n8HQUuD97DbER7IxFLNpNcwSSt
X-Authority-Analysis: v=2.4 cv=A5dh/qWG c=1 sm=1 tr=0 ts=6901352d cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=pGLkceISAAAA:8 a=kAP0dVoXV5zkFeC1rmcA:9 a=CjuIK1q_8ugA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI4MDE4MCBTYWx0ZWRfX6Ga7GdQduiVf
 +oh+W9W6fYeulF2DkDnHdYlkc5vVBpz9uPpKbML9kIqREw9OwxxrFs1Ppih8ChpAfSInuvNpW7o
 6SU9j1+VqjQhUsHSg12aiqWo1CcADA6n3vhdB5c2dGZAAAkvZgFBSNdTod4QhgmYeKP6de7uG0h
 GEXDTGms6kuGsnhchVaTL5TtSTR/YL6lccI07RYf2xPaGjk58jAUXWzq8XxSfw7YQKso9kaTsEP
 EabJ+KfiP12cd2sadowLYYi+uMmi+qJ2dByiOAcOAQMSI/Zda8TVTV4Qg5Vu6ltIgeUGWeR4UdY
 Tb2O+Qp2WNW1mPHYVapNGEYk8SReR/yYiY1fWmR/xvwJ3h5p+iEund+/VLyYxrYwtT3esK2XvmI
 aXKapIhclh+qlttZXRkRzKoenJCbiQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-28_08,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 spamscore=0 bulkscore=0 impostorscore=0
 clxscore=1015 malwarescore=0 adultscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2510280180

On Sat, Oct 18, 2025 at 02:33:43PM +0000, Vladimir Lypak wrote:
> YUV formats on this hardware needs scaling for chroma planes. However it
> is not implemented for QSEED2 which breaks display pipeline if YUV format
> is used (causing partial and corrupted output with PPDONE timeouts).
> This patch temporarily disables YUV by switching affected sub-block to
> RGB only format list.
> 
> Fixes: daf9a92daeb8 ("drm/msm/dpu: Add support for MSM8996")
> Signed-off-by: Vladimir Lypak <vladimir.lypak@gmail.com>
> ---
>  drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 

Does it apply to all QSEED2 platforms or just some of them?

-- 
With best wishes
Dmitry

