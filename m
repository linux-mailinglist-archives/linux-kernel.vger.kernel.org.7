Return-Path: <linux-kernel+bounces-874428-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 31B3EC164C9
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 18:50:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D04131A20986
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 17:50:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61D1F34DCE3;
	Tue, 28 Oct 2025 17:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Ezj4BxaT";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="WzEbofNJ"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B90F34DB41
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 17:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761673811; cv=none; b=h2y/VGQf3zYp1YF2aAyojEnRDuJwSFuyLl7Lsg8gWSSWSqcLUqzBPxpal8+8xDxF7vKGLAZ+1um0eRGKyv5Hz8JQB3ClG/KytaUOkdC+++DhM9D8ZZQW3BQy6tEHLVBDCJXtHjNcaN7RiyDJwS8zvehs9FRmKbE60FxzT79i6kA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761673811; c=relaxed/simple;
	bh=RQuXrerRH0GC1Ou/VhVeBwaDYub4MWKrX7UL4Px9W0Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pS+/pcQsbswK9CDuF/j62YN4mIT/mhH+0CJmxXK9a7eHJvqrScM7+KPoURwSQNmt5a1ef/rTh/mAip21FEd7DbD30xPdMyU/2yhTgur1HJnA19PBIKIHMtRwx5mT2+HCw+ZjhVNalp2KvSAfOI/K9u4moO/caswcKIK0QRjsqE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Ezj4BxaT; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=WzEbofNJ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59SEnhua1965827
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 17:50:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=p2sRd95FEGpGXnW+m3gEn4ld
	EEcfyS3da4aKxTK71sg=; b=Ezj4BxaT1tB4/XY2DvgOikYAdKHq2cIw6U7Yt4oh
	rLiK//QABBxlSATl8iOvcxXNkBLx/9189obJNhLii95R6fKv5pzALOUBM7F6YaTZ
	brp8py3bxVmTLPqMYIZBaDQc5TFb9wruhKKSIIqB7NSXfPx/4lNl1CEZNPJDZJcq
	Fib2rroHKlSLJ7t8x24lU65wGt3C3iJ1WZ9lZxOVyDtEruh14aH1PtW794YOV5EI
	J6vxAI6736yZOkutf1RgzpMlBE9e6zuWTYInR8QFUzLXPYfb870zSN8ewMvge2l0
	0SZjFg6iPx0O/XabDIFmJrNjBGEHstRPwsAXsp2awWqe1g==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a2w51s574-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 17:50:08 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-340299fd99dso1267576a91.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 10:50:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1761673808; x=1762278608; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=p2sRd95FEGpGXnW+m3gEn4ldEEcfyS3da4aKxTK71sg=;
        b=WzEbofNJcdDb926Fp49AeUPqwCmoLJso+wIetzKi3G9n/hPuf8Rmg6rB5jUaGT0goI
         lgE+1rD69ojq2g3sFjxJ/QVbpirfwafFBWCgcxoUDy+yFIxkSHXawN83XBaQyzGvH+2o
         YeVB8Z9FxWxWkUl72Y+I21eE3oZzQl6jPlHfPFr6vQMRWk9s2Fg86WYD1Yd/u3p2y0cf
         pYbJcoBfrwNIq5d+E34kVsCEfBxEaIeyk+wXp2bsy8Wv8qzqHF7JagszmI3kP8sjZlsD
         qtSsVvdeMp7TtKnCOr1Y/f01cGiA2apWkCtXlQSns08Z/JqUS9U2N9Tf64boZdowdAx5
         89rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761673808; x=1762278608;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p2sRd95FEGpGXnW+m3gEn4ldEEcfyS3da4aKxTK71sg=;
        b=FrRr3hhwCXXxp2DTVDkqn7a+SCmi4cvFBL+y5HAB80LtWE9Ec0jlENa4NDdeDXtCqT
         pjs2FCOkide89+Va1GGUgjynEu7ttzrMl0vt0Rfxcthxal9bvlAklCU5qKX9/SSJoE5J
         AM5bFiiWqu5TiHYGK2yA9sliyZpzZvsG7cd8Hd0TwQkbA8712hqbEPbj4k+sNb4Kbl/R
         DCsQuEiSzUnjCvRsorhLItiMs2njjZmIWf2uSEx0Y9Pvz7FKQl3mRFZXYY2sg1ed8e5H
         CHp68qQ4YY16D6lK9rFyGms+3l9/sc6c35+kgJIbjHQ2xzhwhnWduj/6zGjkvoazwN9E
         fb7g==
