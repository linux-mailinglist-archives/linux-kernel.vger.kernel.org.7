Return-Path: <linux-kernel+bounces-850246-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 264B1BD2579
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 11:42:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5CF531892BFC
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 09:43:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7808A2FDC5C;
	Mon, 13 Oct 2025 09:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ckwE5F9H"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24A2C2FE045
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 09:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760348554; cv=none; b=loGGlllxdnmfwc1ZgCdEIpvD3FKLmw04VU67BoXkWgMoVYpBQ91ugjZMnJgNJgwZu/23IT9ccLoEXdBM+R4W6+BjTSCA+eJOnxX2Ls5yKNv1BvFqOiOUo/4JEgK1F6dLcRTHMg+W+b+dg7VNv+nPuf35yUVf68beokKlTkXMEu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760348554; c=relaxed/simple;
	bh=I+VcpLD2Vwq3nTThX8kfrnW8b2lxLrLieNtKngEorpU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nYMPVrUKcLFEw+OwQdraNJDCCyvTqA4LXQz9Ks/ZlqTdj4olxZRPqhepkP+Ek47i+74+SSgfK4n96rKK7zpK5dApIKwpJ3RxFa3vLoZVKr4Ez1yvVKxcR6ZpmrW6azCSbWh6kQVXYZyEoxeUmh+2YqDso5AaX9Gh92UJhmroWTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ckwE5F9H; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59D2nLbm000642
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 09:42:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	HEW469dJbFSwk5XAW8ElPGM+xdFOARugfDp8dZgFiTE=; b=ckwE5F9HjBTHQwt/
	c4Sgeg+pxNjuR+rUaRI+wmd83PQNr0eMuGO665+GUi4gQBlSeYjSBJ4nG5j/E6IP
	RkEHTbS/FTa9ihKLIsSDCecVRM2K50hjsB2LDTOVmiNra2Kx7V029yUV0xHCEXu/
	uehCiAZcgd1J+1nPcW4NIAGT//cRk35hMolbDaZ9xV9VbisTPXLKIE2GuvXuxk10
	G+qBoe3HNnN1uWymnkEAH60nTufrOIUMxi6IOa14mU4LJ5NCs5J5XXhbPAO/SX5t
	hSVTgsHIAIYN7fjTv8clFftLuxe5IRUy5aX+n2pz0E1dhsk1Bn5d+TQ7OxHpjNGU
	vJm5SQ==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49qferv411-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 09:42:31 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-872d2ad9572so2305981485a.3
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 02:42:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760348551; x=1760953351;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HEW469dJbFSwk5XAW8ElPGM+xdFOARugfDp8dZgFiTE=;
        b=Ph5u3+MHb8z9ArcYd5lHJdTF1X3cgtgnHgxSElmjKKtdwfLsDGHFN7TKvDUgal4u/N
         a/kDEw5BipFuumCBwrvhYl6eq2G6Xl8tpOExXffoEMeKQafecHlVZcDqfySUpJ/4j2i/
         ISSyzIPUCahxtBfwdhg6EzjTHRuT+sVS6bwdqNhZoxq4E+Z6ozG7ECC8Hc4MWjr8ng0n
         FD+UKr2vFpkmPQopJsAOVu18YbDOZbskqhKXQAmgvwl0/RP19siJ+zwzQ+s6Du8anE3o
         j/gkJeyA1FZSxJKG+4gVtPUf99j8vUyTvjGSE8JM6XXxmu6eiliKbKG38Egq4SSnFvxu
         9iNw==
X-Forwarded-Encrypted: i=1; AJvYcCWeBvIUMN94dgMa2qT3Wx87SXT7zBu9JpipSewUu5tlxTGDqWUBZym3NGHBvz227ydHYZWwBOzzUwT3Hw8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0A/XKXF7RcLxU9AJDyxnnnMjAOTLB4Hj3sH9KA2ABwv8TyB0q
	yHWa1LU4OracLEjHegwAirX1EJ+2YPH2iVtBNhWw8Qn0eV/wyP6Ok8mcHCLGY6YPaIk+hbAu7B8
	ySXYiRP8Ar5o1EbpU1jnUeyoZuEV9+wgIKz88AVE2jQoJ+EVHXE1n6R6XKJcl2Re0l90=
