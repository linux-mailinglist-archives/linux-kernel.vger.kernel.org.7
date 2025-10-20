Return-Path: <linux-kernel+bounces-860042-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D0FACBEF30D
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 05:33:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7787D18989BA
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 03:33:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0706C2BD00C;
	Mon, 20 Oct 2025 03:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GfyndtTF"
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E71F12868A9
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 03:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760931187; cv=none; b=I34fLQC6aqLnrZXWvZkT2yjsyEoKx+IJQA4K3zwb4fzbKgXgscjhGE5QEKfAtU0iB6QJkOsW1fJtiF9/Szhe5yrrFQXedjS+TJPD9fCuUuk9podYeBRjjQeB8WsrTKJ3+KlSDYW1FdZpFlwOjkBUrjnDV9pd2JdCk0d8gIb+n6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760931187; c=relaxed/simple;
	bh=21dD031tGAH9diIPRFJcMBeyJ5+2PaqTPis2r+LU094=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=CBvZAk4Nia6+jKRqknvx1kph5wY4zyNLM+G6/3xrTxS+M41PPjUtyfIkgW3iYbWKI2Y9mDZu7zRjmJ4VBPBJ2d43Xr7aRrtoxiTCKTKDm8iVuXPnDWdFY974mAaCzgdQbalP4VpbfIBM66E8hmfLqIRAuNHOYCKFVMN8ZPlsNrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GfyndtTF; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-7c0e357ab51so3336485a34.2
        for <linux-kernel@vger.kernel.org>; Sun, 19 Oct 2025 20:33:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760931185; x=1761535985; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=TM+5sZf5OooBDgSucBoXLeOFjPqmBCLK+QVbvsF8E6w=;
        b=GfyndtTFNrAF7WIXhe1fdSw0mmXehTJ/Q5htpm2usCaa91n2EmKTw55y8S7UUf/vTO
         hyQLBmt8HWFoXjOGRigC7NrHBNFgw5mTNx0ynkrE8w1UCB/o7iY/ikp2Z7PwXoe2riUV
         ornpPIG0z9HanrKoTzuSjGrHFJTR9AUjOy114VVY48k9QDfP7mB52nl1Njwh2ll3Zcc5
         UrLgrcE2YBAJEgFAB9/TUbImAnw9U6E5yJFE3chWq0GSIqPfBvIX5sdzwy496J7ni5UW
         x4EV5jDBUtHmAKdmmpqAKihmcn/gvjO/TN0IlWECnF7hvKQnJn24c+PAQH18fwwcohsM
         eeCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760931185; x=1761535985;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TM+5sZf5OooBDgSucBoXLeOFjPqmBCLK+QVbvsF8E6w=;
        b=tQ9FbX9OZqmFvHZZtTgjAa2/8GvcIiXsyG4AEo04ccHPqAMZQzFLFkwmZGL3lVUGZE
         htQgR94Rz0xp8dqQ5JvFu0nc+qhD1LJ0uc93a+WBO2A9CXOqNpWEBeezS49K/4sc0YT6
         xwAuY5Hnl/L2wpgworBfkUZ7uHBRfmo9RgiM8SWAhuM3xXyrohcMLy4SSRry0fnBEj1B
         6UCLu+DX1bSjLMEPfXiN86ZHzsvYPcR9aN3l8J4wzj8vIvzwLeeb32gXwdzbh/9iE+Tx
         B8AZZIGFYo5+pstWHAiGNXiD6Yxj5CYdITqxvFjQzTlp/dkaAqC4KKlLiNsXEUIIUfp/
         0TPg==
X-Forwarded-Encrypted: i=1; AJvYcCXCCGISQ5J9LbPCxh/1vZBYroJaOPzd+TFO/nl6JfMtulCGEiSxYkESKVdz569zzXddBpTH1KzKnPaVOd0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9KRCYzJxlqfk+F+NbKTU7eyy6wilHF07GrBHaeaYUh9TIBMd3
	qBdaJ48PUSTXCmlSa7cEeutuR7625mjKusd4vqHGLzRM0IuHTF/iO+8b
