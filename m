Return-Path: <linux-kernel+bounces-742578-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 57B6BB0F3EF
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 15:26:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EAF3E7B675D
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 13:24:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E61C933DF;
	Wed, 23 Jul 2025 13:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hammernet-be.20230601.gappssmtp.com header.i=@hammernet-be.20230601.gappssmtp.com header.b="vimqZbjm"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8530D38FA6
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 13:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753277146; cv=none; b=lVvexdrvq6UXla8kHo2i5jqu3P2EvMs4vUjcbZezVoArTJJIwKos7ri0aBrPOm/R1AhyHsbhIOJw/9R4Qt12mG/HXU8ZDnsV7lTJ4eETDUUWH7sh773HsKuISdp1fZz5hxYe393H8sQRhnLIVjpR2LaCwZW18QCfAseCTWj0zDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753277146; c=relaxed/simple;
	bh=IRWOjBedd9/hnuVTcXrjjqnFUAKjZDKX/qV1HyL1jLk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HVFQW2fzpRyImPe3/Z8/CmkUWgyq7wNmwvU4u/8A4J4PwpYKg75feyIC8xyzZkepGKtOIvCHnxqsTbIjN9KX98tcjJCGiHDorhKpflQC7UviaZRdrkXURBD0kn5fqWRDtrif2W/bvitQlNhCqCsEuHJ5LL5838X/5B9cibWmOBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hammernet.be; spf=fail smtp.mailfrom=hammernet.be; dkim=pass (2048-bit key) header.d=hammernet-be.20230601.gappssmtp.com header.i=@hammernet-be.20230601.gappssmtp.com header.b=vimqZbjm; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hammernet.be
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hammernet.be
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4561607166aso52050505e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 06:25:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hammernet-be.20230601.gappssmtp.com; s=20230601; t=1753277142; x=1753881942; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/jOFjaGN3CsVqLePSDjEetRndyZpxQTsvQQ0tgo6UDc=;
        b=vimqZbjmm/spvJmXK/kKPHBVAm+U/wAHIaaLk8ZPVLGZGzItLRZcjYh/vxcTTW3un1
         XCslBPt8gt8zlDHgbUflgpoZysDlYVrBwrxpyZdE94z+3BaFz28+eVPa5XsN/79+waGk
         cDAwI4jHBNW7gYSpb7KOSn5QTW40DP1bsZ02nQ4cno9/XPCAzgtwGQ15cT2yRzqWW2MW
         HPaVdQbsZ3EQcynQLhUWWjgd+WCe/qp0FIX3SB0tK2Z0U0DSnDRR2bgs4RISZVinVJrz
         K2zZuYgzwPUuPmrOtm7PmM2oI3XId5t7yZ86MjIveNG81zyfKCPjY/Rv6qcrb4FfV0lZ
         bCjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753277142; x=1753881942;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/jOFjaGN3CsVqLePSDjEetRndyZpxQTsvQQ0tgo6UDc=;
        b=nF6UwBR9Fi3obDcpUVBZ1L9I0kAvWZqGzi8d82iyF6HnT3eHDVmVVf/R2gb2oUDn5H
         cHJXdeRJHdcr2Xjclg7ly7gdouHpu8tqHqxCKWyRraD/UwIm5hoiKGBIJ+uY2qoTL5wG
         k/p9J5tSQo3aVPNsmPpNkznR033a38A6tQVl5TwPBxWuTedNsWrMhJNAWg1ku5/0LCoA
         gEMqOGLixZyZi2AiHdNRtGAcF3lbyMYDTP2Ag+42l7ZauFYtz5b0YMKWYgT4FWccgusC
         W4Rxr4g4CrkGymIzAFh6li/BObiC+yU122jrV6eL0x8WGkYie7GK9e+iccKuBzzsUrE4
         DrgA==
