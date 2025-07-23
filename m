Return-Path: <linux-kernel+bounces-743301-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0394B0FD0E
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 00:45:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0BBDA16956F
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 22:45:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38BF12AD25;
	Wed, 23 Jul 2025 22:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d5MM9fMQ"
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29DB3229B12;
	Wed, 23 Jul 2025 22:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753310733; cv=none; b=AfAEUXBuTmNeJc9tzBs/iWcmoaW9x5++U7Myg3Vm2ixny+FTw1cfwTJE8AVSxWef34ftgQbQGQ0HA3j4sO+aZGzVCb9UK+wun4o4aYPP4vORQGGosmqEZ0TQhkQc7d9ygxQ0fmKnV0U0aZOfNUue59uofszjQamPXKeSYRdUYog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753310733; c=relaxed/simple;
	bh=94UAvqGw5BU+XPP0OyfbGx1LunGov/eSC5+M+9sWAeA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jlNmjDX4HQhUlfm/pR1F26xBzxx7tUNg4SgEQHrSS9K61yXntCwj1esGFHNiWxM7BigPFdqtXQ/WJE2aCjnA49924u3Cf2oH/2ARRZQmXwrt7oU5LGxEg0eBKI4GBjr3TtlhwMelTPZeHqgbmGWREsJnUg+8pKvMxLHtWxrNW3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d5MM9fMQ; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-b321bd36a41so393360a12.2;
        Wed, 23 Jul 2025 15:45:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753310731; x=1753915531; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BsSQL3Vwnw+tLfFu0xgQFzyGewrOaXiW80oniV4mXuI=;
        b=d5MM9fMQY0Hmb668cldkVu8i2NVFDocY4qINndZOiYOcxcoWsICV5Gueda5WoZBGoF
         otwMpuXZGbLPUMxE0QpKgsq2DR2bz0SxBJ6czupaSvuNxn6Jl59/qanu+1lK4Vk+oxr4
         /Y3Z+YEIgJoTE6KjxJF3VjiO07AJ912FuPzWhbDlHJp2wzqQpgtwXw9+xhG1SHyoyh07
         6fmfutCC1qXnOavV2ky/mBTtJVJ4CEWhS5A/9Rac/5knx+7oGBSigDo0KBw1Eyxmvzg9
         PmMSJFU8eC91R3sgUi9YWKTuibv+GjyRMV+txKYQaDqXca9l66q7S53dvfCF7oWA/DZM
         jjUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753310731; x=1753915531;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BsSQL3Vwnw+tLfFu0xgQFzyGewrOaXiW80oniV4mXuI=;
        b=UbfMYffTtqG1sL7GPFtyumIVhgTX5wcTbyvwUYu/GOGSyCTjq44V6Af4WVOW9wozXs
         u2vAKcnUrLB1Rlxsnj3MRHIAOuznCnqTgv+lFzwsBOBqmQB3bubL2ZTplNYWESrhcyTn
         Lja4FcO/GXUACM4YQbVqBHh7UxON+tlq1Ukn7m6+PxawhFkReVI3OmKjOfKokO3y9KN/
         A3KGKVQRQKIDUyw8APZ8Kxq01HcYm+/thI5rpHK7sIu97AbYUnciiUvYt2ac4uKHNnaG
         MZk9TAbAYqxxpw8+01c2ViDXzALyzBYH0Lc2AF9cP/yLw9hh3zuJ2Atk0J3kg9o2IkDA
         sNuw==
X-Forwarded-Encrypted: i=1; AJvYcCU7pyKnk6KFgxKE/jLNO4rR9PnVbDqA1F1gd6SOse/Q2gUruw1r7hfGqhGUdewAoOZx8qjv/BX4iwAYMVLn@vger.kernel.org, AJvYcCXQnJ8KeO6BXgYYHGsreT0j8Ie1n7wYWn+wlXHegcsa5yhBpvu4oUAatn/bEC4hkKEAKxKp9S1Pu1NC@vger.kernel.org
X-Gm-Message-State: AOJu0Yynxsvld5RFLjFNf5EOE7rqFtZColDBLt/FCFhoVB1B1JjwkgWu
	GCkrxvKk2u+KJKk2SUFUoMhFXsDRqX4MUX/6J0eqUL9cSROlMCbbpQs=
X-Gm-Gg: ASbGnctEa8/zKxhOD1dIGIpCtuKWxAN/Y63p8oF4r2Kt1MG4hG+3u51cyBLIlsIXw93
	t8Q88BBEUQ2uvrs4slqQLZfwu1xqLy0hRNqR+tShT6STwdMOs67OKLOPdR33MB4YM+Xe9NNPL/o
	kGZiivEQHTddsSTgWMlf8wUEoSBnA42wnZUHW+hqpyKfSHAs2YiDUb61nhvFO1M62gckSLJ+qqe
	jxSHMY9NugOO9Hyo8gGLhPRD6EeJQefjqGVl0WMkA5FfNSTdfjIEPA9Qef000Mo+W1emKVnpo6w
	HvfQJ2fPAy8lQFHoH1rNAC7wTqRXvPg98eNLDw2sGKIz6zw++S070u73wEHNU4m8DP5bPvYpnY3
	z3B4n1cc7psgN+1A0EiqHw8mjFM9oi0wys4rUVMnsG7Kq
X-Google-Smtp-Source: AGHT+IHiZHXZ3o9Sy0wMu/NV5ivRDKsQ0eXF4l4GSCt7RZOpjddgQKvcEcYp1RF9kO0kjPiHk6mgYA==
X-Received: by 2002:a17:902:cece:b0:234:d431:ec6e with SMTP id d9443c01a7336-23f9813a90emr73288825ad.3.1753310731403;
        Wed, 23 Jul 2025 15:45:31 -0700 (PDT)
Received: from localhost.localdomain ([2a0d:e487:157f:651:b817:d1e:dd27:e736])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23fa475f83asm990235ad.41.2025.07.23.15.45.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 15:45:30 -0700 (PDT)
From: Jihed Chaibi <jihed.chaibi.dev@gmail.com>
To: andrew@lunn.ch,
	gregory.clement@bootlin.com,
	sebastian.hesselbarth@gmail.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	jihed.chaibi.dev@gmail.com
Subject: [PATCH] ARM: dts: armada-370-db: Fix stereo audio input routing on Armada 370
Date: Thu, 24 Jul 2025 00:45:04 +0200
Message-Id: <20250723224504.70862-1-jihed.chaibi.dev@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The simple-audio-card configuration for the Armada 370 development
board incorrectly routed the left channel signal ("AIN1L") to both
sides of the stereo "In Jack".

This commit corrects the typo for the right channel, changing the
second "AIN1L" entry to "AIN1R" to enable proper stereo input
recording.

Signed-off-by: Jihed Chaibi <jihed.chaibi.dev@gmail.com>
---
 arch/arm/boot/dts/marvell/armada-370-db.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/marvell/armada-370-db.dts b/arch/arm/boot/dts/marvell/armada-370-db.dts
index a7dc4c04d..a9a05d826 100644
--- a/arch/arm/boot/dts/marvell/armada-370-db.dts
+++ b/arch/arm/boot/dts/marvell/armada-370-db.dts
@@ -119,7 +119,7 @@ sound {
 			"Out Jack", "HPL",
 			"Out Jack", "HPR",
 			"AIN1L", "In Jack",
-			"AIN1L", "In Jack";
+			"AIN1R", "In Jack";
 		status = "okay";
 
 		simple-audio-card,dai-link@0 {
-- 
2.39.5


