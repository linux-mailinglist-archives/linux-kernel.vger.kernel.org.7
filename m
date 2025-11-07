Return-Path: <linux-kernel+bounces-889942-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A562EC3EE42
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 09:11:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 267913B2472
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 08:09:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AA68313261;
	Fri,  7 Nov 2025 08:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D2+4ZIeQ"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 168FC311975
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 08:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762502890; cv=none; b=JLwvEnmGWHnRT7XHRe2HYxfgDs0umjVP62AQ9CekJAi9ke5NTPyx4I8M3aciY1yPViDc+QnZDP4rtWfsfwhwecsSdwJDLNoaYD8XXUg37U2z24GXHcTzApVG/j4IFTi+6kNlRJXXgH4X6MPHlSQYXz7VD3bgicGiiIi/bPMRgOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762502890; c=relaxed/simple;
	bh=fn0piwHHX8ir16QQNvantQ27c+ublvYdiUMR9gXOvsw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TkwATZMp9UR8ugx3LfH521lg6Bn4JKOJGRWXpzIRkidRU7thQpIBWxDyJt/5hYYF7kelPEYqiIwvmPRi4+jekzy0BUMazmy3j/Hn6jvfsN23TuH9xRmdeHjff4jU6oP5HzAIblHDMwiVClg6tquftkyfMmPIO7wT8TkNQse88W0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D2+4ZIeQ; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-640e9f5951aso721774a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 00:08:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762502886; x=1763107686; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KAbW6u5pPeCbc23UbdkfRXIbK91z4t3E/qRGXTD33Cg=;
        b=D2+4ZIeQwm7/zEgETTqykOPKMEZjtfpQQKgUSmTfouX0gkgL8eKCYE3YKZ99YzIsQa
         Fi8vhsvCvxMy5TbjariD77vMn0ReUvot/4r7zmIwzOidGW87pZ8n6LEalD/DH3IqgZBb
         fu2lQ+5KJuhkSvQEGA/zRAhXwksz197vsYHKJWJZpffbh2WL1OJ+QHc/pdjz+zsgzbX+
         3b1Ibo8SxA/VxnrC8wBEArYCP25P9VxyLXovNb99JVJhR4TQRpO6EC/udAmIzolOIT2K
         3K6ca2BsFHSgMJVxEuMrdxSiIyig9YCyBDkanG9nM3ZyIndQzn/2ME8E587l8N5zzdWJ
         Cqbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762502886; x=1763107686;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KAbW6u5pPeCbc23UbdkfRXIbK91z4t3E/qRGXTD33Cg=;
        b=FlAT5ZkRjefRolM56ShYulywMjsOFgTJe0nrD4B6Ic9XvzRSKfGoLBvtjoRQPtcVhf
         VgC1wE4fBMalpVSf9tRSRPTxI29lcLRt9c3JHg4c6t54samURi5UPpiJiHewWM8s/iER
         V3lfR+8mRHftoSXPuI9pED4DTj5cHoy7Mn3KLrAbo7asMGVkrxmHXGBXMHbGyLUZv6g7
         vEcJbs/ApbHfJXT5tGloYmpbo4ieOoaTJX5Ti6nRNmhGpCVwuulK8lETeGA6T4P9tBjo
         8dLVRKSP+ludR/2S/XZkBRqZskcdenwhXJ9CODTf9byhWdNDOwPIHi6kn8HfgU8Str6n
         1ZuQ==
X-Forwarded-Encrypted: i=1; AJvYcCUhC++j6jqEsj8uBMOs6oxHLrNRlqspm0IOEsM10U/BdV77egXzDQjH2codBGWhr9CmBG0IhLWjTlovWeE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAWkkTDre+tScld36xNfC8e54UqI283TRjYGyts5TywZ3exlP4
	rLob6C/be6Yk2vXnPhRxZT7NqeAFWTpjMj+pD1scrcqpQa51A1KAzE7P
