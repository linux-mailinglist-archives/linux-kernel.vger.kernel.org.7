Return-Path: <linux-kernel+bounces-799094-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C0431B426EB
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 18:28:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 19AB97A78AE
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 16:27:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84FB22F5305;
	Wed,  3 Sep 2025 16:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="BrtsH0fi"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A55272E5429
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 16:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756916925; cv=none; b=B2Ok/EoWXCBBstzet61ZqcUv5tOsx3MGMmjTHh7Sv+7cYLu6bDcSA9Sb41G03LA3+Mqnt5v6ni5Q0EwB6pd8GCyUOMxTmGvNKJlzN0MOjvwEtbNlmhkq/d540fSNTo1FaElPue5WC6OfDjcr9CTiovlmhjEueAda0jMfaIhEQWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756916925; c=relaxed/simple;
	bh=h4uzpxwbZv5GjsKYDvvfHvKOFpa5oECNqTN6Yy9bj4g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gXqmWUZoamIDLoyzFxkhGknYLh0ejQr5U1znavmG7iuD0OmuDO47F3eFNnndIpvPf3ha1zlTLnfkoID2WdWz1ubscjTD2ro7Z0JPPP5INhid3xxZgNcjIp0gu2+ljftLjuH3fSzyXuXJyRdRY4Jx3g9BolpGp9KTC/IcvPUtzkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BrtsH0fi; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 583DwuHH005265
	for <linux-kernel@vger.kernel.org>; Wed, 3 Sep 2025 16:28:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	3W8v279knRH3OWhUMa8czqjX5zZ7UZx/tVNRcDruII4=; b=BrtsH0fiD+ApJV97
	Y0r9qpTkipdek14wqYg/qYx6vUcKC5WywT42WJk+qpFhicqfMW0Y953Ef1q8HRtR
	3XUl31g0QSVQDhyUNDwOg5IEN4A5+JfyL6cqV8MYQQCsbWtXYEeqtWCbo+GbldCq
	FMpRJ5ISzRilwhIo6oBI1IyaWHYhqd+7YxC0pzCm+w37ldRAbgEK0ej6Bxw9d2lv
	1eW/FOyx7Lr6LamPW/hK3uH1vcUBcFWk0pT3HtSVBnoKqELJPgLJihXSsopen1cg
	lLsOzVMyEvFI+vf5kZe0dN/cbkmP2fBxMkmK+EJqj0jdQ9krQW7iqAqtHqw3OvOL
	2sKAfg==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48urmjmbqs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 16:28:41 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-76e6e71f7c6so99538b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 09:28:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756916920; x=1757521720;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3W8v279knRH3OWhUMa8czqjX5zZ7UZx/tVNRcDruII4=;
        b=Fp6T3m/hehq2cDxO9XO2GqK5VrlNzieahrEdnJzK+1hsajN1np5mKaMALYGfOXaLxD
         7/jg9Lp+K5BypZxboAbc0lsMh3jh6Qhg8Te5Vqh9e1kkQkbe5FTkrKumDHHRbYI52vAj
         97Dra5zYGA9qFgHBXExkvayOSmo5ABRH6bdlITU+3cN6Fm41SK65RyKrpwa2l6QKLrmV
         pmuVKZ8RrCcux7WyGpBGRji/zkyAxxOUrAs6gYC0slFPoxz/26f7llsb4DzI4Opapwd1
         Dj9ja4A8GwuRi+2mTfJfi9F/6dleroUqHin68e1TeuvZco4JGvwP41y54hMoT5oV9UpT
         F1cA==
X-Forwarded-Encrypted: i=1; AJvYcCWjgPhxWza32mDpBDMxpZCfkS0V1makVTH92tkZPclF7YZdH32nPX25DsiFrYZGyz3UMDAoc6FkqwsPh9g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4sZG4rLiUDRy3IlR8U9FVkiC1Ojais7zyUNr/Kmr1yx8yIzMw
	bumso+kMeYYH+Xjz1Gk6H2HP2VW1t3GhuFRIMl8xmdpXK5T3hCMBqvLggofaejdET9A3agcEVAB
	YXXq78sF4L6h+56ocUmk4TuKTnpScL7fd3CC9exSjZT5lBaMacYJNUVObvaX7xq7/Vag=
