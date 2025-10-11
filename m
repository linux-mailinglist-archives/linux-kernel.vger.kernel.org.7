Return-Path: <linux-kernel+bounces-849202-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 44343BCF7FF
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 17:57:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3D4824E1E3B
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 15:57:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C33B527E1B1;
	Sat, 11 Oct 2025 15:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="MStmPpZ4"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99EEA277C9E
	for <linux-kernel@vger.kernel.org>; Sat, 11 Oct 2025 15:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760198217; cv=none; b=gZLyCPTEJ77/4gMn9MMb1owEzZnI068hTMxuetDYBSFBylmPCTu8ttgalN+zG0Wup2MHATO0t0P5OFK/rPYQGIHTVSCSun8/TKy4zPqDuP6rNDFL3CcoZiy8Q0iQ0TFmFCmIPBAytz/qzsJOevQTGaZ+DXklbo0ub1zHj3Kp00g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760198217; c=relaxed/simple;
	bh=kLZpOY3n1Z/K7XxdlSQiFTduuS6/5SC0CiM8PVE2Bv0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NaUMZGNjrzymOkEd11/syp70+bR/7DM6EdxI3VhKPQFkmaa2qKHipGgeYEJmTuiv0pXpgbPdz3Boq/1fBssNkxGSf5mYNGXRblLshtJAop6bv3GoXC24IS+WTuMq2QJSQWgU+m23Dd9vE0II7/wMZ6FTPSZSu8JcyppwY078yjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=MStmPpZ4; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59BDSu39002909
	for <linux-kernel@vger.kernel.org>; Sat, 11 Oct 2025 15:56:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=SgSlMXYO2I/LhunZZinSNKre
	mdE+cTsZbKFJGYD8eac=; b=MStmPpZ4xur+UfapQ7+BbFWX4nOGFBIMNQWzt9jz
	SJPBQT/MaZTIJghdLTHBznPz7a4lkgfzhPiy48NWxcNhmNYQT8IvgWb6VzjLEEIX
	t+zv4BUVFX2i8Y+ugkhv0YgVFzO0ePnr5OCxBKny1G286ovvgeI4vFnadjKjAq6E
	7UHjiFJDUQW9M99Sgpg7Mt50uwhfQIMGe6QoMTLI2PNuIUCXOD8pBxWyui67xaVa
	NnWjmu93AWjihJF0UIOvC9jfJwuKT5KzpsJMkI3d7KinJys5w+ny6Dwuj7ojdgEp
	YqPGJ7G6fG34YYrnEPUEeLApwyO4hJByFh4/SIb4ywK2cg==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49qfbs0vc6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sat, 11 Oct 2025 15:56:48 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-870d82c566fso1582554285a.1
        for <linux-kernel@vger.kernel.org>; Sat, 11 Oct 2025 08:56:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760198207; x=1760803007;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SgSlMXYO2I/LhunZZinSNKremdE+cTsZbKFJGYD8eac=;
        b=mDWMn+T16i3W52oJw8Smg2/LD3yxjGw8Uy4k8oIlncxsOyeZjlVCG+ksc7xAmvS/+6
         V4Kn/5zb4s1QdqMHTGHQBSVTscfaLY8VtWUFMbb58eEYJQCOLFcWGjo0sbEbt2heVihA
         QSmOSMh1lA8fS29hP5I2vdUnFaiFK2gXGxcA3lHTNs4OsKNEKjkxjmbiZ/Zhv2pJ8cSn
         QVQyRQuk7AqykhleFrE7Cb1neHAmBJ+MWEiNrCZRRx1alUZDo7EYXKPW32ZKc2IkJm1q
         YedSHPJfY9Q9Q5LtpZ23SFS1ERepCMFmClInTigLRztgepBGZp2y4UtRbZ79B/qhp39l
         ylxw==
X-Forwarded-Encrypted: i=1; AJvYcCXNuJoslMUpCXroyInmFPCysrBSm8MjJ0aB8qf4jz3p43oR1gGu5iCijqDLCCo+QTyHb27n1Jzj7dHYnYI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzClZdOASJet7WgcKVoYGzYaPoGpC3JMudfDeBG6AXeDVBgZjQR
	oIlYt2ygKbRgLV7oEmIMT4GAurufwjAl3bOiTRJDIzuUfGgDS0z2vaMtiyHAuazg9nOvTPa0iFd
	l5kcCwOomzkX+D6nK4yP/o5Lh867DvWzlzyMbUIEh9R6Sitw38VCwNwAS8x0bBMbC2ec=
X-Gm-Gg: ASbGncu4hv4dThBaZc7CQBMAzKJYMtbCTunpDb36V86AOrp4tA84hCi0u4CeueLmuOB
	cXaNxkDh+VH76WFtqLLltFZBk6g2JRWcd30WKzHSenX92TJ54FfjiKlcFqte+Zg5vsh9pqByun3
	t3WdOOCQ6INxFeIMs6cmuHCtkcMWbk1UHdBOWDiSSGO6Pjbqr0F3xFAwomGrBo+eKTWne7NmjiA
	zabmyjUzQ8E/BgMm6tjw6gjDAiNboyqFqeMd2DTAZ8iroWq2w3JgIEYBC2P1/ttOsRNChLh+01S
	dLMZjFG4x4evh3xPRmkBBCW+iMRDNJLx4lOd1bX3BsPODtTIKGRwTYvy+RPRNbI1SCE0FYFDUXV
	uiT6Lfz3Y0P6wNZpks9rT1Oxr9a5hvQvK31ioTBPV860BixXwkfNm
