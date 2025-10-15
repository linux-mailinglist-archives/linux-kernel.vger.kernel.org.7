Return-Path: <linux-kernel+bounces-854804-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B358BDF6FF
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 17:40:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90CCC3C203A
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 15:40:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1091320CD5;
	Wed, 15 Oct 2025 15:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="fFifcm06"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B94032C309
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 15:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760542841; cv=none; b=Jzj1985KoPHfwgQgwnSjZGEjBbrxD64gVmfTiQ9TVKA8t1/xZZB7qBaEgDN++BB6jKjHOofjnxTVq210gkMzyAtCOZgDzWSQvQ/lx/KymIgz4TTX+dlRttDOLh9JiUV6/AZDzTAAUA2faRI4v8Kn1Y7qm3ax5fSpPjnD/tNQuuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760542841; c=relaxed/simple;
	bh=8yIzlOJSXfO6YXhbSck71FcfdlxfIEO0W1rlhZ3Foj0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rJfy/OClLYGvk4Y96Sqvd2qpss/HhxGKmLcLJnnfSWSF7dcZIfyqHriqq10SyflKrWdYNf1ETY2n+vRoon8LgwjWbp81uhq3GPmEsdDhDYepuqQz+JNK2cNDa70Yxbhc/jf3DeEyOGCt4pj7qOpTGgl+9azi9RtMXby3tcHLtX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fFifcm06; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59FAP1QN024767
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 15:40:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=v51xGGLBzfthpJ6uAG1FtfpT
	PpeQpU30JZDZNcynxBI=; b=fFifcm06MJtVgPqG3E+gCnYpVvRuDmp8Kd5uoQhJ
	KU8sxlsS/ZEY2VcwhzOQaw5i1Qtdshl/deNlyb8C9HL7eC0cQqMiBfIz+wje3iFa
	evnphpSb97MAd9bPeNhrZxG6HlnL530o9Ej323pF1JFTaBf54WAKcsbffE0ujUBe
	zZrvzCnoyKpJk33+0stXq639TgJd2N9UgnwjFHfsjKlaCifQlz+1yU14zd464FAT
	uINnJbFeeEXWLjF3ZrNXEMUfP00/kPcglhFjYRRjRPstwTQy7aQryG5+Sq+8K9S3
	v3GKHBAfFKsxohCoV8AEAKDVkeLxiTuhey1ErGpQ0gKqwQ==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49qff0vx88-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 15:40:38 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2699ed6d43dso112123565ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 08:40:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760542838; x=1761147638;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v51xGGLBzfthpJ6uAG1FtfpTPpeQpU30JZDZNcynxBI=;
        b=sGnsQALVHg29/lZq3aderzQyaE72jDEPjDUKztsM7Ifo51FCFReSjAv/rzme/IpOsw
         v8AwT3/BtJHNLooAEpwN7JgJvgLsK9j51Abok532yaBPQlpzxKHcsxwGsnhyhMKanhPz
         530uctou6vSmf+/Y3L3/KNfI6pLyTnxr6hWKbJEXzwrY0Qrso1WHymnmHFL6infTQ9YP
         0V0r8f/LU6bom2QMyKc1TL84ZqgdwsQz9DU2HPCvf6jdDQC0mK5I9dXn2ACG6YZzcmRn
         4nIsmyHdxBuKACS22YncH3q+Vv0i7PjLAl6CRA+zb/QHoPaYX/dlkK2R2Qq04ZnTdwQ/
         AEIQ==
X-Forwarded-Encrypted: i=1; AJvYcCWDvY840wygHcMjTlV895jNAmFBNBMfnTAPqQmlH1s4+lw0aptOxIZCQWPKKYZL+vDz3rAL4OUIM++/hE4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrHVBD+Tedi5IfChEfjwHSYRhzZrf1HVr41z+YOLcVz96Za5wa
	AruSwh0HZvB6BwA/6uvewXqd+T2YD3KhYhJYDN1v6SUcZvnjdhpR35QoJEI2iZ20L06ZztRq9SL
	EEna1X1pakz2LLn8X4qtMqH62tt5fcpJuVTPy7tfwW4oQph33j4i5/l4UgO5iZiRs4ZI=
X-Gm-Gg: ASbGncsttjT08NyGTmfXJaiqmbTDNrjIKTTGibj7XikLqiRwdOqKo6/HhhSCz/e0o1x
	9BhB/HiLpyMsTvWlfnDCP3CvXYg6tDY6JGLxDn3sC4Jbw5TbVAIk29lf1RQwKTc4pNyE8pdJwHw
	RhMUkd8JvezRZh8KPsnfqHd9PZK2sZVvGc5yAKsvkWkVgcmNGrM269TyORRrqyOBTiGnl89sM+R
	E2EPZxk8Sx6EDD4e3IfPo8KCooEkY0byytcLG9xjNV9nzye8XzVTgOLnxxnPq9CN7J+lA8QWAw7
	LPTje9Qvl4oRiYlut5tJvVQ67MoAALwdegfS/XmOIqCYj+R4M7lIpxx4wkjwiLz41IFYRRStesw
	DioPAFeLVXgOOG4IN7+zw078uNg==
