Return-Path: <linux-kernel+bounces-803007-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C70B2B4595A
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 15:41:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 761891C81F59
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 13:42:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DD8A350D59;
	Fri,  5 Sep 2025 13:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="n9B0clsF"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20C912882D7
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 13:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757079689; cv=none; b=P+ZBC+S7qJ33lxpxyc2Pch9cOAy1+lRAegDS3WPzi8ItF2MLOjoXqtFOwmLpXENr9lcksB5cV/He9v1ldN16bq47PQuEmVfRYDV3abDqqAZmZA0phnMXxG+MXsy8AVP/Szq7R06cCOOaNLOcKuWfMRezXXI7ts7i6e69vPIBEBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757079689; c=relaxed/simple;
	bh=jLry5UhH6/hPCvtIbxA4Y7EVMcaMoizeFGKLOfELDV0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i10/FRl8R+oaTyIegdD0l6Q6uAvoBWbMoYIGIoW2kY6ZfvC/Ee0ozXl04lWWrso/iKBenQi96fgGzFCZump8ypTKzNTf33MHyiIb0s/QClETtJfjcf4KWFFj4eIpY+9GPUEmFFgKqVocTuJx7fiNScmkj544BkQM2sd7leMT7Hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=n9B0clsF; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58572Onj003799
	for <linux-kernel@vger.kernel.org>; Fri, 5 Sep 2025 13:41:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	9nairzrxrLx+7AmhxXAPpkwSM1Xt+xwotCDD82OGERA=; b=n9B0clsF/5Xvf6fQ
	HgVu6KdMH+j+jIb0eHfcKqZWA7cOthaiEiUELXvxcHzTcBJGv1S4zBLh8FHqTHDZ
	fYHD8hgC3RpgGcujbi+O/3mbnVFgp3qshrVwPJLrKrN+xCE4j0F5LVsmOJ3fLTML
	dKP1EXdtxf695XzIP0bS/Hd5g4VaGzvLmdJHZHoFkXz7FqvUXUcxBrPpFRzewgO7
	FFTZuSI1n5vd36ufu+7SDnQeDZZ3YGSYy7LHPpJQj/k5ku2Tgd5TaQH8mOKHm9Zd
	utyuf5ciEYzYC54sWCBGappjxvgW5kBm/Im69b8rHDUPx/0km/wbzZM7wtYZ/oU5
	wOdf5Q==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48ur8sbcvw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 13:41:26 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4b30cb3c705so65103551cf.3
        for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 06:41:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757079685; x=1757684485;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9nairzrxrLx+7AmhxXAPpkwSM1Xt+xwotCDD82OGERA=;
        b=pvs2B/iVEI80Zc0L32gNRNqzadOR0vlCDtkk5BOZpoo0D+b7AA23xYtqh+l/I2ALYy
         GtFem2ln13o0jnG0dPySg4ICQw5+6rG6s5TNYhxAjSIXwnbZK0fpdKrVeTZkfu4I5zar
         5X2Qj+IjDt9yVGGHl3wqvsANik22RaU2yM/tvWJHQ1NxZe6WWOBUoocmxetCsZpDj4ay
         GLavfk+7Bsc3Tg8N1w2IiGGW82yomEd2qkMNKhqjf3q4HGeoIBSjkhRWBNaRZMf4Cfqv
         GMoCcNFb8sG5/EBRGzbQbJ6Fq5DSCfhHqf0xH6nBCd6/yDSFNXHUoCesmNzaM+MtvC1P
         W3vw==
X-Forwarded-Encrypted: i=1; AJvYcCXjoNo2J6nW0oHvJBw76045fgzomf/biSUiH0rYm8DQXow2VhtJw10cVOLePWZMEBe5JBziuLoR8ScGvq0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcT5VTRkZj6hpN73nG1z4WrW4q2PXfiAhF0Kkl7CSnbFSiFc5X
	Qy5t+8EXdLNzPtPpKY9niTeqNmOOs+M2VpRwjZrgV1ckb65/rat+FOr88wkNTRUCxPq01ZTF82T
	5CGxAtBsl21v2xZHWCWR1fLtRMxKzXEJ/OpJzkSZB5vNJkUi47gn45gXADhlQvAqwh4c=
