Return-Path: <linux-kernel+bounces-754682-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ADEADB19AE2
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 06:49:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4EED1756E4
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 04:49:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 897A22135D1;
	Mon,  4 Aug 2025 04:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="g7eiM1y5"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EE1D10E4
	for <linux-kernel@vger.kernel.org>; Mon,  4 Aug 2025 04:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754282986; cv=none; b=CD6jMi1ddgR4sDiKLjB2BIpgQU7irpoVjzLas8xRlNbXk4BJee8+YXYSFCR0E/DfGlxE6mOWtyth9z9WPEwKWNLUZSLd4xQSigF/BUIF3ow0DU0o3IA1aPz1GNEEwTdq8tf/6+NCRhOffXm/3W/69GoanJdWLgzp92kgCsdJ/Ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754282986; c=relaxed/simple;
	bh=0ltsV4mWvJmUpf/h8E1XC7/gt4iYXwt23Cs/5n8Rjdw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PXHghYiVyZgjjL/uJZobQR1qywCqX9sgWA9R1vh3lcL/DzWgH5Re6IgVMdXfslnPdmvMCCPvK+r+tNMyIrU5/rr5udp/g2IsPjPAFxWB30ifhK1gYam/ZxuC+HTLd0MUl89h/Gqo/kwVO/zvGl1KjwwJgVnrt95TKh9jy6kou8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=g7eiM1y5; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 573NwDIX012229
	for <linux-kernel@vger.kernel.org>; Mon, 4 Aug 2025 04:49:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=7Yglzp+yr4eKtq6gEDEP5fa6
	YZypOJLaqkMYl6UIZkg=; b=g7eiM1y5O/gIMYLOM748dtFF6sgsQD7aG486JCJa
	uBkwY8WfteAbZIH95pEwiQQd1PtY1yEb3zBkLdNfbRmd1+OlQl813xqdyVbSVgHZ
	2Y0xPIxXj+ALbWW8I2h1xR0IhI+gSptZp/NU168tZkrvEIRs4n6oyeYK9LFwvcSe
	8fH0G+9Fj1+NycxDvQ7stY5p5IKDFe5jLYxTtji+ioQ6wOZn0ednUHoeeMrz1Z4y
	/WJZNsOXeDtK9XNFxJZVDGSoX3EaQgwzOXcFEsaeVq2G/TPYE5YAjdcOc0e9K/I2
	5pWFdV4+Rg+oP76TWRJ7ylTk1CGComuikXj8XR7hpjR/Rw==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48981rkteq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 04 Aug 2025 04:49:43 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7e32df3ace0so275881885a.0
        for <linux-kernel@vger.kernel.org>; Sun, 03 Aug 2025 21:49:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754282983; x=1754887783;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7Yglzp+yr4eKtq6gEDEP5fa6YZypOJLaqkMYl6UIZkg=;
        b=StHVACoiygmKYs9Vqp1APUWWW4TZ4YfpR5FSItfQFBwazAXidwLUJtK8nns8P8qJTa
         XK4fSIO5yzMybmVpyxicvTiKtvZuW4LQXsnRMI1i073MkkEL5ZKygho1jmxNoZB5/NmI
         bG53gBl8F+Rd6Dys6IPjabryi6KgY9Zaq82JT9VaOpUCByutRWcLlrYU/F0c44yl5tfr
         2I5Yzr9d1FGeFbi/9AZ0t/5jIvkzzvk0AcHFR15prt1j4pzAYnE+jkQtUdXPhJeYegUp
         yDwN7yUhxDARpf0Y1SnVJB2TNUaz1B+L8Xu3J2iCqnnxqR0v4pF8Y0s/O+dFajBjbj0B
         NTjQ==
X-Forwarded-Encrypted: i=1; AJvYcCXG0g0UcysTzKDAOq0ptarOMGEDIg6lNPnCJeSuEs/VpvlZji+JfitaEN1agIPMcJpQHZQsPpUh5zsJmkk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyv8nLbEqVlwVJcnjHSf0r5QYUrfBDcbf5j+LGDUOP+N8p6LIpP
	hmb9wQcyy1YlRnO+Soy6bKoNiR/gyK8XXAhM+Igd1Gh/AwERlu5x7UYCHuVvrLpvrrIdn9czFw4
	T7Rrk60FZPcRJVQauuSrvbawwP3Yjy7UK06Mgbn4z5rIvJnjWkTxa+TvhGPBam2ZrDbE=
