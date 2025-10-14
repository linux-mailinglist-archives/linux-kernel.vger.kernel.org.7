Return-Path: <linux-kernel+bounces-853223-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 37FD6BDAF54
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 20:36:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C2A019A0B44
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 18:36:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 775B02C026F;
	Tue, 14 Oct 2025 18:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="n0mpjO1K"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CA0D2BDC23
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 18:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760466945; cv=none; b=i9+i7N7zlkhREQR/UMBxiVYSwPDmOJSfYMjQoZR57uDvI7D9f4+MGwNG9I8x0pPvDv0tM1bjVq4QzBJL6qhwHRtulbHpY1jFRaRYwSfFtwwmbuxhnQIL1ph8Tyz/04v+fNDRAKhTdQxgSwbIDtvaoxX02L4JAGX28/N1zu/AWPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760466945; c=relaxed/simple;
	bh=88MwhoLBLl0h6gGQJ/l9piaAckp8mCR95svQBZRY0AU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z0MLesxXj20ws5KIMIJEvcdiEmSnvo9psa3wbt/FZwUG5mQaqxKGnocOfIGxecMIrGxJYL7dlFhC6T3ecT7TypHP7tCtRa5Bz4KyUWGPNwrPESQ/oBQvTfg9bqKtX9lOBELVkLJbnOtcqtkYnE/Q0KSNgbz2gJO3shw9qtqIcOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=n0mpjO1K; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59EFxDfk001471
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 18:35:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=JgyeBCAKXfxEVl9M5RNSJ9fG
	fb4hvj/8SPvA2yhEbrU=; b=n0mpjO1KKHOTDOS4Yf8/cnKMs4fBvLpkCuZ56ZrV
	pnrP8HuX3pN0YpoyWTbK4EdcU3IVziN5RT41XeBY9FlEtA5Hdk+RnnnRJJOacPr8
	eUY9aZupFsvNphTb6P9PpLkysRcRj4oFI10/+EE/0zQ5eMhqH356NqeoRNr5ZA3S
	1gdoDKjNSQeMGfM0YsE/1bKAljIECX32IvWbjMl1W+3ecgCYsaIEXEjJ2GLnl3Y5
	cgynbeiiNYeKw7KqyQgAux79yzbD0zgfc4vHY+jx8elR3/s9WbdELeIUnVsNINka
	VjsQNDV+6IAAuVD3TjesPQnomw41/IeJ9auKisQl+zw9Dg==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49qfa89m97-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 18:35:43 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-78f2b1bacfcso258748026d6.3
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 11:35:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760466942; x=1761071742;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JgyeBCAKXfxEVl9M5RNSJ9fGfb4hvj/8SPvA2yhEbrU=;
        b=vzp1tOPlcTJpGmKejbFYQNap2n9bETx1hyX6X7ucOoabKSjBt2uSrD/4/5HWtEme+e
         /fnWX7BMg8K3vSbNM1NIuFspF7uRHpgwyrrewsF3OCxEU1rILepTPXLTJbfCiGTN57R6
         AIR7RMWZxLWl8orbHD3cvvjB8OPiYDdIvPQYapQi8a1fOR8eKJDOqbRwYF3sSabaejgB
         a1D/lGOD+ZusNxoBsqGJQa7YWM4NJKDveDj+a95RipmN2BzDOSVVPx8iErv9Dtw9Ckd2
         3hEtSYRRbUf8vcNkJdzhBzd7sMt8rcG4J1md86bJsg9yEgF3y3FPzmT6E7UTlruHTjuj
         NY2w==
