Return-Path: <linux-kernel+bounces-773394-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E4676B29F3C
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 12:39:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 83B0218A6C46
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 10:40:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C22A2765C4;
	Mon, 18 Aug 2025 10:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="j+4WJsdR"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6508258EFF
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 10:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755513582; cv=none; b=LRmas/6mjGdktYVzDCnMbF27mxmHE/VQCRFwEhhbZgqqMmOfNNr2ezV3/DLTgFQkUa/wirZdnFPyXaxYpInXztHK73r2xCiloGtucXmdOxfXxzE4lugvFZQHkOibm79+IixU8rIvmPHDmTmJg+7o1BpvxHYCqTNogW7FXlADdB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755513582; c=relaxed/simple;
	bh=wxFiqofRnaNDpW/xtKn163O+QZ+nnDNV98i5gnAsyKM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u5hOCQJ7fFS4/wcv3wo0NUsasCSw2l2QxRci1rmozUNtstvYs+o8CR0ZHyupBJhWWO8el+hpeVq9dXfDPmA3qtPyaWnBjKxvFlvLUVjlw8axA4jRCk0mf37ZfRcl4JXOWbboFlfvkFRklrxluZqUB4xu5Q1Nt0e92y2AZlqWpWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=j+4WJsdR; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57I8ODkA023911
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 10:39:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=yeNe6eth2dAkJ/cZO+bbJK7D
	iChjr4KrV6qgrujy2KY=; b=j+4WJsdRAhMlg+pVQygdG89v3WcJBoArZ4W04LsH
	7H7f9Xglbb95WD976MFCp0oGdiYDY/T2XXdmjunsafj7JYbkLsI4IqBWI5QV0pDs
	+Z43KmPmvED+bFh6ofiMniQ8dirtxQf/pzD2iFmruffb/JwH05APMLMkXA1iIuxH
	LlkMM179jlkEntIe21QNFqTuFm4/fvk4R+8Awy4VuHyaK9Nh35e4poSgDKUjhhhD
	VYztfXKWo2gXNYOLC1keotoAh4xkry4d75+ftiVcBiZU3OIx+n1Xo7i6efkRClXM
	w7H6YuKnOQJXOCBY5e6NS0AMzkyRrCBVuotCDJ+eEIgHbA==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48jh074b5k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 10:39:39 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-323267b6c8eso9128607a91.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 03:39:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755513578; x=1756118378;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yeNe6eth2dAkJ/cZO+bbJK7DiChjr4KrV6qgrujy2KY=;
        b=lUViTJA6/eFxvGf8qwE7+v6V8cKKKk+RfYF2YW+2JEr/vUhugQWg+ubROPzFKMjfqZ
         QLryswNneQxKfqEGPhSrCclG8WQzCNhUSkfUuhCy9PMk7HI4k/2If78zW3IRNglTIMTq
         0FwWONlHSuhNFRTo1woA9P0gjNZE7UiU4YqmARWpN8PxM30cXALMuaYrI+oYBp6uGs7c
         RAnkTMFOJ/IjoHmDX1nTeIYKAoSEus39QMYhkxoR5ynaPBA3RXNXgGIfxSyq3fnSRWhE
         obIMLJGOc3HPSWdV1eebiWvXleIPSPdYxwKpKVuwNQX7LY4PH46fM0bBzb9Cjodm01nB
         6X/w==
X-Forwarded-Encrypted: i=1; AJvYcCW9XzVMCUPi65hoKyK/sbqN1I7IGhv/9dtSe9LrfMsBx6GDDTOEM/ZozrwEikhHFIDoYA2rSi0TBoLUh7U=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWdOpaeTtmMrv2mUbEb1pb9sBf80Qcs9cERIIp21uYuJiftqlp
	IUT6u9SREzSUFBfqI5MHoh162YlOprPtFCUeWgNEwZzrQbN1A6cJGPjr9eXBrBP1y+RH3yrhAVO
	0YyJrjFGT9DYiE3xc8EiA4RhPA6pDfooiIGtqwkZQHuYsj6hkMdiNZY4Dp6I+G3AUWQot3z6Fm2
	s8cLoIbN1i6sYftTmtK2qUNkJmkhboZaZesVN2LE04aA==
X-Gm-Gg: ASbGncuO6LeChX/EgfmMrxvQ1tWOuW6zk6MGgoeWxGdaDV9cAwS888axyiJDPtYW3Bx
	hBmqE/TCQfiQ76hGFXFH3Sp9QPygQnEwICT98GHq97T9m7Klxjw1DkRc7j0XmrnbR6reqT8STk4
	aIcuBgBkA5rdOII2OvyuaV