X-Gm-Gg: ASbGncv2E4PGAC+tOAL8qOg3u4atQxd+j3fHM5Lrr7SR9ZjW+ydZmxLjsxzuD+uL113
	qM70LE6wn0+sgS9HA5uJJVkaqhq/gB0wK0ZnjAWMVMxAoc2sTHo+LSS5PsVQEo4rWNapNDuFOMk
	o5ExiU3uzl2EhsA5J+6HCtIr060yJ2GhVoA6FZuXqzdqhgbtt4vKOOksmcJEs/u2dSslv/BYmj1
	vBFYdTlFr4Y7IB4WLEWl1q2p9hz47qPjWmNWIjDGgpqQRVoJmZX8F+ijC8Ap36z5x9ZJDbwglPe
	ckbFXkDCmmy8M7TszJ8QjnCVuR76il5PvOgvyORsdZ/K8Gc4H3p5fhr+MvZ8SM1UinF84mfh1+2
	aCD7EwnwjTO3Q4AJt9nUptWal/zrmgL1yklMy79ViBWLQvvaeNo45
X-Received: by 2002:a05:620a:aa0c:b0:887:1728:c4f4 with SMTP id af79cd13be357-8871728c59amr894422485a.83.1760348551005;
        Mon, 13 Oct 2025 02:42:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG5rMB9HvB5AXbxg2RKZKWc68eyxTWU6vytaj2N3831Ox5tj0I0+5UFZ/Bm24Ksc00cJzA/Sw==
X-Received: by 2002:a05:620a:aa0c:b0:887:1728:c4f4 with SMTP id af79cd13be357-8871728c59amr894420685a.83.1760348550522;
        Mon, 13 Oct 2025 02:42:30 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-590881e4e58sm3942630e87.25.2025.10.13.02.42.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Oct 2025 02:42:29 -0700 (PDT)
Date: Mon, 13 Oct 2025 12:42:28 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Tessolve Upstream <tessolveupstream@gmail.com>
Cc: andersson@kernel.org, konradybcio@kernel.org, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] arm64: dts: qcom: Add support for QCS615 talos
 evk board
Message-ID: <7izkmevb43hgqxosvf5aox7lasnby67kbmyqxjh6hypqvonh7p@x5rm3ehnsoye>
References: <qq4aak33bn3mqxd2edu6zgkkshby63mmitg7zqkly2rj4c2lh7@4s7sndb7e2jr>
 <20251010114745.1897293-1-tessolveupstream@gmail.com>
 <20251010114745.1897293-2-tessolveupstream@gmail.com>
 <q32oj6ry7ixulfaxzkm63nidg7ddmdl2moaakmx6rlv77p3wzl@wd2ekastvyms>
 <2d5a3fa5-3882-4859-96fd-3ff2174e655d@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2d5a3fa5-3882-4859-96fd-3ff2174e655d@gmail.com>
