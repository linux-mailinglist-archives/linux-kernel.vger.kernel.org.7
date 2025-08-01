Return-Path: <linux-kernel+bounces-753722-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6611BB186EA
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 19:54:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8158D5821F2
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 17:54:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D7612701C2;
	Fri,  1 Aug 2025 17:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Ov/k89LR"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7C211AAA1B
	for <linux-kernel@vger.kernel.org>; Fri,  1 Aug 2025 17:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754070853; cv=none; b=YW5DvHMTsAgCLn1Hz2d991d/Ckn737ETvgIK2uq0iwutX9wk5rJzzUQ/L/vGgmHwftUaE6ENAYtBY6iTzaVIFZsSl0XQTNSzEcUwqRc6ggZsrW2lDAYncj8qzK25ndJs1DKJMKpe2ykfF3kTxA0xAJR3LqHk8r0mNlHNku+aC6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754070853; c=relaxed/simple;
	bh=fAoe6Y6LPeN/HPnLbHqLpj5NHlL21pCUIdALDreDr8I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nBa3kuyZ0HTs3SPSkqgYMfIkIOCQRXC2mjstFiFXzYnVpmyWw6ag1qLL1KKTStk4/IzQVNqdQ+hHQImuC4alfVuyTnL9wPHk3zyOROW+r0JJzAzltBhl4Ewr4n09NtgjigKjl2ES4HyjL+R7giubdpSGGuPDXIXwkbCsgG0+ggY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Ov/k89LR; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 571HfaNF029256
	for <linux-kernel@vger.kernel.org>; Fri, 1 Aug 2025 17:54:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	S7f4+guRHjktBbGeLl9ySxS18aKIvptkhBuK8g5+Jd4=; b=Ov/k89LROPmGZoQe
	SQAxcIV7umVQbtY/pAM0wiLm5Ws6FY8LL08LCLsfmWOaFNxw0nxhRSIURDSWWMjG
	W1ruyLxnfK42G6+kx0h1F5J1vN5GPnrNE+RGHAbnoqOfMysDe9E8ArDEEUvJH2dF
	zl7yaMDDTZXMJYHl1Ssv+yisSLc5N692DEuRlzM3E+mhNgrMRW4fsOtpc/Lsr2EP
	iKsEO6PUHTrXsT5mX3Brf9ceJT4bF5KAVxBypajuD+eFnESllc3sm6PxrIm2L2qM
	6939zY52TGg7bwNIpJ1F0jMWGeRMJuXXBDxOUHn/LbJi3jR+gHKwvodCOuqhJ2GE
	lOHJNA==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 484q86d4s0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 01 Aug 2025 17:54:11 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4ab878dfc1aso47996311cf.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Aug 2025 10:54:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754070849; x=1754675649;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S7f4+guRHjktBbGeLl9ySxS18aKIvptkhBuK8g5+Jd4=;
        b=BotWGvMNyE2UwohLUDmlTKpEoOe3sm2aVYsD9rsXPpz0T8sRbJeE5sIbIy27Gq5Ux9
         8znVmPshAcqg72s5b3k0VmEjipoVwOYZuQYMBCJlpE1idsuF+R4wPZ/g/tEqtcPsZy4U
         tx3+40mZF1Gwk9n80ALvNQQ9GVvfyi7J/HpGzT5ZOM/ZWB64UDOsJXUlQx0DbAYL1qaW
         NlhYvkHfYwzQIfMAXnAHMVNv2xu0lNcbY4nXPSYvucgCycV2dksnXGdJ+YPRObXYto0G
         CYI0XirE/Wo4tTbOMUPd9pgOAMVjR/9Zo8DXMW5cTkaO5y/SEARh/4Tibecy9QBSHO4x
         dEQQ==
X-Forwarded-Encrypted: i=1; AJvYcCX41PlgATQLUAxKbs0vHj5h4vP+zKado0EC6EYO9dCIk3fbr6Y9de7VtZ4TznPaLHD65BR9X9VjUIGgSu0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIgbBZ/5ODPFyFCZiUTimbc8Sjtguzu04bZYza6/oLpZ5ELBBY
	oLL6ZMTODrF8XlRHxvJsom9sYIQswkq4d5tb4wjUtrzKDDI6Pfgu+gFijMrq89U47TyDYCj7fO2
	fecOVR5Iw3ZPQiLXO/iU9QEBQluyetYZcAD+3Axm83LWlUrzJnL5nPCwIFocZsApjGzg=
