Return-Path: <linux-kernel+bounces-790269-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A05E8B3A3E3
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 17:16:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B0CD980AFD
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 15:16:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B649221264;
	Thu, 28 Aug 2025 15:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="E+xFESxd"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB28421C16E
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 15:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756394163; cv=none; b=bz4TR8BQJW8ZMZ8fwTZWnCerkUVlP9JmZrPUJ6eEOfCknlgmaPE4nUJfDPnEBGkAJ8Zl/xsgS8f6ReDhd4xisPKLD7D2p612xKAlfzSLLKofMfq482OarR9ycu02LZw3mertYEg4T6HIIt5gtc9kLmSjA+y7H1o6HbH/mwncsvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756394163; c=relaxed/simple;
	bh=URRU48cWWZKXWYFt8cB99iHFjpEreIFbVOTSGj9tHNo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U8mP2wKfrXz3ghGMMTavXuuDPSM+CoiGU74X9sXNdzfYggk/bXqAyfBFTfasbslmYN6lTJ1HhOJNL+5bhT59EReEk0szaKAZaE8lgJX3KfxcSmbbal77yu8+F/uQ7GfeKI+HRkR/F1pYYuSozX4CMFbPLRjd3wSsLWDaKMeNwHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=E+xFESxd; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57SAsAbn005504
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 15:16:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=baDCJN4Ix+gOwGahkROrbNwU
	3+styHRf+7rMYdXAkDA=; b=E+xFESxdnnEimTHToxuR/9tA8PbNJaiQUx+qdK9V
	je7HYh6Yz2wxNfi+ENxmD85DkfWW1Ujm0SWws9G8YvBSeSJuGFXBK+7gcVHkFDx/
	D6Zi6tKtmOKkjlOQ8WC78/Ex7LnxC8PYY/nrUudmnU1QVOu3l865mND3Q+To30y4
	GKwPTD16++l0TPHutiTTdigM4zjsl9L6/7mq99w0jvqEVEWs2Ib1RKtKs5Ia0wUI
	MiT+ZELzLYOmhkPeAFXg8BhuGX7VOKTcUHP2QyZ4XcMts5J9+Kx5r0CZkv3MneNg
	IhZrzoxpuCyEh4RQgC/cXcaxqZ+jI2rgv2wceCSx9P4tEA==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48q5up0ge0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 15:16:00 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-771e331f0fcso832792b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 08:16:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756394159; x=1756998959;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=baDCJN4Ix+gOwGahkROrbNwU3+styHRf+7rMYdXAkDA=;
        b=eNXW2/gywltoFJyTKaf3hJ3e5DmrldmTGJLxpnWhT9SLvjdmP/VdasmWfFHYNr6bXP
         nGGnlaCw1V+LkNFrOETR3hrDF3OvUk4lx6CBms/B2CmLxNz3J0YAIlFjIXUsnlq0robn
         5HOyve1rD79DuzxKL/5NBD+tNfnYciy3HQ8/D/S89lDsThPzsOass20LK1dgBPRxiSAk
         gm89wO5gSAOx0B2dnAqcpVYt4NQSrurV0bT2cIjeUuLX6bWmt24KOa99xjl+vsO8H3SZ
         3r0wHSzThdKTRbu63Eq33z0mxwWugqd990gyhGKEvoKJR4Zn2NhEGt989ogkJtrWVoSL
         Q5rQ==
X-Forwarded-Encrypted: i=1; AJvYcCUaYtz3HRxkZl86+xMsbousCe6BcyYFCzX2SLJL+SOoJsAnYOR232V2wjEHqXRJuqh6+fR9+gQGamlB62I=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLdCQ6HutNBn437G42Kw+AWwnTwfijpy3G8oWWrRLZ/svz+Vsq
	4HSX/tpkYhptUHm7VKrpvviK1UvC+J9JFxu2Nlo+wAtVk9Vw8rGT8FWVyposfX9nkS+ouWhtpQ0
	BQGJ6EaIHuAPIS3HQ/NLVuxEJr0teLb7ILQGQJ3JDpKo0hJ6NCH+8vMZJPn4zYVTIlyQ=
X-Gm-Gg: ASbGnctgn05js/Lys1XUc8ftjMm6z7wTN0c75pxefyyxOEHYkCS0noESeuaXyLXZha2
	eq8CPm3EPZprE5JUReNJ9Mdue2BrIQrIbD/0DI4zTXQabEAY090oXx4WbqGoJc2H+q3tHzFzOR4
	YXU+34fvPLF22+wVGfVMEnm3EWNIWnYTg60JaGYtimvVEJlK2O25IaqelBUm+zkan3GvUVeRR/U
	h+RoGyCokJnAMX0tB75SYXuOQCzvwOBvdfkxpZmJFDdXLDiQFpyZjoQGRS79PY6o+VMxTksen13
	SOBVDeD9cH3f2v+f1wH0natkG0aNxCaJdIMX526NLr+KizQtbOrMHziqtFEuIphl2bRI
