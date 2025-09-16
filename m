Return-Path: <linux-kernel+bounces-818079-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 59258B58C68
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 05:36:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A43971B26E29
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 03:36:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6015027A935;
	Tue, 16 Sep 2025 03:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dhCRJQQ8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6E47277C81;
	Tue, 16 Sep 2025 03:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757993723; cv=none; b=Illy52tw8zUmFTmSc8ar+5Ar3K5Nj/zJYX9oUzMbIQVU1o48n/aenqkJqM3EEL/fJxniJ42Z/q+/p/ma3LUiObQCfZHSwkLc27ljgBY2EEeH24Td0n7wK+AEOwFLl47MnjDBmWmnd/wQqhiQLOrlXlnSUVqVY11K1h73EG5fV9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757993723; c=relaxed/simple;
	bh=8oAmMgNUvcFWbF3KtriZccsEdzvp1RE+WJ1o1RTAqkA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Cni4LINjZ5z2Jw+ukMJgR3RUJ9P17vBffbE0hgfkQbqXFrMKYY9G6T5E8PROnyuFxZQ2FzOmtjwU1nDWlx7bkcaZ14RptFUzCVL6aZGn7OneD4ACCvhUml206OUzKZk50ralF39/Sl85pm9+gEz3RsvDfeRCGG26hKAS6qbwIh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dhCRJQQ8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2818AC4CEF7;
	Tue, 16 Sep 2025 03:35:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757993723;
	bh=8oAmMgNUvcFWbF3KtriZccsEdzvp1RE+WJ1o1RTAqkA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dhCRJQQ8QgGNEa5PQd5V6Jv0j+x3drr4a3j4gjBXGWjf0xXYigd/519UPcQLOemOs
	 V7ogujCxEc0LWVFzUMthyyjjM9Rbi4Dr5o7lHKFGQGGm+ZQDsG6PTRyGx4gNaFnF49
	 F4nQqtJZdmEwSNsNnyoUeH5VAfcS9+ZyKzrxkYXhdKmZ5HPR2XqUXn7VqQx91HF+3D
	 zicoTmUybUf1DPFOHe33KO7Nyag6zAy/JUgBeH+RAxcSK1Z0e0UIBOS0NBMSVZsb4o
	 ksfkyMu9Gw0NIFaYu9Yo9Ju5P6eQxgqE8bfWmYpycY4cUlTtAZM/eaKAwakH7z1YCQ
	 79hF+rrolVA5w==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 6/7] samples/damon/prcl: use damon_initialized()
Date: Mon, 15 Sep 2025 20:35:10 -0700
Message-Id: <20250916033511.116366-7-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250916033511.116366-1-sj@kernel.org>
References: <20250916033511.116366-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

damon_sample_prcl is assuming DAMON is ready to use in module_init time,
and uses its own hack to see if it is the time.  Use
damon_initialized(), which is a way for seeing if DAMON is ready to be
used that is more reliable and better to maintain instead of the hack.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 samples/damon/prcl.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/samples/damon/prcl.c b/samples/damon/prcl.c
index 0226652f94d5..b7c50f2656ce 100644
--- a/samples/damon/prcl.c
+++ b/samples/damon/prcl.c
@@ -122,8 +122,6 @@ static void damon_sample_prcl_stop(void)
 	}
 }
 
-static bool init_called;
-
 static int damon_sample_prcl_enable_store(
 		const char *val, const struct kernel_param *kp)
 {
@@ -137,7 +135,7 @@ static int damon_sample_prcl_enable_store(
 	if (enabled == is_enabled)
 		return 0;
 
-	if (!init_called)
+	if (!damon_initialized())
 		return 0;
 
 	if (enabled) {
@@ -154,7 +152,12 @@ static int __init damon_sample_prcl_init(void)
 {
 	int err = 0;
 
-	init_called = true;
+	if (!damon_initialized()) {
+		if (enabled)
+			enabled = false;
+		return -ENOMEM;
+	}
+
 	if (enabled) {
 		err = damon_sample_prcl_start();
 		if (err)
-- 
2.39.5

