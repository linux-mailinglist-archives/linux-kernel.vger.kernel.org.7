Return-Path: <linux-kernel+bounces-888054-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 32A19C39B56
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 10:01:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D221B3500F6
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 09:01:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED81630AAB7;
	Thu,  6 Nov 2025 09:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qlw5w1+N"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40B30309F0F;
	Thu,  6 Nov 2025 09:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762419656; cv=none; b=udCAyFX3Rs2FFQNsW0RPahO3+O70krozuTI+qf4WEiV+kjv8KA1InBYWCocXrJrHzgeziwVOONSGbWejrJF5+8DTjfdiHKC7ln0SbukU8yWAt4APZlJJhH1F/NRXyrdjamujEZvIo+hcv0jGq+TjE4rqCQi+oDEhPekvpq8CKJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762419656; c=relaxed/simple;
	bh=KVHSoYJz2fwVZGAv/nzMWmyyfkWgXd7S9jVEFUkbYwo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eat1c0dQJi/VQiYjbcVR83RkHMaw4lXK6RqD7D/haDphsQUM8Vcj0Yi3IFgMT2ZNDe26LNcJh00mMpy0avpHj0CFj0hhI3FuWjw0J77ys5VfOvOBBG+ZAcko0C8UpiMcPS+rgAKrQ/fequZlkZPqJQ50RSFT4K+oatL8fXh0Z8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qlw5w1+N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E4CEC4CEFB;
	Thu,  6 Nov 2025 09:00:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762419656;
	bh=KVHSoYJz2fwVZGAv/nzMWmyyfkWgXd7S9jVEFUkbYwo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qlw5w1+NizkOPD/dk3OD9kbZdpOFMgUPNCC9J8kf1XlJfrHK+jjwQPQubxx374/hk
	 Npm22YxBUAG7CSrWPQJdC33yE8EVP1RCv0deqhKAeK4wvcecOWjzBFUWt9E2QyTxWN
	 JczIRfA8P5JE3x8Awuz+FPRVcx49/iuURwOsFlcQYK09lr7QV0NDfLzlr0lSEVM36Y
	 qbn9dhWm1jufOB0WSUkqYS8cEqCQK7rop/LXPPVexsZ4ud4OZsFbxL8xwO47wBlY1S
	 6lp+YoSJMO0XCC4e+xYTI+xA/PQiTVdR+7EX/Aof6IqvFvocnqCk8dhjKj7hYkN98h
	 tX0n8fFBMV6BQ==
Date: Thu, 6 Nov 2025 10:00:53 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Xianwei Zhao <xianwei.zhao@amlogic.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Kevin Hilman <khilman@baylibre.com>, 
	Jerome Brunet <jbrunet@baylibre.com>, Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
	Heiner Kallweit <hkallweit1@gmail.com>, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org
Subject: Re: [PATCH 1/5] dt-bindings: interrupt-controller: Add support for
 Amlogic S6 S7 and S7D SoCs
Message-ID: <20251106-gleaming-taipan-of-penetration-147b8a@kuoka>
References: <20251105-irqchip-gpio-s6-s7-s7d-v1-0-b4d1fe4781c1@amlogic.com>
 <20251105-irqchip-gpio-s6-s7-s7d-v1-1-b4d1fe4781c1@amlogic.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251105-irqchip-gpio-s6-s7-s7d-v1-1-b4d1fe4781c1@amlogic.com>

On Wed, Nov 05, 2025 at 05:45:32PM +0800, Xianwei Zhao wrote:
> Update dt-binding document for GPIO interrupt controller
> of Amlogic S6 S7 and S7D SoCs.
> 
> Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
> ---
>  .../bindings/interrupt-controller/amlogic,meson-gpio-intc.yaml         | 3 +++
>  1 file changed, 3 insertions(+)

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


