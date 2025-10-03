Return-Path: <linux-kernel+bounces-841271-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F164BB6AD8
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 14:51:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E9CD218896F4
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 12:51:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B092155A30;
	Fri,  3 Oct 2025 12:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eWnkJxja"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51E22146D45
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 12:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759495862; cv=none; b=GUpKAWAZKYg6DZg6WkiT2/4rkKZehJwW2atlT8QGe7oeXmODqclg+/AsV14+j2R6WKzWKxaSjMOigmgkpiKyBhR1bD2TSRLbn2ayIyacSc7POnaTOykJfkB6A4UgiPGfNfF5B2tPfPK39V0Q6u5eXPsfIg+aprcYrvxUyQdn0/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759495862; c=relaxed/simple;
	bh=mSudeg4QDvsImGywt/0dAyPlzjFfeZ24EUC1/n7/GmA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cGmesk24IM7wNN6gYphqEljw+5lLOYHsGDxhJc5CtoJbs0AlM8ryPwwmNmTBeIQxjcbn/cRGcn7/6V7Hiy4ohIE0RQVd1SLT9v21rRapkxwAlYF7JYDsBdrmB7wcI1OYkSQQh+X7iivTxu/Xs5m4PIphXKiB5S6Lo5ospBtoyaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eWnkJxja; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-46e326e4e99so17729995e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 03 Oct 2025 05:51:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759495858; x=1760100658; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=samCYGqwi9pnzVf12goEC93sXVEkXkpJUcL0gXrpXZY=;
        b=eWnkJxja731pRID0sUB7qYHj2C2eJu4wE6TaucKQyj0WtGX2IFPh0HFDEpFYY1yo34
         GM1NTAR+9UmVgQQifAotQ+luDvJ/uhuJok+1msCpiOhr+Rsc1dWDX2+odLtgoVU26wBR
         EV0iNGd4EBMVg1cxBCiG2P8xx9OiN0lVbuibzkszkctX17q2+PYbV0sW1cHrlnKpT8qt
         Ej8dUUcWqJTIpcjlTkjrbXC6hDk605u5BlwA1fYXcT5VwOnT0aUoxyJ9+3oJD5g4NUJM
         ZJOhTmcEcrAiz01oNAzkmsc6otV7KAf54fGyPcFleGzJCrrJsjydn4WEIF+ClVHY8Mii
         OlqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759495858; x=1760100658;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=samCYGqwi9pnzVf12goEC93sXVEkXkpJUcL0gXrpXZY=;
        b=BCIBZTyGuTmcoGlTiB4mUAe0Il7G+Y7bCoYw6YeEtUvgz/PsDk4E/4MRG1Eaqlouav
         XYER6zSX3BY0t9OLFaT7JE6BG6LXaVWG6qrDwVKKJLU06x4EdLkqzRYytQMZvQM0Tzyz
         fLpfINB/Yn47shpA54vb1R+sAfcY2f/G0pON5wDnfWhMFYyQbV0a55la9Fb3NT1Vkxcd
         84FbmJjqke+TIH82O3NRWfr26MiR/MatOUYF9ncI3J/n+hlgUdRCf4SHvKWyIviB8gwM
         z3tm+HWVQellnFvnacElr/HFwyuacJPVXEfBsveujZma2/ZClltxUdqAclUV2oawXORa
         YQEw==
X-Forwarded-Encrypted: i=1; AJvYcCXnLmRyPzgtiF28sUPeAqsLWkcvZlQjh4Fa1X+lUTp11QSmNm75svn+3M8akzpjTfT0DLMaSPHZn9O4gTU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbddT5eJKo7szG1xRESfTi9IRefLhERbQ/yiK1W0b5FMX3DX6h
	3RQEZE73tVt94ea1LcuBlWlXHYitF94uIoF3n79HJCkXX7pV9+NPfRpZ
X-Gm-Gg: ASbGncv+xlVY6Sec10xNU2Q5rnMN1dHNM6zyVT6yWOAbM5ZX/yZQBAvliQHx9vIn33L
	TY6kFc4GCzdB2BCe0C9IqgDNiTOIC/ZNQNSl7K80yWo7ENs3jL04zHKlt/Db8yTx7m9v8QBKwJ4
	hXW0/TYfVMv+2X+V3jy/AOdoc2jlntLU1KWExIHB98lDq1RglhY10ctEe5ifpGwbQEzngzsdjre
	x81YJHbGkuUnL2PEuft/B0uJ7kF3NDkC0KaRYk+tjFVwj80hUG256e4TQJY3FYiS848s/JLi9sF
	4fQigdC0A460sbOtWR681XNeAf8Jbz4RysRogs8e5DEQafctJXngwtJDZMrgIfz7W5dcfB1M2up
	emUMJI0Y4ixK7/viogIz2XQrFPfC0NvMUtpNmaLOXvhYkjEfvWXy4H1GyE66LlwvygbI/59Deq2
	ayGoSI
X-Google-Smtp-Source: AGHT+IENzuZxbYIdrHD3oo9Oii97vCN3RXSUhQc4ZEVlPzK73ksVqzVkKPvFzgGiDGx4BnU+23owmw==
X-Received: by 2002:a05:6000:1a86:b0:3ec:dfe5:17e8 with SMTP id ffacd0b85a97d-4255d294d2emr4872007f8f.6.1759495858309;
        Fri, 03 Oct 2025 05:50:58 -0700 (PDT)
Received: from localhost.localdomain ([37.159.33.161])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e5c40983asm80598605e9.3.2025.10.03.05.50.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Oct 2025 05:50:57 -0700 (PDT)
From: Stefano Radaelli <stefano.radaelli21@gmail.com>
To: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Stefano Radaelli <stefano.radaelli21@gmail.com>,
	Nishanth Menon <nm@ti.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Tero Kristo <kristo@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v1 0/3] arm64: dts: ti: Refactor and alignment of VAR-SOM-AM62P
Date: Fri,  3 Oct 2025 14:50:26 +0200
Message-ID: <20251003125031.30539-1-stefano.radaelli21@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series introduces updates to the VAR-SOM-AM62P device tree:

 - Patch 1 refactors the IPC configuration to align with upstream changes
   by including the new common k3-am62p-ti-ipc-firmware.dtsi.
 - Patch 2 adds support for the WM8904 audio codec, enabling audio
   playback and capture.
 - Patch 3 adds support for the ADS7846 touchscreen controller available
   on the SOM.

These changes have been tested on the VAR-SOM-AM62P platform with
Symphony Carrier Board.

Stefano Radaelli (3):
  arm64: dts: ti: var-som-am62p: Refactor IPC configuration into common
    dtsi
  arm64: dts: ti: var-som-am62p: Add support for WM8904 audio codec
  arm64: dts: ti: var-som-am62p: Add support for ADS7846 touchscreen

 arch/arm64/boot/dts/ti/k3-am62p5-var-som.dtsi | 148 ++++++++++++------
 1 file changed, 98 insertions(+), 50 deletions(-)


base-commit: 58809f614e0e3f4e12b489bddf680bfeb31c0a20
-- 
2.47.3