X-Gm-Gg: ASbGncs/m2YUJFLHEbkbzUTlk86kc7qOD+iY9LOEawJVV9VrkyX1soS3wGjC12iOUQJ
	z98es2v98LL5i6jugcvyRstrW9Tl3wzMjFYMNjLQaEjG0D6Q3u41lEL6ojg+x0CgkVBxgWY3Ks5
	BpE+GqDqrvLRjiSydmRVvUIAntJiaumzYRDUNKtHPhs/NxnELUPMDi1JxRAQI37lIwkU/L2GM0X
	d3riYwlQqVgH6ZAMTT9ndkTCdGSu5lDOjNLBwFDALHmVvqv4kpvl20FBXyZX/1gBElYacm8X+eQ
	Hng4dXittP2IQbIBzf4+yZh7zgU82tiw+GzTmhjCWli26YG1oRviC3cUmhW3fWeer6of3v4TQtj
	oj6SdVqPj0KxUwR8NhVLPQGoSsoqw3EVnVs1/wTXnWaBPxMtVpcGe+98Nt+Icz+hVNM1ED6JqaV
	iL9LqvwqwQ++3jvKrh73JpocXm5i1tnA/iTUgCdFX6H3I5aRljUEkUG+E/Gc9YXUOfAmY=
X-Google-Smtp-Source: AGHT+IF7O7QJ2kAFACQQzwx2SwACX6580PsjZQMl5XtCZs1f6ZD3zs+9sKXPqkpiDb12JYf6ussacw==
X-Received: by 2002:a17:907:3e88:b0:b5c:6e0b:3706 with SMTP id a640c23a62f3a-b72d0a3a93bmr100861766b.13.1762502886219;
        Fri, 07 Nov 2025 00:08:06 -0800 (PST)
Received: from localhost (dslb-002-205-018-238.002.205.pools.vodafone-ip.de. [2.205.18.238])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b72bf97d43bsm179882466b.45.2025.11.07.00.08.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 00:08:05 -0800 (PST)
From: Jonas Gorski <jonas.gorski@gmail.com>
To: Florian Fainelli <florian.fainelli@broadcom.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 6/8] net: dsa: b53: move ARL entry functions into ops struct
Date: Fri,  7 Nov 2025 09:07:47 +0100
Message-ID: <20251107080749.26936-7-jonas.gorski@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251107080749.26936-1-jonas.gorski@gmail.com>
References: <20251107080749.26936-1-jonas.gorski@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now that the differences in ARL entry formats are neatly contained into
functions per chip family, wrap them into an ops struct and add wrapper
functions to access them.

Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
---
 drivers/net/dsa/b53/b53_common.c | 67 ++++++++++++++++++++++----------
 drivers/net/dsa/b53/b53_priv.h   | 30 ++++++++++++++
 2 files changed, 76 insertions(+), 21 deletions(-)

