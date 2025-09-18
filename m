Return-Path: <linux-kernel+bounces-768403-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 134BCB260BD
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 11:24:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A9E8A1C84D81
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 09:19:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 203402ECEAC;
	Thu, 14 Aug 2025 09:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="E8s6wYjm"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FDAA2EA72D
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 09:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755163104; cv=none; b=iVLcuwTNdjnldh7EuWTmVHvFLz7XSKGtTTL2QseO4FPafxerY1ZTNBj4yFxd1vdesktOIKsqYdhw+oSvLUb7qVzWO/jNG7YNi/4GPgty5V0BIFtfO5Vua7vtRfYnMyxOfR4xjs1cM++zQjrRPKDXFRuZQP3mokJLbhhf7GkFFrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755163104; c=relaxed/simple;
	bh=46LJa2wDbshNFnzJs1SRupO9qJEw9lE6qDyw8MpBQY0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OYDbNhIzZv7iMpz129f38WqdDp9ewxps1CaKylq2Q6G7jRT3/zVEgyYJU1n07H6rugtXbJRgH9BV65rJvpxy+t0/7niwFpfLhrEVofknWU6BMPfxEYfAoqFuoea1DtS5LcbP3BX+EbMnvbrIJe7MQkaVyUZ29WR6FppK9II/MfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=E8s6wYjm; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-45a1b097037so3841155e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 02:18:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755163100; x=1755767900; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Sw1jsJRwABde2QJUqyand4FN1Jn1+zxeyEdBFH61xAc=;
        b=E8s6wYjm3yibyxK2pSPB5gGXEGEorRFWmtAb8L6BvchilgpnrIN5tkhV0KRxlnuLwZ
         f/Vn4FLWmB66AsUI4PIOT8qNLkGl7sLFqK69EWNzgPK4XVgs0HQuAD8ZGnZ58LL4wRaf
         urx+vTUzJN17SefCB0xGYNzektLlNXGPI27gKaXPxN8ImQrzldT/AyxTNCtvnUomddnK
         WvHMl1IWbtsNO12OxeGsDHZErnAOCaHuQ3oD1pkfvFCdvVVwk8lQqSHCTTD49UwAIIW1
         TQvzkRkt9+omZnEHD3dow5dt+0PDA3TFiugOglo9n9y+GVmZjgjrbPPrfutEhQwy/8kB
         bEiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755163100; x=1755767900;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Sw1jsJRwABde2QJUqyand4FN1Jn1+zxeyEdBFH61xAc=;
        b=r+6Fxi1rVB3AwM2rdvGzIKu1ar5rpyX7l7gfWowvsviIcvKWW5OAujLgvBg5Tl90Vz
         EYFRfLvS3OKo/XuAgevT4tNG+2jPSYcl+yNJ1i4+XxGMsgh770Tke4kQUPnEgF3oOF+h
         8N0bpRMQwHzik48FbN+OSwoqP9gWW57NF0zGqlyoD12vivdkTY2K/9+GL/4xZLppe04E
         Xo8bx7wEQDk7p3Et/qV95M7/2U5VYZBCb721PjJmFoERW7WdKvXp4rqVULlFJMS2t5Hy
         j3brPtZMKr629rXobgYOskeEiEv4MUoGfas0bKuaUNBbsMYDS9H1eLGxH2ClrRK8LDfY
         ojaA==
X-Forwarded-Encrypted: i=1; AJvYcCXXDiutGZ3296CeUK3F9+w2/gRuam8JgQa3kbH+mYLXvtm4y6p6IjON+dhNuiBFtRT3DHKMlI6jpCYQ16E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yye0pNqKCGNUdmTB1N7hfyY3iZy6TbnjOIk7sDoXezr5DcdFAko
	BdzS9OLqwe8uATarWzGIjmjVjuJbe7XwbtOBg3KOBwcWOguA5Qsh3Ykq1afJCnMJcMQ=
