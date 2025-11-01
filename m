Return-Path: <linux-kernel+bounces-881307-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E509C27F55
	for <lists+linux-kernel@lfdr.de>; Sat, 01 Nov 2025 14:28:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 74A7D1897B5A
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Nov 2025 13:28:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD0892F5338;
	Sat,  1 Nov 2025 13:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k2WAib4U"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F3FE2E92B5
	for <linux-kernel@vger.kernel.org>; Sat,  1 Nov 2025 13:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762003696; cv=none; b=LmkqYUhRN4d3/djqkYHYxydYjXREqNBw6Quq0QDRzv/R8ldixNdeFUR/kYnCnAWdTuAdBN5fDTp2w1XRrDe87fFr827W+LgDarLUj6pdIEeME4uVrduU9WdbnElg+vwT96+yMqBMmJgvfu8b0Abl3DW5hHBYt3Mc7I7FeKmsweA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762003696; c=relaxed/simple;
	bh=gAgc+jApGGkkwyUp36XmfvqsPjvOHQyW1LpchMLaSBs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Wxq3W7xkWyiHcjZunWuKnXC1bBWeDU7wk3jx7cgJQhOmdwy+ac/k3iXgOel0FuayUqLQ5W1+xFP4FEMDd6l+e0sArQBfkwgBDBI9jyS/hz3rryQF3v4852zgCm/PDFUEC/IwNbuP3vOX0ECqy8RWMm25Jc57YNxc/cs4VZr1caI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k2WAib4U; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-63c0c9a408aso4613958a12.3
        for <linux-kernel@vger.kernel.org>; Sat, 01 Nov 2025 06:28:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762003692; x=1762608492; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ONIF9EAoYN2P35o4ugvv8mkCoUJAyvaPuhuKkOC/Ehg=;
        b=k2WAib4UD4/suQf6SlBJhoDyXxeqRxll/FIdr20OA23vHjRbTbDPhtGcF8wh6o00zx
         YVyrcQO0iLPRxq5qOmiAWqlmgmIQotWa4ja+ahMh8NtuJSVDB9W5GaL4LmyjEZf66CoA
         UjJl6cG6nS+M9uG48jvPv+MgqS9N4rqsGCKiRU/ToisiufcV/ePQGjYAqq2l+MOg/d7o
         lNkkPwWDqdG3MsDYr2ncyUzt3eNaWG7vVw8wudH5uWttMBZjVOkbJJf2fkMvQAF+OZNj
         fk/b9mPb3csem4EoUDNVO015+ZLpj+OvUVW/7Dq6fZ8isyQ52De28Oqt0zkTGBr3bVZV
         a/0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762003692; x=1762608492;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ONIF9EAoYN2P35o4ugvv8mkCoUJAyvaPuhuKkOC/Ehg=;
        b=MXxRTnvVsy8gTXcksS7haQ5c4VzoMIrb7SfWhc3f1ID/C5Ah4aNSZ4U/TVneoDQILt
         JmS9NHC7vKsJm2JZvcpmdOR8uEXGJSXxZjdkQhKl6jTL7C9qEOos/EV+RWkU/2pe3HYh
         hntEHElRjOBPaXo4Ta7rgQ7XSgnkoTGyPYJ/nX136P7HJaZQzkzuLZoBROdvjXtI0M13
         W7vrOnbAbvBtSzgSRIPKICzxvsCTXuPPZc1iUrlgQ4u1LZTTgcwZo3hPXERD9zKhoD1R
         b45WLnn8ibg/pweVxos9mqPKdjdNu5ZTJEKWao1OM/BfIYw/VQtYsRKdNSrgvDQaWrq3
         pr7w==
X-Forwarded-Encrypted: i=1; AJvYcCWrxLdyR+SBqtxeffyIhGr634tnfF/aAEBfj9XO7ngaHlHzLheo6fe5JV+MySFUXjzkuJ4i/TV8ZkiUPCA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNQuD5KbzTZjG433pLMdeaVarNN6WGhST4R02bHrwIYpOpJaxJ
	H3p0PyssPFgwJX+ZX/3N2/31BiXVjZzaEYjMJuZQdgWHS2Nfk/DG9KBD
X-Gm-Gg: ASbGncvFXHY5NMuaGV77jW/0aEImUmmS41rwoEOVF/GH7EcFt8rmS6Luuu5zF1tiE9L
	YdzVtHDHzKuxXHgcgWRASpn593yC0imPaR4nsHYshActA2C27I/oFYTD6QiDuow/G2zu7U3n846
	fL2w33systREDPnld6lE0U8rEDc+xC2P4jFADO5z3yQKIFenUdDJPGufgNcqqClNlEthBkDoOH+
	Afm52RyoPKcLNeVmEP4r4Vu4U9vj6fS6T5Ok16VgcrBaqL+P1wD4UPs+srywsxz9Ti8lp3NrABL
	4LvGYbOTrXdMWqvwusYtiO0640mcYTYxZHQqtlbBEmdHcFXBWtcO3U63vadWKdVrh+Sxnjf2pBH
	DDODCQtFyscS+7NqErWpww8hwmDRoeyNXX0yg2EcWH4Tkpcs673ATnfTFNuJrZb461kkz28ep0K
	wp8e5berjrKn28eYEnLeeJGeswvDK79CTruTS3Rzqiah4doZtvHxC/w5j6cTom/Bo0K0s=
X-Google-Smtp-Source: AGHT+IEkkIjbsnvjLHIsgEaTZR8QN0VYoBx925w48c7nmnrJD75okGYjHNezpBJlCKTezTSeeku+kg==
X-Received: by 2002:a05:6402:2744:b0:640:6a18:2914 with SMTP id 4fb4d7f45d1cf-64076fad99bmr5315981a12.14.1762003692322;
        Sat, 01 Nov 2025 06:28:12 -0700 (PDT)
Received: from localhost (dslb-002-205-018-238.002.205.pools.vodafone-ip.de. [2.205.18.238])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6407b428102sm4022741a12.20.2025.11.01.06.28.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Nov 2025 06:28:11 -0700 (PDT)
From: Jonas Gorski <jonas.gorski@gmail.com>
To: Florian Fainelli <florian.fainelli@broadcom.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net 0/2] net: dsa: b53: fix bcm63xx rgmii user ports with speed < 1g
Date: Sat,  1 Nov 2025 14:28:05 +0100
Message-ID: <20251101132807.50419-1-jonas.gorski@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It seems that the integrated switch in bcm63xx does not support polling
external PHYs for link configuration. While the appropriate registers
seem to exist with expected content, changing them does nothing.

This results in user ports with external PHYs only working in 1000/fd,
and not in other modes, despite linking up.

Fix this by writing the link result into the port state override
register, like we already do for fixed links.

With this, ports with lower speeds can successfully transmit and receive
packets.

This also aligns the behaviour with the old bcm63xx_enetsw driver for
those ports.

Jonas Gorski (2):
  net: dsa: b53: fix resetting speed and pause on forced link
  net: dsa: b53: fix bcm63xx RGMII port link adjustment

 drivers/net/dsa/b53/b53_common.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)


base-commit: d7d2fcf7ae31471b4e08b7e448b8fd0ec2e06a1b
-- 
2.43.0