X-Forwarded-Encrypted: i=1; AJvYcCXYa2kX98jl8c2/uCP8BZRDUtxMfebwItLMl55GOHj5RNePaPcV2ewGCPRCQFa0gerVQ7FYthoIQzYAzZE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzBXbrYVHvvhW5QDbYFzs0PilODHvYdQQTSD+JSbkoX4JDgurS
	LusT+BMWn1FPR501Z8JTaZW+FFEaR8IxPJmQaj6qMBsgc/rM1Pvwl24e3C59HAS5fBzVNoBiCy3
	fKrz2vSG2fj4oOOx2cksdGugEwM+MDPbkzNtwVxo1GFyXDuxDc9PGAlscvCmBjXHzURdmP3KPSI
	8=
X-Gm-Gg: ASbGncu6MqdgxKCGf7baotKCVuep4sHpZkUnd7viw9kLGnyISqfUIFBItCOUvimzTsp
	Mxmz9B3XV5ezkFA+a4wAXNaI2E3M+wNnQBFky0/HyOyKBLq1NOxklMgH+noawaE3H5BxWNF0o1g
	5aaPcU++Yn2tBDEt5Q9COrvSlUUSJSCNHWOsUzrVQXFNwlq81DSmGKFA7XuQ4gign9DbBeVEnvj
	Gl2yDKyk9LO94fm3P4Ljxpo2VfNBIAuMNEvjNWZTIqpttp2Q2+SfZyv22taUX5qFU3vgJKnebp+
	GExFv8tmCASeks7xGyxfZPjmnvdLnsDrWexj4gi/ygKVJ1NZF7rkCV+azJh5JIj2u14bCe6HdlS
	qMrUc/b29lDxg0brD0JTrVRfRtp22gTfubkqjmmzJ0V0NNCQrRKQT
X-Received: by 2002:ac8:5754:0:b0:4b5:f369:8e30 with SMTP id d75a77b69052e-4e71bd45691mr167116531cf.71.1760466941760;
        Tue, 14 Oct 2025 11:35:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHofj8LwYDeK6yXRXtAUxitNSZSVVk6QKkZX8yZloH/rMjOd5sZzIPxOGDAxCmCCVgx9cAzbw==
X-Received: by 2002:ac8:5754:0:b0:4b5:f369:8e30 with SMTP id d75a77b69052e-4e71bd45691mr167116061cf.71.1760466941284;
        Tue, 14 Oct 2025 11:35:41 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-590881e4e2csm5477278e87.14.2025.10.14.11.35.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 11:35:40 -0700 (PDT)
Date: Tue, 14 Oct 2025 21:35:38 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Bryan O'Donoghue <bod@kernel.org>
Cc: Robin Murphy <robin.murphy@arm.com>,
        Charan Teja Kalla <charan.kalla@oss.qualcomm.com>, joro@8bytes.org,
        will@kernel.org, saravanak@google.com, conor+dt@kernel.org,
        robh@kernel.org, mchehab@kernel.org, krzk+dt@kernel.org,
        abhinav.kumar@linux.dev, vikash.garodia@oss.qualcomm.com,
        dikshita.agarwal@oss.qualcomm.com,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        bjorn.andersson@oss.qualcomm.com, linux-media@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, iommu@lists.linux.dev
Subject: Re: [RFC PATCH 0/3] Introduce iommu-map-masked for platform devices
Message-ID: <6gx74wxie4wcabq27wo5y7v36uuurez4jxlzanroepqazdlgtw@sdtv2ld47d3q>
References: <aec0f40a-8346-4194-8b18-1022fe3366bb@arm.com>
 <0d0560cc-9757-4c7b-8de4-170148d99481@oss.qualcomm.com>
 <ead7cf8b-fbc4-4242-a9da-b313dded1abc@arm.com>
 <nzqte4glwtpjs5bhkxz43yhdufelxvqvzmg5tepudxwetimir3@bvlw5csjizsh>
 <9d3eeb9f-b8ea-48e5-a1d9-0865f63ef991@arm.com>
 <fhb4woejzh3r6v5dxvdiopnsbuwstucfuuzbiymxg4wrxrjc7t@dt3z3utq6lwd>
 <8d88cd9d-16e8-43f9-8eb3-89862da1d0c1@arm.com>
 <hOs24ZavnUyKYyNwBWwRpYnrsefzBfp95yuy9zyp1ByxR9_3VacGX1Yntt8pCE4w3gllPwvevs1AZqghmwKoFg==@protonmail.internalid>
 <zcgn4xw2xghyna2eysavujbzbiydyki7p7upzzv7one5mdyjy6@sj7f75kc4vwu>
 <fb767586-a376-48eb-97b4-bf33061642b9@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fb767586-a376-48eb-97b4-bf33061642b9@kernel.org>
