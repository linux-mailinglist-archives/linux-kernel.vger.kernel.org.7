Return-Path: <linux-kernel+bounces-802949-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ACD1B458C3
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 15:25:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE8385C1937
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 13:24:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FB7A350841;
	Fri,  5 Sep 2025 13:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="MHTn0O4S"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCE61342CB6
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 13:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757078681; cv=none; b=juWz0WYoFc618fN/75FbGmqH+iZP8P6/hvf8X4IAhFIlMGFD61y1NwGvN1GghWPuX6Q7yMaKqGcjoOdKDlujnfaC7YHuTHI3sAyoz6mogiYrnIGTYYBnzV64uafX9euK8S0GHYffMbPD092iNuYB14MOTUqY+G5rRNW8F7Fq2tU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757078681; c=relaxed/simple;
	bh=47V1pWT30/JAy9Msd5PdOFGYfzNex1CvOxWZoRPIq0k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eZQOKNr31vHv0AkoME4Un7gw6vBI1YZxjCxa8CvoGwJwnDuOsTLI7qnu79fr3D+yxIb+DuZ+Y+JqGfG472bwUJu9ePZwQBA0FA7lNx1CGPqLHhb78tYVAwgWVNAafyjpNhLlo3M8T5d+ghs8jR5DX9uSgE6LQ29BIBuUWGluQuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=MHTn0O4S; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5856ukaQ024727
	for <linux-kernel@vger.kernel.org>; Fri, 5 Sep 2025 13:24:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	RttbkaeRD6xilyn46DClTRGu1NipwCW1nrCCMWrHQIM=; b=MHTn0O4S7Gy3dMp2
	koQg+xshH1SQPVBHB5e2F1UaGDM3B0BNHStVPQfc40YfWwU08RMD4J4yWOS19BYO
	0aGdrsVnKgH5CPHdZOgrHv2zt4OwZc/IfMxcbaYs9+tgWMpV9L2LctpevJV8/tiB
	SIWH8509GHw04YDwiIBeVpMoNpePUBiOWZa4MqgjXDzYgvhqFJsD9tLWRcWgGD3E
	DXL092Uy7nipZTbgfuu6UL9D0AtFZceB68ghGj4Oi1/eZqe8LcgJmZkyceBwlrSX
	YoiCJgi+f3bADusrMvz+W5C31B1E7wSIYZhVjvcw1R5eTZAoZxK/SOV9KmM7jbw8
	P2VWYw==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48ut2fu3dd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 13:24:39 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-811917bdcfeso174500785a.3
        for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 06:24:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757078678; x=1757683478;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RttbkaeRD6xilyn46DClTRGu1NipwCW1nrCCMWrHQIM=;
        b=fextXBb07cIqJmF7p6DeBnFaxIEnOIJSpTK8t5a0UlTnOTyd3VfPEfeNO/6TgYnBJb
         8jDYr/hwAaaNp9ax8e25MbvlTL9t74160nnf0pSFrO8ogt2UsNX2/qgj/mj8aQtcoYq6
         LOgtcDAkKGae/k9vjDOcTrJNKYTGypuFRLQaDr38DZMiWdixdOtz46lTkRwVYNxdmTAd
         KcZ0X1r6MKTLVzdkPhLc9rqgITg4t8xeJkRW1jBpBoAI3vRBE9u04IqTiKTDRZP9iNFN
         T5Rd5dcmcfpROjcDhjTJ+kkYn5IBB5eGWSJMHow7A1ALMRGwliyzlVXL5XXg74JZ4BtV
         GYNA==
X-Forwarded-Encrypted: i=1; AJvYcCXcX7kWs+8326K9lggkx1UvFRiGoDliIXOR90Fe4KR82HX7fvSDYG8WfPxOUL7o9qboR2irh51Xj5rtpEY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzX5qQsjA946HLVwKLha5VLZr0PV5VQxZlDnmoSg4wCywOJxptG
	ZBONziTTNzjjAmwPTo2Ic0vG5+ZuL4O1gLX0hUUODEd29GDuN+WlEnoUmOPeymjk6SL+Yl/NG8V
	+mDJilCTHkXCYHAZDukBppmVDzDzOBsbPaLmWKT7XRZtpOs0FAN6Sqr6ta0J8wgpYQ7z4+NBflJ
	3z/LGONQt4EXzJrEiqlfU4FFYv83LftJW6Xmk6Q+rtZg==