X-Forwarded-Encrypted: i=1; AJvYcCW4kMYzTj9uONJ8YvDB+zx5DZ6x/vjR6+/zWreHep6pJTlBY4hETc8fiXcb6MNmSb3RYPiEZKrRpGp7nxo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJSVMjVsfKoYajzR2OI5y0+IlFUpUZnVbFAhEqXv7rXyseznk4
	ZmgDuIYGRzn2NYZMsvoyogHlw1j8dWlgqUrCfN8IFmVRO8mqyVYMz0rnvAAZfyPSGmNbOFK6qpT
	UdDSncAY3rsO/XqytcmWMqTow/vDuYdbSHQS7gEomDFAY/am9vsB2oKM4nz7z4NcoVwA=
X-Gm-Gg: ASbGncujyVdwE4GoUlprdMR9AMhqyr82qZbGpWt9W7/amoERCMmWFiiqL0OCZyX8q8Y
	2Exgnr9NBFzPq2RdwTvVqX9uNnbmPL7Js1cErf2wDBVzFewTvyGIAYLdm4wJpeYurusajUsip0x
	hwJkJUcKfCCt3P3mOdnfO7hUf52yppCB+GxJQyEhNBJ5NWpLmr8MJX+KrOCpNEz+MNnvHmn+OJ4
	WQtJj56ntUWQyb7kAJOysaCSlC1PB3YG/PHNpeOOjy7Dpv5U1pIrbnfcKOzW+J1D1zUbbqqtMT8
	3SViNZaV5jmx2sZVN4GYdFOpmYz7Q/xcOYP+zz1S6lniw1oexKpE51Vnr8ZuN88q2sg0x7EklFP
	kSB1XK47PtcH9SWjDUTicsNoiLdSDVrLT
X-Received: by 2002:a17:90b:4d0c:b0:335:2823:3683 with SMTP id 98e67ed59e1d1-34027a105d4mr4955066a91.9.1761673807591;
        Tue, 28 Oct 2025 10:50:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFmFHckhsPGpEbVPLXbcPP671qlbe6u0dg82t5Y8NkQanWb4AgPNJ5BkpS154qJVc8fgzThsA==
X-Received: by 2002:a17:90b:4d0c:b0:335:2823:3683 with SMTP id 98e67ed59e1d1-34027a105d4mr4955024a91.9.1761673806974;
        Tue, 28 Oct 2025 10:50:06 -0700 (PDT)
Received: from hu-pkondeti-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34028fe80c5sm1569088a91.0.2025.10.28.10.50.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Oct 2025 10:50:05 -0700 (PDT)
Date: Tue, 28 Oct 2025 23:19:59 +0530
From: Pavan Kondeti <pavan.kondeti@oss.qualcomm.com>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Pavan Kondeti <pavan.kondeti@oss.qualcomm.com>,
        hrishabh.rajput@oss.qualcomm.com,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v3] watchdog: Add driver for Gunyah Watchdog
Message-ID: <cf5c0f82-56ce-4ced-986f-aae8a23e7166@quicinc.com>
References: <20251028-gunyah_watchdog-v3-1-e6d1ea438b1d@oss.qualcomm.com>
 <4659e69b-907a-49ba-8eb6-ac17232a5219@roeck-us.net>
 <3e4fd54c-90fb-4b15-a9cd-a2d11b0aa952@quicinc.com>
 <6ceb8331-cc4a-4754-8b9e-dea887665efc@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6ceb8331-cc4a-4754-8b9e-dea887665efc@roeck-us.net>
X-Proofpoint-GUID: qk9T1gJNcXWG38rBFgU_udvNHMcTpk8Y
X-Authority-Analysis: v=2.4 cv=YMiSCBGx c=1 sm=1 tr=0 ts=69010250 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=kj9zAlcOel0A:10 a=x6icFKpwvdMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=RMpeMXYOqeSlBc37jRsA:9
 a=CjuIK1q_8ugA:10 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-ORIG-GUID: qk9T1gJNcXWG38rBFgU_udvNHMcTpk8Y
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI4MDE1MCBTYWx0ZWRfXxBxncTdiMDDk
 hLE/6u9K45MJ4YAvtWRLPxI+faz6DNkslT7m/nM0KKaXSyFZlwpVWC93qcmjXWBXI0jaC4J769V
 6E7+Jc5j8flCN3kFIkzXsQ4p45S/94t6qGzCIOq0wnwQUEOrX2UiGl7ph95pj0zh9pxtrsxb/5q
 7Qxw/T+SuepO9HmjJC/+ln4u5sUwIhgQF32Bb9PWY5Mtd6jp7NouHuTRt3uEpYgcmmUVw/hFFvy
 ikoeZOE8Q4kpqd6/2koxhH25zrrN0oFj6oLU1WvSEYe1n/FI7CNEOSJlivVn+N4Bu7N1s0Rf1gH
 9I1dbbp3SM1NpaMgOioK/jhEhq8FViDjjmXOihDAGvEo2uQ2jmCIrr/7mgvBzwiLKuntwFIm0vu
 3GyAkfjAdsl7tROaj6RHyIjuSuqXGA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-28_06,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 adultscore=0 clxscore=1015 priorityscore=1501
 lowpriorityscore=0 impostorscore=0 spamscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510020000 definitions=main-2510280150

