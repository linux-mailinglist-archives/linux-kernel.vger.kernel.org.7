Return-Path: <linux-kernel+bounces-771504-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0F16B28825
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 00:03:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B8E65E275C
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 22:03:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFA2F222562;
	Fri, 15 Aug 2025 22:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="aZ8Ww0UH"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A808528399
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 22:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755295407; cv=none; b=OsB1SuVKmX86R8D4PJ34o5ptO2lbYOa0Rnrk4GtWXXQUacPZai2b8WS3W/h1JCKFOCHzCdBtMgn4/d5m4vGNOggWXeTSfhMia+D0TFZSlfOoRbVBUIzspxXD70Dy7XwzSX9ftFWPNKdGZ50bgcDsWgqa/sMBV0ZXHDXw3jKuRb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755295407; c=relaxed/simple;
	bh=nQkHdDW9KfDS3+GPCTkk9jnGBJIoRWBUyMce7zVrsKA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T2hZy9LwxNgbdhJFsT4ROdQXUhh0bhHjzFHFBz36au7yyqJxAs+5/g0VoKB5IeVK+wBC5HThkS5YrsvdkEN5u+Ss4pVMIv7DLSbzcmgO1gzoeFiSIX8I0IsOYGQ5PkQLISh7IOB6x00avrB69LVRfz/91yzTOd1AoSCoHTXfNH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=aZ8Ww0UH; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57FELfM6026633
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 22:03:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	JNM2ahG1ABS4L192+NMT+YV+CWUqiXZwpX5AXo7uFao=; b=aZ8Ww0UHeoHWKCza
	rfzcK/SdIaB+coyxqBItNSKHt+BIYXKsNsZEti4KW0wk6GHqUutX6KM6rFtkh/P3
	A8/esj3yZdnhvC6G+WdxVLZNbnElAlrISeCFTk52PthIpn2FUS23nfkUTDXyTmPx
	9VWN9sybVjEC+9njFMieO6OZS/DOTkgFfRei+VgML9TmzMg1T429Atay0Xcbf15H
	PrO+N9hl9dGIJn/kIDfdwQsGxqVT64soYMs9pdwrLgeixjOYp0qRvvAgpQzAt9wk
	UGC827IJkANRcLmTt25Ccpzc5uMLDqSbDgudHCXmf3xSNSfWPYA6I3Z+lht60vsi
	OyxT5A==
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com [209.85.222.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48g5hmm8ax-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 22:03:24 +0000 (GMT)
Received: by mail-ua1-f72.google.com with SMTP id a1e0cc1a2514c-890190c6f0dso3899076241.2
        for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 15:03:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755295404; x=1755900204;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JNM2ahG1ABS4L192+NMT+YV+CWUqiXZwpX5AXo7uFao=;
        b=HY5Zm85FuDNnxDuDYNithubIr9ObJkTxrMEiN7VykTmgjxRyST99vI7yEqG497TwwR
         6KqBZn33VbqH/xTLqdD5WjOnel2+VvP6z4R/ZXuM36V5Paj+5gR7+Zz70nhTb5yIUK4V
         NYIZomgrIZI0z/4wxE2VCZGR70yygZPJ7K+xBpBG6dQV0pe2BJfvK30aPrZWP5P5KWQx
         ZBvugeFjJAXGFPqgwtUopl1XqGqx7dXC9HZt8ofkogQbe0bPTQOBbTRutLBVoQIObyfr
         QOHr+vLPf+pQ1DFPndjTMU3sB07yYV6C5U4OU/tCutxmZcjbbaEY2fZRZsDNzkbj0Khu
         kL+w==
X-Forwarded-Encrypted: i=1; AJvYcCVuZb7J0Ki0VUNs0ebI3uRLd+6OGl+CCn/bzDxYmWlSw6AAkoW2wNIA5uPVooI8Z/gRIqlWofUMQ/wQKiM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTfYBsxdTJZSrCAuTEBJgMGJvCSvEonxVQRU8exGOpz5qiLSZx
	drig5mpE2KFAqFRsD0TCgxlAwE4LofiN5asIHfXlQhmUgaLL2Q5AM5+e6hA2noZkDSMAiGVvShJ
	uNCXMefMgpPMu9QHlifPoiPofF8/qK+T35auBqQyjEEf+eviJdGJNNrFO4eGsdPIqokQ=
X-Gm-Gg: ASbGncs4UEfqOrzrN7QOLppfrdRurKpZOt/Blvk2XMwu31vEi4gynDWvH9AXMaDbZha
	CxyFK5AYs00lLCLAgI0MdVM/fJ+ahH6LwQugB1VwRrw3o3TpSRzJ8Jv4apRjfn1NF/4iUOZboRd
	Nolz1YJSpLTPVGyXOH7zoTWn9IE3zRk4zDg31OpszccykEpCsto9eBd3qBa6Fu342sVad7i7+1u
	CKFJSS2gzeKa5T6Hrt/QudMWbpKAM2coukqWkyss7RdSBYgj3QLcPghYLYqnqZF3P4OwslEUi6Z
	rgMd0Cx6EbgPtvi8G0FPeorAWUFklkdek+IW04qYFb3d3phPyx+QRxJ5RXEWJ659LATI9wG+ikH
	jR9MVwY1Bf47Kvv4jmPlte7aimye6AWPHbYgViyNnwOVLecq6BkOy
X-Received: by 2002:a05:6102:5114:b0:4e7:7146:a9e with SMTP id ada2fe7eead31-5126ab2ee2fmr1537414137.6.1755295403719;
        Fri, 15 Aug 2025 15:03:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHPgdle96VSE3B52v51lbV5p87cOgzaz0zms6MwnH/nHTPEsUDfOL5fTX136xoJjksYefpN9g==
X-Received: by 2002:a05:6102:5114:b0:4e7:7146:a9e with SMTP id ada2fe7eead31-5126ab2ee2fmr1537378137.6.1755295403274;
        Fri, 15 Aug 2025 15:03:23 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55cef367728sm507900e87.56.2025.08.15.15.03.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Aug 2025 15:03:22 -0700 (PDT)
Date: Sat, 16 Aug 2025 01:03:20 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Eric =?utf-8?Q?Gon=C3=A7alves?= <ghatto404@gmail.com>
Cc: andersson@kernel.org, konradybcio@kernel.org, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/2] arm64: dts: qcom: add initial support for Samsung
 Galaxy S20 FE
