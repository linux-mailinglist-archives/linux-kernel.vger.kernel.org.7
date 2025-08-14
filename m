Return-Path: <linux-kernel+bounces-768694-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5D18B2643C
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 13:28:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 574485C7304
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 11:28:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47F832F39C3;
	Thu, 14 Aug 2025 11:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="NxkzQuRb"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F38CB2EAB6E
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 11:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755170888; cv=none; b=Kz3BCOsrb+8BwZh8BaOXReuc2JQ3AKhWtBqcpsMjXwjzsU1sqI554GeFjaMBoup/eNL1jx3l332P1ooQkebYQq2FUttytlNPjVbO6CYWrvaqPjbUVr3kRtS2kiNvIzNfYEs0SX7eGVKgdfFHbCt1WOsJPRet5z9MIAwmvOt87D0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755170888; c=relaxed/simple;
	bh=5a5UqwOexGq949D2CWoHjQzkzA1hMW3F2lBNPWzINeI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IglSWMjdfmVp+/JPuRHWkv0RKmyS6BXwvYnz4qdM7EoUNYTJ8ZhtH66sB9KPsLMxHQzuiTBKfEvHvRMbgOeUgAk4I5NhcyszTpUAC+0GTcO0XeYi3keBDFakHm4NVHljsKHXhf8BVjW4Bn+vwH6/ReFAzvXBJUvBtX7YXEy/jXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NxkzQuRb; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57E9knlv030062
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 11:28:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	0R6a4KQ0X3kUwsCYYCdAk+/a3kbqiO+5qCfgnfaBdBE=; b=NxkzQuRbhO3632Ya
	ux+j1TlBikqdGIaf6rbCDTzmolKtCIzM9aG514n7Bo4TlOUOfxl//Pd/NZEoPdaY
	gqS06U5jkLhME6MqqbaNSJXy8xQYYkDUu8TjgDBC00klDZu+zIRtTmeLKx1GvS/J
	ktkg/150oyCtHHPGt/i39dxcyhtuICR6xTA5p08KBzottT8Io2kMRRAA6QWBQQnP
	cyt3gsd3Z7TaGcNIgHNrT2RcqXrcPyLW0mHmrc+Wuz/kRjTcHIGIqkXH6TAGQ1l6
	NIwCGdz2fwLL03w6lONC7+Ztmehh+lu0CczZNhIhvv2shgraPf0fLREGdXCPcJuJ
	Y6GxIw==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48fm3vtcsh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 11:28:05 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4b10990a1f0so17863711cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 04:28:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755170885; x=1755775685;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0R6a4KQ0X3kUwsCYYCdAk+/a3kbqiO+5qCfgnfaBdBE=;
        b=hxkTYsRl2tjcIoT+gg4fUsQkan7SNYug6vQ5q16SwuXhbuxbdGYJmOgUPLiRiOPdo7
         KgXEEWY9DzJgrwmjGr2s9P2uFJF5QHfuMjnVLDQkve9Reyjr58VS6r7LUupqGcLjyNch
         y8RnGOifht9LRvsj1BcOZALWsVuN8htBIv7k5gopuvCLb3wCmTPHtBUfXtu4G+v6NGy2
         2VBClCKw+UmeNbBaDXisurtlszRAw72Ma+bxG64iQ1jczCTOPR2VJzeuUMIPecx2afLx
         v5CEDEs903ezQ+5v+PsPHii7m+0h98DPFs/L8+Me6zJITuai+kbGBMzXD9/LjalwjuDZ
         mBYg==
X-Forwarded-Encrypted: i=1; AJvYcCWh+OndnO+Mud5I5C4z/y/ihZV85WhQSRg8iR/N4NzJZ0Ip/Iir2fQVZv0j5tQFr9jfemaFmKVafzJkphw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyuptXNOyPG63ROzdLtCLKz0g0lP9dYpl0ZJcTEqgtiZGcPXo7O
	2IJvl1hVAitVV11jjYg9f/V399Tl8SBZ7svILzvhDN3ssaMbD2QYyMSa7bkwNinLbVie1NflF/t
	9JhKKL3CCzXvpx9s9U0avm4R3HuMWOs/GWnQeEGifz3vQxZcsy8pQommLCEnQrGUmQu0=
X-Gm-Gg: ASbGncsLhcBwxK0Po7oJterhHGXldpzBXY3JVlJhwLTjrWAAdyWwngCYPCqkpIBqMrN
	JPIaYFlGrVBFBUl1OMTKwZsAxI66L7m6PjpMRJt7t1IudyitCP7lowQgmroQL7QpSWTmveiJwjT
	6Yn8bprCfskzNQBdlqF6m/m9HaR3K8ygGiSWighzgbNes9ZOfwdbmuPaGKp7Men3bXUTvr85FE+
	d9u3XT3+fT+HNprP6+U3XK1BOx2Q90xfSBXnfdK4ymuMyWkoC+49L2MettSmzSqUwUMwL4ZCc6J
	XCg6OIxFvxg2DroJMTSy9q78BePPN1G/6MKUHRgi3dqc8dHiblPaJLV5NwlZTbCScwy1ll9ydV7
	qGnh2a7NyXfrKMw5LwCD3xPl3DTxbwlPQ3/bj+rr6/5/MEB4qIcnY
