Return-Path: <linux-kernel+bounces-824470-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 25226B89521
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 13:54:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4F2B3BC8A3
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 11:54:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FA1830CB58;
	Fri, 19 Sep 2025 11:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BC1M7mFm"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C63830CB4A
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 11:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758282880; cv=none; b=d6K5zgH0Wjc7hrtTF797zDjURCE4vkX5of8vgM2UsbUPRUVruo2BAdV4zg6RutUMZd/lxjkSrfDHxRaTPcLgLMG2TtIt4cdjiyXlVV0BCjXIhmp/ip/3tFxyI8kyfhQQDB3BWdPpWeQLPNnVGEaJAyFV9qDKmmATaGmsG4GkUAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758282880; c=relaxed/simple;
	bh=Iq/+HNrRZiJdlx1daWo5Fe9G3p7h2sfcOcvxda2ZB/4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VQBcVlq84KzwGtOH+84F37ONBD3VjKNUqxxDlCw6Hjnf8FsZidzdAr2VAqUiV1GumnoJ7vdTti6q1flPsg+v2bgKHE4yXdmxVlWN5G4bkH/rmzd+LfIJL2Q5kbGvp2WydjBGX9KFUsiA+zOcefBBbTFHv+u1/47h3C4+ZL90sIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=BC1M7mFm; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-45dd7b15a64so18024205e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 04:54:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1758282876; x=1758887676; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Zw5JhaXdnoe3jqyhiF/Ntgpl9bjPmMJVwWBx3p8kIAs=;
        b=BC1M7mFm8byL9uXGvMTtnQ+thiPosrh4/zpZYinnYft5Eu8Kd8LBHryRhIhV+orXFw
         PFDIkxStwVm5BxCHF98YAM4OGX+B2VHlrxbe3OafCLV6oC6SLSGsovesRnLN5lO/LA+l
         MgqZtb++9leTtSmgI7BgQmCvdvPfmOaFRdN+bz7N1VJ+rgIUwfuqdcFY0E/L9LXrQ2SD
         ZUGW6LXGesEEgAWj9khPAn/7S/Lgm/YVNU6W7ODvti+Vjb8pjBoKkUjqH1jFrIUUMRZA
         qfE0kRQDmqt6i4p2nQ/AAwu3SPN9QJZcSc+lX/PKZ+KgyhT0lpN8vazdJCd6uHb9mdpz
         ++MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758282876; x=1758887676;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zw5JhaXdnoe3jqyhiF/Ntgpl9bjPmMJVwWBx3p8kIAs=;
        b=sSoGgwvL4WtKU0u31yZqQiOJRRyLzN19Sm3FX5DtKwI4h20ZIcHjH6fd/QvWDNUg92
         ejObih5kouxRoR19abTf6ZW+8boOCtVl4tfgVz+B/HuKfXhlthAGG0KrVHNgO+EG6UKC
         x99zfd/QV1rUghthbX80xUCpj6q/U/+MbVLyM94ODUuigHeouDoiKVQXP3HN30l0KVLO
         T4aqhfJewDxSPuGE8V3UTeVKcVSou+M1cy1dlXoVTaLKa9PkRDc2inVkQQ6B3rw5FfuX
         Q6R2GfWbP0HSvuEyOP129xCSlqV8ayE5T/MsazX58o6Ofpok9RE/s7SndtDVSXDDI9Hw
         0B4w==
X-Forwarded-Encrypted: i=1; AJvYcCXHscJqRCfdAPDx51g6PDnQumNMYtQfWACcql4bvyipYvyqgarPnQlbPckdX/hAwyPZrigTcJhme3fS+9E=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIegVBvzpnWWrDPYqON3TgytwWO5a429/Pt/HvRkQsM4jmFopp
	bGjYrcPxMZGYEkh1MuGnZv18Q8nlPKh506mE4v0XzaxOtjK8IfqV1AEFFAIsw1CaFVs=
X-Gm-Gg: ASbGncvotsykfZkobFe/Y4i8J5JWcqQBOUVca50Iqw1py9lNz0tjpzEind6XuP4Yz/Y
	IN7cz6KBop166gMF2nb/MLsuze1N/VqJJyaCWHVX2QG82J/2WQ4E1WHJA1CCV9sKTRxDJS5AaWB
	HY5XO8ja0j7wQxg7Uc1aQjYX1+R7UX8jff9noO+ugbtK8doHeFTU7XyqirsIL3xs/4XYqMoUNmv
	VKbRKiiUTVm/AeDnX0NyfJA4N7BBE8nGQUkm2hB5qMd6vcy7NUzCSFavKBejjy82sQfTE4o1lkJ
	fYpNneIJH2/so+metl0EX2Z4KS0ka9hq7LcKQmYdBxPEt/rAK0feANtw23kRw9BMoQgG9VKxGAO
	E8TErx+//Wcjn2DaLED0G6Q==
