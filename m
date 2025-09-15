Return-Path: <linux-kernel+bounces-816739-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3391EB577CA
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 13:15:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9AFE3B038B
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 11:15:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40A632FDC36;
	Mon, 15 Sep 2025 11:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dJx7+62O"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5B1D2FE07E
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 11:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757934884; cv=none; b=nl1XGiAFs6BlT1kIYbTRX5CmpPEUFZrascKYXlJWHBIHN7GT2IajSQAzNg7FZ4n8Fer7rJGE9vcK1TJMDacuH2J06Gg/xSGjGsuhJX/3Zz8rFG/NUjbvwIfEtZXAFmf22KOqVrehvP7TafWj1CtiDQwJBLp13cz+a9PsYaMT16g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757934884; c=relaxed/simple;
	bh=NmQTuE6oktbowc1fE4SzF/Rv2PfEBusgZuNoSX/J7vY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lJSR7/8bxSf/nWtbsiyzJFfhORIcn8TWBhM4xksUUcdTZXyMtgqwa5xk0RuYo4wuhL+HckSy96wrczdYPbp7nqDw7i8Y0u79AhxatFji/fbuVTZjbxCchiACFCp0RDoHWE6+kN8RW5byzNaxLWy//T1VWnDyU5zH0yZdlkpJETQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dJx7+62O; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58F8FfOJ014029
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 11:14:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=UE7EY6vJQIQpbunoS5He5lME
	uax+fe4RHGemt1V3aWo=; b=dJx7+62OlQPI1RNydmN/4kCNITuoVFKlgH7f93wT
	sJwd92efp6QuuQxKXaaB1K+mhBdXjcPlRHrDKMJz0tD44FLfV8KlHRsP1xMLzYeq
	5K9B/+yIQG40ahukawsfKCwoJzUxunn4dj8EfXt4FR6KvZXcPDanmWgXF5RMstA8
	8+RMKM/d3kyVx0zke/R6KHGclBd8Ch7rULj9Mpz+6vNh/0geV69a08IapsWXyIpu
	1WlczUxwiQzYlxneXhStTydUrNTCT28nWvr46P/L7EYJh21lOwtZkgT3TkslfnDH
	vRV2Fd5i85TWMZtNpZAk0/HtjLenS6kxetFOlEHlIeVeJw==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 494wyr4whj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 11:14:41 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4b302991816so86622911cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 04:14:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757934881; x=1758539681;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UE7EY6vJQIQpbunoS5He5lMEuax+fe4RHGemt1V3aWo=;
        b=AdUuSuHa/Ik5LXJmS2w48PrW0OSYujCl/Ba4LjgfEZzM8Ov48YYl+n+Od2teIlk1dO
         W0TB/LEgssNZ4iXFu/hCj9+2LUdcAbuO6OR1TUau6erZzsWxbRCaDLo1HQ0ARoOn931H
         5GJVCAV1WiqFXw5aEOGBrGCAIHyqf5Z2SXNbCfNcjcEOHetcYPaYTrssnRuN5wB9Catc
         2lx+QrG7AQOhOkRgXcd1N1iKxwDemttMPrXhI5yHcSlYBr//xC/jErHxRKDSqwkmf+wa
         AtDitIYDaIZRg8BpFRZgT9GaNe4FJbeOZSRZZJE8q86QtFSczOHJXryokPm0qj75zwSK
         LJ1A==
X-Forwarded-Encrypted: i=1; AJvYcCWmmCl47BMKr73PqB7sz4UCOcpb0wJsckybMHhOI+9mUNVJSj01Uhn+cH0+CY7oBOpXOzpD7b18O299HXc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxN3AKNnv4vam6VQS3tgok67W5qhnKuWD9a+nQEnFQGryz+2zPX
	vQUvTqIOwe38ORf9YF2zNsgeiQaznFMpm4M2MF+Vw2IOfq1zaUv6o/RSLuPAZdyQDYjNkkhFDl3
	po0A+b6AtC0VsR4S8wxseJ2Fm5ZK54m9/Ttxai410fLnnLhdXTXA/H1Bwy/jdjVSa1u0=