X-Received: by 2002:ac8:7d0e:0:b0:4b0:78d0:dc44 with SMTP id d75a77b69052e-4b10a9aa389mr38574231cf.27.1755170884459;
        Thu, 14 Aug 2025 04:28:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFzRCuM9kiY6PI0qg20Mf1hQ4IcpinSzxqZg4ByzOn/kmppeZpOhjcFAAW2d7sv+FmBrYxbKQ==
X-Received: by 2002:ac8:7d0e:0:b0:4b0:78d0:dc44 with SMTP id d75a77b69052e-4b10a9aa389mr38573641cf.27.1755170883961;
        Thu, 14 Aug 2025 04:28:03 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55b88c9912dsm5631019e87.108.2025.08.14.04.28.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 04:28:03 -0700 (PDT)
Date: Thu, 14 Aug 2025 14:27:59 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Yijie Yang <yijie.yang@oss.qualcomm.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Yingying Tang <quic_yintang@quicinc.com>,
        Shuai Zhang <quic_shuaz@quicinc.com>,
        Yongxing Mou <quic_yongmou@quicinc.com>
Subject: Re: [PATCH v5 0/3] Initial support for Qualcomm Hamoa IOT EVK board
Message-ID: <nruypjmek7f76m5nbv6vs63koscrwcqknswfm67rkcjtqxpwhe@3ijzkbbaxj2p>
References: <20250814-hamoa_initial-v5-0-817a9c6e8d47@oss.qualcomm.com>
 <5reeryefhw7burzf2lymhg5wivaq2n4gq5hszvfp57dergvpyx@qehaf334gdrn>
 <7e5d39e0-115e-40be-b44f-0195a4827a0c@oss.qualcomm.com>
 <63ecde5c-8234-4630-97e8-5806b9ff3eea@kernel.org>
 <a56b3e85-0d42-4945-8b6b-dcff20c7b104@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a56b3e85-0d42-4945-8b6b-dcff20c7b104@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODExMDEwNyBTYWx0ZWRfXy8ejwiFByreS
 Vl0IN13KK55EbAsKWxNXiYMPqpEMHsoJwoK5cyjnqZEEkuW6rMR0AV5ROfasFI2pW7KMCY9rFpD
 OCxz1jdnRkpiTl89mAmmskLaKfgfP58X0aHMDIhxAg074BCZ+DYeRcRYzxRK9IzyVtDS8FM8208
 aK9zOI8MMUUx0bYKYJnW1oQBEpnbP1RA+FWI4TLO9LfLn4cDa1q7ADyKfndv+BlqGzlVswS7wpe
 nZC8PqbxQqzIlsn8sjBL2M6AnSQ1jZKsRdtkrasmqfh1qRI5BgksK3s0CjUS7N+zX1pqSnZ2Fsf
 z7osRgQqq67FGXKXqEPx5ahPZ5PsT/x3gMGVHy9Te7rwwWKeuYwTrqx0FMTgi++cOdYCOCRLReR
 10wLkYpF
X-Proofpoint-GUID: TnIz1C42lm2msgJ-NedfJCSVWhadpmhT
X-Authority-Analysis: v=2.4 cv=A+1sP7WG c=1 sm=1 tr=0 ts=689dc845 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=g6L9LbontCBDyxqOBiAA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-ORIG-GUID: TnIz1C42lm2msgJ-NedfJCSVWhadpmhT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-13_02,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 priorityscore=1501 malwarescore=0 spamscore=0
 phishscore=0 clxscore=1015 adultscore=0 bulkscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508110107