X-Gm-Gg: ASbGncs8iqmHqbuZdlNPUoC7GKVD9uVaEQGMciA1P2HkmoYqsRQ2fibiZtApIBSFHqZ
	mjYyKpuG5vYjNIAUoPfdkqz9UvI2Wp0vdr6Mcfv5pFOF5sdWSMxBhlkvBIiQF/DdQxLPwmPN9nh
	kMz941DDgXBVREy920J46D7Qe40fHsj3+WTn0ZGhcyeEeHJ8KtGu4dQugpmNTWtt5n/pU+wti4d
	S8dIzuYtbMlM+rV9Vs6CIjwEag/OHdBIbOZVu0xIohi2n9nYCegVXUez9mc77GechXbUCUPXKiY
	IvZgdGg5Lg6S4JA6zKHcLbpzYGx0lodFJYsBbWchpDdgijt7yP81xt0/KVnCyRUlhy5KbprwBsR
	zM5Hkr6P/yoiVS5A7JJyXvC+cHBOt160sqWB9/Zy7z84fT3dXyH6J
X-Received: by 2002:a05:620a:36c7:b0:7e6:5e9d:f8e6 with SMTP id af79cd13be357-7e69629dbcdmr1106345285a.22.1754282983180;
        Sun, 03 Aug 2025 21:49:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHzOqo7RSMXHRYDfEyQ47x4B+Pz6jpUX0s23rEdmLa1EGEICWbN/mAirTNdrgCZnMomrjhq8g==
X-Received: by 2002:a05:620a:36c7:b0:7e6:5e9d:f8e6 with SMTP id af79cd13be357-7e69629dbcdmr1106343785a.22.1754282982745;
        Sun, 03 Aug 2025 21:49:42 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55b88c98c15sm1529094e87.106.2025.08.03.21.49.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Aug 2025 21:49:41 -0700 (PDT)
Date: Mon, 4 Aug 2025 07:49:40 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Yongxing Mou <quic_yongmou@quicinc.com>
Cc: "Rob Herring (Arm)" <robh@kernel.org>, linux-arm-msm@vger.kernel.org,
        Kuogee Hsieh <quic_khsieh@quicinc.com>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        freedreno@lists.freedesktop.org,
        Abhinav Kumar <abhinav.kumar@linux.dev>, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        dri-devel@lists.freedesktop.org, Simona Vetter <simona@ffwll.ch>,
        Maxime Ripard <mripard@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        David Airlie <airlied@gmail.com>
Subject: Re: [PATCH v5 3/5] dt-bindings: display/msm: Document MDSS on QCS8300
Message-ID: <aiaonlbxwzbpuvnzijzp7btf2oxvtseq7zoylopllooeqshmux@unhoejkdyl6v>
References: <20250730-mdssdt_qcs8300-v5-0-bc8ea35bbed6@quicinc.com>
 <20250730-mdssdt_qcs8300-v5-3-bc8ea35bbed6@quicinc.com>
 <175390746243.1660386.11206814214268936734.robh@kernel.org>
 <cdbe1013-4f15-4638-870b-151292920ce7@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cdbe1013-4f15-4638-870b-151292920ce7@quicinc.com>
X-Proofpoint-ORIG-GUID: Of7C_cR-mr37iW-iL_qMw0MF1KDY-_UX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA0MDAyMiBTYWx0ZWRfX7sKtB3JmnSV0
 LGnZAYtMDxwnnnKqiQTUwkXFKa/3LxB3rBNlC08DrhHKlORjMvsR0EhKfwRQ3tUtFDNATfGZeNv
 xRazSvyawTQ17L3PsiVFrWsp3ArB72nErGK51TXNIEG4TV2dhqkHUTrRPpJFIEAjirqxkjkZXWl
 Pe1kFmgQaoOh2TZCnN+7NLVjK8yZjzaKqvzimko/tvZOURzqcg34NSGbZ1RlGB51lFNGGAj6u0w
 V4oy6n9E6CQB+ldHWuUd8+lbp2MP54/wKfMklTSNV2+iupoOvfjvemU8WxgP3/RpYAkU1ny0epd
 CE96Ov9oAP1/4vXa90KRtVU3eoLC8e2EYvheNSHP/JugEforUJjYR2wYhuy2le6M6h47JWJN52l
 8ovrSCdsVAGc3t0T2HK/5ok4BeFcOfMeHAgiswqEnjFG2sxI+ru0uQ8CyingEt35x+tQNbBK