X-Gm-Gg: ASbGncs7Hkl8DGZJW+FsZUokyMN4MMG66WvhfOEYoq4Bu+wyJ2WqrtmxmMDzgM/ZA+J
	X/9WW2mx+w2NBE90GFcV1fyR4T799N83Iao8qRuOBpCYkZ+OXW2AN42pTIqwF081BitWgkP6mud
	8LnVBk7TDkJd3GU+78/o1goNNqSMsAr5iHLwL1UW3f28exDWSfy0DifFYgnfWyqU0G5p7RQhR5y
	tpsmEiOebRG50xrBjq9OBi7KKGok7rbwPviCFI5ZyYmTWHnSdlJnAJJPwrEttiuirboi9PU0Fth
	veUAx7DlAe/DcpA0qXNS9ab4uHyF2yel9bOXC6f3fyG9iTh9prp5jZvH+te2t8aT3jiL
X-Received: by 2002:a05:6a00:2314:b0:772:bb4:a1c8 with SMTP id d2e1a72fcca58-7723e387c08mr16394827b3a.23.1756916920260;
        Wed, 03 Sep 2025 09:28:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFxMR7hBz3AXIbxT3k+26DZmNA55+biuruOPc4EMsmI//RROhDkSqh0Pri4+DqMIllJh0FwlQ==
X-Received: by 2002:a05:6a00:2314:b0:772:bb4:a1c8 with SMTP id d2e1a72fcca58-7723e387c08mr16394797b3a.23.1756916919720;
        Wed, 03 Sep 2025 09:28:39 -0700 (PDT)
Received: from hu-wasimn-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7725ad1e086sm9459942b3a.20.2025.09.03.09.28.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 09:28:39 -0700 (PDT)
Date: Wed, 3 Sep 2025 21:58:33 +0530
From: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>, kernel@oss.qualcomm.com,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        netdev@vger.kernel.org, Monish Chunara <quic_mchunara@quicinc.com>
Subject: Re: [PATCH 2/5] arm64: dts: qcom: lemans: Add SDHC controller and
 SDC pin configuration
Message-ID: <aLhssUQa7tvUfu2j@hu-wasimn-hyd.qualcomm.com>
References: <20250826-lemans-evk-bu-v1-0-08016e0d3ce5@oss.qualcomm.com>
 <20250826-lemans-evk-bu-v1-2-08016e0d3ce5@oss.qualcomm.com>
 <rxd4js6hb5ccejge2i2fp2syqlzdghqs75hb5ufqrhvpwubjyz@zwumzc7wphjx>
 <c82d44af-d107-4e84-b5ae-eeb624bc03af@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c82d44af-d107-4e84-b5ae-eeb624bc03af@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=OemYDgTY c=1 sm=1 tr=0 ts=68b86cb9 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=Jh9KyP6SycQYY5kWdYcA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=OpyuDcXvxspvyRM73sMx:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: Qz-7QZrcPMLlK0hAdjMD1LSR9KLs3zXB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAyNCBTYWx0ZWRfX6X6jk1a5SXO+
 JSZPlYfUVPrYVMzkxOgnE1B1vOo+LpDeGHW1ryEr0X0LmMCakeF9upwKVjJuFKxmL806+lAbB/n
 cIiFhtlMIl6xS8AghBCzqpfO32cjtW39CRJAkfD9k1z8YUmaBIaLkxKiigLJtnUPdQC2280tK4/
 d6Ywa+gsQd140Iv7D9sGrk3eWemu9z96NLvApTxgq1qbd4kKrq1odwuB+qUf2oC/0CLUCqZP9gJ
 rML0VLfDo3VCZ/WfIENaYOGBFBzlMYP/sdlk6JrrGU1DpVektelSlc1SkDKz7GmXQLasn55PyF+
 A7sbWBM8mLkfFVySrZreuk1JpWx4HIXlhOMvoZmwdvYB2X0WmyuVnjMk6dX3ExldEEZsUjoJgc+
 jOdkOrRD
