Return-Path: <linux-kernel+bounces-804284-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 48AD3B47021
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 16:22:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D02905868A9
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 14:22:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDA321C5F14;
	Sat,  6 Sep 2025 14:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GtuJzwCO"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7A611367
	for <linux-kernel@vger.kernel.org>; Sat,  6 Sep 2025 14:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757168518; cv=none; b=ksnM8m7M6TcBPkvCmuA/max1nS8pQ9PPFNaaEeRmY2L8TZ4EeL1Neknp9pByx0/aKc6pm5LwlDHclQ/riyFlfnR02V1X7zqONo84twm+7U/F0nC0LXkZENw4AAvCi6pgTAsUwVMiVb10QTRKz7nPKQNM/F5ZXS5QBxuR14J1LEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757168518; c=relaxed/simple;
	bh=7j0jt8b522CM/vqL0S9lO8QKWP4dLy9jsKB5Ykbj4B8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=h2YO1OsosCliqVX9va8xeoJvo/p+189ThrRn3C/KPDo2NhDNYVE+FNN4D19TSOKmW3gNlMpL3svtClwDB0Nft88lQgbIHdZvIQDFAYTEd8URNSVIT6xMWmBIpvbDahH7dPT5cv8vtAes5AxHCXNRVP/TqapUk/UIwSX6GaXN6iE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GtuJzwCO; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-77287fb79d3so2578691b3a.1
        for <linux-kernel@vger.kernel.org>; Sat, 06 Sep 2025 07:21:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757168516; x=1757773316; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BPOBPfaBOIERCGNPLoOShLjN/VoHaXMpNeHByEOlGTM=;
        b=GtuJzwCO/e5JmkcyhaLzYETpMzjWxq0OJ5nd+DOPzaaYUirhgqul70aUDkZPULF1pL
         sB31D8AQ9Unx2lMW0c9moPa5/vC5Ihp8f9l7ZDG95PoXVPa303kyZGSSNiphU0/Fw0LM
         N2ts0rz7D1j3sYO/ZCw9/ZR+gnC42TUqgyZf2cDjlPoPjIJBsKywSyLNgL8T385ljgAO
         90byrl/3AuUIEnQNLBVLmUdiI1y9cs+qVJBfHivK4OVyFn5k7hm+DIZQgV0GI54unlhy
         mUphvMFXzWskMwhqD3P2k56Ly5Nr3q2zolYbPaU2V16AM1AEFqA4A+NUwq762vqw3thv
         k+IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757168516; x=1757773316;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BPOBPfaBOIERCGNPLoOShLjN/VoHaXMpNeHByEOlGTM=;
        b=jj5qoslAwCQqtY2qWASWf2dNvVeAnmDCwgD1DkDG74MM6ghabdqzNnosNYaB5QGJV+
         KHWC0LbYtS/dmP1BYGus9cDh00GwlWEfJXM6NAx+q2uBb9XH7ELYAcTRGioK2esdNUxe
         0BNlZZmUJmoKPAcye9ehREcWSXeEEFC5L8YslBeeFbp43UWUoesGog9zFZObS2YMYtgh
         BHMsVl/AXqVt451QiBzjERgE4Yav1ZFzvxcsR4h2/GQsgMG3Goh6lfJrbw2/SKYcQiKq
         uOb7UK26HrRBMmzhSSGPy2r+pX2PRT9U8f1L+yRW2WT8qVMEXi0cz1rDwN30e5UpY1Zj
         fAkQ==
X-Forwarded-Encrypted: i=1; AJvYcCV95FmrfiRcOS4HLxs5vVTPITo1YRgtfAR/srGp9iUu2ydGHVozIg58LOk6cyh7edVROCbvnRzneOsVzP4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9ZlgocS5tuoH6vkUz269d9AfNrgXcXwp6iSJ0cujOcX+jPyNj
	JhQpiw6eTO8eXYmdtEOoZZUHDl+Wo+2xbvm0Dl1SHGsuY94sFVzyJSSW
