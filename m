Return-Path: <linux-kernel+bounces-767148-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B93F4B24FDE
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 18:35:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E2A0A1894A32
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 16:30:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F16D6288CB1;
	Wed, 13 Aug 2025 16:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="CQO1HDkB"
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1523628850C
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 16:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755102565; cv=none; b=iI/7J941Vs9atMj7YlEZ3b1uVis7nfMOtQpZUB4jp0VYimeS6jOSle5rdQm/hpbALmGWIr6lbu3VWc2sEMNKwI5KNRA+jNIw2H7DWX5TvUpeJ0aV/YC/rXKqpKjt1QLytKuUeo5HbhqEUQ+UBH+63w0KJHODhg/o0bLE7nonJ8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755102565; c=relaxed/simple;
	bh=bYaQ7xlrKxCuwQtNn2omZ7BjgvDcPYjR2TMWck0VGQM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Fk6QukbjkaIXTZJ+RmH+5mfoT3x6A2Dk0KYPoPMil8l3gVplI46WnkcPPjJDFFFIzyrUvrH0PjU6O2JlEja3zAobLhnaHl/S8Rj42che3vubBj8B9MCRyiSfyEqqN20iObDQ2ptN7ajTTYthUI6T6ekKW2adf0rggAHqDRLA7u8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=CQO1HDkB; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-b4233978326so3915403a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 09:29:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1755102563; x=1755707363; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LhDh0bK+gQwaFqeot2nkbIRJyYLX52+XKHM1mxR51Ak=;
        b=CQO1HDkBKZSsuTtj99voFysofUPnuHmD2TgOKkdW++4ySpL8r940YD2/Ryqi9HhTrU
         rqP6svTg2EWjK4gOnYtb6STrxP60RO+GMsRmuZzLFrPrQHvePSfShOSyEtvhFwfRqclW
         0Kq1oOjzgu4DI5b63cyHmHOd5Vg6gZSDwIWaI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755102563; x=1755707363;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LhDh0bK+gQwaFqeot2nkbIRJyYLX52+XKHM1mxR51Ak=;
        b=Br+mVrCCdRWNDdxrgPBKHHK+jVfN3WqL+k4f0nMIwUOVezHPaFVhcTzptK7HRyEuBZ
         AqlHwP18cnWFibi6R1wndWqAccZDkWEdGXAtV40j4O32wXM12kFrL/qx+6g5LBWZ7oYu
         E4d1YlNFqW3dWYdIJHdNrJNOKPii7pBkadisGDDDIyStjwk1Dk34BXYTFV9eKzILOTbb
         thA4EEHxae7FZYo884voz7R0EBF1V9K7irOr9fyvYIdWte8GPyv1zH4gZfgHuZJVedCx
         7UHLRd5WWM2haxiLTg6c6BL5H4s2iOvkBQ8ex6Zl6GpPR/2/hK5uXV0I4DCWSAOTzl3P
         KEEw==
X-Forwarded-Encrypted: i=1; AJvYcCXb6mapRigH+/mKyLIFu84o0oXCLscl5HtXiRt0eis4iZoto469zYxBOT3LAqkaKMKkDZjIZ0ic1q+9FPE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMxN3bFyV7QZkfgdlDg2/oj5tBFilu46uJRR2vkeLz/O+bfzes
	vm726TVci6C3Y3ib2tCGxt3VdMUeKvvbrPKm071j6XJ/BLL/QcbS3izAmy9u38rz8Q==
X-Gm-Gg: ASbGncsfuS50Nis677c5UziNLuEN10oYrd51Po0+h6oWkuH0Yjl8l4UnAxGzvc97ja9
	xmsFweq5WAZ2+LQKrhdrot3dV5M5pwawnDaTUv5PS+bPyDe3HR7H2yX6s1Q8+a8l39avP6Ig04W
	9xmm1iG1e6tlUCL0+mJ6JhEtQoAXmlJvgqkMmpOG1WF3Ltb+8j0AwFvROqW/nbAMmqF0TBvBJOY
	RAtQlK2ZZqpuNoUMxivr8q10x+ve5YspLGZeZs9xJnDbG5f4WBZ9Ty9bfu4H1UqvVNKSkabykod
	Y4yynn83YmOLB4MekHvRRpUk+omcBAatGv/hphvvbQ6NVGBRIOWEmxa2biecn9i2iixzKXBa0+5
	ysqcKjgldDtuZP/rKj0THEcEKKEuwQ3VsBmpw6IsZPL66tj3cP9DncWxsO83kJ+vWguQqHIz5gN
	5hq2B2hrw+WnVTxrNEoJBR/DXG1A==
X-Google-Smtp-Source: AGHT+IHaS6kzgD2z3CPm/bEpl6Q8l6D7g2epnpf64XF+XoK4p8+KLJvuUjbFUmkBdlSH0iEurBAjzQ==
X-Received: by 2002:a17:903:2f85:b0:240:4d5b:29b4 with SMTP id d9443c01a7336-2430cf2af9fmr57123965ad.0.1755102563267;
        Wed, 13 Aug 2025 09:29:23 -0700 (PDT)
Received: from hyd-csg-thor2-h1-server2.dhcp.broadcom.net ([192.19.203.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241d1f0f7bfsm329311915ad.41.2025.08.13.09.29.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 09:29:22 -0700 (PDT)
From: Bhargava Marreddy <bhargava.marreddy@broadcom.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com,
	vsrama-krishna.nemani@broadcom.com,
	Bhargava Marreddy <bhargava.marreddy@broadcom.com>
Subject: [net-next 0/9] Add more functionality to BNGE
Date: Wed, 13 Aug 2025 21:55:54 +0000
Message-ID: <20250813215603.76526-1-bhargava.marreddy@broadcom.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

This patch series adds the infrastructure to make the netdevice
functional. It allocates data structures for core resources,
followed by their initialisation and registration with the firmware.
The core resources include the RX, TX, AGG, CMPL, and NQ rings,
as well as the VNIC. RX/TX functionality will be introduced in the
next patch series to keep this one at a reviewable size.

Thanks,

Bhargava Marreddy (9):
  bng_en: Add initial support for RX and TX rings
  bng_en: Add initial support for CP and NQ rings
  bng_en: Introduce VNIC
  bng_en: Initialise core resources
  bng_en: Allocate packet buffers
  bng_en: Allocate stat contexts
  bng_en: Register rings with the firmware
  bng_en: Register default VNIC
  bng_en: Configure default VNIC

 drivers/net/ethernet/broadcom/Kconfig         |    1 +
 drivers/net/ethernet/broadcom/bnge/bnge.h     |    7 +
 .../net/ethernet/broadcom/bnge/bnge_core.c    |   16 +
 .../ethernet/broadcom/bnge/bnge_hwrm_lib.c    |  483 ++++
 .../ethernet/broadcom/bnge/bnge_hwrm_lib.h    |   23 +
 .../net/ethernet/broadcom/bnge/bnge_netdev.c  | 2175 +++++++++++++++++
 .../net/ethernet/broadcom/bnge/bnge_netdev.h  |  290 ++-
 .../net/ethernet/broadcom/bnge/bnge_resc.c    |    4 +-
 .../net/ethernet/broadcom/bnge/bnge_resc.h    |    1 +
 .../net/ethernet/broadcom/bnge/bnge_rmem.c    |   58 +
 .../net/ethernet/broadcom/bnge/bnge_rmem.h    |   22 +
 11 files changed, 3076 insertions(+), 4 deletions(-)

-- 
2.47.3