On Tue, Oct 28, 2025 at 10:29:32AM -0700, Guenter Roeck wrote:
> On 10/28/25 09:40, Pavan Kondeti wrote:
> > On Tue, Oct 28, 2025 at 09:06:12AM -0700, Guenter Roeck wrote:
> > > On 10/28/25 02:35, Hrishabh Rajput via B4 Relay wrote:
> > > > From: Hrishabh Rajput <hrishabh.rajput@oss.qualcomm.com>
> > > > 
> > > > On Qualcomm SoCs running under the Gunyah hypervisor, access to watchdog
> > > > through MMIO is not available on all platforms. Depending on the
> > > > hypervisor configuration, the watchdog is either fully emulated or
> > > > exposed via ARM's SMC Calling Conventions (SMCCC) through the Vendor
> > > > Specific Hypervisor Service Calls space.
> > > > 
> > > > When Gunyah is not present or Gunyah emulates MMIO-based watchdog, we
> > > > expect Qualcomm watchdog or ARM SBSA watchdog device to be present in
> > > > the devicetree. If we detect either of the device nodes, we don't
> > > > proceed ahead. Otherwise, we go ahead and invoke GUNYAH_WDT_STATUS SMC
> > > > to initiate the discovery of the SMC-based watchdog.
> > > > 
> > > > Add driver to support the SMC-based watchdog provided by the Gunyah
> > > > Hypervisor. module_exit() is intentionally not implemented as this
> > > > driver is intended to be a persistent module.
> > > > 
> > > > Signed-off-by: Hrishabh Rajput <hrishabh.rajput@oss.qualcomm.com>
> > > > ---
> 
> ...
> > > > +	gunyah_wdt_dev = platform_device_register_simple(GUNYAH_WDT_DRV_NAME,
> > > > +							 -1, NULL, 0);
> > > 
> > > I did not follow the discussion around this, so I may be missing something.
> > > If so, apologies.
> > > 
> > > This is a highly unusual approach. What is the point of not instantiating
> > > the watchdog device through devicetree and doing it in the init function
> > > instead ? There should be a devicetree node which instantiates the device;
> > > it should never be instantiated from the init function unless there _is_
> > > no devicetree, which is obviously not the case here.
> > > 
> > > Every other driver which supports devicetree has an .of_match_table
> > > which triggers device instantiation. If the Gunyah watchdog can for
> > > some reason not use that approach, its devicetree description should
> > > be fixed. Instantiating the device from its init function because its
> > > devicetree description is bad or missing is just wrong. It is even more
> > > wrong to try to contact the hardware or embedded controller to figure out
> > > if the device is there. This can have all kinds of negative impact on other
> > > hardware.
> > > 
> > The Gunyah WDT node gets overlayed by bootloader. We see that this
> > overlay is failing w/ upstream device tree since the overlay has
> > references to downstream code. Please see [1]. Hence we are trying to
> > register the platform device dynamically.
> > 
> 
> This is just wrong. Whatever happens downstream is not an upstream concern.
> If an overlay is broken, fix it.

The problem (watchdog availability to Linux) has been fixed on latest QC
devices where Gunyah (Hypervisor) emulate the MMIO. The watchdog device
has been added to device tree and it works with
drivers/watchdog/qcom-wdt.c drivers. 

However, we have older QC platforms like SM8550, SM8650, SM8750 etc
where watchdog is supported only through Gunyah SMC interface. we are
told it is better to expose this as a hypervisor interface, so we are
adding platfrom device in the code. 

Our goal is to enable the watchdog functionality on older Qualcomm
devices that are already supported in upstream. One of the main use cases
is to enable RAM dump collection upon kernel panic. With the
watchdog enabled, Linux fails to "pet" the watchdog during a panic and
device enter RAM dump collection mode.

> 
> NACK to the current approach.
> 

In hindsight, it would have been a lot better to add the watchdog device
directly from the qcom specific code and add the watchdog driver as a 
standard platform driver that probes the device using the
SMC interface. We plan to try this approach in v4 and will wait for
further feedback.

Thanks,
Pavan

