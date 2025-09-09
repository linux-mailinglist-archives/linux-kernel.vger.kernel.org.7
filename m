Return-Path: <linux-kernel+bounces-808265-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA319B4FD47
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 15:36:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B891D5E44AD
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 13:33:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D32534A314;
	Tue,  9 Sep 2025 13:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JcFDeALS"
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D6BC342CA7;
	Tue,  9 Sep 2025 13:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757424670; cv=none; b=NS4eYiDaI78rITmrjhWcjTN5zJ6qMQXLJVLPUX9zKG8jykeRY2pcWTR8xr48oX822bNv7uFaORy8Edy7D95p+pR5tckjh7mo0bfHxpKb3briubLYKfVzBXsKdnWOcSgvqJ6hWizbWkD2COoeO4FQso+5NOCvfCFQRgcJdVqvlZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757424670; c=relaxed/simple;
	bh=RgKxM6KZ24ZlUF9/EEXgaGtFSR5Jh11LgsiNA7kcQsY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hBMlvnSgdI2UpiGSTcVdvcvdsBat+2hWkI100nVv07P4fI1j9r4ss97Tf3ERlHVN75ofOdVTJF0UO4dohHZsWitkwp4V7CDyoqdgCHSqxfgTxAwO//obvr+LYWfmgJ9mkndcZh2HkFKc7Jv/qBNgSJ8v66743mYBf7HIM4E9WxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JcFDeALS; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-32da88701c7so729665a91.0;
        Tue, 09 Sep 2025 06:31:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757424668; x=1758029468; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oWkcAixsHGM19sxUvUtGscd74QmWi7n2SnlzLzrgGQk=;
        b=JcFDeALS4qSV9Q7w7V6cqyKBRXQ9HUGWckTvKKh7TA3o8wHhWX5TUZ1UtwLhtthEEf
         EZYetM1d+vrN9XcewFkefEEUwLwrXwHBshqMQdHnlmCf1LccVyRGcOM5kxkGGcxFNsRr
         9sYHytFlj4xBizO3Ema3lrQ9sHbpuwJIe111TK39AgZTXmtGi0eKKW/wTpRM8pY7wKlx
         m99kNQIdBpvo0thH4AeBVNwUCgOMxpOa67P0WZajy42qTQFHwj4qEsHsbKc2z5PEs5YM
         kGCye05KEwkM+r7pd4NWPrpE4HKbGCtFvAbt5fEROporACiRT0ZKGlUSokI91ViPMVPB
         15vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757424668; x=1758029468;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oWkcAixsHGM19sxUvUtGscd74QmWi7n2SnlzLzrgGQk=;
        b=gkFxQDcKrZi/jq+V8k1gcfwh9qTHdI6srPV1HW5J3slwXvRWGYu5n3Pv0+RhlA0z+r
         PDY0F7kZGjjI4fx7+03IZ51JrtOmLuT7olzVZv2RTanW3e56WE1HoaD3KzK8poRmmOZS
         ikzXfKIuZ+D5BUT9cazd2YFGhNCGqp3c4YVydzyCTra+fMWXcueAQKPxFpxA6Q2Jsv47
         hJ6z/EoLNf36NkBg9vNrxkguzZOAK8TQVcEkWEERMmspw1qawNju8o/ah25vMjIlSpGK
         a1Fxr1Hb19yWcoi1vT2DyhSbKZ1zNWzAtXWrE5bcFeXqz3Z5W/JjaZE/yflzEzE7GwQW
         vLvQ==
X-Forwarded-Encrypted: i=1; AJvYcCV8ob6u5ETJGZmxUra/X+11pLKknymxQo2ugnLa7MtxFXWLnBFlodEC1eH7gQHP1jsBLgHkpzYPfdTz@vger.kernel.org, AJvYcCXh2q3f+ewC/qynbfbqeRQNJRBxmr87zZE3Zn4KIwZE+tg7e3fEkFh1Flu2pmTMwsI89j788brgmtDG1xD9@vger.kernel.org
X-Gm-Message-State: AOJu0Yzl0LXZSkaz/+zjSzJq05AoHwRzmDGCFlFqjpHLcjZtFcQlhNXR
	S/RLxOMN5knx8ky2HlgG+MYkjEKRYUIZo1ttTQmUJtxJ0JiS3LufJRrl
X-Gm-Gg: ASbGncsVfHYq/liY0Jg4opgni7kHDNFzMwaahk3qwMGBGIhHrXSPuRY77rWdggSQCE7
	9HOtJrmCxnMVYFwVfKRfdLhzPv377BSB79lR5S5RcORFS76CG7YaRRh46+qeqW1pna2MhAdkCwo
	6C44XBFY7ckZrrTHqXC5WZBcH3NvIm2XVsvQWSkHfXxzQ0k5GLWxXUVir05p+aJpiHNRyELreQg
	CoFzurLRbhhY4t2UCQtJN1PEmkksOJH8zIvFmWEo4yaBWboTCSVIse5K/70GkT+6CwUes4RX3F4
	2olIjyzM9iaydKF4HAhUOgpU1xKERa4dCroQ9lmnTPD9ZGBHRZih212GYhQZXl0oL8cRP+XDgwm
	XAdIf2PhLUKRqQaEavnfQvPGbpmsyliQppLEPOmgUwLjuuVNi328=
X-Google-Smtp-Source: AGHT+IHqROdQImdvdEY0U/BqL0neIDZHUA1DGKWu1ZNUro0s3KD1rqjv15uBTzj4q/7BVZR3LI/efA==
X-Received: by 2002:a17:90b:3ec1:b0:327:9b36:87cf with SMTP id 98e67ed59e1d1-32d43fcf16amr16685269a91.30.1757424668244;
        Tue, 09 Sep 2025 06:31:08 -0700 (PDT)
