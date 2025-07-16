Return-Path: <linux-kernel+bounces-733777-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B21D7B078D3
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 16:59:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3CEC517249B
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 14:58:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23FC3264615;
	Wed, 16 Jul 2025 14:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="S/J9NI6+"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE45519D06B
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 14:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752677908; cv=none; b=YWpLp2cjqCIdBqXInYCh1mk+w2XYle9zp1G2SVmqt7ufuLJF/gJXuoRuc0yIY+/hKX7K8duvY0PdBhBbv0tgokEd+QnUOfWnng0HScLJ082TxxcW6xWk5coMAo0zi8kCzbXbSSOS8ZhGYyIggdJ7yedWxMyHcX4BHytvsSfMxkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752677908; c=relaxed/simple;
	bh=fiecLZEgxwBHhvCtE3OC0jqMMMcMzWtkxcrkMLboTz4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z12KrJDJs2UCFZIL0orrHkpfZcPnTmTUvNkxBplKdQVeJGyXm133V6lEnzhrGQusG2p4wGJaS7L7H2vMF0t5RKIYb/eWfjb0mGSELCyYtrqsW5r5F+yPHFaUluScO7mEMJJhKBQvVazPqdZIi+LKeL37sBtl5vRGtSmDsP2qXVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=S/J9NI6+; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56GDq7N5029551
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 14:58:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	RDf8cJibEjhiFo83apzBrmHpgcz1vDYMn9bRtB9wako=; b=S/J9NI6+NVkFsLcs
	HyzjPCyusqVoUyOQhQWOgN30XCuBEKk5jTJU5Y+B3miL5fodY8U9LZQeELU1aApM
	VnZzSxcvy9uAKZkpdTWMcU3cky8nB1Eu+LZijxs1Yg+xajsblzBzy7RP5Q9tNFa6
	3HtV4uepI0W3Q/eQf23HGFl1hrc+YuFbNImCTUJKu6B3aVADDa2RLU9mbRt766kw
	OGmRzP+CDaEeIu3LSmlgn6XZQUlUySbfbHlVoKyKODb2UJ8rGvAja3qOG420brXl
	3Lt01qrG+mprDqi5EVACmAsUG6WMtFffNhOMRCjvBhBZKfw6N1PTIdJ8O4s2s501
	fYJC2w==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47ufxb4d8h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 14:58:18 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7c955be751aso1059719085a.2
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 07:58:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752677898; x=1753282698;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RDf8cJibEjhiFo83apzBrmHpgcz1vDYMn9bRtB9wako=;
        b=adKrzY6xMenUgEiW9sXvPntMhaygZ0HkFZqipVXE/FVqyo4jEWZ4mvet2pq5R2S4su
         G53ddPKAJ1t6eiHX/bEVmrCZDmqjW+5oX/Xa0wdoxC/aX516KnuBY9NIgnTEEzrAbzev
         u3C115IyXPaxQmtTGxavcOh7EilfX/APDXrQMMSUT50DP1WYk84PNf7+A1KyOYBhni7V
         Y/Q7qPkW3Y5gwHdLc7c5+E73UVKyasIbHseCq3ZyGZJJeAxePuofyS/B8R3P26iQIfX5
         MUWd2IcZjtsUnrrM71NCkA2Sd2XalFm3jzFeI1ldgnhmQamfBJTaiWR0D7xYcjkAvtEF
         vDmg==
X-Forwarded-Encrypted: i=1; AJvYcCXXs/vlCNIg2kav7iPIdvK12aouTOje5gSOrdJX5gYgJ2yEo/gg9wWGHynslFNEievMYMvLmcTUPZiffM0=@vger.kernel.org
X-Gm-Message-State: AOJu0YywOfOqGoVrLQhnOVCIVfGmPxITb9s4m3mczwydDuxdN7cBAgzL
	FNHIGgc18zO+KSYBmNj//trokhYGQVl3Dtst1wW4OA3TO7TzN30Me3+boG3ski0dTUbw+cAxOZx
	MVseL2cXUz1MxUPK1iXW4vTHwbXM5Hld5nj0aJR/OGmh8/9OVyGp4OoWoIny8Bm7Zpdg=
X-Gm-Gg: ASbGnctpWiw7rbcukL/OZoEGNXvefXsnOcKYG5vyNGJA7o0H91/h2jF0KgJB5U/AJ7M
	yygTOK0XC696ibva0JJbVnE4J108p8zonM2OIM1xYeswGuK2k5CV9kKgrl1eXoeOKw59FdkXzBa
	RMuAw+IQ8MWU1lQuRQt3J+hM8RGfbfsg/drPpp9UP/atbznqSy2jBw6HOZdloOESFnwixt8qUUb
	YwpSBnhkBYkACY6IFzg0FghnMCZil37qzI1z4/7C6QhQuIIhHGWN9PHaA2UO79NtEI7G7WwVcC8
	G/s3jqiqG63D1AoSnYXc+/b6dnJvdjK2+hLslYDVlfKqIUOG8sE6DRarulGtETWXk+0faY2gUMR
	POsoOzhfhOHMkO+awgO4nyx0mA/Q5lH29XRkpV55o97JUBkLMsua8
X-Received: by 2002:a05:620a:22ab:b0:7e3:4413:e492 with SMTP id af79cd13be357-7e34413e876mr264145585a.62.1752677897598;
        Wed, 16 Jul 2025 07:58:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH0jOujE3U+BYkwFkxZi068fm97ejo79VB/1BsmjFpf/HPzJEDPZJZLcHh9+NAlr5Fw707ZVQ==
