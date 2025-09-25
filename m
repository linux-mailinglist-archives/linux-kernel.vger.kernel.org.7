Return-Path: <linux-kernel+bounces-833015-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 924CDBA0FBE
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 20:17:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C7915188F899
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 18:17:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 307B5313551;
	Thu, 25 Sep 2025 18:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=raptorengineering.com header.i=@raptorengineering.com header.b="LXgGIbr/"
Received: from raptorengineering.com (mail.raptorengineering.com [23.155.224.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 471371DBB13;
	Thu, 25 Sep 2025 18:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.155.224.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758824242; cv=none; b=W3a58pbuX3q64sh7Lz3NBhXvC3t2WcyeJcb1nEoXJ0RaRjFQajzezQ8pSPLjV1NqgNoeg4ZRPhoa1GawwrFiojC83GI67RR3D+IEtEC4SIuQuMFTlSlkZlEGQP3zf+P9o9WOWPc4DI81DvWwvyd+qXfys1Z28q064qF9kpInsxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758824242; c=relaxed/simple;
	bh=KJlAdLSMv/O1fTBRiZESYf40wSdiRm8AARZFujKMh/Y=;
	h=Date:From:To:Cc:Message-ID:Subject:MIME-Version:Content-Type; b=VLvYpjbro4QGqUy3kKBJReynYgHExGCg1Xbt1KG+L2LAuJX61LedIoO4p7atj2fdfe9GEiI8tKlVv3DFNKDPEiJgBYRdfF9XkXviID9SAZIcxRz2IB5YKJX7za781FSAJgt4JxfJQpSDJtPJ86lVyQSx1M34LbQEfGX7yi7y0Pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=raptorengineering.com; spf=pass smtp.mailfrom=raptorengineering.com; dkim=pass (1024-bit key) header.d=raptorengineering.com header.i=@raptorengineering.com header.b=LXgGIbr/; arc=none smtp.client-ip=23.155.224.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=raptorengineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=raptorengineering.com
Received: from localhost (localhost [127.0.0.1])
	by mail.rptsys.com (Postfix) with ESMTP id 47653828840F;
	Thu, 25 Sep 2025 13:17:12 -0500 (CDT)
Received: from mail.rptsys.com ([127.0.0.1])
	by localhost (vali.starlink.edu [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id ZN60ecC7vRAx; Thu, 25 Sep 2025 13:17:10 -0500 (CDT)
Received: from localhost (localhost [127.0.0.1])
	by mail.rptsys.com (Postfix) with ESMTP id BA4858288415;
	Thu, 25 Sep 2025 13:17:10 -0500 (CDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.rptsys.com BA4858288415
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=raptorengineering.com; s=B8E824E6-0BE2-11E6-931D-288C65937AAD;
	t=1758824230; bh=v9sDnheTOre9eFbnepovDVQnFuMaiwclq+difl4qEO8=;
	h=Date:From:To:Message-ID:MIME-Version;
	b=LXgGIbr/mGnA0E8h+n2ziHCO9yTruGQ9+oRXrytL8VF4xODuqQLyad4bh7cd/5tEW
	 BqzDwMX0YnmaMaNabbGZJm+4NcgRY5oE3KcHQHKb8Rux/Hb+Xqn7VWHSTFqJtbHRJl
	 ie5+YOlirkWaEKJ0XAER+1j7HtrGPs1Tyc4nM1Ec=
X-Virus-Scanned: amavisd-new at rptsys.com
Received: from mail.rptsys.com ([127.0.0.1])
	by localhost (vali.starlink.edu [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id KirvynyNggoS; Thu, 25 Sep 2025 13:17:10 -0500 (CDT)
Received: from vali.starlink.edu (localhost [127.0.0.1])
	by mail.rptsys.com (Postfix) with ESMTP id 8AC9A828840F;
	Thu, 25 Sep 2025 13:17:10 -0500 (CDT)
Date: Thu, 25 Sep 2025 13:17:10 -0500 (CDT)
From: Timothy Pearson <tpearson@raptorengineering.com>
To: devicetree <devicetree@vger.kernel.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>, 
	Rob Herring <robh+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Lee Jones <lee@kernel.org>, 
	Georgy Yakovlev <Georgy.Yakovlev@sony.com>
Cc: Shawn Anastasio <sanastasio@raptorengineering.com>
Message-ID: <956178193.1748561.1758824230379.JavaMail.zimbra@raptorengineeringinc.com>
Subject: [PATCH v3 0/4] Add drivers for Sony Cronos control CPLD
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mailer: Zimbra 8.5.0_GA_3042 (ZimbraWebClient - GC139 (Linux)/8.5.0_GA_3042)
Thread-Index: uDrGoQaoV9tsMxvmUg8S0vfyMMdpaw==
Thread-Topic: Add drivers for Sony Cronos control CPLD

Hello all,

This series adds a driver for the multi-function CPLD found on the Sony
Interactive Entertainment Cronos x86 server platform. It provides a
watchdog timer and an LED controller, both of which will depend on the
MFD parent driver implemented in this series. Device tree bindings are
also included.

Thanks,

Changes in v3:
  - Address reviewer concerns
  - Add LED and watchdog drivers to series

Shawn Anastasio (1):
  dt-bindings: mfd: Add sony,cronos-cpld

Timothy Pearson (1):
  mfd: sie-cronos-cpld: Add driver for Sony Cronos CPLD

 .../bindings/mfd/sony,cronos-cpld.yaml        |  92 +++
 MAINTAINERS                                   |   7 +
 drivers/mfd/Kconfig                           |  11 +
 drivers/mfd/Makefile                          |   1 +
 drivers/mfd/sony-cronos-cpld.c                | 591 ++++++++++++++++++
 include/linux/mfd/sony/cronos/core.h          |  17 +
 include/linux/mfd/sony/cronos/registers.h     |  59 ++
 7 files changed, 778 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/sony,cronos-cpld.yaml
 create mode 100644 drivers/mfd/sony-cronos-cpld.c
 create mode 100644 include/linux/mfd/sony/cronos/core.h
 create mode 100644 include/linux/mfd/sony/cronos/registers.h

--
2.30.2

