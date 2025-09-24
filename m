Return-Path: <linux-kernel+bounces-831159-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BC38B9BBA7
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 21:35:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A41F175BE8
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 19:35:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 651BC26FD8E;
	Wed, 24 Sep 2025 19:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="IeD45TIx"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E812255F24
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 19:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758742510; cv=none; b=qL6NrmbKXFDqlbuwwDS4ZQyT4wJGMDfSCz6tKUeDn3xmumPnKcz1GxbuYZoOcNCdnj9XhMcwCG1u5xFYADXsXeAi2woSR8ovWIjHZ7CVpH9XJ8HFFovcB3uGQTxIQXZHYIpAATmWBu4AUd516LVsqWVSh93Qw0HoQtRhe1YUMoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758742510; c=relaxed/simple;
	bh=JVhXArOWemQPLrAxDExGAeOdw8F8ud5AdjfE9pP8bKo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r2r/gAoYfsMILQ6jCfmkdasZuUArwVk4fh+s3wU4NQ4B2abWabis9PZ7Er0Fck+8G4YWVo2ehpJqVhZ5Ml3cr+0a0i+y0h518BLElXrAghTa/TxBID/6doxCJ6P6DyDmzcXLJRsQ6Y4RfSIm6JlViVOMW6Pq/hWjNgSdZQeXSWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=IeD45TIx; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58ODNUZY029443
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 19:35:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=TNlc6/vrXO2HQmuvBAOIMDlW
	uUXokEx/akryGttD9H0=; b=IeD45TIxGK67Oq3ViacGVuBJFVBuF42Wn0vhGcj4
	aBCYkK2Fn4ukG2I6lUs7WQEhixz1/n4JRWc63TKbN40BQUbCOMGn2gHWnVCoNkoU
	mvLKIag/mqWRpMS2LSj6n9ZKLJfdvPm6H9SZpi0fjsc9njzDa/06l3MlzDa8lKg4
	FQauxHQCRCNdVtjbWG/h+G/czDv4mtKnVkgRHXq4gsPHoq0ChRwUawh5U+X+cooP
	VyiBKijFkq0IFT0g6oIqehmZ/6fkmTGsV5Ub3mdJUA6IOiSmJbdbxDRYeBM2Q/kt
	wIqYw+MO+smiNOgbgLhfqj42TquAbkPhlY7DSFAloL9xAw==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 499n1fneq3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 19:35:08 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4b47b4d296eso4787031cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 12:35:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758742507; x=1759347307;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TNlc6/vrXO2HQmuvBAOIMDlWuUXokEx/akryGttD9H0=;
        b=kVTn7hYItrjhXVw+B4kKyiD9tnNNqxNIi96dokdhvUaRkMe7B7xOli7iYAV4ijnBpT
         n3pgwV9i0PVT/K5sTUHf8wccfboYZ/hjMIydfdiHZTRKAQHWwlyKg3xr1tUP1qpjndJS
         n0lp3WWZdvlXSypNMwHmDC9AAtLV/m2tOMbVjH6V1fKdajMxrCMDBlZGy8ShWtkF+RLP
         pODKSJKz6GGkLsoo82Advc4NrjsH8aMvaVjJbVx1pdlWM8VvpEgbZ+mLsrBKBwd8Ip8P
         qjggKzrpEK/xydlBI3cOh8LgUGGcgnAaTloePBAQowGJUviRWlNroKGNalmvntswBAsN
         goGg==
X-Forwarded-Encrypted: i=1; AJvYcCUfLYP24cwkesMHucumlnrTo0HEJj2OL7jQ4/VqK11cmcRzSipqmiMyPu5Q2xs+OlPs1DFJhOB9yftgHRQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOXm0gcqIXgUpcqvvDqSG1bZ2lNSuFfRTuZZkRWNHn9ltiIet3
	wwVt064ZxSBd3GihdG4pShJ+SfAGkbWl9hYRc/gsxRJXp69DacfQW1KeOnnrFy3p9kVNZeowFJ0
	ZO7aKjPz0KkSjJjF8byPRlOA9cQPixN59Xcf7uQZicFsdh5QoKYf4eOQsQz0m49BnkEE=
