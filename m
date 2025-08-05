Return-Path: <linux-kernel+bounces-756235-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C636B1B195
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 11:59:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB87F3BDBBA
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 09:59:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A21826B0BE;
	Tue,  5 Aug 2025 09:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="a/cKFDsv"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F9BA1AA782
	for <linux-kernel@vger.kernel.org>; Tue,  5 Aug 2025 09:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754387955; cv=none; b=XNzlXRHzB/AvsyQCtVwlMCfjB0mlMjwYvYcGnvD3x0LkUOTJrAsTLL00/2/u1SUF4SW6OjK0MVE9UcRk702gD7GheqJIuXjKA1KqPWoNRRXg7i6Kh4SmyBjizZJOCmQa7uABoMsjMtHX4Yt79JUykwpvIIP0Oqe9O/OmBmVXVIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754387955; c=relaxed/simple;
	bh=6xnkcRjjaBCV9mGFQ39UJqLkd2ZbEMv3DHt3bw7xXVQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PFagfyOkLbcIviLo2E3aQFj3kf51sluV61WmSDIBd/aq7a4Xj9YUhBKKUpN/x0DLwfs8IGuZZ7RMDm1qP+ik5oIwHRAPAjfj2E+XokXqkuyI+DEn+fvINh0QatRGafWfjKxwZTQTKmcOVwos88hFVm7A/DPnt0VzqeR2tEU8i+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=a/cKFDsv; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5759w1bm016967
	for <linux-kernel@vger.kernel.org>; Tue, 5 Aug 2025 09:59:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	oFkvM2HVsX9Y21JHEp/hCHiYryvffbqt4OmpC31gI6M=; b=a/cKFDsvjeknMpcV
	QDZ0r6yQBaPCNk7jNDdJ/aX+Ognr4LHk5faaMtRFv4C55saHwbzUGEp1Qph4yRkZ
	VwYJEEeeGhhxq+71m+g44x3hGmCrQr8tZZ7PjtN6YbQgq8gqKmgby/xaNM92ijom
	n6Nd+Eqp2AsqRvoaAQfOgDssOnNgQdcciVpVeFhyYeZ0OalpesYBLEyyb45qysGT
	Lu0WoFIbOzjhdFpOPH3DfrO2fG5HvOU1SHFb4wOfxO9Tvp9B+58q1znp8ZWZkzGy
	dElqQHtrPat2JrBWdD6epOg/jj7Ku9B+eHHi241DdozGQmn6TtNVWOIM08Nv6pBq
	nHVj1A==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48aqyv49x1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 05 Aug 2025 09:59:12 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6fb5f71b363so85042306d6.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Aug 2025 02:59:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754387951; x=1754992751;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oFkvM2HVsX9Y21JHEp/hCHiYryvffbqt4OmpC31gI6M=;
        b=V/McjyCfB9HMzVlke1jD2m+3LJm5F/J1gyALCoPdrIHzsDIXdslBIj40XeGGLd5+fA
         2kC8PZPZFZ8MdrKesc2qRS3SegEs0X9X0+14Z+WdlG9zvufRcQ10Uoyl3qLaQ9BZNo3w
         g6aSfDmZ4H/G1KORGTS6OIeWeP8ay3pa+zomM9PcxoqMMDaaWohJYvrVXJcSndASbwba
         XoPpo3Dp54FoXpJyQ6U1z0fqsZuH8oBAAL2xixW3jyUsalrWILzenxoXB+1BmhRl8jV0
         6rekvS7Tr0nJGP0zf3uHQUfcYDp0Xi/9yyu5wZcgNmaUMGf/LuMmbiXDewhATo6XTFmc
         meQg==
X-Forwarded-Encrypted: i=1; AJvYcCXuQv4udqkmczqCaDgQKCWYK5SqqI5n3Blp0tF1lhPoBRO61RtJlZPLrr2cbqvtaeTkOXdkA+cQiPLOYUo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7nEPDWsLd5Ad5yn8E9tYv2O8UhUVY+RtUAWe22HYeGQGCo5Bg
	wsqC1OrLvs1+l7k4g6T3ua47O70TYDyF6Kzd1qxZzBk1gJSuL0hj8fP0LyUWBFaSxqk86M7LLtP
	8/r8LIb4zS+NCZlXLBYQTj6mJAcUpeE7Ci5UunenCa/cjXpkqlohxjwmupkS0lhlrl3A=
X-Gm-Gg: ASbGnct+z896vSe5DxweCU8aOJjUPCJQiImKcabpnImMcCxnxbMJ1BsBy3Euv7GrZU1
	WiiVeA2rSCi3R6p1zK02duNrXsot4VN8czqWUcZ91Gma6ccuxhIpXvFFK0CSCdGhn7TZW/pF0tI
	IfVN0oVlIXklRQzkuDIgpOXy++8iHYz+LWEo6CbgG8usMEJlqb6mSyNae6V7flrUU+We64nkNJV
	PkhJn30P9EsxGz2kqQfFFRI943Djb3svaFtG0yttVNK1gOALlrsRCEDVA0K6FOPW8kIRqAzQBMZ
	9zq7M+wMsd7q4QYmFl2E6Yu2YMjlUtM1pJjpk15p64I3zrg4lCTjCp2T2gwouu0iuEiL4KiMyA+
	HgD4OFEDW5ewITY2Yd62oIkec/YnDSRVJ4Pq4PNMHajoUP7Pgq7Uv
X-Received: by 2002:a05:6214:411:b0:706:de4c:fddf with SMTP id 6a1803df08f44-70935eeed18mr164933426d6.9.1754387951288;
        Tue, 05 Aug 2025 02:59:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGERL535Nj+LI6rztA9IAgnP+naoieBDZmsnatDeRA4g6lNmzXFHANW7lm0JicsfOzA4t0Pqg==
