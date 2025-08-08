Return-Path: <linux-kernel+bounces-760560-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 59A0DB1ECDD
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 18:12:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 59A6D1C24BE8
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 16:13:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF91328689C;
	Fri,  8 Aug 2025 16:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="uz7uoBRR"
Received: from relay.smtp-ext.broadcom.com (relay.smtp-ext.broadcom.com [192.19.166.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD0D627BF84;
	Fri,  8 Aug 2025 16:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.19.166.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754669561; cv=none; b=V5wl7BERLKQ0rUJr1aqIey8H8Owzqm5PN7COOmTopU1jEWwVsiYnNcdnZWNeo+UkKY+6Gg1P1JfXNo2rdAXsIAYLW2MzgB/03KSQ9S5CZ5BxjKeAD/PHyWnmvjiZFjHnzHwhxJexeBiEciEXjdRpiwhhCyTAHRfRmyqZSNp5M/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754669561; c=relaxed/simple;
	bh=rC4NJQZYKBomAUkrkpro9lZoaI84/bdLQnD6f0Tc5Vk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GaOjdnpmVaCoUOpw7riAQyWH6JNfY0O6LHuvYZiG9bMAGOuyF/C3WisJpnSwMO9GA6V20WMaFFyKQVxx2f/0E6M4LcmGewFkYgoDiEvUvsR3dPGQBkAJrZDopTgUQ+GwFiVNFx1ZtqCRjWaQ6/K6BOhqFJDaTAcZ/TuDOxUYFrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=uz7uoBRR; arc=none smtp.client-ip=192.19.166.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: from mail-lvn-it-01.broadcom.com (mail-lvn-it-01.lvn.broadcom.net [10.36.132.253])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id 05633C0008FB;
	Fri,  8 Aug 2025 09:04:22 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com 05633C0008FB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1754669062;
	bh=rC4NJQZYKBomAUkrkpro9lZoaI84/bdLQnD6f0Tc5Vk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uz7uoBRR44bYIJwTlPGgJd4aCiXrLUZZB7x3Iv5JiK3McTeFiSuwInAZwTeSkN+MY
	 hKEWNlTH5OFuUE9EMseWdxXE85PqfRlHuEnM/Es0/MJ2NLb+Px9mao+EogyhMunGxZ
	 3vGCAUOAvBadbeRpsJEQER7yzIPskyh9ZEm9hqKU=
Received: from fainelli-desktop.igp.broadcom.net (fainelli-desktop.dhcp.broadcom.net [10.67.48.245])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail-lvn-it-01.broadcom.com (Postfix) with ESMTPSA id C598F1800051E;
	Fri,  8 Aug 2025 09:04:21 -0700 (PDT)
From: Florian Fainelli <florian.fainelli@broadcom.com>
To: bcm-kernel-feedback-list@broadcom.com,
	Taishi Shimizu <s.taishi14142@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Hauke Mehrtens <hauke@hauke-m.de>,
	Rafal Milecki <zajec5@gmail.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Linus Walleij <linus.walleij@linaro.org>,
	Stefan Wahren <wahrenst@gmx.net>
Subject: Re: [PATCH v2 2/2] ARM: dts: BCM5301X: Add support for Buffalo WXR-1750DHP
Date: Fri,  8 Aug 2025 09:04:21 -0700
Message-ID: <20250808160421.40480-1-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250713071826.726682-3-s.taishi14142@gmail.com>
References: <20250713071826.726682-1-s.taishi14142@gmail.com> <20250713071826.726682-3-s.taishi14142@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Florian Fainelli <f.fainelli@gmail.com>

On Sun, 13 Jul 2025 16:18:25 +0900, Taishi Shimizu <s.taishi14142@gmail.com> wrote:
> Add initial device tree support for the Buffalo WXR-1750DHP, a consumer Wi-Fi
> router based on the Broadcom BCM4708A0 SoC.
> 
> Hardware specifications:
> * Processor: Broadcom BCM4708A0 dual-core @ 800 MHz
> * RAM: DDR3 256 MB
> * Ethernet Switch: Broadcom BCM53011 integrated via SRAB
> * NAND Flash: 128 MB (8-bit ECC)
> * SPI Flash: None
> * Ports: 4 LAN Ports, 1 WAN Port
> * USB: 1x USB 3.0 Type-A port
> 
> Signed-off-by: Taishi Shimizu <s.taishi14142@gmail.com>
> ---

Applied to https://github.com/Broadcom/stblinux/commits/devicetree/next, thanks!
--
Florian

