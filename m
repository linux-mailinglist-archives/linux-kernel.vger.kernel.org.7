Return-Path: <linux-kernel+bounces-885902-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 23328C34362
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 08:25:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 119F54E9053
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 07:25:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F60D2D5935;
	Wed,  5 Nov 2025 07:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iNL7Fy1O"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE87E2D24AB
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 07:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762327528; cv=none; b=QcwqAMffyVz0t1ktBr0CNBkuw1ay6TU9g01Y8hkopHTn0OC7H+9NcSO5HDBo06ycuswv+Cj5AbzrnKKll0X0+2NXdcKU/PVUH9LXi7dz0sQeeyM1svVmtNbOY/WpYBb4AsbmunrPwj3n9jUDPpl9FP8d8+gKzBWwrKVnZiKF2wU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762327528; c=relaxed/simple;
	bh=3MQHnfbexcJms+PA/tw+OrIpFP88dlcCh/W8jqhAOro=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Fl5uokcuyp66tRDs992TY/VkMDov9mDPxsSAJzt+YNOU5l0dD0NofV8J8+av18oVeiIkXYgiE9iUDUMth2uE8cyTOuXSalOTTcM0e2FbMLR1rBGDl252YPoq60ESX0PHTgsu7L6PzIMEC4aGHFuMWlsF/yfKtZqPLIIM5Ps09WM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=iNL7Fy1O; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b7270b7b767so1385266b.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 23:25:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762327525; x=1762932325; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FzyJ0fh/wAbVru2AIw9Z/iVWtj/2W/vCo97JCS7BrIo=;
        b=iNL7Fy1OY0+Dx9QAPDnlVHJl+cc3sXENxyOY6qqsxmiOI8/KIGCsHnlZ11mGvzdL4i
         udBuAtRhfrVU8IXZifgZKGC4r7TUPf6BiICiYaL52ux8H1Ip7Yc4gatf/Fm3+HwzVN8r
         TTtxnNkYlHN1yinjnEbsrAJMiglk1+2fB+G6pm6Kg67ditQO21OVAd3zGtJrkfP7IXlC
         YLoj2d1Lgpe4WXSSnSrWEE1gkrkdkuX+5NjhnqHJTmuhRfyEPzFvJ377Eiqky+ny0rhJ
         Wv9dxEbIb+n9UkDJIUPyZXfTMr3F8DNZn592pXisXWlJt6O9ZQUuOPOmsoGNpZHuYjFh
         5D9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762327525; x=1762932325;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FzyJ0fh/wAbVru2AIw9Z/iVWtj/2W/vCo97JCS7BrIo=;
        b=UgvABR3kCrAV/Fb/eer5kxdStVb6HblIXVUpTfT0hiQs7TjrpQbwooW3tBc7W+MXiV
         0DT2hmJUqLKwY3m/EuFqOfyrI2aDnCTE9wQlpOm8PWHGxuxCICINgLJWTkBJ5q004srP
         +vbZapxBtOBh5X9dH82N+zNMVKVeJYQmLegm6Won3Vec43VqgToHbcdNqPr2G+niMbPI
         BbUWeOoo7OXlNx6zH2fK3mOrBdIJ1F3H5L8Xb2zvMCsywO/gkwXWfFb7vwvIEFpru5h/
         bs87qgrRKkiXLh9vBTNdE3ionHbMnm56dKShy6Z511Ia0VX3PWOt95kGpmMKB12VEG+W
         cFNQ==
X-Forwarded-Encrypted: i=1; AJvYcCVjZWCZQQoF+aWFpRo0+ukiUhp6uHjkEumpM47txJiDcXr8TwGkdCpwUq/A8I6OIsERdRWbBp1xF2282nE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPXuHrSyD/5TrPoEfGWatNo1lOXnPabxBpnDFHNC+CH4dgzS/j
	JkyXwy0/Cl8Qn4Xrc6fILpYevQ8zt5eFdkQ7nroUVR6B0A+7mpSBiDFV5DrpVt1njfU=
X-Gm-Gg: ASbGncsYD5VtvvO3VljP55TRwsy42xekcLF71nGIzpHt0p2Ej7ECH3Gb9UV8XyBuu6x
	oDnYD7VJ/roCsPNJeUKcNvtP7Jp8JlmX0JnUJTzCV9zN8zAaoY9stobA1Xz6ZCPcvL742eDUSEX
	dEDoA56JDbGbrIz9O/XH0+hjQMpHY/XnOzeUEh176c2ctb/LMU5E6jVxdNGf2uSjgBiOwmWozF9
	NaMwEWlZtvsy6jmWsz7l9jq57qumqNWf82DuA+CSfsgSiiJBUHPMSQVtzI5QpQImlQIn9xd3NDg
	MDwSvmjAf4ISUzNufQsfe9NmFjnrBH5iGWW556VDpG+IUVEbqn6LjKy2IgZ0e8ndTMbfcYgebA3
	9jpF008hfHb1ZYe1u9euYq3WTqPgwrTNB1yycnf5PlHZA3p7Fs5wlzXENRKymRGIIuW1Ur63DXY
	XxzMv8Gnuz6H2KRNhH
X-Google-Smtp-Source: AGHT+IH5PD1LXiuJ1OVxB91pB1B4L0WrpF1/eJTOcdn/V7iCjj7s8mrxuloXatGB8SxHsWzsC8nfAw==
X-Received: by 2002:a17:906:f34e:b0:b72:6762:f76c with SMTP id a640c23a62f3a-b726762f87amr59779866b.5.1762327525074;
        Tue, 04 Nov 2025 23:25:25 -0800 (PST)
Received: from [127.0.1.1] ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b723d6f8c5bsm411534866b.20.2025.11.04.23.25.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 23:25:24 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
 Kaustabh Chakraborty <kauschluss@disroot.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20251031-exynos7870-drm-dts-v4-3-c1f77fb16b87@disroot.org>
References: <20251031-exynos7870-drm-dts-v4-0-c1f77fb16b87@disroot.org>
 <20251031-exynos7870-drm-dts-v4-3-c1f77fb16b87@disroot.org>
Subject: Re: (subset) [PATCH v4 3/5] arm64: dts: exynos7870-on7xelte:
 enable display panel support
Message-Id: <176232752377.13426.2352187579192770383.b4-ty@linaro.org>
Date: Wed, 05 Nov 2025 08:25:23 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Fri, 31 Oct 2025 00:50:17 +0530, Kaustabh Chakraborty wrote:
> Enable DECON and DSI nodes, and add the compatible display panel and
> appropriate panel timings for this device. Also, remove the
> simple-framebuffer node in favor of the panel.
> 
> This device has a 1080x1920 Synaptics TD4300 display panel.
> 
> 
> [...]

Applied, thanks!

[3/5] arm64: dts: exynos7870-on7xelte: enable display panel support
      https://git.kernel.org/krzk/linux/c/35e69cc6bdef74a3c4794bd278a94dfb512abd7a

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