X-Gm-Gg: ASbGncv4DYn2F2VjhusMacrmp3ghdrReYHJFo9n1h4sI7h+ySBxV4juz9+mINje+zy5
	hXOXj3dd/2EMtem9AH1FBRb19J40h07txFoTnjgX13Kw9LuyVQZV3GO4UntvnVTmxcdPa1Cvrfu
	m6scM222myWIQqA/m0iqrQwFq615kA02LO5cCvYNHRbE4bUGlr7OPIOeZ4hOxy1YfOLz15tYpah
	CYzNF9qxy+cQe/u8CTrQcnZS80UDkKfmMEiW0MVfX3FucPA+AHMSFfagNwPN0Rw9xkoRxE+lgW9
	QwJGcAwU/XdG0ibyBAq+Jqf74yJoPx4vxUq1lIKIp5b1lMUjrB10gR/0V8vL45ktjk+ztJYfxud
	Bjcj3nW7dEXHGrbN+anKjeF3P0/fkDZh/aIeZBY6JntStzCDAWNUa
X-Received: by 2002:a05:622a:5c85:b0:4b7:9abe:e1e4 with SMTP id d75a77b69052e-4da4e56e355mr14523361cf.82.1758742507155;
        Wed, 24 Sep 2025 12:35:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHvunyYwlMrtpEhJRVotUbghi/QPDvwX9pX5ZtFUlvPG3ImxRAdBB7QbYV0goF20BESh/Jo/A==
X-Received: by 2002:a05:622a:5c85:b0:4b7:9abe:e1e4 with SMTP id d75a77b69052e-4da4e56e355mr14522991cf.82.1758742506719;
        Wed, 24 Sep 2025 12:35:06 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-361a8f57156sm45081381fa.37.2025.09.24.12.35.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 12:35:05 -0700 (PDT)
Date: Wed, 24 Sep 2025 22:35:02 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
Cc: andersson@kernel.org, konradybcio@kernel.org, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        mukesh.savaliya@oss.qualcomm.com, anup.kulkarni@oss.qualcomm.com
Subject: Re: [PATCH v1] arm64: dts: qcom: lemans-evk: Add firmware-name to
 QUPv3 nodes
Message-ID: <uudcntpurhydj454jemum43a5wizrg3efbqb6h4co3cvyqvn4g@qighmntbkr5s>
References: <20250924035409.3976652-1-viken.dadhaniya@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250924035409.3976652-1-viken.dadhaniya@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: BUHZVr7-8sEpJlXHwjj3FQ9QDsQ6Upk8
X-Proofpoint-GUID: BUHZVr7-8sEpJlXHwjj3FQ9QDsQ6Upk8
X-Authority-Analysis: v=2.4 cv=No/Rc9dJ c=1 sm=1 tr=0 ts=68d447ec cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=B4HikTB3W-0rk1GVoTwA:9 a=CjuIK1q_8ugA:10
 a=zZCYzV9kfG8A:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAzNyBTYWx0ZWRfX/bHOD8Y3EnTX
 gSIgR8eGJUkD+v810cVrIHxIet5Q3Skxlt2ZIYogBFLMjY2u42jlvyfMZ2POGlrSKAelvKLDmCn
 j7JXooirSx0hbxlsLN+6zybBFLwfeGeWiThAbdW5xZJe+9OEcQ0yzG/02JhTyUp4+CV9OEz9Ieg
 fiXXKM53UGh4N9pcXSE+AEnheTeCuYzXkfrNPWT4Lr082NSNHpjM4W0WJxXo7+mFrYAHh1zeyPb
 p1zXUO35SXTlnhWl6NJZIozjfWSWrn1OO5230jb9e5OGJdEnuApmbpJhBpkrmumxeqxyn/oOMQs
 Bwwoo9r5v487ByOUs2X1rAvV80TfDmm4k8dVMCZBNa9dsgJ+ITLb3RpdogjblYU9KVOPzRX4Slb
 kWK3CD4W
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_06,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 suspectscore=0 adultscore=0 malwarescore=0
 phishscore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509200037

On Wed, Sep 24, 2025 at 09:24:09AM +0530, Viken Dadhaniya wrote:
> Traditionally, firmware loading for Serial Engines (SE) in the QUP hardware
> of Qualcomm SoCs has been managed by TrustZone (TZ). While this approach
> ensures secure SE assignment and access control, it limits flexibility for
> developers who need to enable various protocols on different SEs.
> 
> Add the firmware-name property to QUPv3 nodes in the device tree to enable
> firmware loading from the Linux environment. Handle SE assignments and
> access control permissions directly within Linux, removing the dependency
> on TrustZone.
> 
> Signed-off-by: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/lemans-evk.dts | 3 +++
>  1 file changed, 3 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