X-Received: by 2002:a05:620a:7085:b0:858:9d54:e899 with SMTP id af79cd13be357-8820d18e381mr2693140685a.32.1760198207505;
        Sat, 11 Oct 2025 08:56:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGF4e8oE9a8ZlZe6MjQVUbFU5Qz1czZ4lPLXspIfK2RqqFUrTfptrIWkI6x337JAbepIphv4Q==
X-Received: by 2002:a05:620a:7085:b0:858:9d54:e899 with SMTP id af79cd13be357-8820d18e381mr2693137785a.32.1760198206913;
        Sat, 11 Oct 2025 08:56:46 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5908856dfe0sm2024644e87.91.2025.10.11.08.56.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Oct 2025 08:56:46 -0700 (PDT)
Date: Sat, 11 Oct 2025 18:56:44 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Abel Vesa <abel.vesa@linaro.org>
Cc: Pankaj Patil <pankaj.patil@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>
Subject: Re: [PATCH 09/24] arm64: dts: qcom: glymur-crd: Add RPMH regulator
 rails
Message-ID: <jszx4ztfjbjdxgpslfqbpl6urnvnqqp2l32v2dcrez4j4ngdi4@y5nsco67e5gb>
References: <20250925-v3_glymur_introduction-v1-0-24b601bbecc0@oss.qualcomm.com>
 <20250925-v3_glymur_introduction-v1-9-24b601bbecc0@oss.qualcomm.com>
 <sean5dkqku4norpl5llaps6wd3qjcxbb5kodjgvh4dshjkqvt2@jtlqhser6hsn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <sean5dkqku4norpl5llaps6wd3qjcxbb5kodjgvh4dshjkqvt2@jtlqhser6hsn>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAxOCBTYWx0ZWRfX6dX+914Me4Po
 b57WfdB2z/0PIVXzFM4IdytYbaFsB23w/YVVypqdFtzRAkDwBR3kQ2Nh1kGNuxiqMlUDVRNsr/4
 i9Gyoy+Mi1FrYRVsJ/YR1N0wos6OWXJosuXg+e4acc16PYLpZqJywhSJ8ILKO7BLnL/odS9ST8X
 Ai2J6e/b/70ss3j7xRTmn5XmbgCSHkG7hr1ZudXPxEeuJuaLlFArptUu7VhgFPvVyYl9q1zCGub
 C4ccZPgjX7GUU+XnjvyNVEFF8Ptr517+sNaa3WjlSfJgu6+4qFTikI1PYNutpuYAjTwEN9E9iev
 SVW9vnw0lHC/rArljqrFcZWwObPwv6NMQZSQWd3jEAjKOlQWpPHXTiogOgJa042fJoEzajNvPF/
 +TAoOsbYBnbb29ymrUn73JWTy3by0w==
X-Proofpoint-ORIG-GUID: C98z8jrvks1Ftl9N-ZrW5GTRoIvnpgDk
X-Proofpoint-GUID: C98z8jrvks1Ftl9N-ZrW5GTRoIvnpgDk
X-Authority-Analysis: v=2.4 cv=U7SfzOru c=1 sm=1 tr=0 ts=68ea7e40 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=gEfo2CItAAAA:8 a=EUspDBNiAAAA:8 a=7HhUDsceNTqC75YT8XgA:9
 a=CjuIK1q_8ugA:10 a=NFOGd7dJGGMPyQGDc5-O:22 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-11_03,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 priorityscore=1501 impostorscore=0
 spamscore=0 malwarescore=0 bulkscore=0 clxscore=1015 adultscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510020000
 definitions=main-2510110018

On Sat, Oct 11, 2025 at 02:31:27PM +0300, Abel Vesa wrote:
> On 25-09-25 12:02:17, Pankaj Patil wrote:
> > From: Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>
> > 
> > Add RPMH regulator rails for Glymur CRD.
> > 
> > Signed-off-by: Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>
> > Signed-off-by: Pankaj Patil <pankaj.patil@oss.qualcomm.com>
> > ---
> >  arch/arm64/boot/dts/qcom/glymur-crd.dts | 332 ++++++++++++++++++++++++++++++++
> >  1 file changed, 332 insertions(+)
> > 
> > diff --git a/arch/arm64/boot/dts/qcom/glymur-crd.dts b/arch/arm64/boot/dts/qcom/glymur-crd.dts
> > index 4561c0b87b017cba0a1db8814123a070b37fd434..e89b81dcb4f47b78307fa3ab6831657cf6491c89 100644
> > --- a/arch/arm64/boot/dts/qcom/glymur-crd.dts
> > +++ b/arch/arm64/boot/dts/qcom/glymur-crd.dts
> > @@ -6,6 +6,7 @@
> >  /dts-v1/;
> >  
> >  #include "glymur.dtsi"
> > +#include <dt-bindings/regulator/qcom,rpmh-regulator.h>
> >  
> >  / {
> >  	model = "Qualcomm Technologies, Inc. Glymur CRD";
> > @@ -66,3 +67,334 @@ chosen {
> >  &tlmm {
> >  	gpio-reserved-ranges = <4 4>, <10 2>, <44 4>; /*Security SPI (TPM)*/
> >  };
> > +
> > +&apps_rsc {
> > +
> > +	vph_pwr: vph-pwr-regulator {
> 
> dtbs_check gives this:
> 
> arch/arm64/boot/dts/qcom/glymur-crd.dtb: rsc@18900000 (qcom,rpmh-rsc): 'vph-pwr-regulator' does not match any of the regexes: '^pinctrl-[0-9]+$', '^regulators(-[0-9])?$'
>         from schema $id: http://devicetree.org/schemas/soc/qcom/qcom,rpmh-rsc.yaml#
> 
> so node name needs to be regulator-vph-pwr instead.

Actually not just that. VPH-PWR is not a part of the apps-rsc (why is it
even there??). It should be a part of the board DTS.

-- 
With best wishes
Dmitry

