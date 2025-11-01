Return-Path: <linux-kernel+bounces-881115-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E0B6C277DF
	for <lists+linux-kernel@lfdr.de>; Sat, 01 Nov 2025 06:00:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E542A4E26ED
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Nov 2025 05:00:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E922F2940D;
	Sat,  1 Nov 2025 05:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K3C62Da0"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E16BF28E0F
	for <linux-kernel@vger.kernel.org>; Sat,  1 Nov 2025 05:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761973246; cv=none; b=NNN5NhnaRftw1S2si8C2Bsab+OhuenCSEVfhBdQsfv8iBm4uNg2zhbXcYYeyFbTMXUXCy0ZCaFnth6CYtE0HVQbCZwyz2j+zPA5kByi2RdUkyeFYkkkn9U5ta8Uataut0NdmKvmjePT6c6b0263X8aUXE2lG5gNkxHGjd/Gw1vA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761973246; c=relaxed/simple;
	bh=Oh44UZjHsMc/rfrWX2YnpJEvv9Vn65qg079kLT1V5X4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iGInxl7xGrZ7FmXCXXFJ4ovAqU+WvwhgdJgFl/SnfegtTsd9BXx0zpFL3q+80xYD+sT3GlYc8ao3w+TLfhiFvcca1sFfT3t+43nAB+CTvweDbsepFAiRqDfY0O//wMCo3NvA/RnlHr9v0m6TSd+3lwQ9dqIXuGHvTS19rhKWNpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K3C62Da0; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-781206cce18so3328174b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 22:00:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761973244; x=1762578044; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wIwIO+j2mO8maDFel6M1v9YStfB+c9Y+ZJYZAlcF5l4=;
        b=K3C62Da0MiW2n+FCH7++i2JfNn9L0KD7y8swc8xt+7eNOTCsy1PHF73Cl0F0jjEijL
         2GyQjTeYRkONJKkCIdPkbKnEIM0cm67/EIb4ZJBs6FfQPQdJjddVZv10I0K+pE9MOeq4
         MmijoZG4OCbeOkutGtJKd5Lbr1rC6XFrmcc1xemrSIvQsvuZReQJSw6mCNyr5upeylJe
         GkkCGLo44eNjdybxR2cGzo5TyHHn9wRE5Dh+Ty5i5KfhJIFE2Si306VRoFBhrpXCnZsZ
         YXg3SzvcwqsUZEGTVbVxxRh3zS7cLaFFh9IMMPAPLmZytdnnq14D93cOv+o6/v36tgYW
         EAMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761973244; x=1762578044;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wIwIO+j2mO8maDFel6M1v9YStfB+c9Y+ZJYZAlcF5l4=;
        b=NlBV9mVcu19Sg63JdSmkJnc6Ee+Reqko6NdoL7WHLrrCg6kTWiIWPQwodJO0Es8X4C
         YOo8gWvpf+5BfHRmcgngS9s4Udr9Ga8zGP5wNr3J19UbC2yNvxbkidq1l85JlCODWngP
         /SZk6AJjtw+tdMcaJV7+nL69Z2KgbW+l7EubKhXEjekSbK9S0oOS3rSVwbwCT1o577di
         tF/BfAJ9unOMAV3XwI/Dep9jFg6cOZAm+4od+MxYosaOcY/J4m0w+IrM7IBzGQ4sj7zU
         POuKuy/UmgAaSE/eBCRzCExXgr3Ruju5/LFAkOdLVvf7cSRXkd6rpuptlQ+zxYywPhbS
         rs+w==
X-Forwarded-Encrypted: i=1; AJvYcCXJCk8kzaOQzoxqX7OboPyW8eGsUhC2umQQ1i+2vN2ZXoV/rzJqeeteobjsxTeMspgxwuaklmPIUUoxmC4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyu5f9xNHTM/pzhJnWZEazW7vXNcuDp6sHPc9mdlTbTwdOtrCkL
	j+EahsO2Im3hjn02q1fI4RCQ3g3+C5iBrYtxKTKbLQEil4KNPNfPNgZX
X-Gm-Gg: ASbGnct7sjox18JgnqukcFMdflEZ5adPjitE5b8c5VxEz2Pkxu8rmYR9QyU5kAAyhdj
	k1k7qrnJKHkC3c0uZpIdSPnY1IABe6T8T16ZxDwMM7jC9TtQLb7fPGfCXYlJKYNuCaV/j+3CXQd
	WAnn4J84LwViNAAzzAp69UfA7m7hT0OvjJ1YHkZeP+D8G2Br9SY03KfXbIvlY4rwhiWyZfkFgGe
	2NHAYVDyJDS6LJp7X89X2kLgCNnNxzmnujRNX6oJ2GKownUth1ZHzlcuoDOZp4ViWmJ/sBD0ZN9
	UFZZBntiJ9ZPshT4BvgDBmUB/s02yl4Si2yE/vQLFMQn/R0e9j4CuONwbzX79vppQuy2/it0jlX
	auR3VvEqLl5+FouJ3wMtR/PrQ3lNNX6LYjenCEcXJ3JMkPsmK3cCraZx3sxooXRe2MczEg1UckZ
	nLh7CY7oqsD07/gG2JyV1/Y9vfg0j6mbE=
X-Google-Smtp-Source: AGHT+IEMhJ6NXDRyaN0YqS139CnyyfuTRt27C2a8e3X3e0TG0+kZ4vhiRrmxHXesFyCgHskXvBB3jw==
X-Received: by 2002:a05:6a20:c916:b0:341:8609:3bad with SMTP id adf61e73a8af0-3477a5c1395mr13547881637.5.1761973244223;
        Fri, 31 Oct 2025 22:00:44 -0700 (PDT)
Received: from iku.. ([2401:4900:1c06:600d:690:cbc4:d4d9:22c2])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b93b8aa3ff1sm3761095a12.14.2025.10.31.22.00.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 22:00:43 -0700 (PDT)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Magnus Damm <magnus.damm@gmail.com>,
	linux-renesas-soc@vger.kernel.org
Cc: linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	Prabhakar <prabhakar.csengg@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 0/4] Add USB3.0 clocks and resets for R9A09G057 and R9A09G056
Date: Sat,  1 Nov 2025 05:00:30 +0000
Message-ID: <20251101050034.738807-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Hi All,

This patch series adds USB3.0 clock and reset entries for Renesas R9A09G057
and R9A09G056 SoCs. The changes include updates to the clock driver source
files and the corresponding device tree bindings header files.

Cheers,
Prabhakar

Lad Prabhakar (4):
  dt-bindings: clock: renesas,r9a09g057-cpg: Add USB3.0 core clocks
  dt-bindings: clock: renesas,r9a09g056-cpg: Add USB3.0 core clocks
  clk: renesas: r9a09g057: Add USB3.0 clocks/resets
  clk: renesas: r9a09g056: Add USB3.0 clocks/resets

 drivers/clk/renesas/r9a09g056-cpg.c              |  9 ++++++++-
 drivers/clk/renesas/r9a09g057-cpg.c              | 16 +++++++++++++++-
 .../dt-bindings/clock/renesas,r9a09g056-cpg.h    |  2 ++
 .../dt-bindings/clock/renesas,r9a09g057-cpg.h    |  4 ++++
 4 files changed, 29 insertions(+), 2 deletions(-)

-- 
2.43.0


