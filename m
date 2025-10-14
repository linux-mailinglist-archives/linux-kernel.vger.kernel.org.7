Return-Path: <linux-kernel+bounces-853293-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 62F8FBDB21C
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 21:52:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 587F13B052B
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 19:52:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF508301702;
	Tue, 14 Oct 2025 19:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="CnIzFCOZ"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 618C82D322E
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 19:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760471537; cv=none; b=hj6e+SjShimXYNndjQ4nl1YgWNk/kBH8bhfbCUpjE1JFGnH3zZxD1+0oWEthuaHk3cleed9yFYJ3C979Un1ikkPxBa3xLnPZU0bm1cmsM5wCSeJcoobgzNvRx6D563zVbEQ6v1uGhnqxtmZu8zcq45+f0WClhmzaFcGrllOLiZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760471537; c=relaxed/simple;
	bh=MldrdjjVbk2vSLcfcDGESxPH9MtFHvBHW7Thz6YJ8nk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TciTCgenrKBNA2P8Z/txE1VZFklSvaX5utY8SOmZNvWSZ/RcsZGYGEuf/SmlhLc7Su+lyXsJgOlLDvSyEWgzRcRuRTwXGi2a2JH+YZgilKRy9RuTp4sTEfWZ0l8gnwn9OrZXNUF42Ff41YqRqI2DsD2ZzPIDnv5miBi4OZai7W4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=CnIzFCOZ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59EFWclB008937
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 19:52:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	FE8ab9b1Aojs54zfzqipUaznRoSyN2GE+suwbEktyuc=; b=CnIzFCOZZxGC+d1K
	epihuDKB4rboKQN/WAI7C5dt1d+VWxWXmqWzWcBUZH2Ki0/iwXJ3Gp9ckbrC3Q96
	eh5jPNHyrptQlE4U8kp3KwcLuzQQbD2y/PT9+uP+PmkkYKxtFiPxNk314UAXZnng
	1iFV+cSBInt2OOg3Hi6WdYFp5UKBSBY9Gxx0kDcI9mIFtizDxI+rpySyodzxndSX
	JrbXQb1+uaCVSITumwUDcNOkSeUL4GiHV8qKBuV+nfijXClbNMmUD9rJjNxQi9iO
	oqd75UxN98YgtoqIRtdhpL0wCwfz3aBgox8/jwdukfGfQbsnb6iWBIB1ZSc00sAm
	sFng8A==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49qfm5hut2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 19:52:14 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-78ea15d3583so255997596d6.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 12:52:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760471533; x=1761076333;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FE8ab9b1Aojs54zfzqipUaznRoSyN2GE+suwbEktyuc=;
        b=mnjjinSmeJFCMsWbCRZwG22MRUYga8qHOXcdRFYjDdMwNka9zJV4Jw3MvFmqWKiBr2
         P5kukz2spowfsgEFBhwRoUV17OZrRduXXDmyE7IELBpVyHPtoh5HrqmhbiSGrsY0bx7/
         sgJ7r0zC6ZRL4hv/Q8jvUpZa1x2jXlnlQhzpk51LXGIu9Oe36bZ1sQBcx5xUaIDH0Gjr
         iQPHi2gh8htIZPGyAw2EVxuNnDonA8XR7j3iJ/EE0cK/t9wCNr6oEa2GvIJvuMfcWhce
         9gU8vDTIpKmVEq4ChYmq1ltMFVztdXfoMxbFvV7aSOE2RJrOMWBmPv0ZVTkT5s81EvdA
         ftcw==
X-Forwarded-Encrypted: i=1; AJvYcCXqpTdIfr+QsH8422LPi+A5utaxsfoMA/AdpCElTtNkBVB1lunjZH+HIdPR6BoLl1NGA5rBOr9eXY++FeI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpzCSjCSRuLFdFo863l/WDz8vBY+WDk9kAuChRa5k7roeuMu3j
	LP6T3wSvoLSZfCYHjfMvQgvtap2G14Uwbud1JUBnIFmHuMAyjKKWK7bzP3IxW5GrAICUzcB37Os
	mquhqdkm6fTzsysw6/uMYS+hPKZs5eNusVWATXdFPbmMdsgqn0SZVBWAKXUt6Tgt54YY=
