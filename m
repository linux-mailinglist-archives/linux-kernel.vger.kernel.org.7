Return-Path: <linux-kernel+bounces-824875-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA0DAB8A599
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 17:39:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5CF557E3327
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 15:39:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7E2331B820;
	Fri, 19 Sep 2025 15:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RcPwZbUA"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D3DB3176E5
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 15:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758296352; cv=none; b=IId9/jIu7CX+ahr9JR9sNGGT9MkfEq03P1Gh4wLxL3kuHMRhtI3gp35WaHJ8mpH2SA77YaTLzJs4GDh76xrAdrMTXgzUo9uvIg3oBfu+/cYnMV2uQQ4rEZtrLmknNRjFsXb3AA+fm/WHuyNvLKnHY9IGyV+TCzGBMiqxFJuInTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758296352; c=relaxed/simple;
	bh=K0k+4kNcMJsdNdrqorQ4S7Pg5Q5SSIopCK9d++okImQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jgiuMb6XLUlSVUuJFq0YYlamj82clSpqO4VSb5xOF9PHWcr1qCZrcyPMF60cPx+XOHfG3d1oSjm2icb5XWNYUduwDvMRbW3IeUtzUTKLUp1Y875LNlBMZaDYDWEyCie7KpIWVfHwQxxthjT8pR8PJ+M7bTVRZr1C3cXxnlHYYiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RcPwZbUA; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-560888dc903so2567948e87.2
        for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 08:39:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758296348; x=1758901148; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uctKhO+/UeiiSpqt6MjSlg1WxmH8h+yZMn/dalnwyT8=;
        b=RcPwZbUA1+8xlMSkpVoYoLeXBt44D10Ob/IWJdXthnBnDsTEFwNB9decoIl14+2+oL
         s+qwYmtTJYzjLjMKiaAr6GduPKVBmlf/Xh3Tosvdldgfb8KTXIkyjRwTYjhOGKSmPGuO
         kyZsJiOILUHgp2zHoRnXU0LVpyeGuQ2NTJ6kpndg+Fh5DSphO8CCs/ZjpfEA4YbL0oZU
         GlSODIVOKtjvVAmfyISK7NWB4aEkgCFJJqdOpWhY7syzdE51u1Fn9ssERcBbX3mF5mO4
         pwVMAmt9MpKDU/E/9Xo4g1c0QgnT4hN0m+sxWpzlPX+mCjW/3arPa3baiFCFwtaN6esK
         +tdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758296348; x=1758901148;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uctKhO+/UeiiSpqt6MjSlg1WxmH8h+yZMn/dalnwyT8=;
        b=DnBqf74q5TC6/e67z2u2Pr8rhFNxATDt+zotlmVDX8UiFjvA0Ck7sWQXQqdpFdaNOY
         vfzZ94BYY4v39Oxejffjhruyuo74yyVbDW88VRAaVZkwuJRIfSdLpaoOhUyYGMlmvf0p
         u3aw79XUSRWB1nGxlWsrVAVcv62Y6zGG3ZLiNlan08+ZGjJ/Deess9iKtE1HB/pCpcSD
         cnWx4CLHl63lyVjzXogiBbab8ChiyMhiJrvUUql9hRtzz01QhsSiVqooHNzaWUm3oILk
         Y0EDTW2lphk8VG9CysJAgly5Kn29VF4kzItR4MfAx9nqZJGbpLWTZpLpJkAWplZ9s4Rn
         gHhQ==
X-Forwarded-Encrypted: i=1; AJvYcCUO1xqw3YbFjfFOFhxEdiOY1PmWtG/AuzooYN00DXUnvvcXWk1K87z63fTPTJSw5ItyvIHKiM39XDA9sgA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyo8FDOC4QqYalTvOw64XKJq08OixzSBYjujr+CFd49oxFHqegq
	QfhqwWbBOp4MIoNSsrpjsOdAODrN5X52Nex8frWFNAF43A+1Un1X12K7
X-Gm-Gg: ASbGncsikokyzVbIJf8Rk77dFu4SxvZLget+oIiAO8IIaGgFeskUBBLoHWqXPUR2mbT
	Dy6m2JXe9RWk6s9tqJO31xGYfoWXdf0uWRqqpl8ICdPtRilEidKRU4jpKXDYv9f7HeZSDecDBVS
	F5KGdkO8Zn5NEMoH3h1OsA7h8pmLSykTwoHnznRH+RosjFyN/194+TgORXypD/cIttBeW/pR2KY
	vg9mhGOuw/lLZ5k4uuQhrGTIrnOpfEwpkBtvFGQ8COgMI3JC473njQb4jI2IVLmHq1vwpwyAk4g
	jnG5k9CgL9Z/jX43Ph3JC+38gvQUZT4uHbOaUFIC2JgMBpy+7ifImOFPvvP6JuH2XDU3LCzCsA0
	fZRFpD9kJWZAF/A==
X-Google-Smtp-Source: AGHT+IGJfZhXf/HH8Pyz+cqkoqEOZKpxJz2zqRcH4yC3gZ73i2LnNl7A6Sca09TBNTUOc4JHpYxYMA==
X-Received: by 2002:a05:6512:6508:b0:55f:6c5d:759d with SMTP id 2adb3069b0e04-579e45216bbmr1104441e87.49.1758296347969;
        Fri, 19 Sep 2025 08:39:07 -0700 (PDT)
Received: from xeon.. ([188.163.112.70])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-578a5f44771sm1485769e87.20.2025.09.19.08.39.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Sep 2025 08:39:07 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Neil Armstrong <neil.armstrong@linaro.org>,
	Jessica Zhang <quic_jesszhan@quicinc.com>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Svyatoslav Ryhel <clamor95@gmail.com>
Cc: dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/2] DRM: panel: add support for Sharp LQ079L1SX01 panel
Date: Fri, 19 Sep 2025 18:38:37 +0300
Message-ID: <20250919153839.236241-1-clamor95@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Sharp LQ079L1SX01 panel is a LCD panel working in dual video mode found in
Xiaomi Mi Pad (A0101).

---
Changes in v2:
- adjusted schema with ">" and dsi0 > dsi
- fixed copyright from Nvidia to Xiaomi since sconfiguration equence is
  based on the downstream Xiaomi code.
- adjusted commit name of second commit

Changes in v3:
- tested with drm-misc-next
- switched to mipi_dsi_dual* macros
---

Svyatoslav Ryhel (2):
  dt-bindings: display: panel: document Sharp LQ079L1SX01 panel
  gpu/drm: panel: Add Sharp LQ079L1SX01 panel support

 .../display/panel/sharp,lq079l1sx01.yaml      |  99 ++++++++
 drivers/gpu/drm/panel/Kconfig                 |  15 ++
 drivers/gpu/drm/panel/Makefile                |   1 +
 .../gpu/drm/panel/panel-sharp-lq079l1sx01.c   | 225 ++++++++++++++++++
 4 files changed, 340 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/sharp,lq079l1sx01.yaml
 create mode 100644 drivers/gpu/drm/panel/panel-sharp-lq079l1sx01.c

-- 
2.48.1


