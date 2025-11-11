Return-Path: <linux-kernel+bounces-895795-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A47B9C4EEDE
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 17:05:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A7991885B4D
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 16:06:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27E253590DC;
	Tue, 11 Nov 2025 16:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GoNaWb3y"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC00F2D9780
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 16:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762877145; cv=none; b=UZzhK/tUNLszMZPG8tSeCQKvBs0Eh5p92toY6/t93Kie8Mn3DSbWp9qbmS/T+FH7XQnu97f4MatW0ABPoN4jmWBokTAISOYJS2TfO2JIzEinSNWGtKVzOhUlY4OHR8S24RLHfj0beRK/GV1wvVI/OFVLYXCVXEZFrVR/gn2lwkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762877145; c=relaxed/simple;
	bh=bh/aGYh2TxqNDfolJ2dzfp2J9SHIt4utWVkJr4yXJW8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=acP928ipK55Cg0PgjpPOoPMtSvhKOrbt22Wc3QeTn21riGW+zgYVGgrbY7AU4/6j6i83k54vA+foQCzu50/hNkKqQSCK5fX6CgWGOtfe5oHSsUufzHwq29gm0WYgfa8LbqTIPFOSWaCeKSU6gQC2E/KN/9F9IFeCGAoJtAjcfhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GoNaWb3y; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-47778704516so14453505e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 08:05:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762877142; x=1763481942; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+RZXbES+suQSnoFPsMGN23SzPRLTGjJvuz6wdaZN3k8=;
        b=GoNaWb3y1+D5XYlQ/izJ4rwTyemnzfXKoco2C5nUeZ8rZRi4nmwyxP/0W7g7AH26B6
         MydFRLDiiM2kjNQ9pp1+pHAhNOoG4hSp8LDLhfwv50i3J5wSXFJACAZdO1XLyBcQolWJ
         nwarMB7O4zmAIEig80pE2RUmbI7Ob/y7HrPodJd6ivDFpllw4li42EbkuJyhM+u3Tkcl
         MKV5m0buEsFLjTaAErJS4ZbzZH0RlTgjVvo0b9koC+kv0XywMvdVIBzstljHDJ/n9mmh
         /V01Zh/rPku7kVTI/8ssHs8Ga1wcF22ZxGZyyitVE/OMbWZ0i3aFDGLHWy4ZMGia52+S
         bkpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762877142; x=1763481942;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+RZXbES+suQSnoFPsMGN23SzPRLTGjJvuz6wdaZN3k8=;
        b=mtRVdt7Azfkf1GG0uuNzF9kTK+pwWj7xI2Iq3CTtwm7swI5DVm1cMqJfyzfDnSnT1t
         GW5K5wOz5JyNqAU6b9Mw92MgAb1V/zPFdNkM/mc9wXG0ISKXhZ8KgkkDABiJey9ooqG4
         l+O1fhET6yy2CF/H1f3qN0co1gLRW6aZ1M18sLiSxAVDuf2SpmEtPRh/nJbLJxgqVaKC
         mWMuzRjprVez+5RFS4Wg0NDorRq5RLiYRjaJswrO2SaRpxV0uXj4RcLAugYLAeXA5bjI
         7v3ODw6CNjkpz89U+Qg/5ko34hAal2Gbti2Q1uDM/6f+DbfBcjwaYTPl6UwFGw2yhc1q
         dtrw==
X-Forwarded-Encrypted: i=1; AJvYcCXrjws6zH6Ab7SEt6xqnfzwW3+S33hVe3wJPS+mPqRFhONOCAkDUsfDP2Rfuo6COA+FCT2n4EueIESUngY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYqFbjhAWP6jL85WGDmW2cX5FL+UXdvsvvPq96GuXp0wwZa2bq
	H5Ico7GLjfN7XhRj4JlzzqJzDifVWV9yKhYjVv3oISFM4ovt2WnHjEUUwk0z/yzlrJA=