X-Received: by 2002:a17:903:94f:b0:250:643e:c947 with SMTP id d9443c01a7336-290273ee209mr362922905ad.28.1760542837789;
        Wed, 15 Oct 2025 08:40:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH0flfR5h7EFdAnGkZA4xK4OhgMnYLtcfmupB0TvW9tUJ2NNuuPUm+lRnMe685BmxN8pgVIOg==
X-Received: by 2002:a17:903:94f:b0:250:643e:c947 with SMTP id d9443c01a7336-290273ee209mr362922665ad.28.1760542837307;
        Wed, 15 Oct 2025 08:40:37 -0700 (PDT)
Received: from hu-kamalw-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29034e1cbcbsm200774325ad.45.2025.10.15.08.40.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 08:40:36 -0700 (PDT)
Date: Wed, 15 Oct 2025 21:10:31 +0530
From: Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Pankaj Patil <pankaj.patil@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 09/24] arm64: dts: qcom: glymur-crd: Add RPMH regulator
 rails
Message-ID: <20251015154031.hbifj6khno3gi3mz@hu-kamalw-hyd.qualcomm.com>
References: <20250925-v3_glymur_introduction-v1-0-24b601bbecc0@oss.qualcomm.com>
 <20250925-v3_glymur_introduction-v1-9-24b601bbecc0@oss.qualcomm.com>
 <a49f3f75-c882-4635-9be3-a433b7fe32c8@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a49f3f75-c882-4635-9be3-a433b7fe32c8@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAxOCBTYWx0ZWRfX2KeY9MDWI6Jz
 MBRyW8on1+8bvbLjHeg/RARTWDN2GLERr6SKhA4+29NNy3CYIlN+jDe8oX+OHz/8/bqU9FoWh5q
 RlQKT2gQl7qD9SI5VSXdBIRUf+iG8k2OEH0Mq4diWYgq780y5MeIhLz4/NCPdKwMLtA2DuL6mOY
 DFGXtqT6JpDnATvzF9STGGLbEDEag6XR1kqTURuqtvY71f6QeQhGZ3oq9/hEKsmETjcCGjDymRw
 +LVcvVYnDRq5NoRLGqpBxWklMjC8UaXr+f38s97XVC0Jdtf+XFtmpD9dBLztyBgeYrJ/78uGV7M
 Du4uWnSUHxxnhIJ+EsJ4a+3Czprw5t/6T3TggDcVQ==
X-Proofpoint-GUID: d4DeaJk_bjt9XRgsVbdFHaWJzLeSQ7-B
X-Authority-Analysis: v=2.4 cv=PriergM3 c=1 sm=1 tr=0 ts=68efc076 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=kj9zAlcOel0A:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=VNp9kv7xENmXbawpSbEA:9 a=CjuIK1q_8ugA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-ORIG-GUID: d4DeaJk_bjt9XRgsVbdFHaWJzLeSQ7-B
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-15_05,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 bulkscore=0 phishscore=0 lowpriorityscore=0
 spamscore=0 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510020000
 definitions=main-2510110018

On Thu, Sep 25, 2025 at 01:01:56PM +0200, Konrad Dybcio wrote:
> On 9/25/25 8:32 AM, Pankaj Patil wrote:
> > From: Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>
> > 
> > Add RPMH regulator rails for Glymur CRD.
> > 
> > Signed-off-by: Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>
> > Signed-off-by: Pankaj Patil <pankaj.patil@oss.qualcomm.com>
> > ---
> 
> [...]
> 
> > +	regulators-1 {
> > +		compatible = "qcom,pmcx0102-rpmh-regulators";
> > +		qcom,pmic-id = "C_E0";
> > +		vdd-s1-supply = <&vph_pwr>;
> > +		vdd-s8-supply = <&vph_pwr>;
> > +
> > +		vreg_s1c_e0_0p3: smps1 {
> > +			regulator-name = "vreg_s1c_e0_0p3";
> > +			regulator-min-microvolt = <300000>;
> > +			regulator-max-microvolt = <1200000>;
> > +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> > +		};
> > +
> > +		vreg_s8c_e0_0p3: smps8 {
> > +			regulator-name = "vreg_s8c_e0_0p3";
> > +			regulator-min-microvolt = <300000>;
> > +			regulator-max-microvolt = <1200000>
> 
> Both of these regulators, having no consumers, will be parked to 0.3 V
> (the lower bound)
> 
> There are other similar cases in this patch

Ok. I will remove the unused rails.

But just wanted to let you know currently i have exposed all the rails that
are allowed to be controlled from APPS, mostly these rails will be staying
OFF if no clients in SW are there to vote on them.

But do note that some of the clients may be getting added as more features
get added, as lot of these rails are not unused in the HW. The client driver
just isnt enabled as of now.

So wanted to check if I should remove ALL rails that are unused in SW?
 or
Can i keep the ones for which clients will be getting added in near future.

(i would prefer the later option, if that is ok with you?)

> 
> Does the board still boot with all the expected functionality with only
> patches 1-9 applied?

No. just tested, it seems not able to boot properly with just 1-9 patches.
is your concern about squashing of the patches?
(just trying to understand)

> 
> Konrad

Regards,
Kamal

