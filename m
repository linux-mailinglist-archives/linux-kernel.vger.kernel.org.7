Return-Path: <linux-kernel+bounces-584532-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E688DA78854
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Apr 2025 08:48:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2665216F2BD
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Apr 2025 06:48:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F36C233152;
	Wed,  2 Apr 2025 06:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="kYgfOfje"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7309E1519A6;
	Wed,  2 Apr 2025 06:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743576511; cv=none; b=MjCLSLUSThqrc9ngbMMdHIDK90zt9jQEeQy7TFoGt69R/enBIXWAaFNoFSjiIXevN5Ijs53kCdMowvEUWXwM2AIngWTCQdahEHyqgMX342p/AdcRvkFz8nV3uvHlQFMhpFB1YJi+S9TAAHPcBdHz+QbQUuT4QOjdItDQaI0kZgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743576511; c=relaxed/simple;
	bh=rJrZTLUfPSsTaF0Kiwgppk0BV/2THL2Hyq1TkbBJ6SM=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iQl8TfOHIuI9evPQy2SDsVRCEKyDkw/YxQSM2RW+lYiCof5RfLtxdHPXP+7bZZ9zHjwo3bP85UejgS+7MNt+/R4talUWnEC5bYSKmmSX2L7e6T92vyue8SeoqwulK4EO6EBeiY0dOs7DqgpV3jeIWfcFI7HnjEJ8nwTN4Sya/i4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=kYgfOfje; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5321sJfs001410;
	Wed, 2 Apr 2025 06:48:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=1j19lerr3n1G3skQOlESOS3N
	natj1gPn+jkxsjfvJ5s=; b=kYgfOfje9zIAjtSDb/ol97biVyGEKEM/u2vM/DbV
	BbVrSHpjXOA8T8OV4MCpS0xJUQ5bkYPMUeQDS1QXvV5oPjUKRKMjFRVlRtoytaw3
	2qvXADiNcY1yXfHUTHInUJvRFKscUNX2mKm/Z9r65mBODbk1Vf1qh+AVAAIwDU0L
	Tq9WJ9Q7AgOlrTP6iMHxRrmXYqlGOXETxaczQK2+JtRhOdyNaT9HZHSpKGrJax2P
	I68lu2YwyZgwXngRFSTj5zK7ZPOfoRlCOybAprgNjLnhxBR1OwFyrhn7ey38omSg
	A6Rozcow9wrp+bJowZhrVcWapH4v5uFdGd+0pIlHjzAkvg==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45p67qjq7c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 02 Apr 2025 06:48:24 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 5326mNE8032766
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 2 Apr 2025 06:48:23 GMT
Received: from hu-wasimn-hyd.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 1 Apr 2025 23:48:16 -0700
Date: Wed, 2 Apr 2025 12:18:05 +0530
From: Wasim Nazir <quic_wasimn@quicinc.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
CC: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Bjorn Andersson
	<andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel@quicinc.com>
Subject: Re: [PATCH v5 5/6] arm64: dts: qcom: Add support for QCS9075 Ride &
 Ride-r3
Message-ID: <Z+zdpU1f6LZrC96c@hu-wasimn-hyd.qualcomm.com>
References: <b0b08c81-0295-4edb-ad97-73715a88bea6@kernel.org>
 <Z4dMRjK5I8s2lT3k@hu-wasimn-hyd.qualcomm.com>
 <80e59b3b-2160-4e24-93f2-ab183a7cbc74@kernel.org>
 <Z8AWHiVu05s0RJws@hu-wasimn-hyd.qualcomm.com>
 <a8991221-88b2-4a39-a51b-587c4cdeebe4@kernel.org>
 <Z8laCxtHOdNm3rRu@hu-wasimn-hyd.qualcomm.com>
 <Z8lb889QrqluPXXl@hu-wasimn-hyd.qualcomm.com>
 <e00a7061-5283-4809-b652-5f6c5e1e4496@kernel.org>
 <Z9v/z/i6OyWXXe7N@hu-wasimn-hyd.qualcomm.com>
 <b46aad11-4787-49f9-ab4e-1737e583622f@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <b46aad11-4787-49f9-ab4e-1737e583622f@kernel.org>
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Authority-Analysis: v=2.4 cv=fMI53Yae c=1 sm=1 tr=0 ts=67ecddb8 cx=c_pps a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17 a=GEpy-HfZoHoA:10 a=kj9zAlcOel0A:10 a=XR8D0OoHHMoA:10 a=vCNE6W48tcnhvlFSCsYA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: p9FsdoVEX0kD8V9RgtZZcPnl_WzTu5J9
X-Proofpoint-GUID: p9FsdoVEX0kD8V9RgtZZcPnl_WzTu5J9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-02_02,2025-04-01_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxscore=0
 priorityscore=1501 phishscore=0 spamscore=0 impostorscore=0 clxscore=1015
 mlxlogscore=999 bulkscore=0 malwarescore=0 suspectscore=0
 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504020042

