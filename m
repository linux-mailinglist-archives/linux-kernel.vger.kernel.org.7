Return-Path: <linux-kernel+bounces-852948-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A78F4BDA462
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 17:15:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0982A18957EA
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 15:14:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E5952FE059;
	Tue, 14 Oct 2025 15:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jQeBDQh6"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B52E32FF652
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 15:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760454823; cv=none; b=eRsVg1YzQWYxvx+QDixBVkg1xqD2pPvHJhXG0JZI7hbCj60aWeu9qZW4pvwOcBwUvuBSamFJT8EhHKX28ysOT0HcfOlcui7d6PDG+to7tdnzargRK8n/HbhgJs0s0DLz5XwXIP7wZst0yraQqv/bzlt4gdSGpFeADe/s2ssGYeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760454823; c=relaxed/simple;
	bh=bk+3Urmidyseaj7bEE31gjN1uAPuJrv5gmtVX98iJNU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cZNbIgPdD0PppfbIXsUeXGdKdZBPm9NqeqBtJNB/ugwM+kqBGiwElytki2q0b2bIhOgZ9hEI9iLiqa5UGJGzpC0YHckKuvZxO0ra32d0voKSZXxRd9tGQMXZNGEZrT7RZFsLCXeZACcz7mO0p1J5HsQS1x48BQzPt4sdcDwHLs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jQeBDQh6; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-273a0aeed57so80095045ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 08:13:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760454820; x=1761059620; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=a8tOeziCnN4Ni2u4fQrMrmy+/9+u3hrm4KNQAT/jop8=;
        b=jQeBDQh6F2n3iiE33uKlcu8I+oKZ37aqghF0Q0wgZe4n5l2YvBMdJGBmNuHo/4hi5M
         T7L4Rb0ieRlzoKIfV7fsnoxUBGh+RPRTLbySZI96GQcBUXFbrHZO6z59ZLqQxnEDoiRC
         89GG49h5B2c9NCNY3zAb3dU/XVle7Bk/Gkkgunwue4quuDTshY/daTDRL/QzUK8l6WWs
         e95Li5yKPG6i6YUXi5PhhpMIpo2UOigy/kHf8iTmcOERM5hf8ANcE3wvfvVNLKaBnUqm
         PDBvntNwqxEwtRJ3tpSIZ6V/C4TOQhJAiAQCr0kFwOM2ftr55HyPMAtc3fX+eJN8ffRH
         UPJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760454820; x=1761059620;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a8tOeziCnN4Ni2u4fQrMrmy+/9+u3hrm4KNQAT/jop8=;
        b=Zcaw6frdBPf1ySNeLUAQ9ufSID3q/W/+kRmH2kKyY+bopSKB/ILNMVAfuyNVnzFCQ6
         v+IaGn67NlCqvPDtoQqlRJzB+6+wshp5M1ZmTa+q71qmI60fr80PGJ+vEeET3zyg4Edj
         +46uXRJtKnn2yO7vTrZDmi045hKATorg2Dec/U9fTGyezFfcJAzxoLgEU0NetJ9NE4Js
         uUzan3EChIRRC6sdnQJmX3IycqeMik4OMVWnJnHiqhVex1VLTgJ15T5xrgKhWmT1TqRm
         sCPmmJDU7h1QO2Z2dUwe1ylsM4EEagpS+ZocMqesju/L8B7e6L1ixUbwL4FlW5iof93h
         YHEQ==
X-Forwarded-Encrypted: i=1; AJvYcCWl0gVMlftlo9xyBa7KVjj6lXkosnde69RNHCIhTzcxXKDUCsbI9rucmvxaf5jPVNOAOkjKCGETT9j7rMM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1hAxkIr9Qu7711wxIX6X5N+89EQ6QK0kIYHlthPlol5xXk9Ts
	zQ1rBWB+Ld7P8bkR80csN/EwWGZE2ZN4BjbMA3J09hNKRZ8vcOvA2G8R
X-Gm-Gg: ASbGncvC4qdHt6+QCwimvNY3+2hU0B8XaNa8WdRDAIfJiRWshEj5LtliiYjpf8/0L6A
	eLou8JdjVCcoPAHKZwPQy1s2i2wfLSf/T1ReqJHDDvGxFkhLrEfDN/BP0nKk8AagF/ttaxexEeA
	XCngrNZ38TLfYgOJYzLUcooEgNG14gAJX5lK+IKy22etABN9LM60jpRLaN4NpLUAX8PT6JyJyL6
	U5mtd2xYsKqt5uoloqKL5jUI2er07D8AUa+jxV/WE8CHSpsfx4hMMbYfPXjihKLyypycWX/2YuW
	1mlIwnsWe0y0k7MA8hl+rfA5P6a8qmhxgHEeNeIST87KtRuI7e+jnwSKTPsCsB/uG7Ok/kkXgLO
	WcJb/CELSpF7ar8+fvGX4w0taWOrUq4wwBUYX1fJi1amNA9HKe7kik1auXG2DB9rjggKEMUXyWA
	==
X-Google-Smtp-Source: AGHT+IEZNraDrsdlmzWt45LeJsdeKrIjLC4h1zu7z+ngdEnkAeoGnJKGbBlO93KLbkvtdV0gORV/tA==
X-Received: by 2002:a17:902:f641:b0:269:8ace:cd63 with SMTP id d9443c01a7336-29027f43af0mr311264675ad.30.1760454819718;
        Tue, 14 Oct 2025 08:13:39 -0700 (PDT)
Received: from iku.. ([2401:4900:1c07:6d70:c338:e681:47e3:e797])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29034f8f9bbsm167171125ad.121.2025.10.14.08.13.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 08:13:39 -0700 (PDT)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Magnus Damm <magnus.damm@gmail.com>
Cc: linux-renesas-soc@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	Prabhakar <prabhakar.csengg@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 0/2] Add XSPI core and module clocks to Renesas R9A09G077/87 SoCs
Date: Tue, 14 Oct 2025 16:13:23 +0100
Message-ID: <20251014151325.160062-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Hi all,

This patch set adds support for the core and module clocks used by the
xSPI (Expanded SPI) IP on the R9A09G077 and R9A09G087 SoCs.

Cheers,
Prabhakar

Lad Prabhakar (2):
  dt-bindings: clock: renesas,r9a09g077/87: Add XSPI0/1 IDs
  clk: renesas: r9a09g077: Add xSPI core and module clocks

 drivers/clk/renesas/r9a09g077-cpg.c           | 35 ++++++++++++++++++-
 .../clock/renesas,r9a09g077-cpg-mssr.h        |  2 ++
 .../clock/renesas,r9a09g087-cpg-mssr.h        |  2 ++
 3 files changed, 38 insertions(+), 1 deletion(-)

-- 
2.43.0


