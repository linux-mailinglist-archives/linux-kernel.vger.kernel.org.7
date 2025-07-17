Return-Path: <linux-kernel+bounces-735389-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EE4EB08EA0
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 15:58:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4B53A458CF
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 13:57:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C0372F5C5F;
	Thu, 17 Jul 2025 13:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X6BfOmcf"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C3F13597A;
	Thu, 17 Jul 2025 13:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752760691; cv=none; b=e/92Nvz8iH42h8oaRxcns9UMcIf47NXcrmfOM3+n8hTcuuFYmh6AGYt1sGAe4HMWTl99YHRGhZY9RmL7o3dWNKrm6QGzHWncx7Q9Mi0ZBYxeW+S+x0RKu55aNUk/xX2frsTiG6MMh9wYCBgj7ZbK+hqRo/gCaYWYMIHVWTzgsJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752760691; c=relaxed/simple;
	bh=THvl4igOhvgHWggbmvH3vWN2kTk9+2Oyun1mAfsnT2U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rYcT2XOOhqVwiD7saal6hA1nTNYZ7SOhwC+sTSW/xMwYTLE6w63WTehEUrkQi3bjMJ6sk34au1SiozZHeoL91fKTyAsr9QLBbLxPvYuO0FLIxlz7SDiR6SDjFISNrjwyS31bY5OQkOEk4/n5HVTwSZVx4lAsT0ez1zXswu0avWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X6BfOmcf; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-33097e1133fso9171941fa.1;
        Thu, 17 Jul 2025 06:58:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752760688; x=1753365488; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mvLdJgfrCrg7KBtAJf/OmkIYvQvfWE8ejXVPhNns87s=;
        b=X6BfOmcf6vWDRdEG9lA3ozs8Xii9nhliOMH/Ax5oLV+L1qOwivFI8MrxDgYzUGBzVd
         UtmFazKq8VPEclKpIwn1ETfv4fQstTN59tkMttpRSqdaxJiDUyjGKJZWWtRAsCnhAV7L
         UdoE9SCgd8O/FvJST/OTEPlHL+T/o93FN8uty1kBP6FPeMHuzBCQV3/ClseDf6LF20/Q
         qR0Yvsa7joNgyPzyuIxPLNo4QkEKbgbFodHgsPjPVHUd8YgIRA4AIjWr9vMldyYsM0jc
         Ch5aO6jT/Xmd9V70I0mUdzsyL3H/w8WgR8HRJjYM8bI2eMHTnLPoJaQ8Hq9zzigMI8nF
         1WQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752760688; x=1753365488;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mvLdJgfrCrg7KBtAJf/OmkIYvQvfWE8ejXVPhNns87s=;
        b=Ce2dDhflZvm4bFBzd9/KEvw+xy9j04ITzXKLLJIoY51bBKWtW9pTth4KylePkhZJPn
         WbAz+3lZgrMrKT62BZKVVz+r2ctOPxBsuiGJeo07QVgoT+cImajIQf+5lTLc/K8CLggr
         A4u33wEfRBbxCI+75Y4O1gcBFUgi4Kq2L0ZtFGS0fwHdCBpgEjLFz0JM2GeFBsKh/5/P
         OnJPa3+3I32RXkdbtlntypL7HmjhmJCoe6uPO2Qvh2J0MEtJwT434XSDZSqwacBPi7//
         drJxhNXLMGXA57w5mQUbGh6cXvjlLW48SYU6uOenbABft5c59pptD2TQYLtMkZ9BC8aS
         0cug==
X-Forwarded-Encrypted: i=1; AJvYcCUD8BcjuWdFp6jAe7ldWYy75FDpoJQ52zNocb0cKwr4WV3YyfshfcD/WoHHOwCs4RiqH20rFh37B03msMhH@vger.kernel.org, AJvYcCUNRSjA9NrAOw70cOCJnkuJmmTEiMjtLkkhiLEUv5QtbcrABtIE/KCVI7pn0Vr7rhuJl0oYYt51wtiI@vger.kernel.org
X-Gm-Message-State: AOJu0YxGFZDC4xZZ5VL953iRr7vpE2vFOixbE/kUkJVmZoTl0nf7ibEw
	eVZUHj9OEa9jd5ORqZdi/E9wgx9hy1pQYZJ1i5hkTstiu/SGJ5QLQ3Hp
X-Gm-Gg: ASbGnctJh5/tMNvgzbsJeE0AjLLjI+avUuF4zQoy597aRp1ZpY0dD7uLeavc/qEwp46
	SWKQfzcA+TveyLk9MV254lLrXFHGtA+vxxElMH0gd1xABx1sdCwc0MXZrGdXAl8v23GZ59irFoa
	5PUHpt37JwgmKiql0/D1C+gtTnIiT9L/ja0/vDWv+qlyx1fjep8ZP1fn8yPXv9HzzKccjnaKczx
	QxzRNNSrqkVu7WHi4kpGujv1hHg8Ida6sPo1b/WVgTnpaXZ0y4SjdolI57aUQzEuL9IgTPxHgG8
	cyVtaK2Gy+F9P3C4LzW5popebLZwyP7Y8WfhljTIj60vCvInjHkEFt+zJNzkU29F3GKP9p1WtQV
	Bg+9igfmnt1C1ZpamNK34uPpX
X-Google-Smtp-Source: AGHT+IGr09ky+5MckjMOGZ/G5pyFoGLBtwoGCcGyLgcGzkwgBSzXm4YHJTtl7KQTmKkHZ+P7Vc14Qg==
X-Received: by 2002:a05:651c:e12:b0:32b:755e:6cd4 with SMTP id 38308e7fff4ca-3308e590ac5mr13654101fa.38.1752760687569;
        Thu, 17 Jul 2025 06:58:07 -0700 (PDT)
Received: from xeon.. ([188.163.112.60])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-32fa29134fcsm23794421fa.15.2025.07.17.06.58.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jul 2025 06:58:07 -0700 (PDT)
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
Subject: [PATCH v1 0/2] drm: panel: add support for panel used in ASUS VivoTab RT TF600T
Date: Thu, 17 Jul 2025 16:57:50 +0300
Message-ID: <20250717135752.55958-1-clamor95@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for Hydis HV101HD1 MIPI DSI panel used in ASUS VivoTab RT TF600T.

Svyatoslav Ryhel (2):
  dt-bindings: display: panel: Document Hydis HV101HD1 DSI panel
  drm: panel: Add support for Hydis HV101HD1 MIPI DSI panel

 .../display/panel/hydis,hv101hd1.yaml         |  60 ++++++
 drivers/gpu/drm/panel/Kconfig                 |  13 ++
 drivers/gpu/drm/panel/Makefile                |   1 +
 drivers/gpu/drm/panel/panel-hydis-hv101hd1.c  | 188 ++++++++++++++++++
 4 files changed, 262 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/hydis,hv101hd1.yaml
 create mode 100644 drivers/gpu/drm/panel/panel-hydis-hv101hd1.c

-- 
2.48.1


