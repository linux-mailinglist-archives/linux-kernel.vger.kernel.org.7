Return-Path: <linux-kernel+bounces-840660-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A586DBB4EA0
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 20:42:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8FDE04E2EEA
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 18:42:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA84627FB2D;
	Thu,  2 Oct 2025 18:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P+thbIqr"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 870EB27A924
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 18:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759430542; cv=none; b=MGhPdQok6JxAKzIxObv70BuwXDPRdkoomRsnwC5IlOO23P6RmfZMKh3uU3eU2YYVuSW/zqfXkPCA5qgkShWqo/CA2P74b5GGbb5wkHiLizUfyYcFL4cbzv3UZd7gWSFgncmJjyTVAaKXFBWZnB3PQuE+5/FV+Vnl0F7HlHN7vm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759430542; c=relaxed/simple;
	bh=HhCHFa0EFtA8AuRvrj8xtXesClEos9CJZT5NVSJ5C8o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C4YIYoKILseaswDO7oFsNt7qAOOTZo37jHBCrVHcEQdDUn4sqpCOlCtPREhkG6/1A19h3q6307u4pBX1C/EEwCgTRFrAw/nfp6gizEmS7ftvk5tQ78/qbqcdrHkmwxTKiShmVk0Ob5cti49Vb/n+mevKgQa9BEdTaHH3yt+tyvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P+thbIqr; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-789fb76b466so1380475b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 11:42:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759430541; x=1760035341; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7qPjlv1lJ8MR6fVmoY/AaU1ujSOHO/r4FwpJCh/Gigc=;
        b=P+thbIqr9MS/sGnKeKRgJJgjqpy75emZGNeRU97cH/xtMH55/m9veurh/SfDTjnlEp
         mUD25J6wBpPw1hc4AA/fqD9SO8s9i/uEq5bB+2zJrNgO40DPdT6zRgpax0SP9fyTKEND
         q/qiuh/5BsuvsXuLkLhYen3tODNKaQapsCu6RSSTq2PQRGYAC4UaQ/Sv2cTOT2XJQGt9
         ifGks+HxLUHy2oJetbyPpTsBtyQY1N3011am5vO+3MdwJkyew/JjgqemEwqR3d6B8tCD
         jf+F0Ck+IrYEklYTlUCSTot+HqvELTu6TpyYVc3ZMAx6PKd+en/UUk2RcPwkkc2VZvyB
         o6cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759430541; x=1760035341;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7qPjlv1lJ8MR6fVmoY/AaU1ujSOHO/r4FwpJCh/Gigc=;
        b=OTlh0GJAFwQcRt9DGmvyMEKOrqMvnSPjzqLMAhZlVkDXwSLPc61VZ/ofORQpHbai+T
         JSLFvfWR1Q10wHYvuYqacEbtP8g0iKas+BMHYOcSk8Ed2t5tpngAv+15O/hAfeyS0PkT
         PL19lacG01rGlUoUAUjevnQp3jjhW4baA4uK+KLo3qHhSrJY7RPp2rgxA82Aoo127ogM
         khxP4qjZ9ZpbhmlRo3JxEynt+e0M9O/Ogcq+cXuU5dfbUpqW3LRei7I2LuD1yc4UlBWS
         gqI+mCT5ievm4GbdsGhxSIV6x9n7jn0frkUsnTOBELgXMNqzeMByVNDPgwtnbYgGu/xW
         zLpg==
X-Forwarded-Encrypted: i=1; AJvYcCXhnKpudZL+7BdFI8UlbuA/CoSAmxk4KaRqA0iPpQxQj3J5+8uEXMfglKVUf7FuAY3dkuOzFpef119/kYk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9GFTVJliOk6+EfsmyWlyR1V93rDc5bTfPNC1ztuJamC6LwGl9
	AyDw5ff76ISjyiUxcM5nc+qsCWWHfmV53F5gnfF9H4/tLteMuI2vS/aw4cR9tA==
