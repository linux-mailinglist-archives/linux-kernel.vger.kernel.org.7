Return-Path: <linux-kernel+bounces-781770-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AC99DB31684
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 13:42:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E3201C8183C
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 11:42:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2BD72EF657;
	Fri, 22 Aug 2025 11:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="OiaUG0Bt"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 029F12F49FF
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 11:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755862950; cv=none; b=TUS44sNF9U04+rCymKsqSZ6zUIiYcVQI7KYmPXgyJZBXJSPHhpr/3+MTsBCSpTzbaZ0udVeEQ4aA1CPz+a4o0anOo19ANO/eoVGLPiu8LjPw+PWh332hr9jIWSfQlzLpdF97jqKM8mqSspmR0Ka3fk5GGqIooBKd8ZdhlbZB0TI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755862950; c=relaxed/simple;
	bh=3o+FmQxfh3Vqu+734KWY67K1eSRB0PrsBChmW5BJDQI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fbRQayXFvjuFWtL/QtMHVehwxTEHiP5iRZ9LRD+CpxtNBtXdDCPhZWQfantlrtKkOJG/WTgrbP3gkPm9mhWwuyqlbkq44mHoD2U63HdPnI1SWMr8wajybweVy8jljuSaCwP9b3cp056KkDPLVwGE0o0G4h0OM4zAgxr68ihvcTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=OiaUG0Bt; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57M8UWBT021853
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 11:42:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=KAhSD2vjv/ePHUmD+gzyEEp4
	2L2WxYKoMwQm05Sn2Yc=; b=OiaUG0Btg4yL0nRWgSNlhwZClARkvbc61cx7zd60
	ACHg8wc7y11jD3eOM/32pUXH+TVk8km+31XcXZjI9FSulMPjp+t2vo5CuE1EPTc/
	XJVsEUCoRTaafNgdnv/eSPRvzLpVkMczXOoMoj4hZARV8yJOGV/AZL8F63otkVpA
	z0DppPkqHX413v8iMPvxF2ZqVDGWZ9nwDGzC1E5Zm20V4bz8r113YK4RrDj7VChB
	jpte2SnZs5FytqPkJObC0CkPcLRz30JurOImTJv4Bz0bwS2OcshjVku77l+H8s5s
	RXbqlJ4FYde8yKvsJ7zOnzJCullQPwo+FJdEU03xA+rPDw==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48n52a938j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 11:42:28 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4b109bc5ecaso57460741cf.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 04:42:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755862947; x=1756467747;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KAhSD2vjv/ePHUmD+gzyEEp42L2WxYKoMwQm05Sn2Yc=;
        b=tyeh/1mTkIccCoZn+7zCh4Fu+zkZw6zWbvpLMlKQtoDQNJe4SnmmJ7OxwiSQndDhi/
         UnvetMFhenILnAfSYgPFsL0aOL5lDrNJXa2zuKW6fD+grg2Ken4OT9/oMTmvyAPuNCKe
         0YHZnWl7CssNA2e+0bWgOou6/u6gFe7/jLPSav7hgtSqtNGEz6LnfP302gn4xE/z8QRy
         gFB/RFpvC000hpCnu6rotE3A4fdjx5FlOXe7axt9uEgn2MtN7okst30BAmMSO+mgdlSD
         o5wrLEfj4VC1yb78v5IORa/OMm75Z24J0l3jtSWM4apev3mbQroDzwDCHqrAQHGT71ML
         g6eA==
X-Forwarded-Encrypted: i=1; AJvYcCU/gxknyVWzexkF1LYJ1x4goF5tW9yWOQHgaDoqTVNtumnlg2I93VF9SypwQ2fpaHxUoAdhmi6mwwrraHA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNN82plIBuBH+eMLJ2SPdSm4KcYquuIYltTRE66Nl0IZwwkrOc
	cW4cR2goGTgFAFjVXmpNtcd8J7bWWDPbDjbVbEET5UZ8sU4h09K4Rz4Uk7oxKivfJoskm5KFDFK
	CoRR7Nu3RoRw5sl/a/L2/l+ei2u4k+dFbbKlAj+eQ50+pa+p2IZvYYASb9oyYGL8N0eWRajjqfj
	E=
