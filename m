Return-Path: <linux-kernel+bounces-769536-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 49F16B26FF0
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 22:09:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0D5DF7AFBDC
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 20:07:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F336E24A079;
	Thu, 14 Aug 2025 20:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AwSLfIGe"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B9A6245003
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 20:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755202141; cv=none; b=qoMUWFJyWwx3e2dSalfJXj2p5G0FZaDdIxpt7+USIeYwGJCa+2Kg2YmC3uA6TWJ8dZE1IFpy4aHw5RijpU8vxU0RKOswAlgVaXiFYzC07j4dVFQGxQ/nm1vjgvX0GfvrT1kOgeFSfM2xlaPN9f10a0oy4oOi+Kzt47Gqx4KzrDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755202141; c=relaxed/simple;
	bh=hpEZj2hgTAHBNqpJr1wwGW2jnAWJzDDDdJiItxxERdo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VOdmSvgIVm5sorqwp2QxYzckfSMhYdkslCLfvfcQGG54enOoww3WtHB8aZlRoCjpnzec61v0WUkzoVFuQF4U9ROoz5DnSrmK4T0+vOW8KhOhs96TDDff0y5fj77JFwOiyDg/Ig1aE73ra1zdo9Ug/UBrFtIKXRk2ZBLjrCsTbUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=AwSLfIGe; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3b9edf504e6so694734f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 13:08:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755202138; x=1755806938; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=89vmInG+qHg13f/BKcLEh+mZzeLc6IUOY0zinQ8e3nI=;
        b=AwSLfIGeE/4XMHgd3vEUuljiLFNP713y5R23KvOSmCnMUgM0wKfGetvLtzdSLRcG5j
         3TKWkosBu4rMsbnk/BOKHkTkncf8lfissmpc7I0OqnB8mY1ABET5cu1aCSR36QuU9kGV
         sWwZc3wHVAX2I4sAmHIEBb3lTkIuxRdMYuyvFXwGrIgaAbEVxoA67th7m9yagSAuyQYe
         I/S5xeJYM9a69RVhXVtWw00hj/xVhqIFNUm2Xy6XULMoVwrhbFrROgUVGezsc6p7TLpt
         Wor+lyhAecVFBUygEBTeL8xa3VrncmKK0D1SeUSOTAXwXYrINSRPuGNgdpnhzoT7T1ra
         GT7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755202138; x=1755806938;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=89vmInG+qHg13f/BKcLEh+mZzeLc6IUOY0zinQ8e3nI=;
        b=fgusHPeUPAEB7kdRbWQKLPgKMGaSMH7n3gEwGiwXyAOJGqzgjg+BPLCbJEv3bdiWuX
         hr4sky29Ir+QIfLJAiyq6SOJ3Hi2qbvBrTzvzjthRfo6QPoR6MvZmSOBHSwffvd4c+op
         1PyRYE5ypxtAxkGqa5ePFPelyps3tKY7O0NIi+sLGNSMZJsfS/XCGfIlTKC8eTy890TR
         bugPIGhVpE1oKwlipQzDXQUMJ5gyCIemKxBmIq3HPVgLGQI7fl15GdD8H/4yM23S5kfk
         NP4juVO5EZiKlQHoGHLuJ//k4JrRO+i82LsEwqbamzHSeBzEuEQ6z5pF2Wg6FQ/YUKpx
         AbiA==
X-Forwarded-Encrypted: i=1; AJvYcCWS1DsCg991fNrEW2PTtCIlc1w/dgDEze1SafrlKKaqvaW7LlvFQKIMcHOzszIGt0oD/RCjz3064W9fp3I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzru/54QWrFfxlit35QLM/VZT7QBFkZ+hbtHhyGd107OydPYKKb
	Kq5odyL5eKSS02/AbcoppZTjCzQ9+vyQR4YuS+PyxHqf/pm7QT5yjJcxGXW80+KJDIxsieIhaSD
	oGnXHw3Skw1Xnloy9/lf9twgbDlCXmmbCcYhSMUKHwA==
X-Gm-Gg: ASbGncsDSD7nV1uQOL81xks4Z9ajryvXlO3lSKCBHAqoDQpEU5NRfJt2rwQTFgWhcZc
	ntutjq42lWFjsGJO0eFxKZYdbos/e2LaTH+odLgBuncTK7KUoWUR6CEc+7QiPrB8umooyehl0P6
	J0qCyV3mwBNJilftT/RwL+BS8q91Tzm88N8B9zZmuOpL3F+EwWxOz6d1PLquJz19AbtFfi+TfTJ
	ST0i85MDA==
