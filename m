Return-Path: <linux-kernel+bounces-757219-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1CADB1BF56
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 05:33:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3391C18379B
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 03:33:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 871D81DEFF5;
	Wed,  6 Aug 2025 03:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="XIDjR8lF"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C03B85260
	for <linux-kernel@vger.kernel.org>; Wed,  6 Aug 2025 03:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754451186; cv=none; b=NkKmJiRyejB7ozxbeyLRORLJhKn8tVwE/rgNdn5UjEvkYS9JZdFKrywjGCdNjXSGWskSrWZ+PcUetxXh9VsVXayWDo5XXf/KYZAw3X+csBZDpQ5wsEabsN3Q/NVOlBkUZd8H+sMuEaO6/rRqCaXB9Eh8hbER8E3KZ3JskPjC+t4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754451186; c=relaxed/simple;
	bh=f7pG9H4432qS9R1r/kzZomzIOKpZCgtoTOoxePgpyUI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U7x2ELrPvp0cRc0lIeg4NVvrb66179Nluf5rh58TZFbVEJFKatT9GaP21hpuTQD1+i2mOJNxnm22znmurUUbLbbgDgL0qJjUMQjGOTj4kGJtT02kCwDEL48Fex31TjIB6SER+RqaGmTXY9jDIN35wCSwlURnqHnAjMXlzvBnDQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XIDjR8lF; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5761g9rq031863
	for <linux-kernel@vger.kernel.org>; Wed, 6 Aug 2025 03:33:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=E6ZxrCjqBVtepsO7mQAejcOr
	0b+KcgjVHvwf5asrNsQ=; b=XIDjR8lFhqErTT2U2/ak4Yt42dRDv7vBONTj+97u
	HsrGQ3g4IvW4ZSyI0r23vHX6ok1b67UEs45SnOuTSELlmLEGOJlIc/YMpqHcefsV
	u2z6FgrkxFmC2mdHwESRRX5LNZuZumSWaglAwCSUlYpqrUcMUupwSC/KHz8T2ObT
	6KY2xphjdwjuU6WI9mZBXW4h6Sn5lpuATBOa9WzHNPt0SvqSQqVG8/997ltZ/2ax
	KvYufXxdKxDZ45aZjaIyvBDUHSWB+udPrRWXM5pSrygQJTLJElmqi28jmxwuhDKu
	L6fGrpe+tIkbKAfQhSiUzW0ugDSw/uHyMAzDfWiSkG5DNw==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48bpw198sf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 06 Aug 2025 03:33:04 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4ab7464e3bfso67323121cf.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Aug 2025 20:33:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754451184; x=1755055984;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E6ZxrCjqBVtepsO7mQAejcOr0b+KcgjVHvwf5asrNsQ=;
        b=eD2nhuDHYInm4iorJy836//yUjB+NOk47tDRZxgOS+uUsyZ5e5oExna943U5GD8vwV
         Red5qZX8HHC6uTGnVkTXw3Nm1BlgAqcjBjooFMTpK3ff5dwdX5H2zgdREMtmkLVkBy6M
         fui7J7L2mw6YQ4cOk4hBnPuy6KLnT9zFlDsX9y3vMAQPsY7xkbZxT76vk6uCAszltUOZ
         Ep+azFk6TDCat3KVFg3z+zjFeMXZAUG/hK/Swuec48vqTmBxBTCRTxMpVMTjYPJVUUvM
         +7XTB6Ib9m8zkAObAzGOE+psYiqoN+5zdN/00cGlMlhkGh8MqwqBU5jubl11eNvRcFOL
         LN9g==
X-Forwarded-Encrypted: i=1; AJvYcCUB160rTJR6ph/wqwQGOX05xIzThsDFkkpMhIqCBgZSLsALf6Ci2bJJA/hvndvAHw6kzMlRxr2Iwl3MuFY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgD2xfjgaFWjDQzmxQdc5No5T/M2tSQ5Avc6VsZil/ugXFRGm3
	l/GGy4C4igDSJskYBzYZEAiVLhHgfGCo8NlPXIBaf1ja0gwM+QpQ20ONJ42j7A/DQNKL2Xja/tJ
	n3UeFalE+dKq56zDvAielf3lgDcYdYYT2uwWmNACcbFvMe/QvdagvWUNdoctF/ocjFJo=