X-Gm-Gg: ASbGncv0ZNEQ8S0Gtm1HeHS5yP9OYu2MejBf3OGnpLYRgCUW+io4fIfzQK9cwa2Y4mG
	Qvv7yJQPUYdwe9PGhO/c3APKkwcz3JH2QoTELvGwq7T47ROcI0Wo+94MQ86ngaNSiF4GdjZIhbj
	SEnWvz9ee19k0nA1lmedKzyg==
X-Received: by 2002:a05:620a:4044:b0:807:87a9:89a8 with SMTP id af79cd13be357-80787a98b83mr1630326885a.28.1757078677412;
        Fri, 05 Sep 2025 06:24:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFwKlqHy3ni2v6MLagolHNSXn+wi+jzOJYgpcpKQrunqd0lwMvR3Jz4UeTH+V50XEmq/HR3JKYmu8PmY4cD2hQ=
X-Received: by 2002:a05:620a:4044:b0:807:87a9:89a8 with SMTP id
 af79cd13be357-80787a98b83mr1630321185a.28.1757078676776; Fri, 05 Sep 2025
 06:24:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250826181506.3698370-1-umang.chheda@oss.qualcomm.com>
 <20250826181506.3698370-3-umang.chheda@oss.qualcomm.com> <ao3nb3xkeutqetqx7amlfbqtvhuyojfvzm4prsze2mhgb2rpnc@s2bsigcrlxzo>
In-Reply-To: <ao3nb3xkeutqetqx7amlfbqtvhuyojfvzm4prsze2mhgb2rpnc@s2bsigcrlxzo>
From: Swati Agarwal <swati.agarwal@oss.qualcomm.com>
Date: Fri, 5 Sep 2025 18:54:25 +0530
X-Gm-Features: Ac12FXwf69CKgwq0J5qfcDqJVVXGxU5AIZsk8pJGBMQ2vq1_qm6B_7wK263cVew
Message-ID: <CAHz4bYs7Jy_NXcn6bOCHfxG=YoO+5vcAMUYEcptkJK+Cx+pA9Q@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] arm64: dts: qcom: Add Monaco EVK initial board support
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Umang Chheda <umang.chheda@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Rakesh Kota <rakesh.kota@oss.qualcomm.com>,
        Nirmesh Kumar Singh <quic_nkumarsi@quicinc.com>,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
        Mohd Ayaan Anwar <quic_mohdayaa@quicinc.com>,
        Arun Khannna <quic_arkhanna@quicinc.com>,
        Monish Chunara <quic_mchunara@quicinc.com>,
        Vikash Garodia <quic_vgarodia@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAzOCBTYWx0ZWRfX+SeJ5g1JqKD1
 ghRnnjpiGHjdgpRF/LetAV92LOqigp0lJhEbAG+BjnQOTL3I5RNSPK58uvJ3QE7X2gSkKOPMYk/
 PBM0eHyNRzvVqHF5JXi4TMAmkvarxY4dheFgY0C4TcsCU9t+3NTG2NM1K2+bc8TfqmGIsfVZgEr
 IO/qu5A8NtgbX1J6/+HZ/7lcYu4ysgDPHWnAIAdXaqSPS693KplkKbNAJOwxJi43GoHZV7j15PC
 52272gVxtbpqhwTNMu3zUtj3Q5Cgwc0z+X5FZIcQa8mVJKaEIOTlgJzwImmadClU0Iv4aBoNLQ9
 m4SWK1sDDjWgCSSBpnu2w9s9g+rLDjWdIzknCpW+m8t+biIfH+TwYfMjWbAC1GvxeJHC+jjuc5I
 9cUbQDSF
X-Proofpoint-ORIG-GUID: lM8Lom9gRLs5wKQvwCI_k8CvkyQh1UE2
X-Proofpoint-GUID: lM8Lom9gRLs5wKQvwCI_k8CvkyQh1UE2
X-Authority-Analysis: v=2.4 cv=U7iSDfru c=1 sm=1 tr=0 ts=68bae497 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8 a=uv0PlPAYtInrpSTTwawA:9
 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-05_04,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 clxscore=1011 impostorscore=0 suspectscore=0
 malwarescore=0 priorityscore=1501 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508300038

