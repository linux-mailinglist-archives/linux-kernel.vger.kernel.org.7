Return-Path: <linux-kernel+bounces-773389-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 171DCB29F31
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 12:34:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 816B9189B81C
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 10:34:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 689F326E6F2;
	Mon, 18 Aug 2025 10:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="OdMFnioy"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24713225D7
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 10:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755513232; cv=none; b=fnlDWVC0NJeau3Jxnwm+yoS5OEp3x99WHqXSCe73hxhRffv0NwlovnUm/7Og24VAL4cXV49yEwQHgN91oeZDoeOZgU5+/RnmpnXY51lsoRs5+PxbeaejRPa+0qwaf4DuP3KnS5M+vKsgMSKeiL5jZ647yrH+MOlPRrWCyhpMy08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755513232; c=relaxed/simple;
	bh=kp5VnNcbs+9/ErL8zE8XvSZqvp7my5Lsakn8f4ZZTOo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jqpDVCmBQYWSyN+VRYtmm5H/vhd6Yi/SRl1f8Izb+lcWYeppL0CdS54H9yw4hfUF633tp0LNq8QHAAF+n7mzDP/xN7XkQ0p64zgz3wi+KCNL3QvN5jfgpZDMSWcO2LcdT4wSwLOD1vLlu/3uPugyg4SiBRmScyTKeUTp7Ced1Ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=OdMFnioy; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57I8Jn72022517
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 10:33:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=A7ynXFPAdDr93bbf3NbCgD8j
	ygp0goJYJwT/DBfR7E0=; b=OdMFnioyG0X1y6dW2Lq6fKB/IyxOCBIiQ9TQ8iTJ
	KLoSIDasmi+ltdOJ/C9MTSKl7e5M7zSEXhwwcMlFxUxMEGx4dUkwmSvJea/U7467
	VgGJMod+C9m8cnxmmiigaSCYORPDMDpWxUtSezUXfOKqNmuidxMLeMf6xTUAwode
	gwLcyBuy6JOk+V4qod2x2Ri6Z11gDCsR36TJ3oel1nNQOIVA/lpdcLFU/Y40w3Sz
	gJ5KQq/4XRVdabpnis8ePfZCai9vShmehQ5eh6XDCT0VyNZ6b2JstJOYV+6SSeI2
	hE8AfUUzEh3+jjfFhsxr8QTItYxlkR5UfQCs9Us7gEISZQ==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48jj744a9x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 10:33:50 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4b109c5457cso116905441cf.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 03:33:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755513227; x=1756118027;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A7ynXFPAdDr93bbf3NbCgD8jygp0goJYJwT/DBfR7E0=;
        b=F1Jgh3jIo1lR38r1C6OTI7m7yDgUNA2A5r+pGKpcTLLx/oRIgQt88qpU6fSkTwuxo/
         Gd//9ELDj2ql+NMjcps3js9Kf5nKJ7oNsPAvCOqhjxbJjgZxamvf/bvsXCAARDXo3CGv
         PeRrejywTQFlWw5v7NnoqMG05xxbt/Glu8ZC6hnUTDpHE4jGdfye4PCCdOR3NaHhh4ss
         iDoqMTBgtXl8ZbxxZSunqMyPHoSfWFUa47T4YCvqQV0vD0YYH7d5yjpkKi4Or8w9u7BF
         SajFsDzMj9+djPMibqd6ZuDfx6ZQ74LU8iqkjMbaj1jk5jjhwd2m1gyYYXW/Nc7exU/3
         kKtg==
X-Forwarded-Encrypted: i=1; AJvYcCUIZaH7KsvtKlrup/XWSRvlV6139lLfKa1qEvOeVyPStXJl7CfHxztnMfjTH8XTswrDeIb7IGUcaP7YM/Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxag5lMR+ozcXf4FvSF+KRHGMGwkDirgR3HOgxTvT9K4ChZ0Wlg
	SmCCJO4fZCKaKUs58TGr10E41+uwVmjc2UbWQljgQryn+FQpvI1NTkMcO9ZUNaRKAawvKI7Epwa
	U6dCe+7y6iK2bdSgdmlFCZoDwCi9sEc7+gsRXn1MzoRTT0/PBRY2ginp0Trod3I8Usjw=
