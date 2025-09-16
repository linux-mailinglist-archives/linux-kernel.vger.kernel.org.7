Return-Path: <linux-kernel+bounces-818539-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 42BBEB59308
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 12:11:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B94581BC3F68
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 10:12:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FE152F83AB;
	Tue, 16 Sep 2025 10:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DmiW6rvf"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 033282F7AB5
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 10:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758017476; cv=none; b=TxCcdqucExqz1mJFClfg6iDOUn64DXARgWpCkmoSKz/mMrKRIm8egkW60miCbAm7xc4R4hvKfX26aSJ0AXUWKpSpFv6FvcYyAkWJ/bzClzy2cWR4VUYSnBJ9Fixh6Zllv0EeWBt4HKpCGCfnyTxrqKhWH1wk9Mp6ecrP7Frs8bQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758017476; c=relaxed/simple;
	bh=Senl6G5y2kjgDQnYbNw5Eo8uk0FX5ScdfFCK2ebKnMg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BYxCKxuQFkKUz/V3iyXTxHCtNYpBx5UuNX+0nUMR2K2E3LAPkvl2DNF9+ujPpFjEx2bePy94X/v+7ntW28yHTMsfqd+bq7dmMs/U4sXhapGBQq3ma5bnZGCcWbwMkHhlTHUuQY8wnUiye24LRaY06+ZvIU/fTYEUmOoP4t/0Khg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DmiW6rvf; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58G3pitZ019569
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 10:11:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=4zWarvLQaWsU823mOnf/9QZs
	pHRdOWsN0EgD2XaoFVw=; b=DmiW6rvfu2QZrBXt1xcnd/cQeGrzTJgx1rYY1wv8
	9wJQXTuX3dFgY5AKJ1Ym8tAcj44YZKjXFinuXhy5bgdgm5o0fH1u6mRJP747fsqs
	FSryIrDKNd+F4p9o0cETFDdkss5mOlLVI+GFCfv4nqiKeLfVTvuAvKNPuGrYBufH
	07ViD+MCxAI9J6YcFnPp/4rc7dGAu5l0uAcTqcfOSNOArt1hNZqGIN5oboacPV/+
	R56SHkZHQ6vFEyyrMrjfP+GRqfu0Tn3+VLhCYUJB1dUkt/6kSno8rzlVWWomka97
	3hYW74tVD2R1m3I6tSaiPbIXboD2xKnEtkeq49nZzcRKhA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 494yma8fb5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 10:11:13 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7fc5584a2e5so1700372985a.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 03:11:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758017473; x=1758622273;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4zWarvLQaWsU823mOnf/9QZspHRdOWsN0EgD2XaoFVw=;
        b=k8B9tnmTvmS5/A1v2dIZMG58fiu3Kmveu9u7MdfCDzlO4E03bkMdnmvp1RiVilmUhT
         aO/YOK6oKqWZV3YZnH/nMqfLRjTHxI++eNyptROCsT/zDvpsaFyBGwsuFpmAj2TOxSsb
         HVUDVFrFmucP5SeoMI2fLY0IdDncTCscM7cLs2Jn3r5HP7aDNvjjjAq4KdUdQ7yB9uih
         54vXlmgyljdFD5o//aH2gRfxRagMig2+IFLabAPM+GMb68CvzxOECqJX00+z1D+4nLuS
         gsIQSUWMFxUSOzsp1o0LaRj2N91aXLZKyT/egfY+3PmGi5pW9WEsNR9cBFqFH+XyZfxm
         g3vw==
X-Forwarded-Encrypted: i=1; AJvYcCXVz5i463HBKPdo4f21yAbI6nQV7PWuO+mGqlrZ5aMsZiJxCpmLYRbK6SV0MOA56oNraJoiyCFG3zRILvc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYyg1FcdkEfbepU7kerH1Sw3tViCceTQ9kZKZ+KRDZjQn10ksf
	iR0qm+iSGy6vQDACqnBunQO7nJvlszp6hDGmQPWaAwPUkRGseoZ0HQG5+/s18UPg14XswdKBFHj
	DIaEWcGg6Zwkk09skOotW06FVe4D6myc+wVDidyXrl1Y0qvVE+B6AzfXPq5VxRfB3B2I=
