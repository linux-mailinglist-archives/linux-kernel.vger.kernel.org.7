Return-Path: <linux-kernel+bounces-790662-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C949CB3AB81
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 22:18:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 979AE161697
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 20:18:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28EE3285C96;
	Thu, 28 Aug 2025 20:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d46Kf2I5"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C5F1258EF5;
	Thu, 28 Aug 2025 20:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756412296; cv=none; b=j0NFHmcqC/UWEpZiRBRckB0lHZFBcHMrOZdVSmnDKeJ0wgjbutQd7pNMV0WZLPzeIbdgCNTUo/ImrUhFoFSIB5nGTTUN7poRGr5dXnOtpcjTM9yk6d8zyWHLNRoYXh9VfbL8dnbFvo+GEcsioo1kzxd2ELXDDgIRWsX88bWBqSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756412296; c=relaxed/simple;
	bh=jhA37hhVr8wj0WJeJG31Rvu5eKA3U8C0zXObbdTnrBY=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=D6c5vokXwnF2wVsvLLSGrETDYI+p/h7YsG/EWGnIe7pRgMsnFTcUrmLJ979GYm6vXIct0u/vJPpVGcga/VqkWyDBqYM9dY8JQQz43wQo1tQc81qydnkRWCdWrYQihqc6lcSaqjtuE9qlH2Dow+cqCAjZnBi+ka7yNQMSNAngXq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d46Kf2I5; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-7720f23123dso1389650b3a.2;
        Thu, 28 Aug 2025 13:18:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756412293; x=1757017093; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=CCMfyYe+rRC89koI5NU7x//VsxIZJbbgljIhPc8iuh4=;
        b=d46Kf2I5FhF3YZ5hWNXsod1tlYnwt26LNdjzy6RccZI84lXvllfbitMpG5gvisr6pI
         cpWFedPeFNczm2w1mzXefXpi5rWL614VZUPLzdWDdOdzS4BpxuISXZW/Jm+sYXFdDKOt
         tLz8ZzS4srqjjPmPUH6O7SAMvE/1aHO4gnbdILupGcZ54zLvSsb/W7EgDScBMSM4Wi/b
         /SXYi0PtxM0wjVo86HvGBEcm8buIHu3RwVytdarGxKk4eK4J3PiTQMGXwQJT+HBIfxhE
         CZ3wTbcYwjWYT1AyY/YPExUy4th+B+imqAJyluavvMvWbfoN4/flRUKFSakQlaLq9kbp
         wrIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756412293; x=1757017093;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CCMfyYe+rRC89koI5NU7x//VsxIZJbbgljIhPc8iuh4=;
        b=PfgBWoX7U01OgHLcvvtEkJU/oFXeKf2F1u1riYSI3Da3T41V0uzXu9Lyw4Q23EzFFd
         O7wZ0+YxA28GLGjDNUjp5NhV0D0KKUB0CBkdUVJaFx5Pts4DiDVncVu1PIlnK6NDT56B
         QLbmDssswk0lkKbjAk5e167MUsBCwOhXa5Z2JmWA3txU7q1CaPIK18inswkg6E0fDg5E
         lIeeqd2hH7K1hrbm4w8Oi/qT1Fz7lkDRAWc1bCYSC+wclNbA2CQ6hGWgiYFnJmSk2cy6
         rFCf6YYoERIrPR0ilCwD8AkSsIWfitLGB5PuIPFLD+0AThN+h4zKHn/U0bV0c15m4Mcx
         M1+Q==
X-Forwarded-Encrypted: i=1; AJvYcCVijjS7WVdPpAhuotwtRF9Hur/8Ixui+wO4FS4XfvM3FhOuT+6xZYusrc1gGlrAVwHzwLEquIUpqTa+Zw0v@vger.kernel.org, AJvYcCXu0iRO3HxYkR9itZ/lzjs4Qoqojtq5qzyC5R4LWKCIisd8WOga8RknnkVXTS8Ty6NjRTm55ENHYlcY@vger.kernel.org
X-Gm-Message-State: AOJu0YwW9pldRakQfZWEQCDNh0lephZo+fO1TWiC7m5PCCnfyif4qx/f
	bQeOGKl7t26W4fAhQ7PI3FwUNLDqn0JXvhhn0ILSSuScV5iDrrlcb6BX
X-Gm-Gg: ASbGncsnsBM0SYgik8y/3M1tuh80mVklTmBdpwtm5VR6EksCm9vWjo+Bmx3t81z3flK
	4Gmbj7Id3K7fuOTWaFWWQ5QRND6l3nipXXeSYv+bwmhHRIIlzW54zSyrhy56574BU9CC+UO2Ejo
	guyZD+ILpc16+nVp2UCm/u6Q2rWEudVMJWEmBzYTJdrAYlAdmOxwEXM/okG74vNmjeG3FYr5vow
	Agqle1T0zi49aRBe6w8qwILTc/BqSBR8IhjpUn57Wy325aSRoTqSjV6PBaJrnLKp1dxOFNLOxb/
	YS1Pe7q4MTFSfAX9NRo7Z2NxmvbnjZ3+fjPK4cNKSL9q7b2utLcEHOX6f2nx+TIOTMDM75ULTCd
	iIWj/YC7H5q3O9sUQM+5ogfd2oSdoYVX7ZuXgs4ncdkkTDlskvdiFnCTxfTKtlKpe
X-Google-Smtp-Source: AGHT+IFh9t117fD0EHzHKAg9oD3dUeYrOE3aiYwPGzUsuZ2JoARj2Ixr7cTSErqIhXlJe1VvZL+iRA==
X-Received: by 2002:a17:903:17c3:b0:23f:f96d:7579 with SMTP id d9443c01a7336-2462ef446c2mr304033375ad.37.1756412293434;
        Thu, 28 Aug 2025 13:18:13 -0700 (PDT)
Received: from localhost (185.3.125.34.bc.googleusercontent.com. [34.125.3.185])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-24903705bd6sm3884375ad.30.2025.08.28.13.18.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Aug 2025 13:18:12 -0700 (PDT)
From: Chia-I Wu <olvaffe@gmail.com>
To: Boris Brezillon <boris.brezillon@collabora.com>,
	Steven Price <steven.price@arm.com>,
	Liviu Dudau <liviu.dudau@arm.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] drm/panthor: add custom ASN hash support
Date: Thu, 28 Aug 2025 13:18:04 -0700
Message-ID: <20250828201806.3541261-1-olvaffe@gmail.com>
X-Mailer: git-send-email 2.51.0.318.gd7df087d1a-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some socs such as mt8196 require custom ASN hash.

Chia-I Wu (2):
  dt-bindings: gpu: mali-valhall-csf: add asn-hash
  drm/panthor: add asn-hash support

 .../bindings/gpu/arm,mali-valhall-csf.yaml    |  8 ++++++
 drivers/gpu/drm/panthor/panthor_device.c      | 28 +++++++++++++++++++
 drivers/gpu/drm/panthor/panthor_device.h      |  6 ++++
 drivers/gpu/drm/panthor/panthor_gpu.c         | 17 +++++++++++
 drivers/gpu/drm/panthor/panthor_regs.h        |  4 +++
 5 files changed, 63 insertions(+)

-- 
2.51.0.318.gd7df087d1a-goog