X-Gm-Gg: ASbGnctTQ3OjgRDEVSXfCMHtXL5pwjl9sO9t4nl2AKGd7p+wFvEuYh0lZjy1OjKasDS
	Yqub2knalb707FdHC4eyOUdg+KP3qguw2eXXAMiAXGTuHe/zCztmhz2b8iVg6urLb/pw0Icmmkv
	rm3LHuaZwfXWwa3kF/i5/3U6M1triUjUcaw7U1rqcRUo9ivWvJxJNQBaLQf2tcvavS8qRbeqQQI
	9ZRNxNZDfR4UUZLZoF1RvfRQfmrsQ/JCw70n5u84A0EhHc8wHnePzYXYi+vLlUmXVKycKZwugY9
	1bgEZn3oLrHHWKh8b90A3adGHsMQq8GFuVBvlN6CIULnxbb9738D7GECjQ6cCI93ZfLJA6DHymA
	rC/sdzzH7Yjd8IoLwxwpQfMFxiuc38vuaH2L9Q9vOl7Ng2HbP4jCp
X-Received: by 2002:a05:622a:1a29:b0:4b4:9773:5863 with SMTP id d75a77b69052e-4b77d0446cemr132550691cf.48.1757934880814;
        Mon, 15 Sep 2025 04:14:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHqyK3/SBERxfJelmharBzCPiOcF1a5b27+7+3enxQOwgbeFlfGbnEd2RvdA2OiZrdidoXpCw==
X-Received: by 2002:a05:622a:1a29:b0:4b4:9773:5863 with SMTP id d75a77b69052e-4b77d0446cemr132550211cf.48.1757934880246;
        Mon, 15 Sep 2025 04:14:40 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-57178b7e5fbsm2655981e87.22.2025.09.15.04.14.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 04:14:39 -0700 (PDT)
Date: Mon, 15 Sep 2025 14:14:37 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Xilin Wu <sophon@radxa.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] arm64: dts: qcom: qcs6490: Introduce Radxa Dragon
 Q6A
Message-ID: <2vpckcbl7biqaqtb2e22mhnorbiq3xqlsa4ys7x2grzrs67u6f@iixiq3xhfwzl>
References: <20250915-radxa-dragon-q6a-v3-0-a6c32d988ed7@radxa.com>
 <20250915-radxa-dragon-q6a-v3-2-a6c32d988ed7@radxa.com>
 <33vm6uzxqbs5bukswpzdkrn3ronl7mp2q5d3j772t7lqcnvqvg@5or7jxglcynf>
 <B3EFC6A5E09F74FB+a67c9b82-a7c5-4dbb-9486-90a6df55ed13@radxa.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <B3EFC6A5E09F74FB+a67c9b82-a7c5-4dbb-9486-90a6df55ed13@radxa.com>
X-Proofpoint-ORIG-GUID: -E5qixK0UUGvjxqlxp9wZulVfVKwNxo4
X-Authority-Analysis: v=2.4 cv=SouQ6OO0 c=1 sm=1 tr=0 ts=68c7f521 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=NEAV23lmAAAA:8 a=ksxQWNrZAAAA:8 a=foqy6ynOqZJRs6KxsBoA:9
 a=CjuIK1q_8ugA:10 a=kacYvNCVWA4VmyqE58fU:22 a=l7WU34MJF0Z5EO9KEJC3:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTEzMDAwMCBTYWx0ZWRfX6QEKxZyI/xzN
 YMvZ5mdo/Cxcbls8iXvYorPyH+D7zF/aObCfvdTJyWL8kcIegLq3oY9QjoXBtzPVvmvJBd+Amj6
 ykOujHeFE9Za2f4KUotgqDozr//xVK4kozEnvzDvahCADjrsojYoScz3MOO+l/1pl/e/qkTD0xJ
 NYig+oi+2jbszEgDMqvdIwjCI6CTyY/fKphWNsOZ7E4kfwcMR5nM9LZbUYr3nOKlh97PFxp0ZQ1
 2L8S+HrYeL6hxlst6ZICmsxDaXdeYLXCmTVLwDhDJenXAdQ0/wn3Eezeg/lLzG2pncX30oZO9Go
 2GexxywVHru/5EoOLcne8uEHWo54MHxXshgsZ0iTDJELqYiHtR3iANy5P+FEv+7gCPpvcvSSIQD
 oWT3g/P8
