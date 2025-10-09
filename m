Return-Path: <linux-kernel+bounces-846979-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D20BBC9941
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 16:43:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8EB494FB13E
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 14:41:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8CC62EB5C9;
	Thu,  9 Oct 2025 14:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ExdeOdGT"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 636DA2EB84C
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 14:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760020889; cv=none; b=MTEVWtoC/TOVoXq5V5BNdD62v4rnNhwzF3wyGBCgY09/PICcLo7rvWEaMPCXw6FRbAlGKyTdOBPnTfWYZ7dZFnojjtMJBYDVu369rQe46kzOxZByG5RtD8sg2uMkhBDYl0PYf4rbCegi5OkhgeAUXtPUXBySBsBp8JkTuOmsFrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760020889; c=relaxed/simple;
	bh=hMAlIl8gIK8LztwW9HVQfeQYtg5hZj6rasv0Brdvkx4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oBuKD9HXAjExIF3d4cGNU6LLFNOhH4B5AQJY61khYHfJ/8JX45vw+qu7aTmscasmEHPpYkFgddvACh60EblY0nMvG+Syxheua5wTYlz+jXRL95GxOU211eJ0DsqXgtrsXpTC2KICX88l6XrxLaAA0DygbMnwp1UQrhteeU9KjJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ExdeOdGT; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5996EhEO022547
	for <linux-kernel@vger.kernel.org>; Thu, 9 Oct 2025 14:41:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=FPQiX2366I2f8Av1zpm9cGRd
	bl2lIGNgfsiAginJlD0=; b=ExdeOdGTwivkH3fbQt9LUnWGOabIJ8LV0nM8sVFS
	0U9BNq8O77c6HfHPfyVJCUaciOFWFlvH/JdSAVS2Ch29beH4O/pLHyDk/x9k3wPD
	EcSAZr6EhSX9vTJZ+/zoCa0c4R8d0rnqZkq2XXKYiVKSfSJK8f3WgjgF6cprOQvB
	M+90L3XbLWixakVTrv7KeUvmiHzgNyc2cTLj7HjL0eH2cc5zWLlxvcoDbPE6j2B0
	ivdo3cSFqrZqDMBtsvKWh3TNdbhlYl1DC07e4ajBmrSZTPmWzkkpFmg8VEci6iHm
	SMuBdnzwqZ+wcar/OXiqKjw4MDQ2qI+X1mwTlU2tPO51nQ==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49nv4sk6r9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 14:41:27 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4deb67c61caso41991281cf.2
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 07:41:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760020886; x=1760625686;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FPQiX2366I2f8Av1zpm9cGRdbl2lIGNgfsiAginJlD0=;
        b=Xg37ZZT6Tjwqq6dWDZ8sIz6Kyrm4sVQaQfDqYD3nSfuGHQRycmfG4FKYoxbOvPjdOD
         QtFpvVaTGbXE4bEl+pSsCGzMEcTUWykBFeje40GGY2aayTaEpIEsIkcKCTSl3z+ILpWN
         VksEKsqItlkIVrGY7BPZQ+vQywO7NBLNO1dLWTwqBLgEUvFWI2eo0ZlXrhNmJqep8Pcn
         yRsshvQ/fasmYw7Rrz5A2R32/O8g7o3QZgEG0TX2IQ19PXcVuOSG3IsVrUNxCrkotub/
         ZGE7P6kP/0FuN0uqyMelxSdzXrdfsSes+7JEV9H2bBMJXmJ++HUnyw3ke17etjJDGsmb
         gCbA==
X-Forwarded-Encrypted: i=1; AJvYcCXATjThbRnxFKbqxtVu1PWkXygJ4xvwRZ/XjA1p4CHoYD8Iuhmnf0GO9+azJPO7V9vTLiQ7JM7HXFaXcgw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQ9U1WnVg7DLTU60Lu/kp0LN5f5tpOVu5clD2ujpuLsUnTdvBv
	YMRiQYkwI0Z6ZxAhSw+34o7O+4IHfXvKq0RteCNQn4hjTFDdGwBGAxOrNvUsCfbS8f2gwSLidNP
	QOwV4E1oGHnAD/q/R0gYy02L+5a4ILPyPKzx+daNPoI+oAah92zXsyw1xmwKlMmJE8Cw=
X-Gm-Gg: ASbGncvCpjWwOPB/LEP8N+lYS5Th70ONDei4zNUJww69im1Umr7iAtxQoAhbPvxyfjM
	3UxKUcnW2yaEMcjEk5txe36aUEYzSzodGptaW5L6dziUcUhZ1uz/D7dLxFU7OoTy33NuAXDrvYu
	F6LoMrf1gr1h2rqGM1eEYje2hgNJykBUGlvxpLMwoCAP4dBbiEEzZcTvi+MnMy8582rQQkwfhR3
	J1QPDHBWk1InRn5Q7R/+jsWq4+GHf/6YTah6dHIDH4cdOk/iV/1Ho+5ibQP53hj38ve+TVtDvxR
	U1p8V93ziuyaP1D1vxeBzafHnBFt9zB6tixao+BhhxtzAXDrQy6ESqfsUq9mTwcA7qGBPR2LT8U
	Se2iTW+erikVSDUaBw+q2SBTfHP3QeQTOnnhUIk6DzV7B/Zj1xk+JLIjstw==