Received: from localhost.localdomain ([240e:3a6:1c4b:13c0:db95:4539:1490:64d2])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32dab173060sm810778a91.5.2025.09.09.06.31.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 06:31:07 -0700 (PDT)
From: WeiHao Li <cn.liweihao@gmail.com>
To: heiko@sntech.de,
	robh@kernel.org
Cc: krzk+dt@kernel.org,
	conor+dt@kernel.org,
	linux-phy@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	WeiHao Li <cn.liweihao@gmail.com>
Subject: [PATCH v2 1/4] phy: rockchip: inno-usb2: Add usb2 phy support for RK3368
Date: Tue,  9 Sep 2025 21:29:55 +0800
Message-ID: <20250909132958.26423-2-cn.liweihao@gmail.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250909132958.26423-1-cn.liweihao@gmail.com>
References: <20250909132958.26423-1-cn.liweihao@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

RK3368 has one USB2.0 PHY with two ports. This adds device specific data
for it. Device specific data get form rockchip downstream source [1].

[1] https://github.com/rockchip-linux/kernel/blob/develop-4.4/drivers/phy/rockchip/phy-rockchip-inno-usb2.c#L2805

Signed-off-by: WeiHao Li <cn.liweihao@gmail.com>
---
 drivers/phy/rockchip/phy-rockchip-inno-usb2.c | 48 +++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/drivers/phy/rockchip/phy-rockchip-inno-usb2.c b/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
index b0f23690ec..df574337d4 100644
--- a/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
+++ b/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
@@ -1847,6 +1847,53 @@ static const struct rockchip_usb2phy_cfg rk3366_phy_cfgs[] = {
 	{ /* sentinel */ }
 };
 
+static const struct rockchip_usb2phy_cfg rk3368_phy_cfgs[] = {
+	{
+		.reg = 0x700,
+		.num_ports	= 2,
+		.clkout_ctl	= { 0x0724, 15, 15, 1, 0 },
+		.port_cfgs	= {
+			[USB2PHY_PORT_OTG] = {
+				.phy_sus	= { 0x0700, 8, 0, 0, 0x1d1 },
+				.bvalid_det_en	= { 0x0680, 3, 3, 0, 1 },
+				.bvalid_det_st	= { 0x0690, 3, 3, 0, 1 },
+				.bvalid_det_clr = { 0x06a0, 3, 3, 0, 1 },
+				.idfall_det_en	= { 0x0680, 6, 6, 0, 1 },
+				.idfall_det_st	= { 0x0690, 6, 6, 0, 1 },
+				.idfall_det_clr	= { 0x06a0, 6, 6, 0, 1 },
+				.idrise_det_en	= { 0x0680, 5, 5, 0, 1 },
+				.idrise_det_st	= { 0x0690, 5, 5, 0, 1 },
+				.idrise_det_clr	= { 0x06a0, 5, 5, 0, 1 },
+				.ls_det_en	= { 0x0680, 2, 2, 0, 1 },
+				.ls_det_st	= { 0x0690, 2, 2, 0, 1 },
+				.ls_det_clr	= { 0x06a0, 2, 2, 0, 1 },
+				.utmi_bvalid	= { 0x04bc, 23, 23, 0, 1 },
+				.utmi_id	= { 0x04bc, 26, 26, 0, 1 },
+				.utmi_ls	= { 0x04bc, 25, 24, 0, 1 },
+			},
+			[USB2PHY_PORT_HOST] = {
+				.phy_sus	= { 0x0728, 8, 0, 0, 0x1d1 },
+				.ls_det_en	= { 0x0680, 4, 4, 0, 1 },
+				.ls_det_st	= { 0x0690, 4, 4, 0, 1 },
+				.ls_det_clr	= { 0x06a0, 4, 4, 0, 1 }
+			}
+		},
+		.chg_det = {
+			.opmode		= { 0x0700, 8, 0, 0, 0x1d7 },
+			.cp_det		= { 0x04b8, 30, 30, 0, 1 },
+			.dcp_det	= { 0x04b8, 29, 29, 0, 1 },
+			.dp_det		= { 0x04b8, 31, 31, 0, 1 },
+			.idm_sink_en	= { 0x0718, 8, 8, 0, 1 },
+			.idp_sink_en	= { 0x0718, 7, 7, 0, 1 },
+			.idp_src_en	= { 0x0718, 9, 9, 0, 1 },
+			.rdm_pdwn_en	= { 0x0718, 10, 10, 0, 1 },
+			.vdm_src_en	= { 0x0718, 12, 12, 0, 1 },
+			.vdp_src_en	= { 0x0718, 11, 11, 0, 1 },
+		},
+	},
+	{ /* sentinel */ }
+};
+
 static const struct rockchip_usb2phy_cfg rk3399_phy_cfgs[] = {
 	{
 		.reg		= 0xe450,
@@ -2289,6 +2336,7 @@ static const struct of_device_id rockchip_usb2phy_dt_match[] = {
 	{ .compatible = "rockchip,rk3308-usb2phy", .data = &rk3308_phy_cfgs },
 	{ .compatible = "rockchip,rk3328-usb2phy", .data = &rk3328_phy_cfgs },
 	{ .compatible = "rockchip,rk3366-usb2phy", .data = &rk3366_phy_cfgs },
+	{ .compatible = "rockchip,rk3368-usb2phy", .data = &rk3368_phy_cfgs },
 	{ .compatible = "rockchip,rk3399-usb2phy", .data = &rk3399_phy_cfgs },
 	{ .compatible = "rockchip,rk3562-usb2phy", .data = &rk3562_phy_cfgs },
 	{ .compatible = "rockchip,rk3568-usb2phy", .data = &rk3568_phy_cfgs },
-- 
2.47.2


