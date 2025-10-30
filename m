Return-Path: <linux-kernel+bounces-878081-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 92969C1FBE8
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 12:13:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB9041A27A55
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 11:11:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B12F33559D0;
	Thu, 30 Oct 2025 11:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="bjF1szMk";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Z+L/6C/b"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B0F0342CBB
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 11:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761822594; cv=none; b=rmjZ5pjq4PrqP3WNN8sx+RwiH2RSmaL9oJ2NoCXXSA2VPP/cQpaNAQQ55igBfW4K2fz/Pq7QaLkSCs3FqpAKmVktlb2R76tq41TV8adskQJvz6BaVI3iLWmJAutfIayuj4hO+2cjn0ETrjSZnrC5wWo05r9qCoALfJlMww7NZUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761822594; c=relaxed/simple;
	bh=WN6RMBwkOJd1/iIMPaHzRsVxFObpYnCTdWoFhh4uxaM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GPTRtdOQvHvlLtGTnOCFd59MJXqP470/Fuqfym6XW+v+DLXD+50DJIIUhelnDyVl+qOXEXLUhzwXTKCiTkQlD5x74T67bzbuljDtjF7LDBS/KkTf+MjG79Ma25avrGHkZ2AHBrQyWECaATh1MFEbsTPVWylAVHe5FwHJIGBWy8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bjF1szMk; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Z+L/6C/b; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59UB8YfG3808750
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 11:09:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	C3t+V/SRFoYfytayU9pkmTuSfwG91Y15AOZSC71aJ0w=; b=bjF1szMkLfb8GjNw
	3PRfJhc4OHw+cOIELts/Ku8ae1xapRq6ydqJvRMOn7utIxuB3J+HwT2IMkO3OWR3
	3wSV78DQOXdNnXCcB5o+mXMhIGU+g/7ukRT1s3HWkQIckUH38NVJtvHUnYQnGlL4
	LwUasELqWs+iOsHRXnBLqm03loOXA75ABUYHco0O/NK/2Toj7HnFUVWwu0wCyulZ
	d0rwIjk9N0bSm5aTbm38s1PAYEFuITXIrpXK5IHMuhUPXJcq34nYJU8wCPM7o01n
	0vVaAfilr+44ICAEhzxizWop17uqozvnn5B0tz0JS3jOSC1dOC2ymF6H31rTW34A
	yDF99w==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a46vv8049-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 11:09:52 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-33be01bcda8so941416a91.2
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 04:09:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1761822591; x=1762427391; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C3t+V/SRFoYfytayU9pkmTuSfwG91Y15AOZSC71aJ0w=;
        b=Z+L/6C/b/Wtjz8LNTpwMGUgksDGA8y5RAUxjR6wDrE9abxjBdAupFnfvtA7qTxTkq3
         Nqe6Ve6kWInbKw0al09U3mOzD219MzlbP3BLJVdTqYPZ351yDBeFQlUeHobldnZTRpO0
         SoBBDCegvkjc2LEP+sj28+KM+aQtKGB7QO1bHmf24zKKVKc+/QEBfQNJF+JymZucuJnR
         qpSXMgKVYT2MgXtBknsLn6NjMyRrRbDzA7wtzQ6IGiogEDIbWd3+7HREKF52/pnMKqf+
         d5+9HP+KXkm/0xJGlXoBDZfJbTfGtMVIbqX/mNWzKN5VYptohb+e8YYLgXCLrW/MK1wd
         +fIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761822591; x=1762427391;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C3t+V/SRFoYfytayU9pkmTuSfwG91Y15AOZSC71aJ0w=;
        b=eDyYYhcDrI4MNKjeO2DIaAov9ExWco2yQt71oqzyhUvYWU9J6Qyy9W+NNIXR5X3/eA
         1vuvMGHBXtQ/aXfGuErmHQJdQy9bWmIBMiO0W83/b48Wuus1Q8WWlXp4gZPv9S6UUgP0
         Fymz1po9teBJyhspn18weIqPor9/LrlmfLCX7Gs4rgIx19aUYoxmALqNnSN9NLshELHO
         x15VDUbSEwNoSLJqrhOAU9eLXGEihCfg7Oz59MF28m3hrWsnuhRDm8p4aQCgVoiAYIdY
         yEDjbJlwE5dFmA4l0DYTMA8Lk8nerCv+RGA2i/W15K6hWYQI/wBDiC2ugIKDvZUA04Ya
         QhCg==