X-Gm-Gg: ASbGnctAqLSwm+CAcefn6nNcxr5EnDIuDQuesVakQNne75oYTxWaGknDq/6tMx4soYs
	yOtE2hRIFYDV91MKwbu9cYD15ctkLkvbm4fKmYmYyjgIcMtLUOELe4l+fMD7/kKOHmy9RCSP6ju
	sdH23BXzAf6ozrLGpsv8Jcdf+CdKR2FE+rWDj53mvsFHOUFmtjKC2DEybnLKenlL3oE/9helHMT
	O+wo6Q0jYky48qgtdr/e6UpIcEY4mYSLttrp0Mny//C09//wHBSKH5j7Mub7CKqxqzwWTSdaAV3
	U9tsXkzI5ZgWqvIAbTwnqJ6cjE4LjYPg7SWaqmht8B+pFiJp2FxSg4Pm8FxR72CKBH8KjEJucMo
	qrht7tV0aiFBdEny908UkePM8Q693t4AO/MQuhM6dr81dVHLbFOg3
X-Received: by 2002:a05:622a:24e:b0:4ab:9586:386b with SMTP id d75a77b69052e-4b11e27d4f3mr156692041cf.53.1755513226743;
        Mon, 18 Aug 2025 03:33:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFmsjNW1ZeHTRfqJuRiDYJxZ1Opx0gN6XfkaTOXUZxgte6+tNjsiZmaOhN2niJbZ9NaHk0qng==
X-Received: by 2002:a05:622a:24e:b0:4ab:9586:386b with SMTP id d75a77b69052e-4b11e27d4f3mr156691421cf.53.1755513226026;
        Mon, 18 Aug 2025 03:33:46 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55cef369843sm1592070e87.60.2025.08.18.03.33.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 03:33:45 -0700 (PDT)
Date: Mon, 18 Aug 2025 13:33:43 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
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
Subject: Re: [PATCH 1/9] arm64: dts: qcom: x1-asus-zenbook-a14: Add missing
 pinctrl for eDP HPD
Message-ID: <ubagrwewqqyvdgjmibhqp57x7ttqukqtv6ziftwsayuomlght6@j2k7i63rldsd>
References: <20250814-x1e80100-add-edp-hpd-v1-0-a52804db53f6@linaro.org>
 <20250814-x1e80100-add-edp-hpd-v1-1-a52804db53f6@linaro.org>
 <pmhy2ogyorelllgandehtzlen64tzegp5pc6fkg7al7xzjcb2h@lq4lpaaavr6j>
 <aKLZ5M12Q-qTuB4n@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aKLZ5M12Q-qTuB4n@linaro.org>
X-Proofpoint-GUID: m8gIR0rIisZUx2iBkiSYTbZCDzw11ueV
X-Proofpoint-ORIG-GUID: m8gIR0rIisZUx2iBkiSYTbZCDzw11ueV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE2MDAzMyBTYWx0ZWRfXxpeozou3CB/H
 5jS60QGwf0GnGH4HalZHQOqOmbKqicCcOLmAyRGGNYIl9z7FyaweSEtDIFH3k13BZJMZtBiLn7a
 PBFA+pT9z2ViSW2UQ/YlS9vg61NMhbzHHzrh+K9oYuoVcO5GFNKzTxCEFmA02rwnUXPhJS846EA
 +oLhAvTFI53l350D+2Y1Yvh75Hw6AS91sLoluTWT8A/5oP8m/ya/0G1nToqDP3WQqsctQVfDRKl
 qSCCuaH1X/iCh5V3YPnuVNbi88/L8yuCxjHnHkpX7OQrSkjo9xhYBSYkPPc9C5X1qwD3M4IAmUC
 QSI5p0XmI4quL9Ob0oSL5Pz/h6HKIWCxHRxvofzanQ6Vy5Y8W6GGHbACE7g+EGQm2GSJiX3Cq01
 5A+Hfbaq
X-Authority-Analysis: v=2.4 cv=MJtgmNZl c=1 sm=1 tr=0 ts=68a3018e cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=KKAkSRfTAAAA:8 a=thYETgxLN2gimk122HMA:9 a=CjuIK1q_8ugA:10
 a=kacYvNCVWA4VmyqE58fU:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-18_04,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 bulkscore=0 adultscore=0 suspectscore=0
 phishscore=0 clxscore=1015 impostorscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508160033

