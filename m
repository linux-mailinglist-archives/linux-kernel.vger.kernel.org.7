Return-Path: <linux-kernel+bounces-783539-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0F54B32EC8
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Aug 2025 11:27:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 912063B32DC
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Aug 2025 09:27:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 540492641E3;
	Sun, 24 Aug 2025 09:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dBTBtonU"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 207E925A2BB;
	Sun, 24 Aug 2025 09:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756027659; cv=none; b=cl6lLUK2zOjtl+9S9K1yD/iwKqnZIFDjcDXlllpnLrYy3oZ+LOhjvWqmsssAzf1cZuYm3nAze/c0iCvDD0qSKBcgEv2tuEabIBj17H/ascKipJlfNRN/aRnIsoqYvRdtmgh6vHHT9PxRwBWcwVdZpV1zZrYU6Tun+6RpegEGuYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756027659; c=relaxed/simple;
	bh=pTxN5ed8bJapcVec8RN8KlEMDIw471Wnk2w6nTz7sns=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UjcnzcjZEDC5ok2w0QBat2y9F2bXQJeJxF7tT0K/KQTDtj17NYU+AD6pKgHHYQrKxzZ7y+AXQnET9lOzbkPpMkLYFvNzGNqCGD/9v9ko6D31fpSGQXrQZi9ZWECqZL8hDf2XjwLn3iBJocVgEF+9bSuV5boNNsr9CiaGBmgVOcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dBTBtonU; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-61c26f3cf6fso3718207a12.1;
        Sun, 24 Aug 2025 02:27:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756027656; x=1756632456; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QpGLLUNQscE/kPg1TKl6LWBCLDLaDqD+YWwgJokFJD0=;
        b=dBTBtonUKfdtif+O6a5L3NIQAyZQBQ740+q63KvS7Ap+BixMBb9UrdYJkSV1c21hRg
         CcUvaJsIFD+7fWp5fK6ODD1dkMVtjz1B4PDCes99yy1h8H8z03vr4Iv6fjVmyxn3+2d1
         bpBfcrkcE51K/zChm+8bUO7yiB/Y50Wj9o8g22aarM/5r9p/n/vxlqR1qIxQF0Ff4QBQ
         KCG/aUROZ6vh5FoL9O8912UYynkF8l8rAuoNdiY0hxbf7+G0s/DxUqUEfrOiTg9IcCGf
         lreYDGtH7syYM2ak6PwmEcpjyduTvAaEpMkrF/mDyfvCQc7i3/FnPY3DpSEe1URM1NUQ
         cytg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756027656; x=1756632456;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QpGLLUNQscE/kPg1TKl6LWBCLDLaDqD+YWwgJokFJD0=;
        b=eYz7KhrsQlh8WfFKiHbKo2hTT7CWLyh7MBxPLPhVJxzrPuI/VtLeW1XA++V/EncHdT
         GixbQVCQE0g5tM/EV5tbNCqYpCmP5fI2v0oQtIZPKullJl38S8lETi02vWn7cWHHL7Al
         DNToKjFAbkc2zLXhNtriiD7//WWRlle1E/cbzRU+MEN/4cSNNTuD/XhhLUl9c8e+lDv+
         wMYOyeflEQcCYiJW6fNBnmumttK4P2/hiWNQC0dsxVhx1Z2Jn0pn7Ky2ZO5VocTqSpyO
         Zdd4i6soKTBKySr52/y3tnYMCtHt6DRCQAdGESaDiks2YMNhp815siAGdEcfenWmfhL2
         yf0w==
X-Forwarded-Encrypted: i=1; AJvYcCUubNJL4l7hwpAbDzJBawfdAHitc2gO7pjGQF5DU8ggjBcUHGcS0SRqNw01iFme2/A0NXIX6dBObOSr@vger.kernel.org, AJvYcCVEpvZTuYPs83wg1yc9xDM7udc94MDKzPFUG+xaG4Rg7ib6e2q7XNALjZFIyn/wsEp36bWZpbvBVGsE9VPS@vger.kernel.org
X-Gm-Message-State: AOJu0YxCkLyeIVBnU2caox5VRoR5Z+yiLafTUo9Oh/IEJXIFMyGwO8rV
	EisUhamhJy3B5R+NFlW5fiHs06DtgzhDEePpjfc3RqDZz8HCQGLr3CoW
X-Gm-Gg: ASbGncsLOExZGl0gXd43LiREVN0bXlwx0oyOI87QZjeXtKDoY5vcQ3+WvCiDGYSaRJt
	6D0Ws/lZD7bxZibOjalxtSdUQ/AWRxEGuZeAAJDBUrn1sBCNwNpKEFE/aYS8bTpubat7roxCWcp
	J5WfteuoPRBHvJSzia/IQNjEoKo+8skUscQNow6oNMLaiyDZtkyNFXocljoI9rHIqKVVO9Ap4ik
	IV3m0zb0hkQFAq891uSOpTBohN8mjxcYogOuJleUqhnnZiLJKsLgS/LnSxmC525OjJBn+d/6jDt
	js0k7APObYY9xN5kZE4J1o2/vMgyO6QLbYZIjQqhFMeNtXi/OPQKYXNYJwGpyyGQqw+BpWDd3HO
	7y8y6waQp+WyHvI6WfKA7q7el
X-Google-Smtp-Source: AGHT+IGmoBRzHic6I2jrFPimeAndq08OTOYSvf/ELJQK4Kcm6+/5O6wg6YTT5GlBhd83WTB+sV1+aA==
X-Received: by 2002:a05:6402:4314:b0:617:d013:74a with SMTP id 4fb4d7f45d1cf-61c1b3bb4d8mr6534313a12.4.1756027656345;
        Sun, 24 Aug 2025 02:27:36 -0700 (PDT)
Received: from xeon.. ([188.163.112.76])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-61c316f503dsm3035391a12.31.2025.08.24.02.27.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Aug 2025 02:27:35 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Andrzej Hajda <andrzej.hajda@intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Svyatoslav Ryhel <clamor95@gmail.com>,
	Maxim Schwalm <maxim.schwalm@gmail.com>
Cc: dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/3 RESEND] drm: bridge: add support for Triple 10-BIT
Date: Sun, 24 Aug 2025 12:27:25 +0300
Message-ID: <20250824092728.105643-1-clamor95@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Triple 10-BIT LVDS Transmitter is used in Microsoft Surface RT and
MStar TSUMU88ADT3-LF-1 HDMI bridge is used in ASUS Transformer AiO
P1801-T.

---
Changes on switching from v2 to v3:
- place mstar,tsumu88adt3-lf-1 alphabetically
- fix typos

Changes on switching from v1 to v2:
- sort compatible alphabetically in schema
---

David Heidelberg (1):
  dt-bindigs: display: extend the LVDS codec with Triple 10-BIT LVDS
    Transmitter

Maxim Schwalm (1):
  drm/bridge: simple-bridge: Add support for MStar TSUMU88ADT3-LF-1

Svyatoslav Ryhel (1):
  dt-bindigs: display: extend the simple bridge with MStar
    TSUMU88ADT3-LF-1

 .../devicetree/bindings/display/bridge/lvds-codec.yaml       | 1 +
 .../devicetree/bindings/display/bridge/simple-bridge.yaml    | 1 +
 drivers/gpu/drm/bridge/simple-bridge.c                       | 5 +++++
 3 files changed, 7 insertions(+)

-- 
2.43.0