X-Gm-Gg: ASbGncv82QUt5kl5e0HBB2GVgP/aLk0PNt3P9raBx3Osfi9sNUzG+RDLXr6bbLuBoAa
	Dn0rBwT8sRAYyNYZ64TzUDzlfhMXWiLUOTyXgOs8Yf29IWaXIYi71XqGTzby4pCYj1GSvX3Ts+H
	cXWxTKPlA3Tij90lPv4szHtudOyjXWYkv2b5b70c6IDefG/LM4pBBWmYVLfNHgwmMYz5Z9Ja1Mc
	ilHlRH2lUK5VbIJ2HrRSNuT1GdnkoQkJ7TXhPJExqRToR8Q7EdA6Ql9RwSyw0CKJLRXO8iMvYIN
	gg56KlQB09or4o7r6IHXNsMsJi7Ad/H/6soKNK+rt0qb8znHW/DEwCroIGoAG2IzII8tX3J0gQd
	gxT/+MNEPOsp3I6phFtjWbNzSPCnuws2WTXyJxgrTnKTTgRSLrpiS
X-Received: by 2002:ac8:5755:0:b0:4ae:f502:d62e with SMTP id d75a77b69052e-4af10d19299mr10950451cf.50.1754070849505;
        Fri, 01 Aug 2025 10:54:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF3kthbEbHtl8fTjc7vGgklihIbJVuQF5n8TQ1Xt9JTa+3yTNpRoKu//yUU3XhxhYkcsc/6cQ==
X-Received: by 2002:ac8:5755:0:b0:4ae:f502:d62e with SMTP id d75a77b69052e-4af10d19299mr10950041cf.50.1754070849010;
        Fri, 01 Aug 2025 10:54:09 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55b88cb7fd2sm666886e87.179.2025.08.01.10.54.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Aug 2025 10:54:08 -0700 (PDT)
Date: Fri, 1 Aug 2025 20:54:06 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Yijie Yang <yijie.yang@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/4] arm64: dts: qcom: Add base HAMOA-IOT-EVK board
Message-ID: <myk2qvna427nmfz37p7xniafueu2akpmqzq2y7qmqnzsmggwks@fctmeqkgdkrc>
References: <20250729-hamoa_initial-v3-0-806e092789dc@oss.qualcomm.com>
 <20250729-hamoa_initial-v3-4-806e092789dc@oss.qualcomm.com>
 <pbvyog477v32s4lu72z52dhsond5yud5w3nxmcouvr6ljlndlh@ws46dncy35c6>
 <b4a3f568-f41f-4141-b421-8b158973f810@oss.qualcomm.com>
 <cawg456ucsvssm2ngbcjvpprxke7s3sfqf4fzoj5dtfj2flnzw@2e3h5ojgn4s5>
 <391b8214-37f2-460d-94d0-3bd0daa00066@oss.qualcomm.com>
 <mlbutlxudl5i32zrqegxiefaa2sbkntriwdftn7hxo4khidtf2@oiljtmtktovu>
 <31b03c1b-513a-4eae-9233-568aab12e0c8@oss.qualcomm.com>
 <afd9e24f-b432-494c-8ea6-dbfe4c51e048@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <afd9e24f-b432-494c-8ea6-dbfe4c51e048@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODAxMDEzOCBTYWx0ZWRfX0WuPGiWxCQ8N
 YzLYB0F3h8BmyRtKZ9goqSnnEwvd5kRUvs1MLlWTrLaqvcrpk07MCIMTe/Bm5ZlZisD/iQsdbCq
 73NbOVsVtSbYtD+ZcDDJJ0PcIZZPzBKypI9YKUpriUn7MSEBCMfn3iYON5hP202A1aYZ9AlYV8u
 8jN3Aib0+deB4Hk3tJejUMSq2RjQjluVY+WCMwwieRczMwWDR2bmZPUcSvxPZReSXZAfabAAds0
 qUFNr653wsbdKLw4leA/f3vgjnUuafIPwzvnoOhPRl/TzMFFAheOsOFYe932deM+NjZb9ctZRBH
 DGMTEjSdkOOPwiyg9kN40zKSThnbq7eBSINLZd9bguHWn7ZNKDlN+DONSmbvhfYiiPurnCa2aAK
 B1maoc+JSOVYhmxw/Ide4bYRse5i/gZJNWPXE4xRYriBm0sqTb5MaevxXxl2KRgByf5mK3mb
X-Authority-Analysis: v=2.4 cv=TqLmhCXh c=1 sm=1 tr=0 ts=688cff43 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=ugY2ukpke_LRrYEqQncA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-ORIG-GUID: 3SZbmc8fAoAZOuv1AEqmxgf-FzKdvUaI
X-Proofpoint-GUID: 3SZbmc8fAoAZOuv1AEqmxgf-FzKdvUaI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-01_06,2025-08-01_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 phishscore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0
 malwarescore=0 adultscore=0 spamscore=0 priorityscore=1501 clxscore=1015
 impostorscore=0 mlxlogscore=999 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2508010138

