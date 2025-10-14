Return-Path: <linux-kernel+bounces-852322-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C5E0BD8ABE
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 12:09:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E11364F02D8
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 10:09:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D320D2FB984;
	Tue, 14 Oct 2025 10:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HgM6NoUj"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 672B12EBDD0
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 10:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760436564; cv=none; b=hfClbwxrCR+Bd5JaQoD4n1Ck2GbGuy3jilM/yxfMqxKHNoLE6Ukzv483DF6PlTk0Xaq0siAtv7aIJAfs0YPOvhtw89I0PHHGUwIcYqIyiPXtB6B24TyCmpSgymo+O54Hmwb4x4eEVr3PAM9nN03wbrqcxQuFKkHmxoyhXtOMkTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760436564; c=relaxed/simple;
	bh=8NXJFlFsvTG3EbIAl4tjRuPzI2AZxM6EiXric7dRspY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FPvg4ew/6zoQQ8dz+5gJfOAbHx06w7zxE5sYItMeQHwosYVLFmSBPmRPE5CNNKbry+wADfJ6Ov3dWDl0IdONHBisD/ZkvkUVQqjTaVowSXnqusrce/I4uZ4vdS4B3nbu6BqwesCjXzkTNA6buAmSZ2iUjlnHA7LYXfrbMGOe6CY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HgM6NoUj; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-46e4ad36541so53718325e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 03:09:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760436561; x=1761041361; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=d/ttxF/dZw7J4JSYZeZOo0fN3D/uqFn7kWok+tyJugc=;
        b=HgM6NoUjMJKx6ah9M6XamaxyIR72OUtfBcmpK/K9DgIWDCvzVIAzlq9XpiuoI5N0Sm
         ReB62m+bwuHjf9mVxPQHRyjeLtMqPFxQ98q5+G4TAt1C2IDNtcoVCWSLJnUjQ3a7zPKr
         yeXC3Co0GuptdgKf9dgSu95lxCDZvA1E1TY20QA2AI/4gKEk2wqyGHKYAtX7nUMTyWGt
         Z2HzsxV3bPCbFV9uXXrz7skMvl96QwHKuMdRuDJrFxLhJjRrUeSEt3hL6eOBtwMe+QwU
         +jWeNOiHp6f+CY1pjSxBV3xGhWe0sgpOeE9WkwV87aadaN/aJD4ugnE1jTqvqtqnUiIS
         a4Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760436561; x=1761041361;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d/ttxF/dZw7J4JSYZeZOo0fN3D/uqFn7kWok+tyJugc=;
        b=HQ6as7dmfkQoS7icRKjOewieiodmix39ZH+d/spHgepSKYby1zJXF7o0OgNMDWyGy9
         O0CgYkSBlTXl/GUDg7K1s/H6k1S7LIBiNGLLxsAb1eSAxCfaL4oaFySkqL2szHTP//Zf
         g6wUXMXTuzO3f95EPHYZFsfVt1UtrNizOznid9TWR0g0+qRPrTlhoOchftYirv9ib9qK
         Z+0yFSRvt4xP9G6VXpDVPsjLb8/hPN90n3gIxWK9loEnt33ftkMw7pe6/d9BWR/+DnLi
         SYbZmGHW42vSEzQ0fcztOMnrKILpawAcA/kQ7JayJbAX9I3MSNy8Tq+ccrktl8r8Au2W
         IyKQ==
X-Forwarded-Encrypted: i=1; AJvYcCW9zaX94KRCEr6+McB6yRtMGz6MmUa8kibmHP7xys4zm2G1eSWjz8WZ6tPo70dhhoOHF44iE3gVX4jNJwU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGsBQhvc5zcEQsQUBCeaWEuVol2cvql2pG3UdgVXPZbbDrEtY9
	RXOdOoXvVonE84zNZFGcVnnVS0f0vms/vo8iWyQCCM5igS1C8tzTLsPpuV1di4bSQFQ=
X-Gm-Gg: ASbGncujdcsaC3u3enztN3CLys5s+mm5Q5NX9l0XHcbjE7bYKDXX0bozJyMAnmfOAf3
	+EXdKfUiD3f3nAll16OtxKxU5QuDfW7gKGFU8vs4ENb5DlB+bVxDjEwg0DWnAyd2GJt4hXqyL5D
	CKPALcgZ+3KEjoZy7crm756gD8wildVXdgEzeC79USJv1FROf7J3P3JZG6hkSmAOLvpnyDD21UE
	yJtO32B5dYT4A+UReiYcmUGNfK9vENCZCefDMhVbk+m89UcH8o2SmNiPEzaNxGcejTM4i2av4DT
	wxEryWV4iF0UHYpliuLHoLEDTiFGuR1O4QBjyGLzji50XA12CyULSssKOEIoo6TCleKlL+XyiTp
	pbEQR0l+SWaqRl0fH2G/3o6RzMpqkTUVJ67pWgupu0g==
