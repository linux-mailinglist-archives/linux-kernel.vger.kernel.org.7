Return-Path: <linux-kernel+bounces-770676-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B6A6B27DC0
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 12:02:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5779A1BC56EE
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 10:00:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 441182FF652;
	Fri, 15 Aug 2025 09:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cab.de header.i=@cab.de header.b="mDlz89XJ"
Received: from mx08-007fc201.pphosted.com (mx08-007fc201.pphosted.com [91.207.212.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABD092FCC16;
	Fri, 15 Aug 2025 09:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755251956; cv=none; b=KWu0tx2+TeO0Lh4h5XbS6343K/sE/EIV6yPZrnR8KRQP9XNnRLuJH40d5HqkhZxQmR8fZEo+jLrfln/mkucqL4yHQsocCcxtmgsue+lofflLv5apLR0Us4nwp5u3ubqyRlJlQjeXNynQDlW4WBNoqyVEfGNSR1SuPjiWozFNFDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755251956; c=relaxed/simple;
	bh=C/eAsnQim+cPhpZ60TLsY5VOyKIxJMLsf0ERiOi78C8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=XcRkHHET6RHTdn+nlWFXr5N5+/OASiejgsVaG+a1re0KPe2IVxgAKmDUDhD72EuozTbdVQPBqkJ/0jpQlVLGZRsJQp9oF4LjbRLvvM6sBq+YVyAfhUmb+wBuMJ/uSajYU/9uoy3jnnG5hJctbUyYZJaTa425zCt5v6a+1+pg01w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cab.de; spf=pass smtp.mailfrom=cab.de; dkim=pass (2048-bit key) header.d=cab.de header.i=@cab.de header.b=mDlz89XJ; arc=none smtp.client-ip=91.207.212.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cab.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cab.de
Received: from pps.filterd (m0456229.ppops.net [127.0.0.1])
	by mx08-007fc201.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 57F9wt84265753;
	Fri, 15 Aug 2025 11:58:55 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cab.de; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp-2025; bh=DfTq9JGGqIeWegpF934nhDAD
	EXEqp1Xkj9iyZqb8LFs=; b=mDlz89XJCssAuIh+2AsRH9WCozuoq+9Jt+UkcNP3
	PZPxDrpqCu0AjnuP9NGdhcahP4QG9uraFESbyfcGpA2Sv9HvotyEp3VhePQx0G5d
	DHLHRwhwxq6IABoYgpGffZ82cL9rFT4+YQzo8lflTz8nd96+LguMUbjKJiCHEZzv
	/i8fuuKjcYV8x9MOxTxjrGHIX+BDzHRvtsEbz2GoSMo6b7drC0P4WbaYCgOsMTy7
	b4dzkLQOlPZIcYdYXw49vVbrJotEIxbhxftUvC4pnbvBM8b0vVFCHR2DdFmp8BSL
	H3FEnrZaeuCVFuBCdfgMWL+V/DgzVDpU009z8qI79Z8FnA==
Received: from adranos.cab.de (adranos.cab.de [46.232.229.107])
	by mx08-007fc201.pphosted.com (PPS) with ESMTPS id 48fqcpsbfb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 Aug 2025 11:58:55 +0200 (MEST)
Received: from KAN23-025.cab.de (10.10.3.180) by Adranos.cab.de (10.10.1.54)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.36; Fri, 15 Aug
 2025 11:59:11 +0200
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
Subject: [PATCH v2 0/3] eeprom: at25: support Cypress FRAMs without device ID
Date: Fri, 15 Aug 2025 11:58:35 +0200
Message-ID: <20250815095839.4219-1-m.heidelberg@cab.de>
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
X-Proofpoint-ORIG-GUID: uWCy04TrlsMY4Ar1CXUfoqjIlZW3iZn4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE1MDA4MCBTYWx0ZWRfX9UN+TUCUB4LO
 F2ihFxUjZ4V+DivIpm47Tbpp1qQjt9IC9/pDyjsxkHNhvCLPibq4Eep+f3QZtrxGkdP2fjxTvil
 6EHSTh/FvVedzF2UWDyxw0thRpx94aeSa/+QkHyJIaY/aFX5meZId5w9Tt7Krf6BqXZszEIt3rq
 AS/PlhEjSvN4Qsiq/6dm2UGebq6FLatLxEOkFi25/EjSaBYsxnop2Ce9rMgs50vhcO/Uy6S4nfl
 qvpSOtFVPu0+i99r2h6N9t84Mmty0EtXCxiR7g3wLWh2JoaIL1M+GJfcdZOfsZx9YVJC6NTeH24
 2jrMN9hrd5W82qud9k6q61SDlXG0+Sqlc9/7YGf3n+E3TcCTYK7OES55EQWflg=
X-Authority-Analysis: v=2.4 cv=bctrUPPB c=1 sm=1 tr=0 ts=689f04df cx=c_pps
 a=LmW7qmVeM6tFdl5svFU9Cg==:117 a=LmW7qmVeM6tFdl5svFU9Cg==:17
 a=kldc_9v1VKEA:10 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=OwM_m4cHvPE-cwAFzhwA:9
X-Proofpoint-GUID: uWCy04TrlsMY4Ar1CXUfoqjIlZW3iZn4

Hello,

patch changelog:

v2:
  - Commit message extended to explain the reason of the change in the
    binding (patch 1)
  - Example added to the binding (patch 1)
  - Reviewed-by added to commit message (patches 2+3)

=======

Currently supported FRAMs use compatible="cypress,fm25","atmel,at25" in
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

 .../devicetree/bindings/eeprom/at25.yaml      |  8 +++
 drivers/misc/eeprom/at25.c                    | 67 ++++++++++---------
 2 files changed, 44 insertions(+), 31 deletions(-)


base-commit: 8f5ae30d69d7543eee0d70083daf4de8fe15d585
-- 
2.43.0


