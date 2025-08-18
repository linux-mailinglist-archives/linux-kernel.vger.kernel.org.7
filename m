Return-Path: <linux-kernel+bounces-773069-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6231AB29B08
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 09:45:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B94505E74D8
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 07:44:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0218281520;
	Mon, 18 Aug 2025 07:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xNTwlCMH"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F302F280035
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 07:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755503084; cv=none; b=H1u2UvtJeDCSnC/FCDgQDSy+CAFXm/RURQhXnwUwKpY+4nvkykjQvxBlbi/qQ3Zqwe92FL+NPVCsr4ZKD6GliKcQUXKVDgY5XLS2h778kuNXTy5jGoyGdfoY2IecihkxAyUKox+qrq7TaP8Fuuzz9fUhO/1JGQkEBKh4HUUwBGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755503084; c=relaxed/simple;
	bh=jO41a6HejjBPXSF3nuomJXZzUSmXK9fA1x8Yvu3KM8Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nIQ8AMUSUJHxPz57tLqqo1gD7VSJkU8s0hR0GaC+Z/f6CgeQxyXNh9F968b1LFwpLXBy5SBD7xrqiItX8/Em53Uy2rJgoNM/GtqTaMcZMsbYkJbrbcHCeeHRjrkLjpx3WODv3TiHrdVelYV4NwMKOFnaZCkX7BzF+wxK0IESBHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xNTwlCMH; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-afcb61f6044so646788866b.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 00:44:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755503081; x=1756107881; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0q3D1hCM7sezdvpVcrp0vH4dqDUryB04vg1xMtc6bwU=;
        b=xNTwlCMHBXYmuzYqVCHoSOTrT9mBaaG6SL1rT6wJBN8S4OK5kREyVtELyDNwF0hBnf
         VbuT4UaOvQJyzR0jtpB0V+uXXGV1V0rd+0+fFbB2UDsGsX6/h9XgzsiqDCWoeIAgOb3n
         6odwMT2FmLXYD4gUKDbItWpfdmYDvz9CHOXXCJteROarBTvxcA7RYgHFiFR87RPdjPlB
         wT8x7ku8j604BacDjmghAM+ZRU2pt47lAmhZn1/+mZyI4SC1wLxGHmedO/RTZYKdRz9S
         nFBwPKvrw5n6qO+m5H7+mTKf7+JqUeObO3dXZWFkp9KhbIi2sViom5aoyTpc7Q9WG5Qj
         kJwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755503081; x=1756107881;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0q3D1hCM7sezdvpVcrp0vH4dqDUryB04vg1xMtc6bwU=;
        b=SJap8dXM5PlhPBeGx3Pe/oYjhSUl771VZ+uJ5wNQFjiEyigYY/x/7qc0kFhJGlP5WI
         +jSDa4VmNk2xJ/geeGt8zpK75U9xemClBY84JH0uORFAUHUhuX/4b7JVo65PqtcezP4P
         5sZ+19MOAAZt83O5uyUjh2KRcWSMQaLae02TXSlkfsWt55azqcMAV2IFoxOef5f+nUwQ
         yxSeHORvZClaIh+AGp8JNIEa+SfllqBWS4eNwrA0ZDOl9dL4XtcOCwtx8RDHqq+E4ieV
         +F4SKJLbcQKWMwvnoyj40v7wOPz+0w7YrjIwmbe3DVDmTixO2zZccHfJea3Ghrrs0ILk
         BLAw==
X-Forwarded-Encrypted: i=1; AJvYcCW4udMLoH8HUudCUYKP582pH4P/xVKFAUyuky8foKFHNAp1mutvXxTM4CfSYfl8NQdMVNxdIgkOG1PqIP4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwIT5y48jablNmtjuwShqAVV6+kTCCRdy4hO62YzJ0vBAL1HnU
	tW6JfeZATX3OyaHJY7UAiTTHGlKr9yqrIH8sN1BUzfq7/sZjUuG0kowZJ3VSBZ4+WEs=
X-Gm-Gg: ASbGnctRMu7vJHKKe0kbWslsckUM1F4g9kj/+ASiUjjMun1tLinSfUIuUX2Hn/pMDHF
	6thdE2ahYbqYf1MIpFxDzoU9QlJfatEA0ry2eWviPpSsxKoYYv0R2N6MJPWvHcfHWe06MF1k3j5
	tKq1JXf6UPpyUuyYoHkFhzAJLaZN5LKr+1gT1gRnxjBk9VvFaXzSi3GXQEuwo7Do1KjwH6vJG75
	LInEic0b3HMBXZE553kOzeaJCAGCgFvb7ua4dn8v6JEYM/fZ9Id0RNNC6DTNHB9MU1AfMKMH9AT
	3Di2QU/DxawgPTU86F/pysoWe8Hjn03j0KRinpa7KSAxbvaREd8E8uIlXzFTr4rlvKnL1pNIvhD
	YyNjwl8Haui8lw+GvSS/pnPCddcm1cbrRgw==
