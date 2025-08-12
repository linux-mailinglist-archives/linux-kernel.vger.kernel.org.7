Return-Path: <linux-kernel+bounces-765174-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF541B22C88
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 18:01:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8ACE504C74
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 15:57:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09D572FA81B;
	Tue, 12 Aug 2025 15:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gDvM2J8n"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 681F82F8BEB;
	Tue, 12 Aug 2025 15:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755013985; cv=none; b=F8+p79BTq6YWcc5nKogtE2p/wVnhH9SWtqR1uelABcDdkOfxtPoQ9hA1ITHWhyCFguKRfL8KFBU6C66JERVEKfulQ0T/h+rNNH9D9Z1ysK1eZXXNHxiCKlk8z4sfIE3cuZucFAsAi5xLRtxUAO+4uq6oD2gzUs6az56Pd6zUJJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755013985; c=relaxed/simple;
	bh=KTpTCCjkRQ7n/04aWXym3yGT7vJ2QtIeN0GnK9dV3AI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pR6BbBD4aSTutM/Q7I8VYWw3v/vS9mSlVO4rbI88QopQjU+9lAHRrVpymOHDEGRgwpMpWDfdThQVc4Q4Z2BaQe/qdFLustDuh9veCamWvjgjSo10+7IEGXYo0MpV8koGYIjMqUGGnJBrxJAzmaPE/xVi+z5wA+s15jf+EmLM/Pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gDvM2J8n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5CCBC4AF0C;
	Tue, 12 Aug 2025 15:53:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755013984;
	bh=KTpTCCjkRQ7n/04aWXym3yGT7vJ2QtIeN0GnK9dV3AI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gDvM2J8nBvJryctvpwI1NRYjLOYp37rknbpUpCz8vmOSmn2I8HrillVizXMZtXl8o
	 XusQxEjYTomR668FXvlU/3B6IF8Y5xvJIBZf3wok2d9lQ4BpDPlYWwCYbXKeC+s8UI
	 HGUZ9XfBfx6eFkAhIzRLtjMDM+sdF5nYBak8UEay/uOYbEISyU7kQ5dfzReFkyjgWf
	 Wr1bsay1UlboivWvC+AMbixWowfM57DLPxVKoyuYyzQwuNKhpHnQViO1sfF3MXOCmu
	 Rm0XCzc3182g7m+LxyB7oj6FGGCwvwHiKy2YsGIyvgLTw3tahptOCQQ95Ak8YPzq7C
	 OJbFW61ppGxzQ==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1ulrJ8-00000006kWI-2K8p;
	Tue, 12 Aug 2025 17:53:02 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	"Jonathan Corbet" <corbet@lwn.net>,
	"Mauro Carvalho Chehab" <mchehab+huawei@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 17/39] scripts: sphinx-pre-install: fix rhel recomendations
Date: Tue, 12 Aug 2025 17:52:34 +0200
Message-ID: <393a299a850ba9d94c6a8965e78db4da2dbf7e37.1754992972.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1754992972.git.mchehab+huawei@kernel.org>
References: <cover.1754992972.git.mchehab+huawei@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 scripts/sphinx-pre-install.py | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/scripts/sphinx-pre-install.py b/scripts/sphinx-pre-install.py
index 6b5f9eda91bb..1f64909953b9 100755
--- a/scripts/sphinx-pre-install.py
+++ b/scripts/sphinx-pre-install.py
@@ -519,9 +519,9 @@ class SphinxDependencyChecker:
                       "For most, enabling epel and crb are enough:\n" \
                       "\tsudo dnf install -y epel-release", \
                       "\tsudo dnf config-manager --set-enabled crb\n" \
-                      "Yet, some may have other required repositories. Those commands could be useful:" \
-                      "\tsudo dnf repolist all" \
-                      "\tsudo repoquery --available --info <pkgs>",
+                      "Yet, some may have other required repositories. Those commands could be useful:\n" \
+                      "\tsudo dnf repolist all\n" \
+                      "\tsudo dnf repoquery --available --info <pkgs>\n",
                       "\tsudo dnf config-manager --set-enabled '*' # enable all - probably not what you want")
 
                 self.first_hint = False
-- 
2.50.1


