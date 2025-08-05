Return-Path: <linux-kernel+bounces-756312-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E1260B1B28D
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 13:19:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C437E7A35DE
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 11:17:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3B96259CBA;
	Tue,  5 Aug 2025 11:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WcIGHwxo"
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B263A24728B;
	Tue,  5 Aug 2025 11:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754392728; cv=none; b=C4WNWmtQNv5nDBMrpNIEV2MJj2IXqSk8ZKEUO8yS2MfwRBoCQOuNAWjuFfY+aOnJt9D7TsdS3QW8amokQz5k02tf4ehel/ULgY9+YUZfJALD8FaVUPxSxy/sjBTb2+7du9r7n1IUCfE18qd/pTE8/qXXa80Z0fqbclaRZGV3BnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754392728; c=relaxed/simple;
	bh=HWKv7ENcWJ5P5qVVKyV90sLF4YTQf9daZ1hSHW1sMG8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pG5jL/zQoKFRrKoU4VUV1TnQSyMnEshNkXIdFgdIhBM2PL2/oW6QrST2vIeCZWRAuiJxMp1yZQgGwcMR7FO7b8+6oouitxSl8zdwPbscI3bMPXfsUewUjL3ppVeXbddh2J/WjmkQh5yuksg5+TRJiRAH9eqwfcznycqqIsY4w0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WcIGHwxo; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-3322a34e84fso41861831fa.0;
        Tue, 05 Aug 2025 04:18:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754392725; x=1754997525; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H3jwKXNI4rekJ3bC3lnRJQ6Yd8MMqu4YCCAHk1Ogkeo=;
        b=WcIGHwxohv4Ep5QC1hxJdkCI/K1HNWNgoe74uJARmnsztRHyngsQmsT6I+aq3VMwnR
         BLx+hD0TjC77QTmU5uzAbAD5y+LiIPKsOkl6YdISRorJLgOThrjpMJxGq8hasvBSQZ+H
         8xH8I2r0HKtV39EPhGubXtJIjgSOlshWcQwtKpKjDmdwTcqtUovLGG32qFFwzUiVizCt
         edoYizUmimInnx+BgHgj1LZB4xl5wNrnCwhuxo7jCe7qt2xHdEXNYKP+hbZZS2Q9u8gv
         VOaImBv85b+Na40KH84K4M9wai0OqFzvlkdUoAyVvApbCqgvJFFldb4TwFx/YBV26gGK
         T3zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754392725; x=1754997525;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H3jwKXNI4rekJ3bC3lnRJQ6Yd8MMqu4YCCAHk1Ogkeo=;
        b=LRFyx5WG3Qdkm04fun39YX9Q6AOs1mCNNU3qwcQ7n2dIrMftoQikomF3TytoKK3C+J
         n0Bsp2tCqOl9W8b/beK6rkXCgRJgx5z6JNktT1FOR2OUu4VvJqoV3TTmcUc44GEA5jMt
         ApgUcNrkwNAljNMe7alaOGGNXKwSmXevKiMLtyqnFU1qlgv1LKdSCFYL9mDB+PSbeuI+
         QZayD7TALn+Uc0bX1gK9O4e21BKEMNwoWQ2JKixeBB7g5Dh+ChQVWGpiZP1FRZxpIH02
         8pTraqRUTr7I7W4mKmC126MjhtlQdnmpufZTwN7wgjyCc9efLU0RYeS0PqK9RNPPwR6N
         70EQ==
X-Gm-Message-State: AOJu0Yx3nZpynIrTUadvNq7oTcY8lokcZEdAeEhDggPinXmv3SbprNSK
	9v5ce8/4R6utpIuFmgCJEdmkiwu7/EixLGYmgGdAxxoZDsR0lPLY2M4RWZAeuSTjVuPnoA==
