Return-Path: <linux-kernel+bounces-804426-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BCA9B4769F
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 21:00:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12C133AE7E8
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 19:00:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F3FB285060;
	Sat,  6 Sep 2025 19:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d5y61xJo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E33126A1A8;
	Sat,  6 Sep 2025 19:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757185214; cv=none; b=mjOho6C9LQzspXhwef+2RATxjGbL8oMnaPicTdgYPKILKbNDttbBm7o9tj50bFb11yb2D9DPC5GQii1to5ha6BHVKIg2/yB+Jiy37mb43usNL6/kR4Gtc8AWDAHAWOpgpJyY/QUKQCpTJoG7D4xscfNbjT1mCu7mUP/KGnoOFvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757185214; c=relaxed/simple;
	bh=CcV57OvdgwUpKL1hzOguejWbAFsaeT5MKm3AdLQYygs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uXc+Nisdp6svMfbHhTy27KlhnPfwpU8gJz4zjErf45NGWTwVZtBFPaa+iSWC+zdIp1k7mHw+dzWTbxLAtx234/5m6RPbZVMX2jNKoDz3kYv+6sg02UWRwpZ6uGQqj5RVTKggnnF5+elrFo1yBpS/c1rrFCmzo9xRsnOh7kXeQjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d5y61xJo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDBF2C4CEE7;
	Sat,  6 Sep 2025 19:00:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757185213;
	bh=CcV57OvdgwUpKL1hzOguejWbAFsaeT5MKm3AdLQYygs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=d5y61xJowrV1fBEemh9CqGiLJEKGgOc2WPzK/N2x6xprkJJrOZqoXDM7o24LZcFjj
	 hcQxWzJJ2Gpk/I8dCbX2kx6xnUUCUzAG/lKpnhDnQ4KDmnVSfBWXwN45+qunYSGMZe
	 O9aqcXyATpTyhXzjUR/Gi8+F+9beR0jhTs6u240oWXHQhzvYaHtoDdlMf+UqLYbb4g
	 v0CqEHRI40H65gc/tPKQaG55xmRM69v/JQMYulUIcinHcQJZk3pvfNIi4VtZBv/8R+
	 sO4lblBeXulRMklXl9HY+TWepXpxsfKzEiufWyjWLD9XUL4XvyeYBvw0lwVG65/XVb
	 FFVcMTgTOggQw==
Date: Sat, 6 Sep 2025 14:00:13 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Mohammad Rafi Shaik <mohammad.rafi.shaik@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, Mark Brown <broonie@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, kernel@oss.qualcomm.com,
	prasad.kumpatla@oss.qualcomm.com, devicetree@vger.kernel.org,
	ajay.nandam@oss.qualcomm.com,
	Srinivas Kandagatla <srini@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
	Conor Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH v1 1/2] ASoC: dt-bindings: qcom,sm8250: Add QCS8300 sound
 card
Message-ID: <175718521242.1621347.30475789277054307.robh@kernel.org>
References: <20250905142647.2566951-1-mohammad.rafi.shaik@oss.qualcomm.com>
 <20250905142647.2566951-2-mohammad.rafi.shaik@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250905142647.2566951-2-mohammad.rafi.shaik@oss.qualcomm.com>


On Fri, 05 Sep 2025 19:56:46 +0530, Mohammad Rafi Shaik wrote:
> Add bindings for QCS8300 sound card, which looks fully
> compatible with existing SM8250.
> 
> Signed-off-by: Mohammad Rafi Shaik <mohammad.rafi.shaik@oss.qualcomm.com>
> ---
>  Documentation/devicetree/bindings/sound/qcom,sm8250.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


