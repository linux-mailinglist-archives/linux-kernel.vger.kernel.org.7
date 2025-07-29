Return-Path: <linux-kernel+bounces-748942-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 99429B147E4
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 07:46:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F532189563F
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 05:45:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87E5A237180;
	Tue, 29 Jul 2025 05:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brighamcampbell.com header.i=@brighamcampbell.com header.b="lzHJaEg4"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B84A237163
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 05:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753767887; cv=none; b=ub9kM+lh8QLDdgQY+i34/rcL8ISaCJOJaX8fU4sjc08LIXUvuzubjGBqs35Q98K9/tZtpn62ohFSJw2seWG3ZV5+wCsSqZ5LC06tU0lchJ3zJ7K2+4W3SRdWjG64usGr/PSN2UWFTHwCYIeF6XcRmkvIcLMh6mfNqgEKFJBTmwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753767887; c=relaxed/simple;
	bh=wn6aIVhT5uYy+9pKOugbqhAK3ZKulr32QnRr6e2nGO0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hH36zU8b/NVlCwAbclfjiN9kaiM4JNB5MkbLwFhW2SVQY5vLWrY/yy+enD8D1pyivpsY8rYe7Rbwv0HcjjlP6xFcDgZzvKCtOoNk63VkyjR8ricQXsxH5m8XuUOchUKQi5h7wPYEE/o0pCCkkuaOaosq7O3cPCtXRWGgKJelKdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=brighamcampbell.com; spf=pass smtp.mailfrom=brighamcampbell.com; dkim=pass (2048-bit key) header.d=brighamcampbell.com header.i=@brighamcampbell.com header.b=lzHJaEg4; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=brighamcampbell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=brighamcampbell.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-75001b1bd76so3290598b3a.2
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 22:44:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brighamcampbell.com; s=google; t=1753767886; x=1754372686; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Dyl9k/+GgCioEtou2dmlzc7vsavwZ2MlrAwTUSd5lFc=;
        b=lzHJaEg40PGGCaVtgQG9g0Pe9WiBrqfKqhE1nr6vIkfJoX3bAQR+MFj3BKM76BDW7B
         7TAbFkCrSPDWdemcvTFWBAzbhNQU7h3Flk6zAHjXfMRP6sKBtAZDQu2TRhyOT3u2VukI
         KrDvs0J0qd4I54RAOM9R3UzjqMu7WbZfzK+ThZK9BqMI3TzhPOzIC1duSq9zPt/OmVp+
         eQ16sdoW5tWELNEajM6YfujguehJK3XOMmpTsBP4DCgs122Tdg4BZ+T6ckkVybMSM6LM
         u4/vMGTyxH6xkI/F/xGR2pqNb84uSMXsu19t50lms8mIuLwQy+/5IhWVhlQyqhfPSIe/
         +rJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753767886; x=1754372686;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Dyl9k/+GgCioEtou2dmlzc7vsavwZ2MlrAwTUSd5lFc=;
        b=R8D8dEbONLMirJX+Ze/yMJ4XFepQMhdlBAbLFcv746fT/OuHi6zs4Ar338rv5ALNMJ
         JVrUmmLw6vFn37HlTJajo4diRkubc3ci+aoE103gOIgezDknZJaTfHHa+OUIZXOp2U+L
         /Kl8rdwAaNA9QXOCTFvQC8yzNOchFPPABpTL2ZlaP0W7/2dJ7oQZ3Tr/vbRhKXFf935H
         kmvtIwFDbNndGgUyVKQ2orDcAtmVEpMRoz+qcXDv0vy/rM+zxYaXvcp5WMLR580c0KU6
         LsQHRlX/U42782KThgmUjmm2Yqfwx38W730V1XwYwjXLvpD49Irc+1WUR15UMdCCQ9vt
         j2/A==
X-Forwarded-Encrypted: i=1; AJvYcCUh7FknFk0QlM7/xQYTO8+ejWE8x//u3U28D2nS1bV/LlGnNtZGyh9ZQ8ZkW71QdkxhKdBe03t2qDzn1N8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOnl/9HqrEi+sbIepwoFkD8pXEDar3hYu3handweDXFChL01Bm
	GBYb8zEQSwehxLoE4vltqK9/uM1RGchQRgRUv5hUF7CqVWKJ+IwoGG4/5IZQywbYD/k=
