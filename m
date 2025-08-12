Return-Path: <linux-kernel+bounces-765164-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B8E21B22C6F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 17:59:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1FC4A7B7FB0
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 15:54:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E686B2F9460;
	Tue, 12 Aug 2025 15:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XeUJiRb6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A7342F659C;
	Tue, 12 Aug 2025 15:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755013985; cv=none; b=sVVMc2EZPlmSSxjm9MoBAPQySpeQ9Tcgv1Z6z2clLcY91wsM3UOkkyZksRG6mFgxsRJFTaO+jmYshwWxQWyYqc5jSmSsb31W7DVNYFbRK2/b5BrKF5TH7wUvxTcrVIDYKCKSqKLoWLfsQFjLMudn2dActizLrSGFq/8IRZri2dI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755013985; c=relaxed/simple;
	bh=F0VIBtxterrSQG9wqzNfarK/AogmBCYnIszdwgzywXg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S2TJthHyXOX9Ua6tuWSmYPjtdf7Y8tzonQS8yhnsrjXAx6YGomrVQJlRfg5cDvF5FP8Ef2qFCYUHe3q/2g+/6mr+24blLiFWw50C70nac32cAc5suXsgP2Disvobd+LzBBk3IyeCo8o5Dorw5EsDP8bWinOwruL8jYbf330GzLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XeUJiRb6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B89C7C4CEF6;
	Tue, 12 Aug 2025 15:53:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755013984;
	bh=F0VIBtxterrSQG9wqzNfarK/AogmBCYnIszdwgzywXg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XeUJiRb6yJo+s7FnM6i9GtC4OxkoRd1tbcLwwG0NyeBCT+xEb1D1YzsLlVDeIdZEI
	 TcpALt3fCLtkDTlQO5uCxdWXmGoRjYgzIGKXzYQJcq6r0eyRQ3uieImIFwcyjivhuh
	 dxrIeRbFpzwCseskvTW0tNlP27cRiD3dsZXpdLWkHL4XvtGQ78hFGqndd48akmRjit
	 UBySO4KyXXfTplPmwKEjSYqPogNhoPjz3AMGv9yZWsAeeYQNPerzE17PrnO8u0cbqP
	 Ga2gmG+s/ZgS2lUaV7ZTMrXjUc8CaZJL+bwAXqCClGoZrAOqxXnqf1HlbZDyiTJnrX
	 UfyqWZVz4zVFw==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1ulrJ8-00000006kWU-2hgd;
	Tue, 12 Aug 2025 17:53:02 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	"Jonathan Corbet" <corbet@lwn.net>,
	"Mauro Carvalho Chehab" <mchehab+huawei@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 20/39] scripts: sphinx-pre-install: fix OpenMandriva support
Date: Tue, 12 Aug 2025 17:52:37 +0200
Message-ID: <0b4e7aa88c96e6a5b8f2e6f381b3e21124680d33.1754992972.git.mchehab+huawei@kernel.org>
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

OpenMandriva Lx 4.3 has different package names for ImageMagick
and yaml. Fix them to ensure that system setup will pass.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 scripts/sphinx-pre-install.py | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/scripts/sphinx-pre-install.py b/scripts/sphinx-pre-install.py
index 94f3d2e32fd6..2f6036eadc94 100755
--- a/scripts/sphinx-pre-install.py
+++ b/scripts/sphinx-pre-install.py
@@ -647,6 +647,11 @@ class SphinxDependencyChecker:
             packager_cmd = "dnf install"
             noto_sans = "noto-sans-cjk-fonts"
             tex_pkgs = ["texlive-collection-fontsextra"]
+
+            # Tested on OpenMandriva Lx 4.3
+            progs["convert"] = "imagemagick"
+            progs["yaml"] = "python-pyyaml"
+
         else:
             packager_cmd = "urpmi"
             noto_sans = "google-noto-sans-cjk-ttc-fonts"
-- 
2.50.1