X-Gm-Gg: ASbGncswzBzq9zCUS1hTMgzezFJ+gnMLaUG9tVHcFOaN2Kq7FT61Z4oiApBHRMaIopN
	xqEtG9mK8n9tukTF1b4d/HfOMPdq0906X9dJFaJVfaKn49sE1hQma1R0H7zPViCLSPZH43Zjm0J
	zzlAAPeRkj27qPcDnvsz5BvkQwqpv3zCJDDrUVKKKotbWTRY41KcGMd1FDNUQ7B4He4C4adVMOc
	/KH4QqTYJB4C4RUKAdOUa751Y1c0o12SH2Q7xQkuS6T2/u+vhFbKV2YbL8GAex/1Z732ucCPlWg
	Ecg8Q7asxF/Lylf4E/bjQxKhkYoIYgZdNfOiYyZOyy5rYeDR+YEFYLs9P2cqpJLVDYdmknfSemF
	VndsEB6I+ZdWolfsNNy1LUGQVNgMpmftattcVPvKGGY1cpgqJfvKqqv9HIGGrKWDG3Mrpv9rI6R
	sBu7Q+GlXGAw==
X-Google-Smtp-Source: AGHT+IHSXRKU0H/Tj60xds+NdCJx8dzbIdYpjnBVmyNb0yUakAI7tZidFBFo9vJrXoitO39gS81lLQ==
X-Received: by 2002:a05:6830:3895:b0:7c2:7b5e:8cb2 with SMTP id 46e09a7af769-7c27cc4be1emr4547628a34.30.1760931184891;
        Sun, 19 Oct 2025 20:33:04 -0700 (PDT)
Received: from localhost.localdomain ([122.8.183.87])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7c28890e24bsm2244146a34.23.2025.10.19.20.33.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Oct 2025 20:33:04 -0700 (PDT)
From: Chen Wang <unicornxw@gmail.com>
To: u.kleine-koenig@baylibre.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	unicorn_wang@outlook.com,
	conor+dt@kernel.org,
	rabenda.cn@gmail.com,
	inochiama@gmail.com,
	krzk+dt@kernel.org,
	mani@kernel.org,
	liujingqi@lanxincomputing.com,
	palmer@dabbelt.com,
	pjw@kernel.org,
	robh@kernel.org,
	tglx@linutronix.de,
	sycamoremoon376@gmail.com,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	sophgo@lists.linux.dev,
	chao.wei@sophgo.com,
	xiaoguang.xing@sophgo.com,
	fengchun.li@sophgo.com
Subject: [PATCH 0/4] Add PCIe support in DTS for Sophgo SG2042 SoC
Date: Mon, 20 Oct 2025 11:32:55 +0800
Message-Id: <cover.1760929111.git.unicorn_wang@outlook.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chen Wang <unicorn_wang@outlook.com>

This new patch set is a continuation of the previous patchset
"[PATCH v3 0/7] Add PCIe support to Sophgo SG2042 SoC" [1].

The drivers and bindings have already been merged into the kernel
mainline, and this patchset will focus on submitting the remaining
DTS changes into the mainline.

This patchset is based on v6.18-rc1 and the only changes since v3
is a fix to address the comments from Manivannan Sadhasivam to make
sure PCI address of the I/O port to start from 0.

Link: https://lore.kernel.org/linux-riscv/cover.1757643388.git.unicorn_wang@outlook.com/ [1]

Chen Wang (4):
  riscv: sophgo: dts: add PCIe controllers for SG2042
  riscv: sophgo: dts: enable PCIe for PioneerBox
  riscv: sophgo: dts: enable PCIe for SG2042_EVB_V1.X
  riscv: sophgo: dts: enable PCIe for SG2042_EVB_V2.0

 arch/riscv/boot/dts/sophgo/sg2042-evb-v1.dts  | 12 +++
 arch/riscv/boot/dts/sophgo/sg2042-evb-v2.dts  | 12 +++
 .../boot/dts/sophgo/sg2042-milkv-pioneer.dts  | 12 +++
 arch/riscv/boot/dts/sophgo/sg2042.dtsi        | 88 +++++++++++++++++++
 4 files changed, 124 insertions(+)


base-commit: 3a8660878839faadb4f1a6dd72c3179c1df56787
-- 
2.34.1


