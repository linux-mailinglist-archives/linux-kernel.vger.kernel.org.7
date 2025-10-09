Return-Path: <linux-kernel+bounces-846846-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BDB72BC9383
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 15:14:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 416FD3E3C93
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 13:14:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 946672E6CDA;
	Thu,  9 Oct 2025 13:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Fb3Ey9bA"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 412BD78F59
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 13:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760015656; cv=none; b=ahuIEgbIXAEaaX9M68GaOmXNn/1J71qrtGqTFZIryuFDl0uKcswXLuI5eVOYiWyq3ki7JB5x3f9yj5bAMdH2U5/M6q3F0Pc7tiW4edeTpx3yePymON7ySxXmaDUvqj2c2ZckVYSwEoia9emsR03jC6yYGDbU36t7NjzqR0/5vL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760015656; c=relaxed/simple;
	bh=uXvSpjVF8BK7YFN0xoPwvysk7CDBGOxoFJjEr38/hn0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WvR+QlPkmeIVWCLXURzD/FlhDgOlZvY4z6oILMPlXokBXMEWZ2QBqfLRrIquiSHjLS+AaIBgj0mx4LtaIOL6XOqjMEt8/cFK1JculC1LaqVbQRrHnXF5ceKVwKTWjYyr8UtDHx+GogXv6Pcayj8Us0nD9BYWOM31qOgLzpkhUZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Fb3Ey9bA; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5996EP9P005152
	for <linux-kernel@vger.kernel.org>; Thu, 9 Oct 2025 13:14:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	lo5MRavVGxHbSwlyHOLgkDpCLDtjLUpSjKDigiF2Nwc=; b=Fb3Ey9bAch2igCHD
	rOvvjWjhsPymbUsAwVfk5vAVZZ8AbiKfkYkZPrDzYBZh5eFSmlJYYOBf12XoaUY9
	QkF65lPdzd9KBenADpNVL8vXcILzE+ttTspZkCgo26I8OxHvA5dI0GtRJuEEgnBE
	M5YEzHyO+ntM8XatSL24cMFO2jGgZRaqBpl/MS+XfRB7Bj6Ed1u7QI4KewI55frg
	lxWDu4dnBm0XPs4iGJczScylUzGR6GyfTj4nceaJiE0F0M9BYCJ/ZUDygGFxsaYe
	hiLIi5zZPmsHjNSvjLNpo7gnBqg6Yu3M2kDpxGrLJby2f4E1i2U45YJmt4UGkRev
	aNN3KA==
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com [209.85.217.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49nv4u2we9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 13:14:13 +0000 (GMT)
Received: by mail-vs1-f70.google.com with SMTP id ada2fe7eead31-588c87efb7dso2454458137.2
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 06:14:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760015653; x=1760620453;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lo5MRavVGxHbSwlyHOLgkDpCLDtjLUpSjKDigiF2Nwc=;
        b=X9v1C+cn0IRP29Jbparl18U1faTfRw+RApFtFW5k+RVqxsXiGU4owyShjDhCDvuP6h
         bifdgdRSiUEXVkP80KIXWSW+A4ZCcG44+TcB5CllHn/7Cl8jhE6Hi/MyIq9iODa6FOup
         CUAGphKJcBY1bQVutZ3IoXxezCluIXNkz22Pbqz5nsun0hq7kWv1LsCzS60FzT5Z4HJU
         zrGUuok6rxidi9V+qwQjea0p5b4AOuAyHodACH4rCibGvlJjcve8V/JA1RbQHBOTtYZw
         DN1BPxRXvqOVgwrJP9zATnoGc2c1t4S3ZvGcFQJmCoy0+pVduXZMNitZEw2ZaM9bWkuo
         O1dg==
X-Forwarded-Encrypted: i=1; AJvYcCVnz4Dy8rw28L5XXOOCjiBdsHJwAnjJxbmX7aNMAtjv5Rk69r3WHzTO4qcCj2L/L4IEG355EjHmKb/iq0w=@vger.kernel.org
X-Gm-Message-State: AOJu0YyH0q+kOJwSGEOAyIe2DAzUZiuS+CdpEErTE/ba1v2FNt0dks6v
	6751KQ7vDXQCs3crs3/QEP6jVhF6mfeILK278m5cRXxTVYStg3BXUW7i9C86o8kD/1Zb8EGYY5E
	TckE2Fb+r91MQJdJKtNt5b+XU3AxkyCjDeV+cww2WJPztYNPIPX8c78gkbcFIxtwDPLE=
X-Gm-Gg: ASbGnct34POoGoFgyHRXG88Rac/aqpw1RT1rnOkVsBhYG9d8QkuSCBEMSYAxtXnk8WZ
	IsUSeVSdmd34fKxl0Ye3/KvldgSGRQVBGppFTLAS0XeAJByT2IPp4HR+top552TyPAqHiV9eje8
	QTZrLCVauLWtdVQRkkfIiHAxI3m1sRAWQdwsDk1VUhudpNoZ6KBFnZ5P9LpZd4gJn7Z/8c6wCU5
	mg31fg+LEdMqQUzmia3VnIuTKKpmRmRJK/tVMguRbgbUAp/6ylOC8n9nZInS9HB9l5xZVKnWAsS
	3+GYftWkMm+ADYDekXV6B8o6FLjRrMYE4FeaIEW97oLfk9fBIaZxz0Z7DNBdXCqulbs1pEyWkn6
	NRTgCDdXPTzoriXtq4CUXrYs+1f/hp6W6K6/5hMw15/hvTcS2zbuzpzmtqQ==
X-Received: by 2002:a05:6102:e10:b0:5d5:f6ae:38e9 with SMTP id ada2fe7eead31-5d5f6ae3d78mr557345137.42.1760015653057;
        Thu, 09 Oct 2025 06:14:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IECks5cD3E8/Ce3Prr57QfCkGaf307hNA+1+lQir9ZyF994JSEye7UPdlYasS5n+CNSCMBGtQ==
X-Received: by 2002:a05:6102:e10:b0:5d5:f6ae:38e9 with SMTP id ada2fe7eead31-5d5f6ae3d78mr557333137.42.1760015652601;
        Thu, 09 Oct 2025 06:14:12 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59082802080sm327717e87.25.2025.10.09.06.14.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 06:14:10 -0700 (PDT)
Date: Thu, 9 Oct 2025 16:14:08 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Rob Herring <robh@kernel.org>,
        Charan Teja Kalla <charan.kalla@oss.qualcomm.com>, joro@8bytes.org,
        will@kernel.org, robin.murphy@arm.com, saravanak@google.com,
        conor+dt@kernel.org, mchehab@kernel.org, bod@kernel.org,
        krzk+dt@kernel.org, abhinav.kumar@linux.dev,
        vikash.garodia@oss.qualcomm.com, dikshita.agarwal@oss.qualcomm.com,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        iommu@lists.linux.dev
Subject: Re: [RFC PATCH 0/3] Introduce iommu-map-masked for platform devices
Message-ID: <q6ym54dfmwes3avn2mv22hukstwfrus2d233atjy7cttvgrhvl@ahcqalnz72vs>
References: <20250928171718.436440-1-charan.kalla@oss.qualcomm.com>
 <CAL_JsqK9waZK=i+ov0jV-PonWSfddwHvE94Q+pks4zAEtKc+yg@mail.gmail.com>
 <1d36569c-55b9-4390-87d1-fd0c2f837014@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1d36569c-55b9-4390-87d1-fd0c2f837014@kernel.org>
X-Authority-Analysis: v=2.4 cv=Vrcuwu2n c=1 sm=1 tr=0 ts=68e7b526 cx=c_pps
 a=N1BjEkVkxJi3uNfLdpvX3g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=x6icFKpwvdMA:10 a=EUspDBNiAAAA:8 a=nh7g1Hw0eNnsH1J9AAMA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=crWF4MFLhNY0qMRaF8an:22
X-Proofpoint-GUID: kBk7hmSBjQY94UAUvRWUntxqm-2tZG27
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA4MDEyMSBTYWx0ZWRfX0pL+86SnEmz6
 W3rZh4Iu1qhRJxSiQ6XoG1A4RUJ+W6yjiUOIN763sGrkw/Yb0YGQ2LGZV5k1HerL+Fcwh2QMx0A
 +8DOYiM1RT5MHSPy1d7TdCX3NZkdoSQVKjyatyWjRSTCxDE+VZf4leSuB1tZn4ZwfUmVOmmFZTW
 5EufrRNKRmemYSdMc+qlEU+JhUq5JDp/qaOyspP3bt9dig6iCVK/PP5Q1xprx9IYh01JyV+9sLf
 bpMSp6lJuFDgIyAS8uzciU0xr2j77DuZsfiQq1euYPMExFoZvCX0sWsNrz2ZJ0yQGATcykqeVYl
 bV1OxDw98Fl6bueXjy343HNpkjQDszppNLaa9batERjC33d2ZdvHDkY5+Seas4ExNGshSo+7aZz
 QqfQMnP4CMRIuVJdyGhEGhcGNs0QBA==
X-Proofpoint-ORIG-GUID: kBk7hmSBjQY94UAUvRWUntxqm-2tZG27
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-09_04,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 impostorscore=0 clxscore=1015 adultscore=0
 bulkscore=0 spamscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510080121

On Thu, Oct 09, 2025 at 09:26:43AM +0900, Krzysztof Kozlowski wrote:
> On 29/09/2025 05:23, Rob Herring wrote:
> > On Sun, Sep 28, 2025 at 12:17 PM Charan Teja Kalla
> > <charan.kalla@oss.qualcomm.com> wrote:
> >>
> >> This series introduces a new iommu property called iommu-map-masked(may
> >> be there is a better name), which is used to represent the IOMMU
> >> specifier pairs for each function of a __multi-functional platform
> >> device__, where each function can emit unique master id(s) that can be
> >> associated with individual translation context.
> >>
> >> Currently, the iommu configuration - at least for arm architecture-
> >> requires all the functions of a platform device will be represented
> >> under single dt node thus endup in using only a single translation
> >> context.
> >>
> >> A simple solution to associate individual translation context for each
> >> function of a device can be through creating per function child nodes in
> >> the device tree, but dt is only to just represent the soc layout to
> >> linux kernel.
> >>
> >> Supporting such cases requires a new iommu property called,
> >> iommu-map-masked(taking cue from iommu-map for pci devices) and syntax
> >> is:
> >>    iommu-map-masked = <FUNCTION_ID1 &iommu ID1 MASK1>,
> >>                       <FUNCTION_ID2 &iommu ID2 MASK2>;
> >> NOTE: As an RFC, it is considered that this property always expects 4
> >> cells.
> >>
> >> During the probe phase of the driver for a multi-functional device
> >> behind an IOMMU, a child device is instantiated for each FUNCTION_ID.
> >> The call to of_dma_configure_id() on each child sets up the IOMMU
> >> configuration, ensuring that each function of the device is associated
> >> with a distinct translation context.
> >>
> >> This property can also be used in association with 'iommus=' when dt
> >> bindings requires the presence of 'iommus=', example[2]. For these
> >> cases, representation will be(on arm64):
> >>    iommus = <&iommu sid mask>; //for default function.
> >>    iommu-map-masked = <FUNCTION_ID &iommu sid mask>;//additional
> >> function.
> > 
> > Where does the FUNCTION_ID value come from?
> > 
> > Why can't you just have multiple "iommus" entries where the index
> > defines the default and any FUNCTION_ID entries? What's in each index
> > is specific to the device.
> 
> 
> We discussed the problem earlier and that is what I asked them to do.
> Apparently I was just ignored so now two maintainers say the same. We
> can get ignored still and the third maintainer will have to tell this.

The main problem (which comes from IOMMU definition) is that currently
the iommus property is not defined nor used as an ordered list or
anything like that. Other devices depend on it being a set with no
additional structure. We can change that, but it might potentially
affect others.

The iommu-maps is e.g. used by Tegra display device to map multiple
contexts separately, but it doesn't fit all the needs because it doesn't
allow us to specify the mask.

Also, the video-codec is not unique, we have other similar usecases, the
display, camera and GPU, which also need to map some of the contexts
manually.

Last, but not least, there are e.g. fastrpc devices which have
subdevices just to declare the IOMMU entry for the context stream. I
would very much prefer to be able to drop the subnodes in a longer term.

Speaking from the drivers point of view, we also don't have any control
on how the IOMMUs are attached, while we need to control it for these
kind of contexts.

-- 
With best wishes
Dmitry