X-Received: by 2002:a05:6214:411:b0:706:de4c:fddf with SMTP id 6a1803df08f44-70935eeed18mr164933146d6.9.1754387950742;
        Tue, 05 Aug 2025 02:59:10 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-33238272ff7sm19726081fa.7.2025.08.05.02.59.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Aug 2025 02:59:09 -0700 (PDT)
Date: Tue, 5 Aug 2025 12:59:07 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Sarthak Garg <quic_sartgarg@quicinc.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, quic_cang@quicinc.com,
        quic_nguyenb@quicinc.com, quic_rampraka@quicinc.com,
        quic_pragalla@quicinc.com, quic_sayalil@quicinc.com,
        quic_nitirawa@quicinc.com, quic_bhaskarv@quicinc.com,
        kernel@oss.qualcomm.com
Subject: Re: [PATCH V4 4/4] arm64: dts: qcom: sm8550: Remove SDR104/SDR50
 broken capabilities
Message-ID: <lkjp2353athoi76h3j3bgkcxdwfn6akcyyweipt4g774ztmmer@vcw7ru5red3n>
References: <20250801084518.2259767-1-quic_sartgarg@quicinc.com>
 <20250801084518.2259767-5-quic_sartgarg@quicinc.com>
 <69f2807c-9a28-4b31-97cc-2756f0ab9fd4@kernel.org>
 <c7e36755-9255-4209-9d53-20077bd1d3ba@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c7e36755-9255-4209-9d53-20077bd1d3ba@quicinc.com>
X-Proofpoint-GUID: gWUL8pM1Fg2FQKWWqjtKDPBQfqqqP1s-
X-Authority-Analysis: v=2.4 cv=F/xXdrhN c=1 sm=1 tr=0 ts=6891d5f0 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=COk6AnOGAAAA:8 a=kKDBy8IbGvpil11uj3cA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=iYH6xdkBrDN1Jqds4HTS:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: gWUL8pM1Fg2FQKWWqjtKDPBQfqqqP1s-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA1MDA3MiBTYWx0ZWRfXxWvNnmIjG8at
 4fhd3eG6bHHW4aRiDCl8xbKdq4jFhJ02okxiHrMwv64iMe22d+iwH68Q+zZMDX5I5PZhxoVxJ34
 7fpeZCv/81iMS8NE5YhxlRrYprxw9XMFUKSmFd+nKqICdxCIMvnAtLtpvpx8lhSgMJTMFkhp0eU
 qtzAibKcaFChhdUQre83PLs04x1TvLu8B51qH73BWsfX0O4OtfS1ycEbHFmvokUIKt8n+YdkGws
 X76W+Nh2atUIylIR+3RUqk7r/hQ4P2pEEpHqmZDkeayKe56YZZWEEe5JJu+PAEJiIct0DLmDoqi
 Dp0ULaw1OepAr7yvmhalWTb+/FFVaC8Nap/9kxotbsgBeupEIlCNWAhUtY3/R04MgVqB0XGzArf
 FZoj9nPO1DQzpBGJPimHpsFMfISwY06RjpUspc+iehEvo/OfxjJmYKQhFk9aj97sH/PuPjls
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-05_02,2025-08-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 mlxscore=0 phishscore=0 bulkscore=0 adultscore=0
 clxscore=1015 mlxlogscore=993 priorityscore=1501 impostorscore=0
 malwarescore=0 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2508050072

On Tue, Aug 05, 2025 at 02:49:29PM +0530, Sarthak Garg wrote:
> 
> 
> On 8/1/2025 2:32 PM, Krzysztof Kozlowski wrote:
> > On 01/08/2025 10:45, Sarthak Garg wrote:
> > > The kernel now handles level shifter limitations affecting SD card
> > > modes, making it unnecessary to explicitly disable SDR104 and SDR50
> > > capabilities in the device tree.
> > > 
> > > However, due to board-specific hardware constraints particularly related
> > > to level shifter in this case the maximum frequency for SD High-Speed
> > > (HS) mode must be limited to 37.5 MHz to ensure reliable operation of SD
> > > card in HS mode. This is achieved using the max-sd-hs-frequency property
> > > in the board DTS.
> > > 
> > > Signed-off-by: Sarthak Garg <quic_sartgarg@quicinc.com>
> > > ---
> > >   arch/arm64/boot/dts/qcom/sm8550-hdk.dts                     | 1 +
> > >   arch/arm64/boot/dts/qcom/sm8550-mtp.dts                     | 1 +
> > >   arch/arm64/boot/dts/qcom/sm8550-sony-xperia-yodo-pdx234.dts | 1 +
> > >   arch/arm64/boot/dts/qcom/sm8550.dtsi                        | 3 ---

You missed several devices which use SM8550. Please fix that.

> > >   4 files changed, 3 insertions(+), 3 deletions(-)
> > > 
> > 
> > This will break MMC for all of the users and nothing in commit msg or
> > cover letter explains that or mentions merging strategy.
> > 
> > Exactly this case is covered by your internal guideline, no? Please read it.
> > 
> > Best regards,
> > Krzysztof
> 
> Just to make sure I’m addressing the right concern — are you primarily
> worried about the introduction of the max-sd-hs-frequency property in the
> board DTS files, or about the removal of the sdhci-caps-mask
> from the common sm8550.dtsi?

This patch requires all previous patches to work, so it can not be
applied in parallel. It should be applied after the previous patches are
merged by MMC maintainers and then available in the Bjorn's tree. This
requires either skipping a release for this patch or using an immutable
tag for the MMC patches. All these deteails should be explained in the
cover letter.

-- 
With best wishes
Dmitry

