Return-Path: <linux-kernel+bounces-764604-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83082B224FE
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 12:54:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6CC0C3A6CBE
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 10:52:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EED22ECD00;
	Tue, 12 Aug 2025 10:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="paES9/v9"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04F4E2E7641
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 10:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754995935; cv=none; b=GQjnek+ue6RmxereGhSiSg2XvAl9QkkxXMImNrbpTf0UQxkyOMR5xyrH9NKZ7N+YyklsiTW85+uYEKBcN719yDkASqOEKxc2eiNzsqYnuUUUTx2OlLxvko8FbexKmQA6Cokw8aQXRL54FuI35a5o2BlAuTbXMnjdoILZE9CTCkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754995935; c=relaxed/simple;
	bh=t55+OxdOQK9kjz+pTTcn9wYdyzdpqs/wBpTLxjWl0CU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a5NFZVj0EFQvdA22R/B3nLqY48uyCiakGSTHg1UXc9x1PrR1PoByBN4eoMGcmm2vgpjq6sAI/0a1Kqmo7QiuYi/tU0LNKwm+9TgBjkls7JSwTZVuMJOPTYM+ti3fzDlZ9Q+h4plI+BFMqwxEzMhoKDSard/NlSAec1ItuGer5VA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=paES9/v9; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57C5Ymnq021869
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 10:52:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	vrdvUYMsLFxF4FLJgur6KfN0+EY7My8qqgb8/nvdTZw=; b=paES9/v9Axp0Fr/x
	zuwKhKq3pHhID3usJyNQPSTEC+WRcV8MSPEOu66bbL5Akz6I5cuH1W6KexdeVh8i
	uVzAX4k2pU6Cejx60ZGURljlynPQV/+3WbecmbiidlEd8GbATgek3mqUQfaewrDJ
	4qs4SSVuMtc1WyoJSMtE08sHr1+FMkLhTKaqNW57oUIo5K/Ayjm+4iKieBQcwVre
	VFekmWyceUGnt0S+h0UtjA6IyWCjiaiaPK790rLjhaBAgo/3Jgsr9/VsmWL65Suk
	TrXlsI0GBP3J+BpMs9KS1Db/nzhmdPga+rXSX52vlEeWzg4cmK/jQrLNBmbNzAwu
	IatRLw==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48dxj47tj1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 10:52:13 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7e84d132874so566626185a.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 03:52:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754995931; x=1755600731;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vrdvUYMsLFxF4FLJgur6KfN0+EY7My8qqgb8/nvdTZw=;
        b=VUvyyd8ujNEimWyCM+TVvFTl/sWOP3PRoti2cZoxclULdPhabKfSmNXnQZvMaIsDxN
         v/Ho07Gd2bSz9KKkWp5xUpfe9SRShkKCahViskg0sEVf7lMXw1umtunKz0NrMpgMPh04
         mFBTnjw0vUb3XbPy/fN/ujLqVi6oJzCn6uBy9CDgmk/RtfQWyOcDCmFXRU9myveDYmB0
         hQoTo/mBSVnq/jblCw9PvTvKRZcviXJh5I+PlS0QJ4OOgNSSEs5KhjDGubyhhSrG5ztu
         skiYXdbsdC4FrcPsAO56rhdBYPCJ9rvlajyinJA8GVRvdYmM7aQl5U1MhW4U53SbICTu
         TPtw==
X-Forwarded-Encrypted: i=1; AJvYcCUlWvFXpQUPh2TfwMOAGF/qo7kXTI7XQBm0e9CTLc8f81HxaYyuSdH6xKbLOu7mXh+d76/V/0Bxl/zEIC4=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywc0Nc3MaljIQ4pHw6LDeP5jSxamLFmPaWda1avQG2aYfTnnwZM
	OzuzCYxlflxHxkBLcxl4LAtMvnnYbH7CO3+JOxVGAtB/FMiQ2nHbY+J1OM3/HvePG2SFIxxQCRQ
	9ZBFbwP7DQS4vHEGFhDV3YRm+Ci6I0EgvnXKwcdvR5Rs/wHd5AE0na7z6vglDpCZ1YeU=
X-Gm-Gg: ASbGncsfUp9GHGmYFwY42oB6ZzsYpSEfZ1SxjAqpRbxmcchdLJiYHjX3Wo0eKkVYGh2
	D8V439rePLtlsf+CtAWXX+PXHOGzw9eDad9LC7w+9ju78spPaNq6ENVLn4xxYPqACrjsaC1OK0J
	PANMmYVSeDbDsvswaHNx712IKJFhecpoQLhON4PcDjmvKmRZoHb+WBoUxdEsmX4Lkar5UQueZ1m
	wGDbYaZhohQiQN53sUKEcn6zjgbllJZ+0JmUJBRyXTB4th7uJyvEckNx1UdJJ0KT3PgvmGUOYxs
	LNXJuH3mHV9UnnNF1s+TBNyGyPON84WtcVWfRNVRukB71kc+vlejMtwl+WIqATqPKUb33zKOjXq
	uV4sVRTpyoaR4+DJjbHbYpBwwlL6Bk6iUh7PhX47bl27azxOnuUEz