X-Google-Smtp-Source: AGHT+IFty0LGXanrKQc8uiaU34t2aKCwoDXillmmR4k+u5DKXRZr2oxF+R0FQjEB+ClxtwJ90j4SFQ==
X-Received: by 2002:a05:600c:3e08:b0:45d:f680:3140 with SMTP id 5b1f17b1804b1-464f7027e14mr67841705e9.2.1758282876587;
        Fri, 19 Sep 2025 04:54:36 -0700 (PDT)
Received: from linaro.org ([86.121.170.194])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45f32085823sm81620805e9.0.2025.09.19.04.54.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Sep 2025 04:54:35 -0700 (PDT)
Date: Fri, 19 Sep 2025 14:54:34 +0300
From: Abel Vesa <abel.vesa@linaro.org>
To: Xilin Wu <sophon@radxa.com>
Cc: Vinod Koul <vkoul@kernel.org>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Dmitry Baryshkov <lumag@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Sibi Sankar <quic_sibis@quicinc.com>, 
	Rajendra Nayak <quic_rjendra@quicinc.com>, Johan Hovold <johan@kernel.org>, 
	Taniya Das <quic_tdas@quicinc.com>, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
	linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v3 0/3] phy: qcom: edp: Add missing ref clock to x1e80100
Message-ID: <qohctzmztibeoy4jv6unsvevdawfh2h3drrneo5wmbfkirokog@pfaz3vht5kjz>
References: <20250909-phy-qcom-edp-add-missing-refclk-v3-0-4ec55a0512ab@linaro.org>
 <6A43111ED3D39760+a88e4a65-5da8-4d3b-b27e-fa19037462c8@radxa.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6A43111ED3D39760+a88e4a65-5da8-4d3b-b27e-fa19037462c8@radxa.com>

On 25-09-19 19:06:36, Xilin Wu wrote:
> On 9/9/2025 3:33 PM, Abel Vesa wrote:
> > According to documentation, the DP PHY on x1e80100 has another clock
> > called ref.
> > 
> > The current X Elite devices supported upstream work fine without this
> > clock, because the boot firmware leaves this clock enabled. But we should
> > not rely on that. Also, when it comes to power management, this clock
> > needs to be also disabled on suspend. So even though this change breaks
> > the ABI, it is needed in order to make we disable this clock on runtime
> > PM, when that is going to be enabled in the driver.
> > 
> > So rework the driver to allow different number of clocks, fix the
> > dt-bindings schema and add the clock to the DT node as well.
> > 
> > Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> > ---
> > Changes in v3:
> > - Use dev_err_probe() on clocks parsing failure.
> > - Explain why the ABI break is necessary.
> > - Drop the extra 'clk' suffix from the clock name. So ref instead of
> >    refclk.
> > - Link to v2: https://lore.kernel.org/r/20250903-phy-qcom-edp-add-missing-refclk-v2-0-d88c1b0cdc1b@linaro.org
> > 
> > Changes in v2:
> > - Fix schema by adding the minItems, as suggested by Krzysztof.
> > - Use devm_clk_bulk_get_all, as suggested by Konrad.
> > - Rephrase the commit messages to reflect the flexible number of clocks.
> > - Link to v1: https://lore.kernel.org/r/20250730-phy-qcom-edp-add-missing-refclk-v1-0-6f78afeadbcf@linaro.org
> > 
> > ---
> > Abel Vesa (3):
> >        dt-bindings: phy: qcom-edp: Add missing clock for X Elite
> >        phy: qcom: edp: Make the number of clocks flexible
> >        arm64: dts: qcom: Add missing TCSR ref clock to the DP PHYs
> > 
> >   .../devicetree/bindings/phy/qcom,edp-phy.yaml      | 28 +++++++++++++++++++++-
> >   arch/arm64/boot/dts/qcom/x1e80100.dtsi             | 12 ++++++----
> >   drivers/phy/qualcomm/phy-qcom-edp.c                | 16 ++++++-------
> >   3 files changed, 43 insertions(+), 13 deletions(-)
> > ---
> > base-commit: 65dd046ef55861190ecde44c6d9fcde54b9fb77d
> > change-id: 20250730-phy-qcom-edp-add-missing-refclk-5ab82828f8e7
> > 
> > Best regards,
> 
> Hi,
> 
> I'm observing what looks like a related clock failure on sc8280xp when
> booting without a monitor connected to a DP-to-HDMI bridge on mdss0_dp2.

Am I to understand that this is triggered by this patchset ?

I don't see how though.

> 
> Do you think sc8280xp might require a similar fix, or could this be a
> different issue?

There is no TCSR clock controller on sc8280xp, so it must be something
else. My feeling is that this is probably triggered by the link clock
source not being parented to the clock generated by the PHY, or PHY PLL
isn't locked yet at that point, but I'm not sure.

I'm not able to reproduce this issue on my x13s.

