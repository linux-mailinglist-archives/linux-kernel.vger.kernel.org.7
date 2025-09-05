Return-Path: <linux-kernel+bounces-802908-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A774B45845
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 14:54:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE1585A5087
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 12:54:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 741ED350D62;
	Fri,  5 Sep 2025 12:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eS6egm/L"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E1E6350D56;
	Fri,  5 Sep 2025 12:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757076879; cv=none; b=aluWYVbF1YEgI7DA2GJomYiKdPLJMzZth2TZv1kZxJTqYHZt6KPr5hm+ey+I/UvixRTdGC2p1zY2PvlS864ulWCBfNuGX5VvcPOLS+qh1eTTQCGYdyMJvZLXzE46mMDD28aNwVemeGQGFTUFwojA26jQIO/xhv97SX9PJGxaKRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757076879; c=relaxed/simple;
	bh=9zVtf+kkwvfKIRDWnjM5qNCzCgneDp3vdJpNzR4um+4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HS3KtUWbBXDo21bP6Jvzx8BOpF5d+wfcT+oZlx8uFwKj2wbXew3aCkwmxKYBGjLYmr978Df4CZKSFfC5sCM7z8Uo0hHif+38sKwzgNObD1iDOVj+RGJOEWvPx5dHRyc7oCDviU7V1rZHeYCJVFTOz5quwNQT90THB0QvG5LrmO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eS6egm/L; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-7725147ec88so941156b3a.0;
        Fri, 05 Sep 2025 05:54:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757076877; x=1757681677; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6zupGbMwuSB5pJigRGD6irptM+15GY/4lbepUjeraZg=;
        b=eS6egm/L9wZoHaBH2tvYWxDQ/zeB2x8qeHP6LWj2s8xZ6SaUbarmOUxntWakJAbmWp
         Jq0gdEUqk/wyVrAx8z9nMJ1sugZTNI3TPQiLn5fkp4C0Htp7eoS15SIhVxBfYCbL7p1y
         Nr2GEi/Lq4fjiQZfW6/0yOd12qtRxNBMGlMDfdReD+psu30eBzcFhMRlDzi4Iwv1r4t8
         OKk0fLtjC/FP64Z/dazk4uLNEy0/3/kyeaLYJFf9hOz/jk7bGWOUfbC4xa6MruzHD7x1
         2gEEjHpDqvbwJGYMuYu4HANNAQGslOJUu5tm8KNARvdq5GS4BApjq8Qc+t1cp8jhzci8
         /HFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757076877; x=1757681677;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6zupGbMwuSB5pJigRGD6irptM+15GY/4lbepUjeraZg=;
        b=NbhB4QUhYcVVnk4MmkEqYujmAPGAfMbf+Hqjd5Pc7PUwe6r+hN1SdIPeHRim7lINqu
         l3dIGtbY0fxnRlnt73Yr6xnOdJGxOBii8okG0RjXLYChW1z+5i5G9bFbqvixjy+sOoFE
         Nz9tdWoMPUYLhJOoQRUrqBeDaCLJO6OVZuNXBJbeZM3hlR+yr9GvAd4RPdaEyeIVx+Gt
         WfZGIZMM9C9Jb/kamcweKtD2htdE5JxEw21cEqV25AEfrmpbRavisyHR1GfNSwCYwzlC
         TkmKQ17AakAqLNiBLTcerOHw0sz+THjD9NULmM5NnstUxcgSPgCWYcxhtOp1+r1+4UIa
         XxOg==
