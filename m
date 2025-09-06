Return-Path: <linux-kernel+bounces-804007-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 85831B4689C
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 05:21:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 421033BF004
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 03:21:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36B571F4CB3;
	Sat,  6 Sep 2025 03:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AzyJ74b2"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EFA41DF254
	for <linux-kernel@vger.kernel.org>; Sat,  6 Sep 2025 03:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757128898; cv=none; b=SSikbmeybo28clbmhs6oFwaZhIxaZwX3eZsrr/px3xfiwkenBmWrwQ/ca1MIsNHrgBQVsT/LhMPSQwSp9fOcPVAwZ3T1g3MoGTtdZIfN0/jURS4nxyABGzJMhWjiytE1iWv9ZNShWPlhxE+zXRRzK9R3iX+9xVCwEmvD8Z2BsHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757128898; c=relaxed/simple;
	bh=o+FaEWcsuObUNv07NnL2n6St+0yeCtdSIOD17oMGGwY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QiNvU7FcpU9d1ajDvAW+fMX0onHGsNm1dZubqdD8QULJY3b1KstCbjvElrxLttBSpw4epAeLmf5BpE/Z5STy3HEwuN0W5CD6p7zTN7IHqDi3yNloBOS8JCRs+wUWDjLUJIeG53SC70oODIIPNobxorBJDN6WbFTTEEb7+pAB7DU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AzyJ74b2; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-25221fa3c9bso149025ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 20:21:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757128896; x=1757733696; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NyCEsVkz56P0H6XVc95lmqF2qsvWh4kZKhuPs1kvLI8=;
        b=AzyJ74b2k6HIvJhgyVSKWtADd6Nhxh3Dx4xib9fIL5iRwZH9ETpV/dACesbwRa2ZZR
         +TYaUwry0nBuELokl2LG9CjvxFMgJZoqTGsXzXZveLEHfudrRmfU1c8Q3Hs3gjjjAYHt
         ZX+8+XPo1+K+tOZ9xZX32/OJHNklNdTrzYvU1k32EzgWn8ibGlL9IzxNojWRR0bASlPW
         udbAuBpbIeM58srf0czECi99vTLtGA0ecZb324O1YlBIU4EeB43GLjZlX4lcSOlDVCRq
         J18ph0Fkvpag8ZxqhK6c2lV0Q4SQNfg1Ecb2BUymzfsL6zQJprgsP9KlDivIY2ySP7ze
         JaaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757128896; x=1757733696;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NyCEsVkz56P0H6XVc95lmqF2qsvWh4kZKhuPs1kvLI8=;
        b=c7L3uzlRMDJZPwWrXMXjQkJc7AoEp6gkEY0Fs0W7I+/fBkIdPLlYJ6u/XB5XMyCeRw
         7CLRFT4goI6LenBRqwHWCCyTHPK8+ZAcY+JYvRgCyp4v7NUQIAzE43W6PuMXusZsmnhq
         6mtSV5pqsLGevjQBs+vL2J/r9cxveb4s0NqF4XBqmoyz58lJ0FH9lxzRzXayY10vqTTU
         ifamcFLYJs/Qcp38lmcjNeIX+rGrFy1U/DyanMSUVgxjesJmU/5AZ7p8nIzlzf8s6VdY
         X5Y1s5+shJOsmRFZPgrvJcIeGab71JUxATtoyq17jK5USCTanYaoTN2BRatHxCtFZncM
         fISw==
X-Gm-Message-State: AOJu0YyK1+NA9YxR51dJLG6jTSXBIqe48EZq89EjgzWtHFULkyYMRnC6
	JEjLf8kaLKCTC0Pk+IycIQW2ejXufVxruYeTHNu+7WtxmRqjLMNirJl4iTvv0A==
X-Gm-Gg: ASbGncu4HqTPJE2cMIYsdcKvoKOCwzC88wriHSAICgbdynSJlOWF38BJX5uTt72NCa6
	dLccCQnCQRUB2ZBP1wWDBg+tdAHChMiYT0zocD5aUUm9RbzQVOiR7b8YkY1RRp7kxDt02az96Kp
	uYpRcX9q91hP0Tipc4D/TpJK2dbaG1noFbvQ16fIKNmZN4MDWR1LfdTlemr4PYReOAuFMT8b0GA
	cnVpqA2ZNH6tZfB5nDhL4Fogj4B5cZ9AlYXTfeIDJeoBoSQt3K63vTBBAqCwV+b9Dg30LmZvrCU
	re2ATbI/O4A71uTBdI+s6RXuV2U3EbuNLgad0F5i+Mica4nOOGDER9iNjgj4CAva1J0ciMyOrcU
	Px+oi+3FTWRp1XI3DFwUpmo/el6Yk6JV2prtpMfrrS8H3Q0MPrg/pLKhy+CYgZSRev9kc
X-Google-Smtp-Source: AGHT+IECrJbfsqt0RHTSBsnY+DI416cfexn5FtuhIQsuPwmhACNVK6DTa8+ncsCXvWht6PeLc8ivwQ==
X-Received: by 2002:a17:902:d2c2:b0:234:986c:66cf with SMTP id d9443c01a7336-251788fd0fbmr10908765ad.16.1757128896363;
        Fri, 05 Sep 2025 20:21:36 -0700 (PDT)
Received: from localhost.localdomain (36-231-187-52.dynamic-ip.hinet.net. [36.231.187.52])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24905da2896sm228127265ad.81.2025.09.05.20.21.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 20:21:35 -0700 (PDT)
From: Nick Huang <sef1548@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Nick Huang <sef1548@gmail.com>
Subject: [PATCH v2 0/3] dt-bindings: mfd: Fix typos in PMIC/BBNSM documentation
Date: Sat,  6 Sep 2025 11:21:20 +0800
Message-ID: <20250906032123.21534-1-sef1548@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series contains minor typo fixes in the Device Tree bindings
documentation for MFD nodes, including PMIC and BBNSM descriptions. These
corrections improve readability and ensure consistent documentation for
developers using these bindings.

This series builds upon and complements the previous v1 patch:
https://lore.kernel.org/all/20250902142749.13724-1-kusogame68@gmail.com/

The patches include:

1. dt-bindings: mfd: nxp,bbnsm: Fix typo in documentation
   - Corrected "Intergrates" -> "integrates" in documentation for RTC & ON/OFF control.

2. dt-bindings: mfd: rohm,bd96802-pmic: Fix typo in comment
   - Corrected "contolling" -> "controlling" in comment about SoC shutdown and PMIC control.

3. dt-bindings: mfd: rohm,bd71847-pmic: Fix typo in documentation
   - Corrected "abd" -> "and" to improve readability and avoid confusion.

All patches have been signed-off appropriately. One patch is co-developed,
and the others are authored and signed-off by Nick Huang.

These changes are purely documentation fixes and have no functional impact.


Nick Huang (3):
  dt-bindings: mfd: rohm,bd71847-pmic: Fix typo in documentation
  dt-bindings: mfd: rohm,bd96802-pmic: Fix typo in documentation
  dt-bindings: mfd: nxp,bbnsm: Fix typo in documentation

 Documentation/devicetree/bindings/mfd/nxp,bbnsm.yaml         | 2 +-
 Documentation/devicetree/bindings/mfd/rohm,bd71847-pmic.yaml | 2 +-
 Documentation/devicetree/bindings/mfd/rohm,bd96802-pmic.yaml | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

-- 
2.48.1


