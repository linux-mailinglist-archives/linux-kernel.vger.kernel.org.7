Return-Path: <linux-kernel+bounces-798340-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 80C2DB41C91
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 13:04:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 47A927ABE5A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 11:02:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F53F2F4A0A;
	Wed,  3 Sep 2025 11:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="UkA9kHsU"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC1032F3C09
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 11:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756897431; cv=none; b=mwSaBGKbolQd2Bw3oavCS8Mr7pPd4lmjBnmrVS+D0JIS55sfss70N2vKYM4Uxm/PzYev/pH0O1ONh6dSUY9XHcz7cn1VvB3djW6ExFVajReZZ1KDiI/nEc3KKPyASFwkkiagXAS6HpIu09vTHm7XNqcRNmdL6wxYE1KG7ofDMKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756897431; c=relaxed/simple;
	bh=e3kvP4gdtHKiyeq6Finn3R34MTwK60sAoTGCUeSBPwM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IYMuKaOsxjcKMLVuqg0GvxHDvfKv2R1bKxyUjhbsLZXF+4AoK7qvRtyNSy684l3Tlbe5fksriRLhEMw5tlnuUzkpkKc7cNRm/IwsHow428qTqoM+UevSsukJf2IBXsHnDFX4vepy7O5Z1fKjIeew9jQM56iFujU1hbrPZX4xJIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=UkA9kHsU; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 583AQLMo020050
	for <linux-kernel@vger.kernel.org>; Wed, 3 Sep 2025 11:03:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	aWkbYNfRZoXmhvAvUwbU9hVkBMShIQECRKoeyXEKUmI=; b=UkA9kHsUizEZ6BVg
	ucsNJ0iEwynVFRjgxRkxc7L0EfeoM4SJWpRaS5lE4im9NDKbIv2IByd44G39bXdC
	ctgCqk8jQzE0IKvp0tiLX4fy66pcKC6nnZN0TiaRtxKzvs6lXa9zCPaNLjqGgGKZ
	0kyy1zxrsUxl4mx/lHOIDv9W1HsiG+eUB/k/fuE93s68BTCShjb2xviE9H8i1fUt
	kuf6anquzhlZMCKtK2NgBjvEFcjCvkqfYJCUeFyFNzHiIXXDoflQ2/PWmGkNytMR
	SEwSJpDcuBK6Qx7aYa3aRf9czE9Jq1tpVC1KDTByTzgw7X4CGr3iTmfPaqOXjzy+
	cdrtyA==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48urw03ek0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 11:03:48 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-72048b6e864so19311976d6.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 04:03:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756897428; x=1757502228;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aWkbYNfRZoXmhvAvUwbU9hVkBMShIQECRKoeyXEKUmI=;
        b=LYC044X7qkporUiS8JmiFgSMS8wG3+1nPEfg1hFkVzX4+fDfEqcpQV3GuZMJyfL1jt
         tFS58bs4loUDPMiOlHT4jNsGHrIHzPuneFIopL+39oKRqDsqttzyk5C3ji2xPb9IgUM6
         VTz3pBnTQJ3tTmnqx90IidHmtc7O5ZvLCujPPXr/PrVOPTYWN7WAsOHa4geq9O6khOuY
         g2EYZkFXwMqmUiM+k95DvrVx+/D+mpFXZIRQCg6W26nGtrqKJC2JwFjMVyLDLro0JKQs
         Jby3JK5Us0e09f5AALynIZPaQzhD2mFd+YVvtsWlvUh/b5uBCAkzyCes4zKNKYb9DLCo
         ftYQ==
X-Forwarded-Encrypted: i=1; AJvYcCU//C3dBa7ukvPmxIfPNLBSJOmPC45sv/HuF9OUrGEz8OFC+JYinLGz8tYowGKaD8FFzjB8PHuD64UF/NA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxuMU+pW3zqMbysNM/AL8D24Wgp+BQ/Z2Ft46CQPgu4IvpRWRvO
	8ZtwqZDWYT0LB3XaZdm7fpo/g916mbHPPEMCbg/MwzKKvtAgUiFSB84klqyB4WRcfoPR14KoEcr
	oC9zrPffUCvaQgMPvwy0kqSIBYKkj4U2wTKEcdN5t+XcD81R+xKF5Q9MmJZx3GHUqHjw=
X-Gm-Gg: ASbGncvBooFQRBYRxklBqpu0lcNbUqu46DGSjXZuJtmgt60+ioqB7uaYk9dYMGOp6km
	8FX4RDtNpPwmvlpnKRXOloJxw0zn7ad0ZdUsj6xpxRuUjNo4Lh9Nz33aoj21w+RtL1Cl/vdpWRO
	4WyvAf5nUDk0+zdXDJaF4S0q2GqktoqchOKpkMy30jAFv4h8/qyYlM8jEHVSLUdg61qiNRsa0KU
	DUejHBDsGCntCpTRx30+NU7Naalh7c6F39vCC9mo0pPt8aANlIokuS68C61YePBeKbXAA/lustX
	OCZ/Uvn1lqAKTGHjBThct7CxqP0bCtsiBROS6VFH3V7lBekNwWw1uQnxI6DRIOvdL5p7cBtfLhj
	y/3BZ99jaUjFJV6nBiA297hd6sikliNx5wqRNqFsxx/Mhiy+47RPm
