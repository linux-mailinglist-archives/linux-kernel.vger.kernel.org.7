Return-Path: <linux-kernel+bounces-816180-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C5D92B5709E
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 08:49:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 56AFD189ABC1
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 06:49:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C476C29E10F;
	Mon, 15 Sep 2025 06:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b="ztqs7/tJ"
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AC461C695
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 06:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757918941; cv=none; b=DqbaAnsuMlLWy4osRThDvDXjHRUBGCzz/5vkitdLC60I2//UGK8KA362jAqoFJD/tZTadvhaks4Ts+0OfheUI/oj4JfYAZN5DLfaS8HQqpyutrw4U6nODEioOnkdSapNOpE1880bDT78Od6viRv6T3kATpg4Aw0lJRfJT4TttCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757918941; c=relaxed/simple;
	bh=1drSnzrbgIy1jdrQOPrFNMW+P1BL3uQW7eCgBejKEJw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=U1M57eLc8F9h00O2/434FJ67D6St+3a0g59EqfYYCUQcqoTqg+WN+gnso+p4x+EPrUuGzxh7GOWUsUv+Gjar52Gi5TpesgzbjbYPpovNUTh8PE2HJCQT7Bnd+8oRDlas6KcWAloDNhLtEzVd75A7UAuIRz5PBNVidqRVYPWADQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com; dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b=ztqs7/tJ; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-32e32f702b9so1086415a91.3
        for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 23:48:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=huaqin-corp-partner-google-com.20230601.gappssmtp.com; s=20230601; t=1757918937; x=1758523737; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fiUtUPpKH3GTS21MnIohX80aiXP/6F0+dIepjp0LO+E=;
        b=ztqs7/tJpilYAmQFpQOrXUEw4Ihmuu5uvyv+mdXZnVWqtylvVw3aa/k0I2iis2BEQM
         ZfFenRbHA9nqMgPral+37jPx5yOng7QabgxLyNPUUH0OW69RBYry7VE9PuOMjjqCAZsC
         T5cp+wHMTe297c0b9qMSNqO460rYCDEvfn4meqWZ77KOvhhi40REqnvxeSk1Xt+Zy7K+
         YWlqF5c8+aEbSORzpb70np6OFV9tgGiIqMjSTRULJbTVG6mKIz1A27SSB4sbNliTLZXn
         K6yajmBF0y2UTn3eFCwAyhuCPS01ou0ju6iU7Qaqvw+PL3G83Ph+eRrPQ8QMottphZsT
         OFTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757918937; x=1758523737;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fiUtUPpKH3GTS21MnIohX80aiXP/6F0+dIepjp0LO+E=;
        b=cO4qExO5ucR6P7HFBqWUA6uWeTDyn31GgUjO2WtIurXXj0RfYun3U/F6M3PShd9Th5
         0MZTD8BWtf+sclfbOQvTr4JdkVuh/mheluSzD1mjWY1ARjNXAyY/+bjMYttb9/h5iwKM
         VY5LgBmEpswjBWB7gfofy2mrvIhCf54v7cXb/DW1bQ4/5yd7sucqwfFJGfXQyhQos9Cj
         0ocr0jNE7Y5VQSMLz/O1vPkpRGX4h0YdT7piPJeYkWbGPlfHfJBdoJ8VaZa7s9WzkccD
         6Yz8nd/ZpBVC9RxS701RtX26m9zeBvHryQUIF1tejKClfuA0DbNqt11Ujg7sXWzZ904N
         auHQ==
X-Forwarded-Encrypted: i=1; AJvYcCU8MzCl5BPpTBuUY2AB8nxDDokmnD5doLuldhagDzxL2G5H+dlKb9V9LP9j1CgA+uUg2BESumbMTwPMmtQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNNkECGvhzR0kghXpO03TDVVsDRQ4WUNQ1AkI8ybzqL0W7Hd/b
	uo4UTtfkuKjAKe/u0dqmi5GiEdE85AvdFnapLDWaIR7fbHYrONk5PcIjaZfSqJXD8Fo=