X-Received: by 2002:ad4:5bac:0:b0:6fa:c408:5a3b with SMTP id 6a1803df08f44-709d5c6f1b7mr40015126d6.9.1754995931437;
        Tue, 12 Aug 2025 03:52:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF/dJcvVsnI5zs8AmyFySKz8aEKAGU74Spts/yY1T3s2IF+LNgVa3AfWWzCvKg31q62eogSGA==
X-Received: by 2002:ad4:5bac:0:b0:6fa:c408:5a3b with SMTP id 6a1803df08f44-709d5c6f1b7mr40014856d6.9.1754995930903;
        Tue, 12 Aug 2025 03:52:10 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-33238272944sm42016811fa.13.2025.08.12.03.52.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 03:52:10 -0700 (PDT)
Date: Tue, 12 Aug 2025 13:52:08 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Nitin Rawat <quic_nitirawa@quicinc.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, vkoul@kernel.org,
        kishon@kernel.org, conor+dt@kernel.org, bvanassche@acm.org,
        andersson@kernel.org, neil.armstrong@linaro.org,
        konradybcio@kernel.org, krzk+dt@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH V1 2/4] arm64: dts: qcom: sm8750: add max-microamp for
 UFS PHY and PLL supplies
Message-ID: <ljythvl2yfilcnmgdwt2cyyefxmgl54osll5e76qn7njadhgqq@rwrl3dy6ykt3>
References: <20250806154340.20122-1-quic_nitirawa@quicinc.com>
 <20250806154340.20122-3-quic_nitirawa@quicinc.com>
 <20250808-calm-boa-of-swiftness-a4a7ce@kuoka>
 <9af71063-0629-4ccc-bc76-3fb588677bf4@oss.qualcomm.com>
 <292907f3-25d6-40d9-be6e-b6b83e646d73@kernel.org>
 <5e32be05-0dbd-4d6f-879d-8ce97fb430ba@quicinc.com>
 <rh3qxu2rijpjswfash3rpmmh6sw47l3b6j5p5upti6zffknasz@cywwm3fypghd>
 <89ab7e51-f82e-465a-aa22-1ccb8e7a0f6d@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <89ab7e51-f82e-465a-aa22-1ccb8e7a0f6d@quicinc.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA5MDAyNyBTYWx0ZWRfXzGoKaWL9hkZJ
 uCDWyOmcpXM+n+j0hb1DFusrWRH5N+WiCKUNQ3KC5XbngDjKJ35SVtTZ1Z/jAYIRITXlqDSNQPQ
 n39ydVnta8kPvDbegBGzk2xZ6qQp6YedGOlD7JJrsoLPKz2wKHIx3HR3VaE8WV1EIMbsM39deh9
 iLlKFD0HAFkjt/XL9KpTNQMTUnChp1f+PFfpSMFSgYFNs1Z46QVTOytp5lO6q10MKNMObI66IVw
 7Rb4Sti0ZDugVmJte50kvBd9vptCJiddirJZMvj79dn+hOzzySjJ9cDng43K/+PF8K/vyiDubn3
 owjMW9phPy1aR14wLUm5a6gMMaYnt9eySfpx24Iz+WW5hx7TEZxdy331GJi9THpNixbHoFgN8n4
 soq1MWFG
X-Authority-Analysis: v=2.4 cv=fvDcZE4f c=1 sm=1 tr=0 ts=689b1cdd cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=7T__WHWB9XTw_rtxigEA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-ORIG-GUID: L25cOo-ANoaZCbNMGsMsMqEPRHNJxYJR
X-Proofpoint-GUID: L25cOo-ANoaZCbNMGsMsMqEPRHNJxYJR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-12_05,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 priorityscore=1501 spamscore=0 suspectscore=0
 clxscore=1015 phishscore=0 bulkscore=0 impostorscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508090027