diff --git a/drivers/net/dsa/b53/b53_common.c b/drivers/net/dsa/b53/b53_common.c
index fa4cf6ceddb8..c69022cc85bf 100644
--- a/drivers/net/dsa/b53/b53_common.c
+++ b/drivers/net/dsa/b53/b53_common.c
@@ -1910,10 +1910,7 @@ static int b53_arl_read(struct b53_device *dev, const u8 *mac,
 
 	/* Read the bins */
 	for (i = 0; i < dev->num_arl_bins; i++) {
-		if (is5325(dev) || is5365(dev))
-			b53_arl_read_entry_25(dev, ent, i);
-		else
-			b53_arl_read_entry_95(dev, ent, i);
+		b53_arl_read_entry(dev, ent, i);
 
 		if (!ent->is_valid) {
 			set_bit(i, free_bins);
@@ -1995,10 +1992,7 @@ static int b53_arl_op(struct b53_device *dev, int op, int port,
 	ent.is_static = true;
 	ent.is_age = false;
 	memcpy(ent.mac, addr, ETH_ALEN);
-	if (is5325(dev) || is5365(dev))
-		b53_arl_write_entry_25(dev, &ent, idx);
-	else
-		b53_arl_write_entry_95(dev, &ent, idx);
+	b53_arl_write_entry(dev, &ent, idx);
 
 	return b53_arl_rw_op(dev, 0);
 }
@@ -2109,17 +2103,6 @@ static void b53_arl_search_read_95(struct b53_device *dev, u8 idx,
 	b53_arl_to_entry(ent, mac_vid, fwd_entry);
 }
 
-static void b53_arl_search_rd(struct b53_device *dev, u8 idx,
-			      struct b53_arl_entry *ent)
-{
-	if (is5325(dev))
-		b53_arl_search_read_25(dev, idx, ent);
-	else if (is5365(dev))
-		b53_arl_search_read_65(dev, idx, ent);
-	else
-		b53_arl_search_read_95(dev, idx, ent);
-}
-
 static int b53_fdb_copy(int port, const struct b53_arl_entry *ent,
 			dsa_fdb_dump_cb_t *cb, void *data)
 {
@@ -2153,13 +2136,13 @@ int b53_fdb_dump(struct dsa_switch *ds, int port,
 		if (ret)
 			break;
 
-		b53_arl_search_rd(priv, 0, &results[0]);
+		b53_arl_search_read(priv, 0, &results[0]);
 		ret = b53_fdb_copy(port, &results[0], cb, data);
 		if (ret)
 			break;
 
 		if (results_per_hit == 2) {
-			b53_arl_search_rd(priv, 1, &results[1]);
+			b53_arl_search_read(priv, 1, &results[1]);
 			ret = b53_fdb_copy(port, &results[1], cb, data);
 			if (ret)
 				break;
@@ -2688,6 +2671,24 @@ static const struct dsa_switch_ops b53_switch_ops = {
 	.port_change_mtu	= b53_change_mtu,
 };
 
+static const struct b53_arl_ops b53_arl_ops_25 = {
+	.arl_read_entry = b53_arl_read_entry_25,
+	.arl_write_entry = b53_arl_write_entry_25,
+	.arl_search_read = b53_arl_search_read_25,
+};
+
+static const struct b53_arl_ops b53_arl_ops_65 = {
+	.arl_read_entry = b53_arl_read_entry_25,
+	.arl_write_entry = b53_arl_write_entry_25,
+	.arl_search_read = b53_arl_search_read_65,
+};
+
+static const struct b53_arl_ops b53_arl_ops_95 = {
+	.arl_read_entry = b53_arl_read_entry_95,
+	.arl_write_entry = b53_arl_write_entry_95,
+	.arl_search_read = b53_arl_search_read_95,
+};
+
 struct b53_chip_data {
 	u32 chip_id;
 	const char *dev_name;
@@ -2701,6 +2702,7 @@ struct b53_chip_data {
 	u8 duplex_reg;
 	u8 jumbo_pm_reg;
 	u8 jumbo_size_reg;
+	const struct b53_arl_ops *arl_ops;
 };
 
 #define B53_VTA_REGS	\
@@ -2720,6 +2722,7 @@ static const struct b53_chip_data b53_switch_chips[] = {
 		.arl_buckets = 1024,
 		.imp_port = 5,
 		.duplex_reg = B53_DUPLEX_STAT_FE,
+		.arl_ops = &b53_arl_ops_25,
 	},
 	{
 		.chip_id = BCM5365_DEVICE_ID,
@@ -2730,6 +2733,7 @@ static const struct b53_chip_data b53_switch_chips[] = {
 		.arl_buckets = 1024,
 		.imp_port = 5,
 		.duplex_reg = B53_DUPLEX_STAT_FE,
+		.arl_ops = &b53_arl_ops_65,
 	},
 	{
 		.chip_id = BCM5389_DEVICE_ID,
@@ -2743,6 +2747,7 @@ static const struct b53_chip_data b53_switch_chips[] = {
 		.duplex_reg = B53_DUPLEX_STAT_GE,
 		.jumbo_pm_reg = B53_JUMBO_PORT_MASK,
 		.jumbo_size_reg = B53_JUMBO_MAX_SIZE,
+		.arl_ops = &b53_arl_ops_95,
 	},
 	{
 		.chip_id = BCM5395_DEVICE_ID,
@@ -2756,6 +2761,7 @@ static const struct b53_chip_data b53_switch_chips[] = {
 		.duplex_reg = B53_DUPLEX_STAT_GE,
 		.jumbo_pm_reg = B53_JUMBO_PORT_MASK,
 		.jumbo_size_reg = B53_JUMBO_MAX_SIZE,
+		.arl_ops = &b53_arl_ops_95,
 	},
 	{
 		.chip_id = BCM5397_DEVICE_ID,
@@ -2769,6 +2775,7 @@ static const struct b53_chip_data b53_switch_chips[] = {
 		.duplex_reg = B53_DUPLEX_STAT_GE,
 		.jumbo_pm_reg = B53_JUMBO_PORT_MASK,
 		.jumbo_size_reg = B53_JUMBO_MAX_SIZE,
+		.arl_ops = &b53_arl_ops_95,
 	},
 	{
 		.chip_id = BCM5398_DEVICE_ID,
@@ -2782,6 +2789,7 @@ static const struct b53_chip_data b53_switch_chips[] = {
 		.duplex_reg = B53_DUPLEX_STAT_GE,
 		.jumbo_pm_reg = B53_JUMBO_PORT_MASK,
 		.jumbo_size_reg = B53_JUMBO_MAX_SIZE,
+		.arl_ops = &b53_arl_ops_95,
 	},
 	{
 		.chip_id = BCM53101_DEVICE_ID,
@@ -2795,6 +2803,7 @@ static const struct b53_chip_data b53_switch_chips[] = {
 		.duplex_reg = B53_DUPLEX_STAT_GE,
 		.jumbo_pm_reg = B53_JUMBO_PORT_MASK,
 		.jumbo_size_reg = B53_JUMBO_MAX_SIZE,
+		.arl_ops = &b53_arl_ops_95,
 	},
 	{
 		.chip_id = BCM53115_DEVICE_ID,
@@ -2808,6 +2817,7 @@ static const struct b53_chip_data b53_switch_chips[] = {
 		.duplex_reg = B53_DUPLEX_STAT_GE,
 		.jumbo_pm_reg = B53_JUMBO_PORT_MASK,
 		.jumbo_size_reg = B53_JUMBO_MAX_SIZE,
+		.arl_ops = &b53_arl_ops_95,
 	},
 	{
 		.chip_id = BCM53125_DEVICE_ID,
@@ -2821,6 +2831,7 @@ static const struct b53_chip_data b53_switch_chips[] = {
 		.duplex_reg = B53_DUPLEX_STAT_GE,
 		.jumbo_pm_reg = B53_JUMBO_PORT_MASK,
 		.jumbo_size_reg = B53_JUMBO_MAX_SIZE,
+		.arl_ops = &b53_arl_ops_95,
 	},
 	{
 		.chip_id = BCM53128_DEVICE_ID,
@@ -2834,6 +2845,7 @@ static const struct b53_chip_data b53_switch_chips[] = {
 		.duplex_reg = B53_DUPLEX_STAT_GE,
 		.jumbo_pm_reg = B53_JUMBO_PORT_MASK,
 		.jumbo_size_reg = B53_JUMBO_MAX_SIZE,
+		.arl_ops = &b53_arl_ops_95,
 	},
 	{
 		.chip_id = BCM63XX_DEVICE_ID,
@@ -2847,6 +2859,7 @@ static const struct b53_chip_data b53_switch_chips[] = {
 		.duplex_reg = B53_DUPLEX_STAT_63XX,
 		.jumbo_pm_reg = B53_JUMBO_PORT_MASK_63XX,
 		.jumbo_size_reg = B53_JUMBO_MAX_SIZE_63XX,
+		.arl_ops = &b53_arl_ops_95,
 	},
 	{
 		.chip_id = BCM53010_DEVICE_ID,
@@ -2860,6 +2873,7 @@ static const struct b53_chip_data b53_switch_chips[] = {
 		.duplex_reg = B53_DUPLEX_STAT_GE,
 		.jumbo_pm_reg = B53_JUMBO_PORT_MASK,
 		.jumbo_size_reg = B53_JUMBO_MAX_SIZE,
+		.arl_ops = &b53_arl_ops_95,
 	},
 	{
 		.chip_id = BCM53011_DEVICE_ID,
@@ -2873,6 +2887,7 @@ static const struct b53_chip_data b53_switch_chips[] = {
 		.duplex_reg = B53_DUPLEX_STAT_GE,
 		.jumbo_pm_reg = B53_JUMBO_PORT_MASK,
 		.jumbo_size_reg = B53_JUMBO_MAX_SIZE,
+		.arl_ops = &b53_arl_ops_95,
 	},
 	{
 		.chip_id = BCM53012_DEVICE_ID,
@@ -2886,6 +2901,7 @@ static const struct b53_chip_data b53_switch_chips[] = {
 		.duplex_reg = B53_DUPLEX_STAT_GE,
 		.jumbo_pm_reg = B53_JUMBO_PORT_MASK,
 		.jumbo_size_reg = B53_JUMBO_MAX_SIZE,
+		.arl_ops = &b53_arl_ops_95,
 	},
 	{
 		.chip_id = BCM53018_DEVICE_ID,
@@ -2899,6 +2915,7 @@ static const struct b53_chip_data b53_switch_chips[] = {
 		.duplex_reg = B53_DUPLEX_STAT_GE,
 		.jumbo_pm_reg = B53_JUMBO_PORT_MASK,
 		.jumbo_size_reg = B53_JUMBO_MAX_SIZE,
+		.arl_ops = &b53_arl_ops_95,
 	},
 	{
 		.chip_id = BCM53019_DEVICE_ID,
@@ -2912,6 +2929,7 @@ static const struct b53_chip_data b53_switch_chips[] = {
 		.duplex_reg = B53_DUPLEX_STAT_GE,
 		.jumbo_pm_reg = B53_JUMBO_PORT_MASK,
 		.jumbo_size_reg = B53_JUMBO_MAX_SIZE,
+		.arl_ops = &b53_arl_ops_95,
 	},
 	{
 		.chip_id = BCM58XX_DEVICE_ID,
@@ -2925,6 +2943,7 @@ static const struct b53_chip_data b53_switch_chips[] = {
 		.duplex_reg = B53_DUPLEX_STAT_GE,
 		.jumbo_pm_reg = B53_JUMBO_PORT_MASK,
 		.jumbo_size_reg = B53_JUMBO_MAX_SIZE,
+		.arl_ops = &b53_arl_ops_95,
 	},
 	{
 		.chip_id = BCM583XX_DEVICE_ID,
@@ -2938,6 +2957,7 @@ static const struct b53_chip_data b53_switch_chips[] = {
 		.duplex_reg = B53_DUPLEX_STAT_GE,
 		.jumbo_pm_reg = B53_JUMBO_PORT_MASK,
 		.jumbo_size_reg = B53_JUMBO_MAX_SIZE,
+		.arl_ops = &b53_arl_ops_95,
 	},
 	/* Starfighter 2 */
 	{
@@ -2952,6 +2972,7 @@ static const struct b53_chip_data b53_switch_chips[] = {
 		.duplex_reg = B53_DUPLEX_STAT_GE,
 		.jumbo_pm_reg = B53_JUMBO_PORT_MASK,
 		.jumbo_size_reg = B53_JUMBO_MAX_SIZE,
+		.arl_ops = &b53_arl_ops_95,
 	},
 	{
 		.chip_id = BCM7445_DEVICE_ID,
@@ -2965,6 +2986,7 @@ static const struct b53_chip_data b53_switch_chips[] = {
 		.duplex_reg = B53_DUPLEX_STAT_GE,
 		.jumbo_pm_reg = B53_JUMBO_PORT_MASK,
 		.jumbo_size_reg = B53_JUMBO_MAX_SIZE,
+		.arl_ops = &b53_arl_ops_95,
 	},
 	{
 		.chip_id = BCM7278_DEVICE_ID,
@@ -2978,6 +3000,7 @@ static const struct b53_chip_data b53_switch_chips[] = {
 		.duplex_reg = B53_DUPLEX_STAT_GE,
 		.jumbo_pm_reg = B53_JUMBO_PORT_MASK,
 		.jumbo_size_reg = B53_JUMBO_MAX_SIZE,
+		.arl_ops = &b53_arl_ops_95,
 	},
 	{
 		.chip_id = BCM53134_DEVICE_ID,
@@ -2992,6 +3015,7 @@ static const struct b53_chip_data b53_switch_chips[] = {
 		.duplex_reg = B53_DUPLEX_STAT_GE,
 		.jumbo_pm_reg = B53_JUMBO_PORT_MASK,
 		.jumbo_size_reg = B53_JUMBO_MAX_SIZE,
+		.arl_ops = &b53_arl_ops_95,
 	},
 };
 
@@ -3020,6 +3044,7 @@ static int b53_switch_init(struct b53_device *dev)
 			dev->num_vlans = chip->vlans;
 			dev->num_arl_bins = chip->arl_bins;
 			dev->num_arl_buckets = chip->arl_buckets;
+			dev->arl_ops = chip->arl_ops;
 			break;
 		}
 	}
diff --git a/drivers/net/dsa/b53/b53_priv.h b/drivers/net/dsa/b53/b53_priv.h
index 458775f95164..ef2413509b5d 100644
--- a/drivers/net/dsa/b53/b53_priv.h
+++ b/drivers/net/dsa/b53/b53_priv.h
@@ -58,6 +58,17 @@ struct b53_io_ops {
 				bool link_up);
 };
 
+struct b53_arl_entry;
+
+struct b53_arl_ops {
+	void (*arl_read_entry)(struct b53_device *dev,
+			       struct b53_arl_entry *ent, u8 idx);
+	void (*arl_write_entry)(struct b53_device *dev,
+				const struct b53_arl_entry *ent, u8 idx);
+	void (*arl_search_read)(struct b53_device *dev, u8 idx,
+				struct b53_arl_entry *ent);
+};
+
 #define B53_INVALID_LANE	0xff
 
 enum {
@@ -127,6 +138,7 @@ struct b53_device {
 	struct mutex stats_mutex;
 	struct mutex arl_mutex;
 	const struct b53_io_ops *ops;
+	const struct b53_arl_ops *arl_ops;
 
 	/* chip specific data */
 	u32 chip_id;
@@ -371,6 +383,24 @@ static inline void b53_arl_from_entry_25(u64 *mac_vid,
 		*mac_vid |= ARLTBL_AGE_25;
 }
 
+static inline void b53_arl_read_entry(struct b53_device *dev,
+				      struct b53_arl_entry *ent, u8 idx)
+{
+	dev->arl_ops->arl_read_entry(dev, ent, idx);
+}
+
+static inline void b53_arl_write_entry(struct b53_device *dev,
+				       const struct b53_arl_entry *ent, u8 idx)
+{
+	dev->arl_ops->arl_write_entry(dev, ent, idx);
+}
+
+static inline void b53_arl_search_read(struct b53_device *dev, u8 idx,
+				       struct b53_arl_entry *ent)
+{
+	dev->arl_ops->arl_search_read(dev, idx, ent);
+}
+
 #ifdef CONFIG_BCM47XX
 
 #include <linux/bcm47xx_nvram.h>
-- 
2.43.0


