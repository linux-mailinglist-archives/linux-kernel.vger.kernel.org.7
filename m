Return-Path: <linux-kernel+bounces-842806-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A1A3BBDA85
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 12:17:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40CB33B836E
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 10:17:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A9C12264C9;
	Mon,  6 Oct 2025 10:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="B9BU96QQ"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 465ED1CF96
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 10:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759745842; cv=none; b=M+uC5FTNh8jB+rroe53EDmhCNLHmvDaSuayWZpw5ObUTHG6sz6W2FBM7IpIk0jX5sH2yNltW5uyyrgsTNGuF4NcKKTGD5gmkP7CvV3IQIodSTW+QJVfo9oZaGvRxyhCijVo1o92l3SGnWBGIH71M6KOaZ/hs2YhScRbIAWyGq+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759745842; c=relaxed/simple;
	bh=Tiky2pSy0auQKdURWLTUbAEY3hp4JAZJSG3LUSqJB3c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mYGA+gt+2y6yz4IccRU2rALWoSQF44ZMKf9gaF0kJOlzBlF/gPBpvhP/JHuSjy11Ooea6KAf2RC7wLgyLeOV+hn6PJ4Zt8YSvgAXvKWX6is7wLFV2brSiwGo6p9GlUiF3RHlXmTXYVyRTuF2gAGpVGchx10Nlj7Eegn3ZpINUQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=B9BU96QQ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5961Xi6w020520
	for <linux-kernel@vger.kernel.org>; Mon, 6 Oct 2025 10:17:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=mjBtCJA8Vf2Snrb94p+MIDHM
	Z5Q11YLNQRUSy7FdNjw=; b=B9BU96QQP+suuGlSaSdPb1SYqnSKAa9e65TOjuAy
	/4nYgMWk3Po67qruPcbQh+Yk9Qy6j6Nb/+3A/f8gmTMPeQOFtHqZ89+GhS8c11LO
	9VWUz44ZBaYdj79k8H7pJthOKVu2U/yd5Q48FWabId3mA6nyW9HsGMBHVtKberys
	nqdYCBuat00n8Ml/PEDVyljT7N/uTc2Pe42U88pxS/VylCvBPbSa+O7AA2W73ZcK
	AO0bXF5DruRzjVxrgA1Bib6xfHVC/ktTo7TZ4l9i2oBJ/if85cz41Wlwq81U49LP
	Zk8fACs3kvYTMWptKBbIukYyy4hsqxiVZ9A14azfD6qgow==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49js9durmh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 10:17:20 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4e56cd1d360so114122301cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 03:17:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759745839; x=1760350639;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mjBtCJA8Vf2Snrb94p+MIDHMZ5Q11YLNQRUSy7FdNjw=;
        b=Kv1WdWyiitSLT+SZR/aMi6WVRhxfJmfUEwFhr9f+sW/qfb4uLvQfJZVC2g1I5R7VmD
         buAhqix8a4nMyKt5DgTJiiGBXbPuvZ5wqwYUWW2HvKiJW9LOEZ7N1Syr09L3Sb1RnjuN
         IxGng+RgzRO+gJ08ZRHD6LCBtzfBVZfFOmurmrQqDJ8TR+vyN/uTQeFpvh4dkcA5RRkh
         I0EpUL3qeedY1TbdTjoAW7Ni4UFczYlLleA9kdVy9r9ZI5vx812AFKeLbPAJQF9OXGNk
         Tj5AdtSzqGPa9h4QtW6/5xGmsrYJm4DwVestHWqCLzoqk+arpgMvKDzJQ/cLuY9DJPtc
         L+yg==
X-Forwarded-Encrypted: i=1; AJvYcCVF5M+cs77JPnbnO+b9WDhbAv7ClqvyfF0eOVmdDpF3TJYEupFVWNwnIDCADCdOsTImth/PIBDkVleETFk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVfKepA11d2TfY6at3A0pwm7WOCsjMqTfFaqoxU1CWhPiIv1fX
	6YTbhf84S470lKIUhwcN0wv2jQFt8PEK95juMIwlYT2d0/09yQCg5twUUG3M1n9t+2e4AIjumkL
	yTInnZCepqb2M8LrtZ5bcz121eTVpBx5tnvCLsmnKojZz/9bBjQjRtDrYY2K4+VnKQvQ=
X-Gm-Gg: ASbGnct7hEFVTSp+jFRiiFIqzpD4Iis8gsCUSRW5IcSNKed1QyDuhf4cQSIotHds8RZ
	DnV1UbXl7J53l1X8dGF5QpLGtY3VhOlxtpbAka2mK9TgHJD6+sojyc3HlJt8h6tka86WEHhXkOR
	wMkFinmZkMJg+EQU8PvG2or+AQ3plgYp028x8EzcIyja/D9JFvuXlzlnHRhFQIwikABROK75yxP
	dPWnYwgvcJuUdFh3GKbZuml8H2vLTqeA/+8AYYEepV/dffS3I4kMMowabkEoT3zqU9VBQb1u4yO
	frKAAai6jigBrbYNam43z1Zqw8AXS5FWX8jn/QsJKC+oqeLje01t3bVhsOC+BSp5Toz13BqN4G6
	WwWnIdpB7zbcKsGd0XbSfwLD2vfHGi+m4heEF3KHVXMIOR4LIT+N60GhR8Q==
