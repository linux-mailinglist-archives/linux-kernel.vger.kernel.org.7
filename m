Return-Path: <linux-kernel+bounces-582072-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0D73A768E4
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Mar 2025 16:57:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 876CF3B21E2
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Mar 2025 14:50:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A4B822CBF8;
	Mon, 31 Mar 2025 14:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J0IoV8eb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6563222CBE8;
	Mon, 31 Mar 2025 14:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743431844; cv=none; b=JEV/HOQLST1hbx9hM+tRZh5fmjlJKIJbWQsB6X4G/jERWzl5Ard85J1bZYmTjYLjmdExpRtfiT+D897XZkP4ltRHUhFYdo6wLbBLo8yIOJvLpqmVD0BEzOC2DKj7+ozvegle/HHM/Hyck7IkWdYTQ7y34e0MrwOaTiw2Hcwbum4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743431844; c=relaxed/simple;
	bh=nel+CNbtIcIbXhGVRK9Wmqiu+JKidiJ+yS/1506Ry7M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KjGqRpfNk0eAqaqoHFEXDgukMbBD68kr1zL57PVS6kOlk5gEWxAEt6eWI0zSCMqoRHQj3HsmpEAPtEVqALvuyi9caUFIrCTrjqwad+uLhLvIWRgjB3Fw7Zn1A3UyKZ+YcCdBSC1VaO4QZzdVf4zBRDyUhzB4DqOiZqdqikmtX10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J0IoV8eb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49B6AC4CEE3;
	Mon, 31 Mar 2025 14:37:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743431844;
	bh=nel+CNbtIcIbXhGVRK9Wmqiu+JKidiJ+yS/1506Ry7M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=J0IoV8ebfn91I62ieFegKX7b7/n0ECabbVHdq5Yq3oeNdgm4G63YuXDhZ7CXPRg7H
	 YaQ9EjU2h+ZOU9Vc471/lPYDXcJTsCnFurjf08WEasbfAX+hBi0k9fJwsjsnPx/Qf/
	 H6maW8aNCs5gs1QT+u+irPbrKuhLMW1/EKUYbUdjEVW8UFVVf/Nin4Eg3OPyKELh0K
	 A5EWXbpb2GxoY0FtyMQy+zfjmFNZzh9nsNh9FxY0HjfwCMD7mmcBJaDT8FPgMWC+DR
	 VmwclqxLN/Arnb94caQzYVJ27tN0FkECNnf70p7r3lIQxxIrD61bS6wM2lD6zXzS/N
	 vLOtH15Ah2Gmg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Kees Cook <kees@kernel.org>,
	Juergen Gross <jgross@suse.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
	xen-devel@lists.xenproject.org,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.10 5/6] xen/mcelog: Add __nonstring annotations for unterminated strings
Date: Mon, 31 Mar 2025 10:37:07 -0400
Message-Id: <20250331143710.1686600-5-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250331143710.1686600-1-sashal@kernel.org>
References: <20250331143710.1686600-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.235
Content-Transfer-Encoding: 8bit

From: Kees Cook <kees@kernel.org>

[ Upstream commit 1c3dfc7c6b0f551fdca3f7c1f1e4c73be8adb17d ]

When a character array without a terminating NUL character has a static
initializer, GCC 15's -Wunterminated-string-initialization will only
warn if the array lacks the "nonstring" attribute[1]. Mark the arrays
with __nonstring to and correctly identify the char array as "not a C
string" and thereby eliminate the warning.

Link: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=117178 [1]
Cc: Juergen Gross <jgross@suse.com>
Cc: Stefano Stabellini <sstabellini@kernel.org>
Cc: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
Cc: xen-devel@lists.xenproject.org
Signed-off-by: Kees Cook <kees@kernel.org>
Acked-by: Juergen Gross <jgross@suse.com>
Message-ID: <20250310222234.work.473-kees@kernel.org>
Signed-off-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/xen/interface/xen-mca.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/xen/interface/xen-mca.h b/include/xen/interface/xen-mca.h
index 7483a78d24251..20a3b320d1a58 100644
--- a/include/xen/interface/xen-mca.h
+++ b/include/xen/interface/xen-mca.h
@@ -371,7 +371,7 @@ struct xen_mce {
 #define XEN_MCE_LOG_LEN 32
 
 struct xen_mce_log {
-	char signature[12]; /* "MACHINECHECK" */
+	char signature[12] __nonstring; /* "MACHINECHECK" */
 	unsigned len;	    /* = XEN_MCE_LOG_LEN */
 	unsigned next;
 	unsigned flags;
-- 
2.39.5


