Return-Path: <linux-kernel+bounces-736807-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47817B0A30E
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 13:47:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 92D957A7EA6
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 11:45:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86173221297;
	Fri, 18 Jul 2025 11:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="PvyQsUsb"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E2481DED49
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 11:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752839228; cv=none; b=Y5y85+ab1DejTTJu8Psl0SQGwQjVWVW4pudR8OEdIfQwY7wOvX0dPEuLkzAnsbwCrHNtFMsbBYHUgdA2o5Hdxm5BagnfQcU+ugo7VGPjVS81nbEzzx5ZZzXIXikbMTTiqI6OigvyUinJ/QQ5Sumqi8YeCHnLpT/3VNyeG7ybHq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752839228; c=relaxed/simple;
	bh=ytkcnLwqiafPf/jGRtT7S0382mzgavn9/7lB3ddQiNM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lPtD7UZnsxhxn6HckMLRxg+0OEn6rpwycU2/+itQx4dB4TmMCccP5Jk2tqllmNN0/0MNAxz7DADA9rCNe9KGlT8u86Sugj1JCMQbmPtVo3TigeGGLk7L0OkHSg+vbhYKN0viOd0k21f0IDWFYmkM/eIpSAo5SQWYyfblPO/6+T8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PvyQsUsb; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56I8tvi3021699
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 11:47:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=esD0BgiWEWaYJCdGXCJIJorS
	TkPDE9pqdzuFw4kpSBU=; b=PvyQsUsbuyHkGWf/T7KjP7sJx9J/bysQi5Oz0U8x
	gf3ssH10xYtGOZshAZ3AUrVXJwwoARElKaPXb7SdTzv4wIRNgkiJiFEvYO4kVGQ3
	Nx6xOjw42W7pYJZ8BSYKpgX+sFVt/TXloMQ5rDnAscdKkhkTzxs+r3Z0WSiHkUrl
	+oBXnBScM2Jh2130W1vY2qcivnlgnIjpItqhCtQ1xtVRYzDquA20z17X22j9jCEa
	MrH3jnLU8JLPdvfsYcV4iS6uSd6Esf8ltRGho2NqkjYkpQFv7lx9IjVPY6uTg/Qq
	T68kr2tu3TT7LvpbWGioZFq6mkgHrs0i1DqDeArFAulpxw==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47ufu8k5mr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 11:47:05 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-3138c50d2a0so3001273a91.2
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 04:47:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752839225; x=1753444025;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=esD0BgiWEWaYJCdGXCJIJorSTkPDE9pqdzuFw4kpSBU=;
        b=HqON1OqX+AUZLijIMWLCHgh6hPLhvl5uiP+CEaFSzxKGVo2xvb7KXQuJGtOU9cPHMT
         cE/XaS7ceaPNGY8OaXr6JY3CUGOsiDwu0dxvN8o8c7AfrpCoxhx0H9vzoYaiXx2s3o1O
         w/uy0wUtgpraNY0ea1G5UPt5tFeazM+G5FucMDVMR5/P80dRXN/ujvM80gDjQlme+Osy
         6LMRogokoNjnNl8pSb43ZVrCqYg+GtBa/u09QOCdBnmtGoxFVuLwkO/vcjjRUHXc6dN4
         64CoFmxd5aAz89FgIx/R1kNslBAui+EkbpEpY4oQ2DGqPYSIuLT+hKLVGKXdOc2FnmwM
         zcnw==