X-Proofpoint-GUID: Of7C_cR-mr37iW-iL_qMw0MF1KDY-_UX
X-Authority-Analysis: v=2.4 cv=a8Mw9VSF c=1 sm=1 tr=0 ts=68903be8 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=gEfo2CItAAAA:8 a=voM4FWlXAAAA:8 a=COk6AnOGAAAA:8
 a=VwQbUJbxAAAA:8 a=Wy_ckEHB4fXvzh_zUiEA:9 a=CjuIK1q_8ugA:10
 a=PEH46H7Ffwr30OY-TuGO:22 a=sptkURWiP4Gy88Gu7hUp:22 a=IC2XNlieTeVoXbcui8wp:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-04_02,2025-08-01_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 bulkscore=0 clxscore=1015 phishscore=0
 spamscore=0 mlxlogscore=999 mlxscore=0 malwarescore=0 impostorscore=0
 suspectscore=0 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2508040022

On Mon, Aug 04, 2025 at 12:00:39PM +0800, Yongxing Mou wrote:
> 
> 
> On 2025/7/31 4:31, Rob Herring (Arm) wrote:
> > WARNING: This email originated from outside of Qualcomm. Please be wary of any links or attachments, and do not enable macros.
> > 
> > On Wed, 30 Jul 2025 17:42:28 +0800, Yongxing Mou wrote:
> > > Document the MDSS hardware found on the Qualcomm QCS8300 platform.
> > > 
> > > Signed-off-by: Yongxing Mou <quic_yongmou@quicinc.com>
> > > ---
> > >   .../bindings/display/msm/qcom,qcs8300-mdss.yaml    | 284 +++++++++++++++++++++
> > >   1 file changed, 284 insertions(+)
> > > 
> > 
> > My bot found errors running 'make dt_binding_check' on your patch:
> > 
> > yamllint warnings/errors:
> > 
> > dtschema/dtc warnings/errors:
> > /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/qcom,qcs8300-mdss.example.dtb: phy@aec2a00 (qcom,qcs8300-edp-phy): compatible:0: 'qcom,qcs8300-edp-phy' is not one of ['qcom,sa8775p-edp-phy', 'qcom,sc7280-edp-phy', 'qcom,sc8180x-edp-phy', 'qcom,sc8280xp-dp-phy', 'qcom,sc8280xp-edp-phy', 'qcom,x1e80100-dp-phy']
> >          from schema $id: http://devicetree.org/schemas/phy/qcom,edp-phy.yaml#
> > /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/qcom,qcs8300-mdss.example.dtb: phy@aec2a00 (qcom,qcs8300-edp-phy): compatible: ['qcom,qcs8300-edp-phy', 'qcom,sa8775p-edp-phy'] is too long
> >          from schema $id: http://devicetree.org/schemas/phy/qcom,edp-phy.yaml#
> > 
> > doc reference errors (make refcheckdocs):
> > 
> > See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20250730-mdssdt_qcs8300-v5-3-bc8ea35bbed6@quicinc.com
> > 
> > The base for the series is generally the latest rc1. A different dependency
> > should be noted in *this* patch.
> > 
> > If you already ran 'make dt_binding_check' and didn't see the above
> > error(s), then make sure 'yamllint' is installed and dt-schema is up to
> > date:
> > 
> > pip3 install dtschema --upgrade
> > 
> > Please check and re-submit after running the above command yourself. Note
> > that DT_SCHEMA_FILES can be set to your schema file to speed up checking
> > your schema. However, it must be unset to test all examples with your schema.
> > 
> This warning need to apply this patch..
> https://lore.kernel.org/all/20250730072725.1433360-1-quic_yongmou@quicinc.com/
> thanks, link in the cover-letter seem wrong. and there is an unnecessary ~

It's not listed in b4 dependencies.

-- 
With best wishes
Dmitry

