Return-Path: <linux-kernel+bounces-770879-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7501DB27FE1
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 14:18:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 863251CE3990
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 12:18:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9D8A30498A;
	Fri, 15 Aug 2025 12:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wp.pl header.i=@wp.pl header.b="TFIfiBUf"
Received: from mx4.wp.pl (mx4.wp.pl [212.77.101.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BAED304964
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 12:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.77.101.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755260207; cv=none; b=AGhIgizSlo0Arnx9A18ckgZ1ntmdMGXJKVtFiz8amYNbU+v/e9GeJoGoZJPJqnppeR1/sMkOWCWRoK8BNIBkZiANnFzQCBrOxAZ1PypZvmocWmanTc8C6I5b7G5u37PC87ivoGBmPx1aCGWOoQt5zXqV9VpqsMzmbFyPmOfkxuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755260207; c=relaxed/simple;
	bh=jfCSf6p9tA9bj+JTPbqnBT/qYxj3EM1PzKEg4HLZ9Ds=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fNUXKIgEI8WJVK6TwdBsx/iOqzXEttHBuKivJFEp6ltkensFbpxuuHrYehfLHVI6b0TuBimSsISdA0vl2nCqOSIqN6t6Sd0K9Lzto/0lTr7Pj7PZ3Zvxtn4gAgiy2SXAuAHJ6guDh7Wf5i6dScrm24Kc0L+BN28eDwSB2ojz7Jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl; spf=pass smtp.mailfrom=wp.pl; dkim=pass (2048-bit key) header.d=wp.pl header.i=@wp.pl header.b=TFIfiBUf; arc=none smtp.client-ip=212.77.101.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wp.pl
Received: (wp-smtpd smtp.wp.pl 30380 invoked from network); 15 Aug 2025 14:16:36 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wp.pl; s=20241105;
          t=1755260197; bh=XxsT9u/bn2Cw8UI50kEntS3WVMhKzCrN+NMcu5/psSw=;
          h=From:To:Subject;
          b=TFIfiBUf+I9LUmajccLU982GiMY1xuXEdH4tcZHTLSaMPFljPPMQUewWfLVTtGr/I
           UpPD3ylI7q6CIiXEROh7h395G3zgjicA5VBeOCJfFiY0Ui0nHoO755PxBwutdP4wc8
           jex2qQmcJvciPiTlFM5cNMQlUYB3S1dI+wDIhUNOwIt4BMDAiW2zFCv5Iy6AhK7+mD
           zjn/TTtU/zNv/ItgJ4hU8fz2GNbaga9CqKtmbRM82YaibQIgYWNYSAi8Oz1eDJa0vo
           kSY+7RwRS1iS6NVeHCNdBCG/0ixOk6L4nc+iiUuWd+hfIiZ7aGI5h4KcByLU3mFbm+
           aFVemOBlHYQsQ==
Received: from 83.24.134.210.ipv4.supernova.orange.pl (HELO laptop-olek.lan) (olek2@wp.pl@[83.24.134.210])
          (envelope-sender <olek2@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP
          for <john@phrozen.org>; 15 Aug 2025 14:16:36 +0200
From: Aleksander Jan Bajkowski <olek2@wp.pl>
To: john@phrozen.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	tsbogend@alpha.franken.de,
	olek2@wp.pl,
	devicetree@vger.kernel.org,
	linux-mips@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] mips: lantiq: danube: rename stp node on EASY50712 reference board
Date: Fri, 15 Aug 2025 14:12:22 +0200
Message-ID: <20250815121635.3397802-1-olek2@wp.pl>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-WP-MailID: cd1bfe4adf4b0c912587650974b9f7e1
X-WP-AV: skaner antywirusowy Poczty Wirtualnej Polski
X-WP-SPAM: NO 0000000 [IUOE]                               

  This fixes the following warning:
arch/mips/boot/dts/lantiq/danube_easy50712.dtb: stp@e100bb0 (lantiq,gpio-stp-xway): $nodename:0: 'stp@e100bb0' does not match '^gpio@[0-9a-f]+$'
	from schema $id: http://devicetree.org/schemas/gpio/gpio-stp-xway.yaml#

---
Changes in v2:
- added sysctrl patch
---
Aleksander Jan Bajkowski (2):
  mips: lantiq: xway: sysctrl: rename stp clock
  mips: lantiq: danube: rename stp node on EASY50712 reference board

 arch/mips/boot/dts/lantiq/danube_easy50712.dts | 2 +-
 arch/mips/lantiq/xway/sysctrl.c                | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

-- 
2.47.2