X-Forwarded-Encrypted: i=1; AJvYcCXRcG+XBnNBc2qL/7x6xFTxCFdbrEfvkf+c3LP7eCy2GIZoVqLhktxWhhcgt2XrISJRrKdT1ZXHND4VLiI=@vger.kernel.org
X-Gm-Message-State: AOJu0YysZct3NMJW2aTiHMho8x2HwWNaSy+Va7sJg+TCo0g8pgSs2vIe
	LLMrAEhcBBtKWH3RgmiiNlU1pXx7VWzo0nTKgUXbDP0YkeVrTaSqbdwtVPO1HIOp9yjLTGuU7g7
	4MFPvS6EoEucIaJU8OC8e9YmyVz3hwphje8pRtT6+ZYHlqli8Qcg6Up86PI7eF0hOTClFWxAypH
	vmf3z8P2Iq4a7GNU2xYSnlMa7E9ChDZn5sSGEAtouucQ==
X-Gm-Gg: ASbGncuUVrLjt29svOK6GcVRFewuGbOA9pBjDWoxpcIxCEhpzppPJLQYSEgZDsyAFJX
	JmLZss4DdEgjwjbbn0M2xGbbMvpF1iEHHib03fmRFvcfZBv4ja9+WSBJliLJTplYd/zG4t/+++p
	1d/Q1q4a7CxL5BRPgog0e6MGvrsb7f9qUSV+A=
X-Received: by 2002:a17:90a:e70e:b0:313:279d:665c with SMTP id 98e67ed59e1d1-31caf821883mr8766062a91.7.1752839224576;
        Fri, 18 Jul 2025 04:47:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH/e2gTuOuRLymJ4eOQ4DhprwaCxsJiNfGjI9j8p3zBknk5c0ZzcCU5OhLtMQ+p3evd2nstjb8g0a74HKuWdfs=
X-Received: by 2002:a17:90a:e70e:b0:313:279d:665c with SMTP id
 98e67ed59e1d1-31caf821883mr8766034a91.7.1752839224131; Fri, 18 Jul 2025
 04:47:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250716-hamoa_initial-v1-0-f6f5d0f9a163@oss.qualcomm.com>
 <20250716-hamoa_initial-v1-4-f6f5d0f9a163@oss.qualcomm.com>
 <aHkm4qjgSaklHGp0@linaro.org> <4363f117-cc25-4904-84cf-4b3779797223@oss.qualcomm.com>
 <ng7koaqz6s4cslugrujklsrprsl7v7wijtserr6edvsvbeqfkv@pldexeryni7h> <aHoU7MnweSHGPwxp@linaro.org>
In-Reply-To: <aHoU7MnweSHGPwxp@linaro.org>
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Fri, 18 Jul 2025 14:46:52 +0300
X-Gm-Features: Ac12FXy2Ni2DJVd4IxEHAjNLlJqPYCR_DtiPN2YpU_IHj7Inv-raVfZg2vrnC-g
Message-ID: <CAO9ioeWZYht=oJHKeHqwpPmOyJkDE5H2hxh-+Ppp0V=OPv7bJw@mail.gmail.com>
Subject: Re: [PATCH 4/4] arm64: dts: qcom: Add base HAMOA-IOT-EVK board
To: Stephan Gerhold <stephan.gerhold@linaro.org>
Cc: Yijie Yang <yijie.yang@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE4MDA5MiBTYWx0ZWRfX6aABdv0v4j5q
 N/YrlJ+YsCIdVfJpgldIhufywLcQtzPqQUegCoToH+ahZENlpxrXP00cmC8CHCEBYSpWduywO6l
 tmXVeUUHn4feiFGSStBM2jJtmQiW85X81mbrCRDGxCb4E3ChF7ltoE9uMhc1f9uuknCF0iuzIL9
 y+Ofv7Jg8D4wZL1PICqv40fGkQed2flkCHTLFS/Vqqad10pfCWZDKEG/NeS9FjLxrxGMpzpIjCZ
 IeZvlcGluaAJitWL093jSmSzdQ+oA2OiM0hDz0Vpf2W5DaaQTFaFlYgS08KdxRhUugqTKOVf/L4
 iE4Kd5yX/gkB2YZzMct4l4RpFk6/qq0sbdRrBe4uVKts1xYLD+o+H/thLW/cdzmdkO0Fz0Qvseb
 ozNs2jgSmqvDtrCcipg0WNT854UriGBsX4OEIHxEwL9YSAH/ag93JAcKtntKxFOMqYehAEE3
