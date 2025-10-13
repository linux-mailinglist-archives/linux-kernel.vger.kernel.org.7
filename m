Return-Path: <linux-kernel+bounces-850480-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 80F55BD2F02
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 14:17:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 09D634EF0B6
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 12:17:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 345AB26E6E3;
	Mon, 13 Oct 2025 12:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="21iEEdtV"
Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C30B156CA
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 12:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.238.236.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760357851; cv=none; b=EljnNOSz5WVdkyqP5xLSjxieEeb0OoLNegNFEZ1u+OulJLw3F/7RKvmJd2HowYGHnDyhIpoPxCDfCqV8G8aQRlu/1a5AF8vD1H4jAN3G2nZUAjRtnbIIR0PNXiKqVROtKIZtUFlC7J2HAXwT3C8fRO+YIBr6ff4ujbSpfaOuc7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760357851; c=relaxed/simple;
	bh=JN2nrz1jM5oOA3YioyA2ynVFlmP+iurajezl38qJx4o=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=o2p2k7tdloB7Iez1ln3N7reTXIyqvYLB5LWEq6KsIgnYrzqjHCVJSrWgSwdIy+Z05Hofo+7We1GaOVepVJ3bQ24LJBHneIfuNz1DsZY9n/IghZBN/+PEBD5tNRkaXj24tLkx9RBpkEFL/LcpEuFcJfCXzy1Amo9xQ4aLDf0W0HE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info; spf=pass smtp.mailfrom=kemnade.info; dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b=21iEEdtV; arc=none smtp.client-ip=178.238.236.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=From:Sender:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=Du1q0d8iaqBmjtERDybGAzIfy4R227O66LOdBibIRSM=; b=21iEEdtVLyqas0aNnOcZjTKntt
	ZNA7ATosy4Fr6Ptu7q5SB4+t+eicCNXHJtqyfeYwxRoU5FnflligZ51sejMPaKdzk7NVPwkhIxwxA
	vdrXQY5vAyFZ9aPw7t3pFxRVFynn9TRaYZoQNcFN1dmejBRSw1Q3h6nEGVXT3Z0TNHcpujngvKX+8
	CcmbN5LB4WKGPNrbopZ82KmBlp8t1OSJT9ElcwYu4b/s25OK0HbUxi1oY+HkK3Yx8Uqka8AAj3wGa
	efh3upEJn4JIyBOPIFoG7PWpNN60yLLCMi2rFh3cr8+V7yVLMFI3g0ilK3aBO4oVMTdKZyjzAEUeK
	jNnkhKxg==;
From: Andreas Kemnade <andreas@kemnade.info>
To: linux@armlinux.org.uk,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	ebiggers@google.com,
	ardb@kernel.org,
	dario.binacchi@amarulasolutions.com,
	martin.petersen@oracle.com,
	andreas@kemnade.info,
	alexander.stein@ew.tq-group.com,
	stefan.eichenberger@toradex.com,
	lukas.bulwahn@redhat.com,
	tytso@mit.edu,
	linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH] arm: imx_v6_v7_defconfig: enable ext4 directly
Date: Mon, 13 Oct 2025 14:17:09 +0200
Message-ID: <20251013121709.104546-1-andreas@kemnade.info>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In former times, ext4 was enabled implicitely by enabling ext3 but with
the ext3 fs gone, it does not get enabled, which lets devices fail to
mount root on non-initrd based boots with an ext4 root.

Fixes: d6ace46c82fd ("ext4: remove obsolete EXT3 config options")
Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
---
 arch/arm/configs/imx_v6_v7_defconfig | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/configs/imx_v6_v7_defconfig b/arch/arm/configs/imx_v6_v7_defconfig
index 9a57763a8d38a..0d55056c6f821 100644
--- a/arch/arm/configs/imx_v6_v7_defconfig
+++ b/arch/arm/configs/imx_v6_v7_defconfig
@@ -436,9 +436,9 @@ CONFIG_EXT2_FS=y
 CONFIG_EXT2_FS_XATTR=y
 CONFIG_EXT2_FS_POSIX_ACL=y
 CONFIG_EXT2_FS_SECURITY=y
-CONFIG_EXT3_FS=y
-CONFIG_EXT3_FS_POSIX_ACL=y
-CONFIG_EXT3_FS_SECURITY=y
+CONFIG_EXT4_FS=y
+CONFIG_EXT4_FS_POSIX_ACL=y
+CONFIG_EXT4_FS_SECURITY=y
 CONFIG_QUOTA=y
 CONFIG_QUOTA_NETLINK_INTERFACE=y
 CONFIG_AUTOFS_FS=y
-- 
2.47.3