X-Google-Smtp-Source: AGHT+IFYRa5/G/vkuyAEvzPFOvv12naV5coa7rSBsKS6OmFNdjfJsZKTFi2E19B+6H4KXxIuA2nubw==
X-Received: by 2002:a17:907:7f90:b0:afb:513a:f62f with SMTP id a640c23a62f3a-afcbd8974c4mr1402578566b.20.1755503081196;
        Mon, 18 Aug 2025 00:44:41 -0700 (PDT)
Received: from linaro.org ([2a02:2454:ff21:ef30:6db9:9ad4:f47a:99b])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afcdd010e1bsm733850266b.93.2025.08.18.00.44.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 00:44:40 -0700 (PDT)
Date: Mon, 18 Aug 2025 09:44:36 +0200
From: Stephan Gerhold <stephan.gerhold@linaro.org>
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>
Cc: Aleksandrs Vinarskis <alex.vinarskis@gmail.com>,
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
Message-ID: <aKLZ5M12Q-qTuB4n@linaro.org>
References: <20250814-x1e80100-add-edp-hpd-v1-0-a52804db53f6@linaro.org>
 <20250814-x1e80100-add-edp-hpd-v1-1-a52804db53f6@linaro.org>
 <pmhy2ogyorelllgandehtzlen64tzegp5pc6fkg7al7xzjcb2h@lq4lpaaavr6j>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pmhy2ogyorelllgandehtzlen64tzegp5pc6fkg7al7xzjcb2h@lq4lpaaavr6j>

On Sat, Aug 16, 2025 at 01:06:50AM +0300, Dmitry Baryshkov wrote:
> On Thu, Aug 14, 2025 at 03:30:28PM +0200, Stephan Gerhold wrote:
> > At the moment, we indirectly rely on the boot firmware to set up the
> > pinctrl for the eDP HPD line coming from the internal display. If the boot
> > firmware does not configure the display (e.g. because a different display
> > is selected for output in the UEFI settings), then the display fails to
> > come up and there are several errors in the kernel log:
> > 
> >  [drm:dpu_encoder_phys_vid_wait_for_commit_done:544] [dpu error]vblank timeout: 80020041
> >  [drm:dpu_kms_wait_for_commit_done:524] [dpu error]wait for commit done returned -110
> >  [drm:dpu_encoder_frame_done_timeout:2715] [dpu error]enc40 frame done timeout
> >  ...
> > 
> > Fix this by adding the missing pinctrl for gpio119 (func1/edp0_hot and
> > bias-disable according to the ACPI DSDT).
> > 
> > Fixes: 6516961352a1 ("arm64: dts: qcom: Add support for X1-based Asus Zenbook A14")
> > Signed-off-by: Stephan Gerhold <stephan.gerhold@linaro.org>
> > ---
> >  arch/arm64/boot/dts/qcom/x1-asus-zenbook-a14.dtsi | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> > 
> > diff --git a/arch/arm64/boot/dts/qcom/x1-asus-zenbook-a14.dtsi b/arch/arm64/boot/dts/qcom/x1-asus-zenbook-a14.dtsi
> > index 16d045cf64c08c02c420787e000f4f45cfc2c6ff..613c675aac296f931293a1ba3d8506c6663bad21 100644
> > --- a/arch/arm64/boot/dts/qcom/x1-asus-zenbook-a14.dtsi
> > +++ b/arch/arm64/boot/dts/qcom/x1-asus-zenbook-a14.dtsi
> > @@ -1001,6 +1001,9 @@ &mdss_dp1_out {
> >  &mdss_dp3 {
> >  	/delete-property/ #sound-dai-cells;
> >  
> > +	pinctrl-0 = <&edp_hpd_default>;
> > +	pinctrl-names = "default";
> > +
> >  	status = "okay";
> >  
> >  	aux-bus {
> > @@ -1236,6 +1239,12 @@ cam_indicator_en: cam-indicator-en-state {
> >  		bias-disable;
> >  	};
> >  
> > +	edp_hpd_default: edp-hpd-default-state {
> > +		pins = "gpio119";
> > +		function = "edp0_hot";
> > +		bias-disable;
> > +	};
> 
> I think this is common enough. Let's maybe push this into the SoC dtsi
> instead of copying it to all devices?
> 

I had it there before, but Johan commented on the patch set from Chris
that he would prefer to keep the potentially board-specific pinctrl out
of the SoC dtsi [1]. So I can either address his feedback or yours. :-)

There isn't really a convention for X1E either - we have a wild mix
where some pinctrl is defined in the SoC dtsi (UART, I2C, SDHCI, ...)
and others is copied for each board (e.g. PCIe).

The reason I chose this approach is that I didn't feel it is guaranteed
that the HPD pin has external pull down. It seems to be the case on most
devices, but in theory a device could maybe rely on the internal pull
down. Might be better to have it explicitly defined, the 5 additional
lines are not that much at the end.

I'm also fine with moving it. Perhaps Bjorn or Konrad could comment if
they would prefer to have the pinctrl template defined in the SoC dtsi?

Thanks,
Stephan

[1]: https://lore.kernel.org/linux-arm-msm/Z_kB3jOH04-zFnym@hovoldconsulting.com/