X-Gm-Gg: ASbGncuJnQ4UL3cm6p15AIOoIfgjTxLZHeu4hwbMek1767IvGbX40CPwMHtGfCB8+/t
	ZXRBw4NsFuMbp0gchOGukf94EnXSn110Ku3Ew2nClRn0vEruVS5Bv/KcuBSuqQigOfnk1dnVbER
	MvLCz0B7jH7mMfo1gaeu79+ursG+hOFXXg09ghhSoNZcqCPCWi4zzoIw0JrgSxrPt2SKrsqqsHI
	EjMckaUUGCC7a4h06cVjpTq8rnK+QurIMTgg0FtJP0D77iQnaF9Ln1HiKJFppvgBjoJr0AWZe6A
	wIaKiQyXNmuJ808RKtFXUyJ2CUl02sGffwoCa4ez52h+X3fHb/nAqVDEfm55cXyjMfo13Hv892Y
	8x8TNCP3HfAv173tjCt+WwegTW5rQMk5Op6PrGmU/ZraVfGGV9Y3S
X-Received: by 2002:a05:622a:1109:b0:4e7:3a18:c50c with SMTP id d75a77b69052e-4e73a18c6a7mr38823601cf.29.1760471533233;
        Tue, 14 Oct 2025 12:52:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG/b54gij/Z9LNqxtZyviJcaCwCE73o4iaf3lQkWjY+f7mz3xk3dVSt5hsvqmSCN+n4FLev9A==
X-Received: by 2002:a05:622a:1109:b0:4e7:3a18:c50c with SMTP id d75a77b69052e-4e73a18c6a7mr38823371cf.29.1760471532781;
        Tue, 14 Oct 2025 12:52:12 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-590971ea4easm4401509e87.53.2025.10.14.12.52.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 12:52:12 -0700 (PDT)
Date: Tue, 14 Oct 2025 22:52:10 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>
Cc: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Pankaj Patil <pankaj.patil@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 17/24] arm64: dts: qcom: glymur-crd: Avoid RTC probe
 failure
Message-ID: <cgfxsjr53dz5i3pjinljywah4b2jgeomnglranaty6cazek5wb@gyjpt4auwchd>
References: <20250925-v3_glymur_introduction-v1-0-24b601bbecc0@oss.qualcomm.com>
 <20250925-v3_glymur_introduction-v1-17-24b601bbecc0@oss.qualcomm.com>
 <CAJKOXPdi0+c_FqinVA0gzoyqG6FVFp0jq5WSLsWWKiT12VVs3Q@mail.gmail.com>
 <CADhhZXaB310hVo_w8_CoJLQ3j9dy1eeTwbmk0q=vUV2ga1PAYA@mail.gmail.com>
 <8f81289d-7672-42e6-b841-6514607cdb38@oss.qualcomm.com>
 <20251013110407.dqpjdrdaw4gzpcy4@hu-kamalw-hyd.qualcomm.com>
 <49004d3e-7914-48ee-8705-ee86d1944166@oss.qualcomm.com>
 <20251014123658.sobt6ab6gnbafyme@hu-kamalw-hyd.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251014123658.sobt6ab6gnbafyme@hu-kamalw-hyd.qualcomm.com>
X-Proofpoint-GUID: U9gwp2oSAVyUSgeviJ08IcTbZGM6UuUB
X-Proofpoint-ORIG-GUID: U9gwp2oSAVyUSgeviJ08IcTbZGM6UuUB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAyMCBTYWx0ZWRfX9yI565S0O4GD
 jCW0mV4fN8gEBF2goL3whXG9MsgjNJnC1bp80lfiFwzXCj+9CZK3Eg18Z2sESW9gNVOU9bMrKEM
 OIydTw1KGqOTHoRdhUZtLBJhyITAY2PzRYaQns5ctx80OmRD1b97c0nJB1bP6Nmi48e/awZpY+i
 /HN8RtDMUR0JUu9dASqW8EN93+QdskOMXeT1Uhn0KUV+iTRf6SDkbZcfFWNbICoLXOUSwXKT+ES
 HzxfqbkF0Q9yF93MXifzv0T4R8quadLFSCNuiyYHUtCPpA5nhe/j0Hb8HASgMly/MYz8yGsiKxB
 i52ijrvm2B8cN/snc/NI9rJZhnNWVzivq0OQrQmWSchMf80KmjskVw6jShvtXFv7w7fF/cHWdH9
 M3aLteYNkvHI97FW6ttX4UEWHG9hFw==