On Wed, Aug 27, 2025 at 7:13=E2=80=AFAM Dmitry Baryshkov
<dmitry.baryshkov@oss.qualcomm.com> wrote:
>
> On Tue, Aug 26, 2025 at 11:45:06PM +0530, Umang Chheda wrote:
> > Add initial device tree support for Monaco EVK board, based on
> > Qualcomm's QCS8300 SoC.
> >
> > Monaco EVK is single board supporting these peripherals:
> >   - Storage: 1 =D0=B2 128 GB UFS, micro-SD card, EEPROMs for MACs,
> >     and eMMC.
> >   - Audio/Video, Camera & Display ports.
> >   - Connectivity: RJ45 2.5GbE, WLAN/Bluetooth, CAN/CAN-FD.
> >   - PCIe ports.
> >   - USB & UART ports.
> >
> > On top of Monaco EVK board additional mezzanine boards can be
> > stacked in future.
> >
> > Add support for the following components :
> >   - GPI (Generic Peripheral Interface) and QUPv3-0/1
> >     controllers to facilitate DMA and peripheral communication.
> >   - TCA9534 I/O expander via I2C to provide 8 additional GPIO
> >     lines for extended I/O functionality.
> >   - USB1 controller in device mode to support USB peripheral
> >     operations.
>
> Is it actually peripheral-only?
Hi Dmitry,

HW supports OTG mode as well on the USB0 port but for enabling OTG
mode , it requires two things, one is role switch support and another
is VBUS supply on/off support. Both will be taken care of by Type-C
manager HD3SS3220. Currently, VBUS enablement support is not present
in the driver. Once that support is added, I will add OTG support for
the USB0 port, until then we would like to keep it in peripheral mode
for ADB support.

This is the same change which was discussed for lemans-evk [1] applies
for monaco-evk as well.

[1] https://lore.kernel.org/linux-arm-msm/d6816cc6-c69e-4746-932e-8b030ca17=
245@oss.qualcomm.com/

Regards,
Swati
>
> >   - Remoteproc subsystems for supported DSPs such as Audio DSP,
> >     Compute DSP and Generic DSP, along with their corresponding
> >     firmware.
> >   - Configure nvmem-layout on the I2C EEPROM to store data for Ethernet
> >     and other consumers.
> >   - QCA8081 2.5G Ethernet PHY on port-0 and expose the
> >     Ethernet MAC address via nvmem for network configuration.
> >     It depends on CONFIG_QCA808X_PHY to use QCA8081 PHY.
> >   - Support for the Iris video decoder, including the required
> >     firmware, to enable video decoding capabilities.
>
> I don't see firmware being declared here.
>
> >
> > Co-developed-by: Rakesh Kota <rakesh.kota@oss.qualcomm.com>
> > Signed-off-by: Rakesh Kota <rakesh.kota@oss.qualcomm.com>
> > Co-developed-by: Nirmesh Kumar Singh <quic_nkumarsi@quicinc.com>
> > Signed-off-by: Nirmesh Kumar Singh <quic_nkumarsi@quicinc.com>
> > Co-developed-by: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
> > Signed-off-by: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
> > Co-developed-by: Mohd Ayaan Anwar <quic_mohdayaa@quicinc.com>
> > Signed-off-by: Mohd Ayaan Anwar <quic_mohdayaa@quicinc.com>
> > Co-developed-by: Arun Khannna <quic_arkhanna@quicinc.com>
> > Signed-off-by: Arun Khannna <quic_arkhanna@quicinc.com>
> > Co-developed-by: Monish Chunara <quic_mchunara@quicinc.com>
> > Signed-off-by: Monish Chunara <quic_mchunara@quicinc.com>
> > Co-developed-by: Vikash Garodia <quic_vgarodia@quicinc.com>
> > Signed-off-by: Vikash Garodia <quic_vgarodia@quicinc.com>
> > Co-developed-by: Swati Agarwal <swati.agarwal@oss.qualcomm.com>
> > Signed-off-by: Swati Agarwal <swati.agarwal@oss.qualcomm.com>
> > Signed-off-by: Umang Chheda <umang.chheda@oss.qualcomm.com>
> > ---
> >  arch/arm64/boot/dts/qcom/Makefile       |   1 +
> >  arch/arm64/boot/dts/qcom/monaco-evk.dts | 463 ++++++++++++++++++++++++
> >  2 files changed, 464 insertions(+)
> >  create mode 100644 arch/arm64/boot/dts/qcom/monaco-evk.dts
> >
>
> --
> With best wishes
> Dmitry

