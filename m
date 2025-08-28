Return-Path: <linux-kernel+bounces-789930-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 17727B39CDC
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 14:19:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5282564731
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 12:18:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33F233101BA;
	Thu, 28 Aug 2025 12:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="joJzk8fP"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 225882BE7B6
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 12:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756383346; cv=none; b=qfyxc7MflcUOXZZcKH8PgJ428tf5hqHRO6o8QowBezK7sz1CDl+2nH/le+49HD6aBUek79n6Emnce69TFpp5mlHroGfGL14LploAdrqvML6VC1GYbG0VrEICtrlf95AqmuW88DwVkcKxXhms21G3mzYA4hW0X3x1deqYQGtW2XI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756383346; c=relaxed/simple;
	bh=2xhCRHRTLxjuQLGzNqN8SkuqvNwon6nBw35IuX6DRFU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VXgRew71zLYWWP5aSrqzcWMKCsTgH4TeWmS9zBmVdzFS/FtuVs3XxgFI5B5xg5JTyCEc0oS4+mZzLz15xAczlIQT3PgWAiTqCZ5dpkc6HwFEKBBTWgsRZAoDKa9/9w3NnAKuf9o9cPn/kWZGemGym+RG3r5Ja3Gge3Y3rLdNOAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=joJzk8fP; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57S664AV027275
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 12:15:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	sOlqLjJ4+85L5pngv20TDeHigXp7nWgjBGPjqExbJGw=; b=joJzk8fPNrb07kV1
	dPOO5dApt8wVm5oGGKgWCtdV1DFmHk6YUQr/vY+qBY/dA8Yp4hWvEQoBbrOyffgC
	BGUsq0HIo3yO1faSCFveHXeFtNtrfvVejrq9dSn+Dkmb3XT1d5HU0z/f8zK+OAHl
	ahjtbhYx5A4Xg6LJwcZOM8UpLCihss2TAa6A8jBAhImd87Gh8js3+Wlzs2uiBWK6
	ptDkBEyTayINCtjYnqoXXdfgiZNvmjbEPj8Z3fWZJuNy6HVOS/kjpXptsxpCL6hI
	/KDPt004yUYkMVNXtjmtXJwa9NZRbA3EPFR40LhwZrTpoC04a9IvCRhmsoGfEAWz
	rf4YAQ==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48se16y5m1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 12:15:43 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-327709e00c1so974931a91.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 05:15:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756383342; x=1756988142;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sOlqLjJ4+85L5pngv20TDeHigXp7nWgjBGPjqExbJGw=;
        b=LNzZ+5LnPSwApWMe4/X+aB2ejAakh7BH6iK+a9onZg1Azp+6GjeJYeWUq7DPvSQSib
         vTenUcXGjIAzLCcmFgIZZF0t8YYTyUbKoaK+6CjcSsh6KRvN+0gOZtjmbxJw3yBACtJN
         eSQprEirWakY3QfUwojYydHWIhrQBDKRtLzgdrS07oVMo7bnw2HNJ+SHDnu3RURjw7OZ
         B2cG+mL7WS/WLvV8SW/bZC/b9ai3lU3WFV4afbE+nm9+SdTBRMYPw1WZYm040bGfS3Uo
         b97HBQxeg+oW3mvM6ifbLCuCpgZaGC7MvZfpSbliMFycnHVqDHRX4oRqjwBR6fxJuyT0
         JQqA==
X-Forwarded-Encrypted: i=1; AJvYcCVBdJ0zwBFDui6TBHTCzZMTLBnfwAtgfIBurE5q5NJOo6axoCosLrC3yQYRotZpgU3lFJQB9m9bOi3mIak=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1/8FiuXO2OXjz3H5FcTJOTMW5MMNQpYBdZADZia4E30YInZ6E
	VxledrtfuaUX5w8L3nvHxDOnTAPHB/2RGqkvTL9W3NV9ClZtk/5HWmRaC92quq3kqDL2bOx4UzL
	7iIvAf3ZRqWm5rhjALzdIb8RkwdhJ7zjIIjp5HE8aYwvqO+SgwwTI5dc5ybvdZnaYfmOes3v8cE
	jcvAUMks5+w+vVlILnvI9Gr30CoFQBhZOvBypiRxoULA==
X-Gm-Gg: ASbGncsip5f/Vw3kgbutxfSJBb5xCg/4wSbQpgVSqd/yIVf6wfudqlKzR8tMczyK/Od
	dugf1E7oWzhrXzFIG/jZrsHVmyfxEVN0xPaZeJQV3OFsNjBBKk4fFGcVq9DtsYLsvrFgPEXyL2r
	dXl2CIqZxi3AtTMf/0NfAedGs=
X-Received: by 2002:a17:90b:3bcd:b0:31e:ec02:2297 with SMTP id 98e67ed59e1d1-3251744bd07mr31170091a91.19.1756383342300;
        Thu, 28 Aug 2025 05:15:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHSsXkSAZdNMuiuXSHYHnTqO7N+RkBf5W6xlTEjzKw50BVu/0ezesPtrdfj3US2rSF06Spip/rafkI1bV+Bz8o=