X-Gm-Gg: ASbGncuEeFVFicWM8NFYy/Tm0oRdErWiHFTYB7SJ8ULQdut+lk5a2bxmSJwp+PkuG+F
	j30us9BiMJP2eDcJPKA3L1MGAbhDVlQmJAanhyZpf4uzKARLPUvIwPrxyWuOjv+TdcG9WftFY5M
	DGZPIpqc6OdeR6zBcVq4L23DFPcQfzHfh1yK1+sKVLcIx7BZuTW5Gcd8ives5dMqPRr1tx+CVZd
	TNLniPpKcUMDCioRtNMyxunVYjMI5I6+eBQgm5Ir19bKHjAHZaJFWsSoTATBBUqJghNVpCREvMv
	a2pEGmdN1aAKnKr5tv6PSl7Kz/K+WEM/+1h0LTUcWKkQqXdM5VIqBqDjbdHN5FATTwHiS6LI8cc
	J6OF8YcxG2zmEdUg7FcjEDG3JpGqoAepsw0hT
X-Google-Smtp-Source: AGHT+IHgCKHrKmlG0XE5ASsl3flO7xdPvj24GpGqa+EV9hH/V/JZ27mTKnghzyA1i5XsC1PyFXNpXg==
X-Received: by 2002:a05:600c:3151:b0:459:e3f8:92ec with SMTP id 5b1f17b1804b1-45a1b60e2e8mr20488895e9.10.1755163100162;
        Thu, 14 Aug 2025 02:18:20 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:2454:ff21:ef41:ea13:2485:4711:708])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45a1c74876csm13861925e9.14.2025.08.14.02.18.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 02:18:19 -0700 (PDT)
From: Stephan Gerhold <stephan.gerhold@linaro.org>
Date: Thu, 14 Aug 2025 11:18:07 +0200
Subject: [PATCH 2/2] drm/msm: dp: Delay applying clock defaults until PHY
 is fully enabled
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250814-platform-delay-clk-defaults-v1-2-4aae5b33512f@linaro.org>
References: <20250814-platform-delay-clk-defaults-v1-0-4aae5b33512f@linaro.org>
In-Reply-To: <20250814-platform-delay-clk-defaults-v1-0-4aae5b33512f@linaro.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
 Stephen Boyd <sboyd@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Dmitry Baryshkov <lumag@kernel.org>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>, 
 Abhinav Kumar <abhinav.kumar@linux.dev>, 
 Jessica Zhang <jessica.zhang@oss.qualcomm.com>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 Abel Vesa <abel.vesa@linaro.org>, Michael Walle <mwalle@kernel.org>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.2

On some Qualcomm platforms, we cannot safely reparent clocks when the new
parent is not already powered up. This problem occurs for the DP and DSI
controller when we try to reparent the link clocks using the standard
"assigned-clock-parents" property to the clock source provided by the PHY.
We often bypass this problem, because the clocks are already assigned to
the correct parent by the boot firmware. Without that, there is an error
during boot in the kernel log and DP/DSI is not functional.

For example, the following error occurs on X1E if the &mdss_dp3 controller
was not initialized by the boot firmware:

  clk: failed to reparent disp_cc_mdss_dptx3_link_clk_src to aec5a00.phy::link_clk: -16
  disp_cc_mdss_dptx3_link_clk_src: rcg didn't update its configuration.
  WARNING: CPU: 0 PID: 77 at drivers/clk/qcom/clk-rcg2.c:136 update_config+0xd4/0xe8
  pc : update_config+0xd4/0xe8
  Call trace:
   update_config+0xd4/0xe8 (P)
   clk_rcg2_set_parent+0x58/0x68
   __clk_set_parent+0x4c/0x214
   clk_core_set_parent_nolock+0xe8/0x1f4
   clk_set_parent+0xa4/0x13c
   of_clk_set_defaults+0x15c/0x4a8
   platform_probe+0x3c/0xc4
   ...
  clk: failed to reparent disp_cc_mdss_dptx3_pixel0_clk_src to aec5a00.phy::vco_div_clk: -16
  disp_cc_mdss_dptx3_pixel0_clk_src: rcg didn't update its configuration.
  WARNING: CPU: 0 PID: 77 at drivers/clk/qcom/clk-rcg2.c:136 update_config+0xd4/0xe8
  ...

