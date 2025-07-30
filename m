Return-Path: <linux-kernel+bounces-751114-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AEA08B16567
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 19:23:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 962B15A81F0
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 17:22:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E8DB2E0419;
	Wed, 30 Jul 2025 17:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="xdCF1R+t"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AB952DEA94;
	Wed, 30 Jul 2025 17:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753896191; cv=none; b=qBy/bDJMtVNPwAB4qI3B5wpFeg0t3OtGwOvmkeyZQGNL+mx4sTZAG6Xw9azPeGlWCGK0BFM6RCnlE7CQ8+Uw7vYPNbmyPKFtkxx0B/Ew4hFtzFKisdL7DxP4gA+CO3QnONyQiYoLCYUFHxH2hRaby1JkwdaH3b1VP5PSAZjceBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753896191; c=relaxed/simple;
	bh=h705O3MXZ7CoRpdRU1wDJ74D+TD6qxGHpUvX1+z/du4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZfeoU0cEljA3dHlmznWWu+apc6MuM174hnn9dxsiS3Av5Rt6pSLr2C02C5w56IeUHbcxcdk+mZmXz6GW7ea35YupOYiGu02yU3tYZFpWwJIbWlmRNCe4dQNpu0u9HfVTZkcLM9ftXZGJ3t+b2MijxCQ6hHptON7wjZIOBnUAWis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=xdCF1R+t; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:
	Subject:Cc:To:From:Reply-To:Content-Type:In-Reply-To:References;
	bh=fjxV2fdbeg/h7RCtTN73y+CF0z8gq4C7j/9uDu2WKKY=; b=xdCF1R+tlH6pEoAULbsqGKzjMv
	uf+AKAISFfsTTXBRT+ju1EBnF/rwOcDG3bhNuwnJr9v2F1QxljxCPM0Z8C2MWTTW/NNvA9dz5a4Rt
	wW3H+UtPYeeYIkpeq6MeuOLibOstLxSyHiHwQ1zyBe+w5xt08NrF0DVX+ELYngkLMv6fb4X/d9FlY
	0xogGvddwY4sP4Vjoha7rY/B2tcxhNwQLCeIL626RIbWxTjFSSZs0gO+KogfhfC3/GQnxlhHc6saM
	2SoPZ20CAcxhy8Ver+aEIkOh9xTKDi5uxSf9ShZ+VUkLWFZVSoOVfmv4qMrEZTq1Qj2fo5U392FOM
	3LSNH+eA==;
Received: from [194.95.143.137] (helo=phil.dip.tu-dresden.de)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1uhAWC-0001Xq-EF; Wed, 30 Jul 2025 19:23:08 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: lee@kernel.org,
	srini@kernel.org
Cc: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	heiko@sntech.de,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] qnap-mcu: add nvmem subdevice to read the eeprom
Date: Wed, 30 Jul 2025 19:22:46 +0200
Message-ID: <20250730172248.1875122-1-heiko@sntech.de>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The qnap-mcu is firmware running on a Weltrend WT61P803 MCU and there is
an eeprom connected to it, that can be read via the serial interface.

The eeprom is somewhat important, as it contains for example the
assigned mac address for the rk3568's gmac interface on TSx33 devices.

So add a nvmem driver for it and hook it into the mfd.

Heiko Stuebner (2):
  dt-bindings: mfd: qnap,ts433-mcu: allow nvmem-layout child node
  nvmem: add driver for the eeprom in qnap-mcu controllers

 .../bindings/mfd/qnap,ts433-mcu.yaml          |   3 +
 drivers/mfd/qnap-mcu.c                        |   1 +
 drivers/nvmem/Kconfig                         |   9 ++
 drivers/nvmem/Makefile                        |   2 +
 drivers/nvmem/qnap-mcu-eeprom.c               | 110 ++++++++++++++++++
 5 files changed, 125 insertions(+)
 create mode 100644 drivers/nvmem/qnap-mcu-eeprom.c

-- 
2.47.2


