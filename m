Return-Path: <linux-kernel+bounces-882056-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CD5AC29842
	for <lists+linux-kernel@lfdr.de>; Sun, 02 Nov 2025 23:17:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 15A114E1AA9
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Nov 2025 22:17:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AD2021FF35;
	Sun,  2 Nov 2025 22:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aCT6I/Jd"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D041AA92E
	for <linux-kernel@vger.kernel.org>; Sun,  2 Nov 2025 22:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762121815; cv=none; b=OZYQnvPcOQSI12B9szYRrA+oKzgzU4F2ZTh9US7Bks231S4DJ81aXTeP4x7aNM38Pxpw8weJlDsVEm4gCVoEG77JzIQ9tj8MfjmcrhCx2byfuoAv3IZxmN18h+sIddcX2hzDZKmfAjt1mdKcIeNuJ/Kt+WsORmOsPTLQiIR5PEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762121815; c=relaxed/simple;
	bh=wsAWTN0eLlBiEGL/wUQ4n2on9qNGbOthalUagaZS+vo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OTOFx+111FoyBT+SjcmpkaJWFM+gbpGePgcA7odkD6FkMHrph5lFJK4lAc1WHe1hBMOwMryj81miMxH2aoy4Lr6dDa9fxO4zDdx5PXoqikTArrDfefAYXkmVZ/u30HB4rugq0O5UkEN2b3w9iulVuEjG3tFHy2mIoUmJLvsa2ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aCT6I/Jd; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2953e415b27so18098005ad.2
        for <linux-kernel@vger.kernel.org>; Sun, 02 Nov 2025 14:16:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762121812; x=1762726612; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DzTHM0N5jn83Spik5G9PnfqO4YiXJ2V5D0HuVfUYWgA=;
        b=aCT6I/JdqXsFRbnj7T6LoBtwG/d1v740suzF3xklap2abkZ/XyIxj/qho1HwA8E7Il
         d17elz4VXC+LiQxv73koSfIRt6yn8fXMU2cc9e/Ph5SIxF2oeXon6JpUGkoiU4AUOIU8
         J1gGGnu7Tj3mszai7UUfcASTa6zBQySyz2t+YC7YHIgIxWffijKscRWPBDZXbWV7WVuF
         FuWedk5bSyucfuljK6U0PlnFsdkLH8Fy6rjKQ7yVfd7bsHwY99FgKKjjuDTL+ARetDx/
         zQm8I+1MQ+iYV4mQSc5GARaBuGB3JG3hE6fL/zMU3NoyIPdfVF1rm3JwaHQLxSlnnb7r
         ZOwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762121812; x=1762726612;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DzTHM0N5jn83Spik5G9PnfqO4YiXJ2V5D0HuVfUYWgA=;
        b=hbiLbgemzClLtg9KgROolwFFDqWmt+NJHkUX4fS1025NQnYeWChoI+jiemHvKfsm7o
         F7IWHGMoQ5HoSFHPUV2CSnCjdtvF+ZP7ONfjK+Q1ts0zlBx9O570Ey51Pv8Hdeq8FJ29
         omLl/uO+s5HPstTBgTv6YS3BzlWIxdCNX3EY9JAcL7EoaOXj7cQJieKYNbtWpE1O2CVx
         uC3cOs3hKZKBDGclW6E4hb1FAr82kmierI8NhcvOZHmzkQmPtqPLsU15Q/P/r+6BNoMR
         L9TZ6uVDSjVzyqAJo78ylVjBphHOWmB5eXdshGWMAiT1+sNhEWs2d8Vp44nzYSWTb4m9
         AA5A==
X-Forwarded-Encrypted: i=1; AJvYcCWQ3+yADt7Ooff2nIai6G2axf5QkLThOx7xsLdTgkXFntkD7N1kyg+p6a6HTglY8f1iHcwuV1TKPX0ybIM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXAQXhJQ2sU0kbRymwI733u7JqUmNKtgfZ8EJex5IF+5KG3SrH
	/wYCOw3LIfYl99LSbQJfbPlMkuUrEQf3zKBYSGxSjs0YknHniqT+Uhzm
X-Gm-Gg: ASbGncu1emGbKXnan6wuygO54wof8M0KujSPYlSa1fbiuwgOCO8+coEvRnKYdf8YGAS
	0A21AcyTE6tqrAQoLe+sfRVQmN6IlLanZjPqdOtE3Kz+UIHJ4W21/kzHTm2hdSCemIHDUOk3tSs
	ZVxixxBFmRYrbrZU9LleLsn02Tq+BT6iUpUbrxSNQPweDDkRdk1W1mSQ6v8sAlMKDyoErfsIz69
	D1GvIigPqJ6WC5dx/HpnmwTg9QWynnJF7PlO2vtJe7v0WVhGkrS53rEZMwieuR9uubmEbdamXFQ
	ZS2wog/xV/4KiKjbbPPgepKPOSdh72402OdTxaIw0NGRAo5FUU7R9Goi2i9ruldSOLClccqyB5H
	yl/+c3Y0B2hyXR0jgWTq3LSEcF+Us9surJrVS1p5HYl4YjCAyzQOCVEEg0nuahqeNX7fr8Himeq
	O/HSpLSDM80eHovkFVk3vl8Pk=
X-Google-Smtp-Source: AGHT+IHVVJYWd8UPKfc0DgSAdtRg6W9eUK9Ue+pS4SyVc2z0ghJlZAxip8Z3wthzYtVrp4JqIN7pxA==
X-Received: by 2002:a17:903:1ce:b0:294:f30f:ea4b with SMTP id d9443c01a7336-2951a3620a9mr122622075ad.8.1762121812140;
        Sun, 02 Nov 2025 14:16:52 -0800 (PST)
Received: from localhost.localdomain ([2804:14d:4c64:860f:2214:33ff:7c70:4d9b])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-295357a1851sm83362835ad.27.2025.11.02.14.16.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Nov 2025 14:16:51 -0800 (PST)
From: Rodrigo Gobbi <rodrigo.gobbi.7@gmail.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	conor+dt@kernel.org,
	mranostay@gmail.com,
	wbg@kernel.org
Cc: ~lkcamp/patches@lists.sr.ht,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH v3 0/2] iio: proximity: update Lidar-lite v2 and create v3
Date: Sun,  2 Nov 2025 19:10:25 -0300
Message-ID: <20251102221643.9966-1-rodrigo.gobbi.7@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series moves the Lidar v2 binding from trivial to a dedicated place.
It also adds the v3, which was not described yet, in the same place since
it's the same hardware and it is already supported by the driver.
---
Hi, all,
Very few changes in this v3. At the v2 link, there was a discussion about
the PWM output pin and the current support of that. It was suggested to
not add that pin here, at least for now.
Tks and regards.

Changelog:
v3: split things in a patchset
    replace power-gpios to powerdown-gpios
    user proper lidar node name
v2: https://lore.kernel.org/all/20250801224112.135918-1-rodrigo.gobbi.7@gmail.com/
v1: https://lore.kernel.org/all/20250701223341.36835-1-rodrigo.gobbi.7@gmail.com/#t
---
Rodrigo Gobbi (2):
  dt-bindings: iio: proximity: Remove Lidar-lite-v2 from trivial
  dt-bindings: iio: proximity: Add Lidar-lite-v2 and v3

 .../proximity/pulsedlight,lidar-lite-v2.yaml  | 54 +++++++++++++++++++
 .../devicetree/bindings/trivial-devices.yaml  |  2 -
 2 files changed, 54 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/proximity/pulsedlight,lidar-lite-v2.yaml

-- 
2.48.1