On Thu, Aug 14, 2025 at 05:28:01PM +0800, Yijie Yang wrote:
> 
> 
> On 2025-08-14 17:05, Krzysztof Kozlowski wrote:
> > On 14/08/2025 10:54, Yijie Yang wrote:
> > > 
> > > 
> > > On 2025-08-14 16:24, Dmitry Baryshkov wrote:
> > > > On Thu, Aug 14, 2025 at 03:27:27PM +0800, Yijie Yang wrote:
> > > > > Introduce the device tree, DT bindings, and driver modifications required
> > > > > to bring up the HAMOA-IOT-EVK evaluation board—based on the X1E80100 SoC—to
> > > > > a UART shell.
> > > > > This patch set focuses on two key hardware components: the HAMOA-IOT-SOM
> > > > > and the HAMOA-IOT-EVK carrier board.
> > > > > The HAMOA-IOT-SOM is a compact System on Module that integrates the SoC,
> > > > > GPIOs, and PMICs. It is designed to be modular and can be paired with
> > > > > various carrier boards to support different use cases.
> > > > > The HAMOA-IOT-EVK is one such carrier board, designed for IoT scenarios.
> > > > > It provides essential peripherals such as UART, on-board PMICs, and
> > > > > USB-related components.
> > > > > Together, these components form a flexible and scalable platform, and this
> > > > > patch set enables their initial bring-up through proper device tree
> > > > > configuration and driver support.
> > > > > 
> > > > > Qualcomm SoCs often have multiple product variants, each identified by a
> > > > > different SoC ID. For instance, the x1e80100 SoC has closely related
> > > > > variants such as x1e78100 and x1e001de. This diversity in SoC identifiers
> > > > > can lead to confusion and unnecessary maintenance complexity in the device
> > > > > tree and related subsystems.
> > > > > To address this, code names offer a more consistent and project-agnostic
> > > > > way to represent SoC families. They tend to remain stable across
> > > > > development efforts.
> > > > > This patch series introduces "hamoa" as the codename for the x1e80100 SoC.
> > > > > Going forward, all x1e80100-related variants—including x1e81000 and others
> > > > > in the same family—will be represented under the "hamoa" designation in the
> > > > > device tree.
> > > > > This improves readability, streamlines future maintenance, and aligns with
> > > > > common naming practices across Qualcomm-based platforms.
> > > > > 
> > > > > Features added and enabled:
> > > > > - UART
> > > > > - On-board regulators
> > > > > - Regulators on the SOM
> > > > > - PMIC GLINK
> > > > > - USB0 through USB6 and their PHYs
> > > > > - Embedded USB (eUSB) repeaters
> > > > > - USB Type-C mux
> > > > > - PCIe6a and its PHY
> > > > > - PCIe4 and its PHY
> > > > > - Reserved memory regions
> > > > > - Pinctrl
> > > > > - NVMe
> > > > > - ADSP, CDSP
> > > > > - WLAN, Bluetooth (M.2 interface)
> > > > > - USB DisplayPort
> > > > > 
> > > > > DTS Dependency:
> > > > > https://lore.kernel.org/all/20250724-move-edp-endpoints-v1-3-6ca569812838@oss.qualcomm.com/
> > > > > 
> > > > > Signed-off-by: Yijie Yang <yijie.yang@oss.qualcomm.com>
> > > > > ---
> > > > > To: Bjorn Andersson <andersson@kernel.org>
> > > > > To: Konrad Dybcio <konradybcio@kernel.org>
> > > > > To: Rob Herring <robh@kernel.org>
> > > > > To: Krzysztof Kozlowski <krzk+dt@kernel.org>
> > > > > To: Conor Dooley <conor+dt@kernel.org>
> > > > > Cc: linux-arm-msm@vger.kernel.org
> > > > > Cc: devicetree@vger.kernel.org
> > > > > Cc: linux-kernel@vger.kernel.org
> > > > > 
> > > > > ---
> > > > > Changes in v5:
> > > > > - Update base commit.
> > > > > - Drop an already merged patch:
> > > > > https://lore.kernel.org/all/20250804-hamoa_initial-v4-2-19edbb28677b@oss.qualcomm.com/
> > > > > - Link to v4: https://lore.kernel.org/r/20250804-hamoa_initial-v4-0-19edbb28677b@oss.qualcomm.com
> > > > 
> > > > Please keep full changelog rather than trimming previous iterations.
> > > 
> > > Sure, I will restore them.
> > > 
> > > > 
> > > > Also, is there a reason why you didn't pick up audio and display chunks
> > > > as it was requested on the corresponding reviews?
> > > 
> > > Display-related changes have been merged into '[PATCH v5 3/3] arm64:
> > > dts: qcom: Add base HAMOA-IOT-EVK board' and are already present there.
> > > 
> > > Audio support is still under debugging due to unresolved issues, and
> > > it's unclear when it will be ready. Would it be acceptable to proceed
> > > without it for now?
> > Audio was sent to the lists, so this is confusing. What was the point of
> > that posting? It clearly said:
> > 
> > "Basic test is good in Hamoa-IOT-EVK board."
> 
> Additional issues with audio were discovered during further testing, and
> the current audio series on the list is not suitable to be merged into
> this series at this time.

What if the maintainer had picked up that series, with the issues?
If you uncover an issue, please respond to the patchset, descring that
it should not be merged (together with the reason and the description of
a problem).

> 
> > 
> > So was that true or not?
> > 
> > Best regards,
> > Krzysztof
> 
> -- 
> Best Regards,
> Yijie
> 

-- 
With best wishes
Dmitry

