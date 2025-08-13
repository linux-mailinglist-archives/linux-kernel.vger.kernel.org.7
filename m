Return-Path: <linux-kernel+bounces-766779-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88B2BB24AF9
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 15:47:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80F51625EFE
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 13:45:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 869772E11CB;
	Wed, 13 Aug 2025 13:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="BWyDWoEo"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 841FC1C84DC
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 13:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755092710; cv=none; b=c+MJXrJx6aNA80xWlY4b0ULdyx2vBhFPZ4OiLxj11ggmvxSEka0AQPnip/2QDU+yHFSrNOViYyqUmTYbJu5nL93WZY2zaRyBmfzyP1BgUOND1Pntux2r/iQrj1fNEsCGvxBOtzXRBFfi7vmElUzueRP+HWGoS1Mf5v5eWVswjvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755092710; c=relaxed/simple;
	bh=rrnMVCgKWPLf3+i9sUlbk7B07YYSKzjrB6rut30/jHI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YKMmXDDV9rGRqcTOVcYuF3bKouptSCFfdGNNC5g/ViSJeWvJa1W988wPJ3iyTpt8ohxkK4gwX4XumKhHQhseD9Feg+E2xYBtCzRA/dvnx71Fy7a3pRL2h0S9Iyfe2cbe5bivi8DQ2ESGNKkKq8WIk/bpacz3d7SyoaOcgBFXKrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BWyDWoEo; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57DBLdQG020580
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 13:45:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=Tbskgr1FSTKaGM3oXM2qZ3de
	YMZHFeQyPrPKxR6kD+w=; b=BWyDWoEoFq58JRa7SG5IxEESvB+SRK7rvbZs0POW
	sWjRIfqUXIvOJzv1PPyAnuOrxuJaj+K4ayVOhePlzBTJpBHTdM7Oob8H7sRnXAf0
	D6UvXPg8TY9ebo5GZzexsA9gCdZdajJb1519o40GZtzjXBKi+v/1BZTWKpJ9U0+3
	8W9HHulT+EDFFMjpzCjkrgwf5K8C2AP+5XdS4Xz6sMr+S2cRzJ65OxywIaaI+3e3
	xW78x4RcKJ5z1MuOLPkX5XrUuIOzcqrN3K0lDxIMvsK+3VsqTDZS0VJarkgltiea
	NwBRv/2P9qgpSJdJMd5oiDaTv2RgToLKYbNov39aG5tr8Q==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48g5hmbvrq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 13:45:08 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4b0faa8d615so24395021cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 06:45:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755092708; x=1755697508;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tbskgr1FSTKaGM3oXM2qZ3deYMZHFeQyPrPKxR6kD+w=;
        b=fC8lwmIlcIlw0Tb2ccYbiQ0YR04b91Pis+lJxDyvnwSA4Hw/LFMPNj9WwwEMW+vkmi
         pwqxdvugd1QgfH+T8XiVjr8vgFhfTufY+YUfYCV6WmFutgSxFYPD2XHxZzHV3d4omrm4
         OulfAp+5EjpLdj1gOy3wKr+HHMu+PtaW2zNzNGrCDTiCSkRCxqu6h6f9Yhu5uPBB8cxX
         NmSTll2Ofwe/3p3CjRS3iUnOwJ/XkxHOkKRbZncaVNQkyREejCbABXCNkaEmUqsSSsQD
         r/5hDSuH4AlblPk+Yyb/qxsqwwzRWCDikjhJ7aPHl+mC8c76MpDYqnsixNqDGN2gcokJ
         bYGg==
X-Forwarded-Encrypted: i=1; AJvYcCUzVOz2JCyd6LQcDPg31CNvNA0OVupaWUjdfP0IT7r0kcO+tOx88TjaLQ5WQSBeicrjr7YoUKVdHnJMaCg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxb4XeI7a6WmJSdBYOw4gb8D8TZ+2zHIe9l996qckV5cr2O+lpr
	whkIXZKAe2HTrZwDIYmdP8YdeIWEWc+dDZ4SJldrx22/fH3n+rpCoFtRDLSB5Hss+wQUlcrk6DO
	NtjjuzTPx+qGNTh5LRT47+GNLUMAPWDmQ0pG1eFxL0pOZdeHBh3WwiGKdDNdcR1j+Ljo=