X-Forwarded-Encrypted: i=1; AJvYcCWLIVXFXwtsGK1zE5dEwsSVJviRATIZrku0wa/kCyFdPK6Xcjgu8J2+ZN0w/6MLJRvl9kyMLsjssH7QhxE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVwsI9gtEX/G0BpQuD7rmS1CQgRjde9zjHFsYmQVYUTM3RyVuy
	H4Pii54ll1As1VIis+BuOX/aBUa3spDCN4xV9EXNJMDpEDh3VI6ILU0FufaxQuqvBvILIcouB7n
	KvH5knbPO/f9plDTecz8U8iBOK7jLyTeut0BMyOD9Oe0FZ8N4LodXYzQ4xOGh82cqYGuY+T97Hn
	Tb11WBL4W8R8sAn2nfzlXquEZGnmaSSm3wK/nkQ/XbRg==
X-Gm-Gg: ASbGncuCNYrGNmGwc8FFSKKS3o9Xzk2rdo60dZMH5A/gy2yTC7aTf2HGPcK0lYlwhlO
	vCXl5Y+9zilHWchVoc4W/eVrPVLwcEulzz7wQfAvfB9bMCmHDsHCCecK+A8onBCoMP77fjTxSnN
	pUQFsEvmoGJdv04TSoe5yoTw3Yw/WxSima+hpi2a8h+B0vmYnl+Q4uO+NT
X-Received: by 2002:a17:90b:28c4:b0:32e:1b1c:f8b8 with SMTP id 98e67ed59e1d1-3403a2f1869mr8283798a91.26.1761822591239;
        Thu, 30 Oct 2025 04:09:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHuWpqx2dQdmzUz1hZvXjx7VVf4+VIGRNiz0+Zaq+XhkkcB2ivQP29u5OES2V8GiXIBVa6H9GEFSmEr5sBRwm0=
X-Received: by 2002:a17:90b:28c4:b0:32e:1b1c:f8b8 with SMTP id
 98e67ed59e1d1-3403a2f1869mr8283746a91.26.1761822590649; Thu, 30 Oct 2025
 04:09:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250925-v3_glymur_introduction-v1-0-24b601bbecc0@oss.qualcomm.com>
 <20250925-v3_glymur_introduction-v1-3-24b601bbecc0@oss.qualcomm.com>
 <2960a6fc-106b-4280-b4d4-9c1a3a449454@oss.qualcomm.com> <0a47016c-1d7e-4026-92bb-a13ac2ce169b@oss.qualcomm.com>
 <gg7srymb2dspk4jeycc5su5gjl434ymgzapqqyqw7yq2marzue@ql27qx2ptuo6> <a52ff3b6-c5f3-48a8-a8d7-812026b0d87e@oss.qualcomm.com>
In-Reply-To: <a52ff3b6-c5f3-48a8-a8d7-812026b0d87e@oss.qualcomm.com>
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Thu, 30 Oct 2025 13:09:42 +0200
X-Gm-Features: AWmQ_bm0nqsGfZToTGMJZvwnm3Zigyl1Y1rqsBL9EH-Xv3C031bXjloOuVadfTc
Message-ID: <CAO9ioeWafyhCdcOt0V9DBwupvSbGg66T-JUL_2rhcTpxQxj2vw@mail.gmail.com>
Subject: Re: [PATCH 03/24] arm64: dts: qcom: Introduce Glymur base dtsi and
 CRD dts