X-Proofpoint-GUID: -E5qixK0UUGvjxqlxp9wZulVfVKwNxo4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-15_04,2025-09-12_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 phishscore=0 adultscore=0 suspectscore=0
 priorityscore=1501 malwarescore=0 bulkscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509130000

On Mon, Sep 15, 2025 at 06:43:50PM +0800, Xilin Wu wrote:
> On 9/15/2025 6:10 PM, Dmitry Baryshkov wrote:
> > On Mon, Sep 15, 2025 at 09:31:44AM +0800, Xilin Wu wrote:
> > > Radxa Dragon Q6A is a single board computer, based on the Qualcomm
> > > QCS6490 platform.
> > > 
> > > Features enabled and working:
> > > 
> > > - Three USB-A 2.0 ports
> > > - RTL8111K Ethernet connected to PCIe0
> > > - eMMC module
> > > - SD card
> > > - M.2 M-Key 2230 PCIe 3.0 x2
> > > - Headphone jack
> > > - Onboard thermal sensors
> > > - QSPI controller for updating boot firmware
> > > - ADSP remoteproc (Type-C and charging features disabled in firmware)
> > > - CDSP remoteproc (for AI applications using QNN)
> > > - Venus video encode and decode accelerator
> > > 
> > > Signed-off-by: Xilin Wu <sophon@radxa.com>
> > > ---
> > >   arch/arm64/boot/dts/qcom/Makefile                  |   1 +
> > >   .../boot/dts/qcom/qcs6490-radxa-dragon-q6a.dts     | 961 +++++++++++++++++++++
> > >   2 files changed, 962 insertions(+)
> > > 
> > 
> > > +
> > > +&gpu_zap_shader {
> > > +	firmware-name = "qcom/qcs6490/a660_zap.mbn";
> > 
> > Is the device fused to reject standard qcs6490 firmware? If not, can we
> > point it to the existing files (maybe except the ADSP)? Anyway, could
> > you please submit the required set of files to the linux-firmware repo?
> 
> No, the device is not fused. So it can use firmware from linux-firmware
> repo, except ADSP and Audioreach topology.
> 
> Sure, I can submit the ADSP firmware and Audioreach topology file to
> linux-firmware.> >> +

Yes, please. Also please consider adding ADSP fastrpc shell and modules
to https://github.com/linux-msm/hexagon-dsp-binaries/

> > > +&usb_2 {
> > > +	dr_mode = "host";
> > 
> > As Konrad has asked, please describe the onboard hub and the USB ports.
> > This will ensure that corresponding ports are correctly marked as
> > hotplug in sysfs.
> > 
> 
> Sure, will describe them in v4.
> 
> > > +
> > > +	status = "okay";
> > > +};
> > > +
> > > +&usb_2_hsphy {
> > > +	status = "okay";
> > > +
> > > +	vdda-pll-supply = <&vreg_l10c_0p88>;
> > > +	vdda33-supply = <&vreg_l2b_3p072>;
> > > +	vdda18-supply = <&vreg_l1c_1p8>;
> > > +};
> > > +
> > > +&venus {
> > > +	status = "okay";
> > 
> > No separate firmware?
> > 
> 
> The one from linux-firmware works.>

Great!

> 
> 
> -- 
> Best regards,
> Xilin Wu <sophon@radxa.com>
> 

-- 
With best wishes
Dmitry