X-Gm-Gg: ASbGncs9g3wolxVKOcZ5P2wY6hi1cYYCSuC6ZB1KPjHaPijVcgIQQt8y9RP1kZ+Hh7q
	l/o3nDoJlxO1bKE5/olvWuVsv6e/4LE3qkV6xy4uAbodIjMi8lTIPN2j0TIeUgQ43lxW4tkpGYn
	dygiJh1IzEKbytXwhYw38BGe69Ll54BzLy5BFP99wt7z00c3onnzU2ud+fM1+Ak0Z80ZpdJsIIO
	7uzfDEEKBkoQJDO7BuNFzgmRFxtysI/2NCjXI0fdYll/7j3CBcODMdnjHDHxA9vAUS2WMrmCyDM
	ycoHhXQc7MlgtfjjSojJXzOGYJqDdk6INtThdQ4cUu//NOHKeuaKZw4PHRF86aKy8iHG9w81hyY
	Rwo3U6UcrTdhgkHCcIkmDR2T1/KpHiwfQMUT/MQgOKv9FJfEzrNUt4YhI8Q0Y1Ew3PR5DJQ==
X-Google-Smtp-Source: AGHT+IEtIy+Hi5uuKxac8S0s2Kwt21jsETnnkrvc/UZLJ8TEi/PCM+nYkRL0KblqTptdD8le+aZKYg==
X-Received: by 2002:a17:90b:1d0c:b0:329:d50e:2f10 with SMTP id 98e67ed59e1d1-32de4f5cde5mr11445513a91.22.1757918937437;
        Sun, 14 Sep 2025 23:48:57 -0700 (PDT)
Received: from ubuntu.huaqin.com ([116.66.212.162])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b54d3f4d40bsm929084a12.0.2025.09.14.23.48.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Sep 2025 23:48:56 -0700 (PDT)
From: Zhijian Yan <yanzhijian@huaqin.corp-partner.google.com>
To: sam@ravnborg.org,
	neil.armstrong@linaro.org,
	daniel@ffwll.ch,
	dianders@google.com,
	hsinyi@google.com
Cc: dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zhijian Yan <yanzhijian@huaqin.corp-partner.google.com>
Subject: [PATCH v2] drm/panel: Add support for KD116N3730A07
Date: Mon, 15 Sep 2025 14:47:14 +0800
Message-ID: <20250915064715.662312-1-yanzhijian@huaqin.corp-partner.google.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add panel driver support for the KD116N3730A07 11.6" eDP panel.
This includes initialization sequence and compatible string, the
enable timimg required 50ms.

KD116N3730A07:
edid-decode (hex):

00 ff ff ff ff ff ff 00 2c 83 10 01 00 00 00 00
02 23 01 04 95 1a 0e 78 03 3a 75 9b 5d 5b 96 28
19 50 54 00 00 00 01 01 01 01 01 01 01 01 01 01
01 01 01 01 01 01 09 1e 56 dc 50 00 28 30 30 20
36 00 00 90 10 00 00 1a 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 fe
00 4b 44 31 31 36 4e 33 37 33 30 41 30 37 00 2e

Signed-off-by: Zhijian Yan <yanzhijian@huaqin.corp-partner.google.com>
---
Change since V1:

-Add edid in commit message.

V1:https://lore.kernel.org/all/20250912131104.1726775-1-yanzhijian@huaqin.corp-partner.google.com/
---
 drivers/gpu/drm/panel/panel-edp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/panel/panel-edp.c b/drivers/gpu/drm/panel/panel-edp.c
index 62435e3cd9f4..2c8536c64c19 100644
--- a/drivers/gpu/drm/panel/panel-edp.c
+++ b/drivers/gpu/drm/panel/panel-edp.c
@@ -2046,6 +2046,7 @@ static const struct edp_panel_entry edp_panels[] = {
 	EDP_PANEL_ENTRY('K', 'D', 'B', 0x1212, &delay_200_500_e50, "KD116N0930A16"),
 	EDP_PANEL_ENTRY('K', 'D', 'B', 0x1707, &delay_200_150_e50, "KD116N2130B12"),
 
+	EDP_PANEL_ENTRY('K', 'D', 'C', 0x0110, &delay_200_500_e50, "KD116N3730A07"),
 	EDP_PANEL_ENTRY('K', 'D', 'C', 0x044f, &delay_200_500_e50, "KD116N9-30NH-F3"),
 	EDP_PANEL_ENTRY('K', 'D', 'C', 0x05f1, &delay_200_500_e80_d50, "KD116N5-30NV-G7"),
 	EDP_PANEL_ENTRY('K', 'D', 'C', 0x0809, &delay_200_500_e50, "KD116N2930A15"),
-- 
2.48.1