X-Received: by 2002:a17:903:1904:b0:240:b075:577f with SMTP id d9443c01a7336-2446d88a228mr161159685ad.37.1755513578203;
        Mon, 18 Aug 2025 03:39:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFUM2A0hdX9FsBJLEPJbp3KSguYOCXdOebXbrwsf8ik37oWFFlR4LOTxGgWWRteP6dq+6jq5ehC6dDWnd+1oLM=
X-Received: by 2002:a17:903:1904:b0:240:b075:577f with SMTP id
 d9443c01a7336-2446d88a228mr161159285ad.37.1755513577778; Mon, 18 Aug 2025
 03:39:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250814-x1e80100-add-edp-hpd-v1-0-a52804db53f6@linaro.org>
 <20250814-x1e80100-add-edp-hpd-v1-1-a52804db53f6@linaro.org>
 <pmhy2ogyorelllgandehtzlen64tzegp5pc6fkg7al7xzjcb2h@lq4lpaaavr6j>
 <aKLZ5M12Q-qTuB4n@linaro.org> <ubagrwewqqyvdgjmibhqp57x7ttqukqtv6ziftwsayuomlght6@j2k7i63rldsd>
 <aKMCfJW-Qv4Z-gnz@linaro.org>
In-Reply-To: <aKMCfJW-Qv4Z-gnz@linaro.org>
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Mon, 18 Aug 2025 13:39:26 +0300
X-Gm-Features: Ac12FXw9-48k1mfCCr7bd_NPB5vnYv4AGrWYDnXzJRQ9v-s8MaalFg_Q-oShxVM
Message-ID: <CAO9ioeXhBH_=+KMMBzxZXsQu_y57tdMQW5dwHV_dhwG3gUxytA@mail.gmail.com>
Subject: Re: [PATCH 1/9] arm64: dts: qcom: x1-asus-zenbook-a14: Add missing
 pinctrl for eDP HPD
To: Stephan Gerhold <stephan.gerhold@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Aleksandrs Vinarskis <alex.vinarskis@gmail.com>,
        Abel Vesa <abel.vesa@linaro.org>, Xilin Wu <wuxilin123@gmail.com>,
        Jens Glathe <jens.glathe@oldschoolsolutions.biz>,
        Srinivas Kandagatla <srini@kernel.org>,
        Sibi Sankar <quic_sibis@quicinc.com>,
        Rajendra Nayak <quic_rjendra@quicinc.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>,
        Christopher Obbard <christopher.obbard@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Proofpoint-ORIG-GUID: gJMo4LSlxVh9muTurwW-6GhHI8f-gBtg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE2MDAyMCBTYWx0ZWRfX9m0bdM5Z9/NO
 5GBt5XEGTHNlr78Qo9oXgjPPwgCbUv50sAdSXarA5OK6Q6L0JAlwoplWaeugViONCZmPbMwykGv
 5MzD3QM2h2Hru3MKbCnedkzBEQMZiVE9o4t4eOFx/2qlS/G/RfbzHP0OFzMfM+FTYEQobJ4p0iK
 xIaFuOPmWG7PbpU+nlTI+P16zT4MbK1oNDlM6aSyTmpVcgBQWt4TfbfaPxE78nRskljfuVzl+Tf
 W612195GVUBXA2ADBuCFXldHBEYKE0AfB0cpTBHY9QAmp2NsjhldnscJdUIvjeW70EV+aPYDQo3
 RXsLp7COd8A5/b4ZKpiBPVGMGaNeeX05XV/XO/Lq0MBeJ+SOiKUOF4VMQ/oHyzoN5CDhUbYAJaX
 rRQa5cl5
X-Authority-Analysis: v=2.4 cv=a+Mw9VSF c=1 sm=1 tr=0 ts=68a302eb cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10
 a=KKAkSRfTAAAA:8 a=q_Zo2jFP8hCPp6grwmUA:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: gJMo4LSlxVh9muTurwW-6GhHI8f-gBtg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-18_04,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 suspectscore=0 impostorscore=0 phishscore=0
 adultscore=0 priorityscore=1501 clxscore=1015 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508160020

