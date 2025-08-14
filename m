Return-Path: <linux-kernel+bounces-768695-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77706B26441
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 13:29:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D840A583C31
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 11:28:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 119F92EAB6E;
	Thu, 14 Aug 2025 11:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cab.de header.i=@cab.de header.b="CTP+8Il/"
Received: from mx07-007fc201.pphosted.com (mx07-007fc201.pphosted.com [185.132.181.212])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5991223A9BB;
	Thu, 14 Aug 2025 11:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.181.212
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755170908; cv=none; b=JyVbJV+XC0SI4RZAmjIyfodI/H4VOFr5ROXI38+21+xqyyQwgJJ6RW6OB/XFGQnW8an44JsdrSIYET3nv4N+jhfiVJckbbgqYy7x4k4XeuvUZOoUql/xJ2p6NrNJhPFPuZbCPMfwQbRTlf7sq7t+qkXlDyABSxsCF0WPuUyM/OM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755170908; c=relaxed/simple;
	bh=9B12Ti9Po4ogZWXUi+sGDetOlB576SJO33a4l0EoeWI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kUNhgEAzLrNnI8HKXXrZLj576TvtbNhhbZGGFpYdkma+qS1q7jCUDuoDJX68TYhtjamlZOe3lzdQilWZob+3UepBH8Y/wPR0kjYJz2OVJycycy/vv/96PtVscBW+v674zutBTctrJXPYIcbVmMDUB3/DtkAtEj/xej+CjhTvJ+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cab.de; spf=pass smtp.mailfrom=cab.de; dkim=pass (2048-bit key) header.d=cab.de header.i=@cab.de header.b=CTP+8Il/; arc=none smtp.client-ip=185.132.181.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cab.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cab.de
Received: from pps.filterd (m0456228.ppops.net [127.0.0.1])
	by mx07-007fc201.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 57EBGRg12316998;
	Thu, 14 Aug 2025 13:16:27 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cab.de; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp-2025; bh=xPYi6m0sROnpJ1Gr+1GgEeoj
	VXhDXVBOj7W0bO5I6DI=; b=CTP+8Il/3sNCurrgTI68bkxLXN1Zc2Osp+SsCwda
	J9GK9joabyNHXt4hNQb+2lXdV8JT43IhK6W+8NJrRuxOXhGyT/96bRsIXxV/U7yd
	v7lcz1inu3qBLPABzo0g1qGQybluY63aNOH52NNolfPQdtpWWoPuq8wrVQ1ln6iI
	IZjex4N3FiPTMLjot/S7j9VFUXfeTonn++thyn0og8pcn/I/cDon1nZrPgCg/Lel
	xwaSxRWp4zIX6S5OjpiMcA4qtmaUUZt+56M+me30w3+AblUZp6dzzQRyLvc3LXHs
	n+DYA09/CZqg3kMlH94+4U5w3ivajm/WRNW+ZxSTjaPfzQ==
Received: from adranos.cab.de (adranos.cab.de [46.232.229.107])
	by mx07-007fc201.pphosted.com (PPS) with ESMTPS id 48fq5w10wh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 Aug 2025 13:16:27 +0200 (MEST)
Received: from KAN23-025.cab.de (10.100.0.18) by Adranos.cab.de (10.10.1.54)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.24; Thu, 14 Aug
 2025 13:16:41 +0200
From: Markus Heidelberg <m.heidelberg@cab.de>
To: Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>,
        <devicetree@vger.kernel.org>
CC: Markus Heidelberg <m.heidelberg@cab.de>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Christian Eggers <ceggers@arri.de>,
        Alexander Sverdlin
	<alexander.sverdlin@gmail.com>,
        Jiri Prchal <jiri.prchal@aksignal.cz>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/3] eeprom: at25: support Cypress FRAMs without device ID
Date: Thu, 14 Aug 2025 13:15:29 +0200
Message-ID: <20250814111546.617131-1-m.heidelberg@cab.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: Adranos.cab.de (10.10.1.54) To Adranos.cab.de (10.10.1.54)
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE0MDA5MyBTYWx0ZWRfX/tg5nTgdNE9u
 TQWQtT6YD9q96RpXr1DcNezl88ETQv0j9aFJvYBvjIQgCQ1Y24pU1AFhgpfUO6vo5AnnLd0ZbYF
 jJYVCJKlNeKQEMU/FwKwvZ7EOGqx0FNq2hAQ7qi37E6sa00EjBPhp6hkkQN15GoWh+4iONlr5zZ
 XpINA04H7TQY2yenCR38evTXlAAB4fgeuK8khrpLHmIrC4duW7eMYqRBBliEKhpAEWt4f88vEIJ
 VOE7HVwW1ijRfPqUF9IjAfFXcqqzVsbzN33qRvZzm761robDHA0tIap5DYFAhrJSe36fopQqKaK
 0P4XL2NpBx4HvwPdovFyuZm8N1AMD3SneQnCQH/Ob3iTrZTdqD3trmMNeaSNSE=
X-Proofpoint-ORIG-GUID: woLIckiHSCs0Ekxu8O5aVex4S-uzybej
X-Authority-Analysis: v=2.4 cv=eMkTjGp1 c=1 sm=1 tr=0 ts=689dc58b cx=c_pps
 a=LmW7qmVeM6tFdl5svFU9Cg==:117 a=LmW7qmVeM6tFdl5svFU9Cg==:17
 a=K2GD-7p5giEA:10 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=OwM_m4cHvPE-cwAFzhwA:9
X-Proofpoint-GUID: woLIckiHSCs0Ekxu8O5aVex4S-uzybej

Hello,

currently supported FRAMs use compatible="cypress,fm25","atmel,at25" in
Devicetree, the memory size is read from its device ID.
For FRAMs without device ID this is not possible, so with these patches
the "size" property can be set manually as it is done for EEPROMs. In
that case the device ID is not read anymore.

This patch series is basically the same as the one marked as RFC four
months ago:

  https://lore.kernel.org/all/20250401133148.38330-1-m.heidelberg@cab.de/

Based on v6.17-rc1 now and extended by a comment to the at25 binding.

Markus Heidelberg (3):
  dt-bindings: eeprom: at25: use "size" for FRAMs without device ID
  eeprom: at25: support Cypress FRAMs without device ID
  eeprom: at25: make FRAM device ID error message more precise

 .../devicetree/bindings/eeprom/at25.yaml      |  1 +
 drivers/misc/eeprom/at25.c                    | 67 ++++++++++---------
 2 files changed, 37 insertions(+), 31 deletions(-)


base-commit: 8f5ae30d69d7543eee0d70083daf4de8fe15d585
-- 
2.43.0