On Mon, Aug 18, 2025 at 09:44:36AM +0200, Stephan Gerhold wrote:
> On Sat, Aug 16, 2025 at 01:06:50AM +0300, Dmitry Baryshkov wrote:
> > On Thu, Aug 14, 2025 at 03:30:28PM +0200, Stephan Gerhold wrote:
> > > At the moment, we indirectly rely on the boot firmware to set up the
> > > pinctrl for the eDP HPD line coming from the internal display. If the boot
> > > firmware does not configure the display (e.g. because a different display
> > > is selected for output in the UEFI settings), then the display fails to
> > > come up and there are several errors in the kernel log:
> > > 
> > >  [drm:dpu_encoder_phys_vid_wait_for_commit_done:544] [dpu error]vblank timeout: 80020041
> > >  [drm:dpu_kms_wait_for_commit_done:524] [dpu error]wait for commit done returned -110
> > >  [drm:dpu_encoder_frame_done_timeout:2715] [dpu error]enc40 frame done timeout
> > >  ...
> > > 
> > > Fix this by adding the missing pinctrl for gpio119 (func1/edp0_hot and
> > > bias-disable according to the ACPI DSDT).
> > > 
> > > Fixes: 6516961352a1 ("arm64: dts: qcom: Add support for X1-based Asus Zenbook A14")
> > > Signed-off-by: Stephan Gerhold <stephan.gerhold@linaro.org>
> > > ---
> > >  arch/arm64/boot/dts/qcom/x1-asus-zenbook-a14.dtsi | 9 +++++++++
> > >  1 file changed, 9 insertions(+)
> > > 
> > > diff --git a/arch/arm64/boot/dts/qcom/x1-asus-zenbook-a14.dtsi b/arch/arm64/boot/dts/qcom/x1-asus-zenbook-a14.dtsi
> > > index 16d045cf64c08c02c420787e000f4f45cfc2c6ff..613c675aac296f931293a1ba3d8506c6663bad21 100644
> > > --- a/arch/arm64/boot/dts/qcom/x1-asus-zenbook-a14.dtsi
> > > +++ b/arch/arm64/boot/dts/qcom/x1-asus-zenbook-a14.dtsi
> > > @@ -1001,6 +1001,9 @@ &mdss_dp1_out {
> > >  &mdss_dp3 {
> > >  	/delete-property/ #sound-dai-cells;
> > >  
> > > +	pinctrl-0 = <&edp_hpd_default>;
> > > +	pinctrl-names = "default";
> > > +
> > >  	status = "okay";
> > >  
> > >  	aux-bus {
> > > @@ -1236,6 +1239,12 @@ cam_indicator_en: cam-indicator-en-state {
> > >  		bias-disable;
> > >  	};
> > >  
> > > +	edp_hpd_default: edp-hpd-default-state {
> > > +		pins = "gpio119";
> > > +		function = "edp0_hot";
> > > +		bias-disable;
> > > +	};
> > 
> > I think this is common enough. Let's maybe push this into the SoC dtsi
> > instead of copying it to all devices?
> > 
> 
> I had it there before, but Johan commented on the patch set from Chris
> that he would prefer to keep the potentially board-specific pinctrl out
> of the SoC dtsi [1]. So I can either address his feedback or yours. :-)
> 
> There isn't really a convention for X1E either - we have a wild mix
> where some pinctrl is defined in the SoC dtsi (UART, I2C, SDHCI, ...)
> and others is copied for each board (e.g. PCIe).

PCIe pinctrl is a part of SoC DTSI for SM8[4567]0.

> The reason I chose this approach is that I didn't feel it is guaranteed
> that the HPD pin has external pull down. It seems to be the case on most
> devices, but in theory a device could maybe rely on the internal pull
> down. Might be better to have it explicitly defined, the 5 additional
> lines are not that much at the end.

I don't think anybody will use internal pull-down for this, it would be
too risky in case the eDP cable is bad. I have checked several laptops,
they use external pull-down or two MOSFETs.

> I'm also fine with moving it. Perhaps Bjorn or Konrad could comment if
> they would prefer to have the pinctrl template defined in the SoC dtsi?

-- 
With best wishes
Dmitry

