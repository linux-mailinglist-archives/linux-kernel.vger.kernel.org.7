Return-Path: <linux-kernel+bounces-773392-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91358B29F3F
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 12:40:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE2DF3BF786
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 10:38:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B34642765C9;
	Mon, 18 Aug 2025 10:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="o3rR1E4r"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFFFF2727EC
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 10:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755513481; cv=none; b=mkQq1sGaiuQNmOvLNR7xhsjGPWET1EZ1wFSdqNgHLwmLGZKRlNH7i7yYmqkqjkbPnOvTXf3GcIdKdeL5hXYDNQeXen02796BydVuRZAETmKr9QcRL9V9vxoUwMPoj0/mSX8/usMZt9bYjk9KlqfvIr/G4IeiV2CQdtjgS0ZU0OQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755513481; c=relaxed/simple;
	bh=s8IwXCiUQ0FxlihavqVxQsLHd47yJOgvxCiikfOxmxY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bh4OapfwzoxL+6cdR67xYtNne5y5I4eWizjXnfsHrNAga6PYsYy+heMPK53XQdBmTxomAeb1uu6gFbTM1kCDMCboJbrbxMHAc69Y6xRdYBFMwDIX2tFSw8u4n7wUNjyrXsiI6hPbjjmTkjnqJV0p2zctq/I8OaiEhkyp0zSCUJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=o3rR1E4r; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-45a1b0becf5so20164385e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 03:37:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755513477; x=1756118277; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MJ+dLG7D8VMA5zUxamVufYYDcWdBwujLeZKSQ4qaAMA=;
        b=o3rR1E4rJFwrg7CZUW03Sr4xdmf25dhIq+EpRU5K4Tt9KcGs2mGu9Ca5Ju/lh03Jf5
         +3QETiXW1MEXBOhLDcj8hQNkQ7hPQXNczsaKwni+s9/5NjUbh8qU7NSf44shtTjx+pag
         SoxkRH3sjroN+TffGPQhHUn2c6CJgdYBrF/48N19VBSJ2dhjWCGd7wlE+6+w+2Y/JWA2
         vlDD+p7utAyWPPgIE2O7ALXPPnN2XOmRTL2a6C2SFkwdUrRd3NlOByQh1KlN9/yJFxye
         Z3BRZaBBD4DZ4JsIox/z48MZ9Z6igfmpO+nIFaNx7rwPIS4k/fZB8I33mj9EXgvJZsGo
         vroQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755513477; x=1756118277;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MJ+dLG7D8VMA5zUxamVufYYDcWdBwujLeZKSQ4qaAMA=;
        b=g5W3MMvPmutr5ZBfqlWaHYYgk4WGqC5zHHXos7f+CIoi8h8M2pjrmbkupdUhAjInSp
         RCUa8/KjB0ramvuPFrEtZufH01zUiYCMmMgIruuh2FymwfgAUc3JsHMtEtBeROIT3V2y
         KqL2M4j4Gufgu2mjCF0mkcjmrj8+1QZ83KlDi+yME667WLLXiPtXVpqwqCVZZQumhWs6
         3rJYJvpP7no/dNHaZTlexGZtLopvLAF50uvJC+YzQZ9Xrgm//Okxhm81qA0IBRLeU6JP
         XFcR5zC4CB1voE3squ6LclDYV54Z+J9w4LB6D6ilcXlEaUivjkyyp1h7gQM73AOkNtRh
         4txg==
X-Forwarded-Encrypted: i=1; AJvYcCXKCxQ3J401NjShSD+9/skAe4DvApc5edPCKF5NCGRB8dtscuq4/K2jP7+GCEyL8YOCch+hxF35d/RjInQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSgI+jv5h0cBD6q8jQ8cxTZ3tgaYUi/q5/yZmZZ1zsBCl50gRU
	CLe+ceXU/UTmzAX7zUxW/rSP7UQUaMWV+M35nwbXEedK2XsnyH/cAOJZWhMrxouhqGE=
X-Gm-Gg: ASbGncvb0d63n6wzop5Wn8vgnUlXTfJpZDVATbmQBZFd0zuTsKhS4WWKgPuX0DGqUXp
	RGsk6T/6xCKCO5KgK/9woRFmyfN5Oxp1PYVH0y3Uzi9c86Vuj2lsyVYwAoLV3KZitL4f9+kMmg4
	ysMm/rKFyZ9hFHak8taKVAXG0kesanBxZ+KK9NPz757Rco3Y5Xi1pablNmRwFEEz1q/dzMb4aGK
	65wbH9bUetGCIagwirWb/BqedOg3WIC0mogcO9gP8bM3hG/LBrRN8q22+B1D6FIymCx5eNMUmYu
	voUXPDO+Rw6p5yvlNDik0Av+T8gVix99CTRIY6M9/anIIMdOom5LdC0AG/Gtl2s8AqrX3aISsDI
	rm02774khp9y0fhAs0Cg/iV0YNUNX4stS
X-Google-Smtp-Source: AGHT+IH/iXgPgP6GZzzqwOmyT3dKbeYre4usD+yo4PWWSrFhchZe3s7Qf6anzEm7JhSB0vvjno+pSQ==
X-Received: by 2002:a05:600c:198e:b0:456:1904:27f3 with SMTP id 5b1f17b1804b1-45a2183d444mr88116475e9.18.1755513477021;
        Mon, 18 Aug 2025 03:37:57 -0700 (PDT)
