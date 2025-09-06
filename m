Return-Path: <linux-kernel+bounces-804313-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F3FFDB471D3
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 17:18:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D09B51C24726
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 15:19:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D661B21CC7B;
	Sat,  6 Sep 2025 15:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sigxcpu.org header.i=@sigxcpu.org header.b="CF5xJ0q/";
	dkim=pass (2048-bit key) header.d=sigxcpu.org header.i=@sigxcpu.org header.b="QD0yosu0"
Received: from honk.sigxcpu.org (honk.sigxcpu.org [24.134.29.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25EE61DA4E;
	Sat,  6 Sep 2025 15:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=24.134.29.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757171913; cv=none; b=ZlOWg0qFDJ6tAs5ejjTZ1eK43VtkMQ2LlQ/FN5MCPs5geR3n9dUXdWnEPgD1PTWH0+qdRa6z5aDRpSidqIhstx4kgE6alNiDpepSxS12aKDW9jRne8tZqOtfm/lmOKBtd4lIWVd3loo9J4LlRUHNRP/K7j+7/VbUbcB6arBJ8GU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757171913; c=relaxed/simple;
	bh=2NShP4uBgORUvxG5QGzRXtYvh7uD9S9t3XI9Ql28qFY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=P0LbC4t4uZiqAmpJePPIM51XcEVYlsLuiF7dB9bRpF8K/6moZBM+pyyZbwxDEl05stasZ6fGkmKs7xGF3v+6iGK6jDf8yFEIPSCTh0tIZ1PFY9GASGMUbCefwRjTWFm36qLQMJaHusUot4HjmHip7ebvDpup0Qey1J32LSrvlkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sigxcpu.org; spf=pass smtp.mailfrom=sigxcpu.org; dkim=pass (2048-bit key) header.d=sigxcpu.org header.i=@sigxcpu.org header.b=CF5xJ0q/; dkim=pass (2048-bit key) header.d=sigxcpu.org header.i=@sigxcpu.org header.b=QD0yosu0; arc=none smtp.client-ip=24.134.29.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sigxcpu.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sigxcpu.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=sigxcpu.org; s=2024;
	t=1757171900; bh=2NShP4uBgORUvxG5QGzRXtYvh7uD9S9t3XI9Ql28qFY=;
	h=From:Subject:Date:To:Cc:From;
	b=CF5xJ0q/+izVUqCxlLTHcTqCZ7AeHvbqVsjsn/vl83PxS0BzIW0Cqr+Nr+Y1pTtpu
	 /StldoKefd6K5u5TBRBQm9MYxYgrnKQiYydhRjq90ivMq8T03vt3UoBhiqXuUhclNU
	 /QPJNZlFkv6RRMOytkJXHoF1DUuBUo/kDt6F+WeFCJYsPezEWeDWo3KCrZcYlwC1Qu
	 gSoezUSPtggkOZfmC1BWmit8xrqrS6A/P/YQjo8x3z6AlvGcO4dzXO8N/SJMuwc4sp
	 flMyMT6e0c4IOv3C/woJYxCxfpsFaA7a7YA7YMYPDIXiDvfvQFFf2zWfBV564elF/S
	 FQCrjsQkz7MFw==
Received: from localhost (localhost [127.0.0.1])
	by honk.sigxcpu.org (Postfix) with ESMTP id 51829FB06;
	Sat,  6 Sep 2025 17:18:20 +0200 (CEST)
Received: from honk.sigxcpu.org ([127.0.0.1])
	by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gPxJSbNr_dvx; Sat,  6 Sep 2025 17:18:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=sigxcpu.org; s=2024;
	t=1757171898; bh=2NShP4uBgORUvxG5QGzRXtYvh7uD9S9t3XI9Ql28qFY=;
	h=From:Subject:Date:To:Cc:From;
	b=QD0yosu00PNYZvsHsE/30TcpMQSULUlY/oHTAE+BZqipSUW104KA6eZphc96kQgqs
	 NiRoexNqYz2RFt9oP1up0HwHw71KDySt5Rc2rGBhX/flB8L6W0nmlRhjhJOEHJ1lUe
	 f1QIH/3KU2Rvoa74sRsDjQ5eksqhTRuMB/1bL4AhX+8W9NAV4nluyqr93RlMEYsZNz
	 NkbVgzT8iIBPNmw0JZlVDVBO/fXQCR7zFKs9UEIdO1VFmjHX4txX1AlxxGIxd7hT9X
	 P19u1RsOWMOlYp+7ppYkXtocghr/zojnIjJ62XZfcbVdW5ShAL7QIE1QOiPAgwvUbD
	 UNneVEosH4Kqw==
From: =?utf-8?q?Guido_G=C3=BCnther?= <agx@sigxcpu.org>
Subject: [PATCH v2 0/3] drm/panel: visionox-rm69299: Add backlight support
 and small fixes
Date: Sat, 06 Sep 2025 17:17:24 +0200
Message-Id: <20250906-shift6mq-panel-v2-0-aa5e585d8717@sigxcpu.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAIRQvGgC/3XMQQ7CIBCF4as0sxZDkap05T1MF9AOdBIFhNrUN
 L272L3L/yXvWyFjIszQVisknClT8CXEoYJ+1N4ho6E0CC4arnjN8kh2Oj9fLGqPD6YaZU78esF
 +EFBOMaGlZQfvXemR8hTSZ/fn+rf+peaacSalNFIbYzXqWya39PF9DMlBt23bF11O45WuAAAA
X-Change-ID: 20250901-shift6mq-panel-959b3087ecd2
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <jessica.zhang@oss.qualcomm.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 phone-devel@vger.kernel.org, 
 =?utf-8?q?Guido_G=C3=BCnther?= <agx@sigxcpu.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1067; i=agx@sigxcpu.org;
 h=from:subject:message-id; bh=2NShP4uBgORUvxG5QGzRXtYvh7uD9S9t3XI9Ql28qFY=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0VCYlFLUy9aQU5Bd0FJQVNXL2hsSksvT
 UhqQWNzbVlnQm92RkNqWk9TOFAvb3Vzd2RwS01jV0ZhMkxjVGwzCjRiMXltS2Q1QXpuYi9vZGpo
 ODZKQWpNRUFBRUlBQjBXSVFSajlzemZsaUtkQ1NocktzTWx2NFpTU3Z6QjR3VUMKYUx4UW93QUt
 DUkFsdjRaU1N2ekI0N3llRC85UmZMZnhIeGpCOG4yL1BFSXovQ1JDelZNc1dLa1UySmpZTmMrOQ
 pkMnhIakQ1bXJmYlVZM2tja3NRZ1dZL29GdTdCQjl4MmZqNFNacy9FLzBKT0JzdlBqM2tySlhVR
 UtWYjg0d0lCCjlKZ2tmMUYzNjdNSndqaWViWmt5UUU0b0xTdXZnVnFGTWtpbS9GNzJFdHloUU5s
 SllYSStrV1NvYU5vVzV3WWcKcHBCRy95OHZmOEEvVjdiRGYzK0oyT1AzT3JaMVFGTXpPK1RHQVE
 1UlBpV0QyQ3Ryb1REK2E3ejBUUTFWTVIwdQppdEV2M3VmM0VDbkhIQzU1d3ZOMnpRZ214R3lrL2
 JxUUhXV2dZMkdkY1FwWlFnVEM5Tmd1akRHamFNVVZLZGw0CjlIVlN0b2hGMG1HbmZ3cHlScmxwN
 GZxN2JOMjQ1V0cyWUk4NFlsT04rbkl0RlpqbVBpZlF2UGUzOHdSSmhLQkgKNUI1RkJQYVZhSXNy
 ck15N1I5VTB4dEhhZWhkRE9YMllsVWZ5clc1T1ZrdlgvTk96UERhUVhoakNBc29mQ3RaZgpDajh
 ZRkkza3F6WXVnek8yandTTTR5OXpNMzZCT3ZsN3RxV1VBR3puNEZ6UHp2QnBHUFF4S0gzT1ovSl
 VPT1dTClJObnhrWEIyQlhMUVkzcWZVTEpCRjRNTll6a0g2OHFTMS9hQTA0d0pzMGhhU2dDS0ptN
 Hl2dFFGR3B3Umo1elkKNW90ci90TFFOOVJad3VjS3Bmbi95WlBVbjRzV2QvZVN0MndVQXhGUjVG
 VXFOR21UVUJRSWwydHNDekpnTWJRRApRZm9WQ1hhdWN5NUtqcWJoNXRUbmFDUGVSd3RrWGFRTlN
 oTzZ6VGFMOURGVWVkK0Urd1VMMDE0dk5QU3ltWDgyCkg2QzE5Zz09Cj1GaWsyCi0tLS0tRU5EIF
 BHUCBNRVNTQUdFLS0tLS0K
X-Developer-Key: i=agx@sigxcpu.org; a=openpgp;
 fpr=0DB3932762F78E592F6522AFBB5A2C77584122D3

This adds optional backlight support via DSI commands. If
a max_brightness is set in the panel description the backlight
is created.

While at that we fold in the already sent out clock fix and
a fix that prevents us from clearing all mode flags when we
only want HS mode.

Signed-off-by: Guido Günther <agx@sigxcpu.org>
---
Changes in v2:
- Add Fixes: to the first two commits to make backports simpler
- Collect Reviewed-by:, thanks Neil!
- Link to v1: https://lore.kernel.org/r/20250901-shift6mq-panel-v1-0-444b4abbfaea@sigxcpu.org

---
Guido Günther (3):
      drm/panel: visionox-rm69299: Fix clock frequency for SHIFT6mq
      drm/panel: visionox-rm69299: Don't clear all mode flags
      drm/panel: visionox-rm69299: Add backlight support

 drivers/gpu/drm/panel/panel-visionox-rm69299.c | 71 +++++++++++++++++++++++++-
 1 file changed, 69 insertions(+), 2 deletions(-)
---
base-commit: b320789d6883cc00ac78ce83bccbfe7ed58afcf0
change-id: 20250901-shift6mq-panel-959b3087ecd2

Best regards,
-- 
Guido Günther <agx@sigxcpu.org>