X-Proofpoint-ORIG-GUID: Qz-7QZrcPMLlK0hAdjMD1LSR9KLs3zXB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-03_08,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 spamscore=0 bulkscore=0 priorityscore=1501
 adultscore=0 clxscore=1015 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508300024

On Wed, Sep 03, 2025 at 06:12:59PM +0200, Konrad Dybcio wrote:
> On 8/27/25 3:20 AM, Dmitry Baryshkov wrote:
> > On Tue, Aug 26, 2025 at 11:51:01PM +0530, Wasim Nazir wrote:
> >> From: Monish Chunara <quic_mchunara@quicinc.com>
> >>
> >> Introduce the SDHC v5 controller node for the Lemans platform.
> >> This controller supports either eMMC or SD-card, but only one
> >> can be active at a time. SD-card is the preferred configuration
> >> on Lemans targets, so describe this controller.
> >>
> >> Define the SDC interface pins including clk, cmd, and data lines
> >> to enable proper communication with the SDHC controller.
> >>
> >> Signed-off-by: Monish Chunara <quic_mchunara@quicinc.com>
> >> Co-developed-by: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
> >> Signed-off-by: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
> >> ---
> >>  arch/arm64/boot/dts/qcom/lemans.dtsi | 70 ++++++++++++++++++++++++++++++++++++
> >>  1 file changed, 70 insertions(+)
> >>
> >> diff --git a/arch/arm64/boot/dts/qcom/lemans.dtsi b/arch/arm64/boot/dts/qcom/lemans.dtsi
> >> index 99a566b42ef2..a5a3cdba47f3 100644
> >> --- a/arch/arm64/boot/dts/qcom/lemans.dtsi
> >> +++ b/arch/arm64/boot/dts/qcom/lemans.dtsi
> >> @@ -3834,6 +3834,36 @@ apss_tpdm2_out: endpoint {
> >>  			};
> >>  		};
> >>  
> >> +		sdhc: mmc@87c4000 {
> >> +			compatible = "qcom,sa8775p-sdhci", "qcom,sdhci-msm-v5";
> >> +			reg = <0x0 0x087c4000 0x0 0x1000>;
> >> +
> >> +			interrupts = <GIC_SPI 383 IRQ_TYPE_LEVEL_HIGH>,
> >> +				     <GIC_SPI 521 IRQ_TYPE_LEVEL_HIGH>;
> >> +			interrupt-names = "hc_irq", "pwr_irq";
> >> +
> >> +			clocks = <&gcc GCC_SDCC1_AHB_CLK>,
> >> +				 <&gcc GCC_SDCC1_APPS_CLK>;
> >> +			clock-names = "iface", "core";
> >> +
> >> +			interconnects = <&aggre1_noc MASTER_SDC 0 &mc_virt SLAVE_EBI1 0>,
> >> +					<&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_SDC1 0>;
> >> +			interconnect-names = "sdhc-ddr", "cpu-sdhc";
> >> +
> >> +			iommus = <&apps_smmu 0x0 0x0>;
> >> +			dma-coherent;
> >> +
> >> +			resets = <&gcc GCC_SDCC1_BCR>;
> >> +
> >> +			no-sdio;
> >> +			no-mmc;
> >> +			bus-width = <4>;
> > 
> > This is the board configuration, it should be defined in the EVK DTS.
> 
> Unless the controller is actually incapable of doing non-SDCards
> 
> But from the limited information I can find, this one should be able
> to do both
> 

It’s doable, but the bus width differs when this controller is used for
eMMC, which is supported on the Mezz board. So, it’s cleaner to define
only what’s needed for each specific usecase on the board.

-- 
Regards,
Wasim

