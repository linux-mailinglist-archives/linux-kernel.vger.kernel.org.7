Return-Path: <linux-kernel+bounces-829496-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 844DAB97351
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 20:32:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3EFAD3AE646
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 18:32:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70B40301712;
	Tue, 23 Sep 2025 18:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="es8n5gGP"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3254301020
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 18:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758652365; cv=none; b=bC6UThXZPycItwiqltncHfUSWVy4j0hhDTnyVwvphtaZjkazI+9AK7Z2Qlw951GXiEjCij8OGrN+/tg5t6G1R8b7RtwkQxvzxnxCm4MAgL+smf83f6gbEd3AyC3Kwcz0yALYOze5UVxyMoiVzHA99CWdT1eOQtTz8sgNdvbmuC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758652365; c=relaxed/simple;
	bh=xlUwMom0yQylASsa5GD7EC+5DktGsdejR5nEE2JCl+0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ME4SQFYw6LvNBTg+UA3xN4uBJl41VrLQaNDzDom6GbJ82XEhoVOiZgwht8Eobw7FbBmtvSkxbvW8NCMMFUfuN+BV93S2yz4dlKv9SPS+Z4+XAR6CTX4WbEmak0/iqefqv9eie7Dd3b8VqYlX3BNaC5L4GfNcZO0i2K2QPvIpiMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=es8n5gGP; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58NF6lJp015045
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 18:32:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=0ywgl4YoydNFbxN0XRqWFqXQ
	EgLsb3KzEP1PoHIEnTc=; b=es8n5gGPQGrm5R6zA26WUXGLiyn821zeBMRxFToR
	CsxJJwtQ1/nIDVBeRUJTHoIf1vHpSgBUAGbePMCfqvfDwYwYgWVP3C4h/lNtAA1s
	ktpt8/NOEPxpn5hYTo24YMoWhniTHCq7LrznEm4REwmA8qD7TRsVSVUhIkUchWxG
	Z15SDM+n25tv6Oe+VEeBujJEQTsyIcB2VejohYt4/MDHFVVXds927/VFgG+7xCup
	mPRuOZ2eARdaCyDvkE+POTNdL1gP/D03SaSDCkt2m8WAbgiNtTk/nWwX2lAy2ORq
	X4URjki7i4uyh7gsyhBosT5L2b41fF1Ph47LWDq97IIg0Q==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49b3kk5kve-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 18:32:41 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4cdcff1c0b1so55721771cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 11:32:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758652361; x=1759257161;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0ywgl4YoydNFbxN0XRqWFqXQEgLsb3KzEP1PoHIEnTc=;
        b=FtGHmYxrH9IwVu/MDo0Ltrq74pCEwpnwKVeA9i3qqySBavqVduUW3DtksgsjVO2jq9
         2wW147CS2nkm6EHxSj+rrMhGzJpzXKo6GTrLGueGKUx3JElsVvlA9EAyu6YqZ0B+dMne
         EvUOdxxhi21DGKObdydh7DUZKtz4ICVKxRqlxOrUvBGZb3GygbALlnBbkq8VQKZKF8l5
         B7zO505ESkPCXrGaNkb0Wbm9sJvAGg3YpqxJ3tJ4QuCfCyY+Wuqkuzih4BujTRKbwzrS
         Gl8P2wdCLP4yzEpRsuEBsl+GPI6fWb9TyMQg23cD1f4zxCgZ2nhawgg3D9LM6ZmJMBTW
         TNRw==
X-Forwarded-Encrypted: i=1; AJvYcCXX2RHDSwsi228XE4wTN/CzjP2a9tI+S6c/teNe6ZcEjZklUNYCZcgi0/+R9IiMNt3rUAqVHoB3vHXWNS8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4Gi07lpwU8mNE6dJr0ov2TNwNhIv073Cru5ZW2XjP8uOs0gzC
	sWUK6+R+BgfjNrM8woFrD1p7coaGbgU3VBce1T/cNJiY1mISbonDeHTrmHr/dzKIwbsp3POlk67
	Rn9KjqcBKxSdLnwE3y+Uhf5BqtydCWd+o5I5k+uatUZ7W3quSg90NYyMP6dvQaOdFXss=