X-Authority-Analysis: v=2.4 cv=V71wEOni c=1 sm=1 tr=0 ts=68eea9ee cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=dw0t6H4-AAAA:8 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=CsomoNAreF6FlIaDNSYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=1HOtulTD9v-eNWfpl4qZ:22 a=wVJa4CU9-Z26yuRAZDil:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-14_04,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 spamscore=0 adultscore=0 suspectscore=0
 impostorscore=0 phishscore=0 clxscore=1015 lowpriorityscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510020000
 definitions=main-2510110020

On Tue, Oct 14, 2025 at 06:06:58PM +0530, Kamal Wadhwa wrote:
> Hi Konrad, 
> 
> On Tue, Oct 14, 2025 at 12:23:23PM +0200, Konrad Dybcio wrote:
> > On 10/13/25 1:04 PM, Kamal Wadhwa wrote:
> > > On Mon, Oct 06, 2025 at 04:28:59PM +0200, Konrad Dybcio wrote:
> > >> On 10/1/25 2:23 PM, Kamal Wadhwa wrote:
> > >>> Hi Krzysztof,
> > >>>
> > >>> On Thu, Sep 25, 2025 at 1:41 PM Krzysztof Kozlowski <krzk@kernel.org> wrote:
> > >>>>
> > >>>> On Thu, 25 Sept 2025 at 15:34, Pankaj Patil
> > >>>> <pankaj.patil@oss.qualcomm.com> wrote:
> > >>>>>
> > >>>>> From: Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>
> > >>>>>
> > >>>>> On Glymur boards, the RTC alarm interrupts are routed to SOCCP
> > >>>>> subsystems and are not available to APPS. This can cause the
> > >>>>> RTC probe failure as the RTC IRQ registration will fail in
> > >>>>> probe.
> > >>>>>
> > >>>>> Fix this issue by adding `no-alarm` property in the RTC DT
> > >>>>> node. This will skip the RTC alarm irq registration and
> > >>>>> the RTC probe will return success.
> > >>>>
> > >>>>
> > >>>> This is ridiculous. You just added glymur CRD and you claim now that
> > >>>> it's broken and you need to fix it. So just fix that commit!
> > >>>
> > >>> I'm afraid, but this is an actual limitation we have for Glymur
> > >>> (compared to Kaanapali).
> > >>> The RTC is part of the pmk8850.dtsi that is common between Kaanapali and
> > >>> Glymur. On Glymur (unlike Kaanapali) the APPS processor does *not* have the RTC
> > >>> IRQ permission for the RTC peripheral.
> > >>
> > >> This is interesting.. is that a physical limitation, or some sort of
> > >> a software security policy?
> > > 
> > > This is mostly a limitation for all compute targets(like Glymur). On compute
> > > targets we need to support ACPI TAD feature[1] this feature uses the RTC alarm.
> > > In a nutshell, this feature implements 2 times - AC ( adaptor power) and
> > > DC (battery power) timers, and based on active power source(AC or DC?) at the
> > > time of timer expiry device will either go for a full bootup or stay in power
> > > down.
> > > 
> > > This feature is implemented on a different subsystem (SoCCP subsystem), and
> > > since the SPMI `IRQ` permissions can only be assigned to only one subsystem,
> > > so we can't use the alarms on APPS. This is why we use no-alarms DT to register
> > > RTC device without alarm-irq support.
> > > 
> > > [1] TAD specification - https://uefi.org/sites/default/files/resources/ACPI_5.pdf
> > > section 9.18
> > 
> > Hm, is there maybe some sort of an interface to talk to the SoCCP
> > and set the RTC as we wish, from the OS?
> 
> Yes, the developement is almost done and we have done some testing as well, but
> that kernel driver needs some more cleanup and testing before posting to
> upstream. This will be added in future.

If the series is reposted, please add a comment, pointing out that this
is a temporal measure and should be removed later.

-- 
With best wishes
Dmitry