X-Received: by 2002:a05:6a00:2d85:b0:772:a5c:6eea with SMTP id d2e1a72fcca58-7720a5c7183mr8959028b3a.17.1756394159425;
        Thu, 28 Aug 2025 08:15:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEr+f+TmPKCG2a3iQClc3TLskdjaiUttLjb5wUJrFV04qdT1/xLcvX7ROCMwXEmiI50+eK2WA==
X-Received: by 2002:a05:6a00:2d85:b0:772:a5c:6eea with SMTP id d2e1a72fcca58-7720a5c7183mr8958959b3a.17.1756394158822;
        Thu, 28 Aug 2025 08:15:58 -0700 (PDT)
Received: from hu-wasimn-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-770eb8b94efsm12551158b3a.40.2025.08.28.08.15.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Aug 2025 08:15:58 -0700 (PDT)
Date: Thu, 28 Aug 2025 20:45:49 +0530
From: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>, kernel@oss.qualcomm.com,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        netdev@vger.kernel.org,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
        Sushrut Shree Trivedi <quic_sushruts@quicinc.com>,
        Nirmesh Kumar Singh <quic_nkumarsi@quicinc.com>,
        Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>,
        Mohd Ayaan Anwar <quic_mohdayaa@quicinc.com>,
        Dikshita Agarwal <quic_dikshita@quicinc.com>,
        Monish Chunara <quic_mchunara@quicinc.com>,
        Vishal Kumar Pal <quic_vispal@quicinc.com>
Subject: Re: [PATCH 3/5] arm64: dts: qcom: lemans-evk: Extend peripheral and
 subsystem support
Message-ID: <aLBypYX9y4KPPSji@hu-wasimn-hyd.qualcomm.com>
References: <20250826-lemans-evk-bu-v1-0-08016e0d3ce5@oss.qualcomm.com>
 <20250826-lemans-evk-bu-v1-3-08016e0d3ce5@oss.qualcomm.com>
 <bab2e05a-140f-460c-8c28-358e37727c6b@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bab2e05a-140f-460c-8c28-358e37727c6b@kernel.org>
X-Proofpoint-GUID: 9RcAJt6pfLE2DttUhF-1UUctSb14s40_
X-Proofpoint-ORIG-GUID: 9RcAJt6pfLE2DttUhF-1UUctSb14s40_
X-Authority-Analysis: v=2.4 cv=JJo7s9Kb c=1 sm=1 tr=0 ts=68b072b0 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=kj9zAlcOel0A:10 a=2OwXVqhp2XgA:10 a=UXIAUNObAAAA:8 a=ogXbWB_6-ELqwvBGSFsA:9
 a=CjuIK1q_8ugA:10 a=bFq2RbqkfqsA:10 a=OpyuDcXvxspvyRM73sMx:22
 a=a1s67YnXd6TbAZZNj1wK:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAzMSBTYWx0ZWRfXx4irvIj34vID
 Q+6+jvHelp75XthtvBcI8JMn4gN3jwqdToU8n8H7tSsOxiINyeDQALQkPQtZIpt74L4DBWiphLa
 6KgKeRyvGdylptXDxGgquj6ZrTk37jRv2ir4PVcDzfweTSptBlQyY9cdHXnB0e4gPUCq3m099XF
 icDdtAKmnyUg1F6F0NSkEQw/nbBiliv9+9NDMhnKBXEj8svMUuCkPd5DA/xdYzqhnSssnRnGMYl
 xvyGLGKxHJJgY8o5W8e8ehyveDepWCcmX4i1145WWV1phKhOniJQGz26GznXfJPG1wNUhVSRH8F
 RwE5uYKZR+rKIKnX09NHiWfNbN9QTvwIiy2tEocbWMIJVH6Bi/tc7vvISZFFIQ23U1/C0o0yfWZ
 W6ttF1Qn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-28_04,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 bulkscore=0 spamscore=0 impostorscore=0
 malwarescore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508230031

On Thu, Aug 28, 2025 at 08:56:07AM +0200, Krzysztof Kozlowski wrote:
> On 26/08/2025 20:21, Wasim Nazir wrote:
> > +
> > +&gpi_dma0 {
> > +	status = "okay";
> > +};
> > +
> > +&gpi_dma1 {
> > +	status = "okay";
> > +};
> > +
> > +&gpi_dma2 {
> > +	status = "okay";
> > +};
> > +
> > +&i2c18 {
> > +	status = "okay";
> > +
> > +	expander0: pca953x@38 {
> 
> Node names should be generic. See also an explanation and list of
> examples (not exhaustive) in DT specification:
> https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation
> 

Ack.

> 
> > +		compatible = "ti,tca9538";
> > +		#gpio-cells = <2>;
> > +		gpio-controller;
> > +		reg = <0x38>;
> > +	};
> > +
> 
> 
> 
> Best regards,
> Krzysztof

-- 
Regards,
Wasim

