Return-Path: <linux-kernel+bounces-885298-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E7D48C32883
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 19:10:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C728B4E3B76
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 18:10:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 446B433E341;
	Tue,  4 Nov 2025 18:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UOnJw7AB"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFD8933BBA0
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 18:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762279805; cv=none; b=X9wpujkd5RWXbsQD+lwozXbJekhOzSnK14l0FJolw57NJVX9U6wptp+6Tm5qZf63ns0wWIeOiPrEiga1Z2npt5ahuVyEZACh5mAR7fDB1VXYtB9eSByYpowQhPa4bc3v51dB/uelsrOm7Bb9TxkqjC6bwjpEIkAgaFU4wZBeJQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762279805; c=relaxed/simple;
	bh=4G5UrM8a7/K3tV3l71rgb1Dcgib61vdWac8QHH1DBdU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QvXlwJkj/zerKkTXzu1xFWiuVMGiKf0/1010rApWLy1C4GgkucC17bcfqAlRb3D6YYKxViCTTUx8ECcJgk8gGRfYEd1F2WuYXw/P0nt7/seXmIH/6nyD/TtEl7N/tWNnBq1nvLURlMv505oCFQDQ4Z9EhpZGXfRjUR5hIdU6mFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UOnJw7AB; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4775638d819so5230315e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 10:10:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762279802; x=1762884602; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HBEyfODAKvgwzHmkCm17lPDKK7nQ8zv0WCO9yDZDp4E=;
        b=UOnJw7ABeh8LTc6uIOzV6KkNzTvM8cRRLwKsj3xquXnEqZM84Er5uw5oEmyVh5DJlE
         HvKBTyLud1TRlz/F/zRX1ctZ1teF6yNUhXlN27Gy3SLnP1Xq5NX/edzJ0C8V8erKk85n
         Rgt7fspFKVWp4/z+fEY0VBZF+DV22UAtGcRMTJznTD1oFqGde0MCiQu4e+JJGh9rbVuv
         G0DXcygXMsLOZotjx8rqusaC3jIHFGm7XqVIS4dFStkTh0SCbZHP3sQiGFmfYlHhDDtp
         +lL3qZFV7KAPVz7ocCc7UzcAd+SxMW3eK570XCFlDKQAVicNhU3EybNsI62NzKbrncrw
         vf2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762279802; x=1762884602;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HBEyfODAKvgwzHmkCm17lPDKK7nQ8zv0WCO9yDZDp4E=;
        b=RFwpwgdZdSRuSJ0jaCagaHjhMJogVVzcGgmQA3AQnUXTwgWn2bbqe7drJoGqI00oI9
         IW/1UAhAP2b5Y/e6wqebWoE2L4ZNfms+GTLfMjLpZBGss/clhyp4vaHts5cZuTRq7vAC
         asi+/TqUGmlPUF+xNKbfy+8gWwyEG0XOvE0bBXmL6Fr4EhUSf/dF2M/ZzwXITnVFdT/x
         nb6nJb6v1A1YXoJn6YfKF03/zwvLirbi6B+mmYqWLCPhU5R4BtprH9H1JDvlTnwmQRC1
         RCe+xl0hSE1Q9OC0KR6qWoKRsrPqVBX4El+jkyXTx+GJXcsjS5VgG7mY1uPSq/0pBVTf
         F1SA==
X-Forwarded-Encrypted: i=1; AJvYcCX5rGSu2fJVTSPkbaoPsBD7mQmascLvDbzeHGXFX452P7wukt5l+G66Cq5QqGeazYxlPyJ/olO0C82IScc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOsA9bsGkMM+d9ydswbmdK8q7f4Kp3pI6+/jJNSlkjT9gSOQFd
	621PcE8El+S38thae25H2OwyknpGpRgrP6omE+yvJvR2L923teAaFpe6
X-Gm-Gg: ASbGncuy2O+WW4Z8KUWkMoTVNyvxaSb8Aqc4m65iDAvEDhB6dT+jbEmxryX6Vp6Er+s
	Q0kqN+QZKvgBFirWv61BVVaOM8eVDQ8lsoN2F0Q7u0XSdtQEtjyVej4ErpLY1sCmaesaZJe37YX
	KkvIic5A7D64lapZ6V4UOwYa0vNIGrBE20RAzx4PbkL9sP/kqlirGGvgUbu2ZM2PcgMs0sIVm1s
	Uy1cN7obHHfmMNgwtDYGvOwm220QnzfWwIceIaaE6eKzRaAG/Xxxn0awrfWTc9QzR0fVQv2ugx6
	iNaTEJTPfuJ6q4R7Q2xBNh+gz20zjEe9O63ijF0ksHZHNjyTd74qhbsUSdizEo7w7knWxj9fh+p
	GiSUrHtne+sqsU9LSAoa4hLkqUtevGoog+qOnfGMtfUc0+D/0u4WbOUwfmoNsKkXO+gm+pnTO/X
	TdDR3LAaWK8LASVMG9iA==
X-Google-Smtp-Source: AGHT+IE+3VWITYfmpHgFCOUqnzMrVHgHtPMl6DRBEJeRwc9yMJmO7cxC+Ce40qfK3g3txnNqIhsCKA==
X-Received: by 2002:a05:600c:6388:b0:458:a7fa:211d with SMTP id 5b1f17b1804b1-4775ce1874bmr2405065e9.29.1762279801598;
        Tue, 04 Nov 2025 10:10:01 -0800 (PST)
