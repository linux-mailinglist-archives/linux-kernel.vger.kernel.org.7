Return-Path: <linux-kernel+bounces-781691-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BF7C2B3158F
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 12:37:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 44A9A1BA5EA5
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 10:35:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5A932F5474;
	Fri, 22 Aug 2025 10:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="NbJHNySp"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B671F219A81
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 10:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755858890; cv=none; b=utxyyNhnuSvxy+SnKBIwzH7joV43dDL/d+pZOTD3P/23txoaEvs0qkkd0usmBeLsT4Ot9bZ6RsvPTsxRzwcpMNryPuhkR0iQIyXg+J2y6vHSm/3/Z2UvE4yRoNfS64Ospwf2blg65oP9wjUe0mC9FYbeaWEtG7Hjb52PhUVRH2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755858890; c=relaxed/simple;
	bh=cNc3uQTBlPMD/fIqEi+w2U9HdRDuV2p5IcMHEWL2ySw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bQJhZBn9jUd/HHRuYr851elALImw7WvkuUDNqIp1PMePczR9Z61fLTBrvaXQ3oIlKvEW1IQWeCl6p3CFj3yqlQb+L7SeoXRpF6KdTjTt2L3c+rsj4OAexhDHwMAssw1dJZQQpuWm5iNhsy3KqTa0qgqkCrQVy45NSRD8EFf+HUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NbJHNySp; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57M8UPqS005787
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 10:34:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=kveQ+tzxSixYaW9ElHHUjKWE
	uXQ0n186XTdsODdNbAY=; b=NbJHNySp6cGBngKyWzHr7So4mttf5+9GBE3hYVFs
	ZEd6u2yMLX0GIOPRWpZg0P+mTOKlZC69c1twVJFxi4UZ4JMTDfEl1CbY8IKOuhQR
	/azdpfol49X2Vyx6kaZwaxPr4pe1g3MjDloys9oQeyikt/r2p36HX/r1Wmjek2pZ
	RCkZafM7HAjwxsvM15rtswXP1qsP6d6FhDBKHDZuGQoYv/TkuipsJLcNIZ/slQLq
	3YCyx/mrbJCQFqrXw7neMCIYfEVDm92cZR0Lb29VLbOlcvAfG7z98b62y8iEbn8H
	M87g89SlpvBZQBzuoUogJ7QyylEaPwQPASW/1ljOS630iA==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48n52drt2g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 10:34:47 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4b109be525eso43966851cf.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 03:34:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755858887; x=1756463687;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kveQ+tzxSixYaW9ElHHUjKWEuXQ0n186XTdsODdNbAY=;
        b=wMynfQPfZigwWG5XXZ33T4fmfSD3EWlBCs5ENxFZ3VYZzti/TTa2kIAE3iEmM2hYyp
         SHHTH6fU7HkWyCe0RB2pcjXQJ/9rcI1EMLKGPcw4VzJ6MGdS1n0mGc/20gG/1IYVCUbu
         CR1GdVxLtYY4lVuTfvqpTOccvwMvgzdl6sU62CGp7FeMbGp9/fBE6BzelgMCZS4XybiX
         LisxfnwBKJ74utoW94x61GZTrDyj8kDH/Guq8qYXr6t9gDhuUb1h5wAp01MDnNV9hHpU
         zonPvucxyos6+zwq+q7Kide0g10QMQMzOABU/O8hQA/o9GXlvGhnq/qi3amGxdMG+24c
         MGMQ==
X-Forwarded-Encrypted: i=1; AJvYcCVjNRtAne/Dug7lRNf4x2LdHhESQozMyhzoMFKljHS9hWy1/IxSahoGD8ebjDi4Rd6f0N1ZAIiBRlbgAl0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8pQix1zS9q3W138h/5EaEGUhafyK1wZKwHVbj6U8/AEhT9ufv
	FXWkJE3gfAcLffZMENNSd+O4usD6CSTD7OwOPA0pO+PoQd0DscPF3G4Kqn/qWV6VXluL68vOEVL
	7xl0F2QosDCKtFVX/EwcyXJR9dapUAv4e7gafJF6roxyx8lVA0dZapIVpqUyXocW7fi4=