X-Gm-Gg: ASbGncv98HFwAt+yPTUWmtdmD3bVoAB/RivfXeDXhNQqp2EkOmyUEQ0dfDwJGcTD7/5
	pel6Km2JHbrwcGUGj2pXzoZUsq24VTzjrWtiUZuRMX1njqBm5z3+PviU2uVrmVXuD48cD5jj/Lu
	BGgmWva1sD0OVkV3C4ia50YH1C9IBw7Doy/a/hhRaKjethEk7da+U243e5PrKGmzUkc9xx3WkLj
	5oEId7VBiwFR6shcTOdC24rdFK8LWX7EOhYuzXV66UHfJBBLKYukd1r54G3jEXGmMDfDWEhh7wr
	nDWRmdzW0yCbbl6trP4JK7qA15shw5gSN1Z99gYMbAIj5QOatTOmxBZK1CYYjb4WHT0nFppkgA7
	EOsGbSneF/EZAiMie+Evp0GA1
X-Google-Smtp-Source: AGHT+IGKYReSnAS/we3DqHPYR1vVqaW4RERMy1vQce2L8Zm81CShyAFEbk/EjveCAyDjT5F3Z0KRoA==
X-Received: by 2002:a2e:83d0:0:b0:32c:bc69:e932 with SMTP id 38308e7fff4ca-33256687baamr25842891fa.7.1754392724481;
        Tue, 05 Aug 2025 04:18:44 -0700 (PDT)
Received: from artem-pc.. ([88.201.168.202])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-332382a9054sm19367161fa.28.2025.08.05.04.18.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Aug 2025 04:18:44 -0700 (PDT)
From: Artyom Shimko <artyom.shimko@gmail.com>
To: linux-hwmon@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	sudeep.holla@arm.com,
	cristian.marussi@arm.com,
	jdelvare@suse.com,
	guenter.roeck@linux.com,
	Artem Shimko <artyom.shimko@gmail.com>
Subject: [PATCH v1 1/4] hwmon: scmi: Add default case with debug output
Date: Tue,  5 Aug 2025 14:18:38 +0300
Message-ID: <20250805111840.6472-2-artyom.shimko@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250805111840.6472-1-artyom.shimko@gmail.com>
References: <20250805111840.6472-1-artyom.shimko@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Artem Shimko <artyom.shimko@gmail.com>

Improve handling of unsupported sensor types:
- Add default case in sensor type switch statement
- Log skipped sensors with debug information including:
  * Sensor ID
  * Sensor type
  * Sensor name (if available)
- Use rate-limited dev_dbg for safety

Debug output format:
"Skipping unsupported sensor ID:%d Type:%d (%s)"

Signed-off-by: Artem Shimko <artyom.shimko@gmail.com>
---
 drivers/hwmon/scmi-hwmon.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/hwmon/scmi-hwmon.c b/drivers/hwmon/scmi-hwmon.c
index 364199b332c0..a3b5b5c0ec25 100644
--- a/drivers/hwmon/scmi-hwmon.c
+++ b/drivers/hwmon/scmi-hwmon.c
@@ -275,6 +275,10 @@ static int scmi_hwmon_probe(struct scmi_device *sdev)
 			nr_count[type]++;
 			break;
 		}
+		default:
+			dev_dbg(dev, "Skipping unsupported sensor ID:%d Type:%d (%s)\n",
+				i, sensor->type, sensor->name ? sensor->name : "unnamed");
+			continue;
 	}
 
 	if (nr_count[hwmon_temp])
@@ -323,6 +327,10 @@ static int scmi_hwmon_probe(struct scmi_device *sdev)
 			idx = --nr_count[type];
 			*(scmi_sensors->info[type] + idx) = sensor;
 			break;
+		default:
+			dev_dbg(dev, "Skipping unsupported sensor ID:%d Type:%d (%s)\n",
+				i, sensor->type, sensor->name ? sensor->name : "unnamed");
+			continue;
 		}
 	}
 
-- 
2.43.0


