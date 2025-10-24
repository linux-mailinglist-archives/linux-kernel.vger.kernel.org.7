Return-Path: <linux-kernel+bounces-869188-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E4A3C073B7
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 18:15:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 56A171C2794A
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 16:16:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5F49270578;
	Fri, 24 Oct 2025 16:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="rIK2bPpt"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A640C1D514E
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 16:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761322526; cv=none; b=IEO95x9efFNbncwa/7Fkq+91XvmNA0GfwnP8o3SBBHdiebP4eicAtkuj4CNcC5gcnTblRB6UuIQuocMhbuc1crdg1Id7ibBU3coaqQWC8tTSsP4MhqlCDzENsrPkeqYX22IvMuvqykSPv6JETootVDKnnAnlUEyYnC58e7xLMyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761322526; c=relaxed/simple;
	bh=e9gZeMGN3pLQbfkAI6g+chfPTIRCv+JSr9r7OpEpjuk=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=L9HalRvgFl1QCdhrNoysk6/zLqG4pyejp+TfS8rpkXnYApdjA97ewp1EMiRHMUcslYWrdOyZcLPguUc4rgaMHlsLPAN5Qair6+PXxObMiXanYdoAMbQH27/w19CtLRWJkxufM+aeUoJGDRimRfKR+inIxiGOBgpj5aTJvOJ+fRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=rIK2bPpt; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1761322524; x=1792858524;
  h=from:subject:date:message-id:mime-version:
   content-transfer-encoding:to:cc;
  bh=e9gZeMGN3pLQbfkAI6g+chfPTIRCv+JSr9r7OpEpjuk=;
  b=rIK2bPptIlecVng0ALvH+Fs4E+ZbJTS0YKnamMpsKP4tHBoHdNbSFmlV
   xQfPK9/UxVLTBOJdyy6fk0M33Z7ptF+1DS1eOvOFrBC9d5LC97CTiJE1K
   46qLhWbqLq5OwHz9uKkoDLnFIef/W/lIMxNPYpNJn9pwnckTB5d0CAA1Z
   8MFS0LwatAbX9ZEShvdpkmj8koAKkyMz9PwX3nyAEbLMSmDH0cWPowvC1
   G9CT1qZmqw0ihTNgrtdF5cBP66M3vWs6dhzoM+vO13kZ4t5JpQ52/8saZ
   mgPMeWG3ON07mwOFWkIVGaLP4hPcIqQ7vePUHDL63lYMmjHyB+KG3Rue+
   A==;
X-CSE-ConnectionGUID: OZLbVyjtRe6JiCTkoaquJg==
X-CSE-MsgGUID: tWkYl6LlQYecV7NCWXBUjA==
X-IronPort-AV: E=Sophos;i="6.19,252,1754982000"; 
   d="scan'208";a="48227183"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 24 Oct 2025 09:15:24 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Fri, 24 Oct 2025 09:15:04 -0700
Received: from [127.0.0.1] (10.10.85.11) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Fri, 24 Oct 2025 09:15:01 -0700
From: Ludovic Desroches <ludovic.desroches@microchip.com>
Subject: [PATCH 0/2] drm/atmel-hlcdc: fix memory bugs
Date: Fri, 24 Oct 2025 18:14:51 +0200
Message-ID: <20251024-lcd_fixes_mainlining-v1-0-79b615130dc3@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPul+2gC/x3LWwqAIBBA0a3EfCeo2YO2EiGSkw3UFAoRhHtP+
 jxw7wsJI2GCsXoh4k2JTi5QdQXL5jigIF8MWupWSW3Evni70oPJHo54JyYOwindGD8o13cDlPW
 K+DflnOacP62Vzw1mAAAA
X-Change-ID: 20251024-lcd_fixes_mainlining-a1234d81a768
To: Manikandan Muralidharan <manikandan.m@microchip.com>, "Dharma
 Balasubiramani" <dharma.b@microchip.com>, Maarten Lankhorst
	<maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>, Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Claudiu Beznea
	<claudiu.beznea@tuxon.dev>
CC: <dri-devel@lists.freedesktop.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, Ludovic Desroches
	<ludovic.desroches@microchip.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=783;
 i=ludovic.desroches@microchip.com; h=from:subject:message-id;
 bh=e9gZeMGN3pLQbfkAI6g+chfPTIRCv+JSr9r7OpEpjuk=;
 b=owEBbQKS/ZANAwAKAT455hP3e2QtAcsmYgBo+6YFICrXySxOd9teoHGeB2+HmsYggPPyWFg9a
 3Nkv1Nq3VaJAjMEAAEKAB0WIQQAMEvJiWmsW41tNU0+OeYT93tkLQUCaPumBQAKCRA+OeYT93tk
 LaL3D/kBHNZN3S0vO14Kj0FTERJ2sgFYLuy2xE2tfj6kKNq54iFnwGmqovofI4usMq7ZVoVuoaU
 /HAwVhYZiV6xUAfoLkhK7dKcNMFsLNk26H8I2h++xCthy2sXyfKKadipCX/00HjfUuuoseDO7Gi
 facNrCrQjES3HjO2c9dtEO+nAjGr1/eMQk+YD4PV4DYvrxKJnsoup6bqQWl1l6iPqZeetdLeutu
 8wG+bi5J7ZaFnLyC228aoLTQcID0oYDaRX2wcWXGN5baSHamPJY/pmr5A9QiB3ZwBRC+CJO4+3D
 vpP8SmIytiFIaMtyHp2+1a/JG3toz4zLIrqNwfH8QRkj8/Bep6UcrqxpH/Bcot+snlJnUOCJZVN
 Dd4GfOrkFXWODaQISEO5lC1VocEQ+gztwcAm5pjrVHPb2dOVGUakhcy/U90G04P12FWqwZFVPmR
 CgOuvEmzSulQxAqveUC6StIcGk4eNJah38C5L7suk4Mde+6KyeTveUVNR5I7hby0mEdbXyWx8ij
 4DuuktM/LUuDIRvYQfM5MOy7JVj0H97GUIEqF2eHGa3sQHtynOEQDXgv1+7tmefa6iDa8oPwEzO
 CFTBoMbTMbfcNFcFTYl/PMC7wXWrh5sfkRmHuBLnL0cxq0BH2JwTTDylY/8MbztCrcPvu8UqGCb
 qZsNnyKmfrt/4Xg==
X-Developer-Key: i=ludovic.desroches@microchip.com; a=openpgp;
 fpr=665BAA7297BE089A28B77696E332995F09DCC11A

These two patches fix a memory leak and a use after free bugs.

The memory leak bug had been reported by several users. There were some
attempts to fix it in the past, but the resolutions proposed caused
other breakages.

Signed-off-by: Ludovic Desroches <ludovic.desroches@microchip.com>
---
Ludovic Desroches (2):
      drm/atmel-hlcdc: fix memory leak from the atomic_destroy_state callback
      drm/atmel-hlcdc: fix use-after-free of drm_crtc_commit after release

 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)
---
base-commit: 72fb0170ef1f45addf726319c52a0562b6913707
change-id: 20251024-lcd_fixes_mainlining-a1234d81a768

Best regards,
-- 
Ludovic Desroches <ludovic.desroches@microchip.com>


