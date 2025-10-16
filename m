Return-Path: <linux-kernel+bounces-856429-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6418BBE421C
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 17:11:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D407E19C3EB5
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 15:11:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 572D4343D91;
	Thu, 16 Oct 2025 15:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uu9nsJdd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EA4A31A7F3
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 15:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760627458; cv=none; b=hirR0s2FipChHvpHVr8/AwlJhn7x/mo24gdJhNwUykR4rIFGR6lxwBV12TGxcaSvxW80qOG9/rDzuW54HJuI7hEMMWV5CszQgUntppe5LptE9V8BdKujGvZvZ38ytT1ur/Lp4uLf5FFz745ZtYmtvbPkP14hiYowN9MS9K2nGEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760627458; c=relaxed/simple;
	bh=hjA+KH3Wj1C+zAvItz/eOBEiIkWyOOrmjBXeUhx60V4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=TNHAHM9O7AqWgmbWf0Kj8GU3DfrrExhXTGOb/GVD9LEC+yiW87hIFuVrkoNB7gPe68N2Pkxwap6nbKGdrkCixqRTvIeDbQBudl8b4e84DPBNY1YIiMETLPgch69CiTZ4ZUHl0sRN252AGJzfZhjGfVEecujLDPkABCt75virxXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Uu9nsJdd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 09AFCC4CEF1;
	Thu, 16 Oct 2025 15:10:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760627458;
	bh=hjA+KH3Wj1C+zAvItz/eOBEiIkWyOOrmjBXeUhx60V4=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=Uu9nsJddt3eQ9c+WthR+SA1K1ZBI2GrAwnqByaF5rvFKlFBAzj3eRpdaSr1QbwQ1D
	 SVwAeFgEbez7sSRppoCVr8XgO1QmVkbKfQOwqRX92KA0cRc/cj8R5EZg0xxmhzHD+r
	 QrsjhRoiqyqYTqia/bBAiJFZNsAOGNKHnv/hzDNMvEOYR+XxLUKBDa57iDvUhfeEnT
	 gnF7FtMA/JcoQS6Sc8tMWnIRBUf+Wl8sxdgUCYVpZQrH/OF5Qr1HM4Kdm2zE/hMC7p
	 zy7dbL0i2ZNmbg4fQ9B3fgbIiSqAIfbWLHneSM/RIu1hxuwjiUCrTnsAdeBfpSnxfv
	 NcUGpE3l4SOrw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F29B5CCD183;
	Thu, 16 Oct 2025 15:10:57 +0000 (UTC)
From: David Heidelberg via B4 Relay <devnull+david.ixit.cz@kernel.org>
Date: Thu, 16 Oct 2025 17:10:50 +0200
Subject: [PATCH RESEND v3] ARM: multi_v7_defconfig add /proc/config.gz
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251016-arm-config_gz-v3-1-3874adbf07ad@ixit.cz>
To: Russell King <linux@armlinux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 David Heidelberg <david@ixit.cz>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1307; i=david@ixit.cz;
 h=from:subject:message-id;
 bh=7w/aD3shZMm8S2nIaaI4q8HkXYxgH0I/7K7GWxdOw78=;
 b=owEBbQKS/ZANAwAIAWACP8TTSSByAcsmYgBo8QsAL6yf9pjJS3iO30WWOBjT6+PwMNJHZhFwG
 qnooKwCd8SJAjMEAAEIAB0WIQTXegnP7twrvVOnBHRgAj/E00kgcgUCaPELAAAKCRBgAj/E00kg
 csuTEACboB0BZzXR0uwri8Qb1JkyA8RYDzGFFe4g9Hrf2EFiCVtOdkvzmo/H5wnnUvXkSKVyNYA
 jwIMrQRxPDciNoL1AaIqVN2K97isMpKKR2koVJVaWHkhBQiWqQxynMVBHsmjUE0R/mssFizOfa8
 B5Bi9ILpz9GYlM80tgC3/Tbkx75CgYHbYj4dXfSO+qB2jd5OYX63asmXQwlszi9AkSGj/SKpf7Z
 t8Vqri322w29wCdzDnDFDoHWqfNO07mR4zfibE0zX2RhKzNvvLwPBq0gSk8r1KUL680F0L9pexx
 rTlwFOR01b65TFxLfHJP1awvFBnzZ1JZPi2EEzZXUvillNszbJ9yTTIOsNjp2Pfq+rUWk4kDeAX
 FJ9mYE+ufWvHlR2erSE4V8u+8EP4wRpMhU45KVS0lXmcjtxpQDYkIz5/78rupQrLii1tcqNhppw
 yOuXkR3Xuw2Et2qyyxsLWPwj8IEzRXxXS5+1DZKcYMdn0YfO+drS7gxik8YfB1lXudeFAJi4fyU
 I+BJ+0EvDuz7nfz//pTCiiHR7EewLZmEmCLIuy5RS0Bpv4eAS2PhhjjWFQQL5c8unEIc/vy8/3u
 2ZwpUhBfOmhtd5BS+SgwKhSgPYjVGAv1GbZ3Ms/LwlyHJuOqlj59BYvT77GtmfMVJSvnyh470Jb
 cHsrH31gU1Y/LWw==
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