On Tue, Aug 12, 2025 at 01:25:02AM +0530, Nitin Rawat wrote:
> 
> 
> On 8/9/2025 4:37 PM, Manivannan Sadhasivam wrote:
> > On Fri, Aug 08, 2025 at 08:49:45PM GMT, Nitin Rawat wrote:
> > > 
> > > 
> > > On 8/8/2025 3:09 PM, Krzysztof Kozlowski wrote:
> > > > On 08/08/2025 10:58, Konrad Dybcio wrote:
> > > > > On 8/8/25 9:29 AM, Krzysztof Kozlowski wrote:
> > > > > > On Wed, Aug 06, 2025 at 09:13:38PM +0530, Nitin Rawat wrote:
> > > > > > > Add `vdda-phy-max-microamp` and `vdda-pll-max-microamp` properties to
> > > > > > > the UFS PHY node in the device tree.
> > > > > > > 
> > > > > > > These properties define the maximum current (in microamps) expected
> > > > > > > from the PHY and PLL regulators. This allows the PHY driver to
> > > > > > > configure regulator load accurately and ensure proper regulator
> > > > > > > mode based on load requirements.
> > > > > > 
> > > > > > That's not the property of phy, but regulator.
> > > > > > 
> > > > > > Also reasoning is here incomplete - you just post downstream code. :/
> > > > > 
> > > > > The reason for this change is good, but perhaps not explained clearly
> > > > > 
> > > > > All of these values refer to the maximum current draw that needs to be
> > > > > allocated on a shared voltage supply for this peripheral (because the
> > > > 
> > > > 
> > > > It sounds very different than how much it can be drawn. How much can be
> > > > drawn is the property of the regulator. The regulator knows how much
> > > > current it can support.
> > > 
> > > Consumers are aware of their dynamic load requirements, which can vary at
> > > runtime—this awareness is not reciprocal. The power grid is designed based
> > > on the collective load requirements of all clients sharing the same power
> > > rail.
> > > 
> > > Since regulators can operate in multiple modes for power optimization, each
> > > consumer is expected to vote for its runtime power needs. These votes help
> > > the regulator framework maintain the regulator in the appropriate mode,
> > > ensuring stable and efficient operation across all clients.
> > > 
> > > 
> > > Stability issues can arise if each consumer does not vote for its own load
> > > requirement.
> > > For example, consider a scenario where a single regulator is shared by two
> > > consumers.
> > > 
> > > If the first client requests low-power mode by voting for zero or a minimal
> > > load to regulator framework during its driver's LPM sequence, and the second
> > > client (e.g., UFS PHY) has not voted for its own load requirement through
> > > the regulator framework, the regulator may transition to low-power mode.
> > > This can lead to issues for the second client, which expects a higher power
> > > state to operate correctly.
> > > 
> > 
> > I think we all agree on consumers setting the load for shared regulators, but
> > the naming and description of the DT property is what causing confusion here.
> > There is no way the consumers can set the *max* current draw for a shared
> > regulator. They can only request load as per their requirement. But the max
> > current draw is a regulator constraint.
> 
> To avoid confusion with regulator-level constraints, I'm open to renaming
> the property vdda-phy-max-microamp to something more descriptive, such as
> vdda-phy-client-peak-load-microamp or vdda-phy-peak-load-microamp. Along
> with updating the description, this would better reflect the property's
> actual intent: to specify the maximum current a client may draw during peak
> operation, rather than implying it defines the regulator’s maximum
> capability.

Move them into the driver please.

> 
> 
> Having said that, I had a follow-up discussion with the PHY designer to
> confirm whether this value could vary at the board level. Based on their
> response, it's a fixed value for the SoC and does not change across
> different boards(atleast for now). Therefore, I can remove from device tree
> and replaced with hardcoded, per-compatible data in the driver.
> 
> > 
> > > 
> > > > 
> > > > 
> > > > > supply's capabilities change depending on the maximum potential load
> > > > > at any given time, which the regulator driver must be aware of)
> > > > > 
> > > > > This is a property of a regulator *consumer*, i.e. if we had a chain
> > > > > of LEDs hanging off of this supply, we'd need to specify NUM_LEDS *
> > > > > MAX_CURR under the "led chain" device, to make sure that if the
> > > > > aggregated current requirements go over a certain threshold (which is
> > > > > unknown to Linux and hidden in RPMh fw), the regulator can be
> > > > > reconfigured to allow for a higher current draw (likely at some
> > > > > downgrade to efficiency)
> > > > 
> > > > 
> > > > The problem is that rationale is downstream. Instead I want to see some
> > > > reason: e.g. datasheets, spec, type of UFS device (that was the argument
> > > > in the driver patch discussion).
> > > 
> > > 
> > > The PHY load requirements for consumers such as UFS, USB, PCIe are defined
> > > by Qualcomm’s PHY IP and are well-documented in Qualcomm’s datasheets and
> > > power grid documentation. These values can depending on the process or
> > > technology node, board design, and even the chip foundry used.
> > > 
> > > As a result, the load values can differ across SoCs or may be even
> > > board(unlikely though) due to variations in any of these parameters.
> > > 
> > 
> > Okay. This goes into the commit message and possibly some part of it to property
> > description also.
> 
> 
> 
> 
> > 
> > - Mani
> > 
> 

-- 
With best wishes
Dmitry

