Return-Path: <linux-kernel+bounces-755482-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 20275B1A6CB
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 17:57:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 51ACE18A4886
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 15:57:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A2A42749F9;
	Mon,  4 Aug 2025 15:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UiWqU1xR"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B888F274670;
	Mon,  4 Aug 2025 15:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754322926; cv=none; b=KVlbKiTWmoBzS2bd6IAbKy15X6ypSj1g98XpEI/F9bGbe/lEwepoh4dd4OA6WJHyud/9le5NSyhdcuMa0PLVHexOsrUcHDn5SYMmtBEEddkoBernG1bC2YGQndhtGUfgkKHHSw7cNGzA9kw/2JrFF4E641Cnpy0kZjjFjKgrSmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754322926; c=relaxed/simple;
	bh=GXAHOtGKKmzH+pgZDyuFCzmMVltVa2uZmadjU2mvBFw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MypMdsw/Ez3VQCOEDzhSbg1KaRyY7yWCD0fWp+Um3NJoUPh76WPBfQatip+bCStM8cOdt6VsAabplckt+Kgs+YcHjequy/4Lj651YbUIlK/JH7CvYmvPJK4GCeqUqvTd1+QzwfUKJeoEPbBJKqwTZfwI9mm985sU3KqUghGpdSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UiWqU1xR; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-60bfcada295so5593604a12.1;
        Mon, 04 Aug 2025 08:55:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754322923; x=1754927723; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v8PNRT/I48ie0bRNz5r0+TyoGyzFa1yYHCMX5vHGvkU=;
        b=UiWqU1xR13mOWJnh4UpLqMLCX8niVxgDo3UkhB90IEUuKJwqM986Wg7Cxi5TaADyV5
         4hIEa/6Pv2skRPrtW//wjBMtgXW0H83jq2QCZfSffgL6LnCFfwf5KkMhXdzX80O8HLzC
         +mzdQVSXV0t7jjf97mft9r9Q7AyfYDuhOg6N3s/G2Q8kEdUzAJXetdoYPAjz5iUy45sR
         m3uS0TfDi593g41lNiCWkU1Nimb8YDi+BFOfZwgi8Ecs8dI8LWfITuKC6HLjQgkiazmv
         p7GqvvBM0bqQxUo+LMSQEXePPLstkBRkl6GaS0NVa9WxYoaOvSpH1i7ogyDjCN2KhJyU
         1hQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754322923; x=1754927723;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v8PNRT/I48ie0bRNz5r0+TyoGyzFa1yYHCMX5vHGvkU=;
        b=jOhacdD2D0IA1thawVsfQd1Nu7XOqo2jUgMQOTTL0wZxKva4UkyWeg5JWpzDfFijTT
         jiK/Pc8CevseHZMe4w2gLeP6BEk1NNdKZr9+8mNRwhfgp3vZlz/NeH2aVYAKkusML9Of
         3o0T844IAEK6fBVMcD0sJjI+jb24swjTuJnHWCFY7sXtzradEiTtXDtxyP8e5b2d9vjq
         dIi39UwMO2J1G77Dt1FwVMAS36aonTvlTT0mCPYmzbrkZ6tIKxWbuGy8WUnLoiNh3b3G
         VDek1NL1YTuWoqQJvfWJHDL5lXabdzkumF1X5fUtD0anU2/pqFR7ljBBAU3a4UXUyqAu
         qC0w==
X-Forwarded-Encrypted: i=1; AJvYcCWHHCcTstHAgMyZg+0UesGpynuziej9FLjSqCXqRhNDjLBhUiKVeqhTKgv/oiUFZ3WpJo8eXAvgMN0oEOeO@vger.kernel.org, AJvYcCX+MIk/T+I2ZdPYNZfPRtDuRnvz3aROmm1/d4s+PetWtqYct3wj74z9l2wL85rD0Bq+uMNJtn3C+YBs@vger.kernel.org
X-Gm-Message-State: AOJu0Yxk2sRF/GOlLKmxRlSP/Ci1P6MLU3GLJKIrMDsckD0f5tkncyHd
	osBgqGzegsTMBih74jCPglvLNeu54Ti6sxyIpWU03TFcYHOXLtWsHZlJ
X-Gm-Gg: ASbGncsNb80rkUKYoGFKbQGIb7wg1yEnmEM9AJ3NVqT6NtaHh61hN009gG7qFTK7B2z
	UBqwHnhippgYKinJWK7q8Keo7dq0lv8KZ2+g4fOwr/D7t/CynBW2A5bvVEcwHQGXu6td5MtxA/Y
	7Rtppoag5//vy0FoePKIZYOgMdKiDJi9FIYLn5mHrVzxGpe+SUUexvXlk4Y+HDlo5J7M0Numdz3
	0/yL9pUa7kAuD/VIneczGKPO83pKhnNvlkEYDcaLXV13hAzzsRt+qEmx8LXPXTATVN3oWZHJtzo
	fMU0ymno3k1uaVZt8PyJcuO4ovsohTpRKaJwn/Afmhrd99EgITNZ2mhJ1fmaSkP2jpK4Q1QM9om
	4EHgXZHBehAJMl8U+I9Ch8OAWUn6yZ5Yg8e+Ay25ejcLlh43suK4ciiZUtOM=
