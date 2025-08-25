Return-Path: <linux-kernel+bounces-784120-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B5A1B336F7
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 08:56:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 187BD3AE02B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 06:56:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C9E7287277;
	Mon, 25 Aug 2025 06:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RXtV6EuD"
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE10F28725F;
	Mon, 25 Aug 2025 06:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756104879; cv=none; b=MLeAr6WzGEAYwgzATq/wqsjGx7GCC1QslP6y1EUybjdFzVe8jT4plQRX3NvKfK9jEgq8SVr60AY572WaEL1QvRh+n6Wx+pWM83FYfGL37OkIVj4y03C6UL+CpINxAqZhpUx3lgENhSm4pE5Okk67zwTxSSXTzvDXLzZ93kew3ZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756104879; c=relaxed/simple;
	bh=p0/ul3UeEcUz4h8vcB8yVSLHox3GIlZPeDNzcrMxymY=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=M42rf7ihRXfr0vPsM2+eVSb6vGWBCCg2L+PYnM7aAqHmZEEhRP/PV2ilDOtlXCNV00WWe4Bc6y3px78P/8qXgb6wlJp/xJ5EvvwYA/nz5LFkCZPxMK1HTbOxASRnR0XbUrgaRSIdTPTYmdS8fq6xCq/Dn4wc0T2Z4hakozLp7rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RXtV6EuD; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-74526ca7a46so90642a34.2;
        Sun, 24 Aug 2025 23:54:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756104877; x=1756709677; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=bjCk9K/9vMZWlVyVVNpjDms4LHQz7N1FEpHm6N3zn4E=;
        b=RXtV6EuDWrcibC6L5UcVpJ5okrGDpux8zFuLKIjEobhUNqcrjqAhDmHe7SYTtc5egz
         8jYcbXdzcXP1DK+Q8nDJHqg8EYiOKMtooaTOZZTlarsHUn+pLm1mYx6P8uENsCFU3SV0
         8CzqDjIhNmBAS883PJTmJTAO3hEI+HxUlC/YPY/RhePyEzz50Hk9DZUaZiIH+/FFQcxQ
         Drj0EbrwVRWQhNr5WhVbG3JlHX4zRHc7jg7NMzoQly7CDS9hDcA4y2uRF8BDbPd+6zj7
         9aLDcKbfiUVySw9RHEHNifUqZvyfG7jhIJ0fg9q8hwQt/OTTDwW/Gs2jLlfLGe2KxkPm
         eYEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756104877; x=1756709677;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bjCk9K/9vMZWlVyVVNpjDms4LHQz7N1FEpHm6N3zn4E=;
        b=l3+LtDSNVMgiDfj8VsHgCq/Ku74x0jLpFwYdinQ7T9PMMpoNkIprRFgZ5T/LlJ2Gdr
         /laDekgacp/OfBod1VjEnuhFeMS3mKJRz1+ZIzKrr0hxQCMtU72vtMuvhyT/l0/Og1LF
         sLbFOMdZc6vjkr7u44f6n2I5fLrG0BhhU1YboAsrk0WsLAg2LwKa5f0MZR6glh4OLoH/
         1Yp21UXDL4XaYVEjOO22N2MgoZlTqpKAvro2ZkIi/36FPV9maSaWw9uko4SUYejxd7Lh
         EkleG5T2PQuMN/E7UctlIPjV1mZJEoAX3TuR4CnmvScZcj/DOWJh37zwg7Au9t2+VFHb
         e2BQ==
X-Forwarded-Encrypted: i=1; AJvYcCW/3knON2Dmf5IFbZjvJsL9/3JGksRGV7hkD5AqL7DQkxbM07Wl7ZTMliu5Vn2aSCopIL/g8vh2/moImFz9@vger.kernel.org, AJvYcCXozM4hBztDUeLJCnIsQy/VtH6ADzSlxowQbbfpVpwgY778x/3Qzb9JtMsYSzwdDsm1uf232hN5o0i+@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0gEWrXXM2AdARK7sdKKZhDP3yqwY1ICf8aptV1Gf4SDijk3ZA
	K29JMAiulcvMbMkbW1MahqdbOBWPxPoTiT/uqNHQevoCL4dBh+KqRXDg
X-Gm-Gg: ASbGncvtj5JW8D01hOaaYUOp/lYdiQjbzwXeQpraS6/yWDsbrYNKWp7af/TPfOycSaF
	eCfL6l1D8mupoyHhThmkd/zTIwv6SAn0p9AqIyq9Kn4ces7mlplxEixmMjUeO0/NSAPjErrHHPY
	fqZJ6MPoAkIor1m1s6UGUgLovQx4NHHyCDhbM6x4oTvI/fkDt89/vXLeQkicQzOdXavXuh1+V0J
	kjxZcj37KqR+TLfkTIOUvVhvlovTG4MKLgHxwBoIKDEqvxgbyM+Sbdu5CSgvrTgH82sP9V1fyJZ
	GzZHW4McMw8KSZZ0Wkmp/KeMJJEFDn+bf4SaCKUB1PdwwzgBRVAH43u38dlOORQUgAPUu/WxR8F
	gre5AniF7Vrbj+YrMS1xHU8bqkQTGVjQn
X-Google-Smtp-Source: AGHT+IHDP2qnmqjS+OjyuxLINGnH6RRIlWczknh6KUY3WAEc+CTBhXBDniv6qq7QdHd/r3GPOi1JPw==
X-Received: by 2002:a05:6830:6993:b0:741:c135:6afe with SMTP id 46e09a7af769-74500900005mr6184862a34.5.1756104876891;
        Sun, 24 Aug 2025 23:54:36 -0700 (PDT)
Received: from localhost.localdomain ([122.8.183.87])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-745226acdfcsm433568a34.12.2025.08.24.23.54.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Aug 2025 23:54:35 -0700 (PDT)
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
Subject: [PATCH 0/4] irqchip/sg2042-msi: Set irq type according to DT configuration
Date: Mon, 25 Aug 2025 14:54:24 +0800
Message-Id: <cover.1756103516.git.unicorn_wang@outlook.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chen Wang <unicorn_wang@outlook.com>

The original MSI interrupt type was hard-coded, which was not a good idea.
Now it is changed to read the device tree configuration and then set the
interrupt type.

Also improve the code to obtain msi-ranges parameters in this patchset.

This patchset is based on irq/drivers branch of tip.

Chen Wang (4):
  irqchip/sg2042-msi: Improve the logic of obtaining msi-ranges
    parameters
  irqchip/sg2042-msi: Set irq type according to DT configuration
  riscv: sophgo: dts: sg2042: change msi irq type to
    IRQ_TYPE_EDGE_RISING
  riscv: sophgo: dts: sg2044: change msi irq type to
    IRQ_TYPE_EDGE_RISING

 arch/riscv/boot/dts/sophgo/sg2042.dtsi |  2 +-
 arch/riscv/boot/dts/sophgo/sg2044.dtsi |  2 +-
 drivers/irqchip/irq-sg2042-msi.c       | 21 ++++++++-------------
 3 files changed, 10 insertions(+), 15 deletions(-)


base-commit: 8ff1c16c753e293c3ba20583cb64f81ea7b9a451
-- 
2.34.1


