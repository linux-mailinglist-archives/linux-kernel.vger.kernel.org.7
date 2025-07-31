Return-Path: <linux-kernel+bounces-752229-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C66CAB172C0
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 16:03:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC2B76239EF
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 14:03:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ED2A2D4B4E;
	Thu, 31 Jul 2025 14:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iAyLmzw2"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D02732D3EC2
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 14:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753970527; cv=none; b=k5ctxsKbnL8tR7YAjlvjr3iza5K8nXXt2HpfeX1zy3dgP7tjFEiu3eyDncJn+ADb0jeJoOwpNYmQhV1Is3uIAcjjTLMmnMo2UyHTB+4Rg3ay8BQ1U9J0Ogdwisuf93oxyK5+gkPPD0UcZh1WlQmlzPpQ4AkAKBhESkDkf4aYyX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753970527; c=relaxed/simple;
	bh=kidXAy0mvcs3fegsiwVQUUCUIiIdfC0KACC45Gf8Baw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BeUuNxhUC97/XK3maySsk9TMfcvyYAhAt7mZmsrA+nv5y2UmpDPR8+ssx5uYl7fV6K5BZBxFv5LGktE28b1zXL8hg9xPeB15dwqWMITpb4+sp6lBlI1W2MeM1fE2FS1wE9OeH9b9kVjtqZ3yHDBDPj+zFpEfznnzc3cQzvlTSis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=iAyLmzw2; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3b78d337dd9so665860f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 07:02:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753970524; x=1754575324; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fIjCGhz8tLixz44uwO4xKNvBCCKp5RNzQO4yWFCNcHo=;
        b=iAyLmzw2bxgnnCA2mSA+doWEnkLKzglsWuQPKCOdoZRR0cg53AyjVnsDzVmVEpiV0h
         KLd5T29r/rg49hm67hbKn+onKfehEf4CvQUwpCqAKOWLPJ5aTyu+v0Y6Brm78SFY6tCO
         DkDiaXYdNDniJ2CmDclz4ZK43qz0XPooYBm+JErTobDe19X8ZH71ksEbCZ12sg6dgc1/
         dfXW3L0nSo/v1aezjHDdYwzXPibi6SMPkmdY8PfAFtxbMaMFXC8ALrFlPEl6Dr4WiPT/
         +Qn2w8J8+GwSg9UQjbcBBgPzDpsL07m3CYP+gr1TpTOZ94p39NMKY4Rb93SFSA4lsWom
         CrRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753970524; x=1754575324;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fIjCGhz8tLixz44uwO4xKNvBCCKp5RNzQO4yWFCNcHo=;
        b=LDzuWUR1A9viiqlUzU32qe3sjdQKDITHfa5/ZoRou2utEzlgC0yAJq0cG8StzcBQa1
         kYIuXojHa52u5INypTCRtYbModBi8GN2U/CMlhJ1uEl0pN7xMJcNU8zrUaA/GVd1FO/s
         b9lNKkIkFEAEPEvVtSMcxcwdh4t7Am0P4rH25xAGP6Nu9Uva8u0mJjhzkUaE/xvOj0IY
         vErP354E0kr7rjAyQc3FI5N6LBbMu1ajuq4Fv9qQU4h+D8snQ7YjPr+VyLc0dT5fOemo
         D3jhbUluUeXLGtawhSmHdNLPXjKknzOFOuAzSba7xPPUL64sA1dCthK0B11tYGjv+d9t
         9phA==
X-Forwarded-Encrypted: i=1; AJvYcCW5PquxlDt1GDPS+zRP3A9YhINPS6hisLYbsS7Koh/STb5w7N8qpeSXQtom94ttYdbAfmY4F/oL06Zt4bo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHWm2lyDkO1Gjv75s0I45gwaldMMf3DJjdwI5ICYeizHmhYD0p
	0MiiAL6irfNZ5veYLORKkzJZuo8jXoDuqbNFVQ10Iw9z8gOMmor/m9gxXbDHuGxabp4=
X-Gm-Gg: ASbGnctlG4L7rvSVK4HOZ2jgRXwz9KRlYacdaPB9jqEAxZg84TBjS6p017yVj2cBM/O
	/EeRvbUjI0zfM1gp/zUiKdnmZ/CQScw8CAm3ii/xi54y8ZjAsCec4f30sZdstZgIMjwRDfCutFU
	x6699hCxgOmDIX+MO0LdOYlBfS6wpnVsXjc+6SN0LU9hArA8FhDnuzWDxFmj+cxNgYYYTU9OsDk
	h8RDiBOoL60qJG695Gxm+NFANU+8bT2seolcX6zxpy0TnAk8pg6RW468eFyCMha3Xw9qdQ85dqK
	nbyjKNxVz0N5V8Dc+/9+EwbGIndnZnfAA+kBTbLfShy8HeX6KPJnxIf1ZbN97VgVW9MdYEKjuYd
	W6otxvHXZZVrLXzXGakXn+hBgqGQ5nJGU1GUmnk2Y/NDJN8AbXiwGq/pRXMY=
X-Google-Smtp-Source: AGHT+IG/HsPKeTgglpnFos4WwXnhrkZuA5HfDzh0mWx5wGuKVHOsX/A/E/TRT6CmAsPxomm8vH7Xvg==
X-Received: by 2002:a05:6000:400e:b0:3b7:994b:8409 with SMTP id ffacd0b85a97d-3b7994b8636mr4606215f8f.39.1753970523586;
        Thu, 31 Jul 2025 07:02:03 -0700 (PDT)
Received: from mai.. (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4589ee57c18sm28121285e9.28.2025.07.31.07.02.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Jul 2025 07:02:03 -0700 (PDT)
From: Daniel Lezcano <daniel.lezcano@linaro.org>
To: mbrugger@suse.com,
	chester62515@gmail.com,
	ghennadi.procopciuc@oss.nxp.com,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de
Cc: s32@nxp.com,
	kernel@pengutronix.de,
	festevam@gmail.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ghennadi Procopciuc <ghennadi.procopciuc@nxp.com>,
	Thomas Fossati <thomas.fossati@linaro.org>
Subject: [PATCH v2 6/8] arm64: dts: s32g274-rd2: Enable the SWT watchdog
Date: Thu, 31 Jul 2025 16:01:39 +0200
Message-ID: <20250731140146.62960-7-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250731140146.62960-1-daniel.lezcano@linaro.org>
References: <20250731140146.62960-1-daniel.lezcano@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The SWT0 is directly connected to the reset line and only one instance
is useful for its purpose. Let's enable it for the s32g274-rd2.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Ghennadi Procopciuc <ghennadi.procopciuc@nxp.com>
Cc: Thomas Fossati <thomas.fossati@linaro.org>
---
 arch/arm64/boot/dts/freescale/s32g274a-rdb2.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/s32g274a-rdb2.dts b/arch/arm64/boot/dts/freescale/s32g274a-rdb2.dts
index 505776d19151..4f58be68c818 100644
--- a/arch/arm64/boot/dts/freescale/s32g274a-rdb2.dts
+++ b/arch/arm64/boot/dts/freescale/s32g274a-rdb2.dts
@@ -56,6 +56,10 @@ &stm3 {
 	status = "okay";
 };
 
+&swt0 {
+	status = "okay";
+};
+
 &usdhc0 {
 	pinctrl-names = "default", "state_100mhz", "state_200mhz";
 	pinctrl-0 = <&pinctrl_usdhc0>;
-- 
2.43.0