X-Gm-Gg: ASbGncu45esaSTk1oSrpDK/lKv03Lx/JySjN/F6EC+omht6XCFgKTfgYMcLabSbworh
	5QyPKmaib7GuaeznunagPwYImnlckqgfIz6kP975/Fgv2aclZDyPEI7EiO9d1eGTd9k3jm6Kp8R
	N83RQ5WiZYMA/ZaS96NTqE+ChfyL5sNExUkFOnU0m4g7QKpjyDQ5aW+5Iys+GsO93alG0wDiPpN
	MKJk9SVqk7tETfxA4rtgWn75R3lzwfon+bFOHoSgz5YZTNkMZviQHO0U1XrI5EZsnqT/vLRo6D0
	AJBrVR4TN+yiyHHkP2txWh/z33XOGJ+4RM2jMobuVKY8HlExr12N7TAgvZ02ID0JH5CiYcSwjAj
	Me7sU9etL901jd9JznJirYlt5VHJFG1DAes21BBvsE71rIfZkYKDE
X-Received: by 2002:a05:622a:a10:b0:4b3:285:91da with SMTP id d75a77b69052e-4b31dc737afmr311154681cf.68.1757079684536;
        Fri, 05 Sep 2025 06:41:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEuMjYizg5Pnq40M/qfidOWisBr2dPqOMM0XLBwoecs1KjkC0Nk5K5IjnyM5w+W1vLbkO4LuQ==
X-Received: by 2002:a05:622a:a10:b0:4b3:285:91da with SMTP id d75a77b69052e-4b31dc737afmr311153971cf.68.1757079683724;
        Fri, 05 Sep 2025 06:41:23 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5608ace9c89sm1784613e87.91.2025.09.05.06.41.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 06:41:22 -0700 (PDT)
Date: Fri, 5 Sep 2025 16:41:21 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Swati Agarwal <swati.agarwal@oss.qualcomm.com>
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
Subject: Re: [PATCH v3 2/2] arm64: dts: qcom: Add Monaco EVK initial board
 support
Message-ID: <ow7gdrkissn4npgbua3krdtkexvf47yu57e6luf7bizfvcvbge@33uwiohzlunk>
References: <20250826181506.3698370-1-umang.chheda@oss.qualcomm.com>
 <20250826181506.3698370-3-umang.chheda@oss.qualcomm.com>
 <ao3nb3xkeutqetqx7amlfbqtvhuyojfvzm4prsze2mhgb2rpnc@s2bsigcrlxzo>
 <CAHz4bYs7Jy_NXcn6bOCHfxG=YoO+5vcAMUYEcptkJK+Cx+pA9Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHz4bYs7Jy_NXcn6bOCHfxG=YoO+5vcAMUYEcptkJK+Cx+pA9Q@mail.gmail.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAxOSBTYWx0ZWRfX76UwvyGJF8kz
 o+rVEas88Wh83Bz468iHDPfTEd3HEv7Ti/HQo1cotRQAqsanMjyLCoATql386jGWz0M1qMPnee1
 r0OZ9yWT4RyDHv/Pwj+jefCJWSy9ibu76MoWHEWMyGz0ggDo4VM0+DdgZWf4E7BhgSWsAQgQskx
 6khs4bNzxoSnb21Qs8hNp36o/NAUlR0rSUt963fAtmaKshETEwnaM/t7sNvlSMTPJbwrUFFua78
 FxNNPtCFkaj9EUFr9Yu4Cg3YcE935d40FZJFKRK/ZUq5NAM0EIghUCf7PREoePLxe7tVLoAKvma
 SfrSN6jfic66rKZW+z9tqCIVk6JAGDtzm3S/ZZhynM1n6igxiPZaCnFhQFYc83KnALwlnUhKDA6
 kTimjBu+
X-Proofpoint-GUID: PlSVr1puVUpuPymjMb95V0W6b4n0axKR
X-Proofpoint-ORIG-GUID: PlSVr1puVUpuPymjMb95V0W6b4n0axKR
X-Authority-Analysis: v=2.4 cv=PNkP+eqC c=1 sm=1 tr=0 ts=68bae886 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8
 a=5rBl_X4QI-NXlREZvckA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-05_04,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 priorityscore=1501 impostorscore=0 clxscore=1015
 suspectscore=0 adultscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508300019

