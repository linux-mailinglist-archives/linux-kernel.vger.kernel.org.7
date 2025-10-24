Return-Path: <linux-kernel+bounces-868326-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 062D2C04E53
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 09:59:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D0E71AE155C
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 07:58:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B7B42F8BDF;
	Fri, 24 Oct 2025 07:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IjmaJSio"
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4676B2F83D4
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 07:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761292646; cv=none; b=MN5ziP8uOzM5RbBY7jLLc/nhAWSN6iEszX+mTdQZqcpXftUX21hFst2k7+/Vb4bBhQB/9DoRHbRvxzUq1uP7sZ3yddf+QJrQs3OoU6iIu9fNG3GKdGlDbIbloqzqnh6kbrtccCm8KSj/GRZZJbILEKeXqVOJWoSVoUt5tKqDjMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761292646; c=relaxed/simple;
	bh=1S4UQ+7nhEA8zNaooCtgSqA9haFJvF9HfZbaXeqS2EM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uIGf27hQt9WHBSfMH98tzpt35JfIt+MTw9gHbjm6CV2CmlkjVt9GZ8nvnP+y06ssXm4TWHA76vzs9QZiGCLVREdNbFdvUBF+3q7V7AYxf0ZNZ+TIHKa8LY/9xzPbBsWNTxurobPvB1azCpozGstqQM7Iu+2FG1iD2jT+/DKeZ10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IjmaJSio; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-b553412a19bso1126920a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 00:57:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761292644; x=1761897444; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bsCgGE+t2FAq88PcqDeZB7E9huH7ZBCKhVdOKCnfFwg=;
        b=IjmaJSioIn++WVvjuZqEGIOa8+5Te6i9jBTQXZlrlhB+d3pQfBl0tp5RSuuljbU/04
         GXpRj5k+sDatnfiS2r18jGkSLvTBTLqDFfeLHmx2dLMzxJ96vO43g75GaDAjxzSzFT2I
         opoVsEyZ+0WnkQxTQc4ivDeSX+7mSalro16ShXp/xAxiRN7lTuzOl9fitqVY/8QNMXxG
         upJrNUL6O75POGqRRAyu1tUKF9fdAO2uphCysolERxIIOts+DzyxrtaiQyrqCOaLqEnp
         lYsmMdLMh7QAOW047695wd74e6o9yiyrsBHlweqpS7eL+NFkI9jBF1XiD5nJpZgMGPk7
         GkCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761292644; x=1761897444;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bsCgGE+t2FAq88PcqDeZB7E9huH7ZBCKhVdOKCnfFwg=;
        b=b7PgU7wwcOwuThT3+tmvMeT4oH85WWDL6dRTwShCr8j4TRhcKUQ8mIdhktqndvjMnB
         Q5McDHl4BFRbrR0Xm87kAVNHtvYGzEb3GHj/CWk69rxNaN4NntjcjizBYWHBxS5CYTne
         /xjxepWOxu7tJfQSiu5hxUT30Jys73HJIYZtKV46N+LtRWA16QONNbFu8Ur/9xT20X/O
         g/tEPIKRUfYotUqCeil2TwVj0SpH4sGi0cs2XpMSFjwe71k6X4PSUdXZO3sxYwRPX8H3
         mYgCKpRo5lxgt2aZmtx8X41ol0pXGfIqiUeW9C5D8CMBTOZReh00JFIRgSpoq8hW2zbQ
         zOeQ==
X-Forwarded-Encrypted: i=1; AJvYcCWLclXqibpv5KGrrZSpf61CSVX4T34HE8DXysmd3SZ9q4G599O60U2C2l5KQ82kV6Ei2NNsV5sjY99Opgs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgpR1tVRRqe7LjlPnDeK8WVxlwXP91j+qx1sBkOrIdl6r7rec0
	yIFOybRsEiPRs8bhx26HRDntAnp6QgwT8DLxp35VaO+tkkwjuuf5qBYG
