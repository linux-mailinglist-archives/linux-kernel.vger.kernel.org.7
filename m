Return-Path: <linux-kernel+bounces-758712-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 265E9B1D301
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 09:08:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C3773AA669
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 07:08:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9684923372C;
	Thu,  7 Aug 2025 07:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tia6Z3YZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01D9C23185D
	for <linux-kernel@vger.kernel.org>; Thu,  7 Aug 2025 07:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754550488; cv=none; b=H7Mmrcil3WsZM1/7G/cap4LExc/9DQAf+x4+ZyQ196o7y+emVE1FCBCsO0X+to2TDGyi62Reg0KxnGpvxmHNHuGZGRCUN+3xW4LXtnnIb5D20FbtkE4rRJ32yHi2qFrXtWb0X4yZzitO+PEoY/+iKpvdu1F8R8QW8IraPOWlvls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754550488; c=relaxed/simple;
	bh=C3VM1bITsfuRyW9zueWhlegNs14fCUR6OGnnYlAim0s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HPHc/VZn4pOeOIrzTVnw1lRGUGYxracjVKg+XfwBHo6Syo6I0hZgMBmQ9lt07Ur0TgCfHvSv58KPbOR8I4C6gC3wWtE6t3khQSu3OQHvdg7wI3zkc0Ycju7Ua5NJbZPPNTz6N/qV9C4LXjuIxBbZkpo79OuBG95mRSugrGoL5rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tia6Z3YZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E58ADC4CEEB;
	Thu,  7 Aug 2025 07:08:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754550487;
	bh=C3VM1bITsfuRyW9zueWhlegNs14fCUR6OGnnYlAim0s=;
	h=From:To:Cc:Subject:Date:From;
	b=tia6Z3YZFsu6d6DMNWf2EPI/fjggQFPDmRP/eXBw0ASjJHRHH5OS1FssKJscFDY7T
	 xEIsnqWhEWIisvLftESaqh81c4dgFD+WyvjG7wLuyhF9kwT2S0UNLOFcvasO4bMJWW
	 tubHar6Uey3KheTZgpywvRPn4v/YYQkKYN2GaqKkKRRpWe2XnuaT9TzyaYMTctIhft
	 x27qIU8T5ZUL5Ql1YPBd9ea+og0YtlYHRXtcWhHnEX46FuJSpcDq5WIMXLjtzuQXvt
	 etNKOtwCCg2l1vN7gSVKAN+T67jgNkj+3a1zxabpE4SNmNX41JkF3neeok4OmgG8nY
	 va05At/Ud3LjA==
From: Philipp Stanner <phasta@kernel.org>
To: Danilo Krummrich <dakr@kernel.org>,
	Alexandre Courbot <acourbot@nvidia.com>
Cc: dri-devel@lists.freedesktop.org,
	nouveau@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Philipp Stanner <phasta@kernel.org>
Subject: [PATCH] MAINTAINERS: Add website of Nova GPU driver
Date: Thu,  7 Aug 2025 09:07:57 +0200
Message-ID: <20250807070756.103816-2-phasta@kernel.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Nova GPU driver has a sub-website on the Rust-for-Linux website
which so far was missing from the respective section in MAINTAINERS.

Add the Nova website.

Signed-off-by: Philipp Stanner <phasta@kernel.org>
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index bd62ad58a47f..3588d43894c4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7829,6 +7829,7 @@ M:	Danilo Krummrich <dakr@kernel.org>
 M:	Alexandre Courbot <acourbot@nvidia.com>
 L:	nouveau@lists.freedesktop.org
 S:	Supported
+W:	https://rust-for-linux.com/nova-gpu-driver
 Q:	https://patchwork.freedesktop.org/project/nouveau/
 B:	https://gitlab.freedesktop.org/drm/nova/-/issues
 C:	irc://irc.oftc.net/nouveau
@@ -7840,6 +7841,7 @@ DRM DRIVER FOR NVIDIA GPUS [RUST]
 M:	Danilo Krummrich <dakr@kernel.org>
 L:	nouveau@lists.freedesktop.org
 S:	Supported
+W:	https://rust-for-linux.com/nova-gpu-driver
 Q:	https://patchwork.freedesktop.org/project/nouveau/
 B:	https://gitlab.freedesktop.org/drm/nova/-/issues
 C:	irc://irc.oftc.net/nouveau
-- 
2.49.0