X-Proofpoint-ORIG-GUID: CDKe10ErlWpLFhBEBQJ9mGpb6JJhDG5M
X-Proofpoint-GUID: CDKe10ErlWpLFhBEBQJ9mGpb6JJhDG5M
X-Authority-Analysis: v=2.4 cv=f59IBPyM c=1 sm=1 tr=0 ts=687a3439 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=YHsmNHqWrCgzcmbIdFEA:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-18_02,2025-07-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 malwarescore=0 spamscore=0 mlxscore=0
 bulkscore=0 suspectscore=0 impostorscore=0 adultscore=0 priorityscore=1501
 mlxlogscore=999 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507180092

On Fri, 18 Jul 2025 at 12:33, Stephan Gerhold
<stephan.gerhold@linaro.org> wrote:
>
> On Fri, Jul 18, 2025 at 12:27:34PM +0300, Dmitry Baryshkov wrote:
> > On Fri, Jul 18, 2025 at 04:19:13PM +0800, Yijie Yang wrote:
> > > On 2025-07-18 00:37, Stephan Gerhold wrote:
> > > > On Wed, Jul 16, 2025 at 05:08:42PM +0800, Yijie Yang wrote:
> > > > > The HAMOA-IOT-EVK is an evaluation platform for IoT products, composed of
> > > > > the Hamoa IoT SoM and a carrier board. Together, they form a complete
> > > > > embedded system capable of booting to UART.
> > > > >
> > > > > This change enables and overlays the following peripherals on the carrier
> > > > > board:
> > > > > - UART
> > > > > - On-board regulators
> > > > > - USB Type-C mux
> > > > > - Pinctrl
> > > > > - Embedded USB (EUSB) repeaters
> > > > > - NVMe
> > > > > - pmic-glink
> > > > >
> > > > > Written with contributions from Shuai Zhang (added Bluetooth).
> > > > >
> > > > > Signed-off-by: Yijie Yang <yijie.yang@oss.qualcomm.com>
> > > > > ---
> > > > >   arch/arm64/boot/dts/qcom/Makefile          |   1 +
> > > > >   arch/arm64/boot/dts/qcom/hamoa-iot-evk.dts | 835 +++++++++++++++++++++++++++++
> > > > >   2 files changed, 836 insertions(+)
> > > > >
> > > > > diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
> > > > > index 4bfa926b6a0850c3c459bcba28129c559d50a7cf..c5994b75d3e56e74ffb64b2389ee1bcc086f3065 100644
> > > > > --- a/arch/arm64/boot/dts/qcom/Makefile
> > > > > +++ b/arch/arm64/boot/dts/qcom/Makefile
> > > > > @@ -13,6 +13,7 @@ dtb-$(CONFIG_ARCH_QCOM)       += apq8039-t2.dtb
> > > > >   dtb-$(CONFIG_ARCH_QCOM)       += apq8094-sony-xperia-kitakami-karin_windy.dtb
> > > > >   dtb-$(CONFIG_ARCH_QCOM)       += apq8096-db820c.dtb
> > > > >   dtb-$(CONFIG_ARCH_QCOM)       += apq8096-ifc6640.dtb
> > > > > +dtb-$(CONFIG_ARCH_QCOM)        += hamoa-iot-evk.dtb
> > > > >   dtb-$(CONFIG_ARCH_QCOM)       += ipq5018-rdp432-c2.dtb
> > > > >   dtb-$(CONFIG_ARCH_QCOM)       += ipq5018-tplink-archer-ax55-v1.dtb
> > > > >   dtb-$(CONFIG_ARCH_QCOM)       += ipq5332-rdp441.dtb
> > > > > diff --git a/arch/arm64/boot/dts/qcom/hamoa-iot-evk.dts b/arch/arm64/boot/dts/qcom/hamoa-iot-evk.dts
> > > > > new file mode 100644
> > > > > index 0000000000000000000000000000000000000000..843f39c9d59286a9303a545411b2518d7649a059
> > > > > --- /dev/null
> > > > > +++ b/arch/arm64/boot/dts/qcom/hamoa-iot-evk.dts
> > > > > [...]
> > > > > +       vreg_wcn_3p3: regulator-wcn-3p3 {
> > > > > +               compatible = "regulator-fixed";
> > > > > +
> > > > > +               regulator-name = "VREG_WCN_3P3";
> > > > > +               regulator-min-microvolt = <3300000>;
> > > > > +               regulator-max-microvolt = <3300000>;
> > > > > +
> > > > > +               gpio = <&tlmm 214 GPIO_ACTIVE_HIGH>;
> > > > > +               enable-active-high;
> > > > > +
> > > > > +               pinctrl-0 = <&wcn_sw_en>;
> > > > > +               pinctrl-names = "default";
> > > > > +
> > > > > +               regulator-boot-on;
> > > > > +       };
> > > > > +
> > > > > +       /*
> > > > > +        * TODO: These two regulators are actually part of the removable M.2
> > > > > +        * card and not the CRD mainboard. Need to describe this differently.
> > > > > +        * Functionally it works correctly, because all we need to do is to
> > > > > +        * turn on the actual 3.3V supply above.
> > > > > +        */
> > > > > +       vreg_wcn_0p95: regulator-wcn-0p95 {
> > > > > +               compatible = "regulator-fixed";
> > > > > +
> > > > > +               regulator-name = "VREG_WCN_0P95";
> > > > > +               regulator-min-microvolt = <950000>;
> > > > > +               regulator-max-microvolt = <950000>;
> > > > > +
> > > > > +               vin-supply = <&vreg_wcn_3p3>;
> > > > > +       };
> > > > > +
> > > > > +       vreg_wcn_1p9: regulator-wcn-1p9 {
> > > > > +               compatible = "regulator-fixed";
> > > > > +
> > > > > +               regulator-name = "VREG_WCN_1P9";
> > > > > +               regulator-min-microvolt = <1900000>;
> > > > > +               regulator-max-microvolt = <1900000>;
> > > > > +
> > > > > +               vin-supply = <&vreg_wcn_3p3>;
> > > > > +       };
> > > >
> > > > Like the TODO comment already says, regulators located on a M.2 card
> > > > shouldn't be described as part of the device DT. We need a proper
> > > > solution for modelling the M.2 slots together with the standard power
> > > > supplies (3.3V and 1.8V) and hook this up to the pwrseq subsystem. This
> > > > is also the reason why the CRD does not have Bluetooth enabled upstream
> > > > yet, this needs to be solved first.
> > > >
> > > > As far as I know, there is no one actively working on addressing this at
> > > > the moment. Perhaps you can assign someone at QC to work on solving this
> > > > upstream.
> > >
> > > This power section is now managed by UEFI, rendering these regulator nodes
> > > unnecessary. Therefore, I will remove them in the next version.
> >
> > No. The regulators for the M.2 slot should be present here so that Linux
> > doesn't disable them. Which triggers a question: how are they
> > controlled? I don't see a GPIO line there.
> >
>
> The 0.95V and 1.9V regulators are located on the inserted M.2 *card* and
> get automatically enabled by the 3.3V supply of the M.2 *slot*. If you
> remove the card or insert a different one, they won't be present. This
> is why they shouldn't be part of the DT. The M.2 slot only has a 3.3V
> supply and a 1.8V supply.
>
> The only reason why they are here is that the current bindings for the
> WCN7850 require describing the whole PMU and internal regulators of the
> M.2 card. Ideally, we should have a generic description for the M.2
> slot/connector instead.

Agree.


-- 
With best wishes
Dmitry

