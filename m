Return-Path: <linux-kernel+bounces-849652-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F6A2BD095A
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Oct 2025 20:08:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 829C51897D46
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Oct 2025 18:08:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A1352F28FB;
	Sun, 12 Oct 2025 18:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mwIyc7OO"
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E6842F28F8
	for <linux-kernel@vger.kernel.org>; Sun, 12 Oct 2025 18:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760292450; cv=none; b=Tk1PpVeNrDWhU1C0f7yV66Y3RdAVIIqkTKiAm7/nHr4zJD9rXTMWcjZvudqxhKBo44oUybH/GABMdm4ekUlNbnOjxkYEAw8IABTo2ao28xjoYHkNjtrNpNrIGm4KJsJSj7Q/AKPHfhuJHCrCe9yJX5Wk5b3+fMKSG5xReKsDS8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760292450; c=relaxed/simple;
	bh=jg2NE16emE6/A9nnGAISOkOaG4gb4wO16wIq6mM5VFU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iIIITQYaGAmFREo8q+vt91DcQgz0zMXdaystDv1ms6RN/wqS6fqyr+S1Z31s2KbVTw1k/Jwjwy78WxHYMTA6Bwrseme1LDyigAXM7VjewSznb9l0h+wpqNMIgEezafQW5Hz1PSofheFW3Tx83R5ekq2XkqKaYZ7K7NorrFLxkcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mwIyc7OO; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-b57bffc0248so2515685a12.0
        for <linux-kernel@vger.kernel.org>; Sun, 12 Oct 2025 11:07:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760292449; x=1760897249; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h4ud3JfniFPXrvZXNPpGJmhJ0NKwQUht98YQCdsaH54=;
        b=mwIyc7OO6NJwbovsJbrCto84mwQrRL5O5ADuPoTWKtl98q4mJThs327Uo+nZyGWaBj
         n0UcjQjl8QvtwiBBsPWHZuXpgU6QIbdLZiwv+GEl3hNc67qkb7AbqJZHUYywoPMln/g7
         2QAgSj/AKLtQRwWgUkPf3yC9qqFbSDz2okU+vrJKwSCB0nptbuA1s2ec1EnYtDNdHgxP
         ecBAJwlqE4ITgMO4NYXgxu9xtI0yzEvsqIsFHthyb3s+sJS4YWNnKBci9M4QMNiwvY7l
         K5gH5hrVbGjtFhUUkMav2YqMVR1QPDKuvL7BPeglsl4OvfUalYCEdV3Bs8qdZjR59V9f
         S9ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760292449; x=1760897249;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h4ud3JfniFPXrvZXNPpGJmhJ0NKwQUht98YQCdsaH54=;
        b=VkNEQSEn9zd+kbMMsLwwUJNtTxEVbkzE6K6YR3ZfTbMdfkQMYosJOYfHPm7cYM0gHr
         tZazbeHodxqSUeuwGtuzbzblW3BJURpEDye5w8rqwaHYI7IeIUkSC8GUdUShdO3c4fSc
         1i4UGk3PhDt3GYWdVvsZec7AVq+Ax2s6+st7ZLoL9Tjkd70gbEdKoKO6nphm84VzOZPt
         wppiYFsh0g1RVcE5ThLAg7YcYg4rATVDlQHyse9Gt75FPCb5fWvKV5R/IRPddmYcNWOO
         zKyiipM9/ab/aENtw4M/Q3oK7iaFcQACg0KshVsFPlKxaXv4tUt1zUlXg6Evmn+Hwke/
         hPtg==
X-Forwarded-Encrypted: i=1; AJvYcCX/fTHQ9gcbF9H2AzvULUuvLUhqHoKukTQIY/ZVibJlcwl3ym6bOedQ59nIxboBAl9DhMjZf8H18l3B82U=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIzU9uQ4E3/DfmjMCZ6UBkQvBUlYtBCLRARLJe9Er7/wmt+TTI
	T5LTscdFkpdtaaPOkD1wEXY0lhFf9K3BRK2SodlgTN6Fu+8imygp8M2SEaO/cQ==
X-Gm-Gg: ASbGnctsJQl9To6LPfffXLDFHO9XyJhgD34nwnLDG2ZOY3Mq3nmtsTvCGZVzvumvxwY
	MVdTnZkeypd0LF/HSqtq0USlwoUxjI/ip0GwFxsy7ibu76jvCpwk7xd7VzNYTSbm9RZG6KtuAeg
	t7Kzv1LvqUBSaD3mj7Kvv1aBdY6a5otJG5VEGo7Po7A3D+GevDe7RsA9Q7b8ucf3BQY3QIrZrpH
	l2f5eAfFkeBhmUWhrTGFRoTrBOGkPJFR13aFmmzagucR478Jh+FxPTWjKcCX2exYMJikgoiEpt4
	psOQIeEORHVW9dcYBTSA/pgI1xIwdjXa1hVhNCRwO0Ylelrsz9bUZKOM2zsTuYBzpACg0ZjQ9St
	RJLnpWzbRNkdLOa6hEBNbpU2Jy5YHQvXBCHD814QgJbbcfTEigkDpvEIpU5Rsmg==
X-Google-Smtp-Source: AGHT+IFQrrOSKTP+v5RJLdPE2qomGexJJnmalRps8ECs1c2T3X8NS+ECJAuU0t4ycD7nqvokir+lIg==
X-Received: by 2002:a17:903:38c7:b0:269:aba9:ffd7 with SMTP id d9443c01a7336-28ec9cafcc7mr251834875ad.25.1760292448673;
        Sun, 12 Oct 2025 11:07:28 -0700 (PDT)
Received: from akshayaj-lenovo.. ([223.233.65.54])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29034f56c0fsm111734345ad.104.2025.10.12.11.07.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Oct 2025 11:07:28 -0700 (PDT)
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
Subject: [PATCH v5 6/6] iio: accel: bma400: Add detail to comments in GEN INTR configuration
Date: Sun, 12 Oct 2025 23:36:13 +0530
Message-ID: <20251012180619.195244-7-akshayaj.lkd@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251012180619.195244-1-akshayaj.lkd@gmail.com>
References: <20251012180619.195244-1-akshayaj.lkd@gmail.com>
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
index 840c4156ba60..05f72707f830 100644
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