On Fri, Sep 05, 2025 at 06:54:25PM +0530, Swati Agarwal wrote:
> On Wed, Aug 27, 2025 at 7:13 AM Dmitry Baryshkov
> <dmitry.baryshkov@oss.qualcomm.com> wrote:
> >
> > On Tue, Aug 26, 2025 at 11:45:06PM +0530, Umang Chheda wrote:
> > > Add initial device tree support for Monaco EVK board, based on
> > > Qualcomm's QCS8300 SoC.
> > >
> > > Monaco EVK is single board supporting these peripherals:
> > >   - Storage: 1 в 128 GB UFS, micro-SD card, EEPROMs for MACs,
> > >     and eMMC.
> > >   - Audio/Video, Camera & Display ports.
> > >   - Connectivity: RJ45 2.5GbE, WLAN/Bluetooth, CAN/CAN-FD.
> > >   - PCIe ports.
> > >   - USB & UART ports.
> > >
> > > On top of Monaco EVK board additional mezzanine boards can be
> > > stacked in future.
> > >
> > > Add support for the following components :
> > >   - GPI (Generic Peripheral Interface) and QUPv3-0/1
> > >     controllers to facilitate DMA and peripheral communication.
> > >   - TCA9534 I/O expander via I2C to provide 8 additional GPIO
> > >     lines for extended I/O functionality.
> > >   - USB1 controller in device mode to support USB peripheral
> > >     operations.
> >
> > Is it actually peripheral-only?
> Hi Dmitry,
> 
> HW supports OTG mode as well on the USB0 port but for enabling OTG
> mode , it requires two things, one is role switch support and another
> is VBUS supply on/off support. Both will be taken care of by Type-C
> manager HD3SS3220. Currently, VBUS enablement support is not present
> in the driver. Once that support is added, I will add OTG support for
> the USB0 port, until then we would like to keep it in peripheral mode
> for ADB support.

Add comment to the DT file, please.

> 
> This is the same change which was discussed for lemans-evk [1] applies
> for monaco-evk as well.
> 
> [1] https://lore.kernel.org/linux-arm-msm/d6816cc6-c69e-4746-932e-8b030ca17245@oss.qualcomm.com/
> 
> Regards,
> Swati
> >
> > >   - Remoteproc subsystems for supported DSPs such as Audio DSP,
> > >     Compute DSP and Generic DSP, along with their corresponding
> > >     firmware.
> > >   - Configure nvmem-layout on the I2C EEPROM to store data for Ethernet
> > >     and other consumers.
> > >   - QCA8081 2.5G Ethernet PHY on port-0 and expose the
> > >     Ethernet MAC address via nvmem for network configuration.
> > >     It depends on CONFIG_QCA808X_PHY to use QCA8081 PHY.
> > >   - Support for the Iris video decoder, including the required
> > >     firmware, to enable video decoding capabilities.
> >
> > I don't see firmware being declared here.
> >
> > >
> > > Co-developed-by: Rakesh Kota <rakesh.kota@oss.qualcomm.com>
> > > Signed-off-by: Rakesh Kota <rakesh.kota@oss.qualcomm.com>
> > > Co-developed-by: Nirmesh Kumar Singh <quic_nkumarsi@quicinc.com>
> > > Signed-off-by: Nirmesh Kumar Singh <quic_nkumarsi@quicinc.com>
> > > Co-developed-by: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
> > > Signed-off-by: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
> > > Co-developed-by: Mohd Ayaan Anwar <quic_mohdayaa@quicinc.com>
> > > Signed-off-by: Mohd Ayaan Anwar <quic_mohdayaa@quicinc.com>
> > > Co-developed-by: Arun Khannna <quic_arkhanna@quicinc.com>
> > > Signed-off-by: Arun Khannna <quic_arkhanna@quicinc.com>
> > > Co-developed-by: Monish Chunara <quic_mchunara@quicinc.com>
> > > Signed-off-by: Monish Chunara <quic_mchunara@quicinc.com>
> > > Co-developed-by: Vikash Garodia <quic_vgarodia@quicinc.com>
> > > Signed-off-by: Vikash Garodia <quic_vgarodia@quicinc.com>
> > > Co-developed-by: Swati Agarwal <swati.agarwal@oss.qualcomm.com>
> > > Signed-off-by: Swati Agarwal <swati.agarwal@oss.qualcomm.com>
> > > Signed-off-by: Umang Chheda <umang.chheda@oss.qualcomm.com>
> > > ---
> > >  arch/arm64/boot/dts/qcom/Makefile       |   1 +
> > >  arch/arm64/boot/dts/qcom/monaco-evk.dts | 463 ++++++++++++++++++++++++
> > >  2 files changed, 464 insertions(+)
> > >  create mode 100644 arch/arm64/boot/dts/qcom/monaco-evk.dts
> > >
> >
> > --
> > With best wishes
> > Dmitry

-- 
With best wishes
Dmitry

