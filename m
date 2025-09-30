Return-Path: <linux-kernel+bounces-837352-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A9BABAC1C1
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 10:47:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 82FED1923B64
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 08:47:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32BBB2F4A06;
	Tue, 30 Sep 2025 08:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lxf4ejqO"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1A802F4A00
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 08:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759222013; cv=none; b=LXe4flxNmLwafN55GqQctC0Stx9YDG/MOUR2z8CBnrHukw5+O1Je0R9PM5U+K6WxjyOzpI3VRgwSWI19n/0kw6VGS3oYt+6xhyMxrB4MRt9VtRKihZHSg9qHJ4SsvZQPfmc+9yTNM5ABzeVJI4ETUik+K555qpNOixxE8mjzFFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759222013; c=relaxed/simple;
	bh=Kx9E7uci+b63lQZhRViq5cTuJs8SyIKzf0cDEpj51Ok=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Z6Es4UjVdj44YyColxLJCpCIc/wR5NXE0hEKSEAkelV5ZkmEL3HWwTGgC1TNqx9v3TNjoiCa9NcSJD4gU0+gS8trHvIgiw8vTPITQP1+R8QGDtxurj/2mRT1Wr9s52g/nrS+BuEV7YIJaaL/78DGJAEOYVI6zNQ/wy6LlxPForY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lxf4ejqO; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3ecdf2b1751so3752565f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 01:46:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759222010; x=1759826810; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fVsl8vGcfYK8AgATkYy0L7h3lyqmmijzRq6HHy2CfXM=;
        b=lxf4ejqO4xDnCAIVjwc9mV9zRWqn8PBjDQLtNn3mH0vTNnzGmGsWmJdLqSWJ83f4PQ
         sqlWfpCvk8ZbvzyUYg18wRgnqTw/cpli3/6ALit1V1b6RGPRmcD8bCf7/5I5GOAImLA2
         v48t9OGsaZKfOq3W9c2ijCu04Xbpp+Dsj+I08GI+6o+srBRgTd6bjGWUsAfGQuL7WuxW
         m9IW0gv2v/Sl0NmnaUZ2MdYY/iZOaeWitohUh4gqC1+C6HcxemWommmusZF12kpce3aS
         X80YlovevomUWIO+6ITjn2vPxIsezQ8VX0wNNGO5cOYjdKneTm6S4PVtB50VpGeWkPc/
         oWCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759222010; x=1759826810;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fVsl8vGcfYK8AgATkYy0L7h3lyqmmijzRq6HHy2CfXM=;
        b=j/Df3AhMlrGtPYdeX0bpEOeFSl3ow+IVmQ6YkPkX5XCPSUmVTdwI0DOkXFovR0PuEw
         sgG2zdLtW+uHKD8pg2vze0SaAoPqURFQ2z9sdeg6TU1i8qcM0gHNkNKbsDe2hWVXzhWU
         ChfTV9K0eXRix7ok1BYLuYzs/8VPACs6Km2SctSsbaGaXpnvfDeMViLUFWh6j0CRetN+
         A1TfWCJ6oyYpsPuknNPWXByA63FiQcA3fnINA4CTSDHMXOH+GDxQVjapf8TehUNkGsyD
         a4OEexAu9benZGV9DJkSU5TQQaDVv+9YqcRNamP908COGdfRGji8fPCaawrw6PvQzgYM
         BTXg==
X-Gm-Message-State: AOJu0Yztf4TBXyzLybOUHtoVjaqHuzrf9VSv3Is4mzCRy1XIHm5w6g+K
	2sT9SPBh7LunpRGjBgd3yCfs1VxepX19tpddSF3EP/khptUR1lqzsAQx
X-Gm-Gg: ASbGncutGAl7DIirau1wfQvyG+/v+/obq0mYrdGy5WuPJMaBzAp5q8feQX33RmnUOov
	n0rbkDfstnQ81q/aTpoTQlzs8plaRVyA2ZkB4TBDrFHzEwYsKxOrUFhvt7bDhkHi9L7Dkp0fcEe
	0L3GgqE0giQfRW03sxaOEL9y9I4I0DOVrkGpS25jmmmxMNPm13pXjjhq0YBnkwH6uvgR/PuLpVd
	NxPevGZc8GRqZG2MlwFCcj0GHAn0T/ldXYsbo15JxhAx+CCi5LtUVicBa8fpw+/9LRjjKcXi8db
	KbIBr+E92kZLBa1V5C5VPaN4WQ4H5tPN9XGA7r/KaewyAqp9zk01iShegWrM24tSxYUvl5U/SKk
	pU01P0lS76FqCxPBQKh/rd4JmAEEIfNPeG5xTE7cOLY1dNCMU88nkCISsO+gqtv2H/DBUgW4ONP
	NvF8f4of5qAG+tbp8AuD+egwxbrozBYBd3HnRO22fRL8I0pI0awlO+KpAckQ5Q9A==