X-Gm-Gg: ASbGnct7PMZCr1M7V71yMPvn3pBJ0zZDuXB3+BxBEJxjBQtqTeJsOqAPHT0ABZrqm3E
	TM5vBA+Vwp/9AT80rhNN4zr3J5ecZhhyVA62aFE2uO5PgHOCh7/8BrH50vWhN6eqDM6BoVMZG7o
	iOvYLdfip8xUZYUzwdDQZB314sygjeLB2Jj6CvJVN3VpFt4NcGFQ0qPoovZw1ea+FwQN/7P9yni
	UqYMMmNVHNaUDmJjx2BBVtC5AQQVNQFFqb7/Z7rdKRk5BNv21h1EQ1j+FQ47VTSrSk+Ebuoy64Y
	EJ5tsiDtlcoha5gGd2wURz990pEI1FYzhkv9YELbTeZt01HnX6dfkUJ8CC6wfxdVpuRTtPrDCQ6
	WgekOXoKkYeDuITahPbrXIqIJkJw4UwunNSHb0ZLHKo2WN1TGLpG3
X-Received: by 2002:ac8:7d05:0:b0:4ab:640d:414e with SMTP id d75a77b69052e-4b0fdfdcf13mr30019871cf.3.1755092706655;
        Wed, 13 Aug 2025 06:45:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEwat25ikRoIeKUsZVQAp4uJJPxvfxNq7VavVdhY+SbjXOk0RTjYbCeFGW8hIPVRdi8aHXzsw==
X-Received: by 2002:ac8:7d05:0:b0:4ab:640d:414e with SMTP id d75a77b69052e-4b0fdfdcf13mr30018941cf.3.1755092705862;
        Wed, 13 Aug 2025 06:45:05 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55b88ca2978sm5281543e87.116.2025.08.13.06.45.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 06:45:04 -0700 (PDT)
Date: Wed, 13 Aug 2025 16:45:03 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Taniya Das <taniya.das@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Taniya Das <quic_tdas@quicinc.com>,
        Ajit Pandey <quic_ajipan@quicinc.com>,
        Imran Shaik <quic_imrashai@quicinc.com>,
        Jagadeesh Kona <quic_jkona@quicinc.com>, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH v4 7/7] clk: qcom: gcc: Add support for Global Clock
 Controller
Message-ID: <rv7puyb6wj4jf5yfnml3sjwjes2qnxwwfmkvhlbgbxescy7zjg@nh7xym4qgjg6>
References: <20250813-glymur-clock-controller-v4-v4-0-a408b390b22c@oss.qualcomm.com>
 <20250813-glymur-clock-controller-v4-v4-7-a408b390b22c@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250813-glymur-clock-controller-v4-v4-7-a408b390b22c@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODEyMDExOSBTYWx0ZWRfX+COADwhS25fG
 wid1e9CP6InBKTEA9/Z8Jv2d3G8qzuMRBd3SjbhfSAfVlAyJfg3rnDX74TK+KUhx7oM2R8X/ct5
 WwilbeFjhxV2MxS8lYlL9N2/12NEYF07nmjNYrlxNxY6hUG0Ltitfhs+EfmQPW4LBe7Mg3mS1Cp
 4vF3Qpvi91Gw0RB+NVbgJOAU/9YMZhnF2kwiRwceQuyE0FUoA9oiGYbk9Feb5oiXETYxT+cunvx
 HFRSo2zSzHhAkEw7PCtqjX75wlle1XXOKOpsdIBbWLllQ6TV0TbktlNajfC6KxWgbVjGXSIJ7aE
 XPVLEfCiVtbB//bcbAk2KdFHr7Lb3wltb5VewPevuudmBsLI94J7HStD0uAoKpJyl76tFAF/AwN
 Vi6SCLum
X-Proofpoint-GUID: RpjDBG_fB7wgu0BGVUQAQksURbe4aHfL
X-Proofpoint-ORIG-GUID: RpjDBG_fB7wgu0BGVUQAQksURbe4aHfL
X-Authority-Analysis: v=2.4 cv=d4b1yQjE c=1 sm=1 tr=0 ts=689c96e4 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=wc6weylmL2S_uF29i7wA:9 a=CjuIK1q_8ugA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-13_01,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 spamscore=0 phishscore=0 adultscore=0
 bulkscore=0 priorityscore=1501 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508120119

On Wed, Aug 13, 2025 at 01:25:23PM +0530, Taniya Das wrote:
> Add support for Global clock controller for Glymur SoC which would
> enable the consumers to enable/disable the required clocks.
> 
> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> Signed-off-by: Taniya Das <taniya.das@oss.qualcomm.com>
> ---
>  drivers/clk/qcom/Kconfig      |    9 +
>  drivers/clk/qcom/Makefile     |    1 +
>  drivers/clk/qcom/gcc-glymur.c | 8616 +++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 8626 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