To: Taniya Das <taniya.das@oss.qualcomm.com>
Cc: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Pankaj Patil <pankaj.patil@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: tFFLCIWIZmFVLkALp4R6EK7fb8kXPKjx
X-Authority-Analysis: v=2.4 cv=dK6rWeZb c=1 sm=1 tr=0 ts=69034780 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8
 a=x9u-acLCX0oi0GpMQDsA:9 a=QEXdDO2ut3YA:10 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-ORIG-GUID: tFFLCIWIZmFVLkALp4R6EK7fb8kXPKjx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDMwMDA5MCBTYWx0ZWRfX5rRU+W/7Ytod
 7MwUyL5/ybRxrbnoz0acGifdL8Q9LjJf11sZY9rpNiicElcbHyIya93wvjbFSYpVqQMrSg45DF3
 xVM9KYd3FfnYNWgAVvsXa+c2cHHsEd3bQYtkf8cq13ZVP5CAKGTwCMdCWLgbNl+UVDz/dpFc3ng
 Pdj2+R1OEN5CiBYZgq9Ogzc1SSwsVWuS8/2GR79TeJfd8Ip3Ttcku8opzD5T6c/fY6g7dOJ+Qpl
 u2Z1bw7YpmBeG1jDemMv7kNG7GVun8zyL8vDg+RBfa5eS3JbkLKwASjHcFidvIyay8HTS1vsRCm
 b49LjSgJWfdEY83j23ZeimV5eYkNhA2biYlb679gRzFWe31ucViUefbClYSmqb/WU2oDzQclVPg
 WjV7YIaxG31g1kP94G2/5lYaF0V0nQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-30_03,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 suspectscore=0 clxscore=1015 spamscore=0
 lowpriorityscore=0 phishscore=0 priorityscore=1501 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2510300090

On Thu, 30 Oct 2025 at 12:44, Taniya Das <taniya.das@oss.qualcomm.com> wrot=
e:
>
>
>
> On 10/29/2025 4:06 PM, Dmitry Baryshkov wrote:
> > On Wed, Oct 29, 2025 at 03:30:54PM +0530, Taniya Das wrote:
> >>
> >>
> >> On 9/25/2025 3:46 PM, Konrad Dybcio wrote:
> >>>> +          tcsrcc: clock-controller@1fd5044 {
> >>>> +                  compatible =3D "qcom,glymur-tcsr";
> >>>> +                  reg =3D <0x0 0x1fd5044 0x0 0x48>;
> >>> We can map 0x1fd5000 - 0x1fd5094 inclusive, as that seems like a
> >>> logical subblock (this would require adjusting the driver)
> >>>
> >>
> >> Konrad, we encountered issues when trying to map regions beyond just t=
he
> >> clock reference registers. Normally, we map the entire address range o=
f
> >> a clock controller (CC) module in the device tree. However, for TCSRCC
> >> where CLKREF_EN registers are located within shared modules like TCSR =
or
> >> TLMM=E2=80=94we don't own the whole address space, and mapping the ful=
l range
> >> can overlap with other devices.
> >> To avoid this, we propose defining the base address as the first
> >> register actually used, and the size to only include up to the last
> >> register we use. This ensures we only map the relevant subblock,
> >> preventing conflicts with other device nodes.
> >
> > Then you need to behave slightly differently: map the full range at the
> > basic device (TLMM, TCSR, etc.) and then create TCSRCC as a child devic=
e
> > to that node (and use paren't regmap to access the registers).
> >
>
> Dmitry, I agree that this approach is ideal. However, the current
> hardware implementation isn=E2=80=99t consistent across multiple SoCs, wh=
ich
> means the driver design also needs to adapt. Given these differences, we
> decided to strictly map only the range of hardware registers that are
> actually used for clocks, rather than the entire module.

You are writing a driver for the platform, not a generic driver for
all the platforms.

>
> >>
> >> So want to keep the mapping same from the start of clockref clocks.
> >>
> >>> There's also a laaaarge pool of various TCSR_ registers between
> >>> the previous node and this one.. but we can leave that in case we
> >>> need to describe it in a specific way some day
> >>>> +                  #clock-cells =3D <1>;
> >>>> +                  #reset-cells =3D <1>;
> >>>> +          };
> >>>> +
> >>
> >> --
> >> Thanks,
> >> Taniya Das
> >>
> >
>
> --
> Thanks,
> Taniya Das
>


--=20
With best wishes
Dmitry

