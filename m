Return-Path: <linux-kernel+bounces-859183-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8438ABECF73
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 14:23:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3D2A64E6369
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 12:23:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 721DD285C8C;
	Sat, 18 Oct 2025 12:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i6+etu4G"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB43917A31C
	for <linux-kernel@vger.kernel.org>; Sat, 18 Oct 2025 12:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760790215; cv=none; b=IFCu+Gu4B5UbHGsfsI/q3oetq0QnIuLSFG7VQpz23v8J9O4RjCoxF555FHhnBJ6eFzjQnm9/wpS5o6faxo6zUCOhtvB5/5ndILaTP3nSvJHbugA/+B10ulPI2G+JTy8112t20k5e39vVkikMunhNidQW9FaKvhNjKFJIURrjcxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760790215; c=relaxed/simple;
	bh=hjA+KH3Wj1C+zAvItz/eOBEiIkWyOOrmjBXeUhx60V4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=s81o/Tr4j8r3RjFRgvbPov4bavmRBdjPXv9fMAQzN36ngJVe8d4buku0nRMeyNUYQsXCBNW9onziE9S6qlo/o2LbtOtwiUCXKl/dn+vJq8rbidPUZSeLyI36Yl7vgy0dOvYasZRxOWA0EXF+gJb4r3gweywGpipm7Pp06lKNO8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i6+etu4G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 56B64C4CEF8;
	Sat, 18 Oct 2025 12:23:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760790215;
	bh=hjA+KH3Wj1C+zAvItz/eOBEiIkWyOOrmjBXeUhx60V4=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=i6+etu4GXlchxqIIf4CNY0BF4g0S+LweWmngpQwuGuTvLgl+Kp2gZAGnBQI1Y76bk
	 lz0+tqkSytI8fxQQDnaaB27LQGchNg5/wy/HhledVge1Vy6Hawo5KSiW+p5OiIgC9i
	 T7WyOGJkDwmeX+TSiaZwL7dtsWGqm9JQu6uCJTEDXAqzmTVaA+BcmRjSeRNGexQQ7h
	 cdOq66P5V97BxfH/oF639P2b3TSZ9pGhxrUEjmNzler70WZqzoLYZI4EzNyTb+LrRB
	 XSZs+doDOgC7dQ4b8sq8S0846L1hUVXHfZGXTDyAfCtURmLRrVzy8CW6XuUUAZglTh
	 vT4djG9eNzW5A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43803CCD195;
	Sat, 18 Oct 2025 12:23:35 +0000 (UTC)
From: David Heidelberg via B4 Relay <devnull+david.ixit.cz@kernel.org>
Date: Sat, 18 Oct 2025 14:22:57 +0200
Subject: [PATCH RESEND v3] ARM: multi_v7_defconfig add /proc/config.gz
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251018-arm-config_gz-v3-1-0de1eaadd902@ixit.cz>
To: Russell King <linux@armlinux.org.uk>, Ard Biesheuvel <ardb@kernel.org>, 
 Arnd Bergmann <arnd@arndb.de>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 David Heidelberg <david@ixit.cz>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1307; i=david@ixit.cz;
 h=from:subject:message-id;
 bh=7w/aD3shZMm8S2nIaaI4q8HkXYxgH0I/7K7GWxdOw78=;
 b=owEBbQKS/ZANAwAIAWACP8TTSSByAcsmYgBo84bFUXDf8xi9WnUPm10TJ71uwk3sxLZfjtFB7
 7FAxgH5IhyJAjMEAAEIAB0WIQTXegnP7twrvVOnBHRgAj/E00kgcgUCaPOGxQAKCRBgAj/E00kg
 cnI2D/0b15ZI37jdYTKlxu1rONqBTQJqsCCYgB4N+sRazVYVxyDoZxqZcZmw2Ls4Z6MUKQFOBRX
 a6BwkeYJTBwlJaDlSCtshtC1A8U9C/EkE/jeSdq4r65VvLyzj+ylhae63OfyxgH3wQrQkSZiWA8
 GEklNbawfl6PkdyfhyyUBFLTyjZgOGhTR1wdUjxbJUAidi0OZ798Blv/wUH0VfbglODF/HU87Cy
 aGHfrMa1GwjNoRNI8gIpl6zxFkipgAVMcu37/0JN45Lfdho3aGHXxls5MZA1G7vqm76LhVDQB4S
 8cc4LAirydGL2R9ivYJg4cup/qhu4LkzZ4tRvcrYk7NSMyIBucNedkkI8oe3l97Sg0QSZDpIOeU
 8ehTx7k/QpesIq/THLaPKzUvc0ZeoBylpCRHek7fnD72JyR0jliygGRqp7mEjBRhjRXPiUzWG8B
 PgLOBEQH75vO8dWS/9Q90s54WhYwoBmWbMuZzREaDYTNpZZ6XqjU6vMG6nrYd/ujI2SCNlRNSXH
 aLFIH6j6OUaYufulfD/V47ISvzjG77ylfMv8ztra4V1jolTNPVfj7B+KKemnIDInheSLYJTmS1x
 SK18W7VppaC3qAvGj85OJtYl+Qvr95Ou/hWcPLlQrcO9NEdbPFeLz/li9E6TAiybwCsMLfAQI6C
 pr9wSSHm7N6tXDQ==
X-Developer-Key: i=david@ixit.cz; a=openpgp;
 fpr=D77A09CFEEDC2BBD53A7047460023FC4D3492072
X-Endpoint-Received: by B4 Relay for david@ixit.cz/default with auth_id=355
X-Original-From: David Heidelberg <david@ixit.cz>
Reply-To: david@ixit.cz

From: David Heidelberg <david@ixit.cz>

While 32-bit ARM isn't that widespread, multi_v7_defconfig is used for
building more generic images, where having access to config can be handy.

arm64 and x86_64 already bundle config.gz, so this is an effort to provide
the same level of comfort with ARMv7 devices.

Signed-off-by: David Heidelberg <david@ixit.cz>
---
Changes in v3:
- Rebased against next-20250715; otherwise, just a resend.
- Link to v2: https://lore.kernel.org/r/20250329-arm-config_gz-v2-1-f725d331fb5d@ixit.cz

Changes in v2:
- IKCONFIG is now module instead of built-in (Greg).
- Link to v1: https://lore.kernel.org/r/20230612210208.109267-1-david@ixit.cz
---
 arch/arm/configs/multi_v7_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 65df4014c4a60..5180c90cb5da1 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -1,6 +1,8 @@
 CONFIG_SYSVIPC=y
 CONFIG_NO_HZ_IDLE=y
 CONFIG_HIGH_RES_TIMERS=y
+CONFIG_IKCONFIG=m
+CONFIG_IKCONFIG_PROC=y
 CONFIG_CGROUPS=y
 CONFIG_BLK_DEV_INITRD=y
 CONFIG_EXPERT=y

---
base-commit: f2b1f6a9f382564b1d4cf16c45e73ccccb917f1f
change-id: 20250329-arm-config_gz-7d656859ad59

Best regards,
-- 
David Heidelberg <david@ixit.cz>