X-Google-Smtp-Source: AGHT+IGhYcM1EjuHseqFI8tRZvchmyS35I7xUk/4EU6AC6XLlnEooj6iq3rh59ZcN+RWuk1UNgay5A==
X-Received: by 2002:a05:600c:a341:b0:46e:74bb:6bc with SMTP id 5b1f17b1804b1-46fa9a8932cmr155892235e9.5.1760436560606;
        Tue, 14 Oct 2025 03:09:20 -0700 (PDT)
Received: from linaro.org ([86.121.7.169])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46fab3d2c1asm149604235e9.1.2025.10.14.03.09.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 03:09:19 -0700 (PDT)
Date: Tue, 14 Oct 2025 13:09:17 +0300
From: Abel Vesa <abel.vesa@linaro.org>
To: Vinod Koul <vkoul@kernel.org>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>
Cc: Dmitry Baryshkov <lumag@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
	linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, 
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Subject: Re: [PATCH v3 0/4] phy: qcom: edp: Add support for Glymur platform
Message-ID: <c6w5wqjqdimn3cfex3n6aynol4hfqejct23ziq4wcwj2svuk5g@tzfi6fnbpc4k>
References: <20251014-phy-qcom-edp-add-glymur-support-v3-0-2772837032ef@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251014-phy-qcom-edp-add-glymur-support-v3-0-2772837032ef@linaro.org>

On 25-10-14 13:02:26, Abel Vesa wrote:
> The Glymur platform implements the eDP/DP PHY version 8.
> Add the necessary registers, rework the driver to accommodate
> this new version and add the Glymur specific configuration data.
> 
> This patchset depends on:
> https://lore.kernel.org/all/20250909-phy-qcom-edp-add-missing-refclk-v3-0-4ec55a0512ab@linaro.org/
> 
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---

Urgh, for some reason, b4 re-enrolled (lost old branch) this one as v3 instead.

This is actually v4. Hopefully, v4 will know to pick this one up when applying.

Sorry about the mess.

> Changes in v4:
> - Force fallthrough for 5400 and 8100 link rates in qcom_edp_com_configure_pll_v8,
>   as they use the same values.
> - Picked up Rob's and Konrad's R-b tags.
> 
> Changes in v3:
> - Split the DP_AUX_CFG_SIZE change into as separate patch, as per
>   Konrad's request.
> - Re-worded the dt-bindings commit, as per Krzysztof's request.
> - Link to v2: https://lore.kernel.org/r/20250909-phy-qcom-edp-add-glymur-support-v2-0-02553381e47d@linaro.org
> 
> Changes in v2:
> - Sorted alphabetically the both the compatible and v8 specific
>   configuration.
> - Prefixed the new offsets with DP in order differentiate from PCIe ones
> - Link to v1: https://lore.kernel.org/r/20250904-phy-qcom-edp-add-glymur-support-v1-0-e83c6b9a145b@linaro.org
> 
> ---
> Abel Vesa (4):
>       dt-bindings: phy: Add DP PHY compatible for Glymur
>       phy: qcom: edp: Fix the DP_PHY_AUX_CFG registers count
>       phy: qcom-qmp: qserdes-com: Add v8 DP-specific qserdes register offsets
>       phy: qcom: edp: Add Glymur platform support
> 
>  .../devicetree/bindings/phy/qcom,edp-phy.yaml      |   2 +
>  drivers/phy/qualcomm/phy-qcom-edp.c                | 232 ++++++++++++++++++++-
>  .../phy/qualcomm/phy-qcom-qmp-dp-qserdes-com-v8.h  |  52 +++++
>  3 files changed, 279 insertions(+), 7 deletions(-)
> ---
> base-commit: b529e9498b7948df2be579282cbf0d5a9a3b7f9a
> change-id: 20250903-phy-qcom-edp-add-glymur-support-2a8117d92b89
> 
> Best regards,
> -- 
> Abel Vesa <abel.vesa@linaro.org>
> 