X-Forwarded-Encrypted: i=1; AJvYcCV8I4Gf3HkZJkhOd8o9CiRenVGdbUqz1yIsJwdBJLm6VEhHx7rYj/6oHVzsv7olwf1C/V57XsjhSPz1J3u8@vger.kernel.org, AJvYcCWijCZmu8eG8JXC1N40ip/+ycMGHA0X/iHK+1y8xjnMhz4cbcM+p4IZIpbtgKYSYIjUGW/L98lQMBnH@vger.kernel.org
X-Gm-Message-State: AOJu0YySxZnWrlWaa+Lm4i4E8W3yFY0ASwNwvmm2XNFoNlLySKZVL6KE
	hakL3mvabI369TEGhA9v8I+NIi5awugwZB/nqNERD3TtfqLFdXiJBtnz
X-Gm-Gg: ASbGncvzfXEuKPaZYlIPH9ztj0hYa1Bzv011ndkNuBk/EEDPmLlYSXBOcyh8gTellnG
	W+FtE8sjgVFS77LVkKRu2UROFP/c2/5S5+f4DyPnymP/8Ago+6mhzJ61CWv9/dz6IPljUBzrRDC
	HTye98LoDbTM5QFix1CtUKP5Mdvc+Z0DuMMcK/SeYHVwG39jhHcilmH7ogSBID7a3JTJDVJsot0
	rZoHuHnJg7cq85hJVDTuSVDz7jkqeAH7qPBtLMK8CuB3+dQd40gqV9RFwyE7cHXmDPY/AaJj1Wv
	eH+cVocamDX1NR/qvEeOmKaXIjmkdw0QpdLRCLfw1OD4Upe+8BYmmdka+TIAVs/lSfc9dV8pUVp
	6H1KYAiYGn5E=
X-Google-Smtp-Source: AGHT+IHz8ZpqtG/43s7cNTW4AIO3toc8lazJSE325RJNj8fa1X+mR1KxOA03A5DcboEutvT3Z2i+sA==
X-Received: by 2002:a05:6a20:5d9c:b0:24a:8315:7ed with SMTP id adf61e73a8af0-24e83e26e68mr3563566637.17.1757076877333;
        Fri, 05 Sep 2025 05:54:37 -0700 (PDT)
Received: from localhost.localdomain ([2401:ce20:10::d4])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b4fb98f9f6asm4992305a12.8.2025.09.05.05.54.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 05:54:36 -0700 (PDT)
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
Subject: [PATCH v1 1/4] phy: rockchip: inno-usb2: Add usb2 phy support for RK3368
Date: Fri,  5 Sep 2025 20:53:14 +0800
Message-ID: <20250905125318.7956-2-cn.liweihao@gmail.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250905125318.7956-1-cn.liweihao@gmail.com>
References: <20250905125318.7956-1-cn.liweihao@gmail.com>
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
 drivers/phy/rockchip/phy-rockchip-inno-usb2.c | 49 +++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/drivers/phy/rockchip/phy-rockchip-inno-usb2.c b/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
index b0f23690ec..c6c575bce9 100644
--- a/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
+++ b/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
@@ -1847,6 +1847,54 @@ static const struct rockchip_usb2phy_cfg rk3366_phy_cfgs[] = {
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
+				.ls_det_en	= { 0x079c, 15, 15, 1, 0 },
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
@@ -2289,6 +2337,7 @@ static const struct of_device_id rockchip_usb2phy_dt_match[] = {
 	{ .compatible = "rockchip,rk3308-usb2phy", .data = &rk3308_phy_cfgs },
 	{ .compatible = "rockchip,rk3328-usb2phy", .data = &rk3328_phy_cfgs },
 	{ .compatible = "rockchip,rk3366-usb2phy", .data = &rk3366_phy_cfgs },
+	{ .compatible = "rockchip,rk3368-usb2phy", .data = &rk3368_phy_cfgs },
 	{ .compatible = "rockchip,rk3399-usb2phy", .data = &rk3399_phy_cfgs },
 	{ .compatible = "rockchip,rk3562-usb2phy", .data = &rk3562_phy_cfgs },
 	{ .compatible = "rockchip,rk3568-usb2phy", .data = &rk3568_phy_cfgs },
-- 
2.39.5