Message-ID: <xmxo5uogkexiwq5zh2eza53pnl5jrqidd7an7bftjtq4wpaup5@mlekuufdbg5v>
References: <20250815151426.32023-1-ghatto404@gmail.com>
 <20250815151426.32023-3-ghatto404@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250815151426.32023-3-ghatto404@gmail.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODEyMDExOSBTYWx0ZWRfX5pN8/BabdJUe
 pQdJ2QbFCXAV27wet8+dNbXNQkbrPumg60+JNlmhVlJ26ytB+jMKrLKLYxbHHRCPLdjCAlTj3ZB
 DX2eZkOEEOK4f24PtWvxe1DKtDWlqyhSLTTsjstmg414+mPKFP7hOYhNcbrIOY+2p3NZTKLg8W1
 60LwpX0709fih+nyoL5OOmf0Vmf2DI7cPgj9l7M/iDZnrFu9rKHOYFVmv0HVNWiwckvgSlSX7L4
 zLvhNwhH9zCZ44iWlOBS9QhvXHC7YoOUlhGkfrIu2gUGIrsUTwYzo8kREbuw3biEtPO6nxvU/vJ
 bpZU/RHWcYcwiyJE2fiK+Vf+Gle6o1SfUM7+vntORYW1NwGfL/K4fUW54SCIHCxf+G3FjmELB18
 /qFqc3M2
X-Proofpoint-GUID: rqS_RXL-5oPOChFut6FEoym5egDKP3jv
X-Proofpoint-ORIG-GUID: rqS_RXL-5oPOChFut6FEoym5egDKP3jv
X-Authority-Analysis: v=2.4 cv=d4b1yQjE c=1 sm=1 tr=0 ts=689faeac cx=c_pps
 a=ULNsgckmlI/WJG3HAyAuOQ==:117 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=2OwXVqhp2XgA:10 a=pGLkceISAAAA:8 a=72Elj11P4sURrl_B_tIA:9 a=3ZKOabzyN94A:10
 a=wPNLvfGTeEIA:10 a=1WsBpfsz9X-RYQiigVTh:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-15_08,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 spamscore=0 phishscore=0 adultscore=0
 bulkscore=0 priorityscore=1501 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508120119

On Fri, Aug 15, 2025 at 03:14:26PM +0000, Eric Gonçalves wrote:
> Add new device support for the Samsung Galaxy S20 FE 4G/5G
>  (SM-G980/SM-G981B) phone
> 
> What works:
> - SimpleFB
> - Pstore/ramoops

While the patch is correct, are there any obstacles in enabling more
devices on the phone? I'd say, buttons, remoteprocs, PCI and USB
peripherals should be low hanging fruits. If you can read pmic_array
from debugfs/qcom_socinfo, then you should be able to identify PMICs and
add corresponding regulators too.

> Signed-off-by: Eric Gonçalves <ghatto404@gmail.com>
> ---
>  arch/arm64/boot/dts/qcom/Makefile             |  1 +
>  .../boot/dts/qcom/sm8250-samsung-r8q.dts      | 47 +++++++++++++++++++
>  2 files changed, 48 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/qcom/sm8250-samsung-r8q.dts

-- 
With best wishes
Dmitry

