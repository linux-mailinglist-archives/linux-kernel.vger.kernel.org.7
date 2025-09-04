Return-Path: <linux-kernel+bounces-799779-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B4B0B43029
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 05:00:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 848531C207AC
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 03:00:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0ED520010C;
	Thu,  4 Sep 2025 03:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y8KlkoSL"
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEA6F1EE019;
	Thu,  4 Sep 2025 03:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756954817; cv=none; b=KsjFmq4vz+1ewzv2HhVXtYV2l8yJmML+9cl33jWYRs0PRNBtMX3LNy3bA1/zYuseyPNzS564E8PHtjftvT0ePd0uJN4keeR+dnpNgX4HMxMwn5FbjpQg7IsdRe679v+E1uo1qlK+DdzVmd74peQcJ4UlYq8eviO6WgAo7iqzw4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756954817; c=relaxed/simple;
	bh=DR9R3XunPL5phVZguwOyECoq4O8IMCWYj0R0VN53bBY=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=pRSAT0wQVIslUateXJdYzXGvTdhIO/awOuZQlHqBbRirNWMT8vJxv1MM8sVMGZuoVz5ZrXHMFQ296LcO26uN/Ke1nx4PSlH8nia2/fAtRUBf5/i+dBCojkU1HTOyRlFqwBp1PLLOo0gHdrvl/tmvIUlHksAhfSli2zCBzZN6hag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y8KlkoSL; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-74382048b8cso413450a34.3;
        Wed, 03 Sep 2025 20:00:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756954815; x=1757559615; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=vFU219JiYxB+UL7dKKMifccL2sg9lhUG+NSi9MilUC4=;
        b=Y8KlkoSLTHy/9arFe5h9l74HAHSPp1ceuETkt1mJU4rw4Wjgu1CgRD0dgA0F7eulsE
         xZtANVgkwYL7J3aBENu7HhxAAXReNlSpn6+F80Kx5Zs6CuPYGmUXtpuTeTg5uwffBtvA
         Xg1vKopL+TikQPDnzzrN6Kt2H+FmidZ/rrJglA+O9g6TZHtbYRFHmwqHS4ovbPJGn/UE
         Mh0Kzne9wIvUMg26t5DjUGGNv/N0qcUtYTANSoU172WwDXcJI15bwEGwca2CUOZJ0qz7
         y5F/65Mt6iwszoHxqd2lIa/AT2D+bgqaw2jLVXMAaZ+zEglXEcYagtgN1OehfFV7d/rq
         xgJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756954815; x=1757559615;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vFU219JiYxB+UL7dKKMifccL2sg9lhUG+NSi9MilUC4=;
        b=dOLfm7jNUEb60P9xa0aFfoCLWIEhUahQhWkN59QwiTnwXs9zdQCWFLggDKVz3UMOGJ
         SQWGLkipnYsAwPIT4xwUP4ruIrsrDwW7zx0Nk6Y0sLsAQvrRxOdnCcq9MWVOnmVW6lt1
         B4eOI668E+cTvjBzT7gK7wzXxuLRqndj2L8fa37/dSrTWZWSgKio1R22JBowudRoaP69
         goYTs+zrzHWHfor0giHvEhszZn97QeQqQPZ0CV5OBBnC2gcDGa0Y/50J0fp2Z3r3oAsg
         uXOmRGk3ekLSnmmqiveDupduWmby/C3ZusIxEYbemT3HsuKfRynBn3OvnrkzOf0LijBS
         XM/w==
X-Forwarded-Encrypted: i=1; AJvYcCU5mTWi5GHgvaLQfPCFAtIeJ1HJ7mTPjFMJOPU06i+HX/xDQnm51PT4l9FbC3i8jk/6G2/qxLJ3B4AhobEk@vger.kernel.org, AJvYcCVza/2yc2fcGKImFRh/hGbx2ddvFsRer8l5f6EuRiaUxCvHybRnl9da1vMUmpkpBvXHCWrWY+agLYZ9@vger.kernel.org
X-Gm-Message-State: AOJu0Ywi5jWtcGFjJCHijZgVjMI+hu0RLG451KTP5b6zyLQ4Qfhn7u+d
	0Lb8uNkcwsLRI9G/2XUPkiXB6ixU6bb6751wk/WdYAZLH21xIuZpoaUn
