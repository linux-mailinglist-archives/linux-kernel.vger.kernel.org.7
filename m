Return-Path: <linux-kernel+bounces-892935-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CB83C4629F
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 12:14:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2044D1890738
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 11:13:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F465306B11;
	Mon, 10 Nov 2025 11:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="c4ieaw+5"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E279221542;
	Mon, 10 Nov 2025 11:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762773191; cv=none; b=W3ZN5BI5osKkXZOrODtFr0Dn3cOayaOne8Ssx81MHy0rKy3W+KwQDJliRF7+Vdo6yuDF15opr4U4deqnfnBttdo1w9oFTfJSpeiX7OHBb9woSCgPvnS9cpHMjMueakj5NNrcmvCZiNaBOFCGcJ3O2D0zI97ZdF1l3IC3BKLaIxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762773191; c=relaxed/simple;
	bh=9RqVLI2u1/PoEpSnHthOb30jaJC7RjCNqQ/ZIHq7IC0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mfyHZM0xvJAxdqor4Qyv/c0g3wnIvNwTybndxs3KmeNHX/fQUQAUMvSjeam+lXYdmilpGU022zUKmCuy1IOFgq35U0hPic8HUQjHHuTfTYmBtiXIC+mK578DZV3nkGpUPCx/6KjlDudJ5TLGfISRD0anBANn7os3Po9WLC730fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=c4ieaw+5; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1762773179; x=1763377979; i=w_armin@gmx.de;
	bh=5QXbf+tdtDVaJS6E+/9MpC/YXVCCK4BaK4+AIi5tAh4=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:
	 MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=c4ieaw+55KRs8/xVvvyk2RLtzuIJGa5Cw6hmS8LDJ/2M6ZCmnmNDWGb+lehGACDG
	 R62bwj/bfIBlQQO9l65UU3eGnKf1fab7px6BhOTt0P1Kx4M5v4YtV0SiXGz1NUBzr
	 hJ+lJOV01M+fsg27toX/v3MGGhkfEdXANM+X4ZvGjjhcTbsGJPnOThIscUGMBPY7Z
	 dtPsXBs6dLD9HuGMdbA3ECp8wcoE3VNEhsix4dhtJJ8RXjap6IiNv4qZDjRV4kqbc
	 UDJz9uCJAEN1d7rqlxtbfbhEOfPqYlakKyLDO07SzTosjsSy5gzDZeKUOPOCHku98
	 Es+NJ2ZODsvm4fRK1w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-inspiron.dip.tu-dresden.de ([141.76.8.184]) by mail.gmx.net
 (mrgmx005 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1MLiCo-1vZwiI3wQa-00X8qY; Mon, 10 Nov 2025 12:12:59 +0100
From: Armin Wolf <W_Armin@gmx.de>
To: hansg@kernel.org,
	ilpo.jarvinen@linux.intel.com
Cc: platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lkml@antheas.dev
Subject: [PATCH 0/2] platform/x86: msi-wmi-platform: Fix autoloading
Date: Mon, 10 Nov 2025 12:12:51 +0100
Message-Id: <20251110111253.16204-1-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ALm1FCYM7hNueU6MQjAistYXMCJTEXLPuioXTDpZZvkmj/3n09K
 zt5E2LsIUG1ZI8P/eSGxZYZW+LBgNQkH51ZLvmry6wWL+aQCFx+irliVULGb5J3Yx5piPkx
 WeyieMBI5tzDg2KaCxTGFYZ3wjaJncLHmRStP35gXB99fadWWn+rAZ5tJJkwOgPIk2OrzKI
 Gkw5Hr5B/GuNjQV5SB8/Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:yAdTi8YI2ZE=;GyHp+gdSvbvWMfgsjZl7mRviXGe
 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
 vOnPcdEW7eb09hYJ9pM3Y2YNBFcqYBzmUwtedq

As already noted by Antheas Kapenekakis back in May, the
msi-wmi-platform driver fails to automatically load on MSI Claw
devices. Back then i suspected an issue with the device firmware,
however i just found out that i made a silly mistake when specifying
the GUID string of the driver, preventing the WMI driver core from
matching it to its WMI device.
Additionally i noticed that said GUID was copied from the Windows
driver samples, meaning that it might be shared across different
vendors. Because of this we have to prevent this driver from loading
on non-MSI devices.

Compile-tested only.

Armin Wolf (2):
  platform/x86: msi-wmi-platform: Only load on MSI devices
  platform/x86: msi-wmi-platform: Fix typo in WMI GUID

 .../wmi/driver-development-guide.rst          |  1 +
 drivers/platform/x86/Kconfig                  |  1 +
 drivers/platform/x86/msi-wmi-platform.c       | 43 ++++++++++++++++++-
 3 files changed, 43 insertions(+), 2 deletions(-)

=2D-=20
2.39.5