On Fri, Aug 01, 2025 at 12:39:09PM +0200, Konrad Dybcio wrote:
> On 8/1/25 3:48 AM, Yijie Yang wrote:
> > 
> > 
> > On 2025-08-01 04:22, Dmitry Baryshkov wrote:
> >> On Thu, Jul 31, 2025 at 04:45:33PM +0800, Yijie Yang wrote:
> >>>
> >>>
> >>> On 2025-07-31 02:42, Dmitry Baryshkov wrote:
> >>>> On Wed, Jul 30, 2025 at 02:28:25PM +0800, Yijie Yang wrote:
> >>>>>
> >>>>>
> >>>>> On 2025-07-29 18:37, Dmitry Baryshkov wrote:
> >>>>>> On Tue, Jul 29, 2025 at 09:32:00AM +0800, Yijie Yang wrote:
> >>>>>>> The HAMOA-IOT-EVK is an evaluation platform for IoT products, composed of
> >>>>>>> the Hamoa IoT SoM and a carrier board. Together, they form a complete
> >>>>>>> embedded system capable of booting to UART.
> >>>>>>>
> >>>>>>> This change enables and overlays the following peripherals on the carrier
> >>>>>>> board:
> >>>>>>> - UART
> >>>>>>> - On-board regulators
> >>>>>>> - USB Type-C mux
> >>>>>>> - Pinctrl
> >>>>>>> - Embedded USB (EUSB) repeaters
> >>>>>>> - NVMe
> >>>>>>> - pmic-glink
> >>>>>>> - USB DisplayPorts
> >>>>>>>
> >>>>
> >>>>
> >>>>>>> +    vreg_rtmr0_1p15: regulator-rtmr0-1p15 {
> >>>>>>
> >>>>>> Hmm, so there are regulators for the retimer, but they are not used.
> >>>>>> Could you please point out, why?
> >>>>>
> >>>>> According to the schematic, there is a regulator and a retimer (PS8830).
> >>>>> However, as mentioned above, the retimer is not connected to USB 0 and is
> >>>>> therefore not used in the EVK. As a result, the regulator is left unused in
> >>>>> this context.
> >>>>
> >>>> What is connected to the retimer then?
> >>>
> >>> All data lines are broken, except for some power lines.
> >>
> >> Ok. please add a comment. If the retimer is connected to I2C bus, please
> >> define it too.
> > 
> > It’s not connected to I2C. I will add a comment here.
> > 
> >>
> >>>
> >>>>
> >>>>>
> >>>>>>
> >>>>>>> +        compatible = "regulator-fixed";
> >>>>>>> +
> >>>>
> >>>> [...]
> >>>>
> >>>>>>> +
> >>>>>>> +    usb_1_ss0_sbu_default: usb-1-ss0-sbu-state {
> >>>>>>> +        mode-pins {
> >>>>>>> +            pins = "gpio166";
> >>>>>>> +            function = "gpio";
> >>>>>>> +            bias-disable;
> >>>>>>> +            drive-strength = <2>;
> >>>>>>> +            output-high;
> >>>>>>
> >>>>>> What does this pin do? It's not recommended to set GPIO values through
> >>>>>> pinctrl.
> >>>>>
> >>>>> It is used to switch data lines between USB Type-C orientation detection and
> >>>>> DisplayPort AUX channels.
> >>>>
> >>>> I don't think I follow it here. Which data lines? Type-C orientation
> >>>> detection uses CC1 / CC2, DP AUX use SBU lines.
> >>>
> >>> I made a mistake here — this pin switches between two data sources: one is
> >>> DP AUX, and the other is a GPIO pair configured with the function
> >>> usb0_sbrx/usb0_sbtx. Both data sources originate from the SoC and are routed
> >>> to the USB0_SBU1 and USB0_SBU2 lines of the USB Type-C connector.
> >>
> >> So, it's some USB4 stuff. Ideally it should be described via the
> >> gpio-sbu-mux, but I don't think we can do that for now. I'd let Bjorn,
> >> Konrad or Abel comment on this.
> > 
> > Sure.
> 
> There is no DT representation of USB4 hardware at the moment, feel
> free to pretend it doesn't exist for now.
> 
> If we wanted to be hyper-correct, the way USB(3) is plugged into the
> bigger picture isn't quite pristine either, but that's a story for
> another day - need some puzzle pieces to come together first

Ack. Then the current description is fine.

-- 
With best wishes
Dmitry

