Return-Path: <linux-kernel+bounces-816007-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 674E2B56E16
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 03:59:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A470F3BDC76
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 01:59:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C285D244681;
	Mon, 15 Sep 2025 01:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SMhkqNfd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EAE7242D7B
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 01:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757901500; cv=none; b=SUFg3zfWviJY6c00GpW/iT/QwewWyCZRcxV/pqbmk4MVsGS/SSYciJznegVV/vpf88oOS+tGOUd7vmycGu5Jrhzj3nNpzsNZH2pGiYlPRe0XfrVorYqT4W7qTNOv3FoFi3Bit17oGkVsqtOxvx6o8WmYM6pu+1yG13Hi3so6Sxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757901500; c=relaxed/simple;
	bh=tG/+3LKYF2FSnLVHXLho3ONEf7Ek8I7B7tVYfXji6YQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qIAMwCN1xi257AYM6jOBiQM+kUVU0r+eOuqJCOlh9N8xU9EVPzPIyu+4AVoZhhTtJh9m9y8saCZZMFO1vlberK105CxrygIh9GNWp7zGoqnxw3h8jXmHAAdsr5Ks5NgIXse6nGBm/qO3hYGjCNcFbNOa+RBzAyk49W0d3DHc42I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SMhkqNfd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A127C4CEFC;
	Mon, 15 Sep 2025 01:58:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757901498;
	bh=tG/+3LKYF2FSnLVHXLho3ONEf7Ek8I7B7tVYfXji6YQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SMhkqNfd6to+CzSXDYZsuRKahWPQW48UDCRpnqV24zGixc6e7uJsA3rjnGLStLyNa
	 WqC7vYM6VdNbv2oqW7iSA8iTLGwaZgyD90C0MPl3SUdwhAAqIl3ACCYs0YFqR5Ik4L
	 kw3+gaW63asJg1DV5hWO1fRRA8XY+jKkalDNvq/F3qOgN+Mi0Lo9lAlVVDVzXV8TCs
	 W8vz0whqujmKarvV4Lh9Jrro85Dwwbc2lzMvVyOO9aGQ6DwbuR1BQ8hJ9e+EJ4t542
	 lsXA8VykTYta83P1D2OHogtlsPPjZfoHMfhSXPxED/LbaotkwmKxDCiRzq9/CmloBP
	 vjLzhZZMfbwlg==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH 6/6] MAINTAINERS: rename DAMON section
Date: Sun, 14 Sep 2025 18:58:07 -0700
Message-Id: <20250915015807.101505-7-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250915015807.101505-1-sj@kernel.org>
References: <20250915015807.101505-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DAMON section name is 'DATA ACCESS MONITOR', which implies it is only
for data access monitoring.  But DAMON is now evolved for not only
access monitoring but also access-aware system operations (DAMOS).
Rename the section to simply DAMON.  It might make it difficult to
understand what it does at a glance, but at least not spreading more
confusion.  Readers can further refer to the documentation to better
understand what really DAMON does.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 4c8bbf70a3c7..ca8e3d18eedd 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6738,7 +6738,7 @@ S:	Maintained
 W:	https://docs.dasharo.com/
 F:	drivers/platform/x86/dasharo-acpi.c
 
-DATA ACCESS MONITOR
+DAMON
 M:	SeongJae Park <sj@kernel.org>
 L:	damon@lists.linux.dev
 L:	linux-mm@kvack.org
-- 
2.39.5