X-Google-Smtp-Source: AGHT+IFfDvdFyuA9ALAp4YUM+ddrT5rqMT7rYruobfsQVPiAjFL8ichJg94bEOG/da/SNG5DJlXzHA==
X-Received: by 2002:a17:907:7ea5:b0:ae0:b847:435 with SMTP id a640c23a62f3a-af94024cadbmr998008866b.49.1754322922814;
        Mon, 04 Aug 2025 08:55:22 -0700 (PDT)
Received: from playground.localdomain ([82.79.237.20])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a075a74sm761114266b.17.2025.08.04.08.55.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Aug 2025 08:55:22 -0700 (PDT)
From: Laurentiu Mihalcea <laurentiumihalcea111@gmail.com>
To: Abel Vesa <abelvesa@kernel.org>,
	Peng Fan <peng.fan@nxp.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Fabio Estevam <festevam@gmail.com>,
	Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-clk@vger.kernel.org,
	imx@lists.linux.dev,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Pengutronix Kernel Team <kernel@pengutronix.de>
Subject: [PATCH 5/7] reset: imx8mp-audiomix: Extend the driver usage
Date: Mon,  4 Aug 2025 11:54:05 -0400
Message-Id: <20250804155407.285353-6-laurentiumihalcea111@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250804155407.285353-1-laurentiumihalcea111@gmail.com>
References: <20250804155407.285353-1-laurentiumihalcea111@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>

Some NXP SoCs integrate one or more, per-subsystem, block control IPs,
which allow users to control the assertion and de-assertion of the
reset lines tied to some peripherals present in said subsystems. Some
examples of such SoCs include i.MX8MP with AUDIOMIX block control and
i.MX8ULP with SIM LPAV.

Some of the aformentioned block control IPs exhibit a common pattern with
respect to the assertion and de-assertion of the reset lines. Namely, the
user is able to control the state of the reset line by toggling a bit from
one of the IP's registers.

Linux can take advantage of this pattern and, instead of having one driver
for each block control IP, a single, more generic driver could be used.

To allow this to happen, the previous approach, in which a single reset
map is used, is replaced by a per-driver approach, in which each auxiliary
device driver holds a reference to a certain reset map.

Signed-off-by: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
---
 drivers/reset/reset-imx8mp-audiomix.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/reset/reset-imx8mp-audiomix.c b/drivers/reset/reset-imx8mp-audiomix.c
index 6b357adfe646..a3d0bd823272 100644
--- a/drivers/reset/reset-imx8mp-audiomix.c
+++ b/drivers/reset/reset-imx8mp-audiomix.c
@@ -26,7 +26,12 @@ struct imx8mp_reset_map {
 	bool active_low;
 };
 
-static const struct imx8mp_reset_map reset_map[] = {
+struct imx8mp_reset_info {
+	const struct imx8mp_reset_map *map;
+	int num_lines;
+};
+
+static const struct imx8mp_reset_map imx8mp_reset_map[] = {
 	[IMX8MP_AUDIOMIX_EARC_RESET] = {
 		.offset	= IMX8MP_AUDIOMIX_EARC_RESET_OFFSET,
 		.mask	= IMX8MP_AUDIOMIX_EARC_RESET_MASK,
@@ -44,10 +49,16 @@ static const struct imx8mp_reset_map reset_map[] = {
 	},
 };
 
+static const struct imx8mp_reset_info imx8mp_reset_info = {
+	.map = imx8mp_reset_map,
+	.num_lines = ARRAY_SIZE(imx8mp_reset_map),
+};
+
 struct imx8mp_audiomix_reset {
 	struct reset_controller_dev rcdev;
 	spinlock_t lock; /* protect register read-modify-write cycle */
 	void __iomem *base;
+	const struct imx8mp_reset_info *rinfo;
 };
 
 static struct imx8mp_audiomix_reset *to_imx8mp_audiomix_reset(struct reset_controller_dev *rcdev)
@@ -59,6 +70,7 @@ static int imx8mp_audiomix_update(struct reset_controller_dev *rcdev,
 				  unsigned long id, bool assert)
 {
 	struct imx8mp_audiomix_reset *priv = to_imx8mp_audiomix_reset(rcdev);
+	const struct imx8mp_reset_map *reset_map = priv->rinfo->map;
 	void __iomem *reg_addr = priv->base;
 	unsigned int mask, offset, active_low;
 	unsigned long reg, flags;
@@ -112,7 +124,8 @@ static int imx8mp_audiomix_reset_probe(struct auxiliary_device *adev,
 	spin_lock_init(&priv->lock);
 
 	priv->rcdev.owner     = THIS_MODULE;
-	priv->rcdev.nr_resets = ARRAY_SIZE(reset_map);
+	priv->rinfo           = (const struct imx8mp_reset_info *)id->driver_data;
+	priv->rcdev.nr_resets = priv->rinfo->num_lines;
 	priv->rcdev.ops       = &imx8mp_audiomix_reset_ops;
 	priv->rcdev.of_node   = dev->parent->of_node;
 	priv->rcdev.dev	      = dev;
@@ -144,6 +157,7 @@ static void imx8mp_audiomix_reset_remove(struct auxiliary_device *adev)
 static const struct auxiliary_device_id imx8mp_audiomix_reset_ids[] = {
 	{
 		.name = "clk_imx8mp_audiomix.reset",
+		.driver_data = (kernel_ulong_t)&imx8mp_reset_info,
 	},
 	{ }
 };
-- 
2.34.1


