Return-Path: <linux-kernel+bounces-827018-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 19E69B8FE7F
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 12:06:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E59A918A12E0
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 10:06:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DEF92F3606;
	Mon, 22 Sep 2025 10:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LQ0QVCB6"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D5F21F4C9F
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 10:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758535583; cv=none; b=nerQnxraB31oBDMwG4baBtF28XT5M5NR8aZYUtgP60u/WkUSPW2XsUZgmqeCHP5sB67o8SjUSiMhkdnEjsHSKY9B/kFQUQYf/X1xfmnOe4tE17s4MxwMb9AFboS5lmfC6erYAeH/ITkMWyIF/CCOslOII8+gK+Mt+ZfniK6emH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758535583; c=relaxed/simple;
	bh=tlxtEOBd50Gk6lCncQ1rHB0F3BBqgZPoLgxbbS4ptdU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=LYlvC3EArRPyKtEzQRt8Z0CFrBZ4dSMrQTpZja2CLHt6NVTpACQOncseqpiiaQKb74v0gx94/3wu/5CLZbN2CcJIm1apRz/2YYCV4wck19VKbR3hUtUn2gfPely78z6wBbsJCQCiuNlLX+xpbH9b0sEpKcttI/EJgWmxAXpAUeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LQ0QVCB6; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3ee155e0c08so2573805f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 03:06:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758535579; x=1759140379; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=unx+477Xo9SXjdzpioJOWI84YS3CAeJIIcacV6mD704=;
        b=LQ0QVCB6fYkd9fYvwVHKRT424vLLV5ldUXsl4E0iyu21XF0or/1VU1roivwgjPhWhg
         GZgqkCe7T4cuKaIWhrZV4qX3J2B8ByMkJeTEN1EbZPK+/0GjSAsF/958d7CW5y9eIj5i
         O6lBPAK+tpd7cun9dUgW9dzDDAtLc7PaRpQVd9axH+2NB2H9QckvOEDRDRlw8aVc02CF
         adRPHukBrNf72QN8pJf4HZcMVjvh0tjhSnBkxWbzdWVPvUfHXYhW0zYjJSczR+b84nqb
         C63jEl7uXqAnNTkCSCi0ljnP/Oage77Vm2/HRJtBw6qxfQZQBaOSy76ge0EN/RK1balD
         GRow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758535579; x=1759140379;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=unx+477Xo9SXjdzpioJOWI84YS3CAeJIIcacV6mD704=;
        b=Zf/cRwvK16nCYRlFz3r+RcKk729eM9cpVO0pBoabkJmRNbisK+322lfs9MMnXJDZtX
         kWl/K7rpWntjWiNW8ZGabatXrDDBzX4QRC3i52LF4Jzwqjt4/W4dG5Fx6C2RylcMCf6S
         UPmtsu0NZlMPpSjhzgtMIn7sJGTA9XYRnz6e+KMcy1oPVkdl9wX9mJ9SrmtgkT3WhkjI
         J6KCesiT6ISeGq+atGH6WqEXJrUvPhlc4u3LuEd76k7VBixtQ6rfocgy68kHq+WR5jY2
         iAY95IQdCk/Q+P8XdDfS7T5Y6Cd1F+TA6aGvaodUjlRAt5D38TcnMCOl9/J4teDEQ4cJ
         yavw==
X-Gm-Message-State: AOJu0YxNzKU4ZAj1xwteuO5q+QV4VD11hC49EZER2Gr2B8p6uNchNtXD
	y0B1gZIMIjr5OdiO99Q05GYiZeEhM4wizrXquoRlAcBQiN+GnrElVDTZ
X-Gm-Gg: ASbGncskFvCefKO3hCbWXHYf6+CcbUmKj4/qCbKTMvksZzShnfjw0+dx/vySyJakTnh
	cPOZdxgZRknekX4XkbF1r289k4CQRT7y4aYLktEMuQE19HmLNEHNzcGXlWjaq5ONp3s83Ai/Wpn
	CZQiU5W4fEECfxxWxZOZTdxGjGeEwu+P6XemrlqMEp/m6PDewnhOB11JigCHe698ipeT8u1Qp0A
	F20jpY7PLhB8YnExxwGrf7zUevf5crFsATHhu+wFMyq1nctWPCUhb+mm6XdmBbEDkY9wJYOXEO9
	KWZQGGfKi1YTwALaRl44gZR+iBNiHQE41KaeSoiMoWvK0VBPOocEVeqQlT5kPtYelQxO6APnPDx
	+gLTvVqVi3f074yuQyi4kSzSMeG5D0m2aVhMr+4v2qJ7EQwW1LbUfQdqzR+ULcg+Bndb3mvnwEb
	F0bnaDm9NESlm4R/jU
X-Google-Smtp-Source: AGHT+IFPgQWMfW7+KuDx0XBlYA9F21pJgkpSv8WTV4nH9rMZwyvad2B/FC4WdzJHu0BGJqOjLMdEzA==
X-Received: by 2002:a05:6000:22c4:b0:402:7afc:1cf5 with SMTP id ffacd0b85a97d-4027afc20d1mr695483f8f.35.1758535579347;
        Mon, 22 Sep 2025 03:06:19 -0700 (PDT)
Received: from localhost (2a02-8440-750d-3377-171e-75f8-f2d4-2af8.rev.sfr.net. [2a02:8440:750d:3377:171e:75f8:f2d4:2af8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46d1f3e1b03sm40908675e9.23.2025.09.22.03.06.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 03:06:19 -0700 (PDT)
From: =?utf-8?q?Cl=C3=A9ment_Le_Goffic?= <legoffic.clement@gmail.com>
Subject: [PATCH v7 0/7] Add DDR4 memory-controller bindings and factorise
 LPDDR and DDR bindings
Date: Mon, 22 Sep 2025 12:06:13 +0200
Message-Id: <20250922-b4-ddr-bindings-v7-0-b3dd20e54db6@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAJUf0WgC/x3MQQqAIBBA0avIrBtQS6WuEi0sR5uNhUIE0d2Tl
 m/x/wOVClOFSTxQ6OLKR25wnYBt9zkRcmgGLbWRo9a4DhhCwZVz4JwqOmUV9SR9NBZadRaKfP/
 HeXnfD6+bg1phAAAA
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

This v7 is a subset of the v6 and other prior versions, split to simplify
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
base-commit: 07e27ad16399afcd693be20211b0dfae63e0615f
change-id: 20250922-b4-ddr-bindings-7161e3e0af56

Best regards,
--  
Clément Le Goffic <legoffic.clement@gmail.com>