Received: from jernej-laptop ([178.79.73.218])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477558c1a03sm24688685e9.2.2025.11.04.10.10.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 10:10:01 -0800 (PST)
From: Jernej Skrabec <jernej.skrabec@gmail.com>
To: wens@csie.org
Cc: mripard@kernel.org,
	maarten.lankhorst@linux.intel.com,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch,
	samuel@sholland.org,
	dri-devel@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Jernej Skrabec <jernej.skrabec@gmail.com>
Subject: [PATCH v2 00/30] drm/sun4i: Refactor layer code for proper DE33 support
Date: Tue,  4 Nov 2025 19:09:12 +0100
Message-ID: <20251104180942.61538-1-jernej.skrabec@gmail.com>
X-Mailer: git-send-email 2.51.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Current DE33 support in sun4i-drm driver is based on my PoC code. It was
written with *a lot* of hacks, because it was never meant to be upstreamed.
Fortunately, DT parts were never merged which give us a chance to do it
right.

This is first of three series with proper DE33 support for H616 SoC. It's
the longest, since it prepares terrain for new drivers in remaining series.
Point of this work is to completely decouple mixer and layer code. Till
DE3, mixer and layers were intimately connected. However, from DE33
onwards, this is no longer the case. DE33 and upcoming DE35 planes are
shared comodity between all mixers and can be assigned in any way driver
(or user) prefers. This requires planes code to be completely independent
from mixer. The only exception is mixer clock frequency which is used in
VI scaler, but in that case mixer pointer is obtained through currently
assigned CRTC.

Second series will introduce separate driver for DE33 planes and adjust
mixer code to new DT bindings. Third series will introduce TCON(-TOP)
adjustments, HDMI PHY and finally, DT updates for several boards.

Current WIP code for remaining two series can be found at [1]. Code has
been tested on Tanix TX6, which has DE3, for any regressions and on Myir
MYD-YT507H board [2], which has DE33, with HDMI and LVDS panel outputs
running simultaneously and independently. This confirms that plane code
is properly decoupled.

Please review.

Best regards,
Jernej

[1] https://github.com/jernejsk/linux-1/commits/sun4i-drm-refactor/
[2] https://github.com/jernejsk/linux-1/commits/okt507c-v3

Changes from v1:
- collected tags
- updated commit messages
- added missing kerneldoc description
- moved vi_scaler_num position

Link: https://lore.kernel.org/linux-sunxi/64c0a4e1-15a5-4f41-9fba-852b0e83fd6f@app.fastmail.com/T/#t

Jernej Skrabec (30):
  drm/sun4i: mixer: Fix up DE33 channel macros
  drm/sun4i: mixer: Remove ccsc cfg for >= DE3
  drm/sun4i: de2: Initialize layer fields earlier
  drm/sun4i: ui_layer: Move check from update to check callback
  drm/sun4i: vi_layer: Move check from update to check callback
  drm/sun4i: layers: Make atomic commit functions void
  drm/sun4i: Move blender config from layers to mixer
  drm/sun4i: ui layer: Write attributes in one go
  drm/sun4i: vi layer: Write attributes in one go
  drm/sun4i: mixer: Move layer enabling to atomic_update
  drm/sun4i: de2/de3: Simplify CSC config interface
  drm/sun4i: csc: Simplify arguments with taking plane state
  drm/sun4i: de2/de3: Move plane type determination to mixer
  drm/sun4i: ui_layer: Change index meaning
  drm/sun4i: layer: move num of planes calc out of layer code
  drm/sun4i: ui_layer: use layer struct instead of multiple args
  drm/sun4i: vi_layer: use layer struct instead of multiple args
  drm/sun4i: ui_scaler: use layer instead of mixer for args
  drm/sun4i: vi_scaler: use layer instead of mixer for args
  drm/sun4i: layers: Make regmap for layers configurable
  drm/sun4i: csc: use layer arg instead of mixer
  drm/sun4i: layers: add physical index arg
  drm/sun4i: vi_scaler: Update DE33 base calculation
  drm/sun4i: mixer: Convert heuristics to quirk
  drm/sun4i: ui_scaler: drop sanity checks
  drm/sun4i: mixer: Add quirk for number of VI scalers
  drm/sun4i: mixer: split out layer config
  drm/sun4i: layer: replace mixer with layer struct
  drm/sun4i: vi_scaler: Find mixer from crtc
  drm/sun4i: Nuke mixer pointer from layer code

 drivers/gpu/drm/sun4i/sun8i_csc.c       | 113 ++++++-----
 drivers/gpu/drm/sun4i/sun8i_csc.h       |  16 +-
 drivers/gpu/drm/sun4i/sun8i_mixer.c     | 217 +++++++++++++--------
 drivers/gpu/drm/sun4i/sun8i_mixer.h     |  65 ++++---
 drivers/gpu/drm/sun4i/sun8i_ui_layer.c  | 183 +++++++-----------
 drivers/gpu/drm/sun4i/sun8i_ui_layer.h  |   7 +-
 drivers/gpu/drm/sun4i/sun8i_ui_scaler.c |  44 ++---
 drivers/gpu/drm/sun4i/sun8i_ui_scaler.h |   4 +-
 drivers/gpu/drm/sun4i/sun8i_vi_layer.c  | 244 +++++++++---------------
 drivers/gpu/drm/sun4i/sun8i_vi_layer.h  |   7 +-
 drivers/gpu/drm/sun4i/sun8i_vi_scaler.c |  51 ++---
 drivers/gpu/drm/sun4i/sun8i_vi_scaler.h |   6 +-
 12 files changed, 475 insertions(+), 482 deletions(-)

-- 
2.51.2