X-Forwarded-Encrypted: i=1; AJvYcCX6CwALv5JhQH8Cwnvrjkz2IL0P2htrSl8WbV8WJoocVle31lMbjjvbIsW+ta+CWopRWgYucM7BbEWu5Ow=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcoI7moZ8iXjgIbYEb/qOORUnImsUrVJyk/U+kCMloe3u4g/Rw
	2gwf0dBe4yxEv5X03AfSZ+Ah8rxDoxiDCmocAzDMXZ+XsNgJIBBsJeKCD4M6B7N1ES8=
X-Gm-Gg: ASbGncvXoPISZxXxW2YunAK60nKbkI13SkKAtepjsdnww4uegWY28oWxJfHU/MLMqjB
	2Rs0z2jRRkVYmA8tmqIyEfEcfUjDJpR238daZNPKwRz8/RGwVZhDSReygK8hMoPIoGHdCIGO6Ae
	6Jpkl90guZQaDrSJFgsxPtvFM9/Y/EvHnVZOM9elqQj3yyOUk9qG+ENU61iNWrlb0IMDBtEBBXR
	issBxB3qa2bhDXkskjV6MVUNP3WdELjtB7yycm1jTGA3N3/BlzwsKRIelFGwR87m5OSamWHfmoB
	CAnCxeW3UgKjhVHoccBSEq3B6Fv39mv6ItPz8rzZ9Zx3/fmRiUiNwQZZKhLa38qhjMSsBI2slxD
	agUALOg7nEcUxLwnNrWXxMqLx3OS1GY91hMPZTv8KVldRixbjNA==
X-Google-Smtp-Source: AGHT+IG7lEmEEOErHvtFjRdp4cL9IAeiY0R7yViDRurEsfQTfNPWbZmrOYW259gPKET6e12uFu2ovw==
X-Received: by 2002:a05:6000:288a:b0:3a3:67bb:8f3f with SMTP id ffacd0b85a97d-3b768f16391mr2725907f8f.53.1753277141746;
        Wed, 23 Jul 2025 06:25:41 -0700 (PDT)
Received: from pop-os.telenet.be ([2a02:1807:2a00:3400:7fcb:5e01:8f11:1009])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b61ca315basm16320109f8f.39.2025.07.23.06.25.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 06:25:41 -0700 (PDT)
From: Hendrik Hamerlinck <hendrik.hamerlinck@hammernet.be>
To: sboyd@kernel.org,
	dlan@gentoo.org
Cc: skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linux.dev,
	linux-clk@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	spacemit@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Hendrik Hamerlinck <hendrik.hamerlinck@hammernet.be>
Subject: [PATCH v2] clk: spacemit: fix resource leak in spacemit_ccu_reset_register
Date: Wed, 23 Jul 2025 15:25:04 +0200
Message-ID: <20250723132504.66273-1-hendrik.hamerlinck@hammernet.be>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The function spacemit_ccu_reset_register() allocates memory for an
auxiliary device. If auxiliary_device_add() fails, it skips cleanup of
these resources, resulting in leaks.

Fix this by using the appropriate error handling path.

Fixes: 988543522ebd ("clk: spacemit: set up reset auxiliary devices")
Signed-off-by: Hendrik Hamerlinck <hendrik.hamerlinck@hammernet.be>
Reviewed-by: Yixun Lan <dlan@gentoo.org>
---
Changes in v2:
- Properly place the Fixes tip.
---
 drivers/clk/spacemit/ccu-k1.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/spacemit/ccu-k1.c b/drivers/clk/spacemit/ccu-k1.c
index 65e6de030717..5bb85e32c6cf 100644
--- a/drivers/clk/spacemit/ccu-k1.c
+++ b/drivers/clk/spacemit/ccu-k1.c
@@ -1059,7 +1059,7 @@ static int spacemit_ccu_reset_register(struct device *dev,
 	ret = auxiliary_device_add(adev);
 	if (ret) {
 		auxiliary_device_uninit(adev);
-		return ret;
+		goto err_free_aux_id;
 	}
 
 	return devm_add_action_or_reset(dev, spacemit_adev_unregister, adev);
-- 
2.43.0


