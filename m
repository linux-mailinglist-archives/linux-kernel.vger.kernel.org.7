Return-Path: <linux-kernel+bounces-893242-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 94C5DC46E3A
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 14:28:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 619DE188C9C5
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 13:27:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A9D1310624;
	Mon, 10 Nov 2025 13:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="P3CjxPc8"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 916873101BB
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 13:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762781245; cv=none; b=r35UBSghaVmcaC9nUWQ+b8MxkxR226J5CBqhNkVOz9NeM4ITB61GsPuVXAR95BL9AdIQ3fiuDHEBPDNxzGWggdfDvAt9KQr5VrIX1dhQnTD8iID/7v/2r1JzKpYGnbCWAL2TzdYQm2ZaOWg78FK8yLtzCdMEi+LhHhVgo1F952c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762781245; c=relaxed/simple;
	bh=Njp1OFTuz9utdC2qL/d8X0rZRq/nM4HD99+auXVWGJM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=u+3Gle3GwzZcLE0DHK0inLr5NvpyEn1jn2Kwdt4n4x8/WY2Mdo51XC/SIdwgDCRbCw0ljzOne547kEg0cArHZjhDXtH5ENQEbhv0rSlFYx4SKv7CarlYqfmdL5jyI/9zsSwOqh0VAuEzSf/YEVR5NnoAswAUsGWPZUutmKFiVfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=P3CjxPc8; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-477632d9326so23186585e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 05:27:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1762781242; x=1763386042; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hDSYeqhLqgZ1KCbw764tGpkRpKz9b+tHmjUhRyEtv94=;
        b=P3CjxPc89Dq5Fgx9OZEIy1V8mWUOtnFxYfdia1KNR1cY5LIItlzV/Oka1cKY/tSnKK
         D6jLZy+ORqGejWgGBUlAhJTeVvKrjAoS+F/TMktLDYB509mAIKuFZe/mwIc1Zwq+BvtK
         4Mr4bmuhOq+rd6X6h4/LFjvFOsd9xgG/PkX6soVkCDGaGuuxjLYp26TdGV9qtnmhM9E7
         SvTb1yIC8VddkQWqKTfKNT6bAGWuJnqRLR7Bj2aNK0uFKaBx9Js9R2/fYnFZhrA7ZPi7
         qkgJelDy5B2wUCveKxMiEST0+PZ0n6eoTbBfeal16zXbVlvjNa1cd3v2QsWCypAu9FRl
         AaVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762781242; x=1763386042;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hDSYeqhLqgZ1KCbw764tGpkRpKz9b+tHmjUhRyEtv94=;
        b=s8P/WhLa7/KIZy3G/3Bj/JK/hVNyDlFJmzfqQZBO1RoPgjJmIs7XoJHyxKDLW2IVqX
         fRGg6AXneafxb6Sn70eWQOhwQ7L2KzGacquKzw+oaPCBjaFHsunBFKkei/cgXFJ2h7M6
         4yb9hgKuT7CxCBUYzoBqiQSslycKAiuDKgpQoj8myXDsCH5lqDTlCCUC7r8skgN8Fr1i
         xocAa8x1mpBfRJPP4oIik+i7FAGvQK/fpBU/fKql6RTHl5/6NrGf7+lOGe8twZBpU8XN
         /53bIx29dG/yrYCVuyXVP/BKxVtAzty3W4XzYcbqazWDGbmPTgo14xXtV1KCWhcarwTa
         nzSQ==
X-Forwarded-Encrypted: i=1; AJvYcCXcnXyhYAe3xDpWIPVPCW9pcDp43CHddVUFwg7jRhNA1ta1O7ZTXS51I5uZi3jpXiXjKBHXJg0vPGYj9uY=@vger.kernel.org
X-Gm-Message-State: AOJu0YznWCdTw6uGwhj/8esSVgCfdHk3UbMoNhRaphk3SjBTrlTQzlfl
	6yeGdWLb5ixTHV3I+VIS4wOxXUJl/INEvlXaXaJyM/r00+KmtAHKnKZ4QuBvFwWp0JQ=
X-Gm-Gg: ASbGncsoA3gr/fk0+WO/3r1tWDtNsMUZur1Hb/qWvNL5LEOg8/CGCeSiZUMsa8Sd2fo
	DHO1JKys2mu0t0a27djNBXPlCYNPYsvtJhCYSqJQsjw7CNZQzoCEFnQYiu590PXmml4587ByqEJ
	b9jGC0rVfqhr3r/vpURYY8NKr5bMUP5RcfCAA7q1BNLbmFCxSsqI1HBxDWNq5SpLTdTDJiYB0GW
	dTWXp++S/HZVjVsKG7tCnBIp6KQ8c1IfnRbmhQOs7bqGbO9WCdNKmXj97dDaN23ZOseNp6PKrUW
	wIllIWdPkzf3nFm3Vk21kfpZgSge5Dmg/Z4jn4YOJ4JoMWoeW4pLcjQbhmK1+MFIAnddUcfkw5U
	mYnw3fO6rDUD5IQGlXINV2tt6NuGLEpDDBGBOyJ8c3/9RC/XxtogzKXEToDQXGArIEEe3tDwDvF
	IQotvNtQwNJzoj+aficXIUOmlxZQ7Zjw==
X-Google-Smtp-Source: AGHT+IE3xQKg+Mx3z2Jr4LgMiTiQav2Kn2t8JoLdkI/zvAlaZgGcoXnHD7GN7fbZn7l92N4WUe1ztg==
X-Received: by 2002:a05:600c:a6a6:b0:477:79cf:89d4 with SMTP id 5b1f17b1804b1-47779cf8b43mr32595975e9.31.1762781241703;
        Mon, 10 Nov 2025 05:27:21 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.134])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47778daf2c3sm94207025e9.10.2025.11.10.05.27.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 05:27:21 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: p.zabel@pengutronix.de
Cc: claudiu.beznea@tuxon.dev,
	linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH v2 0/2] reset: rzg2l-usbphy-ctrl: Add suspend to RAM support
Date: Mon, 10 Nov 2025 15:27:13 +0200
Message-ID: <20251110132715.724084-1-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Hi,

Series adds suspend to RAM support to the rzg2l-usbphy-ctrl driver.
Patch 1/2 is a preparatory change to avoid suppressing any
configuration errors.

Thank you,
Claudiu

Changes in v2:
- use pm_runtime_put_sync() in patch 2/2
- collected tags

Claudiu Beznea (2):
  reset: rzg2l-usbphy-ctrl: Propagate the return value of
    regmap_field_update_bits()
  reset: rzg2l-usbphy-ctrl: Add suspend/resume support

 drivers/reset/reset-rzg2l-usbphy-ctrl.c | 105 +++++++++++++++++++-----
 1 file changed, 86 insertions(+), 19 deletions(-)

-- 
2.43.0


