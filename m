Return-Path: <linux-kernel+bounces-753715-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A3F41B186D1
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 19:41:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0076E188DFF4
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 17:41:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C03A32701C5;
	Fri,  1 Aug 2025 17:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="LfM0ZBEY"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18542182D3
	for <linux-kernel@vger.kernel.org>; Fri,  1 Aug 2025 17:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754070070; cv=none; b=RUNZFcDa/AQn3LDv1xhXRbFsT3p/hdEXXTXKBtouKIsRAf134amp2GZIBv90Xdio1D8ZlOcg+hpaE8q3lYutlibKk0fpKR+5u/89AZ/DkEAIidsgYqEFJ610aCEQUZ45SC7qk/3pEL5CJHRH0s5Q+Pd/D/CcEXar9bHaqPcY2h8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754070070; c=relaxed/simple;
	bh=qX4/Gta/0qJljFewqm7g2+SbhR0hTNDOH4e1NugN41U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aTcvTBkMdghleh5tQ239w5K5FR7EjXITYiAOLMSTlE6TR4GFPsEBsPy2hxczStvgAbm/RR+Pq9UfjqY3FSK53YwD9s/1ZnM410i3qvEnsM+dVFHvDwNvfBB0kF5UYXjwJ7YP/cLG1Nq4lnsjWdWDp1Y6yfflP3jItQmwO+wNgD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=LfM0ZBEY; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5719HGJL018997
	for <linux-kernel@vger.kernel.org>; Fri, 1 Aug 2025 17:41:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=TAjqsWG+09WgcEob8VLyeHOX
	BEVCAsO//HB0wzN0Dsg=; b=LfM0ZBEY5sfySZKfIylbPz+OU21VVVPRZEKyqQlf
	c23LIfgNs2B3XFaRQybRDSFl3TDy9hceOqdA93nToXnbyL7gu1C+TIoXcnAZleLD
	iNJiQNnywFXMCuUOHGolIA/PYQPzHwp9hnWOJagCQtqCvoHXYf0Y7YGlMJsC200F
	bK7HB1bzVP8W1G6EcoS2S4vOuZirCLFT7pxbra2GauWaE8EScPhbUCV4wqWLGPpU
	kN0/EYcsp0KQT4cIcLwJtKFjKmgwpSMM0rBzw41pkPImjdhrXI2fyZVrCtwF+Ggq
	nMt8GWPs8/J6ZVGHI/LSO7krYgbJSLVVTF2bBnEkVDMYwA==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 487jwghars-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 01 Aug 2025 17:41:06 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4aeb486c46eso37336231cf.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 Aug 2025 10:41:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754070065; x=1754674865;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TAjqsWG+09WgcEob8VLyeHOXBEVCAsO//HB0wzN0Dsg=;
        b=v+cW9rsHJF06bY8oANRDix8Eop1/tQwBaCrlcLBZW24DVSSRKnE5tfANPzQjBo+OrV
         xfjQ/ELpYFUOrJg39veE5vIb59nf7XqLcQVHk1ya4+ziAAmrwuamsEageP6iihHWOnxa
         UZ8Fyp/Z3rMdtMi2sUNjrqMnT+4oM4BeUTDaJ47RNjgRvUaP96xl2soNAsEWOfK+8Pma
         UZ9zginSQV/EJNuSlnCKBSDorgvorjw3YTjGFZncA5GlkJx0IJucTO3Tkj9X2v+DGPIJ
         jwtaTL1Y22pvNZMLhWTN7fZdtrxTmIYbA4IPSwVv7fs7vUmWQ6ceO+9OhXGkJykAKIJy
         AvPA==
X-Forwarded-Encrypted: i=1; AJvYcCWGJ3vgjPfT6IRxw0TNGo0kez/CHLv6hcWr18TVgGFQm0+t240u35vuNX9D2mOJy/6QRtHXForc49EwU+A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUoRVn9i8tXa7cL+9BtVISCtJ3SWPSdCwO0Pm31uyH6SxV2uXb
	TqvPXgs+nnk3MMmieWvBT2eFQWlBBLH+yIUTuNtxVAtzCbJvZtVhOEbdMtuXRv3smP+ioEGF+Vq
	ylwb32f1JaIK2mohLsgPDun+ctJJS+d6jitX5Op0eU4BFqeSioWr5wPx5+OD49xtRkPE=
X-Gm-Gg: ASbGncvAWAyloDwsaeYUW456XWzhK4I5C44/5Vr+3unWZjT2NfjviXK4HAUKbMKht4m
	Ufs4+S6dSejnBzVyUaz3IpGq7/nP6bxA/TFZBytLDYLNCYpmaRbPRqC9W09EK+MgsfzTdGs5p4K
	L4AIStUJLEjLIhy6zDGmrPQF5tAYK1ujTLFePc/ltuocGejMrVR+BoVNlBEIjokt3j86GUM8OdS
	D2tljKyMBN4hyZ3DqnbiOIN3f/kRVR95zUL+a4J0DXo2lYAcCxORhLbLCMiV/NQtkGpS47EMMIz
	GnjNKkR5u7rIaJWnFLDgvQLmIfzyiKqSXybWRW6x7Dxy+o74eCPJzSj62lwCKDvDzNeu93E5phO
	EokN2vmrcQTzmu2xUWUP0pWt6buxPTahMHrw04qUUci7+GA/kJB9s