X-Received: by 2002:a05:622a:258d:b0:4b3:119b:ce78 with SMTP id d75a77b69052e-4e576a453e3mr139192301cf.6.1759745839376;
        Mon, 06 Oct 2025 03:17:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFneIl4EQIxJa6n32VNKE7X0s7JbEcg/88HnLrJYCESRbRjGP4rJ5I9OAoOz+kVVwCl6LHRww==
X-Received: by 2002:a05:622a:258d:b0:4b3:119b:ce78 with SMTP id d75a77b69052e-4e576a453e3mr139191901cf.6.1759745838716;
        Mon, 06 Oct 2025 03:17:18 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-58b01124dddsm4911460e87.6.2025.10.06.03.17.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Oct 2025 03:17:16 -0700 (PDT)
Date: Mon, 6 Oct 2025 13:17:15 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: david@ixit.cz, Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] Documentation: dt-bindings: arm: qcom: Add Pixel 3
 and 3 XL
Message-ID: <ssu3efxljgp335rv6u7lewisgtg5su7td3gnsnbn5tudo33ipg@g5dznpl3q223>
References: <20251005-pixel-3-v1-0-ab8b85f6133f@ixit.cz>
 <20251005-pixel-3-v1-1-ab8b85f6133f@ixit.cz>
 <bq3jeaxksk33ntdk32ojsdyh2d3qkglvgj6segtc3acizlkrhm@fvdsccdbuook>
 <6807638b-b212-44b9-b7cb-e53e1f11c0d9@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6807638b-b212-44b9-b7cb-e53e1f11c0d9@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=Hrl72kTS c=1 sm=1 tr=0 ts=68e39730 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=4j8LxGC6uulKEnvcibQA:9 a=CjuIK1q_8ugA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-GUID: gZQRMRkSifi0SlFI0xM5-jigPBFg2OA6
X-Proofpoint-ORIG-GUID: gZQRMRkSifi0SlFI0xM5-jigPBFg2OA6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA0MDAwNCBTYWx0ZWRfX5ErCt0g7kC7p
 XewGMpv+sURlbxbGLhiCHjINyBFMEsyTs9czQMtMEBIEOk57+WLs6O6WJ9YtfRSSjZjRn6InIDR
 FBC/ZvyZCyJl2b7f9jyyf0KFwP9SaK0tzzOyEdnjxExAXAc6ouFmJWu30MABFjv1nigg75FrUsk
 xQMbcTJU7gGc98SdYeT1HxsSiYiM70LXY6WbzzocAtFo9yDv5xr855up5VZ3KwYPjBNypkEMA2B
 CfAvklgMXx+Ux2+pEdMxN4TrejLFDcjF/tb8oSPvwvjRjh7nOm11V0Poi4VuUnQS4xLORqg2KU9
 VN3bb/oZcM49HM8bBbt+NFqqYMOpKf9MAMaQoQce80vzOgZu9Zx63ssJMi8FV7Iez66vhTquI2x
 8Wrt76V+ryvcE0XuVfT2kW8/Foq9Wg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-06_03,2025-10-02_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 spamscore=0 adultscore=0 lowpriorityscore=0
 bulkscore=0 priorityscore=1501 malwarescore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2510040004

On Mon, Oct 06, 2025 at 10:09:58AM +0200, Konrad Dybcio wrote:
> On 10/6/25 12:21 AM, Dmitry Baryshkov wrote:
> > On Sun, Oct 05, 2025 at 03:16:28PM +0200, David Heidelberg via B4 Relay wrote:
> >> From: David Heidelberg <david@ixit.cz>
> >>
> >> Document the bindings for the Pixel 3 and 3 XL.
> >>
> >> Signed-off-by: David Heidelberg <david@ixit.cz>
> >> ---
> >>  Documentation/devicetree/bindings/arm/qcom.yaml | 5 ++---
> >>  1 file changed, 2 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
> >> index ae43b35565808..2190c5b409748 100644
> >> --- a/Documentation/devicetree/bindings/arm/qcom.yaml
> >> +++ b/Documentation/devicetree/bindings/arm/qcom.yaml
> >> @@ -976,9 +976,8 @@ properties:
> >>  
> >>        - items:
> >>            - enum:
> >> -              - google,cheza
> >> -              - google,cheza-rev1
> >> -              - google,cheza-rev2
> > 
> > Why are you removing those?
> 
> I removed these a long time ago, the base for this series is 6.17-release
> instead of -next :/

Anyway, they should not be changed in this patch.

> 
> Konrad
> 
> > 
> >> +              - google,blueline
> >> +              - google,crosshatch
> >>                - lenovo,yoga-c630
> >>                - lg,judyln
> >>                - lg,judyp
> >>
> >> -- 
> >> 2.51.0
> >>
> >>
> > 

-- 
With best wishes
Dmitry