X-Google-Smtp-Source: AGHT+IFNKqn3I7Ak0yCQK65+PzvDoYV8kvut0/aco1wX5M8V/khPAzAoVBU1h3CVCUW6iDQw7YuIxA==
X-Received: by 2002:a05:6000:178b:b0:3b7:9c79:32bb with SMTP id ffacd0b85a97d-40e4ff1991bmr19424072f8f.44.1759222009713;
        Tue, 30 Sep 2025 01:46:49 -0700 (PDT)
Received: from localhost (2a02-8440-7149-a758-f461-9bc4-1c75-ebc1.rev.sfr.net. [2a02:8440:7149:a758:f461:9bc4:1c75:ebc1])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-40fc5603356sm22122689f8f.30.2025.09.30.01.46.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Sep 2025 01:46:49 -0700 (PDT)
From: =?utf-8?q?Cl=C3=A9ment_Le_Goffic?= <legoffic.clement@gmail.com>
Subject: [PATCH v8 0/7] Add DDR4 memory-controller bindings and factorise
 LPDDR and DDR bindings
Date: Tue, 30 Sep 2025 10:46:43 +0200
Message-Id: <20250930-b4-ddr-bindings-v8-0-fe4d8c015a50@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAPOY22gC/3WNQQ6CMBBFr0Jm7ZhSaFFX3sOwoMwAk0hLWkM0h
 Ltb2bt8L/nvb5A4Cie4FRtEXiVJ8BkupwL6qfMjo1Bm0EobddUaXY1EEZ14Ej8mbEpbcsWqG4y
 FvFoiD/I+io828yTpFeLnOFibn/3fWhtU6CoirdjU5Ox9nDt5nvswQ7vv+xcaQSS5rgAAAA==
X-Change-ID: 20250922-b4-ddr-bindings-7161e3e0af56
To: Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Julius Werner <jwerner@chromium.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, 
 =?utf-8?q?Cl=C3=A9ment_Le_Goffic?= <legoffic.clement@gmail.com>, 
 =?utf-8?q?Cl=C3=A9ment_Le_Goffic?= <clement.legoffic@foss.st.com>
X-Mailer: b4 0.15-dev-0dae4

Introduce DDR4 bindings, which is the first DDR type to be added.
As the DDR and LPDDR use the same properties, factorise them in a
sdram-props bindings file and rename lpddr-channel into sdram-channel.

Changes in v8:
- Globally fix typo/grammar in SDRAM props bindings:
  - DDR4 bindings compatible description:
    - s/lpddrX,YY,ZZZZ/lpddrX-YY,ZZZZ/
    - s/in lower case/lowercase/
    - s/statis/static/
    - s/~/-/
  - Add an "s" where a plural form is used (e.g. registers) in the DDR4
    binding revision-id description
- Fix the number of chars that an SPD can contain in the part number
  field.
- Link to v7: https://lore.kernel.org/r/20250922-b4-ddr-bindings-v7-0-b3dd20e54db6@gmail.com

The v7 is a subset of the v6 and other prior versions, split to simplify
the review and merging process.

Changes in v7:
- None
- Link to v6: https://lore.kernel.org/all/20250909-b4-ddrperfm-upstream-v6-5-ce082cc801b5@gmail.com/

Signed-off-by: Clément Le Goffic <legoffic.clement@gmail.com>
---
Clément Le Goffic (7):
      dt-bindings: memory: factorise LPDDR props into SDRAM props
      dt-bindings: memory: introduce DDR4
      dt-bindings: memory: factorise LPDDR channel binding into SDRAM channel
      dt-binding: memory: add DDR4 channel compatible
      dt-bindings: memory: SDRAM channel: standardise node name
      arm64: dts: st: add LPDDR channel to stm32mp257f-dk board
      arm64: dts: st: add DDR channel to stm32mp257f-ev1 board

 .../memory-controllers/ddr/jedec,ddr4.yaml         | 34 ++++++++
 .../memory-controllers/ddr/jedec,lpddr-props.yaml  | 74 -----------------
 .../memory-controllers/ddr/jedec,lpddr2.yaml       |  2 +-
 .../memory-controllers/ddr/jedec,lpddr3.yaml       |  2 +-
 .../memory-controllers/ddr/jedec,lpddr4.yaml       |  2 +-
 .../memory-controllers/ddr/jedec,lpddr5.yaml       |  2 +-
 ...lpddr-channel.yaml => jedec,sdram-channel.yaml} | 40 ++++++---
 .../memory-controllers/ddr/jedec,sdram-props.yaml  | 94 ++++++++++++++++++++++
 arch/arm64/boot/dts/st/stm32mp257f-dk.dts          |  7 ++
 arch/arm64/boot/dts/st/stm32mp257f-ev1.dts         |  7 ++
 10 files changed, 173 insertions(+), 91 deletions(-)
---
base-commit: 30d4efb2f5a515a60fe6b0ca85362cbebea21e2f
change-id: 20250922-b4-ddr-bindings-7161e3e0af56

Best regards,
--  
Clément Le Goffic <legoffic.clement@gmail.com>