X-Authority-Analysis: v=2.4 cv=R64O2NRX c=1 sm=1 tr=0 ts=68ecc987 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=x6icFKpwvdMA:10 a=pGLkceISAAAA:8 a=3Jcqw9wqeHKyueRvwKwA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-GUID: gK2QG68ywlsEY7LVEKoBqU2dZ_wL5CDK
X-Proofpoint-ORIG-GUID: gK2QG68ywlsEY7LVEKoBqU2dZ_wL5CDK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAxOCBTYWx0ZWRfX1drp7E/HY1oi
 2gqfTc0v7gxqtQeXKortvJ5h9BcZrXpBO5RMRqy12QldLpP027SGrZobSRXFHRolJJ3Vrx4S3vb
 wDSCEldtZbnqmOh/RyLpp8hXtZvga8nxVY/L3Um+se22hWEfAC6aX64giOCyGsmgMWGVVv+giot
 DZfqVetsn/qzKGA/iC4x0jl/hnGcbjU1VSZA/4jnBHFbD3CNjn27quAvAb4jx7N3/k2NgIRV5nK
 kqkmSRtuiXQLcNdINEgYP0bsOFDbt/PRqYEgST+Ufp5IYP+JDLgqBOmJrNOCSUdTWgn6mom7SQq
 caPPznO0aHpqY3NfKJt2/AB7k14cvXZBZ6NWm1H7l0or2pHpaogqJEaBUdwKHkVmO981koEsWiH
 scF/8nnvunsI1n8c2mkyNl9fyBM4Fg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-13_03,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 lowpriorityscore=0
 priorityscore=1501 malwarescore=0 adultscore=0 impostorscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510110018

On Mon, Oct 13, 2025 at 02:34:10PM +0530, Tessolve Upstream wrote:
> 
> 
> On 10/10/25 17:49, Dmitry Baryshkov wrote:
> > On Fri, Oct 10, 2025 at 05:17:45PM +0530, Sudarshan Shetty wrote:
> >> Introduce the device tree support for the QCS615-based talos-evk
> >> platform, which follows the SMARC (Smart Mobility ARChitecture)
> >> standard. The platform is composed of two main hardware
> >> components: the talos-evk-som and the talos-evk carrier board.
> >>
> >> The talos-evk-som is a compact System on Module that integrates the
> >> QCS615 SoC, PMIC, and essential GPIO connectivity. It follows the
> >> SMARC standard, which defines a modular form factor allowing the SoM
> >> to be paired with different carrier boards for varied applications.
> >>
> >> The talos-evk is one such carrier board, designed for evaluation
> >> and development purposes. It provides additional peripherals
> >> such as UART, USB, and other interfaces to enable rapid
> >> prototyping and hardware bring-up.
> >>
> >> This initial device tree provides the basic configuration needed
> >> to boot the platform to a UART shell. Further patches will extend
> >> support for additional peripherals and subsystems.
> >>
> >> The initial device tree includes basic support for:
> >>
> >> - CPU and memory
> >>
> >> - UART
> >>
> >> - GPIOs
> >>
> >> - Regulators
> >>
> >> - PMIC
> >>
> >> - Early console
> >>
> >> - AT24MAC602 EEPROM
> >>
> >> - MCP2515 SPI to CAN
> >>
> >> QCS615 talos-evk uses a Quectel AF68E WiFi/BT module (PCIe for
> >> WiFi and UART for Bluetooth), which is different from the RIDE
> >> platform. Plan to enable these in a follow-up patch series.
> >>
> >> Signed-off-by: Sudarshan Shetty <tessolveupstream@gmail.com>
> >> ---
> >> Changes in v2:
> >>  - Rename compatible to "qcom,talos-evk" (suggested by Dmitry/Bjorn)
> >>  - Merge enum entry with existing qcs615-ride block (suggested by Krzysztof)
> >>  - Fix subject and commit message to use imperative mood
> >>
> > 
> >> +
> >> +&usb_1 {
> >> +	status = "okay";
> >> +};
> >> +
> >> +&usb_1_dwc3 {
> >> +	dr_mode = "host";
> > 
> > Is it really host-only?
> 
> The USB1 port supports both device and host modes, and the ID pin
> is available on the hardware. By default, it operates in device mode,
> and switching to host mode requires a hardware switch on the SoM.
> In the current patch, I’ve set dr_mode = "host" for host operation.

Please provide this info as a comment (e.g. switch xyz should be
switched to 'ON' for this to work).

> I plan to add proper role-switch logic (using the ID pin) in the
> next patch version, so the controller can dynamically switch between
> device and host modes.

Yes, please. There are a lot of users who depend on USB device mode to
work (e.g. to connect to the board via ADB).


-- 
With best wishes
Dmitry