On Mon, 18 Aug 2025 at 13:37, Stephan Gerhold
<stephan.gerhold@linaro.org> wrote:
>
> On Mon, Aug 18, 2025 at 01:33:43PM +0300, Dmitry Baryshkov wrote:
> > On Mon, Aug 18, 2025 at 09:44:36AM +0200, Stephan Gerhold wrote:
> > > On Sat, Aug 16, 2025 at 01:06:50AM +0300, Dmitry Baryshkov wrote:
> > > > On Thu, Aug 14, 2025 at 03:30:28PM +0200, Stephan Gerhold wrote:
> > > > > At the moment, we indirectly rely on the boot firmware to set up the
> > > > > pinctrl for the eDP HPD line coming from the internal display. If the boot
> > > > > firmware does not configure the display (e.g. because a different display
> > > > > is selected for output in the UEFI settings), then the display fails to
> > > > > come up and there are several errors in the kernel log:
> > > > >
> > > > >  [drm:dpu_encoder_phys_vid_wait_for_commit_done:544] [dpu error]vblank timeout: 80020041
> > > > >  [drm:dpu_kms_wait_for_commit_done:524] [dpu error]wait for commit done returned -110
> > > > >  [drm:dpu_encoder_frame_done_timeout:2715] [dpu error]enc40 frame done timeout
> > > > >  ...
> > > > >
> > > > > Fix this by adding the missing pinctrl for gpio119 (func1/edp0_hot and
> > > > > bias-disable according to the ACPI DSDT).
> > > > >
> > > > > Fixes: 6516961352a1 ("arm64: dts: qcom: Add support for X1-based Asus Zenbook A14")
> > > > > Signed-off-by: Stephan Gerhold <stephan.gerhold@linaro.org>
> > > > > ---
> > > > >  arch/arm64/boot/dts/qcom/x1-asus-zenbook-a14.dtsi | 9 +++++++++
> > > > >  1 file changed, 9 insertions(+)
> > > > >
> > > > > diff --git a/arch/arm64/boot/dts/qcom/x1-asus-zenbook-a14.dtsi b/arch/arm64/boot/dts/qcom/x1-asus-zenbook-a14.dtsi
> > > > > index 16d045cf64c08c02c420787e000f4f45cfc2c6ff..613c675aac296f931293a1ba3d8506c6663bad21 100644
> > > > > --- a/arch/arm64/boot/dts/qcom/x1-asus-zenbook-a14.dtsi
> > > > > +++ b/arch/arm64/boot/dts/qcom/x1-asus-zenbook-a14.dtsi
> > > > > @@ -1001,6 +1001,9 @@ &mdss_dp1_out {
> > > > >  &mdss_dp3 {
> > > > >         /delete-property/ #sound-dai-cells;
> > > > >
> > > > > +       pinctrl-0 = <&edp_hpd_default>;
> > > > > +       pinctrl-names = "default";
> > > > > +
> > > > >         status = "okay";
> > > > >
> > > > >         aux-bus {
> > > > > @@ -1236,6 +1239,12 @@ cam_indicator_en: cam-indicator-en-state {
> > > > >                 bias-disable;
> > > > >         };
> > > > >
> > > > > +       edp_hpd_default: edp-hpd-default-state {
> > > > > +               pins = "gpio119";
> > > > > +               function = "edp0_hot";
> > > > > +               bias-disable;
> > > > > +       };
> > > >
> > > > I think this is common enough. Let's maybe push this into the SoC dtsi
> > > > instead of copying it to all devices?
> > > >
> > >
> > > I had it there before, but Johan commented on the patch set from Chris
> > > that he would prefer to keep the potentially board-specific pinctrl out
> > > of the SoC dtsi [1]. So I can either address his feedback or yours. :-)
> > >
> > > There isn't really a convention for X1E either - we have a wild mix
> > > where some pinctrl is defined in the SoC dtsi (UART, I2C, SDHCI, ...)
> > > and others is copied for each board (e.g. PCIe).
> >
> > PCIe pinctrl is a part of SoC DTSI for SM8[4567]0.
> >
>
> For some reason it's not on X1E.
>
> > > The reason I chose this approach is that I didn't feel it is guaranteed
> > > that the HPD pin has external pull down. It seems to be the case on most
> > > devices, but in theory a device could maybe rely on the internal pull
> > > down. Might be better to have it explicitly defined, the 5 additional
> > > lines are not that much at the end.
> >
> > I don't think anybody will use internal pull-down for this, it would be
> > too risky in case the eDP cable is bad. I have checked several laptops,
> > they use external pull-down or two MOSFETs.
> >
>
> So are you suggesting to put just the "template" (the
> edp-hpd-default-state node) into the SoC dtsi and keep the
> pinctrl-0/pinctrl-names reference in the board DT,

Yes.

> or to put everything
> into the SoC dtsi? I'm not sure if there is a use case where there
> wouldn't be any HPD connected to GPIO119.

Still it's a board configuration (pretty much like PCIe config is).


-- 
With best wishes
Dmitry