X-Gm-Gg: ASbGncv50O6D5aV9hU7rV8jr/GHLxOnTaLSBpRyeh88u6o+IP73z63awT2+vsh/dcDZ
	YJVGQESZ/VM8mLq3FGdm1bKj80ooZPP4ntzYb22OTs+lhhuJB4vdRf6RzWfjoqA2GzcXpdmzeFZ
	AAevSP7g14lGjU5reBCY8R/3FB9Yv+Rr000Zfq0/8KNpn6wjv6J/RjGyO12HLFvBdEz/jEL8nAW
	JdDlp+y0s/kpUa3Tx+U5tOXw4OJnoICyjDoE5oMmSiu4MUmFKyk3U0Srs0XLuKUaAKDVVFh3NbO
	LJ1FxVdXmp8ifFV8/ZM7XgfV2GDNWAOIR/dEkSKakhxCF7IMp1WGuE0Qt3jZZht/BXucHI1Y3JF
	0IQP7pkVu5uEjy6dXeOQ7aPfBrybJWv4wykHB4Q5Y3fX7fzIxWg==
X-Google-Smtp-Source: AGHT+IEXjHtUpb2buMY+5CWdYbI8oH6HrpCcTJ3ZyV6pv+VA6IOFmuXaOileu5xjs8foum5R3PGMSQ==
X-Received: by 2002:a05:6a00:b52:b0:748:f74f:6d27 with SMTP id d2e1a72fcca58-76334fa7565mr21727897b3a.24.1753767885652;
        Mon, 28 Jul 2025 22:44:45 -0700 (PDT)
Received: from mystery-machine.tail542cf.ts.net ([64.71.154.6])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7640872a500sm6972462b3a.22.2025.07.28.22.44.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jul 2025 22:44:44 -0700 (PDT)
From: Brigham Campbell <me@brighamcampbell.com>
To: maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch,
	linus.walleij@linaro.org,
	neil.armstrong@linaro.org,
	jessica.zhang@oss.qualcomm.com,
	sam@ravnborg.org
Cc: dianders@chromium.org,
	skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linux.dev,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Brigham Campbell <me@brighamcampbell.com>
Subject: [PATCH v2 0/3] drm/panel: novatek-nt35560: Fix bug and clean up
Date: Mon, 28 Jul 2025 23:44:32 -0600
Message-ID: <20250729054435.1209156-1-me@brighamcampbell.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix bug in novatek-nt35560 driver's nt35560_set_brightness() which
causes the driver to incorrectly report that it "failed to disable
display backlight".

Add mipi_dsi_dcs_read_multi() to drm_mipi_dsi.c for improved error
handling in drivers which use mipi_dsi_dcs_read() multiple times in a
row. It seems like although this feature may be useful for the nt35560,
we don't expect many drivers to use it. Once again, I am happy to remove
this change if it's not worth maintaining.

Add mipi_dsi_dcs_write_var_seq_multi() and
mipi_dsi_generic_write_var_seq_multi() to drm_mipi_dsi.h to allow
drivers to more conveniently construct MIPI payloads at runtime.

Clean up novatek-nt35560 driver to use "multi" variants of MIPI
functions which promote cleaner code.

Brigham Campbell (3):
  drm/panel: novatek-nt35560: Fix invalid return value
  drm: Add MIPI support function and macros
  drm/panel: novatek-nt35560: Clean up driver

 drivers/gpu/drm/drm_mipi_dsi.c                |  37 ++++
 drivers/gpu/drm/panel/panel-novatek-nt35560.c | 198 ++++++------------
 include/drm/drm_mipi_dsi.h                    |  35 ++++
 3 files changed, 132 insertions(+), 138 deletions(-)


base-commit: 33f8f321e7aa7715ce19560801ee5223ba8b9a7d
-- 
2.50.1