X-Received: by 2002:a17:90b:3bcd:b0:31e:ec02:2297 with SMTP id
 98e67ed59e1d1-3251744bd07mr31170041a91.19.1756383341777; Thu, 28 Aug 2025
 05:15:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250812055542.1588528-1-krishna.kurapati@oss.qualcomm.com>
 <20250812055542.1588528-4-krishna.kurapati@oss.qualcomm.com> <d121952e-4662-4651-9398-3a5446a2281c@oss.qualcomm.com>
In-Reply-To: <d121952e-4662-4651-9398-3a5446a2281c@oss.qualcomm.com>
From: Udipto Goswami <udipto.goswami@oss.qualcomm.com>
Date: Thu, 28 Aug 2025 17:45:29 +0530
X-Gm-Features: Ac12FXxpoBpQzfudUCruaW0Kd4qcz4c4oR-SINclPGIyBv5ZH2lkiXCY60AdRnw
Message-ID: <CAMTwNXBM2m6sazPZVng3V-DDJP2T0aVBgh8C5d4K7Yq_O_A2Jg@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] usb: xhci: plat: Facilitate using autosuspend for
 xhci plat devices
To: Krishna Kurapati PSSNV <krishna.kurapati@oss.qualcomm.com>,
        Mathias Nyman <mathias.nyman@linux.intel.com>
Cc: Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Mathias Nyman <mathias.nyman@intel.com>, linux-arm-msm@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: R8c2ye-EoVFMZ92Z4HBSVzjDKRIbnqo8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODI2MDEyMCBTYWx0ZWRfXx5Jd/K4IgQZm
 zxwrGF9QCDISE6dmOLBOVxwNuXi4VB8aZzy/eBY76hhBkpxMZq0ijfmo2mpLH59VdfEI5PcWz+p
 fiZ8iABFh8/18dcspwQ6MxV9aU+T2zpIZb73vaOcLl7zhYQz8XK/LvtkPTNDDzGewt9cU3yHEvF
 bYxUfaLDPxjvE+h3p7orbmGxY8Ry4puJ/N8kT3ruJnA1VYLvHKBe1LPjb1cljYJS5eWgOemEfxi
 smYSBuaRg/CTfzXeZn4o8f19o/3pb5nBbsjgFiIsNs9+7cY8sE25nAfpidBJgpVnz3jM97Aa4RD
 UGKsYchxEFekKjhtXmi385RPEdcy8EhdCWcpChfgkzvSea3f1GdGdsrp1JdD0cfeIVxIIXCd9ZN
 VH6Arr9J
X-Proofpoint-ORIG-GUID: R8c2ye-EoVFMZ92Z4HBSVzjDKRIbnqo8
X-Authority-Analysis: v=2.4 cv=CNYqXQrD c=1 sm=1 tr=0 ts=68b0486f cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10
 a=EUspDBNiAAAA:8 a=VUFb5atXsKZqicoco_gA:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-28_03,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 priorityscore=1501 adultscore=0 spamscore=0
 phishscore=0 suspectscore=0 bulkscore=0 malwarescore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508260120

On Mon, Aug 25, 2025 at 11:10=E2=80=AFAM Krishna Kurapati PSSNV
<krishna.kurapati@oss.qualcomm.com> wrote:
>
>
>
> On 8/12/2025 11:25 AM, Krishna Kurapati wrote:
> > Allow autosuspend to be used by xhci plat device. For Qualcomm SoCs,
> > when in host mode, it is intended that the controller goes to suspend
> > state to save power and wait for interrupts from connected peripheral
> > to wake it up. This is particularly used in cases where a HID or Audio
> > device is connected. In such scenarios, the usb controller can enter
> > auto suspend and resume action after getting interrupts from the
> > connected device.
> >
> > Signed-off-by: Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>
> > ---
> >   drivers/usb/host/xhci-plat.c | 1 +
> >   1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/usb/host/xhci-plat.c b/drivers/usb/host/xhci-plat.=
c
> > index 5eb51797de32..dd57ffedcaa2 100644
> > --- a/drivers/usb/host/xhci-plat.c
> > +++ b/drivers/usb/host/xhci-plat.c
> > @@ -171,6 +171,7 @@ int xhci_plat_probe(struct platform_device *pdev, s=
truct device *sysdev, const s
> >               return ret;
> >
> >       pm_runtime_set_active(&pdev->dev);
> > +     pm_runtime_use_autosuspend(&pdev->dev);
> >       pm_runtime_enable(&pdev->dev);
> >       pm_runtime_get_noresume(&pdev->dev);
> >
>
> Hi Mathias,
>
>   Can you help provide your review on this patch.
>
Hi Krishna,

I think the email added for Mathias isn't correct.
Adding the correct one.

Thanks,
-Udipto

