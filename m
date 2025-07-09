Return-Path: <linux-kernel+bounces-723170-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B2924AFE3F4
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 11:20:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3245482770
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 09:19:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64480286D7E;
	Wed,  9 Jul 2025 09:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="Nh/Y3RCP"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 702E1285C92
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 09:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752052729; cv=none; b=pX3lsas5WoECNUhIXT8/GUcW7MiZ4LUsyHzcxWaTG/rviLhJREJnk0DUqeEtTd6qHtkNWKgWFioM0mPkDMPFYQJWK+O0ixw3GzHHFFApk0NpItYDBeb+ElZEtV4mA1k8qAkHaGAR1BUOUXpxgqL7d7gVQHFmXTBwiUpemh0PB80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752052729; c=relaxed/simple;
	bh=YZmEw3jGDd+2qgbm25oUb6kfM16R2p862EV52VAwfqs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CpozqK63U90g65Bjvde4AW8PV/UcmR+97MSBBeXkm9TmG0WHRgR2PoTO998JRTMNuZpEvusfhQgxED2iJtyKnZNmhgI9DrjVWAi+UlCQGyj/oGPZRov9wr+ZA9chjiGnSc9W8g1uwliwJbj+ASFrUf44MBaOfC9/4/Ps7o/9Cmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=Nh/Y3RCP; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-ae0bde4d5c9so1095002566b.3
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jul 2025 02:18:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1752052726; x=1752657526; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uAQIOUI3dQN/BAWWa5L7E496C+B20N9+qpU1jibn7CE=;
        b=Nh/Y3RCPN8O1hs40jnAcKShZ4I86K3FPiBxiteV36jDlKBWjE1pFWF/ovlzc9RjHQx
         4qk559FPKK4+vd/UxO7AbYNx3Osnd3tJ4qlQ1NWoqW60WhJXf9zUcVhyVjnAYchzYDMu
         ntSh+Gxkg0H9cdd5u+xJEaA8zqfwjAXetmGKT4/FkF5ynwQ0DwPUTIcM+gzdyU7khgpD
         RMBiOy0EPouGpqy0uG9OgFZ3grdLTOT5Hs1UJTg7XFY96yluLnL9ocs1gMiNGpMz/m8q
         rDpa6kl9jBx7svNvfwFWOAedjxWy3nCJ6CO8F2sRY7W09139ylkt1c7EAeyl76k1yY0w
         N61w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752052726; x=1752657526;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uAQIOUI3dQN/BAWWa5L7E496C+B20N9+qpU1jibn7CE=;
        b=A4PQIeVmWOctaXevai3RqzY5UMUrqRn7UrZXhmvaKOBilAAFbbCw49Ys67Ynb+W4w1
         zgKQtDG4Xrg+dgAWi6dhpadwLydwLXCwZ2Y+31hEjRYS5iwUnARZcseXNfazr1MDt5rx
         T9ei9TWQjowwFfGpE8c5dDiUnyr0STqPUlNpXaowf03ok9JR4aIjJwIzf6A5Etx1caka
         7yvk1k0XyXWXJ/zeVRjf5fJG0BLzqLBLwCnTX7QLULsjWz2nPph3TiTk/TXpvYAkwkPi
         qBukeYNxYyQASiL3Uoo0DI/7RjhnwpDY1cRYjtLwR3Dhtl9smSeUurJXmSNsPN5FdBGK
         HHOw==
X-Forwarded-Encrypted: i=1; AJvYcCXRh8jY9KcyAdVl/D8diZDJIUMJvYX/ef4XmgSyXObMCD4fiTFnykmhuGtawcDymEOo5A2qbmjXl0rjuoQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyj99RADIbaqU0D0qsnNVkKeQhkM4tMH4V8zgSmtN/zeIg3u/wA
	+GAY8vOwMteOZfX0MLzBEp14qH9EeoqD7ITIyx4+OrmtO2KJNay2ngfpDU8UxY0uoCc=
