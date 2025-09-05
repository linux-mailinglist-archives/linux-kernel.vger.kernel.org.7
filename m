Return-Path: <linux-kernel+bounces-803386-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B4288B45E76
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 18:44:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 494AB3AF387
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 16:44:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 425C83090E8;
	Fri,  5 Sep 2025 16:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="C50OPR7J"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33DA02F7ACC
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 16:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757090637; cv=none; b=n1Io6tnUFVHPSiEbOeI6QBFYgW06+AzJOjrsUJhDnbq7/Adysrxfn5p43yR7p8BnfyB+pkcDHAWDGQTqO8hPUY8V+2MfsbustazM8EtjRiXdq8E2v3/LMiJZhEIQsm93ifq3mTf3zU0qRoo+ep97za3jZH/RDB6IA/SSPvOTQAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757090637; c=relaxed/simple;
	bh=Jwq5Cmuwq0xKoPb8D5Y+WDIT0WgPSbIA0dAerV9mjcM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dYe3zDraOFq8JmD3x86g9je1FAj4TihOmjVCoVfZaeGSiDt8fay1Pj0oms5WwBGILxce75OkFwa88hoRogekU16xoPFzbONDpXwdt/MwhwdQCu9Aky809iiFLL7XmTVtu4244tnn5JtJtMntM7sacDapbdeJ/Fa0a2J6mZksTdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=C50OPR7J; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 585FuEX6013622
	for <linux-kernel@vger.kernel.org>; Fri, 5 Sep 2025 16:43:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=suqflfzPR+pi7AQ5LgBM/gjS
	VWHsISZIF8XCQ8+m1Fo=; b=C50OPR7JbK6QmAO/hk0Gi2t9QdrxrrPXlfZljFgS
	zhxnNYCwJxIFnuO4x/Xg+EOca5PyZRjxrBXHwTh9KZUwhomSL7JOB5eAsQX3S/5Y
	uNvBg/ikrOuO0YayepymIyM5vZNnnr6cEoA8xkb4Rxly2fm5u6T7V3C0a6+vMVN6
	J0l1ud37ZTFqFX5Npdo4mjvC8OQPcB31dsnQRs3AF+1GIge6Ty6pzWM4L/95y4Gd
	MvmBTqiRa/6HGpyROCYFbHMzUPMkGGtlPfvv4WqoFmHfAjaR78wHAZuMtV8efEZr
	TXbPU+VbJjPMynxbyMm1lTcky0JsZasFs4we8Fs2SNkwCQ==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48w8wyft8j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 16:43:55 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-7296c012f86so37963946d6.3
        for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 09:43:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757090634; x=1757695434;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=suqflfzPR+pi7AQ5LgBM/gjSVWHsISZIF8XCQ8+m1Fo=;
        b=iIayo5JtKkozYIavE1OIpgPglh8S3aCoRPVz6dTSmDh2tEOPGHF/ndDWzTGq1WosPx
         LaZwfe2nz4JXCeQzCrqxsRBtbFd/u34izskMnXol0jlcmseTdOTMuaMAjdU7Pnr+WYXW
         2cWUqttX5uXeVdrQ3HKo6CAGOf4reQAY/C+8mSbOXc44W10ZhCJBGqlpbFUFsz2xqRXq
         VoPxMfjYkDGWYMDY9UmDAQrUptA8AcGSd9y4OsJxUlot5llxzN7TguZ1N9unXf0Yt+VP
         ItlFNPqGeLhvtY8HIpsS/kN+/07I5SmR8wggS+sjDA3wWgv8EswaHVKnQ7ZIry2TMuAT
         At4A==
X-Forwarded-Encrypted: i=1; AJvYcCX1H3uoRPdAjOE1TX7Q2mtaoS0PdyGoOuZD+waSbhyrmhNa1iQ7woRMesfBzZNtl0sq28aTnGPylfOevhQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCN7cSAWahjBarU18Qn9WntNb0CwQi96DEgxHIip7onumVC3+e
	uQQtLML57/EWjVUdphPLgUyHHYJUBZkBrJeu8u0+SSm58kGGoyIcJT/ZCbXzi9CXbhNdwT5X6gU
	04UOfp4jWA78TnnO+gHGj25FiPyRdZU09u8M829EkIfH3QBDEDSML9J7qO0LLH4kzVoo=