X-Gm-Gg: ASbGnctAUcJ4u7CwFABWwaGEhoQSf40gx8H/zy73Tdxf86Ap8K1tIQJe0c82r301E0n
	SsYRheEVKPUIXmjWxIvyVn6TNx+1ncPlS4yXJr7t3oNgu0X3ZgIKnJvdqg5qm3x1lYuIFH8Ck3o
	jjc3s5rDb471JUBNJql3FMEoYAlalPu3eBgczjRPIkDNFLkEs0YmZQywSG8HeqM0y5RC2FMRMwb
	mTq9wjscNAPFLSLmy/2YRKYkhdmjxm3WPWq0JrRNiAt4+cJEj7dumhdpTwoP9QUxIZqePr6sUoZ
	b91c0ccsfm3scgndPGiT2XScvI9WThS92J19tSNZUjbfCJ2/hE3fjMEfMAKwRBFgx99pmwKn6Rd
	unrflRuzRINm09ojDzow9qxBff9C5hTd8sXO+4lKQCp77oogPkKIdPWR+1fymNuudWSkr1tmyYn
	v2TpIICY7qQDo7rKfuVF4=
X-Google-Smtp-Source: AGHT+IH+MYmpINWnsFKQUpl4/+4Jobxe4uN5z+gwXyp65Xhhafeom17agVpTYxk/6AzKP9Q1JVntow==
X-Received: by 2002:a05:600c:4ecc:b0:475:de05:661f with SMTP id 5b1f17b1804b1-4777329400bmr113603115e9.41.1762877142176;
        Tue, 11 Nov 2025 08:05:42 -0800 (PST)
Received: from hackbox.lan ([86.121.7.169])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4775ce2cde0sm384957555e9.15.2025.11.11.08.05.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 08:05:40 -0800 (PST)
From: Abel Vesa <abel.vesa@linaro.org>
To: Abel Vesa <abelvesa@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Fabio Estevam <festevam@gmail.com>, Philipp Zabel <p.zabel@pengutronix.de>, 
 Daniel Baluta <daniel.baluta@nxp.com>, 
 Shengjiu Wang <shengjiu.wang@nxp.com>, Frank Li <Frank.Li@nxp.com>, 
 Laurentiu Mihalcea <laurentiumihalcea111@gmail.com>
Cc: linux-clk@vger.kernel.org, imx@lists.linux.dev, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, 
 Pengutronix Kernel Team <kernel@pengutronix.de>
In-Reply-To: <20251104120301.913-1-laurentiumihalcea111@gmail.com>
References: <20251104120301.913-1-laurentiumihalcea111@gmail.com>
Subject: Re: [PATCH v4 0/8] Add support for i.MX8ULP's SIM LPAV
Message-Id: <176287713958.95002.12532568280694164920.b4-ty@linaro.org>
Date: Tue, 11 Nov 2025 18:05:39 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-dedf8


On Tue, 04 Nov 2025 04:02:53 -0800, Laurentiu Mihalcea wrote:
> The LPAV System Integration Module (SIM) is an IP found inside i.MX8ULP's
> LPAV subsystem, which offers clock gating, reset line
> assertion/de-assertion, and various other misc. options.
> 
> This series adds support for the IP by introducing a new clock HW provider
> driver and by modifying i.MX8MP's AUDIOMIX block control reset driver to
> allow it to be used for i.MX8ULP's SIM LPAV as well.
> 
> [...]

Applied, thanks!

[1/8] reset: imx8mp-audiomix: Fix bad mask values
      (no commit info)
[2/8] dt-bindings: clock: document 8ULP's SIM LPAV
      commit: 3b521bf8c51246466e2c337f1f2b60acfdfe82d6
[3/8] clk: imx: add driver for imx8ulp's sim lpav
      commit: fdc1dc7dd53b95805d3943ed36785c1ec812915e
[4/8] reset: imx8mp-audiomix: Drop unneeded macros
      (no commit info)
[5/8] reset: imx8mp-audiomix: Switch to using regmap API
      (no commit info)
[6/8] reset: imx8mp-audiomix: Extend the driver usage
      (no commit info)
[7/8] reset: imx8mp-audiomix: Support i.MX8ULP SIM LPAV
      (no commit info)
[8/8] arm64: dts: imx8ulp: add sim lpav node
      (no commit info)

Best regards,
-- 
Abel Vesa <abel.vesa@linaro.org>