X-Gm-Gg: ASbGncsQl8SicW/Zb7a2rpqhvxBmO9DQALTXWf/h+hi9s0Eq6D+GYoIwMPE4GqseAra
	7/WpVodwG47MlzNkKKrtvVoxXO/m/LzLgGQGPfr0SblUAQg299z/Dzzs/bkgBsKBQaPU50WgW4o
	J7R+y2TOg+b5HITLd4uw2YS0XD3GdyUwpMRLSlB+Kz5wIrQJL8ELzQtuDpLZBYRBviaLIgurLUb
	qWiFc0N2D0c+73V51Zz5Fi0D69ULO0i8AHX6o1BqSUbYw77yuNmJcmTakwxeIsLlXesANixY0n0
	8idQMiKjMMR9QbPBT/UiQeIEpEa/imt2JG76DLdWqLEURNGSXxSCW5oi9J+mKLeLVYejxK47DEf
	v68ookoOMO0CtBshRKZiVAydNl+bcAQ1vsouP7p7Qsxw=
X-Google-Smtp-Source: AGHT+IGx/vzlfyTviick6hyyNUlcbGsI+JPz+PSX0OW7+e4XECNcxPqd0I6M02c/e4D8+rgbMwjMcQ==
X-Received: by 2002:a17:907:9281:b0:ae3:a8dd:418a with SMTP id a640c23a62f3a-ae6cfc748eamr190274466b.56.1752052725491;
        Wed, 09 Jul 2025 02:18:45 -0700 (PDT)
Received: from otso.local (144-178-202-139.static.ef-service.nl. [144.178.202.139])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae3f6b5e737sm1060116866b.142.2025.07.09.02.18.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jul 2025 02:18:45 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Wed, 09 Jul 2025 11:18:18 +0200
Subject: [PATCH v2 4/4] phy: qcom: phy-qcom-snps-eusb2: Add extra register
 write for Milos
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250709-sm7635-eusb-phy-v2-4-4790eeee7ae0@fairphone.com>
References: <20250709-sm7635-eusb-phy-v2-0-4790eeee7ae0@fairphone.com>
In-Reply-To: <20250709-sm7635-eusb-phy-v2-0-4790eeee7ae0@fairphone.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Wesley Cheng <quic_wcheng@quicinc.com>, 
 Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>, 
 Abel Vesa <abel.vesa@linaro.org>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-phy@lists.infradead.org, Luca Weiss <luca.weiss@fairphone.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752052719; l=1428;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=YZmEw3jGDd+2qgbm25oUb6kfM16R2p862EV52VAwfqs=;
 b=zN8r6w9eZkpsfJvCdS/uEyRLTfMfcMPeQkNPEXxwm1zg2mzNgMq6//5XUqXcPzpMEX576tiX8
 v8sIG6hQ6VlD7xQf/Q2ZKTCgES3vUcgQxUzwebHmbVyiNZdDrA4X384
X-Developer-Key: i=luca.weiss@fairphone.com; a=ed25519;
 pk=O1aw+AAust5lEmgrNJ1Bs7PTY0fEsJm+mdkjExA69q8=

As per the downstream devicetree for Milos, add a register write for
QCOM_USB_PHY_CFG_CTRL_1 as per the "eUSB2 HPG version 1.0.2 update".

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
The downstream driver supports an arbitrary extra init sequence via
qcom,param-override-seq.

volcano-usb.dtsi has the following which is implemented in this patch:

    /* eUSB2 HPG version 1.0.2 update */
    qcom,param-override-seq =
            <0x00 0x58>;
---
 drivers/phy/phy-snps-eusb2.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/phy/phy-snps-eusb2.c b/drivers/phy/phy-snps-eusb2.c
index e232b8b4d29100b8fee9e913e2124788af09f2aa..87fc086424ba4d9fb3ce870aa7f7971a51d4a567 100644
--- a/drivers/phy/phy-snps-eusb2.c
+++ b/drivers/phy/phy-snps-eusb2.c
@@ -420,6 +420,12 @@ static int qcom_snps_eusb2_hsphy_init(struct phy *p)
 	/* set default parameters */
 	qcom_eusb2_default_parameters(phy);
 
+	if (of_device_is_compatible(p->dev.of_node, "qcom,milos-snps-eusb2-phy")) {
+		/* eUSB2 HPG version 1.0.2 update */
+		writel_relaxed(0x0, phy->base + QCOM_USB_PHY_CFG_CTRL_1);
+		readl_relaxed(phy->base + QCOM_USB_PHY_CFG_CTRL_1);
+	}
+
 	snps_eusb2_hsphy_write_mask(phy->base, QCOM_USB_PHY_HS_PHY_CTRL2,
 				    USB2_SUSPEND_N_SEL | USB2_SUSPEND_N,
 				    USB2_SUSPEND_N_SEL | USB2_SUSPEND_N);

-- 
2.50.0


