Return-Path: <linux-kernel+bounces-836172-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 337AFBA8ED5
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 12:56:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E15013A4E8E
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 10:56:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 640022FDC2D;
	Mon, 29 Sep 2025 10:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W0QslfMm"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79CAB2E1EF4
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 10:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759143403; cv=none; b=d8kJpJJCXHHCsXSiBU8WTMKb8LAFODKnWYkLZnFkdAZ4YtKsI/l7MkRxwmLfQBKrmD/MJ8LkhFJHFSFjvytiymn4DA0IqKXMID6t6uGHDaC24ZK3M9JcdbDc67ATuiYrDrhOKUMjJ1xf3zaWoJQb/uQ/LJFWOwLqq/1hX4+waVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759143403; c=relaxed/simple;
	bh=nOFnWCGB6HBPfZQXYY9HPFmCV1TjCfRVoNu8nGEeJzo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=e2k7P34MPAs1u9EeIv+Gwj8zV46Z6DMYhWkBlaz/q9j+rBQff7/e3np4tH+dDviUeY1g9HQV6kW1/ir1SUBlOtoebCtSx5t4d1xBCkvjbYWBaqfPuctbSEs9vdosKp8hQMrnm6ze09uC8sFn5tLWF1mhUQDSDLOoGMTrbopfoO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W0QslfMm; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2697899a202so39333545ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 03:56:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759143402; x=1759748202; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RZEDGcSwCEIii6+/CYGRaHQD4PqaSNrfaJOncbrJmO4=;
        b=W0QslfMmvOGIpzJJgoeuvNlYpMrIc2EaVNz42Tg/J3+lz0T1UJ6llZma649yzms+oq
         jaj5elRqOkbW/ec52CK1NizSqXvBixWsbpkv3XlMGeNcnd37IY5dgZtRIpDnj0WzEvS6
         pUNKmu6cQGx7por1MUWk14zB0tZwh35Zh3akwB2RYEubQxAa6x7MO7nlZCSmqTCgcfHb
         GloLKKT1ZToOp6ugQ4m3FFNeG/dKFInf29HjfoG8RWN0Smze/9GIDTkDVCShHzKyY+hj
         xj71KTM0ivyiFI+N8kSHDmTexvBP8e9RgB43Y/gEa636D0klXes9vmsDFyRGVVdQBN21
         kyWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759143402; x=1759748202;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RZEDGcSwCEIii6+/CYGRaHQD4PqaSNrfaJOncbrJmO4=;
        b=HRizmTkH0Rg1buAv32+6EvYw3OGJVDITvUVMbs3WQoeK+aPgbN1s+SKCK4BU7Amdhk
         6jsaxFagaq+JB2AYgB+XY8CwWKTRPDZU3c09rdfSYOzvJP8AwSW01kDqcq7hsUYrGnL8
         zJlqYR+SSbksQaeWG4iU6Xp5f4EB2Vn+2IcGVOlbPVsy1bOVGbC6mntTbSKn6ONjTiD6
         Bo3BLgpPwFUy4rPFJaeX8S9KWhY+IxiBgmRlEu00LKduQgIJ1+dTUREGThvndCnhGk17
         /VF80lgvzVF+SVNyfosLGu4jRNAyMHU3qQPBAP3z4aUv7MGt4S1n4ukcsMLij0BEyijt
         99UQ==
X-Forwarded-Encrypted: i=1; AJvYcCWavWa4IidxU9/2i/K2CZ/znlY980KP8XIa+yWW9NF4LK6aHk3rmgKdcNBGWF2hyKX/vPTvuJIWEIZW2co=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTxvswQjfLKjQuL+pQvU8PQ12zZhau3Mhkur4f9lmz4NmXNX3F
	9ahBeYxp4+tPmeUghU4PNnkH9/OQYwBgAqbNEXX+UwCR5u6l01wuqbbp
X-Gm-Gg: ASbGncsz9eEJbf9xL1qoMIZZDTbR+PbeM4et4+Mou2AD2Hu8RDOrQZ43TJQ3XpX+Hh0
	WGpB6qJUkji4Nt9JN5iYBKsaD8hezhaBUrd6uarEhKlqFLrD2mTM0O/IXN6xNui1EuTdV0R1ulS
	IfAxc2li4IEXvcXWY4WpSHEDOXtE4yBGeJD3ZtGy6ZLVt63CnbhHuPkjg+3t5lnUuuPVxg/qRn7
	7AK9FKheiFt79bX4ku8gD0VgPvbFL4YCceUoDf0jYdnoWs5oSv5cfIRvRut7OB/4ZTeTAGkhKY/
	2ffcQDwLdRB++2723urYy9uV3p7YnZycMKDaGeAEbuOPkgndyZ+vVQHZjainXk3f4w5vYS12lT9
	dQ7LhrbNtpiIBxLqd0QXKTj0/QnsfEvNNur6hYietPVWAAsU/Fcsq
X-Google-Smtp-Source: AGHT+IEZV0jFaXr2Lo/DqtPOAzg63RPmCiWyhZxXNvdL1PDKiMk4xMyA2I7apO6hTvbXrjXOgH3iMg==
X-Received: by 2002:a17:902:f647:b0:269:aba9:ffd7 with SMTP id d9443c01a7336-28d1713873fmr1034785ad.25.1759143401719;
        Mon, 29 Sep 2025 03:56:41 -0700 (PDT)
Received: from HYB-iPCgmhaB8Cy.ad.analog.com ([59.9.235.253])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-28cef7db380sm4762325ad.107.2025.09.29.03.56.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Sep 2025 03:56:41 -0700 (PDT)
From: Joan-Na-adi <joan.na.devcode@gmail.com>
X-Google-Original-From: Joan-Na-adi <joan.na@analog.com>
To: Liam Girdwood <lgirdwood@gmail.com>
Cc: Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	Joan Na <joan.na@analog.com>
Subject: [PATCH v2 0/3] MAX77675 regulator driver: Add support for MAX77675 device
Date: Mon, 29 Sep 2025 19:56:15 +0900
Message-Id: <20250929105618.177511-1-joan.na@analog.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Joan Na <joan.na@analog.com>

MAX77675 regulator driver and device tree bindings

Changes since v1:
- Fixed build error due to missing 'max77675_of_match' declaration.
- Removed duplicate '.list_voltage' initialization.
- Corrected value usage in regmap_update_bits call.
- Added CONFIG_OF guards and used of_match_ptr().

Joan Na (3):
  dt-bindings: regulator: Add MAX77675 binding header
  regulator: max77675: Add MAX77675 regulator driver
  dt-bindings: regulator: Add MAX77675 regulator binding

 .../bindings/regulator/maxim,max77675.yaml    | 202 +++++
 drivers/regulator/Kconfig                     |   9 +
 drivers/regulator/Makefile                    |   1 +
 drivers/regulator/max77675-regulator.c        | 792 ++++++++++++++++++
 drivers/regulator/max77675-regulator.h        | 252 ++++++
 .../regulator/maxim,max77675-regulator.h      |  78 ++
 6 files changed, 1334 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/regulator/maxim,max77675.yaml
 create mode 100644 drivers/regulator/max77675-regulator.c
 create mode 100644 drivers/regulator/max77675-regulator.h
 create mode 100644 include/dt-bindings/regulator/maxim,max77675-regulator.h


base-commit: bf40f4b87761e2ec16efc8e49b9ca0d81f4115d8
--
2.34.1