X-Gm-Gg: ASbGnctCCfz9s9+7AVb9+KsPt4BnOkZSJIbkmfKj9NFk2vHoica4xY507LaM2/8kmIo
	eJpBXegO2d9S8maJlxdtQ7x2HGIx5pC253Pvb1Kjo+7WIdTqieWtlKmkrps9jwh4TzE2mvAan2h
	rN8DaYfh92Ej6LA6NPALCSRlt7kc6gUXszewciA14oxl83BNWBlUalH41lC1gUJNyYZ07dnrc8x
	BheW6jUDfJqHIo5tmh7g97eiqAjYh7cIR/EXxm2WbenMac7qmFUpu2BsPMMzIp+VO/jU25ZVkai
	ZfGugkdmIt9jyntGWsCQJrRAmOlKLTHreshRAkDM9kmjfZzTy96KIvT8/lsN1FDipxnVq3bnO4p
	NhfkZTOl9/iUmkmeicwvwszf2SjD71iqpihGnWsajIXLFPsRqbTpu
X-Received: by 2002:a05:622a:1a27:b0:4b0:65cc:f64f with SMTP id d75a77b69052e-4b2aab3c33bmr22432731cf.54.1755858886909;
        Fri, 22 Aug 2025 03:34:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGitENoH3QIhDfrMsc85KABpbqP+cmpwOZOUhVCbOkZutTUgU8nZ46PieBebtYJ+AhzzSGsfA==
X-Received: by 2002:a05:622a:1a27:b0:4b0:65cc:f64f with SMTP id d75a77b69052e-4b2aab3c33bmr22432591cf.54.1755858886489;
        Fri, 22 Aug 2025 03:34:46 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55cef3513c9sm3554851e87.29.2025.08.22.03.34.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Aug 2025 03:34:45 -0700 (PDT)
Date: Fri, 22 Aug 2025 13:34:43 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
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
Subject: Re: [PATCH v8 5/6] drm/msm: mdss: Add QCS8300 support
Message-ID: <iza3iyj6ztuudm5rqfrxtalwxfghzsguf3pieulylebdblq7sw@divpjvwwvmsg>
References: <20250821-qcs8300_mdss-v8-0-e9be853938f9@oss.qualcomm.com>
 <20250821-qcs8300_mdss-v8-5-e9be853938f9@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250821-qcs8300_mdss-v8-5-e9be853938f9@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIwMDAxMyBTYWx0ZWRfXygFbb4ZVxfIw
 AesNGAyKL+zjTOV2nBQ0+sXk7iLPr0fJkFD4TXQoysrViynjKg/F1KFYOfO48TzXVm3fYU/f7Pj
 SWGNVgxtdpyu9aNyDFoxM4zpdHIX0PbykP4sWm4HZ9xn4/wEARuYxl1ZISjAycqR+Tnk5LYVkLB
 Wpqc0xtNARP7DBpGFA4yoeNQBotJaW5nUk3Xi1WERvXFUKcTs0r4SilUsh2h0jMD3ec4wn9DcBo
 UeWL+X1p0Wm11XZlWEXzKDWFeIn7qrZchSfnmjL6VJ8ay33NmzQHsYpdSIHymqujk2plQyu3250
 rCvIMPkb+FF6xdI4IpvAp9P58XP8vVgGekQRAA90ejZqM6rE6yVj0F4ppDv5KLOU9kf5efwU0mU
 wxppSdnsuwEoFWAq7aI0zq1cZho2EQ==
X-Proofpoint-ORIG-GUID: 8QFpL6rZlz0RjEnBfz6VPpv3sLOHodGR
X-Proofpoint-GUID: 8QFpL6rZlz0RjEnBfz6VPpv3sLOHodGR
X-Authority-Analysis: v=2.4 cv=SoXJKPO0 c=1 sm=1 tr=0 ts=68a847c7 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=PV2lBtblPjvqxubg-rEA:9 a=CjuIK1q_8ugA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-22_03,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 adultscore=0 lowpriorityscore=0 bulkscore=0
 priorityscore=1501 suspectscore=0 malwarescore=0 phishscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2508110000 definitions=main-2508200013

On Thu, Aug 21, 2025 at 11:36:00AM +0800, Yongxing Mou wrote:
> Add Mobile Display Subsystem (MDSS) support for the QCS8300 platform.
> 
> Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
> ---
>  drivers/gpu/drm/msm/msm_mdss.c | 1 +
>  1 file changed, 1 insertion(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