X-Gm-Gg: ASbGncuv/ZfREc37JE4pLucWsrUz4B7DfoluItK+hrGzAL91G94bY6ttFNJ7fhOuKhn
	YzfXA9aZBpvJcTNoZeB28nwhwVj81KeGPctKAtc0bCbxiQjmY3Wtfyops0jKOLmpHWdsSE4/lN9
	2Rc1hmSUqWvhMsqYEPIpyZ5lgEkXwwy3eOjpUHxZDMwzjwwRKPyf7GeUFdYaacPT5aZA1ljGNVK
	nXNNVnfAtmWzNu8ZqurxpwSsNV2Av2SIfjCb1BUkyS6YYigFjQhBO/E2dDQ0+MlwbP/dlwHAV7T
	Fi8tNYgA3lR2+NbxCeeJ67NsWiqlgB2gfq/gPcLoUY0kpHvoXu4oWb4fel0i7QCLN1kLepXvltd
	8X9aGXXWwGpciIMGIGkmCGx1MSwMEUfrnL60RsmpBXq7b82IO9cZVDL81OS9sZ0iQzSaQrUDsJv
	XISR4gbnESy3++12A4xlPF
X-Google-Smtp-Source: AGHT+IGTHOLGIwrjQXatww+KV9yMhd2IOEe91lui9OUaDG0ykvPq+cnpLgcMgz87qAdZPtufjmcT2A==
X-Received: by 2002:a17:903:2446:b0:290:6b30:fb3 with SMTP id d9443c01a7336-2948b97658bmr17002255ad.16.1761292644352;
        Fri, 24 Oct 2025 00:57:24 -0700 (PDT)
Received: from Black-Pearl.localdomain ([27.7.191.116])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-2946dfd045esm46608205ad.64.2025.10.24.00.57.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Oct 2025 00:57:24 -0700 (PDT)
From: Charan Pedumuru <charan.pedumuru@gmail.com>
Date: Fri, 24 Oct 2025 07:57:08 +0000
Subject: [PATCH v5 1/3] arm: dts: ti: omap: am335x-pepper: Fix vmmc-supply
 property typo
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251024-ti-sdhci-omap-v5-1-df5f6f033a38@gmail.com>
References: <20251024-ti-sdhci-omap-v5-0-df5f6f033a38@gmail.com>
In-Reply-To: <20251024-ti-sdhci-omap-v5-0-df5f6f033a38@gmail.com>
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Paul Barker <paul.barker@sancloud.com>, 
 Marc Murphy <marc.murphy@sancloud.com>, Tony Lindgren <tony@atomide.com>, 
 Kishon Vijay Abraham I <kishon@kernel.org>
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, 
 Charan Pedumuru <charan.pedumuru@gmail.com>
X-Mailer: b4 0.14.3

Rectify a typo for the property "vmmc-supply" to resolve the errors
detected by dtb_check.

Signed-off-by: Charan Pedumuru <charan.pedumuru@gmail.com>
---
 arch/arm/boot/dts/ti/omap/am335x-pepper.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/ti/omap/am335x-pepper.dts b/arch/arm/boot/dts/ti/omap/am335x-pepper.dts
index e7d561a527fd..10d54e0ad15a 100644
--- a/arch/arm/boot/dts/ti/omap/am335x-pepper.dts
+++ b/arch/arm/boot/dts/ti/omap/am335x-pepper.dts
@@ -347,7 +347,7 @@ &mmc3 {
 	status = "okay";
 	pinctrl-names = "default";
 	pinctrl-0 = <&wireless_pins>;
-	vmmmc-supply = <&v3v3c_reg>;
+	vmmc-supply = <&v3v3c_reg>;
 	bus-width = <4>;
 	non-removable;
 	dmas = <&edma_xbar 12 0 1

-- 
2.51.1