X-Proofpoint-GUID: r-v13HEr-pPsutWAn2bNi7KsU2MWZapE
X-Proofpoint-ORIG-GUID: r-v13HEr-pPsutWAn2bNi7KsU2MWZapE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAxNyBTYWx0ZWRfXyVHtbZ4z8r5W
 bkLmIvHTw3Nda/6F0P50OQMgwNpvLaeJh9Zcr1938+/24PFvEwQZ3TcMEwhr6+HGkFcA9O3VNnM
 W9MBPKe492g9IZsrkJAxOdV/g6eKu+Rdkjorm13T0hSx12pT1/lyar4bVQ1DD1N76V6WxKZ+wPo
 K7jizPBiq7ib7UrCI+Z9uCCNTwLiI7rW3sWUiCQFFv0eJ3ucPOFAXiSS+pcwCxt8HutNqWl0h1i
 XKuDdbwm4LhVdUn5PhhGLEVYuX7rYvhK3RmeAyBvhE/iL5bIW7D/+xVQWAyXaKutCpQqNDbkUfH
 UJwM/zcIfjP7VL3PuNo0QfC9qqU5QKGzHvfJ0dIzDfeeJAQ8uTVEE1cxwGP/6/f7/C2uhr/wVDC
 CqEHWvIaz2kSSQ0u1jMEpxyv4vNC6Q==
X-Authority-Analysis: v=2.4 cv=JLw2csKb c=1 sm=1 tr=0 ts=68ee97ff cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=hQP1gfvqEBNhzPyMEHAA:9
 a=CjuIK1q_8ugA:10 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-14_03,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 adultscore=0 bulkscore=0 priorityscore=1501
 impostorscore=0 suspectscore=0 malwarescore=0 spamscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510110017

On Tue, Oct 14, 2025 at 04:07:37PM +0100, Bryan O'Donoghue wrote:
> On 13/10/2025 13:31, Dmitry Baryshkov wrote:
> > 
> > And from DT perspective compare:
> > 
> > 		fastrpc {
> > 			compatible = "qcom,fastrpc";
> > 			#address-cells = <1>;
> > 			#size-cells = <0>;
> > 
> > 			compute-cb@3 {
> > 				compatible = "qcom,fastrpc-compute-cb";
> > 				reg = <3>;
> > 				iommus = <&apps_smmu 0x1803 0x0>;
> > 			};
> > 
> > 			compute-cb@4 {
> > 				compatible = "qcom,fastrpc-compute-cb";
> > 				reg = <4>;
> > 				iommus = <&apps_smmu 0x1804 0x0>;
> > 			};
> > 
> > 			compute-cb@5 {
> > 				compatible = "qcom,fastrpc-compute-cb";
> > 				reg = <5>;
> > 				iommus = <&apps_smmu 0x1805 0x0>;
> > 			};
> > 		};
> 
> Sorry this is perfect.
> 
> Each function id can be associated with a device and a compat string
> associated with it.

So, which part of the hardware is described by the -cb device? What does
it mean _here_?

> There's no weirdness with iommu-map, you get a struct device for your SID
> and you associate the SID with the FUNCTION_ID you want.
> 
> In fact the FUNCTION_ID could conceivably be the reg. It could be stored in
> platform code.

-- 
With best wishes
Dmitry