X-Gm-Gg: ASbGncuEwP4EJKOZgf2BAMvUA+pvePU8DUwh6V6jNxy8aAn8dlbzjeoxbfwXZN71JTz
	wv6M4WtuyHhTp/hW7ptYlKDMdUfwBiVdXTk8nG83y9nWUQU7GAFT9sGBZVlhpo42CO2bFvjIoJN
	Z9EdaUu6mCn8MGKANoDwO8sC2NDYqlgfsewmLKUk9T2XmEYAow37Yi03+UIrd77CEy1sKu8r2eg
	tiSEHBu2OOvLOBMV6bEAOB/yWfzdwl3Zia2UsJDVSBIZsO5NdEtZAjd/He1yRLjbAfos1bSL7vT
	hOjynOJTtnLegS/z3aIhOk3JfMIZV1jU7IOSeJ1r01apW7gGRIrVOUuslmpjKlemdM7KK4IvdeD
	9LbXMjU0+0SF6ygLfte9sHrPt3WbK3cOSIiE40qprqZoP2rQGkr2lQXWl
X-Google-Smtp-Source: AGHT+IE158JkUSIaEaS3oXYZ4vFl7nu8N6VKeXlcYX2Ca7DdlwgbiaYwME8zie6eNvnBRdAOll7WXQ==
X-Received: by 2002:a05:6a21:3396:b0:2f6:9592:9065 with SMTP id adf61e73a8af0-32b6209567cmr471844637.30.1759430540647;
        Thu, 02 Oct 2025 11:42:20 -0700 (PDT)
Received: from akshayaj-lenovo.. ([223.233.78.22])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b62ce55205csm162917a12.18.2025.10.02.11.42.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Oct 2025 11:42:20 -0700 (PDT)
From: Akshay Jindal <akshayaj.lkd@gmail.com>
To: dan@dlrobertson.com,
	jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org
Cc: Akshay Jindal <akshayaj.lkd@gmail.com>,
	shuah@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 5/5] iio: accel: bma400: Add detail to comments in GEN INTR configuration
Date: Fri,  3 Oct 2025 00:11:06 +0530
Message-ID: <20251002184120.495193-6-akshayaj.lkd@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251002184120.495193-1-akshayaj.lkd@gmail.com>
References: <20251002184120.495193-1-akshayaj.lkd@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Append additional information to existing comments in the generic
interrupt configuration code to provide more context.

Signed-off-by: Akshay Jindal <akshayaj.lkd@gmail.com>
---
 drivers/iio/accel/bma400_core.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/accel/bma400_core.c b/drivers/iio/accel/bma400_core.c
index 41e95291b36b..c42cdf0a1645 100644
--- a/drivers/iio/accel/bma400_core.c
+++ b/drivers/iio/accel/bma400_core.c
@@ -1208,7 +1208,10 @@ static int bma400_generic_event_en(struct bma400_data *data,
 	detect_criterion = bma400_genintr->detect_mode;
 	intrmask = bma400_genintr->intrmask;
 
-	/* Enabling all axis for interrupt evaluation */
+	/*
+	 * Enabling all axis for interrupt evaluation
+	 * Acc_filt2 is recommended as data source in datasheet (Section 4.7)
+	 */
 	ret = regmap_write(data->regmap, BMA400_GENINT_CONFIG_REG(genintr, 0),
 			   BMA400_GENINT_CONFIG0_X_EN_MASK |
 			   BMA400_GENINT_CONFIG0_Y_EN_MASK |
@@ -1226,7 +1229,10 @@ static int bma400_generic_event_en(struct bma400_data *data,
 	if (ret)
 		return ret;
 
-	/* Initial value to avoid interrupts while enabling*/
+	/*
+	 * Initial value to avoid interrupts while enabling
+	 * Value is in units of 8mg/lsb, i.e. effective val is val * 8mg/lsb
+	 */
 	ret = regmap_write(data->regmap, BMA400_GENINT_CONFIG_REG(genintr, 2), 0x0A);
 	if (ret)
 		return ret;
-- 
2.43.0