X-Gm-Gg: ASbGnctEIXEsPXM3I/cV3HgS6JotmRYFCJ/tW/iDmKGC+MfQmu47gf3Zoto1LjbQ0Tx
	FtnNAKl4YiyBOoJQm+TxGM+5SfvezqHZZzUAf2HhrDOtPPZ22Zh/bclWRJKczJZoZ0SxtDtx0Oq
	hSbQj6TfnEXYGZyZncDpYh2kOWaFmyEJo16icsX9YaCgUhCFPxSXVzHSueTgew3WVmRjbHMPzXN
	Mr30h/D0nq4eZIltQwoHNl+7L63dssjXllKvGcd7nDmraNIJO8/Pw8kR8aLHuep2NikUoriUeRF
	aJa+IXhxMQKgNb6iP1JIFF+K2IPl89lAANw+7OzEigc0MRdKFM1u6/dVE+EtINV2z1mTV1tXi6i
	FmMmfrgNaYDNNWriz04jkxwA+v0RK3fYbJ/u+4UJ2wc9+MCjIveAv
X-Received: by 2002:a05:622a:11d6:b0:4ae:cc29:82a2 with SMTP id d75a77b69052e-4b0916256a9mr15640381cf.59.1754451183443;
        Tue, 05 Aug 2025 20:33:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGIwhF9FkF6BS9ElI024cVRv19Q5ymyMG2vkjQdqC5u3HaOqDL9TDsvnsZAVpO/+YTwS4Uowg==
X-Received: by 2002:a05:622a:11d6:b0:4ae:cc29:82a2 with SMTP id d75a77b69052e-4b0916256a9mr15640001cf.59.1754451182812;
        Tue, 05 Aug 2025 20:33:02 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55b8898bdaesm2164581e87.9.2025.08.05.20.33.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Aug 2025 20:33:02 -0700 (PDT)
Date: Wed, 6 Aug 2025 06:33:00 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Yongxing Mou <quic_yongmou@quicinc.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 6/6] drm/msm/dp: Add DisplayPort controller for QCS8300
Message-ID: <akeglwafbtldzbqwudwsogrdw6zsxua7ohzkkjxqrw4d5uwhdt@fdbqudkqwpe3>
References: <20250806-mdssdt_qcs8300-v6-0-dbc17a8b86af@quicinc.com>
 <20250806-mdssdt_qcs8300-v6-6-dbc17a8b86af@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250806-mdssdt_qcs8300-v6-6-dbc17a8b86af@quicinc.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA2MDAwOSBTYWx0ZWRfXzU8RsLPpVtWq
 MH1uXlW4ymb2S3i+MaNhIvWU/GQeq2cKo2K4pnRZE+YcsqXohhAlkuHx0t2iwQYrmWpccM9xSV3
 qXJFJmCy2yygOAESivKyQn532XQyHd30Ji1UBnNc5uPZl9EBGsbYOTb1rzFIzJaDXwLWSeIcYKU
 QNnN9M3baDYaC/GA1MKqKd8bVKTekvekRFB2Sa+V8Cevevn0q/jgMs8HtaehKSfG1Os5t++E8bi
 vSHdt8X/PhIMQPKR0V6XY4N27V5GQebJwWoi9ajfMCPU1D71Qla10s2ubnRqoMHnKY7wTNyKN9C
 gmU6gXRNTKmv8PCY+qriG/0GFtffhgaloXzYqstEmq69fnYzGzvKKhvU83esIXlmnv8HFtQOp7m
 PrZGjI/1
X-Authority-Analysis: v=2.4 cv=Ha4UTjE8 c=1 sm=1 tr=0 ts=6892ccf0 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=2iKMfItpbZzF_GTDK0UA:9
 a=CjuIK1q_8ugA:10 a=dawVfQjAaf238kedN5IG:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: 1AduwZZ7lieaP4NSZmMXK4TAyKcTcqkI
X-Proofpoint-GUID: 1AduwZZ7lieaP4NSZmMXK4TAyKcTcqkI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-05_05,2025-08-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 malwarescore=0 clxscore=1015 phishscore=0
 bulkscore=0 adultscore=0 suspectscore=0 spamscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508060009

On Wed, Aug 06, 2025 at 11:16:50AM +0800, Yongxing Mou wrote:
> The Qualcomm QCS8300 platform comes with one DisplayPort controller
> with same base offset as SM8650. But it requires new compatible string
> because QCS8300 controller supports 4 MST streams. 4 MST streams will
> be enabled as part of MST feature support. Currently, using SM8650 as
> fallback to enable SST on QCS8300.
> 
> Signed-off-by: Yongxing Mou <quic_yongmou@quicinc.com>
> ---
>  drivers/gpu/drm/msm/dp/dp_display.c | 1 +
>  1 file changed, 1 insertion(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

