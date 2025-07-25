Return-Path: <linux-kernel+bounces-745308-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 63159B1183A
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 08:14:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A05F47A3C28
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 06:12:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9B6B28467D;
	Fri, 25 Jul 2025 06:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="ogdtOgBd";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="nxX8zxbW"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17BF524061F;
	Fri, 25 Jul 2025 06:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753424034; cv=none; b=RtEG7dceAyi7hzW4PXHZ7+4c6tzIFAyIpMV3i0h/L89rQHLsKOyjFvdlIcHHC70rEywe7orVIyRO90Fn3dpNMwijr4+xWgMofqhpmthZTqn9vf8HBtKKhHT8Spzvl/i3w95zXPmKgbb9otUGX8SUYNtanxH1ntl2nLhaDImtnUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753424034; c=relaxed/simple;
	bh=dQonKsSteECdfo4mLGdIGrm9i7PJKSb4L8kxHk/GEKg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UZGByPakB1QggG/fA7XRpE1VDldt/ayIe6LPkZ6DmSNSmYScfnquIEpr/mRzhUz+qYstVRZzJ3KnMZD2VT+Yk+Ns1lx5xauXIfodjUgxeyKynNl5eYw/mxN6m7lwrQolM35GO+T+ypdZU/jgBQ8qCkqeY29cHPG4lkcW0IxhYPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=ogdtOgBd; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=nxX8zxbW reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1753424030; x=1784960030;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=c31s3mpskb+5zWGcp6639wWZ2XSIoFe0Eg4tpjdgFMQ=;
  b=ogdtOgBdvmS3fBkvgyOb+QjT8MEDFywoYUyKAUxpiLgOoJhTQIHciTU2
   gvA36H5122mvBgGN1jDPhovKTHUTQqDR+wFbbWDoYnmoBNjOGdTwcCz8J
   wps6yi/hLD5yFsDh+F2ygxzj2VZPUl4s0yU/OgW9Gl0rVlswdg1PXlhQ2
   uZ6PhD1x9dFkxgs8M4/CTGT82hUrOp6vBxT1E04/1OYKMFimqnkgKTShL
   m8U6d/niCLNuAXtjZOII3ULCOTpcAUupoqx2M8EQQhZPVbpfi4orGi3z7
   lfjj7r3dbNuMuJ+mJ73jxHP5ILJtUcsKK5x281DLtapCmKcZjUJyHlsMB
   A==;
X-CSE-ConnectionGUID: KtrZHt8ISB6KLNEAanoAzg==
X-CSE-MsgGUID: tBddOxUiTNeUQbv7eHksUQ==
X-IronPort-AV: E=Sophos;i="6.16,338,1744063200"; 
   d="scan'208";a="45413012"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 25 Jul 2025 08:13:47 +0200
X-CheckPoint: {6883209A-2C-9BFD12F6-F51D5FD4}
X-MAIL-CPID: 3EBA27A9C48D9BD60EA4DEFA9B9C27DB_3
X-Control-Analysis: str=0001.0A002111.68832097.007F,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 66306173583;
	Fri, 25 Jul 2025 08:13:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1753424022;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=c31s3mpskb+5zWGcp6639wWZ2XSIoFe0Eg4tpjdgFMQ=;
	b=nxX8zxbW99AsUHe6/kYCs+Iu3wG9ud87J90b07DNjKOPyUbgHpQQ+7iqC/vRK0V/l8uoDC
	5ta5hoq2r+U/gbFKLd/KTSnEKcQc7m9iIIGnConpXWqAWksJZ5lGTPHbsC2nEayCCorjRD
	f0uiVMoUsPdajBIeKxBatveqTNd7WNv2Wa2AHj02c0Mvx6/Pjr4xMZv/7U+tHr/EC7AbCM
	vYD1khlJqoW1U7YnjpYPInetCpilo+3Xp6JvkcWpBTxLb9liv1gL5R54nZqJIRQRVjxuaJ
	FSm8zUSWrPbcqgmdQoFT5TgRfXhtdJtHEkGtQ4lgD3grBefFhJ1egPtx7igSSA==
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Shawn Guo <shawnguo@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Alexander Stein <alexander.stein@ew.tq-group.com>,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 00/10] ls1021 DT fixes
Date: Fri, 25 Jul 2025 08:13:25 +0200
Message-ID: <20250725061339.266125-1-alexander.stein@ew.tq-group.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Hi,

this series fixes most of the CHECK_DTBS=y warnings for LS1021A.
The only warning left is:
> esdhc@1560000 (fsl,ls1021a-esdhc): $nodename:0: 'esdhc@1560000' does not
> match '^mmc(@.*)?$'

But changing this might break some bootloaders as they reference the
/soc/esdhc@1560000 node explicitly by path.

Best regards,
Alexander

Alexander Stein (10):
  ARM: dts: ls1021a: Fix gic node unit address
  ARM: dts: ls1021a: Fix qspi node unit address
  ARM: dts: ls1021a: Fix sai DMA order
  ARM: dts: ls1021a: Fix FTM node
  ARM: dts: ls1021a: Add reg property to enet nodes
  ARM: dts: ls1021a: Remove superfluous address and size cells for
    queue-group
  ARM: dts: ls1021a: remove undocumented 'big-endian' for
    memory-controller node
  ARM: dts: ls1021a: Fix watchdog node
  ARM: dts: ls1021a: remove property 'snps,host-vbus-glitches'
  ARM: dts: ls1021a: remove undocumented 'big-endian' for
    memory-controller node

 arch/arm/boot/dts/nxp/ls/ls1021a.dtsi | 40 +++++++++------------------
 1 file changed, 13 insertions(+), 27 deletions(-)

-- 
2.43.0