X-Gm-Gg: ASbGncvX+U44bKKToEpQl9uynYl1xUZMU3HF89WKsNKZF0FFsYYSDoeXImi4dsOZM2q
	FuixxNKrH5/mv2t+egfCihyRL+PWJTRj4EY8EXxStEnQsIIIh75wBHtcspkrUuMbScaFkFwOvcP
	tlQnMp4kfAOVB9XX6/oKTrOwZa1BcCVkfc9dHhpttPCsCEVjCSoSuRISpqLvoWOocCuqwZsH8h1
	CEA0cqy1WE3OS/R2ivQU1fEuVLTQ6DP6F3bglOvGanvz2Jd+cWxkTQfbuv/Cw/9L7DA262FCLfH
	Ksx6ZHf3CIwjrXdxnvhV0NWIlCLhMXZxHBepeX8LbgTP8Bc9J1YS1dEYwTbDQsBAQwWL8atFMzM
	fFcWww94bLKVp02I3R2fkImRXQUp1qWnAQ3s6cn2TyqU=
X-Google-Smtp-Source: AGHT+IFKeulPMsBsQALjUqa6sF2+AWk4bJt+0haQDiVNq0B22+NXV63rjkaWnjX7VtXX2WZpPqcF0w==
X-Received: by 2002:a05:6808:1b20:b0:438:3911:48a3 with SMTP id 5614622812f47-4383911506bmr1569553b6e.48.1756954814645;
        Wed, 03 Sep 2025 20:00:14 -0700 (PDT)
Received: from localhost.localdomain ([122.8.183.87])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4380007b0b6sm2262726b6e.25.2025.09.03.20.00.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 20:00:13 -0700 (PDT)
From: Chen Wang <unicornxw@gmail.com>
To: u.kleine-koenig@baylibre.com,
	aou@eecs.berkeley.edu,
	unicorn_wang@outlook.com,
	conor+dt@kernel.org,
	inochiama@gmail.com,
	krzk+dt@kernel.org,
	looong.bin@gmail.com,
	palmer@dabbelt.com,
	paul.walmsley@sifive.com,
	robh@kernel.org,
	tglx@linutronix.de,
	sycamoremoon376@gmail.com,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	sophgo@lists.linux.dev
Subject: [PATCH v3 0/3] irqchip/sg2042-msi: Set irq type according to DT configuration
Date: Thu,  4 Sep 2025 11:00:06 +0800
Message-Id: <cover.1756953919.git.unicorn_wang@outlook.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chen Wang <unicorn_wang@outlook.com>

Read the device tree configuration and then use it to set the
interrupt type.

This patchset is based on irq/drivers branch of tip.

---

Changes in v3:
  Thers is no major change in this version. Just adjust the order of the patches
  to change the DTs first. Thanks to Thomas for the suggestion.

Changes in v2:
  The patch series is based on irq/drivers branch of tip. You can simply review
  or test the patches at the link [2].

  Reverted the change to obtain params of "msi-ranges"; it's better not to
  assume the value of "#interrupt-cells" is 2, even though it's known to be
  the case. Thanks to Inochi for the comments.

Changes in v1:
  The patch series is based on irq/drivers branch of tip. You can simply review
  or test the patches at the link [1].

Link: https://lore.kernel.org/linux-riscv/cover.1756103516.git.unicorn_wang@outlook.com/ [1]
Link: https://lore.kernel.org/linux-riscv/cover.1756169460.git.unicorn_wang@outlook.com/ [2]
---

Chen Wang (3):
  riscv: sophgo: dts: sg2042: change msi irq type to
    IRQ_TYPE_EDGE_RISING
  riscv: sophgo: dts: sg2044: change msi irq type to
    IRQ_TYPE_EDGE_RISING
  irqchip/sg2042-msi: Set irq type according to DT configuration

 arch/riscv/boot/dts/sophgo/sg2042.dtsi | 2 +-
 arch/riscv/boot/dts/sophgo/sg2044.dtsi | 2 +-
 drivers/irqchip/irq-sg2042-msi.c       | 7 +++++--
 3 files changed, 7 insertions(+), 4 deletions(-)


base-commit: d36bf356068cdb5499b9bc458db9149c0fd938a2
-- 
2.34.1