X-Gm-Gg: ASbGncvP4uQUWE2RVGIK/J+TSloyMtMVouoIwUi5bwdI9vuITkrFay2VYVrzx190XqK
	BfbS2heNTy/n5Wf7HOAvf374WbEZaQ2wyc25U8JReFhVzMukfZG0qZNObb7oOJF70PfwCshIY71
	bBXuYqu+ZxRrl+TQmdPpj/mEdSIMgT4MFk8MbD/d0j1k1PhZCt8XI8f0P0EtCR8dxK49x0emfOE
	jdFHLRITo81LkuikJjVzQXFx9l7WXU+QtpaHhjNWL1Dk0SkP5JMYrrzX00gQwv+cWYspRfgmgjP
	wnjFDWJAdUe9rvUxwJosxImm+O2gDwWVhxm3lUQl+usD5ab2JG9zY2nYnqJGyQLepgs/0KXCInP
	9sfsHwERw8yqm+P6Cztlyv6in/rpRcoliYXYW4rMxOQ==
X-Google-Smtp-Source: AGHT+IFkrP5dlF9HUPo7WpPFbiPuovQaEgyUiSeWaBKpepMZeU4dQipBUYLMjANFy1meGzIQ6VRGqQ==
X-Received: by 2002:a17:902:f70a:b0:248:bae3:ecfb with SMTP id d9443c01a7336-251738cd029mr34257925ad.59.1757168516069;
        Sat, 06 Sep 2025 07:21:56 -0700 (PDT)
Received: from localhost.localdomain ([240e:3a6:1c4b:13c0:db95:4539:1490:64d2])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24b14206426sm128267195ad.17.2025.09.06.07.21.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Sep 2025 07:21:55 -0700 (PDT)
From: WeiHao Li <cn.liweihao@gmail.com>
To: heiko@sntech.de
Cc: linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	WeiHao Li <cn.liweihao@gmail.com>
Subject: [PATCH v1 1/1] soc: rockchip: grf: Set pwm2/xin32k pad default to xin32k for rk3368
Date: Sat,  6 Sep 2025 22:21:25 +0800
Message-ID: <20250906142125.7602-1-cn.liweihao@gmail.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

PWM2 and xin32k share the same pad, but some peripheral need to xin32k
clock to run properly, such as tsadc. I have observed that this pad is
used as xin32k by default on some existing board [1], so it maybe more
appropriate to set it to xin32k by default.

I also tested it on another rk3368 based board [2], without this adjust,
tsadc does not work properly.

[1] https://rockchip.fr/geekbox/Geekbox_V1.23.pdf
[2] https://ieiao.github.io/wiki/embedded-dev/rockchip/rk3368

Signed-off-by: WeiHao Li <cn.liweihao@gmail.com>
---
 drivers/soc/rockchip/grf.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/soc/rockchip/grf.c b/drivers/soc/rockchip/grf.c
index 344870da76..c0c2ec1296 100644
--- a/drivers/soc/rockchip/grf.c
+++ b/drivers/soc/rockchip/grf.c
@@ -98,6 +98,17 @@ static const struct rockchip_grf_info rk3368_grf __initconst = {
 	.num_values = ARRAY_SIZE(rk3368_defaults),
 };
 
+#define RK3368_PMUGRF_SOC_CON0		0x100
+
+static const struct rockchip_grf_value rk3368_pmugrf_defaults[] __initconst = {
+	{ "pwm2 select", RK3368_PMUGRF_SOC_CON0, FIELD_PREP_WM16_CONST(BIT(7), 0) },
+};
+
+static const struct rockchip_grf_info rk3368_pmugrf __initconst = {
+	.values = rk3368_pmugrf_defaults,
+	.num_values = ARRAY_SIZE(rk3368_pmugrf_defaults),
+};
+
 #define RK3399_GRF_SOC_CON7		0xe21c
 
 static const struct rockchip_grf_value rk3399_defaults[] __initconst = {
@@ -175,6 +186,9 @@ static const struct of_device_id rockchip_grf_dt_match[] __initconst = {
 	}, {
 		.compatible = "rockchip,rk3368-grf",
 		.data = (void *)&rk3368_grf,
+	}, {
+		.compatible = "rockchip,rk3368-pmugrf",
+		.data = (void *)&rk3368_pmugrf,
 	}, {
 		.compatible = "rockchip,rk3399-grf",
 		.data = (void *)&rk3399_grf,
-- 
2.47.2