In the current implementation, it is tricky to solve this from any of the
involved drivers, because the call to clk_set_parent() happens from the
platform driver core (before the probe() function of the DP driver is
called). Similarly, the PHY/clock driver cannot solve this alone, because
it doesn't know which clock rate and configuration to use for the PHY.

For DSI on SM8750, we solved this by avoiding use of assigned-clock-parents
and calling clk_set_parent() separately from the DSI controller driver (see
commit 80dd5911cbfd ("drm/msm/dsi: Add support for SM8750")). We could do
that for the DP controller as well, but this would require changing the
existing DT bindings for a number of platforms, just to workaround a
limitation in the Linux driver model. The DT does not specify when to apply
the assigned-clock-parents, so there is nothing wrong with the current
hardware description.

Instead, fix this by using the new "driver_managed_clk_defaults" option in
the platform_driver struct. Delay the call to of_clk_set_defaults() until
we have set up the PHY to avoid the error shown above.

Signed-off-by: Stephan Gerhold <stephan.gerhold@linaro.org>
---
 drivers/gpu/drm/msm/dp/dp_ctrl.c    | 10 ++++++++++
 drivers/gpu/drm/msm/dp/dp_display.c |  2 ++
 2 files changed, 12 insertions(+)

diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.c b/drivers/gpu/drm/msm/dp/dp_ctrl.c
index c42fd2c17a328f6deae211c9cd57cc7416a9365a..21249d2b85b308ef2437f1c7a309c795103599f6 100644
--- a/drivers/gpu/drm/msm/dp/dp_ctrl.c
+++ b/drivers/gpu/drm/msm/dp/dp_ctrl.c
@@ -7,6 +7,7 @@
 
 #include <linux/types.h>
 #include <linux/clk.h>
+#include <linux/clk/clk-conf.h>
 #include <linux/completion.h>
 #include <linux/delay.h>
 #include <linux/iopoll.h>
@@ -140,6 +141,7 @@ struct msm_dp_ctrl_private {
 	bool core_clks_on;
 	bool link_clks_on;
 	bool stream_clks_on;
+	bool clk_defaults_set;
 };
 
 static inline u32 msm_dp_read_ahb(const struct msm_dp_ctrl_private *ctrl, u32 offset)
@@ -1789,6 +1791,14 @@ static int msm_dp_ctrl_enable_mainlink_clocks(struct msm_dp_ctrl_private *ctrl)
 	phy_configure(phy, &ctrl->phy_opts);
 	phy_power_on(phy);
 
+	if (!ctrl->clk_defaults_set) {
+		ret = of_clk_set_defaults(ctrl->dev->of_node, false);
+		if (ret)
+			return ret;
+
+		ctrl->clk_defaults_set = true;
+	}
+
 	dev_pm_opp_set_rate(ctrl->dev, ctrl->link->link_params.rate * 1000);
 	ret = msm_dp_ctrl_link_clk_enable(&ctrl->msm_dp_ctrl);
 	if (ret)
diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
index d87d47cc7ec3eb757ac192c411000bc50b824c59..b8a0e61b806e6e386980f9c6ad6f58b487a68c7e 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -1487,6 +1487,8 @@ static struct platform_driver msm_dp_display_driver = {
 		.suppress_bind_attrs = true,
 		.pm = &msm_dp_pm_ops,
 	},
+	/* Apply clock parents after PHY is fully initialized */
+	.driver_managed_clk_defaults = true,
 };
 
 int __init msm_dp_register(void)

-- 
2.50.1