X-Received: by 2002:a05:6214:5281:b0:71a:ccf0:7201 with SMTP id 6a1803df08f44-71accf07438mr104249746d6.38.1756897427639;
        Wed, 03 Sep 2025 04:03:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHRXBlO/ViruyIDsyGwPbK7fDiqcvgmS/bmjq2OzaOcbs3BncKqSX1fHhqPQuIsQopHv2mdzQ==
X-Received: by 2002:a05:6214:5281:b0:71a:ccf0:7201 with SMTP id 6a1803df08f44-71accf07438mr104248966d6.38.1756897426985;
        Wed, 03 Sep 2025 04:03:46 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5608ad4e680sm436636e87.150.2025.09.03.04.03.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 04:03:46 -0700 (PDT)
Date: Wed, 3 Sep 2025 14:03:44 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Vikash Garodia <quic_vgarodia@quicinc.com>
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
        Swati Agarwal <swati.agarwal@oss.qualcomm.com>
Subject: Re: [PATCH v3 2/2] arm64: dts: qcom: Add Monaco EVK initial board
 support
Message-ID: <j3kuygqqymh5pbujdum4tc275fbd5xrhejry4c5spuivxloon4@zrqfuqtydvyf>
References: <20250826181506.3698370-1-umang.chheda@oss.qualcomm.com>
 <20250826181506.3698370-3-umang.chheda@oss.qualcomm.com>
 <ao3nb3xkeutqetqx7amlfbqtvhuyojfvzm4prsze2mhgb2rpnc@s2bsigcrlxzo>
 <26faedb2-63ca-e2e0-aad6-49575a8c49bf@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <26faedb2-63ca-e2e0-aad6-49575a8c49bf@quicinc.com>
X-Proofpoint-GUID: I8Z2NXtFAihehNX6S3phj1V_qe_HxNyb
X-Proofpoint-ORIG-GUID: I8Z2NXtFAihehNX6S3phj1V_qe_HxNyb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAyNyBTYWx0ZWRfXyAb+sLKlVE+f
 vMs+ymTAr+NooTeT+l4+osSFB3z8gJyga9GwGwzyThn6Fbz4wE/cN07gi9t2EnXDxnwS9noGgqS
 R5ofikZfB2FfKWE/yb+2q0j4pQQMNdnywvSuwumBFc43JvTQoZoGilNGq90aYm0OW39lBZTF7cG
 fT809SqekU4UUZ+R5uBpdXtxNKJGIWOqbBuB+nPRp6q7FfrgI8+q9e07r3OWDa+elJmnOjtFUoY
 R2RM3WAn3ouGH3gAfRRcdLoUgrorwCjr//15apxnFyTFMfVJW0fn2IHGF/qr9Y/VAXg8YZiqW8V
 WOimf0qjvNuOZpxJ3MgMeKDnhHRRURZYkqmmFNUOfXz+o2pRl2u9sYFyXAfZ2BJK/xTTRtrQaXk
 JYHlRAeA
X-Authority-Analysis: v=2.4 cv=NrDRc9dJ c=1 sm=1 tr=0 ts=68b82094 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=yJojWOMRYYMA:10 a=3BAVvXf_q9qCSfg946IA:9 a=3ZKOabzyN94A:10
 a=wPNLvfGTeEIA:10 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-03_06,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 malwarescore=0 priorityscore=1501 phishscore=0
 impostorscore=0 spamscore=0 bulkscore=0 adultscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508300027

On Wed, Sep 03, 2025 at 03:35:54PM +0530, Vikash Garodia wrote:
> 
> On 8/27/2025 7:12 AM, Dmitry Baryshkov wrote:
> > On Tue, Aug 26, 2025 at 11:45:06PM +0530, Umang Chheda wrote:
> >> Add initial device tree support for Monaco EVK board, based on
> >> Qualcomm's QCS8300 SoC.
> >>
> >> Monaco EVK is single board supporting these peripherals:
> >>   - Storage: 1 � 128 GB UFS, micro-SD card, EEPROMs for MACs,
> >>     and eMMC.
> >>   - Audio/Video, Camera & Display ports.
> >>   - Connectivity: RJ45 2.5GbE, WLAN/Bluetooth, CAN/CAN-FD.
> >>   - PCIe ports.
> >>   - USB & UART ports.
> >>
> >> On top of Monaco EVK board additional mezzanine boards can be
> >> stacked in future.
> >>
> >> Add support for the following components :
> >>   - GPI (Generic Peripheral Interface) and QUPv3-0/1
> >>     controllers to facilitate DMA and peripheral communication.
> >>   - TCA9534 I/O expander via I2C to provide 8 additional GPIO
> >>     lines for extended I/O functionality.
> >>   - USB1 controller in device mode to support USB peripheral
> >>     operations.
> > 
> > Is it actually peripheral-only?
> > 
> >>   - Remoteproc subsystems for supported DSPs such as Audio DSP,
> >>     Compute DSP and Generic DSP, along with their corresponding
> >>     firmware.
> >>   - Configure nvmem-layout on the I2C EEPROM to store data for Ethernet
> >>     and other consumers.
> >>   - QCA8081 2.5G Ethernet PHY on port-0 and expose the
> >>     Ethernet MAC address via nvmem for network configuration.
> >>     It depends on CONFIG_QCA808X_PHY to use QCA8081 PHY.
> >>   - Support for the Iris video decoder, including the required
> >>     firmware, to enable video decoding capabilities.
> > 
> > I don't see firmware being declared here.
> 
> It would pick the default firmware from driver monaco platform data.

Yes, but the commit message says something different.

-- 
With best wishes
Dmitry

