Return-Path: <linux-kernel+bounces-856901-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A392BE5618
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 22:25:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A6F6A1AA07D7
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 20:26:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A2652DECB2;
	Thu, 16 Oct 2025 20:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z/qiCvfE"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A1F92641C6
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 20:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760646345; cv=none; b=h2pXJNgrfXvvQoS9cZCIzsSLUvB2aDpoM7hxgPHH2A7uz9WUbSnCY1oW1+ZDkHIoLHTj0OYIbqPa8VERT7qIEN8XoVp5HQ485al2dA3ovlBtdH7XjFlP30myFgYQOeqNMUlM1rwfmlVf4aEiEvh0wlnLeLhjsh7Ad3dBUsyBFtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760646345; c=relaxed/simple;
	bh=xzMCfBofaf4XHkgbk8F4fMxam7uappNgmG0GSVXRwoY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kGjswnVUfbChlv5bo4LD7mySBDK9AxwHtXWkB8nMiPTfuL0vyKf9N97iEp4Jf9ybIbCYPvT6RkEoUUWZMnkCqI2V47Mh04cvB0CeARkZ1MneKiiSdDXqXxdMrhdSbAPgO6p2r9avhEKs9LtafY+dRlflP9VTTIxg+0VU8mB3938=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z/qiCvfE; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-290a3a4c7ecso12473255ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 13:25:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760646343; x=1761251143; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5sM2OUSBW/7DJRiuJ3co/xCNYS5XBVYrFpTjYZpSMgI=;
        b=Z/qiCvfESzFYw2aUKPefxj7bcpBv14QsgXpKcLUPIQ+zM6H3eq8UXMPqBVQGUZpIho
         4UZL8+ecSkwlALhAaH3It57NCB46Na0V3ZgPzHV3aluhDKrO9Ud4EntXZr8vbZTYUwva
         Ar+Jgj13OKLaag7hRXyHyNsxgOrmSOg1S20JOZ6NgTmJ6jqN70O6UFitb6rCf4rhdLE0
         ygMP8muMfMS7qKQrEb1owCGGrn9QFBpLC1oYLXjUKfHP8ZpltvtL9xBpnswTQ/HSL5zN
         Ww+Eo1pUzmQy6tltZzYiGmjgJZoMmW8l1moCPUdxJFBpkUJ1ZnDEGOoKJctt5CrP9NHS
         Bv9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760646343; x=1761251143;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5sM2OUSBW/7DJRiuJ3co/xCNYS5XBVYrFpTjYZpSMgI=;
        b=MElpWj8J/YaA3IDy+shhk32kxlShyppS0H9DD+550RQPoywhE/r2HHjVDdda8+WMbD
         rOukTPNSbmjjAy4QQVFgt1oRZKKM/rrXiFzmAhzt8RIkW2/GwA7C2mkgjrOemspu9usX
         lLRKB9LuxJl1Kt74Uz1YTv4meXfUsftiQPfJmUWU1rV0iIIkvi+adFHX5OY5iqmkLjjn
         xTtELef/YobFeBpQWTNURrFweljJ6T4M53T7fmDu83+wYJGIdqLFbUPR0TUI2VRGqEte
         bJp04JsEvAfct07R30zXWuoHMrmAqi4C9TFHZ5l20fVpqalpBdTT0yuMb7M7d9I9C0rH
         5ijw==
X-Forwarded-Encrypted: i=1; AJvYcCU5BUQ3i9rXaXbsxqK+2i21V6s9aK0DNIuzMmrwTqJBfxEWUbfOXiJvtmqUj2Lq2qIcnaFehq6XNKB24l8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcSYzAOpuELNbou6xVr95YMMx+5DbWHE5gwXl0nO5zoxptKrOV
	YGEqLC05iAbqjZPHlgAtShHLy44+DXLkFnASJcNrKTydXfsHeqUnjkp+INXZEQ==
X-Gm-Gg: ASbGnctFqyxiFXcoNFzTTSjeDBoRc1emI7yoNlSYnTjFAOz6JF6B8ikb6HQgyHvcqYh
	O9oEodU5j05rg5AtvPOSjTc2epbDVKznB/Jh5ejA9pYk3Qympq7AbZLWYO0jpfTMgLK7GYtOGQ2
	5g5/RHt/2fhuK4uz6fA1OPtOzTlh+959MwsM8is6NooaYJcvdVsHI5xNtn/IYdgRuGlZJaBxTG4
	YslvCSJt5MZRH89qKO/5CDNtnvPqrY0InzRfUBN3cZzQrrAhNMaPfeuhA8U5G7Y5o5x833LgY9K
	HUuapLzMu26DCr5E56jIvtr8derVFvt824RrbK7YkfqATQPMo6OBE1HzkoJknlFDsxI/VHidn8o
	MxPtfGmEdb6PIBV8GawHdpBq2lrGb77OX1Or3Z7qo8cthQI7nDdP0B5OCOz1DjwZItEZdzwlIMy
	hY+buIR5+CI/hU8S86m3ijMQ==
X-Google-Smtp-Source: AGHT+IGs54Upiel/Ao5NcK/hfJnpT2pOUEtODPp/RACbAL82uRfTJvEpomnmEP81ZtMTAH9e6PZGeg==
X-Received: by 2002:a17:902:fc44:b0:26d:58d6:3fb2 with SMTP id d9443c01a7336-290c9c89697mr14011435ad.12.1760646343364;
        Thu, 16 Oct 2025 13:25:43 -0700 (PDT)
Received: from iku.. ([2401:4900:1c07:c7d3:a396:54ac:a48f:c314])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29099af9131sm39577735ad.103.2025.10.16.13.25.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 13:25:42 -0700 (PDT)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: linux-renesas-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Prabhakar <prabhakar.csengg@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 0/5] Enable Ethernet support for RZ/T2H and RZ/N2H SoCs
Date: Thu, 16 Oct 2025 21:21:24 +0100
Message-ID: <20251016202129.157614-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
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
This series of patches adds support for Ethernet on the RZ/T2H (R9A09G077)
and RZ/N2H (R9A09G087) SoCs. It includes the addition of the MII Converter
(ETHSS) node, GMAC nodes, and enables Ethernet support in the
RZ/T2H-N2H-EVK board DTS.

Cheers,
Prabhakar

Lad Prabhakar (5):
  arm64: dts: renesas: r9a09g077: Add ETHSS node
  arm64: dts: renesas: r9a09g087: Add ETHSS node
  arm64: dts: renesas: r9a09g077: Add GMAC nodes
  arm64: dts: renesas: r9a09g087: Add GMAC nodes
  arm64: dts: renesas: rzt2h-n2h-evk: Enable Ethernet support

 arch/arm64/boot/dts/renesas/r9a09g077.dtsi    | 482 +++++++++++++++++
 .../dts/renesas/r9a09g077m44-rzt2h-evk.dts    |  70 +++
 arch/arm64/boot/dts/renesas/r9a09g087.dtsi    | 485 ++++++++++++++++++
 .../dts/renesas/r9a09g087m44-rzn2h-evk.dts    |  79 +++
 .../dts/renesas/rzt2h-n2h-evk-common.dtsi     |  94 ++++
 5 files changed, 1210 insertions(+)

-- 
2.43.0