X-Received: by 2002:a05:622a:2617:b0:4db:5202:d4c with SMTP id d75a77b69052e-4e6eacd239cmr116681281cf.23.1760020886216;
        Thu, 09 Oct 2025 07:41:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEQCT9fe6gb0r9Ti2FL4beKrwqnfcI7Jo0U085lbk3COrZ4Vvf6eZvpSGNwWHODrCy2DfPJ6w==
X-Received: by 2002:a05:622a:2617:b0:4db:5202:d4c with SMTP id d75a77b69052e-4e6eacd239cmr116680621cf.23.1760020885608;
        Thu, 09 Oct 2025 07:41:25 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-375f39fcafbsm29930991fa.26.2025.10.09.07.41.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 07:41:24 -0700 (PDT)
Date: Thu, 9 Oct 2025 17:41:21 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Luca Weiss <luca.weiss@fairphone.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Casey Connolly <casey.connolly@linaro.org>,
        Alexander Martinz <amartinz@shiftphones.com>,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH v2 3/6] arm64: dts: qcom: qcm6490-shift-otter: Add
 missing reserved-memory
Message-ID: <an5bytw5kee2a76ezpmw4w6n2tf2dv4gr7yblfyfluhxwk2jcu@t3dga5hvtoub>
References: <20251009-otter-further-bringup-v2-0-5bb2f4a02cea@fairphone.com>
 <20251009-otter-further-bringup-v2-3-5bb2f4a02cea@fairphone.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251009-otter-further-bringup-v2-3-5bb2f4a02cea@fairphone.com>
X-Proofpoint-GUID: 66mj1nOFyBegpAyyOFqpzSoyhLuthpRy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA4MDEyMSBTYWx0ZWRfXyh/2CO63AeRS
 HO22TpoW+j70aAlLQ77HxSxxrjrfHViK7qoTFVpNhXW2+jvHBxjhsQhSzyr6Ndn7pCc8omWDds1
 +OQyH3IrglCfPo/HHOq1ppL9XCGX71FgNQr79z3T66huLp1btIsHTrvpSa3PZpGJBKoMCI1dL5U
 QfImviBr6T2ONRcWkg5CernzIKms7lDXgoVyhssJ62XOsf+f4iSvQTvCH1LqVGd5iityehV5I8G
 nP6a8N2PgWahzx3Lh7we1PRq4eAfoVdCwR8nQDfcaUiKG79OvmVzUOm84Ah0mI9lSIkfnfWCw3u
 H5XKo1ektoZ9pQaRgvKxbe0ESMD6PwWySftQaw5jEGxiI0g4R3y+It/d4h1F8lA2qAe/JFfzJIP
 wPNNQ9nArJPxmWGaRchnRkNuRZ6mPw==
X-Authority-Analysis: v=2.4 cv=SfL6t/Ru c=1 sm=1 tr=0 ts=68e7c997 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=7Ovdx5uLAAAA:8 a=EUspDBNiAAAA:8 a=6H0WHjuAAAAA:8
 a=bVQzUrBaaxfiXJaSTkAA:9 a=CjuIK1q_8ugA:10 a=kacYvNCVWA4VmyqE58fU:22
 a=TQZWkJv5rNK5-PaLMsrg:22 a=Soq9LBFxuPC4vsCAQt-j:22
X-Proofpoint-ORIG-GUID: 66mj1nOFyBegpAyyOFqpzSoyhLuthpRy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-09_05,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 malwarescore=0 bulkscore=0 priorityscore=1501
 suspectscore=0 impostorscore=0 lowpriorityscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510080121

On Thu, Oct 09, 2025 at 11:06:33AM +0200, Luca Weiss wrote:
> From: Alexander Martinz <amartinz@shiftphones.com>
> 
> It seems we also need to reserve a region of 81 MiB called "removed_mem"
> otherwise we can easily hit memory errors with higher RAM usage.
> 
> Fixes: 249666e34c24 ("arm64: dts: qcom: add QCM6490 SHIFTphone 8")
> Signed-off-by: Alexander Martinz <amartinz@shiftphones.com>
> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> ---
>  arch/arm64/boot/dts/qcom/qcm6490-shift-otter.dts | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/qcm6490-shift-otter.dts b/arch/arm64/boot/dts/qcom/qcm6490-shift-otter.dts

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