X-Google-Smtp-Source: AGHT+IGKc9ZBNpWJ4I9Z0j/oToKVZ6aTO0FfDgJPF8j8gtu/zqmiqJg8fmAnLHK6f8AkBPmsmQMx8efcURRD131GeXk=
X-Received: by 2002:a5d:5f48:0:b0:3a4:fbaf:749e with SMTP id
 ffacd0b85a97d-3b9edf5c16fmr3617118f8f.49.1755202137594; Thu, 14 Aug 2025
 13:08:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250814-x1e80100-add-edp-hpd-v1-0-a52804db53f6@linaro.org> <20250814-x1e80100-add-edp-hpd-v1-3-a52804db53f6@linaro.org>
In-Reply-To: <20250814-x1e80100-add-edp-hpd-v1-3-a52804db53f6@linaro.org>
From: Christopher Obbard <christopher.obbard@linaro.org>
Date: Thu, 14 Aug 2025 21:08:46 +0100
X-Gm-Features: Ac12FXwcy2rijYKbCWBUafOnzlxRftZ29_CYuP5mDfKmcaHzvsr3lHSMtQFoOA0
Message-ID: <CACr-zFAJWT=01Pz8EOKpwLV6PZBq_--tU=-=CO1n6rkpOE0RMQ@mail.gmail.com>
Subject: Re: [PATCH 3/9] arm64: dts: qcom: x1e78100-lenovo-thinkpad-t14s: Add
 missing pinctrl for eDP HPD
To: Stephan Gerhold <stephan.gerhold@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Aleksandrs Vinarskis <alex.vinarskis@gmail.com>, Abel Vesa <abel.vesa@linaro.org>, 
	Xilin Wu <wuxilin123@gmail.com>, Jens Glathe <jens.glathe@oldschoolsolutions.biz>, 
	Srinivas Kandagatla <srini@kernel.org>, Sibi Sankar <quic_sibis@quicinc.com>, 
	Rajendra Nayak <quic_rjendra@quicinc.com>, linux-arm-msm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Johan Hovold <johan@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Stephan,

On Thu, 14 Aug 2025 at 14:30, Stephan Gerhold
<stephan.gerhold@linaro.org> wrote:
>
> At the moment, we indirectly rely on the boot firmware to set up the
> pinctrl for the eDP HPD line coming from the internal display. If the boot
> firmware does not configure the display (e.g. because a different display
> is selected for output in the UEFI settings), then the display fails to
> come up and there are several errors in the kernel log:
>
>  [drm:dpu_encoder_phys_vid_wait_for_commit_done:544] [dpu error]vblank timeout: 80020041
>  [drm:dpu_kms_wait_for_commit_done:524] [dpu error]wait for commit done returned -110
>  [drm:dpu_encoder_frame_done_timeout:2715] [dpu error]enc40 frame done timeout
>  ...
>
> Fix this by adding the missing pinctrl for gpio119 (func1/edp0_hot and
> bias-disable according to the ACPI DSDT).
>
> Fixes: 7d1cbe2f4985 ("arm64: dts: qcom: Add X1E78100 ThinkPad T14s Gen 6")
> Signed-off-by: Stephan Gerhold <stephan.gerhold@linaro.org>

Tested-by: Christopher Obbard <christopher.obbard@linaro.org>
Reviewed-by: Christopher Obbard <christopher.obbard@linaro.org>

> ---
>  arch/arm64/boot/dts/qcom/x1e78100-lenovo-thinkpad-t14s.dtsi | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/qcom/x1e78100-lenovo-thinkpad-t14s.dtsi b/arch/arm64/boot/dts/qcom/x1e78100-lenovo-thinkpad-t14s.dtsi
> index 4cf61c2a34e31233b1adc93332bcabef22de3f86..b775110bbcaff165cac259cacc7509a64746b987 100644
> --- a/arch/arm64/boot/dts/qcom/x1e78100-lenovo-thinkpad-t14s.dtsi
> +++ b/arch/arm64/boot/dts/qcom/x1e78100-lenovo-thinkpad-t14s.dtsi
> @@ -1010,6 +1010,9 @@ &mdss_dp1_out {
>  &mdss_dp3 {
>         /delete-property/ #sound-dai-cells;
>
> +       pinctrl-0 = <&edp_hpd_default>;
> +       pinctrl-names = "default";
> +
>         status = "okay";
>
>         aux-bus {
> @@ -1263,6 +1266,12 @@ &tlmm {
>                                <72 2>, /* Secure EC I2C connection (?) */
>                                <238 1>; /* UFS Reset */
>
> +       edp_hpd_default: edp-hpd-default-state {
> +               pins = "gpio119";
> +               function = "edp0_hot";
> +               bias-disable;
> +       };
> +
>         eusb3_reset_n: eusb3-reset-n-state {
>                 pins = "gpio6";
>                 function = "gpio";
>
> --
> 2.50.1
>