On Sat, Mar 29, 2025 at 05:48:00AM +0100, Krzysztof Kozlowski wrote:
> On 20/03/2025 12:45, Wasim Nazir wrote:
> > Hi Krzysztof,
> > 
> >>>>
> >>>> Which piece of actual hardware is represented in qcom-ride-common?
> >>>>
> >>>
> >>> All daughter cards like SOC-card, display, camera, ethernet, pcie, sensor, etc.
> >>
> >> No, I asked about the name of the hardware, datasheet, ID or picture.
> >> Common DTSI represents somoething, not just because you wanted to add
> >> something you had in downstream.
> >>
> > 
> > Currently we don't have any datasheet or document which is publicly
> > available, so I will try my best to describe our HW.
> > 
> > Ride is a modular hardware system with several smaller daughter cards
> > connected to single backplane board and each daughter card is stacked on
> > top of each other. I will try to explain each daughter card with HW
> > components and how it is connected to construct the ride-hw.
> > 
> > Backplane board:
> >   - It contains an MCU (Aurix TC397), CAN/LIN transceiver,
> > 	Audio/GNSS/IMU-I2C signals, Fan header
> >   - It holds & connects all the daughter cards.
> > 
> > SoC card:
> >   - It contains:
> >     - SoM:
> >       - One of QCS9075M/QCS9100M/QAM8775p SoM.
> > 	  - Each SoM is composed of either qcs9075/qcs9100/sa8775p SoC, along
> > 		with DDR & PMICs.
> >       - Each SoM can be mounted to same SoC-daughter card of ride-hw.
> >     - In addition to SoM, it also has
> >       - 4x UART, 2x USB 3.1 & 1x USB 2.0
> >       - Memory: 1x OSPI, 2x UFS-3.1
> >       - Debug: JTAG/QDSS header
> >       - PCIe0, PCIe1 & Display signals
> >       - Reset button
> >   - It is connected to backplain board via B2B connector.
> > 
> > Display card:
> >   - It contains:
> >     - 4 eDP ports & 2 DSI-DP bridge
> >     - I2C GPIO expander & I2C switch
> >   - It is connected to SoC-card via B2B connector.
> > 
> > Camera card:
> >   - It contains:
> >     - 4 Quad DE-serializer, each supporting 4 MIPI CSI inputs
> >     - Total upto 16 Cameras ports are supported.
> >   - It is connected to backplain board via B2B connector.
> > 
> > Ethernet card:
> >   - There are two variants of ethernet card each with different
> > 	capabilities:
> >     - [Ethernet-v1] card contains:
> >       - 2x 1G RGMII phy, 2x 1G SGMII phy(enabled currently)
> > 	  - Total 4 phy supported, only 2 phy are enabled and it is used in
> > 		ride.
> >     - [Ethernet-v2] card contains:
> > 	  - 2x 1G RGMII phy, 2x 2.5G HSGMII(enabled currently) & 10G PCIe based
> > 		MAC+PHY controller
> > 	  - Total 5 phy supported, only 2 phy are enabled and it is used in
> > 		ride-r3.
> >   - Either [Ethernet-v1] or [Ethernet-v2] is connected to backplain board
> > 	via B2B connector.
> > 
> > PCIe card:
> >   - It contains:
> >     - PCIe connections to SoC-card
> > 	- NVME, 2x WLBT module QCA6696/QCA6698 (Wi-Fi & bluetooth solution) &
> > 	  GNSS module
> >   - It is connected to backplain board via B2B connector & PCIe signals are
> > 	connected to SoC card via flyover cables.
> > 
> > Sensor Card:
> >   - It contains 3-Axix compass & 6-Axis 3D IMU (accel/gyro) module which
> > 	are communicating via I2C
> >   - It is connected to backplain board via B2B connector.
> > 
> > Front panel card:
> >   - It does not contain any active circuitry, only ports are available
> >     - Audio-in/out ports
> >     - USB hub ports
> >     - CAN/LIN ports
> >     - 12V power off switch
> >   - It is connected to backplain board via ribbon cable.
> > 
> >>
> >>>
> > 
> >>>> |             |                      | +-------------------------+-----------------------+-----------------< sa8775p-ride-common.dtsi           |
> >>
> >>
> >> There is no ride-common hardware. If there is, send us any proof of its
> >> existence. all your statements here show you want to create some
> >> structure because you like it. I don't think you get my questions. You
> >> painted diagram of DTS, not hardware.
> >>
> >> We talk about hardware. Not your DTS. Drop all DTSI, DTS, DTSO from here
> >> and show us the hardware.
> >>
> > 
> > Considering outlined h/w description, following are ride configuration
> > variation each platform supporting:
> > 
> > Between qcs9075, qcs9100 & sa8775p ride/ride-r3 boards, SoM is changing;
> 
> Define these as SoMs then.