Received: from linaro.org ([2a02:2454:ff21:ef30:d6e:23fa:76e1:25d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45a1c6cf151sm168054945e9.8.2025.08.18.03.37.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 03:37:56 -0700 (PDT)
Date: Mon, 18 Aug 2025 12:37:48 +0200
From: Stephan Gerhold <stephan.gerhold@linaro.org>
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
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
Message-ID: <aKMCfJW-Qv4Z-gnz@linaro.org>
References: <20250814-x1e80100-add-edp-hpd-v1-0-a52804db53f6@linaro.org>
 <20250814-x1e80100-add-edp-hpd-v1-1-a52804db53f6@linaro.org>
 <pmhy2ogyorelllgandehtzlen64tzegp5pc6fkg7al7xzjcb2h@lq4lpaaavr6j>
 <aKLZ5M12Q-qTuB4n@linaro.org>
 <ubagrwewqqyvdgjmibhqp57x7ttqukqtv6ziftwsayuomlght6@j2k7i63rldsd>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ubagrwewqqyvdgjmibhqp57x7ttqukqtv6ziftwsayuomlght6@j2k7i63rldsd>

On Mon, Aug 18, 2025 at 01:33:43PM +0300, Dmitry Baryshkov wrote:
> On Mon, Aug 18, 2025 at 09:44:36AM +0200, Stephan Gerhold wrote:
> > On Sat, Aug 16, 2025 at 01:06:50AM +0300, Dmitry Baryshkov wrote:
> > > On Thu, Aug 14, 2025 at 03:30:28PM +0200, Stephan Gerhold wrote:
> > > > At the moment, we indirectly rely on the boot firmware to set up the
> > > > pinctrl for the eDP HPD line coming from the internal display. If the boot
> > > > firmware does not configure the display (e.g. because a different display
> > > > is selected for output in the UEFI settings), then the display fails to
> > > > come up and there are several errors in the kernel log:
> > > > 
> > > >  [drm:dpu_encoder_phys_vid_wait_for_commit_done:544] [dpu error]vblank timeout: 80020041
> > > >  [drm:dpu_kms_wait_for_commit_done:524] [dpu error]wait for commit done returned -110
> > > >  [drm:dpu_encoder_frame_done_timeout:2715] [dpu error]enc40 frame done timeout
> > > >  ...
> > > > 
> > > > Fix this by adding the missing pinctrl for gpio119 (func1/edp0_hot and
> > > > bias-disable according to the ACPI DSDT).
> > > > 
> > > > Fixes: 6516961352a1 ("arm64: dts: qcom: Add support for X1-based Asus Zenbook A14")
> > > > Signed-off-by: Stephan Gerhold <stephan.gerhold@linaro.org>
> > > > ---
> > > >  arch/arm64/boot/dts/qcom/x1-asus-zenbook-a14.dtsi | 9 +++++++++
> > > >  1 file changed, 9 insertions(+)
> > > > 
> > > > diff --git a/arch/arm64/boot/dts/qcom/x1-asus-zenbook-a14.dtsi b/arch/arm64/boot/dts/qcom/x1-asus-zenbook-a14.dtsi
> > > > index 16d045cf64c08c02c420787e000f4f45cfc2c6ff..613c675aac296f931293a1ba3d8506c6663bad21 100644
> > > > --- a/arch/arm64/boot/dts/qcom/x1-asus-zenbook-a14.dtsi
> > > > +++ b/arch/arm64/boot/dts/qcom/x1-asus-zenbook-a14.dtsi
> > > > @@ -1001,6 +1001,9 @@ &mdss_dp1_out {
> > > >  &mdss_dp3 {
> > > >  	/delete-property/ #sound-dai-cells;
> > > >  
> > > > +	pinctrl-0 = <&edp_hpd_default>;
> > > > +	pinctrl-names = "default";
> > > > +
> > > >  	status = "okay";
> > > >  
> > > >  	aux-bus {
> > > > @@ -1236,6 +1239,12 @@ cam_indicator_en: cam-indicator-en-state {
> > > >  		bias-disable;
> > > >  	};
> > > >  
> > > > +	edp_hpd_default: edp-hpd-default-state {
> > > > +		pins = "gpio119";
> > > > +		function = "edp0_hot";
> > > > +		bias-disable;
> > > > +	};
> > > 
> > > I think this is common enough. Let's maybe push this into the SoC dtsi
> > > instead of copying it to all devices?
> > > 
> > 
> > I had it there before, but Johan commented on the patch set from Chris
> > that he would prefer to keep the potentially board-specific pinctrl out
> > of the SoC dtsi [1]. So I can either address his feedback or yours. :-)
> > 
> > There isn't really a convention for X1E either - we have a wild mix
> > where some pinctrl is defined in the SoC dtsi (UART, I2C, SDHCI, ...)
> > and others is copied for each board (e.g. PCIe).
> 
> PCIe pinctrl is a part of SoC DTSI for SM8[4567]0.
> 

For some reason it's not on X1E.

> > The reason I chose this approach is that I didn't feel it is guaranteed
> > that the HPD pin has external pull down. It seems to be the case on most
> > devices, but in theory a device could maybe rely on the internal pull
> > down. Might be better to have it explicitly defined, the 5 additional
> > lines are not that much at the end.
> 
> I don't think anybody will use internal pull-down for this, it would be
> too risky in case the eDP cable is bad. I have checked several laptops,
> they use external pull-down or two MOSFETs.
> 

So are you suggesting to put just the "template" (the
edp-hpd-default-state node) into the SoC dtsi and keep the
pinctrl-0/pinctrl-names reference in the board DT, or to put everything
into the SoC dtsi? I'm not sure if there is a use case where there
wouldn't be any HPD connected to GPIO119.

Thanks,
Stephan