X-Received: by 2002:a05:622a:4cf:b0:4a9:c2e1:89c4 with SMTP id d75a77b69052e-4af10d11dbemr9816731cf.47.1754070064570;
        Fri, 01 Aug 2025 10:41:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH7Ab4B6jqYhlQ+NXunglR7CtdqDQ1rwdXyehj8v1lg2vJ1+icL9dUzr7rCyfChKa3r6LzegQ==
X-Received: by 2002:a05:622a:4cf:b0:4a9:c2e1:89c4 with SMTP id d75a77b69052e-4af10d11dbemr9816281cf.47.1754070063932;
        Fri, 01 Aug 2025 10:41:03 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-332382a6f74sm6639461fa.20.2025.08.01.10.41.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Aug 2025 10:41:03 -0700 (PDT)
Date: Fri, 1 Aug 2025 20:41:01 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Ayushi Makhija <quic_amakhija@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        robdclark@gmail.com, lumag@kernel.org, sean@poorly.run,
        marijn.suijten@somainline.org, airlied@gmail.com, simona@ffwll.ch,
        quic_rajeevny@quicinc.com, quic_vproddut@quicinc.com,
        quic_jesszhan@quicinc.com
Subject: Re: [PATCH] drm/msm: update the high bitfield of certain DSI
 registers
Message-ID: <e6bg2nin5zqoemjxevqhzhshgeit24t6wxb3pnfazrk6hkxajq@773bvnmqs5id>
References: <20250730123938.1038640-1-quic_amakhija@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250730123938.1038640-1-quic_amakhija@quicinc.com>
X-Authority-Analysis: v=2.4 cv=WvgrMcfv c=1 sm=1 tr=0 ts=688cfc32 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8 a=CjfMZ6mt8HIBDwBlgy4A:9
 a=CjuIK1q_8ugA:10 a=kacYvNCVWA4VmyqE58fU:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: 4w7ZfKMqM142B9kI3_s5btfK9OgwvCg_
X-Proofpoint-GUID: 4w7ZfKMqM142B9kI3_s5btfK9OgwvCg_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODAxMDEzNiBTYWx0ZWRfXz1CqUIxBI0qK
 ROL3mGCUWSa0iOCriqlDQcQ15NYt0S4AfwlYPRnbowQbSnyzFPipLHOzXtPw6IY8kNMNTgfQ7w7
 mojDiIzXroi0io55WECiGjpG6KoRFZU+BgCgUQS/UCvKQJR90bjEb1jqmTmEBBmkOJbmmEYFOuG
 Ja4qeATwo2F1NdFDWg5c4CpfztVkavo9ccTC1ppFJoJc+8JGpg/3TR+yHeuE1IRT5mranSbZLM/
 z7zJAXh9HvYiLke7s8MFOvHE9puT57fbd03hG2hhg0lWArb/fyPzeCMgsgcJCwZF9wJevu80+sd
 ALVPIoMFsoQQ6Tq7YOQeOiyYb9cz4/dhav4krJObusrWAgsIkhQ3CKLkZKvaeE4n/GnDM92M7SX
 OfVspjsPPT7jvS0kJEUVvDAvjnJe5d/gJ7tJkiRhR+C1HAKIYnDQlWTzq2m4Bvothk2zjgR+
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-01_06,2025-08-01_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 clxscore=1015 suspectscore=0 lowpriorityscore=0
 spamscore=0 mlxscore=0 impostorscore=0 adultscore=0 malwarescore=0
 priorityscore=1501 mlxlogscore=694 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2508010136

On Wed, Jul 30, 2025 at 06:09:38PM +0530, Ayushi Makhija wrote:
> Currently, the high bitfield of certain DSI registers
> do not align with the configuration of the SWI registers
> description. This can lead to wrong programming these DSI
> registers, for example for 4k resloution where H_TOTAL is
> taking 13 bits but software is programming only 12 bits
> because of the incorrect bitmask for H_TOTAL bitfeild,
> this is causing DSI FIFO errors. To resolve this issue,
> increase the high bitfield of the DSI registers from 12 bits
> to 16 bits in dsi.xml to match the SWI register configuration.
> 

Fixes: 4f52f5e63b62 ("drm/msm: import XML display registers database")

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

> Signed-off-by: Ayushi Makhija <quic_amakhija@quicinc.com>
> ---
>  drivers/gpu/drm/msm/registers/display/dsi.xml | 28 +++++++++----------
>  1 file changed, 14 insertions(+), 14 deletions(-)

-- 
With best wishes
Dmitry