X-Gm-Gg: ASbGnctd6kIs/+DnSyEm01C+4qblTOWooXMlCDUVrqjvW2XWvM5VIJFW06Phju946Fz
	+0c6q03sSeRCSpjqu0xFVn0YPN2LFAOUQFtP2J5+Wbha4cCeCHMzCZw64/vtlmr3oYYSofn9U21
	+7ZDAT9PgizLgT6qWR45MaGEB2bRDu7FC3rJForYPRVG42jlmI1XpEg/V5zdyrgI1rF0ko2TxtB
	MJaslWXXYg/sYw6AwXYFPexMkiIb/O+kkYDPq1IHr8CNkhYIOQnDoL9243onpeQ2iqvKX3FtfJL
	+CfzAaxPrHMFk/CHLYWB+z2ozbRdfVZIjFBrQbCkLEqWoVacJtzlp/TTmhkQHhWvq6XgEYq95aD
	IR/gZEk7E9suAUjvr9NHusmjYfX4tivUUySx68ZZaC5nH2wU7NbM4
X-Received: by 2002:a05:6214:628:b0:70d:47a7:72cf with SMTP id 6a1803df08f44-70d97124af1mr30644876d6.24.1755862946599;
        Fri, 22 Aug 2025 04:42:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEDtB7Zynj/rf/xXI0GvnluKkqYde7D50ORiC0miS2xPMWbtzXkTpNJzvnsT5Gfpb6b73VP8g==
X-Received: by 2002:a05:6214:628:b0:70d:47a7:72cf with SMTP id 6a1803df08f44-70d97124af1mr30644576d6.24.1755862946133;
        Fri, 22 Aug 2025 04:42:26 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55e033fc2e8sm1537277e87.59.2025.08.22.04.42.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Aug 2025 04:42:25 -0700 (PDT)
Date: Fri, 22 Aug 2025 14:42:23 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Cc: Sean Paul <sean@poorly.run>, Konrad Dybcio <konradybcio@kernel.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Connor Abbott <cwabbott0@gmail.com>,
        Srinivas Kandagatla <srini@kernel.org>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Gaurav Kohli <quic_gkohli@quicinc.com>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v4 1/6] drm/msm/adreno: Add speedbins for A663 GPU
Message-ID: <atomptaspsr7cfmqs4v3lr4lgeufbwq7jqz3lf72r2rxhv6emg@uhx443xvylz7>
References: <20250822-a663-gpu-support-v4-0-97d26bb2144e@oss.qualcomm.com>
 <20250822-a663-gpu-support-v4-1-97d26bb2144e@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250822-a663-gpu-support-v4-1-97d26bb2144e@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=feD0C0QF c=1 sm=1 tr=0 ts=68a857a4 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=EbwLtv1J8F1BF5yYxN8A:9 a=CjuIK1q_8ugA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-ORIG-GUID: LvUkVPCm4zMRegnaZlcItDBs-6qxD6AN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIwMDAxMyBTYWx0ZWRfX8z2jgRWje0XY
 lul8czwNo0svK35g9YEU0/K5fjcCaoZbnONqs86gJ2VWLD+2nhpTY2NGMdbFFbyAP6wflxV70/F
 cWV9kk4x9Zbwq8m9WgCHakkxmTlLZjMM7EbP+hNGMux4BCzoTb3mYqRg+UT/WRpQ/bVp2P5Z1yj
 R2H+EJOQkOO92wluCTgKPEHg04Zy1mcxUHH9D3OivzJiwEY9Pb1FtXeD5709qH0Wic5jwh0QU4m
 zB4tIORXhCVqkdjD0l08RaMggAASR8QZEJKwVqdupF++pXtyScnI4pB/Z0kVGaXEkYOZcjeqF3a
 hGDRC+Dj5sUkSh0hebtbi4Jadn1mAuzeq6XRWqOX0mjard5mrp80knfS8UnG8RtQhcgexsI7mlN
 VsxoHHmArrF88sDEK1v/ifGCWC0b3g==
X-Proofpoint-GUID: LvUkVPCm4zMRegnaZlcItDBs-6qxD6AN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-22_04,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 adultscore=0 malwarescore=0 bulkscore=0
 lowpriorityscore=0 spamscore=0 impostorscore=0 suspectscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2508110000 definitions=main-2508200013

On Fri, Aug 22, 2025 at 12:25:26AM +0530, Akhil P Oommen wrote:
> Add speedbin mappings for A663 GPU.
> 
> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
> ---
>  drivers/gpu/drm/msm/adreno/a6xx_catalog.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