sure

> 
> > And between ride & ride-r3 ethernet is changing.
> 
> Different ethernet cards can be also represented as cards - their own
> DTSI. But there is no soc-card with one or other ethernet, so do not
> create fake structure just because downstream had it.
> 

Ok, will proceed with dtsi for v1/v2 ethernet cards and use it for ride &
ride-r3 respectively.

> 
> > Excluding these differences all other cards i.e SoC, display, camera, PCIe,
> > sensor, front & backplain are same and are refactored in ride-common.
> > If any variant of these cards comes up in future we need to refactor
> > ride-common accordingly. I will try to outline this as clearly as possible
> > in next commit log.
> > 
> > Considering current outlines of all daughter cards, following defines
> > ride/ride-r3 variant boards:
> >   - sa8775p ride    : QAM8775p SoM + [Ethernet-v1] + other daughter cards
> >   - sa8775p ride-r3 : QAM8775p SoM + [Ethernet-v2] + other daughter cards
> >   - qcs9100 ride-r3 : QCS9100M SoM + [Ethernet-v2] + other daughter cards
> >   - qcs9075 ride-r3 : QCS9075M SoM + [Ethernet-v2] + other daughter cards
> > 
> > Since we don't have a document yet which formally describes
> > qcs9075/qcs9100 ride board with [Ethernet-v1] card, I shall be dropping
> > this particular variant in next patch series and re-send after complete
> > documentation is available.
> > 
> >>> Actually we are not including dts here instead *.dtso file will be
> >>> overlayed to *-ride.dts to generate *-ride-r3.dts.
> >>>
> >>> Below is the correct arrow sequence.
> >>
> >> And the overlay represents what exactly? Different board? No, that's not
> >> how overlays should be used.
> >>
> >> You have different board, you have different DTS.
> >>
> > 
> > No the overlay is not a different ride board. This overlay represents
> > [Ethernet-v2] card which is different than [Ethernet-v1] card.
> 
> Different cards is not an overlay. Overlay is for added cards, but you
> replace here the card.
> 

Understood, will proceed with dtsi way of adding ethernet cards for
ride & ride-r3 boards.

>
>

Based on current understanding, here is the final structure for the dts
& dtsi, representing all variant of boards.

Ethernet cards are represented using dtsi as:
  - [Ethernet-v1] card: sa8775p-ride-ethernet-88ea1512.dtsi
  - [Ethernet-v2] card: sa8775p-ride-ethernet-aqr115c.dtsi

+-------------------------------------------------------------------------------------------------------------------------------------------------------+
|                                                                                                                                                       |
|                                                           sa8775p.dtsi                                                                                |
|                                                                 |                                                                                     |
|                                       +-------------------------+-----------------------+                                                             |
|                                       |                         |                       |                                                             |
|                                       v                         |                       v                                                             |
|                                qcs9075-som.dtsi         qam8775p-som.dtsi        qcs9100-som.dtsi                                                     |
|                                       |                         |                       |                                                             |
|                                       v                         v                       v                                                             |
|                                     (IOT)                    (AUTO)                   (IOT)                                                           |
|                                       |                         |                       |                                                             |
|             +-------------------------+                         |                       |                                                             |
|             |                         |                         |                       |                                                             |
|             |                         | +-------------------------+-----------------------+---------------< sa8775p-ride-ethernet-88ea1512.dtsi       |
|             |                         | |                       | |                     | |                                                           |
|             |                         | | +-------------------------+-----------------------+----------+--< sa8775p-ride-common.dtsi                  |
|             |                         | | |                     | | |                   | | |          |                                              |
|             |                         | | |          +----------+ | |                   | | |          |                                              |
|             |                         | | |          |          | | |                   | | |          |                                              |
|             v                         v v v          |          v v v                   v v v          |                                              |
|  qcs9075-iq-9075-evk.dts         qcs9075-ride.dts    |     sa8775p-ride.dts        qcs9100-ride.dts    |                                              |
|                                                      |                                                 |                                              |
|                                                      | +-----------------------------------------------+                                              |
|                                                      | |                                                                                              |
|                                                      | | +------------------------------------------------< sa8775p-ride-ethernet-aqr115c.dtsi        |
|                                                      | | |                                                                                            |
|                                                      v v v                                                                                            |
|                                              sa8775p-ride-r3.dts                                                                                      |
|                                                                                                                                                       |
+-------------------------------------------------------------------------------------------------------------------------------------------------------+

Please let us know if we can proceed with the change.


Thanks & regards,
Wasim

> Best regards,
> Krzysztof