X-Gm-Gg: ASbGncuXXJdBElwVqdZ+RKOkw8wqjaTC7gjWRJyDauo25VcBbaa3m2nsyOHxsw/aADo
	0SKGwoWDhyNK5fz7xZgcXUXh9baBLka2T/CdkMlN/qiPzUdyTQGBi8VNMWLf0Wec13V7VxNJaCg
	lDv841LJin1H0QuthjgXViUNa5cn018+eD9S1G39R90B0kUx0E2mdM0eZPLDLWaXVHGxif0AfGi
	dIKzojNPeTtMMwxjeWAy5QfQ+zBcBx/0yj5rz2IheS3kL2yDoKXSyqBbOFHN/hC8laUwDOdeNwz
	XCFBY+KunJNenOVzeyPj7jjQhfgQZD77qcSiLEoa6UEXm3sAcjQVD1fPttmHKWznoNYH+/kM9Jq
	vOUHm2o8C1DVWNeLxKGyL7xmkeJ4xpKk/E5UcPryUBNqd0gTVk0kX
X-Received: by 2002:ac8:5f8f:0:b0:4c3:a0c1:335d with SMTP id d75a77b69052e-4d36b898548mr37820391cf.37.1758652360607;
        Tue, 23 Sep 2025 11:32:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEMBlvHXtNDgFyPI1NlAGqjKTycFvFqD7+JE0+3TxE26+LvFO3cH0FAg4wxgHNuHH6UPT3b5g==
X-Received: by 2002:ac8:5f8f:0:b0:4c3:a0c1:335d with SMTP id d75a77b69052e-4d36b898548mr37819791cf.37.1758652359989;
        Tue, 23 Sep 2025 11:32:39 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-57a0ed3d148sm3565534e87.84.2025.09.23.11.32.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 11:32:38 -0700 (PDT)
Date: Tue, 23 Sep 2025 21:32:36 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
Cc: andersson@kernel.org, konradybcio@kernel.org, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        mukesh.savaliya@oss.qualcomm.com, anup.kulkarni@oss.qualcomm.com
Subject: Re: [PATCH v2] arm64: dts: qcom: qcs6490-rb3gen2: Add firmware-name
 to QUPv3 nodes
Message-ID: <kijycy56wjgztfgltj773opeu7zc2ct32msbfioliliming6im@r4imwgdv3x2h>
References: <20250923161107.3541698-1-viken.dadhaniya@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250923161107.3541698-1-viken.dadhaniya@oss.qualcomm.com>
X-Proofpoint-GUID: ZdhK8AxI7fsbNqaR-N-AsjSxg_iFmxL9
X-Proofpoint-ORIG-GUID: ZdhK8AxI7fsbNqaR-N-AsjSxg_iFmxL9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIyMDA4OSBTYWx0ZWRfX9+HFKjT/s2NY
 wMQicD4fXih96ttooNFvVIuVvqdlHOkCRtmBgQVfTQdtoTm1n5WmOKip1Ei3YO+zA46s+0s/Erc
 0tdF70LFh7osfDuUhVjM68Bw7NXep9bEiH75RIx9M/r0IKVYYYFikI2zyz4oXfKscQwDJc7hF2x
 89ITeCoO1OkrrbNtpknEcEbzXatyNiGy+Yp43CV3jAHESB57YBVOb8wUIdb4uvHC7OMP+7GOi/6
 k6MtJVuvxiFjqm7UC9pV2kBl/xL5LvUyIdJpzD4+4/yjKfs+MP+sddGDXJA/grufaRBvniokzxA
 s1/tfk6xuMu4UC4sJwEGl/WuaDyMKvFE7sMIiiBfCOQYzn7pXaIEZpcPDfdjTMBeaUW8FaOIJX0
 y0hzAwr6
X-Authority-Analysis: v=2.4 cv=BabY0qt2 c=1 sm=1 tr=0 ts=68d2e7c9 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=N2x_zcOB-Zb5SKZ0QwgA:9
 a=CjuIK1q_8ugA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-23_04,2025-09-22_05,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 phishscore=0 bulkscore=0 priorityscore=1501
 adultscore=0 malwarescore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509220089

On Tue, Sep 23, 2025 at 09:41:07PM +0530, Viken Dadhaniya wrote:
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
> v1 -> v2:
> 
> - Updated the commit log.
> 
> v1 Link: https://lore.kernel.org/all/20250923143431.3490452-1-viken.dadhaniya@oss.qualcomm.com/
> ---
>  arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts | 2 ++
>  1 file changed, 2 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