X-Received: by 2002:a05:620a:22ab:b0:7e3:4413:e492 with SMTP id af79cd13be357-7e34413e876mr264140585a.62.1752677896933;
        Wed, 16 Jul 2025 07:58:16 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55a0fe70bccsm1355597e87.30.2025.07.16.07.58.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 07:58:16 -0700 (PDT)
Date: Wed, 16 Jul 2025 17:58:14 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Doug Anderson <dianders@chromium.org>
Cc: Konrad Dybcio <konradybcio@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        cros-qcom-dts-watchers@chromium.org, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rob Clark <robin.clark@oss.qualcomm.com>,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH v2 3/4] dt-bindings: arm-smmu: Remove sdm845-cheza
 specific entry
Message-ID: <2kpb6lwr36izbbp45dbv7lg2akjdxteiadhtc2bbphmsreycwu@nre7uzuezydq>
References: <20250716-topic-goodnight_cheza-v2-0-6fa8d3261813@oss.qualcomm.com>
 <20250716-topic-goodnight_cheza-v2-3-6fa8d3261813@oss.qualcomm.com>
 <CAD=FV=XmwiA_gX9pF5Dja1vezson7f21WHC8u8+Rhg_6OUJ+rw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAD=FV=XmwiA_gX9pF5Dja1vezson7f21WHC8u8+Rhg_6OUJ+rw@mail.gmail.com>
X-Proofpoint-GUID: KUcrCUDEnuLh65w2q-bCCEdAl1lp2mtr
X-Proofpoint-ORIG-GUID: KUcrCUDEnuLh65w2q-bCCEdAl1lp2mtr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE2MDEzNCBTYWx0ZWRfXwIhaDFQWgBzT
 L6YW21304fmfL9IIbSIAg4eLAVHooxIrLi7eKxrkeuLhTsGXr5bheDXolXWyeyOMRQUUXXGXjYF
 gl20dYGLFF+C8RWR7lHeoI/AmCMn3+ac7ECgBO/ZzAjW+E5upEJISrPeicJ5n50YHr0mr+VFY5k
 +Gqucp/SblA4rG1EarM5ME55LQJDfsQXOZ4JUrSrOWuHX71ZwJ0ulAJ5QeJ88S+K0MIYaqUh7W3
 PkDYufcKeKV52H7t/TRJHWCmqI8xTaykixIcy5uvUA6FTOWRZAi93Rh6hF6KnI87RNjqA2cOdZs
 xMYc+3cWw7vq+dP/KHFv8ek6Fms6Z0HzmEsaJhCrYptasWb3zjjs2GGau+iV23przz1aX2OLDOH
 h3BTyB9MTII7ILCIY+aQtjdRr4Sof8qPCZgKUCjVB+PR0gJPVvrs8D1Os4NlUeX5cVeATOP6
X-Authority-Analysis: v=2.4 cv=Xc2JzJ55 c=1 sm=1 tr=0 ts=6877be0a cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Wb1JkmetP80A:10 a=cm27Pg_UAAAA:8 a=EUspDBNiAAAA:8 a=HCTRSnsxAeQ6huVMZXoA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-16_02,2025-07-16_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 mlxscore=0 priorityscore=1501 adultscore=0 mlxlogscore=999
 phishscore=0 suspectscore=0 spamscore=0 lowpriorityscore=0 impostorscore=0
 clxscore=1015 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507160134

On Wed, Jul 16, 2025 at 07:21:51AM -0700, Doug Anderson wrote:
> Hi,
> 
> On Wed, Jul 16, 2025 at 3:16 AM 'Konrad Dybcio' via
> cros-qcom-dts-watchers <cros-qcom-dts-watchers@chromium.org> wrote:
> >
> > From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> >
> > The firmware on SDM845-based Cheza boards did not provide the same
> > level of feature support for SMMUs (particularly around the Adreno
> > GPU integration).
> >
> > Now that Cheza is being removed from the kernel (almost none exist at
> > this point in time), retire the entry as well.
> >
> > Most notably, it's not being marked as deprecated instead, as there is
> > no indication that any more of those ~7 year old devboards will be
> > built.
> >
> > Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> > ---
> >  Documentation/devicetree/bindings/iommu/arm,smmu.yaml | 4 ----
> >  1 file changed, 4 deletions(-)
> >
> > diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
> > index 7b9d5507d6ccd6b845a57eeae59fe80ba75cc652..646814ec7d15f6d8a0136de73b7eaddae232ea64 100644
> > --- a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
> > +++ b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
> > @@ -132,10 +132,6 @@ properties:
> >                - qcom,sm7150-smmu-v2
> >            - const: qcom,adreno-smmu
> >            - const: qcom,smmu-v2
> > -      - description: Qcom Adreno GPUs on Google Cheza platform
> > -        items:
> > -          - const: qcom,sdm845-smmu-v2
> > -          - const: qcom,smmu-v2
> 
> The code supporting this can also be removed then, right?
> 
> drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c:     { .compatible =
> "qcom,sdm845-smmu-v2", .data = &qcom_smmu_v2_data },

No, we must keep it for the Adreno SMMU on SDM845.

> 
> Reviewed-by: Douglas Anderson <dianders@chromium.org>

-- 
With best wishes
Dmitry