X-Gm-Gg: ASbGncuSjpI9Ht6BJAUOYoyGIGffNcJuifxDupDMlbFSxnlOpzZ93cwyZoSu0glhYRA
	RN2aiHm8fwyI1XVUJEBi6pdzqWmeHVsI+tBqmTKy6E+MY1mMgKQ1LyoIw+KIiXlrpY2p430/l0b
	rn3liRXOvL0N+YhOpWZDrADFFq28Rg3LhEctshHu8CZ00pe9/HbZ3mGeYqXmfrnmvMjKKV3RSnY
	1d2EMvURvrjZVhBWRYV9k2PerCbcUqUR+2cnjZnzFc9/m9ypRTKPboblA3gnk/0jjHKL0/EDQuM
	/EthDFfYSuZ4iDkG/HkyFwv0P3j7PXD1SmyMMNWCnehusvQ5ThSpBlCKWC4+3iS4PfOAZgy7485
	0x+oA1nHqUrVpnt58euNR4CAJ3+ew58z/pZd6JX+8fakueNoH3/ez
X-Received: by 2002:ad4:5745:0:b0:734:8eac:353e with SMTP id 6a1803df08f44-7348eac384cmr17846536d6.36.1757090634135;
        Fri, 05 Sep 2025 09:43:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEhHOlrH9tvNA1dTB5GEq9RQjj64EL1qdRc5r/I2S1MBiKCWxrLuvxLGgufouv9wUmgFBGc7A==
X-Received: by 2002:ad4:5745:0:b0:734:8eac:353e with SMTP id 6a1803df08f44-7348eac384cmr17846066d6.36.1757090633478;
        Fri, 05 Sep 2025 09:43:53 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5608ace8068sm1807051e87.79.2025.09.05.09.43.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 09:43:52 -0700 (PDT)
Date: Fri, 5 Sep 2025 19:43:50 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
Cc: broonie@kernel.org, lgirdwood@gmail.com, tiwai@suse.com, vkoul@kernel.org,
        srini@kernel.org, yung-chuan.liao@linux.intel.com,
        pierre-louis.bossart@linux.dev, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, neil.armstrong@linaro.org,
        krzysztof.kozlowski@linaro.org, linux-sound@vger.kernel.org
Subject: Re: [PATCH v3 09/12] ASoC: codecs: wcd939x: get regmap directly
Message-ID: <qly2mvnlrmsoy3jds25i532etwcnljewic3zcc5dbm36nolzlp@macsnqtd3hqw>
References: <20250905154430.12268-1-srinivas.kandagatla@oss.qualcomm.com>
 <20250905154430.12268-10-srinivas.kandagatla@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250905154430.12268-10-srinivas.kandagatla@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=Ycq95xRf c=1 sm=1 tr=0 ts=68bb134b cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=4rFx_9ibI0NpJ5H6q0gA:9 a=CjuIK1q_8ugA:10
 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-GUID: T5sDE1__KBhqm-dU5zyOkhK4zziBDEKD
X-Proofpoint-ORIG-GUID: T5sDE1__KBhqm-dU5zyOkhK4zziBDEKD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTAxMDEwMSBTYWx0ZWRfX27ewUpR7L8MW
 C6eUdTHquwmib1NuVa5cgXml/RzPDndW137FRvvRHn+TXv4uiY+yPQjzL7G/K4nA2NAxgwTMASi
 T1iyyYGJy31Zf3nz1f6p9R7DY2ecgRJ06hZ8jxB3Xn+rehFwcViGJ0Rj7pyiXB0crHuxFpB2BYA
 +gHBOji0vpznH/LLMem1BIqa04SdpsqgF7eSeAkcjlAWxOdF7etXUEKXkt69H9Jbo42o55grppt
 5nniRGjosGSR0ZW5XtEgeHp8H0w00DqRn21Ih05OZR60/jwCiJPTqONCCjy/G1/6cBT7lUEZzIK
 h2ufxVD1arJZYUwCQfQz7RGxWx0Mmt+ZPQZtH6sVkiv/6y4f9CjXEVwr8sLrNJx1xWi5yY2ECeu
 jXbZhRPz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-05_05,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 adultscore=0 phishscore=0 malwarescore=0
 bulkscore=0 suspectscore=0 impostorscore=0 spamscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509010101

On Fri, Sep 05, 2025 at 04:44:27PM +0100, Srinivas Kandagatla wrote:
> for some reason we ended up with a boiler plate for dev_get_regmap in
> wcd939x codec and started exporting a symbol for this. Remove this
> redundant wrapper and direclty get regmap.
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
> ---
>  sound/soc/codecs/wcd939x-sdw.c | 9 ---------
>  sound/soc/codecs/wcd939x.c     | 6 +++---
>  sound/soc/codecs/wcd939x.h     | 6 ------
>  3 files changed, 3 insertions(+), 18 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

> 

-- 
With best wishes
Dmitry

