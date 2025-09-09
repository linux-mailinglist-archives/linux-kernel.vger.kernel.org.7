Return-Path: <linux-kernel+bounces-807471-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 87582B4A4BF
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 10:13:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 13E8B1B2553C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 08:13:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0E7E2472A8;
	Tue,  9 Sep 2025 08:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="Q2AnvXi+"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC0C62472B0
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 08:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757405597; cv=none; b=DlJMB7sWRTx2AvcpXIp20q9MoLufx66W+UkkSumdyldNtKt3/W58zhhrwJhrdyoSk/zF1nuge7qZNSomFtqN8h8kEUYljCI6SDx38T2FEMH820ISPYucqElf6YYu46gpJYvXx7OXO7aTtDlS94rH7EVPS4Xe8VXSkJE1EyJ9F7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757405597; c=relaxed/simple;
	bh=zqf1+LbTORxR6nLmizBjAcnmRRmXXgKVnMQT++abQHc=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=phLTXf5jMUx27uA10Ib/pgDcxbEyWlnioQInJxL1mxuOSwshHoLDqSuJN6yL1OZAfkrmFjfgNL6d4y2/OD0AaDTyikmAfPwodOuljHIhHza6oSso3ludTCDj8xR2Y+IuB56jm2+iPeyTWI2Gf4h0eeSRgjNLV7mcjgUxmUItEZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=Q2AnvXi+; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-45b4d89217aso34145205e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 01:13:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1757405592; x=1758010392; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Uc+B8kk1sBtw2n6JodNl4cIKG73Gr6sjO1mB12nXlpM=;
        b=Q2AnvXi+A1wnALxLnkG1JfL0ZmbmaHUuJjyI37allATzAmxs73kP5VWSz97gmJN7aQ
         pGBZiba+srDrJRJQZZyc46ssJ693w1o8TPhignO6aYECyZl5uPNtHkjIHSm6DLxQV3XB
         yQbAwFUpgGai88cpxab33WRSnwcFxfEydJzDjKvnzCaDLOtC1EO/6rABonwjBdX0R8Xa
         +U6ibUIgDbsrye4zTF05q3FkxK54E1Qv5woGJvdVzqMr83jQKdENj5arLxN57iEX0UPF
         /2cdafLyLFwI9lC4RAio2QFoU8QPeBK+eqEVNaIspJsjDG4rcsNlNzw/MeEBI5d75dZ5
         J0CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757405592; x=1758010392;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Uc+B8kk1sBtw2n6JodNl4cIKG73Gr6sjO1mB12nXlpM=;
        b=tZWoIdHCdxWtuS1DRJ2KwRPP9T8vVzHOMrg65c2JXrW3Mr4BbCKk8eewCJcKCH8UJ1
         uFmtCY2SlfGZ3QV/Sbnn5utqcfvj4RwyPUk4wyc1jcNkXZ4M4L5yb2/wxscNf1QCrBGu
         MQODQY2UPw/wh+51uWpkez4z0bg4nK/uWDLTdf3ZSSrxDXHQNHED98+QIfcN1kJL3lNY
         bFsZLzXieBmGtv2HT+dc+RAQl0iTR4KtrVpRm7Qn52610s+s3i5HWjg5qdeT7gx7TU7+
         DkM06VGDrSJIUV0SK8lcz/S2CcYMjzSISdWwLPQTNVCP3aIiavcwb6AEQoTaSYvJiwX9
         1NgQ==
X-Forwarded-Encrypted: i=1; AJvYcCXPhLrfjHiFvoQ7eNbA/P6affFdozszTpA+VhL9sTt8Psk1HDi96a1yFFowjBj+C7Cqo0/U3GNA4fgMCmQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjptwPbwtQnujWaSsfuTLpw+2aIohMIp9dYsnMmGgaZZqex5gP
	YPqAuv5pWynKrbwJtfA/8STXGZm4wuGYI9b23spZnz0KOE26WRE9737fRrnk5xoEktk=
X-Gm-Gg: ASbGncupYQqjIcPvmcKZcNgKdo2xp+XXG4ktkVpLw7LPHNL23W0tmLTaY3+H4AJD+S+
	aGxw+pBGBtr2ZNZI31kHLdcQwmjtEo3Ly7NnF03MQRDZ34trrQ6swOwnka82OSQ4yuHrcXT906/
	GflfF2a9/bgFzFXeaBdTD5gdP2lY3n/LbsqZLw12K6ixR7CWyJteQmE04G6heYVfO9sVUVcEHa/
	sdibQxvmygvcXVEBEQ4PN+ERGy8ApNx6C1PvDhP0Rp9GB9MGy36gNbOMEgPsbsQaoGJwfY0vxZl
	0LiXrcBoFbLUaOL4XDZiVVIlRQbKgv7PbJBI8yLxlPD1qQH24QzAvfMTzbsqgMnn1UI71k0qJlw
	gutxlAsjMke+85JRBETcu/N29JQUHuO3Go+bd0kX1hjjGWKUAgRY+cpad1UUtc/CHu9h9MKk5CE
	zYs6KXABq5SOLvXIenPIWlMBw=
X-Google-Smtp-Source: AGHT+IFQY53b9Lt9FJgcVQgAWziqwA6SQuP5nQ0HtXCEHhXITcGNSSmEk4gXwM/tj/M7Ors/YxANkQ==
X-Received: by 2002:a05:6000:2f81:b0:3dc:2136:7523 with SMTP id ffacd0b85a97d-3e629f21c5dmr8819285f8f.0.1757405592148;
        Tue, 09 Sep 2025 01:13:12 -0700 (PDT)
Received: from raven.intern.cm-ag (p200300dc6f1b3000023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f1b:3000:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45de18f4824sm124970235e9.10.2025.09.09.01.13.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 01:13:11 -0700 (PDT)
From: Max Kellermann <max.kellermann@ionos.com>
To: Richard Henderson <richard.henderson@linaro.org>,
	Matt Turner <mattst88@gmail.com>,
	Max Kellermann <max.kellermann@ionos.com>,
	linux-alpha@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] alpha: add missing SPDX headers
Date: Tue,  9 Sep 2025 10:13:02 +0200
Message-ID: <20250909081308.836850-1-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
 arch/alpha/kernel/audit.c     | 1 +
 arch/alpha/kernel/bugs.c      | 1 +
 arch/alpha/kernel/smc37c669.c | 1 +
 3 files changed, 3 insertions(+)

diff --git a/arch/alpha/kernel/audit.c b/arch/alpha/kernel/audit.c
index 3ab04709784a..ec61f20ca61f 100644
--- a/arch/alpha/kernel/audit.c
+++ b/arch/alpha/kernel/audit.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 #include <linux/init.h>
 #include <linux/types.h>
 #include <linux/audit.h>
diff --git a/arch/alpha/kernel/bugs.c b/arch/alpha/kernel/bugs.c
index e8c51089325f..9f61923a9910 100644
--- a/arch/alpha/kernel/bugs.c
+++ b/arch/alpha/kernel/bugs.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 
 #include <asm/hwrpb.h>
 #include <linux/device.h>
diff --git a/arch/alpha/kernel/smc37c669.c b/arch/alpha/kernel/smc37c669.c
index a5a6ed97a6ce..b9a03563b277 100644
--- a/arch/alpha/kernel/smc37c669.c
+++ b/arch/alpha/kernel/smc37c669.c
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * SMC 37C669 initialization code
  */
-- 
2.47.3


