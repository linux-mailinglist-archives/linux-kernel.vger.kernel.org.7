Return-Path: <linux-kernel+bounces-849822-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 69062BD0FE8
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 02:26:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E33A23472A2
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 00:26:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AE001E9B0D;
	Mon, 13 Oct 2025 00:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IZVgnal4"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 683881DA0E1
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 00:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760315169; cv=none; b=KwEJSJvkEqKNsEpScNwUzMN47O45DpDYGuUiwcvQ3+4O0r8W/28ovmZV10GqgQWtKyfnH006Xdz0ZPEVezFg+jVkOuYZVzS3Olc+D2kPl+rmK+J5lUcqNKkNT7d4i40IkPPB1fL3Oom2vf4cVEwFjT4uKQwH1NfS8x+72pbGL+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760315169; c=relaxed/simple;
	bh=qkI2fr9nMZfALOyGjObaRxpnsyOdhK8rFNnreSoGoGE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=RjUqtDs1gLM3bPPgyJIHhggL7pTNYlKBNeGgdLD+mUk3NzAhxrMtfO8NcP/jvvJuu8GZFS1RJ8IFId+UL0etdfoN7+T/qCEJarLq82eeSIvZZnmrnGH2/K6iWazLfrRea7Lj3itXLsLE9pL0oWq9m/PdGsTO7HHvekfcBeYf6r4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IZVgnal4; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-77f68dfe7d9so365143b3a.3
        for <linux-kernel@vger.kernel.org>; Sun, 12 Oct 2025 17:26:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760315167; x=1760919967; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=52qW7t9qFGfmc8duc2ZnW0Dwh+huBp5wpeF7g/x2FgA=;
        b=IZVgnal4TPPqm+BLGQR3Q68J2N7ADkxVk+y/3rAoQGbpG5cLWE1Cg7Z1OMa6Mw0KoM
         JCdZEsZ6v4bluXZqUIVA3dyClff+i+C698IBEWSIHPzJ3AplGx+mKw8Fr3gonRNKMchL
         B28SSZOe5Lh0c0VAkG4bXnSrni7JlVJb6tmVNAOuMD0tzoKRRjpp+6A8P8g594C5Sgar
         lM0LxTGC2cPP6Jguu/5CSs/96bJaTBcJA2STLul9TWueZlLVD+R4pk/4KvShzvT/IBXc
         b+vThXRS0Br/Ii1tTe5d6+qoIeHw/qJtESfVGCQwJhpIvcNqRw/qcmtIovdQKaozGFOq
         a5uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760315167; x=1760919967;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=52qW7t9qFGfmc8duc2ZnW0Dwh+huBp5wpeF7g/x2FgA=;
        b=LGFBlD4qS3pyGzUtv2xPp/tTiCz55dyyG8XFra3J+dN2dW3/iv0kCO96vOHUzDZofq
         A6HjhBT+yQO70ZUj2R31TXqV6XoCnXr7mv4sjRIy0mpXSdXPsZnhjB7aGFTs9Nn1bzot
         KyAlXSbyQ6ZxiRcitcYSxVce3rCriSJMZLjftQA9hdxVTMTzb1orR0DNUnYnPj+CyBjk
         mtNLBD6fFbeC7TQ+09uJZr2oA8GVJV3UnhlhRTgjDH2VFfHaN9h+I0ZaadYBIxjKnTnA
         kgOpqzgqouiwWoiO+OP6wXWqpxYLb1N3IlPbGXs7FfSk5bJitnDibyz77BRvWMdxwyxK
         HoSg==
X-Forwarded-Encrypted: i=1; AJvYcCX1oRu4yZjsDf/o3ItFA5x2isSixwmJjBP5S+FKEwKlnvG3ZCvz+GyMfAIqbqTD+++7bC1WPcgRSEPMOkc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/ugUHJ128pn5qRdGJb+KOXPJV11X0I8w8o1k6+heKPw1FKOWG
	PAdJTDo+ZXA648g3Yk1IPGgaIgJn0cKmBcDvcjsWciwnZiwewpDu6J6NTwSppIRUwZ8=
X-Gm-Gg: ASbGncuSfWE96u/yhh/+9hpNL3Eyrwy6321r4UxZByvn3Qv2VQGqyHH68d35HjGf/fX
	vzBtThif4EH8beJJ7uA+ncEBqHnwuWqoGLXIucmVyBPCGpb1+HPjNabjqICukj+MNPWaf0mMIQr
	qiC+PuZFnlSE/HE6vf4kumHVmfM87MmUXf2PUQDXcrYeVLpnRNe0pxxqJ30THBcSE74vRK1WVIp
	0g+34CxkjY47Me9o/Pkol2KLe4psXERkBc5xyoYOM6KOHQG5yl/b0mYCIM+V6tfYQ9PI18KCo03
	E6eWWtF5y1+0YNKyniapAk12fWHl1Ar59qPoOK91jiSUvUaxLmkB8Kz1w7DqLubsuImnALx3PNx
	K0ItZbgS+kjxeE5XDq8fW64qHe9zN2OfQg5sFmAYOkDKTeABOHrKTueA4SSCIM+47KRYQ4hM=
X-Google-Smtp-Source: AGHT+IGvoh+AZ0SUxDtJK2K9IGdS0Lw3Mw50fcHGc3vf/lr8P7A3VShG6ttG1Wy2MqgJYHaTqL7WRQ==
X-Received: by 2002:a05:6a00:1250:b0:781:1bf7:8c66 with SMTP id d2e1a72fcca58-79387c1ae19mr13001682b3a.7.1760315167533;
        Sun, 12 Oct 2025 17:26:07 -0700 (PDT)
Received: from [127.0.1.1] ([121.134.152.93])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7992d096740sm9624862b3a.38.2025.10.12.17.26.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Oct 2025 17:26:07 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
 Kaustabh Chakraborty <kauschluss@disroot.org>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250928-exynos7870-dt-fixes-v1-7-a40e77a73f16@disroot.org>
References: <20250928-exynos7870-dt-fixes-v1-0-a40e77a73f16@disroot.org>
 <20250928-exynos7870-dt-fixes-v1-7-a40e77a73f16@disroot.org>
Subject: Re: (subset) [PATCH 7/7] arm64: dts: exynos7870-on7xelte: add
 bus-width to mmc0 node
Message-Id: <176031516254.11660.11521062491196215930.b4-ty@linaro.org>
Date: Mon, 13 Oct 2025 02:26:02 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Sun, 28 Sep 2025 22:13:58 +0530, Kaustabh Chakraborty wrote:
> Add the bus-width property in &mmc0 node. The Exynos DWMMC driver
> assumes bus width to be 8 if not present in devicetree, so at least with
> respect to the Linux kernel, this doesn't introduce any functional
> changes. But other drivers referring to it may not. Either way, without
> the bus-width property the hardware description remains incomplete.
> 
> 
> [...]

Applied, thanks!

[7/7] arm64: dts: exynos7870-on7xelte: add bus-width to mmc0 node
      https://git.kernel.org/krzk/linux/c/2bb07378bae9504f5122bfbe4a6082bcdcc8bdf6

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