X-Gm-Gg: ASbGncvHY/8R7d7LwPneH9oJekz5Rh5QyB5BLsqUaASZ0Iyx9quk3fqFvdZKpGWZUvB
	VCaPsREmPbuRxxC6nUEOkIQ2Bmjni6Zyj1uk5NiC5GISYvlINup0s+ZoSQ4LmoD7mUVVoUnIjJN
	Jw1G5uCGpGg1Yzw8HXYEpxL1jVDm5TJU7tb83ErcaulYDzkSjtQsO9JrBkAFgumP+01MBAopza4
	lxB58Yn6qkqSnCrATg87vpCyPnP5umMajL7FQPMStQjMiNAoc4Z+RtkTeHkDy2g6lGWzaX+JHsw
	S79VYaXQTXDkwBBwsp6sHcd+ZrTyrwzCAHsJvmrj1MSPRaLWw+xCdgJ7lhEOXmdbgXyR006DhX8
	bvslv0zBlzqE4etSJeJZUZpRDIOTxuQAwbtays913f8subHWLwBAE
X-Received: by 2002:a05:622a:4247:b0:4b7:a907:bae3 with SMTP id d75a77b69052e-4b7a907be09mr73861451cf.83.1758017472760;
        Tue, 16 Sep 2025 03:11:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH2nSW+Tgo9EtUqjkqnT6uhsmX8sWmrNT+suj6UsQLiHDt68XvEFnu/O56i03mtbQPeIPMa4w==
X-Received: by 2002:a05:622a:4247:b0:4b7:a907:bae3 with SMTP id d75a77b69052e-4b7a907be09mr73861211cf.83.1758017472359;
        Tue, 16 Sep 2025 03:11:12 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-56e65d11f49sm4336890e87.142.2025.09.16.03.11.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 03:11:11 -0700 (PDT)
Date: Tue, 16 Sep 2025 13:11:09 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Luca Weiss <luca.weiss@fairphone.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] arm64: dts: qcom: sm6350: Add interconnect support
 to UFS
Message-ID: <nxu3omwiy627fqubg5zhff2cnyvoeod77tlqpcz4bqfkyfewpt@ob2la5knpnrp>
References: <20250314-sm6350-ufs-things-v1-0-3600362cc52c@fairphone.com>
 <20250314-sm6350-ufs-things-v1-3-3600362cc52c@fairphone.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250314-sm6350-ufs-things-v1-3-3600362cc52c@fairphone.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTEzMDAxOSBTYWx0ZWRfX1/R/ahHmC9L6
 5caBzJ19SyciBDDDi9BhRLfqdcZMxomOb/+yb4W+iRWsuOqEbHFTKDp5V9SfWwqa6KD/T3dkZcV
 Po1D7nW+qwAIPSiqoxhIoRl105zMtH6/rGqRglbz67iZ17PYFMe4grHBm6Wgm6thqCxKiqXCEN8
 EQCBBnaB3umFaXHchTYybdGVY0bU36/krqkMaEu5Ydp5hjvFpHJhqU6+X8bc6yT40nqhUkooM21
 +lW8yzpu2rDsPo/3D6G4RS7VEwkKqDO/ZFeQl8f3ep9hGu89mYAeDjPYg6ehsxuQkaiMjgLlO05
 G6KX5Agv+hGPmnIMSmOPB6TVOCDYi6RKus6FlbY52dWy14VWGh9qouQ8ZK4/MkrFmGHqU/L0rYh
 ui6hjLaE
X-Authority-Analysis: v=2.4 cv=cdTSrmDM c=1 sm=1 tr=0 ts=68c937c1 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=6H0WHjuAAAAA:8 a=EUspDBNiAAAA:8 a=_cXTkGicC_EJ3ct5vroA:9
 a=CjuIK1q_8ugA:10 a=NFOGd7dJGGMPyQGDc5-O:22 a=Soq9LBFxuPC4vsCAQt-j:22
X-Proofpoint-ORIG-GUID: pEBx1emoH1fiEjdrhSPtILihWxGHapOu
X-Proofpoint-GUID: pEBx1emoH1fiEjdrhSPtILihWxGHapOu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-16_02,2025-09-12_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 priorityscore=1501 adultscore=0 suspectscore=0
 bulkscore=0 impostorscore=0 spamscore=0 malwarescore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509130019

On Fri, Mar 14, 2025 at 10:17:04AM +0100, Luca Weiss wrote:
> Define the two NoC paths used by UFS: ufs-ddr and cpu-ufs.
> 
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> ---
>  arch/arm64/boot/dts/qcom/sm6350.dtsi | 7 +++++++
>  1 file changed, 7 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

